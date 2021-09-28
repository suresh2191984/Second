<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RevenueDisplay.ascx.cs"
    Inherits="CommonControls_RevenueDisplay" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
<asp:UpdateProgress ID="updateProg1" runat="server" AssociatedUpdatePanelID="updatePanel1"
    DynamicLayout="true" DisplayAfter="1000">
    <ProgressTemplate>
        <asp:Image runat="server" ID="imgUpdate" ImageUrl="~/Images/ajax-loader.gif" />
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div style=" vertical-align:top;width:100%;">
             
            <asp:Chart ID="Chart1" runat="server" BackColor="Transparent"  Width="225px">
                <Series>
                    <asp:Series Name="Series1">
                    </asp:Series>
                   
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BackColor="Transparent">
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Name="legends1" >
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            <asp:Chart ID="Chart2" runat="server" BackColor="Transparent" Width="225px">
                <Series>
                    <asp:Series Name="Series2">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea2" BackColor="Transparent">
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Name="legends2">
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            
            <asp:Label ID="lblType" runat="server" Visible="false" ></asp:Label>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

