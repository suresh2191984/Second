<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewDueDetails.aspx.cs" Inherits="Billing_ViewDueDetails"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/SecPrescriptionPage.ascx" TagName="SecPPage" TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/EsBillPrint.ascx" TagName="EsBillPrint" TagPrefix="uc16" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Due Details</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            width: 2%;
        }
    </style>

    <script language="javascript" type="text/javascript">

        function CallPrint() {
            document.getElementById('tdprint').style.display = 'none';
            var prtContent = document.getElementById('divPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            document.getElementById('tdprint').style.display = 'block';

        }
        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header" runat="server">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc10:MainHeader ID="MHead" runat="server" />
                <uc8:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc9:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        runat="server" style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata" id="divPrint" >
                        <%--<ul id="content" runat="server">
                            <asp:Label ID="lblDiagnosisHeader" runat="server" Text=""></asp:Label>
                            <li>
                                <uc12:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <table border="1" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="0" align="center">
                                    <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="0" align="center">
                                    <label style="font-family: Verdana; font-size: 14px;" id="lblHospitalName" runat="server">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td colspan="7" align="center">
                                                <asp:Label ID="lblTypeBill" Style="font-weight: bold;font-size:smaller" runat="server" meta:resourcekey="lblTypeBillResource1"></asp:Label>
                                                <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                                    runat="server" meta:resourcekey="lblDupBillResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" nowrap="nowrap" style="width: 10%">
                                                <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 3%">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 25%;">
                                                <span style="width: 23%">
                                                    <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                </span>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 10%">
                                                <label>
                                                    <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" meta:resourcekey="Rs_BillDateResource1"></asp:Label></label>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 3%">
                                                &nbsp;:
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 25%;">
                                                <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="Label1" runat="server" Text="Patient Name" 
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                               
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style1">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <span style="width: 23%">
                                                <asp:Label ID="lblTitleName" runat="server" 
                                                    Style="font-weight:bold;font-size:smaller" 
                                                    meta:resourcekey="lblTitleNameResource1"></asp:Label>
                                                    <asp:Label ID="lblName" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </span>
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                &nbsp;:&nbsp;
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 23%">
                                                <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style1">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="lblAge" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblAgeResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="Label2" runat="server" Text="Sex" 
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style1">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="lblSex" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblSexResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    meta:resourcekey="gvResultResource1">
                                                    <Columns>
                                                        <asp:BoundField DataField="Description" HeaderText="Discription" meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="Due" HeaderText="Total Due Amount" meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="Paid" HeaderText="Total Paid Due" meta:resourcekey="BoundFieldResource3" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr valign="top">
                                                        <td align="right" style="width: 70%">
                                                            <table border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                                                                <tr>
                                                                    <td align="right" valign="Middle" class="style5">
                                                                        <asp:Label ID="Rs_TotalDueAmount" Text="TotalDue Amount :" Style="font-size:smaller" runat="server" meta:resourcekey="Rs_TotalDueAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Image runat="server" ID="Irupee3" ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee3Resource1" />
                                                                        <asp:Label ID="lblGrossAmount" Style="font-size:smaller" runat="server" meta:resourcekey="lblGrossAmountResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="trServiceCharge" style="display: block;" runat="server">
                                                                    <td align="right" valign="Middle" class="style5">
                                                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :"  Style="font-size:smaller" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                                                    </td>
                                                                    <td align="right" valign="middle">
                                                                        <asp:Label ID="lblServiceCharge" runat="server"  Style="font-size:smaller" meta:resourcekey="lblServiceChargeResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="trDiscount" style="display: none;" runat="server">
                                                                    <td align="right" valign="Middle" class="style5"  Style="font-size:smaller">
                                                                        <asp:Label ID="lblDiscountPercent" runat="server" meta:resourcekey="lblDiscountPercentResource1" />&nbsp;Discount
                                                                        (-) :
                                                                    </td>
                                                                    <td align="right" valign="middle">
                                                                        <asp:Label ID="lblDiscount" runat="server"  Style="font-size:smaller" meta:resourcekey="lblDiscountResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" valign="Middle" align="right" colspan="2">
                                                                        <div id="dvTaxDetails" runat="server">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" valign="Middle" colspan="2">
                                                                        -----------------------------------
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" valign="Middle" class="style5">
                                                                        <asp:Label ID="Rs_GrandTotal" Text="Grand Total :" runat="server"  Style="font-size:smaller" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Image runat="server" ID="Irupee1" ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="Irupee1Resource1" />
                                                                        <asp:Label ID="lblGrandTotal" runat="server"  Style="font-size:smaller" meta:resourcekey="lblGrandTotalResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" colspan="2" valign="Middle">
                                                                        -----------------------------------
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" valign="Middle" class="style5">
                                                                        <asp:Label ID="Rs_AmountReceived" Text="Amount Received :" runat="server"  Style="font-size:smaller" meta:resourcekey="Rs_AmountReceivedResource1"></asp:Label>
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Image runat="server" ID="Irupee" ImageUrl="~/Images/Indian_rupees.PNG" meta:resourcekey="IrupeeResource1" />
                                                                        <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblAmountRecievedResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="trDue" runat="server" style="display: block">
                                                                    <td align="right" valign="Middle" class="style5">
                                                                        <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server"  Style="font-size:smaller" meta:resourcekey="lblCurrentVisitDueLabelResource1"></asp:Label>
                                                                        &nbsp;:
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblDueAmounttxt" runat="server"  Style="font-size:smaller" meta:resourcekey="lblDueAmounttxtResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="left">
                                                            <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblDisplayAmountResource1"></asp:Label>
                                                            <asp:Label ID="lblAmount" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblAmountResource1"></asp:Label>
                                                        </td>
                                                        <tr>
                                                            <td colspan="6" align="left">
                                                                <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblDueAmountinWordsResource1"></asp:Label>
                                                                <asp:Label ID="lblDueAmount" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblDueAmountResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%">
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td style="padding-top: 5px;">
                                                                            <asp:Label Font-Bold="True" ID="lblPayment" Text="Payment Mode" runat="server"  Style="font-size:smaller" meta:resourcekey="lblPaymentResource1"></asp:Label>
                                                                        </td>
                                                                        <%--<td align="right">
                                                                        <asp:Label ID="lblmedfort" runat="server" Text="For Sharp Sight Centre" />
                                                                    </td>--%>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="lblPaymentMode"  Style="font-size:smaller" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                                                                            <span id="lblPayMode" runat="server"></span>
                                                                        </td>
                                                                    </tr>
                                                                    <%-- <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblOtherCurrency"></asp:Label>
                                            </td>
                                        </tr>--%>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                <td colspan="6" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>--%>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdprint" align="center" colspan="2">
                                    <input type="button" id="btnPrint" onclick="CallPrint();" value="Print" class="btn" />
                                    <asp:Button ID="Cancel" runat="server" Text="Cancel" class="btn" meta:resourcekey="CancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                </tr>
                </table>
                    <uc11:Footer ID="Footer1" runat="server" />
                    </div>
    </form>
</body>
</html>
