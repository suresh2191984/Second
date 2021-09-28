<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Counselling.aspx.cs" Inherits="Psychologist_Counselling" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../EMR/History.ascx" TagName="History" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="ucPatHeader" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
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
<%@ Register Src="../EMR/Diagnostics.ascx" TagName="Diagnosticsl" TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucInv" %>
<%@ Register Src="~/CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc17" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc18" %>
<%@ Register Src="../CommonControls/Miscellaneous.ascx" TagName="Miscellaneous" TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/EMROPCaseSheet.ascx" TagName="EMROP" TagPrefix="uc20" %>
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
            //            obj1.style.display = 'none';
            //            obj2.style.display = 'none';
            //            obj3.style.display = 'none';

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

        function Validate() {
            var e = document.getElementById("ddlCouselType");
            var strUser = e.options[e.selectedIndex].value;
            if (strUser == '---------------Select----------------') {
                alert("Please Select Counsel Type");
                return false;
            }
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
                                    <asp:Panel ID="pnl1" runat="server" CssClass="dataheader2" Style="width: 100%" 
                                        BorderWidth="1px" meta:resourcekey="pnl1Resource1">
                                        <table width="100%">
                                            <tr>
                                                <td width="35%" align="right">
                                                    <asp:Label ID="lblCounselType" runat="server" Text="Counseling Type" 
                                                        meta:resourcekey="lblCounselTypeResource1"></asp:Label>
                                                </td>
                                                <td width="50%">
                                                    <asp:DropDownList ID="ddlCouselType" runat="server" Width="30%" CssClass="ddlsmall"
                                                        meta:resourcekey="ddlCouselTypeResource1">
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
                                                <asp:Panel ID="PrevPnl" runat="server" CssClass="dataheader2" 
                                                    meta:resourcekey="PrevPnlResource1">
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
                                                                                        <asp:Label ID="Label3" Text="Show Previous History" runat="server" 
                                                                                        meta:resourcekey="Label3Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div style="display: none" id="Grdminus">
                                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Grdplus','Grdminus','GrdResponse',0); HideGo();" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);HideGo();">
                                                                                        <asp:Label ID="Label4" Text="Hide Previous History" runat="server" 
                                                                                        meta:resourcekey="Label4Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div id="GrdResponse">
                                                                                    <asp:UpdatePanel ID="updpnl1" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:GridView ID="grdView" EmptyDataText="No Record Found" runat="server" AllowPaging="True"
                                                                                                CellPadding="1" AutoGenerateColumns="False" DataKeyNames="VisitID,VisitDate,CounselType,Symptoms"
                                                                                                Width="100%" ForeColor="Black" PageSize="5" CssClass="mytable1" BackColor="#DEBA84"
                                                                                                OnRowDataBound="grdView_RowDataBound" OnRowCommand="grdView_RowCommand" 
                                                                                                OnPageIndexChanging="grdView_PageIndexChanging" CaptionAlign="Top" 
                                                                                                meta:resourcekey="grdViewResource1">
                                                                                                <PagerTemplate>
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td align="center" colspan="5">
                                                                                                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" 
                                                                                                                    CommandArgument="Prev" CommandName="Page" Height="10px" 
                                                                                                                    ImageUrl="~/Images/previousimage.png" meta:resourcekey="lnkPrevResource1" 
                                                                                                                    Width="10px" />
                                                                                                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" 
                                                                                                                    CommandArgument="Next" CommandName="Page" Height="10px" 
                                                                                                                    ImageUrl="~/Images/nextimage.png" meta:resourcekey="lnkNextResource1" 
                                                                                                                    Width="10px" />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </PagerTemplate>
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="VisitID" HeaderText="PatientVisitID" 
                                                                                                        meta:resourcekey="BoundFieldResource1" Visible="False" />
                                                                                                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" 
                                                                                                        HeaderText="Visit Date" meta:resourcekey="BoundFieldResource2" />
                                                                                                    <asp:BoundField DataField="CounselType" HeaderText="Counseling Type" 
                                                                                                        meta:resourcekey="BoundFieldResource3" />
                                                                                                    <asp:HyperLinkField DataTextField="Symptoms" HeaderText="Symptoms" 
                                                                                                        meta:resourcekey="HyperLinkFieldResource1">
                                                                                                        <ItemStyle ForeColor="Black" />
                                                                                                    </asp:HyperLinkField>
                                                                                                </Columns>
                                                                                                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                                                                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                                                                <PagerSettings Mode="NextPrevious" />
                                                                                                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center"></PagerStyle>
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
                                                            <asp:Panel ID="pnlfckeditor" runat="server" CssClass="defaultfontcolor" 
                                                                meta:resourcekey="pnlfckeditorResource1">
                                                                <div class="dataheader2">
                                                                    <table width="100%" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td class="colorforcontent" height="23" width="100%" align="left" colspan="2">
                                                                                <div style="display: none; width: 100%;" id="Fckplus1">
                                                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);" />
                                                                                    <span class="dataheader1txt" style="width: 100%; cursor: pointer" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);">
                                                                                        <asp:Label ID="Label1" Text="Symptoms / Hisotry" runat="server" 
                                                                                        meta:resourcekey="Label1Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div style="display: block; width: 100%;" id="Fckminus2">
                                                                                    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                                        onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);" />
                                                                                    <span class="dataheader1txt" style="width: 100%; cursor: pointer" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);">
                                                                                        <asp:Label ID="Label2" Text="Symptoms / History" runat="server" 
                                                                                        meta:resourcekey="Label2Resource1"></asp:Label></span>
                                                                                </div>
                                                                                <div id="Fckresponse" style="display: block;">
                                                                                    <FCKeditorV2:FCKeditor ID="fckCounselling" runat="server" Width="100%" 
                                                                                        Height="200px">
                                                                                    </FCKeditorV2:FCKeditor>
                                                                                    <asp:CheckBox ID="chkHistory" runat="server" Text="Is Confidential?" 
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
                                                <asp:Panel ID="pnlRec" runat="server" Width="328px" 
                                                    meta:resourcekey="pnlRecResource1">
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
                                                                                    <asp:CheckBox ID="cPD" runat="server" Text="Is Provisional Diagnosis?" 
                                                                                        meta:resourcekey="cPDResource1" />
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
                                                        Enter History</HeaderTemplate>
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
                                                <ajc:TabPanel runat="server" ID="tpExamination" HeaderText="Enter Examination" meta:resourcekey="tpExaminationResource1">
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
                                                                                <asp:Table ID="drawNewPattern" BorderWidth="1px" runat="server" Width="100%" meta:resourcekey="drawNewPatternResource1">
                                                                                </asp:Table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tbSummary" runat="server" HeaderText="Summary" 
                                                    meta:resourcekey="tbSummaryResource1">
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
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <uc18:GeneralAdv ID="uGAdv" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
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
                                        onmouseout="this.className='btn'" Width="70px" OnClick="btnsave_Click" 
                                        OnClientClick="return Validate();" meta:resourcekey="btnsaveResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="70px" OnClick="btnCancel_Click1" 
                                        OnClientClick="return CancelValidate();" meta:resourcekey="btnCancelResource1"/>
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
    </div>
    </form>
</body>
</html>
