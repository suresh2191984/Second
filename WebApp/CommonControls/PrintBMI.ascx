<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintBMI.ascx.cs" Inherits="CommonControls_PrintBMI" %>
<style type="text/css">
    .style1
    {
        width: 180px;
    }
</style>
<asp:Panel runat="server" ID="pnlError" GroupingText="Errors" Visible="False" 
    CssClass="defaultfontcolor" meta:resourcekey="pnlErrorResource1">
    <table class="defaultfontcolor">
        <tr>
            <td>
                <asp:Literal ID="lblError" runat="server" meta:resourcekey="lblErrorResource1"></asp:Literal>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlGeneral" GroupingText="General" runat="server" 
    meta:resourcekey="pnlGeneralResource1" >
    <table cellpadding="0" cellspacing="3" border="0">
        <tr>
            <td  style="visibility: hidden">
                <asp:Label ID="lblBMIVitalsID" runat="server" 
                    meta:resourcekey="lblBMIVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td class="style1" >
                <asp:Label ID="lblBMIVitalsName" runat="server" 
                    meta:resourcekey="lblBMIVitalsNameResource1"></asp:Label>
            </td>
            <td >
            <asp:Label ID="lblBMI" runat="server" meta:resourcekey="lblBMIResource1"></asp:Label>
               
            </td>
            <td >
                <asp:Label ID="lblBMIUOMCode" runat="server" 
                    meta:resourcekey="lblBMIUOMCodeResource1"></asp:Label>
            </td>
            <td  style="visibility: hidden">
                <asp:Label ID="lblFatVitalsID" runat="server" 
                    meta:resourcekey="lblFatVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td >
                <asp:Label ID="lblFatVitalsName" runat="server" 
                    meta:resourcekey="lblFatVitalsNameResource1"></asp:Label>
            </td>
            <td >
            <asp:Label ID="lblFat" runat="server" meta:resourcekey="lblFatResource1"></asp:Label>             
                            </td>
            <td >
                <asp:Label ID="lblFatUOMCode" runat="server" 
                    meta:resourcekey="lblFatUOMCodeResource1"></asp:Label>
            </td>
             
        </tr>
        <tr>
            <td  style="visibility: hidden">
                <asp:Label ID="lblHeightVitalsID" runat="server" 
                    meta:resourcekey="lblHeightVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td class="style1" >
                <asp:Label ID="lblHeightVitalsName" runat="server" 
                    meta:resourcekey="lblHeightVitalsNameResource1"></asp:Label>
            </td>
            <td >
            <asp:Label ID="lblHeight" runat="server" meta:resourcekey="lblHeightResource1"></asp:Label>
                
            </td>
            <td >
                <asp:Label ID="lblHeightUOMCode" runat="server" 
                    meta:resourcekey="lblHeightUOMCodeResource1"></asp:Label>
            </td>
            <td  style="visibility: hidden">
                <asp:Label ID="lblWeightVitalsID" runat="server" 
                    meta:resourcekey="lblWeightVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td >
                <asp:Label ID="lblWeightVitalsName" runat="server" 
                    meta:resourcekey="lblWeightVitalsNameResource1"></asp:Label>
            </td>
            <td >
            <asp:Label ID="lblWeight" runat="server" meta:resourcekey="lblWeightResource1"></asp:Label>                
            </td>
            <td >
                <asp:Label ID="lblWeightUOMCode" runat="server" 
                    meta:resourcekey="lblWeightUOMCodeResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td  style="visibility: hidden">
                <asp:Label ID="lblBMRVitalsID" runat="server" 
                    meta:resourcekey="lblBMRVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td class="style1" >
                <asp:Label ID="lblBMRVitalsName" runat="server" 
                    meta:resourcekey="lblBMRVitalsNameResource1"></asp:Label>
            </td>
            <td >
             <asp:Label ID="lblBMR" runat="server" meta:resourcekey="lblBMRResource1"></asp:Label>
                
            </td>
            <td >
                <asp:Label ID="lblBMRUOMCode" runat="server" 
                    meta:resourcekey="lblBMRUOMCodeResource1"></asp:Label>
            </td>
            
                 <td  style="visibility: hidden">
                <asp:Label ID="lblFatMassVitalsID" runat="server" 
                         meta:resourcekey="lblFatMassVitalsIDResource1"></asp:Label>&nbsp;
            </td>  
            <td>
                <asp:Label ID="lblFatMassVitalsName" runat="server" 
                    meta:resourcekey="lblFatMassVitalsNameResource1"></asp:Label>
            </td>
            <td>
             <asp:Label ID="lblFatMass" runat="server" meta:resourcekey="lblFatMassResource1"></asp:Label>
             
            </td>
            
            <td>
                <asp:Label ID="lblFatMassUOMCode" runat="server" 
                    meta:resourcekey="lblFatMassUOMCodeResource1"></asp:Label>
            </td>
            
        </tr>
        <tr>
        <td  style="visibility: hidden">
                <asp:Label ID="lblFreeFatMassVitalsID" runat="server" 
                    meta:resourcekey="lblFreeFatMassVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td class="style1" >
                <asp:Label ID="lblFreeFatMassVitalsName" runat="server" 
                    meta:resourcekey="lblFreeFatMassVitalsNameResource1"></asp:Label>
            </td>
            <td >
             <asp:Label ID="lblFreeFatMass" runat="server" 
                    meta:resourcekey="lblFreeFatMassResource1"></asp:Label>
                
                
            </td>
            <td >
                <asp:Label ID="lblFreeFatMassUOMCode" runat="server" 
                    meta:resourcekey="lblFreeFatMassUOMCodeResource1"></asp:Label>
            </td>
        <td  style="visibility: hidden">
                <asp:Label ID="lblTotalBodyWaterVitalsID" runat="server" 
                    meta:resourcekey="lblTotalBodyWaterVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td >
                <asp:Label ID="lblTotalBodyWaterVitalsName" runat="server" 
                    meta:resourcekey="lblTotalBodyWaterVitalsNameResource1"></asp:Label>
            </td>
            <td >
             <asp:Label ID="lblTotalBodyWater" runat="server" 
                    meta:resourcekey="lblTotalBodyWaterResource1"></asp:Label>               
                </td>
            <td >
                <asp:Label ID="lblTotalBodyWaterUOMCode" runat="server" 
                    meta:resourcekey="lblTotalBodyWaterUOMCodeResource1"></asp:Label>
            </td>
        
        </tr>
        
    </table>
</asp:Panel>
