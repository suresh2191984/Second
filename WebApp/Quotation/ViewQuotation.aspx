<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewQuotation.aspx.cs" Inherits="Quotation_ViewQuotation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Quotation</title>    
   
    <script language="javascript" type="text/javascript">

        function CallPrint() {
            var prtContent = document.getElementById('divReceived');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }

    </script>
    <link href="../PlatForm/StyleSheets/Common.css" rel="Stylesheet" type="text/css" runat="server" id="lnkCommon_css" />
    <link href="../PlatForm/Themes/GG/style.css" rel="stylesheet" type="text/css" id="lnkstylesheet_css" runat="server" />


    <script src="../PlatForm/Scripts/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <%--<Attune:Attuneheader ID="Attuneheader" runat="server" />--%>
   
                    <div class="contentdata" style="height:650px;overflow-y: scroll;">
                    
                        <div id="divReceived" align="center">
                            <table class="w-100p">
                                <tr>
                                    <td colspan="2" class="a-center bold">
                                        <asp:Label ID="lblSupQuot" runat="server" Font-Size="Small" 
                                            Text="Supplier Quotation" meta:resourcekey="lblSupQuotResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <table class="w-70p">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOrgName" Font-Bold="True" Font-Size="Small" runat="server" 
                                                        meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="tdTinNo" runat="server" class="hide">
                                                    <asp:Label ID="lblOrgTinnotxt" Font-Bold="True" Text="TIN No :" runat="server" 
                                                        meta:resourcekey="lblOrgTinnotxtResource1"></asp:Label>
                                                    <asp:Label ID="lblOrgTinno" runat="server" 
                                                        meta:resourcekey="lblOrgTinnoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="tdDLNo" runat="server" class="hide">
                                                    <asp:Label ID="lblOrgDlnotxt" Font-Bold="True" Text="DL No :" runat="server" 
                                                        meta:resourcekey="lblOrgDlnotxtResource1"></asp:Label>
                                                    <asp:Label ID="lblorgDlno" runat="server" 
                                                        meta:resourcekey="lblorgDlnoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStreetAddress" runat="server" 
                                                        meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="a-left w-30p">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblQuotation" class="bold" runat="server" Text="Quotation No" 
                                                        meta:resourcekey="lblQuotationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblll1" runat="server" meta:resourcekey="lblll1Resource1">:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblQuotationNo" runat="server" 
                                                        meta:resourcekey="lblQuotationNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblFDate" class="bold" runat="server" Text="Valid From Date" 
                                                        meta:resourcekey="lblFDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblll2" runat="server" meta:resourcekey="lblll2Resource1">:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblValFromDate" runat="server" 
                                                        meta:resourcekey="lblValFromDateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTDate" class="bold" runat="server" Text="Valid To Date" 
                                                        meta:resourcekey="lblTDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblll3" runat="server" meta:resourcekey="lblll3Resource1">:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblValToDate" runat="server" 
                                                        meta:resourcekey="lblValToDateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStatustxt" class="bold" runat="server" Text="Status" 
                                                        meta:resourcekey="lblStatustxtResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblll4" runat="server" meta:resourcekey="lblll4Resource1">:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorName" Font-Bold="True" Font-Size="Small" runat="server" 
                                                        meta:resourcekey="lblVendorNameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorTinnotxt" Font-Bold="True" Text="TIN No :" 
                                                        runat="server" meta:resourcekey="lblVendorTinnotxtResource1"></asp:Label>
                                                    <asp:Label ID="lblVendorTinno" runat="server" 
                                                        meta:resourcekey="lblVendorTinnoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorAddress" runat="server" 
                                                        meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorCity" runat="server" 
                                                        meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                                </td>
                                            </tr>
											<tr>
                                                <td>
                                                    <asp:Label ID="lblvendorState" runat="server" 
                                                        meta:resourcekey="lblvendorStateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorPhone" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView EmptyDataText="No matching records found " ID="grdResult" runat="server"
                                            AutoGenerateColumns="False" CssClass="gridView w-100p" 
                                            meta:resourcekey="grdResultResource1">
                                            <Columns>
                                                <asp:BoundField HeaderText="Product" DataField="ProductName" 
                                                    ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText=" Cost Price " DataField="Rate"  DataFormatString="{0:N}"
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText=" Unit " DataField="Unit" 
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText=" Selling Price " DataField="SellingPrice" ItemStyle-HorizontalAlign="Right"
                                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource4" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText=" MRP " ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N}" 
                                                    DataField="MRP" meta:resourcekey="BoundFieldResource5" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="Discount (%)" DataField="Discount"  DataFormatString="{0:N}"
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource6" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="Tax (%)" DataField="Tax"  DataFormatString="{0:N}"
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource7" >
                                                </asp:BoundField>
												<asp:BoundField HeaderText="SoldYesterDay" DataField="InHandQuantity" 
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource8" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="SoldLastMonth" DataField="StockReceived" 
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource9" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="SoldLastQuater" DataField="StockIssued" 
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource10" >
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="Product is" DataField="ReceiptNo" 
                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource11" >
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="w-100p">
                            <tr>
                                <td colspan="2" class="a-center">
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="javascript:return CallPrint();"
                                        Width="40px" runat="server" CssClass="btn" meta:resourcekey="btnPrintResource1" />
                                 <%--   <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn"
                                        OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />--%>
                                    <asp:Button ID="btnClose" Text="Close" Visible="False" runat="server" CssClass="btn"
                                        OnClick="btnClose_Click" 
                                        meta:resourcekey="btnCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
        
        <asp:HiddenField ID="hdnMessages" runat="server" />
         <%--<Attune:Attunefooter ID="Attunefooter" runat="server" />--%>
    </form>
    

    
</body>
</html>
