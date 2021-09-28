<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NMCPharmaBillPrint.ascx.cs"
    Inherits="CommonControls_NMCPharmaBillPrint" %>
<div id="divtag" runat="server" style="padding-left: 30px;">
    <asp:Table ID="billLaser" runat="server" Width="65%" Style="padding-left: 40px;">
        <asp:TableRow>
            <asp:TableCell Height="10px" Width="60%" ID="orgHeadLaser" Font-Bold="true" Font-Size="12px"
                ColumnSpan="2" HorizontalAlign="Center" runat="server">
                <asp:Label ID="Duplicate" Visible="false" runat="server" Text="Duplicate Copy"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell Height="10px" Width="60%" ID="BillType" Font-Bold="true" Font-Size="12px"
                ColumnSpan="2" HorizontalAlign="Center" runat="server">
                <asp:Label ID="CreditOrCash" runat="server"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell Width="40%" VerticalAlign="Top" HorizontalAlign="Left" Style="padding-top: 0px;
                padding-left: 50px;">
                <asp:Table ID="Table1" runat="server">
                    <asp:TableRow>
                        <asp:TableCell ID="patientNameLaser" Font-Bold="true" HorizontalAlign="left" runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="PatientAddress" Font-Bold="true" runat="server" HorizontalAlign="left">
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
            <asp:TableCell ID="billHeaderTDLaser" HorizontalAlign="Right" Style="padding-top: 0px;
                padding-left: 60px;" runat="server" Width="40%" VerticalAlign="Top">
                <asp:Table ID="billHeaderLaser" runat="server" Width="100%">
                    <asp:TableRow>
                        <asp:TableCell ID="billNoLaser" Style="padding-top: 0px;" Font-Bold="true" HorizontalAlign="left"
                            runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="billDateLaser" Style="padding-top: 0px;" Font-Bold="true" HorizontalAlign="left"
                            runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="regno" Style="padding-top: 0px;" Font-Bold="true" HorizontalAlign="left"
                            runat="server">
                                &nbsp;
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="refby" Style="padding-top: 0px;" Font-Bold="true" HorizontalAlign="left"
                            runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                     <asp:TableRow>
                        <asp:TableCell ID="lblPharmacyBillNo" Style="padding-top: 0px;" Font-Bold="true" HorizontalAlign="left"
                            runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell Height="28px" Width="60%" ID="TitleRow" Font-Bold="true" Font-Size="18px"
                ColumnSpan="2" HorizontalAlign="Center" runat="server">
  
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ID="billDetailTDLaser" runat="server" VerticalAlign="Top" ColumnSpan="2"
                Style="padding-left: 0px;">
                <asp:Table ID="billDetailLaser" runat="server" CellPadding="3" CellSpacing="0" Width="100%">
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow Style="display: none;">
            <asp:TableCell ID="amountInWordsLaser" Font-Bold="true" Height="115px" VerticalAlign="Top"
                Style="padding-right: 0px;" HorizontalAlign="right" runat="server" ColumnSpan="2">
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ID="tdSoldByLaser" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                HorizontalAlign="left" runat="server" ColumnSpan="2">
  
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ID="tdBillPolicy" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                HorizontalAlign="left" runat="server" ColumnSpan="2">
  <%--    <asp:Label ID="lblPolicy" runat="server" />--%>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</div>
