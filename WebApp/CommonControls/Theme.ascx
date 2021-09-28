<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Theme.ascx.cs" Inherits="CommonControls_Theme" %>

<script runat="server">

</script>
<script type="text/javascript" language="javascript">
    function setThemeID(id) {

        //alert(id);
        document.getElementById('<%= hdnSelectedID.ClientID %>').value = id;

         //alert(document.getElementById('<%= hdnSelectedID.ClientID %>').value);
    
    }

</script>
<div id="leftDiv" runat="server">
    <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_Theme_ascx_001%>
            </div>
        </div>
        <div class="categoryitems">
            <%--<div id="midIP" runat="server" style="cursor:pointer;" onclick="showIP();"></div>--%>
            <div id="hideIPdiv" style="display: block;">
               <%-- <ul class="boxe">
                <li class="boxmenu_1"><asp:LinkButton ID="BtnthemeIB"  Text="India Blue" runat="server" OnClick="BtnthemeIB_Click" /></li>
                 <li class="boxmenu_1"> <asp:LinkButton ID="BtnthemeBB"  Text="Black Beauty" runat="server" OnClick="BtnthemeBB_Click" /> </li>
                  <li class="boxmenu_1"> <asp:LinkButton ID="BtnthemeGG"  Text="Go Green" runat="server" OnClick="BtnthemeGG_Click" /></li>
                    
                    
                </ul>
                --%>
                <ul class="boxe">
                    <asp:Repeater ID="rptMenu" runat="server">
                        <ItemTemplate>
                        <li class="boxmenu_2">
                                <asp:LinkButton ID="BtnThemeChange" Text='<%# Eval("ThemeName") %>' runat="server"
                                    OnClick="BtnthemeChange_Click" meta:resourcekey="BtnThemeChangeResource1"></asp:LinkButton>
                         <asp:HiddenField ID="HdnThemeID" runat="server" Value='<%#Eval("ThemeID")%>' />

                        </li>
                        
                        
                            <%--<asp:HyperLink ID="hlk" Font-Underline="false" NavigateUrl='<%# Eval("ThemeURL")%>'
                                runat="server"> <li class="boxmenu_2"><%#Eval("ThemeName")%> </li></asp:HyperLink>--%>
                                
                                
                                
                                
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <asp:Literal ID="link" runat="server" meta:resourcekey="linkResource1" />
                
                
                <ul class="bottom">
                </ul>
            </div>
        </div>
    </div>
</div>
 <asp:HiddenField ID="hdnSelectedID" runat="server" />
