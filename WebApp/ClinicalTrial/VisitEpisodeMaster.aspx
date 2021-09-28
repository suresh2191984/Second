<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitEpisodeMaster.aspx.cs"
    Inherits="ClinicalTrial_VisitEpisodeMaster" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/FileUpload.ascx" TagName="FileUpload" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/ClinicalTrailMaster.js" type="text/javascript"></script>

    <style type="text/css">
        .style3
        {
            width: 202px;
        }
    </style>

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

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                         <div>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <table class="w-100p searchPanel">
                                        <tr>
                                            <td colspan="2">
                                                <div>
                                                    <asp:Panel ID="pnlas" runat="server" meta:resourcekey="pnlasResource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="a-center">
                                                                    <asp:Label ID="lblmsg" runat="server" Style="display: none; color: Green; font-weight: bold;
                                                                        font-size: larger" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: table-row;">
                                                                <td>
                                                                    <asp:Panel ID="Panel5" runat="server" GroupingText="Existing Episode Details" meta:resourcekey="Panel5Resource1">
                                                                        <table class="bg-row w-100p">
                                                                            <tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: table-row;">
                                                                                <td id="Td1" colspan="2" runat="server">
                                                                                    <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="2"
                                                                                        cellspacing="0">
                                                                                        <tr id="Tr1" runat="server" width="50%" align="right">
                                                                                            <td id="Td2" class="style1" runat="server">
                                                                                                <asp:Label ID="Rs_SupplierName" Text="Study Name: " runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td3" runat="server" width="6%">
                                                                                                <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                                                                    AutoComplete="off"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderEpisodeSearch" runat="server" TargetControlID="txtClientNameSrch"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientListforSchedule"
                                                                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                            <td id="Td6" align="left" class="style1" runat="server" width="25%">
                                                                                                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                                                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnSearch_Click" />
                                                                                            </td>
                                                                                        </tr>
                                                                       
                                                                                        
                                                                                        <tr class="tablerow">
                                                                                            <td colspan="3">
                                                                                                <table class="w-100p" id="excel" runat="server">
                                                                                                    <tr id="Tr2" runat="server">
                                                                                                        <td id="Td7" class="a-center" runat="server">
                                                                                                            <div id="dvSearchItem" runat="server" style="display: block;">
                                                                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                                                                    <ContentTemplate>
                                                                                                                        <asp:GridView ID="gvclientmaster" CssClass="w-98p gridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                                            DataKeyNames="EpisodeID,EpisodeName,VisitDetails" PageSize="5" EmptyDataText="No Matching Records found"
                                                                                                                            wrap="wrap" OnPageIndexChanging="gvclientmaster_PageIndexChanging" OnRowDataBound="gvclientmaster_RowDataBound"
                                                                                                                            OnRowCommand="gvclientmaster_RowCommand" HeaderStyle-CssClass="dataheader1" RowStyle-Height="5px"
                                                                                                                            BackColor="White">
                                                                                                                            <Columns>
                                                                                                                                <asp:TemplateField HeaderText="S.No.">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <%#Container.DataItemIndex+1%>
                                                                                                                                    </ItemTemplate>
                                                                                                                                    <ItemStyle Width="3%" />
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:BoundField DataField="EpisodeNumber" HeaderText="Study Number">
                                                                                                                                    <ItemStyle Width="5%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="EpisodeName" HeaderText="Study Name">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="ClientName" HeaderText="CRO/Sponsor">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="StudyType" HeaderText="Study Type">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="NoofSitting" HeaderText="Number Of Visits">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="NoOfPatient" HeaderText="Number Of Patient(Max)">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="ISAdhoc" HeaderText="Allow Ad-hoc Visits">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:TemplateField HeaderText="Study Start Date" SortExpression="VisitDate">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "StartDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                                                                                    </ItemTemplate>
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Study End Date" SortExpression="VisitDate">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "EndDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                                                                                    </ItemTemplate>
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:BoundField DataField="TherapeuticVlaue" HeaderText="Therapeutic Area">
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="Life Status">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:DropDownList ID="ddlGridEpisodeStatus" runat="server" Style="margin-left: 0px"
                                                                                                                                            CssClass="ddl" Enabled="true">
                                                                                                                                            <asp:ListItem Text="Active" Value="A"></asp:ListItem>
                                                                                                                                            <asp:ListItem Text="Suspend" Value="S"></asp:ListItem>
                                                                                                                                            <asp:ListItem Text="Block" Value="B"></asp:ListItem>
                                                                                                                                        </asp:DropDownList>
                                                                                                                                    </ItemTemplate>
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="Action">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <%--  <asp:Button ID="btnChangeStatus" runat="server" Width="85" Text="Change Status" onmouseover="this.className='btn btnhov'"
                                                                                                                         CommandName="ChangeStatus" CssClass="btn" />--%>
                                                                                                                                        <input class="btn" id="btnChangeStatus" commandargument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                                            commandname="ChangeStatus" style="width: 90px;" type="button" runat="server"
                                                                                                                                            value="Change Status" />
                                                                                                                                    </ItemTemplate>
                                                                                                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                                                                                                </asp:TemplateField>
                                                                                                                            </Columns>
                                                                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                                            <HeaderStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                                        </asp:GridView>
                                                                                                                        <input type="hidden" id="hdnEpisodeID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnOwnClientID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnClientID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnAddressDetails" runat="server" />
                                                                                                                        <input type="hidden" id="hdnPackageID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnNoOfVisit" runat="server" />
                                                                                                                        <input type="hidden" id="hdnKitDetails" runat="server" />
                                                                                                                        <input type="hidden" id="hdnKitTempTable1" runat="server" />
                                                                                                                        <input type="hidden" id="hdnKitTempTable2" runat="server" />
                                                                                                                        <input type="hidden" id="hdnKitID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnAddressID" runat="server" value="0" />
                                                                                                                        <input type="hidden" id="hdnParentClientID" runat="server" value="0" />
                                                                                                                        <input type="hidden" id="hdntxtsalesmancode" runat="server" value="0" />
                                                                                                                        <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                                                                                                        <input type="hidden" id="hdncollectioncenterid" runat="server" value="0" />
                                                                                                                        <input type="hidden" id="hdnclientnames" runat="server" value="" />
                                                                                                                        <input id="hdnStateID" type="hidden" value="0" runat="server" />
                                                                                                                        <input type="hidden" id="hdnFileValue" runat="server" />
                                                                                                                        <input type="hidden" id="hdnEpisodeStatus" runat="server" />
                                                                                                                        <input type="hidden" id="hdnChildClientList" runat="server" />
                                                                                                                        <input type="hidden" id="hdnChildClientID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnChildClientIDDummy" runat="server" />
                                                                                                                        <input type="hidden" id="tempChkChildIDs" runat="server" />
                                                                                                                        <input type="hidden" id="hdnParentClientList" runat="server" />
                                                                                                                        <input type="hidden" id="hdnChildCode" runat="server" />
                                                                                                                        <input type="hidden" id="hdnEpisodeName" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSIteID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSiteDetails" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSiteTempTable1" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSiteTempTable2" runat="server" />
                                                                                                                        <input type="hidden" id="hdnClientType" runat="server" />
                                                                                                                        <input type="hidden" id="hdnTotalNoOfSites" runat="server" />
                                                                                                                        <input type="hidden" id="hdnVisitGuid" runat="server" />
                                                                                                                        <input type="hidden" id="hdnEpisodeVisitId" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSiteVisitMapID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnProductVisitMapID" runat="server" />
                                                                                                                        <input type="hidden" id="hdnSetSiteSubjectAllocation" runat="server" />
                                                                                                                        <input type="hidden" id="hdnVisitWiseSubject" runat="server" />
                                                                                                                        <input type="hidden" id="hdnRemarks" runat="server" />
                                                                                                                    </ContentTemplate>
                                                                                                                </asp:UpdatePanel>
                                                                                                            </div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div id="dvShowNew" runat="server" style="display: block;">
                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','divLocation',1);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','dvNewEpisode',1);">
                                                                            <asp:Label ID="Label3" ForeColor="Black" Text="Create/Edit Study" Font-Underline="True"
                                                                                runat="server" meta:resourcekey="Label3Resource1"></asp:Label></span>
                                                                    </div>
                                                                    <div id="dvHideNew" runat="server" style="display: none;">
                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','divLocation',0);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvShowNew','dvHideNew','dvNewEpisode',0);">
                                                                            <asp:Label ID="Label4" ForeColor="Black" Text="Create/Edit Study" Font-Underline="True"
                                                                                runat="server" meta:resourcekey="Label4Resource1"></asp:Label></span>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div id="dvNewEpisode" runat="server" style="display: block;">
                                                                        <asp:Panel ID="Panel1" runat="server" BorderColor="White" BorderWidth="1px" meta:resourcekey="Panel1Resource1">
                                                                            <table class="dataheader3 w-100p">
                                                                                <tr>
                                                                                    <td colspan="4">
                                                                                        <asp:Panel ID="Panel6" runat="server" GroupingText="Study / Protocol Information"
                                                                                            meta:resourcekey="Panel6Resource1">
                                                                                            <table class="w-100p bg-row">
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblEpisodeName" Text="Study/Protocol Name" runat="server" meta:resourcekey="lblEpisodeNameResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:TextBox ID="txtEpisodeName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onblur="return ConverttoUpperCase(this.id);"
                                                                                                            meta:resourcekey="txtEpisodeNameResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderEpisodeName" runat="server" TargetControlID="txtEpisodeName"
                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientListforSchedule"
                                                                                                            OnClientItemSelected="SelectedEpisodeValue" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                            Enabled="True">
                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblEpisodeNo" Text="Study/Protocol No" runat="server" meta:resourcekey="lblEpisodeNoResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:TextBox ID="txtEpisodeNo" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtEpisodeNoResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label16" Text="CT Study Phase" runat="server" meta:resourcekey="Label16Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList ID="ddlCTStudyPhase" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" meta:resourcekey="ddlCTStudyPhaseResource1">
                                                                                                        </asp:DropDownList>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblclient" Text="CRO" runat="server" meta:resourcekey="lblclientResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:TextBox ID="txtClientName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="lblSponsor" Text="Sponsor" runat="server" meta:resourcekey="lblSponsorResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:TextBox ID="txtSponsor" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtSponsorResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    <td id="tdChildClient" runat="server" style="display: none;">
                                                                                                        <asp:Label ID="Label9" Text="Site: " runat="server" meta:resourcekey="Label9Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td colspan="3">
                                                                                                        <div id="gNadvTable" runat="server">
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Label ID="lblStudyPeriod" Text="Study/Protocol Period" runat="server" meta:resourcekey="lblStudyPeriodResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td colspan="1">
                                                                                                        <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                                                                        <asp:TextBox Width="70px" ID="txtFromPeriod" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFromPeriod"
                                                                                                            PopupButtonID="ImgFDate" Enabled="True" />
                                                                                                        <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                                            CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" CssClass="Txtboxsmall" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtToPeriod"
                                                                                                            PopupButtonID="ImgTDate" Enabled="True" />
                                                                                                        <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                                            CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblClientType" Text="Study/Protocol Type" runat="server" meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList ID="ddlEpisodeType" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" meta:resourcekey="ddlEpisodeTypeResource1">
                                                                                                        </asp:DropDownList>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label13" Text="Site-Wise Subject Allocation" runat="server" meta:resourcekey="Label13Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList ID="ddlSiteWiseSubject" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" onchange="javascript:return SetSiteSubjectAllocation(this.id);"
                                                                                                            meta:resourcekey="ddlSiteWiseSubjectResource1">
                                                                                                        </asp:DropDownList>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label14" Text="Visit-Wise Subject Allocation" runat="server" meta:resourcekey="Label14Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList ID="ddlVisitWiseSubject" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" onchange="javascript:return SetVisitSubjectAllocation(this.id);"
                                                                                                            meta:resourcekey="ddlVisitWiseSubjectResource1">
                                                                                                        </asp:DropDownList>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label5" Text="Study Life Status" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-30p">
                                                                                                        <asp:DropDownList ID="ddlEpisodeLifeStatus" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" Enabled="False" meta:resourcekey="ddlEpisodeLifeStatusResource1">
                                                                                                            <asp:ListItem Text="Active" Value="A" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                                            <asp:ListItem Text="Suspend" Value="S" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                                            <asp:ListItem Text="Block" Value="B" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                                                        </asp:DropDownList>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblStudySource" runat="server" Text="Study Source" meta:resourcekey="lblStudySourceResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList runat="server" ID="ddlStudySource" meta:resourcekey="ddlStudySourceResource1" CssClass="ddlsmall">
                                                                                                        </asp:DropDownList>
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblStudyDesign" runat="server" Text="Study Design" meta:resourcekey="lblStudyDesignResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:TextBox ID="txtStudyDesign" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                            TextMode="MultiLine" MaxLength="254" Height="30px" meta:resourcekey="txtStudyDesignResource1"></asp:TextBox>
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblTherapeuticArea" Text="Therapeutic Area" runat="server"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-30p">
                                                                                                        <asp:TextBox ID="txtTherapeuticArea" runat="server" onfocus="javascript:return SetContextValue();"
                                                                                                            MaxLength="50" Width="170px"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"   CssClass="Txtboxsmall"></asp:TextBox>
                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderTherapeuticArea" runat="server"
                                                                                                            TargetControlID="txtTherapeuticArea" EnableCaching="False" MinimumPrefixLength="1"
                                                                                                            CompletionInterval="0" OnClientItemSelected="SelectedTherapeuticVlaue" CompletionListCssClass="wordWheel listMain .box"
                                                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                            ServiceMethod="SearchSpeciality" FirstRowSelected="True" ServicePath="~/OPIPBilling.asmx"
                                                                                                            UseContextKey="True" DelimiterCharacters="" Enabled="True">
                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </asp:Panel>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3">
                                                                                        <asp:Panel ID="Panel2" runat="server" GroupingText="Study / Protocol Attributes"
                                                                                            meta:resourcekey="Panel2Resource1">
                                                                                            <table class="w-100p bg-row">
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblReferenceLab" runat="server" Text="Reference Lab" meta:resourcekey="lblReferenceLabResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-12p">
                                                                                                        <asp:TextBox ID="txtReferenceLab" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtReferenceLabResource1"></asp:TextBox>
                                                                                                    </td>
                                                                                                    <td class="a-right w-12p">
                                                                                                        <asp:Label ID="lblScreenSubjects" runat="server" Text="Screening Subjects" meta:resourcekey="lblScreenSubjectsResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-right w-5p">
                                                                                                        <asp:TextBox ID="txtscrSubjects" runat="server" CssClass="Txtboxsmall" Width="35px"
                                                                                                            meta:resourcekey="txtscrSubjectsResource1" onblur="return ValidateSubjectCount(this.id);"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="a-right w-20p">
                                                                                                        <asp:CheckBox ID="chkUndefinedScreening" Text="Undefined No.of Screening Subjects"
                                                                                                            runat="server" OnClick="javascript:ScreeningUndefined()" />
                                                                                                    </td>
                                                                                                    <td class="a-right w-12p">
                                                                                                        <asp:Label ID="lblMonitSubjects" runat="server" Text="Randomized Subject" meta:resourcekey="lblMonitSubjectsResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-right w-5p">
                                                                                                        <asp:TextBox ID="txtNoOfPatient" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onkeydown="return ValidateOnlyNumeric(this);"
                                                                                                            meta:resourcekey="txtNoOfPatientResource1" onblur="return ValidateSubjectCount(this.id);"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="a-right w-12p">
                                                                                                        <asp:Label ID="lblSiteCount" runat="server" Text="Number Of Sites" meta:resourcekey="lblSiteCountResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-30p">
                                                                                                        <asp:TextBox ID="txtSiteCount" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onkeydown="return blockNonNumbers(this, event, true, false);"
                                                                                                            onblur="return CheckSiteCount(this.id);" meta:resourcekey="txtSiteCountResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:CheckBox ID="chkAdhoc" Text="Allow adhoc visits & tests" runat="server" meta:resourcekey="chkAdhocResource1" />
                                                                                                    </td>
                                                                                                    <td class="w-5p">
                                                                                                    </td>
                                                                                                    <td class="w-62p">
                                                                                                        <asp:Label Text="Number of Patients / Subjects (max) :" runat="server" ID="lblPatients"
                                                                                                            Visible="False" meta:resourcekey="lblPatientsResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr class="tablerow">
                                                                                                    <td colspan="6">
                                                                                                        <div id="div1" runat="server" style="display: none;">
                                                                                                            <table id="Table1" runat="server" class='dataheaderInvCtrl w-100p' style="background-color: White;
                                                                                                                border: 1,1,1,1;">
                                                                                                            </table>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="3" class="v-top">
                                                                                                        <table>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <div id="dvAtt1" runat="server" style="display: block;">
                                                                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                                                            style="cursor: pointer" onclick="showResponses('dvAtt1','dvAtt2','divLocation',1);" />
                                                                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvAtt1','dvAtt2','divLocation',1);">
                                                                                                                            <asp:Label ID="Label7" ForeColor="Black" Text="Click To Add Episode Attributes" Font-Underline="True"
                                                                                                                                runat="server" meta:resourcekey="Label7Resource1"></asp:Label></span>
                                                                                                                    </div>
                                                                                                                    <div id="dvAtt2" runat="server" style="display: none;">
                                                                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                                                            style="cursor: pointer" onclick="showResponses('dvAtt1','dvAtt2','divLocation',0);" />
                                                                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('dvAtt1','dvAtt2','divLocation',0);">
                                                                                                                            <asp:Label ID="Label8" ForeColor="Black" Text="Hide" Font-Underline="True" runat="server"
                                                                                                                                meta:resourcekey="Label8Resource1"></asp:Label></span>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td colspan="6">
                                                                                                                    <div id="divLocation" runat="server" style="display: none;">
                                                                                                                        <asp:Panel ID="tblPanel" runat="server" GroupingText="Study Attributes" class="w-100p"
                                                                                                                            meta:resourcekey="tblPanelResource1">
                                                                                                                            <table id="tblclientatt" runat="server" class="w-100p">
                                                                                                                                <tr id="aTr1" runat="server">
                                                                                                                                    <td id="aTd1" runat="server">
                                                                                                                                        <asp:Label ID="Rs_SelectAttributes" Text="Attributes" runat="server"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd2" runat="server">
                                                                                                                                        <asp:TextBox ID="txtClientAttributes" runat="server"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"></asp:TextBox>
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd3" runat="server">
                                                                                                                                        &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Rs_EnterAttributeValue" Text="Enter Attribute Value"
                                                                                                                                            runat="server"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd4" runat="server">
                                                                                                                                        <asp:TextBox ID="txtValue" runat="server"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"></asp:TextBox>
                                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd5" runat="server">
                                                                                                                                        &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Rs_SelectAttributeType" Text="Select Attribute Type"
                                                                                                                                            runat="server"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd6" runat="server">
                                                                                                                                        <asp:DropDownList ID="ddlClientTypes" runat="server">
                                                                                                                                        </asp:DropDownList>
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd7" colspan="2" runat="server">
                                                                                                                                        &nbsp; &nbsp;&nbsp; &nbsp;<asp:Label ID="lblShowin" Text="Show In :" runat="server"></asp:Label>
                                                                                                                                        &nbsp;
                                                                                                                                        <asp:CheckBox ID="chkReg" Text="Reg" runat="server" />
                                                                                                                                        <asp:CheckBox ID="chkInvoice" Text="Invoice" runat="server" />
                                                                                                                                        <asp:CheckBox ID="chkReceipt" Text="Receipt" runat="server" />
                                                                                                                                    </td>
                                                                                                                                    <td id="aTd8" colspan="2" class="a-center" runat="server">
                                                                                                                                        <input type="button" id="btnClientAttributes" value="Add" class="btn" onclick="javascript:checkEpisodeATtributes();" />
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                                <tr id="aTr2" runat="server">
                                                                                                                                    <td id="aTd9" class="v-top" colspan="5" runat="server">
                                                                                                                                        <div id="div4" runat="server" style="overflow: auto; height: 100px;">
                                                                                                                                            <input type="hidden" id="hdnClientAttributes" runat="server"> </input>
                                                                                                                                            <input id="hdntvtvalue" runat="server" type="hidden"></input>
                                                                                                                                            <table id="tblClientAttributes" runat="server" class='dataheaderInvCtrl w-100p'
                                                                                                                                                style="background-color: White; border: 1,1,1,1;">
                                                                                                                                            </table>
                                                                                                                                        </div>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </asp:Panel>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td colspan="2" class="bg-row">
                                                                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                                                        <ContentTemplate>
                                                                                                                            <table>
                                                                                                                                <tr>
                                                                                                                                    <td colspan="2">
                                                                                                                                        <input id="ChkTRFImage" runat="server" value="Upload" type="checkbox" onclick="ShowTRFUpload(this, this.id);" />
                                                                                                                                        <label for="chkUploadPhoto" id="Label10" runat="server" style="color: #2C88B1; font-size: small;">
                                                                                                                                            File Upload</label>
                                                                                                                                    </td>
                                                                                                                                    <td colspan="2">
                                                                                                                                        <div id="TRFimage" style="display: none;">
                                                                                                                                            <asp:FileUpload ID="FileUpload1" runat="server" class="multi" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF|txt"
                                                                                                                                                meta:resourcekey="FileUpload1Resource1" />
                                                                                                                                        </div>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td colspan="2">
                                                                                                                                        <div id="divUpload" runat="server" style="display: none">
                                                                                                                                            <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                                                                                                                                                width="70%">
                                                                                                                                                <tr>
                                                                                                                                                    <td colspan="4">
                                                                                                                                                        <TRF:FileUpload ID="TRFImageUpload" runat="server" Rows="6" OnClick="EpisodeFileUpload_Click" />
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                            </table>
                                                                                                                                        </div>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </ContentTemplate>
                                                                                                                    </asp:UpdatePanel>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </asp:Panel>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3">
                                                                                        <asp:Panel ID="Panel4" runat="server" GroupingText="Visit Episode Information" meta:resourcekey="Panel4Resource1">
                                                                                            <table class="w-100p bg-row">
                                                                                                <tr>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label1" Text="Visit Name :" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:TextBox ID="txtVisitName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtVisitNameResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="Label15" Text="Visit Type" runat="server" meta:resourcekey="Label15Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-15p">
                                                                                                        <asp:DropDownList ID="ddlVisitType" runat="server" Width="175px" Style="margin-left: 0px"
                                                                                                            CssClass="ddl" meta:resourcekey="ddlVisitTypeResource1">
                                                                                                        </asp:DropDownList>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:Label ID="lblAddressType" Text="Package Name :" runat="server" meta:resourcekey="lblAddressTypeResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-30p">
                                                                                                        <asp:TextBox ID="txtPkgName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtPkgNameResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPkg" runat="server" TargetControlID="txtPkgName"
                                                                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" OnClientItemSelected="SelectedPackageValue"
                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetQuickBillItems"
                                                                                                            FirstRowSelected="True" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                                                                            DelimiterCharacters="" Enabled="True">
                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td class="w-5p">
                                                                                                        <asp:Label ID="Label2" Text="Timed Visit :" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-13p">
                                                                                                        <table class="w-100p">
                                                                                                            <tr>
                                                                                                                <td class="w-20p">
                                                                                                                    <asp:TextBox ID="txtTimedValue" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                                        CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onkeydown=" return ValidateOnlyNumeric(this);"
                                                                                                                        meta:resourcekey="txtTimedValueResource1"></asp:TextBox><sup> th</sup> &nbsp;<img
                                                                                                                            src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                </td>
                                                                                                                <td class="w-30p">
                                                                                                                    <asp:DropDownList runat="server" Width="65px" ID="ddlTimedType" CssClass="ddl" meta:resourcekey="ddlTimedTypeResource1">
                                                                                                                    </asp:DropDownList>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td class="w-5p">
                                                                                                        <asp:Label ID="lblVisitNo" Text="Visit No. " runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="w-5p">
                                                                                                        <asp:TextBox ID="txtVisitNo" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                            onblur="return CheckVisitNumber(this.id);" CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                                                                            onkeydown="return ValidateOnlyNumeric(this);" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                    </td>
                                                                                                    <td class="w-10p">
                                                                                                        <asp:CheckBox ID="chkmandatory" Text="Is Mandatory" runat="server" meta:resourcekey="chkmandatoryResource1" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="4">
                                                                                                        <asp:Panel ID="Panel3" runat="server" GroupingText="Kit" meta:resourcekey="Panel3Resource1">
                                                                                                            <table class="w-100p searchPanel">
                                                                                                                <tr>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:Label ID="lblKitName" Text="Kit Name :" runat="server" meta:resourcekey="lblKitNameResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-10p">
                                                                                                                        <asp:TextBox ID="txtKitName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtKitNameResource1"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtKitName"
                                                                                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" OnClientItemSelected="SelectedKitName"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetProductListWithName"
                                                                                                                            FirstRowSelected="True" ServicePath="~/InventoryWebService.asmx" UseContextKey="True"
                                                                                                                            DelimiterCharacters="" Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:Label ID="lblNoOfKit" Text="No of Kit :" runat="server" meta:resourcekey="lblNoOfKitResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:TextBox ID="txtNoOfKit" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                                            Text="1" CssClass="Txtboxsmall" onkeydown="return ValidateOnlyNumeric(this);"
                                                                                                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtNoOfKitResource1"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <input type="button" id="btnKit" class="btn" style="width: 60px; height: 20px;" value="Add Kit"
                                                                                                                            onclick="AddKitDetails();" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr class="tablerow">
                                                                                                                    <td colspan="3">
                                                                                                                        <div id="div2" runat="server" style="display: block;">
                                                                                                                            <table width="100%" id="tdKitTable" runat="server" class='dataheaderInvCtrl' style="background-color: White;
                                                                                                                                border: 1,1,1,1;">
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr style="display: none;" id="tdSite" runat="server">
                                                                                                    <td id="Td10" colspan="4" runat="server">
                                                                                                        <asp:Panel ID="Panel7" runat="server" GroupingText="Site">
                                                                                                            <table class="w-100p">
                                                                                                                <tr>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:Label ID="Label11" Text="Site Name :" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-10p">
                                                                                                                        <asp:TextBox ID="txtSiteName" runat="server" MaxLength="50" Width="170px" AutoComplete="off"
                                                                                                                            CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" ></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderSiteName" runat="server" TargetControlID="txtSiteName"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientListforSchedule"
                                                                                                                            OnClientItemSelected="SelectedSiteValue" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                                            Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:Label ID="Label12" Text="No of Subjects/Patients :" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <asp:TextBox ID="txtSitePatientNo" runat="server" MaxLength="50" Width="35px" AutoComplete="off"
                                                                                                                            Text="0" CssClass="Txtboxsmall" onkeydown="return ValidateOnlyNumeric(this);"
                                                                                                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" ></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td class="w-5p">
                                                                                                                        <input type="button" id="Button1" class="btn" style="width: 60px; height: 20px;"
                                                                                                                            value="Associate Site" onclick="AddSiteDetails();" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr class="tablerow">
                                                                                                                    <td colspan="3">
                                                                                                                        <div id="div3" runat="server" style="display: block;">
                                                                                                                            <table width="100%" id="tdSiteTable" runat="server" class='dataheaderInvCtrl' style="background-color: White;
                                                                                                                                border: 1,1,1,1;">
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" class="a-center">
                                                                                                        <input type="button" id="btnAdd" class="btn" style="width: 60px; height: 20px;" value="Add Visit"
                                                                                                            onclick="checkCustomerAddress();" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr class="tablerow">
                                                                                                    <td colspan="6">
                                                                                                        <div id="divaddressdetails" runat="server" style="display: none;">
                                                                                                            <table id="tblClientDetail" runat="server" class='dataheaderInvCtrl w-100p'
                                                                                                                style="background-color: White; border: 1,1,1,1;">
                                                                                                            </table>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td class="w-100p" colspan="6">
                                                                                                        <asp:Panel ID="pnlSitewiseContactList" runat="server" GroupingText="Sitewise Contact List"
                                                                                                            meta:resourcekey="pnlSitewiseContactListResource1" CssClass="w-100p">
                                                                                                            <asp:GridView ID="grdSitewiseContactList" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                                PageSize="5" EmptyDataText="No Matching Records found" wrap="wrap"
                                                                                                                BackColor="White" meta:resourcekey="grdSitewiseContactListResource1" CssClass="w-100p gridView">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="TemplateFieldResource1">
                                                                                                                        <ItemTemplate>
                                                                                                                            <%#Container.DataItemIndex+1%>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="5%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Site" meta:resourcekey="TemplateFieldResource2">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblsiteName" runat="server" Text='<%# Eval("ReferenceType") %>' meta:resourcekey="lblsiteNameResource1"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="10%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Contact Type" meta:resourcekey="TemplateFieldResource3">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblContactType" runat="server" Text='<%# Eval("ContactType") %>' meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="8%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Contact Person" meta:resourcekey="TemplateFieldResource4">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblContactPerson" runat="server" Text='<%# Eval("Name") %>' meta:resourcekey="lblContactPersonResource1"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="8%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Contact No" meta:resourcekey="TemplateFieldResource5">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("Mobile") %>' meta:resourcekey="lblContactNoResource1"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="8%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Contact Address" meta:resourcekey="TemplateFieldResource6">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblContactType" runat="server" Text='<%# Eval("Address1") %>' meta:resourcekey="lblContactTypeResource2"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle Width="20%" />
                                                                                                                    </asp:TemplateField>
                                                                                                                </Columns>
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                                <RowStyle Height="5px" />
                                                                                                            </asp:GridView>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </asp:Panel>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="w-100p">
                                                                                        <div runat="server" id="dvApproved" style="display: none;">
                                                                                            <asp:Panel ID="Panel8" runat="server" GroupingText="Approval Details">
                                                                                                <table class="w-100p bold">
                                                                                                    <tr>
                                                                                                        <td class="w-55p a-right">
                                                                                                            <asp:Label ID="Label6" Text="Study Approve Status: " runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="w-15p a-left">
                                                                                                            <asp:DropDownList ID="ddlEpisodeStatus" runat="server" Width="175px" Style="margin-left: 0px;
                                                                                                                display: block;" CssClass="ddl" Enabled="False" meta:resourcekey="ddlEpisodeStatusResource1">
                                                                                                                <asp:ListItem Text="Pending" Value="Pending" Selected="True" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                                                <asp:ListItem Text="Approve" Value="Approved" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                                                <%-- <asp:ListItem Text="Cancel" Value="Cancel" meta:resourcekey="ListItemResource6"></asp:ListItem> --%>
                                                                                                            </asp:DropDownList>
                                                                                                        </td>
                                                                                                        <td style="display: none;" class="w-10p a-right" runat="server" id="tdApproveRemarks1">
                                                                                                            <asp:Label ID="Label17" Text="Approve Remarks: " runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td style="display: none;" class="w-15p a-left" runat="server" id="tdApproveRemarks2">
                                                                                                            <asp:TextBox ID="txtApproveRemarks" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                                TextMode="MultiLine" MaxLength="254" Height="30px"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </asp:Panel>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" class="a-center">
                                                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                                            <ContentTemplate>
                                                                                                <asp:Button ID="btnFinish" Text="Save" runat="server" 
                                                                                                    CssClass="btn" onmouseout="this.className='btn'" OnClientClick="return checkisempty();"
                                                                                                    Width="100px" OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                                                                                <%--  &nbsp;
                                                                                                <asp:Button ID="Button1" Text="Save Task" runat="server" onmouseover="this.className='btn btnhov'"
                                                                                                CssClass="btn" onmouseout="this.className='btn'"  OnClientClick="return CheckVisitNumberSequence();"
                                                                                                Width="100px"/> --%>
                                                                                                <asp:Button ID="btnCancel" runat="server" Text="Clear" CssClass="btn" 
                                                                                                    onmouseout="this.className='btn'" Width="100px" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                                                                                &nbsp;
                                                                                                <asp:Button ID="btnExit" runat="server" Text="Exit" CssClass="btn" 
                                                                                                    onmouseout="this.className='btn'" Width="100px" OnClick="btnExit_Click" Visible="False"
                                                                                                    meta:resourcekey="btnExitResource1" />
                                                                                            </ContentTemplate>
                                                                                        </asp:UpdatePanel>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td id="tdChkDelete" valign="top" runat="server">
                                                                    <asp:HiddenField ID="hdnCheckIsUsed" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                                <div id="divPrintarea">
                                                    <table width="100%">
                                                        <tr>
                                                            <td class="style3">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html>

<script type="text/javascript">
    showResponses('dvAtt1', 'dvAtt2', 'divLocation', 0);

    function SelectedTherapeuticVlaue(source, eventArgs) {
        var StrName = eventArgs.get_text().trim();
        var StrID = eventArgs.get_value();
    }
    function SetContextValue() {
        var sval = "<%= OrgID %>";
        $find('<%= AutoCompleteExtenderTherapeuticArea.ClientID %>').set_contextKey(sval);
        return false;
    }
    
</script>

