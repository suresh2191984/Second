<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TaskActionMapping.aspx.cs" Inherits="Admin_TaskActionMapping" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function OnTreeClick(evt) {
            var src = window.event != window.undefined ? window.event.srcElement : evt.target;
            var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
            if (isChkBoxClick) {
                var parentTable = GetParentByTagName("table", src);
                var nxtSibling = parentTable.nextSibling;
                if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
                {
                    if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
                    {
                        //check or uncheck children at all levels
                        CheckUncheckChildren(parentTable.nextSibling, src.checked);
                    }
                }
                //check or uncheck parents at all levels

                CheckUncheckParents(src, src.checked);
            }
        }

        function RoleCheck(id) {
            var e = document.getElementById("ddlTaskActions");
            var obj = document.getElementById(id).id;
            var strUser = e.options[e.selectedIndex].value;
            if (strUser == 0) {
                alert("Please Select Role");
                return false;
            }
            else {
                if (obj == 'btnRemove') {
                    chkGrponchange();
                }
            }
        }

        function chkGrponchange() {
            var tableBody = document.getElementById('chklstMapedActions').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items to remove taskactions');
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <asp:Panel ID="pnl1" runat="server" CssClass="dataheader2 defaultfontcolor">
                                    <table border="0" style="border-color: Red" width="100%">
                                        <tr>
                                            <td colspan="3">
                                                <div id="div1">
                                                    <asp:Panel ID="pnl2" runat="server" CssClass="dataheader2" Style="width: 100%" BorderWidth="1px">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td width="35%" align="right">
                                                                    <asp:Label ID="lblTask" runat="server" Text="Select Role To Map:"></asp:Label>
                                                                </td>
                                                                <td width="45%">
                                                                    <asp:DropDownList ID="ddlTaskActions" CssClass="ddlsmall" runat="server" OnSelectedIndexChanged="ddlTaskActions_SelectedIndexChanged"
                                                                        AutoPostBack="true">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="30%">
                                                <div>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <div style="overflow: scroll; border: 2px; border-color: #fff; width: 250px; height: 400px;"
                                                                    class="ancCSviolet">
                                                                    <asp:TreeView ID="TVH" runat="server" Width="50px" ExpandImageUrl="~/Images/bullet.png"
                                                                        CollapseImageUrl="~/Images/bullet.png" Font-Size="Medium" Font-Names="Tahoma"
                                                                        meta:resourcekey="TVHResource2">
                                                                        <ParentNodeStyle ChildNodesPadding="2px"></ParentNodeStyle>
                                                                        <Nodes>
                                                                            <asp:TreeNode ImageUrl="~/Images/whitebg.png" SelectAction="None" Value="0" meta:resourcekey="TreeNodeResource1">
                                                                            </asp:TreeNode>
                                                                        </Nodes>
                                                                    </asp:TreeView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td width="45%" align="left">
                                                <div>
                                                    <asp:UpdatePanel ID="updpnl" runat="server">
                                                        <ContentTemplate>
                                                            <table width="100%" border="0" align="center">
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:Button ID="btnAdd" runat="server" Text=">>" CssClass="btn" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" Width="62px" OnClientClick="return RoleCheck(this.id);" OnClick="btnAdd_Click" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:Button ID="btnRemove" runat="server" Text="<<" CssClass="btn" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" Width="62px" OnClientClick="return RoleCheck(this.id);" OnClick="btnRemove_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </td>
                                            <td width="35%">
                                                <div>
                                                    <table id="tbMap" width="100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pnlMaped" Visible="false" runat="server" GroupingText="Mapped Task Actions" CssClass="dataheader2 defaultfontcolor">
                                                                    <asp:CheckBoxList ID="chklstMapedActions" runat="server">
                                                                    </asp:CheckBoxList>                                                                    
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Label ForeColor="Red" Visible="false" ID="lblTaskError" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:HiddenField ID="hdnRoleID" runat="server" />
                                <asp:HiddenField ID="hdnValues" runat="server" Value="1" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
