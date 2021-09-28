<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OPIPNewAndRevisit.aspx.cs"
    Inherits="Reports_OPIPNewAndRevisit" meta:resourcekey="PageResource1" culture="auto" uiculture="auto" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>OP/IP New And Revisit</title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            width: 75px;
        }
        .style2
        {
            width: 302px;
        }
        .style3
        {
            width: 102px;
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
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server">
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
                        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>--%>
                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                        <table border="0" cellpadding="0" cellspacing="1" width="100%">
                            <tr>
                                <td height="32">
                                    <div class="dataheaderWider">
                                        <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="style1" align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td class="style2">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
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
                                                <td class="style1" align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td class="style2">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
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
                                                <td class="style3">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" 
                                                        meta:resourcekey="imgBtnXLResource1" />
                                                    <asp:LinkButton ID="lnkExportXL" runat="server" Font-Bold="True" Font-Size="12px"
                                                        ForeColor="Black" ToolTip="Save As Excel" OnClick="imgBtnXL_Click" 
                                                        meta:resourcekey="lnkExportXLResource1"><u><asp:Label ID="lbexporttoxl" 
                                                        runat="server" Text="Export To XL" meta:resourcekey="lbexporttoxlResource1"></asp:Label></u></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdDate" style="font-weight: bold; font-size: 14px;" runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                <div id="divResult" runat="server">
                                    <table>
                                        <tr valign="top">
                                            <td>
                                                <asp:Label runat="server" ID="lblVisit" Text="VISIT DETAILS"  
                                                    style="display:none;" meta:resourcekey="lblVisitResource1"></asp:Label>
                                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                    CssClass="mytable1" RowStyle-BackColor="White" 
                                                    ItemStyle-VerticalAlign="Top" meta:resourcekey="grdResultResource2">
<RowStyle BackColor="White"></RowStyle>
                                                    <Columns>
                                                        <asp:BoundField HeaderText="VISIT TYPE" DataField="PatientName" />
                                                        <asp:BoundField HeaderText="COUNT" DataField="VisitNotes" ItemStyle-HorizontalAlign="Right" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                            <td>  &nbsp;</td>
                                            <td>
                                             <asp:Label runat="server" ID="lblBill" Text="BILL DETAILS" style="display:none;" 
                                                    meta:resourcekey="lblBillResource1"></asp:Label>
                                                <asp:GridView ID="GrdVisit" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                    CssClass="mytable1" RowStyle-BackColor="White" 
                                                    meta:resourcekey="GrdVisitResource1">
<RowStyle BackColor="White"></RowStyle>
                                                    <Columns>
                                                        <asp:BoundField HeaderText="BILLING DETAILS" DataField="PatientName" />
                                                        <asp:BoundField HeaderText="Total Amount" DataField="VisitNotes" ItemStyle-HorizontalAlign="Right" />
                                                        
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <%--  </ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
