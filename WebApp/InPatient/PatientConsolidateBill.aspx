<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientConsolidateBill.aspx.cs"
    Inherits="InPatient_PatientConsolidateBill" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
 
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="~/CommonControls/DynamicDHEBAdder.ascx" TagName="DHEBAdd" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc23" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>IPView Bill</title>
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
        tHead
        {
            display: table-header-group;
        }
        .style1
        {
            height: 12px;
        }
    </style>
</head>
<body onload="javascript: AddTHEAD('DataGrid')" oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function CallPrintRecceipt() {

            var prtContent = document.getElementById('printArea1');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();

        }

        function AddTHEAD(tableName) {
            var table = document.getElementById('tblBillPrint');
            if (table != null) {
                var head = document.createElement("THEAD");
                head.style.display = "table-header-group";
                head.appendChild(table.rows[0]);
                table.insertBefore(head, table.childNodes[0]);

            }
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
                        style="cursor: pointer;" runat="server" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <div align="center" id="printArea1" style="font-family: Verdana; font-size: 10px;"
                            runat="server">
                            <table width="95%" border="1" style="border-style: solid; border-width: 1px; border-color: Black;
                                font-size: 10px; font-family: Verdana;" cellspacing="0" cellpadding="0" align="center"
                                runat="server" id="tblBillPrint">
                                <tr id="trEnhanceMent" runat="server" style="display: none;">
                                    <td align="center">
                                        <asp:Label ID="lblEnhancementBill" runat="server" Text="Enhancement Credit Bill"
                                            Style="font-weight: 700" meta:resourcekey="lblEnhancementBillResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="Table1" width="100%" border="0" style="font-size: 10px; font-family: Verdana;"
                                            cellspacing="0" cellpadding="0" align="center" runat="server">
                                            <tr>
                                                <td colspan="5" align="center">
                                                    <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                                                        meta:resourcekey="imgBillLogoResource1" />
                                                    <br />
                                                    <label style="font-family: Verdana; font-size: 13px;" id="lblHospitalName" runat="server">
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr class="dataheaderInvCtrl" style="display: none;" id="trPatientDetails" runat="server">
                                                <td colspan="7">
                                                    <table width="98%" id="tblHeader" runat="server" border="0" cellspacing="0" cellpadding="0"
                                                        style="font-family: Verdana; font-size: 10px;">
                                                        <tr>
                                                            <td align="center" colspan="6">
                                                                <asp:Label Font-Size="11px" Style="font-weight: bold" ID="lblTempBill" Visible="False"
                                                                    runat="server" Text="Temporary Bill" 
                                                                    meta:resourcekey="lblTempBillResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPatientNo" runat="server" Text="Patient No" 
                                                                    meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblBillDate" Text="Bill Date" runat="server" 
                                                                    meta:resourcekey="lblBillDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
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
                                                                   <asp:Label ID="Rs_PatientName" Text="Patient Name"  runat="server" 
                                                                    meta:resourcekey="Rs_PatientNameResource1"></asp:Label></label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblNameResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <%--Patient No--%><asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" 
                                                                    meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
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
                                                                <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" 
                                                                    meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                                            </td>
                                                            
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblAgeResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="Rs_Sex" Text="Sex" runat="server" 
                                                                    meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblSexResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblPhy" Text="Primary Physician " 
                                                                    meta:resourcekey="lblPhyResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lbIPNo" Text="IP No" runat="server" 
                                                                    meta:resourcekey="lbIPNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblIPNo" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblIPNoResource1"></asp:Label>
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
                                                                <asp:Label runat="server" ID="Label1" Text="Date of Admission" 
                                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblDOA" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblDOAResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="Label3" Text="Date of Discharge" runat="server" 
                                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblDOD" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblDODResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
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
                                                                <asp:Label ID="lblInsuranceCoName" runat="server" Text="Insurance Co Name" 
                                                                    meta:resourcekey="lblInsuranceCoNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceCoNameText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceCoNameTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillNo" Text="Bill No" runat="server" 
                                                                    meta:resourcekey="lblInsuranceBillNoResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillNoText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceBillNoTextResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsurancePatientName" runat="server" Text="Patient Name" 
                                                                    meta:resourcekey="lblInsurancePatientNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID="lblInsurancePatientNameText" runat="server" 
                                                                    Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsurancePatientNameTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillDate" runat="server" Text="Bill Date" 
                                                                    meta:resourcekey="lblInsuranceBillDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInsuranceBillDateText" runat="server" 
                                                                    Style="font-weight: 700" meta:resourcekey="lblInsuranceBillDateTextResource1"></asp:Label>
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
                                                                <asp:Label ID="lblInsuranceAgeSex" runat="server" Text="Age/Sex" 
                                                                    meta:resourcekey="lblInsuranceAgeSexResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAgeSexText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceAgeSexTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAdmitDate" runat="server" Text="Date of Admission" 
                                                                    meta:resourcekey="lblInsuranceAdmitDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <span style="width: 23%">
                                                                    <asp:Label ID="lblInsuranceAdmitDateText" runat="server" 
                                                                    Style="font-weight: 700" meta:resourcekey="lblInsuranceAdmitDateTextResource1"></asp:Label>
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
                                                                <asp:Label ID="lblInsuranceAddress" runat="server" Text="Address" 
                                                                    meta:resourcekey="lblInsuranceAddressResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceAddressText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceAddressTextResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceDischargeDate" Text="Date of Discharge" 
                                                                    runat="server" meta:resourcekey="lblInsuranceDischargeDateResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceDischargeDateText" runat="server" 
                                                                    Style="font-weight: 700" 
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
                                                                <asp:Label runat="server" ID="lblInsuranceTPA" Text="TPA Co Name" 
                                                                    meta:resourcekey="lblInsuranceTPAResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceTPAText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceTPATextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceRegNo" Text="Patient Reg No" runat="server" 
                                                                    meta:resourcekey="lblInsuranceRegNoResource1"></asp:Label>
                                                                <%--<asp:Label ID="lblInsuranceRegNo" Text="Patient Reg No" runat="server"></asp:Label>--%>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                <asp:Label ID="lblInsuranceRegNoText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceRegNoTextResource1"></asp:Label>
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
                                                                <asp:Label ID="lblInsuranceTaxNo" Text="Service Tax No" runat="server" 
                                                                    meta:resourcekey="lblInsuranceTaxNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceTaxNoText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceTaxNoTextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblInsuranceIPNo" Text="IP No" 
                                                                    meta:resourcekey="lblInsuranceIPNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceIPNoText" runat="server" Style="font-weight: 700" 
                                                                    meta:resourcekey="lblInsuranceIPNoTextResource1"></asp:Label>
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
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsurancePanNo" runat="server" Text="PAN No" 
                                                                    meta:resourcekey="lblInsurancePanNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsurancePanNoText" runat="server" Text=" - " 
                                                                    Style="font-weight: 700" meta:resourcekey="lblInsurancePanNoTextResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillPeriod" runat="server" Visible="False" 
                                                                    Text="Bill Period" meta:resourcekey="lblInsuranceBillPeriodResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1" visible="false">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblInsuranceBillPeriodText" runat="server" Visible="False" 
                                                                    Style="font-weight: 700" meta:resourcekey="lblInsuranceBillPeriodTextResource1"></asp:Label>
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
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-family: Verdana;
                                            font-size: 10px;">
                                            <tr>
                                                <td colspan="3">
                                                    <br />
                                                    <div style="padding-left: 10px">
                                                        <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                            Width="98%" OnRowDataBound="gvIndentRoomType_RowDataBound" 
                                                            meta:resourcekey="gvIndentRoomTypeResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="center" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Room Charges" 
                                                                    meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <span style="font-family: Verdana; font-size: 10px;"><b>
                                                                                        <asp:Label ID="lblFeeTypeDetails" runat="server" 
                                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "RoomTypeName") %>' 
                                                                                        meta:resourcekey="lblFeeTypeDetailsResource1"></asp:Label>
                                                                                    </b></span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIndentRoomDetails" runat="server" AutoGenerateColumns="False"
                                                                                        Width="100%" GridLines="None"
                                                                                        Font-Names="Verdana" Font-Size="10px" 
                                                                                        meta:resourcekey="gvIndentRoomDetailsResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" BorderColor="Black" BorderStyle="Solid" />
                                                                                        <PagerStyle CssClass="dataheader1" />
                                                                                        <RowStyle CssClass="dataheaderInvCtrl" />
                                                                                        <Columns>
                                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                                                                meta:resourcekey="BoundFieldResource1" />
                                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                                                                meta:resourcekey="BoundFieldResource2" />
                                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                                                                meta:resourcekey="BoundFieldResource3" />
                                                                                            <asp:BoundField HeaderText="Description" DataField="Description" 
                                                                                                meta:resourcekey="BoundFieldResource4">
                                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="From" DataField="FromDate" 
                                                                                                DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource5">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="To" DataField="ToDate" 
                                                                                                DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource6">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="UnitPrice" 
                                                                                                meta:resourcekey="TemplateFieldResource1">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                        Width="60px" meta:resourcekey="txtUnitPriceResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="10%" />
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Quantity" 
                                                                                                meta:resourcekey="TemplateFieldResource2">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                                        Width="60px" meta:resourcekey="txtQuantityResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="10%" />
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Amount" 
                                                                                                meta:resourcekey="TemplateFieldResource3">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' 
                                                                                                        Width="60px" meta:resourcekey="txtAmountResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="10%" />
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                                                                meta:resourcekey="BoundFieldResource7" />
                                                                                            <asp:BoundField DataField="FromTable" Visible="False" HeaderText="From Table" 
                                                                                                meta:resourcekey="BoundFieldResource8" />
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvParentGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        HorizontalAlign="Right" Font-Names="Verdana" Font-Size="10px" RowStyle-HorizontalAlign="Right"
                                                        OnRowDataBound="gvParentGrid_RowDataBound" 
                                                        meta:resourcekey="gvParentGridResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="center" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Hospital Consolidated Bill" 
                                                                meta:resourcekey="TemplateFieldResource6">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <asp:Label ID="lblReceiptInterim" 
                                                                                    Style="font-weight: bold; font-family:Verdana;font-size:10px;" runat="server"
                                                                                   meta:resourcekey="lblReceiptInterimResource1"></asp:Label>
                                                                <%--               <%# DataBinder.Eval(Container.DataItem, "ReceiptNO")%>--%>
                                                                         <%# DataBinder.Eval(Container.DataItem, "ReceiptInterimNo")%>
                                                                                <p style="display: none;">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "Status"   )%>
                                                                                </p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvChildGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" CssClass="mytable1" Font-Names="Verdana" 
                                                                                    Font-Size="10px" meta:resourcekey="gvChildGridResource1">
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="dataheader1" BackColor="White" ForeColor="#000066" 
                                                                                        HorizontalAlign="Left" />
                                                                                    <RowStyle CssClass="dataheaderInvCtrl" />
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="Description" HeaderText="Description" 
                                                                                            meta:resourcekey="BoundFieldResource9" >
                                                                                            <ItemStyle HorizontalAlign="Left" Width="200px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="FromDate" HeaderText="Date" 
                                                                                            meta:resourcekey="BoundFieldResource10">
                                                                                            <ItemStyle HorizontalAlign="Right" Wrap="False" Width="30px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Status"
                                                                                            Visible="False" HeaderText="Status" 
                                                                                            meta:resourcekey="BoundFieldResource11" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Unit" HeaderText="Quantity" 
                                                                                            meta:resourcekey="BoundFieldResource12" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Amount" HeaderText="Rate"
                                                                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource13" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField HeaderText="Amount" 
                                                                                            meta:resourcekey="TemplateFieldResource5">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="txtAmount" runat="server" Style="padding-right: 10px;" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'
                                                                                                    Width="60px" meta:resourcekey="txtAmountResource2"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Right" Width="7%" />
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" style="padding-right: 15px; height: 25px;">
                                                                                <b>Total :
                                                                                    <asp:Label ID="LblTotvalue" runat="server" 
                                                                                    meta:resourcekey="LblTotvalueResource1"></asp:Label></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvParentPharmaGrid" runat="server" AutoGenerateColumns="False"
                                                        Width="100%" HorizontalAlign="Right" Font-Names="Verdana" Font-Size="10px" RowStyle-HorizontalAlign="Right"
                                                        OnRowDataBound="gvParentPharmaGrid_RowDataBound" 
                                                        meta:resourcekey="gvParentPharmaGridResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Pharmacy Consolidated Bill" 
                                                                meta:resourcekey="TemplateFieldResource8">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <asp:Label ID="lblPharReceiptInterim" 
                                                                                    Style="font-weight: bold; font-family:Verdana;font-size:10px;" runat="server" 
                                                                                    meta:resourcekey="lblPharReceiptInterimResource1"></asp:Label>
                                                                               <%-- <%# DataBinder.Eval(Container.DataItem, "ReceiptNO")%>--%>
                                                                                  <%# DataBinder.Eval(Container.DataItem, "ReceiptInterimNo")%>
                                                                                <p style="display: none;">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "Status"   )%>
                                                                                </p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvPharChildGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" CssClass="mytable1" Font-Names="Verdana" 
                                                                                    Font-Size="10px" meta:resourcekey="gvPharChildGridResource1">
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="dataheader1" BackColor="White" ForeColor="#000066" 
                                                                                        HorizontalAlign="Left" />
                                                                                    <RowStyle CssClass="dataheaderInvCtrl" />
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="Description" HeaderText="Description" 
                                                                                            meta:resourcekey="BoundFieldResource14" >
                                                                                            <ItemStyle HorizontalAlign="Left" Width="200px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BatchNo" HeaderText="Batch No" 
                                                                                            meta:resourcekey="BoundFieldResource15">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="40px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="FromDate" HeaderText="Date" 
                                                                                            meta:resourcekey="BoundFieldResource16">
                                                                                            <ItemStyle HorizontalAlign="Right" Wrap="False" Width="30px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Status"
                                                                                            Visible="False" HeaderText="Status" 
                                                                                            meta:resourcekey="BoundFieldResource17" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Unit" HeaderText="Quantity" 
                                                                                            meta:resourcekey="BoundFieldResource18" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Amount" HeaderText="Rate"
                                                                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource19" >
                                                                                            <ItemStyle HorizontalAlign="Right" Width="15px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField HeaderText="Amount" 
                                                                                            meta:resourcekey="TemplateFieldResource7">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="txtAmount" runat="server" Style="padding-right: 10px;" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'
                                                                                                    Width="60px" meta:resourcekey="txtAmountResource3"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Right" Width="7%" />
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" style="padding-right: 15px; height: 25px;">
                                                                                <b>Total :
                                                                                    <asp:Label ID="LblPharTotvalue" runat="server" 
                                                                                    meta:resourcekey="LblPharTotvalueResource1"></asp:Label></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="7">
                                                    <div class="dataheaderInvCtrl" align="left" style=" font-size:14px; font-weight: bold"
                                                        id="trRoomCharges" runat="server">
                                                        <asp:Label style="text-align:center;" ID="lblSummaryBill" runat="server" 
                                                            Text="Summary Bill" meta:resourcekey="lblSummaryBillResource1"></asp:Label>
                                                    </div>
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                        <tr class="dataheaderInvCtrl">
                                                            <td colspan="3" align="right" style="padding-left: 15px;">
                                                                <asp:GridView ID="gvPatientSummary" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    Font-Names="Verdana" Font-Size="10px" 
                                                                    meta:resourcekey="gvPatientSummaryResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Center" />
                                                                    <Columns>
                                                                        <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                                                        <asp:TemplateField HeaderText="Description" 
                                                                            meta:resourcekey="TemplateFieldResource9">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="chkID" runat="server" Style="text-align: left;" 
                                                                                    Text='<%# Eval("Description") %>' meta:resourcekey="chkIDResource1" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource20">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trNonMedicalLine">
                                                            <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trAmountDetails">
                                                            <td colspan="3" style="padding-top: 10px; vertical-align: middle;">
                                                                <table cellpadding="4" class="dataheaderInvCtrl" style="vertical-align: middle; font-family: Verdana;
                                                                    font-size: 10px;" cellspacing="0" border="0" width="100%">
                                                                    <tr class="dataheaderInvCtrl">
                                                                        <td width="22%">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td width="41%" align="right">
                                                                            Gross Bill Amount
                                                                        </td>
                                                                        <td width="10%" align="right" class="details_value">
                                                                            <asp:HiddenField ID="hdnGross" runat="server" />
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee1" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee1Resource1" />
                                                                            <asp:Label ID="txtGross" runat="server" Text="0.00" Font-Bold="True" 
                                                                                meta:resourcekey="txtGrossResource1"></asp:Label>
                                                                            <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trDiscount" style="display: none;" runat="server">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Discount
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee2" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee2Resource1" />
                                                                            <asp:Label ID="txtDiscount" runat="server" Font-Bold="True" Text="0.00" 
                                                                                meta:resourcekey="txtDiscountResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trTax" style="display: none;" runat="server">
                                                                        <td align="right" colspan="2">
                                                                            Tax
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee3" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee3Resource1" />
                                                                            <asp:Label ID="txtTax" runat="server" Font-Bold="True" Text="0.00" 
                                                                                meta:resourcekey="txtTaxResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trTaxDetails" runat="server">
                                                                        <td colspan="3" align="right">
                                                                            <div id="dvTaxDetails" runat="server">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPreviousDue" style="display: none;" runat="server">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Previous Due
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee4" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee4Resource1" />
                                                                            <asp:Label ID="txtPreviousDue" Font-Bold="True" runat="server" Text="0.00" 
                                                                                meta:resourcekey="txtPreviousDueResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trCreditDebit" style="display: none;" runat="server">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Credit/Debit Card Charge
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" ID="Irupee5" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee5Resource1" />
                                                                            <asp:Label ID="lblServiceCharge" Font-Bold="True" runat="server" Text="0.00" 
                                                                                meta:resourcekey="lblServiceChargeResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trRoundOff" style="display: none;" runat="server">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Round Off
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" ID="Irupee6" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee6Resource1" />
                                                                            <asp:Label ID="lblRoundOff" Font-Bold="True" runat="server" Text="0.00" 
                                                                                meta:resourcekey="lblRoundOffResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="dataheaderInvCtrl">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right" valign="middle">
                                                                            Net Bill Amount
                                                                        </td>
                                                                        <td align="right">
                                                                            -----------<br />
                                                                            <asp:Image runat="server" ID="Irupee7" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee7Resource1" />
                                                                            <asp:Label ID="lblTotal" Font-Bold="True" runat="server" Text="0.00" 
                                                                                meta:resourcekey="lblTotalResource1" />
                                                                            <br />
                                                                            -----------
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trAdvance" style="display: none;" runat="server" class="dataheaderInvCtrl">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right" valign="middle">
                                                                            <asp:Label ID="lblAdvance" runat="server" Text="Advance Received From Patient" 
                                                                                meta:resourcekey="lblAdvanceResource1"></asp:Label>
                                                                        </td>
                                                                        <td align="right">
                                                                            -----------<br />
                                                                            <asp:Image runat="server" ID="Irupee8" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee8Resource1" />
                                                                            <asp:Label ID="txtRecievedAdvance" Visible="False" Font-Bold="True" runat="server"
                                                                                Text="0.00" meta:resourcekey="txtRecievedAdvanceResource1" />
                                                                            <br />
                                                                            -----------
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="Preauth" runat="server" style="display: none">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label2" runat="server" Text="Pre Authorization Amount :" 
                                                                                Font-Bold="True" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" ID="Irupee15" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee15Resource1" />
                                                                            <asp:Label ID="lblPreAuthAmount" Text="0.00" runat="server" Font-Bold="True" 
                                                                                meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
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
                                                                                <strong>Amount Received from Patient</strong>
                                                                            </div>
                                                                            <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                                                runat="server">
                                                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                                <strong>Amount Received from Patient</strong>
                                                                            </div>
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee9" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee9Resource1" />
                                                                            <asp:Label ID="txtPreviousAmountPaid" Font-Bold="True" runat="server" 
                                                                                Text="0.00" meta:resourcekey="txtPreviousAmountPaidResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="divMore3" style="display: none">
                                                                        <td colspan="3" align="right">
                                                                            <asp:GridView ID="grdPayDetails" CellPadding="5" runat="server" ShowFooter="True"
                                                                                AutoGenerateColumns="False" Font-Names="Verdana" Font-Size="10px"
                                                                                OnRowDataBound="grdPayDetails_RowDataBound" 
                                                                                meta:resourcekey="grdPayDetailsResource1">
                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                <PagerStyle CssClass="dataheader1" />
                                                                                <Columns>
                                                                                    <asp:BoundField HeaderText="Rno" DataField="ReceiptNO" 
                                                                                        meta:resourcekey="BoundFieldResource21" />
                                                                                    <asp:BoundField HeaderText="Date" DataField="CreatedAt" 
                                                                                        DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource22" />
                                                                                    <asp:BoundField HeaderText="Description" DataField="Remarks" 
                                                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource23" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField HeaderText="Amount" DataField="AmtReceived" DataFormatString="{0:0.00}"
                                                                                        ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource24" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPreviousRefund" runat="server" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Label ID="lblPreviousRefund" Text="Previous Amount Refund" Font-Bold="True"
                                                                                runat="server" meta:resourcekey="lblPreviousRefundResource1" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" ID="Image1" Height="10px" Width="10px" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Image1Resource1" />
                                                                            <asp:Label ID="txtPreviousRefund" Text="0.00" Font-Bold="True" runat="server" 
                                                                                meta:resourcekey="txtPreviousRefundResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="dataheaderInvCtrl">
                                                                        <td align="right" visible="false">
                                                                            <asp:Label ID="txtRefundAmount" Visible="False" Font-Bold="True" runat="server" 
                                                                                meta:resourcekey="txtRefundAmountResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" id="trPaidAmt" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Non-MedicalItems
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" ID="Irupee10" Height="10px" Width="10px"
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" 
                                                                                meta:resourcekey="Irupee10Resource1" />
                                                                            <asp:Label ID="lblPaidAmt" runat="server" Font-Bold="True" Text="0.00" 
                                                                                meta:resourcekey="lblPaidAmtResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" id="trCoPay" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Co-Payment
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee11"
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" 
                                                                                meta:resourcekey="Irupee11Resource1" />
                                                                            <asp:Label ID="lblCoPayment" runat="server" Font-Bold="True" Text="0.00" 
                                                                                meta:resourcekey="lblCoPaymentResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trTpaDetails" runat="server" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Label ID="tpaDetails" runat="server" Text="Amount Received From TPA" 
                                                                                meta:resourcekey="tpaDetailsResource1"></asp:Label>
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee12" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee12Resource1" />
                                                                            <asp:Label ID="txtThirdParty" runat="server" Text="0.00" Font-Bold="True" 
                                                                                meta:resourcekey="txtThirdPartyResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" id="trTPADue" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Due From TPA
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee13" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee13Resource1" />
                                                                            <asp:Label ID="lblTPADue" runat="server" Font-Bold="True" Text="0.00" 
                                                                                meta:resourcekey="lblTPADueResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="dataheaderInvCtrl" runat="server" id="trGrsndTotal" style="display: none;">
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td align="right">
                                                                            Due
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee14" 
                                                                                ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee14Resource1" />
                                                                            <asp:Label ID="txtGrandTotal" Font-Bold="True" runat="server" Text="0.00" 
                                                                                meta:resourcekey="txtGrandTotalResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="100%">
                                            <tr>
                                                <td align="left">
                                                    <table>
                                                        <tr id="trAmountInWords" runat="server">
                                                            <td align="left">
                                                                <asp:Label ID="lblAmountinWords" runat="server" Style="font-family: Verdana; font-size: 10px"
                                                                    Text="Amount received in Words:" 
                                                                    meta:resourcekey="lblAmountinWordsResource1"></asp:Label>
                                                                <asp:Label ID="lblCurrency" runat="server" 
                                                                    Style="font-family: Verdana; font-size: 10px" 
                                                                    meta:resourcekey="lblCurrencyResource1"></asp:Label>
                                                                -
                                                                <asp:Label ID="lblAmount" runat="server" 
                                                                    Style="font-family: Verdana; font-size: 10px" 
                                                                    meta:resourcekey="lblAmountResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td width="30%">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="trDueAmountinWords" runat="server" style="display: none;">
                                                            <td align="left" runat="server" id="tdDueAmount">
                                                                <asp:Label ID="lbldueamt" runat="server" Style="font-family: Verdana; font-size: 10px"
                                                                    Text="Due Amount in Words:" meta:resourcekey="lbldueamtResource1"></asp:Label>
                                                                <asp:Label ID="lblDueAmountinWords" runat="server" 
                                                                    Style="font-family: Verdana; font-size: 10px" 
                                                                    meta:resourcekey="lblDueAmountinWordsResource1"></asp:Label>
                                                                -
                                                                <asp:Label ID="lblDueAmount" runat="server" 
                                                                    Style="font-family: Verdana; font-size: 10px" 
                                                                    meta:resourcekey="lblDueAmountResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="10px">
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="lblSignature" runat="server" Text="Signature" align="right" 
                                                                    meta:resourcekey="lblSignatureResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trmedfortfooter" runat="server">
                                                            <td>
                                                                <div id="medfortfooter" style="height: auto;" runat="server">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                        </div>
                        <div>
                            <center>
                                <input type="button" id="btnBillPrint" runat="server" value="Print Bill" class="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onclick="CallPrintRecceipt();return false;" />
                            </center>
                        </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnPharmaShow" runat="server" />
    </div>
    </form>
</body>
</html>
