<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MsgForm.aspx.cs" Inherits="Masters_MsgForm" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Health Care</title>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        &nbsp;<table style="width: 648px">
            <tr>
                <td style="width: 100px; height: 27px; background-color: cornsilk">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Papyrus" Font-Overline="True"
                        Font-Size="Medium" Text="Label" ForeColor="DarkViolet" Width="566px" 
                        meta:resourcekey="lblMsgResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:LinkButton ID="lbtnContinue" runat="server" Style="z-index: 100; left: 12px;
                        position: absolute; top: 67px" OnClick="lbtnContinue_Click" 
                        meta:resourcekey="lbtnContinueResource1">Continue</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; font-size: 10px; width: 100px; text-indent: 10px;
                    font-family: Verdana; background-color: whitesmoke">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp;<asp:Label ID="Label1" runat="server" Text=" e-hospice CopyRight - 2008    "
                        Width="324px" meta:resourcekey="Label1Resource1"></asp:Label>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                </td>
            </tr>
        </table>
        &nbsp;
    </div>
    </form>
</body>
</html>
