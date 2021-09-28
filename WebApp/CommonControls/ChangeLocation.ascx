<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChangeLocation.ascx.cs"
    Inherits="CommonControls_ChangeLocation" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/ddaccordion.js" language="javascript"></script>
<script type="text/javascript" src="../scripts/menu.js" language="javascript"></script>
--%>
<div id="leftDiv" runat="server" visible="false">
    <%--<div id="divRoles" runat="server" style="cursor:pointer;" onclick="showChangeRoles();">
    </div>--%>
    <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_ChangeLocation_ascx_001%>
                <!--<asp:Label ID="Rs_ChangeLocation" runat="server" Text="Change Location" meta:resourcekey="Rs_ChangeLocationResource1"></asp:Label>-->
                </div>
        </div>
        <div class="categoryitems">
            <div id="hidediv" style="display: block;">
                <ul class="boxe">
                    <asp:Repeater ID="rptChangeLocation" runat="server" OnItemCommand="rptChangeLocation_ItemCommand">
                        <ItemTemplate>
                            <li class="boxmenu_2">
                                <asp:Label ID="lblAddressID" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "AddressID") %>'
                                    runat="server" meta:resourcekey="lblAddressIDResource2"></asp:Label>
                                <asp:LinkButton ID="linkLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Location") %>'
                                    CommandName="go" meta:resourcekey="linkLocationResource2"></asp:LinkButton>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <ul class="bottom">
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
</div>
