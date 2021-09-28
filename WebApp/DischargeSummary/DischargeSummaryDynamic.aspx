<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DischargeSummaryDynamic.aspx.cs"
    Inherits="DischargeSummary_DischargeSummaryDynamic" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Reference Control="~/DischargeSummary/PatientAddress.ascx" %>
<%@ Reference Control="~/DischargeSummary/PatientDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/ConditionOnDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfAdmission.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfSurgery.ascx" %>
<%@ Reference Control="~/DischargeSummary/PrimaryConsultant.ascx" %>
<%@ Reference Control="~/DischargeSummary/TypeOfDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/Diagnose.ascx" %>
<%@ Reference Control="~/DischargeSummary/TreatmentPlan.ascx" %>
<%@ Reference Control="~/DischargeSummary/History.ascx" %>
<%@ Reference Control="~/DischargeSummary/BackrounMedicalProblem.ascx" %>
<%@ Reference Control="~/DischargeSummary/AdmissionVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/SystemicExamination.ascx" %>
<%@ Reference Control="~/DischargeSummary/DischargeVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/GeneralExamination.ascx" %>
<%@ Reference Control="~/DischargeSummary/SurgeryDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/CourseInHospital.ascx" %>
<%@ Reference Control="~/DischargeSummary/DischargePrescription.ascx" %>
<%@ Reference Control="~/DischargeSummary/Advice.ascx" %>
<%@ Reference Control="~/DischargeSummary/Procedure.ascx" %>
<%@ Reference Control="~/DischargeSummary/ChiefSurgeon.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHAdmissionVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHDischargeVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHPatientDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/PostOpInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/PreOpInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/RoutineInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/RoomSummary.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Discharge Summary CaseSheet</title>
    <%--  <link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function PrintDischargeSheet() {


            var prtContent = document.getElementById('PrintDischarge');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            WinPrint.close();
            return false;    
        }


        function pValidationDischarge() {

            if (document.getElementById("pid").value == '') {
                var userMsg = SListForApplicationMessages.Get("DischargeSummary\\DischargeSummaryDynamic.aspx_1");
if (userMsg != null) {
    alert(userMsg);
    return false;
}
else {
    alert('Select a discharge summary for viewing');
    return false;
}
                return false;
            }
        }

    </script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
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
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: None;">
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
                    <div class="contentdata">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div id="PrintDischarge">
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 0%" align="center">
                                <tr>
                                    <td align="center">
                                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label Style="font-family: Verdana; font-size: 12px;" ID="lblHospitalName" runat="server"
                                            Font-Bold="True" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trHeaderLine" runat="server" style="display: none;">
                                    <td>
                                        <hr style="color: Black; height: 0.5px;" />
                                    </td>
                                </tr>
                                <tr id="trTitle" runat="server" style="display: none">
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 18px" align="center">
                                        <asp:Label ID="lblTypeOfDis" runat="server" meta:resourcekey="lblTypeOfDisResource1"></asp:Label>
                                        <asp:Label ID="lblDischargeTypeName" runat="server" meta:resourcekey="lblDischargeTypeNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder1" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder2" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder3" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder4" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder4" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder5" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder5" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder6" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder6" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder7" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder7" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder8" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder8" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder9" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder9" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder10" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder10" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder11" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder11" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder12" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder12" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder13" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder13" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder14" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder14" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder15" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder15" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder16" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder16" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder18" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder18" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder17" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder17" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder19" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder19" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder20" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder20" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder21" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder21" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr id="trPlaceHolder22" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder22" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                 <tr id="trPlaceHolder23" runat="server" style="display: none">
                                    <td>
                                        <asp:PlaceHolder ID="PlaceHolder23" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="NextReviewDate" runat="server" style="display: none">
                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                        <asp:Label ID="Rs_NEXTREVIEW" Text="NEXT REVIEW -" runat="server" meta:resourcekey="Rs_NEXTREVIEWResource1"></asp:Label>
                                        <asp:Label ID="lblNextReview" runat="server" meta:resourcekey="lblNextReviewResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trReviewreason" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblRRH" runat="server" Text="REVIEW REASON -" Font-Bold="True" meta:resourcekey="lblRRHResource1"></asp:Label>
                                        <asp:Label ID="lblReviewReason" runat="server" meta:resourcekey="lblReviewReasonResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="NextReviewNotes" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_Info" Text="Always review with a scheduled appointment from the front office counter for us
                                        to serve you better." runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILE" Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)"
                                            runat="server" meta:resourcekey="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILEResource1"></asp:Label>
                                    </td>
                                </tr>
                                <%-- <tr>
                                <td align="center" colspan="4">
                                                                <asp:Button ID="btnFinish" runat="server" Text="Print" OnClientClick="javascript:" CssClass="btn"  />

                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintDischargeSheet();"
                                        value="Print" class="btn" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" />
                                </td>
                            </tr>--%>
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
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="lblSMO" runat="server" Visible="False" meta:resourcekey="lblSMOResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCI" runat="server" Visible="False" meta:resourcekey="lblCIResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="lblSMOT" runat="server" Text="Medical Duty Officer" Visible="False"
                                            meta:resourcekey="lblSMOTResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCIT" runat="server" Text="Consultant Incharge" Visible="False"
                                            meta:resourcekey="lblCITResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%" id="tdPreparedBy" runat="server">
                                        <asp:Label ID="lblPreparedByT" runat="server" Text="Prepared By:" Visible="False"
                                            meta:resourcekey="lblPreparedByTResource1"></asp:Label>
                                        <asp:Label ID="lblPreparedBy" runat="server" Visible="False" meta:resourcekey="lblPreparedByResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center" id="tdTyped" runat="server">
                                        <asp:Label ID="lblTypedByT" runat="server" Text="Typed By:" Visible="False" meta:resourcekey="lblTypedByTResource1"></asp:Label><asp:Label
                                            ID="lblTypedBy" runat="server" Visible="False" meta:resourcekey="lblTypedByResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnPrint"  runat="server" Text="Print" CssClass="btn" OnClientClick="return PrintDischargeSheet();" meta:resourcekey="btnPrintResource1"/>
                                    <%--<input type="button" name="btnPrint" id="btnPrint" onclick="PrintDischargeSheet();"
                                        value="Print" class="btn" runat="server" />--%>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click"
                                        meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
    <%--<p>
        &lt;li id=&quot;li1DSY&quot; runat=&quot;server&quot;&gt; &lt;asp:LinkButton ID=&quot;LinkDSY&quot;
        runat=&quot;server&quot; Text=&quot;Discharge Summary&quot; onclick=&quot;LinkDSY_Click&quot;
        &gt;&lt;/asp:LinkButton&gt; &lt;/li&gt;</p>--%>
</body>
</html>
