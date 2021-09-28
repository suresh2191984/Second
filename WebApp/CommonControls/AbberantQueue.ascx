<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AbberantQueue.ascx.cs"
    Inherits="CommonControls_AbberantQueue" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    .ddlaltrasmall
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 19px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        width: 100px;
    }
</style>
<table id="divabberant" runat="server" style="border-color: Red; background-color: White;z-index:99;">
    <tr class="dataheader1">
        <td class="a-center">
            <table class="w-100p">
                <tr class="a-center">
                    <td class="a-center" nowrap="nowrap" onmouseover="ShowDivs();">
                        <asp:Label ID="Label5" Text="Queue" Font-Bold="True" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                    </td>
                    <td class="a-right" nowrap="nowrap" id="div11" style="display: none">
                        <asp:UpdatePanel ID="Up2" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlInvSamplesStatus" onchange="javascript:ShowDivs();" CssClass="ddlaltrasmall"
                                runat="server" OnSelectedIndexChanged="ddlInvSamplesStatus_OnSelectedIndexChanged"
                                AutoPostBack="True" meta:resourcekey="ddlInvSamplesStatusResource1">
                                </asp:DropDownList>
                                <%--<asp:Timer runat="server" id="UpdateTimer" interval="60000" ontick="UpdateTimer_Tick" />--%>
                            </ContentTemplate>
                            <%--<Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlInvSamplesStatus" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger controlid="UpdateTimer" eventname="Tick" />
                            </Triggers>--%>
                           </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="a-center">
        <div  id="div22" style="display: none">
            <table>
                <tr>
                    <td class="a-left">
                        <asp:GridView ID="grdresult" CssClass="w-100p gridView" runat="server" ForeColor="Black" CellPadding="1"
                            AutoGenerateColumns="False" Style="margin-top: 0px" OnRowCreated="grdresult_RowCreated1"
                            OnRowDataBound="grdresult_RowDataBound" EmptyDataRowStyle-CssClass="dataheader1"
                            EmptyDataText="No Matching Records Found" 
                            meta:resourcekey="grdresultResource1">
                            <HeaderStyle CssClass="dataheader1" />
<EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="Status" 
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                            <asp:Label runat="server" ID="lblstatus" Text='<%# bind("Status") %>' Style="display: none;"
                                                meta:resourcekey="lblstatusResource1"></asp:Label>
                                            <asp:Label runat="server" ID="lblDisplayStatus" Text='<%# bind("DisplayStatus") %>'
                                                meta:resourcekey="lblDisplayStatusResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="70px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Current Location" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="linkCL" runat="server" Font-Underline="True" 
                                            ForeColor="Red" Font-Bold="True" Text='<%# bind("CLCount") %>' 
                                            meta:resourcekey="linkCLResource1"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="25px"/>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Other Location" 
                                    meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="linkOL" runat="server" Font-Underline="True" 
                                            ForeColor="Red" Font-Bold="True" Text='<%# bind("OLCount") %>' 
                                            meta:resourcekey="linkOLResource1"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <%--<asp:Label runat="server" ID="lbldesc" ForeColor="Red" Font-Size="Smaller" Text="* To Hide,Double Click Here"></asp:Label>--%>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td  id="div33" style="display:none">
                        <img id="Img1" src="~/Images/collapse_blue.jpg" style="size:3px" title="Click to hide AbberentQueue" runat="server" onclick="HideDivs()" meta:resourcekey="Img1Resource1" />
                    </td>
                </tr>
            </table>
            </div>
        </td>
    </tr>
</table>

<script type="text/javascript" language="javascript">
    function ShowDivs() {
        $("#div11").show();
        $("#div22").show("slow");
        $("#div33").show("slow");
        $('[id$="divabberant"]').css({ "position": "fixed", "top": "100px", "left": "1000px" });
        $("#div11").show();
//        $('[id$="divabberant"]').draggable();
    }
    function HideDivs() {
        $("#div11").hide();
        $("#div22").hide("slow");
        $("#div33").hide("slow");
        $('[id$="divabberant"]').css({ "position": "absolute", "top": "100px", "right": "1000px" });
    }
</script>

