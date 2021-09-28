<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EMITrackingReport.aspx.cs"
    Inherits="Reports_EMITrackingReport" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EMI Tracking Report</title>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.6.js" type="text/javascript"></script>

    <script src="../Scripts/webtoolkit.jscrollable.js" type="text/javascript"></script>

    <script src="../Scripts/webtoolkit.scrollabletable.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script type="text/javascript" runat="server">
        decimal TotalAmounts;
        decimal TotalAmountReceived(decimal totamt)
        {
            if (totamt != 0)
            {
                TotalAmounts += totamt;
            }
            else
            {
                totamt = 0;
            }
            return totamt;
        }
        decimal GetTotalAmount()
        {
            return TotalAmounts;
        }

        decimal TotalEMIValue;
        decimal EMIValue(decimal value)
        {

            if (value != 0)
            {
                TotalEMIValue += value;
            }
            else
            {
                value = 0;
            }
            return value;
        }

        decimal GetTotalEMIValue()
        {
            return TotalEMIValue;
        }
        
     
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
                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                        PopupButtonID="ImgFDate" Enabled="True" CssClass="cal_Theme1" />
                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" 
                                        Width="16px" />
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
                                    <asp:TextBox ID="txtTDate" runat="server"  CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
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
                                        OnClick="lnkBack_Click" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <div id="dvGrid" style="margin-top: 20px; padding-left: 22px;" runat="server">
                            <asp:GridView ID="gvParentGrid" runat="server" DataKeyNames="CreatedAt" Width="75%"
                                AutoGenerateColumns="False" GridLines="both" 
                               ShowFooter="true" CssClass="mytable1">

                                <Columns>   
                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Physician" HeaderText="Name"  />
                                    <asp:BoundField DataField="ClosureStatus" HeaderText="Age"  />
                                    <asp:BoundField DataField="ReceiptNO" HeaderText="Sex"  />
                                    <asp:BoundField DataField="BankNameorCardType" HeaderText="BankName/CardType" />
                                    <asp:BoundField DataField="EMIROI" HeaderText="EMI ROI(In Percentage)"  />
                                    <asp:BoundField DataField="EMITenor" HeaderText="EMI Tenor(In Months)"  />
                                    <asp:TemplateField HeaderText="AmountReceived" FooterStyle-Font-Bold="True" >
                                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <%# TotalAmountReceived(decimal.Parse(Eval("AmtReceived").ToString()))%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <%# (string)" " + GetTotalAmount()%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EMIValue" FooterStyle-Font-Bold="True" ItemStyle-VerticalAlign="Middle"
                                        ItemStyle-Font-Size="9pt" ItemStyle-Height="15px" ItemStyle-Wrap="true" HeaderStyle-Font-Size="10pt"
                                        HeaderStyle-Font-Names="Trebuchet MS" HeaderStyle-ForeColor="Black" HeaderStyle-HorizontalAlign="center"
                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px">
                                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <%# EMIValue(decimal.Parse(Eval("EMIValue").ToString()))%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <%# (string)" " + GetTotalEMIValue()%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                                    </asp:TemplateField>
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                            </asp:GridView>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblTotalAmtReceived" Text="0" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEMIValue" Text="0" runat="server" Visible="false"></asp:Label>
    </div>
    </form>
</body>
</html>
