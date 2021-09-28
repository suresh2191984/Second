<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true"
    CodeFile="ANCPatientDignose.aspx.cs" Inherits="ANC_ANCPatientDignose" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="VitalInformation.ascx" TagName="VitalInformation" TagPrefix="uc1" %>
<%@ Register Src="ANCFollowUp2.ascx" TagName="ANCFollowup" TagPrefix="uc2" %>
<%@ Register Src="ANCVisitSummary.ascx" TagName="ANCVisitSummary" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/VitalsSnapShotview.ascx" TagName="vitalsSSV" TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" runat="server" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry() {
            document.getElementById('btnSubmit').style.display = 'none';
            GetDesc();
        }
        function validExam() {
            document.getElementById('ucANCFollowup_divPregnancy1').style.display = 'none';
            document.getElementById('ucANCFollowup_divGeneral').style.display = 'none';
            document.getElementById('ucANCFollowup_divObstratic').style.display = 'none';
            document.getElementById('ucANCFollowup_divBreast').style.display = 'none';
            document.getElementById('ucANCFollowup_divNipples').style.display = 'none';
            document.getElementById('ucANCFollowup_divGenitalia').style.display = 'none';
            document.getElementById('ucANCFollowup_divExamOthers').style.display = 'none';
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnNoLog">

    <script language="javascript" type="text/javascript">



        // Current Vaccinations

        function LoadCVaccinationsItems() {
            var HidVaccinationsValue = document.getElementById('<%=HdnCVaccination.ClientID %>').value;
            //alert(HidVaccinationsValue);
            var PriorList = HidVaccinationsValue.split('^');
            if (document.getElementById('<%=HdnCVaccination.ClientID %>').value != "") {

                for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                    var PriVacList = PriorList[pvCount].split('~');

                    var row = document.getElementById('<%=tblCVaccinations.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblCVaccinations.ClientID %>').rows.length;
                    row.id = icout;

                    row.id = PriVacList[0];

                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell5 = row.insertCell(2);
                    var cell6 = row.insertCell(3);
                    var cell7 = row.insertCell(4);
                    //alert(PriVacList[0]);
                    cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=CDeleteclick('" + icout + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    //cell1.style.display = "none";
                    cell2.innerHTML = PriVacList[1];
                    cell5.innerHTML = PriVacList[2];
                    cell6.innerHTML = PriVacList[3];
                    //cell6.style.display = "none";
                    cell7.innerHTML = PriVacList[4];
                    cell7.style.display = "none";
                }
            }
            return false;
        }

        function CVaccinationsItems() {
            var VaccinationStatus = 0;
            var HidVaccinationValue = document.getElementById('<%=HdnCVaccination.ClientID %>').value;
            //alert(HidVaccinationValue);
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

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
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
                <uc5:MainHeader ID="MHead" runat="server" />
                <uc10:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc8:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="panelAdvice" runat="server">
                            <ContentTemplate>
                                <table width="90%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td colspan="2" style="text-align: right;">
                                            <asp:Button ID="btnBaseLineAddTop" Visible="False" runat="server" Text="Add BaseLine Screening"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnBaseLineAddTop_Click" 
                                                meta:resourcekey="btnBaseLineAddTopResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Panel ID="Panel2" runat="server" CssClass="collapsePanelHeader" 
                                                Height="30px" meta:resourcekey="Panel2Resource1">
                                                <div style="cursor: pointer; vertical-align: middle;">
                                                    <div style="float: left; margin-left: 20px;">
                                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1">(Click to View ANC Snap Shot View...)</asp:Label><asp:ImageButton
                                                            ID="Image1" runat="server" ImageUrl="../Images/collapse.jpg" 
                                                            AlternateText="(Click to View Details...)" meta:resourcekey="Image1Resource1" />
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel1" runat="server" CssClass="collapsePanel" Height="0px" 
                                                meta:resourcekey="Panel1Resource1">
                                                <uc16:vitalsSSV ID="uSSV" runat="server" />
                                            </asp:Panel>
                                            <ajc:CollapsiblePanelExtender ID="cpeDemo" runat="server" TargetControlID="Panel1"
                                                ExpandControlID="Panel2" CollapseControlID="Panel2" TextLabelID="Label1"
                                                ImageControlID="Image1" ExpandedText="(Click to View ANC Snap Shot View...)"
                                                CollapsedText="(Click to View ANC Snap Shot View...)" ExpandedImage="../Images/collapse.jpg"
                                                CollapsedImage="../Images/expand.jpg" SuppressPostBack="True" 
                                                SkinID="CollapsiblePanelDemo" Enabled="True" />
                                        </td>
                                    </tr>
                                    <tr style="height: 5px;">
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top">
                                            <uc1:VitalInformation runat="server" ID="ucVitalInformationTrend" />
                                            <uc3:ANCVisitSummary runat="server" ID="ucANCVitalSummary" />
                                        </td>
                                        <td align="left" valign="top">
                                            <uc2:ANCFollowup runat="server" ID="ucANCFollowup" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td align="left" height="23" class="colorforcontent" width="30%">
                                            <div id="ACX2plus4Vac" style="display: none">
                                                &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus4Vac','ACX2minus4Vac','ACX2responses4Vac',1);"
                                                    src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                <span class="dataheader1txt" onclick="showResponses('ACX2plus4Vac','ACX2minus4Vac','ACX2responses4Vac',1);"
                                                    style="cursor: pointer"><asp:Label ID="Rs_Vaccinations" Text="Vaccinations" 
                                                    runat="server" meta:resourcekey="Rs_VaccinationsResource1"></asp:Label></span>
                                            </div>
                                            <div id="ACX2minus4Vac" style="display: block">
                                                &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus4Vac','ACX2minus4Vac','ACX2responses4Vac',0);"
                                                    src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                <span class="dataheader1txt" onclick="showResponses('ACX2plus4Vac','ACX2minus4Vac','ACX2responses4Vac',0);"
                                                    style="cursor: pointer"><asp:Label ID="Rs_Vaccinations1" 
                                                    Text="Vaccinations" runat="server" meta:resourcekey="Rs_Vaccinations1Resource1"></asp:Label></span>
                                            </div>
                                        </td>
                                        <td align="left" height="23" width="70%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr id="ACX2responses4Vac" class="tablerow" style="display: block">
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
                                                                meta:resourcekey="drpVaccinationResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                                meta:resourcekey="lblDosesResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDoses" runat="server"  CssClass ="Txtboxverysmall" size="5" 
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
                                                <asp:HiddenField ID="HdnVaccination" runat="server" />
                                                <br />
                                                <br />
                                                <table id="tblCVaccinations" class="defaultfontcolor" runat="server" width="100%"
                                                    cellspacing="0" border="2">
                                                    <tr class="colorforcontent" runat="server">
                                                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                            runat="server">
                                                        </td>
                                                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;" 
                                                            runat="server">
                                                            <asp:Label ID="Rs_Vaccination" Text="Vaccination" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;" 
                                                            runat="server">
                                                            <asp:Label ID="Rs_Doses" Text="Doses" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;" 
                                                            runat="server">
                                                            <asp:Label ID="Rs_Booster" Text="Booster" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                            display: none;" runat="server">
                                                           <asp:Label ID="Rs_VaccinationID" Text="Vaccination ID" runat="server"></asp:Label>
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
                                                    style="cursor: pointer"><asp:Label ID="Rs_Investigation" 
                                                    Text="Investigation" runat="server" 
                                                    meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                            </div>
                                            <div id="ACX2minusInv" style="display: block">
                                                &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                    src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                    style="cursor: pointer"><asp:Label ID="Rs_Investigation1" 
                                                    Text="Investigation" runat="server" 
                                                    meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                            </div>
                                        </td>
                                        <td align="left" height="23" width="70%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr id="ACX2responsesInv" class="tablerow" style="display: block">
                                        <td colspan="2">
                                            <div class="dataheader2">
                                                <asp:Label ID="Rs_InvestigationsOrdered" Text="Investigations Ordered" 
                                                    runat="server" meta:resourcekey="Rs_InvestigationsOrderedResource1"></asp:Label>
                                                <br />
                                                <asp:DataList ID="dlInvName" runat="server" CellPadding="4" GridLines="Horizontal"
                                                    RepeatColumns="5" meta:resourcekey="dlInvNameResource1">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                </td>
                                                                <td>
                                                                    <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                                <br />
                                                <asp:CheckBoxList CssClass="chkdefaultfontcolor" ID="chkInvestigation" RepeatColumns="5"
                                                    runat="server" meta:resourcekey="chkInvestigationResource1">
                                                </asp:CheckBoxList>
                                                <br />
                                               <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                   <asp:Label ID="Rs_OrderMoreInvestigations" 
                                                    Text="Order More Investigations..." runat="server" 
                                                    meta:resourcekey="Rs_OrderMoreInvestigationsResource1"></asp:Label></label>
                                                <br />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <uc15:GeneralAdv ID="uGAdv" runat="server" />
                                <br />
                                <uc11:Adv ID="uAd" runat="server" />
                                <uc17:InvenAdv ID="uIAdv" runat="server" />
                                <br />
                                <table>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblObservation" runat="server" Text="Observation" 
                                                CssClass="defaultfontcolor" meta:resourcekey="lblObservationResource1"></asp:Label>:
                                            <asp:TextBox ID="txtObservation" runat="server" TextMode="MultiLine" 
                                                meta:resourcekey="txtObservationResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTxt" runat="server" Text="Next Review After" 
                                                CssClass="defaultfontcolor" meta:resourcekey="lblTxtResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlNos"  CssClass ="ddl" runat="server" 
                                                meta:resourcekey="ddlNosResource1">
                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">1</asp:ListItem>
                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">2</asp:ListItem>
                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource3">3</asp:ListItem>
                                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource4">4</asp:ListItem>
                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource5">5</asp:ListItem>
                                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource6">6</asp:ListItem>
                                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource7">7</asp:ListItem>
                                                <asp:ListItem Value="8" meta:resourcekey="ListItemResource8">8</asp:ListItem>
                                                <asp:ListItem Value="9" meta:resourcekey="ListItemResource9">9</asp:ListItem>
                                                <asp:ListItem Value="10" meta:resourcekey="ListItemResource10">10</asp:ListItem>
                                                <asp:ListItem Value="11" meta:resourcekey="ListItemResource11">11</asp:ListItem>
                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource12">0</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlDMY"  CssClass ="ddl" runat="server" 
                                                meta:resourcekey="ddlDMYResource1">
                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                                <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource14">Day(s)</asp:ListItem>
                                                <asp:ListItem Selected="True" Value="Week(s)" 
                                                    meta:resourcekey="ListItemResource15">Week(s)</asp:ListItem>
                                                <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource16">Month(s)</asp:ListItem>
                                                <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource17">Year(s)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNextReviewDate" runat="server"  CssClass ="Txtboxsmall"
                                                meta:resourcekey="txtNextReviewDateResource1"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtNextReviewDate"
                                                Mask="99/99/9999" MaskType="Date"
                                                ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtNextReviewDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                meta:resourcekey="MaskedEditValidator5Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtNextReviewDate"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkAdmit" CssClass="defaultfontcolor" runat="server" 
                                                Text="Admit" meta:resourcekey="chkAdmitResource1" />
                                            <asp:CheckBox ID="chkScan" CssClass="defaultfontcolor" runat="server" 
                                                Text="Scan" meta:resourcekey="chkScanResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table>
                                    <tr>
                                        <td>
                                            <input type="hidden" id="did" />
                                            <asp:Button Text="Finish" ID="btnSubmit" Enabled="False" runat="server" CssClass="btn"
                                                onmouseover="this.className='btn btnhov'" 
                                                onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry();"
                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" 
                                                Width="64px" />
                                            <asp:Button Text="Save & Continue" Enabled="False" Visible="False" ID="btnSaveContinue"
                                                runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnSaveContinue_Click" 
                                                meta:resourcekey="btnSaveContinueResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                                meta:resourcekey="btnCancelResource1" />
                                            <asp:Button ID="btnPatientDetail" Visible="False" runat="server" Text="View Patient Detail"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                onmouseout="this.className='btn'" 
                                                meta:resourcekey="btnPatientDetailResource1" />
                                            <asp:Button ID="btnBaseLineAdd" Visible="False" runat="server" Text="Add BaseLine Screening"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnBaseLineAdd_Click" 
                                                meta:resourcekey="btnBaseLineAddResource1" />
                                            <asp:Button ID="btnBaseLineView" Visible="False" runat="server" Text="View BaseLine Screening"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnBaseLineView_Click" 
                                                meta:resourcekey="btnBaseLineViewResource1" />
                                            <asp:Button ID="btnEditBaseLine" Visible="False" runat="server" Text="Edit BaseLine Screening"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnEditBaseLine_Click" 
                                                meta:resourcekey="btnEditBaseLineResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
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
        <uc7:Footer ID="Footer" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" 
            meta:resourcekey="btnNoLogResource1" />
    </div>
    </form>
</body>
</html>
