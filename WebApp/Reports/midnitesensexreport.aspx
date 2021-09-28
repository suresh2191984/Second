<%@ Page Language="C#" AutoEventWireup="true" CodeFile="midnitesensexreport.aspx.cs"
    Inherits="Reports_midnitesensexreport" meta:resourcekey="PageResource1" %>

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
    <title>Mid Night census Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {
            if (document.getElementById('txtFDate').value == '') {
                alert('Enter from date');
                document.getElementById('txtFDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,scrollbars=0,status=0');
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
                        <table id="tblICDreport" align="left">
                            <tr align="left">
                                <td align="left"> 
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td align="left">
                                                    &nbsp;<asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
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
                                                <td align="left">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td align="left">
                                                    <%-- <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                    </b>&nbsp;&nbsp;
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="prnReport">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            <asp:GridView ID="gvDuepaidReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                AllowPaging="True" EmptyDataText="No Records Found" PageSize="100" CssClass="dataheader2"
                                                                ShowFooter="True" OnRowDataBound="gvDuepaidReport_RowDataBound" meta:resourcekey="gvDuepaidReportResource1">
                                                                <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                <PagerStyle CssClass="dataheader1" />
                                                                <RowStyle HorizontalAlign="Left"></RowStyle>
                                                                <Columns>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblOpeningstatistics" runat="server" Text='<%# Bind("WardName") %>'
                                                                                Width="100px" meta:resourcekey="lblOpeningstatisticsResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAdmissionmale" runat="server" Text='<%# Bind("MaleAdmission") %>'
                                                                                meta:resourcekey="lblAdmissionmaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAdmissionfemale" runat="server" Text='<%# Bind("FemaleAdmission") %>'
                                                                                meta:resourcekey="lblAdmissionfemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAdmissionchild" runat="server" Text='<%# Bind("ChildAdmission") %>'
                                                                                meta:resourcekey="lblAdmissionchildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource5">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBirthmale" runat="server" Text='<%# Bind("MaleBirth") %>' meta:resourcekey="lblBirthmaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBirthfemale" runat="server" Text='<%# Bind("FemaleBirth") %>' meta:resourcekey="lblBirthfemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource7">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBirthChild" runat="server" Text='<%# Bind("ChildBirth") %>' meta:resourcekey="lblBirthChildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource8">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferINMale" runat="server" Text='<%# Bind("MaleTransferIN") %>'
                                                                                meta:resourcekey="lblTransferINMaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferINFemale" runat="server" Text='<%# Bind("FemaleTransferIN") %>'
                                                                                meta:resourcekey="lblTransferINFemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource10">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferINChild" runat="server" Text='<%# Bind("ChildTransferIN") %>'
                                                                                meta:resourcekey="lblTransferINChildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource11">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferOutMale" runat="server" Text='<%# Bind("MaleTransferOut") %>'
                                                                                meta:resourcekey="lblTransferOutMaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource12">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferOutFemale" runat="server" Text='<%# Bind("FemaleTransferOut") %>'
                                                                                meta:resourcekey="lblTransferOutFemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource13">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTransferOutChild" runat="server" Text='<%# Bind("ChildTransferOut") %>'
                                                                                meta:resourcekey="lblTransferOutChildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource14">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDischargeMale" runat="server" Text='<%# Bind("MaleDischarge") %>'
                                                                                meta:resourcekey="lblDischargeMaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource15">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDischargeFemale" runat="server" Text='<%# Bind("FemaleDischarge") %>'
                                                                                meta:resourcekey="lblDischargeFemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource16">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDischargeChild" runat="server" Text='<%# Bind("ChildDischarge") %>'
                                                                                meta:resourcekey="lblDischargeChildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource17">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDeathMale" runat="server" Text='<%# Bind("MaleDeath") %>' meta:resourcekey="lblDeathMaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource18">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDeathFemale" runat="server" Text='<%# Bind("FemaleDeath") %>' meta:resourcekey="lblDeathFemaleResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource19">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDeathChild" runat="server" Text='<%# Bind("ChildDeath") %>' meta:resourcekey="lblDeathChildResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource20">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblClosingstatistics" runat="server" Text='<%# Bind("Wardclose") %>'
                                                                                Width="100px" meta:resourcekey="lblClosingstatisticsResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="centre">
                                                            <asp:Label ID="lblPaidAmount" runat="server" meta:resourcekey="lblPaidAmountResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
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
