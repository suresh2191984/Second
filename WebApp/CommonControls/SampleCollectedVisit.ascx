<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SampleCollectedVisit.ascx.cs"
    Inherits="CommonControls_SampleCollected" %>
<%--
<script src="../Scripts_New/Common.js" type="text/javascript"></script>

<script src="../Scripts_New/bid.js" type="text/javascript"></script>--%>

<table class="w-100p">
    <tr>
        <td>
            <div id="deptBlock" runat="server" style="display: none;">
                <table class="w-100p">
                    <tr>
                        <td class="a-left h-23">
                            <div id="ACXdplus1" style="display: none;">
                                <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACXdplus1','ACXdminus1','ACX2responsess6',1);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXdplus1','ACXdminus1','ACX2responsess6',1);">
                                    <asp:Label ID="Rs_Departmentforwhich" Text="Department for which the Samples has to be sent"
                                        runat="server" meta:resourcekey="Rs_DepartmentforwhichResource1" />
                                </span>
                            </div>
                            <div id="ACXdminus1" style="display: block;">
                                <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                    style="cursor: pointer" onclick="showResponses('ACXdplus1','ACXdminus1','ACX2responsess6',0);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXdplus1','ACXdminus1','ACX2responsess6',0);">
                                    <asp:Label ID="Rs1_Departmentforwhich" Text="Department for which the Samples has to be sent"
                                        runat="server" meta:resourcekey="Rs1_DepartmentforwhichResource1" /></span>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responsess6" style="display: block;">
                        <td colspan="2">
                            <asp:Label ID="lblDeptStatus" runat="server" Font-Size="Medium" Font-Bold="True"
                                Text="No Departments Found!" Visible="False" meta:resourcekey="lblDeptStatusResource1"></asp:Label>
                            <div class="dataheader2">
                                <asp:DataList ID="dlDeptName" runat="server" class="w-100p" RepeatColumns="3" ItemStyle-Wrap="true"
                                    RepeatDirection="Horizontal" meta:resourcekey="dlDeptNameResource1">
                                    <ItemStyle Wrap="True"></ItemStyle>
                                    <HeaderTemplate>
                                        <table class="w-100p">
                                            <tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <td class="v-top a-left h20 w-30p" style="border-style: solid; border-collapse: collapse;">
                                            <img src="../Images/bullet.png" alt="" align="middle" />
                                            &nbsp;
                                            <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                        </td>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tr> </table>
                                    </FooterTemplate>
                                </asp:DataList>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="h-23 a-left">
            <div id="ACX2plus3" style="display: block;">
                <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                    onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',1);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',1);">
                    <asp:Label ID="Rs_Samples" runat="server" Text="Samples Collected For Current Visit"
                        meta:resourcekey="Rs_SamplesResource1"></asp:Label></span>
            </div>
            <div id="ACX2minus4" style="display: none;">
                <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                    style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',0);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',1);">
                    &nbsp;<asp:Label ID="Rs_Samples1" runat="server" Text="Samples Collected For Current Visit"
                        meta:resourcekey="Rs_Samples1Resource1"></asp:Label></span>
            </div>
        </td>
    </tr>
    <tr class="tablerow" id="ACX2responsess4" style="display: none;">
        <td class="w-100p">
            <asp:Panel ID="pnlSampleListlbl" CssClass="dataheader2" BorderWidth="1px" runat="server"
                meta:resourcekey="pnlSampleListlblResource1" Style="display: block;">
                <table class="w-100p" cellpadding="5">
                    <tr>
                        <td class="w-100p">
                            <asp:Label ID="lblStatus" runat="server" class="font12" Font-Bold="False" Visible="False"
                                meta:resourcekey="lblStatusResource1">&nbsp;<asp:Label ID="Rs_NoSamples" runat="server"
                                    Text="( No Samples collected for Current Visit )" meta:resourcekey="Rs_NoSamplesResource1"></asp:Label>
                            </asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlSampleList" CssClass="dataheader2 searchPanel" BorderWidth="1px" Visible="False"
                runat="server" meta:resourcekey="pnlSampleListResource1" Style="display: block;">
                <table cellpadding="4" class="w-100p">
                    <tr class="bold">
                        <td style="font-weight: normal; color: #fff;" class="Duecolor a-left w-20p h-8">
                            <asp:Label ID="Rs_Sample" Text="Sample" Font-Bold="True" runat="server" meta:resourcekey="Rs_SampleResource1" />
                        </td>
                        <td style="font-weight: normal; height: 8px; color: #fff;" class="Duecolor w-20p a-left h-8">
                            <asp:Label ID="Rs_Additive" Text="Additive" Font-Bold="True" runat="server" meta:resourcekey="Rs_AdditiveResource1" />
                        </td>
                        <td style="font-weight: normal; color: #fff;" class="Duecolor w-20p a-left h-8">
                            <asp:Label ID="Rs_BarcodeLabel" Text="Barcode / Label" Font-Bold="True" runat="server"
                                meta:resourcekey="Rs_BarcodeLabelResource1" />
                        </td>
                        <td style="font-weight: normal; color: #fff;" class="Duecolor w-20p a-left h-8">
                            <asp:Label ID="Rs_Status" Text="Status" Font-Bold="True" runat="server" meta:resourcekey="Rs_StatusResource1" />
                        </td>
                        <td style="font-weight: normal; color: #fff; display: none" class="Duecolor a-left w-1p h-8">
                            <asp:Label ID="Rs_Department" Text="Department" Font-Bold="True" runat="server" meta:resourcekey="Rs_DepartmentResource1" />
                        </td>
                        <td style="font-weight: normal; color: #fff;" class="Duecolor w-20p a-left h-8">
                            <asp:Label ID="Rs_CollectedTime" Text="Collected Time" Font-Bold="True" runat="server"
                                meta:resourcekey="Rs_CollectedTimeResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="h-10 a-left " colspan="6" style="font-weight: normal; color: #000;">
                            <asp:DataList ID="dtSample" runat="server" class="w-100p" meta:resourcekey="dtSampleResource1">
                                <ItemTemplate>
                                    <table class="w-100p">
                                        <tr>
                                            <td class="h-5 w-20p a-left" style="font-weight: normal; color: #000;">
                                                <%# DataBinder.Eval(Container.DataItem, "SampleDesc")%>
                                            </td>
                                            <td class="h-5 a-left w-20p" style="font-weight: normal; color: #000;">
                                                <%# DataBinder.Eval(Container.DataItem, "SampleContainerName")%>
                                            </td>
                                            <td class="h-5 w-20p a-left" style="font-weight: normal; color: #000;">
                                                <%# DataBinder.Eval(Container.DataItem, "BarcodeNumber")%>
                                            </td>
                                            <td class="w-20p a-left h-5" style="font-weight: normal; color: #000;">
                                                <%# DataBinder.Eval(Container.DataItem, "InvSampleStatusDesc")%>
                                            </td>
                                            <td class="w-1p h-5 a-left" style="font-weight: normal; color: #000; display: none">
                                                <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                            </td>
                                            <td class="w-20p a-left h-5" style="font-weight: normal; color: #000;">
                                                <%# DataBinder.Eval(Container.DataItem, "CreatedAt","{0:dd/MM/yyyy hh:mm tt}")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
