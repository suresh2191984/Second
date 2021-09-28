<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClinicalDisplay.ascx.cs"
    Inherits="Investigation_ClinicalDisplay" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table cellspacing="1" style="height: auto" width="100%" border="0">
    <tr>
        <td>
            <div id="d4001" style="display: none" runat="server">
                <asp:Label Text="ClinicalPathology" runat="server" ID="lblClinic" CssClass="main_title"
                    meta:resourcekey="lblClinicResource1"></asp:Label>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a4002" runat="server" visible="False"><span class="label_subtitle">
                <asp:Label ID="Rs_UrineAnalysis" Text="Urine Analysis" runat="server" meta:resourcekey="Rs_UrineAnalysisResource1"></asp:Label></span></a>
            <div id="d4002" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt4002">
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
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <a id="a4006" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_01 %></span></a>
                            <div id="d4006" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4006">
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
                        <td>
                            <a id="a4013" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_Chemistry" Text="Chemistry" runat="server" meta:resourcekey="Rs_ChemistryResource1"></asp:Label></span></a>
                            <div id="d4013" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4013">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource3"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource3"></asp:Label>
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
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a4025" runat="server" visible="False"><span class="label_subtitle">
                                
                                <asp:Label ID="Rs_UrineMicroscopicExaminations" Text="Urine Microscopic Examinations" runat="server" meta:resourcekey="Rs_UrineMicroscopicExaminationsResource1"></asp:Label></span></a>
                            <div id="d4025" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4025">
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
                        <td>
                            <a id="a4034" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_24hrsUrineSample" Text="24 hrs Urine
                                Sample" runat="server" meta:resourcekey="Rs_24hrsUrineSampleResource1"></asp:Label></span></a>
                            <div id="d4034" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4034">
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
                                                        meta:resourcekey="Uom1004Resource4"></asp:Label>
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
            <a id="a4045" runat="server" visible="False"><span class="label_subtitle">
                <asp:Label ID="Rs_BodyFluidAnalysis" Text="Body Fluid
                Analysis" runat="server" meta:resourcekey="Rs_BodyFluidAnalysisResource1"></asp:Label></span></a>
            <div id="d4045" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt4045">
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
                                        meta:resourcekey="Uom1004Resource5"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
                <table>
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4050" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_Cells" Text="Cells" runat="server" meta:resourcekey="Rs_CellsResource1"></asp:Label></span></a>
                            <div id="d4050" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4050">
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
                                                        meta:resourcekey="Uom1004Resource6"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <a id="a4053" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_02 %></span></a>
                                            <div id="d4053" style="display: none; padding-left: 30px" runat="server">
                                                <asp:Repeater runat="server" ID="rpt4053">
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
                                                                        meta:resourcekey="Uom1004Resource7"></asp:Label>
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
                            <a id="a4059" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_Chemistry1" Text="Chemistry" runat="server" meta:resourcekey="Rs_Chemistry1Resource1"></asp:Label></span></a>
                            <div id="d4059" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4059">
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
                            <a id="a4066" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_03 %></span></a>
                            <div id="d4066" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4066">
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
                            <a id="a4073" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_04 %></span></a>
                            <div id="d4073" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4073">
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
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4078" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_05 %></span></a>
                            <div id="d4078" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4079">
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
        <td>
            <a id="a4082" runat="server" visible="False"><span class="label_subtitle">
                <asp:Label ID="Rs_Serology" Text="Serology" runat="server" meta:resourcekey="Rs_SerologyResource1"></asp:Label></span></a>
            <div id="d4082" style="display: none; padding-left: 30px" runat="server">
                <table>
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4083" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_HIV" Text="HIV" runat="server" meta:resourcekey="Rs_HIVResource1"></asp:Label></span></a>
                            <div id="d4083" style="display: none; padding-left: 30px" runat="server">
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Panel runat="server" ID="pn4084" meta:resourcekey="pn4084Resource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="l4084" CssClass="results" meta:resourcekey="l4084Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="l14084" CssClass="results" meta:resourcekey="l14084Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Panel runat="server" ID="pn4085" meta:resourcekey="pn4085Resource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="l4085" CssClass="results" meta:resourcekey="l4085Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="l14085" CssClass="results" meta:resourcekey="l14085Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <asp:Repeater runat="server" ID="rpt4086">
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
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <asp:Panel runat="server" ID="pn4087" meta:resourcekey="pn4087Resource1">
                                <table style="padding-left: 10px">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lblHead" CssClass="label_subtitle" meta:resourcekey="lblHeadResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Repeater runat="server" ID="rptRubella">
                                                <ItemTemplate>
                                                    <table style="padding-left: 10px">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblName" Text='<%# Bind("Name") %>' CssClass="results"
                                                                    meta:resourcekey="lblNameResource14"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                                    meta:resourcekey="lblResultResource14"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                                    meta:resourcekey="Uom1004Resource10"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lbl4087" CssClass="label_subtitle" meta:resourcekey="lbl4087Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Repeater runat="server" ID="rpt4087">
                                                <ItemTemplate>
                                                    <table style="padding-left: 10px">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblName" Text='<%# Bind("Name") %>' CssClass="results"
                                                                    meta:resourcekey="lblNameResource15"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                                    meta:resourcekey="lblResultResource15"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                                    meta:resourcekey="Uom1004Resource11"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <asp:Panel runat="server" ID="pn4091" meta:resourcekey="pn4091Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="l4091" CssClass="results" meta:resourcekey="l4091Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l14091" CssClass="results" meta:resourcekey="l14091Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l34091" CssClass="results" meta:resourcekey="l34091Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4093" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_06 %></span></a>
                            <div id="d4093" style="display: none; padding-left: 30px" runat="server">
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Panel runat="server" ID="pn4093" meta:resourcekey="pn4093Resource1">
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4096" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_07 %></span></a>
                            <div id="d4096" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4096">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource16"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource16"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Panel runat="server" ID="pn4098" meta:resourcekey="pn4098Resource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="l4098" CssClass="results" meta:resourcekey="l4098Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="l14098" CssClass="results" meta:resourcekey="l14098Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="l24098" CssClass="results" meta:resourcekey="l24098Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="l34098" CssClass="results" meta:resourcekey="l34098Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <a id="a4099" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_08 %></span></a>
                                            <div id="d4099" style="display: none; padding-left: 30px" runat="server">
                                                <asp:Repeater runat="server" ID="rpt4099">
                                                    <ItemTemplate>
                                                        <table style="padding-left: 10px">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                                        meta:resourcekey="lblNameResource17"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                                        meta:resourcekey="lblResultResource17"></asp:Label>
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
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a4102" runat="server" visible="False"><span class="label_subtitle">
                <asp:Label ID="Rs_SemenAnalysis" Text="Semen Analysis" runat="server" meta:resourcekey="Rs_SemenAnalysisResource1"></asp:Label></span></a>
            <div id="d4102" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td style="padding-left: 10px">
                            <a id="a4103" runat="server" visible="False"><span class="label_subtitle">
                                <asp:Label ID="Rs_MacroscopicExamination" Text="Macroscopic
                                Examination" runat="server" meta:resourcekey="Rs_MacroscopicExaminationResource1"></asp:Label></span></a>
                            <div id="d4103" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4103">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource18"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource18"></asp:Label>
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
                        <td style="padding-left: 10px">
                            <a id="a4109" runat="server" visible="False"><span class="label_subtitle"><%=Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_09 %></span></a>
                            <div id="d4109" style="display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt4109">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource19"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource19"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                        meta:resourcekey="Uom1004Resource13"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <a id="a4111" runat="server" visible="False"><span class="label_subtitle">
                                                <asp:Label ID="Rs_Motility" Text="Motility" runat="server" meta:resourcekey="Rs_MotilityResource1"></asp:Label></span></a>
                                            <div id="d4111" style="display: none; padding-left: 30px" runat="server">
                                                <asp:Repeater runat="server" ID="rpt4111">
                                                    <ItemTemplate>
                                                        <table style="padding-left: 10px">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                                        meta:resourcekey="lblNameResource20"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                                        meta:resourcekey="lblResultResource20"></asp:Label>
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
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <a id="a4117" runat="server" visible="False"><span class="label_subtitle">
                                                <asp:Label ID="Rs_Morphology" Text="Morphology" runat="server" meta:resourcekey="Rs_MorphologyResource1"></asp:Label></span></a>
                                            <div id="d4117" style="display: none; padding-left: 30px" runat="server">
                                                <asp:Repeater runat="server" ID="rpt4117">
                                                    <ItemTemplate>
                                                        <table style="padding-left: 10px">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                                        meta:resourcekey="lblNameResource21"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                                        meta:resourcekey="lblResultResource21"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                                                        meta:resourcekey="Uom1004Resource15"></asp:Label>
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
            </div>
        </td>
    </tr>
</table>
