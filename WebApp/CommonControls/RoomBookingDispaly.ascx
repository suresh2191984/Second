<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RoomBookingDispaly.ascx.cs"
    Inherits="CommonControls_RoomBookingDispaly" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
        <div id="divbook" runat="server" align="Center">
            <table>
                <tr>
                    <td style="background-color: #dcfec6; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdAvailInfo" style="background-color: #dcfec6; color: Black;">&nbsp; Available(<asp:Label
                            ID="lblAvailableCount" runat="server" Text="0" 
                            meta:resourcekey="lblAvailableCountResource1"></asp:Label>) </span>
                    </td>
                    <td style="background-color: #fcf2c3; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdBookedInfo" style="background-color: #fcf2c3; color: Black;">&nbsp; Booked(<asp:Label
                            ID="lblBookedCount" runat="server" Text="0" 
                            meta:resourcekey="lblBookedCountResource1"></asp:Label>) </span>
                    </td>
                    <td style="background-color: #ffdbdc; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdOccupiedInfo" style="background-color: #ffdbdc; color: Black;">&nbsp; Occupied(<asp:Label
                            ID="lblOccupiedCount" runat="server" Text="0" 
                            meta:resourcekey="lblOccupiedCountResource1"></asp:Label>) </span>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <div id="divAvailInfo" runat="server" style="font-family: verdana; font-size: 11px;
                            background-color: #dcfec6; border-width: 1px; color: Black; border-color: Silver;
                            border-style: double;">
                        </div>
                    </td>
                    <td>
                        <div id="divBookedInfo" runat="server" style="font-family: verdana; font-size: 11px;
                            background-color: #fcf2c3; border-width: 1px; color: Black; border-color: Silver;
                            border-style: double;">
                        </div>
                    </td>
                    <td>
                        <div id="divOccupiedInfo" runat="server" style="font-family: verdana; font-size: 11px;
                            background-color: #ffdbdc; border-width: 1px; color: Black; border-color: Silver;
                            border-style: double;">
                        </div>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnCurrentPatientBookedStatus1" runat="server" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <%-- <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnBook" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnOccupy" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnDischarge" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnTransfer" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click"></asp:AsyncPostBackTrigger>
    </Triggers>--%>
    <ContentTemplate>
        <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
            OnRowDataBound="gvIndentRoomType_RowDataBound" Width="100%" 
            meta:resourcekey="gvIndentRoomTypeResource1">
            <Columns>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <table style="border: solid 1px white; width: 100%; border-color: #195E00;" class="rooms">
                                        <tr>
                                            <td id="tdFloor" runat="server" class="floor" style="color: White; vertical-align: text-bottom;">
                                                <b>
                                                    <%# DataBinder.Eval(Container.DataItem, "FloorName")%></b>
                                            </td>
                                            <td id="tdDataList" runat="server" style="overflow: auto">
                                                <asp:DataList ID="dlFloorMaster" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                                    OnLoad="Page_Load" OnItemDataBound="dlFloorMaster_ItemDataBound" 
                                                    meta:resourcekey="dlFloorMasterResource1">
                                                    <HeaderTemplate>
                                                        <table style="font-family: Arial; font-size: 11px; height: 100px; padding-left: 15px;
                                                            text-align: center;">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <td id="tdCover" runat="server" style="width: 150px; vertical-align: middle; border-color: Silver;
                                                            background-color: #dcfec6; border-style: solid; border-width: 1px; color: Black;">
                                                            <asp:Panel ID='dvFloor' runat="server" meta:resourcekey="dvFloorResource1">
                                                                <asp:Label ID="lblPatientID" Style="display: none;" runat="server" 
                                                                    Text='<%# Eval("PatientID") %>' meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnVisitID" runat="server" Value='<%# Eval("VisitID") %>' />
                                                                <asp:HiddenField ID="hdnPrimaryConsultant" runat="server" Value='<%# Eval("PrimaryConsultant") %>' />
                                                                <asp:HiddenField ID="hdnPatientInfo" runat="server" Value='<%# Eval("PatientInfo") %>' />
                                                                <asp:Label ID="lblRoomName" runat="server" Text='<%# Eval("RoomName") %>' 
                                                                    meta:resourcekey="lblRoomNameResource1"></asp:Label>
                                                                -
                                                                <asp:Label ID="lblRoomType" runat="server" Text='<%# Eval("roomTypeName") %>' 
                                                                    meta:resourcekey="lblRoomTypeResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnAllowSlotBooking" runat="server" Value='<%# Eval("AllowSlotBooking") %>' />
                                                                <br />
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("PatientStatus") %>' 
                                                                    Visible="False" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                <asp:Label ID="lblBedName" runat="server" CssClass="borderstyle22" 
                                                                    Text='<%# Eval("BedName") %>' meta:resourcekey="lblBedNameResource1"></asp:Label><br />
                                                                <asp:Label ID="lblPatient" runat="server" Style="color: #700704;" 
                                                                    Text='<%# Eval("PatientName") %>' meta:resourcekey="lblPatientResource1"></asp:Label><br />
                                                                <asp:Label ID="lblFromDate" CssClass="labelSide" Style="color: #0f1644;" runat="server"
                                                                    Text='<%# Eval("FromDate") %>' meta:resourcekey="lblFromDateResource1"></asp:Label>
                                                                <asp:Label ID="lblToDate" CssClass="labelSide" Style="color: #0f1644;" runat="server"
                                                                    Text='<%# Eval("ToDate") %>' meta:resourcekey="lblToDateResource1"></asp:Label>
                                                                <div style="vertical-align: bottom;">
                                                                    <asp:LinkButton ID="lnkBook" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkBookResource1">Book</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkOccupy" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkOccupyResource1">Occupy</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkTransfer" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkTransferResource1">Transfer</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkVaccate" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkVaccateResource1">Vacate</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkCancel" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkCancelResource1">Cancel</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkSchedule" Style="color: Black;" CssClass="borderstyle" Visible="False"
                                                                        runat="server" meta:resourcekey="lnkScheduleResource1">Schedules</asp:LinkButton>
                                                                </div>
                                                            </asp:Panel>
                                                        </td>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </tr> </table>
                                                    </FooterTemplate>
                                                </asp:DataList>
                                            </td>
                                            <td id="tdEmptyList" runat="server" visible="False">
                                                <asp:Label ID="lblEmptyMsg" runat="server" Text="No Such Rooms Found." 
                                                    meta:resourcekey="lblEmptyMsgResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </ContentTemplate>
</asp:UpdatePanel>
