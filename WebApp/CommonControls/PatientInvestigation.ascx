<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientInvestigation.ascx.cs" Inherits="CommonControls_PatientInvestigation" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<div style="width: 243px;" onload="loadImg()" id="divContent">

    <asp:GridView ID="gvInvestigation" runat="server" AllowPaging="True" OnPageIndexChanging="gvInvestigation_PageIndexChanging"
        PageSize="3" Height="48px" Width="239px" CaptionAlign="Top"  onrowdatabound="gvInvestigation_RowDataBound" 
        OnSelectedIndexChanged="gvInvestigation_SelectedIndexChanged" HorizontalAlign="Left"
        GridLines="Horizontal" BackColor="#D1EDFF" RowStyle-BorderColor="Black" 
        RowStyle-BorderStyle="Dotted" AutoGenerateColumns="False" 
        onrowcommand="gvInvestigation_RowCommand" 
        meta:resourcekey="gvInvestigationResource1">
        <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"
            NextPageImageUrl="~/Images/nextimage.png" PreviousPageImageUrl="~/Images/previousimage.png" />
        <RowStyle BackColor="#E0E6FC" ForeColor="Black" Height="16px" HorizontalAlign="Left"
            VerticalAlign="Top" BorderStyle="Double" BorderColor="Red" BorderWidth="1" />
        <PagerTemplate>
            <asp:ImageButton ImageUrl="~/Images/nextimage.png" runat="server" ID="btnNxt" CommandName="Page"
                CommandArgument="Next" ImageAlign="Right" 
                meta:resourcekey="btnNxtResource1" />
            <asp:ImageButton ImageUrl="~/Images/previousimage.png" runat="server" ID="btnPre" CommandName="Page"
                CommandArgument="Prev" ImageAlign="Right" 
                meta:resourcekey="btnPreResource1" />
        </PagerTemplate>
        <PagerStyle ForeColor="#993333" HorizontalAlign="Center" VerticalAlign="Top" Wrap="False" />
        <HeaderStyle Wrap="true" CssClass="grdcolor" BorderStyle="Outset" 
            Height="15px" HorizontalAlign="Left" VerticalAlign="Top" Width="30px" />
        <FooterStyle CssClass="gridFooterStyle" />
        <Columns>
            <asp:CommandField ShowSelectButton="false" 
                meta:resourcekey="CommandFieldResource1">
                <HeaderStyle></HeaderStyle>
                <ItemStyle></ItemStyle>
            </asp:CommandField>
             <%--<asp:BoundField DataField="InvestigationName" HeaderText="InvestigationName" />
            <asp:BoundField DataField="InvestigationValue" HeaderText="InvestigationValue" />--%>
            <asp:TemplateField HeaderText="Investigation" 
                meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/bullet.png" 
                        /><%--meta:resourcekey="Image1Resource1"--%>
                    <asp:Label ID="lblInvestigation" runat="server" 
                        Text='<%# (string)DataBinder.Eval(Container.DataItem,"InvestigationName")+" -- " + DataBinder.Eval(Container.DataItem,"InvestigationValue") %>' 
                       ><%-- meta:resourcekey="lblInvestigationResource1"--%></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:TemplateField HeaderText="FilePath" 
                meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnFilepath" runat="server" Text='<%# Bind("FilePath") %>' 
                        CommandName="Go" ToolTip="Select to view" 
                        ><%--meta:resourcekey="lbtnFilepathResource1"--%></asp:LinkButton>
                </ItemTemplate>
                <ControlStyle ForeColor="Black" />
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
    <div style="background-color: Transparent; text-align: left; padding-left: 50px;  
        padding-top: 20px; font-family: Verdana; font-size: small;">        
        <asp:Label ID="lblName" runat="server" Font-Bold="True" ForeColor="#FF0066" 
            meta:resourcekey="lblNameResource1"></asp:Label>
    </div>
</div>