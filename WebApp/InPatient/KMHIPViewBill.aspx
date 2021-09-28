<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KMHIPViewBill.aspx.cs" Inherits="InPatient_KMHIPViewBill"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc23" %>
<%@ Register Src="~/CommonControls/IPBulkBill.ascx" TagName="IPBulkBill" TagPrefix="uc24" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>KMHIPView Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

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
        .style2
        {
            height: 16px;
        }
    </style>
</head>
<body onload="javascript: AddTHEAD('DataGrid')" oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function CallPrintRecceipt() {

            //            if (document.getElementById('chkPharmaPrint') != null) {

            //                if (document.getElementById('chkPharmaPrint').checked == true) {
            //                    if (document.getElementById('gvMedicalItems') != null)
            //                        document.getElementById('gvMedicalItems').style.display = "block";


            //                }
            //                if (document.getElementById('chkPharmaPrint').checked == false) {
            //                    if (document.getElementById('gvMedicalItems') != null)
            //                        document.getElementById('gvMedicalItems').style.display = "none";
            //                    document.getElementById('hdnPharmaShow').value = "1";
            //                }
            //            }
            //            if (document.getElementById('chkMedicalItems') != null) {
            //                if (document.getElementById('chkMedicalItems').checked == true) {
            //                    if (document.getElementById('gvNonMedicalItems') != null)
            //                        document.getElementById('gvNonMedicalItems').style.display = "none";
            //                }
            //                if (document.getElementById('chkMedicalItems').checked == false) {
            //                    if (document.getElementById('gvNonMedicalItems') != null)
            //                        document.getElementById('gvNonMedicalItems').style.display = "block";
            //                }
            //            }
            ////            if (document.getElementById('imgPlus') != null)
            ////                document.getElementById('imgPlus').style.display = "none";


            if (document.getElementById('trKmhInsuranceFooterPayment') != null)
                document.getElementById('trKmhInsuranceFooterPayment').style.display = "none";

            var prtContent = document.getElementById('printArea1');
            var prtContent1 = document.getElementById('dvBreak');
            var prtContent2 = document.getElementById('printArea2');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write(prtContent1.innerHTML);
            if (document.getElementById('chkInvBreakup').checked == true) {
                WinPrint.document.write(prtContent2.innerHTML);
            }
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
//            var prtContent1 = document.getElementById('printArea2');
//            if (document.getElementById('printArea2').visible = true) {
//                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
//                WinPrint.document.write(prtContent1.innerHTML);
//                WinPrint.document.close();
//                WinPrint.focus();
//                WinPrint.print();
//            }

        }
        function printVou(visitID) {

            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";

            var strURL = "../Billing/RefundVoucher.aspx?VID=" + visitID + "&IsPopup=Y&pType=FINALSTLMT";
            window.open(strURL, "", strFeatures, true);

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
        function fnShowInv(chkid) {
            document.getElementById('printArea2').style.display = "none";
            if (document.getElementById(chkid).checked == true) {
                document.getElementById('printArea2').style.display = "block";
                document.getElementById(chkid).Text = "Hide charges break up details";
                return false;
            }
        }
        
        
    </script>

    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />
    <input type="hidden" id="hdnIsCorporatetBill" runat="server" />
    <input type="hidden" id="hdnNeedCorpSummaryBill" value="0" runat="server" />
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper" id="imagelogo" runat="server">
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
                        <div align="center" id="printArea1" style="font-family: Verdana; font-size: 10px;
                            page-break-after: always;" runat="server">
                            <table width="95%" border="1" style="border-style: solid; border-width: 1px; border-color: Black;
                                font-size: 10px; font-family: Verdana;" cellspacing="0" cellpadding="0" align="center"
                                runat="server" id="tblBillPrint">
                                <tr id="trEnhanceMent" runat="server" style="display: none;">
                                    <td align="center">
                                        <asp:Label ID="lblEnhancementBill" runat="server" Text="Credit Bill" Font-Bold="True"
                                            Style="font-weight: 700" meta:resourcekey="lblEnhancementBillResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="Table1" width="100%" border="0" style="font-size: 10px; font-family: Verdana;"
                                            cellspacing="0" cellpadding="0" align="center" runat="server">
                                            <tr>
                                                <td colspan="5" align="center">
                                                    <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
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
                                                                    runat="server" Text="Temporary Bill" meta:resourcekey="lblTempBillResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <%-- <tr id="trMRDNo" runat="server" style="display:none;">
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap"><asp:Label ID="lblMRDNotxt" Text="MRD No" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td  width="83%" align="left" nowrap="nowrap"><asp:Label ID="lblMRDNo" runat="server" Style="font-weight: 700" ></asp:Label></td>
                                                        </tr>--%>
                                                        <tr>
                                                            <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                                <asp:Label ID="lblPatientNo" runat="server" Text="Patient No" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" class="style1">
                                                                &nbsp;:&nbsp;
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <%--<asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700"></asp:Label>--%>
                                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
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
                                                            <td align="left">
                                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <%--Patient No--%><asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
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
                                                            <td width="10%" align="left">
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
                                                    <div class="dataheaderInvCtrl" align="left" style="display: none; font-weight: bold"
                                                        id="trRoomCharges" runat="server">
                                                    </div>
                                                    <div style="padding-left: 10px">
                                                        <table cellpadding="0" style="font-family: Verdana; font-size: 10px; font-weight: bold;"
                                                            cellspacing="0" border="0" width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <asp:Label ID="charges" runat="server" Font-Underline="True" meta:resourcekey="chargesResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <%-- <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvIndentRoomType_RowDataBound" Width="98%">
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <span style="font-family: Verdana; font-size: 10px;"><b>
                                                                                        <asp:Label ID="lblFeeTypeDetails" runat="server" Text='<%#  DataBinder.Eval(Container.DataItem, "RoomTypeName") %>'></asp:Label>
                                                                                    </b></span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>--%>
                                                        <asp:GridView ID="gvIndentRoomDetails" runat="server" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvIndentRoomDetails_RowDataBound" Width="100%" GridLines="None"
                                                            HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderColor="Black" Font-Names="Verdana"
                                                            Font-Size="10px" meta:resourcekey="gvIndentRoomDetailsResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerStyle CssClass="dataheader1" />
                                                            <RowStyle CssClass="dataheaderInvCtrl" />
                                                            <Columns>
                                                                <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Descriptionx" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RoomTypeName") %>'
                                                                            meta:resourcekey="DescriptionxResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="left" />
                                                                    <ItemStyle HorizontalAlign="left" />
                                                                </asp:TemplateField>
                                                                <%--<asp:BoundField HeaderText="Description" DataField="Description">
                                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                            </asp:BoundField>--%>
                                                                <%--<asp:BoundField HeaderText="Comments" DataField="Comments" />--%>
                                                                <asp:BoundField HeaderText="From" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                                                    HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="To" DataField="ToDate" DataFormatString="{0:dd/MM/yyyy}"
                                                                    HeaderStyle-Width="15%" meta:resourcekey="BoundFieldResource5">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="UnitPrice" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                            Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                            meta:resourcekey="txtUnitPriceResource1"></asp:Label>
                                                                        <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Quantity" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                            Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                            meta:resourcekey="txtQuantityResource1"></asp:Label>
                                                                        <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Amount" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                            ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px"
                                                                            meta:resourcekey="txtAmountResource1"></asp:Label>
                                                                        <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource6" />
                                                                <asp:BoundField DataField="ReimbursableAmount" Visible="false" HeaderText="ClaimAmount" />
                                                                <asp:BoundField DataField="NonReimbursableAmount" Visible="false" HeaderText="NonClaimAmount" />
                                                                <asp:BoundField DataField="FromTable" Visible="false" HeaderText="From Table" meta:resourcekey="BoundFieldResource7" />
                                                            </Columns>
                                                        </asp:GridView>
                                                        <%--<asp:BoundField HeaderText="Description" DataField="Description">
                                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                            </asp:BoundField>--%>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trRoomLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    <br />
                                                    <div id="dvTreatmentCharges" class="" align="left" style="font-weight: bold" runat="server">
                                                        <asp:Label ID="Rs_TreatmentCharges" Text="Treatment Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"></asp:Label>
                                                    </div>
                                                    <div style="padding-left: 10px;">
                                                        <asp:GridView ID="gvTreatmentCharges" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvTreatment_RowDataBound" Width="98%" meta:resourcekey="gvTreatmentChargesResource1">
                                                            <Columns>
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <span style="font-family: Verdana; font-size: 10px;"><b>
                                                                                        <asp:Label ID="lblFeeType" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "FeeType") %>'
                                                                                            meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                                                                        <span style="text-decoration: underline;">
                                                                                            <asp:Label ID="lblFeeTypeDetails" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FeeType") %>'
                                                                                                meta:resourcekey="lblFeeTypeDetailsResource1"></asp:Label></span> </span>
                                                                                    </b>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                                                        GridLines="None" Width="100%" OnRowDataBound="gvIndents_RowDataBound" Font-Names="Verdana"
                                                                                        Font-Size="10px" meta:resourcekey="gvIndentsResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <PagerStyle CssClass="dataheader1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource8" />
                                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource9">
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource10" />
                                                                                            <%--<asp:TemplateField HeaderText="Receipt/InterimNo" >
                                                                                                <ItemTemplate>
                                                                                                
                                                                                                    <asp:Label ID="lblReceiptNo" runat="server" Style="text-align: left;" Text='<%# Eval("ReceiptInterimNo") %>'
                                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                                    
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                                <HeaderStyle HorizontalAlign="Left" Width="35%" />
                                                                                            </asp:TemplateField>--%>
                                                                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource5">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                                    <asp:HiddenField ID="hdnServiceCode" runat="server" Value='<%# Eval("ServiceCode") %>' />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                                <HeaderStyle HorizontalAlign="Left" Width="35%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField HeaderText="Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                                                                                meta:resourcekey="BoundFieldResource11">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="UnitPrice" meta:resourcekey="TemplateFieldResource6">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                                                        meta:resourcekey="txtUnitPriceResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="20%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource7">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                                                        meta:resourcekey="txtQuantityResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="10%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource8">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px"
                                                                                                        meta:resourcekey="txtAmountResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                                    <headerstyle horizontalalign="Center" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                                <HeaderStyle HorizontalAlign="Right" Width="20%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource12" />
                                                                                            <asp:BoundField DataField="FromTable" Visible="False" HeaderText="From Table" meta:resourcekey="BoundFieldResource13" />
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
                                            <tr runat="server" id="trTreatmentLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr class="dataheaderInvCtrl">
                                                <td colspan="3" id="tdpharma" runat="server" align="left">
                                                    <div id="dvpharmacy" runat="server">
                                                        <asp:Label ID="Rs_Pharmacy" Text="Pharmacy" runat="server" meta:resourcekey="Rs_PharmacyResource1"></asp:Label></div>
                                                    <br />
                                                    <asp:GridView ID="gvMedicalItems" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                        GridLines="None" Width="100%" OnRowDataBound="gvPharmacy_RowDataBound" Font-Names="Verdana"
                                                        Font-Size="10px" meta:resourcekey="gvMedicalItemsResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Left" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="7%" HeaderText="Receipt/Interim No" meta:resourcekey="TemplateFieldResource10">
                                                                <ItemTemplate>
                                                                    <%--  <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ReceiptNO") %>' meta:resourcekey="lblReceiptNoResource1"></asp:Label>--%>
                                                                    <asp:Label ID="lblReceiptNo" runat="server" Text='<%# bind("ReceiptInterimNo") %>'
                                                                        meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="7%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Description" DataField="Description" HeaderStyle-HorizontalAlign="Left"
                                                                meta:resourcekey="BoundFieldResource14">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Date" ItemStyle-Width="15%" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                                                meta:resourcekey="BoundFieldResource15">
                                                                <ItemStyle Width="15%"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField ItemStyle-Width="10%" HeaderText="Batch No" meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="10%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" HeaderText="Expiry Date" meta:resourcekey="TemplateFieldResource12">
                                                                <ItemTemplate>
                                                                    <asp:Label Text='<%# Eval("ExpiryDate") %>' ID="lblExpiryDate" runat="server" meta:resourcekey="lblExpiryDateResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="10%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Quantity" ItemStyle-Width="7%" DataField="unit" meta:resourcekey="BoundFieldResource16">
                                                                <ItemStyle Width="7%"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="UnitPrice" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                                                DataField="AMOUNT" meta:resourcekey="BoundFieldResource17">
                                                                <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                                                meta:resourcekey="TemplateFieldResource13">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="txtAmount" runat="server" Style="padding-right: 10px;" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'
                                                                        Width="60px" meta:resourcekey="txtAmountResource3"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trPharmacyLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr id="trNonMedicalItems" runat="server">
                                                <td colspan="3" align="center">
                                                    <br />
                                                    <div id="divNonMedicalHead" class="dataheaderInvCtrl" align="left" style="font-weight: bold"
                                                        runat="server">
                                                        <asp:Label ID="Rs_NonMedicalItems" Text="Non-MedicalItems" runat="server" meta:resourcekey="Rs_NonMedicalItemsResource1"></asp:Label>
                                                    </div>
                                                    <div id="divNonMedical" visible="false" runat="server" style="padding-left: 10px">
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <span style="font-family: Verdana; font-size: 10px;"><b><span style="text-decoration: underline;
                                                                        text-align: left;">
                                                                        <asp:Label ID="lblNonMedicalItem" runat="server" Text="Sum of NonMedicalItems :-"
                                                                            meta:resourcekey="lblNonMedicalItemResource1"></asp:Label>
                                                                        <asp:Label ID="lblNonMedicalDetails" runat="server" meta:resourcekey="lblNonMedicalDetailsResource1"></asp:Label>
                                                                        <asp:HiddenField ID="hdnNonMedicalDetails" runat="server" Value="0.00" />
                                                                    </span></b></span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="gvNonMedicalItems" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                                        GridLines="None" Width="100%" OnRowDataBound="gvIndents_RowDataBound" Font-Names="Verdana"
                                                                        Font-Size="10px" meta:resourcekey="gvNonMedicalItemsResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource18" />
                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource19">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource20" />
                                                                            <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                                                            <asp:TemplateField HeaderText="Description" HeaderStyle-Width="30%" meta:resourcekey="TemplateFieldResource14">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                                                        meta:resourcekey="chkIDResource2" />
                                                                                    <asp:HiddenField ID="hdnServiceCode" runat="server" Value='<%# Eval("ServiceCode") %>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderText="Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                                                                meta:resourcekey="BoundFieldResource21">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="UnitPrice" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource15">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                                        meta:resourcekey="txtUnitPriceResource3"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Quantity" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource16">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                                        meta:resourcekey="txtQuantityResource3"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Amount" HeaderStyle-Width="10%" meta:resourcekey="TemplateFieldResource17">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px"
                                                                                        meta:resourcekey="txtAmountResource4"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource22" />
                                                                            <asp:BoundField DataField="FromTable" Visible="false" HeaderText="From Table" meta:resourcekey="BoundFieldResource23" />
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
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
                                                                <asp:Label ID="Rs_GrossBillAmount" Text="Gross Bill Amount" runat="server" meta:resourcekey="Rs_GrossBillAmountResource1"></asp:Label>
                                                            </td>
                                                            <td width="10%" align="right" class="details_value">
                                                                <asp:HiddenField ID="hdnGross" runat="server" />
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee1" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee1Resource1" />
                                                                <asp:Label ID="txtGross" runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="txtGrossResource1"></asp:Label>
                                                                <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
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
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee2" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee2Resource1" />
                                                                <asp:Label ID="txtDiscount" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="txtDiscountResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trTax" runat="server">
                                                            <td align="right" colspan="2">
                                                                <asp:Label ID="Rs_Tax" Text="Tax" runat="server" meta:resourcekey="Rs_TaxResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee3" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee3Resource1" />
                                                                <asp:Label ID="txtTax" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="txtTaxResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTaxDetails" runat="server">
                                                            <td colspan="3" align="right">
                                                                <div id="dvTaxDetails" runat="server">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr id="trPreviousDue" runat="server" visible="false">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee4" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee4Resource1" />
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
                                                                <asp:Image runat="server" ID="Irupee5" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee5Resource1" />
                                                                <asp:Label ID="lblServiceCharge" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="lblServiceChargeResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trRoundOff" style="display: none" runat="server">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_RoundOff" Text="Round Off" runat="server" meta:resourcekey="Rs_RoundOffResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" ID="Irupee6" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee6Resource1" />
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
                                                                <asp:Image runat="server" ID="Irupee7" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee7Resource1" />
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
                                                        <tr id="Preauth" runat="server" style="display: none">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Label2" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" ID="Irupee8" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee8Resource1" />
                                                                <asp:Label ID="lblPreAuthAmount" Text="0.00" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
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
                                                                            runat="server" meta:resourcekey="Rs_AmountReceivedfromPatientResource1"></asp:Label></strong>
                                                                </div>
                                                                <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                                    runat="server">
                                                                    &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                    <strong>
                                                                        <asp:Label ID="Rs_AmountReceivedfromPatient1" Text="Amount Received from Patient"
                                                                            runat="server" meta:resourcekey="Rs_AmountReceivedfromPatient1Resource1"></asp:Label></strong>
                                                                </div>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee9" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee9Resource1" />
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
                                                        <tr runat="server" id="trPaidAmt">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_NonMedicalItems1" Text="Non-MedicalItems" runat="server" meta:resourcekey="Rs_NonMedicalItems1Resource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" ID="Irupee10" Height="10px" Width="10px" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee10Resource1" />
                                                                <asp:Label ID="lblPaidAmt" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblPaidAmtResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trCoPay" visible="true">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_CoPayment" Text="Co-Payment" runat="server" meta:resourcekey="Rs_CoPaymentResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee11" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee11Resource1" />
                                                                <asp:Label ID="lblCoPayment" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblCoPaymentResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trFromTPA" runat="server" style="display: none;">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="tpaDetails" runat="server" Text="Amount Received From TPA" meta:resourcekey="tpaDetailsResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee12" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee12Resource1" />
                                                                <asp:Label ID="txtThirdParty" runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="txtThirdPartyResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trTPADue" style="display: none;">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_DueFromTPA" Text="Due From TPA" runat="server" meta:resourcekey="Rs_DueFromTPAResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee13" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee13Resource1" />
                                                                <asp:Label ID="lblTPADue" runat="server" Font-Bold="True" Text="0.00" meta:resourcekey="lblTPADueResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl" runat="server" id="trGrsndTotal" style="display: none;">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Due" Text="Due" runat="server" meta:resourcekey="Rs_DueResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Image runat="server" Height="10px" Width="10px" ID="Irupee14" ImageUrl="~/Images/Indian_rupees.PNG"
                                                                    meta:resourcekey="Irupee14Resource1" />
                                                                <asp:Label ID="txtGrandTotal" Font-Bold="True" runat="server" Text="0.00" meta:resourcekey="txtGrandTotalResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtPreviousRefund" Visible="False" Font-Bold="True" runat="server"
                                                                    meta:resourcekey="txtPreviousRefundResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl">
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtRefundAmount" Visible="False" Font-Bold="True" runat="server" meta:resourcekey="txtRefundAmountResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
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
                                                            <td style="width: 14%" align="right">
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
                                                            <td style="width: 14%" align="right">
                                                                <asp:Label ID="lblInsurancePatientAmtPaidText" Font-Bold="True" Text="0.00" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right" colspan="2">
                                                                <asp:Label ID="lblInsurancePatientAdvance" Text="Advance Received from patient" runat="server"></asp:Label>
                                                            </td>
                                                            <td align="right">
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
                                    </td>
                                </tr>
                            </table>
                            <table width="90%">
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr id="trAmountInWords" runat="server">
                                                <td align="left">
                                                    <%--<asp:BoundField HeaderText="Comments" DataField="Comments" />--%>
                                                    <asp:Label ID="lblAmountinWords" runat="server" Style="font-family: Verdana; font-size: 10px"
                                                        Text="Amount received in Words:" meta:resourcekey="lblAmountinWordsResource1"></asp:Label>
                                                    <asp:Label ID="lblCurrency" runat="server" Style="font-family: Verdana; font-size: 10px"
                                                        meta:resourcekey="lblCurrencyResource1"></asp:Label>
                                                    -
                                                    <asp:Label ID="lblAmount" runat="server" Style="font-family: Verdana; font-size: 10px"
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
                                                    <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-family: Verdana; font-size: 10px"
                                                        meta:resourcekey="lblDueAmountinWordsResource1"></asp:Label>
                                                    -
                                                    <asp:Label ID="lblDueAmount" runat="server" Style="font-family: Verdana; font-size: 10px"
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
                                                <td align="left">
                                                    <asp:Label ID="lblBilledBy" runat="server"></asp:Label>
                                                </td>
                                                <td align="right" colspan="6">
                                                    <asp:Label ID="lblSignature" runat="server" Text="Authorized Signature" align="right"
                                                        Font-Bold="True" meta:resourcekey="lblSignatureResource1"></asp:Label>
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
                        <div id="dvBreak" style="page-break-before: always;" runat="server">
                            <p style="page-break-before: always;">
                            </p>
                        </div>
                        <div id="printArea2" runat="server" style="font-family: Verdana; font-size: 10px;
                            display: none;">
                            <table width="70%" align="center">
                                <tr>
                                    <td>
                                        <uc24:IPBulkBill ID="IPBulkBillcon" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table width="100%">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <div>
                            <table width="100%">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <center>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox Text="Show charges break up details" runat="server" ID="chkInvBreakup"
                                                    Style="display: none;" onClick="fnShowInv(this.id);" />
                                                <asp:CheckBox AutoPostBack="True" ID="chkPharmaPrint" runat="server" OnCheckedChanged="chkPharmaPrint_CheckedChanged"
                                                    meta:resourcekey="chkPharmaPrintResource1" />
                                                &nbsp;<asp:CheckBox AutoPostBack="True" Text="Show Only ReImbursable Items" runat="server"
                                                    ID="chkMedicalItems" Visible="False" OnCheckedChanged="chkMedicalItems_CheckedChanged"
                                                    meta:resourcekey="chkMedicalItemsResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <%--</td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>--%>
                                    <input type="button" id="btnBillPrint" runat="server" value="Print Bill" class="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onclick="CallPrintRecceipt();return false;" />
                                    <asp:Button ID="btnReceipt" Visible="False" runat="server" OnClick="btnViewReceipt_Click"
                                        Text="Print Receipt" CssClass="btn" meta:resourcekey="btnReceiptResource1" />
                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                    <asp:Button ID="btnCopayReceipt" Visible="False" runat="server" Text="Print Co-Pay Receipt"
                                        CssClass="btn" OnClick="btnCopayReceipt_Click" />
                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                    <asp:Button ID="btnViewSummary" runat="server" OnClick="btnViewSummary_Click" Text="View Summary Bill"
                                        CssClass="btn" meta:resourcekey="btnViewSummaryResource1" />
                                    <asp:Button ID="btnItemizedBill" Visible="False" runat="server" OnClick="btnItemizedBill_Click"
                                        Text="View Itemized Bill" CssClass="btn" meta:resourcekey="btnItemizedBillResource1" />
                                    <asp:Button ID="btnParentandBabyBill" Visible="false" CssClass="btn" runat="server"
                                        Text="Parent and Child Bill" OnClick="btnParentandBabyBill_Click" />
                                    <br />
                                </center>
                            </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnPharmaShow" runat="server" />
        <asp:HiddenField ID="hdnIsSurgeryPatient" runat="server" />
        <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
        <asp:HiddenField ID="hdnRoundOffType" runat="server" />
    </div>
    </form>
    <%--<asp:TemplateField HeaderText="Receipt/InterimNo" >
                                                                                                <ItemTemplate>
                                                                                                
                                                                                                    <asp:Label ID="lblReceiptNo" runat="server" Style="text-align: left;" Text='<%# Eval("ReceiptInterimNo") %>'
                                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                                    
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                                <HeaderStyle HorizontalAlign="Left" Width="35%" />
                                                                                            </asp:TemplateField>--%>
</body>
</html>
