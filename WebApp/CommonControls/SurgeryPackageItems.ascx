<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryPackageItems.ascx.cs"
    Inherits="CommonControls_SurgeryPackageItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <asp:GridView ID="gvSurgeryPkg" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                AutoGenerateColumns="False" DataKeyNames="PackageID" ForeColor="#333333" HorizontalAlign="Left"
                OnRowDataBound="gvSurgeryPkg_RowDataBound" OnRowCommand="gvSurgeryPkg_RowCommand"
                OnPageIndexChanging="gvSurgeryPkg_PageIndexChanging" meta:resourcekey="gvSurgeryPkgResource1">
                <Columns>
                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkIDSelected" runat="server" />
                            <%--meta:resourcekey="chkIDSelectedResource1"--%>
                            <asp:Label ID="lblPackageID" runat="server" Visible="False" Text='<%# Eval("PackageID") %>'> <%--meta:resourcekey="lblPackageIDResource1"--%></asp:Label>
                            <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server" Visible="False"><%--meta:resourcekey="lblAmountResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Package Name" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:Label ID="lblPackageName" Text='<%# Eval("PackageName") %>' runat="server" Width="74px"> <%--meta:resourcekey="lblPackageNameResource1"--%></asp:Label>
                            <asp:TextBox runat="server" ID="txtFromDate" MaxLength="25" Width="120px" Visible="False"> <%--meta:resourcekey="txtFromDateResource1"--%></asp:TextBox>
                            <asp:TextBox runat="server" ID="txtToDate" MaxLength="25" Width="120px" Visible="False"> <%--meta:resourcekey="txtToDateResource1"--%></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="From Date" Visible="false">
                    <ItemTemplate>
                        <asp:TextBox runat="server" ID="txtFromDate" MaxLength="25"  Width="120px"> </asp:TextBox>
                        <asp:LinkButton
                            ID="lbtnFromDate"  runat="server"><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                    <%-- <asp:TemplateField HeaderText="To date" Visible="false">
                    <ItemTemplate>
                        <asp:TextBox runat="server" ID="txtToDate" MaxLength="25"  Width="120px"> </asp:TextBox><asp:LinkButton
                            ID="lbtnToDate" runat="server"><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Package Days" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblPkgDays" Text='<%# Eval("PackageDays") %>' runat="server" Width="74px"> <%--meta:resourcekey="lblPkgDaysResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                CommandName="OView" Text="View" CssClass="btn" />
                            <%--meta:resourcekey="btnViewResource1"--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlPkg" runat="server" CssClass="modalPopup dataheaderPopup" Width="24%"
                Style="display: none" meta:resourcekey="pnlPkgResource1">
                <div style="overflow: auto;">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:GridView ID="gvPackageDetailsSPI" runat="server" runat="server" Width="100%"
                                    CellPadding="4" CssClass="mytable1" AutoGenerateColumns="False" ForeColor="#333333"
                                    HorizontalAlign="Left">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Package Item Name" meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemNameSPI" Text='<%# Eval("ItemName") %>' runat="server" Width="74px"> <%--meta:resourcekey="lblItemNameSPIResource1"--%></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Package Quantity" meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPkgQtySPI" Text='<%# Eval("PkgQuantity") %>' runat="server" Width="74px"> <%--meta:resourcekey="lblPkgQtySPIResource1"--%></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="BtnCloseSPI" runat="server" OnClick="BtnCloseSPI_Click" Text="OK"
                                    CssClass="btn" meta:resourcekey="BtnCloseSPIResource1" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asd:ModalPopupExtender ID="ModelPopUpSPI" runat="server" TargetControlID="btn" PopupControlID="pnlPkg"
                BackgroundCssClass="modalBackground" OkControlID="BtnCloseSPI" DynamicServicePath=""
                Enabled="True" />
            <input type="button" id="btn" runat="server" style="display: none;" />
        </td>
    </tr>
</table>
