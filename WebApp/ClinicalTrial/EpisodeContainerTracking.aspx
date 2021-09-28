<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EpisodeContainerTracking.aspx.cs"
    Inherits="ClinicalTrial_EpisodeContainerTracking" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ControlListDetails.ascx" TagName="ControlListDetails"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

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
    <script type="text/javascript" language="javascript">
        
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
                isCtrl = true;
            }

            return isCtrl;
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
            if (isCtrl || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46)) {
                //            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }

        
    </script>
    

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <div>
                                                    <asp:Panel ID="pnlas" runat="server" meta:resourcekey="pnlasResource1">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="Panel5" runat="server" GroupingText="Sample Tracking" 
                                                                        meta:resourcekey="Panel5Resource1">
                                                                        <table border="0" cellpadding="2" width="100%" class="dataheader3">
                                                                            <tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: block;">
                                                                                <td id="Td1" colspan="2" runat="server">
                                                                                    <table width="50%" border="0" cellpadding="2" cellspacing="0" align="center">
                                                                                        <tr id="Tr1" runat="server" width="100%">
                                                                                            <td style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="Rs_ClientName" runat="server" Text="Site Name"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 15%;" runat="server">
                                                                                                <asp:TextBox ID="txtClient" Width="125px" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                                                                    MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientListforSchedule"
                                                                                                    ServicePath="~/WebService.asmx" OnClientItemSelected="ClientSelected" 
                                                                                                    DelimiterCharacters="" Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="Td2" style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="lblEpisode" Text="Study/Protocol Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td3" runat="server" width="15%">
                                                                                                <asp:TextBox ID="txtEpisodeName" onfocus="getSittingEpisoe();" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteSittingEpisode" runat="server" TargetControlID="txtEpisodeName"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                                                                    MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientEpisode"
                                                                                                    ServicePath="~/OPIPBilling.asmx" 
                                                                                                    OnClientItemSelected="SittingEpisodeSelected" DelimiterCharacters="" 
                                                                                                    Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td id="Td7" style="width: 10%;" align="left">
                                                                                                <asp:Label ID="Label1" Text="Shipping Condition" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td8" style="width: 15%;">
                                                                                                <asp:DropDownList ID="ddlShipping" runat="server" CssClass="ddlsmall">
                                                                                                </asp:DropDownList>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="Td9" style="width: 10%;" align="left">
                                                                                                <asp:Label ID="Label2" Text="Visit No" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td10" style="width: 15%;">
                                                                                                <asp:TextBox ID="txtVisitNo" runat="server"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onkedown="return ValidateOnlyNumeric(this);" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td id="Td11" style="width: 10%;" align="left">
                                                                                                <asp:Label ID="Label5" Text="Additional Details" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td12" style="width: 15%;" colspan="2">
                                                                                                <asp:TextBox ID="txtAdditionalDetails" runat="server" Width="250px" TextMode="MultiLine"></asp:TextBox>
                                                                                            </td>
                                                                                            <td id="Td6" style="width: 10%;">
                                                                                                <asp:Button runat="server" Text="Save" ID="btnSave" OnClick="btnSave_Click" OnClientClick="return checkisempty();"
                                                                                                    CssClass="btn" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: block;">
                                                                <td>
                                                                    <div id="dvShowNew" runat="server" style="display: block;">
                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','dvNewEpisode',1);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','dvNewEpisode',1);">
                                                                            <asp:Label ID="Label3" ForeColor="Black" Text="Search with Filters" Font-Underline="True"
                                                                                runat="server" meta:resourcekey="Label3Resource1"></asp:Label></span>
                                                                    </div>
                                                                    <div id="dvHideNew" runat="server" style="display: none;">
                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','divLocation',0);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','dvNewEpisode',0);">
                                                                            <asp:Label ID="Label4" ForeColor="Black" Text="Search with Filters" Font-Underline="True"
                                                                                runat="server" meta:resourcekey="Label4Resource1"></asp:Label></span>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: block;">
                                                                <td>
                                                                    <div id="dvNewEpisode" runat="server" style="display: none;">
                                                                        <asp:Panel ID="Panel1" runat="server" BorderColor="White" BorderWidth="1px" 
                                                                            GroupingText="Serach Type" meta:resourcekey="Panel1Resource1">
                                                                            <table width="50%" border="0" cellpadding="2" cellspacing="0" align="center">
                                                                                <tr>
                                                                                    <td style="width: 10%;" align="left">
                                                                                        <asp:Label ID="lblSTaskID" runat="server" Text="Enter TaskID" 
                                                                                            meta:resourcekey="lblSTaskIDResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 10%;" align="left">
                                                                                        <asp:TextBox ID="txtTaskID" runat="server" 
                                                                                            meta:resourcekey="txtTaskIDResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 10%;" align="right">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="Label6" runat="server" Text="Choose Status" 
                                                                                            meta:resourcekey="Label6Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlConainerStatus" runat="server" 
                                                                                            meta:resourcekey="ddlConainerStatusResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Button runat="server" Text="Search" ID="btnSearch" OnClick="btnSearch_Click"
                                                                                            CssClass="btn" meta:resourcekey="btnSearchResource1" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" align="center">
                                                                    <table id="tblHeader" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                        <tr runat="server">
                                                                            <td colspan="4" runat="server">
                                                                                <table border="1" id="GrdHeader" runat="server" style="display: block" width="100%">
                                                                                    <tr class="dataheader1" runat="server">
                                                                                        <td align="center" style="width: 5%" runat="server">
                                                                                            <asp:Label ID="Rs_TrackId" runat="server" Text="Consignment No"></asp:Label>
                                                                                        </td>
                                                                                        <td align="left" style="width: 15%" runat="server">
                                                                                            <asp:Label ID="Rs_Select" runat="server" Text="Site Name"></asp:Label>
                                                                                        </td>
                                                                                        <td align="left" style="width: 10%" runat="server">
                                                                                            <asp:Label ID="Rs_PatientNo1" runat="server" Text="Study Number"></asp:Label>
                                                                                        </td>
                                                                                        <td align="left" style="width: 10%" runat="server">
                                                                                            <asp:Label ID="Rs_Name" runat="server" Text="Study Name"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 10%" runat="server">
                                                                                            <asp:Label ID="Rs_Age" runat="server" Text="Shipping Condition"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 5%" runat="server">
                                                                                            <asp:Label ID="Rs_URNNo" runat="server" Text="Visit No"></asp:Label>
                                                                                        </td>
                                                                                        <td align="center" style="width: 20%" runat="server">
                                                                                            <asp:Label ID="Rs_MobileNumber" runat="server" Text="Additional Details"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 10%" runat="server">
                                                                                            <asp:Label ID="Rs_Address" runat="server" Text="Performed Status"></asp:Label>
                                                                                        </td>
                                                                                        <td runat="server" id="tdorg" style="width: 10%">
                                                                                            <asp:Label ID="Rs_ToBePerformStatus" runat="server" Text="To be Perform Status"></asp:Label>
                                                                                        </td>
                                                                                        <td runat="server" id="tdAction" style="width: 5%">
                                                                                            <asp:Label ID="Rs_Action" runat="server" Text="Action"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table border="0" width="100%">
                                                                                    <tr>
                                                                                        <td colspan="10">
                                                                                            <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                DataKeyNames="TrackID,EpisodeID,EpisodeName"
                                                                                                OnRowDataBound="grdResult_RowDataBound" 
                                                                                                OnRowCommand="grdResult_RowCommand" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                                                PageSize="15">
                                                                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                                                    PageButtonCount="5" PreviousPageText="" />
                                                                                                <Columns>
                                                                                                    <asp:TemplateField>
                                                                                                        <ItemTemplate>
                                                                                                            <table id="TabChild" runat="server" border="0" width="100%" align="left">
                                                                                                                <tr id="Tr1" runat="server">
                                                                                                                    <td id="Td1" style="width: 8%;" nowrap="nowrap" runat="server">
                                                                                                                        <asp:LinkButton ID="LinkButton1" ToolTip="Click here To View Visit details" ForeColor="Black"
                                                                                                                            runat="server" CommandName="ShowVisit" Text='<%# Bind("ConsignmentNo") %>' CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                                                                                        <asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                                                                            ImageUrl="~/Images/collapse.jpg" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                                                                    </td>
                                                                                                                    <td id="PatientNumber" align="left" style="width: 15%" nowrap="nowrap" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "ClientName")%>
                                                                                                                    </td>
                                                                                                                    <td id="Name" align="left" width="10%" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "CreatedBy")%>
                                                                                                                    </td>
                                                                                                                    <td id="PatientID" align="left" width="10%" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "EpisodeName")%>
                                                                                                                    </td>
                                                                                                                    <td id="Age" align="left" width="10%" runat="server">
                                                                                                                        <asp:Label ID="lblAge" runat="server" Text='<%# Bind("ConditionDesc") %>'></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td id="URNNo" align="left" style="width: 5%" nowrap="nowrap" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "VisitNo")%>
                                                                                                                    </td>
                                                                                                                    <td id="MobileNumber" align="left" width="20%" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "AdditionalInfo")%>
                                                                                                                    </td>
                                                                                                                    <td id="Address" align="left" width="10%" runat="server">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "StatusDesc")%>
                                                                                                                    </td>
                                                                                                                    <td id="tdGridContainerStatus" runat="server" align="left" width="10%">
                                                                                                                        <asp:DropDownList ID="ddlGridContainerStatus" runat="server" Style="margin-left: 0px"
                                                                                                                            CssClass="ddl" Enabled="true">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </td>
                                                                                                                    <td id="tdChangeStatus" align="left" width="5%" runat="server">
                                                                                                                        <input class="btn" id="btnChangeStatus" commandargument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                            commandname="ChangeStatus" style="width: 50px;" type="button" runat="server"
                                                                                                                            value="Save" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr id="Tr2" runat="server">
                                                                                                                    <td id="TdChildGrid" colspan="10" runat="server">
                                                                                                                        <div style="width: 100%;">
                                                                                                                            <div runat="server" id="DivChild" style="display: none;" class="evenforsurg">
                                                                                                                                <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" AllowPaging="True"
                                                                                                                                    CellPadding="1" AutoGenerateColumns="False" DataKeyNames="TrackID,TrackDetailsID,StatusID, EpisodeID,EpisodeName"
                                                                                                                                    Width="98%" ForeColor="White" OnPageIndexChanging="ChildGrd_PageIndexChanging"
                                                                                                                                    OnRowDataBound="ChildGrid_RowDataBound" OnRowCommand="ChildGrid_RowCommand" PageSize="10"
                                                                                                                                    CssClass="mytable1">
                                                                                                                                    <%--OnRowDataBound="ChildGrid_RowDataBound"--%>
                                                                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                                                                    <Columns>
                                                                                                                                        <asp:TemplateField HeaderText="S.No.">
                                                                                                                                            <ItemTemplate>
                                                                                                                                                <%#Container.DataItemIndex+1%>
                                                                                                                                            </ItemTemplate>
                                                                                                                                            <ItemStyle Width="5%" />
                                                                                                                                        </asp:TemplateField>
                                                                                                                                        <asp:BoundField DataField="ClientName" HeaderText="Site Name">
                                                                                                                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="CreatedBy" HeaderText="Study Number">
                                                                                                                                            <ItemStyle Width="5%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="EpisodeName" HeaderText="Study Name">
                                                                                                                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="ConditionDesc" HeaderText="Shipping Condition">
                                                                                                                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="VisitNo" HeaderText="Visit No">
                                                                                                                                            <ItemStyle Width="5%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="AdditionalInfo" HeaderText="Additional Details">
                                                                                                                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:BoundField DataField="StatusDesc" HeaderText="Status">
                                                                                                                                            <ItemStyle Width="15%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        <asp:TemplateField HeaderText="Performed At" SortExpression="PerformedAt">
                                                                                                                                            <ItemTemplate>
                                                                                                                                                <%# GetDate(DataBinder.Eval(Container.DataItem, "CreatedAt", "{0:dd/MM/yyyy}").ToString())%>
                                                                                                                                            </ItemTemplate>
                                                                                                                                            <ItemStyle Width="5%" HorizontalAlign="Left" />
                                                                                                                                        </asp:TemplateField>
                                                                                                                                        <asp:BoundField DataField="CreatedName" HeaderText="Performed By">
                                                                                                                                            <ItemStyle Width="8%" HorizontalAlign="Left" />
                                                                                                                                        </asp:BoundField>
                                                                                                                                        
                                                                                                                                    </Columns>
                                                                                                                                </asp:GridView>
                                                                                                                                &nbsp;
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="8">
                                                                    <br />
                                                                    <asp:Panel ID="pnlLocation1" Width="800px" Height="300px" runat="server" CssClass="modalPopup dataheaderPopup"
                                                                        ScrollBars="Vertical" Style="display: none" 
                                                                        meta:resourcekey="pnlLocation1Resource1">
                                                                        <br />
                                                                        <table align="center" border="0" width="90%">
                                                                            <tr id="trDeltaTable" runat="server" style="display: block;">
                                                                                <td runat="server">
                                                                                    <table id="tblPatientTestHistory1" border="0" cellpadding="4" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="display: block; text-align: left;" width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <uc8:ControlListDetails ID="ControlListDetails" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Button runat="server" Text="Save" ID="btnPopUpSave" OnClick="btnPopUpSave_Click"
                                                                                                    CssClass="btn" meta:resourcekey="btnPopUpSaveResource1" />
                                                                                            </td>
                                                                                            <td align="left">
                                                                                                <input id="btnpopClose1" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                                                    type="button" value="Close" onclick="ClearPopUp1();" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <br />
                                                                    </asp:Panel>
                                                                    <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                                                                        CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
                                                                        TargetControlID="btnDummy1">
                                                                    </ajc:ModalPopupExtender>
                                                                    <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input type="hidden" id="hdnEpisodeID" runat="server" >
                                                                        <input id="hdnClientID" runat="server" type="hidden"></input>
                                                                            <input id="HdnID" runat="server" type="hidden"></input>
                                                                                <input id="hdnTrackID" runat="server" type="hidden"></input>
                                                                                    <input id="hdnLID" runat="server" type="hidden"></input>
                                                                                        <input id="hdnContainerStatusID" runat="server" type="hidden"></input>
                                                                                            <br />
                                                                                        </input>
                                                                                    </input>
                                                                                </input>
                                                                            </input>
                                                                        </input>
                                                                    </input>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">


    function ClientSelected(source, eventArgs) {

        document.getElementById('hdnClientID').value = eventArgs.get_value();
    }
    function SittingEpisodeSelected(source, eventArgs) {
        document.getElementById('txtEpisodeName').value = eventArgs.get_text();
        var str = eventArgs.get_value().split('~');
        document.getElementById('hdnEpisodeID').value = str[9];

    }

    function getSittingEpisoe() {
        var OrgID = "<%=OrgID%>";
        var ClinetID = document.getElementById('hdnClientID').value;
        var sval = OrgID + '~' + ClinetID + '~' + 'COM';
        $find('AutoCompleteSittingEpisode').set_contextKey(sval);
    }

    function CheckEpisode() {

    }
    function checkisempty() {
        if (document.getElementById('hdnClientID').value == "") {
            document.getElementById('txtClient').value = "";
            document.getElementById('txtClient').focus();
            alert("Select Site Name");
            return false;
        }
        if (document.getElementById('txtClient').value == "") {
            document.getElementById('txtClient').value = "";
            document.getElementById('txtClient').focus();
            alert("Select Site Name");
            return false;
        }
        if (document.getElementById('hdnEpisodeID').value == "") {
            document.getElementById('txtEpisodeName').value = "";
            document.getElementById('txtEpisodeName').focus();
            alert("Enter Episode Name");
            return false;
        }
        if (document.getElementById('txtEpisodeName').value == "") {
            document.getElementById('txtEpisodeName').value = "";
            document.getElementById('txtEpisodeName').focus();
            alert("Enter Episode Name");
            return false;
        }
        if (document.getElementById('ddlShipping').value == "0") {
            document.getElementById('ddlShipping').value = "0";
            document.getElementById('ddlShipping').focus();
            alert("Select Shipping Type");
            return false;
        }
        return true;
    }
    function CallShowPopUp(id) {
        document.getElementById('btnDummy1').click();

        var CtrlID = id;
        var obj = document.getElementById(CtrlID);

    }
    function ClearPopUp1() {

    }
</script>

