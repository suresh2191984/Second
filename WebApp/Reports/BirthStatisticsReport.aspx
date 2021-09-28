<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BirthStatisticsReport.aspx.cs"
    Inherits="Reports_BirthStatisticsReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
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
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
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
                        <table id="tblCollectionOPIP" align="center" width="100%" cellpadding="0" cellspacing="0">
                            <tr align="center">
                                <td align="center">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td align="right" colspan="2">
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
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                        OnClick="btnConverttoXL_Click1" meta:resourcekey="btnConverttoXLResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="Rs_DeliveryType" Text="Delivery Type :" runat="server" meta:resourcekey="Rs_DeliveryTypeResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlDeliveryTypeName"   CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlDeliveryTypeNameResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_Obstretrician" Text="Obstretrician:" runat="server" meta:resourcekey="Rs_ObstretricianResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlObstretician" CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlObstreticianResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="Rs_ProcedureType" Text="Procedure Type :" runat="server" meta:resourcekey="Rs_ProcedureTypeResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlProcedureType"  CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlProcedureTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_Sex" Text="Sex :" runat="server" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblSex" RepeatDirection="Horizontal" runat="server" meta:resourcekey="rblSexResource1">
                                                        <asp:ListItem Text="M" Value="M" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="F" Value="F" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Text="Both" Selected="True" Value="BOTH" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td align="left">
                                                    &nbsp;
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
                                                <div id="prnReport">
                                                    <asp:Label ID="lblNewtable" runat="server" Style="display: block;" meta:resourcekey="lblNewtableResource1"></asp:Label>
                                                    <br />
                                                </div>
                                            </div>
                                            <div>
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
                                                    <asp:GridView ID="gvIPReport" 
        runat="server" AutoGenerateColumns="False" Visible="False"
                                                        Width="100%" OnRowDataBound="gvIPReport_RowDataBound" 
                                                        
        meta:resourcekey="gvIPReportResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b>
                                                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" 
                                                                                    meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                <%# DataBinder.Eval(Container.DataItem, "VisitDate", "{0:dd/MM/yyyy}")%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="750px"
                                                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                    meta:resourcekey="gvIPCreditMainResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="S.No">
                                                                                            <ItemTemplate>
                                                                                                <%# Container.DataItemIndex + 1 %>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="ID" 
                                                                                            meta:resourcekey="BoundFieldResource1">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Name" HeaderText="Patient Name" 
                                                                                            meta:resourcekey="BoundFieldResource2">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="250px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Age" HeaderText="Age" 
                                                                                            meta:resourcekey="BoundFieldResource3">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="50px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BabyName" HeaderText="Baby Name" 
                                                                                            meta:resourcekey="BoundFieldResource4">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Sex" HeaderText="Sex of Baby" 
                                                                                            meta:resourcekey="BoundFieldResource5">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="VisitDate" HeaderText="DOB" 
                                                                                            meta:resourcekey="BoundFieldResource6">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="ProcedureType" HeaderText="Procedure Type" 
                                                                                            meta:resourcekey="BoundFieldResource7">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="DeliveryTypeName" HeaderText="Delivery Type Name" 
                                                                                            meta:resourcekey="BoundFieldResource8">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Obstretrician" HeaderText="Obstretrician" 
                                                                                            meta:resourcekey="BoundFieldResource9">
                                                                                            <ItemStyle Width="25px" />
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
    </form>
</body>
</html>
