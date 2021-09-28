<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EncryptPasswordBulk.aspx.cs" Inherits="EncryptPasswordBulk" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bulk Encryption of Passwords in a Database</title>
</head>
<body style="background-color:#a5a5a3">
    <form id="form1" runat="server">
    <div>
    
            <div id="loginpage">
        <div class="loginbg" ></div>
        <div class="loginimg">
    
        <table>
        <tr><td height="100"></td>
        <tr><td width="500"></td><td width="77">
        <table width="253">
            <tr><td></td></tr>
            <tr><td></td></tr>
            <div id="div1" class="loginpage">
            <tr><td align="center">
                <asp:RadioButton ID="rbEncrypt" Checked="True" Text="Encrypt" 
                    GroupName="rbEncDec" runat="server" meta:resourcekey="rbEncryptResource1" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:RadioButton ID="rbDecrypt" Text="Decrypt" GroupName="rbEncDec" 
                    runat="server" meta:resourcekey="rbDecryptResource1" />
                </td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td>
                &nbsp;<asp:Button ID="btnEncryptData" runat="server" 
                    Text="Encrypt / Decrypt & Update Login Details" onclick="btnEncryptData_Click" 
                    Height="79px" Width="265px" meta:resourcekey="btnEncryptDataResource1" />
                </td>
            </tr>
            </div>
            <tr><td></td></tr>
            <tr><td>
                <asp:Label ID="lblWarning" ForeColor="Red" runat="server" Text=" " 
                    meta:resourcekey="lblWarningResource1"></asp:Label>
                </td></tr>
            <tr><td></td></tr>
        </table>
        </td><td width="500"></td>
        </tr>
        </tr>
        </tr>
        </table>
    </div>
    </div>    
    </div>
    </form>
</body>
</html>
