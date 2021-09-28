<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FirstDialysis.aspx.cs" Inherits="Physician_FirstDialysis" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Advice" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Dialysis First Visit</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

</head>
<body oncontextmenu="return false;">
    <form id="frmDialysisDebut" runat="server" defaultbutton="bGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                <uc3:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnl1" runat="server" meta:resourcekey="pnl1Resource1">
                            <table class="datatable" width="100%" border="1">
                                <tr>
                                    <td class="defaultfontcolor">
                                        <asp:Label ID="Rs_BackgroundProblems" Text="Background Problems" runat="server" 
                                            meta:resourcekey="Rs_BackgroundProblemsResource1"></asp:Label>
                                    </td>
                                    <td class="defaultfontcolor">
                                        <asp:Label ID="Rs_BasicDetails" Text="Basic Details" runat="server" 
                                            meta:resourcekey="Rs_BasicDetailsResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="color: #000000; width: 40%" valign="top" class="defaultfontcolor">
                                        <asp:TreeView ID="tvwHistory" runat="server" ExpandImageUrl="~/Images/bullet.png"
                                            CollapseImageUrl="~/Images/bullet.png" CssClass="defaultfontcolor" 
                                            meta:resourcekey="tvwHistoryResource1">
                                            <Nodes>
                                                <asp:TreeNode SelectAction="None" Text="History:" Value="0" 
                                                    meta:resourcekey="TreeNodeResource1"></asp:TreeNode>
                                            </Nodes>
                                        </asp:TreeView>
                                    </td>
                                    <td class="defaultfontcolor" nowrap="nowrap" valign="top">
                                        <table width="75%">
                                            <tr>
                                                <td class="defaultfontcolor" nowrap="nowrap">
                                                    <asp:Label ID="Rs_IsFirstDialysis" Text="Is First Dialysis?" runat="server" 
                                                        meta:resourcekey="Rs_IsFirstDialysisResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:CheckBox ID="chkFirst" runat="server" Checked="True" 
                                                        meta:resourcekey="chkFirstResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor" nowrap="nowrap">
                                                    <asp:Label ID="Rs_DialysisSince" Text="Dialysis Since" runat="server" 
                                                        meta:resourcekey="Rs_DialysisSinceResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" align="left" style="width: 180px">
                                                    <asp:TextBox ID="tDate" runat="server" MaxLength="1" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="tDateResource1" CssClass="Txtboxsmall" />
                                                    <asp:ImageButton ID="ImgBntCal" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgBntCalResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="tDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="tDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd-MM-yyyy" runat="server" TargetControlID="tDate"
                                                        PopupButtonID="ImgBntCal" Enabled="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor" nowrap="nowrap">
                                                    <asp:Label ID="Rs_BloodGroup" Text="Blood Group" runat="server" 
                                                        meta:resourcekey="Rs_BloodGroupResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBG" runat="server" Text="UnKnown" 
                                                        meta:resourcekey="lblBGResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor" nowrap="nowrap">
                                                    <asp:Label ID="Rs_HIV" Text="HIV" runat="server" 
                                                        meta:resourcekey="Rs_HIVResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblHIV" runat="server" Text="UnKnown" 
                                                        meta:resourcekey="lblHIVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor" nowrap="nowrap">
                                                    <asp:Label ID="Rs_HbsAg" Text="HbsAg" runat="server" 
                                                        meta:resourcekey="Rs_HbsAgResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblHep" runat="server" Text="UnKnown" 
                                                        meta:resourcekey="lblHepResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <uc6:Advice runat="server" ID="advMedicine" Visible="False" />
                        <asp:Panel ID="pnlButton" runat="server" meta:resourcekey="pnlButtonResource1">
                            <table>
                                <tr>
                                    <td align="right" nowrap="nowrap" id="defaultfontcolor">
                                        <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnSave_Click" Width="89px" 
                                            meta:resourcekey="btnSaveResource1" />
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" Width="87px" 
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
