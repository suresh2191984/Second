<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Profile.ascx.cs" Inherits="Investigation_Profile" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table cellspacing="3" width="100%" border="0" class="investigationtbl">
    <tr valign="top">
        <td style="width: 33%">
            <asp:Panel ID="pnlHematology" runat="server" BackColor="#D1E5F8" meta:resourcekey="pnlHematologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" height="23" align="left" background="../Images/Dialysis_bg.jpg" style="background-repeat: no-repeat"
                            bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus3">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">HEMATOLOGY</span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus3">
                                <img src="../Images/hideBids.gif" alt="hide" align="top" style="cursor: pointer;
                                    height: 17px; width: 19px;" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);"><asp:Label
                                    ID="Rs_HEMATOLOGY" Text="HEMATOLOGY" runat="server" meta:resourcekey="Rs_HEMATOLOGYResource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr id="ACX2responses3" style="display: block;">
                        <td colspan="2" bgcolor="#d1e5f8" style="width: 100%">
                            <table class="defaultfontcolor" border="0" width="100%">
                                <tr>
                                    <td colspan="3" align="left" valign="top" class="investigationfont">
                                        <asp:CheckBox runat="server" ID="chkCompleteHemogram" Text="COMPLETE HEMOGRAM" onclick="SelectHemogram('Profile1_chkCompleteHemogram')"
                                            meta:resourcekey="chkCompleteHemogramResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2002" Text="Hb" onclick="checkHemat()" meta:resourcekey="chk2002Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2032" Text="RBC" onclick="checkHemat()" meta:resourcekey="chk2032Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2014" Text="PCV" onclick="checkHemat()" meta:resourcekey="chk2014Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2033" Text="MCV" onclick="checkHemat()" meta:resourcekey="chk2033Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2035" Text="MCH" onclick="checkHemat()" meta:resourcekey="chk2035Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2034" Text="MCHC" onclick="checkHemat()" meta:resourcekey="chk2034Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2003" Text="TC" onclick="checkHemat()" meta:resourcekey="chk2003Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2005" Text="DC" onclick="checkHemat()" meta:resourcekey="chk2005Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2013" Text="ESR" onclick="checkHemat()" meta:resourcekey="chk2013Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2011" Text="Absolute Eosinophils Count" meta:resourcekey="chk2011Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2012" Text="Reticulocyte Count" onclick="checkHemat()"
                                            meta:resourcekey="chk2012Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2018" Text="Smear Study" meta:resourcekey="chk2018Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2031" Text="Blood Group & Rh Typing" meta:resourcekey="chk2031Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2037" Text="Coombs Test Direct" meta:resourcekey="chk2037Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2038" Text="Coombs Test Indirect" meta:resourcekey="chk2038Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk2055" Text="QBC for MP & MF" meta:resourcekey="chk2055Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlSerology" runat="server" CssClass="fon" BackColor="#D1E5F8" meta:resourcekey="pnlSerologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus4">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);"><asp:Label
                                    ID="Rs_SEROLOGY" Text="SEROLOGY" runat="server" meta:resourcekey="Rs_SEROLOGYResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus4">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);"><asp:Label
                                    ID="Rs_SEROLOGY1" Text="SEROLOGY" runat="server" meta:resourcekey="Rs_SEROLOGY1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" class="tablerow" id="ACX2responses4" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top" style="background-image: url(../Images/whitebg.png)">
                                        <asp:CheckBox runat="server" ID="chkSerology" Text="SEROLOGY" onclick="SelectSerology('Profile1_chkSerology')"
                                            CssClass="colorforcontent" meta:resourcekey="chkSerologyResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4121" Text="Widal" onclick="checkSerology()"
                                            meta:resourcekey="chk4121Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4089" Text="VDRL" onclick="checkSerology()" meta:resourcekey="chk4089Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4092" Text="TPHA" onclick="checkSerology()" meta:resourcekey="chk4092Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4091" Text="ASO Titer" onclick="checkSerology()"
                                            meta:resourcekey="chk4091Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4090" Text="Rheumatoid Factor" onclick="checkSerology()"
                                            meta:resourcekey="chk4090Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4084" Text="HIV I & II(ELISA)" onclick="checkSerology()"
                                            meta:resourcekey="chk4084Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4088" Text="Leptospira I<sub>g</sub>M ELISA"
                                            onclick="checkSerology()" meta:resourcekey="chk4088Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4087" Text="Leptospira I<sub>g</sub>G ELISA"
                                            onclick="checkSerology()" meta:resourcekey="chk4087Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlHepatitisPanel" runat="server" CssClass="fon" BackColor="#D1E5F8"
                meta:resourcekey="pnlHepatitisPanelResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus8">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus8','ACX2minus8','ACX2responses8',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus8','ACX2minus8','ACX2responses8',1);"><asp:Label
                                    ID="Rs_HEPATITISPANEL" Text="HEPATITIS PANEL" runat="server" meta:resourcekey="Rs_HEPATITISPANELResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus8">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus8','ACX2minus8','ACX2responses8',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus8','ACX2minus8','ACX2responses8',0);">
                                    <asp:Label ID="Rs_HEPATITISPANEL1" Text="HEPATITIS PANEL" runat="server" meta:resourcekey="Rs_HEPATITISPANEL1Resource1"></asp:Label>
                                </span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses8" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top" style="background-image: url(../Images/whitebg.png)">
                                        <asp:CheckBox runat="server" ID="chkHepatitis" Text="Hepatitis" onclick="SelectHepatitis('Profile1_chkHepatitis')"
                                            CssClass="colorforcontent" meta:resourcekey="chkHepatitisResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4127" Text="HbsAg(ELISA)" onclick="checkHepatitis()"
                                            meta:resourcekey="chk4127Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4128" Text="Anti HBs" onclick="checkHepatitis()"
                                            meta:resourcekey="chk4128Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4129" Text="HCV" onclick="checkHepatitis()" meta:resourcekey="chk4129Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4132" Text="HAV" onclick="checkHepatitis()" meta:resourcekey="chk4132Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4134" Text="Anti HBc" onclick="checkHepatitis()"
                                            meta:resourcekey="chk4134Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <br />
            <br />
            <asp:Panel ID="pnlMotion" runat="server" CssClass="fon" BackColor="#D1E5F8" meta:resourcekey="pnlMotionResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus9">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',1);"><asp:Label
                                    ID="Rs_MOTION" Text="MOTION" runat="server" meta:resourcekey="Rs_MOTIONResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus9">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',0);"><asp:Label
                                    ID="Rs_MOTION1" Text="MOTION" runat="server" meta:resourcekey="Rs_MOTION1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses9" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk3128" Text="Routine Analysis" meta:resourcekey="chk3128Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk3137" Text="Reducing Substance" meta:resourcekey="chk3137Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk3131" Text="Occult Blood" meta:resourcekey="chk3131Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlTorchPanel" runat="server" CssClass="fon" BackColor="#D1E5F8" meta:resourcekey="pnlTorchPanelResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus2">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"><asp:Label
                                    ID="Rs_TORCHPANEL" Text="TORCH
                                    PANEL" runat="server" meta:resourcekey="Rs_TORCHPANELResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus2">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"><asp:Label
                                    ID="Rs_TORCHPANEL1" Text="TORCH  PANEL" runat="server" meta:resourcekey="Rs_TORCHPANEL1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses2" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top" class="investigationfont">
                                        <asp:CheckBox runat="server" ID="chkTorchpanel" Text="TORCHPANEL" onclick="SelectPanel('Profile1_chkTorchpanel')"
                                            meta:resourcekey="chkTorchpanelResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk1008" Text="Toxoplasma I<sub>g</sub>G & I<sub>g</sub>M"
                                            onclick="checkTorch()" meta:resourcekey="chk1008Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk1005" Text="Rubella I<sub>g</sub>G & I<sub>g</sub>M"
                                            onclick="checkTorch()" meta:resourcekey="chk1005Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk1006" Text="CMV I<sub>g</sub>G & I<sub>g</sub>M"
                                            onclick="checkTorch()" meta:resourcekey="chk1006Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk1010" Text="HSV I & II I<sub>g</sub>G & I<sub>g</sub>M"
                                            onclick="checkTorch()" meta:resourcekey="chk1010Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
        <td style="width: 33%">
            <asp:Panel ID="pnlBioChemistry" runat="server" CssClass="fon" BackColor="#D1E5F8"
                meta:resourcekey="pnlBioChemistryResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus5">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);"><asp:Label
                                    ID="Rs_BIOCHEMISTRY" Text="BIO
                                    CHEMISTRY" runat="server" meta:resourcekey="Rs_BIOCHEMISTRYResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus5">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);"><asp:Label
                                    ID="Rs_BIOCHEMISTRY1" Text="BIO CHEMISTRY" runat="server" meta:resourcekey="Rs_BIOCHEMISTRY1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses5" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td>
                                        <asp:Label runat="server" ID="chkBloodSugar" Text="Blood Sugar" meta:resourcekey="chkBloodSugarResource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3012" Text="F" meta:resourcekey="chk3012Resource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3013" Text="PP" meta:resourcekey="chk3013Resource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3011" Text="R" meta:resourcekey="chk3011Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chkGlycosylatedHb" Text="Glycosylated Hb" meta:resourcekey="chkGlycosylatedHbResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3018" Text="Blood Urea" meta:resourcekey="chk3018Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3021" Text="Creatinine" meta:resourcekey="chk3021Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3064" Text="Uric Acid" meta:resourcekey="chk3064Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3053" Text="Total Cholesterol" meta:resourcekey="chk3053Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3055" Text="HDL Cholesterol" meta:resourcekey="chk3055Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3054" Text="LDL Cholesterol" meta:resourcekey="chk3054Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3056" Text="VLDL Cholesterol" meta:resourcekey="chk3056Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3057" Text="Triglycerides" meta:resourcekey="chk3057Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3007" Text="Calcium" meta:resourcekey="chk3007Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3008" Text="Phosphorous" meta:resourcekey="chk3008Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="investigationfont">
                                        <asp:CheckBox runat="server" ID="chkElectrolyte" Text="ELECTROLYTE" onclick="SelectElectrolyte('Profile1_chkElectrolyte')"
                                            meta:resourcekey="chkElectrolyteResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3003" Text="Na" onclick="checkElectro()" meta:resourcekey="chk3003Resource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3004" Text="K" onclick="checkElectro()" meta:resourcekey="chk3004Resource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk3005" Text="Cl" onclick="checkElectro()" meta:resourcekey="chk3005Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3032" Text="Bilirubin(Total)" meta:resourcekey="chk3032Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3033" Text="Bilirubin(Direct)" meta:resourcekey="chk3033Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3040" Text="SGOT" meta:resourcekey="chk3040Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3041" Text="SGPT" meta:resourcekey="chk3041Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3042" Text="Alkaline Phosphatase" meta:resourcekey="chk3042Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3043" Text="Gamma GT" meta:resourcekey="chk3043Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3036" Text="Total Protein" meta:resourcekey="chk3036Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3037" Text="Albumin" meta:resourcekey="chk3037Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3038" Text="Globulin" meta:resourcekey="chk3038Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3039" Text="A/G Ratio" meta:resourcekey="chk3039Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox runat="server" ID="chk3048" Text="CPK - Total" meta:resourcekey="chk3048Resource1" />
                                    </td>
                                    <td colspan="2">
                                        <asp:CheckBox runat="server" ID="chk3049" Text="CPK - MB" meta:resourcekey="chk3049Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3051" Text="LDH" meta:resourcekey="chk3051Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3060" Text="Anoylase" meta:resourcekey="chk3060Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3070" Text="Lipase" meta:resourcekey="chk3070Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox runat="server" ID="chk3044" Text="Acid Phosphatase" meta:resourcekey="chk3044Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlImmunology" runat="server" CssClass="fon" meta:resourcekey="pnlImmunologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus7">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);"><asp:Label
                                    ID="Rs_IMMUNOLOGY" Text="IMMUNOLOGY" runat="server" meta:resourcekey="Rs_IMMUNOLOGYResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus7">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);"><asp:Label
                                    ID="Rs_IMMUNOLOGY1" Text="IMMUNOLOGY" runat="server" meta:resourcekey="Rs_IMMUNOLOGY1Resource1"></asp:Label>
                                </span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses7" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4097" Text="ANA" meta:resourcekey="chk4097Resource1" />
                                    </td>
                                    <td colspan="2" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4098" Text="ds DNA" meta:resourcekey="chk4098Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4070" Text="Anti TB I<sub>g</sub>G" meta:resourcekey="chk4070Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4071" Text="Anti TB I<sub>g</sub>M" meta:resourcekey="chk4071Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4072" Text="Anti TB I<sub>g</sub>A" meta:resourcekey="chk4072Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlOthers" runat="server" CssClass="fon" meta:resourcekey="pnlOthersResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus12">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus12','ACX2minus12','ACX2responses12',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus12','ACX2minus12','ACX2responses12',1);"><asp:Label
                                    ID="Rs_OTHERS" Text="OTHERS" runat="server" meta:resourcekey="Rs_OTHERSResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus12">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus12','ACX2minus12','ACX2responses12',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus12','ACX2minus12','ACX2responses12',0);"><asp:Label
                                    ID="Rs_OTHERS1" Text="OTHERS" runat="server" meta:resourcekey="Rs_OTHERS1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses12" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4104" Text="SEMEN ANALYSIS" meta:resourcekey="chk4104Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkXRay" Text="X RAY" meta:resourcekey="chkXRayResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkAltraSound" Text="ULTRA SOUND" meta:resourcekey="chkAltraSoundResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkECGComputerized" Text="ECG Computerized" meta:resourcekey="chkECGComputerizedResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkTreadMill" Text="TREAD MILL" meta:resourcekey="chkTreadMillResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkEcho" Text="ECHO" meta:resourcekey="chkEchoResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
        <td style="width: 33%">
            <asp:Panel ID="pnlClinicalPathology" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlClinicalPathologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus6">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);"><asp:Label
                                    ID="Rs_CLINICALPATHOLOGY1" Text="CLINICALPATHOLOGY" runat="server" meta:resourcekey="Rs_CLINICALPATHOLOGY1Resource1"></asp:Label>
                                </span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus6">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);"><asp:Label
                                    ID="Rs_CLINICALPATHOLOGY" Text="CLINICAL
                                    PATHOLOGY" runat="server" meta:resourcekey="Rs_CLINICALPATHOLOGYResource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses6" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4003" Text="Urine Routine Analysis" meta:resourcekey="chk4003Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4018" Text="Urine Bile salt & Bile Pigment" meta:resourcekey="chk4018Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk3126" Text="Urine for Pregnancy Test" meta:resourcekey="chk3126Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4017" Text="Urine for Acetone" meta:resourcekey="chk4017Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4015" Text="Microalbuminiuria" meta:resourcekey="chk4015Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4035" Text="24 hrs Urine Protein" meta:resourcekey="chk4035Resource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlCoagulationProfile" runat="server" CssClass="fon" BackColor="#D1E5F8"
                meta:resourcekey="pnlCoagulationProfileResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus10">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);"><asp:Label
                                    ID="Rs_COAGULATIONPROFILE" Text="COAGULATION
                                    PROFILE" runat="server" meta:resourcekey="Rs_COAGULATIONPROFILEResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus10">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);"><asp:Label
                                    ID="Rs_COAGULATIONPROFILE1" Text="COAGULATION PROFILE" runat="server" meta:resourcekey="Rs_COAGULATIONPROFILE1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses10" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top" class="investigationfont">
                                        <asp:CheckBox runat="server" ID="chkCoagulation" Text="COAGULATION PROFILE" onclick="SelectCoagulate('Profile1_chkCoagulation')"
                                            meta:resourcekey="chkCoagulationResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkPlateletCount" Text="Platelet Count" onclick="checkCoagulate()"
                                            meta:resourcekey="chkPlateletCountResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkBleedingTime" Text="Bleeding Time" onclick="checkCoagulate()"
                                            meta:resourcekey="chkBleedingTimeResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkClottingTime" Text="Clotting Time" onclick="checkCoagulate()"
                                            meta:resourcekey="chkClottingTimeResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkProthrombinTimeINR" Text="Prothrombin Time & INR"
                                            onclick="checkCoagulate()" meta:resourcekey="chkProthrombinTimeINRResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkAPTT" Text="APTT" onclick="checkCoagulate()"
                                            meta:resourcekey="chkAPTTResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlMicrobiology" runat="server" CssClass="fon" meta:resourcekey="pnlMicrobiologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus13">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus13','ACX2minus13','ACX2responses13',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus13','ACX2minus13','ACX2responses13',1);"><asp:Label
                                    ID="Rs_MICROBIOLOGY" Text="MICROBIOLOGY" runat="server" meta:resourcekey="Rs_MICROBIOLOGYResource1"></asp:Label></span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus13">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus13','ACX2minus13','ACX2responses13',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus13','ACX2minus13','ACX2responses13',0);"><asp:Label
                                    ID="Rs_MICROBIOLOGY1" Text="MICROBIOLOGY" runat="server" meta:resourcekey="Rs_MICROBIOLOGY1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses13" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkGramsStam" Text="Grams Stain" meta:resourcekey="chkGramsStamResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkKOHMount" Text="KOH Mount" meta:resourcekey="chkKOHMountResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel ID="pnlEndocrinology" runat="server" CssClass="fon" BackColor="#D1E5F8"
                meta:resourcekey="pnlEndocrinologyResource1">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus11">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',1);"><asp:Label
                                    ID="Rs_ENDOCRINOLOGY" Text="ENDOCRINOLOGY" runat="server" meta:resourcekey="Rs_ENDOCRINOLOGYResource1"></asp:Label></span></font></strong></div>
                            <div style="display: block" id="ACX2minus11">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',0);"><asp:Label
                                    ID="Rs_ENDOCRINOLOGY1" Text="ENDOCRINOLOGY" runat="server" meta:resourcekey="Rs_ENDOCRINOLOGY1Resource1"></asp:Label></span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses11" style="display: block">
                        <td colspan="2" bgcolor="#d1e5f8">
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkT3" Text="T3" meta:resourcekey="chkT3Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkT4" Text="T4" meta:resourcekey="chkT4Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkTSH" Text="TSH" meta:resourcekey="chkTSHResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkFreeT3" Text="Free T3" meta:resourcekey="chkFreeT3Resource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkFreeT4" Text="Free T4" meta:resourcekey="chkFreeT4Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkLH" Text="LH" meta:resourcekey="chkLHResource1" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkFSH" Text="FSH" meta:resourcekey="chkFSHResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkProlactin" Text="Prolactin" meta:resourcekey="chkProlactinResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkEstradiol" Text="Estradiol" meta:resourcekey="chkEstradiolResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkProgesterone" Text="Progesterone" meta:resourcekey="chkProgesteroneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk17OHProgesterone" Text="17 OH Progesterone" meta:resourcekey="chk17OHProgesteroneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkTestosterone" Text="Testosterone" meta:resourcekey="chkTestosteroneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkFreeTestosterone" Text="Free Testosterone" meta:resourcekey="chkFreeTestosteroneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkDihydrotestosterone" Text="Dihydrotestosterone"
                                            meta:resourcekey="chkDihydrotestosteroneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkGrowthHormone" Text="Growth Hormone" meta:resourcekey="chkGrowthHormoneResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkACTH" Text="ACTH" meta:resourcekey="chkACTHResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chkBetaHCG" Text="Beta HCG" meta:resourcekey="chkBetaHCGResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <%--<asp:Panel ID="pnlImmunology" runat="server" CssClass="fon" BackColor="#d1e5f8">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#f3faff" class="tablerow">
                        <td colspan="2" width="238" height="23" align="left" background="../Images/Dialysis_bg.jpg"
                            style="background-repeat: no-repeat" bgcolor="#f3faff">
                            <div style="display: none" id="ACX2plus7">
                                <img src="../Images/showBids.gif" alt="Show" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);">IMMUNOLOGY</span></font></strong>
                            </div>
                            <div style="display: block" id="ACX2minus7">
                                <img src="../Images/hideBids.gif" alt="hide" height="15" align="top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);" />
                                <strong><font color="white">&nbsp;<span style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);">IMMUNOLOGY</span></font></strong>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses7" style="display: block">
                        <td colspan="2" bgcolor="#e8fffb"  >
                            <table class="defaultfontcolor">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4097"  Text="ANA" />
                                    </td>
                                    <td colspan="2" align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4098"  Text="ds DNA" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4070"  Text="Anti TB I<sub>g</sub>G" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4071"  Text="Anti TB I<sub>g</sub>M" />
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:CheckBox runat="server" ID="chk4072"  Text="Anti TB I<sub>g</sub>A" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>--%>
        </td>
    </tr>
    <tr>
        <td style="width: 33%">
            &nbsp;
        </td>
        <td style="width: 33%">
            <asp:Label runat="server" ID="lblMsg" CssClass="errormsg" meta:resourcekey="lblMsgResource1"></asp:Label>
        </td>
        <td nowrap="nowrap" class="fon" style="width: 33%">
            &nbsp;
        </td>
    </tr>
    </td> </tr>
</table>
