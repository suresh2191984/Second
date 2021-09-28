<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicUserControl.ascx.cs"
    Inherits="CommonControls_DynamicUserControl" %>
<%@ Register Src="../EMR/Skin.ascx" TagName="Skin" TagPrefix="ucSkin" %>
<%@ Register Src="../EMR/Hair.ascx" TagName="Hair" TagPrefix="ucHair" %>
<%@ Register Src="../EMR/Nails.ascx" TagName="Nails" TagPrefix="ucNails" %>
<%@ Register Src="../EMR/Scars.ascx" TagName="Scars" TagPrefix="ucScars" %>
<%@ Register Src="../EMR/Eye.ascx" TagName="Eye" TagPrefix="ucEye" %>
<%@ Register Src="../EMR/Ear.ascx" TagName="Ear" TagPrefix="ucEar" %>
<%@ Register Src="../EMR/Neck.ascx" TagName="Neck" TagPrefix="ucNeck" %>
<%@ Register Src="../EMR/FootExam.ascx" TagName="Foot" TagPrefix="ucFoot" %>
<%@ Register Src="../EMR/RespiratorySystem.ascx" TagName="RS" TagPrefix="ucRS" %>
<%@ Register Src="../EMR/OralCavity.ascx" TagName="OralCavity" TagPrefix="uc7" %>
<%@ Register Src="../EMR/NeurologicaExamination.ascx" TagName="NeurologicaExamination"
    TagPrefix="uc8" %>
<%@ Register Src="../EMR/DiabetesMellitus.ascx" TagName="DiabetesMellitus" TagPrefix="ucDiab" %>
<%@ Register Src="../EMR/Liver.ascx" TagName="Liver" TagPrefix="ucLiver" %>
<%@ Register Src="../EMR/PVD.ascx" TagName="PVD" TagPrefix="ucPVD" %>
<%@ Register Src="../EMR/OtherDisease.ascx" TagName="OtherDisease" TagPrefix="ucOther" %>
<%@ Register Src="../EMR/Dyslipidemia.ascx" TagName="Dyslipidemia" TagPrefix="ucDyslipidemia" %>
<%@ Register Src="../EMR/SystemicHypertension.ascx" TagName="SystemicHypertension"
    TagPrefix="ucSystemicHypertension" %>
<%@ Register Src="../EMR/RenalDisorder.ascx" TagName="RenalDisorder" TagPrefix="ucRenal" %>
<%@ Register Src="../EMR/Tuberculosis.ascx" TagName="Tuberculosis" TagPrefix="ucTuberculosis" %>
<%@ Register Src="../EMR/GynaecologicalExam.ascx" TagName="GynaecologicalExam" TagPrefix="uc10" %>
<%@ Register Src="../EMR/RectalExamination.ascx" TagName="RectalExamination" TagPrefix="uc11" %>
<%@ Register Src="../EMR/CardiovascularExam.ascx" TagName="CardiovascularExam" TagPrefix="uc12" %>
<%@ Register Src="../EMR/AbdominalExam.ascx" TagName="AbdominalExam" TagPrefix="uc13" %>
<%@ Register Src="../EMR/History.ascx" TagName="History" TagPrefix="uc15" %>
<%@ Register Src="../EMR/Diagnostics.ascx" TagName="Diagnosticsl" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
<%@ Register Src="InvestigationControl.ascx" TagName="InvestigationControl" TagPrefix="ucInv" %>
<%@ Register Src="AbnormalBleedingDisorders.ascx" TagName="AbnormalBleeding" TagPrefix="ucAbnormal" %>
<%@ Register Src="CardiacDiseases.ascx" TagName="CardiacDiseases" TagPrefix="ucCardiac" %>
<%@ Register Src="ChronicNephritis.ascx" TagName="ChronicNephtris" TagPrefix="ucChronic" %>
<%@ Register Src="CJD.ascx" TagName="CJD" TagPrefix="ucCJD" %>
<%@ Register Src="Drugs.ascx" TagName="Drugs" TagPrefix="ucDrugs" %>
<%@ Register Src="Epilepsy.ascx" TagName="Epilepsy" TagPrefix="ucEpilepsy" %>
<%@ Register Src="Leprosy.ascx" TagName="Leprosy" TagPrefix="ucLeprosy" %>
<%@ Register Src="PolycythemiaVera.ascx" TagName="PolycythemiaVera" TagPrefix="ucPolycythemiaVera" %>
<%@ Register Src="Schizophrenia.ascx" TagName="Schizophrenia" TagPrefix="ucSchizophrenia" %>
<%@ Register Src="SeroPositivity.ascx" TagName="SeroPositivity" TagPrefix="ucSeroPositivity" %>
<%@ Register Src="SexuallyTransmittedDiseases.ascx" TagName="SexuallyTransmitted"
    TagPrefix="ucSexuallyTransmitted" %>
