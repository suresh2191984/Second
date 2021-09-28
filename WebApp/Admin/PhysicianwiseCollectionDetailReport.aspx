<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicianwiseCollectionDetailReport.aspx.cs"
    Inherits="Admin_PhysicianwiseCollectionDetailReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Physician Wise Collection Detail</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.name = "ReportWindow";

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
<body id="oneColLayout" oncontextmenu="return true;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <center>
        <div id="divPrint" style="display: none;" runat="server">
            <table cellpadding="0" cellspacing="0" border="0" width="95%">
                <tr>
                    <td align="right" style="padding-right: 10px; color: #000000;">
                        <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport"  
                            Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div id="divOPDWCR" runat="server" style="display: block;">
            <div id="prnReport">
                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                    cellspacing="0" border="1" width="98%">
                    <tr class="Duecolor" style="height: 25px;">
                        <td id="tdPhysicianName" runat="server" align="left" style="font-weight: bold; font-size: 12px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                PageSize="100" ForeColor="Black" OnRowDataBound="grdResult_RowDataBound" GridLines="Both"
                                PagerSettings-Mode="NextPrevious" Width="99%" 
                                meta:resourcekey="grdResultResource1">
                                <PagerTemplate>
                                    <tr>
                                        <td align="center" colspan="6">
                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" 
                                                Width="18px" meta:resourcekey="lnkPrevResource1" />
                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" 
                                                Width="18px" meta:resourcekey="lnkNextResource1" />
                                        </td>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle Font-Underline="true" />
                                <RowStyle Font-Bold="false" />
                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                <Columns>
                                    <%-- <asp:BoundField DataField="VisitType" HeaderStyle-HorizontalAlign="center" HeaderText="Visit Type"
                                                ItemStyle-HorizontalAlign="center" Visible="true">
                                                <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="center" Width="12%"></ItemStyle>
                                            </asp:BoundField>
                                   
                                            <asp:BoundField DataField="Quantity" HeaderStyle-HorizontalAlign="center" HeaderText="Quantity"
                                                ItemStyle-HorizontalAlign="center" Visible="true">
                                                <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="center" Width="12%"></ItemStyle>
                                            </asp:BoundField>--%>
                                    <asp:BoundField DataField="VisitDate" HeaderStyle-HorizontalAlign="center" HeaderText="Date"
                                        ItemStyle-HorizontalAlign="center" Visible="true" 
                                        meta:resourcekey="BoundFieldResource1">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PatientName" HeaderStyle-HorizontalAlign="center" HeaderText="Patient Name"
                                        ItemStyle-HorizontalAlign="center" Visible="true" 
                                        meta:resourcekey="BoundFieldResource2">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                        HeaderText="Collection Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                        Visible="true" meta:resourcekey="BoundFieldResource3">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DiscountAmount" DataFormatString="{0:0.00}" HeaderText="Discount Amount">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RefundAmount" DataFormatString="{0:0.00}" HeaderText="Refund Amount">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AmountToHostingOrg" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                        HeaderText="Amount To Organisation" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                        Visible="true" meta:resourcekey="BoundFieldResource4">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PhysicianAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                        HeaderText="Amount To Physician" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                        Visible="true" meta:resourcekey="BoundFieldResource5">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <table id="tabGrandTotal" style="display: block;" runat="server" cellpadding="4"
                    cellspacing="0" border="0" width="99%">
                    <tr>
                        <td>
                            <table cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                border="1" width="99%">
                                <tr style="height: 25px; font-weight: bold;">
                                    <td colspan="2" align="center" width="27%">
                                       <asp:Label ID="lblTPC" runat="server" ForeColor="Red" 
                                            meta:resourcekey="lblTPCResource1"></asp:Label>
                                    </td>
                                    <td id="tdCollectionAmount" width="15%" align="right" runat="server">
                                    </td>
                                    <td id="tdDiscountAmount" width="12%" align="right" runat="server">
                                    </td>
                                    <td id="tdRefundAmount" width="12%" align="right" runat="server">
                                    </td>
                                    <td id="tdOrganisationAmount" width="15%" align="right" runat="server">
                                    </td>
                                    <td id="tdPhysicianAmount" width="15%" align="right" runat="server">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                         <tr>
                        <td id="tdscalc" runat="server" visible="false">
                            <table cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;font-weight:bold;"
                                border="1" width="99%">
                                <tr id="Tr1" align="right" runat="server">
                                    <td width="88%">
                                        <asp:Label ID="lbltds" Text="TDS (10%)" runat="server" />
                                    </td>
                                    <td id="Td1" align="right" runat="server">
                                        <asp:Label ID="lbltdsamt" Text="0.00" runat="server" />
                                    </td>
                                </tr>
                                <tr id="Tr2" align="right" runat="server">
                                    <td>
                                    </td>
                                    <td id="Td2" align="right" runat="server">
                                        <asp:Label ID="Label2" Text="---------------" runat="server" />
                                    </td>
                                </tr>
                                <tr id="Tr3" align="right" runat="server">
                                    <td class="style2">
                                        <asp:Label ID="lbls" Text="Net Total" runat="server" />
                                    </td>
                                    <td id="Td3" align="right" runat="server">
                                        <asp:Label ID="lblnettotal" Text="0.00" runat="server" />
                                    </td>
                                </tr>
                                <tr id="Tr4" align="right" runat="server">
                                    <td>
                                    </td>
                                    <td id="Td4" align="right" runat="server">
                                        <asp:Label ID="Label4" Text="---------------" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </center>
    </form>
</body>
</html>
