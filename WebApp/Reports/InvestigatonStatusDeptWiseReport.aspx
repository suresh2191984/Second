<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigatonStatusDeptWiseReport.aspx.cs"
    Inherits="Reports_InvestigatonStatusDeptWiseReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
--%><%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>InvestigatonStatus DeptWiseReport</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ItemClientSelected(source, eventArgs) {

            var ClientCorpID;
            var list = eventArgs.get_value().split('^');
            ClientCorpID = list[0];
            document.getElementById('hdnSelectedClientID').value = ClientCorpID;

        }

        function getCountryID() {
            document.getElementById("txtClient").value = "";
            var e = document.getElementById("ddlCountry");
            var ddlCountry = e.options[e.selectedIndex].value;
            document.getElementById("hdnCountryID").value = ddlCountry;
        }

        function CheckPatientSearch() {

            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date');
                return false;
            }
            if (document.getElementById('txtTo').value == '') {
                alert('Select To Date');
                return false;
            }

        }
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
            // WinPrint.close();
        }

        function ShowColumns(obj) {
            $("#pnlColumns").slideToggle("slow");
            $("#lnkBtnSaveTemplate").slideToggle("slow");
            if (obj.value != "Hide") {
                obj.value = "Hide";
            }
            else {
                obj.value = "Show";
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function openViewBill(obj, ftype) {
            var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

            window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
        }
       
    </script>

    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <%--  <div id="wrapper">
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
  --%>
    <%--   <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="100%" valign="top" class="tdspace">
                    <span>&nbsp;</span>
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>--%>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata1">
        <%--<ul>
            <li>
                <uc6:errordisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <table id="tblCollectionOPIP" align="center" cellpadding="0" cellspacing="0" border="0"
                    width="100%">
                    <tr>
                        <td>
                            <div class="dataheaderWider">
                                <table id="tblPatient" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" align="left" runat="server">
                                            <div style="display: block">
                                                <table width="50%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblFrom" Text="From" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="125px" ID="txtFrom" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                            <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTo" Text="To" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTo" Width="125px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                            <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                OnClientClick="return CheckPatientSearch();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Search" />
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" Text="Back"
                                                                OnClick="lnkBack_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
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
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" width="85%">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                &nbsp;&nbsp;
                                <%-- </td>
                                            <td style="padding-right: 10px; color: #000000;">--%>
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Visible="true" Text="Print Report" runat="server"
                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" OnClick="btnPrintAll_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" OnClick="btnSendmail_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width: 70%; height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResult" Width="70%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" CssClass="mytable1"
                        EmptyDataText="Investigaton Status DeptWise Report Not Available">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department">
                                <ItemTemplate>
                                    <asp:Label ID="lnkDept" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Department") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="left" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SampleCollected" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkSampleCollected" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("SampleCollected") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SampleReceived">
                                <ItemTemplate>
                                    <asp:Label ID="lnkSampleReceived" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("SampleReceived") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Completed">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCompleted" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Completed") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approve">
                                <ItemTemplate>
                                    <asp:Label ID="lnkApprove" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Approve") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Recheck">
                                <ItemTemplate>
                                    <asp:Label ID="lnkRecheck" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Recheck") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reject" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkReject" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Reject") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cancel">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCancel" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Cancel") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pending">
                                <ItemTemplate>
                                    <asp:Label ID="lnkPending" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Pending") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pending (%)">
                                <ItemTemplate>
                                    <asp:Label ID="lnkPendingPercentage" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("PendingPercentage") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="right" />
                                <ItemStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
                <asp:PostBackTrigger ControlID="btnPrintAll" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <%--<ul>
                        <li>
                            <uc6:ErrorDisplay ID="ErrorDisplay3" runat="server" />
                        </li>
                    </ul>--%>
                    <table width="100%">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnSendMailReport_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                <asp:HiddenField ID="hdnCountryID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%-- </td>
            </tr>
        </table>--%>
    <%--<uc5:Footer ID="Footer1" runat="server" />--%>
    <%--</div>--%>
    </form>
</body>
</html>
