<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminReports.aspx.cs" Inherits="Admin_AdminReports"
    Culture="auto" UICulture="auto" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DialysisCaseSheet.ascx" TagName="casesheet" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Reports</title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ValidateReport() {
            if (document.form1.ddlReport.value == "Select") {
                alert('Select type of report');
                document.form1.ddlReport.focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body onload="onComboFocus('ddlCategory')">
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="ddlCategory">
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
                        <uc3:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 18%">
                                            <asp:Label runat="server" ID="Category" Text="Select a Category" CssClass="label_title">
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCategory" runat='server' TabIndex="1" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" 
                                               CssClass ="ddlsmall"   AutoPostBack="True">
                                                <asp:ListItem Value="Select">Select</asp:ListItem>
                                                <asp:ListItem Value="Revenue">Revenue</asp:ListItem>
                                                <asp:ListItem Value="Patient Related">Patient Related</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div>
                                                <asp:Panel runat="server" GroupingText="Choose" ID="pnlDate" Width="100%" Visible="false">
                                                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td colspan="2" style="width: 18%; height: 35px;">
                                                                <asp:Label runat="server" ID="Label2" Text="Select a Report" CssClass="blackfontcolorbig">
                                                                </asp:Label>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:DropDownList ID="ddlReport" runat='server'  CssClass ="ddlmedium" TabIndex="2"
                                                                    AutoPostBack="false">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDoctor" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10%">
                                                                <asp:CheckBox runat="server" ID="chkToday" Text="Today" CssClass="label_title" TabIndex="3"
                                                                    AutoPostBack="false" OnClientClick="setEnabled();" OnCheckedChanged="chkToday_CheckedChanged"
                                                                    OnPreRender="chkToday_PreRender" />
                                                            </td>
                                                            <td style="width: 7%">
                                                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title">
                                                                </asp:Label>
                                                            </td>
                                                            <td style="width: 35%">
                                                                <asp:TextBox ID="txtFrom" runat="server"  TabIndex="4" MaxLength="1" CssClass ="Txtboxsmall"
                                                                    Style="text-align: justify" ValidationGroup="MKE" />
                                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                    ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" />
                                                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                                    PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                                            </td>
                                                            <td style="width: 6%">
                                                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title">
                                                                </asp:Label>
                                                            </td>
                                                            <td style="width: 42%">
                                                                <asp:TextBox ID="txtTo" runat="server"  CssClass ="Txtboxsmall" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                                    ValidationGroup="MKE" />
                                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                    ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Repeater runat="server" ID="GridView1">
                                                <HeaderTemplate>
                                                    <table style="color: Black" width="80%" border="0">
                                                        <tr align="left">
                                                            <th>
                                                                Name
                                                            </th>
                                                            <th>
                                                                Age
                                                            </th>
                                                            <th>
                                                                Sex
                                                            </th>
                                                            <th>
                                                                Phone No
                                                            </th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td width="30%">
                                                            <asp:Label ID="lblName" Text='<%#Bind("Name") %>' runat="server"></asp:Label>
                                                        </td>
                                                        <td width="10%">
                                                            <asp:Label ID="lblAge" Text='<%#Bind("Age") %>' runat="server"></asp:Label>
                                                        </td>
                                                        <td width="10%">
                                                            <asp:Label ID="lblSex" Text='<%#Bind("Sex") %>' runat="server"></asp:Label>
                                                        </td>
                                                        <td width="20%">
                                                            <asp:Label ID="lblMobile" Text='<%#Bind("Mobile") %>' runat="server"></asp:Label><br />
                                                            <asp:Label ID="lblPhone" Text='<%#Bind("Phone") %>' runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Label ID="lblResult" runat="server" CssClass="label_title"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
