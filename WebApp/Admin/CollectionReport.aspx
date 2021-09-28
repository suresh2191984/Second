<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectionReport.aspx.cs"
    Inherits="Admin_CollectionReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
   
    </script>

    <script runat="server">
        decimal GTotalUnitPrice;
        decimal TotalUnitPrice;
        string GridN = "";
        //decimal GetGrandTotal(decimal Price)
        //{
        //    GTotalUnitPrice += Price;
        //    lblGTotal.Text = GTotalUnitPrice.ToString();
        //    return Price;
        //}
        decimal GetAmount(decimal Price, string GridName, string ControlName)
        {
            if (GridN != GridName)
            {
                GridN = GridName;
                TotalUnitPrice = 0;
            }
            TotalUnitPrice += Price;
            GTotalUnitPrice += Price;
            lblAmount.Text = GTotalUnitPrice.ToString();
            Label lbl = (Label)FindControl(ControlName);
            lbl.Text = TotalUnitPrice.ToString();
            return Price;
        }
        decimal GetTotal()
        {
            return TotalUnitPrice;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" width="700px">
            <tr valign="middle" align="center">
                <td align="center">
                    <asp:Label ID="lblAmount" runat="server"></asp:Label>
                    <asp:Button ID="btnEmpty" Style="display: none;" runat="server" OnClick="btnEmpty_Click" />
                    <div style="height: 600px; overflow: auto;">
                        <asp:GridView ID="gvPayDet" EmptyDataText="No Results Found." AllowPaging="false"
                            runat="server" GridLines="Both" CssClass="mytable1" ShowFooter="true" AutoGenerateColumns="false"
                            Width="100%">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="S.No">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BillDate" HeaderText="Billed Date" ItemStyle-HorizontalAlign="Left">
                                </asp:BoundField>
                                <asp:BoundField DataField="ReceiptNO" HeaderText="Receipt No." ItemStyle-HorizontalAlign="Left">
                                </asp:BoundField>
                                <asp:BoundField DataField="BillNumber" HeaderText="Bill Number" ItemStyle-HorizontalAlign="Left">
                                </asp:BoundField>
                                <%--<asp:BoundField DataField="PatientName" HeaderText="ReceivedBy" ItemStyle-HorizontalAlign="Left"></asp:BoundField>--%>
                                <%--<asp:BoundField DataField="BilledAmount" HeaderText="Amount" ItemStyle-HorizontalAlign="Right"></asp:BoundField>--%>
                                <asp:TemplateField HeaderText="Received By" FooterStyle-Font-Bold="True">
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceivedBy" Text='<%# bind("PatientName") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" FooterStyle-Font-Bold="True">
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <%# GetAmount(decimal.Parse(Eval("BilledAmount").ToString()), "gvPayDet", "lblAmount")%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <%# GetTotal() %>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnUserIDs" runat="server" />
    </div>
    </form>
</body>

<script type="text/javascript">
    var parentUser = window.opener.document.getElementById('hdnUserID');
    var user = document.getElementById('hdnUserIDs');
    user.value = parentUser.value;
    var bt = document.getElementById('btnEmpty');
    bt.click();
</script>

</html>
