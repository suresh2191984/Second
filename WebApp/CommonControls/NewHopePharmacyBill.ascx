<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NewHopePharmacyBill.ascx.cs"
    Inherits="CommonControls_NewHopePharmacyBill" %>
<div id="divtag" runat="server">
    <asp:Table ID="billLaser" runat="server" Width="680px" Height="340px" BorderWidth="1">
        <asp:TableRow>
            <asp:TableCell Width="57px"></asp:TableCell>
            <asp:TableCell Height="298px" Width="548px" ID="billingDetails">
                <asp:Table ID="tblBill" runat="server">
                    <asp:TableRow>
                        <asp:TableCell runat="server"  Height="79px" Width="548px" ID="orgDetails">
                            <asp:Label ID="Duplicate" Visible="false" runat="server" Text="Duplicate Copy"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell runat="server"  Height="46px" Width="548px" ID="patientDetils">
                            <asp:Table ID="tblPatientDetails" runat="server">
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="billDetailTDLaser" runat="server" Width="548px">
                            <asp:Table ID="billDetailLaser" runat="server" Width="548px">
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="display: none;">
                        <asp:TableCell ID="amountInWordsLaser" Font-Bold="true" runat="server">
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ID="tdSoldByLaser" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                            HorizontalAlign="left" runat="server" ColumnSpan="2">
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
            <asp:TableCell Width="57px"></asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</div>
