<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryDetails.ascx.cs"
    Inherits="DischargeSummary_SurgeryDetails" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblSD" runat="server" Font-Bold="True" ></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Repeater ID="repTreatmentPlan" runat="server" OnItemDataBound="repTreatmentPlan_ItemDataBound">
                <ItemTemplate>
                    <asp:Table ID="tblSOI" Width="100%" runat="server">
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblTreatmentNameT" runat="server" Text="Treatment Name:"></asp:Label>
                                <asp:Label ID="lblTreatmentName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TreatmentName") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblFromTimeT" runat="server" Text="Treatment Date:"></asp:Label>
                                <asp:Label ID="lblFromTime" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTime") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblAnesthesiaTypeT" runat="server" Text="Anesthesia Type:"></asp:Label>
                                <asp:Label ID="lblAnesthesiaType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "AnesthesiaType") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblSurgeryTypeT" runat="server" Text="Surgery Type:"></asp:Label>
                                <asp:Label ID="lblSurgeryType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SurgeryType") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblOperationTypeT" runat="server" Text="Operation Type:"></asp:Label>
                                <asp:Label ID="lblOperationType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperationType") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblOperationFindingsT" runat="server" Text="Operation Findings:"></asp:Label>
                                <asp:Label ID="lblOperationFindings" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperativeFindings") %>'></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">
                                <asp:Label ID="lblOperativeTechniqueT" runat="server" Text="Operative Technique:"></asp:Label>
                                <asp:Label ID="lblOperativeTechnique" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperativeTechnique") %>'></asp:Label>
                                <br />
                                <br />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
</table>
