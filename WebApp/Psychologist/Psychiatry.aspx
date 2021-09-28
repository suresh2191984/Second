<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Psychiatry.aspx.cs" Inherits="Psychologist_Psychiatry" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../EMR/History.ascx" TagName="History" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="ucPatHeader" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../EMR/History.ascx" TagName="History" TagPrefix="uc15" %>
<%@ Register Src="~/CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc17" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc18" %>
<%@ Register Src="../CommonControls/Miscellaneous.ascx" TagName="Miscellaneous" TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc22" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc23" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script language="javascript" type="text/javascript">
        
        function showContentHis(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'tcEMR_tpHistory_ucHistory_div' + ddl[3] + '_' + ddl[4];
            //alert(divid);
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block'
            }
            else {
                document.getElementById(divid).style.display = 'none';
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
        function showOthersBoxHis(ddl) {

            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
            var OID = ddl.split('_');


            var strDiv = 'tcEMR_tpHistory_ucHistory_div' + OID[3] + '_' + OID[4];


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

        function showCaseSheet(popurls) {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800,left=0,top=0";
            window.open(popurls, "", strFeatures);
        }

        function HideHistory() {
            var obj1 = document.getElementById('divAH3');
            var obj2 = document.getElementById('tcEMR_tpHistory_ucHistory_divAH1');
            var obj3 = document.getElementById('tcEMR_tpHistory_ucHistory_divAH2');

            var obj4 = document.getElementById('divOH3');
            var obj5 = document.getElementById('tcEMR_tpHistory_ucHistory_divOH1');
            var obj6 = document.getElementById('tcEMR_tpHistory_ucHistory_divOH2');

            var obj7 = document.getElementById('divGH3');
            var obj8 = document.getElementById('tcEMR_tpHistory_ucHistory_divGH1');
            var obj9 = document.getElementById('tcEMR_tpHistory_ucHistory_divGH2');

            var obj10 = document.getElementById('GrdResponse');
            var obj11 = document.getElementById('Grdplus');
            var obj12 = document.getElementById('Grdminus');

            obj4.style.display = 'none';
            obj5.style.display = 'none';
            obj6.style.display = 'none';

            obj7.style.display = 'none';
            obj8.style.display = 'none';
            obj9.style.display = 'none';
            obj10.style.display = 'none';
            obj11.style.display = 'block';
            obj12.style.display = 'none';

        }

        function loadreview(strreview) {
            var temp = strreview;
            var value, type;
            var temp1 = 0;
            var checkboxCollection = document.getElementById('tcEMR_tpReview_chkreview').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    var j = temp1;
                    value = strreview.split('^')[j].split('~')[1];
                    type = strreview.split('^')[j].split('~')[2];
                    if (type == 'Y') {
                        checkboxCollection[i].checked = true;
                    }
                    else {
                        checkboxCollection[i].checked = false;
                    }
                    var temp = checkboxCollection[i].id;
                    var t = temp.split('chkreview_')[1];
                    var str = "txt" + (Number(t) + Number(1)).toString();
                    document.getElementById(str).value = value;
                    temp1 = j + Number(1);
                }
            }
        }

        function Validate() {
            var e = document.getElementById("ddlCouselType");
            var strUser = e.options[e.selectedIndex].value;
            if (strUser == '---------------Select----------------') {
                alert("Please Select Counseling Type");
                return false;
            }

            var checkboxCollection = document.getElementById('tcEMR_tpReview_chkreview').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    if (checkboxCollection[i].checked == true) {
                        var temp = checkboxCollection[i].id;
                        var t = temp.split('chkreview_')[1];
                        var str = "txt" + (Number(t) + Number(1)).toString();
                        if (document.getElementById(str).value == '') {
                            alert('In Review of System,Textbox marked as Confidential but value not entered');
                            return false;
                        }
                    }
                }
            }

            var checkboxCollection = document.getElementById('tcEMR_tpReview_chkreview').getElementsByTagName('input');
            var confi;
            document.getElementById('hdnTextValue').value = '';
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    if (checkboxCollection[i].checked == true) {
                        confi = 'Y';
                    }
                    else {
                        confi = "N";
                    }
                    var temp = checkboxCollection[i].id;
                    var t = temp.split('chkreview_')[1];
                    var chkid = t.toString();
                    var str = "txt" + (Number(t) + Number(1)).toString();
                    var txt = document.getElementById(str).name;
                    document.getElementById('hdnTextValue').value += txt + '~' + document.getElementById(str).value + '~' + confi + '^';
                }
            }
            //Appeareance
            var app = document.getElementById('tcEMR_tpExamination_EchkAppearance');
            var appconfi;
            var posture, race, attitude, Ethnicity;
            posture = document.getElementById('tcEMR_tpExamination_txtPosture').value;
            race = document.getElementById('tcEMR_tpExamination_txtRace').value;
            attitude = document.getElementById('tcEMR_tpExamination_txtAttitude').value;
            Ethnicity = document.getElementById('tcEMR_tpExamination_txtEthnicity').value;
            if (app.checked == true) {
                if (posture == '' && race == '' && attitude == '' && Ethnicity == '') {
                    alert("The Appearance marked as Confidential but value is empty");
                    return false;
                }
            }

            if (app.checked == true) {
                appconfi = "Y";
            }
            else {
                appconfi = "N";
            }

            document.getElementById('hdnAppearance').value = appconfi + '~' + posture + '~' + race + '~' + attitude + '~' + Ethnicity + '^';
            //-------
            //Attitude
            var attitude = document.getElementById('tcEMR_tpExamination_EchkAttitude');
            var attitudeconfi;
            var attiExam;
            attiExam = document.getElementById('tcEMR_tpExamination_txtAttitudeE').value;
            if (attitude.checked == true) {
                if (attiExam == '') {
                    alert("The Attitude Marked as Confidential but Value is empty");
                    return false;
                }
            }
            if (attitude.checked == true) {
                attitudeconfi = "Y";
            }
            else {
                attitudeconfi = "N";
            }

            document.getElementById('hdnAttitude').value = attitudeconfi + '~' + attiExam + '^';
            //

            //Mood
            var mood = document.getElementById('tcEMR_tpExamination_EchkMood');
            var moodconfi;
            var moodExam;
            moodExam = document.getElementById('tcEMR_tpExamination_EtxtMood').value;
            if (mood.checked == true) {
                if (moodExam == '') {
                    alert("The Mood Marked as Confidential but Value is Empty");
                    return false;
                }
            }
            if (mood.checked == true) {
                moodconfi = "Y";
            }
            else {
                moodconfi = "N";
            }

            document.getElementById('hdnMood').value = moodconfi + '~' + moodExam + '^';
            //

            //Affect
            var Affect = document.getElementById('tcEMR_tpExamination_EchkAffect');
            var Affectconfi;
            var AffectExam;
            AffectExam = document.getElementById('tcEMR_tpExamination_EtxtAffect').value;
            if (Affect.checked == true) {
                if (AffectExam == '') {
                    alert("The Affect Marked as Confidential but Value is empty");
                    return false;
                }
            }
            if (Affect.checked == true) {
                Affectconfi = "Y";
            }
            else {
                Affectconfi = "N";
            }
            document.getElementById('hdnAffect').value = Affectconfi + '~' + AffectExam + '^';
            //

            //Speech
            var Speech = document.getElementById('tcEMR_tpExamination_EchkSpeech');
            var Speechconfi;
            var quality, rate, volume, coordination;
            quality = document.getElementById('tcEMR_tpExamination_txtQuality').value;
            rate = document.getElementById('tcEMR_tpExamination_txtRate').value;
            volume = document.getElementById('tcEMR_tpExamination_txtVolume').value;
            coordination = document.getElementById('tcEMR_tpExamination_txtCoOrdination').value;
            if (Speech.checked == true) {
                if (quality == '' && rate == '' && volume == '' && coordination == '') {
                    alert("Speech Marked as Confidential but values are empty");
                    return false;
                }
            }
            if (Speech.checked == true) {
                Speechconfi = "Y";
            }
            else {
                Speechconfi = "N";
            }
            document.getElementById('hdnSpeech').value = Speechconfi + '~' + quality + '~' + rate + '~' + volume + '~' + coordination + '^';
            //

            //Thought Process
            var ThProcess = document.getElementById('tcEMR_tpExamination_EchkThought');
            var ThProcessConfi;
            var ThProcessExam;
            ThProcessExam = document.getElementById('tcEMR_tpExamination_EtxtThought').value;
            if (ThProcess.checked == true) {
                if (ThProcessExam == '') {
                    alert("The Thought Process marked as Confidential but value is empty");
                    return false;
                }
            }
            if (ThProcess.checked == true) {
                ThProcessConfi = "Y";
            }
            else {
                ThProcessConfi = "N";
            }
            document.getElementById('hdnThProcess').value = ThProcessConfi + '~' + ThProcessExam + '^';
            //

            //Thought Content
            var ThContent = document.getElementById('tcEMR_tpExamination_EchkThoughtcontent');
            var ThContentConfi;
            var compultion, phobias, consci, orient, senso, suicidal, memory, abstractness;
            compultion = document.getElementById('tcEMR_tpExamination_txtObessions').value;
            phobias = document.getElementById('tcEMR_tpExamination_txtPhobias').value;
            consci = document.getElementById('tcEMR_tpExamination_txtConsciousness').value;
            orient = document.getElementById('tcEMR_tpExamination_txtOrientation').value;
            senso = document.getElementById('tcEMR_tpExamination_txtSensorium').value;
            suicidal = document.getElementById('tcEMR_tpExamination_txtSuicidal').value;
            memory = document.getElementById('tcEMR_tpExamination_txtMemory').value;
            abstractness = document.getElementById('tcEMR_tpExamination_txtAbstractness').value;
            if (ThContent.checked == true) {
                if (compultion == '' && phobias == '' && consci == '' && orient == '' && senso == '' && suicidal == '' && memory == '' && abstractness == '') {
                    alert("The Thought Content marked as confidential but value is empty");
                    return false;
                }
            }
            if (ThContent.checked == true) {
                ThContentConfi = "Y";
            }
            else {
                ThContentConfi = "N";
            }
            document.getElementById('hdnThContent').value = ThContentConfi + '~' + compultion + '~' + phobias + '~' + consci + '~' + orient + '~' + senso + '~' + suicidal + '~' + memory + '~' + abstractness + '^';
            //

            //Perceptual
            var Perceptual = document.getElementById('tcEMR_tpExamination_EchkPerceptual');
            var PerceptualConfi;
            var Hallucinations, Illusions;
            Hallucinations = document.getElementById('tcEMR_tpExamination_txtHallucinations').value;
            Illusions = document.getElementById('tcEMR_tpExamination_txtIllusions').value;
            if (Perceptual.checked == true) {
                if (Hallucinations == '' && Illusions == '') {
                    alert("Ther Perceptual marked as Confidential but value is empty");
                    return false;
                }
            }
            if (Perceptual.checked == true) {
                PerceptualConfi = "Y";
            }
            else {
                PerceptualConfi = "N";
            }
            document.getElementById('hdnPerceptual').value = PerceptualConfi + '~' + Hallucinations + '~' + Illusions + '^';
            //

            //Insight
            var Insight = document.getElementById('tcEMR_tpExamination_EchkInsight');
            var InsightConfi;
            var InsightExam;
            InsightExam = document.getElementById('tcEMR_tpExamination_EtxtInsight').value;
            if (Insight.checked == true) {
                if (InsightExam == '') {
                    alert("The Insight marked as confidential but value is empty");
                    return false;
                }
            }
            if (Insight.checked == true) {
                InsightConfi = "Y";
            }
            else {
                InsightConfi = "N";
            }
            document.getElementById('hdnInsight').value = InsightConfi + '~' + InsightExam + '^';
            //

            //Judgement
            var Judgement = document.getElementById('tcEMR_tpExamination_EchkJudgement');
            var JudgementConfi;
            var JudgementExam;
            JudgementExam = document.getElementById('tcEMR_tpExamination_EtxtJudgement').value;
            if (Judgement.checked == true) {
                if (JudgementExam == '') {
                    alert("The Judgement marked as Confidential but Value is empty");
                    return false;
                }
            }
            if (Judgement.checked == true) {
                JudgementConfi = "Y";
            }
            else {
                JudgementConfi = "N";
            }
            document.getElementById('hdnJudgement').value = JudgementConfi + '~' + JudgementExam + '^';
            //

            //Impilsivity
            var Impulsivity = document.getElementById('tcEMR_tpExamination_EchkImpulsivity');
            var ImpulsivityConfi;
            var ImpulsivityExam;
            ImpulsivityExam = document.getElementById('tcEMR_tpExamination_EtxtImpulsivity').value;
            if (Impulsivity.checked == true) {
                if (ImpulsivityExam == '') {
                    alert("The Impulsivity marked as confidential but value is empty");
                    return false;
                }
            }
            if (Impulsivity.checked == true) {
                ImpulsivityConfi = "Y";
            }
            else {
                ImpulsivityConfi = "N";
            }

            document.getElementById('hdnImpulsivity').value = ImpulsivityConfi + '~' + ImpulsivityExam + '^';
            //

            //Reliability
            var Reliability = document.getElementById('tcEMR_tpExamination_EchkReliability');
            var ReliabilityConfi;
            var ReliabilityExam;
            ReliabilityExam = document.getElementById('tcEMR_tpExamination_EtxtReliability').value;
            if (Reliability.checked == true) {
                if (ReliabilityExam == '') {
                    alert("The Reliability marked as Confidential but value is empty");
                    return false;
                }
            }
            if (Reliability.checked == true) {
                ReliabilityConfi = "Y";
            }
            else {
                ReliabilityConfi = "N";
            }
            document.getElementById('hdnReliability').value = ReliabilityConfi + '~' + ReliabilityExam + '^';
            //
        }
        function show() {
            var obj1 = document.getElementById('tdGo');
            obj1.style.display = 'block';
            showResponses('Grdplus', 'Grdminus', 'GrdResponse', 1);
        }

        function ViewGrid() {
            GrdResponse.style.display = 'block';
        }
        function HideGo() {
            var obj1 = document.getElementById('tdGo');
            obj1.style.display = 'none';
        }


        function checkReviewAll() {
            var checkboxCollection = document.getElementById('tcEMR_tpReview_chkreview').getElementsByTagName('input');
            if (document.form1.Rmaster.checked == true) {
                for (var i = 0; i < checkboxCollection.length; i++) {
                    if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                        checkboxCollection[i].checked = true;
                    }
                }
            }
            if (document.form1.Rmaster.checked == false) {
                for (var i = 0; i < checkboxCollection.length; i++) {
                    if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                        checkboxCollection[i].checked = false;
                    }
                }
            }
        }


        function EcheckAll() {
            var app = document.getElementById('tcEMR_tpExamination_EchkAppearance');
            var attitude = document.getElementById('tcEMR_tpExamination_EchkAttitude');
            var mood = document.getElementById('tcEMR_tpExamination_EchkMood');
            var Affect = document.getElementById('tcEMR_tpExamination_EchkAffect');
            var Speech = document.getElementById('tcEMR_tpExamination_EchkSpeech');
            var ThProcess = document.getElementById('tcEMR_tpExamination_EchkThought');
            var ThContent = document.getElementById('tcEMR_tpExamination_EchkThoughtcontent');
            var Perceptual = document.getElementById('tcEMR_tpExamination_EchkPerceptual');
            var Insight = document.getElementById('tcEMR_tpExamination_EchkInsight');
            var Judgement = document.getElementById('tcEMR_tpExamination_EchkJudgement');
            var Impulsivity = document.getElementById('tcEMR_tpExamination_EchkImpulsivity');
            var Reliability = document.getElementById('tcEMR_tpExamination_EchkReliability');
            if (document.form1.Emaster.checked == true) {
                app.checked = true;
                attitude.checked = true;
                mood.checked = true;
                Affect.checked = true;
                Speech.checked = true;
                ThProcess.checked = true;
                ThContent.checked = true;
                Perceptual.checked = true;
                Insight.checked = true;
                Judgement.checked = true;
                Impulsivity.checked = true;
                Reliability.checked = true;
            }
            else {
                app.checked = false;
                attitude.checked = false;
                mood.checked = false;
                Affect.checked = false;
                Speech.checked = false;
                ThProcess.checked = false;
                ThContent.checked = false;
                Perceptual.checked = false;
                Insight.checked = false;
                Judgement.checked = false;
                Impulsivity.checked = false;
                Reliability.checked = false;
            }
        }

        function CancelValidate() {
            var i;
            i = confirm('Are you sure want to Cancel');
            if (i == true) {
                return;
            }
            else {
                return false;
            }
        }

        function showQuitDet(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'tcEMR_tpHistory_ucHistory_td' + ddl[3] + '_' + ddl[4];
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }    
    </script>

