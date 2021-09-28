<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserRoleChange.ascx.cs"
    Inherits="CommonControls_UserRoleChange" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="Department.ascx" TagName="Department" TagPrefix="uc1" %>
<div id="leftDiv" runat="server" visible="false">
    <%--<div id="divRoles" runat="server" style="cursor:pointer;" onclick="showChangeRoles();">
    </div>--%>
    <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
            <%=Resources.CommonControls_ClientDisplay.CommonControls_UserRoleChange_ascx_001%>
                <%--<%=Resources.MenuMasterHeader.__CommonControls_UserRoleChange_ascx%>--%>
                </div>
        </div>
      <div class="categoryitems">
    <div id="hidediv" style="display: block;">
    <ul class="boxe">
        <ul>
            <asp:Repeater ID="rptRole" runat="server" onitemcommand="rptRole_ItemCommand">
                <ItemTemplate>
                    <li class="boxmenu_2">
                                    <asp:Label ID="lblOrgID" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "OrgId") %>'
                                        runat="server" meta:resourcekey="lblOrgIDResource1"></asp:Label>
                                    <asp:Label ID="lblOrgName" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "OrganisationName") %>'
                                        runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                    <asp:Label ID="lblRole" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "RoleID") %>'
                                        runat="server" meta:resourcekey="lblRoleResource1"></asp:Label>
                                    <asp:Label ID="lblRoleName" Visible="False" runat="server" 
                                        Text='<%# DataBinder.Eval(Container.DataItem, "RoleName") %>' 
                                        meta:resourcekey="lblRoleNameResource1" />
                            <asp:LinkButton ID="link" runat="server" Text='<%# (string)DataBinder.Eval(Container.DataItem, "Description") + " at " + (string)DataBinder.Eval(Container.DataItem, "OrganisationName") %>'
                                        CommandName="go" 
                                        OnClientClick="javascript:return OnRoleChageLeftMenu(this);" 
                                        meta:resourcekey="linkResource1"></asp:LinkButton>
                                    <asp:Label ID="lblRoleDesc" Visible="False" runat="server" 
                                        Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>' 
                                        meta:resourcekey="lblRoleDescResource1" />
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </ul>
    <ul class="bottom">
        <li></li>
    </ul>
    </div>
    </div>
    </div>
    <uc1:Department ID="Department2" runat="server" />
    <script type="text/javascript">
        function OnRoleChageLeftMenu(obj) { 
            var $row = $(obj).closest('li');
            var lblOrgID = $row.find($('span[id$="lblOrgID"]')).html();
            var OrgID = '<%=OrgID%>';
            if (lblOrgID != OrgID) {
              //  onRoleChanges(0, 0, 0);
              //  return false;
            }
        }
    </script>
</div>