<%@ Register Src="SickleCellAnamia.ascx" TagName="SickleCellAnamia" TagPrefix="ucSickleCellAnamia" %>
<%@ Register Src="TransplantationSurgery.ascx" TagName="TransplantationSurgery" TagPrefix="ucTransplantation" %>
<%@ Register Src="UnprotectedSex.ascx" TagName="UnprotectedSex" TagPrefix="ucUnprotected" %>
<%@ Register Src="HumanPituitaryHormone.ascx" TagName="HumanPituitaryHormone" TagPrefix="ucHumanPituitaryHormone" %>
<%@ Register Src="Asthma.ascx" TagName="Asthma" TagPrefix="ucAsthma" %>
<%@ Register Src="Endocrinedisorders.ascx" TagName="Endocrinedisorders" TagPrefix="ucEndocrinedisorders" %>
<%@ Register Src="Dementia.ascx" TagName="Dementia" TagPrefix="ucDementia" %>
<%@ Register Src="Filariasis.ascx" TagName="Filariasis " TagPrefix="ucFilariasis" %>
<%@ Register Src="Gout.ascx" TagName="Gout" TagPrefix="ucGout" %>
<%@ Register Src="ProstrateEnlargement.ascx" TagName="ProstrateEnlargement" TagPrefix="ucProstrateEnlargement" %>
<%@ Register Src="Cancer.ascx" TagName="Cancer" TagPrefix="ucCancer" %>
<%@ Register Src="LungDiseases.ascx" TagName="LungDiseases" TagPrefix="ucLungDiseases" %>
<%@ Register Src="GynecologicalAndObstetric.ascx" TagName="Gynacology" TagPrefix="ucGynacology" %>
<%@ Register Src="AlcoholConsumption.ascx" TagName="AlcoholConsumption" TagPrefix="ucAlcohol" %>
<%@ Register Src="ChickenPox.ascx" TagName="ChickenPox" TagPrefix="ucChickenPox" %>
<%@ Register Src="DengueFever.ascx" TagName="DengueFever" TagPrefix="ucDengue" %>
<%@ Register Src="SymptomaticOrAsymptomatic.ascx" TagName="Symptomatic" TagPrefix="ucSymptomatic" %>
<%@ Register Src="Acupuncture.ascx" TagName="Acupuncture" TagPrefix="ucAcupuncture" %>
<%@ Register Src="BloodTransfusion.ascx" TagName="BloodTransfusion" TagPrefix="ucBloodTransfusion" %>
<%@ Register Src="Bonegrafting.ascx" TagName="Bonegrafting" TagPrefix="ucBonegrafting" %>
<%@ Register Src="Childbirth.ascx" TagName="Childbirth" TagPrefix="ucChildbirth" %>
<%@ Register Src="Cocaineintake.ascx" TagName="Cocaineintake" TagPrefix="ucCocaineintake" %>
<%@ Register Src="Malaria.ascx" TagName="Malaria" TagPrefix="ucMalaria" %>
<%@ Register Src="OrganTransplant.ascx" TagName="OrganTransplant" TagPrefix="ucOrganTransplant" %>
<%@ Register Src="PepticUlcerDisease.ascx" TagName="PepticUlcerDisease" TagPrefix="ucPepticUlcerDisease" %>
<%@ Register Src="Skingrafting.ascx" TagName="Skingrafting" TagPrefix="ucSkingrafting" %>
<%@ Register Src="SkinPiercingActivity.ascx" TagName="SkinPiercingActivity" TagPrefix="ucSkinPiercingActivity" %>
<%@ Register Src="Syphilis.ascx" TagName="Syphilis" TagPrefix="ucSyphilis" %>
<%@ Register Src="Typhoid.ascx" TagName="Typhoid" TagPrefix="ucTyphoid" %>
<%@ Register Src="Gonorrhoea.ascx" TagName="Gonorrhoea" TagPrefix="ucGonorrhoea" %>
<%@ Register Src="ParasiticInfections.ascx" TagName="ParasiticInfections" TagPrefix="ucParasiticInfections" %>
<%@ Register Src="Stroke.ascx" TagName="Stroke" TagPrefix="ucStroke" %>
<%@ Register Src="DentalExtraction.ascx" TagName="DentalExtraction" TagPrefix="ucDentalExtraction" %>
<%@ Register Src="BloodDonation.ascx" TagName="BloodDontaion" TagPrefix="ucBloodDontaion" %>
<%@ Register Src="VaccinationHistory.ascx" TagName="VaccinationHistory" TagPrefix="ucVaccination" %>
<%@ Register Src="TravelHistory.ascx" TagName="TravelHistory" TagPrefix="ucTravelHistory" %>
<%@ Register Src="SmallPox.ascx" TagName="SmallPox" TagPrefix="ucSmallPox" %>
<%@ Register Src="NeedleStickInjury.ascx" TagName="NeedleStickInjury" TagPrefix="ucNeedleStickInjury" %>
<%@ Register Src="TravelToMalarialPlace.ascx" TagName="TravelToMalarialPlace" TagPrefix="ucTravelToMalarialPlace" %>
<%@ Register Src="LivedWithHepatitisPerson.ascx" TagName="LivedWithHepatitisPerson"
    TagPrefix="ucLivedWithHepatitisPerson" %>
