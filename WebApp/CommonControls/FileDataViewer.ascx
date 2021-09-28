<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FileDataViewer.ascx.cs"
    Inherits="CommonControls_FileDataViewer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="PdfViewer" Namespace="PdfViewer" TagPrefix="cc1" %>
<asp:UpdatePanel runat="server" ID="updatepnl1">
    <ContentTemplate>
        <table border="0">
            <tr>
                <td>
                    <asp:Panel ID="pnlMain" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="pnlMainResource1">
                        <table width="100%" border="0">
                            <tr>
                                <td style="width: 15%;">
                                    &nbsp;
                                </td>
                                <td align="center" style="font-weight: bold; width: 25%" nowrap="nowrap;">
                                    <asp:Label ID="Rs_SelectImagetoview" runat="server" Text="Select Image to view :"
                                        meta:resourcekey="Rs_SelectImagetoviewResource1"></asp:Label>
                                </td>
                                <td style="font-weight: normal; width: 10%">
                                    <asp:DropDownList CssClass="ddlTheme" runat="server" ID="ddImageList" meta:resourcekey="ddImageListResource1">
                                    </asp:DropDownList>
                                </td>
                                <td style="font-weight: normal; width: 15%">
                                    <asp:Button class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        runat="server" ID="btnGo" Text="Show" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                </td>
                                <td align="center" nowrap="nowrap" style="font-weight: bold; width: 15%">
                                    <asp:Button class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        runat="server" ID="btnPrev" Text="Prev" OnClick="btnPrev_Click" meta:resourcekey="btnPrevResource1" />
                                    <asp:Button class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        runat="server" ID="btnNext" Text="Next" OnClick="btnNext_Click" meta:resourcekey="btnNextResource1" />
                                </td>
                                <td style="width: 20%;">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="hdnfileCnt" runat="server" Visible="False" meta:resourcekey="hdnfileCntResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel runat="server" CssClass="dataheader2" ID="pnlNoData" meta:resourcekey="pnlNoDataResource1">
                        <table width="650px">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="Rs_info" runat="server" Text="No data available for this visit" meta:resourcekey="LabelResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel1Resource1">
                        <cc1:ShowPdf ID="viewData" runat="server" BackColor="WhiteSmoke" Width="642px" BorderWidth="0px"
                            BorderStyle="None" Height="352px" meta:resourcekey="viewDataResource1" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
