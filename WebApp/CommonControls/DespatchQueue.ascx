<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DespatchQueue.ascx.cs"
    Inherits="CommonControls_DespatchQueue" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<%--<script type="text/javascript" src="../Scripts/jquery-1.4.1.js"></script> --%>
<%--
<script type="text/javascript" src="../Scripts_New/ScrollableGridPlugin.js"></script>

<%-- <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>--%>
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
    .header
    {
        position: absolute;
    }
</style>
<asp:UpdatePanel ID="Up2" runat="server">
    <ContentTemplate>
        <table id="divabberant" runat="server" style="border-color: Red; background-color: White">
            <tr class="dataheader1">
                <td class="a-center">
                    <table class="w-100p">
                        <tr class="a-center">
                            <td class="a-center" nowrap="nowrap" onmouseover="ShowDiv();">
                                <asp:Label ID="Label5" Text="DisPatchQueue" Font-Bold="True" runat="server" meta:resourcekey="Label5Resource1" ></asp:Label>
                            </td>
                            <td class="a-right" nowrap="nowrap" id="div1" style="display: none">
                                <asp:DropDownList ID="ddlInvSamplesStatus" onchange="javascript:ShowDiv();" CssClass="ddlaltrasmall"
                                    runat="server" OnSelectedIndexChanged="ddlInvSamplesStatus_OnSelectedIndexChanged"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                                <%--<asp:Timer runat="server" ID="UpdateTimer" Interval="60000" OnTick="UpdateTimer_Tick" />--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <div id="div2" style="display: none">
                        <table>
                            <tr>
                                <td class="a-center">
                                    <asp:GridView ID="grdresult" runat="server" ForeColor="Black" CssClass="w-100p gridView" CellPadding="1"
                                        AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataRowStyle-CssClass="dataheader1"
                                        EmptyDataText="No Matching Records Found" OnRowCommand="grdResult_RowCommand"
                                        OnRowDataBound="grdresult_RowDataBound">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                        <Columns>
                                            <asp:TemplateField HeaderText="DispatchStatus" meta:resourcekey="TemplateField1Resource1">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblstatus" Text='<%# bind("Status") %>'></asp:Label>
                                                    <asp:HiddenField runat="server" ID="hdnstatusid" Value='<%# bind("StatusID") %>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Count" meta:resourcekey="TemplateField2Resource1">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="linkCL" runat="server" Font-Underline="True" ForeColor="Red"
                                                        OnClientClick=" return validateonoroff();" Font-Bold="True" Text='<%# bind("CLCount") %>'
                                                        CommandName="ShowReports" CommandArgument='<%# Eval("StatusID")%>'>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td id="div3" style="display: none">
                                    <img id="Img1" src="~/Images/collapse_blue.jpg" class="font3" title="Click to hide AbberentQueue"
                                        runat="server" onclick="HideDiv()" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlPatientDet" Width="850px" Height="350px" runat="server" CssClass="modalPopup dataheaderPopup"
                                    Style="display: none" ScrollBars="Auto">
                                    <div>
                                        <table class="w-100p">
                                            <tr class="dataheader1">
                                                <td class="a-left">
                                                    <asp:Label runat="server" ID="lblheader" Text="Dispatch Queue" />
                                                </td>
                                            </tr>
                                            <tr class="a-center">
                                                <td class="a-center" colspan="2">
                                                    <asp:GridView ID="grdSample" runat="server" AutoGenerateColumns="False" Height="12%"
                                                        DataKeyNames="PatientVisitID" CssClass="w-100p marginL0 gridView" AllowPaging="True"
                                                        PageSize="5" EmptyDataText="No Matching Records found" OnRowDataBound="grdSample_RowDataBound"
                                                        OnPageIndexChanging="grdSample_PageIndexChanging">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="PatientVisitID" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblvisitid" runat="server" Text='<%# bind("PatientVisitID") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ControlStyle Width="15%" />
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Patient">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientName" runat="server" Text='<%# bind("PatientName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ControlStyle Width="18%" />
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:GridView ID="gvDescription" Width="100%" GridLines="both" AutoGenerateColumns="False"
                                                                        runat="server">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Name" ItemStyle-Width="16%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="name" Text='<%# Eval("Name") %>' runat="server"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="16%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="status" Text='<%# Eval("Status") %>' runat="server"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" VerticalAlign="Middle"
                                                            Width="14px" ForeColor="Black" />
                                                        <HeaderStyle CssClass="dataheader1" Width="14px" />
                                                    </asp:GridView>
                                                    <asp:HiddenField ID="hdnstatusid" runat="server" Value="1" />
                                                    <asp:HiddenField ID="hdnfromdate" runat="server" />
                                                    <asp:HiddenField ID="hdntodate" runat="server" />
                                                </td>
                                            </tr>
                                            <tr class="a-center">
                                                <td colspan="2">
                                                    <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <ajc:ModalPopupExtender ID="mpeReport" runat="server" TargetControlID="hiddenTargetControlForModalPopup1"
                                    PopupControlID="pnlPatientDet" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
                                    DynamicServicePath="" Enabled="True" />
                                <asp:Button ID="hiddenTargetControlForModalPopup1" runat="server" Style="display: none" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="grdSample" EventName="PageIndexChanging" />
                                 
                                <%--<asp:AsyncPostBackTrigger ControlID="lblCount" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlOrganization" EventN ame="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="grdSample" EventName="RowDataBound" />--%>
                                <%--<asp:PostBackTrigger ControlID="grdSample" />--%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddlInvSamplesStatus" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="grdresult" EventName="RowCommand" />
        <asp:AsyncPostBackTrigger ControlID="grdSample" EventName="PageIndexChanging" />
        <%--<asp:AsyncPostBackTrigger ControlID="UpdateTimer" EventName="Tick" />--%>
        <asp:AsyncPostBackTrigger ControlID="grdSample" EventName="RowDataBound" />
    </Triggers>
</asp:UpdatePanel>
<%--<ajc:AlwaysVisibleControlExtender ID="ace" runat="server" TargetControlID="divabberant"
    VerticalOffset="100" HorizontalSide="Right" Enabled="True" />--%>

<script type="text/javascript" language="javascript">
    function ShowDiv() {

        $("#div1").show();
        $("#div2").show("slow");
        $("#div3").show("slow");
        $('[id$="divabberant"]').css({ "position": "fixed", "top": "100px", "left": "1000px" });
        $("#div1").show();
        //$('[id$="divabberant"]').draggable();
    }
    function HideDiv() {
        $("#div1").hide();
        $("#div2").hide("slow");
        $("#div3").hide("slow");
        $('[id$="divabberant"]').css({ "position": "absolute", "top": "100px", "right": "1000px" });


 }
</script>