<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EventChart.ascx.cs" Inherits="Patient_EventChart" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<div id="eventDiv" style="width: 100%;">
    <asp:GridView ID="gvEventChart" runat="server" AllowPaging="True" OnPageIndexChanging="gvEventChart_PageIndexChanging"
        PageSize="4" Width="100%" CaptionAlign="Top" OnRowDataBound="gvEventChart_RowDataBound"
        OnSelectedIndexChanged="gvEventChart_SelectedIndexChanged" HorizontalAlign="Left"
        AutoGenerateColumns="False" BackColor="#D1EDFF" OnRowCommand="gvEventChart_RowCommand"
        RowStyle-BorderColor="Black" RowStyle-BorderStyle="Dotted" 
        meta:resourcekey="gvEventChartResource1">
        <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"
            NextPageImageUrl="~/Images/nextimage.png" PreviousPageImageUrl="~/Images/previousimage.png" />
        <RowStyle BackColor="#d1e5f8" ForeColor="Black" HorizontalAlign="Left"
            VerticalAlign="Top" BorderStyle="Double" BorderColor="Red" BorderWidth="1" Wrap="false" />
        <PagerTemplate>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="20%">
                        <asp:ImageButton ImageUrl="~/Images/nextimage.png" runat="server" ID="btnNxt" CommandName="Page"
                            CommandArgument="Next" ImageAlign="Right" 
                            meta:resourcekey="btnNxtResource1" />
                        <asp:ImageButton ImageUrl="~/Images/previousimage.png" runat="server" ID="btnPre" CommandName="Page"
                            CommandArgument="Prev" ImageAlign="Right" 
                            meta:resourcekey="btnPreResource1" />
                    </td>
                </tr>
            </table>
        </PagerTemplate>
        <PagerStyle ForeColor="#993333" HorizontalAlign="Center" VerticalAlign="Top" Wrap="False" />
        <SelectedRowStyle BackColor="#88C7E1" BorderStyle="None" Font-Bold="True" Font-Italic="False"
            ForeColor="Black" />
        <HeaderStyle Wrap="true" CssClass="Duecolor" BorderStyle="Outset" 
            HorizontalAlign="Left" VerticalAlign="Top" Width="30px" />
        <FooterStyle CssClass="gridFooterStyle" />
        <Columns>
            <asp:TemplateField HeaderText="Options" Visible="false" 
                meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:Label ID="lbl" runat="server" Text="n" meta:resourcekey="lblResource1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VisitID" Visible="false" 
                meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:Label ID="lblVisitID" runat="server" Text='<%# Bind("VisitId") %>' 
                        meta:resourcekey="lblVisitIDResource1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--            <asp:BoundField DataField="VisitId" HeaderText="VisitID" Visible="false"/>--%>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" 
                meta:resourcekey="BoundFieldResource1" />
            <asp:TemplateField HeaderText="Visit Description" 
                meta:resourcekey="TemplateFieldResource3">
                <ItemTemplate>
                    <asp:Label ID="lblEvents" Text='<%# Bind("Events") %>' runat="server" 
                        meta:resourcekey="lblEventsResource1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Physician" HeaderText="Physician" 
                SortExpression="Physician" meta:resourcekey="BoundFieldResource2" />
            <asp:BoundField DataField="VisitNotes" HeaderText="VisitNotes" 
                SortExpression="VisitNotes" meta:resourcekey="BoundFieldResource3" />
              <asp:BoundField DataField="OrganisationName" HeaderText="OrganisationName" 
                SortExpression="OrganisationName" meta:resourcekey="BoundFieldResource4" />
            <asp:TemplateField HeaderText="Options" ItemStyle-Wrap="false" 
                meta:resourcekey="TemplateFieldResource4">
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        meta:resourcekey="DropDownList1Resource1">
                        <asp:ListItem Text="Continue Same Treatment" Value="1" 
                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                        <asp:ListItem Text="Alter Prescription" Value="2" 
                            meta:resourcekey="ListItemResource2"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btndrp" Text="Go" Width="30px"  runat="server" CommandName="Go" 
                        CssClass="btn" onmouseover="this.className='btn btnhov'" 
                        onmouseout="this.className='btn'" meta:resourcekey="btndrpResource1" />
                    <asp:Label ID="lblComplaintID" runat="server" Text='<%# Bind("ComplaintID") %>' 
                        Visible="False" meta:resourcekey="lblComplaintIDResource1"></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="OrgID" HeaderText="OrgID" Visible="false" 
                meta:resourcekey="BoundFieldResource5" />
        </Columns>
    </asp:GridView>
</div>
<div style="background-color: Transparent; text-align: left; padding-left: 50px;
    padding-top: 20px; font-family: Verdana; font-size: small;">
    <asp:Label ID="lblEvent" runat="server" Font-Bold="True" ForeColor="#CC0000" 
        meta:resourcekey="lblEventResource1"></asp:Label>
</div>
