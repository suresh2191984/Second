<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewReportList.aspx.cs" Inherits="Reception_ReportSampleDisplay"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%--<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/ReportDisplay.ascx" TagName="ReportDisplay" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/MRDSnapShotView.ascx" TagName="SnapShot" TagPrefix="uc9" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Reports Display</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<%--    <script src="../Scripts_New/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts_New/Common.js" type="text/javascript"></script>--%>

    <script language="javascript" type="text/javascript">
        function report_validateToDate() {

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
        function fnShowPOPup(obj1, obj2) {

            $('#hdnRptID').val(obj1);
            $('#hdnRptName').val(obj2);
            var modalPopupBehaviorCtrl = $find('mpeAttributeLocation');
            modalPopupBehaviorCtrl.show();
            return false;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
          <%--  <div class="middleheader">
                <uc4:mainheader id="MHead" runat="server" />
                <uc3:header id="RHead" runat="server" />
            </div>--%>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <%--<td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>--%>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                   <%-- <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>--%>
                    <div class="contentdata1">
                        <%--<ul>
                            <li>
                                <uc6:errordisplay id="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                        <div class="contentdata">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                            <table class="w-100p">
                                <tr>
                                    <td class="w-80p v-top">
                                        <div id="divReportControls" runat="server">
                                        </div>
                                    </td>
                                    <td id="tdMRDSnapShot" visible="false" runat="server" class="w-20p v-top">
                                        <uc9:SnapShot ID="MRDSnapShot" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <table id="tblRooms" runat="server" class="w-100p">
                                <tr>
                                    <td>
                                        <table class="rooms w-100p">
                                            <tr>
                                                <td class="tdReportHeader a- center">
                                                    <asp:Label ID="lblGroupText" runat="server" Text="Export Reports" meta:resourcekey="lblGroupTextResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="overflowAuto">
                                                    <%--<asp:DataList ID="dlsReports" runat="server" RepeatColumns="7" RepeatDirection="Horizontal"  meta:resourcekey="dlsReportsResource1">--%>
                                                         <asp:DataList ID="dlsReports" runat="server" OnItemDataBound="Item_Bound" RepeatColumns="7" RepeatDirection="Horizontal" meta:resourcekey="dlsReportsResource1">
                                                        <HeaderTemplate>
                                                            <table class="font11 paddingL15 a-center" style="font-family: Arial;">
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <div id='divFloor' runat="server">
                                                                <td id="tdsCover" class="ReportButton">
                                                                    <asp:LinkButton Text='<%#Eval("ReportDisplayText")%>' CommandName='<%#Eval("ReportID")%>'
                                                                        ID="lnkpros" runat="server" OnClick="butn_Click"></asp:LinkButton>
                                                                            <asp:HiddenField ID="hdnShowDatePopup" runat="server" Value='<%#Eval("ShowDatePopup")%>' /> 
                                                                             <%-- <asp:HiddenField ID="hdnShowDatePopup" runat="server" Value='ShowDateRangePopup' />--%>
                                                               
                                                                </td>
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tr> </table>
                                                        </FooterTemplate>
                                                    </asp:DataList>
                                                    <asp:Panel ID="pnlLocation" Width="600px" Height="150px" runat="server" CssClass="modalPopup dataheaderPopup"
                                                        Style="display: none">
                                                        <br />
                                                        <table width="100%">
                                                            <tr>
                                                                <td style="display: none">
                                                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization"></asp:Label>
                                                                    <asp:DropDownList ID="ddlTrustedOrg" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    From Date :
                                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="70px"></asp:TextBox>
                                                                    <cc1:CalendarExtender ID="cletxtFDate" runat="server" TargetControlID="txtFDate"
                                                                        Format="dd/MM/yyyy">
                                                                    </cc1:CalendarExtender>
                                                                </td>
                                                                <td>
                                                                    To Date :
                                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="70px"></asp:TextBox>
                                                                    <cc1:CalendarExtender ID="cletxtTDate" runat="server" TargetControlID="txtTDate"
                                                                        Format="dd/MM/yyyy">
                                                                    </cc1:CalendarExtender>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <br />
                                                                    <br />
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="bottom" align="center" colspan="3">
                                                                    <asp:LinkButton ID="btn_export" runat="server" Font-Bold="true" ForeColor="Blue"
                                                                        Text="Export to Excel" OnClientClick="return report_validateToDate();" OnClick="btn_Click"
                                                                        Style="border-width: 2px;" Font-Size="12px" Font-Underline="True" />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:LinkButton ID="btncAL" runat="server" Font-Bold="true" ForeColor="Blue" Text="Close Window"
                                                                        Style="border-width: 2px;" Font-Size="12px" Font-Underline="True" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                    <cc1:ModalPopupExtender ID="mpeAttributeLocation" runat="server" TargetControlID="btnDummy"
                                                        PopupControlID="pnlLocation" BehaviorID="mpeAttributeLocation" CancelControlID="btncAL"
                                                        DropShadow="false" Drag="false" BackgroundCssClass="modalBackground" />
                                                    <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                    <input type="hidden" id="hdnRptID" runat="server" />
                                                    <input type="hidden" id="hdnRptName" runat="server" />
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <%--<uc8:ReportDisplay ID="ucReortDisplay" runat="server" />--%>
                        </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
