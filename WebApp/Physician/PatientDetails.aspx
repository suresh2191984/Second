<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.aspx.cs" Inherits="Physician_PatientDetails"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Doctor's Home</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <uc1:MainHeader ID="MainHeader" runat="server" />
            <uc3:DocHeader ID="docHeader" runat="server" />
        </div>
        <div id="primaryContent">
            <div id="maincontent">
                <uc4:LeftMenu ID="LeftMenu" runat="server" CSSStyle="todo" />
                <uc4:LeftMenu ID="LeftMenu1" runat="server" CSSStyle="Report" />
                <uc4:LeftMenu ID="LeftMenu2" runat="server" CSSStyle="outreport" />
                <div class="patientdetails">
                    <h1>
                        <ul>
                            <li class="patientdetailslist">
                                <uc5:SmallSummary ID="SmallSummary" runat="server" Title="CurrentProblems" />
                                <li class="patientdivider">
                                    <img src="../Images/patient_divider.png" alt="" /></li>
                            </li>
                            <uc5:SmallSummary ID="SmallSummary1" runat="server" Title="CurrentProblems" />
                            <li class="patientdivider">
                                <img src="../Images/patient_divider.png" alt="" /></li>
                            <uc5:SmallSummary ID="SmallSummary2" runat="server" Title="CurrentProblems" />
                        </ul>
                    </h1>
                    <ul>
                        <li class="patientreports">
                            <div class="reports">
                                <img src="../Images/vital_signs.png" align="absmiddle" alt="" />
                                <asp:Label ID="Rs_VitalParameters" Text="Vital Parameters" runat="server" meta:resourcekey="Rs_VitalParametersResource1"></asp:Label>
                                <ul>
                                    <asp:BulletedList ID="vit" runat="server" meta:resourcekey="vitResource1">
                                    </asp:BulletedList>
                                </ul>
                                <img src="../Images/notes.png" align="absmiddle" alt="" />
                                <asp:Label ID="Rs_LatestNotes3pm" Text="Latest Notes - 3 pm" runat="server" meta:resourcekey="Rs_LatestNotes3pmResource1"></asp:Label>
                                <ul>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_Asymptomatic" Text="Asymptomatic" runat="server" meta:resourcekey="Rs_AsymptomaticResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_NoFreshECGchanges" Text="No Fresh ECG changes" runat="server" meta:resourcekey="Rs_NoFreshECGchangesResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_Pericardialrub" Text="Pericardial rub +" runat="server" meta:resourcekey="Rs_PericardialrubResource1"></asp:Label></li>
                                    <li class="Reportlink">
                                        <asp:Label ID="Rs_SeeCompleteNotes" Text="See Complete Notes" runat="server" meta:resourcekey="Rs_SeeCompleteNotesResource1"></asp:Label></li>
                                </ul>
                            </div>
                        </li>
                        <li class="patientreports">
                            <div class="reports">
                                <img src="../Images/values.png" align="absmiddle" alt="" />
                                <asp:Label ID="Rs_AbnormalValues" Text="Abnormal Values" runat="server" meta:resourcekey="Rs_AbnormalValuesResource1"></asp:Label>
                                <ul>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_Haemoglobin" Text="Haemoglobin - 9.8 gm%" runat="server" meta:resourcekey="Rs_HaemoglobinResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_Creatinine" Text="Sr. Creatinine - 2.1 mg%" runat="server" meta:resourcekey="Rs_CreatinineResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_TroponinIPositive" Text="Troponin I - Positive - 2.0" runat="server"
                                            meta:resourcekey="Rs_TroponinIPositiveResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_LDL" Text="LDL - 189 mg%" runat="server" meta:resourcekey="Rs_LDLResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_UrinePusCells" Text="Urine - Pus Cells - 6-8" runat="server" meta:resourcekey="Rs_UrinePusCellsResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_TSH" Text="TSH - 23 pg / dL" runat="server" meta:resourcekey="Rs_TSHResource1"></asp:Label></li>
                                    <li class="Reportheader">
                                        <asp:Label ID="Rs_Urine" Text="Urine - Pus Cells - 6-8" runat="server" meta:resourcekey="Rs_UrineResource1"></asp:Label></li>
                                    <li class="Reportlink">
                                        <asp:Label ID="Rs_SeeLatestECG" Text="See Latest ECG (10.45 am)" runat="server" meta:resourcekey="Rs_SeeLatestECGResource1"></asp:Label></li>
                                </ul>
                            </div>
                        </li>
                        <li class="patientreports">
                            <div class="xrayreports">
                                <img src="../Images/xray.png" align="absmiddle" alt="" />
                                <asp:Label ID="Rs_ChestXRayPAViewReport" Text="Chest X Ray PA View - Report" runat="server"
                                    meta:resourcekey="Rs_ChestXRayPAViewReportResource1"></asp:Label>
                                <img src="../Images/xray_image.png" class="xray" alt="" />
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <uc2:Footer ID="Footer" runat="server" />
        </div>
    </div>
    </form>
</body>
</html>
