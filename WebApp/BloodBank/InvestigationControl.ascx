<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvestigationControl.ascx.cs" Inherits="BloodBank_InvestigationControl" %>
<script src="../Scripts/Common.js" type="text/javascript"></script>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
</script>
<table cellpadding="0" width="100%">
   <tr>
    <td>
      <asp:CheckBoxList ID="chklInvestigations" runat="server" 
            meta:resourcekey="chklInvestigationsResource1">
       <asp:ListItem Value="6029" meta:resourcekey="ListItemResource1">Liver function test</asp:ListItem>
       <asp:ListItem Value="6010" meta:resourcekey="ListItemResource2">Complete Hemogram</asp:ListItem> 
       <asp:ListItem Value="9999" meta:resourcekey="ListItemResource3">Plasma Urea</asp:ListItem>
       <asp:ListItem Value="6024" meta:resourcekey="ListItemResource4">Plasma Creatinine</asp:ListItem>
       <asp:ListItem Value="5051" meta:resourcekey="ListItemResource5">Anti HBsAg Antibody</asp:ListItem>
       <asp:ListItem Value="7893" meta:resourcekey="ListItemResource6">Anti HBC IgM Antibody</asp:ListItem>
       <asp:ListItem Value="4897" meta:resourcekey="ListItemResource7">Anti HCV Antibody IgG</asp:ListItem>
       <asp:ListItem Value="5917" meta:resourcekey="ListItemResource8">Anti-HIV-1, -2</asp:ListItem>
       <asp:ListItem Value="9068" meta:resourcekey="ListItemResource9">Anti-HTLV-I, -II</asp:ListItem>
       <asp:ListItem Value="10296" meta:resourcekey="ListItemResource10">Syphilis</asp:ListItem>
       <asp:ListItem Value="11035" meta:resourcekey="ListItemResource11">Nucleic Acid Amplification Testing (NAT)</asp:ListItem>
      </asp:CheckBoxList>
    </td>
   </tr> 
   <tr align="left">
     <td>
       <asp:Button ID="btnOrder" Text="Order" runat="server" CssClass="btn" 
             OnClick="btnOrder_Click" meta:resourcekey="btnOrderResource1"/>
       <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" 
             OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"/>
     </td>
   </tr>
</table>