</head>
<body onload="HideHistory();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
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
                <ucPatHeader:PatientHeader ID="patientHeader" runat="server" />
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
                                    <asp:Panel ID="pnl1" runat="server" CssClass="dataheader2" Style="width: 100%" BorderWidth="1px"
                                        meta:resourcekey="pnl1Resource1">
                                        <table width="100%">
                                            <tr>
                                                <td width="35%" align="right">
                                                    <asp:Label ID="lblCounselType" runat="server" Text="Select Counseling Type" meta:resourceKey="lblCounselTypeResource1"></asp:Label>
                                                </td>
                                                <td width="50%">
                                                    <asp:DropDownList ID="ddlCouselType" runat="server" CssClass="ddlsmall" Width="30%" meta:resourceKey="ddlCouselTypeResource1">
                                                    </asp:DropDownList>
                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table border="0" cellspacing="2" cellpadding="2" width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="PrevPnl" runat="server" CssClass="dataheader2" meta:resourcekey="PrevPnlResource1">
                                                    <div>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 100%">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td class="colorforcontent" width="100%" height="23" align="justify">
                                                                                <div style="display: block" id="Grdplus">
                                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Grdplus','Grdminus','GrdResponse',1); ViewGrid();" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Grdplus','Grdminus','GrdResponse',1); ViewGrid();">
                                                                                        <asp:Label ID="Label3" Text="Show Previous History" runat="server" meta:resourceKey="Label3Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div style="display: none" id="Grdminus">
                                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Grdplus','Grdminus','GrdResponse',0); HideGo();" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);HideGo();">
                                                                                        <asp:Label ID="Label4" Text="Hide Previous History" runat="server" meta:resourceKey="Label4Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div id="GrdResponse">
                                                                                    <asp:UpdatePanel ID="updpnl1" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:GridView ID="grdView" EmptyDataText="No Record Found" runat="server" AllowPaging="True"
                                                                                                CellPadding="1" AutoGenerateColumns="False" DataKeyNames="VisitID,VisitDate,CounselType,Symptoms"
                                                                                                Width="100%" ForeColor="Black" PageSize="5" CssClass="mytable1" BackColor="#DEBA84"
                                                                                                OnRowDataBound="grdView_RowDataBound" OnPageIndexChanging="grdView_PageIndexChanging"
                                                                                                CaptionAlign="Top" meta:resourceKey="grdViewResource1">
                                                                                                <PagerTemplate>
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td align="center" colspan="5">
                                                                                                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                                                    CommandName="Page" Height="10px" ImageUrl="~/Images/previousimage.png" meta:resourceKey="lnkPrevResource1"
                                                                                                                    Width="10px" />
                                                                                                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                                                    CommandName="Page" Height="10px" ImageUrl="~/Images/nextimage.png" meta:resourceKey="lnkNextResource1"
                                                                                                                    Width="10px" />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </PagerTemplate>
                                                                                                <Columns>
                                                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1" Visible="False">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lblVisitID" runat="server" 
                                                                                                                meta:resourcekey="lblVisitIDResource1" Text='<%# Bind("VisitID") %>'></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" 
                                                                                                        HeaderText="Visit Date" meta:resourceKey="BoundFieldResource2" />
                                                                                                    <asp:BoundField DataField="CounselType" HeaderText="Counseling Type" 
                                                                                                        meta:resourceKey="BoundFieldResource3" />
                                                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lbllink" runat="server" meta:resourcekey="lbllinkResource1" 
                                                                                                                Text='<%# Bind("Symptoms") %>'></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                                                                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                                                                <PagerSettings Mode="NextPrevious" />
                                                                                                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                                                                <RowStyle BackColor="#FFF7E7" BorderColor="#DEBA84" ForeColor="#8C4510" />
                                                                                                <SelectedRowStyle ForeColor="White" Font-Bold="True" BackColor="#738A9C"></SelectedRowStyle>
                                                                                            </asp:GridView>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="trGo">
                                                                            <td id="tdGo" align="center" style="display: none">
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="60%" style="vertical-align: top">
                                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <asp:Panel ID="pnlfckeditor" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlfckeditorResource1">
                                                                <div class="dataheader2">
                                                                    <table width="100%" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td class="colorforcontent" height="23" width="100%" align="left" colspan="2">
                                                                                <div style="display: none; width: 100%;" id="Fckplus1">
                                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);" />
                                                                                    <span class="dataheader1txt" style="width: 100%; cursor: pointer" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);">
                                                                                        <asp:Label ID="Label1" Text="Symptoms / Hisotry" runat="server" meta:resourceKey="Label1Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div style="display: block; width: 100%;" id="Fckminus2">
                                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);" />
                                                                                    <span class="dataheader1txt" style="width: 100%; cursor: pointer" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);">
                                                                                        <asp:Label ID="Label2" Text="Symptoms / History" runat="server" meta:resourceKey="Label2Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div id="Fckresponse" style="display: block;">
                                                                                    <FCKeditorV2:FCKeditor ID="fckCounselling" runat="server" Width="100%" Height="200px">
                                                                                    </FCKeditorV2:FCKeditor>
                                                                                    <asp:CheckBox ID="chkHistory" runat="server" Text="Check if confidential" 
                                                                                        meta:resourcekey="chkHistoryResource1" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="40%" style="vertical-align: top">
                                                <asp:Panel ID="pnlRec" runat="server" Width="328px" meta:resourcekey="pnlRecResource1">
                                                    <div>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 100%">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="defaultfontcolor">
                                                                        <tr>
                                                                            <td class="colorforcontent" width="100%" height="23" align="left">
                                                                                <div style="display: none" id="ACX2plus1">
                                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                                                        <asp:Label ID="Rs_Diagnosis" Text="Diagnosis" runat="server" meta:resourcekey="Rs_DiagnosisResource1"></asp:Label></span>
                                                                                </div>
                                                                                <div style="display: block" id="ACX2minus1">
                                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                                                        <asp:Label ID="Rs_Diagnosis1" Text="Diagnosis" runat="server" meta:resourcekey="Rs_Diagnosis1Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div id="ACX2responses1" style="display: block;" class="dataheaderInvCtrl">
                                                                                    <asp:Button ID="btnhidden" runat="server" Text="btnhidden" Visible="False" meta:resourcekey="btnhiddenResource1" />
                                                                                    <uc17:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                                                    <asp:CheckBox ID="cPD" runat="server" Text="Is Provisional Diagnosis?" meta:resourceKey="cPDResource1" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upTabControl" runat="server">
                                        <ContentTemplate>
                                            <ajc:TabContainer ID="tcEMR" runat="server" Style="height: auto; overflow: auto"
                                                ActiveTabIndex="0" Width="100%" meta:resourcekey="tcEMRResource1">
                                                <ajc:TabPanel ID="tpHistory" runat="server" HeaderText="Enter History" meta:resourcekey="tpHistoryResource1">
                                                    <HeaderTemplate>
                                                        Enter History
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divCapHis">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <uc15:History ID="ucHistory" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tpReview" runat="server" HeaderText="Review Of System" meta:resourcekey="tpReviewResource1">
                                                    <HeaderTemplate>
                                                        Review Of System
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                                                            <ContentTemplate>
                                                                <div id="div2">
                                                                    <table width="100%" style="height: auto; font-family: Tahoma;">
                                                                        <tr>
                                                                            <td>
                                                                                <input type="checkbox" name="Rmaster" value="13" id="RchkSelectAll" onclick="checkReviewAll();"><b>Mark
                                                                                    All As Confidential</b>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-family: Tahoma;">
                                                                                <asp:CheckBoxList ID="chkreview" runat="server" 
                                                                                    meta:resourcekey="chkreviewResource1">
                                                                                </asp:CheckBoxList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel runat="server" ID="tpExamination" HeaderText="Enter Examination" meta:resourcekey="tpExaminationResource1">
                                                    <HeaderTemplate>
                                                        Enter Examination
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updpnlExamination" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divCapExam">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                                                            Width="50px" meta:resourcekey="Img1Resource1" />Please Wait...</ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:HiddenField runat="server" ID="hdnSex" />
                                                                                <uc5:PatientVitals ID="PatientVitalsControl" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div id="divReview">
                                                                    <table width="100%" style="height: auto; font-family: Tahoma;">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel1" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel1Resource1">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Appearance :
                                                                                            </td>
                                                                                            <td>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblPosture" runat="server" Text="Posture" 
                                                                                                                meta:resourcekey="lblPostureResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtPosture" runat="server" 
                                                                                                                meta:resourcekey="txtPostureResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="lblRace" runat="server" Text="Race" 
                                                                                                                meta:resourcekey="lblRaceResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtRace" runat="server" meta:resourcekey="txtRaceResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblAttitude" runat="server" Text="Attitude" 
                                                                                                                meta:resourcekey="lblAttitudeResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAttitude" runat="server" 
                                                                                                                meta:resourcekey="txtAttitudeResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblEthnicity" runat="server" Text="Ethnicity" 
                                                                                                                meta:resourcekey="lblEthnicityResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtEthnicity" runat="server" 
                                                                                                                meta:resourcekey="txtEthnicityResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <input id="EchkAppearance" runat="server" type="checkbox" value="1" />
                                                                                                            Check if confidential
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel2" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel2Resource1">
                                                                                    <table style="font-family: Tahoma;">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Attitude :
                                                                                            </td>
                                                                                            <td>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblAttitudeT" runat="server" Text="Attitude Towards Examiner:" 
                                                                                                                meta:resourcekey="lblAttitudeTResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAttitudeE" runat="server" 
                                                                                                                meta:resourcekey="txtAttitudeEResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <input id="EchkAttitude" runat="server" type="checkbox" value="2" />
                                                                                                            Check if confidential
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel3" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel3Resource1">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Mood : </input>
                                                                                            </td>
                                                                                            <td>
                                                                                                <textarea id="EtxtMood" runat="server" cols="80" rows="2"></textarea>
                                                                                            </td>
                                                                                            <td style="font-family: Tahoma;" align="left">
                                                                                                <input id="EchkMood" runat="server" type="checkbox" value="3">
                                                                                                Check if confidential
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel4" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel4Resource1">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Affect : </input>
                                                                                            </td>
                                                                                            <td>
                                                                                                <textarea id="EtxtAffect" runat="server" cols="80" rows="2">Expansive/Erythemic/Constricted/Blunted/Flat</textarea>
                                                                                            </td>
                                                                                            <td style="font-family: Tahoma;">
                                                                                                <input id="EchkAffect" runat="server" type="checkbox" value="4"> Check if 
                                                                                                confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel5" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel5Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Speech :
                                                                                            </td>
                                                                                            <td>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblQuality" runat="server" Text="Quality" 
                                                                                                                meta:resourcekey="lblQualityResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtQuality" runat="server" 
                                                                                                                meta:resourcekey="txtQualityResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblRate" runat="server" Text="Rate" 
                                                                                                                meta:resourcekey="lblRateResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtRate" runat="server" meta:resourcekey="txtRateResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblVolume" runat="server" Text="Volume" 
                                                                                                                meta:resourcekey="lblVolumeResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtVolume" runat="server" 
                                                                                                                meta:resourcekey="txtVolumeResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblCoOrdination" runat="server" Text="Co-Ordination" 
                                                                                                                meta:resourcekey="lblCoOrdinationResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="30%">
                                                                                                            <asp:TextBox ID="txtCoOrdination" runat="server" 
                                                                                                                meta:resourcekey="txtCoOrdinationResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td style="font-family: Tahoma;" width="70%">
                                                                                                            <input id="EchkSpeech" runat="server" type="checkbox" value="5"> Check if 
                                                                                                            confidential 
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel6" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel6Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Thought Process:
                                                                                            </td>
                                                                                            <td>
                                                                                                <textarea id="EtxtThought" runat="server" cols="80" rows="2">Irrelevance/Impaired Thoughts/etc..</textarea>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input id="EchkThought" runat="server" type="checkbox" value="6" />
                                                                                                Check if confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel7" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel7Resource1">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Thought Content:
                                                                                            </td>
                                                                                            <td>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblObessions" runat="server" Text="Obessions/Compultions" 
                                                                                                                meta:resourcekey="lblObessionsResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtObessions" runat="server" 
                                                                                                                meta:resourcekey="txtObessionsResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="lblPhobias" runat="server" Text="Phobias" 
                                                                                                                meta:resourcekey="lblPhobiasResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtPhobias" runat="server" 
                                                                                                                meta:resourcekey="txtPhobiasResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblConsciousness" runat="server" Text="Level of Consciousness" 
                                                                                                                meta:resourcekey="lblConsciousnessResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtConsciousness" runat="server" 
                                                                                                                meta:resourcekey="txtConsciousnessResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="lblOrientation" runat="server" Text="Orientation" 
                                                                                                                meta:resourcekey="lblOrientationResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtOrientation" runat="server" 
                                                                                                                meta:resourcekey="txtOrientationResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="bbl" runat="server" Text="Sensorium &amp; Cognition" 
                                                                                                                meta:resourcekey="bblResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtSensorium" runat="server" 
                                                                                                                meta:resourcekey="txtSensoriumResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblSuicidal" runat="server" Text="Suicidal/Homicidal ideation" 
                                                                                                                meta:resourcekey="lblSuicidalResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtSuicidal" runat="server" 
                                                                                                                meta:resourcekey="txtSuicidalResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="lblMemory" runat="server" Text="Memory" 
                                                                                                                meta:resourcekey="lblMemoryResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtMemory" runat="server" 
                                                                                                                meta:resourcekey="txtMemoryResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblAbstractness" runat="server" Text="Abstractness/Intelligence" 
                                                                                                                meta:resourcekey="lblAbstractnessResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAbstractness" runat="server" 
                                                                                                                meta:resourcekey="txtAbstractnessResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <input id="EchkThoughtcontent" runat="server" type="checkbox" value="7" />
                                                                                                           Check if confidential 
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel8" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel8Resource1">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Perceptual Disturbances :
                                                                                            </td>
                                                                                            <td>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblHallucinations" runat="server" Text="Hallucinations" 
                                                                                                                meta:resourcekey="lblHallucinationsResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtHallucinations" runat="server" 
                                                                                                                meta:resourcekey="txtHallucinationsResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:Label ID="lblIllusions" runat="server" Text="Illusions" 
                                                                                                                meta:resourcekey="lblIllusionsResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtIllusions" runat="server" 
                                                                                                                meta:resourcekey="txtIllusionsResource1"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <input id="EchkPerceptual" runat="server" type="checkbox" value="8" />
                                                                                                          Check if confidential 
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel9" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel9Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Insight : </input>
                                                                                            </td>
                                                                                            <td>
                                                                                                <textarea id="EtxtInsight" runat="server" cols="80" rows="2">Understanding of Illness:        </textarea>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input id="EchkInsight" runat="server" type="checkbox" value="9" />
                                                                                               Check if confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel10" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel10Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Judgement :
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="EtxtJudgement" runat="server" meta:resourcekey="txtJudgementResource1"
                                                                                                    Width="300px"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input id="EchkJudgement" runat="server" type="checkbox" value="10" /> Check if 
                                                                                                confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel11" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel11Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                </input>
                                                                                                Impulsivity :
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="EtxtImpulsivity" runat="server" meta:resourcekey="txtImpulsivityResource1"
                                                                                                    Width="300px"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input id="EchkImpulsivity" runat="server" type="checkbox" value="11" />
                                                                                                Check if confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="panel12" CssClass="dataheader2" runat="server" 
                                                                                    meta:resourcekey="panel12Resource1">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="font-family: Tahoma; font-weight: bold">
                                                                                                Reliability :
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="EtxtReliability" runat="server" meta:resourcekey="txtReliabilityResource1"
                                                                                                    Width="300px"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input id="EchkReliability" runat="server" type="checkbox" value="12" /> Check 
                                                                                                if confidential 
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" style="font-family: Tahoma; font-weight: bold">
                                                                                <input type="checkbox" name="Emaster" id="EchkSelectAll" onclick="EcheckAll();" value="">Mark
                                                                                All as Confidential
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tbSummary" runat="server" HeaderText="Summary" meta:resourcekey="tbSummaryResource1">
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                            <ContentTemplate>
                                                                <div id="div1">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                            </ajc:TabContainer>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">                                                                       
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc18:GeneralAdv ID="uGAdv" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc19:Miscellaneous ID="uMiscellaneous" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="70px" OnClick="btnsave_Click" OnClientClick="return Validate();"
                                        meta:resourcekey="btnsaveResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="70px" OnClick="btnCancel_Click1" OnClientClick="return CancelValidate()" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnVisitID" runat="server" />
        <asp:HiddenField ID="hdnButtonClick" Value="0" runat="server" />
        <asp:HiddenField ID="hdnReviewText" runat="server" />
        <asp:HiddenField ID="hdnTextValue" runat="server" />
        <asp:HiddenField ID="hdnAppearance" runat="server" />
        <asp:HiddenField ID="hdnAttitude" runat="server" />
        <asp:HiddenField ID="hdnMood" runat="server" />
        <asp:HiddenField ID="hdnAffect" runat="server" />
        <asp:HiddenField ID="hdnSpeech" runat="server" />
        <asp:HiddenField ID="hdnThProcess" runat="server" />
        <asp:HiddenField ID="hdnThContent" runat="server" />
        <asp:HiddenField ID="hdnPerceptual" runat="server" />
        <asp:HiddenField ID="hdnInsight" runat="server" />
        <asp:HiddenField ID="hdnJudgement" runat="server" />
        <asp:HiddenField ID="hdnImpulsivity" runat="server" />
        <asp:HiddenField ID="hdnReliability" runat="server" />
    </div>
    </form>
</body>
</html>
