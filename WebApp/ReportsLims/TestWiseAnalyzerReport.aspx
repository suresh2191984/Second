<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestWiseAnalyzerReport.aspx.cs"
    Inherits="ReportsLims_TestWiseAnalyzerReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Wise Analyzer Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../StyleSheets/Common.css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <style type="text/css">
        .grid-scroll
        {
            min-height: 30px;
            max-height: 30px;
            overflow-y: auto;
            overflow-x: hidden;
        }
        a1
        {
            font-weight: bold;
            font-family: Times New Roman;
            font-size: medium;
        }
        .calen
        {
            height: 21px;
            width: 21px;
        }
    </style>

    <script type="text/javascript">
        function pageLoad() {
            $("#txtFromDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                buttonImage: "../images/Calendar_scheduleHS.png",
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtToDate").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFromDate").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtToDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFromDate").datepicker("option", "maxDate", selectedDate);
                }
            })

        }
        $(function() {
            $("#txtFromDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtToDate").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFromDate").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtToDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFromDate").datepicker("option", "maxDate", selectedDate);
                }
            })
        });
        function preventInput(evnt) {
            //Checked In IE9,Chrome,FireFox
            if (evnt.which != 9) evnt.preventDefault();
        }
        function popupprint() {
            var prtContent = document.getElementById('tblSummaryReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function Search_Gridview(strKey, strGV) {
            debugger;
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }
        function validate() {

            if (document.getElementById('grdTestReport').value == 'undefined') {
                alert('No Records to Export');
                return false;
            }
        }
        function validateToDate() {

            if (document.getElementById('txtFromDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFromDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtToDate').focus();
                return false;
            }
            return true;
        }

        function getTestId(source, eventArgs) {
            document.getElementById('hdnTestCode').value = eventArgs.get_value().split('~')[1];
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="dataheaderWider">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table id="tblreport" class="w-100p tblreportCss">
                    <tr>
                        <td>
                            <div class="dataheaderWider" runat="server">
                                <table class="w-100p a-center ">
                                    <tr class="a-center">
                                        <td class="a-left">
                                            <asp:Label ID="lblReportType" runat="server" Text="Report Type : "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlReportType" runat="server" CssClass="ddlsmall" />
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="LblFromDt" runat="server" Text="From Date : "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtFromDate" Width="118px" placeholder="dd/mm/yyyy"
                                                onkeydown="javascript:preventInput(event);" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                            <img src="../images/Calendar_scheduleHS.png" alt="" align="middle" class="calen" />
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblToDt" runat="server" Text="To Date : "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtToDate" placeholder="dd/mm/yyyy" onkeydown="javascript:preventInput(event);"
                                                Width="118px" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                            <img src="../images/Calendar_scheduleHS.png" alt="" align="middle" class="calen" />
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblOrg" runat="server" Text="Organization : "></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" style="width: 170px">
                                                <asp:DropDownList ID="ddlOrganization" runat="server" CssClass="ddlsmall" />
                                                <img src="../Images/starbutton.png" alt="" align="right" id="imgorg" style="display: none;" />
                                            </span>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblLocation" runat="server" Text="Location : "></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" style="width: 175px">
                                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" alt="" align="right" id="imgloc" style="display: none;" />
                                            </span>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblAnalyzerNm" runat="server" Text="Analyzer Name : "></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" style="width: 175px">
                                                <asp:DropDownList ID="ddlAnalyzerNm" runat="server" CssClass="ddlsmall">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" alt="" align="right" id="imganal" style="display: none;" />
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTestNm" runat="server" Text="Test Name : " Style="display: none;"></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" style="width: 170px; height: 22px;">
                                                <asp:TextBox ID="txtTestNm" runat="server" CssClass="searchBox" Style="display: none;"
                                                    Placeholder="Search" />
                                            </span>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestNm"
                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                ServiceMethod="GetTestCodeItems" OnClientItemSelected="getTestId" FirstRowSelected="false"
                                                ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                                Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-right" colspan="3">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="return validateToDate();" OnClick="btnSubmit_Click" />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="lnkBack" Text="Back" Font-Underline="False" runat="server" CssClass="btn"
                                                OnClick="lnkBack_Click" ></asp:Button>
                                        </td>
                                        <td class="a-right" colspan="3">
                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:LinkButton ID="lnkbtnExport" runat="server" Text="Export to XL" Font-Underline="true"
                                                OnClick="lnkbtnExport_Click" Enabled="false"></asp:LinkButton>
                                            <%--OnClientClick="return validate();"--%>
                                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />&nbsp;&nbsp;&nbsp;
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" ToolTip="Print"
                                                meta:resourcekey="btnPrintResource1" />
                                            <asp:LinkButton ID="lnkbtnPrint" runat="server" Text="Print Report" Font-Underline="true"
                                                OnClientClick="return popupprint();" Enabled="false"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <table id="tblCountVal" class="w-100p a-left tblCountVal">
                                    <tr>
                                        
                                        <td>
                                            <a1> <asp:Label ID="lblmsg" runat="server" Text="Summary Report" Visible="False"  meta:resourcekey="lblmsgResource1" style="background-repeat:no-repeat;"></asp:Label></a1>
                                            <br />
                                        </td>
                                        <td>
                                            <a1> <asp:Label ID="lblDmsg" runat="server" Text="Detailed Report" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label></a1>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTotAnalyzer" runat="server" Text="Total Analyzer :" Visible="false" />
                                            <asp:Label ID="lblTotAVal" runat="server" Text="" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotParam" runat="server" Text="Total Parameters :" Visible="false" />
                                            <asp:Label ID="lblTotParamVal" runat="server" Text="" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProTotCount" runat="server" Text="Processed Test Count :" Visible="false" />
                                            <asp:Label ID="lblProTotCountVal" runat="server" Text="" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblNofParam" runat="server" Text="No Of Parameters :" Visible="false" />
                                            <asp:Label ID="lblNofParamVal" runat="server" Text="" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotProTstCount" runat="server" Text="Total Processed Test Count :"
                                                Visible="false" />
                                            <asp:Label ID="lblTotProTstCountVal" runat="server" Text="" Visible="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="a-right">
                                            <asp:TextBox ID="txtSearch" runat="server" Font-Size="14px" CssClass="searchBox"
                                                Visible="false" onkeyup="Search_Gridview(this, 'grdTestReport')" ToolTip="Search"
                                                placeholder="Search"></asp:TextBox>
                                                 <asp:TextBox ID="txtSearch1" runat="server" Font-Size="14px" CssClass="searchBox"
                                                Visible="false" onkeyup="Search_Gridview(this, 'grdDetailedRpt')" ToolTip="Search"
                                                placeholder="Search"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <div class="grid-scroll">
                                            <table id="tblSummaryReport" class="gridView w-100p " rules="all" runat="server"
                                                style="width: 75px; font-size: smaller; border-collapse: collapse">
                                                <tr visible="false" id="trgrdTestReport">
                                                    <td class="dataheaderInvCtrl">
                                                        <asp:GridView ID="grdTestReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                            AllowPaging="True" CssClass="dataheader2" ShowFooter="True">
                                                            <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                            <RowStyle HorizontalAlign="Left"></RowStyle>
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Date" HeaderText="Date">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="OrgName" HeaderText="Organization">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Locationname" HeaderText="Location">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Analyzername" HeaderText="Analyzer">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TestName" HeaderText="Investigation">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Count" HeaderText="Count">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr visible="false" id="trgrdDetailedRpt">
                                                    <td class="dataheaderInvCtrl">
                                                        <asp:GridView ID="grdDetailedRpt" runat="server" AutoGenerateColumns="False" Width="100%"
                                                            AllowPaging="True" CssClass="dataheader2" ShowFooter="True">
                                                            <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                                Position="Top" />
                                                            <RowStyle HorizontalAlign="Left"></RowStyle>
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Analyzername" HeaderText="Analyzer">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Testname" HeaderText="Investigation">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Date" HeaderText="Date">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="VisitId" HeaderText="VisitId">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PatientName" HeaderText="PatientName">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Patientid" HeaderText="Patient Id">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="BarcodeNumber" HeaderText="Barcode">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Status" HeaderText="Status">
                                                                    <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                </div> </td> </tr> </table>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="lnkbtnExport" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnTestCode" runat="server" />
    <asp:HiddenField ID="hdntestName" runat="server" />
    <asp:HiddenField ID="hdnreporttype" runat="server" />

    <script type="text/javascript">
        $(function() {
            debugger;
            $("#ddlReportType").change(function() {
                //alert('Change Happened');
                var ddlselreport = $(this).val();

                if (ddlselreport == 2) {
                    $('#imganal').attr("style", "display:block");
                    $('#imgloc').attr("style", "display:block");
                    $('#imgorg').attr("style", "display:block");
                    $('#lblTestNm').attr("style", "display:block");
                    $('#txtTestNm').attr("style", "display:block");
                    $('#lblTotProTstCount').attr("style", "display:block");
                    $('#lblTotProTstCountVal').attr("style", "display:block");
                    $('#lblNofParam').attr("style", "display:block");
                    $('#lblNofParamVal').attr("style", "display:block");
                }
                else {
                    $('#lblTestNm').attr("style", "display:none");
                    $('#txtTestNm').attr("style", "display:none");
                    $('#imganal').attr("style", "display:none");
                    $('#imgloc').attr("style", "display:none");
                    $('#imgorg').attr("style", "display:none");
                }
            });
        });
        $(document.body).on('change', '#ddlReportType', function() {
            debugger;
            //alert('Change Happened');
            var ddlselreport = $(this).val();
            hdnreporttype.value = ddlselreport;
            if (ddlselreport == 2) {
                $('#imganal').attr("style", "display:block");
                $('#imgloc').attr("style", "display:block");
                $('#imgorg').attr("style", "display:block");
                $('#lblTestNm').attr("style", "display:block");
                $('#txtTestNm').attr("style", "display:block");
                $('#lblTotProTstCount').attr("style", "display:block");
                $('#lblTotProTstCountVal').attr("style", "display:block");
                $('#lblNofParam').attr("style", "display:block");
                $('#lblNofParamVal').attr("style", "display:block");
            }
            else {
                $('#lblTestNm').attr("style", "display:none");
                $('#txtTestNm').attr("style", "display:none");
                $('#imganal').attr("style", "display:none");
                $('#imgloc').attr("style", "display:none");
                $('#imgorg').attr("style", "display:none");
            }
        });

       
    </script>

    </form>
</body>
</html>
