<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintInsuranceCorporateReport.aspx.cs"
    Inherits="Reports_PrintInsuranceCorporateReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <input type="button" name="btnPrint" value="Print" class="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" onclick="PrintReport()" />
                    </br>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblTPC" runat="server" Font-Bold="true" Visible="false" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="grdResult" Width="100%" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="PatientID,PatientVisitID" OnRowDataBound="grdResult_RowDataBound"
                        ShowFooter="True" HorizontalAlign="Right">
                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderStyle CssClass="dataheader1" />
                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                            PageButtonCount="5" PreviousPageText="" />
                        <Columns>
                            <asp:BoundField DataField="PatientID" HeaderText="PatientID" Visible="false" />
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No." />
                            <asp:TemplateField HeaderText="Admission Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblAdmissionDate" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discharge Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDischaredDT" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="RefPhysicianName" HeaderText="RefPhysician"></asp:BoundField>
                            <asp:BoundField DataField="PrimaryConsultant" HeaderText="ConsultantName"></asp:BoundField>
                            <asp:BoundField DataField="TPAName" HeaderText="TPA/Corporate"></asp:BoundField>
                            <asp:BoundField DataField="PreAuthAmount" HeaderText="PreAuth Amount" HeaderStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="BillAmount" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblBillAmount" runat="server" Text='<%#Bind("GrossAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Recieved From Patient" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblRecievedAmount" runat="server" Text='<%#Bind("RecievedAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Refund/Discount " HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblRefund" runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Claim From TPA" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblClaimFromTPA" runat="server" Text='<%#Bind("TPABillAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Received From TPA" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblPaidByTPA" runat="server" Text='<%#Bind("PaidByTPA") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TDS" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblTDS" runat="server" Text='<%#Bind("TDSAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="WriteOff" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblWriteOff" runat="server" Text='<%#Bind("WriteOff") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ClaimForwarded Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblCliamForwardDate" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Settlement Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblTPASettlementDate" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    function PrintReport() {
        document.getElementById('btnPrint').style.display = "none";
        window.print();
    }
</script>

