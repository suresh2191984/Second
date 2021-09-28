<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhyAllSchedules.ascx.cs"
    Inherits="CommonControls_PhySchedule" %>
<style type="text/css">
    </style>
<div id="NoData" align="center" runat="server">
    <asp:Label ID="Rs_No_Data" runat="server" Text="No Data Available" meta:resourcekey="Rs_No_DataResource1"></asp:Label></div>
<table class="rooms w-100p" style="background-color: Transparent;">
    <tr>
        <td style="overflow: auto">
            <div id="YesData" runat="server" visible="false">
                <asp:DataList ID="dlFloorMaster" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                    OnLoad="Page_Load" meta:resourcekey="dlFloorMasterResource1">
                    <HeaderTemplate>
                        <asp:Label ID="lblWarning" runat="server" CssClass="errorbox" Style="color: Black;"
                            meta:resourcekey="lblWarningResource1" Text="Caution : Deleting/Modifying the Schedule may delete all the previous bookings related to the schedule."></asp:Label>
                        &nbsp;<br />
                        <table style="font-family: Arial; font-size: 11px; height: 100px; padding-left: 15px;
                            text-align: center;">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <td id="tdCover" runat="server" class="tokenbooking">
                            <asp:Panel ID='dvFloor' runat="server" meta:resourcekey="dvFloorResource2">
                                <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                <div style="vertical-align: bottom;">
                                    <input type="button" id="btchange" style="color: White; font-size: 9px; font-family: Verdana;"
                                        class="btn" onclick='<%# Eval("AllIds") %>' visible="true" title="Change Schedules"
                                        value="Change" />
                                    <input type="button" id="btcancel" style="color: White; font-size: 9px; font-family: Verdana;"
                                        class="btn" visible="true" onclick='<%# Eval("DelIds") %>' title="Cancel Schedules"
                                        value="Cancel" />
                                </div>
                            </asp:Panel>
                        </td>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tr> </table>
                    </FooterTemplate>
                </asp:DataList>
            </div>
        </td>
    </tr>
</table>
