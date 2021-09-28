<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDiagnose.aspx.cs"
    Inherits="Physician_PatientDiagnose" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Profile.ascx" TagName="Profile" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InventoryAdvice"
    TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/Corporate/AssistantPhysicianName.ascx" TagName="Assphy" TagPrefix="uc20" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Patient Diagnose</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <%-- <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
--%>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry(bid) {
            document.getElementById(bid).style.display = 'none';
            GetDesc();
        }

        function showAlert(id) {
            if (document.getElementById(id).checked != true) {
                var confirmmsg;
               var userMsg = SListForApplicationMessages.Get("Physician\\PatientDiagnose.aspx_1");
               if (userMsg != null) {
                   confirmmsg = userMsg;
               return false;
                   }
               else {
                    confirmmsg = "Are you sure you wish to delete? This action will delete all Referral / Medical letters.";
                    }
                    if (confirm(confirmmsg)) {

                    document.getElementById(id).checked = false;
                }
                else {

                    document.getElementById(id).checked = true;
                }
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
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                            <li class="dataheader">
                                <asp:Label ID="lblDiagnosisHeader" runat="server" Text="Diagnosis" meta:resourcekey="lblDiagnosisHeaderResource1"></asp:Label>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table style="width: 100%" border="0">
                            <tr>
                                <td colspan="3">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="dataheader2">
                                        <tr class="defaultfontcolor" style="padding: 5px">
                                            <td nowrap="nowrap">
                                                <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="dataheader2">
                                        <tr class="defaultfontcolor" style="padding: 5px">
                                            <%--<td nowrap="nowrap">
                                                Diagnosis Description
                                                <asp:TextBox runat="server" ID="txtDiagnosisType" Height="13">
                                                </asp:TextBox>
                                            </td>--%>
                                            <td nowrap="nowrap">
                                                <asp:CheckBox ID="cPD" runat="server" Text="Is Provisional Diagnosis?" meta:resourcekey="cPDResource1" />
                                                &nbsp;
                                                <asp:CheckBox ID="cPos" runat="server" Visible="False" meta:resourcekey="cPosResource1" />
                                                <asp:Label ID="lblPos" runat="server" Visible="False" meta:resourcekey="lblPosResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Panel ID="pnlVitals" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlVitalsResource1">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
                                                        <uc11:PatientVitals ID="PatientVitalsControl" runat="server" />
                                                        <br clear="all" />
                                                        <br clear="all" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td valign="top" style="width: 33%">
                                    <asp:Panel ID="pnlTVH" runat="server" BorderWidth="0px" meta:resourcekey="pnlTVHResource1">
                                        <asp:TreeView ID="TVH" runat="server" ExpandImageUrl="~/Images/History_R.png" CollapseImageUrl="~/Images/History_G.png"
                                            meta:resourcekey="TVHResource1">
                                            <Nodes>
                                                <asp:TreeNode SelectAction="None" ImageUrl="~/Images/whitebg.png" Value="0" 
                                                    meta:resourcekey="TreeNodeResource1">
                                                </asp:TreeNode>
                                            </Nodes>
                                            <ParentNodeStyle CssClass="details_value" />
                                            <RootNodeStyle CssClass="details_value4" />
                                        </asp:TreeView>
                                        <table border="0" class="defaultfontcolor" width="100%">
                                            <tr>
                                                <td style="padding-left: 10%">
                                                    <label id="Label1">
                                                        <asp:Label ID="Rs_Others" Text="Others" runat="server" meta:resourcekey="Rs_OthersResource1"></asp:Label></label>
                                                    <textarea id="txtHOthers" runat="server" cols="16" rows="5"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td valign="top" style="width: 33%">
                                    <asp:Panel ID="pnlTVE" runat="server" meta:resourcekey="pnlTVEResource1">
                                        <asp:TreeView ID="TVE" runat="server" CollapseImageUrl="~/Images/Exam_G.png" ExpandImageUrl="~/Images/Exam_R.png"
                                            meta:resourcekey="TVEResource1">
                                            <Nodes>
                                                <asp:TreeNode SelectAction="None" Value="0" 
                                                    meta:resourcekey="TreeNodeResource2"></asp:TreeNode>
                                            </Nodes>
                                            <ParentNodeStyle CssClass="details_value" />
                                            <RootNodeStyle CssClass="details_value4" />
                                        </asp:TreeView>
                                        <table border="0" class="defaultfontcolor" width="100%">
                                            <tr>
                                                <td style="padding-left: 10%">
                                                    <label id="lblEOthers">
                                                        <asp:Label ID="Rs_Others1" Text="Others" runat="server" meta:resourcekey="Rs_Others1Resource1"></asp:Label></label>
                                                    <textarea id="txtEOthers" runat="server" cols="16" rows="5"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td valign="top" style="width: 33%">
                                    <asp:Panel ID="pnlPre" runat="server" meta:resourcekey="pnlPreResource1">
                                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                            <tr>
                                                <td class="colorforcontent" width="80%" height="23" align="left">
                                                    <div style="display: none" id="ACX2plus2">
                                                        <img src="../Images/showBids.gif" class="" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                                            <asp:Label ID="Rs_Investigation" Text="Investigation" runat="server" meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                                    </div>
                                                    <div style="display: block" id="ACX2minus2">
                                                        <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                            onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                            <asp:Label ID="Rs_Investigation1" Text="Investigation" runat="server" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                                    </div>
                                                </td>
                                                <td width="20%">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="ACX2responses2" style="display: block">
                                                <td colspan="2">
                                                    <table border="0" style="width: 100%; margin-left: 0px; color: Black">
                                                        <tr>
                                                            <td style="padding-left: 3%; color: Black" valign="top" class="defaultfontcolor">
                                                                <asp:UpdatePanel ID="upTV" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:TreeView ID="tvInvestiation" runat="server" ShowCheckBoxes="All" EnableTheming="True"
                                                                            ForeColor="Black" ExpandDepth="0" meta:resourcekey="tvInvestiationResource1">
                                                                        </asp:TreeView>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                                    <asp:Label ID="Rs_MoreInvestigations" Text="More Investigations..." runat="server"
                                                                        meta:resourcekey="Rs_MoreInvestigationsResource1"></asp:Label></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table border="0" style="display: none" runat="server" id="PaidInv">
                                                        <tr runat="server">
                                                            <td style="font-weight: bold; height: 20px; color: #000;" runat="server">
                                                                <asp:Label ID="Rs_PaidInvestigation" Text="Paid Investigation" runat="server" meta:resourcekey="Rs_PaidInvestigationResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:DataList ID="dlInvName" runat="server" CellPadding="4" GridLines="Horizontal"
                                                                    RepeatColumns="1" RepeatDirection="Horizontal">
                                                                    <ItemTemplate>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <%# DataBinder.Eval(Container.DataItem, "Name")%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:CheckBox ID="chkIsBgP" runat="server" meta:resourcekey="chkIsBgPResource1" />
                        <asp:Label ID="lblIsBgP" CssClass="defaultfontcolor" runat="server" meta:resourcekey="lblIsBgPResource1"></asp:Label>
                        <br />
                        <br />
                        <%--<asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>--%>
                        <uc7:Adv ID="uAd" runat="server" />
                        <uc12:InvenAdv ID="uIAdv" runat="server" />
                        <%-- </ContentTemplate>
                        </asp:UpdatePanel>--%>
                        <%--<uc20:Assphy ID="ASSPHY" runat="server" />--%>
                        <br />
                        <uc15:GeneralAdv ID="uGAdv" runat="server" />
                        &nbsp;<table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <div style="display: none;">
                                        <asp:Label ID="Rs_ReviewtoourOPDafter" Text="Review to our OPD after" runat="server"
                                            meta:resourcekey="Rs_ReviewtoourOPDafterResource1"></asp:Label>
                                        <asp:DropDownList ID="ddlNumber" runat="server" meta:resourcekey="ddlNumberResource1">
                                            <asp:ListItem Text="1" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="2" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="3" Value="3" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="4" Value="4" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="5" Value="5" Selected="True" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                            <asp:ListItem Text="6" Value="6" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                            <asp:ListItem Text="7" Value="7" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                            <asp:ListItem Text="8" Value="8" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                            <asp:ListItem Text="9" Value="9" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlType" runat="server" meta:resourcekey="ddlTypeResource1">
                                            <asp:ListItem Text="Day(s)" Value="Day(s)" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                            <asp:ListItem Text="Weeks(s)" Value="Weeks(s)" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                            <asp:ListItem Text="Month(s)" Value="Month(s)" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                            <asp:ListItem Text="Year(s)" Value="Year(s)" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Label ID="Rs_withyourmedicalreports" Text="with your medical reports" runat="server"
                                            meta:resourcekey="Rs_withyourmedicalreportsResource1"></asp:Label>
                                        <br />
                                    </div>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
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
                                                        <asp:CheckBox ID="chkAdditionalPayments" runat="server" onclick="return fnChk(this.id);"
                                                            CssClass="defaultfontcolor" Visible="False" Text="Check here to capture additional charges"
                                                            meta:resourcekey="chkAdditionalPaymentsResource1" />
                                                        <br />
                                                        <asp:CheckBox ID="chkRefer" CssClass="defaultfontcolor" onclick="return fnChk(this.id);"
                                                            runat="server" Text="Referral / Medical Letter" meta:resourcekey="chkReferResource1" />
                                                        <br />
                                                        <br clear="all" />
                                                        &nbsp;<asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                            meta:resourcekey="lblTxtResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlNos" runat="server" CssClass="ddl" meta:resourcekey="ddlNosResource1">
                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource16">1</asp:ListItem>
                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource17">2</asp:ListItem>
                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource18">3</asp:ListItem>
                                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource19">4</asp:ListItem>
                                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource20">5</asp:ListItem>
                                                            <asp:ListItem Value="6" meta:resourcekey="ListItemResource21">6</asp:ListItem>
                                                            <asp:ListItem Value="7" meta:resourcekey="ListItemResource22">7</asp:ListItem>
                                                            <asp:ListItem Value="8" meta:resourcekey="ListItemResource23">8</asp:ListItem>
                                                            <asp:ListItem Value="9" meta:resourcekey="ListItemResource24">9</asp:ListItem>
                                                            <asp:ListItem Value="10" meta:resourcekey="ListItemResource25">10</asp:ListItem>
                                                            <asp:ListItem Value="11" meta:resourcekey="ListItemResource26">11</asp:ListItem>
                                                            <asp:ListItem Value="0" meta:resourcekey="ListItemResource27">0</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlDMY" runat="server" CssClass="ddl" meta:resourcekey="ddlDMYResource1">
                                                            <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource28">Day(s)</asp:ListItem>
                                                            <asp:ListItem Value="Week(s)" meta:resourcekey="ListItemResource29">Week(s)</asp:ListItem>
                                                            <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource30">Month(s)</asp:ListItem>
                                                            <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource31">Year(s)</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <br clear="all" />
                                                        <br clear="all" />
                                                    </div>
                                                </td>
                                        </table>
                                        <table id="tbAssPhy" runat="server" style="display: none">
                                            <tr runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="lblPrescription" runat="server" Text="OnBehalf   :" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                                </td>
                                                <td runat="server">
                                                    <asp:DropDownList ID="drpPhysician" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <tr>
                                    <td>
                                        <input type="hidden" id="did" />
                                        <asp:Button Text="Finish" Enabled="False" ID="btnSubmit" runat="server" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry(this.id);"
                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                        <asp:Button Text="Add more Diagnosis" ID="btnSaveContinue" runat="server" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnSaveContinue_Click"
                                            meta:resourcekey="btnSaveContinueResource1" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            meta:resourcekey="btnCancelResource1" />
                                        <asp:Button ID="Back" runat="server" Text="Back" OnClick="Back_Click" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="BackResource1" />
                                    </td>
                                </tr>
                        </table>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata">
                        <uc6:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <asp:Button ID="Button1" runat="server" Text="OK" CssClass="btn" OnClientClick="ShowProfile('DivProfile')" onmouseover="this.className='btn btnhov'"
                         onmouseout="this.className='btn'"  meta:resourcekey="Button1Resource1"/>
                         <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" OnClientClick="ShowProfile('DivProfile')"
                         onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCloseResource1"/>
                       <%-- <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                         onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                        <input type="button" id="btnClose" value="Close" class="btn" onclick="ShowProfile('DivProfile')"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer" runat="server" />
    </div>
    <input type="hidden" id="hdHist" value="H" runat="server" />
    <input type="hidden" id="hdExam" value="E" runat="server" />
    <input type="hidden" id="hdnRedirectedBy" runat="server" />
    <input type="hidden" id="hdnRedirectedTo" runat="server" />
    <asp:Label ID="lblRedirectURL" runat="server" Visible="False" meta:resourcekey="lblRedirectURLResource1"></asp:Label>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px; display: none;" meta:resourcekey="btnHideValuesResource1" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>

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
            var sVal = document.getElementById('PatientVitalsControl_txtSBP').value;
            var ctrlDBP = document.getElementById('PatientVitalsControl_txtDBP');
            if (sVal.length == 3) {
                ctrlDBP.focus();
            }
        }
    }
