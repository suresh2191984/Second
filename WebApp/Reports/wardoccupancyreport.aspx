<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wardoccupancyreport.aspx.cs"
    Inherits="Reports_wardoccupancyreport" meta:resourcekey="PageResource1" %>

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
    
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validateToDate() {
            if (document.getElementById('txtFDate').value == '') {
              var userMsg = SListForApplicationMessages.Get('Reports\\wardoccupancyreport.aspx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                  document.getElementById('txtFDate').focus();
                return false;
                    }
                     else {
            
                alert('Enter from date');
                document.getElementById('txtFDate').focus();
                return false;
                }
               
            }
            if (document.getElementById('txtTDate').value == '') {
             var userMsg = SListForApplicationMessages.Get('Reports\\wardoccupancyreport.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                  document.getElementById('txtTDate').focus();
                return false;
                    }
                     else {
           
                alert('Enter To date');
                document.getElementById('txtTDate').focus();
                return false;
                }
            
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
                        <table id="tblICDreport" align="center">
                            <tr align="left">
                                <td>
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
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
                                                    <asp:RadioButtonList ID="rblReportType" Visible="false" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblReportTypeResource1">
                                                        <%-- <asp:ListItem Text="Summary" Selected="True" Value="0"></asp:ListItem>--%>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click1" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
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
                                                        <asp:Label ID="Rs_PrintReport" Text="Print_Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="prnReport">
                                                <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                     OnRowDataBound="gvIPReport_RowDataBound"
                                                      meta:resourcekey="gvIPReportResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Ward Occupancy Report" meta:resourcekey="TemplateFieldResource17">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td align="left" style="height: 25px;">
                                                                            <b>
                                                                                <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                            <asp:LinkButton ID="lnkDate" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                                runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                            <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                 OnRowDataBound="gvReport_RowDataBound"
                                                                                meta:resourcekey="gvReportResource1">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Ward Occupancy Report" meta:resourcekey="TemplateFieldResource16">
                                                                                        <ItemTemplate>
                                                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                                <tr>
                                                                                                    <td align="center" style="height: 25px;">
                                                                                                        <asp:Label ID="lblfloor" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("FloorName") %>'
                                                                                                            runat="server" meta:resourcekey="lblfloorResource1"></asp:Label>
                                                                                                        <asp:Label ID="lblward" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("WardName") %>'
                                                                                                            runat="server" meta:resourcekey="lblwardResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <table cellpadding="2" class="defaultfontcolor" style="color: Black; font-family: Verdana;
                                                                                                            text-align: left;" cellspacing="1" width="100%" nowrap="nowrap">
                                                                                                            <tr>
                                                                                                                <td valign="top" class="dataheader2" nowrap="nowrap">
                                                                                                                    <asp:GridView ID="gvwardReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                                                          EmptyDataText="No Records Found" CssClass="mytable1" ShowFooter="True"
                                                                                                                        meta:resourcekey="gvwardReportResource1">
                                                                                                                        <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                                                                        <PagerStyle CssClass="dataheader1" />
                                                                                                                        <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                                                                                        <Columns>
                                                                                                                            <asp:TemplateField HeaderText="Room/BedName" meta:resourcekey="TemplateFieldResource1">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblroombedname" runat="server" Text='<%# Bind("RoomandBedName") %>'
                                                                                                                                        Width="100px" meta:resourcekey="lblroombednameResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Room Type" meta:resourcekey="TemplateFieldResource2">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblRoomType" runat="server" Text='<%# Bind("RoomTypeName") %>' meta:resourcekey="lblRoomTypeResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource3">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="lblNameResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Sex" meta:resourcekey="TemplateFieldResource4">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblsex" runat="server" Text='<%# Bind("Sex") %>' meta:resourcekey="lblsexResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Nationality" meta:resourcekey="TemplateFieldResource5">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblNationality" runat="server" Text='<%# Bind("Nationality") %>' meta:resourcekey="lblNationalityResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Purpose Of Admission" meta:resourcekey="TemplateFieldResource6">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblPurposeOfAdmission" runat="server" Text='<%# Bind("PurposeOfAdmissionName") %>'
                                                                                                                                        meta:resourcekey="lblPurposeOfAdmissionResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Speciality Name" meta:resourcekey="TemplateFieldResource7">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblSpecialityName" runat="server" Text='<%# Bind("SpecialityName") %>'
                                                                                                                                        meta:resourcekey="lblSpecialityNameResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Physician Name" meta:resourcekey="TemplateFieldResource8">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Bind("PhysicianName") %>'
                                                                                                                                        meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Refering Physician" meta:resourcekey="TemplateFieldResource9">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblReferingPhysician" runat="server" Text='<%# Bind("Referingphysician") %>'
                                                                                                                                        meta:resourcekey="lblReferingPhysicianResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField Visible="false" HeaderText="PatientID" meta:resourcekey="TemplateFieldResource10">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblPatientID" runat="server" Text='<%# Bind("PatientId") %>' meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Patient Number" meta:resourcekey="TemplateFieldResource11">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblPatientNumber" runat="server" Text='<%# Bind("PatientNumber") %>'
                                                                                                                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField  HeaderText="DOA" meta:resourcekey="TemplateFieldResource12">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblDOA" runat="server" Text='<%# Bind("DOA","{0:dd/MM/yyyy}") %>'  meta:resourcekey="lblDOAResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Client/Insurance" meta:resourcekey="TemplateFieldResource13">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblClient" runat="server" Text='<%# Bind("ClientName") %>' meta:resourcekey="lblClientResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="PreAuth Amount" meta:resourcekey="TemplateFieldResource14">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblPreauthamount" runat="server" Text='<%# Bind("PreAuthAmount") %>'
                                                                                                                                        meta:resourcekey="lblPreauthamountResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                            <asp:TemplateField HeaderText="Bill Amount" meta:resourcekey="TemplateFieldResource15">
                                                                                                                                <ItemTemplate>
                                                                                                                                    <asp:Label ID="lblBillamount" runat="server" Text='<%# Bind("GrossBillValue") %>'
                                                                                                                                        meta:resourcekey="lblBillamountResource1"></asp:Label>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:TemplateField>
                                                                                                                        </Columns>
                                                                                                                    </asp:GridView>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td align="center">
                                                                                                                    <asp:Label ID="lblPaidAmount" runat="server" meta:resourcekey="lblPaidAmountResource1"></asp:Label>
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
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
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
            <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                <td align="center" colspan="10" class="defaultfontcolor">
                    <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click" />
                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
