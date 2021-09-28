<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientExaminationPackage.aspx.cs"
    Inherits="Patient_PatientExaminationPackage" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
<%@ Register Src="../EMR/Skin.ascx" TagName="Skin" TagPrefix="ucSkin" %>
<%@ Register Src="../EMR/Hair.ascx" TagName="Hair" TagPrefix="ucHair" %>
<%@ Register Src="../EMR/Nails.ascx" TagName="Nails" TagPrefix="ucNails" %>
<%@ Register Src="../EMR/Scars.ascx" TagName="Scars" TagPrefix="ucScars" %>
<%@ Register Src="../EMR/Eye.ascx" TagName="Eye" TagPrefix="ucEye" %>
<%@ Register Src="../EMR/Ear.ascx" TagName="Ear" TagPrefix="ucEar" %>
<%@ Register Src="../EMR/Neck.ascx" TagName="Neck" TagPrefix="ucNeck" %>
<%@ Register Src="../EMR/RespiratorySystem.ascx" TagName="RS" TagPrefix="ucRS" %>
<%@ Register Src="../EMR/OralCavity.ascx" TagName="OralCavity" TagPrefix="uc7" %>
<%@ Register Src="../EMR/NeurologicaExamination.ascx" TagName="NeurologicaExamination"
    TagPrefix="uc8" %>
<%@ Register Src="../EMR/GynaecologicalExam.ascx" TagName="GynaecologicalExam" TagPrefix="uc10" %>
<%@ Register Src="../EMR/RectalExamination.ascx" TagName="RectalExamination" TagPrefix="uc11" %>
<%@ Register Src="../EMR/CardiovascularExam.ascx" TagName="CardiovascularExam" TagPrefix="uc12" %>
<%@ Register Src="../EMR/AbdominalExam.ascx" TagName="AbdominalExam" TagPrefix="uc13" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('PatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('PatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }

        function showOthersBox(ddl) {         
            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
            var ddlist = ddl.split('_');         
            var strDiv = ddlist[0] + '_' + 'div' + ddlist[1] + '_' + ddlist[2];
            if ((ddlValue == "Others" || ddlValue == "Abnormal")) {
                document.getElementById(strDiv).style.display = 'block';
            }
            else {
                document.getElementById(strDiv).style.display = 'none';
            }



            if (ddl == "ucNails_ddlNailsType_4" && ddlValue != "Normal" && ddlValue != "Others" ) {


                document.getElementById('ucNails_trNailsDescription_5').style.display = 'block';
            }
            else {

                if (ddl == "ucNails_ddlNailsType_4" && ddlValue == "Others") {
                    document.getElementById('ucNails_trNailsDescription_5').style.display = 'none';
                }
                else {
                    if (ddl == "ucNails_ddlNailsType_4" && ddlValue == "Normal") {
                        document.getElementById('ucNails_trNailsDescription_5').style.display = 'none';
                    }
                    
                }
            }
            
         
            
            
        }
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
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
                                            ID="btnEMRHistory" runat="server" Text="Capture History" 
                                        CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnEMRHistory_Click" 
                                        meta:resourcekey="btnEMRHistoryResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td>
                                    <ucVitals:PatientVitals ID="PatientVitalsControl" runat="server" />
                                    <ucSkin:Skin ID="ucSkin" runat="server" />
                                    <ucHair:Hair ID="ucHair" runat="server" />
                                    <ucNails:Nails ID="ucNails" runat="server" />
                                    <ucScars:Scars ID="ucScars" runat="server" />
                                    <ucEye:Eye ID="ucEye" runat="server" />
                                    <ucEar:Ear ID="ucEar" runat="server" />
                                    <ucNeck:Neck ID="ucNeck" runat="server" />
                                    <ucRS:RS ID="ucRS" runat="server" />
                                    <uc7:OralCavity ID="OralCavity1" runat="server" />
                                    <uc8:NeurologicaExamination ID="NeurologicaExamination1" runat="server" />
                                    <uc10:GynaecologicalExam ID="GynaecologicalExam1" runat="server" />
                                    <uc11:RectalExamination ID="RectalExamination1" runat="server" />
                                    <uc12:CardiovascularExam ID="CardiovascularExam1" runat="server" />
                                    <uc13:AbdominalExam ID="AbdominalExam1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn1" Text="Save" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="Cancel" runat="server" CssClass="btn1" Text="Cancel" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" 
                                        meta:resourcekey="CancelResource1" />
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
