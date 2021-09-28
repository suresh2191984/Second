<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NeonatalNotes.aspx.cs" Inherits="InPatient_NeonatalNotes"
    meta:resourcekey="PageResource1" culture="auto" uiculture="auto" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Neonatal Notes</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function onClickAddDiagnosis() {
            var rwNumber = parseInt(220);
            var AddStatus = 0;
            var txtDiagnosisValue = document.getElementById('txtDiagnosis').value.trim();
            document.getElementById('tblDiagnosisItems').style.display = 'block';
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[1] != '') {
                        if (DiagnosisList[0] != '') {
                            rwNumber = parseInt(parseInt(DiagnosisList[0]) + parseInt(1));
                        }
                        if (txtDiagnosisValue != '') {
                            if (DiagnosisList[1] == txtDiagnosisValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtDiagnosisValue != '') {
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtDiagnosisValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtDiagnosisValue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtDiagnosisValue != '') {
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtDiagnosisValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtDiagnosisValue + "^";
                }
            }
            else if (AddStatus == 1) {
                alert('Risk factors  already added');
            }
            document.getElementById('txtDiagnosis').value = '';
            return false;
        }

        function ImgOnclickDiagnosis(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            var newDiagnosisList = '';
            if (document.getElementById('hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[0] != '') {
                        if (DiagnosisList[0] != ImgID) {
                            newDiagnosisList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnDiagnosisItems').value = newDiagnosisList;
            }
            if (document.getElementById('hdnDiagnosisItems').value == '') {
                document.getElementById('tblDiagnosisItems').style.display = 'none';
            }
        }

        function LoadDiagnosisItems() {
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var DiagnosisList = list[count].split('~');
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = DiagnosisList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(DiagnosisList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DiagnosisList[1];
                }
            }
        }



        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
        }
    </script>

    <style type="text/css">
        .style2
        {
            height: 21px;
        }
        .style3
        {
            width: 250px;
            height: 20px;
        }
        .style4
        {
            height: 20px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnFinish">
    <input type="hidden" id="hdnDiagnosisItems" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
   <ContentTemplate>--%>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" OnClick="lnkHome_Click"
                                      Text="Home"   meta:resourcekey="LinkButton1Resource1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" runat="server" style="display: block"
                            id="tblSelectOption">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblNeonatalNotes1"
                            runat="server" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td>
                                    <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblNeonatalNotes"
                            runat="server" class="dataheaderInvCtrl">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px; width: 250px;">
                                    <asp:Label ID="Rs_BriefHistory" Text="Brief History" runat="server" meta:resourcekey="Rs_BriefHistoryResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBrfHistory" runat="server" TextMode="MultiLine" onfocus="javascript:expandBox(this.id);"
                                        onblur="javascript:collapseBox(this.id);" Rows="1" meta:resourcekey="txtBrfHistoryResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <%--  <tr>
                                    <td class="defaultfontcolor" style="padding-left:10px;">
                                        Risk Factors
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDiagnosis"></asp:TextBox>&nbsp;&nbsp;
                                        <cc1:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtDiagnosis"
                                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10"
                                            FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                            ServicePath="~/WebService.asmx">
                                        </cc1:AutoCompleteExtender>
                                        <asp:Button ID="btnDiagnosisAdd" OnClientClick="javascript:return onClickAddDiagnosis();"
                                            runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" />
                                    </td>
                                </tr>--%>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <table id="tblDiagnosisItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                        width="100%">
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2" style="padding-left: 10px;">
                                    <asp:Label ID="lblVitals" runat="server" Text="Vitals" Font-Bold="True" meta:resourcekey="lblVitalsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <uc2:PatientVitalsControl ID="uctlPatientVitals" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_GeneralExamination" Text="General Examination" runat="server" meta:resourcekey="Rs_GeneralExaminationResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGeneralExam" runat="server" TextMode="MultiLine" Text="Alert and active. Appears to be normal, in consistent with dates."
                                        onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                        Rows="1" Style="width: 220px;" meta:resourcekey="txtGeneralExamResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table1" runat="server"
                            class="dataheaderInvCtrl">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="lblSysExam" runat="server" Text="Systemic Examination" Font-Bold="True"
                                        meta:resourcekey="lblSysExamResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 10px;">
                                    <asp:HiddenField ID="hdnType" runat="server" />
                                    <asp:GridView ID="grdSysExam" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                        DataKeyNames="ExaminationID" Width="500px" ForeColor="#333333" CssClass="mytable1"
                                        meta:resourcekey="grdSysExamResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="ExamID" ItemStyle-Width="5%" Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExamID" runat="server" Text='<%# Bind("ExaminationID") %>' meta:resourcekey="lblExamIDResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ExaminationName" ItemStyle-Width="30%" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtExamName" runat="server" MaxLength="255" Text='<%# Bind("ExaminationName") %>'
                                                        meta:resourcekey="txtExamNameResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" ItemStyle-Width="30" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                        Rows="1" ID="txtDescription" Text='<%# Bind("ExaminationDesc") %>' TextMode="MultiLine"
                                                        Style="width: 220px;" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table2" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;" class="style3">
                                    <asp:Label ID="Rs_RespiratorySupport" Text="Respiratory Support" runat="server" meta:resourcekey="Rs_RespiratorySupportResource1"></asp:Label>
                                </td>
                                <td class="style4">
                                    <asp:TextBox ID="txtResSupport" runat="server" TextMode="MultiLine" onfocus="javascript:expandBox(this.id);"
                                        onblur="javascript:collapseBox(this.id);" Rows="1" meta:resourcekey="txtResSupportResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_FliudsandNutrition" Text="Fliuds and Nutrition" runat="server"
                                        meta:resourcekey="Rs_FliudsandNutritionResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFluids" runat="server" TextMode="MultiLine" onfocus="javascript:expandBox(this.id);"
                                        onblur="javascript:collapseBox(this.id);" Rows="1" meta:resourcekey="txtFluidsResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_GeneralCourse" Text="General Course" runat="server" meta:resourcekey="Rs_GeneralCourseResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGeneralCourse" runat="server" TextMode="MultiLine" onfocus="javascript:expandBox(this.id);"
                                        onblur="javascript:collapseBox(this.id);" Rows="1" meta:resourcekey="txtGeneralCourseResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table3" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:Label ID="lbl" runat="server" Text="Immunization/Others Prophylaxis" Font-Bold="True"
                                        meta:resourcekey="lblResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkHepatitisb" runat="server" Text="Hepatities B" meta:resourcekey="chkHepatitisbResource1" />
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkInjectionvitamin" runat="server" Text="Injectionvitamin k (or k-1)"
                                        meta:resourcekey="chkInjectionvitaminResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc7:AdviceControl ID="uAd" runat="server" />
                                    <uc12:InvenAdv ID="uIAdv" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc15:GeneralAdv ID="uGAdv" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table4" runat="server"
                            class="dataheaderInvCtrl">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td colspan="2">
                                    <asp:CheckBox ID="chkImmunization" runat="server" Text="Immunization (as per schedule)"
                                        meta:resourcekey="chkImmunizationResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_Plan" Text="Plan" runat="server" meta:resourcekey="Rs_PlanResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPlan" runat="server" Height="70%" TextMode="MultiLine" meta:resourcekey="txtPlanResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblTxtResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlNos" runat="server" meta:resourcekey="ddlNosResource1">
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
                                    <asp:DropDownList ID="ddlDMY" runat="server" meta:resourcekey="ddlDMYResource1">
                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                        <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource14">Day(s)</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="Week(s)" meta:resourcekey="ListItemResource15">Week(s)</asp:ListItem>
                                        <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource16">Month(s)</asp:ListItem>
                                        <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource17">Year(s)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtNextReviewDate" runat="server" meta:resourcekey="txtNextReviewDateResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtNextReviewDate"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtNextReviewDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtNextReviewDate"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" OnClick="btnFinish_Click"
                                        OnClientClick="javascript:return checkForValues();" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="42px" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <%-- </ContentTemplate>
      </asp:UpdatePanel>--%>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">

        LoadDiagnosisItems(); 
    </script>

</body>
</html>
