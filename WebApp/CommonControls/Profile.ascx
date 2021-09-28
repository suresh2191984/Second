<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Profile.ascx.cs" Inherits="CommonControls_Profile" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script src="../Scripts/Common.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" >
function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
           
             else 
            {
            alert('Investigation chosen is already selected. Please select a different one');
            return false ;
            }
           return true;
        }
</script>

<asp:UpdatePanel ID="uPanelprofile" runat="server">
    <ContentTemplate>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div id="dprf" runat="server">
                                    <div id="pVisibleDiv" onclick="showProfile()" class="invprofile" style="background-image: url(../Images/investigation.png);
                                        display: block;">
                                        <asp:Label ID="Rs_Profile" runat="server" Text="Profile" meta:resourcekey="Rs_ProfileResource1"></asp:Label>
                                    </div>
                                    <div id="pInvisibleDiv" onclick="showProfile()" class="invprofile" style="background-image: url(../Images/profile.png);
                                        display: none;">
                                        <asp:Label ID="Rs_Profile1" runat="server" Text="Profile" meta:resourcekey="Rs_Profile1Resource1"></asp:Label></div>
                                </div>
                            </td>
                            <td>
                                <div id="dpkg" runat="server" style="display: none;">
                                    <div id="pkgVisibleDiv" onclick="showPackage()" class="invprofile" style="background-image: url(../Images/investigation.png);
                                        display: none;">
                                        <asp:Label ID="Rs_Package" runat="server" Text="Package" meta:resourcekey="Rs_PackageResource1"></asp:Label>
                                    </div>
                                    <div id="pkgINVisibleDiv" onclick="showPackage()" class="invprofile" style="background-image: url(../Images/profile.png);
                                        display: block;">
                                        <asp:Label ID="Rs_Package1" runat="server" Text="Package" meta:resourcekey="Rs_Package1Resource1"></asp:Label>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div id="invisibleDiv" onclick="showInv()" class="investigation" style="background-image: url(../Images/profile.png);
                                    display: block;">
                                    <asp:Label ID="Rs_Investigation" runat="server" Text="Investigation" meta:resourcekey="Rs_InvestigationResource1"></asp:Label>
                                </div>
                                <div id="visibleDiv" onclick="showInv()" class="investigation" style="background-image: url(../Images/investigation.png);
                                    display: none;">
                                    <asp:Label ID="Rs_Investigation1" runat="server" Text="Investigation" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr valign="top" align="left">
                <td style="width: 60%">
                    <asp:HiddenField ID="hidValue" runat="server" />
                    <div id="Investigation" style="display: none;">
                        <table border="0" cellpadding="2" class="dataheader21" width="100%">
                            <tr>
                                <td style="width: 30%; height: 30PX;" align="center">
                                    <asp:Label ID="serTxt" runat="server" Text="Investigation Names" meta:resourcekey="serTxtResource1"></asp:Label>
                                </td>
                                <td style="width: 45%" align="center">
                                    <asp:TextBox ID="txtSearchText" Width="225px" runat="server" meta:resourcekey="txtSearchTextResource1"></asp:TextBox>
                                </td>
                                <td style="width: 20%" align="center">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:Repeater ID="rptName" runat="server" OnItemCommand="rptName_ItemCommand">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtn" Font-Size="9px" ForeColor="Black" Font-Names="CourierNew"
                                                runat="server" Text='<%# Bind("Alpha") %>' CommandName="text"><%--meta:resourcekey="lnkbtnResource1"--%></asp:LinkButton>
                                        </ItemTemplate>
                                        <SeparatorTemplate>
                                            <asp:Label Style="vertical-align: middle;" ID="lblSeparator" CssClass="defaultfontcolor"
                                                Font-Size="8px" Text="|" runat="server"><%-- meta:resourcekey="lblSeparatorResource1"--%></asp:Label>
                                        </SeparatorTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                            <tr style="height: 1px">
                                <td colspan="3">
                                    <hr class="evenforsurg" style="height: 1px;" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="lblStatus" Text="status" ForeColor="Black" Visible="False" runat="server"
                                        meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div style="padding: 2%; height: 400px; overflow: auto;">
                                        <asp:Repeater ID="rptinvestigation" runat="server" OnItemCommand="rptinvestigation_ItemCommand">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="100%" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 90%; background-color: #f7f7f7;" colspan="3">
                                                            <asp:Label Text='<%# Bind("InvestigationName") %>' ID="lblInvestigation" runat="server"><%--meta:resourcekey="lblInvestigationResource1"--%></asp:Label>
                                                            <asp:Label Text='<%# Bind("InvestigationID") %>' ID="lblinvID" runat="server" Visible="False"><%--meta:resourcekey="lblinvIDResource1"--%></asp:Label>
                                                        </td>
                                                        <td style="width: 10%; font-size: 12px background-color: #f7f7f7;">
                                                            <asp:LinkButton ID="lnkAdd" Style="font-family: Courier New" Text="Add" runat="server"
                                                                ForeColor="Black" CommandName="add"><%--meta:resourcekey="lnkAddResource1"--%></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="Profile" style="display: block; border: 1;">
                        <table border="0" class="dataheader21">
                            <tr valign="top" align="left">
                                <td>
                                    <div id="Div1" style="display: block; border: 0; overflow: auto; height: 450px; width: 100%">
                                        <asp:DataList ID="datalst" RepeatColumns="2" runat="server" OnItemDataBound="datalst_ItemDataBound"
                                            OnItemCommand="datalst_ItemCommand" meta:resourcekey="datalstResource1">
                                            <ItemStyle VerticalAlign="Top" />
                                            <ItemTemplate>
                                                <table border="0" cellpadding="0" cellspacing="2">
                                                    <tr valign="top">
                                                        <td style="width: 1%" align="left" valign="top">
                                                            <div id="ImgDiv" runat="server" style="display: block;">
                                                                <img id='<%# "plus" + DataBinder.Eval(Container.DataItem,"GroupID") %>' src="../Images/plus.png"
                                                                    onclick='hideInvesDiv(&#039;<%# Eval("GroupID") %>&#039;);' style="display: block;" />
                                                            </div>
                                                        </td>
                                                        <td style="width: 14%; font-size: 10px;" align="left" valign="top">
                                                            <asp:Label ID="lblParent" runat="server" Text='<%# Bind("GroupName") %>'><%--meta:resourcekey="lblParentResource1"--%></asp:Label>
                                                            <asp:Label ID="lblGroup" runat="server" Text='<%# Bind("GroupID") %>' Visible="False"><%--meta:resourcekey="lblGroupResource1"--%></asp:Label>
                                                        </td>
                                                        <td style="width: 3%; font-size: 12px" align="right" valign="top">
                                                            <asp:LinkButton ID="add" ForeColor="Black" Style="font-family: Courier New" Text="Add"
                                                                runat="server" CommandName="dListAdd" meta:resourcekey="addResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td colspan="2">
                                                            <table border="0">
                                                                <tr>
                                                                    <td style="padding-left: 5%">
                                                                        <div id='<%# Eval("GroupID") %>' style="font-size: 9px; vertical-align: text-top;
                                                                            display: none">
                                                                            <asp:Repeater ID="rptChild" runat="server">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"InvestigationName") %>'><%-- meta:resourcekey="lblNameResource1"--%></asp:Label>
                                                                                    <asp:Label ID="lblinvID" runat="server" Text='<%# Bind("InvestigationID") %>' Visible="False"><%--meta:resourcekey="lblinvIDResource2"--%></asp:Label>
                                                                                    <br />
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="package" style="display: none; border: 1">
                        <table width="100%" class="dataheader21">
                            <tr valign="top" align="left">
                                <td>
                                    <div id="Div2" style="display: block; border: 0; overflow: auto; height: 450px; width: 100%">
                                        <asp:DataList ID="dtPackage" RepeatColumns="2" runat="server" OnItemCommand="dtPackage_ItemCommand"
                                            OnItemDataBound="dtPackage_ItemDataBound" meta:resourcekey="dtPackageResource1">
                                            <ItemStyle VerticalAlign="Top" />
                                            <ItemTemplate>
                                                <table border="0" cellpadding="0" cellspacing="4">
                                                    <tr valign="top">
                                                        <td style="width: 5%" valign="top">
                                                            <img id='<%# "plus" + DataBinder.Eval(Container.DataItem,"GroupID") %>' src="../Images/plus.png"
                                                                onclick='hideInvesDiv(&#039;<%# Eval("GroupID") %>&#039;);' style="display: block;" />
                                                        </td>
                                                        <td style="width: 89%; font-size: 10px;" valign="top">
                                                            <asp:Label ID="lblPackageParent" runat="server" Text='<%# Bind("GroupName") %>'><%--meta:resourcekey="lblPackageParentResource1"--%></asp:Label>
                                                            <asp:Label ID="lblPackageID" runat="server" Text='<%# Bind("GroupID") %>' Visible="False"><%--meta:resourcekey="lblPackageIDResource1"--%></asp:Label>
                                                        </td>
                                                        <td style="width: 5%" valign="top">
                                                            <asp:LinkButton ID="Packageadd" ForeColor="Black" Style="font-family: Courier New"
                                                                Text="Add" runat="server" CommandName="packageAdd"><%--meta:resourcekey="PackageaddResource1"--%></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td colspan="2">
                                                            <table border="0">
                                                                <tr>
                                                                    <td style="padding-left: 5%">
                                                                        <div id='<%# Eval("GroupID") %>' style="font-size: 9px; vertical-align: text-top;
                                                                            display: none">
                                                                            <asp:Repeater ID="rptPackageChild" runat="server">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblChildName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"InvestigationName") %>'><%--meta:resourcekey="lblChildNameResource1"--%></asp:Label>
                                                                                    <asp:Label ID="lblPackageinvID" runat="server" Text='<%# Bind("InvestigationID") %>'
                                                                                        Visible="False"><%--meta:resourcekey="lblPackageinvIDResource1"--%></asp:Label>
                                                                                    <br />
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td style="width: 40%">
                    <table width="100%" id="table4" border="0" style="border-collapse: collapse;">
                        <tr>
                            <td colspan="5">
                                <asp:DataList ID="dLstAddedInves" runat="server" OnItemCommand="dLstAddedInves_ItemCommand"
                                    meta:resourcekey="dLstAddedInvesResource1">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblHeader" Width="200px" runat="server" Text="Ordered Investigation"
                                            meta:resourcekey="lblHeaderResource1"></asp:Label>
                                    </HeaderTemplate>
                                    <HeaderStyle Wrap="False" CssClass="colorforcontent" BorderStyle="Solid" ForeColor="White"
                                        Height="15px" HorizontalAlign="Left" VerticalAlign="Top" Width="30px" />
                                    <FooterStyle CssClass="gridFooterStyle" />
                                    <ItemStyle Width="220px" />
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 89%;" valign="top">
                                                    <asp:Label ID="invName" CssClass="defaultfontcolor" runat="server" Text='<%# Bind("InvestigationName") %>'><%--meta:resourcekey="invNameResource1"--%></asp:Label>
                                                    <asp:Label ID="invID" runat="server" Text='<%# Bind("InvestigationID") %>' Visible="False"><%--meta:resourcekey="invIDResource3"--%></asp:Label>
                                                    <asp:Label ID="groupID" runat="server" Text='<%# Bind("GroupID") %>' Visible="False"><%--meta:resourcekey="groupIDResource1"--%></asp:Label>
                                                </td>
                                                <td style="width: 5%; font-size: 12px;" valign="top">
                                                    <asp:LinkButton ID="Delete" Style="font-family: Courier New" runat="server" Text="Delete"
                                                        ForeColor="Black" CommandName="Delete"><%--meta:resourcekey="DeleteResource1"--%></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
