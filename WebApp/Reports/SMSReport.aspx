<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SMSReport.aspx.cs" Inherits="Reports_SMSReport" %>

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
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type ="text/javascript" language ="javascript">

        function SelectRow(rid, PID,SMSDAY) {

            document.getElementById('hdnRowID').value = rid;
            document.getElementById('hdnPatientID').value = PID;
            document.getElementById('hdnSMSDay').value = SMSDAY;
            

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="header">
        <div class="logoleft" style="z-index: 2;">
            <div class="logowrapper">
                <%--   <img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
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
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
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
                            <td>
                                <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
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
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                    OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <asp:GridView ID="GvSMSReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="GvSMSReport_RowDataBound"
                                    DataKeyNames="Dose,DrugID" OnRowCommand="GvSMSReport_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Dose" HeaderText="Patient No">
                                            <ItemStyle Width="25px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PrescriptionType" HeaderText="Name">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BrandName" HeaderText="Drug Name">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CreatedAt" HeaderText="BilledDate">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="80px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TotalQty" HeaderText="Total Quantity">
                                            <ItemStyle Width="25px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IssuedQty" HeaderText="Issued Quantity" />
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnsendSMS" runat="server" Text="SendSMS" Visible="false" OnClick="btnsendSMS_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:HiddenField ID="hdnPatientVisitID" runat="server" Value="0" />
                <asp:HiddenField ID ="hdnRowID" runat ="server" />
                <asp:HiddenField ID="hdnPatientID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnSMSDay" runat ="server" />
    </form> 
</body>
</html>
