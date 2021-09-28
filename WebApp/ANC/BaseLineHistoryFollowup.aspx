<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BaseLineHistoryFollowup.aspx.cs"
    Inherits="ANC_BaseLineHistoryFollowup" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            height: 30px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        // BaseLine Histroy ....

        function LoadBaseLineHistroyItems() {
            var HidLoadValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            var list = HidLoadValue.split('^');
            if (document.getElementById('<%=HidBaseLine.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var BaselineList = list[count].split('~');

                    var row = document.getElementById('<%=tblBaseLine.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblBaseLine.ClientID %>').rows.length;
                    row.id = icout;
                    //alert(icout);

                    row.id = BaselineList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    //alert(BaselineList[0]);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell1.style.display = "none";
                    cell2.innerHTML = BaselineList[1];
                    cell3.innerHTML = BaselineList[2];
                    cell4.innerHTML = BaselineList[3];
                    cell5.innerHTML = BaselineList[4];
                    cell6.innerHTML = BaselineList[5];
                    cell7.innerHTML = BaselineList[6];
                    cell8.innerHTML = BaselineList[7];
                    cell9.innerHTML = BaselineList[8];
                    cell10.innerHTML = BaselineList[9];
                    cell9.style.display = "none";
                    cell10.style.display = "none";
                }
            }
            return false;
        }

        // Previous Complicate Function.....

        function LoadPreviousComplicateItems() {
            var HidPreviousCompValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
            //alert(HidPreviousCompValue);
            var PrevList = HidPreviousCompValue.split('^');
            if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {
                    var PreviousCompList = PrevList[Pcount].split('~');
                    var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                    row.id = PreviousCompList;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell1.style.display = "none";
                    cell2.innerHTML = PreviousCompList;
                    //cell2.style.display = "none";
                }
            }
            return false;
        }

        // AssociateDieasesItems Script...

        function LoadAssociateDieasesItems() {
            var HidAssValue = document.getElementById('<%=HdnAssociate.ClientID %>').value;
            var AscList = HidAssValue.split('^');
            if (document.getElementById('<%=HdnAssociate.ClientID %>').value != "") {
                for (var Adcount = 0; Adcount < AscList.length - 1; Adcount++) {
                    var DieasesList = AscList[Adcount].split('~');
                    var row = document.getElementById('<%=tblAssociate.ClientID %>').insertRow(1);
                    row.id = DieasesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell1.style.display = "none";
                    cell2.innerHTML = DieasesList[1];
                    cell3.innerHTML = DieasesList[2];
                    //cell3.style.display = "none";
                }
            }
            return false;
        }

        // Prior Vaccinations

        function LoadPriorVaccinationsItems() {
            var HidVaccinationsValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            //alert(HidVaccinationsValue);
            var PriorList = HidVaccinationsValue.split('^');
            if (document.getElementById('<%=HdnVaccination.ClientID %>').value != "") {

                for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                    var PriVacList = PriorList[pvCount].split('~');

                    var row = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblBaseLine.ClientID %>').rows.length;
                    row.id = icout;

                    row.id = PriVacList[0];

                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    //alert(PriVacList[0]);
                    cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell1.style.display = "none";
                    cell2.innerHTML = PriVacList[1];
                    cell3.innerHTML = PriVacList[2];
                    cell4.innerHTML = PriVacList[3];
                    cell5.innerHTML = PriVacList[4];
                    cell6.innerHTML = PriVacList[5];
                    //cell6.style.display = "none";
                    cell7.innerHTML = PriVacList[6];
                    cell7.style.display = "none";
                }
            }
            return false;
        }

        // Current Vaccinations

        function CVaccinationsItems() {
            var VaccinationStatus = 0;
            var HidVaccinationValue = document.getElementById('<%=HdnCVaccination.ClientID %>').value;
            var Vacclist = HidVaccinationValue.split('^');
            var ddlVaccination = document.getElementById('<%=drpVaccination.ClientID %>').options[document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex].text;
            var ddlVaccinationid = document.getElementById('<%=drpVaccination.ClientID %>').value;
            var Year = '';
            var ddlMonth = '';
            var Doses = document.getElementById('<%=txtDoses.ClientID %>').value;
            var Booster;
            if (document.getElementById('<%=chkBooster.ClientID %>').checked == true) {

                Booster = 'Yes';
            }
            else { Booster = 'No'; }
            var row = document.getElementById('<%=tblCVaccinations.ClientID %>').insertRow(1);
            var vrCount = document.getElementById('<%=tblCVaccinations.ClientID %>').rows.length;
            row.id = vrCount;
            //alert(row.id);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell5 = row.insertCell(2);
            var cell6 = row.insertCell(3);
            var cell7 = row.insertCell(4);
            cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=CDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlVaccination;
            cell5.innerHTML = Doses;
            cell6.innerHTML = Booster;
            cell7.innerHTML = ddlVaccinationid;
            cell7.style.display = "none";
            document.getElementById('<%=HdnCVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
            document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtDoses.ClientID %>').value = '';
            document.getElementById('<%=chkBooster.ClientID %>').checked = false;
            VaccinationStatus = 0;
            return false;
            if (VaccinationStatus == 0) {

                var row = document.getElementById('<%=tblCVaccinations.ClientID %>').insertRow(1);
                var vrCount = document.getElementById('<%=tblCVaccinations.ClientID %>').rows.length + 100;
                row.id = vrCount;
                //alert(row.id);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell5 = row.insertCell(2);
                var cell6 = row.insertCell(3);
                var cell7 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=CDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ddlVaccination;
                cell5.innerHTML = Doses;
                cell6.innerHTML = Booster;
                cell7.innerHTML = ddlVaccinationid;
                cell7.style.display = "none";
                document.getElementById('<%=HdnCVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
                document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex = 0;

                document.getElementById('<%=txtDoses.ClientID %>').value = '';
                document.getElementById('<%=chkBooster.ClientID %>').checked = false;
                VaccinationStatus = 0;
                return false;
            }
        }

        function CDeleteclick(PriorDelItem) {
            //alert('Item - ' + PriorDelItem);
            document.getElementById(PriorDelItem).style.display = "none";
            var HidVacValue = document.getElementById('<%=HdnCVaccination.ClientID %>').value;
            //alert(HidVacValue);
            var pVlist = HidVacValue.split('^');
            var newVaccList = '';
            if (document.getElementById('<%=HdnCVaccination.ClientID %>').value != "") {
                for (var pvCount = 0; pvCount < pVlist.length; pvCount++) {
                    var priorList = pVlist[pvCount].split('~');
                    //alert(priorList[0]);
                    if (priorList[0] != '') {
                        if (priorList[0] != PriorDelItem) {
                            newVaccList += pVlist[pvCount] + "^";
                            //alert('New = ' + newVaccList);
                        }
                    }
                }
                document.getElementById('<%=HdnCVaccination.ClientID %>').value = newVaccList;
            }
            //alert(newVaccList);
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <%--<uc7:Header ID="UsrHeader1" runat="server" />--%>
                <uc11:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata" id="dMain">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor" width="100%">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus1" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);"
                                                        style="cursor: pointer">&nbsp;<asp:Label ID="Rs_PregnancyDetails" 
                                                        Text="Pregnancy Details" runat="server" 
                                                        meta:resourcekey="Rs_PregnancyDetailsResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus1" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_PregnancyDetails1" 
                                                        Text="Pregnancy Details" runat="server" 
                                                        meta:resourcekey="Rs_PregnancyDetails1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses1" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                        <tr>
                                                            <td style="width: 20%">
                                                                <asp:Label ID="lblPregnancy" runat="server" Text="Pregnancy" 
                                                                    meta:resourcekey="lblPregnancyResource1"></asp:Label>
                                                            </td>
                                                            <td style="width: 18%">
                                                                <asp:DropDownList ID="drpPregnancy" Enabled="False" runat="server" CssClass ="ddlsmall"
                                                                    meta:resourcekey="drpPregnancyResource1">
                                                                    <asp:ListItem Text="Select" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="Confirmed" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                    <asp:ListItem Text="To re-confirm" Value="2" 
                                                                        meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                    <asp:ListItem Text="Yet to confirm" Value="3" 
                                                                        meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td style="width: 62%">
                                                                <table id="tblPregnancy" border="0" cellpadding="0" cellspacing="0" width="66%">
                                                                    <tr>
                                                                        <td style="width: 25%">
                                                                            <asp:CheckBox ID="chkIsPrimipara" Enabled="False" runat="server" 
                                                                                Text="Primipara" meta:resourcekey="chkIsPrimiparaResource1" />
                                                                        </td>
                                                                        <td style="width: 75%">
                                                                            <asp:CheckBox ID="chkIsBad" Enabled="False" runat="server" 
                                                                                Text="Bad Obstretic History" meta:resourcekey="chkIsBadResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblEnterDateofLMP" runat="server" Text="Date of LMP" 
                                                                    meta:resourcekey="lblEnterDateofLMPResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" 
                                                                    ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                    TargetControlID="tLMP" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                                    TargetControlID="tLMP" Enabled="True" />
                                                                <asp:TextBox ID="tLMP" runat="server" Enabled="False" CssClass ="Txtboxsmall"  MaxLength="1"
                                                                    Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" 
                                                                    meta:resourcekey="tLMPResource1" />
                                                                <asp:ImageButton Enabled="False" ID="ImgBntCalc" runat="server" CausesValidation="False"
                                                                    ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                    meta:resourcekey="ImgBntCalcResource1" />
                                                            </td>
                                                            <td>
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="tLMP" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                                    meta:resourcekey="MaskedEditValidator5Resource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCalculatedEDD" runat="server" Text="Calculated EDD" 
                                                                    meta:resourcekey="lblCalculatedEDDResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                                                                    ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                    TargetControlID="txtCalculatedEDD" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc1"
                                                                    TargetControlID="txtCalculatedEDD" Enabled="True" />
                                                                <asp:TextBox ID="txtCalculatedEDD" runat="server" Enabled="False" 
                                                                     CssClass ="Txtboxsmall" meta:resourcekey="txtCalculatedEDDResource1"></asp:TextBox>
                                                                <asp:ImageButton Enabled="False" ID="ImgBntCalc1" runat="server" CausesValidation="False"
                                                                    ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                    meta:resourcekey="ImgBntCalc1Resource1" />
                                                            </td>
                                                            <td>
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="txtCalculatedEDD" Display="Dynamic" EmptyValueBlurredText="*"
                                                                    EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                    TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" 
                                                                    ErrorMessage="MaskedEditValidator1" 
                                                                    meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus6" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);"
                                                        style="cursor: pointer">&nbsp;<asp:Label ID="Rs_BaselineHistory" 
                                                        Text="Baseline History" runat="server" 
                                                        meta:resourcekey="Rs_BaselineHistoryResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus6" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);"
                                                        style="cursor: pointer"><asp:Label ID="BaselineHistory1" 
                                                        Text="Baseline History" runat="server" 
                                                        meta:resourcekey="BaselineHistory1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses6" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" width="20%">
                                                        <tr>
                                                            <td style="width: 5%">
                                                                <asp:Label ID="lblGravida" CssClass="fontGPLA" runat="server" Text="G" 
                                                                    meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                                <asp:TextBox ID="txtGravida" MaxLength="2" runat="server"  CssClass ="Txtboxsmall" Width ="120px"
                                                                    meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                            </td>
                                                            <td style="width: 5%">
                                                                <asp:Label ID="lblPara" runat="server" CssClass="fontGPLA" Text="P" 
                                                                    meta:resourcekey="lblParaResource1"></asp:Label>
                                                                <asp:TextBox ID="txtPara" MaxLength="2" runat="server"  CssClass ="Txtboxsmall" Width ="120px"
                                                                    meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                            </td>
                                                            <td style="width: 5%">
                                                                <asp:Label ID="lblLive" runat="server" CssClass="fontGPLA" Text="L" 
                                                                    meta:resourcekey="lblLiveResource1"></asp:Label>
                                                                <asp:TextBox ID="txtLive" MaxLength="2" runat="server" CssClass ="Txtboxsmall" Width ="120px"
                                                                    meta:resourcekey="txtLiveResource1"></asp:TextBox>
                                                            </td>
                                                            <td style="width: 5%">
                                                                <asp:Label ID="lblAbortUs" runat="server" CssClass="fontGPLA" Text="A" 
                                                                    meta:resourcekey="lblAbortUsResource1"></asp:Label>
                                                                <asp:TextBox ID="txtAbortUs" MaxLength="2" runat="server" CssClass ="Txtboxsmall" Width ="120px"
                                                                    meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <asp:HiddenField ID="HidBaseLine" runat="server" />
                                                    <table id="tblBaseLine" class="defaultfontcolor" runat="server" width="100%" cellspacing="0"
                                                        border="2">
                                                        <tr class="colorforcontent">
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                                                                <asp:Label ID="Rs_SexofChild" Text="Sex of Child" runat="server" 
                                                                    meta:resourcekey="Rs_SexofChildResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                                                <asp:Label ID="Rs_Age" Text="Age" runat="server" 
                                                                    meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                                                                <asp:Label ID="Rs_MOD" Text="M O D" runat="server" 
                                                                    meta:resourcekey="Rs_MODResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 13%;">
                                                               <asp:Label ID="Rs_BirthWeight" Text="Birth Weight" runat="server" 
                                                                    meta:resourcekey="Rs_BirthWeightResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 11%;">
                                                                <asp:Label ID="Rs_GrowthNormal" Text="Growth Normal" runat="server" 
                                                                    meta:resourcekey="Rs_GrowthNormalResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                               <asp:Label ID="Rs_GrowthRate" Text="Growth Rate" runat="server" 
                                                                    meta:resourcekey="Rs_GrowthRateResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                                <asp:Label ID="Rs_BirthMaturity"  Text="Birth Maturity" runat="server" 
                                                                    meta:resourcekey="Rs_BirthMaturityResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight:bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                                display: none;">
                                                                <asp:Label ID="Rs_MODID" Text="MODID" runat="server" 
                                                                    meta:resourcekey="Rs_MODIDResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight:bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                                display: none;">
                                                                <asp:Label ID="Rs_BMID" Text="BMID" runat="server" 
                                                                    meta:resourcekey="Rs_BMIDResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus2" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_PreviousComplicatedPregnancies" 
                                                        Text="Previous Complicated Pregnancies" runat="server" 
                                                        meta:resourcekey="Rs_PreviousComplicatedPregnanciesResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus2" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                        style="cursor: pointer">&nbsp;<asp:Label 
                                                        ID="Rs_PreviousComplicatedPregnancies1" Text="Previous Complicated Pregnancies" 
                                                        runat="server" meta:resourcekey="Rs_PreviousComplicatedPregnancies1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses2" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <br />
                                                    <asp:HiddenField ID="HdnPreviousComplicate" runat="server" />
                                                    <table id="tblPreviousComplicate" class="defaultfontcolor" runat="server" width="50%"
                                                        cellspacing="0" border="2">
                                                        <tr class="colorforcontent">
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;">
                                                                <asp:Label ID="Rs_ComplicationName" Text="Complication Name" runat="server" 
                                                                    meta:resourcekey="Rs_ComplicationNameResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus3" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);"
                                                        src="../Images/showbids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_AssociatedDiseases" 
                                                        Text="Associated Diseases" runat="server" 
                                                        meta:resourcekey="Rs_AssociatedDiseasesResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus3" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_AssociatedDiseases1" 
                                                        Text="Associated Diseases" runat="server" 
                                                        meta:resourcekey="Rs_AssociatedDiseases1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses3" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <br />
                                                    <asp:HiddenField ID="HdnAssociate" runat="server" />
                                                    <table id="tblAssociate" class="defaultfontcolor" runat="server" width="50%" cellspacing="0"
                                                        border="2">
                                                        <tr class="colorforcontent">
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;">
                                                                <asp:Label ID="Rs_ComplaintName" Text="Complaint Name" runat="server" 
                                                                    meta:resourcekey="Rs_ComplaintNameResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;">
                                                                <asp:Label ID="Rs_ComplaintName1" Text="Description" runat="server" 
                                                                    meta:resourcekey="Rs_ComplaintName1Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus4" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_PastVaccinations" 
                                                        Text="Past Vaccinations" runat="server" 
                                                        meta:resourcekey="Rs_PastVaccinationsResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus4" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_PastVaccinations1" 
                                                        Text="Past Vaccinations" runat="server" 
                                                        meta:resourcekey="Rs_PastVaccinations1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses4" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <br />
                                                    <asp:HiddenField ID="HdnVaccination" runat="server" />
                                                    <table id="tblPriorVaccinations" class="defaultfontcolor" runat="server" width="100%"
                                                        cellspacing="0" border="2">
                                                        <tr class="colorforcontent">
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;">
                                                                <asp:Label ID="Rs_Vaccination1" Text="Vaccination" runat="server" 
                                                                    meta:resourcekey="Rs_Vaccination1Resource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                                                                <asp:Label ID="Rs_Year" Text="Year" runat="server" 
                                                                    meta:resourcekey="Rs_YearResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                                                               <asp:Label ID="Rs_Month" Text="Month" runat="server" 
                                                                    meta:resourcekey="Rs_MonthResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                               <asp:Label ID="Rs_Doses1" Text="Doses" runat="server" 
                                                                    meta:resourcekey="Rs_Doses1Resource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                                <asp:Label ID="Rs_Booster1" Text="Booster" runat="server" 
                                                                    meta:resourcekey="Rs_Booster1Resource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                                <asp:Label ID="Rs_VaccinationID1" Text="Vaccination ID" runat="server" 
                                                                    meta:resourcekey="Rs_VaccinationID1Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plusPV" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusPV','ACX2minusPV','ACX2responsesPV',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusPV','ACX2minusPV','ACX2responsesPV',1);"
                                                        style="cursor: pointer">&nbsp;<asp:Label ID="Rs_PatientVitals" 
                                                        Text="Patient Vitals" runat="server" 
                                                        meta:resourcekey="Rs_PatientVitalsResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minusPV" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusPV','ACX2minusPV','ACX2responsesPV',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusPV','ACX2minusPV','ACX2responsesPV',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_PatientVitals1" 
                                                        Text="Patient Vitals" runat="server" 
                                                        meta:resourcekey="Rs_PatientVitals1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responsesPV" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <br />
                                                    <uc10:PatientVitals ID="PatientVitalsControl" runat="server" />
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plusCV" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusCV','ACX2minusCV','ACX2responsesCV',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusCV','ACX2minusCV','ACX2responsesCV',1);"
                                                        style="cursor: pointer"><aspPatient Vaccinations</span>
                                                </div>
                                                <div id="ACX2minusCV" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusCV','ACX2minusCV','ACX2responsesCV',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusCV','ACX2minusCV','ACX2responsesCV',0);"
                                                        style="cursor: pointer">&nbsp;<asp:Label ID="Rs_PatientVaccinations" 
                                                        Text="Patient Vaccinations" runat="server" 
                                                        meta:resourcekey="Rs_PatientVaccinationsResource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responsesCV" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="70%">
                                                        <tr>
                                                            <td style="width: 12%">
                                                                <asp:Label ID="lblVacc" runat="server" Text="Vaccination" 
                                                                    meta:resourcekey="lblVaccResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="drpVaccination" runat="server"  CssClass ="ddlsmall"
                                                                    meta:resourcekey="drpVaccinationResource1" 
                                                                    >
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                                    meta:resourcekey="lblDosesResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDoses" runat="server"  CssClass ="Txtboxverysmall" size="5"  Height ="20px"
                                                                    meta:resourcekey="txtDosesResource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="chkBooster" runat="server" Text="Is a Booster?" 
                                                                    meta:resourcekey="chkBoosterResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                    OnClientClick="return CVaccinationsItems();" onmouseover="this.className='btn btnhov'"
                                                                    Text="Add" meta:resourcekey="btnAddResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="5" align="left">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:HiddenField ID="HdnCVaccination" runat="server" />
                                                    <br />
                                                    <table id="tblCVaccinations" class="defaultfontcolor" runat="server" width="100%"
                                                        cellspacing="0" border="2">
                                                        <tr class="colorforcontent">
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;">
                                                                <asp:Label ID="Rs_Vaccination" Text="Vaccination" runat="server" 
                                                                    meta:resourcekey="Rs_VaccinationResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                               <asp:Label ID="Rs_Doses" Text="Doses" runat="server" 
                                                                    meta:resourcekey="Rs_DosesResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                               <asp:Label ID="Rs_Booster" Text="Booster" runat="server" 
                                                                    meta:resourcekey="Rs_BoosterResource1"></asp:Label>
                                                            </td>
                                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                display: none;">
                                                                <asp:Label ID="Rs_VaccinationID" Text="Vaccination ID" runat="server" 
                                                                    meta:resourcekey="Rs_VaccinationIDResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="25%">
                                                <div id="ACX2plusInv" style="display: none">
                                                    &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                                        style="cursor:pointer"><asp:Label ID="Rs_Investigation" 
                                                        Text="Investigation" runat="server" 
                                                        meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minusInv" style="display:block">
                                             <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_Investigation1" 
                                                        Text="Investigation" runat="server" 
                                                        meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                            
                                            </td>
                                        </tr>
                                        <tr id="ACX2responsesInv" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <asp:CheckBoxList CssClass="chkdefaultfontcolor" ID="chkInvestigation" RepeatColumns="5"
                                                        runat="server" meta:resourcekey="chkInvestigationResource1">
                                                    </asp:CheckBoxList>
                                                    <br />
                                                  <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                        <asp:Label ID="Rs_OrderMoreInvestigations" 
                                                        Text="Order More Investigations..." runat="server" 
                                                        meta:resourcekey="Rs_OrderMoreInvestigationsResource1"></asp:Label></label>
                                                    <br />
                                                    <br />
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" height="23" class="colorforcontent" width="30%">
                                                <div id="ACX2plus7" style="display: none">
                                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);"
                                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_Ultrasonography" 
                                                        Text="Ultrasonography" runat="server" 
                                                        meta:resourcekey="Rs_UltrasonographyResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus7" style="display: block">
                                                    <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);"
                                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                    <span class="dataheader1txt" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);"
                                                        style="cursor: pointer"><asp:Label ID="Rs_Ultrasonography1" 
                                                        Text="Ultrasonography" runat="server" 
                                                        meta:resourcekey="Rs_Ultrasonography1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="left" height="23" width="70%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses7" class="tablerow" style="display: block">
                                            <td colspan="2">
                                                <div class="dataheader2">
                                                    <table border="0" cellpadding="0" cellspacing="0" class="tabletxt" width="100%">
                                                        <tr>
                                                            <td>
                                                                <table border="0" cellpadding="0" cellspacing="4" width="100%">
                                                                    <tr>
                                                                        <td style="width: 18%">
                                                                            <asp:Label ID="LblGest" runat="server" Text="Gestational Age" 
                                                                                meta:resourcekey="LblGestResource1"></asp:Label>
                                                                        </td>
                                                                        <td valign="middle">
                                                                            <asp:Label ID="Label1" runat="server" Text="Weeks" 
                                                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                                                    
                                                                            <asp:DropDownList ID="drpweeks" runat="server"  CssClass ="ddl" 
                                                                                meta:resourcekey="drpweeksResource1">
                                                                            </asp:DropDownList>
                                                                      
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lbldays" runat="server" Text="Days" 
                                                                                meta:resourcekey="lbldaysResource1"></asp:Label>
                                                                           
                                                                            <asp:DropDownList ID="drpDays" runat="server" Height="19px" Width="67px"  CssClass ="ddl"
                                                                                meta:resourcekey="drpDaysResource1">
                                                                                <asp:ListItem Text="0" meta:resourcekey="ListItemResource5">0</asp:ListItem>
                                                                                <asp:ListItem Text="1" meta:resourcekey="ListItemResource6">1</asp:ListItem>
                                                                                <asp:ListItem Text="2" meta:resourcekey="ListItemResource7">2</asp:ListItem>
                                                                                <asp:ListItem Text="3" meta:resourcekey="ListItemResource8">3</asp:ListItem>
                                                                                <asp:ListItem Text="4" meta:resourcekey="ListItemResource9">4</asp:ListItem>
                                                                                <asp:ListItem Text="5" meta:resourcekey="ListItemResource10">5</asp:ListItem>
                                                                                <asp:ListItem Text="6" meta:resourcekey="ListItemResource11">6</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="style1">
                                                                            <asp:Label ID="lblPlacental" runat="server" Text="Placental Position" 
                                                                                meta:resourcekey="lblPlacentalResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="style1">
                                                                            <asp:DropDownList ID="drpPlacental" runat="server"  CssClass ="ddlsmall"
                                                                                meta:resourcekey="drpPlacentalResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td class="style1">
                                                                            <asp:Label ID="lblMultiGest" runat="server" Text="Multiple Gestation" 
                                                                                meta:resourcekey="lblMultiGestResource1"></asp:Label>
                                                                            <asp:DropDownList ID="drpMultiGest" runat="server" Height="25px" Width="72px" CssClass ="ddl"
                                                                                meta:resourcekey="drpMultiGestResource1">
                                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource12">Select</asp:ListItem>
                                                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource13">1</asp:ListItem>
                                                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource14">2</asp:ListItem>
                                                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource15">3</asp:ListItem>
                                                                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource16">4</asp:ListItem>
                                                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource17">5</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td class="style1">
                                                                            <asp:Label ID="lblOther" runat="server" Text="Other" 
                                                                                meta:resourcekey="lblOtherResource1"></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:TextBox ID="txtOther1" runat="server"  CssClass="Txtboxsmall"
                                                                                meta:resourcekey="txtOther1Resource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 20%">
                                                                            <asp:Label ID="Label2" runat="server" Text="Date Of UltraSound" 
                                                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" 
                                                                                ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                                TargetControlID="txtDateOfUltraSound" InputDirection="RightToLeft" 
                                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                                CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcDt"
                                                                                TargetControlID="txtDateOfUltraSound" Enabled="True" />
                                                                            <asp:TextBox ID="txtDateOfUltraSound" runat="server" CssClass ="Txtboxsmall" MaxLength="1"
                                                                                Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" 
                                                                                meta:resourcekey="txtDateOfUltraSoundResource1" />
                                                                            <asp:ImageButton ID="ImgBntCalcDt" runat="server" CausesValidation="False" 
                                                                                ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                                meta:resourcekey="ImgBntCalcDtResource1" />
                                                                            <ajc:MaskedEditValidator ID="M" runat="server" ControlExtender="MaskedEditExtender2"
                                                                                ControlToValidate="txtDateOfUltraSound" Display="Dynamic" EmptyValueBlurredText="*"
                                                                                EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                                TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="M" 
                                                                                meta:resourcekey="MResource1" />
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
                                                                            <td height="28px" width="150px">
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
                                                                                <asp:TextBox ID="txtDrugName" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtDrugNameResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtDrugDose" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtDrugDoseResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtFrequency" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtFrequencyResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTakingSince" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtTakingSinceResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblmonthsyears" runat="server" Text="months/years" 
                                                                                    meta:resourcekey="lblmonthsyearsResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td height="28px">
                                                                                <asp:TextBox ID="txtDrugName1" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtDrugName1Resource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtDrugDose1" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtDrugDose1Resource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtFrequency1" runat="server" CssClass="textfieldi" 
                                                                                    meta:resourcekey="txtFrequency1Resource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTakingSince1" runat="server" CssClass="textfieldi" 
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
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSave" Visible="False" runat="server" CssClass="btn" Text="Save"
                                        onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" Width="68px" />
                                    &nbsp; &nbsp;
                                    <asp:Button ID="btnCancel" Visible="False" runat="server" CssClass="btn" Text="Cancel"
                                        onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" 
                                        Width="75px" />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnPatientDiagnose" Visible="False" runat="server" CssClass="btn"
                                        Text="Patient Diagnose" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                        OnClick="btnPatientDiagnose_Click" 
                                        meta:resourcekey="btnPatientDiagnoseResource1" Width="157px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata">
                        <uc12:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                        <input type="button" id="btnClose" value="Close" class="btn" onclick="ShowProfile('DivProfile')"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                    </div>
                </td>
            </tr>
        </table>
        <%--<uc4:Footer ID="Footer1" runat="server" />--%>
    </div>
    </form>
</body>
</html>
