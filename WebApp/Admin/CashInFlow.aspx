<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" ValidateRequest="false"
    CodeFile="CashInFlow.aspx.cs" Inherits="Admin_CashInFlow" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentTypeDetails"
    TagPrefix="uc9" %>
<%@ Register Assembly="IdeaSparx.CoolControls.Web" Namespace="IdeaSparx.CoolControls.Web"
    TagPrefix="Grd" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="OtherCurrency" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cash InCome</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" language="javascript">
        function Validation(obj) {

            if (document.getElementById('dPurpose').options[document.getElementById('dPurpose').selectedIndex].value == 0) {
                alert('Provide Source of Cash');
                document.getElementById('dPurpose').focus();
                return false;

            }
            if (document.getElementById('dPurpose').options[document.getElementById('dPurpose').selectedIndex].value == 'SUR') {
                document.getElementById('divVoucherDetails').style.display = "block";

            }
            else {
                document.getElementById('divVoucherDetails').style.display = "none";
            }
            if (obj == 'After') {
                if (document.getElementById('dPurpose').options[document.getElementById('dPurpose').selectedIndex].value == 'SUR') {
                    if (document.getElementById('txtVoucherNo').value.trim() == '') {
                        alert('Provide the voucher number');
                        return false;
                    }

                }
                if (document.getElementById('txtPayableAmount').value <= 0) {
                    alert('The total received amount will be of zero or lessthan zero');
                    return false;
                }
            }
        }
        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var sVal = 0;
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);
            if (TotalAmount > 0) {
                var oldAmount = document.getElementById('txtPayableAmount').value;
                oldAmount = Number(oldAmount) + Number(TotalAmount);
                ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                //                document.getElementById('txtServiceCharge').value = format_number(Number(ServiceCharge), 2);
                //                document.getElementById('hdnServiceCharge').value = format_number(Number(ServiceCharge), 2);
                document.getElementById('txtPayableAmount').value = format_number(oldAmount, 2);
                //                document.getElementById('hdnPayable').value = format_number(oldAmount, 2);
                return true;
            }
            else {
                alert('Amount cannot be zero');
                return false;
            }
        }

        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            GetCurrencyValues();
            var sVal = 0;
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);
            var oldAmount = document.getElementById('txtPayableAmount').value;
            oldAmount = Number(oldAmount) - Number(TotalAmount);
            document.getElementById('txtPayableAmount').value = format_number(oldAmount, 2);
            return true;
            //            document.getElementById('hdnPayable').value = format_number(oldAmount, 2);

            //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            //            var tempService = document.getElementById('txtServiceCharge').value;
            //            document.getElementById('txtServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);
            //            document.getElementById('hdnServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);

        }
        function getOtherCurrAmtValues(pType, ConValue) {
            if (pType == "REC") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrReceived").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrReceived").value;
                return parseFloat(pAMt).toFixed(2);
            }
            if (pType == "PAY") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrPayble").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrPayble").value;
                return parseFloat(pAMt).toFixed(2);
            }
            if (pType == "SER") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value;
                return parseFloat(pAMt).toFixed(2);
            }
        }
        
    </script>

    <style type="text/css">
        .GridStyle TR TD, .GridStyle TR TH
        {
            font-family: Tahoma, Verdana, Arial;
            font-size: 10pt;
            padding-left: 4px;
            padding-top: 3px;
            padding-bottom: 3px;
            padding-right: 3px;
            border-top: 1px solid #A5A5A5;
            border-left: 1px solid #A5A5A5;
        }
        .GridStyle TR TH
        {
            background-color: #D3D7ED;
        }
        .GridAlternateRowStyle
        {
            background-color: #E9ECF8;
        }
        .GridRowStyle
        {
            background-color: White;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td height="32">
                                    <div class="dataheader2">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="150px;">
                                                    <asp:Label ID="Rs_SelectPayableType" Text="Select Payable Type:" runat="server" meta:resourcekey="Rs_SelectPayableTypeResource2"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:DropDownList ID="dPurpose" runat="server" onchange="javascript:Validation('Before');"
                                                        TabIndex="1" CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td colspan="2" align="center">
                                                    <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divVoucherDetails" style="display: none;" runat="server" class="dataheader2">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="150px;">
                                                    <asp:Label ID="lblVoucher" Text="Enter Voucher No" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtVoucherNo" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divPayment" runat="server" class="dataheader2">
                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                            <tr style="display: none;">
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Rs_PaidAmount" Text="Received Amount :" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="Txtboxverysmall" Height ="19px" ID="txtPayableAmount" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                        ReadOnly="True" MaxLength="8" Style="text-align: right;" TabIndex="3" Text="0.00"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnPayable" Value="0" runat="server" />
                                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <uc9:PaymentTypeDetails EnabledCurrType="false" ID="PaymentTypeDetails" runat="server" />
                                                </td>
                                            </tr>
                                            <tr id="trOtherCurrency" runat="server" style="display: none;">
                                                <td>
                                                    <OtherCurrency:OtherCurrencyDisplay IsDisplayPayedAmount="false" ID="OtherCurrencyDisplay1"
                                                        runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_Remarks" Text="Remarks :" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtRemarks" MaxLength="250" size="25" TextMode="MultiLine"
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divSave" runat="server" class="dataheader2">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr align="center">
                                                <td align="center">
                                                    <asp:Button ID="bsave" OnClientClick="javascript:return Validation('After');" runat="server"
                                                        CssClass="btn" TabIndex="4" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                        Text="Save" OnClick="bsave_Click" meta:resourcekey="bsaveResource2" />
                                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" TabIndex="5" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" Text="Cancel" meta:resourcekey="btnCancelResource2" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <%-- <table border="0" width="100%" >
                            <tr>
                                <td >
                                <div class="dataheader3">
                                    <table cellpadding="0" cellspacing="0"  border="0" width="100%" >
                                        <tr>
                                            <td colspan="4" align="center">
                                                <asp:Label Font-Bold="True" runat="server" ID="lblStatus" 
                                                    meta:resourcekey="lblStatusResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label runat="server" ID="Label1" Text="Select Source Type" 
                                                    meta:resourcekey="Label1Resource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCFList" runat="server" 
                                                    meta:resourcekey="ddlCFListResource1">
                                                </asp:DropDownList>&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            
                                            <td align="right">
                                                <asp:Label runat="server" ID="lblcshFlwType" Text="Select Currency Type" 
                                                    meta:resourcekey="lblcshFlwTypeResource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCurList" runat="server" 
                                                    meta:resourcekey="ddlCurListResource1">
                                                </asp:DropDownList>&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label runat="server" ID="lblRef" Text="Reference No" 
                                                    meta:resourcekey="lblRefResource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRefNo" runat="server" meta:resourcekey="txtRefNoResource1"></asp:TextBox>
                                            </td>
                                           
                                            <td align="right">
                                                <asp:Label runat="server" ID="lblAmtrec" Text="Amount to receive" 
                                                    meta:resourcekey="lblAmtrecResource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAmoutn"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                    runat="server" meta:resourcekey="txtAmoutnResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label runat="server" ID="lblPayemntMode" Text="Select Payemt Type" 
                                                    meta:resourcekey="lblPayemntModeResource1"></asp:Label>:
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList ID="ddlPaymentMode" onchange="javascript:return ShowDeatails();"
                                                    runat="server" meta:resourcekey="ddlPaymentModeResource1">
                                                </asp:DropDownList>&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td align="right">
                                                <asp:Label runat="server" ID="lblDescrip" Text="Description" 
                                                    meta:resourcekey="lblDescripResource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" Height="34px"
                                                    Width="333px" meta:resourcekey="txtDescriptionResource1"></asp:TextBox></td></tr><tr>
                                            <td colspan="4">
                                                <asp:Panel ID="pnlBank" Style="display: none;" runat="server" 
                                                    meta:resourcekey="pnlBankResource1">
                                                    <table border="0">
                                                        <tr>
                                                            <td>
                                                                
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblBankName" Text="Bank Name :" 
                                                                    meta:resourcekey="lblBankNameResource1"></asp:Label></td><td>
                                                                <asp:TextBox ID="txtBankName" runat="server" Width="144px" 
                                                                    meta:resourcekey="txtBankNameResource1"></asp:TextBox></td><td class="style1">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID="lblCheq0" runat="server" Text="Cheque/DD Number:" 
                                                                    meta:resourcekey="lblCheq0Resource1"></asp:Label></td><td>
                                                                <asp:TextBox ID="txtCheque" runat="server" 
                                                                    meta:resourcekey="txtChequeResource1"></asp:TextBox></td></tr></table></asp:Panel></td></tr><tr>
                                            <td colspan="4" align="center">
                                                <table>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return Validation();"
                                                                OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                            <asp:Button ID="btnUpdate" runat="server" Visible="False" Text="Update" CssClass="btn"
                                                                onmouseover="this.className='btn btnhov'" 
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return Validation();"
                                                                OnClick="btnUpdate_Click" meta:resourcekey="btnUpdateResource1" />
                                                        </td>
                                                        <td align="center" colspan="3">
                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                                                meta:resourcekey="btnCancelResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:HiddenField ID="hdnPaidDetailsID" runat="server" />
                                    <Grd:CoolGridView DataKeyNames="PaidDetailsID,SourceTypeID,ReceivedCurrencyID,ReceivedTypeID"
                                        ID="grdCashFlowdetails" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                        Width="100%" ForeColor="#333333" CssClass="mytable1" ItemStyle-VerticalAlign="Top"
                                        RepeatDirection="Horizontal" OnRowCommand="grdCashFlowdetails_RowCommand"
                                        OnRowDataBound="grdCashFlowdetails_RowDataBound" 
                                        meta:resourcekey="grdCashFlowdetailsResource1">

<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                                        <HeaderStyle CssClass="dataheader1" /> 
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField DataField="SourceName" HeaderText="IncomeSourceName" 
                                                meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField DataField="ReceivedCurrencyvalue" HeaderText="Amount" 
                                                meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField DataField="CurrencyName" HeaderText="ReceivedCurreny" 
                                                meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField DataField="ReferenceID" NullDisplayText="--"  
                                                HeaderText="Reference No." meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                HeaderText="DateTime" meta:resourcekey="BoundFieldResource5" />
                                            <asp:BoundField DataField="ModeOFPayment" HeaderText="PaymentType" 
                                                meta:resourcekey="BoundFieldResource6" />
                                            <asp:BoundField DataField="BankName" NullDisplayText="--" HeaderText="BankName" 
                                                meta:resourcekey="BoundFieldResource7" />
                                            <asp:BoundField DataField="ChequeNo" NullDisplayText="--" HeaderText="ChequeNo" 
                                                meta:resourcekey="BoundFieldResource8" />
                                            <asp:BoundField DataField="Description" NullDisplayText="--" 
                                                HeaderText="Description" meta:resourcekey="BoundFieldResource9" />
                                        </Columns>
                                    </Grd:CoolGridView>
                                </td>
                            </tr>
                        </table>--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnPID" runat="server" />
    </form>
</body>
</html>
