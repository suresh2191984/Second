<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewInvestigationReport.aspx.cs"
    Inherits="Investigation_ViewInvestigationReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function CallPrint(strid) {
            //alert('test');
            //alert(strOldOne);
            var tr = window.confirm("Do you wish to complete the investigation");
            if (tr == true) {
                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                //alert(WinPrint);
                //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }
            else {
                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                //alert(WinPrint);
                //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }
            return tr;
            // prtContent.innerHTML = strOldOne;
        }

        function Print(strid) {
            //alert('test');
            //alert(strOldOne);
            var tr = window.confirm("Do you wish to print the investigation result");
            if (tr == true) {
                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                //alert(WinPrint);
                //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }
            else {
                return true;
            }

            return tr;
            // prtContent.innerHTML = strOldOne;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table>
                            <tr align="right">
                                <td align="right">
                                    <asp:HyperLink ID="hypLnkPrint" ImageUrl="~/Images/printer.gif" ToolTip="Print" Target="ReportWindow"
                                        OnClick="javascript:return CallPrint('dPrint')" runat="server" meta:resourcekey="hypLnkPrintResource1"></asp:HyperLink>
                                </td>
                                <td align="right">
                                    <asp:LinkButton ID="lnkPrint" runat="server" ForeColor="Black" Text="Print" OnClientClick="javascript:return CallPrint('dPrint')"
                                        OnClick="lnkPrint_Click" meta:resourcekey="lnkPrintResource1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <div id="dPrint">
                            <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" Width="100%" runat="server"
                                meta:resourcekey="Panel1Resource1">
                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                    <tr>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 15%;" align="left">
                                            <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 20%;" align="left">
                                            <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 15%;" align="left">
                                            <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 20%;" align="left">
                                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                            /<asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 8%;" align="left">
                                            <asp:Label ID="Rs_VisitID" Text="VisitID:" runat="server" meta:resourcekey="Rs_VisitIDResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 22%;" align="left">
                                            <asp:Label ID="lblVisitID" runat="server" meta:resourcekey="lblVisitIDResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 15%;" align="left">
                                            <asp:Label ID="Rs_ReportedOn" Text="Reported On:" runat="server" meta:resourcekey="Rs_ReportedOnResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 25%;" align="left">
                                            <asp:Label ID="lblReportedDate" runat="server" meta:resourcekey="lblReportedDateResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 15%;" align="left">
                                            <asp:Label ID="Rs_AttendedOn" Text="Attended On:" runat="server" meta:resourcekey="Rs_AttendedOnResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 25%;" align="left">
                                            <asp:Label ID="lblAttendedOn" runat="server" meta:resourcekey="lblAttendedOnResource1"></asp:Label>
                                        </td>
                                        <td colspan="2" style="font-weight: bold; height: 20px; color: #000; width: 25%;"
                                            align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; height: 20px; color: #000; width: 10%;" align="left">
                                            <asp:Label ID="Rs_RefBy" Text="Ref.By:" runat="server" meta:resourcekey="Rs_RefByResource1"></asp:Label>
                                        </td>
                                        <td colspan="5" style="font-weight: normal; height: 20px; color: #000; width: 30%;"
                                            align="left">
                                            <asp:Label ID="lblRefPhysician" runat="server" meta:resourcekey="lblRefPhysicianResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <asp:Repeater ID="rptInvResult" runat="server" OnItemDataBound="rptInvResult_ItemDataBound">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="font-weight: bold; padding-top: 5px; height: 15px; color: #000; width: 10%;"
                                                align="center">
                                                <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" Width="100%"
                                                    meta:resourcekey="Panel1Resource2">
                                                    <%#DataBinder.Eval(Container.DataItem, "InvestigationName")%></asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%">
                                                <asp:Repeater ID="rptChildRepeater" runat="server">
                                                    <HeaderTemplate>
                                                        <table border="0" class="dataheaderInvCtrl" cellpadding="4" cellspacing="0" width="100%">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr style="width: 100%">
                                                            <td style="font-weight: normal; height: 15px; color: #000; width: 10%;" align="left">
                                                                <%#DataBinder.Eval(Container.DataItem, "Name")+" :" %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: normal; padding-left: 60px; height: 15px; color: #000; width: 10%;"
                                                                align="left">
                                                                <%#DataBinder.Eval(Container.DataItem, "Value")%>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold; padding-top: 5px; height: 15px; color: #000; width: 10%;"
                                                align="right">
                                                <asp:Panel ID="Panel2" CssClass="dataheader2" BorderWidth="1px" runat="server" Width="100%"
                                                    meta:resourcekey="Panel2Resource1">
                                                    <%#DataBinder.Eval(Container.DataItem, "PerformingPhysicainName")%></asp:Panel>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                        <asp:Panel ID="PnlBtn" CssClass="dataheader2" Width="100%" BorderWidth="1px" runat="server"
                            meta:resourcekey="PnlBtnResource1">
                            <center>
                                <table>
                                    <tr align="center">
                                        <td>
                                            <asp:Button runat="server" ID="btnEdit" Text="Edit" CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                        </td>
                                        <td>
                                            <asp:Button runat="server" ID="btnFinish" Text="Finish" CssClass="btn" TabIndex="6"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return Print('dPrint')"
                                                OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
