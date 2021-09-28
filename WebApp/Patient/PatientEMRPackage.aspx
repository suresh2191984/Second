<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientEMRPackage.aspx.cs"
    Inherits="Patient_PatientEMRPackage" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
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
<%@ Register Src="../EMR/GynaecologicalExam.ascx" TagName="GynaecologicalExam" TagPrefix="uc10" %>
<%@ Register Src="../EMR/RectalExamination.ascx" TagName="RectalExamination" TagPrefix="uc11" %>
<%@ Register Src="../EMR/CardiovascularExam.ascx" TagName="CardiovascularExam" TagPrefix="uc12" %>
<%@ Register Src="../EMR/AbdominalExam.ascx" TagName="AbdominalExam" TagPrefix="uc13" %>
<%@ Register Src="../EMR/History.ascx" TagName="History" TagPrefix="uc15" %>
<%@ Register Src="../EMR/Diagnostics.ascx" TagName="Diagnosticsl" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucInv" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<script type="text/javascript" src="../Scripts/bid.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient EMR</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        input:focus
        {
            /*background: #8AC0DA;*/
            outline: .25px solid #8f0000;
        }
    </style>

    <script type="text/javascript">

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
            var divid = 'tcEMR_tpHistory_ucHistory_div' + ddl[3] + '_' + ddl[4];
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
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
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
    <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata" id="dMain">
                        <%--<ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <table class="w-100p">
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
                            </tr>--%>
                            <tr>
                                <td class="a-right">
                                    <asp:Button ID="btnSaveTop" Text="Save" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    <%-- <asp:Button ID="btnEditPatientReg" Text="Edit Patient Details" runat="server" 
                                    CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" onclick="btnEditPatientReg_Click" />--%>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upTabControl" runat="server">
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
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html>
