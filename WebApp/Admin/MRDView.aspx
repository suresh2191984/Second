<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MRDView.aspx.cs" Inherits="Admin_MRDView"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MRD View</title>
    <%-- <script src="../Scripts/bid.js" type="text/javascript"></script>

   <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table cssclass="dataheader2" border="1" width="100%">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSerachPatientName" Text="Patient Name" runat="server" meta:resourcekey="lblSerachPatientNameResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSerachPatientName" runat="server" CssClass="Txtboxsmall" onkeydown="return isAlphaNumeric(event.keyCode);"
                                                            meta:resourcekey="txtSerachPatientNameResource1"></asp:TextBox>
                                                        <%--<input id="txtAlphanumeric" onkeydown="return isAlphaNumeric(event.keyCode);" onkeyup="keyUP(event.keyCode)" onpaste="return false;" style="width: 235px" type="text">--%>
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="lblMRDNOSearch" Text="MRD No" runat="server" meta:resourcekey="lblMRDNOSearchResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:TextBox ID="txtSearchMRDNO" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtSearchMRDNOResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%">
                                                        <asp:DropDownList ID="ddlStatus" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="left" style="width: 10%">
                                                        <asp:Label ID="Rs_BillDate" runat="server" Text="Visit Date" meta:resourcekey="Rs_BillDateResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%">
                                                        <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                                            CssClass="ddlsmall" runat="server" Width="90px" meta:resourcekey="ddlRegisterDateResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <div id="divRegDate" style="display: none" runat="server">
                                                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                            <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                            <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                        </div>
                                                        <div id="divRegCustomDate" runat="server" style="display: none;">
                                                            <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate2Resource1"></asp:Label>
                                                            <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                            <asp:Label ID="Rs_ToDate2" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate2Resource1"></asp:Label>
                                                            <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourceKey="ImgBntCalcToResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblSearchSelect" Text="Select Option" runat="server" meta:resourcekey="lblSelectResource1"></asp:Label>
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <asp:RadioButtonList ID="radSearchSelectOption" runat="server" RepeatDirection="Horizontal"
                                                            Onclick="ChkSearchMRDType();">
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSelectOption" runat="server" CssClass="biltextb" autocomplete="off"
                                                            meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSelectOption"
                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                            OnClientItemSelected="IAMSelectDept" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            ServiceMethod="GetMRDType" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSearch" Text="Search" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                            meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td nowrap="nowrap" rowspan="1">
                                                        <asp:GridView ID="dgvResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            CellPadding="4" Width="100%" OnPageIndexChanging="dgvResult_PageIndexChanging"
                                                            OnRowCommand="dgvResult_RowCommand" ForeColor="#333333" 
                                                            OnRowDataBound="dgvResult_RowDataBound" CssClass="mytable1">
                                                            <PagerStyle HorizontalAlign="Center" BackColor="White" ForeColor="Red" />
                                                            <Columns>
                                                                
                                                                <asp:TemplateField HeaderText="PatientID" Visible="False" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtPatientID" runat="server" Text='<%# Eval("PatientID") %>' meta:resourcekey="txtPatientIDResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="PatientVisitId" Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtPatientVisitId" runat="server" Text='<%# Eval("PatientVisitId") %>'
                                                                            meta:resourcekey="txtPatientVisitIdResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Visit Date" DataFormatString="{0:dd/MM/yyyy}" DataField="VisitDate"
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtPatientName" runat="server" Text='<%# Eval("PatientName") %>' meta:resourcekey="txtPatientNameResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="MRD No" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtPatientNumber" runat="server" Text='<%# Eval("PatientNumber") %>'
                                                                            meta:resourcekey="txtPatientNumberResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Visit Number" meta:resourcekey="TemplateFieldResource5">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtVisitNumber" runat="server" Text='<%# Eval("VisitNumber") %>' meta:resourcekey="txtVisitNumberResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Description Name" Visible="False" meta:resourcekey="TemplateFieldResource6">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtAddress" runat="server" Text='<%# Eval("Address") %>' meta:resourcekey="txtAddressResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Phone No" meta:resourcekey="TemplateFieldResource7">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtMobileNo" runat="server" Text='<%# Eval("MobileNo") %>' meta:resourcekey="txtMobileNoResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="SpecialityName" meta:resourcekey="TemplateFieldResource8">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtSpecialityName" runat="server" Text='<%# Eval("SpecialityName") %>'
                                                                            meta:resourcekey="txtSpecialityNameResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Status" Visible="False" meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtStatus" runat="server" Text='<%# Eval("Status") %>' meta:resourcekey="txtStatusResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkCheckOut" runat="server" Text="CheckOut"
                                                                            CommandName="CheckOut" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            ToolTip="CheckOut The File" />
                                                                        <asp:LinkButton ID="lnkTransfer" runat="server" Text="Transfer" 
                                                                            CommandName="Transfer" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            ToolTip="Transfer The File" />
                                                                        <asp:LinkButton ID="lnkCheckIN" runat="server" Text="CheckIN" CommandName="CheckIN" OnClientClick="return Confirmation(this.id)"
                                                                            CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' ToolTip="CheckIn The File" />
                                                                        <asp:LinkButton ID="lnkReceive" runat="server" Text="Receive" CommandName="Receive"
                                                                            CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' ToolTip="Receive The File" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <HeaderStyle Font-Size="Small" ForeColor="#FFFFFF" CssClass="grdcolor" Font-Bold="True" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <RowStyle ForeColor="#000066" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        </asp:GridView>
                                                        <ajc:ModalPopupExtender ID="MPEFeeType" runat="server" TargetControlID="Button1"
                                                            PopupControlID="Panel1" BackgroundCssClass="modalBackground" Enabled="True" DropShadow="True"
                                                            DynamicServicePath="" />
                                                        <input type="button" id="Button1" runat="server" style="display: none;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="display: none;
            width: 600px; height: auto;" meta:resourcekey="Panel1Resource1">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table cellpadding="2" cellspacing="2" width="100%">
                        <tr class="dataheader1">
                            <td nowrap="nowrap">
                                <asp:Label ID="lblPatientName1" Text="Patient Name" runat="server" meta:resourcekey="lblPatientName1Resource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblMRDNo1" Text="MRD No" runat="server" meta:resourcekey="lblMRDNo1Resource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblVisitNo1" Text="Visit No" runat="server" meta:resourcekey="lblVisitNo1Resource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblSpeciality1" Text="Speciality" runat="server" meta:resourcekey="lblSpeciality1Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblMRDNo" runat="server" meta:resourcekey="lblMRDNoResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblSpeciality" runat="server" meta:resourcekey="lblSpecialityResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr class="dataheader1">
                            <td nowrap="nowrap" colspan="4">
                                <asp:Label ID="lblSelect" Text="Select Option" runat="server" meta:resourcekey="lblSelectResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" colspan="4">
                                <asp:RadioButtonList ID="radSelectOption" runat="server" RepeatDirection="Horizontal"
                                    Onclick="ChkMRDType();" meta:resourcekey="radSelectOptionResource1">
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="dataheader1">
                            <td>
                                <asp:Label ID="lblName" Text="Name" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblPerson" Text="Collected Person" runat="server" meta:resourcekey="lblPersonResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtName" runat="server" CssClass="biltextb" autocomplete="off" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="actName" runat="server" TargetControlID="txtName" EnableCaching="False"
                                    MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True" OnClientItemSelected="IAMSelectDept"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetMRDType"
                                    ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCollectedPerson" runat="server" CssClass="biltextb" autocomplete="off"
                                    meta:resourcekey="txtCollectedPersonResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderDriverName" runat="server" TargetControlID="txtCollectedPerson"
                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                    OnClientItemSelected="funDriverName" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    ServiceMethod="GetPerformingDriverName" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td colspan="2">
                                <asp:Button ID="btnSubmit" type="button" Text="Submit" runat="server" CssClass="btn"
                                    OnClick="btnSubmit_Click" OnClientClick="javascript:return Validation();" meta:resourcekey="btnSubmitResource1" />
                                <asp:Button ID="btnClose" type="button" Text="Close" runat="server" CssClass="btn"
                                    OnClientClick="mopClose();" meta:resourcekey="btnCloseResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="dgvHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" OnPageIndexChanging="dgvHistory_PageIndexChanging"
                                                meta:resourcekey="dgvHistoryResource1">
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Visit Date" meta:resourcekey="TemplateFieldResource11">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblVisitDate1" runat="server" meta:resourcekey="lblVisitDate1Resource1"
                                                                Text='<%# Eval("VisitDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="CategoryType" HeaderText="Category Type" meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField DataField="SpecialityName" HeaderText="Category Name" meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="FromPerson" HeaderText="From Person" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="ToPerson" HeaderText="To Person" meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource6" />
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle CssClass="dataheaderInvCtrl" HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:HiddenField ID="hdnPatientID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnPatientVisitID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnCatgID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnCollectedID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnStatus" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
    <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
    <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
    <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
    <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
    <asp:HiddenField ID="hdnLastDayYear" runat="server" />
    <asp:HiddenField ID="hdnDateImage" runat="server" />
    <asp:HiddenField ID="hdnTempFrom" runat="server" />
    <asp:HiddenField ID="hdnTempTo" runat="server" />
    <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
    <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
    <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
    <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
    <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
    <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
    <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
    <asp:HiddenField ID="hdnLastYearLast" runat="server" />
    <asp:HiddenField ID="hdnSearchOption" runat="server" />
    </form>

    <script type="text/javascript">
        function ChkMRDType() {
            var list = document.getElementById('<%= radSelectOption.ClientID %>'); //Client ID of the radiolist
            var inputs = list.getElementsByTagName("input");
            var selected;

            for (var i = 0; i < inputs.length; i++) {

                if (inputs[i].checked) {
                    selected = inputs[i];
                    break;
                }
            }
            if (selected) {

                var sval = selected.value;
                $find('actName').set_contextKey(sval);
            }

            Clear();
        }


        function IAMSelectDept(source, eventArgs) {
            var txtType = eventArgs.get_text();
            var txttxt = eventArgs.get_value();
            document.getElementById('<%= txtName.ClientID %>').value = txtType;
            document.getElementById('<%= hdnCatgID.ClientID %>').value = txttxt;

        }

        function funDriverName(source, eventArgs) {
            var txtDrivername = eventArgs.get_text();
            var txtDriverID = eventArgs.get_value();
            document.getElementById('<%= txtCollectedPerson.ClientID %>').value = txtDrivername;
            document.getElementById('<%= hdnCollectedID.ClientID %>').value = txtDriverID;

        }

        function Clear() {
            document.getElementById('<%= txtName.ClientID %>').value = '';
            document.getElementById('<%= txtCollectedPerson.ClientID %>').value = '';
        }

        function Validation() {
            var list = document.getElementById('<%= radSelectOption.ClientID %>'); //Client ID of the radiolist
            var inputs = list.getElementsByTagName("input");
            var selected;

            for (var i = 0; i < inputs.length; i++) {

                if (inputs[i].checked) {
                    selected = inputs[i];
                    break;
                }
            }

            if (selected == undefined) {
                userMsg = SListForApplicationMessages.Get('Admin\\MRDView.aspx_1');

                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Select Any One Option');

                }

                return false;
            }

            else if (document.getElementById('<%= txtName.ClientID %>').value == '' || document.getElementById('<%= hdnCatgID.ClientID %>').value == '0' || document.getElementById('<%= hdnCatgID.ClientID %>').value == '') {
                userMsg = SListForApplicationMessages.Get('Admin\\MRDView.aspx_2');

                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Select a Name');
                }

                return false;
            }
            else {
                return true;
            }

        }
        function mopClose() {
            Clear();
            $find('MPEFeeType').hide();
        }

        
        function Confirmation(id) {

            var re = confirm("Are You sure to CheckIn this File?");
            if (re == true) {
                alert('Updated successfully');
                return true;
            }
            else {
                return false;
            }
        }

        function ShowRegDate() {
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
            document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
            document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = "";
            document.getElementById('<%=hdnTempTo.ClientID %>').value = "";

            document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "0";
            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "0";
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "0") {

                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "1") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "2") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';

            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "3") {
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "1";
                document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "-1") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "4") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "5") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "6") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "7") {
                document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
                document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
                document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;
                document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
                document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;

                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
                document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            }
        }
        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Updated successfully');
            }

            return true;
        }
        function ChkSearchMRDType() {

            var list = document.getElementById('<%= radSearchSelectOption.ClientID %>');
            var inputs = list.getElementsByTagName("input");
            var selected;

            for (var i = 0; i < inputs.length; i++) {

                if (inputs[i].checked) {
                    selected = inputs[i];
                    break;
                }
            }
            if (selected) {

                var sval = selected.value;
                $find('AutoCompleteExtender1').set_contextKey(sval);
                document.getElementById('<%= hdnSearchOption.ClientID %>').value = sval;
            }

            Clear();
        }
        var isShift;

        function isAlphaNumeric(keyCode) {
            return (((keyCode >= 48 && keyCode <= 57) && (isShift == false)) ||
               (keyCode >= 65 && keyCode <= 90) || keyCode == 8 ||
               (keyCode >= 96 && keyCode <= 105))
        }
        
             
    </script>

</body>
</html>
