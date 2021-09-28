<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryPlanReport.aspx.cs"
    Inherits="Reports_SurgeryPlanReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Surgery/Procedure Plan Report </title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.6.js" type="text/javascript"></script>

    <script src="../Scripts/webtoolkit.jscrollable.js" type="text/javascript"></script>

    <script src="../Scripts/webtoolkit.scrollabletable.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">


        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {

                var userMsg = SListForApplicationMessages.Get('CommonMessages_18');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide / select From date');
                }
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonMessages_19');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide / select From date');
                }
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.focus();
            WinPrint.print();

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
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
                                                <td align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTDate" CssClass ="Txtboxsmall" Width ="120px" runat="server"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                                </td>
                                                <td>
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <%--<asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />--%>
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divPrint" style="display: block;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                    <img alt="Print Report" id="btnPrint" src="../Images/printer.gif" onclick="return popupprint();"
                                                        meta:resourcekey="btnPrintResource1" style="cursor: pointer;" />
                                                    <%--<asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />--%>
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="prnReport" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="grdTreatementPlan" runat="server" AutoGenerateColumns="False" DataKeyNames="TreatmentplanID"
                                                            headerText="Plan Surgery " Visible="true" CssClass="filterdataheader2">
                                                            <PagerStyle HorizontalAlign="Left" />
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                PageButtonCount="5" PreviousPageText="" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.NO">
                                                                  <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                             <asp:TemplateField HeaderText="Patient Number" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblname" runat="server" Text='<%# Bind("ScrubTeam") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                        
                                                                <asp:TemplateField HeaderText="Patient Name" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblname" runat="server" Text='<%# Bind("PatientName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Treatment Plan Name" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbltreatmentplanname" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="TreatmentPlanDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Treatment Plan Date" />
                                                            
                                                                <asp:TemplateField HeaderText="Prosthesis" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblProsthesis" runat="server" Text='<%# Bind("Prosthesis") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Room Name" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblroomstatus" runat="server" Text='<%# Bind("RoomName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Provisional" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblProvisonal" runat="server" Text='<%# Bind("IsProvisional") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Surgeon Name" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSurgeonNmae" runat="server" Text='<%# Bind("SurgeonName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Anesthesist Name" ItemStyle-Width="14%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAnesthesiastname" runat="server" Text='<%# Bind("AnesthesiastName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                             <asp:TemplateField HeaderText="Site of Operation" ItemStyle-Width="14%"  >
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# Bind("SiteOfOperation") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
</body>
</form>
</html>
