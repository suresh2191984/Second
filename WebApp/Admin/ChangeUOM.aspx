<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangeUOM.aspx.cs" Inherits="Admin_ChangeUOM" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function SelectUOMCode(rid, uomID, uomCode) {
            window.opener.SelectUOMCode1(rid, uomID, uomCode);
            window.close();
        }
    </script>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="450px" height="450px" class="dataheaderInvCtrl">
    <tr>
        <td>
            <asp:DataList ID="dlUOMCode" runat="server"
                CellPadding="4" GridLines="Horizontal"
                RepeatColumns="8" 
                onitemdatabound="dlUOMCode_ItemDataBound" 
                meta:resourcekey="dlUOMCodeResource1">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rbUOMCode" runat="server" Text='<%# Bind("UOMCode") %>' 
                                    meta:resourcekey="rbUOMCodeResource1" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
    </table>
  
    </form>
</body>
</html>
