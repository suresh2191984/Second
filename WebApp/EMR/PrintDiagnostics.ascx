<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintDiagnostics.ascx.cs"
    Inherits="EMR_PrintDiagnostics" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script type="text/javascript" src="../Scripts/Common.js"></script>

<table id="tblDia" style="display:none" runat="server" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
            align="center">
            <asp:Label ID="Label1" runat="server" Text="DIAGNOSTICS" 
                meta:resourcekey="Label1Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblDia1" style="display:none" runat="server" width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trECGNill" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 220px">
                        <asp:Label ID="lblECG_2" runat="server" Text="ECG" Font-Bold="True" 
                            meta:resourcekey="lblECG_2Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblECGNill" runat="server" Text=" - " 
                                        meta:resourcekey="lblECGNillResource1"></asp:Label>
                                    <asp:Label ID="lblECGResult_2" runat="server" Visible="False" 
                                        meta:resourcekey="lblECGResult_2Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr id="trEchocard" style="display:none" runat="server">
                    <td valign="top">
                        <asp:Label ID="lblEchocardiogram_3" runat="server" Text="Echocardiogram" 
                            Font-Bold="True" meta:resourcekey="lblEchocardiogram_3Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblECNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblECNilResource1"></asp:Label>
                                    <asp:Label ID="lblMyocardiumAndEF_3" runat="server" Visible="False" 
                                        meta:resourcekey="lblMyocardiumAndEF_3Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblRwma_51" runat="server" Visible="False" 
                                        meta:resourcekey="lblRwma_51Resource1"></asp:Label>
                                    <asp:HiddenField ID="hdnEcho" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblValveAbnormality_5" runat="server" Visible="False" 
                                        meta:resourcekey="lblValveAbnormality_5Resource1"></asp:Label>
                                </td>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOtherLesions_7" runat="server" Visible="False" 
                                            meta:resourcekey="lblOtherLesions_7Resource1"></asp:Label>
                                    </td>
                                </tr>
                        </table>
                    </td>
                </tr>
 
                <tr id="trTreadmill" style="display:none" runat="server">
                    <td valign="top">
                        <asp:Label ID="lblTreadmillTest_4" runat="server" Text="Treadmill Test" 
                            Font-Bold="True" meta:resourcekey="lblTreadmillTest_4Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTTNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTTNilResource1"></asp:Label>
                                    <asp:Label ID="lblTreadmillTestResult_8" runat="server" Visible="False" 
                                        meta:resourcekey="lblTreadmillTestResult_8Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSRECG_9" runat="server" Visible="False" 
                                        meta:resourcekey="lblSRECG_9Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAssociatedSymptoms_10" runat="server" Visible="False" 
                                        meta:resourcekey="lblAssociatedSymptoms_10Resource1"></asp:Label>
                                </td>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMPHR_11" runat="server" Visible="False" 
                                            meta:resourcekey="lblMPHR_11Resource1"></asp:Label>
                                    </td>
                                </tr>
                                <%--  <tr>
                                            <td>
                                              
                                                <asp:Label ID="lblMAHR_12" runat="server" Visible="false"></asp:Label>
                                            </td>                                           
                                        </tr>
                                         <tr>
                                            <td>
                                              
                                                <asp:Label ID="lblWorkLoad_13" runat="server" Visible="false"></asp:Label>
                                            </td>                                           
                                        </tr>--%>
                        </table>
                    </td>
                </tr>

                <tr id="trMPS" style="display:none" runat="server">
                    <td>
                        <asp:Label ID="lblMPS_5" runat="server" Text="Myocardial Perfusion Study " 
                            Font-Bold="True" meta:resourcekey="lblMPS_5Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMPSNil_5" runat="server" Text=" - " 
                                        meta:resourcekey="lblMPSNil_5Resource1"></asp:Label>
                                    <asp:Label ID="lblMPSResult_5" runat="server" Visible="False" 
                                        meta:resourcekey="lblMPSResult_5Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr id="trMVS" style="display:none" runat="server">
                    <td>
                        <asp:Label ID="lblMVS_6" runat="server" Text="Myocardial Viability Study" 
                            Font-Bold="True" meta:resourcekey="lblMVS_6Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMVSNil_6" runat="server" Text=" - " 
                                        meta:resourcekey="lblMVSNil_6Resource1"></asp:Label>
                                    <asp:Label ID="lblMVSresult_6" runat="server" Visible="False" 
                                        meta:resourcekey="lblMVSresult_6Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr id="trCoronary" style="display:none" runat="server">
                    <td>
                        <asp:Label ID="lblCoronaryAngiogram_7" runat="server" Text="Coronary Angiogram "
                            Font-Bold="True" meta:resourcekey="lblCoronaryAngiogram_7Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblCoronaryAngiogramNil_7" runat="server" Text=" - " 
                                        meta:resourcekey="lblCoronaryAngiogramNil_7Resource1"></asp:Label>
                                    <asp:Label ID="lblCoronaryAngiogramResult_7" runat="server" 
                                        meta:resourcekey="lblCoronaryAngiogramResult_7Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
     
                <tr id="trOtherDia" style="display:none" runat="server">
                    <td>
                        <asp:Label ID="lblOtherDiagnostics_8" runat="server" Text="Other Diagnostics  " 
                            Font-Bold="True" meta:resourcekey="lblOtherDiagnostics_8Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOtherDiagnosticsNil_8" runat="server" Text=" - " 
                                        meta:resourcekey="lblOtherDiagnosticsNil_8Resource1"></asp:Label>
                                    <asp:Label ID="lblOtherDiagnosticsResult_8" runat="server" Visible="False" 
                                        meta:resourcekey="lblOtherDiagnosticsResult_8Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
       </table>
        </td>
    </tr>
</table>
<br />
