<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientTreatment.ascx.cs"
    Inherits="CommonControls_PatientTreatment" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<div style="width: 100%; height: 70px" onload="loadImg()" id="divContent">
    <asp:GridView ID="gvTreatment" runat="server" AllowPaging="True" OnPageIndexChanging="gvTreatment_PageIndexChanging"
        PageSize="1" Height="48px" Width="98%" CaptionAlign="Top" OnRowDataBound="gvTreatment_RowDataBound"
        OnSelectedIndexChanged="gvTreatment_SelectedIndexChanged" HorizontalAlign="Left"
        GridLines="Horizontal" BackColor="#D1EDFF" RowStyle-BorderColor="Black" RowStyle-BorderStyle="Dotted"
        meta:resourcekey="gvTreatmentResource1">
        <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"
            NextPageImageUrl="~/Images/nextimage.png" PreviousPageImageUrl="~/Images/previousimage.png" />
        <RowStyle BackColor="#E0E6FC" ForeColor="Black" Height="16px" HorizontalAlign="Left"
            VerticalAlign="Top" BorderStyle="Double" BorderColor="Red" BorderWidth="1" />
        <PagerTemplate>
            <asp:ImageButton ImageUrl="~/Images/nextimage.png" runat="server" ID="btnNxt" CommandName="Page"
                CommandArgument="Next" ImageAlign="Right" meta:resourcekey="btnNxtResource1" />
            <asp:ImageButton ImageUrl="~/Images/previousimage.png" runat="server" ID="btnPre" CommandName="Page"
                CommandArgument="Prev" ImageAlign="Right" meta:resourcekey="btnPreResource1" />
        </PagerTemplate>
        <PagerStyle ForeColor="#993333" HorizontalAlign="Center" VerticalAlign="Top" Wrap="False" />
        <HeaderStyle Wrap="true" CssClass="grdcolor" BorderStyle="Outset" Height="15px" HorizontalAlign="Left"
            VerticalAlign="Top" Width="30px" />
        <FooterStyle CssClass="gridFooterStyle" />
        <Columns>
            <asp:CommandField ShowSelectButton="false" meta:resourcekey="CommandFieldResource1">
                <HeaderStyle></HeaderStyle>
                <ItemStyle></ItemStyle>
            </asp:CommandField>
        </Columns>
    </asp:GridView>
    <div style="background-color: Transparent; text-align: left; padding-left: 50px;
        padding-top: 20px; font-family: Verdana; font-size: small;">
        <asp:Label ID="lblName" runat="server" Font-Bold="True" ForeColor="#CC0000" meta:resourcekey="lblNameResource1"></asp:Label>
    </div>
</div>
