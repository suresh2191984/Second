<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ANCVisitSummary.ascx.cs" Inherits="ANC_ANCVisitSummary" %>
<script src="../Scripts/bid.js" type="text/javascript" language="javascript"></script>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>
<div class="ancbg">
<div style="display: none" id="ACX2plusVSanc">
<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plusVSanc','ACX2minusVSanc','ACX2responsesVSanc',1);" />
<span style="cursor: pointer" onclick="showResponses('ACX2plusVSanc','ACX2minusVSanc','ACX2responsesVSanc',1);">Vital Summary</span>
</div>
<div style="display: block" id="ACX2minusVSanc">
<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plusVSanc','ACX2minusVSanc','ACX2responsesVSanc',0);" />
<span style="cursor: pointer" onclick="showResponses('ACX2plusVSanc','ACX2minusVSanc','ACX2responsesVSanc',0);">Vital Summary</span>
</div>
</div>
<table id="ACX2responsesVSanc" style="display: block; width:180px" class="dataheader2">
    <tr>
        <td style="width: 100px;">
            <div class="ancblackfontcolor"><asp:Label ID="Rs_LMP" Text="LMP" runat="server" 
                    meta:resourcekey="Rs_LMPResource1"></asp:Label></div>
        </td>
        <td style="width: 25px;">
            <asp:Label ID="lblLMP" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblLMPResource1"></asp:Label>
        </td>
        <td style="width: 25px;">
            
        </td>
    </tr>
    <tr>
        <td>
            <div class="ancblackfontcolor"><asp:Label ID="Rs_EDD" Text="EDD" runat="server" 
                    meta:resourcekey="Rs_EDDResource1"></asp:Label></div>
        </td>
        <td>
            <asp:Label ID="lblEDD" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblEDDResource1"></asp:Label>
        </td>
        <td>
            
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <div class="fontGPLA">
                <asp:Label ID="Rs_G" Text="G" runat="server" meta:resourcekey="Rs_GResource1"></asp:Label>
                <sub>
                    <asp:Label ID="lblG" CssClass="blackfontcolormediumanc" runat="server" 
                    meta:resourcekey="lblGResource1"></asp:Label>&nbsp; 
                </sub>
                <asp:Label ID="Rs_P" Text="P" runat="server" meta:resourcekey="Rs_PResource1"></asp:Label>
                <sub>
                    <asp:Label ID="lblP" CssClass="blackfontcolormediumanc" runat="server" 
                    meta:resourcekey="lblPResource1"></asp:Label>&nbsp;
                </sub>
               <asp:Label ID="Rs_L" Text="L" runat="server" meta:resourcekey="Rs_LResource1"></asp:Label>
                <sub>
                    <asp:Label ID="lblL" CssClass="blackfontcolormediumanc" runat="server" 
                    meta:resourcekey="lblLResource1"></asp:Label>&nbsp; 
                </sub>
                <asp:Label ID="Rs_A" Text="A" runat="server" meta:resourcekey="Rs_AResource1"></asp:Label>
                <sub>
                    <asp:Label ID="lblA" CssClass="blackfontcolormediumanc" runat="server" 
                    meta:resourcekey="lblAResource1"></asp:Label>
                </sub>
            </div>
        </td>
    </tr>
    <tr id="trOthers" runat="server">
        <td colspan="3">
       <asp:Label ID="Rs_Others" Text="Others:" runat="server" 
                meta:resourcekey="Rs_OthersResource1"></asp:Label>
            <asp:Label ID="lblGPALOthers" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblGPALOthersResource1"></asp:Label></td>
    </tr>
    <tr id="trGA" runat="server">
        <td>
                       <asp:Label ID="Rs_GA" Text="GA" runat="server" 
                           meta:resourcekey="Rs_GAResource1"></asp:Label></td>
        <td>
             <asp:Label ID="lblGAge" CssClass="blackfontcolormediumanc" runat="server" 
                 meta:resourcekey="lblGAgeResource1"></asp:Label></td>
        <td>
            
            &nbsp;</td>
    </tr>
    <tr id="trNoofGes" runat="server">
        <td>
           <asp:Label ID="Rs_NoofFoetus" Text=" No of Foetus" runat="server" 
                meta:resourcekey="Rs_NoofFoetusResource1"></asp:Label>
        </td>
        <td colspan="2">
            <asp:Label ID="lblNoofFoetus" CssClass="blackfontcolormediumanc" runat="server" 
                meta:resourcekey="lblNoofFoetusResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Label ID="lblVacStatus" CssClass="ancblackfontcolor" 
                Text="Vaccination Given" runat="server" 
                meta:resourcekey="lblVacStatusResource1"></asp:Label></td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Repeater ID="repVaccinationStatus" runat="server">
                <ItemTemplate>
                    <table>
                    <tr>
                        <td>
                            <img src="../Images/patient_bullet.png" />
                        </td>
                        <td>
                            <asp:Label ID="lblMoV" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "MonthOfVaccination") %>' 
                                meta:resourcekey="lblMoVResource1"></asp:Label><span class="blackfontcolor">/</span><asp:Label 
                                ID="lblYoV" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "YearOfVaccination") %>' 
                                meta:resourcekey="lblYoVResource1"></asp:Label><span class="blackfontcolor">-</span><asp:Label 
                                ID="lblVName" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "VaccinationName") %>' 
                                meta:resourcekey="lblVNameResource2"></asp:Label>
                            <asp:Label ID="Label1" runat="server" CssClass="blackfontcolormediumanc" 
                                Text="(D-" meta:resourcekey="Label1Resource1"></asp:Label>
                            <asp:Label ID="Label2" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "VaccinationDose") %>' 
                                meta:resourcekey="Label2Resource1"></asp:Label><asp:Label ID="Label3" 
                                runat="server" CssClass="blackfontcolormediumanc" Text=")" 
                                meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                    </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Label ID="lblBgp" CssClass="ancblackfontcolor" Text="Background Problem" 
                runat="server" meta:resourcekey="lblBgpResource1"></asp:Label></td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Repeater ID="repBackgroundProblem" runat="server">
                <ItemTemplate>
                    <table>
                    <tr>
                        <td>
                            <img src="../Images/patient_bullet.png" />
                        </td>
                        <td>
                            <asp:Label ID="lblComplaintName" runat="server" 
                                CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "ComplaintName") %>' 
                                meta:resourcekey="lblComplaintNameResource1"></asp:Label>
                        </td>
                    </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Label ID="lblScanReport" CssClass="ancblackfontcolor" Text="Scan Report" 
                runat="server" meta:resourcekey="lblScanReportResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Repeater ID="repScan" runat="server">
                <HeaderTemplate>
                    <table border="1">
                        <tr align="left">
                            <th align="left">
                                <asp:Label ID="Rs_Date" Text="Date" runat="server" 
                                    meta:resourcekey="Rs_DateResource1"></asp:Label>
                            </th>
                            <th align="left">
                               <asp:Label ID="Rs_GA" Text="GA" runat="server" meta:resourcekey="Rs_GAResource2"></asp:Label>
                            </th>
                            <th align="left">
                               <asp:Label ID="Rs_PP" Text="PP" runat="server" meta:resourcekey="Rs_PPResource1"></asp:Label>
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblUSD" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "USDate") %>' 
                                meta:resourcekey="lblUSDResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblVName" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "GAge") %>' 
                                meta:resourcekey="lblVNameResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" CssClass="blackfontcolormediumanc" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "PlacentalPosition") %>' 
                                meta:resourcekey="Label5Resource1"></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
</table>