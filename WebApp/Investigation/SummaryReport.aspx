<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SummaryReport.aspx.cs" Inherits="Investigation_SummaryReport" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="OrgHeader" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="Menu" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="Footer" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="Message" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="PatientHeader" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="PatientDetails" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Summary Report</title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .popupInfo
        {
            display: none;
            position: absolute;
            border-radius: 5px 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1);
            -webkit-box-shadow: 5px 5px rgba(0, 0, 0, 0.1);
            -moz-box-shadow: 5px 5px rgba(0, 0, 0, 0.1);
            font-family: Calibri, Tahoma, Geneva, sans-serif;
            font-size: 1.0em;
            position: absolute;
            z-index: 99;
            width: 450px;
            padding: 0.5em 0.8em 0.8em 2em;
            background: #9FDAEE;
            border: 1px solid #2BB0D7;
            margin-left: 40px;
        }
        .popupInfo em
        {
            font-family: Candara, Tahoma, Geneva, sans-serif;
            font-size: 1.7em;
            font-weight: bold;
            display: block;
            padding: 0.2em 0 0.6em 0;
        }
        .popupInfo img
        {
            border: 0;
            margin: -10px 0 0 -55px;
            float: left;
            position: absolute;
        }
        .divTable
        {
            width: 100%;
            display: block;
            padding-top: 10px;
            padding-bottom: 10px;
            padding-right: 10px;
            padding-left: 10px;
        }
        .divRow
        {
            width: 99%;
        }
        .divColumn
        {
            float: left;
            width: 50%;
            padding-bottom: 15px;
        }
    </style>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>

    <script type="text/javascript">
        $(function() {
            $('[id^="tabContent"]').hide();
            $('#tabResultSummary').addClass('active');
            $('#tabContentResultSummary').show();
        });
        function ShowTabContent(tabId, DivId) {
            $('#TabsMenu li').removeClass('active');
            $('#' + tabId).addClass('active');
            $('[id^="tabContent"]').hide();
            $('#' + DivId).show();
            $('#hdnSelectedDiv').val(DivId);
            $('#hdnResSummaryTemplate').val('');
            $('#hdnInterpretationTemplate').val('');
            $('#hdnSuggestionTemplate').val('');
        }
        function SetVisibleContent() {
            if ($('#hdnSelectedDiv').val() != '') {
                $('#' + $('#hdnSelectedDiv').val()).show();
            }
        }
        function ResultTemplateShowToolTip(Source, eventArgs) {
            $('span#popupResultTemplate').html("<img src='../images/Info.png' alt='Info' height='48' width='48' /><em>" + eventArgs.get_text() + "</em>" + eventArgs.get_value());
            $('span#popupResultTemplate').show();
        }
        function ResultTemplateHideToolTip(Source, eventArgs) {
            $('span#popupResultTemplate').hide();
        }
        function SelectedResultTemplate(Source, eventArgs) {
            $('#hdnResSummaryTemplate').val(eventArgs.get_value());
        }
        function ResultTemplatePopulated(Source, eventArgs) {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#hdnResSummaryTemplate').val('');
            }
        }
        function InterTemplateShowToolTip(Source, eventArgs) {
            $('span#popupInterTemplate').html("<img src='../images/Info.png' alt='Info' height='48' width='48' /><em>" + eventArgs.get_text() + "</em>" + eventArgs.get_value());
            $('span#popupInterTemplate').show();
        }
        function InterTemplateHideToolTip(Source, eventArgs) {
            $('span#popupInterTemplate').hide();
        }
        function SelectedInterTemplate(Source, eventArgs) {
            $('#hdnInterpretationTemplate').val(eventArgs.get_value());
        }
        function InterTemplatePopulated(Source, eventArgs) {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#hdnInterpretationTemplate').val('');
            }
        }
        function SuggestTemplateShowToolTip(Source, eventArgs) {
            $('span#popupSuggestTemplate').html("<img src='../images/Info.png' alt='Info' height='48' width='48' /><em>" + eventArgs.get_text() + "</em>" + eventArgs.get_value());
            $('span#popupSuggestTemplate').show();
        }
        function SuggestTemplateHideToolTip(Source, eventArgs) {
            $('span#popupSuggestTemplate').hide();
        }
        function SelectedSuggestTemplate(Source, eventArgs) {
            $('#hdnSuggestionTemplate').val(eventArgs.get_value());
        }
        function SuggestTemplatePopulated(Source, eventArgs) {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#hdnSuggestionTemplate').val('');
            }
        }
        function AddResultTemplate() {
            if (typeof FCKeditorAPI != 'undefined' && $('#hdnResSummaryTemplate').val() != '' && $('#txtResultSummary').val() != '') {
                var FCKSection1 = FCKeditorAPI.GetInstance('FCKSection1');
                if (FCKSection1) {
                    FCKSection1.SetHTML(FCKSection1.GetHTML() + $('#hdnResSummaryTemplate').val());
                    $('#txtResultSummary').val('');
                    $('#hdnResSummaryTemplate').val('');
                }
            }
            else {
                alert('There is no template');
                $('#txtResultSummary').val('');
            }
            return false;
        }
        function AddInterTemplate() {
            if (typeof FCKeditorAPI != 'undefined' && $('#hdnInterpretationTemplate').val() != '' && $('#txtInterTemplate').val() != '') {
                var FCKSection2 = FCKeditorAPI.GetInstance('FCKSection2');
                if (FCKSection2) {
                    FCKSection2.SetHTML(FCKSection2.GetHTML() + $('#hdnInterpretationTemplate').val());
                    $('#txtInterTemplate').val('');
                    $('#hdnInterpretationTemplate').val('');
                }
            }
            else {
                alert('There is no template');
                $('#txtInterTemplate').val('');
            }
            return false;
        }
        function AddSuggestTemplate() {
            if (typeof FCKeditorAPI != 'undefined' && $('#hdnSuggestionTemplate').val() != '' && $('#txtSuggestTemplate').val() != '') {
                var FCKSection3 = FCKeditorAPI.GetInstance('FCKSection3');
                if (FCKSection3) {
                    FCKSection3.SetHTML(FCKSection3.GetHTML() + $('#hdnSuggestionTemplate').val());
                    $('#txtSuggestTemplate').val('');
                    $('#hdnSuggestionTemplate').val('');
                }
            }
            else {
                alert('There is no template');
                $('#txtSuggestTemplate').val('');
            }
            return false;
        }
        function AddComplaint() {
            if (typeof FCKeditorAPI != 'undefined' && $('#txtComplaint').val() != '') {
                var FCKSection2 = FCKeditorAPI.GetInstance('FCKSection2');
                if (FCKSection2) {
                    FCKSection2.SetHTML(FCKSection2.GetHTML() + $('#txtComplaint').val());
                    $('#txtComplaint').val('');
                }
            }
            else {
                alert('There is no complaint');
            }
            return false;
        }
        function AddInvSuggested() {
            if (typeof FCKeditorAPI != 'undefined' && $('#txtTestName').val() != '') {
                var FCKSection3 = FCKeditorAPI.GetInstance('FCKSection3');
                if (FCKSection3) {
                    FCKSection3.SetHTML(FCKSection3.GetHTML() + $('#txtTestName').val());
                    $('#txtTestName').val('');
                }
            }
            else {
                alert('There is no suggested investigation');
            }
            return false;
        }
        function ShowChart(obj) {
            try {
                var row = $(obj).closest('tr');
                var hdnTestCode = $(row).find($('input[id$="hdnTestCode"]')).val();
                var lstInvPattern = hdnTestCode.split('~');
                var chkPastTrend = $(row).find($('input[id$="chkPastTrend"]'));
                if ($(chkPastTrend).is(':checked')) {
                    if ($("#divColumnChart" + lstInvPattern[0]).length > 0) {
                        $("#divColumnChart" + lstInvPattern[0]).show();
                    }
                    else {
                        var visitId = $("#hdnVisitID").val();
                        var orgId = $("#hdnOrgID").val();
                        var invId = lstInvPattern[0];
                        var patternId = lstInvPattern[1];
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../WebService.asmx/CreateChart",
                            data: "{VisitID:" + visitId + ",OrgID:" + orgId + ",PatternID:" + patternId + ",InvID:" + invId + "}",
                            success: function(msg) {
                                var dataPath = msg.d;
                                dataPath = "../" + dataPath;
                                var divTag = document.createElement('div');
                                $(divTag).attr('id', 'divColumnChart' + invId);
                                $(divTag).addClass("divColumn");
                                $(divTag).html("<img border='0' src='" + dataPath + "'/>");
                                $(divTag).appendTo($("#divRowChart"));
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(XMLHttpRequest.responseText);
                            }
                        });
                    }
                }
                else {
                    if ($("#divColumnChart" + lstInvPattern[0]).length > 0) {
                        $("#divColumnChart" + lstInvPattern[0]).hide();
                    }
                }
            }
            catch (e) {
                alert(e);
            }
        }
    </script>

