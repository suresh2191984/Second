<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryTeamWiseReport.aspx.cs"
    Inherits="Admin_SurgeryTeamWiseReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Surgery & Intervention Statistics Report</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ChechVisitDate() {
            if (document.getElementById('txtFrom').value == '' || document.getElementById('txtTo').value == '') {
                alert('Provide visit date');
                document.frmPatientVitals.txtFrom.focus();
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
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: None;">
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="height: 5px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" width="100%" cellpadding="4" cellspacing="0" class="dataheader2">
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title"> </asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFrom"  CssClass ="Txtboxsmall" runat="server"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title"> </asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTo" CssClass ="Txtboxsmall" runat="server"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />
                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" />
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnFrom" runat="server" />
                                            <asp:HiddenField ID="hdnTO" runat="server" />
                                            <asp:HiddenField ID="hdnSurgeon" runat="server" />
                                            <asp:HiddenField ID="hdnAnes" runat="server" />
                                            <asp:HiddenField ID="hdnSOI" runat="server" />
                                            <%--  <asp:HiddenField ID="hdnDateWise" runat="server" />--%>
                                            <table cellpadding="4" cellspacing="0" border="0" width="100%" class="dataheader2"
                                                runat="server" style="display: none;" id="tblSurgeryTeam">
                                                <tr>
                                                    <td align="right">
                                                        <asp:CheckBox ID="chksurgeon" runat="server" Text=" Select Surgeon" onclick="javascript:checkchk('divsurgeon',this.id)"
                                                            GroupName="select" />
                                                    </td>
                                                    <td align="left">
                                                        <div id="divsurgeon" style="overflow: scroll; height: 100px; display: none;">
                                                            <asp:CheckBoxList ID="chklstsurgeon" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                    <td align="right">
                                                        <asp:CheckBox ID="chkAnesthetist" runat="server" Text="Select Anesthetist" onclick="javascript:checkchk('divanesthetist',this.id)"
                                                            GroupName="select" />
                                                    </td>
                                                    <td align="left">
                                                        <div id="divanesthetist" style="overflow: scroll; height: 100px; display: none;">
                                                            <asp:CheckBoxList ID="chklstanesthetist" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                    <td align="right">
                                                        <asp:CheckBox ID="chksurgery" runat="server" Text="Select Surgery" onclick="javascript:checkchk('divsurgery',this.id)"
                                                            GroupName="select" />
                                                        <%--/Intervension--%>
                                                    </td>
                                                    <td align="left">
                                                        <div id="divsurgery" style="overflow: scroll; height: 100px; display: none;">
                                                            <asp:CheckBoxList ID="chklstsurgery" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return ChechVisitDate()"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnSearch_Click" />
                                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnReset_Click" />
                                        </td>
                                    </tr>
                                    <tr id="trPrint" runat="server" style="display: none">
                                        <td align="right" style="padding-right: 30px; color: #000000;">
                                            <b id="printText" runat="server">Print Report</b>&nbsp;&nbsp;
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                ToolTip="Print" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="prnReport">
                                                <asp:Label ID="lblNorecord" runat="server" Text="No Matching Records Found" Font-Bold="true"
                                                    Visible="false"></asp:Label>
                                                &nbsp;<asp:Label ID="lblName" runat="server" Font-Bold="true" Visible="false" Font-Size="Small"></asp:Label>
                                                <table id="tblSurgeryReport" cellpadding="5" cellspacing="0" border="0" width="100%"
                                                    runat="server" class="dataheader2" style="display: none;">
                                                    <tr style="height: 10px;">
                                                        <td style="font-weight: normal; color: #000;" align="right">
                                                            <input type="hidden" id="OPid" name="OPid" />
                                                            <asp:GridView ID="gvSurgeryReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                AllowPaging="True" OnPageIndexChanging="gvSurgeryReport_PageIndexChanging" PageSize="100"
                                                                CssClass="dataheader2" OnRowDataBound="gvSurgeryReport_RowDataBound">
                                                                <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                <PagerStyle CssClass="dataheader1" />
                                                                <RowStyle HorizontalAlign="Left"></RowStyle>
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" runat="server" Text='<%#Bind("PatientName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient ID">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblID" runat="server" Text='<%#Bind("PatientID") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Address" HeaderStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbladd" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAge" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sex">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblsex" runat="server" Text='<%#Bind("SEX") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="IP Number">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblIPNumber" runat="server" Text='<%#Bind("IPNumber") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Admission Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAdmissionDate" runat="server" Text='<%#Bind("AdmissionDate") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Discharge Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDischargeDate" runat="server" Text='<%#Bind("DischargedDT") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Surgery / Intervention Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSOI" runat="server" Text='<%#Bind("TreatmentName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Surgeon / Interventionalist">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblChiefSurgeonName" runat="server" Text='<%#Bind("ChiefSurgeonName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSurgicalFee" runat="server" Text='<%#Bind("SurgicalFee") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" style="display: none;" id="trSubTotal" class="dataheader2">
                                                        <td align="right">
                                                            <asp:Label ID="lblSubTotal" runat="server" Width="100%" Font-Bold="true"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px;">
                                        </td>
                                    </tr>
                                </table>
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
