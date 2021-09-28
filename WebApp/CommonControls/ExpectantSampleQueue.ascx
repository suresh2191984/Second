<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ExpectantSampleQueue.ascx.cs"
    Inherits="CommonControls_ExpectantSampleQueue" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
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
<table border="1" id="divabberant" runat="server" style="border-color: Red; background-color: White"
    width="25%">
    <tr class="dataheader1">
        <td align="center">
            <table width="120%">
                <tr align="center">
                    <td align="left" nowrap="nowrap" id="div1">
                        <%--<asp:UpdatePanel ID="Up2" runat="server">
                            <ContentTemplate>--%>
                        <asp:Label ID="lblHeading" Text="Expectant Sample Queue:" Font-Bold="True" runat="server"
                            meta:resourcekey="lblHeadingResource1"></asp:Label>
                        <asp:Label ID="lblLeftBrace" Text='[ ' runat="server" meta:resourcekey="lblLeftBraceResource1"></asp:Label>
                        <asp:LinkButton ID="lblCount" Text='<%# bind("CLCount") %>' Font-Bold="True" runat="server"
                            OnClick="lnkbtn_Click" meta:resourcekey="lblCountResource1"></asp:LinkButton>
                        <asp:Label ID="lblRightBrace" Text=' ]' runat="server" meta:resourcekey="lblRightBraceResource1"></asp:Label>
                        <asp:DropDownList ID="ddlInvSamplesStatus" CssClass="ddlaltrasmall" runat="server"
                            OnSelectedIndexChanged="ddlInvSamplesStatus_OnSelectedIndexChanged" AutoPostBack="True"
                            meta:resourcekey="ddlInvSamplesStatusResource1">
                        </asp:DropDownList>
                        <asp:Panel ID="pnlPatientDet" Width="1050px" Height="350px" runat="server" CssClass="modalPopup dataheaderPopup"
                            Style="display: none" meta:resourcekey="pnlPatientDetResource1">
                            <table width="100%">
                                <tr class="dataheader1">
                                    <td align="left">
                                        <asp:Label runat="server" ID="lblheader" Text="ExpectantSampleQueue" meta:resourcekey="lblheaderResource1" />
                                    </td>
                                    <td align="left">
                                        <div style="float:left;text-align:left;">
                                            <asp:Label runat="server" ID="Label1" Text="Select the Location" meta:resourcekey="Label1Resource1" />
                                            <asp:DropDownList ID="ddlOrganization" runat="server" Width="150px" AutoPostBack="True"
                                                CssClass="ddlTheme" OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged"
                                                meta:resourcekey="ddlOrganizationResource1">
                                            </asp:DropDownList>
                                            <asp:Label runat="server" ID="Label2" Text="Select the Sample" meta:resourcekey="Label2Resource1" />
                                            <asp:DropDownList CssClass="ddl" Width="130px" ID="ddlSample" runat="server" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlSample_SelectedIndexChanged" meta:resourcekey="ddlSampleResource1">
                                            </asp:DropDownList>
                                        </div>
                                        <div style="text-align:right;">
                                            <asp:Label runat="server" ID="lblsanplecount"></asp:Label>
                                            <asp:CheckBox ID="chkdelay" OnCheckedChanged="chkdelay_CheckedChanged" AutoPostBack="true"
                                                runat="server" />
                                            <asp:Label runat="server" ID="lbldelay" Text=" Delay" meta:resourcekey="Label3Resource1" />
                                        </div>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" colspan="2">
                                        <asp:GridView ID="grdSample" runat="server" AutoGenerateColumns="False" Height="12%"
                                            DataKeyNames="PatientVisitID,SampleID,gUID,InvestigationID" Style="margin-left: 0px"
                                            Width="100%" AllowPaging="True" PageSize="10" OnPageIndexChanging="grdSample_PageIndexChanging"
                                            EmptyDataText="No Matching Records found" OnRowDataBound="grdSample_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Visit No" meta:resourcekey="VisitNoResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblvisitid" runat="server" Text='<%# bind("VisitNumber") %>' meta:resourcekey="lblvisitidResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ControlStyle Width="15%" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="PatientNameResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPatientName" runat="server" Text='<%# bind("PatientName") %>' meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ControlStyle Width="25%" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sample" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSample" runat="server" Text='<%# bind("SampleDesc") %>' meta:resourcekey="lblSampleResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ControlStyle Width="20%" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Container" meta:resourcekey="ContainerResource4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAdditive" runat="server" Text='<%# bind("SampleContainerName") %>'
                                                            meta:resourcekey="lblAdditiveResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <%-- <asp:TemplateField HeaderText="Status" 
                                                            meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSampleStatus" runat="server" 
                                                                    Text='<%# bind("InvSampleStatusDesc") %>' 
                                                                    meta:resourcekey="lblSampleStatusResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnInvSampleStatusID" runat="server" 
                                                                    Value='<%# bind("InvSampleStatusID") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Barcode No" meta:resourcekey="BarcodeNoResource6">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBarcode" runat="server" Text='<%# bind("BarcodeNumber") %>' meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Dept" meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDepartment" runat="server" Text='<%# bind("DeptName") %>' meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField Visible="False" HeaderText="Test Name" meta:resourcekey="TemplateFieldResource8">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTestName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                            meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CreatedAt" HeaderText="Collected Dt/Time" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    meta:resourcekey="CollectedResource1">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Reg. Location" meta:resourcekey="TemplateFieldResource9">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbllocation" runat="server" Text='<%# bind("LocationName") %>' meta:resourcekey="lbllocationResource1"></asp:Label>
                                                        <asp:Label ID="lblDelayTime" runat="server" Text='<%# bind("DelayTime") %>' Style="display: none;"
                                                            meta:resourcekey="lbllocationResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExpectedTime" HeaderText=" Sample ExpectedTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    meta:resourcekey="CollectedResource1">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DelayTime" HeaderText="Delay Time" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    meta:resourcekey="CollectedResource1">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                            </Columns>
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" VerticalAlign="Middle"
                                                Width="14px" ForeColor="Black" />
                                            <HeaderStyle CssClass="dataheader1" Width="14px" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td colspan="2">
                                        <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="70px" meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="mpePatternSelection" runat="server" TargetControlID="hiddenTargetControlForModalPopup1"
                            PopupControlID="pnlPatientDet" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
                            DynamicServicePath="" Enabled="True" />
                        <asp:Button ID="hiddenTargetControlForModalPopup1" runat="server" Style="display: none"
                            meta:resourcekey="hiddenTargetControlForModalPopup1Resource1" />
                        <%--</ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlInvSamplesStatus" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="lblCount" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlOrganization" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddlSample" EventName="SelectedIndexChanged" />
                                
                               
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<ajc:AlwaysVisibleControlExtender ID="ace" runat="server" TargetControlID="divabberant"
    VerticalOffset="100" HorizontalSide="Right" Enabled="True" />
