<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IPBulkBill.ascx.cs" Inherits="CommonControls_IPBulkBill" %>
<style type="text/css">
    .dvPrintClass
    {
        font-family: Verdana;
        font-size: small;
    }
    tHead
    {
        display: table-header-group;
    }
    .style5
    {
        width: 228px;
    }
</style>

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
        lblGTotal.Text = GTotalUnitPrice.ToString();
        Label lbl = (Label)FindControl(ControlName);
        lbl.Text = TotalUnitPrice.ToString();
        return Price;
    }
    decimal GetTotal()
    {
        return TotalUnitPrice;
    }
</script>

<div align="center" id="printArea1" style="font-family: Verdana; font-size: 10px;"
    runat="server">
    <table border="0px" cellpadding="0px" cellspacing="0px" width="100%">
        <tr>
            <td colspan="5" align="center">
                <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" Font-Names="Verdana"
                    Font-Size="X-Small"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <br />
                <div id="div1" class="" align="left" style="font-weight: bold; font-size: small;"
                    runat="server">
                    <asp:Label ID="lblRoomHeader" Visible="false" Text="Room Breakup Charges-" runat="server"
                        meta:resourcekey="Rs_TreatmentChargesResource1" Font-Size="X-Small" Font-Bold="True"
                        Font-Names="Verdana"></asp:Label>
                    <asp:Label ID="lblRoomCharges" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Size="X-Small" Font-Bold="True" Font-Names="Verdana"></asp:Label>
                </div>
                <div>
                    <asp:GridView ID="gvIndentRoomDetails" ShowFooter="true" CellPadding="3" runat="server"
                        BorderStyle="Solid" BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False"
                        GridLines="None" Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvIndentRoomDetails_RowDataBound">
                        <HeaderStyle CssClass="dataheader1" />
                        <PagerStyle CssClass="dataheader1" />
                        <RowStyle HorizontalAlign="Left" />
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="35%" HeaderStyle-Width="35%" ItemStyle-BorderStyle="Solid"
                                ItemStyle-BorderWidth="1px" HeaderText="Description" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("RoomTypeName") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                                </ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField HeaderText="From" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource4">
                                <ItemStyle HorizontalAlign="Center" BorderStyle="Solid" BorderWidth="1px" VerticalAlign="Middle"
                                    Wrap="False" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="To" DataField="ToDate" DataFormatString="{0:dd/MM/yyyy}"
                                HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource4">
                                <ItemStyle HorizontalAlign="Center" BorderStyle="Solid" BorderWidth="1px" VerticalAlign="Middle"
                                    Wrap="False" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                                <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                    Width="15%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" Text='<%# bind("AMOUNT") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                                <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                    Width="5%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" Text='<%# bind("unit") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                                <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemTemplate>
                                    <%# GetAmount(decimal.Parse(NumberConvert(Eval("unit"), Eval("AMOUNT")).ToString()), "gvIndentRoomDetails", "lblRoomCharges")%>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# GetTotal() %>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource6" />
                            <asp:BoundField DataField="FromTable" Visible="false" HeaderText="From Table" meta:resourcekey="BoundFieldResource7" />
                        </Columns>
                    </asp:GridView>
                    <%-- <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                        OnRowDataBound="gvIndentRoomType_RowDataBound" Width="98%" meta:resourcekey="gvIndentRoomTypeResource1">
                        <Columns>
                            <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="left">
                                                <span style="font-family: Verdana; font-size: 10px;"><b>
                                                    <asp:Label ID="lblFeeTypeDetails" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RoomTypeName") %>'
                                                        meta:resourcekey="lblFeeTypeDetailsResource1"></asp:Label>
                                                </b></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>--%>
                    <%--<asp:GridView ID="gvIndentRoomDetails" ShowFooter="true" runat="server" AutoGenerateColumns="False"
                        OnRowDataBound="gvIndentRoomDetails_RowDataBound" Width="100%" BorderStyle="Solid" BorderColor="Black" GridLines="None"
                        HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderColor="Black" Font-Names="Verdana"
                        Font-Size="10px" meta:resourcekey="gvIndentRoomDetailsResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <PagerStyle CssClass="dataheader1" />
                        <RowStyle CssClass="dataheaderInvCtrl" />
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource3" />
                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="Descriptionx" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RoomTypeName") %>'
                                        meta:resourcekey="DescriptionxResource1"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="left" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:TemplateField>--%>
                    <%--<asp:BoundField HeaderText="Description" DataField="Description">
                                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                            </asp:BoundField>--%>
                    <%--<asp:BoundField HeaderText="Comments" DataField="Comments" />--%>
                    <%--<asp:BoundField HeaderText="From" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource4">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="To" DataField="ToDate" DataFormatString="{0:dd/MM/yyyy}"
                                HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource5">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="UnitPrice" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                        Text='<%# Eval("AMOUNT") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                        meta:resourcekey="txtUnitPriceResource1"></asp:Label>
                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quantity" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                        Text='<%# Eval("unit") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                        meta:resourcekey="txtQuantityResource1"></asp:Label>
                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal1" Text="Total" runat="server"></asp:Label>
                                </FooterTemplate>
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                                <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemTemplate>
                                    <%# GetAmount(decimal.Parse(NumberConvert(Eval("unit"), Eval("AMOUNT")).ToString()), "gvIndentRoomDetails", "lblRoomCharges")%>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# GetTotal() %>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                            </asp:TemplateField>--%>
                    <%--  <%--<asp:TemplateField HeaderText="Amount" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                   <%-- <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px"
                                        meta:resourcekey="txtAmountResource1"></asp:Label>
                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                    <itemtemplate>
                                    <%# GetAmount(decimal.Parse(NumberConvert(Eval("unit"), Eval("AMOUNT")).ToString()), "gvIndentRoomDetails", "lblRoomCharges")%>
                                    </itemtemplate>
                                <footertemplate>
                                        <%# GetTotal() %>
                                </footertemplate>
                                
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>--%>
                    <%--<asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource6" />
                                <asp:BoundField DataField="FromTable" Visible="false" HeaderText="From Table" meta:resourcekey="BoundFieldResource7" />
                            </Columns>
                        </asp:GridView>--%>
                </div>
            </td>
        </tr>
    </table>
    <%--</ItemTemplate> </asp:TemplateField> </Columns> </asp:GridView>--%>
    <!--/div-->
    <%--</td> </tr--%>
    <table border="0px" cellpadding="0px" cellspacing="0px" width="100%">
        <tr id="trInvs">
            <td colspan="5">
                <div id="dvInv" class="" align="left" style="font-weight: bold; font-size: small;"
                    runat="server">
                    <asp:Label ID="Label1" Text="Investigation Breakup Charges-" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Size="X-Small" Font-Bold="True" Font-Names="Verdana"></asp:Label>
                    <asp:Label ID="lblInvesCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Size="X-Small" Font-Bold="True" Font-Names="Verdana"></asp:Label>
                </div>
                <asp:GridView ID="gvInv" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvInv_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvInv","lblInvesCharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trInv">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trGroup" runat="server">
            <td colspan="5">
                <div id="dvGRP" class="" align="left" runat="server">
                    <asp:Label ID="Label2" Text="Group Investigation Breakup Charges" runat="server"
                        meta:resourcekey="Rs_TreatmentChargesResource1" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblGroupCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvGRP" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvGRP_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvGRP","lblGroupcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trGRP">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trInde" runat="server">
            <td colspan="5">
                <div id="dvIND" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label3" Text="Indents Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblIndentCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvIND" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvIND_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvIND","lblIndentcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trIND">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trCons" runat="server">
            <td colspan="5">
                <div id="dvCon" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label4" Text="Consultation Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblConsulCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvCon" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvCon_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvCon","lblConsulcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trCon">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trGenr" runat="server">
            <td colspan="5">
                <div id="dvGEN" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label5" Text="General Bill Items Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblGeneralCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvGEN" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvGEN_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvGEN","lblGeneralcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trGEN">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trPhaCharge" runat="server" style="width: 100%">
            <td colspan="5" id="tdPha" style="text-align: left;" runat="server">
                <div id="dvPRM" class="" style="font-weight: bold" runat="server">
                    <asp:Label ID="lblPhr" Text="Pharmacy Breakup Charges - " runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblPhrCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
            </td>
        </tr>
        <tr id="trPha" runat="server">
            <td colspan="5">
                <asp:GridView ID="gvPRM" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvPRM_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvPRM","lblPhrcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trPRM">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trSurg" runat="server">
            <td colspan="5">
                <div id="dvSPKG" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label7" Text="Surgery Package Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblSurgeryCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvSPKG" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvSPKG_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvSPKG","lblSurgerycharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trSPKG">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trRoom" runat="server">
            <td colspan="5">
                <div id="dvROM" class="" align="left" runat="server">
                    <asp:Label ID="Label8" Text="Room Breakup Charges-" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblRoomCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvROM" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvROM_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# CheckNull(Eval("ServiceCode")) %>'
                                    meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%--<asp:Label ID="lblTotal" Text='<%# NumberConvert(Eval("Unit"),Eval("Amount")) %>' runat="server"></asp:Label>--%>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvROM","lblRoomcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvROM","lblRoomcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trROM">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trProc" runat="server">
            <td colspan="5">
                <div id="dvPRO" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label9" Text="Procedures Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblProceCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvPRO" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvPRO_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%#  bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvPRO","lblProcecharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trPRO">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trAddi" runat="server">
            <td colspan="5">
                <div id="dvADD" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label10" Text="Additional Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblAdd" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvADD" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvADD_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvADD","lblAdd")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trADD">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trCasu" runat="server">
            <td colspan="5">
                <div id="dvCAS" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label11" Text="Casuality Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblCasulCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvCAS" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvCAS_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvCAS","lblCasulcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trCAS">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trDues" runat="server">
            <td colspan="5">
                <div id="dvDUE" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label12" Text="Due Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblDueCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvDUE" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvDUE_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvDUE","lblDuecharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trDUE">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trImmun" runat="server">
            <td colspan="5">
                <div id="dvIMU" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label13" Text="Immunization Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblImmuCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvIMU" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvIMU_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvIMU","lblImmucharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trIMU">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trLCN" runat="server">
            <td colspan="5">
                <div id="dvLCON" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label14" Text="LCON Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblLconCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvLCON" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvLCON_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvLCON","lblLconcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trLCON">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trMisc" runat="server">
            <td colspan="5">
                <div id="dvMiscellaneous" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label15" Text="Miscellaneous Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblMiscCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvMiscellaneous" ShowFooter="true" CellPadding="3" runat="server"
                    BorderStyle="Solid" BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False"
                    GridLines="None" Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvMiscellaneous_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvMiscellaneous","lblMisccharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trMiscellaneous">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trOthe" runat="server">
            <td colspan="5">
                <div id="dvOTH" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label16" Text="Others Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblOthCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvOTH" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvOTH_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvOTH","lblOthcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trOTH">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trPack" runat="server">
            <td colspan="5">
                <div id="dvPKG" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label17" Text="Health Package Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblHealthCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvPKG" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvPKG_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvPKG","lblHealthcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trPKG">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trRegi" runat="server">
            <td colspan="5">
                <div id="dvREG" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label18" Text="Registration Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblRegCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvREG" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvREG_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvREG","lblRegcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trREG">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr id="trSurgery" runat="server">
            <td colspan="5">
                <div id="dvSOI" class="" align="left" style="font-weight: bold" runat="server">
                    <asp:Label ID="Label19" Text="Surgery Items Breakup Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                    <asp:Label ID="lblSurgCharge" Text="" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"
                        Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                </div>
                <asp:GridView ID="gvSOI" ShowFooter="true" CellPadding="3" runat="server" BorderStyle="Solid"
                    BorderWidth="1px" BorderColor="Black" AutoGenerateColumns="False" GridLines="None"
                    Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvSOI_RowDataBound">
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerStyle CssClass="dataheader1" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="10%" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1px"
                            HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ServiceCode") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" BorderStyle="Solid" BorderColor="Black" Width="20%">
                            </ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Left" BorderStyle="Solid" BorderWidth="1px"
                                Width="45%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("FeeDesc") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="15%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Rate") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px"
                                Width="5%" />
                            <ItemTemplate>
                                <asp:Label ID="lblQty" Text='<%# bind("Qty") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" Text="Total" runat="server"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" FooterStyle-Font-Bold="True">
                            <ItemStyle Wrap="false" HorizontalAlign="Right" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemTemplate>
                                <%# GetAmount(decimal.Parse(Eval("Amount").ToString()), "gvSOI","lblSurgcharge")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# GetTotal() %>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="True"></FooterStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat="server" id="trSOI">
            <td colspan="5" style="height: 1px; background-color: Black; width: 100%;">
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td align="center" style="width: 80%; font-family: Verdana; font-size: 10; 
                text-align: right;">
                &nbsp;<asp:Label ID="lblGrdTot" Style="font-family: Verdana; font-size: 10; "
                    runat="server"  Font-Names="Verdana" Font-Size="X-Small">Grand Total</asp:Label>
            </td>
            <td class="style5" style="width: 3%">
                &nbsp;
            </td>
            <td colspan="1" align="right">
                <asp:Label ID="lblGTotal" Style="font-family: Verdana; font-size: 10; font-weight: bold;"
                    runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
            </td>
        </tr>
        <tr id="trRoundOff" style="display: block" runat="server">
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td align="center" style="width: 80%; font-family: Verdana; font-size: 10; 
                text-align: right;">
                <asp:Label ID="lblRoundOff" Style="font-family: Verdana; font-size: 10; "
                    runat="server" Font-Names="Verdana">Round Off</asp:Label>
            </td>
            <td class="style5" style="width: 3%">
                &nbsp;
            </td>
            <td colspan="1" align="right">
                <asp:Label ID="lblRound" Style="font-family: Verdana; font-size: 10; font-weight: bold;"
                    runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
            </td>
        </tr>
        <%--Pre AuthorizationAmount --%>
        
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td align="center" style="font-family: Verdana; font-size: 10; 
                text-align: right;">
                <asp:Label ID="lblNetAmount" Style="width: 80%; font-family: Verdana; font-size: 10;" runat="server" Font-Names="Verdana" Font-Size="X-Small">Net Amount</asp:Label>
            </td>
            <td class="style5" style="width: 3%">
                &nbsp;
            </td>
            <td colspan="1" align="right">
                <asp:Label ID="lblNetTotal" Style="font-family: Verdana; font-size: 10; font-weight: bold;"
                    runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
                <asp:HiddenField ID="hdnRoundOffType" runat="server" />
            </td>
        </tr>
        <%--End Pre Authorization Amount --%>
    </table>
</div>
