<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingVitals.ascx.cs"
    Inherits="CommonControls_PendingVitals" %>
<table>
    <tr>
        <td>
            <asp:Label ID="lblResult" runat="server" CssClass="defaultfontcolor" 
                meta:resourcekey="lblResultResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="grdPendingVitals" runat="server" AllowPaging="True" CssClass="gridView w-96p m-auto"
                AutoGenerateColumns="False" DataKeyNames="PatientID" OnRowDataBound="grdPendingVitals_RowDataBound"
                OnRowCommand="grdPendingVitals_RowCommand" ForeColor="#333333" 
                meta:resourcekey="grdPendingVitalsResource1">
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Font-Size="XX-Small" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Size="X-Small" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField Visible="false" DataField="PatientID" HeaderText="PatientID" 
                        meta:resourcekey="BoundFieldResource1" />
                    <asp:HyperLinkField Visible="false" DataNavigateUrlFields="PatientID" DataNavigateUrlFormatString="~/Nurse/PatientVitals.aspx?PatientID={0}"
                        Text="Capture Vitals" meta:resourcekey="HyperLinkFieldResource1" />
                    <asp:BoundField DataField="Name" HeaderText="Name" 
                        meta:resourcekey="BoundFieldResource2" />
                    <asp:BoundField DataField="Age" HeaderText="Age" 
                        meta:resourcekey="BoundFieldResource3" />
                    <asp:BoundField DataField="RelationName" HeaderText="Spouse/Father" 
                        meta:resourcekey="BoundFieldResource4" />
                    <asp:BoundField DataField="PhysicianName" HeaderText="Consultant" 
                        meta:resourcekey="BoundFieldResource5" />
                    <asp:BoundField DataField="Condition" HeaderText="Condition" 
                        meta:resourcekey="BoundFieldResource6" />
                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" 
                        HeaderText="VisitDate" meta:resourcekey="BoundFieldResource7" />
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
