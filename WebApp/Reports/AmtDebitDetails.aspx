<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmtDebitDetails.aspx.cs"
    Inherits="Reports_AmtDebitDetails" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .divPopup
        {
            display: none;
            z-index: 1000;
            position: absolute;
            background-color: White;
            padding: 2px;
            border: solid 1px black;
        }
        .style1
        {
            width: 40%;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }

       

    </script>

</head>
<body>
    <form id="form1" runat="server">

    <script>
        function ShowPicture(id, PictureName) {
            var position = $("#" + id).position();
            $("[id$='imgPopupPatient']").attr('src', '<%=ResolveUrl("~/Reception/PatientImageHandler.ashx?ADD=' + PictureName + '")%>');
            $('#divFullImage').show().css({ left: position.left - 150, top: position.top + 20 });
            return false;
        }

        function HidePicture() {
            $('#divFullImage').hide();
            return false;
        }
    
    </script>

    <asp:ScriptManager ID="scriptManager1" runat="server">
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
                <uc3:Header ID="UserHeader1" runat="server" />
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
                <td width="100%" valign="top" class="tdspace">
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
                        <div>
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtFDate" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                            PopupButtonID="ImgFDate" Enabled="True" />
                                        <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                            ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTDate" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                            PopupButtonID="ImgTDate" Enabled="True" />
                                        <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                            ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Search" OnClick="btnSearch_Click"
                                            meta:resourcekey="btnSearchResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="divFullImage" class="divPopup">
                                            <img alt="Patient Picture" id="imgPopupPatient" runat="server" src="~/Images/ProfileDefault.jpg" />
                                        </div>
                                        <asp:GridView ID="gvIPDepositMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                            ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPDepositMainResource1"
                                            OnRowDataBound="gvIPDepositMain_RowDataBound">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="User Name" meta:resourcekey="BoundFieldResource1">
                                                    <ItemStyle Width="100px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="100px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DebitedAmount" HeaderText="To Deposit" meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="True" Width="150px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="RemainingAmount" HeaderText="Pending Amount" meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="90px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DebitedDate" HeaderText="Deposit Date" meta:resourcekey="BoundFieldResource7">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="File Details">
                                                    <ItemTemplate>
                                                        <asp:PlaceHolder ID="imgPlaceHolder" runat="server"></asp:PlaceHolder>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- FileURL--%>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