</head>
<body oncontextmenu="return true;" runat="server" onkeydown="SuppressBrowserBackspaceRefresh();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <OrgHeader:MainHeader ID="MainHeader" runat="server" />
                <PatientHeader:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <Menu:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <Message:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div runat="server" id="divPatientDetails" style="width: 100;">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <PatientDetails:PatientDetails ID="PatientDetail" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:Label runat="server" ID="lblStatus" Visible="false" Text="No Matching Record Found"></asp:Label>
                        <div id="TabsMenu">
                            <ul id="ulTabsMenu">
                                <li id="tabResultSummary" onclick="ShowTabContent('tabResultSummary','tabContentResultSummary')"
                                    class="active"><a href="#"><span>Result Summary</span></a></li>
                                <li id="tabInterpretation" onclick="ShowTabContent('tabInterpretation', 'tabContentInterpretation')">
                                    <a href="#"><span>Clinical Interpretation</span></a></li>
                                <li id="tabSuggestions" onclick="ShowTabContent('tabSuggestions', 'tabContentSuggestions')">
                                    <a href="#"><span>Suggestions</span></a></li>
                                <li id="tabPastTrend" onclick="ShowTabContent('tabPastTrend', 'tabContentPastTrend')">
                                    <a href="#"><span>Past Trends</span></a></li>
                                <li id="tabComments" onclick="ShowTabContent('tabComments', 'tabContentComments')"><a
                                    href="#"><span>Comments</span></a></li>
                                <li id="tabMiscellaneous" onclick="ShowTabContent('tabMiscellaneous', 'tabContentMiscellaneous')">
                                    <a href="#"><span>Miscellaneous</span></a></li>
                            </ul>
                        </div>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <div id="tabContentResultSummary" style="display: none;">
                                    <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblResultSummary" runat="server" Text="Template" />&nbsp;
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtResultSummary" runat="server" Width="150px"
                                                    ToolTip="Enter Result Template Name"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACEResultTemplate" runat="server" TargetControlID="txtResultSummary"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetSummaryReportTemplate" FirstRowSelected="false" ServicePath="~/WebService.asmx"
                                                    UseContextKey="True" DelimiterCharacters="" Enabled="True" OnClientItemOver="ResultTemplateShowToolTip"
                                                    OnClientItemOut="ResultTemplateHideToolTip" OnClientHiding="ResultTemplateHideToolTip"
                                                    OnClientHidden="ResultTemplateHideToolTip" OnClientItemSelected="SelectedResultTemplate"
                                                    OnClientPopulated="ResultTemplatePopulated">
                                                </ajc:AutoCompleteExtender>
                                                <asp:Button ID="btnAddResSummary" runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return AddResultTemplate()" />
                                                <span id="popupResultTemplate" class="popupInfo"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <FCKeditorV2:FCKeditor ID="FCKSection1" Width="100%" runat="server" Height="200"
                                                    ToolbarCanCollapse="true" ToolbarStartExpanded="false">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="tabContentInterpretation" style="display: none;">
                                    <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSection2" runat="server" Text="Template" />&nbsp;
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtInterTemplate" runat="server" Width="150px"
                                                    ToolTip="Enter Interpretation Template Name"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACEInterTemplate" runat="server" TargetControlID="txtInterTemplate"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetSummaryReportTemplate" FirstRowSelected="false" ServicePath="~/WebService.asmx"
                                                    UseContextKey="True" DelimiterCharacters="" Enabled="True" OnClientItemOver="InterTemplateShowToolTip"
                                                    OnClientItemOut="InterTemplateHideToolTip" OnClientHiding="InterTemplateHideToolTip"
                                                    OnClientHidden="InterTemplateHideToolTip" OnClientItemSelected="SelectedInterTemplate"
                                                    OnClientPopulated="InterTemplatePopulated">
                                                </ajc:AutoCompleteExtender>
                                                <asp:Button ID="btnAddInterTemplate" runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return AddInterTemplate()" />
                                                <span id="popupInterTemplate" class="popupInfo"></span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblComplaint" runat="server" Text="Complaint" />&nbsp;
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtComplaint" runat="server" Width="150px"
                                                    ToolTip="Enter Complaint"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACEComplaint" runat="server" TargetControlID="txtComplaint"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetComplaints" FirstRowSelected="true" ServicePath="~/WebService.asmx"
                                                    UseContextKey="True" DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                <asp:Button ID="btnAddComplaint" runat="server" Text="&nbsp;&nbsp;Add&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return AddComplaint()" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <FCKeditorV2:FCKeditor ID="FCKSection2" Width="100%" runat="server" Height="200"
                                                    ToolbarCanCollapse="true" ToolbarStartExpanded="false">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="tabContentSuggestions" style="display: none;">
                                    <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSection3" runat="server" Text="Template" />&nbsp;
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtSuggestTemplate" runat="server" Width="150px"
                                                    ToolTip="Enter Suggestions Template Name"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACESuggestTemplate" runat="server" TargetControlID="txtSuggestTemplate"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetSummaryReportTemplate" FirstRowSelected="false" ServicePath="~/WebService.asmx"
                                                    UseContextKey="True" DelimiterCharacters="" Enabled="True" OnClientItemOver="SuggestTemplateShowToolTip"
                                                    OnClientItemOut="SuggestTemplateHideToolTip" OnClientHiding="SuggestTemplateHideToolTip"
                                                    OnClientHidden="SuggestTemplateHideToolTip" OnClientItemSelected="SelectedSuggestTemplate"
                                                    OnClientPopulated="SuggestTemplatePopulated">
                                                </ajc:AutoCompleteExtender>
                                                <asp:Button ID="btnAddSuggestTemplate" runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return AddSuggestTemplate()" />
                                                <span id="popupSuggestTemplate" class="popupInfo"></span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTestName" runat="server" Text="Investigation" />&nbsp;
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtTestName" runat="server" Width="150px"
                                                    ToolTip="Enter Test Name"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACETestName" runat="server" TargetControlID="txtTestName"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetInvSuggested" FirstRowSelected="true" ServicePath="~/WebService.asmx"
                                                    UseContextKey="True" DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                <asp:Button ID="btnAddInvSuggested" runat="server" Text="&nbsp;&nbsp;Add&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return AddInvSuggested()" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <FCKeditorV2:FCKeditor ID="FCKSection3" Width="100%" runat="server" Height="200"
                                                    ToolbarCanCollapse="true" ToolbarStartExpanded="false">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="tabContentPastTrend" style="display: none;">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="hdnSelInvPastTrend" runat="server" Value="" />
                                                <asp:DataList Width="100%" ID="dlPastTrend" runat="server" RepeatColumns="5" OnItemDataBound="dlPastTrend_ItemDataBound">
                                                    <ItemTemplate>
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 85%;">
                                                                    <asp:CheckBox ID="chkPastTrend" runat="server" onclick="ShowChart(this);" />
                                                                    <asp:Label ID="lblInvName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InvestigationName")%>'> </asp:Label>
                                                                    <asp:HiddenField ID="hdnTestCode" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "TestCode")%>'/>
                                                                    <asp:HiddenField ID="hdnInvID" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "InvestigationID")%>'/>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="divTable">
                                                    <div id="divRowChart" class="divRow" runat="server">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="tabContentComments" style="display: none;">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td>
                                                <FCKeditorV2:FCKeditor ID="FCKSection4" Width="100%" runat="server" Height="200"
                                                    ToolbarCanCollapse="true" ToolbarStartExpanded="false">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="tabContentMiscellaneous" style="display: none;">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkTRF" runat="server" Text="Show TRF" TextAlign="Right" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div>
                                    <table width="100%" border="0" style="text-align: center;">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" Text="Save And Continue" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnSave_Click" />
                                                <asp:Button ID="btnCancel" runat="server" Text="Continue" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="../Images/working.gif" alt="Loading..." />
                                Loading ...
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
        </table>
        <Footer:Footer ID="Footer1" runat="server" />
    </div>
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>
    <asp:HiddenField ID="hdnVisitID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnResSummaryTemplate" runat="server" Value="" />
    <asp:HiddenField ID="hdnInterpretationTemplate" runat="server" Value="" />
    <asp:HiddenField ID="hdnSuggestionTemplate" runat="server" Value="" />
    <input id="hdnSelectedDiv" type="hidden" runat="server" value="tabContentResultSummary" />
    </form>
</body>
</html>
