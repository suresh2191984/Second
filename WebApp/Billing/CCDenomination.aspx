<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CCDenomination.aspx.cs" Inherits="Billing_CCDenomination" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Voucher Receipt </title>
    <style type="text/css">
        .style1
        {
            height: 18px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function openPOPupQuick(url) {
            window.open(url, "PrintBill", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
    </script>

</head>
<body style="font-size: 12px;" onload="window.print()" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <table width="100%" border="0" align="center" id="tblBillPrint" runat="server">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="2" style="font-family: Verdana; font-size: 10px;"
                    cellpadding="2" align="center" id="tbl1" runat="server">
                    <tr>
                        <td align="center">
                            <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                                meta:resourcekey="imgBillLogoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>
                                <asp:Label ID="lblUserName" Text="User Name" runat="server" 
                                meta:resourcekey="lblUserNameResource1"></asp:Label></b>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                            <asp:Label ID="lblUserNametxt" runat="server" 
                                meta:resourcekey="lblUserNametxtResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>
                                <asp:Label ID="lblDate" Text="Cash Closure Date" runat="server" 
                                meta:resourcekey="lblDateResource1"></asp:Label></b>
                            :
                            <asp:Label ID="lblCCDatetxt" runat="server" 
                                meta:resourcekey="lblCCDatetxtResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-decoration: none;">
                            <asp:Label ID="lblDD" Text="Denomination Details:" runat="server" 
                                meta:resourcekey="lblDDResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="gvdata" runat="server">
                        <td>
                            <asp:GridView ID="gvResult" ShowFooter="True" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                Width="100%" Font-Names="Verdana" OnRowDataBound="gvResult_RowDataBound" 
                                meta:resourcekey="gvResultResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="8%" HeaderText="S.No" 
                                        meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>

<ItemStyle Width="8%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Details" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"ClosureID") %>' 
                                                meta:resourcekey="lblIDResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Details" 
                                        meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDetail" runat="server" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Rupees") %>' 
                                                meta:resourcekey="lblDetailResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                                        <HeaderStyle Width="30px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Unit" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUnit" runat="server" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Unit") %>' 
                                                meta:resourcekey="lblUnitResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                                        <HeaderStyle Width="30px" />
                                        <FooterTemplate>
                                            <b>
                                                <div style="text-align: right">
                                                    <asp:Label Style="text-align: right" ID="lblTotal" Text="Total:" runat="server" 
                                                        meta:resourcekey="lblTotalResource1"></asp:Label>
                                                </div>
                                            </b>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" 
                                        meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDetail" runat="server" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' 
                                                meta:resourcekey="lblDetailResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                                        <HeaderStyle Width="30px" />
                                        <FooterTemplate>
                                            <div style="text-align: right">
                                                <asp:Label Font-Bold="True" ID="lblTotalSum" runat="server" 
                                                    meta:resourcekey="lblTotalSumResource1"></asp:Label>
                                            </div>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            &nbsp;<asp:Label ID="Rs_TheSumof" Text="The Sum of" runat="server" 
                                meta:resourcekey="Rs_TheSumofResource1"></asp:Label>
                            <asp:Label ID="lblCurrency" runat="server" 
                                meta:resourcekey="lblCurrencyResource1" />. &nbsp;<asp:Label ID="lblAmountword"
                                runat="server" meta:resourcekey="lblAmountwordResource1"></asp:Label>
                            &nbsp;<asp:Label ID="Rs_Only" Text="Only..." runat="server" 
                                meta:resourcekey="Rs_OnlyResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="Right">
                            <asp:Label ID="lblReceiverSign" runat="server" Style="font-weight: 700" 
                                meta:resourcekey="lblReceiverSignResource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