<%@ Register Src="UnprotectedIntercourse.ascx" TagName="UnprotectedIntercourse" TagPrefix="ucUnprotectedIntercourse" %>
<%@ Register Src="JailOrPrison.ascx" TagName="JailOrPrison" TagPrefix="ucJailOrPrison" %>
<%@ Register Src="MinorSurgery.ascx" TagName="MinorSurgery" TagPrefix="ucMinorSurgery" %>
<%@ Register Src="MajorSurgery.ascx" TagName="MajorSurgery" TagPrefix="ucMajorSurgery" %>
<%@ Register Src="../BloodBank/InvestigationControl.ascx" TagName="InvestigationControl" TagPrefix="ucInvCtrl" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>
<script type ="text/javascript"  language ="javascript" >
var slist={FAIL:'<%=Resources.ClientSideDisplayTexts.CommonControls_DynamicUserControl_Fail %>',PASS:'<%=Resources.ClientSideDisplayTexts.CommonControls_DynamicUserControl_PASS %>',Completed:'<%=Resources.ClientSideDisplayTexts.CommonControls_DynamicUserControl_Completed %>'};
</script>

<script type="text/javascript">
function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else 
            {
            alert('History saved successfully.');
            return false;
            }
           return true;
        }

        function maxWidth(id) {
            var maxlength = 0;
            var curlength = 0;
            var mySelect = document.getElementById(id);
            for (var i = 0; i < mySelect.options.length; i++) {
                if (mySelect[i].text.length > maxlength) {
                    maxlength = mySelect[i].text.length;
                }
            }
            mySelect.style.width = maxlength * 7;
        }
        function restoreWidth(id) {
            var mySelect = document.getElementById(id);
            mySelect.style.width = "100px";
        }
        
</script>

