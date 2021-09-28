<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MRDSnapShotView.ascx.cs"
    Inherits="CommonControls_MRDSnapShotView" %>
<style type="text/css">
    </style>
<table style="border: solid 1px white; width: 250px;" class="roomsMRD">
    <tr style="height: 25px;" align="center" class="floorMRD">
        <td colspan="3" align="center">
            <asp:Label ID="Rs_MRDSnapShotViewToday" runat="server" Text="MRD SnapShot View (Today)"
                meta:resourcekey="Rs_MRDSnapShotViewTodayResource1"></asp:Label>
        </td>
    </tr>
    <tr style="height: 2px;">
        <td colspan="3">
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_ActiveIPList" runat="server" Text="Active IP List" meta:resourcekey="Rs_ActiveIPListResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="ActiveIPList" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="ActiveIPList_Click" meta:resourcekey="ActiveIPListResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_TodaysOP" runat="server" Text="Todays OP" meta:resourcekey="Rs_TodaysOPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="TodaysOP" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="TodaysOP_Click" meta:resourcekey="TodaysOPResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_TodaysSurgery" runat="server" Text="Today's Surgery" meta:resourcekey="Rs_TodaysSurgeryResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="TodaysSurgery" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="TodaysSurgery_Click" meta:resourcekey="TodaysSurgeryResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_LabStatisticsOP" runat="server" Text="Lab Statistics(OP)" meta:resourcekey="Rs_LabStatisticsOPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="LabStatisticsOP" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="LabStatisticsOP_Click" meta:resourcekey="LabStatisticsOPResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="LabStatisticsIP1" runat="server" Text="Lab Statistics(IP)" meta:resourcekey="LabStatisticsIP1Resource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="LabStatisticsIP" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="LabStatisticsIP_Click" meta:resourcekey="LabStatisticsIPResource1"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_LabStatisticsOPandIP" runat="server" Text="Lab Statistics(OP and IP)"
                meta:resourcekey="Rs_LabStatisticsOPandIPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="LabStatisticsOPIP" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="LabStatisticsOPIP_Click" meta:resourcekey="LabStatisticsOPIPResource1"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_ImagingStatisticsOP" runat="server" Text="Imaging Statistics(OP)"
                meta:resourcekey="Rs_ImagingStatisticsOPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="ImagingStatisticsOP" ForeColor="White" Font-Underline="False"
                runat="server" OnClick="ImagingStatisticsOP_Click" meta:resourcekey="ImagingStatisticsOPResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_ImagingStatisticsIP" runat="server" Text="Imaging Statistics(IP)"
                meta:resourcekey="Rs_ImagingStatisticsIPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="ImagingStatisticsIP" ForeColor="White" Font-Underline="False"
                runat="server" OnClick="ImagingStatisticsIP_Click" meta:resourcekey="ImagingStatisticsIPResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_ImagingStatisticsOPIP" runat="server" Text="Imaging Statistics(OP and IP)"
                meta:resourcekey="Rs_ImagingStatisticsOPIPResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="ImagingStatisticsOPIP" ForeColor="White" Font-Underline="False"
                runat="server" OnClick="ImagingStatisticsOPIP_Click" meta:resourcekey="ImagingStatisticsOPIPResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_DeliveryStatistics" runat="server" Text="Delivery Statistics" meta:resourcekey="Rs_DeliveryStatisticsResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="DeliveryStatistics" ForeColor="White" Font-Underline="False"
                runat="server" OnClick="DeliveryStatistics_Click" meta:resourcekey="DeliveryStatisticsResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_DischargeList" runat="server" Text="Discharge List" meta:resourcekey="Rs_DischargeListResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="DischargeList" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="DischargeList_Click" meta:resourcekey="DischargeListResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White; display: none;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_InfectiousDisease" runat="server" Text="Infectious Disease" meta:resourcekey="Rs_InfectiousDiseaseResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="InfectiousDisease" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="InfectiousDisease_Click" meta:resourcekey="InfectiousDiseaseResource2"></asp:LinkButton>
        </td>
    </tr>
    <tr style="height: 25px; border-color: Silver; border-width: 1px; color: White; display: none;">
        <td style="width: 160px;" align="left">
            <asp:Label ID="Rs_NotifiableDisease" runat="server" Text="Notifiable Disease" meta:resourcekey="Rs_NotifiableDiseaseResource1"></asp:Label>
        </td>
        <td style="width: 10px;">
            :
        </td>
        <td style="width: 80px;">
            <asp:LinkButton ID="NotifiableDisease" ForeColor="White" Font-Underline="False" runat="server"
                OnClick="NotifiableDisease_Click" meta:resourcekey="NotifiableDiseaseResource2"></asp:LinkButton>
        </td>
    </tr>
</table>
