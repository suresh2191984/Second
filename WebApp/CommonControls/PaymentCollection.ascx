<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentCollection.ascx.cs" Inherits="CommonControls_PaymentCollection" %>

<table border="0" cellpadding="0" cellspacing="0" width="50%">
    <tr>
        <td>
            <asp:Label ID="lblAmountCollect" runat="server" Text="Amount Recieved" 
                meta:resourcekey="lblAmountCollectResource1"></asp:Label>
        </td>    
        <td>
            <asp:TextBox ID="txtAmountRecieved" runat="server" Text="0.00" 
                meta:resourcekey="txtAmountRecievedResource1" ></asp:TextBox>
        </td>
    </tr>
</table>
