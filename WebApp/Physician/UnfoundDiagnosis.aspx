<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="UnfoundDiagnosis.aspx.cs"
    Inherits="Unfound_Diagnosis" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Advice" TagPrefix="uc5" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="DHEBAdd" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Diagnosis</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        function chkNextReview() {
            var ddlNos = document.getElementById('ddlNos').options[document.getElementById('ddlNos').selectedIndex].value;
            var ddlDMY = document.getElementById('ddlDMY').options[document.getElementById('ddlDMY').selectedIndex].value;
            if (((ddlNos != 0) && (ddlDMY == 0))||((ddlNos == 0)&&(ddlDMY !=0))) {
                alert('Enter NextReviewDate');
                return false;
            }
            else {
                return true;
            }
        }
        function fnChk(chkid) {
            var objAdditional = document.getElementById('chkAdditionalPayments');
            var objReferal = document.getElementById('chkRefer');
            if (objAdditional != null) {
                if (objAdditional.checked == true && objReferal.checked == true) {
                    if (chkid == 'chkAdditionalPayments')
                        objReferal.checked = false;
                    else
                        objAdditional.checked = false;

                }
            }
        }
        </script>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnHideValues">
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
                <uc2:Header ID="Header2" runat="server" />
                <uc6:PatientHeader ID="PatientHeader1" runat="server" ShowVitals="true" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnlVitals" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlVitalsResource1">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="35%" height="23" align="left">
                                        <div style="display: none;" id="ACX2plusMVitals">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);">
                                                <asp:Label ID="Rs_CollectVitals" Text="Collect Vitals" runat="server" meta:resourcekey="Rs_CollectVitalsResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block; height: 18px;" id="ACX2minusMVitals">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);">
                                                <asp:Label ID="Rs_CollectVitals1" Text="Collect Vitals" runat="server" meta:resourcekey="Rs_CollectVitals1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesMVitals" style="display: block">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <uc11:PatientVitals ID="uctPatientVitalsControl" runat="server" />
                                            <br clear="all" />
                                            <br clear="all" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlRec" runat="server" CssClass="defaultfontcolor" Width="800px" meta:resourcekey="pnlRecResource1">
                            <div class="dataheader2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 100%">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td class="colorforcontent" width="100%" height="23" align="left">
                                                        <div style="display: none" id="ACX2plus1">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                                &nbsp;<asp:Label ID="Rs_Diagnosis" Text="Diagnosis" runat="server" meta:resourcekey="Rs_DiagnosisResource1"></asp:Label></span>
                                                        </div>
                                                        <div style="display: block" id="ACX2minus1">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                                &nbsp;<asp:Label ID="Rs_Diagnosis1" Text="Diagnosis" runat="server" meta:resourcekey="Rs_Diagnosis1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses1" style="display: block;">
                                                    <td colspan="2" width="100%">
                                                        <asp:Button ID="btnhidden" runat="server" Text="btnhidden" Visible="False" meta:resourcekey="btnhiddenResource1" />
                                                        <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnlExam" runat="server" CssClass="defaultfontcolor" Width="720px"
                            meta:resourcekey="pnlExamResource1">
                            <div class="dataheader2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 50%" valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="colorforcontent" width="50%" height="23" align="left" valign="top">
                                                        <div style="display: none" id="ACX2plusOne1">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusOne1','ACX2minusOne1','ACX2responsesOne1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusOne1','ACX2minusOne1','ACX2responsesOne1',1);">
                                                                &nbsp;<asp:Label ID="Rs_PatientHistory" Text="Patient History" runat="server" meta:resourcekey="Rs_PatientHistoryResource1"></asp:Label></span>
                                                        </div>
                                                        <div style="display: block" id="ACX2minusOne1">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusOne1','ACX2minusOne1','ACX2responsesOne1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusOne1','ACX2minusOne1','ACX2responsesOne1',0);">
                                                                &nbsp;<asp:Label ID="Rs_PatientHistory1" Text="Patient History" runat="server" meta:resourcekey="Rs_PatientHistory1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responsesOne1" style="display: block" class="tablerow">
                                                    <td colspan="2" width="75%">
                                                        <uc8:DHEBAdd runat="server" ID="DHEBHistory" AdviceMode="EditMode" DescriptionDisplayText="History"
                                                            CommentDisplayText="Comments" ServiceMethod="getHistory" ServicePath="~/WebService.asmx" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 50%" valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="colorforcontent" width="50%" height="23" align="left" valign="top">
                                                        <div style="display: none" id="ACX2plus9">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',1);">
                                                                &nbsp;<asp:Label ID="Rs_Examinations" Text="Examinations" runat="server" meta:resourcekey="Rs_ExaminationsResource1"></asp:Label></span>
                                                        </div>
                                                        <div style="display: block" id="ACX2minus9">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus9','ACX2minus9','ACX2responses9',0);">
                                                                &nbsp;<asp:Label ID="Rs_Examinations1" Text="Examinations" runat="server" meta:resourcekey="Rs_Examinations1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="tablerow" id="ACX2responses9" style="display: block">
                                                    <td colspan="2" width="75%">
                                                        <uc8:DHEBAdd runat="server" ID="dhebAddExam" AdviceMode="EditMode" DescriptionDisplayText="Examination"
                                                            CommentDisplayText="Comments" ServiceMethod="getExamination" ServicePath="~/WebService.asmx" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlInvest" runat="server" CssClass="defaultfontcolor" Width="720px"
                            meta:resourcekey="pnlInvestResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: block" id="ACX2plus10">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);">
                                                &nbsp;<asp:Label ID="Rs_Investigation" Text="Investigation" runat="server" meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: none" id="ACX2minus10">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);">
                                                &nbsp;<asp:Label ID="Rs_Investigation1" Text="Investigation" runat="server" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses10" style="display: none">
                                    <td colspan="2">
                                        <div class="unfounddataheader2">
                                            <table width="100%" border="0" class="defaultfontcolor">
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                            <asp:Label ID="Rs_MoreInvestigations" Text="More Investigations..." runat="server"
                                                                meta:resourcekey="Rs_MoreInvestigationsResource1"></asp:Label></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <uc5:Advice ID="uAd" runat="server" />
                        <uc12:InvenAdv ID="uIAdv" runat="server" />
                        <br />
                        <uc9:GeneralAdv ID="uGAdv" runat="server" />
                        <br />
                        <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="35%" height="23" align="left">
                                        <div style="display: none" id="ACX2plusM">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);">
                                                <asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block; height: 18px;" id="ACX2minusM">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);">
                                                <asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesM" style="display: block">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <br />
                                            <asp:CheckBox ID="chkAdmit" CssClass="defaultfontcolor" runat="server" Text="Admit"
                                                meta:resourcekey="chkAdmitResource1" />
                                            <br />
                                            <asp:CheckBox ID="chkAdditionalPayments" onclick="return fnChk(this.id);" runat="server"  Text="Check here to capture additional charges"
                                                meta:resourcekey="chkAdditionalPaymentsResource1" />
                                            <br />
                                            <asp:CheckBox ID="chkRefer" CssClass="defaultfontcolor" onclick="return fnChk(this.id);" runat="server" Text="Referral / Medical Letter"
                                                meta:resourcekey="chkReferResource1" />
                                            <br />
                                            <br />
                                            &nbsp;<asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                meta:resourcekey="lblTxtResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlNos" CssClass="ddl" runat="server" meta:resourcekey="ddlNosResource1">
                                                <asp:ListItem Value="0">0</asp:ListItem>
                                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="6">6</asp:ListItem>
                                                <asp:ListItem Value="7">7</asp:ListItem>
                                                <asp:ListItem Value="8">8</asp:ListItem>
                                                <asp:ListItem Value="9">9</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="11">11</asp:ListItem>
                                                 <asp:ListItem Value="12">11</asp:ListItem>
                                                
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlDMY" CssClass="ddl" runat="server" meta:resourcekey="ddlDMYResource1">
                                                 <asp:ListItem Value="0">0</asp:ListItem>
                                                <asp:ListItem Value="Day(s)" Selected="True">Day(s)</asp:ListItem>
                                                <asp:ListItem Value="Week(s)" >Week(s)</asp:ListItem>
                                                <asp:ListItem Value="Month(s)">Month(s)</asp:ListItem>
                                                <asp:ListItem Value="Year(s)">Year(s)</asp:ListItem>
                                               
                                            </asp:DropDownList>
                                            <br clear="all" />
                                            <br clear="all" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlSave" runat="server" CssClass="defaultfontcolor" Width="720px"
                            meta:resourcekey="pnlSaveResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr class="tablerow" style="background-color: Transparent">
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <table width="100%">
                                                    <tr>
                                                        <td style="width: 25%">
                                                            <asp:Label ID="lblError" runat="server" CssClass="errorbox" Visible="False" meta:resourcekey="lblErrorResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 25%">
                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClientClick="return chkNextReview();"  OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Finish" meta:resourcekey="btnSaveResource1" />
                                                            <asp:Button ID="btnSaveContinue" runat="server" CssClass="btn" OnClientClick="return chkNextReview();" OnClick="btnSaveContinue_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save &amp; Continue"
                                                                meta:resourcekey="btnSaveContinueResource1" />
                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                                meta:resourcekey="btnCancelResource1" />
                                                            <asp:Button ID="Back" runat="server" CssClass="btn" OnClick="Back_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Back" meta:resourcekey="BackResource1" />
                                                            <asp:Label runat="server" ID="lblRedirectURL" Visible="False" meta:resourcekey="lblRedirectURLResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata">
                        <uc10:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer" runat="server" />
    </div>

    <script language="javascript" type="text/javascript">
        //    function pageLoad() {
        //        $addHandler($get("showModalPopupClientButton"), 'click', showModalPopupViaClient);
        //        $addHandler($get("hideModalPopupViaClientButton"), 'click', hideModalPopupViaClient);
        //    }

        //    function showModalPopupViaClient(ev) {
        //        ev.preventDefault();
        //        var modalPopupBehavior = $find('programmaticModalPopupBehavior');
        //        modalPopupBehavior.show();
        //    }

        //    function hideModalPopupViaClient(ev) {
        //        ev.preventDefault();
        //        var modalPopupBehavior = $find('programmaticModalPopupBehavior');
        //        modalPopupBehavior.hide();
        //    }

        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('uctPatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('uctPatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        
        
    </script>

    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" meta:resourcekey="btnHideValuesResource1" />
    </form>
</body>
</html>
