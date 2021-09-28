<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetRoomCollectionIPReport.aspx.cs"
    Inherits="Reports_GetRoomCollectionIPReport" meta:resourcekey="PageResource1" %>

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
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
            <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

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
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body oncontextmenu="return false;">
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="dataheader2">
                                    <table id="tbl">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                    PopupButtonID="ImgFDate" Enabled="True" />
                                                <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                    Enabled="True" />
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
                                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                    Enabled="True" />
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
                                            <td>
                                                <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                    ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <div id="divPrint" style="display: none;" runat="server">
                                    <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                        <tr>
                                            <td align="right" style="padding-right: 10px; color: #000000;">
                                                <b id="printText" runat="server">
                                                    <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                </b>
                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                               
                                            <div id="prnReport">
                                                <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Width="90%"
                                                    OnRowDataBound="gvIPReport_RowDataBound" meta:resourcekey="gvIPReportResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Collection Report" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td align="left" style="height: 25px;">
                                                                            <b>
                                                                                <asp:Label ID="Rs_Date" Text="Date:" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                            <%# DataBinder.Eval(Container.DataItem, "BillDate", "{0:dd/MM/yyyy}")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="90%"
                                                                                ForeColor="#333333" OnRowDataBound="gvIPCreditMain_RowDataBound" CssClass="mytable1"
                                                                                meta:resourcekey="gvIPCreditMainResource1">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No">
                                                                                        <ItemStyle Width="25px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill Number">
                                                                                        <ItemStyle Width="25px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Qty" HeaderText="Unit" meta:resourcekey="BoundFieldResource5">
                                                                                        <ItemStyle Width="25px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="VisitDate" HeaderText="Date" >
                                                                                        <ItemStyle Width="150px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BillNumber" Visible="False" HeaderText="BillNumber" meta:resourcekey="BoundFieldResource7">
                                                                                        <ItemStyle Width="25px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="RoomName" HeaderText="RoomName/RoomType" meta:resourcekey="BoundFieldResource8">
                                                                                        <ItemStyle Width="25px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BillAmount" HeaderText="Bill Amt" meta:resourcekey="BoundFieldResource9">
                                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                </Columns>
                                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                               
                                <div id="breakup">
                                    <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheader2"
                                        cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                        <tr runat="server">
                                            <td align="right" style="width: 80%;" runat="server">
                                                <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server"></asp:Label>
                                                <label id="Label1" style="color: Green;" runat="server">
                                                </label>
                                                :
                                            </td>
                                            <td align="right" style="padding-right: 15px;" runat="server">
                                                <label id="lblGrandTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ContentTemplate>
                             <Triggers>
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                               
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
