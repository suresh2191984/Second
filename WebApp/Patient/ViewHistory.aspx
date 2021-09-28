<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewHistory.aspx.cs" Inherits="Patient_ViewHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="uc5" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/FeesEntry.ascx" TagName="Billing" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/InvestigationReportViewer.ascx" TagName="InvReport"
    TagPrefix="ucInvReport" %>
<%@ Register Src="../EMR/PrintDiagnostics.ascx" TagName="PrintDiagnostics" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script language="javascript" type="text/javascript">

        function popupprint() {

            var prtContent = document.getElementById('divviewHistory');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();

        }


       


    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:scriptmanager id="scm1" runat="server">
    </asp:scriptmanager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:mainheader id="MainHeader" runat="server" />
                <uc3:patientheader id="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata" id="divMain">
                        <ul>
                            <li>
                                <uc9:errordisplay id="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" style="display: none;" id="tblMain" runat ="server" >
                            <tr>
                                <td align="center" >
                                       <asp:label id="lblMessage" runat="server"></asp:label>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" >
                        <tr>
                        <td>
                        <div id="divviewHistory" runat="server" style="display: block; width: 100%" title="Patient History">
                            <div id="divViewHeader" style="display: block; width: 100%" title="View History" runat="server">
                                <table border="0" cellpadding="0" width="90%">
                                    <tr>
                                        <td align="center">
                                            <asp:label id="Label3" runat="server" text="PATIENT HISTORY"></asp:label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table border="0" class="defaultfontcolor" id="tableResult" runat="server" style="display: block;"
                                width="90%">
                                <tr class="defaultfontcolor" id="tr1" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelLMP" runat="server" text="LMP" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblLMPValue" runat="server" width="145px"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr2" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelFasting_Duration" runat="server" text="Fasting Duration (hours)" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblFasting_DurationValue" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr3" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelLast_Meal_Time" runat="server" text="Last Meal Time" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblLast_Meal_TimeValue" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr4" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td colspan="2" valign="top">
                                                    <asp:label id="LabelRecent_Sonography_Report" runat="server" text="Recent Sonography Report" />
                                                    &nbsp; &nbsp;
                                                </td>
                                            </tr>
                                            <tr align ="right" >
                                                <td >
                                                    <table border="1" width="100%">
                                                        <tr>
                                                            <td style="width: 35%">
                                                                Report Date
                                                            </td>
                                                            <td style="width: 45%">
                                                                <asp:label id="lblReportDateValue" runat="server"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 35%">
                                                                Report Comments
                                                            </td>
                                                            <td style="width: 45%" align="center">
                                                                <asp:label id="lblReportCommentValue" runat="server"></asp:label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr5" runat="server" style="display: none;">
                                    <td align ="right" >
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelUrine_volume_Collected" runat="server" text="24h Urine volume Collected in Ml" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <table border="1">
                                                        <tr>
                                                            <td>
                                                                Height (Cm)
                                                            </td>
                                                            <td>
                                                                Weight (Kg)
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:label id="lblHeightValue" runat="server" cssclass="defaultfontcolor"></asp:label>
                                                            </td>
                                                            <td>
                                                                <asp:label id="lblWeightValue" runat="server"></asp:label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr6" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelAbstinence_days" runat="server" text="Abstinence days" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblAbstinence_daysValue" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr7" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelThyroid_Disease" runat="server" text="On anti-thyroid disease drugs" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblThyroid_Disease_Value" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor" id="tr8" runat="server" style="display: none;">
                                    <td>
                                        <table cellpadding="0" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:label id="LabelReading_taken_between_48_72_hrs" runat="server" text="Reading taken between 48hrs - 72 hrs" />
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:label id="lblReading_taken_between_48_72_hrs_Value" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        </td>
                        </tr>
                        
                        </table> 
                       <table>
                       
                       <tr align="center" >
                        <td>
                         <asp:Button id="btnPrint" runat="server" text="Print"  OnClientClick="return popupprint();"  />
                                        
                        </td>
                        </tr>
                       </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:footer id="Footer" runat="server" />
    </div>
    </form>
</body>
</html>
