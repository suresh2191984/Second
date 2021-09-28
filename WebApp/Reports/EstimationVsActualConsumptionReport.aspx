<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EstimationVsActualConsumptionReport.aspx.cs"
    Inherits="Reports_EstimationVsActualConsumptionReport" %>

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
    <title>EMI Tracking Report</title>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script type="text/javascript" runat="server">
      
     
    </script>

    <style type="text/css">
        /*Calendar Control CSS*/.expand
        {
            background-image: url(images/plus.gif);
            width: 9px;
            height: 9px;
        }
        .collapse
        {
            background-image: url(images/minus.gif);
            width: 9px;
            height: 9px;
        }
        .cal_Theme1 .ajax__calendar_container
        {
            background-color: #DEF1F4;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_header
        {
            background-color: #ffffff;
            margin-bottom: 4px;
        }
        .cal_Theme1 .ajax__calendar_title, .cal_Theme1 .ajax__calendar_next, .cal_Theme1 .ajax__calendar_prev
        {
            color: #004080;
            padding-top: 3px;
        }
        .cal_Theme1 .ajax__calendar_body
        {
            background-color: #ffffff;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_dayname
        {
            text-align: center;
            font-weight: bold;
            margin-bottom: 4px;
            margin-top: 2px;
            color: #004080;
        }
        .cal_Theme1 .ajax__calendar_day
        {
            color: #004080;
            text-align: center;
        }
        .cal_Theme1 .ajax__calendar_hover .ajax__calendar_day, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_month, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_year, .cal_Theme1 .ajax__calendar_active
        {
            color: #004080;
            font-weight: bold;
            background-color: #DEF1F4;
        }
        .cal_Theme1 .ajax__calendar_today
        {
            font-weight: bold;
        }
        .cal_Theme1 .ajax__calendar_other, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_today, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_title
        {
            color: #bbbbbb;
        }
        body
        {
            margin: 0px;
        }
    </style>

    <script type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "Images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "Images/plus.gif";
            }
        }

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
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblFromDate" Text="From Date:" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1" ></asp:TextBox>
                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                        PopupButtonID="ImgFDate" Enabled="True" CssClass="cal_Theme1" />
                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" Width="16px" />
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
                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                        PopupButtonID="ImgTDate" Enabled="True" CssClass="cal_Theme1" />
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
                                <td>
                                    <asp:Button ID="btnShow" Text="Show Report" runat="server" OnClick="btnView_Click" CssClass ="btn"
                                        Font-Names="Trebuchet MS" OnClientClick="javascript:return validateToDate();" />
                                </td>
                                <td>
                                    <asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExcel_Click" CssClass ="btn"
                                        Font-Names="Trebuchet MS" />
                                </td>
                                <td align="left">
                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                        OnClick="lnkBack_Click"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <div id="dvGrid" style="margin-top: 20px; padding-left: 22px;" runat="server">
                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="0" DataKeyNames="Description" ForeColor="#333333" GridLines="None"
                                Width="100%" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                HeaderStyle-BorderWidth="0px">
                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                cellspacing="0" border="1" width="100%">
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                        <tr class="Duecolor">
                                                                            <td align="left" style="font-weight: bold;">
                                                                                <asp:Label ID="lblServiceType" Text='<%# DataBinder.Eval(Container.DataItem,"Description") %>'
                                                                                    runat="server"></asp:Label>
                                                                                <br />
                                                                                <asp:Label ID="lblspcae" runat="server" Text="Service Count" meta:resourcekey="lblspcaeResource1"></asp:Label>
                                                                                <asp:Label ID="lblServiceName" Text='<%# DataBinder.Eval(Container.DataItem,"LocationID") %>'
                                                                                    runat="server" meta></asp:Label>
                                                                            </td>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                        PageSize="100" ForeColor="Black" OnRowDataBound="grdChildResult_RowDataBound"
                                                                        Width="100%">
                                                                        <PagerTemplate>
                                                                            <tr>
                                                                                <td align="center" colspan="6">
                                                                                    <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                                                                    <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                                                                </td>
                                                                            </tr>
                                                                        </PagerTemplate>
                                                                        <HeaderStyle Font-Underline="True" />
                                                                        <RowStyle Font-Bold="False" />
                                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="FeeType" HeaderText="Resource Names" />
                                                                            <asp:BoundField DataField="ProductID" HeaderText="Estimated Quantity" />
                                                                            <asp:BoundField DataField="BillofMaterialID" HeaderText="Utility Quantity" />
                                                                            <asp:BoundField DataField="ParentProductID" HeaderText="Utility Difference" />
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderWidth="0px"></HeaderStyle>
                            </asp:GridView>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
