<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientWiseDepositReport.aspx.cs"
    Inherits="Reports_PatientWiseDepositReport" meta:resourcekey="PageResource1" %>

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
    <title>
        <asp:Label ID="Rs_Patientwise" Text="Patient Wise Deposit Detail" runat="server"></asp:Label>
    </title>
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
            return false;
        }
    
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return true;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <div id="prnReport" runat="server">
        <table width="100%" align="center" id="tblBillPrint" style="font-family: Verdana;
            font-size: 12px; border-style: solid; border-width: 1px;" runat="server">
            <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
            <tr>
                <td>
                    <table width="100%" id="tblHead" runat="server" border="0" cellspacing="0" cellpadding="0"
                        align="center">
                        <tr>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:Label ID="lblHospitalName" runat="server" Font-Bold="True" Style="font-family: Verdana;
                                    font-size: 20px;" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:Label ID="lblHoscity" runat="server" Font-Bold="True" Style="font-family: Verdana;
                                    font-size: 14px;" meta:resourcekey="lblHoscityResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="Rs_Colon" Text=" :" runat="server" meta:resourcekey="Rs_ColonResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <span style="width: 15%">
                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                            </span>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;<asp:Label ID="Rs_colon1" Text=":" runat="server" meta:resourcekey="Rs_colon1Resource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <span style="width: 23%">
                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="Rs_colon2" Text=":" runat="server" meta:resourcekey="Rs_colon2Resource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource1"></asp:Label>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_Sex" Text="Sex" runat="server" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;<asp:Label ID="Rs_colon3" Text=":" runat="server" meta:resourcekey="Rs_colon3Resource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td id="tdprint" runat="server" align="right" style="padding-right: 8px; color: #000000;">
                                            <b id="printText" runat="server">
                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td align="left" colspan="4">
                                            <asp:Label ID="lblnotfound" Text="No Records Found to this Patient" Font-Bold="True"
                                                runat="server" Visible="False" meta:resourcekey="lblnotfoundResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table width="100%" style="font-family: Verdana; font-size: 12px;">
                                            <tr>
                                                <td id="tdDeposit" runat="server">
                                                    <asp:Label ID="Rs_AmtDeposit" runat="server" Text="Amount Deposit Details" Style="font-family: Verdana;
                                                        font-size: 14px;" meta:resourcekey="Rs_AmtDepositResource1"></asp:Label>
                                                </td>
                                                <td id="tdDepositUse" runat="server">
                                                    <asp:Label ID="Rs_AmtUsage" runat="server" Text="Amount Usage Details" Style="font-family: Verdana;
                                                        font-size: 14px;" meta:resourcekey="Rs_AmtUsageResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <div id="prnDeposit" runat="server">
                                                    <td class="dataheaderInvCtrl">
                                                        <asp:GridView ID="gvDepositRpt" EmptyDataText="No Results Found." runat="server"
                                                            CssClass="mytable1" AutoGenerateColumns="False" Width="100%" meta:resourcekey="gvDepositRptResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Center" Font-Size="14px" />
                                                            <Columns>
                                                                <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date"
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourcekey="BoundFieldResource3" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </div>
                                                <div id="prnDepositUsage" runat="server">
                                                    <td class="dataheaderInvCtrl">
                                                        <asp:GridView ID="gvDepositUsageRpt" EmptyDataText="No Results Found." runat="server"
                                                            CssClass="mytable1" AutoGenerateColumns="False" Width="100%" meta:resourcekey="gvDepositUsageRptResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Center" Font-Size="14px" />
                                                            <Columns>
                                                                <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date"
                                                                    meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="AmountUsed" HeaderText="Used Deposited Amount" meta:resourcekey="BoundFieldResource6" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </div>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
