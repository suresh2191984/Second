<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EpisodeReport.aspx.cs" Inherits="Reports_EpisodeReport" meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Episode Reports</title>
    <%-- <link href="../Images/favicon.ico" rel="shortcut icon" />--%>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <%--  <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
    <%-- <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
--%>
    <%-- <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>
--%>

    <script src="../Scripts/Loading.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script type="text/javascript" language="javascript">
        /***Added For Progress bar***/
        //        $(document).ready(function() {
        //            $('form').live("submit", function() {
        //                ShowProgress();
        //            });
        //        });
        /***Added For Progress bar***/
    </script>

    <script language="javascript" type="text/javascript">

        function Select_Visit(vid, pid, PName, vstid) {
            //debugger;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("visitState").value = vstid;
        }

        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnTestName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnTestType.ClientID %>').value = TestType;
        }

        function SelectedTesttemp(source, eventArgs) {

            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnTestName.ClientID %>').value = TestName;
            document.getElementById('<%=txtTestName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnTestType.ClientID %>').value = TestType;
            AutoTextboxExpand(document.getElementById('<%=txtTestName.ClientID %>'));
        }
        function onListPopulated() {
            var completionList = $find("AutoCompleteExLstGrp11").get_completionList();
            completionList.style.width = 'auto';
        }

        function ClearTestDetails() {
            document.getElementById('<%=txtTestName.ClientID %>').value = '';
            document.getElementById('<%=hdnTestName.ClientID %>').value = '';
            document.getElementById('<%=hdnTestID.ClientID %>').value = '0';
            document.getElementById('<%=hdnTestType.ClientID %>').value = '';

        }

        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
            }
        }

        function setContextValue() {
            var sval = "0" + "^" + document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
            $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
            return false;
        }

        function SelectedClientID(source, eventArgs) {
            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value().split('|')[0];

        }
        function clearContextText() {
            $('#divOPDWCR').hide();

        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }

        function CheckToExcel() {
            AlertType = SListForAppMsg.Get('Reports_EpisodeReport_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_01');
            var Pdf = SListForAppMsg.Get('Reports_EpisodeReport_aspx_02') == null ? "Please get Invoice List and Take PDF" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_02');
            var clientName = document.getElementById('txtClient').value;

            if (document.getElementById('<%= txtFDate.ClientID %>').value == '' || document.getElementById('<%= txtFDate.ClientID %>').value == '') {

                // alert('Please get Invoice List and Take PDF'); andrews
                validationwindows(Pdf, AlertType);

                return false;
            }
        }

        function CheckToSaveData() {

            AlertType = SListForAppMsg.Get('Reports_EpisodeReport_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_01');
            var to = SListForAppMsg.Get('Reports_EpisodeReport_aspx_03') == null ? "Provide / select value for From date" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_03');
            var from = SListForAppMsg.Get('Reports_EpisodeReport_aspx_04') == null ? "Provide / select value for To date" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_04');


            var clientName = document.getElementById('txtClient').value;

            if (document.getElementById('<%= txtFDate.ClientID %>').value == '') {
                // alert('Provide / select value for From date'); andrews
                validationwindows(to, AlertType);
                document.getElementById('<%= txtFDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtTDate.ClientID %>').value == '') {
                //alert('Provide / select value for To date'); andrews
                validationwindows(from, AlertType);
                document.getElementById('<%= txtTDate.ClientID %>').focus();
                return false;
            }
        }

    </script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/1900")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
        .wraptext
        {
            width: 200px;
            word-break: break-all;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
--%>
        <%--<script type="text/javascript">
                            $(function() {
                                $("#txtFDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtTDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });

                        </script>--%>
        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr class="a-center">
                <td class="a-left">
                    <div class="dataheaderWider">
                        <table id="tbl" class="a-center w-100p searchPanel" style="display: table;">
                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select Organization" 
                                        meta:resourcekey="lblOrgsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" onchange="javascript:clearContextText();"
                                        runat="server" CssClass="ddlsmall" 
                                        OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged" 
                                        meta:resourcekey="ddlTrustedOrgResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblLoc" Text="Location" runat="server" 
                                        meta:resourcekey="lblLocResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" 
                                        meta:resourcekey="ddlLocationResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_FromDate" Text="From Date " runat="server" 
                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small" ID="txtFDate" runat="server" 
                                        meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                    <a id="txtFromFormat" runat="server">
                                        <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" class="v-middle"></a>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_ToDate" Text="To Date " runat="server" 
                                        meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small" ID="txtTDate" runat="server" 
                                        meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                    <a id="txtToFormat" runat="server">
                                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" class="v-middle"></a>
                                </td>
                            </tr>
                            <tr class="h-5" style="display: table-row;">
                                <td colspan="8">
                                </td>
                            </tr>
                            <tr style="display: table-row;">
                                <td>
                                    <asp:Label ID="lblVisitNo" runat="server" Text="Lab No" 
                                        meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEpisodeNo" runat="server" CssClass="small" 
                                        meta:resourcekey="txtEpisodeNoResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblPatientName" runat="server" Text="Patient Name" 
                                        meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPatientName" runat="server" CssClass="small" 
                                        meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblTestName" runat="server" Text="Test Name" 
                                        meta:resourcekey="lblTestNameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTestName" CssClass="small" runat="server" onchange="AutoTextboxExpand(this);"
                                        onfocus="javascript:ClearTestDetails();" 
                                        meta:resourcekey="txtTestNameResource1"></asp:TextBox><ajc:AutoCompleteExtender
                                            ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server" TargetControlID="txtTestName"
                                            ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                                            EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                            OnClientItemSelected="SelectedTest" OnClientItemOver="SelectedTesttemp">
                                        </ajc:AutoCompleteExtender>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Client Name" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="small" onfocus="setContextValue();"
                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Style="display: block;" 
                                        meta:resourcekey="txtClientResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                        OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                        Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr class="h-5">
                                <td colspan="8">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                                <td class="a-center" colspan="3">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left w-20p">
                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn" OnClick="btnSubmit_Click"
                                                    OnClientClick="javascript:return CheckToSaveData();" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="Get Episodes" 
                                                    meta:resourcekey="btnSubmitResource1" />
                                            </td>
                                            <td class="a-left w-10p">
                                                <asp:ImageButton ID="btnExcel" runat="server" CssClass="h-25 w-25" ImageUrl="~/Images/ExcelImage.GIF"
                                                    meta:resourcekey="btnExcelResource1" OnClick="btnExcel_Click" OnClientClick="javascript:return CheckToExcel();"
                                                    ToolTip="Export To Excel" Visible="false" />
                                            </td>
                                            <td class="a-left w-25p">
                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age btn" Font-Underline="True"
                                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"> <%=Resources.Reports_ClientDisplay.Reports_EpisodeReport_aspx_01%>  <%--Back--%>&nbsp;&nbsp;</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <asp:HiddenField ID="hdnTestName" runat="server" />
                                        <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
                                        <asp:HiddenField ID="hdnTestType" runat="server" />
                                        <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
                                        <input type="hidden" id="hdnPID" name="pid" runat="server" />
                                        <input type="hidden" id="hdnVID" name="vid" runat="server" />
                                        <input type="hidden" id="visitState" runat="server" />
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="loading a-center">
                       <%--  Loading...<br />
                        <br />
                        <img src="../Images/loader.gif" alt="" />--%>
                       <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <div id="progressBackgroundFilter" class="a-center">
                                </div>
                                <div id="processMessage" class="a-center w-20p">
                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                        meta:resourcekey="img1Resource1" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <div id="divPrint" style="display: none;" runat="server">
                        <table class="w-87p">
                            <tr>
                                <td class="a-right paddingR10" style="color: #000000;">
                                    <b id="printText" runat="server">
                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" 
                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" 
                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divOPDWCR" runat="server" style="display: block;">
                        <%--<table id="tbResult" runat="server" border="0" width="100%" style="display: none">
                                                        <tr id="Tr1" runat="server">
                                                            <td id="Td1" align="center" runat="server">
                                                                <asp:Label ID="lblHeader" Font-Bold="True" Font-Size="14px" runat="server" Font-Underline="True"
                                                                    Text="History of Transaction"></asp:Label>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr id="Tr2" runat="server">
                                                            <td id="Td2" align="left" class="dataheader1" runat="server">
                                                                <table border="1" style="width: 100%; font-size: 10px; font-family: Verdana; font-weight: bold;"
                                                                    cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="width: 15%">
                                                                                        <asp:Label ID="lblFDate" Font-Size="10px" runat="server" Text="From Date:"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 35%">
                                                                                        <span id="SFDate" runat="server"></span>
                                                                                    </td>
                                                                                    <td style="width: 15%">
                                                                                        <asp:Label ID="lblClient1" Font-Size="10px" runat="server" Text="Client Name:"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 35%">
                                                                                        <span id="spClientName" runat="server"></span>
                                                                                    </td>
                                                                                    <td style="width: 15%">
                                                                                        <asp:Label ID="lblTDate" runat="server" Font-Size="10px" Text="To Date :"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 35%">
                                                                                        <span id="STDate" runat="server"></span>
                                                                                    </td>
                                                                                    <td style="width: 15%">
                                                                                        <asp:Label ID="lblTotalBal" runat="server" Font-Size="10px" Text=""></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span id="SBal" runat="server"></span>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>--%>
                        <div id="prnReport" class="w-100p" style="overflow: scroll; height: 420px;">
                            <table class="a-center w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:GridView ID="gvEpisodeReport" runat="server" AutoGenerateColumns="False" GridLines="Both"
                                            ForeColor="#333333" OnRowDataBound="gvEpisodeReport_RowDataBound" CssClass="mytable1 gridView w-96p m-auto"
                                            meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Location" HeaderText="Location" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ExternalVisitID" HeaderText="Lab No" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientName" HeaderText="PatientName" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" Width="130px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:dd MMM yyyy}"
                                                    meta:resourcekey="BoundFieldResource1">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="false" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TestCode" HeaderText="Test Code" 
                                                    meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" CssClass="wraptext" />
                                                </asp:BoundField>
                                                <%--<asp:TemplateField HeaderText="Test Code">
                                                                            <ItemTemplate>
                                                                                <asp:GridView ID="ChildGrd" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                    GridLines="Both" ShowHeader="false" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="TestCode">
                                                                                            <ItemStyle Wrap="false"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                </asp:GridView>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Client Name" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCname" runat="server" 
                                                            Text='<%# DataBinder.Eval(Container.DataItem,"ClientName") %>' 
                                                            meta:resourcekey="lblCnameResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="BoundFieldResource2"
                                                    Visible="false">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ClientCode" HeaderText="Client Code" 
                                                    meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="BillNumber" HeaderText="BillNumber">
                                                                            <ItemStyle HorizontalAlign="left" Wrap="False" Width="100px"></ItemStyle>
                                                                        </asp:BoundField>--%>
                                                <asp:BoundField DataField="RateCard" HeaderText="Rate Card" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NetAmount" HeaderText="Bill Amount" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Right" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DiscountName" HeaderText="Discount Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CreatedBy" HeaderText="Created By" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CreatedAt" HeaderText="Date & Time" DataFormatString="{0:dd/MM/yyyy HH:mm}"
                                                    meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="RefPhysician" HeaderText="ReferingPhysician Name" 
                                                    meta:resourcekey="BoundFieldResource5">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                            <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
