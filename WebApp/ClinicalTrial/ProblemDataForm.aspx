<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProblemDataForm.aspx.cs"
    Inherits="ClinicalTrial_ProblemDataForm" %>

<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ControlListDetails.ascx" TagName="ControlListDetails"
    TagPrefix="uc8" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script type="text/javascript">
        function ChangeProblemFormsStatus(id) {
            if (document.getElementById('rdPSF').checked == true) {
            
                document.getElementById('pnlPDF').style.display = 'none';
                document.getElementById('tblProblemDataForm').style.display = 'none';
                document.getElementById('pnlTask').style.display = 'none';

              
                
            }
            if (document.getElementById('rdPDF').checked == true) { 
            
                document.getElementById('pnlPSF').style.display = 'none';
                document.getElementById('tblReportViewer').style.display = 'none';
                document.getElementById('pnlTask').style.display = 'none';
 
            }

        }
        function CloseReportViewer() {
            document.getElementById('pnlPSF').style.display = "none";
            document.getElementById('tblReportViewer').style.display = "none";
            document.getElementById('pnlTask').style.display = "none";
            document.getElementById('pnlPDF').style.display = "none";
            document.getElementById('tblProblemDataForm').style.display = "none";
            document.getElementById('pnlTask').style.display = "none"; 
        }
        function CheckMailAddress() {
            var txtMailAddress = $('#txtMailAddress');
            var mailAddresses = txtMailAddress.val().replace(' ', '');
            if (mailAddresses.length > 0) {
                var address = mailAddresses.split(',');
                var filter = /^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$/m;
                var isValid = true;
                for (var i = 0; i < address.length; i++) {
                    if (!filter.test(address[i])) {
                        isValid = false;
                    }
                }
                if (!isValid) {
                    alert('Provide a valid email address.');
                    txtMailAddress.focus();
                    return false;
                }
            }
            else {
                alert("Provide a email address.");
                txtMailAddress.focus();
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>

                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

                        <script type="text/javascript">
                            function pageLoad() {
                                $("#txtFromDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2050'
                                }); // Will run at every postback/AsyncPostback
                                $("#txtToDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2050'
                                });
                            }

                            $(function() {
                                $("#txtFromDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtToDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });

                        </script>

                        <div>
                            <%--<asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>--%>
                            <div>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel2" runat="server" GroupingText="Subject Search">
                                                <table width="50%">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="lblFromDate" runat="server" Width="75px" Text="From date :"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtFromDate" CssClass="Txtboxsmall" runat="server" Width="75px"></asp:TextBox>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblToDate" runat="server" Width="75px" Text="To date :"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtToDate" CssClass="Txtboxsmall" runat="server" Width="75px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:RadioButton ID="rdPSF" Text="problem specimen form" runat="server" Checked="true" onclick="javascript:ChangeProblemFormsStatus(this.id);"
                                                                GroupName="SerchType" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButton ID="rdPDF" Text="problem data form" runat="server" onclick="javascript:ChangeProblemFormsStatus(this.id);" GroupName="SerchType" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkDispatch" runat="server" Width="75px" Text="Dispatch" TextAlign="Right" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%" valign="top">
                                            <asp:Panel ID="Panel3" runat="server" GroupingText="Subjects List">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:GridView ID="grdProblemDataForm" runat="server" AutoGenerateColumns="False"
                                                                CellPadding="0" PageSize="100" ForeColor="Black" GridLines="Both" Width="100%"
                                                                CssClass="childrow" EmptyDataText="No records found" OnRowCommand="grdProblemDataForm_RowCommand">
                                                                <HeaderStyle CssClass="dataheader1" Font-Underline="True" />
                                                                <RowStyle Font-Bold="False" />
                                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                <Columns>
                                                                    <asp:BoundField DataField="Name" HeaderText="Subject name">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PatientID" HeaderText="Subject Id">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="RelationName" HeaderText="SubjectNo.">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="AliasName" HeaderText="Location">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PatientType" HeaderText="Type" Visible="false">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Action">
                                                                        <ItemTemplate>
                                                                            <asp:Button ID="btnShow" CommandName="ShowReport" CommandArgument='<%# Eval("PatientVisitID").ToString() + "^" + Eval("Name").ToString()+"^"+
                                                                    Eval("PatientID").ToString()+"^"+Eval("URNO").ToString()+"^"+Eval("PatientType").ToString()+"^"+Eval("EMail").ToString()+"^"+Eval("PatientType").ToString() %>'
                                                                                runat="server" Text="View" CssClass="btn1" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                        <td style="width: 60%">
                                            <asp:Panel ID="pnlPSF" runat="server" Style="display: none;" GroupingText="Problem Specimen Form">
                                                <table id="tblReportViewer" runat="server" border="0" style="display: none;" cellpadding="2"
                                                    cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                    <tr id="trPDF" runat="server">
                                                        <td colspan="4">
                                                            <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                                                                <ServerReport ReportServerUrl="" />
                                                            </rsweb:ReportViewer>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:Panel ID="pnlPDF" runat="server" GroupingText="Problem Data Form" Style="display: none;">
                                                <table id="tblProblemDataForm" runat="server" border="0" style="display: none;" cellpadding="2"
                                                    cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                    <tr>
                                                        <td>
                                                            <FCKeditorV2:FCKeditor ID="fckProblemDataForm" Height="600px" runat="server" Width="100%">
                                                            </FCKeditorV2:FCKeditor>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnExportPDF" runat="server" Text="Export" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnExportPDF_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:Panel ID="pnlTask" runat="server" Style="display: none;">
                                                <table id="Table1" runat="server" border="0" style="display: block;" cellpadding="2"
                                                    cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                    <tr>
                                                        <td align="right" style="vertical-align: middle;">
                                                            <asp:Label ID="lblMailAddress" runat="server" Text="To: " />
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                                                runat="server" />
                                                            <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                                                <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com" />
                                                            </p>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Button ID="btnSendMailReport" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="return CheckMailAddress();"
                                                                OnClick="btnSendMailReport_Click" />
                                                        </td>
                                                        <td align="center">
                                                            <input id="btnClose" runat="server" class="btn" type="button" onclick="CloseReportViewer();"
                                                                value="Close" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <input type="hidden" runat="server" id="hdnMailType" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
