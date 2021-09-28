<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LineChartDisplay.ascx.cs"
    Inherits="CommonControls_LineChartDisplay" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<asp:UpdateProgress ID="updateProg1" runat="server" AssociatedUpdatePanelID="updatePanel1"
    DynamicLayout="true" DisplayAfter="1000">
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div style="vertical-align: top; text-align: center; width: 100%;">
            <asp:Chart ID="Chart1" runat="server">
                <series>
                    <asp:Series Name="Series1">
                    </asp:Series>
                   <asp:Series Name="Series2">
                    </asp:Series>
                </series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1" BackColor="Transparent">
                    </asp:ChartArea>
                </chartareas>
                <legends>
                    <asp:Legend Name="legends1" >
                    </asp:Legend>
                </legends>
            </asp:Chart>
            <asp:Label ID="lblType" runat="server" Visible="false"></asp:Label>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
