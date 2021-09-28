<%@ Control Language="C#" AutoEventWireup="true" CodeFile="VitalInformation.ascx.cs" Inherits="ANC_VitalInformation" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<script src="../Scripts/bid.js" type="text/javascript" language="javascript"></script>
<div class="ancbg">
<div style="display: block" id="ACX2plusVIanc">
<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plusVIanc','ACX2minusVIanc','ACX2responsesVIanc',1);" />
<span style="cursor: pointer" onclick="showResponses('ACX2plusVIanc','ACX2minusVIanc','ACX2responsesVIanc',1);">
   <asp:Label ID="Rs_VitalInformation" Text="Vital Information" runat="server" 
        meta:resourcekey="Rs_VitalInformationResource1"></asp:Label></span>

</div>
<div style="display: none" id="ACX2minusVIanc">
<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plusVIanc','ACX2minusVIanc','ACX2responsesVIanc',0);" />
<span style="cursor: pointer" onclick="showResponses('ACX2plusVIanc','ACX2minusVIanc','ACX2responsesVIanc',0);">
  <asp:Label ID="Rs_VitalInformation1" Text="Vital Information" runat="server" 
        meta:resourcekey="Rs_VitalInformation1Resource1"></asp:Label></span>
      
</div>
</div>
<table id="ACX2responsesVIanc" style="display: none; width:180px" class="dataheader2">
<tr ><td colspan="4"></td></tr>
    <tr >
    
        <td style="width:60px">
            <div class="ancblackfontcolor"><asp:Label ID="Rs_PR" Text="PR" runat="server" 
                    meta:resourcekey="Rs_PRResource1"></asp:Label>
                   </div>
        </td>
        <td style="width: 95px; text-align: right;">
            <asp:Label ID="lblPR" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblPRResource1"></asp:Label>
        </td>
        <td style="width: 25px;">
            <asp:Label runat="server" CssClass="blackfontcolor" ID="lblUOM1" 
                meta:resourcekey="lblUOM1Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_BP" Text="BP" runat="server" 
                    meta:resourcekey="Rs_BPResource1"></asp:Label>
                </div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblSystolic" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblSystolicResource1"></asp:Label>
            <asp:Label ID="Label1" CssClass="blackfontcolormediumanc" runat="server" 
                Text="/" meta:resourcekey="Label1Resource1"></asp:Label>
            <asp:Label ID="lblDiastolic" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblDiastolicResource1"></asp:Label>
        </td>
        <td>
            <asp:Label runat="server" CssClass="blackfontcolor" ID="lblUOM2" 
                meta:resourcekey="lblUOM2Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_Weight" Text="Weight" 
                    runat="server" meta:resourcekey="Rs_WeightResource1"></asp:Label>
                   </div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblWeight" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblWeightResource1"></asp:Label>
        </td>
        <td>
            <asp:Label runat="server" CssClass="blackfontcolor" ID="lblUOM3" 
                meta:resourcekey="lblUOM3Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_WTgain" Text="WT gain" 
                    runat="server" meta:resourcekey="Rs_WTgainResource1"></asp:Label>
                  </div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblWeightGain" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblWeightGainResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM4" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM4Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_Temp" Text="Temp" runat="server" 
                    meta:resourcekey="Rs_TempResource1"></asp:Label></div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblTemp" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblTempResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM5" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM5Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <asp:Label ID="Label2" CssClass="defaultfontcolor" runat="server" Text="HB" 
                meta:resourcekey="Label2Resource1"></asp:Label>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblHB" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblHBResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM6" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM6Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td><div><asp:Label ID="Rs_HIV" Text="HIV" runat="server" 
                meta:resourcekey="Rs_HIVResource1"></asp:Label>
                   </div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblBloodSugar" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblBloodSugarResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM7" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM7Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_USugar" Text="U.Sugar" 
                    runat="server" meta:resourcekey="Rs_USugarResource1"></asp:Label></div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblUrineSugar" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblUrineSugarResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM8" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM8Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_UAlbumin" Text="U.Albumin" 
                    runat="server" meta:resourcekey="Rs_UAlbuminResource1"></asp:Label></div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblUrineAlbumin" CssClass="blackfontcolormediumanc" 
                runat="server" meta:resourcekey="lblUrineAlbuminResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblUOM9" CssClass="blackfontcolor" runat="server" 
                meta:resourcekey="lblUOM9Resource1"></asp:Label>
        </td>
    </tr>
    <tr >
    <td width="5px"></td>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_BGroup" Text="B.Group" 
                    runat="server" meta:resourcekey="Rs_BGroupResource1"></asp:Label></div>
        </td>
        <td style="text-align: right">
            <asp:Label ID="lblBloodGroup" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblBloodGroupResource1"></asp:Label>
        </td>
       
    </tr>
    <tr ><td colspan="4"></td></tr>
</table>

