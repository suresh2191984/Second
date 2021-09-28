<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DaywiseAdmissionDischargeRpt.aspx.cs"
    Inherits="Reports_DaywiseAdmissionDischargeRpt" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Day Wise Admission Discharge Report</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script runat="server">
        decimal TotalUnitPrice;
        decimal GetAmount(decimal Price)
        {
            if (Price != 0)
            {
                TotalUnitPrice += Price;
            }
            else
            {
                Price = 0;
            }
            return Price;
        }
        decimal GetTotal()
        {
            return TotalUnitPrice;
        }
        //advance for ip 
        decimal AdvanceIP;
        decimal GetAdvance(decimal adv)
        {
            if (adv != 0)
            {
                AdvanceIP += adv;
            }
            else
            {
                adv = 0;
            }
            return adv;
        }
        decimal GetAdvAmt()
        {
            return AdvanceIP;
        }

        decimal Refund;
        decimal GetRefund(decimal refund)
        {
            if (refund != 0)
            {
                Refund += refund;
            }
            else
            {
                refund = 0;
            }
            return refund;
        }
        decimal GetRefundAmt()
        {
            return Refund;
        }



        decimal Advanceinhand;
        decimal GetAdvHand(decimal hand)
        {

            if (hand < 0)
            {
                hand = 0;
            }

            if (hand != 0)
            {
                Advanceinhand += hand;
            }
            else
            {
                hand = 0;
            }
            return hand;
        }
        decimal GetAdvHandAmt()
        {

            return Advanceinhand;
        }


        //---------------------------
        //For Due --
        decimal Due;
        decimal GetDue(decimal due)
        {
            if (due != 0)
            {
                Due += due;
            }
            else
            {
                due = 0;
            }
            return due;
        }
        decimal GetDueAmt()
        {
            return Due;
        }

        //---------------

        //For Cash ...
        decimal Cash;
        decimal GetCash(decimal cash)
        {
            if (cash != 0)
            {
                Cash += cash;
            }
            else
            {
                cash = 0;
            }
            return cash;
        }
        decimal GetCashAmt()
        {
            return Cash;
        }

        //-----
        decimal Cards;
        decimal Getcard(decimal card)
        {
            if (card != 0)
            {
                Cards += card;
            }
            else
            {
                card = 0;
            }
            return card;
        }
        decimal GetcardAmt()
        {
            return Cards;
        }
        decimal TotalUnitPriceIP;
        decimal GetAmountIP(decimal Price)
        {
            TotalUnitPriceIP += Price;
            return Price;
        }
        decimal GetTotalIP()
        {
            return TotalUnitPriceIP;
        }
        decimal PreAuthamtIP;
        decimal GetPreAuthAmtIP(decimal preauthamt)
        {
            if (preauthamt != 0)
            {

                PreAuthamtIP += preauthamt;
            }
            else
            {
                PreAuthamtIP = 0;
            }
            return preauthamt;
        }
        decimal GetPreAuthAmtIP()
        {

            return PreAuthamtIP;
        }
        decimal CoPayment;
        decimal GetCoPayment(decimal copayment)
        {
            if (copayment != 0)
            {

                CoPayment += copayment;
            }
            else
            {
                copayment = 0;
            }
            return copayment;
        }
        decimal GetCoPaymentAmt()
        {

            return CoPayment;
        }
        decimal CoPercent;
        decimal GetCoPercent(decimal copercent)
        {
            if (copercent != 0)
            {

                CoPercent += copercent;
            }
            else
            {
                copercent = 0;
            }
            return copercent;
        }
        decimal GetCoPercentAmt()
        {

            return CoPercent;
        }
        decimal TotalAmounts;
        decimal GetSettlement(decimal totamt)
        {
            if (totamt != 0)
            {
                TotalAmounts += totamt;
            }
            else
            {
                totamt = 0; 
            }
            return totamt;
        }
        decimal GetSettlementAmount()
        {
            return TotalAmounts;
        }
        decimal MedicalAmtIP;
        decimal GetMedicalAmt(decimal medicalamt)
        {
            if (medicalamt != 0)
            {
                MedicalAmtIP += medicalamt;
            }
            else
            {
                medicalamt = 0;
            }
            return medicalamt;
        }
        decimal GetMedicalAmtIP()
        {
            return MedicalAmtIP;
        }
        decimal NonMedicalAmtIP;
        decimal GetNonMedicalIP(decimal nonmedicalamt)
        {
            if (nonmedicalamt != 0)
            {
                NonMedicalAmtIP += nonmedicalamt;
            }
            else
            {
                nonmedicalamt = 0;
            }

            return nonmedicalamt;
        }
        decimal GetNonMedicalAmtIP()
        {
            return NonMedicalAmtIP;
        }
        //------------------
        decimal ExcessAmount;
        decimal GetExcess(decimal excess)
        {
            if (excess != 0)
            {
                ExcessAmount += excess;
            }
            else
            {
                excess = 0;
            }
            return excess;
        }
        decimal GetExcessAmt()
        {
            return ExcessAmount;
        }


        //-----------------
        decimal TaxAmount;
        decimal GetTax(decimal tax)
        {
            if (tax != 0)
            {
                TaxAmount += tax;
            }
            else
            {
                tax = 0;
            }
            return tax;
        }
        decimal GetTaxAmt()
        {
            return TaxAmount;
        }

        // service charge ...
        decimal Servicecharge;
        decimal GetService(decimal service)
        {
            if (service != 0)
            {
                Servicecharge += service;
            }
            else
            {
                service = 0;
            }
            return service;
        }
        decimal GetServiceAmt()
        {
            return Servicecharge;
        }



        decimal ItemAmount;
        decimal GetAR(decimal diff)
        {
            if (diff != 0)
            {
                ItemAmount += diff;
            }
            else
            {
                diff = 0;
            }
            return diff;
        }
        decimal GetARvalue()
        {
            return ItemAmount;
        }
        
        
    </script>

    <script runat="server">
        decimal discount;
        decimal GetDiscount(decimal Price)
        {
            if (Price != 0)
            {
                discount += Price;
            }
            else
            {
                Price = 0;
            }
            return Price;
        }
        decimal GetDiscountamt()
        {
            return discount;
        }


        decimal NetValue;
        decimal GetNet(decimal netvalue)
        {
            if (netvalue != 0)
            {
                NetValue += netvalue;
            }
            else
            {
                netvalue = 0;
            }
            return netvalue;
        }
        decimal GetNetamt()
        {
            return NetValue;
        }
       
       
    </script>

    <script runat="server">
        decimal GrossBill;
        decimal GetGrossBill(decimal gross)
        {
            if (gross != 0)
            {
                GrossBill += gross;
            }
            else
            {
                gross = 0;
            }
            return gross;
        }
        decimal GetGrossBillValue()
        {
            return GrossBill;
        }
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }

        decimal Cheque;
        decimal Getcheque(decimal cheque)
        {
            if (cheque != 0)
            {
                Cheque += cheque;
            }
            else
            {
                cheque = 0;
            }
            return cheque;
        }
        decimal GetChequeAmt()
        {
            return Cheque;
        }

        //for total amount



        decimal totalamt;
        decimal GetTotala(decimal total)
        {
            if (total != 0)
            {
                totalamt += total;

            }
            else
            {
                total = 0;
            }
            return total;
        }
        decimal GetTotalAmt()
        {
            return totalamt;
        }
        
        
        //-------------------
        decimal Draft;
        decimal GetDraft(decimal draft)
        {
            if (draft != 0)
            {
                Draft += draft;
            }
            else
            {
                draft = 0;
            }
            return draft;
        }
        decimal GetDraftAmt()
        {
            return Draft;
        }
        decimal CreditDue;
        decimal GetCredit(decimal creditdue)
        {
            if (creditdue != 0)
            {
                CreditDue += creditdue;
            }
            else
            {
                creditdue = 0;
            }
            return creditdue;
        }
        decimal GetCreditAmt()
        {
            return CreditDue;
        }
    </script>

    <script runat="server">
       

       
        decimal CreditDueIP;
        decimal GetCreditIP(decimal creditdue)
        {
            CreditDueIP += creditdue;
            return CreditDueIP;
        }
        decimal GetCreditAmtIP()
        {
            return CreditDueIP;
        }
        decimal DraftIP;
        decimal GetDraftIP(decimal draft)
        {
            DraftIP += draft;
            return DraftIP;
        }
        decimal GetDraftAmtIP()
        {
            return DraftIP;
        }
        
       

       
       
    </script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }


        function ShowColumns(obj) {
            $("#pnlColumns").slideToggle("slow");
            $("#lnkBtnSaveTemplate").slideToggle("slow");
            if (obj.value != "Hide") {
                obj.value = "Hide";
            }
            else {
                obj.value = "Show";
            }
        }
        function ChangeSecImage() {
        }

        // Check box - payment types
        function checkallPT() {

            if (document.getElementById('chkp').checked == true) {

                for (var i = 0; i <= 3; i++) {


                    var listitem = "ChkLstColumns_" + i;
                    document.getElementById(listitem).checked = true;


                }
            } else {
                for (var i = 0; i <= 3; i++) {


                    var listitem = "ChkLstColumns_" + i;
                    document.getElementById(listitem).checked = false;
                }
            }

        }



        // Check box - TPA Details 
        function checkallTPA() {

            if (document.getElementById('chkt').checked == true) {

                for (var i = 0; i <= 5; i++) {


                    var listitem = "ChkLstColumns1_" + i;
                    document.getElementById(listitem).checked = true;


                }
            } else {
                for (var i = 0; i <= 5; i++) {


                    var listitem = "ChkLstColumns1_" + i;
                    document.getElementById(listitem).checked = false;
                }
            }

        }

        // Check box - Other Details 
        function checkallOthers() {

            if (document.getElementById('chko').checked == true) {

                for (var i = 0; i <= 3; i++) {


                    var listitem = "ChkLstColumns2_" + i;
                    document.getElementById(listitem).checked = true;


                }
            } else {
                for (var i = 0; i <= 3; i++) {


                    var listitem = "ChkLstColumns2_" + i;
                    document.getElementById(listitem).checked = false;
                }
            }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSubmit">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr>
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl" width="100%" border="0">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_Date" Text="From Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtFDateResource1" ></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                
                                                    <asp:Label ID="Rs_SelectReportType" Text="Select Report Type:" runat="server" meta:resourcekey="Rs_SelectReportTypeResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlselect" runat="server" onchange="rblhide()" meta:resourcekey="ddlselectResource1">
                                                        <asp:ListItem Text="OP" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Selected="True" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                   
                                                </td>
                                                <td id="rbl" runat="server">
                                                <table border ="1" >
                                                <tr >
                                                <td>
                                                
                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Admitted" Value="Admitted" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Text="Discharged" Value="Discharged" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        <asp:ListItem Text="Both" Value="" Selected ="True"  meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                     </td>
                                                    </tr>
                                                    </table>
                                                </td>
                                               
                                                 <td></td>
                                                <td>
                                                 <table border ="1">
                                                <tr>
                                                <td>
                                                <asp:RadioButtonList ID="Rbltypeofpatient" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Credit" Value="Credit"></asp:ListItem>
                                                        <asp:ListItem Text="Cash" Value="Cash" ></asp:ListItem>
                                                        <asp:ListItem Text="Credit&Cash" Value="Creditandcash" Selected ="True"  ></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                      </td>
                                                    </tr>
                                                    </table>
                                                 <%--<asp:RadioButton ID ="rdocredit" Text ="Credit Bill" runat="server" />
                                                 <asp:RadioButton ID ="rdocash" Text ="Cash Bill" runat="server" />
                                                 <asp:RadioButton ID ="rdoboth" Text ="Credit&Cash" runat="server" />--%>
                                                    
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <%--   <td>
                                                    <asp:LinkButton ID="lnkXL" Text="Export" runat="server" OnClick="lnkXL_Click"></asp:LinkButton>
                                                </td>--%>
                                                <%-- <td><asp:HiddenField ID ="hdnpay" runat ="server" /></td> 
                                                        <td> <asp:HiddenField ID="hdntpa" runat ="server" /></td> 
                                                        <td> <asp:HiddenField ID="hdnothers" runat ="server" /></td> 
                                                   --%>
                                                <%--<td>
                                                        <asp:CheckBox ID="chkTPA" Text="TPA Details" runat="server" />
                                                        <asp:CheckBox ID="chkPayment" Text="PaymentMode" runat="server" />
                                                    </td>--%>
                                                <td align="right">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                   
                                                    <tr>
                                                        
                                                       <%-- <td align="right">
                                         
                                                        </td>--%>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pHeader" runat="server" CssClass="">
                            <table border="0" class="cpHeader">
                                <tr>
                                    <td>
                                        <asp:Image ID="ImgCollapse" runat="server" />
                                        <asp:Label ID="lblText" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pBody" runat="server">
                            <%--    <div style="height:100px;position:absolute;top:50%;margin-top:-50px;">--%>
                            <table title="PaymentTypes" border="0" width="50%">
                                <tr>
                                    <td valign="top">
                                        <asp:CheckBox ID="chkp" Text="PaymentTypes" runat="server" onclick="checkallPT()" />
                                        <asp:CheckBoxList ID="ChkLstColumns" runat="server">
                                            <asp:ListItem Text="Card" Value="Card"></asp:ListItem>
                                            <%--  <asp:ListItem Text="Credit/Debit" Value="Credit/DebitCard"></asp:ListItem>--%>
                                            <asp:ListItem Text="Cash" Value="Cash">
                                            </asp:ListItem>
                                            <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                                            <asp:ListItem Text="DD" Value="Drafts"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                    <td valign="top">
                                        <asp:CheckBox ID="chkt" Text="TPADetails" runat="server" onclick="checkallTPA()" />
                                        <asp:CheckBoxList ID="ChkLstColumns1" runat="server">
                                            <asp:ListItem Text="PreAuthAmount" Value="PreAuthAmount"></asp:ListItem>
                                            <asp:ListItem Text="ServiceTAx" Value="ServiceTAx">
                                            </asp:ListItem>
                                            <asp:ListItem Text="ClaimAmt" Value="ClaimAmt"></asp:ListItem>
                                            <asp:ListItem Text="BillDispatchDate" Value="BillDispatchDate"></asp:ListItem>
                                            <asp:ListItem Text="ClaimReceivedDate" Value="TPASettlementDate"></asp:ListItem>
                                            <asp:ListItem Text="ARAgeing" Value="ARAgeing"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                    <td valign="top">
                                        <asp:CheckBox ID="chko" Text="Others" runat="server" onclick="checkallOthers()" />
                                        <asp:CheckBoxList ID="ChkLstColumns2" runat="server">
                                            <asp:ListItem Text="Reimbursable" Value="ReimbursableAmt"></asp:ListItem>
                                            <asp:ListItem Text="NonReimbursable" Value="NonReimbursableAmt">
                                            </asp:ListItem>
                                            <asp:ListItem Text="CoPayment" Value="CoPayment"></asp:ListItem>
                                            <asp:ListItem Text="CoPercent" Value="CoPercent"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnUpdateFilter" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" Text="Ok" OnClick="btnUpdateFilter_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <ajx:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                            CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="true" TextLabelID="lblText"
                            CollapsedText="ShowOtherFields " ExpandedText="HideOtherFields" ImageControlID="ImgCollapse"
                            ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg">
                        </ajx:CollapsiblePanelExtender>
                        <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                <asp:Label ID="Rs_Pleasewait" Text="Please wait.... " runat="server" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <%--<div id="divOPDWCR" runat="server" style="display: block;">--%>
                        <div id="prnReport" style="font-family: Arial; text-decoration: none;">
                            <%-- <asp:UpdatePanel ID ="updategridview" runat ="server" >
                                    <ContentTemplate >--%>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="false" Visible="False"
                                            HeaderStyle-Height="25px" FooterStyle-Height="25px" CellPadding="1" ShowFooter="True"
                                            Width="100%" HorizontalAlign="Right" BorderStyle="Ridge" EnableViewState="true">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-HorizontalAlign="Right">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientName" HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Age" HeaderText="Age">
                                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No" ItemStyle-HorizontalAlign="Right">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BillDate" HeaderText="Bill Date" ItemStyle-HorizontalAlign="Right">
                                                </asp:BoundField>
                                                <asp:BoundField DataFormatString="{0:dd/MM/yyyy}" DataField="DoAdmission" HeaderText="DOA"
                                                    ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
                                                <asp:TemplateField HeaderText="DOD" ItemStyle-HorizontalAlign="Right" Visible="true">
                                                    <ItemTemplate>
                                                        <%# GetDate(DataBinder.Eval(Container.DataItem,"DoDischarge","{0:dd/MM/yyyy}").ToString())%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="GrossBill" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%# GetTotala(decimal.Parse(Eval("TotalAmount").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetTotalAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%# GetDiscount(decimal.Parse(Eval("Discount").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetDiscountamt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                               <%-- <asp:TemplateField HeaderText="TaxAmount" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%# GetTax(decimal.Parse(Eval("TaxAmount").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetTaxAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>--%>
                                                <%-- <asp:TemplateField HeaderText="ServiceCharge" ItemStyle-HorizontalAlign="Right"  Visible ="true">
                                                    <ItemTemplate>
                                                        <%# GetService(decimal.Parse(Eval("ServiceCharge").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetServiceAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="NetValue" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                        <%# GetNet(decimal.Parse(Eval("NetValue").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetNetamt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Received Amount" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                        <%# GetAmount(decimal.Parse(Eval("ReceivedAmount").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string) " "+ GetTotal() %>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Advance" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                        <%# GetAdvance(decimal.Parse(Eval("AdvancePaid").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetAdvAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Due" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                        <%# GetDue(decimal.Parse(Eval("Due").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetDueAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="AdvanceInHand" ItemStyle-HorizontalAlign="Right" Visible="true">
                                                    <ItemTemplate>
                                                        <%# GetAdvHand(decimal.Parse(Eval("DepositUsed").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetAdvHandAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Refund" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%# GetRefund(decimal.Parse(Eval("AmountRefund").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetRefundAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="BillDispatchDate" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "OrderedDate", "{0:dd/MM/yyyy}").ToString())%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="TPASettlementDate" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "DateofSurgery", "{0:dd/MM/yyyy}").ToString())%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:BoundField ItemStyle-Width="25px" DataFormatString="{0:dd/MM/yyyy}" DataField="OrderedDate"
                                                    Visible="false" HeaderText="ClaimForwardDate" ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle Width="25px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField ItemStyle-Width="25px" DataFormatString="{0:dd/MM/yyyy}" DataField="DateofSurgery"
                                                    Visible="false" HeaderText="TPASettlementDate" ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle Width="25px"></ItemStyle>
                                                </asp:BoundField>--%>
                                                <asp:BoundField ItemStyle-Width="25px" DataField="VisitState" HeaderText="VisitState"
                                                    Visible="true" ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle Width="25px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField ItemStyle-Width="25px" DataField="IsCreditBill" Visible="true" HeaderText="IsCreditBill"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField ItemStyle-Width="25px" DataField="ReceivedAmount" Visible="false"
                                                    HeaderText="ReceivedAmount" ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="ClaimAmt" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetCreditIP(decimal.Parse(Eval("CreditDue").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetCreditAmtIP()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Cash" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetCash(decimal.Parse(Eval("Cash").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"" + GetCashAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:BoundField ItemStyle-Width="25px" DataField="Cards"  Visible="false" HeaderText="Card"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                </asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="Card" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# Getcard(decimal.Parse(Eval("Cards").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " +GetcardAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Cards" DataFormatString="{0:0.00}"
                                    HeaderText="Card"></asp:BoundField>--%>
                                                <%-- <asp:TemplateField HeaderText="credit/DebitCard" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# Getcard(decimal.Parse(Eval("Cards").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetcardAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Cheque" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                        <%# Getcheque(decimal.Parse(Eval("Cheque").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetChequeAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Drafts" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetDraft(decimal.Parse(Eval("DD").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetDraftAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CoPercent" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetCoPercent(decimal.Parse(Eval("CoPercent").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetCoPercentAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CoPayment" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetCoPayment(decimal.Parse(Eval("CoPayment").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetCoPaymentAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ReimbursableAmt" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetMedicalAmt(decimal.Parse(Eval("MedicalAmt").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetMedicalAmtIP()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NonReimbursableAmt" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetNonMedicalIP(decimal.Parse(Eval("NonMedicalAmt").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetNonMedicalAmtIP()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                               <%-- <asp:TemplateField HeaderText="RoundOff" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetTax(decimal.Parse(Eval("RoundOff").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetTaxAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ServiceChargeForAdvance" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetTax(decimal.Parse(Eval("RoundOff").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetTaxAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ServiceChargeForRecd.Amt" ItemStyle-HorizontalAlign="Right"
                                                    Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetTax(decimal.Parse(Eval("RoundOff").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)"  " + GetTaxAmt()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>--%>
                                                <%--<asp:BoundField ItemStyle-Width="25px" DataField="TotalCounts" Visible="false" HeaderText="ARAgeing"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                </asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="ARAgeing" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <%# GetAR(decimal.Parse(Eval("TotalCounts").ToString()))%>
                                                    </ItemTemplate>
                                                    <%-- <FooterTemplate>
                                                        <%# (string)"  " + GetARvalue()%>
                                                    </FooterTemplate>--%>
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Settlement Amt" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%# GetSettlement(decimal.Parse(Eval("StdBillAmount").ToString()))%>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%# (string)" " + GetSettlementAmount()%>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                              
                                            </Columns>
                                            <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvOP" Visible="false" runat="server" AutoGenerateColumns="False"
                                        Width="100%" ForeColor="#333333" ShowFooter="true" FooterStyle-HorizontalAlign="Right"
                                        FooterStyle-Font-Bold="true" EnableViewState="True">
                                        <RowStyle Font-Bold="False" />
                                        <Columns>
                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number"></asp:BoundField>
                                            <asp:BoundField DataField="PatientName" HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Age" HeaderText="Age">
                                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" ItemStyle-HorizontalAlign="Right">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BillDate" HeaderText="Bill Date" ItemStyle-HorizontalAlign="Right">
                                            </asp:BoundField>
                                            <%-- <asp:BoundField ItemStyle-Width="25px" DataField="TotalAmount"  HeaderText="GrossBillValue"
                                    ItemStyle-HorizontalAlign="Left">
                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="GrossBillValue" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# GetGrossBill(decimal.Parse(Eval("TotalAmount").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"" + GetGrossBillValue()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" DataField="Discount"
                                    HeaderText="Discount"></asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# GetDiscount(decimal.Parse(Eval("Discount").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"   " + GetDiscountamt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="NetValue" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# GetNet(decimal.Parse(Eval("NetValue").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"" + GetNetamt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" DataField="TotalAmount"
                                    HeaderText="NetValue"></asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Received Amount" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# GetAmount(decimal.Parse(Eval("ReceivedAmount").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string) " "+ GetTotal() %>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Due" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%# GetDue(decimal.Parse(Eval("Due").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)" " + GetDueAmt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" DataField="Due"
                                    HeaderText="Due"></asp:BoundField>--%>
                                            <%--  <asp:BoundField ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" DataField="Cash"
                                    HeaderText="Cash"></asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Cash" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%# GetCash(decimal.Parse(Eval("Cash").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"  " + GetCashAmt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Card" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%# Getcard(decimal.Parse(Eval("Cards").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"  " + GetcardAmt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--  <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Cards" DataFormatString="{0:0.00}"
                                    HeaderText="Cards"></asp:BoundField>--%>
                                            <%-- <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Cheque" DataFormatString="{0:0.00}"
                                    HeaderText="Cheque"></asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Cheque" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# Getcheque(decimal.Parse(Eval("Cheque").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)" " + GetChequeAmt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Drafts" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                    <%# GetDraft(decimal.Parse(Eval("DD").ToString()))%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%# (string)"  " + GetDraftAmt()%>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--  <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="DD" DataFormatString="{0:0.00}"
                                    HeaderText="Drafts"></asp:BoundField>--%>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="false" ForeColor="White" />
                                        <HeaderStyle CssClass="grdcolor" Font-Bold="false" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <div id="divPrintNew" runat="server" style="display: none; background-color: White;
                            width: 600px; height: 400px; overflow-y: auto; overflow-x: auto">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script language="javascript" type="text/javascript">
        function rblhide() {

            var ddlselectText = document.getElementById('<%=ddlselect.ClientID%>').options[document.getElementById('<%=ddlselect.ClientID%>').selectedIndex].text;
            // if (document.getElementById('<%=ddlselect.ClientID %>').SelecttedText =='IP')

            if (ddlselectText == 'IP') {
                document.getElementById('rbl').style.display = 'block';

            }
            else {
                document.getElementById('rbl').style.display = 'none';


            }

        }
    </script>

</body>
</script>
</html>
