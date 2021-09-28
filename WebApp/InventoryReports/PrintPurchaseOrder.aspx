<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintPurchaseOrder.aspx.cs"
    Inherits="InventoryReports_PrintPurchaseOrder" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Purchase Order</title>

    <script src="../InventoryCommon/Scripts/PurchaseOrder.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .style4
        {
            width: 120px;
        }
        .style5
        {
            width: 129px;
        }
        .style18
        {
            width: 20%;
            height: 23px;
        }
        .style19
        {
            height: 23px;
        }
        .style21
        {
            width: 143px;
        }
    </style>

    <script language="javascript" type="text/javascript">

        function popupprint() {
            document.getElementById('divbtn').style.display = 'none';

            var prtContent = document.getElementById('sample');
            //prnReport
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="Divcontent" style="height=70%;" class="contentdata">
        <div id="sample" runat="server">
            <table>
                <tr>
                    <td align="center">
                        <table cssclass="mytable1" height="80%;">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblPurchaseOrder" Text="Purchase Order Details" runat="server" meta:resourcekey="lblPurchaseOrderResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvPurOrderDetails" Visible="False" runat="server" AllowPaging="True"
                                        Height="50%" BorderStyle="Outset" AutoGenerateColumns="False" CellPadding="2"
                                        CellSpacing="2" BorderColor="Black" Width="100%" meta:resourcekey="gvPurOrderDetailsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="PurchaseOrderNo" HeaderText="PO No" meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField DataField="DeliveryDate" HeaderText="PO Date" meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" meta:resourcekey="BoundFieldResource5" />
                                            <asp:BoundField DataField="Units" HeaderText="Unit" meta:resourcekey="BoundFieldResource6" />
                                            <asp:BoundField DataField="Rate" HeaderText="Rate" meta:resourcekey="BoundFieldResource7" />
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8" />
                                            <asp:BoundField DataField="POID" HeaderText="POID" Visible="false" meta:resourcekey="BoundFieldResource9" />
                                            <asp:TemplateField HeaderText="Comments" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                                meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtComments" runat="server" OnkeyPress="return ValidateMultiLangChar(this)" Style="padding-right: 10px;" Width="60px"
                                                        Text='<%# Eval("Comments") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hdnComments" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblPODelivery" Text="Purchase Order Delivery Details" runat="server"
                                        meta:resourcekey="lblPODeliveryResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvDetails" Visible="False" runat="server" AllowPaging="True" Height="50%"
                                        BorderStyle="Outset" AutoGenerateColumns="False" CellPadding="2" CellSpacing="2"
                                        BorderColor="Black" Width="100%" meta:resourcekey="gvDetailsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="PurchaseOrderNo" HeaderText="PO No" meta:resourcekey="BoundFieldResource10" />
                                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource11" />
                                            <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" Visible="false"
                                                meta:resourcekey="BoundFieldResource12" />
                                            <asp:BoundField DataField="LocationName" HeaderText="Location Name" meta:resourcekey="BoundFieldResource13" />
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" meta:resourcekey="BoundFieldResource14" />
                                            <asp:BoundField DataField="Units" HeaderText="Unit" meta:resourcekey="BoundFieldResource15" />
                                            <asp:BoundField DataField="DeliveryDate" HeaderText="PO Date" meta:resourcekey="BoundFieldResource16" />
                                            <asp:BoundField DataField="POID" HeaderText="POID" Visible="false" meta:resourcekey="BoundFieldResource17" />
                                            <asp:BoundField DataField="LocationId" HeaderText="LocationId" Visible="false" meta:resourcekey="BoundFieldResource18" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divbtn">
            <table border="0" cellpadding="0" cellspacing="0" cssclass="mytable1">
                <tr>
                    <td>
                        <center>
                            <asp:Button ID="btnPrint" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                onmouseover="this.className='btn btnhov'" Text="Print" OnClientClick="return popupprint();"
                                meta:resourcekey="btnPrintResource1" />
                        </center>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
