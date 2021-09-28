<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmergencyDashBord.ascx.cs"
    Inherits="CommonControls_EmergencyDashBord" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table cellpadding="0" style="border: 0px; border-color: Red" runat="server" id="tbVisitClient"
    border="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <asp:GridView ID="grdEmDashboard" runat="server" AutoGenerateColumns="false" OnRowDataBound="grdEmDashboard_RowDataBound"
                HeaderStyle-Width="150px" OnRowCommand="grdEmDashboard_RowCommand" DataKeyNames="EmergencyPatientTrackerId">
                <Columns>
                    <asp:BoundField DataField="EmergencySeverityOrgMappingID" HeaderText="EP_OrgMappingID"
                        Visible="false" />
                    <asp:BoundField DataField="EmergencyPatientTrackerID" HeaderText="EP_TrackerId" Visible="false" />
                    <asp:BoundField DataField="PatientId" HeaderText="PatientId" Visible="false" />
                    <asp:BoundField DataField="PatientVisitId" HeaderText="PatientVisitID" Visible="false" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" HeaderStyle-Width="200px" />
                    <asp:BoundField DataField="Age" HeaderText="Age" HeaderStyle-Width="70px" />
                    <asp:BoundField DataField="Sex" HeaderText="Sex" HeaderStyle-Width="70px" />
                    <asp:BoundField DataField="Address" HeaderText="Address" HeaderStyle-Width="150px" />
                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile Number" HeaderStyle-Width="150px" />
                    <asp:BoundField DataField="City" HeaderText="City" HeaderStyle-Width="150px" />
                    <asp:BoundField DataField="Country" HeaderText="Country" HeaderStyle-Width="150px" />
                    <asp:TemplateField HeaderText="Emergency Level" HeaderStyle-Width="120px">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlLevel" runat="server" Width="150px" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlLevel_OnSelectedIndexChanged" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" Visible="false">
                        <ItemTemplate>
                            <asp:Button ID="btnButton" runat="server" Text="Save" Width="60px" CommandName="Save"
                                Visible="false" CommandArgument='<%# Eval("EmergencyPatientTrackerId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
