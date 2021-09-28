<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientHistoryPackage.aspx.cs"
    Inherits="Patient_PatientHistoryPackage" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InventoryAdvice"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

          function showContent(id) {
              var chkvalue = id;          
              var divid = 'div' + chkvalue;
              if (document.getElementById(id).checked == true) {
                  document.getElementById(divid).style.display = 'block';
              }
              else {
                  document.getElementById(divid).style.display = 'none';
              }
          
          }

          function showOthersBox(ddl) {
              var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
              var strDiv = 'div' + ddl;
              
              if ((ddlValue == "Others") || (ddlValue == "Occasional Physicial Activity") || (ddlValue == "Athlete") || (ddlValue == "Regular Exercise")) {
                  document.getElementById(strDiv).style.display = 'block';
              }
              else {
                  document.getElementById(strDiv).style.display = 'none';
              }
          }


          function showOthersChkBox(id) {
              if (document.getElementById(id).checked == true) {


                  document.getElementById('divchkOthers_9').style.display = 'block';
              }
              else {
                  document.getElementById('divchkOthers_9').style.display = 'none';
              }
          }
          //Add surgery details
          function onClickAddSurgery() {
              var rwNumber = parseInt(110);
              var AddStatus = 0;             
              var txtSurgeryName = document.getElementById('txtsurgeryName').value.trim();
              var txtDate = document.getElementById('txtDate').value.trim();
              var txtHospital = document.getElementById('txtHospital').value;
              document.getElementById('tblSurgeryItems').style.display = 'block';
              var HidValue = document.getElementById('hdnSurgeryItems').value;
              var list = HidValue.split('^');
              if (document.getElementById('hdnSurgeryItems').value != "") {
                  for (var count = 0; count < list.length; count++) {
                      var HistoryList = list[count].split('~');
                      if (HistoryList[1] != '') {
                          if (HistoryList[0] != '') {
                              rwNumber = parseInt(parseInt(HistoryList[0]) + parseInt(1));
                          }
                          if (txtSurgeryName != '') {
                              if (HistoryList[1] == txtSurgeryName) {

                                  AddStatus = 1;
                              }
                          }
                      }
                  }
              }
              else {

                  if (txtSurgeryName != '') {
                      var row = document.getElementById('tblSurgeryItems').insertRow(0);
                      row.id = parseInt(rwNumber);
                      var cell1 = row.insertCell(0);
                      var cell2 = row.insertCell(1);
                      var cell3 = row.insertCell(2);
                      var cell4 = row.insertCell(3);
                      cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgery(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                      cell1.width = "6%";
                      cell2.innerHTML = txtSurgeryName;
                      cell3.innerHTML = txtDate;
                      cell4.innerHTML = txtHospital;
                      document.getElementById('hdnSurgeryItems').value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate + "~" + txtHospital + "^";
                      AddStatus = 2;
                  }
              }
              if (AddStatus == 0) {
                  if (txtSurgeryName != '') {
                      var row = document.getElementById('tblSurgeryItems').insertRow(0);
                      row.id = parseInt(rwNumber);
                      var cell1 = row.insertCell(0);
                      var cell2 = row.insertCell(1);
                      var cell3 = row.insertCell(2);
                      var cell4 = row.insertCell(3);
                      cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgery(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                      cell1.width = "6%";
                      cell2.innerHTML = txtSurgeryName;
                      cell3.innerHTML = txtDate;
                      cell4.innerHTML = txtHospital;
                      document.getElementById('hdnSurgeryItems').value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate + "~" + txtHospital + "^";
                  }
              }
              else if (AddStatus == 1) {
                alert('Surgery already added');
              }
              document.getElementById('txtsurgeryName').value = '';
              document.getElementById('txtDate').value = '';
              document.getElementById('txtHospital').value = '';
              return false;
          }

          function ImgOnclickSurgery(ImgID) {
              document.getElementById(ImgID).style.display = "none";
              var HidValue = document.getElementById('hdnSurgeryItems').value;
              var list = HidValue.split('^');
              var newHistoryList = '';
              if (document.getElementById('hdnSurgeryItems').value != "") {
                  for (var count = 0; count < list.length; count++) {
                      var HistoryList = list[count].split('~');
                      if (HistoryList[0] != '') {
                          if (HistoryList[0] != ImgID) {
                              newHistoryList += list[count] + '^';
                          }
                      }
                  }
                  document.getElementById('hdnSurgeryItems').value = newHistoryList;
              }
              if (document.getElementById('hdnSurgeryItems').value == '') {
                  document.getElementById('tblSurgeryItems').style.display = 'none';
              }
          }


          function LoadSurgeryItems() {
              var HidValue = document.getElementById('hdnSurgeryItems').value;
              var list = HidValue.split('^');
              if (document.getElementById('hdnSurgeryItems').value != "") {

                  for (var count = 0; count < list.length - 1; count++) {
                      var HistoryList = list[count].split('~');
                      var row = document.getElementById('hdnSurgeryItems').insertRow(0);
                      row.id = HistoryList[0];
                      var cell1 = row.insertCell(0);
                      var cell2 = row.insertCell(1);
                      var cell3 = row.insertCell(2);
                      var cell4 = row.insertCell(3);
                      cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHistory(" + parseInt(HistoryList[0]) + ");' src='../Images/Delete.jpg' />";
                      cell1.width = "6%";
                      cell2.innerHTML = HistoryList[1];
                      cell3.innerHTML = HistoryList[2];
                      cell4.innerHTML = HistoryList[3];
                  }
              }
          }

          // Prior Vaccinations

          function LoadPriorVaccinationsItems() {
              var HidVaccinationsValue = document.getElementById('HdnVaccination').value;
              //alert(HidVaccinationsValue);
              var PriorList = HidVaccinationsValue.split('^');
              if (document.getElementById('HdnVaccination').value != "") {

                  for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                      var PriVacList = PriorList[pvCount].split('~');

                      var rowV = document.getElementById('tblPriorVaccinations').insertRow(1);
                      var icoutV = document.getElementById('tblPriorVaccinations').rows.length;
                      rowV.id = icoutV;

                      rowV.id = PriVacList[0];
                      //alert(PriVacList[0]);
                      var cell1 = rowV.insertCell(0);
                      var cell2 = rowV.insertCell(1);
                      var cell3 = rowV.insertCell(2);
                      var cell4 = rowV.insertCell(3);
                      var cell5 = rowV.insertCell(4);
                      var cell6 = rowV.insertCell(5);
                      var cell7 = rowV.insertCell(6);
                      //alert(PriVacList[0]);
                      cell1.innerHTML = "<img id='imgbtnLPV' style='cursor:pointer;' OnClick='PriorDeleteclick(" + PriVacList[0] + ");' src='../Images/Delete.jpg' />";
                      cell1.width = "5%";
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


          function PriorVaccinationsItems() {
              if (document.getElementById('txtYear').value != '') {
                  var VaccinationStatus = 0;
                  var HidVaccinationValue = document.getElementById('HdnVaccination').value;
                  var Vacclist = HidVaccinationValue.split('^');
                  var ddlVaccination = document.getElementById('drpVaccination').options[document.getElementById('drpVaccination').selectedIndex].text;
                  var ddlVaccinationid = document.getElementById('drpVaccination').value;
                  var Year = document.getElementById('txtYear').value;
                  var ddlMonth = document.getElementById('drpMonth').options[document.getElementById('drpMonth').selectedIndex].text;
                  var Doses = document.getElementById('txtDoses').value;
                  var Booster = document.getElementById('ddlAnaphylacticReaction').options[document.getElementById('ddlAnaphylacticReaction').selectedIndex].text; ;
                  var vrow = document.getElementById('tblPriorVaccinations').insertRow(1);
                  var vrCount = document.getElementById('tblPriorVaccinations').rows.length;
                  vrow.id = vrCount;
                  //alert(row.id);
                  var cell1 = vrow.insertCell(0);
                  var cell2 = vrow.insertCell(1);
                  var cell3 = vrow.insertCell(2);
                  var cell4 = vrow.insertCell(3);
                  var cell5 = vrow.insertCell(4);
                  var cell6 = vrow.insertCell(5);
                  var cell7 = vrow.insertCell(6);
                  cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
                  cell1.width = "5%";
                  cell2.innerHTML = ddlVaccination;
                  cell3.innerHTML = Year;
                  cell4.innerHTML = ddlMonth;
                  cell5.innerHTML = Doses;
                  cell6.innerHTML = Booster;
                  cell7.innerHTML = ddlVaccinationid;
                  cell7.style.display = "none";
                  document.getElementById('HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
                  document.getElementById('drpVaccination').selectedIndex = 0;
                  document.getElementById('txtYear').value = '';
                  document.getElementById('drpMonth').selectedIndex = 0;
                  document.getElementById('txtDoses').value = '';
                  document.getElementById('ddlAnaphylacticReaction').checked = false;
                  VaccinationStatus = 0;
                  return false;
              }
              else {
                alert('Provide the year for corresponding dose');
                  document.getElementById('txtYear').focus();
                  return false;
              }
              if (VaccinationStatus == 0) {

                  var vrowv = document.getElementById('tblPriorVaccinations').insertRow(1);
                  var vrCount = document.getElementById('tblPriorVaccinations').rows.length;
                  vrowv.id = vrCount;
                  //alert(row.id);
                  var cell1 = vrowv.insertCell(0);
                  var cell2 = vrowv.insertCell(1);
                  var cell3 = vrowv.insertCell(2);
                  var cell4 = vrowv.insertCell(3);
                  var cell5 = vrowv.insertCell(4);
                  var cell6 = vrowv.insertCell(5);
                  var cell7 = vrowv.insertCell(6);
                  cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
                  cell1.width = "5%";
                  cell2.innerHTML = ddlVaccination;
                  cell3.innerHTML = Year;
                  cell4.innerHTML = ddlMonth;
                  cell5.innerHTML = Doses;
                  cell6.innerHTML = Booster;
                  cell7.innerHTML = ddlVaccinationid;
                  cell7.style.display = "none";
                  document.getElementById('HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
                  document.getElementById('drpVaccination').selectedIndex = 0;
                  document.getElementById('txtYear').value = '';
                  document.getElementById('drpMonth').selectedIndex = 0;
                  document.getElementById('txtDoses').value = '';
                  document.getElementById('ddlAnaphylacticReaction').checked = false;
                  VaccinationStatus = 0;
                  return false;
              }
          }

          function PriorDeleteclick(PriorDelItem) {
              //alert(PriorDelItem);
              document.getElementById(PriorDelItem).style.display = "none";
              var HidVacValue = document.getElementById('HdnVaccination').value;
              //alert(HidVacValue);
              var pVlist = HidVacValue.split('^');
              var newVaccList = '';
              if (document.getElementById('HdnVaccination').value != "") {
                  for (var pvCountV = 0; pvCountV < pVlist.length; pvCountV++) {
                      var priorListV = pVlist[pvCountV].split('~');
                      //alert(priorList[0]);
                      if (priorListV[0] != '') {
                          if (priorListV[0] != PriorDelItem) {
                              newVaccList += pVlist[pvCountV] + "^";
                              //alert('New = ' + newVaccList);
                          }
                      }
                  }
                  document.getElementById('HdnVaccination').value = newVaccList;
              }
              //alert(newVaccList);
          }


          // BaseLine Histroy ....

          function LoadBaseLineHistroyItems() {
              var HidLoadValue = document.getElementById('HidBaseLine').value;
              //alert(HidLoadValue);
              var list = HidLoadValue.split('^');
              if (document.getElementById('HidBaseLine').value != "") {
                  for (var count = 0; count < list.length - 1; count++) {
                      var BaselineList = list[count].split('~');

                      var row = document.getElementById('tblBaseLine').insertRow(1);
                      var icout = document.getElementById('tblBaseLine').rows.length;
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
                      cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + BaselineList[0] + ");' src='../Images/Delete.jpg' />";
                      cell1.width = "5%";
                      cell2.innerHTML = BaselineList[1];
                      cell3.innerHTML = BaselineList[2];
                      cell4.innerHTML = BaselineList[3];
                      cell5.innerHTML = BaselineList[4];
                      cell6.innerHTML = BaselineList[5];
                      cell7.innerHTML = BaselineList[6];
                      cell8.innerHTML = BaselineList[7];
                      cell9.innerHTML = BaselineList[8];
                      cell10.innerHTML = BaselineList[9];
                      cell7.style.display = "none";
                      cell9.style.display = "none";
                      cell10.style.display = "none";
                  }
              }
              return false;
          }

          function BaseLineItems() {
              //alert('1');
              var BaseLineStatus = 0;
              var HidAddValue = document.getElementById('HidBaseLine').value;
              //alert(document.getElementById('drdSOC').options[document.getElementById('drdSOC').selectedIndex].text);
              var ddlName = document.getElementById('drdSOC').options[document.getElementById('drdSOC').selectedIndex].text;
              var age = document.getElementById('txtAge').value;
              var ddlDeliveryName = document.getElementById('drpMOD').options[document.getElementById('drpMOD').selectedIndex].text;
              var ddlDeliveryNameID = document.getElementById('drpMOD').value;
              var weight = document.getElementById('txtBwt').value;
              var ddlBMaturity = document.getElementById('drpBMaturity').options[document.getElementById('drpBMaturity').selectedIndex].text;
              var ddlBMaturityID = document.getElementById('drpBMaturity').value;
              //var ddlBMaturity = document.getElementById('drpBMaturity').value;
              //alert(ddlBMaturity);
              var gnormal;
              //alert(ddlName);
              //alert(age);

              if (document.getElementById('chkIsGrowth').checked == true) {

                  gnormal = 'Abnormal';
              }
              else { gnormal = 'Normal'; }
              //var grate = document.getElementById('txtGrowthRate').value;
              var grate = 0;
              var row = document.getElementById('tblBaseLine').insertRow(1);
              var icout = document.getElementById('tblBaseLine').rows.length;
              row.id = icout;
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
              cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
              cell1.width = "5%";
              cell2.innerHTML = ddlName;
              cell3.innerHTML = age;
              cell4.innerHTML = ddlDeliveryName;
              cell5.innerHTML = weight;
              cell6.innerHTML = gnormal;
              cell7.innerHTML = grate;
              cell8.innerHTML = ddlBMaturity;
              cell9.innerHTML = ddlDeliveryNameID;
              cell10.innerHTML = ddlBMaturityID;
              cell7.style.display = "none";
              cell9.style.display = "none";
              cell10.style.display = "none";
              //alert(ddlName);
              document.getElementById('HidBaseLine').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
              //alert(document.getElementById('HidBaseLine').value);
              document.getElementById('drdSOC').selectedIndex = 0;
              document.getElementById('txtAge').value = '';
              document.getElementById('drpMOD').selectedIndex = 0;
              document.getElementById('txtBwt').value = '';
              document.getElementById('drpBMaturity').selectedIndex = 0;
              document.getElementById('chkIsGrowth').checked = false;
              //document.getElementById('txtGrowthRate').value = '';
              BaseLineStatus = 0;
              return false;
              if (BaseLineStatus == 0) {

                  var row = document.getElementById('tblBaseLine').insertRow(1);
                  var icout = document.getElementById('tblBaseLine').rows.length;
                  row.id = icout;
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
                  cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                  cell1.width = "5%";
                  cell2.innerHTML = ddlName;
                  cell3.innerHTML = age;
                  cell4.innerHTML = ddlDeliveryName;
                  cell5.innerHTML = weight;
                  cell6.innerHTML = gnormal;
                  cell7.innerHTML = grate;
                  cell8.innerHTML = ddlBMaturity;
                  cell9.innerHTML = ddlDeliveryNameID;
                  cell10.innerHTML = ddlBMaturityID;
                  cell7.style.display = "none";
                  cell9.style.display = "none";
                  cell10.style.display = "none";
                  document.getElementById('HidBaseLine').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
                  document.getElementById('drdSOC').selectedIndex = 0;
                  document.getElementById('txtAge').value = '';
                  document.getElementById('drpMOD').selectedIndex = 0;
                  document.getElementById('txtBwt').value = '';
                  document.getElementById('drpBMaturity').selectedIndex = 0;
                  document.getElementById('chkIsGrowth').checked = false;
                  //document.getElementById('txtGrowthRate').value = '';
                  return false;
              }
          }
          function ImgDeleteclick(ImgDeleteID) {
              //alert(ImgDeleteID);
              document.getElementById(ImgDeleteID).style.display = "none";
              var HidDeleteValue = document.getElementById('HidBaseLine').value;
              //alert(HidDeleteValue);
              var list = HidDeleteValue.split('^');
              var newList = '';
              if (document.getElementById('HidBaseLine').value != "") {
                  for (var count = 0; count < list.length; count++) {
                      var BaseList = list[count].split('~');
                      if (BaseList[0] != '') {
                          //alert(BaseList[0]);
                          if (BaseList[0] != ImgDeleteID) {
                              newList += list[count] + "^";
                          }
                      }
                  }
                  document.getElementById('HidBaseLine').value = newList;
              }
              //alert(newList);
          }
      
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ucUser" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" width="100%">
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" 
                                        meta:resourcekey="btnBackResource1" />&nbsp;&nbsp;<asp:Button
                                            ID="btnEMRExam" runat="server" Text="Capture Exam" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnEMRExam_Click" 
                                        meta:resourcekey="btnEMRExamResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                                    <asp:Label ID="Label1" runat="server" Text="MEDICAL HISTORY" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trchkHighBloodPressure_402" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkHighBloodPressure_402" runat="server" Text="Systemic Hypertension"
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkHighBloodPressure_402Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkHighBloodPressure_402" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkHighBloodPressure_402" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDuration_1" runat="server" Text="Duration" 
                                                        meta:resourcekey="lblDuration_1Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTreatment_2" runat="server" Text="Treatment" 
                                                        meta:resourcekey="lblTreatment_2Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDuration_1" runat="server" Width="50px" 
                                                        meta:resourcekey="txtDuration_1Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDurationt_1" runat="server" 
                                                        meta:resourcekey="ddlDurationt_1Resource1">
                                                        <asp:ListItem Text="Year" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="3" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CheckBoxList ID="chkTreatment_2" runat="server" RepeatDirection="Horizontal"
                                                        RepeatColumns="4" meta:resourcekey="chkTreatment_2Resource1">
                                                        <asp:ListItem Text="Beta-Blockers" Value="4" 
                                                            meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        <asp:ListItem Text="CCB" Value="5" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                        <asp:ListItem Text="ACEI/ARB" Value="6" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        <asp:ListItem Text="ACEI/ARB-diuretic" Value="7" 
                                                            meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                        <asp:ListItem Text="Alpha-Blockers" Value="8" 
                                                            meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:CheckBox ID="chkOthers_9" runat="server" Text="Others" 
                                                        onClick="javascript:showOthersChkBox(this.id);" 
                                                        meta:resourcekey="chkOthers_9Resource1" />
                                                    <div id="divchkOthers_9" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtOthers_9" runat="server" 
                                                            meta:resourcekey="txtOthers_9Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="trchkHeartDisease_332" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkHeartDisease_332" runat="server" Text="Heart Disease" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkHeartDisease_332Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkHeartDisease_332" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkHeartDisease_332" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDiseaseType_3" runat="server" Text="Disease Type" 
                                                        meta:resourcekey="lblDiseaseType_3Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDisease_4" runat="server" Text="Disease" 
                                                        meta:resourcekey="lblDisease_4Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlDiseaseType_3" runat="server" 
                                                        onchange="javascript:showOthersBox(this.id);" 
                                                        meta:resourcekey="ddlDiseaseType_3Resource1">
                                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                        <asp:ListItem Text="Coronary" Value="10" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                        <asp:ListItem Text="Congenital" Value="11" 
                                                            meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                        <asp:ListItem Text="Arrhythmia" Value="12" 
                                                            meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                        <asp:ListItem Text="Valvular" Value="13" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                        <asp:ListItem Text="Heart Failure" Value="14" 
                                                            meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                        <asp:ListItem Text="cardiomypathy" Value="15" 
                                                            meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                        <asp:ListItem Text="Others" Value="16" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div id="divddlDiseaseType_3" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtothers_16" runat="server" 
                                                            meta:resourcekey="txtothers_16Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDisease_17" runat="server" 
                                                        meta:resourcekey="txtDisease_17Resource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoDescValue" runat="server" 
                                                        TargetControlID="txtDisease_17" EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10"
                                                        FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                                        ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkDiabetesMellitus_389" runat="server" Text="Diabetes Mellitus"
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkDiabetesMellitus_389Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkDiabetesMellitus_389" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDuration_5" runat="server" Text="Duration" 
                                                        meta:resourcekey="lblDuration_5Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblType_6" runat="server" Text="Type" 
                                                        meta:resourcekey="lblType_6Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTreatment_7" runat="server" Text="Treatment" 
                                                        meta:resourcekey="lblTreatment_7Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDuration_5" runat="server" Width="50px" 
                                                        meta:resourcekey="txtDuration_5Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDuration_5" runat="server" 
                                                        meta:resourcekey="ddlDuration_5Resource1">
                                                        <asp:ListItem Text="Year" Value="18" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="19" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="20" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlType_6" runat="server" 
                                                        meta:resourcekey="ddlType_6Resource1">
                                                        <asp:ListItem Text="Type2" Value="21" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                        <asp:ListItem Text="Type1" Value="22" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                                        <asp:ListItem Text="MODY" Value="23" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                        <asp:ListItem Text="IGT" Value="24" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTreatment_7" runat="server" 
                                                        onchange="javascript:showOthersBox(this.id);" 
                                                        meta:resourcekey="ddlTreatment_7Resource1">
                                                        <asp:ListItem Text="None" Value="25" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                        <asp:ListItem Text="OHAs" Value="26" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                        <asp:ListItem Text="OHAs-insulin" Value="27" 
                                                            meta:resourcekey="ListItemResource26"></asp:ListItem>
                                                        <asp:ListItem Text="insulin" Value="28" meta:resourcekey="ListItemResource27"></asp:ListItem>
                                                        <asp:ListItem Text="Native medicine" Value="29" 
                                                            meta:resourcekey="ListItemResource28"></asp:ListItem>
                                                        <asp:ListItem Text="Others" Value="68" meta:resourcekey="ListItemResource29"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div id="divddlTreatment_7" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtothers_68" runat="server" 
                                                            meta:resourcekey="txtothers_68Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td colspan="4">
                                                <asp:CheckBox ID="chkStroke_438" runat="server" Text="Stroke" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkStroke_438Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkStroke_438" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDate_8" runat="server" Text="Date" 
                                                        meta:resourcekey="lblDate_8Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRecovery_9" runat="server" Text="Recovery" 
                                                        meta:resourcekey="lblRecovery_9Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTypeOfCVA_10" runat="server" Text="TypeOfCVA" 
                                                        meta:resourcekey="lblTypeOfCVA_10Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLobeaffected_11" runat="server" Text="Area/Lobe affected" 
                                                        meta:resourcekey="lblLobeaffected_11Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDate_30" runat="server" ValidationGroup="MKE" 
                                                        meta:resourcekey="txtDate_30Resource1"></asp:TextBox>
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender4" runat="server" 
                                                        ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                        TargetControlID="txtDate_30" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton2"
                                                        TargetControlID="txtDate_30" Enabled="True" />
                                                    <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" 
                                                        ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                        meta:resourcekey="ImageButton2Resource1" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator4" runat="server" ControlExtender="MaskedEditExtender4"
                                                        ControlToValidate="txtDate_30" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator4" 
                                                        meta:resourcekey="MaskedEditValidator4Resource1" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRecovery_9" runat="server" 
                                                        meta:resourcekey="ddlRecovery_9Resource1">
                                                        <asp:ListItem Text="Fully Recovered" Value="31" 
                                                            meta:resourcekey="ListItemResource30"></asp:ListItem>
                                                        <asp:ListItem Text="Partially Recovered" Value="32" 
                                                            meta:resourcekey="ListItemResource31"></asp:ListItem>
                                                        <asp:ListItem Text="Not Recovered" Value="33" 
                                                            meta:resourcekey="ListItemResource32"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTypeOfCVA_10" runat="server" 
                                                        meta:resourcekey="ddlTypeOfCVA_10Resource1">
                                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource33"></asp:ListItem>
                                                        <asp:ListItem Text="Infarct" Value="34" meta:resourcekey="ListItemResource34"></asp:ListItem>
                                                        <asp:ListItem Text="Hemorrhage" Value="35" 
                                                            meta:resourcekey="ListItemResource35"></asp:ListItem>
                                                        <asp:ListItem Text="Hemorrhagic Infarct" Value="69" 
                                                            meta:resourcekey="ListItemResource36"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLobeaffected_36" runat="server" 
                                                        meta:resourcekey="txtLobeaffected_36Resource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="trchkRaisedCholestrol_409" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkRaisedCholestrol_409" runat="server" Text="Dyslipidemia" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkRaisedCholestrol_409Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkRaisedCholestrol_409" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkRaisedCholestrol_409" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDuration_12" runat="server" Text="Duration" 
                                                        meta:resourcekey="lblDuration_12Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtduration_12" runat="server" Width="50px" 
                                                        meta:resourcekey="txtduration_12Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlduration_12" runat="server" 
                                                        meta:resourcekey="ddlduration_12Resource1">
                                                        <asp:ListItem Text="Year" Value="37" meta:resourcekey="ListItemResource37"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="38" meta:resourcekey="ListItemResource38"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="39" meta:resourcekey="ListItemResource39"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td colspan="3">
                                                <asp:CheckBox ID="chkCancer_372" runat="server" Text="Cancer" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkCancer_372Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkCancer_372" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTypeofcancer_13" runat="server" Text="Type Of Cancer" 
                                                        meta:resourcekey="lblTypeofcancer_13Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblStageofcancer_14" runat="server" Text="Stage Of Cancer" 
                                                        meta:resourcekey="lblStageofcancer_14Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTreatment_15" runat="server" Text="Treatment" 
                                                        meta:resourcekey="lblTreatment_15Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlTypeofcancer_13" runat="server" 
                                                        meta:resourcekey="ddlTypeofcancer_13Resource1">
                                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource40"></asp:ListItem>
                                                        <asp:ListItem Text="Breast" Value="40" meta:resourcekey="ListItemResource41"></asp:ListItem>
                                                        <asp:ListItem Text="Prostate" Value="41" meta:resourcekey="ListItemResource42"></asp:ListItem>
                                                        <asp:ListItem Text="Liver" Value="42" meta:resourcekey="ListItemResource43"></asp:ListItem>
                                                        <asp:ListItem Text="Kidney" Value="43" meta:resourcekey="ListItemResource44"></asp:ListItem>
                                                        <asp:ListItem Text="Lung" Value="44" meta:resourcekey="ListItemResource45"></asp:ListItem>
                                                        <asp:ListItem Text="ovarian" Value="45" meta:resourcekey="ListItemResource46"></asp:ListItem>
                                                        <asp:ListItem Text="Leukemia" Value="46" meta:resourcekey="ListItemResource47"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlStageofcancer_14" runat="server" 
                                                        meta:resourcekey="ddlStageofcancer_14Resource1">
                                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource48"></asp:ListItem>
                                                        <asp:ListItem Text="Stage I" Value="47" meta:resourcekey="ListItemResource49"></asp:ListItem>
                                                        <asp:ListItem Text="Stage II" Value="48" meta:resourcekey="ListItemResource50"></asp:ListItem>
                                                        <asp:ListItem Text="Stage III" Value="49" meta:resourcekey="ListItemResource51"></asp:ListItem>
                                                        <asp:ListItem Text="Stage IV" Value="50" meta:resourcekey="ListItemResource52"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTreatment_15" runat="server" 
                                                        meta:resourcekey="ddlTreatment_15Resource1">
                                                        <asp:ListItem Text="Chemotherapy" Value="51" 
                                                            meta:resourcekey="ListItemResource53"></asp:ListItem>
                                                        <asp:ListItem Text="Radiation therapy" Value="52" 
                                                            meta:resourcekey="ListItemResource54"></asp:ListItem>
                                                        <asp:ListItem Text="both" Value="53" meta:resourcekey="ListItemResource55"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <%--<asp:Button ID="Button2" runat="server" Text="Add" class="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'"  />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td colspan="3">
                                                <asp:CheckBox ID="chkAsthma_246" runat="server" Text="Asthma" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkAsthma_246Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkAsthma_246" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDuration_16" runat="server" Text="Duration" 
                                                        meta:resourcekey="lblDuration_16Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTreatment_17" runat="server" Text="Treatment" 
                                                        meta:resourcekey="lblTreatment_17Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkExacerbations_18" runat="server" Text="Exacerbations" 
                                                        meta:resourcekey="chkExacerbations_18Resource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDuration_16" runat="server" Width="50px" 
                                                        meta:resourcekey="txtDuration_16Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDuration_16" runat="server" 
                                                        meta:resourcekey="ddlDuration_16Resource1">
                                                        <asp:ListItem Text="Year" Value="54" meta:resourcekey="ListItemResource56"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="55" meta:resourcekey="ListItemResource57"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="56" meta:resourcekey="ListItemResource58"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTratment_17" runat="server" 
                                                        meta:resourcekey="ddlTratment_17Resource1">
                                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource59"></asp:ListItem>
                                                        <asp:ListItem Text="No Treatment" Value="67" 
                                                            meta:resourcekey="ListItemResource60"></asp:ListItem>
                                                        <asp:ListItem Text="Steroids" Value="70" meta:resourcekey="ListItemResource61"></asp:ListItem>
                                                        <asp:ListItem Text="Bronchodilators" Value="71" 
                                                            meta:resourcekey="ListItemResource62"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTimesper_18" runat="server" Text="Times per" 
                                                        meta:resourcekey="lblTimesper_18Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtTimes_18" runat="server" 
                                                        meta:resourcekey="txtTimes_18Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlExacerbations_18" runat="server" 
                                                        meta:resourcekey="ddlExacerbations_18Resource1">
                                                        <asp:ListItem Text="Year" Value="57" meta:resourcekey="ListItemResource63"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="58" meta:resourcekey="ListItemResource64"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="59" meta:resourcekey="ListItemResource65"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkThalassemiaTrait_536" runat="server" Text="Thalassemia Trait"
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkThalassemiaTrait_536Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkThalassemiaTrait_536" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTrait_19" runat="server" Text="Trait" 
                                                        meta:resourcekey="lblTrait_19Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrait_19" runat="server" 
                                                        meta:resourcekey="ddlTrait_19Resource1">
                                                        <asp:ListItem Text="alpha" Value="60" meta:resourcekey="ListItemResource66"></asp:ListItem>
                                                        <asp:ListItem Text="Beta" Value="61" meta:resourcekey="ListItemResource67"></asp:ListItem>
                                                        <asp:ListItem Text="gamma" Value="62" meta:resourcekey="ListItemResource68"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkHepatitisBcarrier_537" runat="server" Text="Hepatitis B carrier"
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkHepatitisBcarrier_537Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkHepatitisBcarrier_537" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDuration_20" runat="server" Text="Duration" 
                                                        meta:resourcekey="lblDuration_20Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTreatment_21" runat="server" Text="Treatment" 
                                                        meta:resourcekey="lblTreatment_21Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDuration_20" runat="server" Width="50px" 
                                                        meta:resourcekey="txtDuration_20Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDuration_20" runat="server" 
                                                        meta:resourcekey="ddlDuration_20Resource1">
                                                        <asp:ListItem Text="Year" Value="63" meta:resourcekey="ListItemResource69"></asp:ListItem>
                                                        <asp:ListItem Text="Months" Value="64" meta:resourcekey="ListItemResource70"></asp:ListItem>
                                                        <asp:ListItem Text="Weeks" Value="65" meta:resourcekey="ListItemResource71"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTreatment_66" runat="server" 
                                                        meta:resourcekey="txtTreatment_66Resource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkSurgicalHistory_0" runat="server" Text="Surgical History" 
                                                    onclick="javascript:showContent(this.id);" 
                                                    meta:resourcekey="chkSurgicalHistory_0Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <div id="divchkSurgicalHistory_0" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblSurgeryName_22" runat="server" Text="Surgery Name" 
                                                        meta:resourcekey="lblSurgeryName_22Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDate_23" runat="server" Text="Date" 
                                                        meta:resourcekey="lblDate_23Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="LblHospital_24" runat="server" Text="Hospital/Centre" 
                                                        meta:resourcekey="LblHospital_24Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtsurgeryName" runat="server" 
                                                        meta:resourcekey="txtsurgeryNameResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" 
                                                        TargetControlID="txtsurgeryName" EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10"
                                                        FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getSurgeryName"
                                                        ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDate" runat="server" ValidationGroup="MKE" 
                                                        meta:resourcekey="txtDateResource1"></asp:TextBox>
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                                                        ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                        TargetControlID="txtDate" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton3"
                                                        TargetControlID="txtDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" 
                                                        ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                        meta:resourcekey="ImageButton3Resource1" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtHospital" runat="server" 
                                                        meta:resourcekey="txtHospitalResource1"></asp:TextBox>
                                                    <%-- <asp:Button ID="btnSurgeryAdd" OnClientClick="javascript:return onClickAddSurgery();"
                                                                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" />--%>
                                                    <input type="button" name="btnIPTreatmentPlanAdd" id="btnSurgeryAdd" onclick="onClickAddSurgery();"
                                                        value="Add" class="btn" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <input type="hidden" id="hdnSurgeryItems" runat="server" />
                                                    <table id="tblSurgeryItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                        cellspacing="0" border="0" width="97%">
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td>
                                    <table border="1" cellpadding="0" align="center" width="100%">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="CheckBox12" runat="server" Text="Major Hospitalization" />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label23" runat="server" Text="Medical Problem"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label24" runat="server" Text="Duration"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox13" runat="server" Text="Complication" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox><asp:DropDownList ID="DropDownList22"
                                                    runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox>
                                                <asp:Button ID="Button1" runat="server" Text="Add" class="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>--%>
                        </table>
                        <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                                    <asp:Label ID="Label7" runat="server" Text="SOCIAL HISTORY" 
                                        meta:resourcekey="Label7Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkTS_476" runat="server" Text="Tobacco Smoking" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkTS_476Resource1" />
                                    <%--  &nbsp;<asp:Label ID="lblTobaccoSmoking" runat="server" CssClass="defaultfontcolor" Text="Tobacco Smoking"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkTS_476" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTypeTS_1" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Type" meta:resourcekey="lblTypeTS_1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTypeTS" onchange="javascript:showOthersBox(this.id);" 
                                                                    runat="server" meta:resourcekey="ddlTypeTSResource1">
                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource72">Cigarttes</asp:ListItem>
                                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource73">Cigars</asp:ListItem>
                                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource74">Bidis</asp:ListItem>
                                                                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource75">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDurationTS_2" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Duration" meta:resourcekey="lblDurationTS_2Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDurationTS" Width="35px" runat="server" 
                                                                    meta:resourcekey="txtDurationTSResource1"></asp:TextBox>
                                                                <asp:DropDownList ID="ddlDurationTS" runat="server" 
                                                                    meta:resourcekey="ddlDurationTSResource1">
                                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource76">day</asp:ListItem>
                                                                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource77">week</asp:ListItem>
                                                                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource78">month</asp:ListItem>
                                                                    <asp:ListItem Value="8" meta:resourcekey="ListItemResource79">year</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <div id="divddlTypeTS" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersTypeTS" runat="server" 
                                                                        meta:resourcekey="txtOthersTypeTSResource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblQtyTS_3" CssClass="defaultfontcolor" runat="server" 
                                                                    Text="Qty" meta:resourcekey="lblQtyTS_3Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPacksTS_9" Width="35px" runat="server" 
                                                                    meta:resourcekey="txtPacksTS_9Resource1"></asp:TextBox>
                                                                <asp:Label ID="lblPacksTS" CssClass="defaultfontcolor" runat="server" 
                                                                    Text="Packs" meta:resourcekey="lblPacksTSResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <%-- <asp:Button ID="btnAddTS" runat="server" Text="Add" />--%>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>--%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>--%>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkAC_369" runat="server" Text="Alcohol Consumption" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkAC_369Resource1" />
                                    <%--  &nbsp;<asp:Label ID="Label4" runat="server" CssClass="defaultfontcolor" Text="Alcohol Consumption"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkAC_369" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTypeAC_4" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Type" meta:resourcekey="lblTypeAC_4Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTypesAC" onchange="javascript:showOthersBox(this.id);" 
                                                                    runat="server" meta:resourcekey="ddlTypesACResource1">
                                                                    <asp:ListItem Value="10" meta:resourcekey="ListItemResource80">Beer</asp:ListItem>
                                                                    <asp:ListItem Value="11" meta:resourcekey="ListItemResource81">Whisky</asp:ListItem>
                                                                    <asp:ListItem Value="12" meta:resourcekey="ListItemResource82">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDurationAC_5" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Duration" meta:resourcekey="lblDurationAC_5Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDurationAC" Width="35px" runat="server" 
                                                                    meta:resourcekey="txtDurationACResource1"></asp:TextBox>
                                                                <asp:DropDownList ID="ddlDurationAC" runat="server" 
                                                                    meta:resourcekey="ddlDurationACResource1">
                                                                    <asp:ListItem Value="13" meta:resourcekey="ListItemResource83">day</asp:ListItem>
                                                                    <asp:ListItem Value="14" meta:resourcekey="ListItemResource84">week</asp:ListItem>
                                                                    <asp:ListItem Value="15" meta:resourcekey="ListItemResource85">month</asp:ListItem>
                                                                    <asp:ListItem Value="16" meta:resourcekey="ListItemResource86">year</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <div id="divddlTypesAC" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersTypeAC_17" runat="server" 
                                                                        meta:resourcekey="txtOthersTypeAC_17Resource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblQtyAC_6" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Qty" meta:resourcekey="lblQtyAC_6Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtQtyAC" Width="35px" runat="server" 
                                                                    meta:resourcekey="txtQtyACResource1"></asp:TextBox>
                                                                <asp:Label ID="lblMlLtr" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="ml/day" meta:resourcekey="lblMlLtrResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <%-- <asp:Button ID="Button2" runat="server" Text="Add" />--%>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>--%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>--%>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkPA_1059" runat="server" Text="Physicial Activity" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkPA_1059Resource1" />
                                    <%--  &nbsp;<asp:Label ID="Label5" runat="server" CssClass="defaultfontcolor" Text="Physicial Activity"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkPA_1059" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblPhysicialExercise" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Physicial Exercise" meta:resourcekey="lblPhysicialExerciseResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlPhysicialActivity" onchange="javascript:showOthersBox(this.id);"
                                                                    runat="server" meta:resourcekey="ddlPhysicialActivityResource1">
                                                                    <asp:ListItem Value="18" meta:resourcekey="ListItemResource87">No Physicial exertion</asp:ListItem>
                                                                    <asp:ListItem Value="19" meta:resourcekey="ListItemResource88">Occasional Physicial Activity</asp:ListItem>
                                                                    <asp:ListItem Value="20" meta:resourcekey="ListItemResource89">Regular Exercise</asp:ListItem>
                                                                    <asp:ListItem Value="21" meta:resourcekey="ListItemResource90">Athlete</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td colspan="3">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td colspan="4">
                                                                <div id="divddlPhysicialActivity" runat="server" style="display: none;">
                                                                    <table style="width: 90%;">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:CheckBox ID="chkAerobic" runat="server" CssClass="defaultfontcolor" 
                                                                                    Text="Aerobic" meta:resourcekey="chkAerobicResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAerobic_22" runat="server" 
                                                                                    meta:resourcekey="txtAerobic_22Resource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:CheckBox ID="chkAnaerobic" runat="server" CssClass="defaultfontcolor" 
                                                                                    Text="Anaerobic" meta:resourcekey="chkAnaerobicResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAnaerobic_23" runat="server" 
                                                                                    meta:resourcekey="txtAnaerobic_23Resource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                &nbsp;&nbsp;
                                                                                <asp:Label ID="lblPhysicialExerciseDuration" runat="server" CssClass="defaultfontcolor"
                                                                                    Text="Duration" meta:resourcekey="lblPhysicialExerciseDurationResource1"></asp:Label>
                                                                            </td>
                                                                            <td nowrap="nowrap">
                                                                                <asp:TextBox ID="txtNos" runat="server" Width="30px" 
                                                                                    meta:resourcekey="txtNosResource1"></asp:TextBox>
                                                                                <asp:DropDownList ID="ddlHrs" runat="server" meta:resourcekey="ddlHrsResource1">
                                                                                    <asp:ListItem Value="24" meta:resourcekey="ListItemResource91">Min</asp:ListItem>
                                                                                    <asp:ListItem Value="25" meta:resourcekey="ListItemResource92">Hrs</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <asp:DropDownList ID="ddldays" runat="server" 
                                                                                    meta:resourcekey="ddldaysResource1">
                                                                                    <asp:ListItem Value="26" meta:resourcekey="ListItemResource93">day</asp:ListItem>
                                                                                    <asp:ListItem Value="27" meta:resourcekey="ListItemResource94">week</asp:ListItem>
                                                                                    <asp:ListItem Value="28" meta:resourcekey="ListItemResource95">month</asp:ListItem>
                                                                                    <asp:ListItem Value="29" meta:resourcekey="ListItemResource96">year</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>--%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                                    <asp:Label ID="Label6" runat="server" Text="ALLERGIC HISTORY" 
                                        meta:resourcekey="Label6Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkDrugs_1061" runat="server" Text="Drug Algergy" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkDrugs_1061Resource1" />
                                    <%-- &nbsp;<asp:Label ID="lblDrugs" runat="server" CssClass="defaultfontcolor" Text="Drugs"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkDrugs_1061" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTypeDrugs" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Type" meta:resourcekey="lblTypeDrugsResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlDrugs" onchange="javascript:showOthersBox(this.id);" 
                                                                    runat="server" meta:resourcekey="ddlDrugsResource1">
                                                                    <asp:ListItem Value="30" meta:resourcekey="ListItemResource97">Pencillin</asp:ListItem>
                                                                    <asp:ListItem Value="31" meta:resourcekey="ListItemResource98">Cephalosporins</asp:ListItem>
                                                                    <asp:ListItem Value="32" meta:resourcekey="ListItemResource99">Digoxm</asp:ListItem>
                                                                    <asp:ListItem Value="33" meta:resourcekey="ListItemResource100">Sulpha Drugs</asp:ListItem>
                                                                    <asp:ListItem Value="34" meta:resourcekey="ListItemResource101">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <div id="divddlDrugs" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersTypeDrugs_34" runat="server" 
                                                                        meta:resourcekey="txtOthersTypeDrugs_34Resource1"></asp:TextBox>
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
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkFood_1062" runat="server" Text="Food Algergy" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkFood_1062Resource1" />
                                    <%-- &nbsp;<asp:Label ID="lblFoods" runat="server" CssClass="defaultfontcolor" Text="Food - Stuffs"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkFood_1062" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTypeFood" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Type" meta:resourcekey="lblTypeFoodResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlFoodType" onchange="javascript:showOthersBox(this.id);"
                                                                    runat="server" meta:resourcekey="ddlFoodTypeResource1">
                                                                    <asp:ListItem Value="35" meta:resourcekey="ListItemResource102">Shell fish</asp:ListItem>
                                                                    <asp:ListItem Value="36" meta:resourcekey="ListItemResource103">Tomato</asp:ListItem>
                                                                    <asp:ListItem Value="37" meta:resourcekey="ListItemResource104">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <div id="divddlFoodType" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersTypeFood_37" runat="server" 
                                                                        meta:resourcekey="txtOthersTypeFood_37Resource1"></asp:TextBox>
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
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkDrugsHistory_1063" runat="server" Text="Drug History" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkDrugsHistory_1063Resource1" />
                                    <%--&nbsp;<asp:Label ID="lblDrugHistory" runat="server" CssClass="defaultfontcolor" Text="Drug Hitory"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkDrugsHistory_1063" runat="server" style="display: none">
                                        <uc5:Adv ID="uAd" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkVaccHis_1064" runat="server" Text="Vaccination History" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkVaccHis_1064Resource1" />
                                    <%-- &nbsp;<asp:Label ID="lblVcacHis" runat="server" CssClass="defaultfontcolor" Text="Vaccination Hitory"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkVaccHis_1064" runat="server" style="display: none">
                                        <div class="dataheader2" style="width: 75%;">
                                            <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                <tr>
                                                    <td style="width: 12%">
                                                        <asp:Label ID="lblVacc" runat="server" Text="Vaccination" 
                                                            meta:resourcekey="lblVaccResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpVaccination" runat="server" CssClass="ddlTheme" 
                                                            meta:resourcekey="drpVaccinationResource1">
                                                            <asp:ListItem Value="8" meta:resourcekey="ListItemResource105">OPV</asp:ListItem>
                                                            <asp:ListItem Value="11" meta:resourcekey="ListItemResource106">MMR</asp:ListItem>
                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource107">Hepatitis B</asp:ListItem>
                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource108">Hepatitis A</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblYear" runat="server" Text="Year" 
                                                            meta:resourcekey="lblYearResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                        <asp:TextBox ID="txtYear" runat="server" CssClass="textfield1" MaxLength="4" size="5"
                                                              onkeypress="return ValidateOnlyNumeric(this);"   
                                                            meta:resourcekey="txtYearResource1"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 7%">
                                                        <asp:Label ID="lblMonth" runat="server" Text="Month" 
                                                            meta:resourcekey="lblMonthResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 28%">
                                                        <asp:DropDownList ID="drpMonth" runat="server" CssClass="ddlTheme" 
                                                            meta:resourcekey="drpMonthResource1">
                                                            <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource109">January</asp:ListItem>
                                                            <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource110">Febrauary</asp:ListItem>
                                                            <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource111">March</asp:ListItem>
                                                            <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource112">April</asp:ListItem>
                                                            <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource113">May</asp:ListItem>
                                                            <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource114">June</asp:ListItem>
                                                            <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource115">July</asp:ListItem>
                                                            <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource116">August</asp:ListItem>
                                                            <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource117">September</asp:ListItem>
                                                            <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource118">October</asp:ListItem>
                                                            <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource119">November</asp:ListItem>
                                                            <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource120">December</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                            meta:resourcekey="lblDosesResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDoses" runat="server" CssClass="textfield1" MaxLength="10" 
                                                            size="5" meta:resourcekey="txtDosesResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblReaction" runat="server" Text="Reaction" 
                                                            meta:resourcekey="lblReactionResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlAnaphylacticReaction" runat="server" 
                                                            meta:resourcekey="ddlAnaphylacticReactionResource1">
                                                            <asp:ListItem Text="1000" meta:resourcekey="ListItemResource121">---Select---</asp:ListItem>
                                                            <asp:ListItem Text="None" meta:resourcekey="ListItemResource122">None</asp:ListItem>
                                                            <asp:ListItem Text="Erythema" meta:resourcekey="ListItemResource123">Erythema</asp:ListItem>
                                                            <asp:ListItem Text="Urticaria" meta:resourcekey="ListItemResource124">Urticaria</asp:ListItem>
                                                            <asp:ListItem Text="Angioedema" meta:resourcekey="ListItemResource125">Angioedema</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="left" colspan="2">
                                                        <asp:Button ID="btnAdd" runat="server" CssClass="btn" OnClientClick="return PriorVaccinationsItems();"
                                                            onmouseout="this.className='btn'" 
                                                            onmouseover="this.className='btn btnhov'" Text="Add" 
                                                            meta:resourcekey="btnAddResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="HdnVaccination" runat="server" />
                                            <br />
                                            <br />
                                            <table id="tblPriorVaccinations" runat="server" border="2" cellspacing="0" class="dataheaderInvCtrl"
                                                width="75%">
                                                <tr class="colorforcontent">
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;">
                                                        Vaccination
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                                                        Year
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                                                        Month
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                        Doses
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                        AnaphylacticReaction
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                        display: none;">
                                                        Vaccination ID
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl" id="tblGynacHis"
                            runat="server">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                                    <asp:Label ID="Label8" runat="server" Text="GYNAECOLOGICAL HISTORY" 
                                        meta:resourcekey="Label8Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkGynacHis_1065" runat="server" Text="Gynaecological History"
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkGynacHis_1065Resource1" />
                                    <%--  &nbsp;<asp:Label ID="lblGynacHistory" runat="server" CssClass="defaultfontcolor"
                                        Text="Gynaecological Hitory"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkGynacHis_1065" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLMPDate" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="LMP Date" meta:resourcekey="lblLMPDateResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="tLMP_38" runat="server" CssClass="textfield" MaxLength="1" Style="text-align: justify"
                                                                    TabIndex="4" ValidationGroup="MKE" meta:resourcekey="tLMP_38Resource1" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" 
                                                                    ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                    TargetControlID="tLMP_38" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                                    TargetControlID="tLMP_38" Enabled="True" />
                                                                <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" 
                                                                    ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                    meta:resourcekey="ImgBntCalcResource1" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                    ControlToValidate="tLMP_38" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" 
                                                                    meta:resourcekey="MaskedEditValidator2Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblMenstrualCycle" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Menstrual Cycle" meta:resourcekey="lblMenstrualCycleResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlMenstrualCycle" runat="server" 
                                                                    meta:resourcekey="ddlMenstrualCycleResource1">
                                                                    <asp:ListItem Value="1001" meta:resourcekey="ListItemResource126">---Select---</asp:ListItem>
                                                                    <asp:ListItem Value="39" meta:resourcekey="ListItemResource127">Regularly regular</asp:ListItem>
                                                                    <asp:ListItem Value="40" meta:resourcekey="ListItemResource128">Regularly irregular</asp:ListItem>
                                                                    <asp:ListItem Value="41" meta:resourcekey="ListItemResource129">IrRegularly regular</asp:ListItem>
                                                                    <asp:ListItem Value="42" meta:resourcekey="ListItemResource130">IrRegularly irregular</asp:ListItem>
                                                                    <asp:ListItem Value="43" meta:resourcekey="ListItemResource131">Regular</asp:ListItem>
                                                                    <asp:ListItem Value="44" meta:resourcekey="ListItemResource132">IrRegular</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCycleLength" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Cycle Length(approx)" meta:resourcekey="lblCycleLengthResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCycleLength_45" runat="server" Width="50px" 
                                                                    meta:resourcekey="txtCycleLength_45Resource1"></asp:TextBox>
                                                                <asp:Label ID="lblCyclelengthDays" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="days" meta:resourcekey="lblCyclelengthDaysResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLastPapSmear" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Last Pap Smear" meta:resourcekey="lblLastPapSmearResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLastPapSmearDt_46" runat="server" CssClass="textfield" MaxLength="1"
                                                                    Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" 
                                                                    meta:resourcekey="txtLastPapSmearDt_46Resource1" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" 
                                                                    ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                    TargetControlID="txtLastPapSmearDt_46" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton1"
                                                                    TargetControlID="txtLastPapSmearDt_46" Enabled="True" />
                                                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                                                                    ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                    meta:resourcekey="ImageButton1Resource1" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                                    ControlToValidate="txtLastPapSmearDt_46" Display="Dynamic" EmptyValueBlurredText="*"
                                                                    EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                    TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" 
                                                                    ErrorMessage="MaskedEditValidator3" 
                                                                    meta:resourcekey="MaskedEditValidator3Resource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblAgeofMenarchy" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Age of Menarchy" meta:resourcekey="lblAgeofMenarchyResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtAgeofMenarchy_47" runat="server" Width="50px" 
                                                                    meta:resourcekey="txtAgeofMenarchy_47Resource1"></asp:TextBox>
                                                                <asp:Label ID="lblAgeofMenarchyYears" runat="server" CssClass="defaultfontcolor"
                                                                    Text="years" meta:resourcekey="lblAgeofMenarchyYearsResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblResult" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Result" meta:resourcekey="lblResultResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlLastPapSmearResult" runat="server" 
                                                                    meta:resourcekey="ddlLastPapSmearResultResource1">
                                                                    <asp:ListItem Value="1002" meta:resourcekey="ListItemResource133">---Select---</asp:ListItem>
                                                                    <asp:ListItem Value="51" meta:resourcekey="ListItemResource134">Negative</asp:ListItem>
                                                                    <asp:ListItem Value="52" meta:resourcekey="ListItemResource135">Positive</asp:ListItem>
                                                                    <asp:ListItem Value="53" meta:resourcekey="ListItemResource136">Inconclusive</asp:ListItem>
                                                                    <asp:ListItem Value="54" meta:resourcekey="ListItemResource137">Awaited</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblContraception" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Contraception" meta:resourcekey="lblContraceptionResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlContraception" onchange="javascript:showOthersBox(this.id);"
                                                                    runat="server" meta:resourcekey="ddlContraceptionResource1">
                                                                    <asp:ListItem Value="1003" meta:resourcekey="ListItemResource138">---Select---</asp:ListItem>
                                                                    <asp:ListItem Value="48" meta:resourcekey="ListItemResource139">IUD</asp:ListItem>
                                                                    <asp:ListItem Value="49" meta:resourcekey="ListItemResource140">Mechanical</asp:ListItem>
                                                                    <asp:ListItem Value="50" meta:resourcekey="ListItemResource141">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <div id="divddlContraception" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtContraceptionOthers_50" runat="server" Width="75px" 
                                                                        meta:resourcekey="txtContraceptionOthers_50Resource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLastMamogram" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Last Mammogram" meta:resourcekey="lblLastMamogramResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLastMammogramResultDt_55" runat="server" 
                                                                    meta:resourcekey="txtLastMammogramResultDt_55Resource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLastMamogramResult" runat="server" CssClass="defaultfontcolor"
                                                                    Text="Result" meta:resourcekey="lblLastMamogramResultResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLastMammogramResult_56" runat="server" 
                                                                    meta:resourcekey="txtLastMammogramResult_56Resource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkHRT_1066" runat="server" Text="Hormone Replacement Theraphy"
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkHRT_1066Resource1" />
                                    <%-- &nbsp;<asp:Label ID="lblHRT" runat="server" CssClass="defaultfontcolor" Text="Hormone Replacement Theraphy"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkHRT_1066" runat="server" style="display: none">
                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <table style="width: 75%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTypeofHRT" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="Type of HRT" meta:resourcekey="lblTypeofHRTResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTypeofHRT" onchange="javascript:showOthersBox(this.id);"
                                                                    runat="server" meta:resourcekey="ddlTypeofHRTResource1">
                                                                    <asp:ListItem Value="57" meta:resourcekey="ListItemResource142">Estrogen</asp:ListItem>
                                                                    <asp:ListItem Value="58" meta:resourcekey="ListItemResource143">Estrogen + Progesterone</asp:ListItem>
                                                                    <asp:ListItem Value="59" meta:resourcekey="ListItemResource144">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblHRTDelivery" runat="server" CssClass="defaultfontcolor" 
                                                                    Text="HRT Delivery" meta:resourcekey="lblHRTDeliveryResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlHRTDelivery" onchange="javascript:showOthersBox(this.id);"
                                                                    runat="server" meta:resourcekey="ddlHRTDeliveryResource1">
                                                                    <asp:ListItem Value="60" meta:resourcekey="ListItemResource145">Tablet</asp:ListItem>
                                                                    <asp:ListItem Value="61" meta:resourcekey="ListItemResource146">Gel</asp:ListItem>
                                                                    <asp:ListItem Value="62" meta:resourcekey="ListItemResource147">Vaginal ring</asp:ListItem>
                                                                    <asp:ListItem Value="63" meta:resourcekey="ListItemResource148">Injection</asp:ListItem>
                                                                    <asp:ListItem Value="64" meta:resourcekey="ListItemResource149">Patch</asp:ListItem>
                                                                    <asp:ListItem Value="65" meta:resourcekey="ListItemResource150">Cream</asp:ListItem>
                                                                    <asp:ListItem Value="66" meta:resourcekey="ListItemResource151">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <div id="divddlTypeofHRT" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersTypeofHRT_59" runat="server" 
                                                                        meta:resourcekey="txtOthersTypeofHRT_59Resource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <div id="divddlHRTDelivery" runat="server" style="display: none">
                                                                    <asp:TextBox ID="txtOthersHRTDelivery_66" runat="server" 
                                                                        meta:resourcekey="txtOthersHRTDelivery_66Resource1"></asp:TextBox>
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
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkObsHis_1067" runat="server" Text="Obstretic History" 
                                        onclick="javascript:showContent(this.id);" 
                                        meta:resourcekey="chkObsHis_1067Resource1" />
                                    <%-- &nbsp;<asp:Label ID="lblObstreticHistory" runat="server" Text="Obstretic History"></asp:Label>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <div id="divchkObsHis_1067" runat="server" style="display: none">
                                        <div style="width: 95%;" class="dataheader2">
                                            <table border="0" cellpadding="0" cellspacing="4" width="100%" class="tabletxt">
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td style="width: 10%">
                                                                    &nbsp;<asp:Label ID="lblGravida" runat="server" Text="Gravida" 
                                                                        meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 10%">
                                                                    &nbsp;<asp:TextBox ID="txtGravida" MaxLength="2" runat="server" CssClass="textfield1"
                                                                          onkeypress="return ValidateOnlyNumeric(this);"  
                                                                        meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 10%">
                                                                    <asp:Label ID="lblPara" runat="server" Text="Para" 
                                                                        meta:resourcekey="lblParaResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 10%">
                                                                    <asp:TextBox ID="txtPara" runat="server" MaxLength="2" CssClass="textfield1" 
                                                                          onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 19%">
                                                                    &nbsp;&nbsp;<asp:Label ID="lblAbortUs" runat="server" Text="AbortUs" 
                                                                        meta:resourcekey="lblAbortUsResource1"></asp:Label>
                                                                    &nbsp;&nbsp;<asp:TextBox ID="txtAbortUs" MaxLength="2" runat="server" CssClass="textfield1"
                                                                          onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 10%">
                                                                    &nbsp;<asp:Label ID="lblLive" runat="server" Text="Live" 
                                                                        meta:resourcekey="lblLiveResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 13%">
                                                                    <asp:TextBox ID="txtLive" runat="server" MaxLength="2" CssClass="textfield1" 
                                                                          onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtLiveResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 10%">
                                                                    &nbsp;<asp:Label ID="lblGPALOthers" runat="server" Text="Others" 
                                                                        meta:resourcekey="lblGPALOthersResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 13%">
                                                                    <asp:TextBox ID="txtGPALOthers" runat="server" MaxLength="50" 
                                                                        CssClass="textfield1" meta:resourcekey="txtGPALOthersResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 9%" align="center">
                                                                    <a id="hrfMDetails" runat="server" name="More" onclick="toggleDiv('divBaseLine');"
                                                                        style="cursor: pointer;">More&gt;&gt;</a>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="divBaseLine" style="display: none;">
                                                            <asp:HiddenField ID="HidBaseLine" runat="server" />
                                                            <table border="0" cellpadding="0" cellspacing="4" width="100%">
                                                                <tr>
                                                                    <td style="width: 12%">
                                                                        <asp:Label ID="lblSexofChild" runat="server" Text="Sex Of Child" 
                                                                            meta:resourcekey="lblSexofChildResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 11%">
                                                                        <asp:DropDownList ID="drdSOC" runat="server" CssClass="ddlTheme" 
                                                                            meta:resourcekey="drdSOCResource1">
                                                                            <asp:ListItem Text="Male" meta:resourcekey="ListItemResource152">Male</asp:ListItem>
                                                                            <asp:ListItem Text="Female" meta:resourcekey="ListItemResource153"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 13%">
                                                                        <asp:Label ID="lblAge" runat="server" Text="Age (in yrs)" 
                                                                            meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 13%">
                                                                        <asp:TextBox ID="txtAge" MaxLength="3" runat="server" CssClass="textfield1" 
                                                                            meta:resourcekey="txtAgeResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 20%">
                                                                        <asp:Label ID="lblMOD" runat="server" Text="Mode Of Delivery" 
                                                                            meta:resourcekey="lblMODResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 22%">
                                                                        <asp:DropDownList ID="drpMOD" runat="server" CssClass="ddlTheme" 
                                                                            meta:resourcekey="drpMODResource1">
                                                                            <%-- OnSelectedIndexChanged="drpMOD_SelectedIndexChanged"--%>
                                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource154">Caesarean</asp:ListItem>
                                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource155">ForcepsDelivery</asp:ListItem>
                                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource156">VaccumExtraction</asp:ListItem>
                                                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource157">NormalVaginalDelivery</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 10%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblBwt" runat="server" Text="Birth Weight" 
                                                                            meta:resourcekey="lblBwtResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtBwt" MaxLength="3" runat="server" Width="20px" 
                                                                            CssClass="textfield1" meta:resourcekey="txtBwtResource1"></asp:TextBox>Kg
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblBMaturity" runat="server" Text="Birth Maturity" 
                                                                            meta:resourcekey="lblBMaturityResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="drpBMaturity" runat="server" CssClass="ddlTheme" 
                                                                            meta:resourcekey="drpBMaturityResource1">
                                                                            <%-- OnSelectedIndexChanged="drpBMaturity_SelectedIndexChanged"--%>
                                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource158">FullTerm</asp:ListItem>
                                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource159">PreTerm</asp:ListItem>
                                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource160">PostTerm</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkIsGrowth" runat="server" Text="IsGrowth Ab Normal?" 
                                                                            meta:resourcekey="chkIsGrowthResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblGrowthRate" Visible="False" runat="server" Text="Growth Rate" 
                                                                            meta:resourcekey="lblGrowthRateResource1"></asp:Label>
                                                                        <asp:TextBox ID="txtGrowthRate" Text="0" runat="server" Visible="False" 
                                                                            CssClass="textfield1" meta:resourcekey="txtGrowthRateResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnAddOne" runat="server" CssClass="btn" OnClientClick="return BaseLineItems();"
                                                                            onmouseout="this.className='btn'" 
                                                                            onmouseover="this.className='btn btnhov'" Text="Add" 
                                                                            meta:resourcekey="btnAddOneResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" colspan="6">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <br />
                                            <table id="tblBaseLine" class="dataheaderInvCtrl" runat="server" width="100%" cellspacing="0"
                                                border="2">
                                                <tr class="colorforcontent">
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                                                        Sex of Child
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                                        Age
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                                                        M O D
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 13%;">
                                                        Birth Weight
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 11%;">
                                                        Growth Normal
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;
                                                        display: none;">
                                                        Growth Rate
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                                        Birth Maturity
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                        display: none;">
                                                        MODID
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                        display: none;">
                                                        BMID
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <%--<tr>
                                        <td>
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Submit" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>--%>
                        </table>
                        <br />
                        <br />
                        <table width="90%">
                            <tr align="center">
                                <td>
                                    <asp:HiddenField runat="server" ID="hdnSex" />
                                    <asp:Button ID="btnSave" runat="server" Text="Save" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" />
                                    &nbsp;
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" 
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
