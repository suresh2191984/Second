<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListofPatientsReport.aspx.cs"
    Inherits="Reports_ListofPatientsReport" meta:resourcekey="PageResource1" %>

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
           <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

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

    <style type="text/css">
        /* So the overflow scrolls */.container
        {
            overflow: auto;
        }
        /* Keep the header cells positioned as we scroll */.container table th
        {
            position: relative;
        }
        /* For alignment of the scroll bar */.container table tbody
        {
            overflow-x: hidden;
        }
    </style>
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
                        <table id="tblCollectionOPIP" align="center" width="95%" border="0">
                            <tr>
                                <td align="center">
                                    <div class="dataheaderWider">
                                        <table id="tbl" border="0">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" CssClass ="Txtboxsmall" Width ="120px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
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
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblVisitTypeResource1">
                                                        <asp:ListItem Text="New Patient" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="Follow Up" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
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
                                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                        CssClass="details_label_age"  OnClick="lnkBack_Click" 
                                                        meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                                <td align="right">
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblVType" RepeatDirection="Horizontal" runat="server" meta:resourcekey="rblVTypeResource1">
                                                        <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnltempItems" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnltempItemsResource1">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                                                    <div id="ACX2plusTemp" style="display: Block; width: 393px;">
                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);">
                                                            &nbsp;
                                                            <asp:Label ID="Rs_Speciality" Text="Speciality" runat="server" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                                        </span>&nbsp;&nbsp;&nbsp;
                                                    </div>
                                                    <div id="ACX2minusTemp" style="display: none; width: 393px;">
                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);">
                                                            &nbsp;<asp:Label ID="Rs_Speciality1" Text="Speciality" runat="server" meta:resourcekey="Rs_Speciality1Resource1"></asp:Label>
                                                    </div>
                                                </td>
                                                <td style="width: 50%" height="23" align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="dataheader2">
                                                    <table class="tablerow" id="ACX2responsesTemp" style="display: none;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" Text="Speciality" Font-Bold="True" ID="lblSpeciality" meta:resourcekey="lblSpecialityResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6" align="left">
                                                                <asp:CheckBoxList ID="cblSpeciality" RepeatColumns="5" runat="server" meta:resourcekey="cblSpecialityResource1">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" Text="Consultant : Dr." Font-Bold="True" Visible="False"
                                                                    ID="lblConst" meta:resourcekey="lblConstResource1"></asp:Label>
                                                            </td>
                                                            <td colspan="6" align="left">
                                                                <asp:CheckBoxList ID="cblConsultingName" RepeatColumns="5" runat="server" meta:resourcekey="cblConsultingNameResource1">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <div id="divFilter" class="dataheaderWider" style="display: none;" runat="server">
                            <table id="Table1">
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged"
                                            meta:resourcekey="ddlCityResource1">
                                        </asp:DropDownList>
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
                                <tr align="right">
                                    <td align="right">
                                        <b id="printText" runat="server">
                                            <asp:Label ID="Rs_PrintReport" Text=" Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lbltotal" runat="server" meta:resourcekey="lbltotalResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <div id="divOPDWCR" runat="server" style="display: none;">
                                    <div id="prnReport">
                                        <div class="container">
                                            <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="95%"
                                                ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                meta:resourcekey="gvIPCreditMainResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="ID" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IPNumber" HeaderText="IP No" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" meta:resourcekey="BoundFieldResource6">
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField DataField="SpecialityName" HeaderText="Speciality" meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="ADMDiagnosis" HeaderText="Diagnosis" Visible="False" meta:resourcekey="BoundFieldResource9" />
                                                    <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="VisitDate"
                                                        meta:resourcekey="BoundFieldResource11" />
                                                    <asp:BoundField DataField="VisitType" HeaderText="Type" meta:resourcekey="BoundFieldResource12" />
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
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
