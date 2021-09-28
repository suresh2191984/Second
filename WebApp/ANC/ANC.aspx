<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ANC.aspx.cs" Inherits="ANC_ANC" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" /> --%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function ReportsDIV() {
            if (document.getElementById('ddlAnyotherClinic').value == '0') {
                document.getElementById('RepDiv').style.display = 'block';
            }
            else {
                document.getElementById('RepDiv').style.display = 'none';
            }
        }
        function UltrasoundDIV() {
            if (document.getElementById('ddlAnypriorUltrasoundConfirmation').value == '0') {
                document.getElementById('UltraDiv').style.display = 'block';

            }
            else {
                document.getElementById('UltraDiv').style.display = 'none';
            }
        }

        function showPastMedical(chkID, divID) {
            if (document.getElementById(chkID).checked) {
                document.getElementById(divID).style.display = 'block';
            }
            else {
                document.getElementById(divID).style.display = 'none';
            }
        }

        function MenstrualDIV() {

            if (document.getElementById('ddlMenstrualCycles').value == '1' || document.getElementById('ddlMenstrualCycles').value == '3') {
                document.getElementById('CyclesDiv').style.display = 'block';
                document.getElementById('Cycles1Div').style.display = 'none';

            }

            else {
                document.getElementById('Cycles1Div').style.display = 'block';
                document.getElementById('CyclesDiv').style.display = 'none';
            }

            if (document.getElementById('ddlMenstrualCycles').value == '0') {
                document.getElementById('CyclesDiv').style.display = 'none';
                document.getElementById('Cycles1Div').style.display = 'none';
            }

        }

        function UseofContraceptivesDIV() {
            if (document.getElementById('ddlUseofContraceptives').value == '0') {
                document.getElementById('ContraceptivesDiv').style.display = 'block';
            }
            else {
                document.getElementById('ContraceptivesDiv').style.display = 'none';
            }

        }
        
    </script>

    <title></title>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <uc2:Header ID="Header2" runat="server" />
            <uc7:Header ID="UsrHeader1" runat="server" />
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table>
                            <tr>
                                <td>
                                    <div>
                                        <table class="tabletxt" width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23">
                                                                <div style="display: none" id="ACX2plus1">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                                        &nbsp;Expected Date of Delivery (EDD)</span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus1">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                                        <asp:Label ID="Rs_ExpectedDateofDelivery" 
                                                                        Text="Expected Date of Delivery (EDD)" runat="server" 
                                                                        meta:resourcekey="Rs_ExpectedDateofDeliveryResource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses1" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td width="200px" height="28px">
                                                                                <asp:Label ID="lblEnterDateofLMP" runat="server" Text="Enter Date of LMP" 
                                                                                    meta:resourcekey="lblEnterDateofLMPResource1"></asp:Label>
                                                                            </td>
                                                                            <td width="80px">
                                                                                <asp:TextBox  CssClass ="Txtboxsmall" ID="txtEnterDateofLMP" runat="server" Width="120px"
                                                                            meta:resourcekey="txtEnterDateofLMPResource1"> </asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                &nbsp;<img alt="" src="../Images/Calendar_scheduleHS.png" />
                                                                            </td>
                                                                            <td width="190px">
                                                                                <asp:Label ID="lblEnterCycleLength" runat="server" Text="Enter Cycle Length" 
                                                                                    meta:resourcekey="lblEnterCycleLengthResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox CssClass ="Txtboxsmall" ID="txtEnterCycleLength" runat="server" Width="120px"
                                                                                    meta:resourcekey="txtEnterCycleLengthResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td height="28px">
                                                                                <asp:Label ID="lblCurrentWeeksofPregnanacy" runat="server" 
                                                                                    Text="Current Weeks of Pregnanacy" 
                                                                                    meta:resourcekey="lblCurrentWeeksofPregnanacyResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox  CssClass ="Txtboxsmall" ID="txtCurrentWeeksofPregnanacy" Width="120px"
                                                                                    runat="server" meta:resourcekey="txtCurrentWeeksofPregnanacyResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                &nbsp;
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblCalculatedEDD" runat="server" Text="Calculated EDD" 
                                                                                    meta:resourcekey="lblCalculatedEDDResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox  CssClass ="Txtboxsmall" ID="txtCalculatedEDD" runat="server" Width="120px"
                                                                                    meta:resourcekey="txtCalculatedEDDResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td height="28px">
                                                                                <asp:Label ID="lblWeeksLeftforEDD" runat="server" Text="Weeks Left for EDD" 
                                                                                    meta:resourcekey="lblWeeksLeftforEDDResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox  CssClass ="Txtboxsmall" ID="txtWeeksLeftforEDD" runat="server" Width="120px"
                                                                                    meta:resourcekey="txtWeeksLeftforEDDResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                &nbsp;
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblEstimatedConceptonDate" runat="server" 
                                                                                    Text="Estimated Concepton Date" 
                                                                                    meta:resourcekey="lblEstimatedConceptonDateResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox  CssClass ="Txtboxsmall" ID="txtEstimatedConceptonDate" runat="server"  Width ="120px"
                                                                                    meta:resourcekey="txtEstimatedConceptonDateResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23" align="left">
                                                                <div style="display: none" id="ACX2plus5">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);">
                                                                        <asp:Label ID="Rs_GynaecologicalHistory" Text="Gynaecological History" 
                                                                        runat="server" meta:resourcekey="Rs_GynaecologicalHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus5">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);">
                                                                       <asp:Label ID="Rs_GynaecologicalHistory1" Text="Gynaecological History" 
                                                                        runat="server" meta:resourcekey="Rs_GynaecologicalHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses5" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td>
                                                                                <table border="0" cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="150px" height="25px">
                                                                                            <asp:Label ID="lblMenstrualCycles" runat="server" Text="Menstrual Cycles" 
                                                                                                meta:resourcekey="lblMenstrualCyclesResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="ddlMenstrualCycles" runat="server"  CssClass ="ddlmedium"
                                                                                                OnSelectedIndexChanged="ddlMenstrualCycles_SelectedIndexChanged" 
                                                                                                meta:resourcekey="ddlMenstrualCyclesResource1">
                                                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                                                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Regular</asp:ListItem>
                                                                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">Irregularly Irregular</asp:ListItem>
                                                                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource4">Regularly Irregular</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div style="display: none" id="CyclesDiv">
                                                                                                <table cellpadding="0" cellspacing="0">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;&nbsp;<asp:Label ID="lblOncein" runat="server" Text="Once in" 
                                                                                                                meta:resourcekey="lblOnceinResource1"></asp:Label>&nbsp;&nbsp;<asp:TextBox
                                                                                                                CssClass="textfield1" ID="txtMenstrualCycles" runat="server" 
                                                                                                                meta:resourcekey="txtMenstrualCyclesResource1"></asp:TextBox>&nbsp;&nbsp;<asp:Label
                                                                                                                    ID="lbldays" runat="server" Text="days" 
                                                                                                                meta:resourcekey="lbldaysResource1"></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div style="display: none" id="Cycles1Div">
                                                                                                <table cellpadding="0" cellspacing="0">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;&nbsp;<asp:Label ID="lblLongestCycledays" runat="server" 
                                                                                                                Text="Longest Cycle days" meta:resourcekey="lblLongestCycledaysResource1"></asp:Label>&nbsp;&nbsp;<asp:Label
                                                                                                                ID="lblOncein1" runat="server" Text="Once in" 
                                                                                                                meta:resourcekey="lblOncein1Resource1"></asp:Label>&nbsp;&nbsp;<asp:TextBox
                                                                                                                    CssClass="textfield1" ID="txtMenstrualCycles1" runat="server" 
                                                                                                                meta:resourcekey="txtMenstrualCycles1Resource1"></asp:TextBox>&nbsp;&nbsp;<asp:Label
                                                                                                                        ID="lbldays1" runat="server" Text="days" 
                                                                                                                meta:resourcekey="lbldays1Resource1"></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="150px" height="25px">
                                                                                            <asp:Label ID="lblLastPapSmearon" runat="server" Text="Last Pap Smear on" 
                                                                                                meta:resourcekey="lblLastPapSmearonResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtLastPapSmearon" runat="server" 
                                                                                                meta:resourcekey="txtLastPapSmearonResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            &nbsp;&nbsp;<asp:Label ID="lblreportedas" runat="server" Text="reported as" 
                                                                                                meta:resourcekey="lblreportedasResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlLastPapSmearon" runat="server"  CssClass ="ddlsmall"
                                                                                                meta:resourcekey="ddlLastPapSmearonResource1">
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource5">Normal</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource6">Abnormal</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="150px" height="25px">
                                                                                            <asp:Label ID="lblUseofContraceptives" runat="server" 
                                                                                                Text="Use of Contraceptives" meta:resourcekey="lblUseofContraceptivesResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlUseofContraceptives" runat="server"  CssClass ="ddl"
                                                                                                onchange="UseofContraceptivesDIV();" 
                                                                                                meta:resourcekey="ddlUseofContraceptivesResource1">
                                                                                                <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource7">Select</asp:ListItem>
                                                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource8">Yes</asp:ListItem>
                                                                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource9">No</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <div style="display: none" id="ContraceptivesDiv">
                                                                                                <asp:DropDownList ID="ddlUseofContraceptives1" runat="server"  CssClass ="ddlsmall"
                                                                                                    meta:resourcekey="ddlUseofContraceptives1Resource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource10">IUD</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource11">Mechanical</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource12">Oral</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource13">Others</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </div>
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23" align="left">
                                                                <div style="display: none" id="ACX2plus6">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);">
                                                                   <asp:Label ID="Rs_PastObstetricalHistory" Text="Past Obstetrical History" 
                                                                        runat="server" meta:resourcekey="Rs_PastObstetricalHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus6">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);">
                                                                      <asp:Label ID="Rs_PastObstetricalHistory1" Text="Past Obstetrical History" 
                                                                        runat="server" meta:resourcekey="Rs_PastObstetricalHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses6" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="100px" height="25px">
                                                                                            <asp:Label ID="lblGravida" runat="server" Text="Gravida" 
                                                                                                meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox CssClass ="Txtboxsmall" ID="txtGravida" runat="server" width="120px"
                                                                                                meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:Label ID="lblPara" runat="server" Text="Para" 
                                                                                                meta:resourcekey="lblParaResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtPara" runat="server" width="120px"
                                                                                                meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:Label ID="lblAbortUs" runat="server" Text="Abort Us" 
                                                                                                meta:resourcekey="lblAbortUsResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="90px">
                                                                                            <asp:TextBox   CssClass ="Txtboxverysmall" ID="txtAbortUs" runat="server" width="120px"
                                                                                                meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="45px">
                                                                                            <asp:Label ID="lblLive" runat="server" Text="Live" 
                                                                                                meta:resourcekey="lblLiveResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="90px">
                                                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtLive" runat="server" width="120px"
                                                                                                meta:resourcekey="txtLiveResource1"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="100px" height="25px">
                                                                                            <asp:Label ID="lblSexofChild" runat="server" Text="Sex of Child" 
                                                                                                meta:resourcekey="lblSexofChildResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlSexofChild" runat="server"  CssClass ="ddl"
                                                                                                meta:resourcekey="ddlSexofChildResource1">
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource14">Male</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource15">Female</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:Label ID="lblAgeinyears" runat="server" Text="Age(in years)" 
                                                                                                meta:resourcekey="lblAgeinyearsResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtAgeinyears" runat="server" 
                                                                                                meta:resourcekey="txtAgeinyearsResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="150px">
                                                                                            <asp:Label ID="lblModeofDelivery" runat="server" Text="Mode of Delivery" 
                                                                                                meta:resourcekey="lblModeofDeliveryResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlModeofDelivery" runat="server"  CssClass ="ddlmedium"
                                                                                                meta:resourcekey="ddlModeofDeliveryResource1">
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource16">Caesarean</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource17">Forceps Delivery</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource18">Vaccum Extraction</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource19">Normal Vaginal Delivery</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="100px" height="25px">
                                                                                            <asp:Label ID="lblBirthWt" runat="server" Text="Birth Wt(kg)" 
                                                                                                meta:resourcekey="lblBirthWtResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtBirthWt" runat="server"  Width ="120px"
                                                                                                meta:resourcekey="txtBirthWtResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td width="90px">
                                                                                            <asp:Label ID="lblat1" runat="server" Text="at" 
                                                                                                meta:resourcekey="lblat1Resource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlat1" CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlat1Resource1">
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource20">Full-term</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource21">Pre-term</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource22">Post-term</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td width="150px">
                                                                                            <asp:Label ID="lblDevelopmentGrowth" runat="server" Text="Development/Growth" 
                                                                                                meta:resourcekey="lblDevelopmentGrowthResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:DropDownList ID="ddlDevelopmentGrowth" CssClass ="ddl" runat="server" 
                                                                                                meta:resourcekey="ddlDevelopmentGrowthResource1">
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource23">Normal</asp:ListItem>
                                                                                                <asp:ListItem meta:resourcekey="ListItemResource24">Abnormal</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="100px">
                                                                                            <asp:Label ID="lblifabnormal" runat="server" Text="if abnormal" 
                                                                                                meta:resourcekey="lblifabnormalResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="100px">
                                                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtifabnornal" runat="server" 
                                                                                                meta:resourcekey="txtifabnornalResource1"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td width="270px" height="27px">
                                                                                            <asp:CheckBox ID="chkPregnanacyComplicationsHistory" runat="server" Text="Pregnanacy Complications History"
                                                                                                
                                                                                                onClick="showPastMedical('chkPregnanacyComplicationsHistory','divShow14');" 
                                                                                                meta:resourcekey="chkPregnanacyComplicationsHistoryResource1" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <div id="divShow14" style="display: none">
                                                                                                <table border="0" cellpadding="0" cellspacing="0">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:DropDownList ID="ddlPregnanacyComplicationsHistory" runat="server" 
                                                                                                                CssClass="selectoption4" 
                                                                                                                meta:resourcekey="ddlPregnanacyComplicationsHistoryResource1">
                                                                                                                <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource25">Select</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource26">Stational DM</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource27">Pregnancy-induced hypertension</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource28">Eclampsia</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource29">Anaemia</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource30">UTI</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource31">Viral Infections</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource32">Venereal Infections</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource33">Hyperemesis Gravidarum</asp:ListItem>
                                                                                                                <asp:ListItem meta:resourcekey="ListItemResource34">PROM</asp:ListItem>
                                                                                                            </asp:DropDownList>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23" align="left">
                                                                <div style="display: none" id="ACX2plus2">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                                                       <asp:Label ID="Rs_PregnancyConfirmationHistory" 
                                                                        Text="Pregnancy Confirmation History" runat="server" 
                                                                        meta:resourcekey="Rs_PregnancyConfirmationHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus2">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                                        <asp:Label ID="Rs_PregnancyConfirmationHistory1" 
                                                                        Text="Pregnancy Confirmation History" runat="server" 
                                                                        meta:resourcekey="Rs_PregnancyConfirmationHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses2" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td width="300px" height="28px">
                                                                                <asp:Label ID="lblPositivePregnancytest" runat="server" 
                                                                                    Text="Positive Pregnancy test was Confirmed at" 
                                                                                    meta:resourcekey="lblPositivePregnancytestResource1"></asp:Label>
                                                                            </td>
                                                                            <td width="69">
                                                                                <asp:TextBox  CssClass="Txtboxsmall" ID="txtPositivePregnancy" runat="server" width="120px"
                                                                                    meta:resourcekey="txtPositivePregnancyResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                               <asp:Label ID="Rs_Weeks" Text="Weeks" runat="server" 
                                                                                    meta:resourcekey="Rs_WeeksResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="270" height="28px">
                                                                               <asp:Label ID="Rs_AnyotherClinicHospitalvisited" 
                                                                                    Text="Any other Clinic/Hospital visited?" runat="server" 
                                                                                    meta:resourcekey="Rs_AnyotherClinicHospitalvisitedResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlAnyotherClinic" runat="server"  CssClass ="ddl"
                                                                                    onchange="ReportsDIV();" meta:resourcekey="ddlAnyotherClinicResource1">
                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource35">Select</asp:ListItem>
                                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource36">Yes</asp:ListItem>
                                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource37">No</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div style="display: none" id="RepDiv">
                                                                                    <asp:Button ID="bdnAttachReport" runat="server" Text="Attach Report" 
                                                                                        CssClass="btn" meta:resourcekey="bdnAttachReportResource1" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="300px" height="28px">
                                                                                <asp:Label ID="lblAnypriorUltrasoundConfirmation" runat="server" 
                                                                                    Text="Any prior Ultrasound Confirmation?" 
                                                                                    meta:resourcekey="lblAnypriorUltrasoundConfirmationResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlAnypriorUltrasoundConfirmation" runat="server" CssClass ="ddl" 
                                                                                    onchange="UltrasoundDIV();" 
                                                                                    meta:resourcekey="ddlAnypriorUltrasoundConfirmationResource1">
                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource38">Select</asp:ListItem>
                                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource39">Yes</asp:ListItem>
                                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource40">No</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div style="display: none" id="UltraDiv">
                                                                                    <asp:Label ID="lblat" runat="server" Text="at" 
                                                                                        meta:resourcekey="lblatResource1"></asp:Label>
                                                                                    <asp:TextBox CssClass="textfield" ID="txtanyUltrasoundConfirmation" 
                                                                                        runat="server" meta:resourcekey="txtanyUltrasoundConfirmationResource1"></asp:TextBox>
                                                                                    <asp:Label ID="lblWeeks" runat="server" Text="Weeks" 
                                                                                        meta:resourcekey="lblWeeksResource1"></asp:Label>
                                                                                    <asp:Button ID="btnAnypriorUltrasoundConfirmation" runat="server" Text="Attach Scan"
                                                                                        CssClass="btn" 
                                                                                        meta:resourcekey="btnAnypriorUltrasoundConfirmationResource1" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23">
                                                                <div style="display: none" id="ACX2plus3">
                                                                    <img src="../Images/showbids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                                                                      <asp:Label ID="Rs_PastMedicalHistory" Text="Past Medical History" 
                                                                        runat="server" meta:resourcekey="Rs_PastMedicalHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus3">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                                                                       <asp:Label ID="Rs_PastMedicalHistory1" Text="Past Medical History" 
                                                                        runat="server" meta:resourcekey="Rs_PastMedicalHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses3" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td width="180px" height="25px">
                                                                                <asp:CheckBox ID="chkDiabetesMellites" runat="server" Text="Diabetes Mellites" 
                                                                                    onClick="showPastMedical('chkDiabetesMellites','divShow');" 
                                                                                    meta:resourcekey="chkDiabetesMellitesResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td class="down" width="30px">
                                                                                                <asp:Label ID="Pastmh" runat="server" Text="for" 
                                                                                                    meta:resourcekey="PastmhResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="100px">
                                                                                                <asp:TextBox CssClass="textfield" ID="Pastmh1" runat="server" 
                                                                                                    meta:resourcekey="Pastmh1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="65px">
                                                                                                <asp:Label ID="Pastmh2" runat="server" Text="Years on" 
                                                                                                    meta:resourcekey="Pastmh2Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlDiabetesMellites" runat="server" 
                                                                                                    CssClass="selectoption4" meta:resourcekey="ddlDiabetesMellitesResource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource41">Diet Control</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource42">OHAs</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource43">Insulin</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource44">Insulin & OHAs</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource45">No Treatment</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="180px" height="25px">
                                                                                <asp:CheckBox ID="chkSystemicHypertension" runat="server" Text="Systemic Hypertension"
                                                                                    onClick="showPastMedical('chkSystemicHypertension','divShow1');" 
                                                                                    meta:resourcekey="chkSystemicHypertensionResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow1" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td class="down" width="30px">
                                                                                                <asp:Label ID="lblfor1" runat="server" Text="for" 
                                                                                                    meta:resourcekey="lblfor1Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="100px">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtSystemicHypertension" runat="server" 
                                                                                                    meta:resourcekey="txtSystemicHypertensionResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="65px">
                                                                                                <asp:Label ID="lblYearson1" runat="server" Text="Years on" 
                                                                                                    meta:resourcekey="lblYearson1Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlSystemicHypertension" runat="server" 
                                                                                                    CssClass="selectoption4" meta:resourcekey="ddlSystemicHypertensionResource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource46">Treatment</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource47">No Treatment</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="180px" height="25px">
                                                                                <asp:CheckBox ID="chkBronchialAsthma" runat="server" Text="Bronchial Asthma" 
                                                                                    onClick="showPastMedical('chkBronchialAsthma','divShow2');" 
                                                                                    meta:resourcekey="chkBronchialAsthmaResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow2" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td class="down" width="30px">
                                                                                                <asp:Label ID="lblfor2" runat="server" Text="for" 
                                                                                                    meta:resourcekey="lblfor2Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="100px">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtBronchialAsthma" runat="server" 
                                                                                                    meta:resourcekey="txtBronchialAsthmaResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="65px">
                                                                                                <asp:Label ID="lblYearson2" runat="server" Text="Years on" 
                                                                                                    meta:resourcekey="lblYearson2Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlBronchialAsthma" runat="server" 
                                                                                                    CssClass="selectoption4" meta:resourcekey="ddlBronchialAsthmaResource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource48">Treatment</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource49">No Treatment</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="180px" height="25px">
                                                                                <asp:CheckBox ID="chkThyroidDisorders" runat="server" Text="Thyroid Disorders" 
                                                                                    onClick="showPastMedical('chkThyroidDisorders','divShow3');" 
                                                                                    meta:resourcekey="chkThyroidDisordersResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow3" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="195px">
                                                                                                <asp:DropDownList ID="ddlThyroidDisorders" runat="server" 
                                                                                                    CssClass="selectoption2" meta:resourcekey="ddlThyroidDisordersResource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource50">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource51">Hypothyroidism</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource52">Hyperthyroidism</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td class="down" width="30px">
                                                                                                <asp:Label ID="lblfor3" runat="server" Text="for" 
                                                                                                    meta:resourcekey="lblfor3Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="100px">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtThyroidDisorders" runat="server" 
                                                                                                    meta:resourcekey="txtThyroidDisordersResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="65px">
                                                                                                <asp:Label ID="lblYearson3" runat="server" Text="Years on" 
                                                                                                    meta:resourcekey="lblYearson3Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlThyroidDisorders1" runat="server" 
                                                                                                    CssClass="selectoption4" meta:resourcekey="ddlThyroidDisorders1Resource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource53">Treatment</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource54">No Treatment</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="200px" height="25px">
                                                                                <asp:CheckBox ID="chkCardiovascularDisorders" runat="server" Text="Cardiovascular Disorders"
                                                                                    onClick="showPastMedical('chkCardiovascularDisorders','divShow4');" 
                                                                                    meta:resourcekey="chkCardiovascularDisordersResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow4" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="195px">
                                                                                                <asp:DropDownList ID="ddlCardiovascularDisorders" runat="server" 
                                                                                                    CssClass="selectoption2" meta:resourcekey="ddlCardiovascularDisordersResource1">
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource55">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource56">Congenital Diseases</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource57">Vascular Diseases</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource58">Coronary Artery Diseases</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td class="down" width="30px">
                                                                                                <asp:Label ID="lblfor" runat="server" Text="for" 
                                                                                                    meta:resourcekey="lblforResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="100px">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtCardiovascularDisorders" 
                                                                                                    runat="server" meta:resourcekey="txtCardiovascularDisordersResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="65px">
                                                                                                <asp:Label ID="lblYearson" runat="server" Text="Years on" 
                                                                                                    meta:resourcekey="lblYearsonResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfield" ID="txtCardiovascularDisorders1" 
                                                                                                    runat="server" meta:resourcekey="txtCardiovascularDisorders1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="200px" height="25px">
                                                                                <asp:CheckBox ID="chkPastHistoryofSurgeries" runat="server" Text="Past History of Surgeries"
                                                                                    onClick="showPastMedical('chkPastHistoryofSurgeries','divShow5');" 
                                                                                    meta:resourcekey="chkPastHistoryofSurgeriesResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow5" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="95">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtPastHistoryofSurgeries" runat="server" 
                                                                                                    meta:resourcekey="txtPastHistoryofSurgeriesResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="50px">
                                                                                                <asp:Label ID="lblPastHistoryofSurgeries" runat="server" Text="Year" 
                                                                                                    meta:resourcekey="lblPastHistoryofSurgeriesResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfield" ID="txtPastHistoryofSurgeries1" 
                                                                                                    runat="server" meta:resourcekey="txtPastHistoryofSurgeries1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="200px" height="25px">
                                                                                <asp:CheckBox ID="chkTransfusions" runat="server" Text="Transfusions" 
                                                                                    onClick="showPastMedical('chkTransfusions','divShow6');" 
                                                                                    meta:resourcekey="chkTransfusionsResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow6" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="145px">
                                                                                                <asp:Label ID="lblApproximateDate" runat="server" Text="Approximate Date" 
                                                                                                    meta:resourcekey="lblApproximateDateResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfield" ID="txtTransfusions" runat="server" 
                                                                                                    meta:resourcekey="txtTransfusionsResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="200px" height="25px">
                                                                                <asp:CheckBox ID="chkVaccinations" runat="server" Text="Vaccinations" 
                                                                                    onClick="showPastMedical('chkVaccinations','divShow7');" 
                                                                                    meta:resourcekey="chkVaccinationsResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow7" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="130px">
                                                                                                <asp:DropDownList ID="ddlVaccinations" runat="server" CssClass="selectoption3" 
                                                                                                    meta:resourcekey="ddlVaccinationsResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource59">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource60">TT</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource61">No</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td width="95px">
                                                                                                <asp:Label ID="lblYearorDate" runat="server" Text="Year or Date" 
                                                                                                    meta:resourcekey="lblYearorDateResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="90px">
                                                                                                <asp:TextBox CssClass="textfield" ID="txtVaccinations" runat="server" 
                                                                                                    meta:resourcekey="txtVaccinationsResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="75px">
                                                                                                &nbsp;&nbsp;&nbsp;
                                                                                                <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                                                                    meta:resourcekey="lblDosesResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfield" ID="TextBox1" runat="server" 
                                                                                                    meta:resourcekey="TextBox1Resource1"></asp:TextBox>
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23" align="left">
                                                                <div style="display: none" id="ACX2plus4">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);">
                                                                       <asp:Label ID="Rs_PersonalHistory" Text="Personal History" runat="server" 
                                                                        meta:resourcekey="Rs_PersonalHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus4">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);">
                                                                      <asp:Label ID="Rs_PersonalHistory1" Text="Personal History" runat="server" 
                                                                        meta:resourcekey="Rs_PersonalHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses4" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkConsanguinousMarriage" runat="server" Text="Consanguinous Marriage"
                                                                                    onClick="showPastMedical('chkConsanguinousMarriage','divShow8');" 
                                                                                    meta:resourcekey="chkConsanguinousMarriageResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow8" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td class="down" width="190px">
                                                                                                &nbsp;&nbsp;&nbsp;<asp:Label ID="txtDegreeofConsanguinity" runat="server" 
                                                                                                    Text="Degree of Consanguinity" 
                                                                                                    meta:resourcekey="txtDegreeofConsanguinityResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlConsanguinousMarriage" runat="server" 
                                                                                                    CssClass="selectoption3" meta:resourcekey="ddlConsanguinousMarriageResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource62">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource63">First</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource64">Second</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource65">Third</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource66">Not Known</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkOccupation" runat="server" Text="Occupation" 
                                                                                    onClick="showPastMedical('chkOccupation','divShow9');" 
                                                                                    meta:resourcekey="chkOccupationResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow9" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtOccupation" runat="server" 
                                                                                                    meta:resourcekey="txtOccupationResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkFamilyBonding" runat="server" Text="Family Bonding" 
                                                                                    onClick="showPastMedical('chkFamilyBonding','divShow10');" 
                                                                                    meta:resourcekey="chkFamilyBondingResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow10" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlFamilyBonding" runat="server" CssClass="selectoption4" 
                                                                                                    meta:resourcekey="ddlFamilyBondingResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource67">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource68">Separated</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource69">Resonable Good</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource70">Cannot Comment</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkFamilySize" runat="server" Text="Family Size" 
                                                                                    onClick="showPastMedical('chkFamilySize','divShow11');" 
                                                                                    meta:resourcekey="chkFamilySizeResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow11" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlFamilySize" runat="server" CssClass="selectoption4" 
                                                                                                    meta:resourcekey="ddlFamilySizeResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource71">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource72">Joint</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource73">Nuclear</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkBladderHabits" runat="server" Text="Bladder Habits" 
                                                                                    onClick="showPastMedical('chkBladderHabits','divShow12');" 
                                                                                    meta:resourcekey="chkBladderHabitsResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow12" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlBladderHabits" runat="server" CssClass="selectoption4" 
                                                                                                    meta:resourcekey="ddlBladderHabitsResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource74">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource75">Normal</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource76">Stress Incontinence</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource77">Urge Incontinence</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource78">Overactive Incontinence</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource79">Overflow Incontinence</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource80">Mixed Incontinence</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="190px" height="25px">
                                                                                <asp:CheckBox ID="chkBowelHabits" runat="server" Text="Bowel Habits" 
                                                                                    onClick="showPastMedical('chkBowelHabits','divShow13');" 
                                                                                    meta:resourcekey="chkBowelHabitsResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <div id="divShow13" style="display: none">
                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlBowelHabits" runat="server" CssClass="selectoption4" 
                                                                                                    meta:resourcekey="ddlBowelHabitsResource1">
                                                                                                    <asp:ListItem Value="Select" Enabled meta:resourcekey="ListItemResource81">Select</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource82">Normal</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource83">Loose Stools</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourcekey="ListItemResource84">Constipated</asp:ListItem>
                                                                                                </asp:DropDownList>
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td class="colorforcontent" width="30%" height="23" align="left">
                                                                <div style="display: none" id="ACX2plus7">
                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);">
                                                                        <asp:Label ID="Rs_TreatmentHistory" Text="Treatment History" runat="server" 
                                                                        meta:resourcekey="Rs_TreatmentHistoryResource1"></asp:Label></span>
                                                                </div>
                                                                <div style="display: block" id="ACX2minus7">
                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);">
                                                                        <asp:Label ID= "Rs_TreatmentHistory1" Text="Treatment History" 
                                                                        runat="server" meta:resourcekey="Rs_TreatmentHistory1Resource1"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td width="70%" height="23" align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responses7" style="display: block">
                                                            <td colspan="2">
                                                                <div class="dataheader2">
                                                                    <table width="713" border="0" cellspacing="0" cellpadding="0" class="tabletxt">
                                                                        <tr>
                                                                            <td height="35px">
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox ID="chkTreatmentHistory" runat="server" Text="Treatment History" 
                                                                                                onClick="showPastMedical('chkTreatmentHistory','divShow15');" 
                                                                                                meta:resourcekey="chkTreatmentHistoryResource1" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <div id="divShow15" style="display: none">
                                                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td width="150px" height="28px">
                                                                                                <asp:Label ID="lblDrugName" runat="server" Text="Drug Name" 
                                                                                                    meta:resourcekey="lblDrugNameResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="150px">
                                                                                                <asp:Label ID="lblDrugDose" runat="server" Text="Drug Dose" 
                                                                                                    meta:resourcekey="lblDrugDoseResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="150px">
                                                                                                <asp:Label ID="lblFrequency" runat="server" Text="Frequency" 
                                                                                                    meta:resourcekey="lblFrequencyResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td width="150px">
                                                                                                <asp:Label ID="lblTakingSince" runat="server" Text="Taking Since" 
                                                                                                    meta:resourcekey="lblTakingSinceResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td height="28px">
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtDrugName" runat="server" 
                                                                                                    meta:resourcekey="txtDrugNameResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtDrugDose" runat="server" 
                                                                                                    meta:resourcekey="txtDrugDoseResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtFrequency" runat="server" 
                                                                                                    meta:resourcekey="txtFrequencyResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtTakingSince" runat="server" 
                                                                                                    meta:resourcekey="txtTakingSinceResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblmonthsyears" runat="server" Text="months/years" 
                                                                                                    meta:resourcekey="lblmonthsyearsResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td height="28px">
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtDrugName1" runat="server" 
                                                                                                    meta:resourcekey="txtDrugName1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtDrugDose1" runat="server" 
                                                                                                    meta:resourcekey="txtDrugDose1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtFrequency1" runat="server" 
                                                                                                    meta:resourcekey="txtFrequency1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textfieldi" ID="txtTakingSince1" runat="server" 
                                                                                                    meta:resourcekey="txtTakingSince1Resource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblmonthyears1" runat="server" Text="months/years" 
                                                                                                    meta:resourcekey="lblmonthyears1Resource1"></asp:Label>
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
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnCheckRoutineLabs" runat="server" Text="Check Routine Labs" 
                                                        CssClass="btn" meta:resourcekey="btnCheckRoutineLabsResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnInformationConfirmed" runat="server" Text="Information Confirmed"
                                                        CssClass="btn" meta:resourcekey="btnInformationConfirmedResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="20px">
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
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
