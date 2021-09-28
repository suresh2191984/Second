<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeathStatisticsReport.aspx.cs"
    Inherits="Reports_DeathStatisticsReport" meta:resourcekey="PageResource1" %>

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

        function checkchk(id, obj) {
            if (document.getElementById(obj).checked) {
                $get(id).style.display = "block";
            }
            else {
                $get(id).style.display = "none";
            }
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
                        <div>
                            <table id="tblCollectionOPIP" class="dataheader2 defaultfontcolor" border="0" width="100%">
                                <tr>
                                    <td align="left">
                                        <table id="tbl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="FromDate:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
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
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
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
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="dataheader2"
                            runat="server" style="display: none;" id="tblSurgeryTeam">
                            <tr>
                                <td align="right">
                                    <asp:CheckBox ID="chksurgeon" runat="server" Text=" Select Gender" onclick="javascript:checkchk('divsurgeon',this.id)"
                                        GroupName="select" meta:resourcekey="chksurgeonResource1" />
                                </td>
                                <td align="left">
                                    <div id="divsurgeon" style="display: none;">
                                        <asp:DropDownList ID="ddlgender" runat="server" meta:resourcekey="ddlgenderResource1">
                                            <asp:ListItem Text="Male" Value="M" meta:resourcekey="ListItemResource3">
                                            </asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F" meta:resourcekey="ListItemResource4">
                                            </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </td>
                                <td align="right">
                                    <asp:CheckBox ID="chkAnesthetist" runat="server" Text="Select Primary Consultant"
                                        onclick="javascript:checkchk('divanesthetist',this.id)" GroupName="select" meta:resourcekey="chkAnesthetistResource1" />
                                </td>
                                <td align="left">
                                    <div id="divanesthetist" style="display: none;">
                                        <asp:DropDownList ID="ddlprimaryconsultant" runat="server" meta:resourcekey="ddlprimaryconsultantResource1">
                                        </asp:DropDownList>
                                    </div>
                                </td>
                                <td align="right">
                                    <asp:CheckBox ID="chksurgery" runat="server" Text="Select Speciality" onclick="javascript:checkchk('divsurgery',this.id)"
                                        GroupName="select" meta:resourcekey="chksurgeryResource1" />
                                    <%--/Intervension--%>
                                </td>
                                <td align="left">
                                    <div id="divsurgery" style="display: none;">
                                        <asp:DropDownList ID="ddlspeciality" runat="server" meta:resourcekey="ddlspecialityResource1">
                                        </asp:DropDownList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <div id="divPrint" style="display: none;" runat="server">
                            <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                <tr>
                                    <td align="right" style="padding-right: 10px; color: #000000;">
                                        <b id="printText" runat="server">
                                            <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <div id="divOPDWCR" runat="server" style="display: none;">
                                    <div id="prnReport" class="dataheader2" nowrap="nowrap">
                                        <asp:GridView ID="gvIPCreditMain" runat="server" CssClass="mytable1" AutoGenerateColumns="False"
                                            Width="100%" OnRowDataBound="gvIPCreditMain_RowDataBound" meta:resourcekey="gvIPCreditMainResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource1">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="IPNumber" HeaderText="IP No" meta:resourcekey="BoundFieldResource2">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource3">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Age" HeaderText="Age/Sex" meta:resourcekey="BoundFieldResource4">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MLCtype" HeaderText="MLC/NON MLC" meta:resourcekey="BoundFieldResource5">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Payertype" HeaderText="Payer" meta:resourcekey="BoundFieldResource6">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DateofAdmission" HeaderText="DOA" meta:resourcekey="BoundFieldResource7">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TreatmentName" HeaderText="Surgery/Intervention" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PhysicianName" HeaderText="Primary Consultant" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SpecialityName" HeaderText="Speciality Name" meta:resourcekey="BoundFieldResource10">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date of Death"
                                                    meta:resourcekey="BoundFieldResource11"></asp:BoundField>
                                                <asp:BoundField DataField="PlaceofDeath" HeaderText="Place of Death" meta:resourcekey="BoundFieldResource12">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TypeofDeath" HeaderText="Type of Death" meta:resourcekey="BoundFieldResource13">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource14">
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                                        <asp:Label ID="lbltxt" runat="server" Style="display: none;" meta:resourcekey="lbltxtResource1"></asp:Label>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdndivsurgeon" Value="N" runat="server" />
    <asp:HiddenField ID="hdndivanesthetist" Value="N" runat="server" />
    <asp:HiddenField ID="hdndivsurgery" Value="N" runat="server" />
    <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script type="text/javascript" language="javascript">
        if (document.getElementById('hdndivsurgeon').value == "Y")
            document.getElementById('divsurgeon').style.display = "block";
        if (document.getElementById('hdndivanesthetist').value == "Y")
            document.getElementById('divanesthetist').style.display = "block";
        if (document.getElementById('hdndivsurgery').value == "Y")
            document.getElementById('divsurgery').style.display = "block";
    </script>

</body>
</html>