<script language="javascript" type="text/javascript">
        function showContentHis(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var items;
            var cnt=0;
            if(document.getElementById('ucDynamic_divHistory1').style.display=='block')
            {
                items=document.getElementById('ucDynamic_hdnStatusCount').value.split('~');
                if(ddl[2]=='rdoYes')
                { 
                  var divid = ddl[0] + '_' + ddl[1] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
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
                          document.getElementById('ucDynamic_hdnStatusCount').value=document.getElementById('ucDynamic_hdnStatusCount').value+ddl[1]+'~';
                     }
                  }
                }
                else
                {
                   var divid= ddl[0] + '_' + ddl[1] +'_div' + 'rdoYes_' + ddl[ddl.length - 1];
                   document.getElementById(divid).style.display ='none';
                   if(items.length>0)
                   {
                      document.getElementById('ucDynamic_hdnStatusCount').value='';
                      for(var i=0;i<items.length;i++)
                      {
                         if(items[i]!=ddl[1] && items[i]!='')
                           document.getElementById('ucDynamic_hdnStatusCount').value=document.getElementById('ucDynamic_hdnStatusCount').value+items[i]+'~';
                      }
                   }
                }
                if(document.getElementById('ucDynamic_hdnStatusCount').value!='')
                {
                  document.getElementById('ucDynamic_lblEligibilityResult').textContent=slist.FAIL;
                  document.getElementById('ucDynamic_hdnPS1').value='N';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.color='Red';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.fontWeight='bold';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.fontSize='small';
                }
                else{
                  document.getElementById('ucDynamic_lblEligibilityResult').innerHTML=slist.PASS;
                  document.getElementById('ucDynamic_hdnPS1').value='Y';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.color='DarkGreen';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.fontWeight='bold';
                  document.getElementById('ucDynamic_lblEligibilityResult').style.fontSize='small';
                }
           }
           
           if(document.getElementById('ucDynamic_divHistory2').style.display=='block')
            {
                items=document.getElementById('ucDynamic_hdnTempStatusCount').value.split('~');
                if(ddl[2]=='rdoYes')
                { 
                  var divid = ddl[0] + '_' + ddl[1] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
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
                          document.getElementById('ucDynamic_hdnTempStatusCount').value=document.getElementById('ucDynamic_hdnTempStatusCount').value+ddl[1]+'~';
                     }
                  }
                }
                else
                {
                   var divid= ddl[0] + '_' + ddl[1] +'_div' + 'rdoYes_' + ddl[ddl.length - 1];
                   document.getElementById(divid).style.display ='none';
                   if(items.length>0)
                   {
                      document.getElementById('ucDynamic_hdnTempStatusCount').value='';
                      for(var i=0;i<items.length;i++)
                      {
                         if(items[i]!=ddl[1] && items[i]!='')
                           document.getElementById('ucDynamic_hdnTempStatusCount').value=document.getElementById('ucDynamic_hdnTempStatusCount').value+items[i]+'~';
                      }
                   }
                }
                if(document.getElementById('ucDynamic_hdnTempStatusCount').value!='')
                {
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').innerHTML=slist.FAIL;
                  document.getElementById('ucDynamic_hdnTS1').value='N';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.color='Red';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.fontWeight='bold';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.fontSize='small';
                }
                else{
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').innerHTML=slist.PASS;
                  document.getElementById('ucDynamic_hdnTS1').value='Y';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.color='DarkGreen';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.fontWeight='bold';
                  document.getElementById('ucDynamic_lblTemporaryStatusResult').style.fontSize='small';
                }
           }
        }
        function showContentHisExam(id) {
            var chkvalue = id;
            var ddl = id.split('_'); 
            var divYesid = ddl[0] +'_div' + 'rdoYes' + '_' + ddl[ddl.length - 1];
            var divNoid = ddl[0] +'_div' + 'rdoNo' + '_' + ddl[ddl.length - 1];
            var divid = ddl[0] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
            var items=document.getElementById('ucDynamic_hdnExamStatusCount').value.split('~');
            var cnt=0;
            if(ddl[1]=='rdoNo')
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
                      document.getElementById('ucDynamic_hdnExamStatusCount').value=document.getElementById('ucDynamic_hdnExamStatusCount').value+ddl[ddl.length-1]+'~';
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
                document.getElementById('ucDynamic_hdnExamStatusCount').value='';
                for(var i=0;i<items.length;i++)
                {
                   if(items[i]!=ddl[ddl.length - 1] && items[i]!='')
                     document.getElementById('ucDynamic_hdnExamStatusCount').value=document.getElementById('ucDynamic_hdnExamStatusCount').value+items[i]+'~';
                }
              }
            }
            if(document.getElementById('ucDynamic_hdnExamStatusCount').value!='')
            {
              document.getElementById('ucDynamic_lblExaminationStatusResult').innerHTML=slist.FAIL;
              document.getElementById('ucDynamic_hdnES1').value='N';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.color='Red';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.fontWeight='bold';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.fontSize='small';
            }
            else{
              document.getElementById('ucDynamic_lblExaminationStatusResult').innerHTML=slist.PASS;
              document.getElementById('ucDynamic_hdnES1').value='Y';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.color='DarkGreen';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.fontWeight='bold';
              document.getElementById('ucDynamic_lblExaminationStatusResult').style.fontSize='small';
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
           document.getElementById('ucDynamic_lblInvestigationStatus').innerHTML=slist.Completed;
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
           if(document.getElementById('ucDynamic_lblEligibilityResult').innerHTML==slist.FAIL)
           {
             var i= confirm('The eligibility status is FAIL. Do u still want to continue');
             if(i)
             {
               document.getElementById('ucDynamic_divHistory1').style.display="none";
               document.getElementById('ucDynamic_divHistory2').style.display="block";
               document.getElementById('ucDynamic_hdnPS2').value='Y';
               document.getElementById('ucDynamic_divSave').style.display="block";
             }
           }
           else{
             document.getElementById('ucDynamic_divHistory1').style.display="none";
             
             document.getElementById('ucDynamic_divHistory2').style.display="block";
             document.getElementById('ucDynamic_hdnPS2').value='Y';
             document.getElementById('ucDynamic_divSave').style.display="block";
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
           document.getElementById('ucDynamic_divHistory2').style.display="none";
           document.getElementById('ucDynamic_divHistory1').style.display="block";
           document.getElementById('ucDynamic_divSave').style.display="none";
        }
        function ExacerClick() {
        var obj = document.getElementById('ucDynamic_ucLungDiseases_chkExacerbations_18');
        document.getElementById('ucDynamic_ucLungDiseases_tdExacer').style.display = "none";
//        document.getElementById('ucDynamic_ucAsthma_tdExacerEMR').style.display = "none";
        if (obj.checked) {
            document.getElementById('ucDynamic_ucLungDiseases_tdExacer').style.display = "block";
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
        var HidVaccinationsValue = document.getElementById('ucDynamic_ucVaccination_HdnVaccination').value;
        var PriorList = HidVaccinationsValue.split('^');
        if (document.getElementById('ucDynamic_ucVaccination_HdnVaccination').value != "") {

            for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                var PriVacList = PriorList[pvCount].split('~');

                var rowV = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').insertRow(1);
                var icoutV = document.getElementById('ucDynamic_ucVaccination_tblPriorVaccinations').rows.length;
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
                document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').value = PriVacList[6];
                var reaction = '';  //document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text;
                document.getElementById('ucDynamic_ucVaccination_ddlAnaphylacticReaction').selectedIndex = 0;
                cell7.innerHTML = reaction;
                cell6.style.display = "none";
            }
        }
        return false;
    }
    function PriorVaccinationsItems() {
        var VaccinationStatus = 0;
        var HidVaccinationValue = document.getElementById('ucDynamic_ucVaccination_HdnVaccination').value;
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
        var userMsg = SListForApplicationMessages.Get('CommonControls\\DynamicUserControl.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Surgery Already Added!");
        }
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

<div class="dataheader2">
    <asp:UpdatePanel ID="upEMR" runat="server">
        <ContentTemplate>
            <div id="wrapper">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <%--<tr>
                                <td>
                                    <asp:Label ID="lblTextHistory" runat="server" Text="For Capturing History"></asp:Label>&nbsp;<asp:LinkButton
                                        ID="History" CssClass="defaultfontcolor" runat="server" Text="Click Here" OnClick="History_Click"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTextExam" runat="server" Text="For Capturing Examination"></asp:Label>&nbsp;<asp:LinkButton
                                        ID="Examination" CssClass="defaultfontcolor" runat="server" Text="Click Here"
                                        OnClick="Examination_Click"></asp:LinkButton>
                                </td>
                            </tr>--%><%--<tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>--%>
                    <%--<tr>
                        <td align="Right">
                            <asp:Button ID="btnSaveTop" Text="Save" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                onmouseout="this.className='btn1'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                            <%-- <asp:Button ID="btnEditPatientReg" Text="Edit Patient Details" runat="server" 
                                    CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" onclick="btnEditPatientReg_Click" />--%>
                    <%--</td>
                    </tr>--%>
                    <tr>
                        <td>
                            <asp:Label ID="lblHistory" Text="History" runat="server"></asp:Label><br />
                            <asp:Label ID="lblHistoryStatus" Text="Pending" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnHistory" ImageUrl="~/images/next.png" ToolTip="Go to Examination" runat="server"
                              CausesValidation="False" meta:resourcekey="btnHistoryResource1" OnClick="btnExam_Click" />
                            <asp:ImageButton ID="btnHistory1" ImageUrl="~/images/previous.png" ToolTip="Back to History" runat="server" style="display:none"
                               CausesValidation="False" meta:resourcekey="btnHistory1Resource1"  OnClick="btnHistory_Click"/>
                        </td>
                        <td>
                            <asp:Label ID="lblExamination" Text="Examination" runat="server"></asp:Label><br />
                            <asp:Label ID="lblExamStatus" Text="Pending" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnOrderInv" runat="server" ImageUrl="~/images/next.png"
                                    ToolTip ="Go to Order Investigation" CausesValidation="False" meta:resourcekey="btnOrderInvResource1" OnClick="btnOrderInv_Click"  />
                            <asp:ImageButton ID="btnExam" runat="server" ImageUrl="~/images/previous.png" style="display:none"
                                    ToolTip ="Back to Examination" CausesValidation="False" meta:resourcekey="btnExamResource1" OnClick="btnExam_Click" />
                           <%-- <asp:Button ID="btnDiagnostics" Text="Diagnostics" runat="server" CssClass="btn1"
                                Font-Size="Small" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                OnClick="btnDiagnostics_Click" />--%>
                            <%--<asp:Button ID="btnOrderInv" Text="===>" ToolTip="Go to Order Investigation" runat="server" Font-Size="Small"
                                OnClick="btnOrderInv_Click" />--%>
                        </td>
                        <td>
                            <asp:Label ID="lblInvestigation" Text="Order Investigation" runat="server"></asp:Label><br />
                            <asp:Label ID="lblInvestigationStatus" Text="Pending" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                      <td colspan="5">
                            <table width="100%" class="dataheaderInvCtrl" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <div id="divHistory1" style="display: block;" runat="server">
                                            <%--<div id="divRef1" onclick="showResponses('divRef1','divRef2','divRef3',1);"
                                    style="cursor: pointer; display: block;" runat="server">
                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                    <asp:Label ID="Rs_ReferringPhysician" Text="Medical History" Font-Bold="True" runat="server" />
                                </div>
                                <div id="divRef2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divRef1','divRef2','divRef3',0);"
                                    runat="server">
                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                    <asp:Label ID="Rs_ReferringPhysician1" Text="Medical History" Font-Bold="True" runat="server" />
                                </div>
                                <div id="divRef3" style="display: none; width: 100%" title="Medical History">--%>
                                            <div id="divMedicalHistory1" onclick="showResponses('ucDynamic_divMedicalHistory1','ucDynamic_divMedicalHistory2','ucDynamic_divMedicalHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label13" Text="Medical History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divMedicalHistory2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divMedicalHistory1','ucDynamic_divMedicalHistory2','ucDynamic_divMedicalHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label14" Text="Medical History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divMedicalHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblMedicalHistory" Visible="false" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <%--<div id="divFamilyHistory1" onclick="showResponses('ucDynamic_divFamilyHistory1','ucDynamic_divFamilyHistory2','ucDynamic_divFamilyHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label1" Text="Family History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divFamilyHistory2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('ucDynamic_divFamilyHistory1','ucDynamic_divFamilyHistory2','ucDynamic_divFamilyHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label2" Text="Family History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divFamilyHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblFamilyHistory" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divSurgicalHistory1" onclick="showResponses('ucDynamic_divSurgicalHistory1','ucDynamic_divSurgicalHistory2','ucDynamic_divSurgicalHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label3" Text="Surgical History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divSurgicalHistory2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('ucDynamic_divSurgicalHistory1','ucDynamic_divSurgicalHistory2','ucDynamic_divSurgicalHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label4" Text="Surgical History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divSurgicalHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblSurgicalHistory" Visible="false" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divSocialHistory1" onclick="showResponses('ucDynamic_divSocialHistory1','ucDynamic_divSocialHistory2','ucDynamic_divSocialHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label5" Text="Social History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divSocialHistory2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('ucDynamic_divSocialHistory1','ucDynamic_divSocialHistory2','ucDynamic_divSocialHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label6" Text="Social History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divSocialHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblSocialHistory" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPersonalHistory1" onclick="showResponses('ucDynamic_divPersonalHistory1','ucDynamic_divPersonalHistory2','ucDynamic_divPersonalHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label7" Text="Personal History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPersonalHistory2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('ucDynamic_divPersonalHistory1','ucDynamic_divPersonalHistory2','ucDynamic_divPersonalHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label8" Text="Personal History" Font-Bold="True" ForeColor="Blue" Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPersonalHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblPersonalHistory" Visible="false" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>--%>
                                            <div id="divTreatmentHistory1" onclick="showResponses('ucDynamic_divTreatmentHistory1','ucDynamic_divTreatmentHistory2','ucDynamic_divTreatmentHistory',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label9" Text="Treatment History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divTreatmentHistory2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divTreatmentHistory1','ucDynamic_divTreatmentHistory2','ucDynamic_divTreatmentHistory',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label10" Text="Treatment History" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divTreatmentHistory" runat="server" style="display: none;">
                                                <asp:Table ID="tblTreatmentHistory" Visible="false" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <asp:Table ID="drawNewHistory" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                Width="100%" class="dataheaderInvCtrl">
                                            </asp:Table>
                                            <table border="1" width="50%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblEligibility" runat="server" Font-Bold="true" Text="Eligibility status ::"></asp:Label>
                                                        <asp:Label ID="lblEligibilityResult" Text="PASS" Font-Bold="true" ForeColor="Green" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnProceed" runat="server" Text="Proceed to Phase-II screeing" OnClientClick="Javascript:showphase2(); return false;" />
                                                        <asp:Button ID="btnExclusion" runat="server" Text="Exclude from blood donation" OnClick="btnExclusion_Click" />
                                                        <asp:Button ID="btnCancel1" Text="Exit" runat="server" OnClientClick="javascript:if(!Checkforsave()) return false;"
                                                         OnClick="btnCancel1_Click" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divHistory2" style="display: none;" runat="server">
                                            <div id="divToday1" onclick="showResponses('ucDynamic_divToday1','ucDynamic_divToday2','ucDynamic_divToday',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label11" Text="Today" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divToday2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('ucDynamic_divToday1','ucDynamic_divToday2','ucDynamic_divToday',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label12" Text="Today" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divToday" runat="server" style="display: none;">
                                                <asp:Table ID="tblToday" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast1to3days1" onclick="showResponses('ucDynamic_divPast1to3days1','ucDynamic_divPast1to3days2','ucDynamic_divPast1to3days',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label15" Text="Past 1 to 3 days" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPast1to3days2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast1to3days1','ucDynamic_divPast1to3days2','ucDynamic_divPast1to3days',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label16" Text="Past 1 to 3 days" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPast1to3days" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast1to3days" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast6weeks1" onclick="showResponses('ucDynamic_divPast6weeks1','ucDynamic_divPast6weeks2','ucDynamic_divPast6weeks',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label17" Text="Past 6 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast6weeks2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast6weeks1','ucDynamic_divPast6weeks2','ucDynamic_divPast6weeks',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label18" Text="Past 6 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast6weeks" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast6weeks" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast8weeks1" onclick="showResponses('ucDynamic_divPast8weeks1','ucDynamic_divPast8weeks2','ucDynamic_divPast8weeks',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label19" Text="Past 8 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast8weeks2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast8weeks1','ucDynamic_divPast8weeks2','ucDynamic_divPast8weeks',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label20" Text="Past 8 weeks" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast8weeks" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast8weeks" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast3months1" onclick="showResponses('ucDynamic_divPast3months1','ucDynamic_divPast3months2','ucDynamic_divPast3months',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label21" Text="Past 3 months" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast3months2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast3months1','ucDynamic_divPast3months2','ucDynamic_divPast3months',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label22" Text="Past 3 months" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast3months" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast3months" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast6mnthsto1year1" onclick="showResponses('ucDynamic_divPast6mnthsto1year1','ucDynamic_divPast6mnthsto1year2','ucDynamic_divPast6mnthsto1year',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label23" Text="Past 6 months to 1 year" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPast6mnthsto1year2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast6mnthsto1year1','ucDynamic_divPast6mnthsto1year2','ucDynamic_divPast6mnthsto1year',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label24" Text="Past 6 months to 1 year" Font-Bold="True" ForeColor="Black"
                                                    Font-Size="Small" runat="server" />
                                            </div>
                                            <div id="divPast6mnthsto1year" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast6mnthsto1year" Visible="false" runat="server" CellPadding="0"
                                                    CellSpacing="0" Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast1year1" onclick="showResponses('ucDynamic_divPast1year1','ucDynamic_divPast1year2','ucDynamic_divPast1year',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label25" Text="Past 1 year" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast1year2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast1year1','ucDynamic_divPast1year2','ucDynamic_divPast1year',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label26" Text="Past 1 year" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast1year" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast1year" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <div id="divPast3years1" onclick="showResponses('ucDynamic_divPast3years1','ucDynamic_divPast3years2','ucDynamic_divPast3years',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" />
                                                <asp:Label ID="Label27" Text="Past 3 years" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast3years2" style="cursor: pointer; display: none; cursor: pointer;"
                                                onclick="showResponses('ucDynamic_divPast3years1','ucDynamic_divPast3years2','ucDynamic_divPast3years',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
                                                <asp:Label ID="Label28" Text="Past 3 years" Font-Bold="True" ForeColor="Black" Font-Size="Small"
                                                    runat="server" />
                                            </div>
                                            <div id="divPast3years" runat="server" style="display: none;">
                                                <asp:Table ID="tblPast3years" Visible="false" runat="server" CellPadding="0" CellSpacing="0"
                                                    Width="100%" class="dataheaderInvCtrl">
                                                </asp:Table>
                                            </div>
                                            <table border="1" width="50%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblTemporaryStatus" runat="server" Font-Bold="true" Text="Eligibility status ::"></asp:Label>
                                                        <asp:Label ID="lblTemporaryStatusResult" Text="PASS" Font-Bold="true" ForeColor="Green" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnProceedto1" runat="server" Text="Back to Phase-I screeing" OnClientClick="Javascript:showphase1(); return false;" />
                                                        <asp:Button ID="btnTemporaryExclusion" runat="server" Text="Temporarily exclude from blood donation" OnClick="btnTemporaryExclusion_Click"/>
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
                                    <tr>
                                        <td>
                                            <ucVitals:PatientVitals ID="PatientVitalsControl" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblCardio_vascular" runat="server" Text="CardioVascular System"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_vascular" Text="Normal" runat="server" GroupName="radioCardio"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                            <asp:RadioButton ID="rdoNo_vascular" Text="Abnormal" runat="server" GroupName="radioCardio"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_vascular" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_vascular" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_vascular" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_vascular" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblRespiratory" runat="server" Text="Respiratory System"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Respiratory" Text="Normal" runat="server" GroupName="radioRespiratory"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                            <asp:RadioButton ID="rdoNo_Respiratory" Text="Abnormal" runat="server" GroupName="radioRespiratory"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Respiratory" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Respiratory" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Respiratory" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Respiratory" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblAbdominal" runat="server" Text="Abdominal System"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Abdominal" Text="Normal" runat="server" GroupName="radioAbdominal"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                            <asp:RadioButton ID="rdoNo_Abdominal" Text="Abnormal" runat="server" GroupName="radioAbdominal"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Abdominal" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Abdominal" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Abdominal" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Abdominal" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblNeurological" runat="server" Text="Neurological System"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Neurological" Text="Normal" runat="server" GroupName="radioNeurological"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                            <asp:RadioButton ID="rdoNo_Neurological" Text="Abnormal" runat="server" GroupName="radioNeurological"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divrdoYes_Neurological" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Neurological" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divrdoNo_Neurological" runat="server" style="display: none">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoNo_Neurological" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Label ID="lblOtherFindings" runat="server" Text="Other Findings"></asp:Label>
                                        </td>
                                        <%--<td align="left" colspan="1">
                                            <asp:RadioButton ID="rdoYes_Other" Text="Yes" runat="server" GroupName="radioNeurological"
                                                onclick="javascript:showContentHisExam(this.id);" />
                                            <asp:RadioButton ID="rdoNo_Other" Text="No" runat="server" GroupName="radioNeurological" />
                                        </td>--%>
                                  <%--  </tr>
                                    <tr>--%>
                                        <td>
                                            <div id="divrdoYes_Other" runat="server">
                                                <table cellpadding="0" align="right" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrdoYes_Other" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblExaminationStatus" Text="Eligibility Status :: " runat="server" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="lblExaminationStatusResult" Text="PASS" Font-Bold="true" ForeColor="Green" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><asp:Button ID="btnExamExclude" Text="Exclude" runat="server" OnClick="btnExamExclude_Click"/></td> 
                                    </tr>
                                </table>
                            </div>
                            <asp:HiddenField ID="hdnControl" Value="" runat="server" />
                            <div id="divHistory" style="display: none;" runat="server">
                                <asp:Panel ID="pnlDisplay" runat="server">
                                </asp:Panel>
                                <asp:Panel ID="pnlHis" runat="server">
                                </asp:Panel>
                                <%--<uc15:History ID="History1" runat="server" />--%>
                            </div>
                            <div id="divInvestigation" style="display:none" runat="server">
                              <ucInvCtrl:InvestigationControl ID="ucInvCtrl" runat="server" />
                            </div>
                            <%--<div id="divExam" style="display:none;" runat ="server">
                                    <ucVitals:PatientVitals ID="PatientVitalsControl" runat="server" />
                                    <ucSkin:Skin ID="ucSkin" runat="server" />
                                    <ucHair:Hair ID="ucHair" runat="server" />
                                    <ucNails:Nails ID="ucNails" runat="server" />
                                    <ucScars:Scars ID="ucScars" runat="server" />
                                    <ucEye:Eye ID="ucEye" runat="server" />
                                    <ucEar:Ear ID="ucEar" runat="server" />
                                    <uc7:OralCavity ID="OralCavity1" runat="server" />
                                    <ucNeck:Neck ID="ucNeck" runat="server" />
                                    <uc12:CardiovascularExam ID="CardiovascularExam1" runat="server" />
                                    <ucRS:RS ID="ucRS" runat="server" />
                                    <uc13:AbdominalExam ID="AbdominalExam1" runat="server" />
                                    <uc10:GynaecologicalExam ID="GynaecologicalExam1" Visible="False" runat="server" />
                                    <uc11:RectalExamination ID="RectalExamination1" runat="server" />
                                    <uc8:NeurologicaExamination ID="NeurologicaExamination1" runat="server" />
                                    <ucFoot:Foot ID="ucFoot" runat="server" />
                                </div>
                                <div id ="divDiagnostics" style="display:none;" runat ="server" >
                                    <uc2:Diagnosticsl ID="Diagnosticsl1" runat="server" />
                                </div>
                                <div id="divOrderInv" style="display:none;" runat ="server">
                                    <ucInv:InvestigationControl ID="InvestigationControl1" runat="server" />
                                </div>--%>
                            <asp:HiddenField runat="server" ID="hdnSex" />
                            <asp:HiddenField runat="server" ID="hdnHistory" />
                            <asp:HiddenField runat="server" ID="hdnButton" />
                            <asp:HiddenField runat="server" ID="hdnHistoryControl" />
                            <asp:HiddenField runat="server" ID="hdnComplaintControl" />
                            <asp:HiddenField runat="server" Value="" ID="hdnStatusCount" />
                            <asp:HiddenField runat="server" Value="" ID="hdnTempStatusCount" />
                            <asp:HiddenField runat="server" Value="" ID="hdnExamStatusCount" />
                            <%--<asp:UpdatePanel ID="upTabControl" runat="server">
                                        <ContentTemplate>
                                            <ajc:TabContainer ID="tcEMR" runat="server" style="height:auto;overflow:auto;" ActiveTabIndex="1" Width="100%"
                                                meta:resourcekey="tcEMRResource1">
                                                <ajc:TabPanel ID="tpHistory" runat="server" HeaderText="Enter History" meta:resourcekey="tpHistoryResource1">
                                                    <ContentTemplate>
                                                        <div id="divCapHis" style="height:auto;overflow:auto;">
                                                            <uc15:History ID="ucHistory" runat="server" />
                                                        </div>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel runat="server" ID="tpExamination" HeaderText="Enter Examination" meta:resourcekey="tpExaminationResource1">
                                                    <ContentTemplate>
                                                        <div id="divCapExam" style="height:auto;overflow:auto;">
                                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                <ProgressTemplate>
                                                                    <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                                        Width="50px" meta:resourcekey="Img1Resource1" />Please Wait...
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
                                                            <asp:HiddenField runat="server" ID="hdnSex" />
                                                            <ucVitals:PatientVitals ID="PatientVitalsControl" runat="server" />
                                                            <asp:Table ID="drawNewPattern" BorderWidth="0px" runat="server" Width="100%" meta:resourcekey="drawNewPatternResource1">
                                                            </asp:Table>
                                                            <ucSkin:Skin ID="ucSkin" runat="server" />
                                                            <ucHair:Hair ID="ucHair" runat="server" />
                                                            <ucNails:Nails ID="ucNails" runat="server" />
                                                            <ucScars:Scars ID="ucScars" runat="server" />
                                                            <ucEye:Eye ID="ucEye" runat="server" />
                                                            <ucEar:Ear ID="ucEar" runat="server" />
                                                            <uc7:OralCavity ID="OralCavity1" runat="server" />
                                                            <ucNeck:Neck ID="ucNeck" runat="server" />
                                                            <uc12:CardiovascularExam ID="CardiovascularExam1" runat="server" />
                                                            <ucRS:RS ID="ucRS" runat="server" />
                                                            <uc13:AbdominalExam ID="AbdominalExam1" runat="server" />
                                                            <uc10:GynaecologicalExam ID="GynaecologicalExam1" Visible="False" runat="server" />
                                                            <uc11:RectalExamination ID="RectalExamination1" runat="server" />
                                                            <uc8:NeurologicaExamination ID="NeurologicaExamination1" runat="server" />
                                                            <ucFoot:Foot ID="ucFoot" runat="server" />
                                                        </div>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tbDiagnostics" runat="server" HeaderText="Enter Diagnostics" meta:resourcekey="tbDiagnosticsResource1">
                                                    <ContentTemplate>
                                                        <div id="div1" style="height:auto;overflow:auto;">
                                                            <uc2:Diagnosticsl ID="Diagnosticsl1" runat="server" />
                                                        </div>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tbOrderInv" runat="server" HeaderText="Order Investigation" meta:resourcekey="tbOrderInvResource1">
                                                    <ContentTemplate>
                                                        <ucInv:InvestigationControl ID="InvestigationControl1" runat="server" />
                                                        </div>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                            </ajc:TabContainer>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="tcEMR" EventName="ActiveTabChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>--%>
                            <%--<tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>--%>
                            <tr>
                                <td align="left">
                                  <div id="divSave" runat="server">
                                    <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="btnCancel" Text="Exit" runat="server" OnClientClick="javascript:if(!Checkforsave()) return false;"
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
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnPS1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnPS2" Value=" " runat="server" />
    <asp:HiddenField ID="hdnTS1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnTS2" Value=" " runat="server" />
    <asp:HiddenField ID="hdnES1" Value=" " runat="server" />
    <asp:HiddenField ID="hdnES2" Value=" " runat="server" />
</div>
