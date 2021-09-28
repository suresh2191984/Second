<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvReportTemplateMaster.ascx.cs" Inherits="CommonControls_InvReportTemplateMaster" %>
    <script language="javascript"  type="text/javascript">
        function OnTreeClick(evt) {
            var src = window.event != window.undefined ? window.event.srcElement : evt.target;
            var nodeClick = src.tagName.toLowerCase() == "a";
            if (nodeClick) {
                var nodeText = src.innerText || src.innerHTML;
                var nodeValue = GetNodeValue(src);
                var objSelVal = document.getElementById('<%=hdnSelctedValue.ClientID %>');
                objSelVal.value = nodeValue;
            }
            return false;
        }
        function GetNodeValue(node) {
            var nodeValue = "";
            var nodePath = node.href.substring(node.href.indexOf(",") + 2, node.href.length - 2);
            var nodeValues = nodePath.split("\\");
            if (nodeValues.length > 1)
                nodeValue = nodeValues[nodeValues.length - 1];
            else
                nodeValue = nodeValues[0].substr(1);
            return nodeValue;
        }
    </script>
    <style type="text/css">
    .treeView a:hover{color:blue;text-decoration:underline;}
    .treeView a:visited{color:#FF6666}
    </style>
<table align="center" border="0" width="90%">
    <tr>
        <td>
            <div style="display: inline;">
                <asp:TreeView CssClass="treeView" ID="tvCatalog" runat="server" Font-Size="Small">
                <SelectedNodeStyle BackColor="#FF6666" />
                </asp:TreeView>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnSelctedValue" runat="server" />
<asp:HiddenField ID="hdnParentPathControl" runat="server" />
