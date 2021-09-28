<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicianWiseReport.aspx.cs"
    Inherits="Reports_PhysicianWiseReport" meta:resourcekey="PageResource2" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style3
        {
            width: 340px;
        }
        .style4
        {
            width: 26%;
        }
        .style5
        {
            width: 30px;
        }
        .style6
        {
            width: 36%;
        }
        .style7
        {
            width: 23%;
        }
    </style>

    <script>
          function DateValidate()
           {
              if ((document.getElementById('txtFromDate').value == '' || document.getElementById('txtToDate').value == '')
                   && (document.getElementById('chkTodayDate').checked == false))
                   {
                alert('Select the From and To dates');
                  document.getElementById('txtFromDate').focus();
                  return false;
                   }
              else 
                   {
                  return true;
                   }
          }
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
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%">
                            <tr>
                                <td class="style7" style="width: 25%;">
                                    <asp:Label ID="lblFromDate" Text="From Date" runat="server" meta:resourcekey="lblFromDateResource2"></asp:Label>
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFromDate"
                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                    <asp:TextBox ID="txtFromDate" runat="server"  CssClass ="Txtboxsmall" Width ="120px" TabIndex="4" MaxLength="1"
                                        Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromDateResource2" />
                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcResource2" />
                                    <ajc:MaskedEditValidator ID="MEdit5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtFromDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MEdit5" meta:resourcekey="MEdit5Resource2" />
                                </td>
                                <td class="style3" style="width: 25%;">
                                    <asp:Label ID="lblTodate" Text="To Date" runat="server" meta:resourcekey="lblTodateResource2"></asp:Label>
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToDate"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtToDate"
                                        PopupButtonID="ImgBntCalc1" Enabled="True" />
                                    <asp:TextBox ID="txtToDate" runat="server"  CssClass ="Txtboxsmall" Width ="120px" TabIndex="4" MaxLength="1"
                                        Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtToDateResource2" />
                                    <asp:ImageButton ID="ImgBntCalc1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalc1Resource2" />
                                    <ajc:MaskedEditValidator ID="MEdit1" runat="server" ControlExtender="MaskedEditExtender1"
                                        ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MEdit1" meta:resourcekey="MEdit1Resource2" />
                                </td>
                                <td align="left" class="style4" style="width: 15%;">
                                    <input type="checkbox" id="chkTodayDate" runat="server" onclick="return Validate();">
                                        <asp:Label ID="Rs_Today" Text="Today" runat="server" meta:resourcekey="Rs_TodayResource2"></asp:Label></input>
                                </td>
                                <td align="right" class="style6" style="width: 15%;">
                                    <asp:DropDownList ID="ddlList" runat="server"  CssClass ="ddlsmall" meta:resourcekey="ddlListResource2">
                                    </asp:DropDownList>
                                </td>
                                <td align="left" style="width: 10%;">
                                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" Height="23px" Width="43px"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnGo_Click"
                                        OnClientClick="return DateValidate();" meta:resourcekey="btnGoResource2" />
                                </td>
                                <td align="right" class="style5" style="width: 10%;">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" OnClick="btnBack_Click"
                                        Height="23px" Width="43px" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        meta:resourcekey="btnBackResource2" />
                                </td>
                            </tr>
                        </table>
                        <rsweb:ReportViewer ID="ReportViewer" runat="server" ProcessingMode="Remote"
                            meta:resourcekey="ReportViewerResource2" Font-Names="Verdana" 
                            Font-Size="8pt">
                            <ServerReport ReportServerUrl="" />
                        </rsweb:ReportViewer>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