</script>

<%--<script type="text/javascript" language="javascript">

    function Showtext(id, chid) {
        if (document.getElementById(id).style.visibility == "visible") {
            document.getElementById(id).style.visibility = "hidden";
            document.getElementById(chid).checked = false;
            document.getElementById(chid).focus();
        }
        else {
            document.getElementById(id).style.visibility = "visible";
            document.getElementById(chid).checked = true;            
        }
        if (document.getElementById(chid).checked) {
            document.getElementById(id).style.visibility = "visible";
            document.getElementById(chid).checked = true;            
        }
        else {
            document.getElementById(id).style.visibility = "hidden";
            document.getElementById(chid).checked = false;
            document.getElementById(chid).focus();
        }
    }

    function GetDesc() {

        var len = document.forms[0].elements.length;
        var hist = document.getElementById('hdHist');
        var exam = document.getElementById('hdExam');
        hist.value = '';

        exam.value = '';
        var cIdSub;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "checkbox") {
                if (document.forms[0].elements[i].checked) {
                    var cId = document.forms[0].elements[i];
                    if (cId.id.substring(0, 3) == 'tCE') {
                        cIdSub = cId.id.substring(3, cId.id.length);
                        exam.value = exam.value + cIdSub + '~' + document.getElementById('tE' + cIdSub).value + '^';
                    }
                    if (cId.id.substring(0, 3) == 'tCH') {
                        cIdSub = cId.id.substring(3, cId.id.length);
                        hist.value = hist.value + cIdSub + '~' + document.getElementById('tH' + cIdSub).value + '^';
                    }
                }
            }
        }
        //    if (document.getElementById('txtEOthers').value != '') {
        //        //exam.value = exam.value + document.getElementById('txtEOthers').value + '^';
        //        document.getElementById('txtEOthers').value = '';
        //    }
        //    if (document.getElementById('txtHOthers').value != '') {
        //        //hist.value = hist.value + document.getElementById('txtHOthers').value + '^';
        //        document.getElementById('txtHOthers').value = '';
        //    }
    }
</script>--%>
</html>
