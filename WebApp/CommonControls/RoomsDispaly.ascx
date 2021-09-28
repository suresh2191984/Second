<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RoomsDispaly.ascx.cs"
    Inherits="CommonControls_RoomsDispaly" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    </style>
<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
        <div id="divbook" runat="server" class="a-center">
            <table>
                <tr>
                    <td style="background-color: #dcfec6; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdAvailInfo" style="background-color: #dcfec6; color: Black;">&nbsp; Available(<asp:Label
                            ID="lblAvailableCount" runat="server" Text="0"></asp:Label>) </span>
                    </td>
                    <td style="background-color: #fcf2c3; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdBookedInfo" style="background-color: #fcf2c3; color: Black;">&nbsp; Booked(<asp:Label
                            ID="lblBookedCount" runat="server" Text="0"></asp:Label>) </span>
                    </td>
                    <td style="background-color: #ffdbdc; border-width: 1px; border-color: Silver; border-style: double;">
                        <span id="tdOccupiedInfo" style="background-color: #ffdbdc; color: Black;">&nbsp; Occupied(<asp:Label
                            ID="lblOccupiedCount" runat="server" Text="0"></asp:Label>) </span>
                    </td>
                </tr>
                <tr class="a-left">
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
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnBook" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnOccupy" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnDischarge" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnTransfer" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click"></asp:AsyncPostBackTrigger>
    </Triggers>
    <ContentTemplate>
        <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
            OnRowDataBound="gvIndentRoomType_RowDataBound" CssClass="w-100p gridView">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <table class="w-100p">
                            <tr>
                                <%--<td align="left" style="height: 25px;">
                                      <b> <%# DataBinder.Eval(Container.DataItem, "FloorName")%> </b>
                                </td>--%>
                            </tr>
                            <tr>
                                <td>
                                    <table style="border:1px solid #195E00;" class="rooms w-100p">
                                        <tr>
                                            <td  id="tdFloor" runat="server"  class="floor" style="color:White;vertical-align:text-bottom;">
                                                <%--<asp:Label ID="lblFloor" runat="server" ></asp:Label>--%>
                                           <b> <%# DataBinder.Eval(Container.DataItem, "FloorName")%></b>
                                            </td>
                                            <td id="tdDataList" runat="server" style="overflow: auto" visible="true">
                                                <asp:DataList ID="dlFloorMaster" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                                    OnLoad="Page_Load" OnItemDataBound="dlFloorMaster_ItemDataBound">
                                                    <HeaderTemplate>
                                                        <table style="font-family: Arial; font-size: 11px; height: 100px; padding-left: 15px;
                                                            text-align: center;">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <td id="tdCover" runat="server" style="width: 150px; vertical-align: middle; border-color: Silver;
                                                            background-color: #dcfec6; border-style: solid; border-width: 1px; color: Black;">
                                                            <asp:Panel ID='dvFloor' runat="server">
                                                                <asp:Label ID="lblPatientID" Style="display: none;" runat="server" Text='<%# Eval("PatientID") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdnVisitID" runat="server" Value='<%# Eval("VisitID") %>' />
                                                                <asp:HiddenField ID="hdnPrimaryConsultant" runat="server" Value='<%# Eval("PrimaryConsultant") %>' />
                                                                <asp:HiddenField ID="hdnPatientInfo" runat="server" Value='<%# Eval("PatientInfo") %>' />
                                                                <asp:Label ID="lblRoomName" runat="server" Text='<%# Eval("RoomName") %>'></asp:Label>
                                                                -
                                                                <asp:Label ID="lblRoomType" runat="server" Text='<%# Eval("roomTypeName") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdnAllowSlotBooking" runat="server" Value='<%# Eval("AllowSlotBooking") %>' />
                                                                <br />
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("PatientStatus") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblBedName" runat="server" CssClass="borderstyle22" Text='<%# Eval("BedName") %>'></asp:Label><br />
                                                                <asp:Label ID="lblPatient" runat="server" Style="color: #700704;" Text='<%# Eval("PatientName") %>'></asp:Label><br />
                                                                <asp:Label ID="lblFromDate" CssClass="labelSide" Style="color: #0f1644;" runat="server"
                                                                    Text='<%# Eval("FromDate") %>'></asp:Label>
                                                                <asp:Label ID="lblToDate" CssClass="labelSide" Style="color: #0f1644;" runat="server"
                                                                    Text='<%# Eval("ToDate") %>'></asp:Label>
                                                                <br />
                                                                <%--<asp:Image ID="IMG1" runat="server" ImageUrl="~/Images/correct.gif" runat="server" />--%>
                                                                <%--<asp:DataList ID="DataList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" onload="Page_Load" >
                                                                    <HeaderTemplate >
                                                                    <table  style="font-family:Arial;font-size:11px; padding-left:15px; text-align:center;"  >
                                                                    <tr>
                                                                        </HeaderTemplate>
                                                                        
                                                                        <ItemTemplate >
                                                                        <td>
                                                                         <asp:Label ID="lblFromDate" CssClass="labelSide" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label> 
                                                                         <asp:Label ID="lblToDate" CssClass="labelSide" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label> <br />
                                                                        </td>
                                                                        </ItemTemplate>
                                                                         
                                                                        <FooterTemplate>
                                                                         </tr>
                                                                    </table>
                                                                        </FooterTemplate>
                                                                    </asp:DataList>--%>
                                                                <div style="vertical-align: bottom;">
                                                                    <asp:LinkButton ID="lnkBook" Style="color: Black;" CssClass="borderstyle" Visible="false" 
                                                                        runat="server">Book</asp:LinkButton>  <%--OnClientClick ="CheckAlreadyBooking();"  --%>
                                                                         <%--OnClick="btnShowBooking_Click"--%>
                                                                    <asp:LinkButton ID="lnkOccupy" Style="color: Black;" CssClass="borderstyle" Visible="false"
                                                                        runat="server">Occupy</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkTransfer" Style="color: Black;" CssClass="borderstyle" Visible="false"
                                                                        runat="server">Transfer</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkVaccate" Style="color: Black;" CssClass="borderstyle" Visible="false"
                                                                        runat="server">Vacate</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkCancel" Style="color: Black;" CssClass="borderstyle" Visible="false"
                                                                        runat="server">Cancel</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkSchedule" Style="color: Black;" CssClass="borderstyle" Visible="false"
                                                                        runat="server">Schedules</asp:LinkButton>
                                                                </div>
                                                            </asp:Panel>
                                                        </td>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </tr> </table>
                                                    </FooterTemplate>
                                                </asp:DataList>
                                            </td>
                                            <td id="tdEmptyList" runat="server" visible="false">
                                                <asp:Label ID="lblEmptyMsg" runat="server" Text="No Such Rooms Found."></asp:Label>
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
