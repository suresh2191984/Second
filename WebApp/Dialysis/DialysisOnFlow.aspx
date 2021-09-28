<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DialysisOnFlow.aspx.cs" Inherits="Dialysis_DialysisOnFlow" meta:resourcekey="PageResource1" %>

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
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Dialysis OnFlow Monitoring</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/AutoComplete.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <style type="text/css">
        .style1
        {
            visibility: hidden;
            height: 40px;
        }
        .style2
        {
            height: 40px;
        }
    </style>
</head>
<body onload="pageLoadFocus('txtTemp')" oncontextmenu="return false;">
    <form id="frmDialysisOnFlow" runat="server" defaultbutton="btnSave">

    <script type="text/javascript" type="text/javascript">
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('txtSBP').value;
                var ctrlDBP = document.getElementById('txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
    </script>

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
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlVitals" runat="server" Visible="False" 
                                        meta:resourcekey="pnlVitalsResource1">
                                        <table class="dialysisdataheader2" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <table width="75%" align="center" class="defaultfontcolor">
                                                        <tr>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblSBPVitalsID" runat="server" 
                                                                    meta:resourcekey="lblSBPVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_Temp" Text="Temp" runat="server" 
                                                                    meta:resourcekey="Rs_TempResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTemp" runat="server" TabIndex="1" MaxLength="6" 
                                                                    meta:resourcekey="txtTempResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblTempUOMCode" runat="server" 
                                                                    meta:resourcekey="lblTempUOMCodeResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDBPVitalsID" Visible="False" runat="server" 
                                                                    meta:resourcekey="lblDBPVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_Pulse" Text="Pulse" runat="server" 
                                                                    meta:resourcekey="Rs_PulseResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPulse" runat="server" TabIndex="2" MaxLength="5" 
                                                                    meta:resourcekey="txtPulseResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblPulseUOMCode" runat="server" 
                                                                    meta:resourcekey="lblPulseUOMCodeResource1"></asp:Label>
                                                            </td>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblPulseVitalsID" runat="server" 
                                                                    meta:resourcekey="lblPulseVitalsIDResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblAPVitalsID" runat="server" 
                                                                    meta:resourcekey="lblAPVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_AP" Text="AP" runat="server" 
                                                                    meta:resourcekey="Rs_APResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtAP" runat="server" TabIndex="3" MaxLength="6" 
                                                                    meta:resourcekey="txtAPResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblAPUOMCode" runat="server" 
                                                                    meta:resourcekey="lblAPUOMCodeResource1"></asp:Label>
                                                            </td>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblVPVitalsID" runat="server" 
                                                                    meta:resourcekey="lblVPVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_VP" Text="VP" runat="server" 
                                                                    meta:resourcekey="Rs_VPResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtVP" runat="server" TabIndex="4" MaxLength="5" 
                                                                    meta:resourcekey="txtVPResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblVPUOMCode" runat="server" 
                                                                    meta:resourcekey="lblVPUOMCodeResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style1">
                                                                <asp:Label ID="lblTempVitalsID" runat="server" 
                                                                    meta:resourcekey="lblTempVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:Label ID="Rs_SBPDBP" Text="SBP/DBP" runat="server" 
                                                                    meta:resourcekey="Rs_SBPDBPResource1"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:TextBox ID="txtSBP" Width="30px" runat="server" TabIndex="5" MaxLength="3" 
                                                                    onkeyup="PreSBPKeyPress();" meta:resourcekey="txtSBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                                /<asp:TextBox
                                                                    Width="30px" ID="txtDBP" runat="server" TabIndex="6" MaxLength="3" 
                                                                    meta:resourcekey="txtDBPResource1" CssClass="Txtboxverysmall"></asp:TextBox>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:Label ID="lblSBPUOMCode" runat="server" 
                                                                    meta:resourcekey="lblSBPUOMCodeResource1"></asp:Label>
                                                                <asp:Label ID="lblDBPUOMCode" Visible="False" runat="server" 
                                                                    meta:resourcekey="lblDBPUOMCodeResource1"></asp:Label>
                                                            </td>
                                                            <td class="style1">
                                                                <asp:Label ID="lblBFlowVitalsID" runat="server" 
                                                                    meta:resourcekey="lblBFlowVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:Label ID="Rs_BFlow" Text="B.Flow" runat="server" 
                                                                    meta:resourcekey="Rs_BFlowResource1"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:TextBox ID="txtBFlow" runat="server" TabIndex="7" 
                                                                    meta:resourcekey="txtBFlowResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:Label ID="lblBFlowUOMCode" runat="server" 
                                                                    meta:resourcekey="lblBFlowUOMCodeResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblUFRateVitalsID" runat="server" 
                                                                    meta:resourcekey="lblUFRateVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_UFRate" Text="U.F.Rate" runat="server" 
                                                                    meta:resourcekey="Rs_UFRateResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUFRate" runat="server" TabIndex="8" 
                                                                    meta:resourcekey="txtUFRateResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblUFRateUOMCode" runat="server" 
                                                                    meta:resourcekey="lblUFRateUOMCodeResource1"></asp:Label>
                                                            </td>
                                                            <td style="visibility: hidden">
                                                                <asp:Label ID="lblUFRemovalVitalsID" runat="server" 
                                                                    meta:resourcekey="lblUFRemovalVitalsIDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_UFRemoval" Text="U.F.Removal" runat="server" 
                                                                    meta:resourcekey="Rs_UFRemovalResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUFRemoval" runat="server" TabIndex="9" MaxLength="6" 
                                                                    meta:resourcekey="txtUFRemovalResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td class="smallfon">
                                                                <asp:Label ID="lblUFRemovalUOMCode" runat="server" 
                                                                    meta:resourcekey="lblUFRemovalUOMCodeResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Rs_Remarks" Text="Remarks" runat="server" 
                                                                    meta:resourcekey="Rs_RemarksResource1"></asp:Label>
                                                            </td>
                                                            <td colspan="6">
                                                                <asp:TextBox runat="server" TextMode="MultiLine" Rows="3" TabIndex="10" MaxLength="100"
                                                                    ID="txtRemarks" Columns="50" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr height="5px">
                                                            <td>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" colspan="5">
                                                                <asp:Button ID="btnSave" Text="Save & Continue Onflow" ToolTip="Saves current entries and continue with onflow monitoring"
                                                                    CssClass="btn" onmouseover="this.className='btn1 btnhov1'" TabIndex="11" onmouseout="this.className='btn'"
                                                                    runat="server" OnClick="btnSave_Click" 
                                                                    meta:resourcekey="btnSaveResource1" />
                                                                <asp:Button ID="btnComplete" Text="OnFlow Completed" TabIndex="12" ToolTip="Saves current entries and wait for dialysis completion"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    runat="server" OnClick="btnComplete_Click" 
                                                                    meta:resourcekey="btnCompleteResource1" />
                                                                <asp:Button ID="btnCancel" ToolTip="Cancel & Go Back" Text="Cancel" TabIndex="13"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    runat="server" OnClick="btnCancel_Click" 
                                                                    meta:resourcekey="btnCancelResource1" />
                                                            </td>
                                                            <td>
                                                                &nbsp;
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
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
