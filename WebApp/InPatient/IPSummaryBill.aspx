<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPSummaryBill.aspx.cs" Inherits="InPatient_IPSummaryBill"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
 
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="DHEBAdd" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc23" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Summary Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .dvPrintClass
        {
            font-family: Verdana;
        }
        .style1
        {
            height: 16px;
        }
    </style>
</head>
<body id="" oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function CallPrintRecceipt() {
            var prtContent = document.getElementById('printArea1');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();

        }
    </script>

    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />
    <asp:ScriptManager ID="scrpt" runat="server">
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
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
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
                        <div align="center" id="printArea1" class="dvPrintClass">
                            <table width="100%" border="0" style="border-style: solid; border-width: 1px; border-color: Black;
                                font-size: 10px; font-family: Verdana;" cellspacing="0" cellpadding="0" align="center">
                                <tr id="trEnhanceMent" runat="server" style="display: none;">
                                    <td align="center">
                                        <asp:Label ID="lblEnhancementBill" runat="server" Font-Bold="True" Text="Credit Bill"
                                            meta:resourcekey="lblEnhancementBillResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" align="center">
                                        <asp:Label Style="font-family: Arial; font-size: medium;" Visible="False" ID="lblHospitalName"
                                            runat="server" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="dataheaderInvCtrl">
                                    <td colspan="7">
                                        <table width="100%" id="tblHeader" runat="server" border="0" cellspacing="0" cellpadding="0"
                                            style="font-family: Verdana; font-size: 10px;">
                                            <tr id="trPatientDetails" runat="server">
                                                <td>
                                                    <table runat="server" border="0" cellspacing="0" cellpadding="0"
                                                        style="font-family: Verdana; font-size: 10px;">
                                                        <tr>
                                                            <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                                <%-- Bill No--%>Patient No
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                <%--<asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700"></asp:Label>--%>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblBillDate" Text="Bill Date" runat="server" meta:resourcekey="lblBillDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <label>
                                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label></label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                </span>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <%-- Patient No--%><asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                                                    <%--<asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700"></asp:Label>--%>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="Rs_Sex" Text="Sex" runat="server" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblPhy" Text="Primary Physician " meta:resourcekey="lblPhyResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lbIPNo" Text="IP No" runat="server" meta:resourcekey="lbIPNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblIPNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblIPNoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="Label1" Text="Date of Admission" meta:resourcekey="Label1Resource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblDOA" runat="server" Style="font-weight: 700" meta:resourcekey="lblDOAResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="Label3" Text="Date of Discharge" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblDOD" runat="server" Style="font-weight: 700" meta:resourcekey="lblDODResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6">
                                                                <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr class="dataheaderInvCtrl" style="display: none;" id="trInsuranceDetails" runat="server">
                                                <td colspan="7">
                                                    <table width="98%" id="Table2" runat="server" border="0" cellspacing="0" cellpadding="0"
                                                        style="font-family: Verdana; font-size: 10px;">
                                                        <tr>
                                                            <td align="center" colspan="6">
                                                                <asp:Label Font-Size="Small" Style="font-weight: bold" ID="Label4" Visible="False"
                                                                    runat="server" Text="Temporary Bill11" meta:resourcekey="Label4Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceCoName" runat="server" Text="Insurance Co Name" meta:resourcekey="lblInsuranceCoNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceCoNameText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceCoNameTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillNo" Text="Bill No" runat="server" meta:resourcekey="lblInsuranceBillNoResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillNoText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceBillNoTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsurancePatientName" runat="server" Text="Patient Name" meta:resourcekey="lblInsurancePatientNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID="lblInsurancePatientNameText" runat="server" Style="font-weight: 700"
                                                                    meta:resourcekey="lblInsurancePatientNameTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillDate" runat="server" Text="Bill Date" meta:resourcekey="lblInsuranceBillDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInsuranceBillDateText" runat="server" Style="font-weight: 700"
                                                                        meta:resourcekey="lblInsuranceBillDateTextResource1"></asp:Label>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAgeSex" runat="server" Text="Age/Sex" meta:resourcekey="lblInsuranceAgeSexResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAgeSexText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceAgeSexTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAdmitDate" runat="server" Text="Date of Admission" meta:resourcekey="lblInsuranceAdmitDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInsuranceAdmitDateText" runat="server" Style="font-weight: 700"
                                                                        meta:resourcekey="lblInsuranceAdmitDateTextResource1"></asp:Label>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAddress" runat="server" Text="Address" meta:resourcekey="lblInsuranceAddressResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAddressText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceAddressTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceDischargeDate" Text="Date of Discharge" runat="server"
                                                                    meta:resourcekey="lblInsuranceDischargeDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceDischargeDateText" runat="server" Style="font-weight: 700"
                                                                    meta:resourcekey="lblInsuranceDischargeDateTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label runat="server" ID="lblInsuranceTPA" Text="TPA Co Name" meta:resourcekey="lblInsuranceTPAResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceTPAText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceTPATextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceRegNo" Text="Patient Reg No" runat="server" meta:resourcekey="lblInsuranceRegNoResource1"></asp:Label>
                                                                <%--<asp:Label ID="lblInsuranceRegNo" Text="Patient Reg No" runat="server"></asp:Label>--%>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceRegNoText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceRegNoTextResource1"></asp:Label>
                                                                <%--<asp:Label ID="lblInsuranceRegNoText" runat="server" Style="font-weight: 700"></asp:Label>--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceTaxNo" Text="Service Tax No" runat="server" meta:resourcekey="lblInsuranceTaxNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceTaxNoText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceTaxNoTextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblInsuranceIPNo" Text="IP No" meta:resourcekey="lblInsuranceIPNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceIPNoText" runat="server" Style="font-weight: 700" meta:resourcekey="lblInsuranceIPNoTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                            </td>
                                                        </tr>
                                                        <tr style="display: block;">
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsurancePanNo" runat="server" Text="PAN No" meta:resourcekey="lblInsurancePanNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsurancePanNoText" runat="server" Text=" - " Style="font-weight: 700"
                                                                    meta:resourcekey="lblInsurancePanNoTextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblInsurancePhysician" Text="Primary Physician " meta:resourcekey="lblInsurancePhysicianResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsurancePhysicianText" runat="server" Style="font-weight: 700"
                                                                    meta:resourcekey="lblInsurancePhysicianTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="display: none;">
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceBillPeriod" runat="server" Visible="False" Text="Bill Period"
                                                                    meta:resourcekey="lblInsuranceBillPeriodResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1" visible="false">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceBillPeriodText" runat="server" Visible="False" Style="font-weight: 700"
                                                                    meta:resourcekey="lblInsuranceBillPeriodTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="dataheaderInvCtrl">
                                    <td colspan="7" runat="server" id="tdDiagnose" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-family: Verdana;
                                            font-size: 10px;">
                                            <tr>
                                                <td>
                                                    <uc23:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                            <tr class="dataheaderInvCtrl">
                                                <td colspan="3" align="right" style="padding-left: 15px;">
                                                    <asp:GridView ID="gvPatientSummary" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        Font-Names="Verdana" Font-Size="10px" meta:resourcekey="gvPatientSummaryResource1">
                                                        <Columns>
                                                            <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                                        meta:resourcekey="chkIDResource1" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:0.00}"
                                                                meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr id="trNormalView" runat="server">
                                                <td colspan="3" style="padding-top: 10px; vertical-align: middle;">
                                                    <table cellpadding="4" class="dataheaderInvCtrl" style="vertical-align: middle; font-family: Verdana;
                                                        font-size: 10px;" cellspacing="0" border="0" width="100%">
                                                        <tr class="dataheaderInvCtrl">
                                                            <td width="22%">
                                                                &nbsp;
                                                            </td>
                                                            <td width="41%" align="right">
                                                                <asp:Label ID="Rs_GrossBillAmount" Text="Gross Bill Amount" runat="server" meta:resourcekey="Rs_GrossBillAmountResource1"></asp:Label>
                                                            </td>
                                                            <td width="10%" align="right" class="details_value">
                                                                <asp:Label ID="txtGross" runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="txtGrossResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trDiscount" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Discount" Text="Discount" runat="server" meta:resourcekey="Rs_DiscountResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtDiscount" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="txtDiscountResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trTax" runat="server">
                                                            <td align="right" colspan="2">
                                                                <asp:Label ID="Rs_Tax" Text="Tax" runat="server" meta:resourcekey="Rs_TaxResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtTax" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="txtTaxResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTaxDetails" runat="server">
                                                            <td colspan="3" align="right">
                                                                <div id="dvTaxDetails" runat="server">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr id="trPreviousDue" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtPreviousDue" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="txtPreviousDueResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trCreditDebit" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_CreditDebitCardCharge" Text="Credit/Debit Card Charge" runat="server"
                                                                    meta:resourcekey="Rs_CreditDebitCardChargeResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblServiceCharge" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="lblServiceChargeResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trRoundOff" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_RoundOff" Text="Round Off" runat="server" meta:resourcekey="Rs_RoundOffResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblRoundOff" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="lblRoundOffResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="Rs_NetBillAmount" Text="Net Bill Amount" runat="server" meta:resourcekey="Rs_NetBillAmountResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                -----------<br />
                                                                <asp:Label ID="lblTotal" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="lblTotalResource1" />
                                                                <br />
                                                                -----------
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtRecievedAdvance" Visible="False" Font-Bold="True" runat="server"
                                                                    Text="0.00" meta:resourcekey="txtRecievedAdvanceResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trAmountReceived" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <div id="divMore1" onclick="showResponses('divMore1','divMore2','divMore3',1);" style="cursor: pointer;
                                                                    display: block;" runat="server">
                                                                    &nbsp;<img id="imgPlus" src="../Images/plus.png" alt="Show" />
                                                                    <strong>
                                                                        <asp:Label ID="Rs_AmountReceivedfromPatient" Text="Amount Received from Patient"
                                                                            runat="server" meta:resourcekey="Rs_AmountReceivedfromPatientResource1"></asp:Label>
                                                                    </strong>
                                                                </div>
                                                                <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                                    runat="server">
                                                                    &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                    <strong><asp:Label ID="Rs_AmountReceivedfromPatient1" Text="Amount Received from Patient"
                                                                    runat="server" meta:resourcekey="Rs_AmountReceivedfromPatient1Resource1"></asp:Label></strong>
                                                                </div>
                                                            </td>
                                                            <td align="right">
                                                                
                                                                <asp:Label ID="txtPreviousAmountPaid" Font-Bold="True" runat="server" Text="0.00"
                                                                    meta:resourcekey="txtPreviousAmountPaidResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="divMore3" style="display: none">
                                                            <td colspan="3" align="right">
                                                                <asp:GridView ID="grdPayDetails" CellPadding="5" runat="server" ShowFooter="True"
                                                                    AutoGenerateColumns="False" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="grdPayDetails_RowDataBound"
                                                                    meta:resourcekey="grdPayDetailsResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerStyle CssClass="dataheader1" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Rno" DataField="ReceiptNO" meta:resourcekey="BoundFieldResource24" />
                                                                        <asp:BoundField HeaderText="Date" DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}"
                                                                            meta:resourcekey="BoundFieldResource25" />
                                                                        <asp:BoundField HeaderText="Description" DataField="Remarks" ItemStyle-HorizontalAlign="Left"
                                                                            meta:resourcekey="BoundFieldResource26">
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="Amount" DataField="AmtReceived" DataFormatString="{0:0.00}"
                                                                            ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource27">
                                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr id="Preauth" runat="server" style="display: none">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Label2" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblPreAuthAmount" Text="0.00" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trPaidAmt">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PaidAgainstNonMedicalItems" Text="Paid Against Non-MedicalItems"
                                                                    runat="server" meta:resourcekey="Rs_PaidAgainstNonMedicalItemsResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblPaidAmt" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblPaidAmtResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnNonMedicalDetails" runat="server" Value="0.00" />
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trCoPay">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_CoPayment" Text="Co-Payment" runat="server" meta:resourcekey="Rs_CoPaymentResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblCoPayment" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblCoPaymentResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="display: none;" runat="server" id="trAmountFromTPA">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="tpaDetails" Text="Amount Received from TPA(Includes Service Charges)"
                                                                    runat="server" meta:resourcekey="tpaDetailsResource1"></asp:Label>
                        </div>
                </td>
                <td align="right">
                    <asp:Label ID="txtThirdParty" runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="txtThirdPartyResource1" />
                </td>
            </tr>
            <tr runat="server" id="trTPADue">
                <td>
                    &nbsp;
                </td>
                <td align="right">
                    <asp:Label ID="Rs_DueFromTPA" Text="Due From TPA" runat="server" meta:resourcekey="Rs_DueFromTPAResource1"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="lblTPADue" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblTPADueResource1"></asp:Label>
                </td>
            </tr>
            <tr class="dataheaderInvCtrl" runat="server" id="trDue">
                <td>
                    &nbsp;
                </td>
                <td align="right">
                    <asp:Label ID="Rs_Due" Text="Due" runat="server" meta:resourcekey="Rs_DueResource1"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="txtGrandTotal" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="txtGrandTotalResource1" />
                </td>
            </tr>
            <%--  <tr><td colspan="3" align="right">----------------------------------------------</td></tr>--%>
            <tr>
                <%--<td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            Previous Refund
                                                        </td>--%>
                <td align="right" visible="false">
                    <asp:Label ID="txtPreviousRefund" Visible="False" Font-Bold="True" runat="server"
                        meta:resourcekey="txtPreviousRefundResource1" />
                </td>
            </tr>
            <tr class="dataheaderInvCtrl">
                <%--  <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            Amount to Refund
                                                        </td>--%>
                <td align="right" visible="false">
                    <asp:Label ID="txtRefundAmount" Visible="False" Font-Bold="True" runat="server" meta:resourcekey="txtRefundAmountResource1" />
                </td>
            </tr>
            <%-- <tr><td colspan="3" align="right">---------------------</td></tr>--%>
        </table>
        </td> </tr>
        <tr runat="server" id="trKmhInsuranceFooter" style="display: none;">
            <td style="padding-top: 10px; vertical-align: middle;">
                <table width="100%" style="font-family: Verdana; font-size: 10px;">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="Rs_GrossBillAmount1" Text="Gross Bill Amount" runat="server" meta:resourcekey="Rs_GrossBillAmount1Resource1"></asp:Label>
                        </td>
                        <td align="right" class="details_value">
                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee15" ImageUrl="~/Images/Indian_rupees.PNG"
                                meta:resourcekey="Irupee15Resource1" />
                            <asp:Label ID="ldlGross" runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="ldlGrossResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="Rs_PreAuthorizationAmount" Text="Pre Authorization Amount" runat="server"
                                meta:resourcekey="Rs_PreAuthorizationAmountResource1"></asp:Label>
                        </td>
                        <td align="right">
                            <asp:Image runat="server" ID="Irupee16" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                meta:resourcekey="Irupee16Resource1" />
                            <asp:Label ID="lblPreAutho" Text="0.00" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthoResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="Rs_CoPayment1" Text="Co-Payment" runat="server" meta:resourcekey="Rs_CoPayment1Resource1"></asp:Label>
                        </td>
                        <td align="right">
                            <asp:Image runat="server" ID="Irupee17" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                meta:resourcekey="Irupee17Resource1" />
                            <asp:Label ID="lblCoPayments" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblCoPaymentsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="Rs_ServiceTax" Text="Service Tax @10.33%" runat="server" meta:resourcekey="Rs_ServiceTaxResource1"></asp:Label>
                        </td>
                        <td align="right">
                            <asp:Image runat="server" ID="Irupee18" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                meta:resourcekey="Irupee18Resource1" />
                            <asp:Label ID="lblTax" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblTaxResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="Rs_ClaimAmount" Text="Claim Amount" runat="server" meta:resourcekey="Rs_ClaimAmountResource1"></asp:Label>
                        </td>
                        <td align="right">
                            <asp:Image runat="server" ID="Irupee19" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                meta:resourcekey="Irupee19Resource1" />
                            <asp:Label ID="lblDueTpa" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblDueTpaResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr runat="server" id="trKmhInsuranceFooterPayment" style="display: none;">
            <td>
                <table width="100%" style="font-family: Verdana; font-size: 10px;">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="lblInsurancePatientAmtPaid" Text="Amount Received from Patient(Including Advance)"
                                runat="server"></asp:Label>
                        </td>
                        <td style="width: 20%" align="right">
                            <asp:Label ID="lblInsurancePatientAmtPaidText" Font-Bold="True" Text="0.00" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td align="right" colspan="2" class="style1">
                            <asp:Label ID="lblInsurancePatientAdvance" Text="Advance Received from patient" runat="server"></asp:Label>
                        </td>
                        <td align="right" class="style1">
                            <asp:Label ID="lblInsurancePatientAdvanceText" Font-Bold="True" Text="0.00" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" colspan="2">
                            <asp:Label ID="lblInsurancePatientAmtRefund" Text="Amount Refunded to patient" runat="server"></asp:Label>
                        </td>
                        <td align="right">
                            <asp:Label ID="lblInsurancePatientAmtRefundText" Font-Bold="True" Text="0.00" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
        <table width="100%" style="font-family: Verdana; font-size: 10px;">
            <tr id="trAmountINWords" runat="server" style="display: none;">
                <td colspan="5" align="left">
                    <asp:Label ID="lblAmountinWords" runat="server" Style="font-family: Verdana; font-size: 10px;"
                        meta:resourcekey="lblAmountinWordsResource1">Amount in Words:&nbsp;(<%= CurrencyName %>)&nbsp;</asp:Label>
                    <asp:Label ID="lblAmount" runat="server" Style="font-family: Verdana; font-size: 10px;"
                        meta:resourcekey="lblAmountResource1"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr id="trDueAmount" runat="server" align="center">
                <td align="left" runat="server" id="tdDueAmount">
                    <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-family: Verdana; font-size: 10px"
                        meta:resourcekey="lblDueAmountinWordsResource1">Due Amount in Words:&nbsp;(<%= CurrencyName %>)&nbsp;</asp:Label>
                    <asp:Label ID="lblClaimAmt" runat="server" Style="font-family: Verdana; font-size: 10px"
                        meta:resourcekey="lblClaimAmtResource1"></asp:Label>
                    <asp:Label ID="lblDueAmount" runat="server" Style="font-family: Verdana; font-size: 10px"
                        meta:resourcekey="lblDueAmountResource1"></asp:Label>
                </td>
            </tr>
            <tr style="display: none;">
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td colspan="3" align="right">
                    <asp:Label ID="lblSignature" Font-Names="verdana" Font-Size="10px" runat="server"
                        Text="Signature" meta:resourcekey="lblSignatureResource1"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="lblBilledBy" runat="server"></asp:Label>
                </td>
                <td align="right" colspan="6">
                    <asp:Label ID="Label5" runat="server" Text="Authorized Signature" align="right" Font-Bold="True"
                        meta:resourcekey="lblSignatureResource1"></asp:Label>
                </td>
            </tr>
        </table>
        </td> </tr> </table>
    </div>
    <table width="100%">
        <tr>
            <td align="center">
                <%--<asp:CheckBox Text="Show Pharmacy Items" ID="chkPharmaPrint" Visible="false" runat="server" />--%>
                &nbsp;<asp:CheckBox AutoPostBack="True" Text="Show Only ReImbursable Items" runat="server"
                    ID="chkMedicalItems" OnCheckedChanged="chkMedicalItems_CheckedChanged" meta:resourcekey="chkMedicalItemsResource1" />
            </td>
        </tr>
    </table>
    <center>
        <br />
        <input type="button" id="btnBillPrint" value="PrintBill" class="btn" onmouseover="this.className='btn btnhov'"
            onmouseout="this.className='btn'" onclick="CallPrintRecceipt();return false;" />
        <asp:Button ID="btnViewSummary" runat="server" OnClick="btnViewSummary_Click" Text="View Bill With Dates"
            CssClass="btn" meta:resourcekey="btnViewSummaryResource1" />
        <asp:Button ID="btnItemizedBill" runat="server" OnClick="btnItemizedBill_Click" Visible="False"
            Text="View Itemized Bill" CssClass="btn" meta:resourcekey="btnItemizedBillResource1" />
        <br />
    </center>
    </div> </td> </tr> </table>
    <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
