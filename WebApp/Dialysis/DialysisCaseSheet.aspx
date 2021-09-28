<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DialysisCaseSheet.aspx.cs"
    Inherits="Dialysis_DialysisCaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="PatientPrescription"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Receipt.ascx" TagName="Receipt" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Dialysis CaseSheet</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .style2
        {
            height: 17px;
        }
        .style3
        {
            height: 25px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="frmDialysisCS" runat="server" defaultbutton="btnSubmit">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="mediumfon">
                                    Patient Name :
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblPatientName" runat="server" CssClass="defaultfontcolor" 
                                        meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="mediumfon">
                                    Age :
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblAge" runat="server" CssClass="defaultfontcolor" 
                                        meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlRec" runat="server" CssClass="defaultfontcolor" GroupingText="Dialysis Record"
                            BorderStyle="Double" BorderWidth="1px" BorderColor="Black" 
                            meta:resourcekey="pnlRecResource1">
                            <table width="100%">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <table width="85%" border="0">
                                            <tr>
                                                <td class="mediumfon" align="right">
                                                    <asp:Label ID="Rs_HDNo" Text="HD No. :" runat="server" 
                                                        meta:resourcekey="Rs_HDNoResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label CssClass="defaultfontcolor" ID="lblHDNo" runat="server" 
                                                        meta:resourcekey="lblHDNoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td class="mediumfon" align="right">
                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" 
                                                        meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label CssClass="defaultfontcolor" ID="lblToday" runat="server" 
                                                        meta:resourcekey="lblTodayResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td class="mediumfon" align="right">
                                                    <asp:Label ID="Rs_StartTime" Text="Start Time :" runat="server" 
                                                        meta:resourcekey="Rs_StartTimeResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label CssClass="defaultfontcolor" ID="lblStartTime" runat="server" 
                                                        meta:resourcekey="lblStartTimeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td class="mediumfon" align="right">
                                                    <asp:Label ID="Rs_EndTime" Text="End Time:" runat="server" 
                                                        meta:resourcekey="Rs_EndTimeResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label CssClass="defaultfontcolor" ID="lblEndTime" runat="server" 
                                                        meta:resourcekey="lblEndTimeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlDialysis" runat="server" CssClass="defaultfontcolor" GroupingText="Dialysis Data"
                            BorderStyle="Double" BorderWidth="1px" BorderColor="Black" 
                            meta:resourcekey="pnlDialysisResource1">
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <table width="75%" border="1" style="border: [double][1][Black]">
                                            <tr>
                                                <th colspan="2" align="center" class="mediumfon">
                                                    <asp:Label ID="Rs_PREDIALYSIS" Text="PRE-DIALYSIS" runat="server" 
                                                        meta:resourcekey="Rs_PREDIALYSISResource1"></asp:Label>
                                                </th>
                                                <th colspan="2" align="center" class="mediumfon">
                                                    <asp:Label ID="Rs_POSTDIALYSIS" Text="POST-DIALYSIS" runat="server" 
                                                        meta:resourcekey="Rs_POSTDIALYSISResource1"></asp:Label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td class="caseDialysis" align="left">
                                                    <asp:Label ID="Rs_SBP" Text="SBP" runat="server" 
                                                        meta:resourcekey="Rs_SBPResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" class="style2">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreSBP" 
                                                        meta:resourcekey="lblPreSBPResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPreSBPUOMCode" runat="server" 
                                                        meta:resourcekey="lblPreSBPUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="caseDialysis" align="left">
                                                    <asp:Label ID="Rs_SBP1" Text="SBP" runat="server" 
                                                        meta:resourcekey="Rs_SBP1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" class="style2">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostSBP" 
                                                        meta:resourcekey="lblPostSBPResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPostSBPUOMCode" runat="server" 
                                                        meta:resourcekey="lblPostSBPUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_DBP" Text="DBP" runat="server" 
                                                        meta:resourcekey="Rs_DBPResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreDBP" 
                                                        meta:resourcekey="lblPreDBPResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPreDBPUOMCode" runat="server" 
                                                        meta:resourcekey="lblPreDBPUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_DBP1" Text="DBP" runat="server" 
                                                        meta:resourcekey="Rs_DBP1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostDBP" 
                                                        meta:resourcekey="lblPostDBPResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPostDBPUOMCode" runat="server" 
                                                        meta:resourcekey="lblPostDBPUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Temp" Text="Temp" runat="server" 
                                                        meta:resourcekey="Rs_TempResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreTemp" 
                                                        meta:resourcekey="lblPreTempResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPreTempUOMCode" runat="server" 
                                                        meta:resourcekey="lblPreTempUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Temp1" Text="Temp" runat="server" 
                                                        meta:resourcekey="Rs_Temp1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostTemp" 
                                                        meta:resourcekey="lblPostTempResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" runat="server" ID="lblPostTempUOMCode" 
                                                        meta:resourcekey="lblPostTempUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style3" align="left">
                                                    <asp:Label ID="Rs_Pulse" Text="Pulse" runat="server" 
                                                        meta:resourcekey="Rs_PulseResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" class="style3">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPrePulse" 
                                                        meta:resourcekey="lblPrePulseResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPrePulseUOMCode" runat="server" 
                                                        meta:resourcekey="lblPrePulseUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="style3" align="left">
                                                    <asp:Label ID="Rs_Pulse1" Text="Pulse" runat="server" 
                                                        meta:resourcekey="Rs_Pulse1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" class="style3">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostPulse" 
                                                        meta:resourcekey="lblPostPulseResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPostPulseUOMCode" runat="server" 
                                                        meta:resourcekey="lblPostPulseUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Weight" Text="Weight" runat="server" 
                                                        meta:resourcekey="Rs_WeightResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreWeight" 
                                                        meta:resourcekey="lblPreWeightResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPreWeightUOMCode" runat="server" 
                                                        meta:resourcekey="lblPreWeightUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Weight1" Text="Weight" runat="server" 
                                                        meta:resourcekey="Rs_Weight1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostWeight" 
                                                        meta:resourcekey="lblPostWeightResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPostWeightUOMCode" runat="server" 
                                                        meta:resourcekey="lblPostWeightUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_WeightGain" Text="Weight Gain" runat="server" 
                                                        meta:resourcekey="Rs_WeightGainResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreWtGain" 
                                                        meta:resourcekey="lblPreWtGainResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" runat="server" ID="lblWtGain" 
                                                        meta:resourcekey="lblWtGainResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_UF" Text="UF" runat="server" 
                                                        meta:resourcekey="Rs_UFResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPostUF" 
                                                        meta:resourcekey="lblPostUFResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" runat="server" ID="lblPostUFUOMCode" 
                                                        meta:resourcekey="lblPostUFUOMCodeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Heparin" Text="Heparin" runat="server" 
                                                        meta:resourcekey="Rs_HeparinResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblPreHeparin" 
                                                        meta:resourcekey="lblPreHeparinResource1"></asp:Label>
                                                    <asp:Label CssClass="smallfon" ID="lblPreHeparinUOMCode" runat="server" 
                                                        meta:resourcekey="lblPreHeparinUOMCodeResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Dialyzer" Text="Dialyzer" runat="server" 
                                                        meta:resourcekey="Rs_DialyzerResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="defaultfontcolor" ID="lblDialyzer" runat="server" 
                                                        meta:resourcekey="lblDialyzerResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_Access" Text="Access" runat="server" 
                                                        meta:resourcekey="Rs_AccessResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblAccessSide" runat="server" CssClass="defaultfontcolor" 
                                                        meta:resourcekey="lblAccessSideResource1"></asp:Label>
                                                    <asp:Label ID="lblAccessSite" runat="server" CssClass="defaultfontcolor" 
                                                        meta:resourcekey="lblAccessSiteResource1"></asp:Label>
                                                </td>
                                                <td class="mediumfon" align="left">
                                                    <asp:Label ID="Rs_BTS" Text="BTS" runat="server" 
                                                        meta:resourcekey="Rs_BTSResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="defaultfontcolor" runat="server" ID="lblBTS" 
                                                        meta:resourcekey="lblBTSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlFb" runat="server" CssClass="defaultfontcolor" GroupingText="Complications"
                            BorderStyle="Double" BorderWidth="1px" BorderColor="Black" 
                            meta:resourcekey="pnlFbResource1">
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <table border="1" width="75%">
                                            <tr>
                                                <th class="mediumfon">
                                                    <asp:Label ID="Rs_General" Text="General" runat="server" 
                                                        meta:resourcekey="Rs_GeneralResource1"></asp:Label>
                                                </th>
                                                <th class="mediumfon">
                                                    <asp:Label ID="Rs_AccessSite" Text="Access Site" runat="server" 
                                                        meta:resourcekey="Rs_AccessSiteResource1"></asp:Label>
                                                </th>
                                                <th class="mediumfon">
                                                    <asp:Label ID="Rs_MachineRelated" Text="Machine Related" runat="server" 
                                                        meta:resourcekey="Rs_MachineRelatedResource1"></asp:Label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor" align="center" valign="top" nowrap="nowrap">
                                                    <asp:BulletedList BulletStyle="Numbered" ID="bltG" runat="server" 
                                                        meta:resourcekey="bltGResource1">
                                                    </asp:BulletedList>
                                                    <asp:Label runat="server" ID="lblbltG" Text="-NIL-" 
                                                        meta:resourcekey="lblbltGResource1"></asp:Label>
                                                </td>
                                                <td class="defaultfontcolor" align="center" valign="top" nowrap="nowrap">
                                                    <asp:BulletedList BulletStyle="Circle" ID="bltA" runat="server" 
                                                        meta:resourcekey="bltAResource1">
                                                    </asp:BulletedList>
                                                    <asp:Label runat="server" ID="lblbltA" Text="-NIL-" 
                                                        meta:resourcekey="lblbltAResource1"></asp:Label>
                                                </td>
                                                <td class="defaultfontcolor" align="center" valign="top" nowrap="nowrap">
                                                    <asp:BulletedList BulletStyle="Circle" ID="bltM" runat="server" 
                                                        meta:resourcekey="bltMResource1">
                                                    </asp:BulletedList>
                                                    <asp:Label runat="server" ID="lblbltM" Text="-NIL-" 
                                                        meta:resourcekey="lblbltMResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <uc6:PatientPrescription runat="server" ID="Treatment" />
                        <asp:Panel ID="pnlNextHD" runat="server" CssClass="defaultfontcolor" BorderStyle="Double"
                            BorderWidth="1px" BorderColor="Black" 
                            meta:resourcekey="pnlNextHDResource1">
                            <table>
                                <tr>
                                    <td class="mediumfon">
                                        <asp:Label ID="Rs_NextHDDate" Text="Next HD Date :" runat="server" 
                                            meta:resourcekey="Rs_NextHDDateResource1"></asp:Label>
                                    </td>
                                    <td class="defaultfontcolor">
                                        <asp:Label ID="lblNextHD" runat="server" meta:resourcekey="lblNextHDResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlEdit" runat="server" CssClass="defaultfontcolor"
                            GroupingText="Payment" meta:resourcekey="pnlEditResource1">
                            <table>
                                <tr>
                                    <td class="defaultfontcolor" align="right">
                                        <asp:Label ID="Rs_PreviousBalance" Text="Previous Balance:" runat="server" 
                                            meta:resourcekey="Rs_PreviousBalanceResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="prnbal" runat="server" meta:resourcekey="prnbalResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="defaultfontcolor" align="right">
                                        <asp:Label ID="Rs_Amountforcurrentvisit" Text="Amount for current visit:" 
                                            runat="server" meta:resourcekey="Rs_AmountforcurrentvisitResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lCA" runat="server" meta:resourcekey="lCAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="defaultfontcolor" align="right">
                                        <asp:Label ID="Rs_TotalAmounttobepaid" Text="Total Amount to be paid:" 
                                            runat="server" meta:resourcekey="Rs_TotalAmounttobepaidResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lTA" runat="server" meta:resourcekey="lTAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="defaultfontcolor" align="right">
                                        <asp:Label ID="Rs_AmountReceived" Text="Amount Received:" runat="server" 
                                            meta:resourcekey="Rs_AmountReceivedResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tAR" runat="server" meta:resourcekey="tARResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlButton" runat="server" meta:resourcekey="pnlButtonResource1">
                            <table>
                                <tr>
                                    <td align="right" nowrap="nowrap">
                                        <asp:Button ID="btnSubmit" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" runat="server" OnClick="btnSubmit_Click" 
                                            meta:resourcekey="btnSubmitResource1" />
                                        <asp:Button ID="btnCancel" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" runat="server" OnClick="btnCancel_Click" 
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
