<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Error</title>
    <%--<link href="StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
</head>
<body id="oneColLayout" onContextMenu="return false;">
    <form id="RecHome" runat="server">
    <div id="wrapper">
        <div id="header">
        </div>
        <div id="primaryContent">
            <div id="maincontent">
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader">
                                <asp:Label ID="lblError" runat="server" Text="Error" 
                                    meta:resourcekey="lblErrorResource1"></asp:Label>
                            </li>
                        </ul>
                    </h1>
                    <div class="rum">
                        <table>
                            <tr>
                                <td align="right" class="defaultfontcolor">
                                    <asp:Label ID="lblError1" runat="server" Text="There is a live session already running on this machine.Please log-out from the
                                    previous session." meta:resourcekey="lblError1Resource1"></asp:Label>
                                    
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
