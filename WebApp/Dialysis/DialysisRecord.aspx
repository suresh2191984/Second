<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DialysisRecord.aspx.cs" Inherits="Physician_DialysisRecord" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%--<%@ Register Src="../Physician/Header.ascx" TagName="DocHeader" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Advice" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/DialysisOnFlow.ascx" TagName="DialysisOnFlow"
    TagPrefix="uc8" %>
    <%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Dialysis Record</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.maskedinput-1.2.2.min.js"></script>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
    
        MM_reloadPage(true);

        function CheckHDDate() {

            if (document.getElementById('btnSubmit').value == 'Save') {
                if (document.getElementById('txtPreSBP').value == '' &&
            document.getElementById('txtPreDBP').value == '') {
                    alert('Provide pre dialysis value');
                    return false;
                }
            }

            if (document.getElementById('btnSubmit').value == 'Finish') {
                if (document.getElementById('txtPostSBP').value == '' &&
            document.getElementById('txtPostDBP').value == '') {
                    alert('Provide post dialysis value');
                    return false;
                }
            }

            if (document.getElementById('btnSubmit').value == 'Finish') {
                if (document.getElementById('tNextHDDate').value == '') {
                    alert('Select HD date');
                    document.getElementById('tNextHDDate').focus();
                    return false;
                }
                return true;
            }
            else {
                return true;

            }
        }
        function PostsbpKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('txtPostSBP').value;
                var ctrlDBP = document.getElementById('txtPostDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('txtPreSBP').value;
                var ctrlDBP = document.getElementById('txtPreDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }

       
    </script>

    <style type="text/css">
        .style2
        {
            width: 390px;
        }
        .style3
        {
            width: 174px;
        }
        .style4
        {
            width: 70px;
        }
    </style>
</head>
<body onload="Page_Load();" oncontextmenu="return false;">
    <form id="frmDialysisRecord" runat="server" defaultbutton="btnSubmit">
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
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                        <asp:Panel ID="pnlRec" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlRecResource1">
                            <ul>
                                <li>
                                    <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </li>
                            </ul>
                            <br />
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td colspan="2" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plus1">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                <asp:Label ID="Rs_HemodialysisDetails" Text="Hemodialysis Details" 
                                                runat="server" meta:resourcekey="Rs_HemodialysisDetailsResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block" id="ACX2minus1">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                <asp:Label ID="Rs_HemodialysisDetails1" Text="Hemodialysis Details" 
                                                runat="server" meta:resourcekey="Rs_HemodialysisDetails1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses1" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="defaultfontcolor" align="left" nowrap="nowrap" style="width: 15%;">
                                                        <asp:Label ID="Rs_HDNo" Text="HD No.:" runat="server" 
                                                            meta:resourcekey="Rs_HDNoResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" align="left" nowrap="nowrap">
                                                        <asp:Label ID="txtHDNo" runat="server" meta:resourcekey="txtHDNoResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" align="right" nowrap="nowrap" style="width: 25%">
                                                        <asp:Label ID="Rs_Date" Text="Date :" runat="server" 
                                                            meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap" align="left">
                                                        <asp:Label ID="txtToday" runat="server" meta:resourcekey="txtTodayResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap" align="right" style="width: 30%" nowrap="nowrap">
                                                        <asp:Label ID="Rs_StartTime" Text="Start Time:" runat="server" 
                                                            meta:resourcekey="Rs_StartTimeResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" align="left" nowrap="nowrap">
                                                        <asp:Label ID="txtStartTime" runat="server" 
                                                            meta:resourcekey="txtStartTimeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" align="right" style="width: 30%" nowrap="nowrap">
                                                        <asp:Label ID="Rs_EndTime" Text="End Time:" runat="server" 
                                                            meta:resourcekey="Rs_EndTimeResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" align="left" nowrap="nowrap">
                                                        <asp:Label ID="txtEndTime" runat="server" 
                                                            meta:resourcekey="txtEndTimeResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br clear="all" />
                        <asp:Panel ID="pnlPre" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlPreResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plus2">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1); " />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                                <asp:Label ID="Rs_PreDialysis" Text="Pre Dialysis" runat="server" 
                                                meta:resourcekey="Rs_PreDialysisResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block" id="ACX2minus2">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0); if (document.getElementById('btnSubmit').value == 'Finish') { document.getElementById('txtPostTemp').focus(); }" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                <asp:Label ID="Rs_PreDialysis1" Text="Pre Dialysis" runat="server" 
                                                meta:resourcekey="Rs_PreDialysis1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses2" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="defaultfontcolor">
                                                            <tr height="30px" valign="middle">
                                                                <td>
                                                                    <asp:Label ID="Rs_Temp" Text="Temp" runat="server" 
                                                                        meta:resourcekey="Rs_TempResource1"></asp:Label>
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPreSBPVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPreSBPVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap" style="vertical-align: middle;">
                                                                    <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPreTemp" 
                                                                        TabIndex="1" meta:resourcekey="txtPreTempResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblPreTempUOMCode" runat="server" 
                                                                        meta:resourcekey="lblPreTempUOMCodeResource1"></asp:Label>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_Pulse" Text="Pulse" runat="server" 
                                                                        meta:resourcekey="Rs_PulseResource1"></asp:Label>
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPreDBPVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPreDBPVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    &nbsp;&nbsp;&nbsp;<asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPrePulse"
                                                                        TabIndex="2" meta:resourcekey="txtPrePulseResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblPrePulseUOMCode" runat="server" 
                                                                        meta:resourcekey="lblPrePulseUOMCodeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_SBPDBP" Text="SBP/DBP" runat="server" 
                                                                        meta:resourcekey="Rs_SBPDBPResource1"></asp:Label>
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPreTempVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPreTempVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    <asp:TextBox Width="30px" MaxLength="3" runat="server" ID="txtPreSBP" TabIndex="3"
                                                                        onKeyUp="PreSBPKeyPress()" meta:resourcekey="txtPreSBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                                    /<asp:TextBox ID="txtPreDBP" runat="server" MaxLength="3" TabIndex="4" 
                                                                        Width="30px" meta:resourcekey="txtPreDBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblPreSBPUOMCode" runat="server" 
                                                                        meta:resourcekey="lblPreSBPUOMCodeResource1"></asp:Label>
                                                                    <asp:Label ID="lblPreDBPUOMCode" runat="server" CssClass="smallfon" 
                                                                        Visible="False" meta:resourcekey="lblPreDBPUOMCodeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    &nbsp;
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPrePulseVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPrePulseVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr height="30px" valign="middle">
                                                                <td>
                                                                    <asp:Label ID="Rs_Weight" Text="Weight" runat="server" 
                                                                        meta:resourcekey="Rs_WeightResource1"></asp:Label>
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPreWeightVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPreWeightVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPreWeight" TabIndex="5"
                                                                        onblur="CalcWeightGain()" meta:resourcekey="txtPreWeightResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblPreWeightUOMCode" runat="server" 
                                                                        meta:resourcekey="lblPreWeightUOMCodeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Rs_WeightGain" Text="Weight Gain" runat="server" 
                                                                        meta:resourcekey="Rs_WeightGainResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    &nbsp;&nbsp;&nbsp;<asp:TextBox Width="75px" MaxLength="6" ReadOnly="True" runat="server"
                                                                        ID="txtWtGain" BorderColor="#E0ECF6" BorderStyle="None" BorderWidth="0px" 
                                                                        meta:resourcekey="txtWtGainResource1"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" runat="server" ID="lblWtGain" 
                                                                        meta:resourcekey="lblWtGainResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_Heparin" Text="Heparin" runat="server" 
                                                                        meta:resourcekey="Rs_HeparinResource1"></asp:Label>
                                                                </td>
                                                                <td style="visibility: hidden">
                                                                    <asp:Label ID="lblPreHeparinVitalsID" runat="server" 
                                                                        meta:resourcekey="lblPreHeparinVitalsIDResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" nowrap="nowrap">
                                                                    <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPreHeparin" 
                                                                        TabIndex="6" meta:resourcekey="txtPreHeparinResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblPreHeparinUOMCode" runat="server" 
                                                                        meta:resourcekey="lblPreHeparinUOMCodeResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="4">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
                                                            <tr>
                                                                <td width="53px">
                                                                    <asp:Label ID="Rs_Access" Text="Access" runat="server" 
                                                                        meta:resourcekey="Rs_AccessResource1"></asp:Label>
                                                                </td>
                                                                <td class="mediumfon" width="250px">
                                                                    <asp:DropDownList runat="server" ID="ddSide" TabIndex="8" 
                                                                        meta:resourcekey="ddSideResource1" CssClass="ddlsmall">
                                                                        <asp:ListItem Text="Right" Value="R" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                                        <asp:ListItem Text="Left" Value="L" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:DropDownList runat="server" ID="ddAccess" TabIndex="9" CssClass="ddlsmall"
                                                                        meta:resourcekey="ddAccessResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="mediumfon" width="212px">
                                                                    <asp:Label ID="Rs_TreatmentBedMachineName" Text="Treatment Bed/Machine Name" 
                                                                        runat="server" meta:resourcekey="Rs_TreatmentBedMachineNameResource1"></asp:Label>
                                                                </td>
                                                                <td class="style3">
                                                                    <asp:TextBox runat="server" ID="txtBedName" Width="75px" MaxLength="50" 
                                                                        TabIndex="10" meta:resourcekey="txtBedNameResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                                </td>
                                                                <td width="53px" class="mediumfon">
                                                                    <asp:Label ID="Rs_DryWeight" Text="Dry Weight" runat="server" 
                                                                        meta:resourcekey="Rs_DryWeightResource1"></asp:Label>
                                                                </td>
                                                                <td class="style2">
                                                                    <asp:TextBox runat="server" ID="txtDryWeight" Width="90px" 
                                                                        meta:resourcekey="txtDryWeightResource1" TabIndex="11" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:Label CssClass="smallfon" ID="lblDryWeightUOMCode" runat="server" 
                                                                        meta:resourcekey="lblDryWeightUOMCodeResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br clear="all" />
                        <asp:Panel ID="pnlOnFlow" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlOnFlowResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblOnflowDetail">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plus5">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);">
                                                <asp:Label ID="Rs_OnFlowDialysis" Text="On Flow Dialysis" runat="server" 
                                                meta:resourcekey="Rs_OnFlowDialysisResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block" id="ACX2minus5">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);">
                                                <asp:Label ID="Rs_OnFlowDialysis1" Text="On Flow Dialysis" runat="server" 
                                                meta:resourcekey="Rs_OnFlowDialysis1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses5" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="left">
                                                    <td>
                                                        <uc8:DialysisOnFlow ID="DialysisOnFlow" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br clear="all" />
                        <asp:Panel ID="pnlPost" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlPostResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plus3">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                                                <asp:Label ID="Rs_PostDialysis" Text="Post Dialysis" runat="server" 
                                                meta:resourcekey="Rs_PostDialysisResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block" id="ACX2minus3">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                                                <asp:Label ID="Rs_PostDialysis1" Text="Post Dialysis" runat="server" 
                                                meta:resourcekey="Rs_PostDialysis1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses3" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Temp1" Text="Temp" runat="server" 
                                                            meta:resourcekey="Rs_Temp1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="defaultfontcolor" style="visibility: hidden">
                                                        <asp:Label ID="lblPostSBPVitalsID" runat="server" 
                                                            meta:resourcekey="lblPostSBPVitalsIDResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap" style="vertical-align: top;">
                                                        <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPostTemp" 
                                                            TabIndex="11" meta:resourcekey="txtPostTempResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                        &nbsp;<asp:Label CssClass="smallfon" runat="server" ID="lblPostTempUOMCode" 
                                                            meta:resourcekey="lblPostTempUOMCodeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Pulse1" Text="Pulse" runat="server" 
                                                            meta:resourcekey="Rs_Pulse1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="defaultfontcolor" style="visibility: hidden">
                                                        <asp:Label ID="lblPostTempVitalsID" runat="server" 
                                                            meta:resourcekey="lblPostTempVitalsIDResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPostPulse" 
                                                            TabIndex="12" meta:resourcekey="txtPostPulseResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <asp:Label CssClass="smallfon" ID="lblPostPulseUOMCode" runat="server" 
                                                            meta:resourcekey="lblPostPulseUOMCodeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_SBPDBP1" Text="SBP/DBP" runat="server" 
                                                            meta:resourcekey="Rs_SBPDBP1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="defaultfontcolor" style="visibility: hidden">
                                                        <asp:Label ID="lblPostPulseVitalsID" runat="server" 
                                                            meta:resourcekey="lblPostPulseVitalsIDResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox Width="30px" MaxLength="3" runat="server" ID="txtPostSBP" TabIndex="13"
                                                            OnKeyPress="PostsbpKeyPress();" meta:resourcekey="txtPostSBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                        /<asp:TextBox Width="30px" MaxLength="3" runat="server" ID="txtPostDBP" 
                                                            TabIndex="14" meta:resourcekey="txtPostDBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                        <asp:Label CssClass="smallfon" ID="lblPostSBPUOMCode" runat="server" 
                                                            meta:resourcekey="lblPostSBPUOMCodeResource1"></asp:Label>
                                                        <asp:Label ID="lblPostDBPVitalsID" runat="server" Visible="False" 
                                                            meta:resourcekey="lblPostDBPVitalsIDResource1"></asp:Label>
                                                        <asp:Label CssClass="smallfon" ID="lblPostDBPUOMCode" Visible="False" 
                                                            runat="server" meta:resourcekey="lblPostDBPUOMCodeResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="tablerow">
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Weight1" Text="Weight" runat="server" 
                                                            meta:resourcekey="Rs_Weight1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="defaultfontcolor" style="visibility: hidden">
                                                        <asp:Label ID="lblPostWeightVitalsID" runat="server" 
                                                            meta:resourcekey="lblPostWeightVitalsIDResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPostWeight" 
                                                            TabIndex="15" meta:resourcekey="txtPostWeightResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <asp:Label CssClass="smallfon" ID="lblPostWeightUOMCode" runat="server" 
                                                            meta:resourcekey="lblPostWeightUOMCodeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_UF" Text="UF" runat="server" 
                                                            meta:resourcekey="Rs_UFResource1"></asp:Label>
                                                    </td>
                                                    <td class="defaultfontcolor" style="visibility: hidden">
                                                        <asp:Label ID="lblPostUFVitalsID" runat="server" 
                                                            meta:resourcekey="lblPostUFVitalsIDResource1"></asp:Label>
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox Width="75px" MaxLength="6" runat="server" ID="txtPostUF" 
                                                            TabIndex="16" meta:resourcekey="txtPostUFResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <asp:Label CssClass="smallfon" runat="server" ID="lblPostUFUOMCode" 
                                                            meta:resourcekey="lblPostUFUOMCodeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_BTS" Text="BTS" runat="server" 
                                                            meta:resourcekey="Rs_BTSResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox Width="75px" runat="server" ID="txtBTS" TabIndex="17" 
                                                            meta:resourcekey="txtBTSResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="tablerow">
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Dialyzer" Text="Dialyzer" runat="server" 
                                                            meta:resourcekey="Rs_DialyzerResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:TextBox ID="txtDialyzer" runat="server" Width="75px" TabIndex="18" 
                                                            meta:resourcekey="txtDialyzerResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Condition" Text="Condition" runat="server" 
                                                            meta:resourcekey="Rs_ConditionResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap">
                                                        <asp:DropDownList runat="server" ID="dCond" TabIndex="18" 
                                                            meta:resourcekey="dCondResource1" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="5">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="tablerow">
                                                    <td class="defaultfontcolor" nowrap="nowrap">
                                                        <asp:Label ID="Rs_Other" Text="Other" runat="server" 
                                                            meta:resourcekey="Rs_OtherResource1"></asp:Label>
                                                        <br />
                                                        <asp:Label ID="Rs_Drugs" Text="Drugs" runat="server" 
                                                            meta:resourcekey="Rs_DrugsResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" nowrap="nowrap" colspan="10">
                                                        <asp:TextBox ID="txtPostDialysisRemarks" runat="server" TextMode="MultiLine" Width="580px"
                                                            Height="50px" MaxLength="500" TabIndex="19" 
                                                            meta:resourcekey="txtPostDialysisRemarksResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br clear="all" />
                        <asp:Panel ID="pnlFb" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlFbResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plus4">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);">
                                                <asp:Label ID="Rs_Complications" Text="Complications" runat="server" 
                                                meta:resourcekey="Rs_ComplicationsResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block; height: 18px;" id="ACX2minus4">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);">
                                                <asp:Label ID="Rs_Complications1" Text="Complications" runat="server" 
                                                meta:resourcekey="Rs_Complications1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses4" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr class="tablerow">
                                                    <th class="defaultfontcolor" style="width: 30%">
                                                        <asp:Label ID="Rs_General" Text="General" runat="server" 
                                                            meta:resourcekey="Rs_GeneralResource1"></asp:Label>
                                                    </th>
                                                    <th>
                                                        &nbsp;
                                                    </th>
                                                    <th class="defaultfontcolor" style="width: 30%">
                                                        <asp:Label ID="Rs_AccessSite" Text="Access Site" runat="server" 
                                                            meta:resourcekey="Rs_AccessSiteResource1"></asp:Label>
                                                    </th>
                                                    <th>
                                                        &nbsp;
                                                    </th>
                                                    <th class="defaultfontcolor" style="width: 30%">
                                                        <asp:Label ID="Rs_MachineRelated" Text="Machine Related" runat="server" 
                                                            meta:resourcekey="Rs_MachineRelatedResource1"></asp:Label>
                                                    </th>
                                                </tr>
                                                <tr class="tablerow">
                                                    <td class="mediumfon" valign="top" nowrap="nowrap" style="width: 30%">
                                                        <asp:CheckBoxList ID="chkG" runat="server" TabIndex="20" RepeatColumns="2"
                                                            RepeatDirection="Horizontal" meta:resourcekey="chkGResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" valign="top" nowrap="nowrap" style="width: 30%">
                                                        <asp:CheckBoxList ID="chkA" runat="server" TabIndex="21" RepeatColumns="2"
                                                            RepeatDirection="Horizontal" meta:resourcekey="chkAResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td class="mediumfon" valign="top" nowrap="nowrap" style="width: 30%">
                                                        <asp:CheckBoxList ID="chkM" runat="server" TabIndex="22" RepeatColumns="2"
                                                            RepeatDirection="Horizontal" meta:resourcekey="chkMResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <input type="hidden" runat="server" id="txtprevWt" name="prevWt" />
                        <br clear="all" />
                        <!-- Dialysis Prescription -->
                         <asp:Panel ID="pnlDescription" runat="server" CssClass="defaultfontcolor">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <%--<tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plusP">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusP','ACX2minusP','ACX2responsesPres',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusP','ACX2minusP','ACX2responsesPres',1);">
                                                <asp:Label ID="Label1" Text="Miscellaneous" runat="server" 
                                                meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block; height: 18px;" id="ACX2minusP">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusP','ACX2minusP','ACX2responsesPres',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusP','ACX2responsesPres',0);">
                                                <asp:Label ID="Label2" Text="Miscellaneous" runat="server" 
                                                meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>class="tablerow" id="ACX2responsesPres" style="display: block">  --%>
                                <tr > 
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                        <uc9:Adv runat="server" ID="uAd" AdviceMode="EditMode" EnableViewState="true" />
                                        </div>
                                      </td>
                                 </tr>
                            </table>
                         </asp:Panel>             
                        
                        
                        <!-- Dialysis on flow -->
                        <asp:Panel ID="pnlNextHD" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlNextHDResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="defaultfontcolor" nowrap="nowrap">
                                        <asp:Label ID="Rs_NextHDDate" Text="Next HD Date" runat="server" 
                                            meta:resourcekey="Rs_NextHDDateResource1"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap" align="left" class="mediumfon">
                                        <asp:TextBox ID="tNextHDDate" runat="server" Width="130px" TabIndex="23" CssClass="Txtboxsmall"
                                            ValidationGroup="MKE" meta:resourcekey="tNextHDDateResource1" />
                                        <asp:ImageButton ID="ImgBntCal" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="tNextHDDate"
                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                            ControlToValidate="tNextHDDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                            meta:resourcekey="MaskedEditValidator1Resource1" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tNextHDDate"
                                            PopupButtonID="ImgBntCal" PopupPosition="TopLeft" Enabled="True" />
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td class="defaultfontcolor">
                                        <asp:Label ID="Rs_NextHDTime" Text="Next HD Time" runat="server" 
                                            meta:resourcekey="Rs_NextHDTimeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td class="mediumfon" nowrap="nowrap">
                                        <asp:DropDownList runat="server" ID="ddNHour" TabIndex="24" 
                                            meta:resourcekey="ddNHourResource1" CssClass="ddl">
                                            <asp:ListItem Text="1" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="2" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="3" Value="3" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="4" Value="4" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="5" Value="5" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                            <asp:ListItem Text="6" Value="6" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                            <asp:ListItem Text="7" Value="7" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                            <asp:ListItem Text="8" Value="8" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                            <asp:ListItem Text="9" Value="9" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                            <asp:ListItem Text="12" Value="12" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList runat="server" ID="ddNMinutes" TabIndex="25" 
                                            meta:resourcekey="ddNMinutesResource1" CssClass="ddl">
                                            <asp:ListItem Text="00" Value="00" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                            <asp:ListItem Text="15" Value="15" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                            <asp:ListItem Text="30" Value="30" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                            <asp:ListItem Text="45" Value="45" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList runat="server" ID="ddNAmPm" TabIndex="26" 
                                            meta:resourcekey="ddNAmPmResource1" CssClass="ddl">
                                            <asp:ListItem Text="AM" Value="AM" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                            <asp:ListItem Text="PM" Value="PM" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_Comments" Text="Comments" runat="server" 
                                            meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" 
                                            meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" 
                            meta:resourcekey="pnlMiscellaneousResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: none" id="ACX2plusM">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);">
                                                <asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" 
                                                meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block; height: 18px;" id="ACX2minusM">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);">
                                                <asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" 
                                                meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesM" style="display: block">
                                    <td colspan="2">
                                        <div class="dialysisrecordbg">
                                            <asp:CheckBox ID="chkAdditionalPayments" CssClass="defaultfontcolor" runat="server"
                                                Visible="False" Text="Check here to capture additional charges" 
                                                meta:resourcekey="chkAdditionalPaymentsResource1" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlButton" runat="server" CssClass="mediumfon" 
                            meta:resourcekey="pnlButtonResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="left" nowrap="nowrap">
                                        <asp:Button ID="btnSubmit" Text="Save" Value="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            TabIndex="27" onmouseout="this.className='btn'" runat="server" 
                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
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
