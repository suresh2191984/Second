<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DueClearance.aspx.cs" Inherits="InPatient_DueClearance" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

//        function reloadpage() {
//            setTimeout("location.reload(true);", timeout);
        //        }
      
        function CheckedCal(txtAmt, chkitem) {
            var gridChkBox = document.getElementById(chkitem);
            var txtGridAmount = document.getElementById(txtAmt).value;
          
            //alert(txtGridAmount);
            if (gridChkBox.checked) {
                var chkgross = Number(document.getElementById('txtGross').value) + Number(txtGridAmount);
                //document.getElementById('txtGross').value = Number(document.getElementById('txtGross').value) + Number(txtGridAmount);
                document.getElementById('txtGross').value = format_number(Number(chkgross), 2);
                document.getElementById('txtGrandTotal').value = format_number(Number(chkgross), 2);
                document.getElementById('Rshiden').value = format_number(Number(chkgross), 2);
                

            }
            else {
                var chkgross = Number(document.getElementById('txtGross').value) - Number(txtGridAmount);
                //document.getElementById('txtGross').value = Number(document.getElementById('txtGross').value) - Number(txtGridAmount);
                document.getElementById('txtGross').value = format_number(Number(chkgross), 2);
                document.getElementById('txtGrandTotal').value = format_number(Number(chkgross), 2);
            }
            // alert(document.getElementById('hdnGross').value);
            SetOtherCurrValues();

        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                if (!document.getElementById('txtAmountRecieved').value > 0) {
                    document.getElementById('txtAmountRecieved').value = '0.00';
                    document.getElementById('hdnAmountReceived').value = '0.00';
                }
                document.getElementById('txtAmountRecieved').disabled = true;

            }
        }
        function closeData() {
            document.getElementById('<%= btnClose.ClientID %>').click();
        }        
        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";

            sVal= getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);           
            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)


                document.getElementById('hdnAmountReceived').value = pAmt;
                document.getElementById('txtAmountRecieved').value = pAmt;

                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);                
                SetOtherCurrValues();
                return true;
            }
            else {
            
           var userMsg = SListForApplicationMessages.Get('InPatient\\DueClearance.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                alert('Amount provided is greater than net amount')
                return false;
                }
            }
        }

        function validate(bid) {
            //            $get(bid).disabled = true;
            //            javascript: __doPostBack(bid, '');

            var alte = PaymentSaveValidation();
            if (alte == true) {
                //document.getElementById('btnSave').style.display = 'none';
                if (Number($get('txtAmountRecieved').value) < Number($get('txtGrandTotal').value)) {
                 //                 if (Number($get('txtAmountRecieved').value) <Number(document.getElementById('Rshiden').value )) {
                   
           var userMsg = SListForApplicationMessages.Get('InPatient\\DueClearance.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                    alert('Please Collect Whole Due Amount.');
                    return false;
                    }
                } else {
                    $get('btnSave').disabled = true;
                    javascript: __doPostBack(bid, '');
                    return true;
                }
            }
            else {
                return false;
            }

        }

        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate");

            //                    var sVal = document.getElementById('hdnAmountReceived').value;
            //                    var tempService = document.getElementById('hdnServiceCharge').value;
            //                    var sNetValue = document.getElementById('txtGrandTotal').value;

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);

            totalCalculate();

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            SetOtherCurrValues();

        }

        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }
        
        
        
        
    </script>

    <style type="text/css">
        .style1
        {
            width: 333px;
        }
        .style2
        {
            width: 488px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        function totalCalculate() {
            var GrossAmount = document.getElementById('<%= hdnGross.ClientID %>').value;
            var DiscountAmount = document.getElementById('<%= txtDiscount.ClientID  %>').value;
            var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');
            var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            var PreviousDue = parseFloat(0).toFixed(2);

            var AdvanceReceivd = parseFloat(0).toFixed(2);

            var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');

            PreviousReceived = chkIsnumber(PreviousReceived);
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            PreviousDue = chkIsnumber(PreviousDue);
            AdvanceReceivd = chkIsnumber(AdvanceReceivd);

            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0) {
              
           var userMsg = SListForApplicationMessages.Get('InPatient\\DueClearance.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Discount Cannot be Greater than Gross Amount');
                return false ;
                }
                document.getElementById('<%= txtDiscount.ClientID  %>').value = GrossAmount;
                totalCalculate();
                //GrandTotal.value = document.getElementById('<%= hdnGross.ClientID %>').value;
            }
            else {
                var totGrossAmount = format_number((Number(GrossAmount) + Number(PreviousDue) - (Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd))), 2);

                // alert(GrossAmount);
                //                alert(PreviousDue);
                //                alert(PreviousReceived);
                //                alert(DiscountAmount);
                //                alert(AdvanceReceivd);

                if (Number(totGrossAmount) > 0) {
                    GrandTotal.value = totGrossAmount
                    RefundAmount.value = 0;
                }
                else {
                    GrandTotal.value = 0;
                    RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd)) - (Number(GrossAmount) + Number(PreviousDue)), 2);
                }
                //RefundAmount
                SetOtherCurrValues();
            }
        }
        function ValidateDiscountReason() {
            if (document.getElementById('txtDiscount').value > 0) {
                //document.getElementById('trDiscountReason').style.display = "block";
                //                document.getElementById('txtDiscountReason').focus();
            }
            else {
                document.getElementById('trDiscountReason').style.display = "none";
            }
        }

        function ChangeFormat() {
            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            var gross = document.getElementById('txtGross').value;
            var discount = document.getElementById('txtDiscount').value;
            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";
                totalCalculate();
                  
           var userMsg = SListForApplicationMessages.Get('InPatient\\DueClearance.aspx_4');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Discount Amount is greater than Gross value');
                return false ;
                }
                clearDiscounts();

            }
        }
        function clearDiscounts() {
            var DiscountCntrls = new Array();
            var tempCtrl = document.getElementById('<%= hdnDiscountArray.ClientID %>').value;
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;

            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    document.getElementById(DiscountCntrls[iCnt]).value = 0;
                }
            }
        }

        function AddDiscountsCheck() {
            var DiscountCntrls = new Array();
            var tempCtrl = document.getElementById('<%= hdnDiscountArray.ClientID %>').value;
            var DiscountControl = document.getElementById('<%= txtDiscount.ClientID %>');
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;
            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
                }
            }

            if (Number(DiscountControl.value) < Number(DiscountAmount)) {
                DiscountControl.value = Number(DiscountAmount);
            }
            return false;
        }
        
    </script>

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
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                        <div id="Nodata" runat="server" visible="false">
                        <asp:Label ID="lblMessage" runat="server" 
                                Text="No Data Available for the selected patient" 
                                meta:resourcekey="lblMessageResource1"></asp:Label>
                           
                            <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" Text="Back" OnClick="btnClose_Click" 
                                meta:resourcekey="Button1Resource1" />
                        </div>
                        <div id="YesData" runat="server">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:GridView ID="gvIndents" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvIndents_RowDataBound"
                                            Width="100%" meta:resourcekey="gvIndentsResource1">
                                            <Columns>
                                                <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                    meta:resourcekey="BoundFieldResource1" />
                                                <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                    meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                    meta:resourcekey="BoundFieldResource3" />
                                                <asp:TemplateField HeaderText="select" 
                                                    meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkRefund1" runat="server" Checked="True" 
                                                                meta:resourcekey="chkRefund1Resource1"  />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                <asp:BoundField HeaderText="Description" DataField="Description" 
                                                    meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Comments" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Comments" Text='<%# Eval("Comments") %>' runat="server" 
                                                            meta:resourcekey="CommentsResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="From" DataField="FromDate" 
                                                    DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                    meta:resourcekey="BoundFieldResource5">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="To" DataField="ToDate" 
                                                    DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                    meta:resourcekey="BoundFieldResource6">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="UnitPrice" 
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                            Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="60px" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                            runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quantity" 
                                                    meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                            Text='<%# Eval("unit") %>'    onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="60px" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                            runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" 
                                                    meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                            Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                            meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnAmount" runat="server" />
                                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Status" HeaderText="Status" 
                                                    meta:resourcekey="BoundFieldResource7" />
                                                <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" 
                                                    meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtDiscount"  runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                               onkeypress="return ValidateOnlyNumeric(this);"    Width="60px" 
                                                            meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="true" Visible="false" 
                                                    HeaderText="IsReImbursable" meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" 
                                                            meta:resourcekey="chkIsReImbursableItemResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr id="trAmtDetails" runat="server" style="display:none;">
                                    <td colspan="3" style="padding-top: 10px;">
                                        <table cellpadding="3" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" 
                                                        class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />
                                                </td>
                                                <td align="right" class="details_value">
                                                    <asp:HiddenField ID="hdnGross" runat="server" />
                                                    <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1"  CssClass ="Txtboxsmall"
                                                        Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                    <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <div style="display: none;">
                                                 <asp:Label ID="lbselectcorp" runat="server" Text="Select Corporate" meta:resourcekey="lbselectcorpResource1" ></asp:Label> &nbsp;
                                                        <asp:DropDownList ID="ddlCorporate" onchange="javascript:calculateDiscountForCorporate();"
                                                            runat="server" meta:resourcekey="ddlCorporateResource1">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount" 
                                                        class="defaultfontcolor" meta:resourcekey="lblDiscountResource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtDiscount" ReadOnly="True" runat="server" TabIndex="4" onkeyup="totalCalculate();"
                                                        Text="0.00"  CssClass ="Txtboxsmall" onblur="AddDiscountsCheck();ChangeFormat();totalCalculate();"
                                                           onkeypress="return ValidateOnlyNumeric(this);"   
                                                        meta:resourcekey="txtDiscountResource2" />
                                                </td>
                                            </tr>
                                            <tr id="trDiscountReason" style="display: none;">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="Label1" runat="server" Text="Reason for Discount" 
                                                        class="defaultfontcolor" meta:resourcekey="Label1Resource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtDiscountReason" runat="server" TabIndex="5" 
                                                        CssClass ="Txtboxsmall" meta:resourcekey="txtDiscountReasonResource1" />
                                                </td>
                                            </tr>
                                            <tr id="trPreviousDue" runat="server" style="display: none">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblPreviousDue" runat="server" Text=" Previous Due" 
                                                        meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                       CssClass ="Txtboxsmall" meta:resourcekey="txtPreviousDueResource1" />
                                                </td>
                                            </tr>
                                            <tr id="trAmountPaid" runat="server" style="display: none">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblAmountPaid" runat="server" Text="Amount Paid" 
                                                        meta:resourcekey="lblAmountPaidResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Enabled="False"
                                                        TabIndex="6" CssClass ="Txtboxsmall" 
                                                        meta:resourcekey="txtPreviousAmountPaidResource1" />
                                                </td>
                                            </tr>
                                            <tr id="trAdvancedPaid" runat="server" style="display: none">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblAdvancePaid" runat="server" Text="Advance Paid" 
                                                        meta:resourcekey="lblAdvancePaidResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                       CssClass ="Txtboxsmall"
                                                        meta:resourcekey="txtRecievedAdvanceResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                            <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" 
                                                        meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                       CssClass ="Txtboxsmall"
                                                        meta:resourcekey="txtServiceChargeResource1" />
                                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Net Payable Amount" 
                                                        class="defaultfontcolor" meta:resourcekey="lblGrandTotalResource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" TabIndex="8" 
                                                        CssClass ="Txtboxsmall" meta:resourcekey="txtGrandTotalResource1" />
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                   <asp:Label ID="Rs_PreviousRefund" Text="Previous Refund" runat="server" 
                                                        meta:resourcekey="Rs_PreviousRefundResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtPreviousRefund" runat="server" TabIndex="8" Enabled="False" 
                                                       CssClass ="Txtboxsmall" meta:resourcekey="txtPreviousRefundResource1" />
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="Rs_AmounttoRefund" Text="Amount to Refund"   runat="server" 
                                                        meta:resourcekey="Rs_AmounttoRefundResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:CheckBox ID="ChkRefund" runat="server" Text="Yes" 
                                                        onClick="javascript:funcRefundChk();" meta:resourcekey="ChkRefundResource1" />
                                                    <asp:TextBox ID="txtRefundAmount" runat="server" TabIndex="8" 
                                                        CssClass ="Txtboxsmall" meta:resourcekey="txtRefundAmountResource1" />
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="Rs_ReasonforRefund" Text="Reason for Refund" runat="server" 
                                                        meta:resourcekey="Rs_ReasonforRefundResource1"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <div id="reasonforRefund" style="display: none">
                                                        <asp:TextBox ID="txtReasonForRefund" runat="server" TabIndex="8" MaxLength="150"
                                                            Width="150px" meta:resourcekey="txtReasonForRefundResource1" /></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" 
                                                        class="defaultfontcolor" meta:resourcekey="lblAmountRecievedResource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" ReadOnly="True" 
                                                       CssClass ="Txtboxsmall" meta:resourcekey="txtAmountRecievedResource1" />
                                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    &nbsp;
                                                </td>
                                                <td align="right">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="style2">
                                                    &nbsp;
                                                </td>
                                                <td align="right" class="style1">
                                                    <asp:CheckBox runat="server" Visible="False" ID="chkDischarge" Text="Discharge Patient"
                                                        Font-Bold="True" meta:resourcekey="chkDischargeResource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:CheckBox ID="chkisCreditTransaction" Visible="False" Text="Credit Transaction"
                                                        runat="server" class="defaultfontcolor" onclick="checkIsCredit();" 
                                                        meta:resourcekey="chkisCreditTransactionResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <uc13:paymentType ID="PaymentType" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Button ID="btnSave" runat="server" Text="Generate Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" 
                                                        OnClientClick="return validate(this.id);" OnClick="btnSave_Click" 
                                                        meta:resourcekey="btnSaveResource1" />
                                                    &nbsp;<asp:Button ID="btnClose" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" Text="Close" OnClick="btnClose_Click" 
                                                        meta:resourcekey="btnCloseResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnTempService" runat="server" Value="0.00" />
        <asp:HiddenField ID="hdnDiscountArray" runat="server" />
        <asp:HiddenField ID="Rshiden" runat="server" />
        <asp:HiddenField ID="hdnYesData" runat="server" Value="0" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

    <script language="javascript" type="text/javascript">
        
        function closeData() {
            document.getElementById('<%= btnClose.ClientID %>').click();
        }

        function doCalcDue(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross,
                            txtindDiscount, hdnDiscountArray, hdnNonMedicalItem,
                            lblNonReimbuse, nonReimburseChkBoxID, flag) {

            var Quantity = document.getElementById(txtQuantity);
            var UnitPrice = document.getElementById(txtUnitPrice);
            var Amount = document.getElementById(txtAmount);
            var hdnAmount = document.getElementById(hdnTotalAmount);

            var OldPrice = document.getElementById(hdnOldPrice);
            var OldQuantity = document.getElementById(hdnOldQuantity);

            var oldAmt = Number(OldPrice.value) * Number(OldQuantity.value);

            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var RecievedAdvance = document.getElementById(txtRecievedAdvance);
            var GrandTotal = document.getElementById(txtGrandTotal);

            var OldPricetoDelete = chkIsnumber(OldPrice.value);
            var OldQuantitytoDelete = chkIsnumber(OldQuantity.value);

            var hdnGrossBillAmount = document.getElementById(hdnGross);
            var OldAmounttoDelete = format_number((Number(OldPricetoDelete) * Number(OldQuantitytoDelete)), 2);


            var IndividualDiscount = document.getElementById(txtindDiscount);
            if (IndividualDiscount == "" || IndividualDiscount == null) {
                IndividualDiscount = parseFloat(0).toFixed(2);
            }

            //var OldAmounttoDelete = 0;
            //format_number(Number(UnitPrice.value), 2);

            Quantity.value = chkIsnumber(Quantity.value);
            UnitPrice.value = chkIsnumber(UnitPrice.value);

            UnitPrice.value = format_number(Number(UnitPrice.value), 2);
            Amount.value = format_number((Number(Quantity.value) * Number(UnitPrice.value)), 2);
            hdnAmount.value = Amount.value;

            var newAmt = Amount.value;

            Gross.value = format_number((Number(Gross.value) + Number(Amount.value) - Number(OldAmounttoDelete)), 2);
            hdnGrossBillAmount.value = Gross.value;

            if (Number(Amount.value) < Number(chkIsnumber(IndividualDiscount.value))) {
              
           var userMsg = SListForApplicationMessages.Get('InPatient\\DueClearance.aspx_5');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Discount cannot be greater than amount');
                return false ;
                }
                IndividualDiscount.value = parseFloat(Amount.value).toFixed(2);
            }

            var DiscountCntrls = new Array();
            var tempCtrl;
            if (hdnDiscountArray == null || hdnDiscountArray == "" || hdnDiscountArray == undefined) {
                tempCtrl = "";
            }
            else {
                tempCtrl = document.getElementById(hdnDiscountArray).value;
            }
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;
            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
                }
            }
            //if (Number(DiscountAmount) != 0) {
            Discount.value = parseFloat(DiscountAmount).toFixed(2);
            //}
            OldPrice.value = UnitPrice.value;
            OldQuantity.value = Quantity.value;
            totalCalculate();
            ValidateDiscountReason();
            //    if (document.getElementById('chkisCreditTransaction').checked == true) {
            if (flag != "ROOM") {
                var gridChkBox = document.getElementById(nonReimburseChkBoxID);
                var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
                var lblNonReimbuse = document.getElementById(lblNonReimbuse);
                if (gridChkBox != undefined) {
                    if (gridChkBox.checked) {
                        //nothing
                    }
                    else {
                        lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(hdnNonMedical.value) + (newAmt - oldAmt)).toFixed(2);
                    }
                    doCalcReimburse();
                }
            }
            //    }

        }
       
    </script>

    <script language="javascript" type="text/javascript">
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        if (document.getElementById('hdnYesData').value == 1) {
            document.getElementById('trAmtDetails').style.display = "block";
            GetCurrencyValues();
        }
        if (document.getElementById('hdnYesData').value == 0) {
            document.getElementById('YesData').style.display = "none";
            document.getElementById('trAmtDetails').style.display = "none";
            
        }
        
    </script>
	<asp:HiddenField ID="hdnMessages" runat="server" />

    </form>
</body>
</html>
