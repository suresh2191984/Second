<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewStockNonUsage.aspx.cs"
    Inherits="StockOutFlow_ViewStockNonUsage" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Usage</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divdamage">
            <table class="borderGrey w-100p" >
                <tr>
                    <td colspan="3" class="a-center">
                        <asp:Image ID="imgBillLogo" runat="server" class="hide a-center" meta:resourcekey="imgBillLogoResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="a-center bold">
                        <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_01%>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblOrgName" runat="server" class="a-left bold" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="w-70p">
                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                    </td>
                    <td class="w-20p a-right" >
                        <span class="marginR0" style="margin-right:14px;"><%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_02%></span>
                        <span class="marginL71" >:</span>
                    </td>
                    <td>
                        &nbsp;<asp:Label ID="lblSDDate" runat="server" meta:resourcekey="lblSDDateResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="h-15p">
                    <td>
                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                    </td>
                    <td class="a-right">
                        <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_03%> <span class="marginL11">:</span>
                    </td>
                    <td>
                        &nbsp;
                        <asp:Label ID="lblSDID" runat="server" meta:resourcekey="lblSDIDResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                    </td>
                    <td class="a-right">
                       <span class="marginR0" style="margin-right:14px;"> <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_04%></span> 
                       <span class="marginL64">:</span>
                    </td>
                    <td>
                        &nbsp;
                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <%--<tr>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>--%>
                <tr>
                    <td colspan="3">
                        <asp:Table CellPadding="4" CssClass="gridView w-100p" runat="server" ID="stockDamageDetailsTab"
                            meta:resourcekey="stockDamageDetailsTabResource1">
                        </asp:Table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" id="commentsTD" runat="server">
                        <%--<hr />--%>
                    </td>
                </tr>
                <tr id="approvalTR" class="hide" runat="server">
                    <td colspan="3">
                        <table class="w-100p" >
                            <tr class="lh25">
                                <td class="w-100">
                                    <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_05%>
                                    
                                </td>
                                <td class="w-10">
                                :</td>
                                <td id="approvedDateTD" class="a-left bold" runat="server">
                                </td>
                            </tr>
                            <tr class="lh25">
                                <td  class="w-100" >
                                    <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_06%>
                                     
                                </td>
                                <td>
                                :</td>
                                <td id="approvedByTD" class="a-left bold" runat="server">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <table class="w-100p">
            <tr>
                <td>
                    <table id="trApproveBlock" class="hide w-100p" runat="server">
                        <tr>
                            <td class="a-center">
                                <input type="hidden" id="hdnApproveStockDamage" runat="server" />
                                <asp:Button ID="btnApprove" Text="Approve" runat="server" CssClass="btn" OnClick="btnApprove_Click"
                                    meta:resourcekey="btnApproveResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="a-center">
                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                        runat="server" CssClass="btn w-5p" meta:resourcekey="btnPrintResource1" />
                    <asp:Button ID="Back" runat="server" CssClass="cancel-btn" OnClick="Back_Click" Text="Back"
                        meta:resourcekey="BackResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('divdamage');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body><html>');
            WinPrint.document.close();
            setTimeout(function() {
                WinPrint.focus();
                WinPrint.print();
                //WinPrint.close();
            }, 1000);
        }
    </script>

</body>
</html>
