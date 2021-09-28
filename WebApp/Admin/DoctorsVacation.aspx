<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DoctorsVacation.aspx.cs"
    Inherits="Admin_ChangeDocSchedule" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/UCDate.ascx" TagName="UCDate" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="ucBookedScvhedule"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Schedule</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body onload="onComboFocus('ddlDrName');">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function ChkValidation() {
            var objDoctor = SListForAppMsg.Get("Admin_DoctorsVacation_aspx_01") == null ? "Select doctor" : SListForAppMsg.Get("Admin_DoctorsVacation_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_DoctorsVacation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_DoctorsVacation_aspx_Alert");

            var selVal = document.getElementById('<%= ddlDrName.ClientID %>').value;
            if (selVal == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\DoctorsVacation.aspx_1");
                if (userMsg != null) {
                    //                    alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //                    alert('Select doctor');
                    ValidationWindow(objDoctor, objAlert);
                    return false;
                }
            }
            return true;
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server">
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
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" border="0" cellpadding="0" cellspacing="1">
                                    <tr>
                                        <td align="center" class="dataheader2">
                                            &nbsp;<table border="0" cellpadding="0" cellspacing="1">
                                                <tr>
                                                    <td align="left" class="style1">
                                                        <asp:Label ID="lblDoctorName" runat="server" Text="Doctor Name" meta:resourcekey="lblDoctorNameResource1"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        : &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlDrName" runat="server" CssClass="ddlsmall" TabIndex="1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" class="tabletxt">
                                                        <asp:Label ID="lblVaccationFrom" runat="server" Text="Vaccation From" meta:resourcekey="lblVaccationFromResource1"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        : &nbsp;
                                                    </td>
                                                    <td>
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                            TargetControlID="tDOB" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                            TargetControlID="tDOB" Enabled="True" />
                                                        <asp:TextBox ID="tDOB" runat="server" MaxLength="1" Style="text-align: justify" TabIndex="2"
                                                            ValidationGroup="MKE" CssClass="Txtboxsmall" meta:resourcekey="tDOBResource1" />
                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            meta:resourcekey="ImgBntCalcResource1" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="tDOB" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" class="tabletxt">
                                                        <asp:Label ID="lblVaccationTo" runat="server" Text="Vaccation To" meta:resourcekey="lblVaccationToResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        : &nbsp;
                                                    </td>
                                                    <td>
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                            TargetControlID="txtToDate" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton1"
                                                            TargetControlID="txtToDate" Enabled="True" />
                                                        <asp:TextBox ID="txtToDate" runat="server" MaxLength="1" Style="text-align: justify"
                                                            TabIndex="2" ValidationGroup="MKE" CssClass="Txtboxsmall" meta:resourcekey="txtToDateResource1" />
                                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            meta:resourcekey="ImageButton1Resource1" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtToDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn" TabIndex="7" Text="Search"
                                                            OnClientClick="return ChkValidation();" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divError" align="center" runat="server" visible="False">
                                                <br />
                                                <asp:Label ID="lblNoSchedule" runat="server" Text="No Schedules available for selected Dates"
                                                    meta:resourcekey="lblNoScheduleResource1"></asp:Label>
                                                .
                                            </div>
                                            <div align="center" class="dataheader2" id="dvAdvancePayments" runat="server" visible="False">
                                                <asp:Panel ID="pnltempAdvancePayments" runat="server" CssClass="defaultfontcolor"
                                                    meta:resourcekey="pnltempAdvancePaymentsResource1">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td class="colorforcontent" height="23" align="left">
                                                                <div id="ACX2plusAdvPmt" style="display: none;">
                                                                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                                                                        &nbsp;<asp:Label ID="lblPlanedVacation" runat="server" Text="Planned Vacation Details"
                                                                            meta:resourcekey="lblPlanedVacationResource1"></asp:Label>
                                                                    </span>
                                                                </div>
                                                                <div id="ACX2minusAdvPmt" style="display: block;">
                                                                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                                                                        &nbsp;
                                                                        <asp:Label ID="lblplanvacationdetails" runat="server" Text="Planned Vacation Details"
                                                                            meta:resourcekey="lblplanvacationdetailsResource1"></asp:Label>
                                                                </div>
                                                            </td>
                                                            <td style="width: 75%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: block;">
                                                            <td colspan="2">
                                                                <div class="filterdatahe" align="center">
                                                                    <asp:GridView ID="gvPhyVacation" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Bold="False"
                                                                        Font-Names="Verdana" Font-Size="10pt" OnRowCommand="gvPhyVacation_RowCommand"
                                                                        OnRowDataBound="gvPhyVacation_RowDataBound" OnRowDeleting="gvPhyVacation_RowDeleting"
                                                                        meta:resourcekey="gvPhyVacationResource1" CssClass="w-100p gridView">
                                                                        <RowStyle ForeColor="#000066" />
                                                                        <Columns>
                                                                            <asp:BoundField HeaderText="ID" DataField="VaccationID" meta:resourcekey="BoundFieldResource1" />
                                                                            <asp:CommandField ShowSelectButton="True" meta:resourcekey="CommandFieldResource1" />
                                                                            <asp:BoundField HeaderText="From" DataFormatString="{0:dd/MM/yyyy}" DataField="Fromdate"
                                                                                meta:resourcekey="BoundFieldResource2">
                                                                                <HeaderStyle Font-Bold="False" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField HeaderText="To" DataFormatString="{0:dd/MM/yyyy}" DataField="ToDate"
                                                                                meta:resourcekey="BoundFieldResource3">
                                                                                <HeaderStyle Font-Bold="False" />
                                                                            </asp:BoundField>
                                                                            <asp:CommandField ShowDeleteButton="True" meta:resourcekey="CommandFieldResource2" />
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="False" ForeColor="White" />
                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                            <div id="dvSchedules" runat="server" visible="False">
                                                <asp:Label ID="lblSchedules" runat="server" Text="Schedules" meta:resourcekey="lblSchedulesResource1"></asp:Label>
                                                <asp:DataList ID="dlSchedules" runat="server" OnLoad="Page_Load" RepeatColumns="5"
                                                    RepeatDirection="Horizontal" meta:resourcekey="dlSchedulesResource1">
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <asp:Panel align="center" ID="dvFloor" Style="width: 120px; vertical-align: middle;
                                                            border-color: Silver; background-color: #dcfec6; border-style: solid; border-width: 1px;
                                                            color: Black;" runat="server" meta:resourcekey="dvFloorResource1">
                                                            <asp:Label ID="lblDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"NextOccurance","{0:dd/MM/yyyy}") %>'
                                                                meta:resourcekey="lblDateResource1"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblFrom" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"From","{0:hh:mm.FF tt}") %>'
                                                                meta:resourcekey="lblFromResource1"></asp:Label>
                                                            <asp:Label ID="lblTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"To","{0:hh:mm.FF tt}") %>'
                                                                meta:resourcekey="lblToResource1"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblRTID" runat="server" Text='<%# Eval("ResourceTemplateID") %>' Visible="False"
                                                                meta:resourcekey="lblRTIDResource1"></asp:Label>
                                                            <asp:Label ID="lblSID" runat="server" Text='<%# Eval("ScheduleID") %>' Visible="False"
                                                                meta:resourcekey="lblSIDResource1"></asp:Label>
                                                        </asp:Panel>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:DataList>
                                            </div>
                                            <div id="dvBookedSlots" runat="server" visible="False">
                                                <asp:Label ID="lblBookedSlots" runat="server" Text="Booked Slots" meta:resourcekey="lblBookedSlotsResource1"></asp:Label>
                                                <asp:DataList ID="dlBookedSlots" runat="server" OnLoad="Page_Load" RepeatColumns="5"
                                                    RepeatDirection="Horizontal" meta:resourcekey="dlBookedSlotsResource1">
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <asp:Panel align="center" ID="dvFloor0" runat="server" Style="width: 120px; vertical-align: middle;
                                                            border-color: Silver; background-color: #fcf2c3; border-style: solid; border-width: 1px;
                                                            color: Black;" meta:resourcekey="dvFloor0Resource1">
                                                            <asp:Label ID="lblSTARTTIME" runat="server" Text='<%# Eval("StartTime") %>' meta:resourcekey="lblSTARTTIMEResource1"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblENDTIME" runat="server" Text='<%# Eval("EndTime") %>' meta:resourcekey="lblENDTIMEResource1"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblBOOKINGDESCRIPTION" runat="server" CssClass="borderstyle22" Text='<%# Eval("BookingDescription") %>'
                                                                meta:resourcekey="lblBOOKINGDESCRIPTIONResource1"></asp:Label>
                                                            <asp:Label ID="lblTOKEN" runat="server" Text='<%# Eval("TokenNumber") %>' Visible="False"
                                                                meta:resourcekey="lblTOKENResource1"></asp:Label>
                                                        </asp:Panel>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:DataList>
                                            </div>
                                            <div align="center">
                                                &nbsp;<asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnModify_Click"
                                                    Enabled="False" TabIndex="7" Text="Save" meta:resourcekey="btnSaveResource1" />
                                                &nbsp;&nbsp;&nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                    TabIndex="8" Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                                <asp:HiddenField ID="hdnVacationID" runat="server" Value="0" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
