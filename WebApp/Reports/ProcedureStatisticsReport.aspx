<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProcedureStatisticsReport.aspx.cs"
    Inherits="Reports_ProcedureStatisticsReport" meta:resourcekey="PageResource1" %>

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
        function popupprint(prnReport) {
            var prtContent = document.getElementById(prnReport);
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
                        <table id="tblCollectionOPIP" width="100%">
                            <tr align="center">
                                <td align="center">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl" width="90%">
                                                    <tr>
                                                        <td align="left" valign="middle">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="100px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
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
                                                        <td align="left" valign="middle">
                                                        &nbsp;&nbsp;
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            &nbsp;
                                                            <asp:TextBox ID="txtTDate" runat="server"  CssClass ="Txtboxsmall" Width ="100px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
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
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn" 
                                                                meta:resourcekey="btnSubmitResource1" OnClick="btnSubmit_Click" 
                                                                OnClientClick="javascript:return validateToDate();" 
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                Text="Get Report" />
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                                meta:resourcekey="lnkBackResource1" OnClick="lnkBack_Click" Text="Back &nbsp; "></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <table>
                                                                <tr>
                                                                    <td align="right">
                                                                        <b>
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:Label ID="Rs_SelectReportType" Text="Select Report Type" runat="server" meta:resourcekey="Rs_SelectReportTypeResource1"></asp:Label></b>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                        <asp:DropDownList ID="ddlType" runat="server" meta:resourcekey="ddlTypeResource1">
                                                                            <asp:ListItem Text="Detailed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                            <asp:ListItem Text="Summary" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                                            meta:resourcekey="rblVisitTypeResource1">
                                                                            <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td align="left">
                                                            <asp:RadioButtonList ID="rblReportHeader" RepeatDirection="Horizontal" runat="server"
                                                                meta:resourcekey="rblReportHeaderResource1">
                                                                <asp:ListItem Text="Procedures" Selected="True" Value="PRO" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                <asp:ListItem Text="Casuality" Value="CAS" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                <asp:ListItem Text="Indents" Value="IND" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                <asp:ListItem Text="General Bill Items" Value="GEN" 
                                                                    meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                            </asp:RadioButtonList>
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
                                            <div id="divPrint" visible="False" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint('prnReport');"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divSummPrint" visible="False" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="B1" runat="server">
                                                                <asp:Label ID="Rs_PrintReportB" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportBResource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                                OnClientClick="return popupprint('divSummary');" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divOPDWCR" runat="server" visible="False">
                                                <div id="prnReport">
                                                    <table id="tblItem" width="100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" Font-Bold="True" ID="lblHeader" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: normal; width: 100%" align="justify">
                                                                <asp:DataList ID="gvIPReport" runat="server" CellPadding="0" RepeatColumns="4" RepeatDirection="Horizontal"
                                                                    Visible="False" Width="100%" OnItemDataBound="gvIPReport_ItemDataBound" meta:resourcekey="gvIPReportResource1">
                                                                    <HeaderTemplate>
                                                                        <asp:Label runat="server" ID="lblHeader" meta:resourcekey="lblHeaderResource2"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                            cellspacing="0" border="1" width="100%">
                                                                            <tr>
                                                                                <td align="center" style="height: 25px;">
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                    <asp:LinkButton ID="lnkDate" ForeColor="Brown" Font-Bold="True" Font-Size="12px"
                                                                                        Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>' runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="font-weight: normal; height: 15%; color: #000; width: 10%;" align="left">
                                                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                        ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="S.No">
                                                                                                <ItemTemplate>
                                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource1">
                                                                                                <ItemTemplate>
                                                                                                    <asp:LinkButton ID="lnkDept" Font-Underline="False" ForeColor="Black" Font-Size="12px"
                                                                                                        Text='<%# Eval("DeptName") %>' runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                                <ItemStyle Width="50%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="TotalCounts" HeaderText="No of Tests" 
                                                                                                meta:resourcekey="BoundFieldResource1">
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                                <ItemStyle Width="18%" HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="BilledAmount" HeaderText="Amount" 
                                                                                                DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource2">
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                                <ItemStyle Width="50%" HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField Visible="False" DataField="LengthofStay" HeaderText="No. of Visit"
                                                                                                meta:resourcekey="BoundFieldResource3">
                                                                                                <ItemStyle Width="5px" />
                                                                                            </asp:BoundField>
                                                                                        </Columns>
                                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_Total" Text="Total:" runat="server" meta:resourcekey="Rs_TotalResource1"></asp:Label>&nbsp;&nbsp;</b><asp:Label
                                                                                            runat="server" ForeColor="Red" ID="lblTot" meta:resourcekey="lblTotResource1"></asp:Label><b>&nbsp;<asp:Label
                                                                                                ID="Rs_Nos" Text="Nos." runat="server" meta:resourcekey="Rs_NosResource1"></asp:Label>&nbsp;</b>
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="trDetTotalAmt" runat="server">
                                                                                <td align="right" runat="server">
                                                                                    <asp:Label ID="lblDetTotal" Text="Total Amount: " runat="server"></asp:Label>
                                                                                    <asp:Label ID="lblDetTotalAmount" Text="0.00" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div id="divSummary" runat="server" visible="False">
                                                <table border="0" width="63%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:GridView ID="gvIPSummary" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPSummaryResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="DeptName" HeaderText="Name" meta:resourcekey="BoundFieldResource4">
                                                                        <ItemStyle HorizontalAlign="Left" Width="63%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="TotalCounts" HeaderText="No of Tests" meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle Width="18%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="BilledAmount" HeaderText="Amount" meta:resourcekey="BoundFieldResource6" DataFormatString="{0:0.00}">
                                                                        <ItemStyle Width="70%"  HorizontalAlign="Right"  />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField Visible="False" DataField="LengthofStay" HeaderText="No. of Visit"
                                                                        meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle Width="5px" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                            <br />
                                                            <div id="breakupSummary">
                                                                <table border="0" id="tabGranTotalSummary" runat="server" class="dataheaderWider"
                                                                    cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                                    <tr id="Tr1" runat="server">
                                                                        <td id="Td1" align="right" style="width: 80%;" runat="server">
                                                                            <asp:Label ID="lblTotalSummaryAmount" Text="Total Amount:" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="Td2" align="right" runat="server">
                                                                            <asp:Label ID="lblSummaryTotalAmount" runat="server"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label Font-Bold="True" Font-Size="13px" runat="server" ID="totTest" meta:resourcekey="totTestResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
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
