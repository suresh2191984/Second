<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioChemistryDisplay.ascx.cs"
    Inherits="Investigation_BioChemistryDisplay" %>
<style type="text/css">
    .style1
    {
        height: 22px;
    }
</style>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table cellspacing="1" style="height: auto" width="100%" border="0">
    <tr>
        <td>
            <div id="d3001" style="display: none" runat="server">
                <asp:Label Text="Bio-Chemistry" runat="server" ID="lblMicro" CssClass="main_title"
                    meta:resourcekey="lblMicroResource1"></asp:Label>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <span class="label_title"><a id="a3002" runat="server" visible="False">
                <asp:Label ID="Rs_Electrolytes" Text="Electrolytes" runat="server" meta:resourcekey="Rs_ElectrolytesResource1"></asp:Label></a></span>
            <div id="d3002" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3002">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3010" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_BloodSugars" Text="Blood Sugars" runat="server" meta:resourcekey="Rs_BloodSugarsResource1"></asp:Label></span></a>
            <div id="d3010" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3010">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d13016" runat="server" style="display: none; padding-left: 30px">
                <table style="padding-left: 30px">
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn3016" meta:resourcekey="pn3016Resource1">
                                <table>
                                    <tr>
                                        <td colspan="3">
                                            <asp:Label runat="server" ID="l3016" CssClass="label_subtitle" meta:resourcekey="l3016Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lblSugar" CssClass="results" meta:resourcekey="lblSugarResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblValues" CssClass="results" meta:resourcekey="lblValuesResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblUOM" CssClass="results" meta:resourcekey="lblUOMResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="d3016" style="display: none; padding-left: 30px" runat="server">
                <asp:Panel ID="pnGTT" runat="server" meta:resourcekey="pnGTTResource1">
                </asp:Panel>
                <asp:Repeater runat="server" ID="rpt3016">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("Name") %>'
                                        meta:resourcekey="lblNameResource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource3"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3017" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_RenalFunctionTests" Text="Renal Function Tests" runat="server" meta:resourcekey="Rs_RenalFunctionResource1"></asp:Label>
                </span></a>
            <div id="d3017" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3017">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource4"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource4"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource4"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <a id="a3023" runat="server" visible="False"><span class="label_title">Spot Na+,K+,Creat</span></a>
                            <div id="d3023" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3023">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource5"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource5"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource5"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3030" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_LiverFunctionTests" Text="Liver Function
                Tests" runat="server" meta:resourcekey="Rs_LiverFunctionTestsResource1"></asp:Label></span></a>
            <div id="d3030" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <a id="a3031" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_Bilrubin" Text="Bilrubin" runat="server" meta:resourcekey="Rs_BilrubinResource1"></asp:Label></span></a>
                            <div id="d3031" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3031">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource6"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource6"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource6"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a3035" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_Protein" Text="Protein" runat="server" meta:resourcekey="Rs_ProteinResource1"></asp:Label></span></a>
                            <div id="d3035" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3035">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource7"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource7"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource7"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn3044" Visible="False" meta:resourcekey="pn3044Resource1">
                                <table style="padding-left: 10px">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="l3044" CssClass="results" meta:resourcekey="l3044Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l13044" CssClass="results" meta:resourcekey="l13044Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l23044" CssClass="results" meta:resourcekey="l23044Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="Uom3044" CssClass="results" meta:resourcekey="Uom3044Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt3030">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource8"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource8"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource8"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3045" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_CardiacEnzymes" Text="Cardiac Enzymes" runat="server" meta:resourcekey="Rs_CardiacEnzymesResource1"></asp:Label></span></a>
            <div id="d3045" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3045">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource9"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource9"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource9"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3052" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_LipidProfile" Text="Lipid Profile" runat="server" meta:resourcekey="Rs_LipidProfileResource1"></asp:Label></span></a>
            <div id="d3052" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3052">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Label1" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label2" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label3" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px" class="style1">
            <a id="a3059" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_General" Text="General" runat="server" meta:resourcekey="Rs_GeneralResource1"></asp:Label></span></a>
            <div id="d3059" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3059">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Label1" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="Label1Resource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label2" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="Label2Resource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label3" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Label3Resource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3071" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_TumorMarkers" Text="Tumor Markers" runat="server" meta:resourcekey="Rs_TumorMarkersResource1"></asp:Label></span></a>
            <div id="d3071" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt3071">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Label1" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="Label1Resource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label2" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="Label2Resource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Label3" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Label3Resource3"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a3077" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_HormoneAssays" Text="Hormone Assays" runat="server" meta:resourcekey="Rs_HormoneAssaysResource1"></asp:Label></span></a>
            <div id="d3077" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <a id="a3078" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_ThyroidProfile" Text="Thyroid Profile" runat="server" meta:resourcekey="Rs_ThyroidProfileResource1"></asp:Label></span></a>
                            <div id="d3078" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3078">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource10"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource10"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource10"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a3088" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_General1" Text="General" runat="server" meta:resourcekey="Rs_General1Resource1"></asp:Label></span></a>
                            <div id="d3088" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3088">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource11"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource11"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource11"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a3094" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_AdrenalHormones" Text="Adrenal Hormones" runat="server" meta:resourcekey="Rs_AdrenalHormonesResource1"></asp:Label></span></a>
                            <div id="d3094" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3094">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource12"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource12"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource12"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a3111" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_SexSteroids" Text="Sex Steroids" runat="server" meta:resourcekey="Rs_SexSteroidsResource1"></asp:Label></span></a>
                            <div id="d3111" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3111">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource13"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource13"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource13"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a3127" runat="server" visible="False"><span class="label_title">
                                <asp:Label ID="Rs_StoolAnalysis" Text="Stool Analysis" runat="server" meta:resourcekey="Rs_StoolAnalysisResource1"></asp:Label></span></a>
                            <div id="d3127" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt3127">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource14"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource14"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource14"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
