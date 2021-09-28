<%@ Control Language="C#" AutoEventWireup="true" CodeFile="VitalsSnapShotview.ascx.cs"
    Inherits="CommonControls_VitalsSnapShotview" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table class="onflowdefaultfontcolor">
    <tr>
        <td>
            <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="defaultfontcolor">
            <div style="overflow: scroll; width: 750px;">
                <table border="0" cellpadding="4" cellspacing="1" width="100%">
                    <tr>
                        <td>
                            <asp:GridView ID="grdSnapShotView" runat="server" CellPadding="4" ForeColor="#333333"
                                OnRowCreated="grdSnapShotView_RowCreated" meta:resourcekey="grdSnapShotViewResource1">
                                <HeaderStyle />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                        <td>
                            <asp:GridView ID="grdFetals" AutoGenerateColumns="False" runat="server" CellPadding="4"
                                ForeColor="#333333" meta:resourcekey="grdFetalsResource1">
                                <Columns>
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Visit Date" DataFormatString="{0:dd/MM/yyyy}"
                                        meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField DataField="FetalNumber" HeaderText="No's" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField DataField="FetalPresentationDesc" HeaderText="Presentation" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField DataField="FetalPositionDesc" HeaderText="Position" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField DataField="FetalMovementsDesc" HeaderText="Movements" meta:resourcekey="BoundFieldResource5" />
                                    <asp:BoundField DataField="FetalFHSDesc" HeaderText="FHS" meta:resourcekey="BoundFieldResource6" />
                                    <asp:BoundField DataField="FetalOthers" HeaderText="Other's" meta:resourcekey="BoundFieldResource7" />
                                </Columns>
                                <HeaderStyle CssClass="subdataheader1" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-left: 20px;">
                            <asp:GridView ID="gvPatientObservation" AutoGenerateColumns="False" runat="server"
                                CellPadding="4" ForeColor="#333333" meta:resourcekey="gvPatientObservationResource1">
                                <Columns>
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Visit Date" DataFormatString="{0:dd/MM/yyyy}"
                                        meta:resourcekey="BoundFieldResource8" />
                                    <asp:BoundField DataField="Observation" HeaderText="Observation" meta:resourcekey="BoundFieldResource9" />
                                </Columns>
                                <HeaderStyle CssClass="subdataheader1" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
