<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DialysisCaseSheet.ascx.cs"
    Inherits="CommonControls_DialysisCaseSheet" %>
<%@ Register Src="PatientPrescription.ascx" TagName="PatientPrescription" TagPrefix="uc6" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
<div id="divDialysisCaseSheet" runat="server" height="100%" width="100%">
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="2" class="defaultfontcolor">
        <tr>
            <td>
                <asp:Panel ID="pnlRec" runat="server" GroupingText="Dialysis Record" BorderStyle="Double"
                    BorderWidth="1px" BorderColor="Black" Width="100%" meta:resourcekey="pnlRecResource1">
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <table width="100%" border="0">
                                    <tr>
                                        <td class="mediumfon" align="right">
                                            <asp:Label ID="Rs_HDNo" runat="server" Text="HD No. :" meta:resourcekey="Rs_HDNoResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblHDNo" runat="server" meta:resourcekey="lblHDNoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="mediumfon" align="right">
                                            <asp:Label ID="Rs_Date" runat="server" Text="Date :" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblToday" runat="server" meta:resourcekey="lblTodayResource1"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="mediumfon" align="right">
                                            <asp:Label ID="Rs_StartTime" runat="server" Text="Start Time :" meta:resourcekey="Rs_StartTimeResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblStartTime" runat="server" meta:resourcekey="lblStartTimeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="mediumfon" align="right">
                                            <asp:Label ID="Rs_EndTime" runat="server" Text="End Time :" meta:resourcekey="Rs_EndTimeResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblEndTime" runat="server" meta:resourcekey="lblEndTimeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlDialysis" runat="server" GroupingText="Dialysis Data" BorderStyle="Double"
                    BorderWidth="1px" BorderColor="Black" Height="273px" Width="100%" meta:resourcekey="pnlDialysisResource1">
                    <table style="width: 100%" border="1" class="defaultfontcolor">
                        <tr>
                            <td align="center">
                                <table width="100%" border="1" style="border: [double][1][Black]">
                                    <tr>
                                        <th colspan="2" align="center" class="mediumfon">
                                            <asp:Label ID="Rs_PREDIALYSIS" runat="server" Text="PRE-DIALYSIS" meta:resourcekey="Rs_PREDIALYSISResource1"></asp:Label>
                                        </th>
                                        <th colspan="2" align="center" class="mediumfon">
                                            <asp:Label ID="Rs_POSTDIALYSIS" runat="server" Text="POST-DIALYSIS" meta:resourcekey="Rs_POSTDIALYSISResource1"></asp:Label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_SBP1" runat="server" Text="SBP" meta:resourcekey="Rs_SBP1Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreSBP" meta:resourcekey="lblPreSBPResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPreSBPUOMCode" runat="server" meta:resourcekey="lblPreSBPUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_SBP2" runat="server" Text="SBP" meta:resourcekey="Rs_SBP2Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostSBP" meta:resourcekey="lblPostSBPResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPostSBPUOMCode" runat="server" meta:resourcekey="lblPostSBPUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="DBP1" runat="server" Text="DBP" meta:resourcekey="DBP1Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreDBP" meta:resourcekey="lblPreDBPResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPreDBPUOMCode" runat="server" meta:resourcekey="lblPreDBPUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_DBP2" runat="server" Text="DBP" meta:resourcekey="Rs_DBP2Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostDBP" meta:resourcekey="lblPostDBPResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPostDBPUOMCode" runat="server" meta:resourcekey="lblPostDBPUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Temp1" runat="server" Text="Temp" meta:resourcekey="Rs_Temp1Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreTemp" meta:resourcekey="lblPreTempResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPreTempUOMCode" runat="server" meta:resourcekey="lblPreTempUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Temp2" runat="server" Text="Temp" meta:resourcekey="Rs_Temp2Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostTemp" meta:resourcekey="lblPostTempResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" runat="server" ID="lblPostTempUOMCode" meta:resourcekey="lblPostTempUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Pulse1" runat="server" Text="Pulse" meta:resourcekey="Rs_Pulse1Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPrePulse" meta:resourcekey="lblPrePulseResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPrePulseUOMCode" runat="server" meta:resourcekey="lblPrePulseUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Pulse" runat="server" Text="Pulse" meta:resourcekey="Rs_PulseResource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostPulse" meta:resourcekey="lblPostPulseResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPostPulseUOMCode" runat="server" meta:resourcekey="lblPostPulseUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Weight1" runat="server" Text="Weight" meta:resourcekey="Rs_Weight1Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreWeight" meta:resourcekey="lblPreWeightResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPreWeightUOMCode" runat="server" meta:resourcekey="lblPreWeightUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Weight2" runat="server" Text="Weight" meta:resourcekey="Rs_Weight2Resource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostWeight" meta:resourcekey="lblPostWeightResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPostWeightUOMCode" runat="server" meta:resourcekey="lblPostWeightUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_WeightGain" runat="server" Text="Weight Gain" meta:resourcekey="Rs_WeightGainResource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreWtGain" meta:resourcekey="lblPreWtGainResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" runat="server" ID="lblWtGain" meta:resourcekey="lblWtGainResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_UF" runat="server" Text="UF" meta:resourcekey="Rs_UFResource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPostUF" meta:resourcekey="lblPostUFResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" runat="server" ID="lblPostUFUOMCode" meta:resourcekey="lblPostUFUOMCodeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Heparin" runat="server" Text="Heparin" meta:resourcekey="Rs_HeparinResource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblPreHeparin" meta:resourcekey="lblPreHeparinResource1"></asp:Label>
                                            <asp:Label CssClass="smallfon" ID="lblPreHeparinUOMCode" runat="server" meta:resourcekey="lblPreHeparinUOMCodeResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Dialyzer" runat="server" Text="Dialyzer" meta:resourcekey="Rs_DialyzerResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDialyzer" runat="server" meta:resourcekey="lblDialyzerResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_Access" runat="server" Text="Access" meta:resourcekey="Rs_AccessResource1"></asp:Label>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:Label ID="lblAccessSide" runat="server" meta:resourcekey="lblAccessSideResource1"></asp:Label>
                                            <asp:Label ID="lblAccessSite" runat="server" meta:resourcekey="lblAccessSiteResource1"></asp:Label>
                                        </td>
                                        <td class="mediumfon" align="left">
                                            <asp:Label ID="Rs_BTS" runat="server" Text="BTS" meta:resourcekey="Rs_BTSResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblBTS" meta:resourcekey="lblBTSResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="mediumfon">
                                            <asp:Label ID="Rs_TreatmentBedandMachineName" Text="Treatment Bed/Machine Name" runat="server"
                                                meta:resourcekey="Rs_TreatmentBedandMachineNameResource1" />
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblMachineName" meta:resourcekey="lblMachineNameResource1"></asp:Label>
                                        </td>
                                        <td align="left" class="mediumfon">
                                            <asp:Label ID="Rs_OtherDrugs" runat="server" Text="Other Drugs" meta:resourcekey="Rs_OtherDrugsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRemarks" runat="server" meta:resourcekey="lblRemarksResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="mediumfon">
                                            <asp:Label ID="Rs_DryWeight" Text="DryWeight" runat="server" meta:resourcekey="Rs_DryWeightResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDryWeight" runat="server" meta:resourcekey="lblDryWeightResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlFb" runat="server" GroupingText="Complications" BorderStyle="Double"
                    BorderWidth="1px" BorderColor="Black" Width="100%" meta:resourcekey="pnlFbResource1">
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <table border="1" width="100%">
                                    <tr>
                                        <th class="mediumfon">
                                            <asp:Label ID="Rs_General" runat="server" Text="General" meta:resourcekey="Rs_GeneralResource1"></asp:Label>
                                        </th>
                                        <th class="mediumfon">
                                            <asp:Label ID="Rs_AccessSite" runat="server" Text="Access Site" meta:resourcekey="Rs_AccessSiteResource1"></asp:Label>
                                        </th>
                                        <th class="mediumfon">
                                            <asp:Label ID="Rs_MachineRelated" runat="server" Text="Machine Related" meta:resourcekey="Rs_MachineRelatedResource1"></asp:Label>
                                        </th>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td align="left" valign="top" nowrap="nowrap">
                                            <asp:BulletedList BulletStyle="Numbered" ID="bltG" runat="server" meta:resourcekey="bltGResource1">
                                            </asp:BulletedList>
                                            <asp:Label runat="server" ID="lblbltG" Text="-NIL-" meta:resourcekey="lblbltGResource1"></asp:Label>
                                        </td>
                                        <td align="left" valign="top" nowrap="nowrap">
                                            <asp:BulletedList BulletStyle="Numbered" ID="bltA" runat="server" meta:resourcekey="bltAResource1">
                                            </asp:BulletedList>
                                            <asp:Label runat="server" ID="lblbltA" Text="-NIL-" meta:resourcekey="lblbltAResource1"></asp:Label>
                                        </td>
                                        <td align="left" valign="top" nowrap="nowrap">
                                            <asp:BulletedList BulletStyle="Numbered" ID="bltM" runat="server" meta:resourcekey="bltMResource1">
                                            </asp:BulletedList>
                                            <asp:Label runat="server" ID="lblbltM" Text="-NIL-" meta:resourcekey="lblbltMResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr align="left">
            <td>
                <uc6:PatientPrescription runat="server" ID="Treatment" />
            </td>
        </tr>
    </table>
    <br />
    <asp:Panel ID="pnlNextHD" runat="server" BorderStyle="Double" BorderWidth="1px" BorderColor="Black"
        Width="100%" meta:resourcekey="pnlNextHDResource1">
        <table border="0">
            <tr>
                <td class="mediumfon">
                    <asp:Label ID="Rs_NextHDDate" runat="server" Text="Next HD Date :" meta:resourcekey="Rs_NextHDDateResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblNextHD" runat="server" meta:resourcekey="lblNextHDResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="mediumfon">
                    <asp:Label ID="Rs_Comments" Text="Comments" runat="server" meta:resourcekey="Rs_CommentsResource1" />:
                </td>
                <td>
                    <asp:Label ID="lblComments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:Panel ID="Panel1" runat="server" CssClass="defaultfontcolor" meta:resourcekey="Panel1Resource1">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:GridView ID="grdOnFlowDialysis" runat="server" AllowPaging="True" CellPadding="4"
                        Width="100%" Font-Size="Small" Font-Bold="False" meta:resourcekey="grdOnFlowDialysisResource1">
                        <HeaderStyle CssClass="defaultfontcolor" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
</div>
