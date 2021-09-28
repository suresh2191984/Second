<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientLedgerReport.aspx.cs"
    Inherits="Reports_PatientLedgerReport" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="IdeaSparx.CoolControls.Web" Namespace="IdeaSparx.CoolControls.Web"
    TagPrefix="Grd" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Ledger Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

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

            if (document.getElementById('txtPatientNo').value == '') {
                alert("Enter Patient Numnber");
                document.getElementById('txtPatientNo').focus();
                return false;
            }

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
        function openViewBill(obj, ftype) {

            if (ftype == "PRM") {
                var skey = "../Inventory/PrintBill.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else if (ftype == "DEP") {
                var skey = "../Reception/PrintDepositReceipt.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "&sType = DEPOSIT"
                           + "";

                window.open(skey, 'ViewDeposit', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else {

                var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                            <tr align="left">
                                <td>
                                    <div class="dataheaderWider">
                                        <table id="tbl" width="70%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPatientNo" runat="server" Text="Patient Number"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPatientNo"  CssClass ="Txtboxsmall" Width ="120px" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    From Date :
                                                    <asp:TextBox ID="txtFDate" CssClass ="Txtboxsmall" Width ="120px" runat="server"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                </td>
                                                <td>
                                                    To Date :
                                                    <asp:TextBox ID="txtTDate" CssClass ="Txtboxsmall" Width ="120px" runat="server"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server">
                                                        <asp:ListItem Text="OP" Selected="True" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                            Please wait....
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    </asp:UpdatePanel>
                                    <div class="dataheaderWider" style="display: none;" id="divPatientDetail" runat="server">
                                        <table width="100%" style="font-family: Verdana; font-weight: 700px;" id="tblPatientDetails"
                                            runat="server">
                                            <tr>
                                                <td align="left">
                                                    <table cellpadding="5" cellspacing="2">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblPName" Text="Patient Name"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblPatientName"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPeriod" runat="server" Text="Report Period"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPeriodFromTo" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblPNo" Text="Patient Number"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblPatientNumber"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPAge" runat="server" Text="Patient Age"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPatientAge" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="dataheaderWider">
                                        <table width="100%" style="font-family: Verdana; font-weight: 700px;" id="tblBillingDetails"
                                            runat="server">
                                            <tr>
                                                <td align="left" class="dataheader2" nowrap="nowrap">
                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="false" HeaderStyle-Height="25px"
                                                        FooterStyle-Height="25px" CellPadding="1" ShowFooter="True" Width="100%" HorizontalAlign="Right"
                                                        CssClass="mytable1" GridLines="Both" BorderStyle="Ridge" EnableViewState="true"
                                                        OnRowDataBound="gvIPCreditMain_RowDataBound">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="8%" HeaderText="S.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" ItemStyle-HorizontalAlign="Right">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BillDate" HeaderText="Bill Date" ItemStyle-HorizontalAlign="Right">
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="DOA" ItemStyle-HorizontalAlign="Right" Visible="true">
                                                                <ItemTemplate>
                                                                    <%# GetDate(DataBinder.Eval(Container.DataItem, "DoAdmission", "{0:dd/MM/yyyy}").ToString())%>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
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
                                                     
                                                            <asp:BoundField ItemStyle-Width="25px" DataField="VisitState" HeaderText="VisitState"
                                                                Visible="true" ItemStyle-HorizontalAlign="Left">
                                                                <ItemStyle Width="25px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField ItemStyle-Width="25px" DataField="IsCreditBill" Visible="true" HeaderText="IsCreditBill"
                                                                ItemStyle-HorizontalAlign="Left">
                                                                <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField ItemStyle-Width="25px" DataField="ReceivedAmount" HeaderText="ReceivedAmount"
                                                                ItemStyle-HorizontalAlign="Left">
                                                                <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="ClaimAmt" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetCreditIP(decimal.Parse(Eval("CreditDue").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)" " + GetCreditAmtIP()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Cash" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetCash(decimal.Parse(Eval("Cash").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"" + GetCashAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                         
                                                            <asp:TemplateField HeaderText="Card" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# Getcard(decimal.Parse(Eval("Cards").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)" " +GetcardAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Cheque" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>--%>
                                                                    <%# Getcheque(decimal.Parse(Eval("Cheque").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetChequeAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Drafts" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetDraft(decimal.Parse(Eval("DD").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetDraftAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="CoPercent" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetCoPercent(decimal.Parse(Eval("CoPercent").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetCoPercentAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="CoPayment" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetCoPayment(decimal.Parse(Eval("CoPayment").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetCoPaymentAmt()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="ReimbursableAmt" Visible="false" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetMedicalAmt(decimal.Parse(Eval("MedicalAmt").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetMedicalAmtIP()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="NonReimbursableAmt" Visible="false" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <%# GetNonMedicalIP(decimal.Parse(Eval("NonMedicalAmt").ToString()))%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <%# (string)"  " + GetNonMedicalAmtIP()%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="ARAgeing" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                                <ItemTemplate>
                                                                    <%# GetAR(decimal.Parse(Eval("TotalCounts").ToString()))%>
                                                                </ItemTemplate>
                                                              
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
                                </td>
                            </tr>
                        </table>
                        
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
