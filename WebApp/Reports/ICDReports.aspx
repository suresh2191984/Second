<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ICDReports.aspx.cs" Inherits="Reports_ICDReports"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ICDCodeReport.ascx" TagName="ICDCodeReport" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

        function popupprintD() {
            var prtContent = document.getElementById('tblPatientDetail');
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
                        <table id="tblICDreport" align="center" width="100%">
                            <tr align="center">
                                <td>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td colspan="4" align="center">
                                                            <uc2:ICDCodeReport ID="ICDCodeReport1" runat="server" />
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
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
                                                        <td align="right">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
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
                                                        <td align="left">
                                                            <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                                meta:resourcekey="rblReportTypeResource1">
                                                                <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" 
                                                                CssClass="details_label_age" OnClick="lnkBack_Click"
                                                                meta:resourcekey="lnkBackResource1"></asp:LinkButton>
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
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" PageSize="5"
                                                                OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                meta:resourcekey="grdResultResource1">
                                                                <HeaderStyle BorderWidth="0px" />
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                <Columns>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
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
                                                                                                                <asp:Label ID="lblICDCode" Text='<%# DataBinder.Eval(Container.DataItem,"ICDCode") %>'
                                                                                                                    runat="server" meta:resourcekey="lblICDCodeResource1"></asp:Label>
                                                                                                                :
                                                                                                                <asp:Label ID="lblComplaintName" Text='<%# DataBinder.Eval(Container.DataItem,"ComplaintName") %>'
                                                                                                                    runat="server" meta:resourcekey="lblComplaintNameResource1"></asp:Label>
                                                                                                            </td>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td class="dataheaderInvCtrl">
                                                                                                    <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                                        Width="100%" meta:resourcekey="grdChildResultResource1">
                                                                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                        <Columns>
                                                                                                            <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource1">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Patient No" meta:resourcekey="TemplateFieldResource2">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblPatientNumber" Text='<%# Eval("PatientNumber") %>' runat="server"
                                                                                                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblAge" Text='<%# Eval("Age") %>' runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Visit Date" meta:resourcekey="TemplateFieldResource4">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblVisitDate" Text='<%# Eval("VisitDate") %>' runat="server" meta:resourcekey="lblVisitDateResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Visit Type" meta:resourcekey="TemplateFieldResource5">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblVisitType" Text='<%# Eval("VisitType") %>' runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
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
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table width="100%">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td class="dataheaderInvCtrl">
                                                                        <asp:GridView ID="gvSummary" runat="server" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                                            HorizontalAlign="Left" CssClass="mytable1" DataKeyNames="ICDCode,ComplaintName"
                                                                            OnRowCommand="gvSummary_RowCommand" meta:resourcekey="gvSummaryResource1">
                                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="ICDCode" meta:resourcekey="TemplateFieldResource7">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("ICDCode") %>' runat="server" meta:resourcekey="lblICDSResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="ICD Description" meta:resourcekey="TemplateFieldResource8">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDNameS" Text='<%# Eval("ComplaintName") %>' runat="server" meta:resourcekey="lblICDNameSResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Patient Count" meta:resourcekey="TemplateFieldResource9">
                                                                                    <ItemTemplate>
                                                                                        <asp:LinkButton ID="lbtnPatientCount" runat="server" Text='<%# Eval("PatientCount") %>'
                                                                                            CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="OView"
                                                                                            Font-Underline="True" meta:resourcekey="lbtnPatientCountResource1"></asp:LinkButton>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Panel ID="pnlPatientDetail" runat="server" CssClass="modalPopup dataheaderPopup"
                                                Width="80%" Style="display: none" meta:resourcekey="pnlPatientDetailResource1">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="B1" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                            </b>
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                                OnClientClick="return popupprintD();" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblPatientDetail" cellpadding="2" cellspacing="0" border="0" width="100%"
                                                    runat="server" class="dataheaderInvCtrl" style="display: block;">
                                                    <tr class="grdcolor" runat="server">
                                                        <td runat="server">
                                                            <asp:Label ID="lblIcdCodePD" runat="server"></asp:Label>:
                                                            <asp:Label ID="lblIcdNamePD" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr class="defaultfontcolor" runat="server">
                                                        <td runat="server">
                                                            <asp:GridView ID="gvPatientDetail" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblNamePD" Text='<%#Eval("Name") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientNumberPD" Text='<%#Eval("PatientNumber") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAgePD" Text='<%#Eval("Age") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitDatePD" Text='<%#Eval("VisitDate") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit Type">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitTypePD" Text='<%#Eval("VisitType") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td align="center" runat="server">
                                                            <asp:Button ID="BtnPatientDetail" runat="server" Text="Close" CssClass="btn" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajc:ModalPopupExtender ID="ModelPopPatientDetail" runat="server" TargetControlID="btnR"
                                                    PopupControlID="pnlPatientDetail" BackgroundCssClass="modalBackground" OkControlID="BtnPatientDetail"
                                                    DynamicServicePath="" Enabled="True" />
                                                <input type="button" id="btnR" runat="server" style="display: none;" /></asp:Panel>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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
