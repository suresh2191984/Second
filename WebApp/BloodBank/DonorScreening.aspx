<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DonorScreening.aspx.cs" Inherits="BloodBank_DonorScreening" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="ucPatHeader" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
<%@ Register Src="~/BloodBank/InvestigationControl.ascx" TagName="InvestigationControl" TagPrefix="ucInvCtrl" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<script type="text/javascript" src="../Scripts/bid.js"></script>
<script type="text/javascript" src="../Scripts/test.js"></script>
<%--<%@ Register Src="../CommonControls/DynamicUserControl.ascx" TagName="DynamicUserControl" TagPrefix="ucDynamic" %>--%>
<%@ Register Src="~/BloodBank/DynamicUserControl.ascx" TagName="BloodDynamicUserControl" TagPrefix="ucBloodDynamic" %>
<%@ Register Src="~/BloodBank/DynamicUserControl2.ascx" TagName="BloodDynamicUserControl2" TagPrefix="ucBloodDynamic2" %>
<%@ Register Src="~/BloodBank/DynamicUserControl3.ascx" TagName="BloodDynamicUserControl3" TagPrefix="ucBloodDynamic3" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script language="javascript" type="text/javascript">
        function showContentHis(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var items;
            var cnt=0;
            if(document.getElementById('divHistory1').style.display=='block')
            {
                items=document.getElementById('hdnStatusCount').value.split('~');
                if(ddl[1]=='rdoYes')
                { 
                  var divid = ddl[0] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
                  if (document.getElementById(id).checked == true) {
                     document.getElementById(divid).style.display = 'block';
                     if(items.length>0)
                     {
                        for(var i=0;i<items.length;i++)
                        {
                           if(items[i]==ddl[1])
                             cnt=cnt+1;
                        }
                        if(cnt==0)
                          document.getElementById('hdnStatusCount').value=document.getElementById('hdnStatusCount').value+ddl[0]+'~';
                     }
                  }
                }
                else
                {
                   var divid= ddl[0] +'_div' + 'rdoYes_' + ddl[ddl.length - 1];
                   document.getElementById(divid).style.display ='none';
                   if(items.length>0)
                   {
                      document.getElementById('hdnStatusCount').value='';
                      for(var i=0;i<items.length;i++)
                      {
                         if(items[i]!=ddl[0] && items[i]!='')
                           document.getElementById('hdnStatusCount').value=document.getElementById('hdnStatusCount').value+items[i]+'~';
                      }
                   }
                }
                if(document.getElementById('hdnStatusCount').value!='')
                {
                  document.getElementById('lblEligibilityResult').innerHTML='FAIL';
                  document.getElementById('hdnPS1').value='N';
                  document.getElementById('lblEligibilityResult').style.color='Red';
                  document.getElementById('lblEligibilityResult').style.fontWeight='bold';
                  document.getElementById('lblEligibilityResult').style.fontSize='small';
                }
                else{
                  document.getElementById('lblEligibilityResult').innerHTML='PASS';
                  document.getElementById('hdnPS1').value='Y';
                  document.getElementById('lblEligibilityResult').style.color='DarkGreen';
                  document.getElementById('lblEligibilityResult').style.fontWeight='bold';
                  document.getElementById('lblEligibilityResult').style.fontSize='small';
                }
           }
           
           if(document.getElementById('divHistory2').style.display=='block')
            {
                items=document.getElementById('hdnTempStatusCount').value.split('~');
                if(ddl[1]=='rdoYes')
                { 
                  var divid = ddl[0] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
                  if (document.getElementById(id).checked == true) {
                     document.getElementById(divid).style.display = 'block';
                     if(items.length>0)
                     {
                        for(var i=0;i<items.length;i++)
                        {
                           if(items[i]==ddl[0])
                             cnt=cnt+1;
                        }
                        if(cnt==0)
                          document.getElementById('hdnTempStatusCount').value=document.getElementById('hdnTempStatusCount').value+ddl[0]+'~';
                     }
                  }
                }
                else
                {
                   var divid= ddl[0] +'_div' + 'rdoYes_' + ddl[ddl.length - 1];
                   document.getElementById(divid).style.display ='none';
                   if(items.length>0)
                   {
                      document.getElementById('hdnTempStatusCount').value='';
                      for(var i=0;i<items.length;i++)
                      {
                         if(items[i]!=ddl[0] && items[i]!='')
                           document.getElementById('hdnTempStatusCount').value=document.getElementById('hdnTempStatusCount').value+items[i]+'~';
                      }
                   }
                }
                if(document.getElementById('hdnTempStatusCount').value!='')
                {
                  document.getElementById('lblTemporaryStatusResult').innerHTML='FAIL';
                  document.getElementById('hdnTS1').value='N';
                  document.getElementById('lblTemporaryStatusResult').style.color='Red';
                  document.getElementById('lblTemporaryStatusResult').style.fontWeight='bold';
                  document.getElementById('lblTemporaryStatusResult').style.fontSize='small';
                }
                else{
                  document.getElementById('lblTemporaryStatusResult').innerHTML='PASS';
                  document.getElementById('hdnTS1').value='Y';
                  document.getElementById('lblTemporaryStatusResult').style.color='DarkGreen';
                  document.getElementById('lblTemporaryStatusResult').style.fontWeight='bold';
                  document.getElementById('lblTemporaryStatusResult').style.fontSize='small';
                }
           }
        }
        function showContentHisExam(id) {
            var chkvalue = id;
            var ddl = id.split('_'); 
            var divYesid = 'div' + 'rdoYes' + '_' + ddl[ddl.length - 1];
            var divNoid = 'div' + 'rdoNo' + '_' + ddl[ddl.length - 1];
            var divid = 'div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
            var items=document.getElementById('hdnExamStatusCount').value.split('~');
            var cnt=0;
            if(ddl[0]=='rdoNo')
            { 
               if (document.getElementById(id).checked == true) {
                 document.getElementById(divid).style.display = 'block';
                 document.getElementById(divYesid).style.display = 'none';
                 if(items.length>0)
                 {
                    for(var i=0;i<items.length;i++)
                    {
                       if(items[i]==ddl[ddl.length - 1])
                         cnt=cnt+1;
                    }
                    if(cnt==0)
                      document.getElementById('hdnExamStatusCount').value=document.getElementById('hdnExamStatusCount').value+ddl[ddl.length-1]+'~';
                 }
               }
            }
            else
            {
              if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display ='block';
                document.getElementById(divNoid).style.display='none';
              }
              if(items.length>0)
              {
                document.getElementById('hdnExamStatusCount').value='';
                for(var i=0;i<items.length;i++)
                {
                   if(items[i]!=ddl[ddl.length - 1] && items[i]!='')
                     document.getElementById('hdnExamStatusCount').value=document.getElementById('hdnExamStatusCount').value+items[i]+'~';
                }
              }
            }
            if(document.getElementById('hdnExamStatusCount').value!='')
            {
              document.getElementById('lblExaminationStatusResult').innerHTML='FAIL';
              document.getElementById('hdnES1').value='N';
              document.getElementById('lblExaminationStatusResult').style.color='Red';
              document.getElementById('lblExaminationStatusResult').style.fontWeight='bold';
              document.getElementById('lblExaminationStatusResult').style.fontSize='small';
            }
            else{
              document.getElementById('lblExaminationStatusResult').innerHTML='PASS';
              document.getElementById('hdnES1').value='Y';
              document.getElementById('lblExaminationStatusResult').style.color='DarkGreen';
              document.getElementById('lblExaminationStatusResult').style.fontWeight='bold';
              document.getElementById('lblExaminationStatusResult').style.fontSize='small';
            }
        }
        function showOthersBoxMedHis(ddl) {
            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
            var OID = ddl.split('_');
            var strDiv = "";
            
            if (OID.length == 3) {
                strDiv = OID[0] + '_div' + OID[OID.length - 2] + '_' + OID[OID.length - 1];
            }
            else {
                 strDiv = OID[0] + '_' + OID[1] + '_div' + OID[OID.length - 2] + '_' + OID[OID.length - 1];
            }

            if ((ddlValue == "Others") || (ddlValue == "Occasional Physicial Activity") || (ddlValue == "Athlete") || (ddlValue == "Regular Exercise")) {
                document.getElementById(strDiv).style.display = 'block';
            }
            else {
                document.getElementById(strDiv).style.display = 'none';
            }
            
        }
        function ChangeInvestigationStatus()
        {
           document.getElementById('lblInvestigationStatus').innerHTML="Completed";
        }
        function showContentMedHis(id) {
            
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = "";
            var strHid = "";
            
            if (ddl.length == 3) {
                divid = ddl[0] + '_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
                strHid = ddl[0] + '_hdn' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
                
            }
            else {
                divid = ddl[0] + '_' + ddl[1] + '_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
                strHid = ddl[0] + '_' + ddl[1] + '_hdn' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
               
            }
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
                document.getElementById(strHid).value = 'Open';
            }
            else {
                document.getElementById(divid).style.display = 'none';
                document.getElementById(strHid).value == 'Close';
            }
        }
        function showContent(id, div) {
            if (document.getElementById('tcEMR_tpHistory_ucHistory_chk' + id).checked == true) {
                document.getElementById('tcEMR_tpHistory_ucHistory_div' + div).style.display = 'block';
            }
            else {
                document.getElementById('tcEMR_tpHistory_ucHistory_div' + div).style.display = 'none';
            }
        }
        function showQuitDet(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            //var divid = 'tcEMR_tpHistory_ucHistory_td' + ddl[3] + '_' + ddl[4];
            var divid = ddl[0]+'_'+ddl[1] + '_td' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }
        function showOthersBoxHis(ddl) {

            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
            var OID = ddl.split('_');


            var strDiv = OID[0]+'_' + OID[1]+'_div' + OID[2] + '_' + OID[3];


            if ((ddlValue == "Others") || (ddlValue == "Occasional Physicial Activity") || (ddlValue == "Athlete") || (ddlValue == "Regular Exercise")) {
                document.getElementById(strDiv).style.display = 'block';
            }
            else {
                document.getElementById(strDiv).style.display = 'none';
            }
        }
        function showOthersChkBox(id) {
            if (document.getElementById(id).checked == true) {


                document.getElementById('tcEMR_tpHistory_ucHistory_divchkOthers_9').style.display = 'block';
            }
            else {
                document.getElementById('tcEMR_tpHistory_ucHistory_divchkOthers_9').style.display = 'none';
            }
        }
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('tcEMR_tpExamination_PatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('tcEMR_tpExamination_PatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        function fnLoadCtl(id) {
            var CtrlArr = new Array();
            CtrlArr[0] = "btnHistory";
            CtrlArr[1] = "btnExam";
            CtrlArr[2]= "btnDiagnostics";
            CtrlArr[3] = "btnOrderInv";
            for (var i = 0; i < CtrlArr.length; i++) {
                var strCtrl1 = 'div' + CtrlArr[i].substr(3, CtrlArr[i].length - 3);
                var strCtrl = document.getElementById(strCtrl1);
                strCtrl.style.display = "none";
                if (id == CtrlArr[i]) {
                    strCtrl.style.display = "block";
                }

            }
            javascript: __doPostBack(id, '');
            return false;

        }
        function btnClick(id) {
            //debugger;
            alert(id);
            var btnObj = document.getElementById(id);
            javascript: __doPostBack(id, '');
            return false;
        }
        function showphase2()
        {
           if(document.getElementById('lblEligibilityResult').innerHTML=='FAIL')
           {
             var i= confirm('The eligibility status is FAIL. Do u still want to continue');
             if(i)
             {
               document.getElementById('divHistory1').style.display="none";
               document.getElementById('divHistory2').style.display="block";
               document.getElementById('hdnPS2').value='Y';
               document.getElementById('divSave').style.display="block";
             }
           }
           else{
             document.getElementById('divHistory1').style.display="none";
             document.getElementById('divHistory2').style.display="block";
             document.getElementById('hdnPS2').value='Y';
             document.getElementById('divSave').style.display="block";
           }
             
        }
        function Checkforsave()
        {
           if(confirm("Unsaved data will be lost,if any. Do you want to continue?"))
           {
              return true;
           }
           else return false;
        }
        function showphase1()
        {
           document.getElementById('divHistory2').style.display="none";
           document.getElementById('divHistory1').style.display="block";
           document.getElementById('divSave').style.display="none";
        }
        function ExacerClick() {
        var obj = document.getElementById('ucLungDiseases_chkExacerbations_18');
        document.getElementById('ucLungDiseases_tdExacer').style.display = "none";
//        document.getElementById('ucDynamic_ucAsthma_tdExacerEMR').style.display = "none";
        if (obj.checked) {
            document.getElementById('ucLungDiseases_tdExacer').style.display = "block";
//            document.getElementById('ucDynamic_ucAsthma_tdExacerEMR').style.display = "block";
        }
    }
       
       function isNumeric(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 0) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }
    function LoadPriorVaccinationsItems() {
        var HidVaccinationsValue = document.getElementById('ucVaccination_HdnVaccination').value;
        var PriorList = HidVaccinationsValue.split('^');
        if (document.getElementById('ucVaccination_HdnVaccination').value != "") {

            for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                var PriVacList = PriorList[pvCount].split('~');

                var rowV = document.getElementById('ucVaccination_tblPriorVaccinations').insertRow(1);
                var icoutV = document.getElementById('ucVaccination_tblPriorVaccinations').rows.length;
                rowV.id = icoutV;

                rowV.id = PriVacList[0];
                var cell1 = rowV.insertCell(0);
                var cell2 = rowV.insertCell(1);
                var cell3 = rowV.insertCell(2);
                var cell4 = rowV.insertCell(3);
                var cell5 = rowV.insertCell(4);
                var cell6 = rowV.insertCell(5);
                var cell7 = rowV.insertCell(6);
                cell1.innerHTML = "<img id='imgbtnLPV' style='cursor:pointer;' OnClick='PriorDeleteclick(" + PriVacList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PriVacList[1];
                cell3.innerHTML = PriVacList[2];
                cell4.innerHTML = PriVacList[3];
                cell5.innerHTML = PriVacList[4];
                cell6.innerHTML = PriVacList[5];
                document.getElementById('ucVaccination_ddlAnaphylacticReaction').value = PriVacList[6];
                var reaction = '';  //document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text;
                document.getElementById('ucVaccination_ddlAnaphylacticReaction').selectedIndex = 0;
                cell7.innerHTML = reaction;
                cell6.style.display = "none";
            }
        }
        return false;
    }
    function PriorVaccinationsItems() {
        var VaccinationStatus = 0;
        var HidVaccinationValue = document.getElementById('ucVaccination_HdnVaccination').value;
        var Vacclist = HidVaccinationValue.split('^');
        var ddlVaccination = document.getElementById('ucDynamic_ucVaccination_drpVaccination').options[document.getElementById('ucDynamic_ucVaccination_drpVaccination').selectedIndex].text;
        var ddlVaccinationid = document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').value;
        var ddlReaction = document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').options[document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex].text;
        var Year = document.getElementById('ucDynamic_ucVaccination_txtYear').value;
        if (document.getElementById('ucDynamic_ucVaccination_drpMonth').options[document.getElementById('ucDynamic_ucVaccination_drpMonth').selectedIndex].text != "---Select---") {

            var ddlMonth = document.getElementById('ucDynamic_ucVaccination_drpMonth').options[document.getElementById('ucDynamic_ucVaccination_drpMonth').selectedIndex].text;
        }
        else {
            var ddlMonth = "";
        }

        var Doses = document.getElementById('ucDynamic_ucVaccination_txtDoses').value;
        if (document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').options[document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex].text != "---Select---") {
            var Booster = document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').options[document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex].text;
        }
        else {
            var Booster = "";
        }
        var vrow = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').insertRow(1);
        var vrCount = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').rows.length;
        vrow.id = vrCount;
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
        document.getElementById('ucDynamic_ucVaccination_HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
        document.getElementById('ucDynamic_ucVaccination_drpVaccination').selectedIndex = 0;
        document.getElementById('ucDynamic_ucVaccination_txtYear').value = '';
        document.getElementById('ucDynamic_ucVaccination_drpMonth').selectedIndex = 0;
        document.getElementById('ucDynamic_ucVaccination_txtDoses').value = '';
        document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').checked = false;
        document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex = 0;
        VaccinationStatus = 0;
        return false;
        if (VaccinationStatus == 0) {

            var vrowv = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').insertRow(1);
            var vrCount = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').rows.length;
            vrowv.id = vrCount;
            var cell1 = vrowv.insertCell(0);
            var cell2 = vrowv.insertCell(1);
            var cell3 = vrowv.insertCell(2);
            var cell4 = vrowv.insertCell(3);
            var cell5 = vrowv.insertCell(4);
            var cell6 = vrowv.insertCell(5);
            var cell7 = vrowv.insertCell(6);
            var cell8 = vrowv.insertCell(7);
            cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlVaccination;
            cell3.innerHTML = Year;
            cell4.innerHTML = ddlMonth;
            cell5.innerHTML = Doses;
            cell6.innerHTML = Booster;
            cell7.innerHTML = ddlVaccinationid;
            cell7.style.display = "none";
            document.getElementById('ucDynamic_ucVaccination_HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
            document.getElementById('ucDynamic_ucVaccination_drpVaccination').selectedIndex = 0;
            document.getElementById('ucDynamic_ucVaccination_txtYear').value = '';
            document.getElementById('ucDynamic_ucVaccination_drpMonth').selectedIndex = 0;
            document.getElementById('ucDynamic_ucVaccination_txtDoses').value = '';
            document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').checked = false;
            document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex = 0;
            VaccinationStatus = 0;
            return false;
        }
    }
    function onClickAddSurgery(type) {
        var hiddenfield;
        var table;
        var txtSurgeryNametext;
        var txtDatetext;
        var txtHospitaltext;
        if(type=='major')
        {
           hiddenfield='ucDynamic_ucMajorSurgery_hdnSurgeryItems';
           table='ucDynamic_ucMajorSurgery_tblSurgeryItems';
           txtSurgeryNametext='ucDynamic_ucMajorSurgery_txtsurgeryName';
           txtDatetext='ucDynamic_ucMajorSurgery_txtDate';
           txtHospitaltext='ucDynamic_ucMajorSurgery_txtHospital';
        }
        else if(type=='minor')
        {
           hiddenfield='ucDynamic_ucMinorSurgery_hdnSurgeryItems';
           table='ucDynamic_ucMinorSurgery_tblSurgeryItems';
           txtSurgeryNametext='ucDynamic_ucMinorSurgery_txtsurgeryName';
           txtDatetext='ucDynamic_ucMinorSurgery_txtDate';
           txtHospitaltext='ucDynamic_ucMinorSurgery_txtHospital';
        } 
        var rwNumber = parseInt(110);
        var AddStatus = 0;
        var txtSurgeryName = document.getElementById(txtSurgeryNametext).value.trim();
        var txtDate = document.getElementById(txtDatetext).value.trim();
        var txtHospital = document.getElementById(txtHospitaltext).value;
        document.getElementById(table).style.display = 'block';
        var HidValue = document.getElementById(hiddenfield).value;
        var list = HidValue.split('^');
        if (document.getElementById(hiddenfield).value != "") {
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
                var row = document.getElementById(table).insertRow(0);
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
                document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate + "~" + txtHospital + "^";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (txtSurgeryName != '') {
                var row = document.getElementById(table).insertRow(0);
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
                document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate + "~" + txtHospital + "^";
            }
        }
        else if (AddStatus == 1) {
            alert("Surgery Already Added!");
        }
        document.getElementById(txtSurgeryNametext).value = '';
        document.getElementById(txtDatetext).value = '';
        document.getElementById(txtHospitaltext).value = '';
        return false;
    }
//    function ShowHistory()
//    {
//       document.getElementById('ucDynamic_btnHistory').style.display='block';
//       document.getElementById('ucDynamic_btnHistory1').style.display='none';
//       document.getElementById('ucDynamic_btnOrderInv').style.display='block';
//       document.getElementById('ucDynamic_btnOrderInv').disabled=true;
//       document.getElementById('ucDynamic_btnExam').style.display='none';
//       document.getElementById('ucDynamic_divHistory1').style.display='block';
//       document.getElementById('ucDynamic_divExam').style.display='none';
//       document.getElementById('ucDynamic_divInvestigation').style.display='none';
//       document.getElementById('ucDynamic_divSave').style.display='none';
//       document.getElementById('ucDynamic_lblExamination').style.fontSize = 'Small';
//       document.getElementById('ucDynamic_lblExamination').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblExamination').style.textDecoration = 'none';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontSize = 'Small';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblInvestigation').style.textDecoration = 'none';
//       document.getElementById('ucDynamic_lblHistory').style.fontSize = 'Large';
//       document.getElementById('ucDynamic_lblHistory').style.fontWeight = 'bold';
//       document.getElementById('ucDynamic_lblHistory').style.textDecoration = 'underline'; 
//       
//    }
//    function ShowExamination()
//    {
//       document.getElementById('ucDynamic_btnHistory').style.display='none';
//       document.getElementById('ucDynamic_btnHistory1').style.display='block';
//       document.getElementById('ucDynamic_btnOrderInv').style.display='block';
//       document.getElementById('ucDynamic_btnExam').style.display='none';
//       document.getElementById('ucDynamic_btnOrderInv').disabled=false;
//       document.getElementById('ucDynamic_btnHistory1').disabled=false;
//       document.getElementById('ucDynamic_divHistory1').style.display='none';
//       document.getElementById('ucDynamic_divHistory2').style.display='none';
//       document.getElementById('ucDynamic_divExam').style.display='block';
//       document.getElementById('ucDynamic_divInvestigation').style.display='none';
//       document.getElementById('ucDynamic_divSave').style.display='block';
//       document.getElementById('ucDynamic_lblExamination').style.fontSize = 'Large';
//       document.getElementById('ucDynamic_lblExamination').style.fontWeight = 'bold';
//       document.getElementById('ucDynamic_lblExamination').style.textDecoration = 'underline';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontSize = 'small';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblInvestigation').style.textDecoration = 'none';
//       document.getElementById('ucDynamic_lblHistory').style.fontSize = 'Small';
//       document.getElementById('ucDynamic_lblHistory').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblHistory').style.textDecoration = 'none'; 
//    }
//    function ShowOrderInvestigation()
//    {
//       document.getElementById('ucDynamic_btnOrderInv').style.display='none';
//       document.getElementById('ucDynamic_btnExam').style.display='block';
//       document.getElementById('ucDynamic_btnHistory1').style.display='block';
//       document.getElementById('ucDynamic_btnHistory1').disabled=true;
//       document.getElementById('ucDynamic_divExam').style.display='none';
//       document.getElementById('ucDynamic_divInvestigation').style.display='block';
//       document.getElementById('ucDynamic_divSave').style.display='none';
//       document.getElementById('ucDynamic_divHistory1').style.display='none';
//       document.getElementById('ucDynamic_divHistory2').style.display='none';
//       document.getElementById('ucDynamic_lblExamination').style.fontSize = 'Small';
//       document.getElementById('ucDynamic_lblExamination').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblExamination').style.textDecoration = 'none';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontSize = 'Large';
//       document.getElementById('ucDynamic_lblInvestigation').style.fontWeight = 'bold';
//       document.getElementById('ucDynamic_lblInvestigation').style.textDecoration = 'underline';
//       document.getElementById('ucDynamic_lblHistory').style.fontSize = 'Small';
//       document.getElementById('ucDynamic_lblHistory').style.fontWeight = 'normal';
//       document.getElementById('ucDynamic_lblHistory').style.textDecoration = 'none';
//    }
    function LoadSurgeryItems(type) {
        var hiddenfield;
        var table;
        if(type=='major')
        {
           hiddenfield='ucDynamic_ucMajorSurgery_hdnSurgeryItems';
           table='ucDynamic_ucMajorSurgery_tblSurgeryItems';
        }
        else if(type=='minor')
        {
           hiddenfield='ucDynamic_ucMinorSurgery_hdnSurgeryItems';
           table='ucDynamic_ucMinorSurgery_tblSurgeryItems';
        }
        var HidValue = document.getElementById(hiddenfield).value;
        var list = HidValue.split('^');
        if (document.getElementById(hiddenfield).value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var HistoryList = list[count].split('~');
                var row = document.getElementById(table).insertRow(0);
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
</script>
<head id="Head1" runat="server">
    <title>Donor Screening</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        input:focus
        {
            /*background: #8AC0DA;*/
            outline: .25px solid #8f0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
   <asp:ScriptManager ID="scm1" runat="server">
    <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
    </Services>
    </asp:ScriptManager>
    <asp:UpdatePanel ID ="upEMR" runat ="server">
    <ContentTemplate>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <ucPatHeader:PatientHeader ID="patientHeader" runat="server" />
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
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
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
                        
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                         <tr>
                        <td>
                            <asp:Label ID="lblHistory" Text="History" runat="server" 
                                meta:resourcekey="lblHistoryResource1"></asp:Label><br />
                            <asp:Label ID="lblHistoryStatus" Text="Pending" runat="server" 
                                meta:resourcekey="lblHistoryStatusResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnHistory" ImageUrl="~/images/next.png" ToolTip="Go to Examination" runat="server"
                              CausesValidation="False" meta:resourcekey="btnHistoryResource1" OnClick="btnExam_Click" />
                            <asp:ImageButton ID="btnHistory1" ImageUrl="~/images/previous.png" ToolTip="Back to History" runat="server" style="display:none"
                               CausesValidation="False" meta:resourcekey="btnHistory1Resource1"  OnClick="btnHistory_Click"/>
                        </td>
                        <td>
                            <asp:Label ID="lblExamination" Text="Examination" runat="server" 
                                meta:resourcekey="lblExaminationResource1"></asp:Label><br />
                            <asp:Label ID="lblExamStatus" Text="Pending" runat="server" 
                                meta:resourcekey="lblExamStatusResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnOrderInv" runat="server" ImageUrl="~/images/next.png"
                                    ToolTip ="Go to Order Investigation" CausesValidation="False" meta:resourcekey="btnOrderInvResource1" OnClick="btnOrderInv_Click"  />
                            <asp:ImageButton ID="btnExam" runat="server" ImageUrl="~/images/previous.png" style="display:none"
                                    ToolTip ="Back to Examination" CausesValidation="False" meta:resourcekey="btnExamResource1" OnClick="btnExam_Click" />
                        </td>
                        <td>
                            <asp:Label ID="lblInvestigation" Text="Order Investigation" runat="server" 
                                meta:resourcekey="lblInvestigationResource1"></asp:Label><br />
                            <asp:Label ID="lblInvestigationStatus" Text="Pending" runat="server" 
                                meta:resourcekey="lblInvestigationStatusResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                      <td colspan="5">
                            <table width="100%" class="dataheaderInvCtrl" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <div id="divHistory1" style="display: block;" runat="server">
                                            <div id="divMedicalHistory1" onclick="showResponses('divMedicalHistory1','divMedicalHistory2','divMedicalHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label13" Text="Medical History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label13Resource1" />
                                            </div>
                                            <div id="divMedicalHistory2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divMedicalHistory1','divMedicalHistory2','divMedicalHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label14" Text="Medical History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label14Resource1" />
                                            </div>
                                            <div id="divMedicalHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblMedicalHistory" Visible="False" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblMedicalHistoryResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divTreatmentHistory1" onclick="showResponses('divTreatmentHistory1','divTreatmentHistory2','divTreatmentHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label9" Text="Treatment History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label9Resource1" />
                                            </div>
                                            <div id="divTreatmentHistory2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divTreatmentHistory1','divTreatmentHistory2','divTreatmentHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label10" Text="Treatment History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label10Resource1" />
                                            </div>
                                            <div id="divTreatmentHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblTreatmentHistory" Visible="False" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblTreatmentHistoryResource1">
                                                </asp:Table>
                                            </div>
                                            <asp:Table ID="drawNewHistory" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                Width="100%" class="dataheaderInvCtrl" 
                                                meta:resourcekey="drawNewHistoryResource1">
                                            </asp:Table>
                                            <table border="1" width="50%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblEligibility" runat="server" Font-Bold="True" 
                                                            Text="Eligibility status ::" meta:resourcekey="lblEligibilityResource1"></asp:Label>
                                                        <asp:Label ID="lblEligibilityResult" Text="PASS" Font-Bold="True" 
                                                            ForeColor="Green" runat="server" 
                                                            meta:resourcekey="lblEligibilityResultResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnProceed" runat="server" Text="Proceed to Phase-II screeing" 
                                                            OnClientClick="Javascript:showphase2(); return false;" 
                                                            meta:resourcekey="btnProceedResource1" />
                                                        <asp:Button ID="btnExclusion" runat="server" Text="Exclude from blood donation" 
                                                            OnClick="btnExclusion_Click" meta:resourcekey="btnExclusionResource1" />
                                                        <asp:Button ID="btnCancel1" Text="Exit" runat="server" OnClientClick="javascript:if(!Checkforsave()) return false;"
                                                         OnClick="btnCancel1_Click" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divHistory2" style="display: none;" runat="server">
                                            <div id="divToday1" onclick="showResponses('divToday1','divToday2','divToday',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label11" Text="Today" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label11Resource1" />
                                            </div>
                                            <div id="divToday2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divToday1','divToday2','divToday',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label12" Text="Today" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label12Resource1" />
                                            </div>
                                            <div id="divToday" runat="server" style="display: none;">
                                                <asp:Table ID="tblToday" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblTodayResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast1to3days1" onclick="showResponses('divPast1to3days1','divPast1to3days2','divPast1to3days',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label15" Text="Past 1 to 3 days" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label15Resource1" />
                                            </div>
                                            <div id="divPast1to3days2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast1to3days1','divPast1to3days2','divPast1to3days',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label16" Text="Past 1 to 3 days" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label16Resource1" />
                                            </div>
                                            <div id="divPast1to3days" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast1to3days" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast1to3daysResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast6weeks1" onclick="showResponses('divPast6weeks1','divPast6weeks2','divPast6weeks',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label17" Text="Past 6 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label17Resource1" />
                                            </div>
                                            <div id="divPast6weeks2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast6weeks1','divPast6weeks2','divPast6weeks',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label18" Text="Past 6 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label18Resource1" />
                                            </div>
                                            <div id="divPast6weeks" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast6weeks" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast6weeksResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast8weeks1" onclick="showResponses('divPast8weeks1','divPast8weeks2','divPast8weeks',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label19" Text="Past 8 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label19Resource1" />
                                            </div>
                                            <div id="divPast8weeks2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast8weeks1','divPast8weeks2','divPast8weeks',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label20" Text="Past 8 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label20Resource1" />
                                            </div>
                                            <div id="divPast8weeks" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast8weeks" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast8weeksResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast3months1" onclick="showResponses('divPast3months1','divPast3months2','divPast3months',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label21" Text="Past 3 months" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label21Resource1" />
                                            </div>
                                            <div id="divPast3months2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast3months1','divPast3months2','divPast3months',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label22" Text="Past 3 months" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label22Resource1" />
                                            </div>
                                            <div id="divPast3months" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast3months" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast3monthsResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast6mnthsto1year1" onclick="showResponses('divPast6mnthsto1year1','divPast6mnthsto1year2','divPast6mnthsto1year',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label23" Text="Past 6 months to 1 year" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label23Resource1" />
                                            </div>
                                            <div id="divPast6mnthsto1year2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast6mnthsto1year1','divPast6mnthsto1year2','divPast6mnthsto1year',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label24" Text="Past 6 months to 1 year" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" meta:resourcekey="Label24Resource1" />
                                            </div>
                                            <div id="divPast6mnthsto1year" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast6mnthsto1year" Visible="False" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast6mnthsto1yearResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast1year1" onclick="showResponses('divPast1year1','divPast1year2','divPast1year',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label25" Text="Past 1 year" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label25Resource1" />
                                            </div>
                                            <div id="divPast1year2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast1year1','divPast1year2','divPast1year',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label26" Text="Past 1 year" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label26Resource1" />
                                            </div>
                                            <div id="divPast1year" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast1year" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast1yearResource1">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast3years1" onclick="showResponses('divPast3years1','divPast3years2','divPast3years',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label27" Text="Past 3 years" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label27Resource1" />
                                            </div>
                                            <div id="divPast3years2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('divPast3years1','divPast3years2','divPast3years',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label28" Text="Past 3 years" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" meta:resourcekey="Label28Resource1" />
                                            </div>
                                            <div id="divPast3years" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast3years" Visible="False" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl" 
                                                    meta:resourcekey="tblPast3yearsResource1">
                                                </asp:Table>
                                            </div>
                                            <table border="1" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblTemporaryStatus" runat="server" Font-Bold="True" 
                                                            Text="Eligibility status ::" meta:resourcekey="lblTemporaryStatusResource1"></asp:Label>
                                                        <asp:Label ID="lblTemporaryStatusResult" Text="PASS" Font-Bold="True" 
                                                            ForeColor="Green" runat="server" 
                                                            meta:resourcekey="lblTemporaryStatusResultResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnProceedto1" runat="server" Text="Back to Phase-I screeing" 
                                                            OnClientClick="Javascript:showphase1(); return false;" 
                                                            meta:resourcekey="btnProceedto1Resource1" />
                                                        <asp:Button ID="btnTemporaryExclusion" runat="server" 
                                                            Text="Temporarily exclude from blood donation" 
                                                            OnClick="btnTemporaryExclusion_Click" 
                                                            meta:resourcekey="btnTemporaryExclusionResource1"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div id="divExam" style="display: none;" runat="server">
                                <table id="drawNewExam" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                    class="dataheaderInvCtrl">
                                    <tr runat="server">
                                        <td runat="server">
                                            <ucVitals:PatientVitals ID="PatientVitalsControl" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblCardio_vascular" runat="server" Text="CardioVascular System" 
                                                meta:resourcekey="lblCardio_vascularResource1"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_vascular" Text="Normal" runat="server" GroupName="radioCardio"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoYes_vascularResource1" />
                                            <asp:RadioButton ID="rdoNo_vascular" Text="Abnormal" runat="server" GroupName="radioCardio"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoNo_vascularResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_vascular" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_vascular" runat="server" 
                                                                meta:resourcekey="txtrdoYes_vascularResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_vascular" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_vascular" runat="server" 
                                                                meta:resourcekey="txtrdoNo_vascularResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblRespiratory" runat="server" Text="Respiratory System" 
                                                meta:resourcekey="lblRespiratoryResource1"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Respiratory" Text="Normal" runat="server" GroupName="radioRespiratory"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoYes_RespiratoryResource1" />
                                            <asp:RadioButton ID="rdoNo_Respiratory" Text="Abnormal" runat="server" GroupName="radioRespiratory"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoNo_RespiratoryResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Respiratory" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Respiratory" runat="server" 
                                                                meta:resourcekey="txtrdoYes_RespiratoryResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Respiratory" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Respiratory" runat="server" 
                                                                meta:resourcekey="txtrdoNo_RespiratoryResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblAbdominal" runat="server" Text="Abdominal System" 
                                                meta:resourcekey="lblAbdominalResource1"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Abdominal" Text="Normal" runat="server" GroupName="radioAbdominal"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoYes_AbdominalResource1" />
                                            <asp:RadioButton ID="rdoNo_Abdominal" Text="Abnormal" runat="server" GroupName="radioAbdominal"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoNo_AbdominalResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Abdominal" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Abdominal" runat="server" 
                                                                meta:resourcekey="txtrdoYes_AbdominalResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Abdominal" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Abdominal" runat="server" 
                                                                meta:resourcekey="txtrdoNo_AbdominalResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblNeurological" runat="server" Text="Neurological System" 
                                                meta:resourcekey="lblNeurologicalResource1"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Neurological" Text="Normal" runat="server" GroupName="radioNeurological"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoYes_NeurologicalResource1" />
                                            <asp:RadioButton ID="rdoNo_Neurological" Text="Abnormal" runat="server" GroupName="radioNeurological"
                                                onclick="javascript:showContentHisExam(this.id);" 
                                                meta:resourcekey="rdoNo_NeurologicalResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Neurological" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Neurological" runat="server" 
                                                                meta:resourcekey="txtrdoYes_NeurologicalResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Neurological" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Neurological" runat="server" 
                                                                meta:resourcekey="txtrdoNo_NeurologicalResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblOtherFindings" runat="server" Text="Other Findings" 
                                                meta:resourcekey="lblOtherFindingsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <div id="divrdoYes_Other" runat="server">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Other" runat="server" 
                                                                meta:resourcekey="txtrdoYes_OtherResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblExaminationStatus" Text="Eligibility Status :: " 
                                                runat="server" Font-Bold="True" 
                                                meta:resourcekey="lblExaminationStatusResource1"></asp:Label>
                                            <asp:Label ID="lblExaminationStatusResult" Text="PASS" Font-Bold="True" 
                                                ForeColor="Green" runat="server" 
                                                meta:resourcekey="lblExaminationStatusResultResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><asp:Button ID="btnExamExclude" Text="Exclude" runat="server" 
                                                OnClick="btnExamExclude_Click" meta:resourcekey="btnExamExcludeResource1"/></td> 
                                    </tr>
                                </table>
                            </div>
                            <asp:HiddenField ID="hdnControl" runat="server" />
                            <div id="divHistory" style="display: none;" runat="server">
                                <asp:Panel ID="pnlDisplay" runat="server" 
                                    meta:resourcekey="pnlDisplayResource1">
                                </asp:Panel>
                                <asp:Panel ID="pnlHis" runat="server" meta:resourcekey="pnlHisResource1">
                                </asp:Panel>
                            </div>
                            <div id="divInvestigation" style="display:none" runat="server">
                              <ucInvCtrl:InvestigationControl ID="ucInvCtrl" runat="server" />
                            </div>
                            <asp:HiddenField runat="server" ID="hdnSex" />
                            <asp:HiddenField runat="server" ID="hdnHistory" />
                            <asp:HiddenField runat="server" ID="hdnButton" />
                            <asp:HiddenField runat="server" ID="hdnHistoryControl" />
                            <asp:HiddenField runat="server" ID="hdnComplaintControl" />
                            <asp:HiddenField runat="server" ID="hdnStatusCount" />
                            <asp:HiddenField runat="server" ID="hdnTempStatusCount" />
                            <asp:HiddenField runat="server" ID="hdnExamStatusCount" />
                            <tr>
                                <td align="left">
                                  <div id="divSave" runat="server">
                                    <asp:Button ID="btnSave" Text="Save" CssClass="btn" runat="server" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="btnCancel" Text="Exit" CssClass="btn" runat="server" OnClientClick="javascript:if(!Checkforsave()) return false;"
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                  </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </td>
                    </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc14:Footer ID="Footer1" runat="server" />
    </div>
    </ContentTemplate>
  
   </asp:UpdatePanel>
   <asp:HiddenField ID="hdnPS1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnPS2" Value=" " runat="server" />
    <asp:HiddenField ID="hdnTS1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnTS2" Value=" " runat="server" />
    <asp:HiddenField ID="hdnES1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnES2" Value=" " runat="server" />
    </form>
</body>
</html>
