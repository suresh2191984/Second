<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationReport.aspx.cs"
    Inherits="Physician_InvestigationReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var valVariable = new Array("txtPatientName", "txtFrom", "txtTo");        
    </script>

</head>
<body>
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="40px">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                </td>
                                <td style="width: 32%">
                                    <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" MaxLength="50" onkeypress="return onEnterKeyPress(event);"
                                        meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                </td>
                                <td style="width: 4%">
                                    &nbsp;
                                </td>
                                <td style="width: 45%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_From" Text="From" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntFromResource1" />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntFrom" Enabled="True" />
                                </td>
                                <td>
                                    <asp:Label ID="Rs_To" Text="To" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtToResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntToResource1" />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntTo" Enabled="True" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td colspan="2" align="left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="return validationWithArrays(valVariable);"
                                                meta:resourcekey="btnSearchResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblResultStatus" runat="server" Visible="False" meta:resourcekey="lblResultStatusResource1"></asp:Label>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" CssClass="mytable1" DataKeyNames="PatientVisitId" ForeColor="#333333"
                                                PageSize="5" Width="100%" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                meta:resourcekey="grdResultResource1">
                                                <PagerSettings Mode="NextPrevious" />
                                                <PagerTemplate>
                                                    <tr>
                                                        <td align="center" colspan="6">
                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                CommandName="Page" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px"
                                                                meta:resourcekey="lnkPrevResource1" />
                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                CommandName="Page" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px"
                                                                meta:resourcekey="lnkNextResource1" />
                                                        </td>
                                                    </tr>
                                                </PagerTemplate>
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" meta:resourcekey="rdSelResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "PatientName") %>'
                                                                runat="server" meta:resourcekey="lblIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="VisitDate" HeaderText="VisitDate" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="PatientVisitId" HeaderText="Visitid" Visible="False" meta:resourcekey="BoundFieldResource2" />
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <td colspan="4" align="center">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnGo" runat="server" Text="Show" CssClass="btn1" onmouseover="this.className='btn1 btnhov'"
                                            onmouseout="this.className='btn1'" OnClientClick="return pValidation()" OnClick="btnGo_Click"
                                            meta:resourcekey="btnGoResource1" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <input type="hidden" id="pid" name="pid" />
    </div>
    </form>
</body>
</html>
