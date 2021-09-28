<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhyBookedSchedule.ascx.cs"
    Inherits="CommonControls_PhyBookedSchedule" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .fontstyle
    {
        font-family: Verdana, Geneva, sans-serif;
        font-size: 8.5pt;
    }
</style>
<asp:Repeater ID="rptSchedules" runat="server">
    <HeaderTemplate>
        <asp:Label ID="lblWarning" runat="server" CssClass="errorbox" Text="Caution : Deleting/Modifying the Schedule may delete all the previous bookings related to the schedule." />
        &nbsp;<br />
        <div style="color: #02358A; font-size: 10pt; font-family: Verdana;">
            <asp:Label ID="Rs_PreviousSchedules" Text="Previous Schedules" runat="server" />
        </div>
        <table class="a-center w-100p" style="border:1px solid #777755;">
            <tr class="evenforsurg a-center" style="border:1px solid #777755;">
                <th rowspan="3" class="a-center" scope="col">
                    <span class="fontstyle"></span>
                </th>
                <th rowspan="3" class="a-center" scope="col">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Start_Date" runat="server" Text="Start Date"></asp:Label></span>
                </th>
                <th colspan="2" rowspan="2" class="a-center" scope="col">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Timing" runat="server" Text="Timing"></asp:Label></span>
                </th>
                <th rowspan="3" class="a-center" scope="col">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Duration" runat="server" Text="Duration in (Mins)"></asp:Label></span>
                </th>
                <th colspan="13" class="a-center" scope="col">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Repeats" runat="server" Text="Repeats"></asp:Label></span>
                </th>
                <th colspan="14" rowspan="3" align="center" scope="col">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Location" runat="server" Text="Location"></asp:Label></span>
                </th>
            </tr>
            <tr class="a-center" style="background-color: #07ABE9; border: 1px solid #777755;">
                <td colspan="2" class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Year" runat="server" Text="Year"></asp:Label></span>
                </td>
                <td colspan="3" class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Month" runat="server" Text="Month"></asp:Label></span>
                </td>
                <td align="center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Week" runat="server" Text="Week"></asp:Label></span>
                </td>
                <td colspan="7" class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Week_Days" runat="server" Text="Week Days"></asp:Label></span>
                </td>
            </tr>
            <tr class="a-center" style="background-color: #07ABE9; border: 1px solid #777755;">
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_From" runat="server" Text="From"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_To" runat="server" Text="To"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Every" runat="server" Text="Every"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_DayMonth" runat="server" Text="Day/Month"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Every1" runat="server" Text="Every"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Day_Month1" runat="server" Text="Day of Month"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Week1" runat="server" Text="Week"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Every2" runat="server" Text="Every"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Sun1" runat="server" Text="Sun"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Mon1" runat="server" Text="Mon"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Tue1" runat="server" Text="Tue"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Wed1" runat="server" Text="Wed"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Thu1" runat="server" Text="Thu"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Fri1" runat="server" Text="Fri"></asp:Label></span>
                </td>
                <td class="a-center">
                    <span class="fontstyle">
                        <asp:Label ID="Rs_Sat1" runat="server" Text="Sat"></asp:Label></span>
                </td>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr style="background-color: #ddffff; border: 1px solid #777755;" class="a-center">
            <td>
                <span class="fontstyle">
                    <asp:LinkButton ID="lnkSelect" runat="server" Style="color: #3333FF; text-decoration: underline;"
                        Text="Edit" OnClientClick="<%# rptSchdeules_ItemdataBound() %>"></asp:LinkButton>
                    /
                    <asp:LinkButton ID="lnkDelete" runat="server" Style="color: #3333FF; text-decoration: underline;"
                        Text="Delete" OnClientClick="<%# rptDelete_ItemdataBound() %>"></asp:LinkButton>
                </span>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("NextOccurance","{0:dd/MM/yyyy}") %>'></asp:Label>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblFrom" runat="server" Text='<%# Eval("StartTime","{0:hh:mm tt}") %>'></asp:Label>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblTo" runat="server" Text='<%# Eval("EndTime","{0:hh:mm tt}") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("SlotDuration") %>'></asp:Label>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblyEvery" runat="server" Text='<%# Eval("yEvery") %>'></asp:Label>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblyDate" runat="server" Text='<%# Eval("yDateMonth") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblmEvery" runat="server" Text='<%# Eval("mEvery") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblmDayofMonth" runat="server" Text='<%# Eval("mDayofMonth") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblmDayofWeek" runat="server" Text='<%# Eval("mDayofWeek") %>'></asp:Label>
            </td>
            <td class="fontstyle" style="background-color: #AAEEFF;">
                <asp:Label ID="lblwEvery" runat="server" Text='<%# Eval("wEvery") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblSunday" runat="server" Text='<%# Eval("Sunday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblMonday" runat="server" Text='<%# Eval("Monday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblTuesday" runat="server" Text='<%# Eval("Tuesday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblWednesday" runat="server" Text='<%# Eval("Wednesday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblThursday" runat="server" Text='<%# Eval("Thursday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblFriday" runat="server" Text='<%# Eval("Friday") %>'></asp:Label>
            </td>
            <td class="fontstyle">
                <asp:Label ID="lblSaturday" runat="server" Text='<%# Eval("Saturday") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblRTID" runat="server" Text='<%# Eval("ResourceTemplateID") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblSTID" runat="server" Text='<%# Eval("ScheduleTemplateID") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblRID" runat="server" Text='<%# Eval("ResourceID") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblRECID" runat="server" Text='<%# Eval("RecurrenceID") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblPRCID" runat="server" Text='<%# Eval("ParentRecurrenceCycleID") %>'></asp:Label>
            </td>
            <td style="display: none;">
                <asp:Label ID="lblRCID" runat="server" Text='<%# Eval("RecurrenceCycleID") %>'></asp:Label>
            </td>
            <td style="background-color: #AAEEFF;">
                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("LocationName") %>'></asp:Label>
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
