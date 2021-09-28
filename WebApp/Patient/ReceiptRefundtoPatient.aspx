<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiptRefundtoPatient.aspx.cs"
    Inherits="Patient_ReceiptRefundtoPatient" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Refund to Patient</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function blacktext(e) {

            //if (!((e.keyCode >= 48) && (e.keyCode <= 57) && e.keyCode == 46) {
            if (!((e.keyCode >= 48) && (e.keyCode <= 57))) {
                //alert("Only Digits Are Allowed");
                if (e.keyCode == 46) {
                    return true;
                }
                else {
                    e.keyCode = 0;
                }
            }

        }
        function ValidateRefundAmount() {
            var txtRAmt = "GridView1_ctl";
        }
        //        function ValidateReason(btnCancel, txtReason) {
        //            if (document.getElementById(txtReason).value == "") {
        //                alert("Reason is Mandatory");
        //                document.getElementById(txtReason).focus();
        //                return false;
        //            }
        //        }txtCancelReason




        function getMessage(v1, v2, v3, v4, v5, v6,v7,v8) {
            var ans;
            ans = window.confirm('Do you wish to take Print?');
            if (ans == true) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";

                var strURL = "../Billing/RefundVoucher.aspx?BillNo="
               + v1
               + "&BilledAmt=" + v2
               + "&Name=" + v3
               + "&PNumber=" +v4
               + "&IsPopup=Y"
               + "&RefundAmount=" + v5
               + "&RefundVoucherNo=" + v6
               + "&VID=" + v7
               +"&PatientID="+v8;
                window.open(strURL, "", strFeatures, true);
            }
            else {
            }
        }


        function ValidateReason() {
            if (document.getElementById('txtCancelReason').value == '') {
                alert('Reason for cancellation is mandatory');
                document.getElementById('txtCancelReason').focus();
                return false;
            }
        }
        function Paymentchanged() {

            if (document.getElementById('rblPaymode_1').checked) {
                document.getElementById('chequediv').style.display = "block";
            }
            else {
                document.getElementById('chequediv').style.display = "none";

                document.getElementById('txtNumber').value = "";
                document.getElementById('txtBankType').value = "";
                document.getElementById('txtRemarks').value = "";
            }
        }
        function dispTask(id) {
            var flag = 0;
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {
                    flag = flag + 1;

                }

            }
            if (flag >= 1) {
                document.getElementById('trpnlAssign').style.display = "block";
                document.getElementById('trpnlRefund').style.display = "none";

            }
            else {
                document.getElementById('trpnlAssign').style.display = "none";
                document.getElementById('trpnlRefund').style.display = "block";
            }
        }
        function changeAmont() {
            document.getElementById('hdnCurrencyAmount').value = "";
            var ddlText = document.getElementById('ddlBaseCurrency').options[document.getElementById('ddlBaseCurrency').selectedIndex].text;
            //alert(ddlText);
            if (ddlText.value != "") {
                var list = ddlText.split('-');
                //alert(list[0]);
                //alert(list[1]);
                var list1 = list[0].split('(');
                var curamount = list[1];
                list1[1] = list1[1].split(')').join("");
                if (document.getElementById('hdnCurRefAmount').value != "") {
                    var tempAmount = document.getElementById('hdnCurRefAmount').value
                    var totAmount = tempAmount / list[1];
                    //alert(totAmount);

                    document.getElementById('currenyName').innerHTML = list1[1];
                    document.getElementById('lblCurName').innerHTML = list1[1];
                    document.getElementById('lblCurrChange').innerHTML = "";
                    if (list1[1] == "INR") {
                        document.getElementById('lblCurrChange').innerHTML = parseFloat(totAmount).toFixed(2);
                        document.getElementById('txtAmount').value = parseFloat(totAmount).toFixed(2);
                        document.getElementById('hdnCurrencyAmount').value = parseFloat(totAmount).toFixed(2);
                    }
                    else {
                        document.getElementById('lblCurrChange').innerHTML = parseFloat(totAmount).toFixed(4);
                        document.getElementById('txtAmount').value = parseFloat(totAmount).toFixed(4);
                        document.getElementById('hdnCurrencyAmount').value = parseFloat(totAmount).toFixed(4);
                    }


                }


            }

        }

        function sumAmount() {
            var sum = 0;
            document.getElementById('hdnCurrencyAmount').value = "";
            var temp = document.getElementById('hdnTemprefAmount').value;
            var stemp = temp.split('~');
            for (var i = 0; i < stemp.length; i++) {

                if (stemp[i] != "") {
                    sum = parseFloat(sum) + parseFloat(document.getElementById(stemp[i]).value);
                }

            }

            document.getElementById('hdnCurRefAmount').value = sum;
            if (document.getElementById('lblCurrChange') != null) {
                document.getElementById('lblCurrChange').innerHTML = "";
                document.getElementById('lblCurrChange').innerHTML = parseFloat(sum).toFixed(2);
                document.getElementById('txtAmount').value = parseFloat(sum);
                document.getElementById('hdnCurrencyAmount').value = parseFloat(sum);
            }


        }
        function ProcessCallBackError(arg) {

            //alert('error'+arg);
            //document.getElementById("txtdummy").value = arg;
            alert('Result value cannot be blank ');
        }
        function ChequeValidate() {
            if (document.getElementById('rblPaymode_1').checked) {
                if (document.getElementById('txtNumber').value == '') {
                    alert("Please Enter Cheque Number");
                    return false;
                }
                if (document.getElementById('txtBankType').value == '') {
                    alert("Please Enter Bank Name");
                    return false;
                }

            }
            var response = window.confirm("Refund will be processed. Do you wish to continue?");
            if (response) {
                SaveRefund('true');
            }
            else {
                return false;
            }
        }
        function ShowSuccess(arg) {
            alert('Refund Successfull');
        }
        function ChequeValidate1() {
            if (document.getElementById('rblPaymode_1').checked) {
                if (document.getElementById('txtNumber').value == '') {
                    alert("Please Enter Cheque Number");
                    return false;
                }
                if (document.getElementById('txtBankType').value == '') {
                    alert("Please Enter Bank Name");
                    return false;
                }

            }

            var response = window.confirm("Refund will be Assigned. Do you wish to continue?");
            if (response) {
                SaveRefund('true');
            }
            else {
                return false;
            }

        }
    </script>

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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
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
                    <div class="contentdata">
                        <ul>
                            <li class="dataheader">
                                <asp:Label ID="lblPName" runat="server" Text="Patient" 
                                    meta:resourcekey="lblPNameResource1"></asp:Label>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblAmtReceivedText" runat="server" 
                                                            Text="Amount Received from the Patient is " 
                                                            meta:resourcekey="lblAmtReceivedTextResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblTotAmtReceived" CssClass="errormsg" runat="server" 
                                                            meta:resourcekey="lblTotAmtReceivedResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblAmtRefundedText" runat="server" 
                                                            Text="Amount Refunded to the Patient is " 
                                                            meta:resourcekey="lblAmtRefundedTextResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblTotAmtRefunded" CssClass="errormsg" runat="server" 
                                                            meta:resourcekey="lblTotAmtRefundedResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblRefAmt" runat="server" Text="Refundable Amount is " 
                                                            meta:resourcekey="lblRefAmtResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblRefundableAmt" CssClass="errormsg" runat="server" 
                                                            meta:resourcekey="lblRefundableAmtResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblWarning" runat="server" CssClass="errorbox" 
                                                meta:resourcekey="lblWarningResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdRefund" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                DataKeyNames="BillingDetailsID" OnRowDataBound="grdRefund_RowDataBound"
                                                ForeColor="#333333" CssClass="mytable1" runat="server" 
                                                OnRowCommand="grdRefund_RowCommand" meta:resourcekey="grdRefundResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkRefund" runat="server" 
                                                                meta:resourcekey="chkRefundResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="False" HeaderText="InterPayID" 
                                                        meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBillDetailsID" runat="server" 
                                                                Text='<%# Bind("IPIterPayDetailsID") %>' 
                                                                meta:resourcekey="lblBillDetailsIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill No" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFinalBillID" runat="server" Text='<%# Bind("BillNumber") %>' 
                                                                meta:resourcekey="lblFinalBillIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    
                                                    <asp:BoundField DataField="ReceiptNO" HeaderText="Receipt No" />
                                                    <asp:BoundField DataField="FeeType" Visible="False" HeaderText="Fee Type" 
                                                        meta:resourcekey="BoundFieldResource1" >
                                                        <ItemStyle HorizontalAlign="Left" Width="5%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FeeDescription" HeaderText="Description" 
                                                        meta:resourcekey="BoundFieldResource2" >
                                                        <ItemStyle HorizontalAlign="Left" Width="30%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FORENAME" HeaderText="Received By" 
                                                        meta:resourcekey="BoundFieldResource3" >
                                                        <ItemStyle HorizontalAlign="Left" Width="30%" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Amt Received" 
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount") %>' 
                                                                meta:resourcekey="lblAmountResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amt Refunded" 
                                                        meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRfdAmt" runat="server" Text='<%# Bind("RefundedAmt") %>' 
                                                                meta:resourcekey="lblRfdAmtResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Refundable Amt" Visible="False" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:Label Font-Bold="True" ID="lblamtcanbetrans" runat="server" 
                                                                meta:resourcekey="lblamtcanbetransResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" Width="3%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amt To Refund" 
                                                        meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:TextBox onchange="return sumAmount();"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                                ID="TxtRfdAmt" Width="85px" Text="0.00" runat="server" 
                                                                meta:resourcekey="TxtRfdAmtResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Reason" 
                                                        meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtRfdReason" MaxLength="255" Width="100px" runat="server" 
                                                                meta:resourcekey="txtRfdReasonResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Mode="NextPrevious" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblResult" Visible="False" runat="server" CssClass="label_error" 
                                                meta:resourcekey="lblResultResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="center" valign="middle">
                                        <td align="center" valign="middle">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                        meta:resourcekey="imgProgressbarResource1" />
                                                    Please wait....
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlAssign" GroupingText="Refund Assign" runat="server" 
                                                meta:resourcekey="pnlAssignResource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_SelectModeofPayment" Text="Select Mode of Payment" 
                                                                runat="server" meta:resourcekey="Rs_SelectModeofPaymentResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rblPaymode" RepeatDirection="Horizontal"
                                                                runat="server" meta:resourcekey="rblPaymodeResource1">
                                                                <asp:ListItem Selected="True" Value="1" Text="Cash" 
                                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Cheque" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_SelectPayingCurrency" Text="Select Paying Currency" 
                                                                runat="server" meta:resourcekey="Rs_SelectPayingCurrencyResource1"></asp:Label>
                                                        </td>
                                                        <td style="font-weight: normal; font-size: 12px; height: 20px; color: #000;">
                                                            <asp:DropDownList ID="ddlBaseCurrency" onChange="javascript:changeAmont();" ToolTip="Select Currency"
                                                                runat="server" Width="250px" meta:resourcekey="ddlBaseCurrencyResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_RefundableAmountis" Text="Refundable Amount is" 
                                                                runat="server" meta:resourcekey="Rs_RefundableAmountisResource1"></asp:Label>
                                                            <asp:Label ID="lblCurName" runat="server" 
                                                                meta:resourcekey="lblCurNameResource1"></asp:Label>)
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCurrChange" runat="server" 
                                                                meta:resourcekey="lblCurrChangeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="chequediv" style="display: none">
                                                                <table>
                                                                    <tr align="center">
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Rs_Amount" Text="Amount" runat="server" 
                                                                                meta:resourcekey="Rs_AmountResource1"></asp:Label>
                                                                            <asp:Label ID="currenyName" runat="server" 
                                                                                meta:resourcekey="currenyNameResource1" Text=")"></asp:Label>)
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                           <asp:Label ID="Rs_ChequeNo" Text="Cheque No." runat="server" 
                                                                                meta:resourcekey="Rs_ChequeNoResource1"></asp:Label>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Rs_Bank" Text="Bank"  runat="server" 
                                                                                meta:resourcekey="Rs_BankResource1"></asp:Label>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Rs_Remarks" Text="Remarks" runat="server" 
                                                                                meta:resourcekey="Rs_RemarksResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr align="center">
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ReadOnly="True" runat="server" ID="txtAmount"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                Width="65px" MaxLength="9" autocomplete="off" 
                                                                                meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox runat="server" ID="txtNumber"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                autocomplete="off" Width="130px" MaxLength="19" 
                                                                                meta:resourcekey="txtNumberResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox runat="server" ID="txtBankType" Width="220px" autocomplete="off" 
                                                                                meta:resourcekey="txtBankTypeResource1"></asp:TextBox>
                                                                            <ajc:autocompleteextender id="AutoCompleteProduct" runat="server" targetcontrolid="txtBankType"
                                                                                enablecaching="False" firstrowselected="True" minimumprefixlength="2" completionlistcssclass="listtwo"
                                                                                completionlistitemcssclass="listitemtwo" completionlisthighlighteditemcssclass="hoverlistitemtwo"
                                                                                servicemethod="GetBankName" servicepath="~/InventoryWebService.asmx" 
                                                                                DelimiterCharacters="" Enabled="True"></ajc:autocompleteextender>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtRemarks" runat="server" Width="150px" autocomplete="off" 
                                                                                meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr id="trTaskAssign" runat="server">
                                                        <td runat="server">
                                                            <asp:Label ID="Rs_TaskAssignTo" Text="Task Assign To" runat="server"></asp:Label>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:CheckBoxList ID="chkAssignTotask" onclick="javascript:dispTask(this.id);" runat="server">
                                                            </asp:CheckBoxList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlRefund" GroupingText="Refund" runat="server" 
                                                meta:resourcekey="pnlRefundResource1">
                                                <asp:Button ID="btnRefund" OnClientClick="return ChequeValidate();" Text="Refund"
                                                    runat="server" Enabled="False" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                    onmouseout="this.className='btn1'" OnClick="btnRefund_Click" 
                                                    meta:resourcekey="btnRefundResource1" />
                                                &nbsp;<asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                    onmouseout="this.className='btn1'" OnClick="btnCancel_Click" 
                                                    meta:resourcekey="btnCancelResource1" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr style="display: none" runat="server" id="trpnlAssign">
                                        <td runat="server">
                                            <asp:Button ID="btnTask" OnClientClick="return ChequeValidate1();" Text="Task" runat="server"
                                                CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                OnClick="btnTask_Click" />
                                            &nbsp;<asp:Button ID="btnTaskCancel" Text="Cancel" runat="server" CssClass="btn1"
                                                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                OnClick="btnCancel_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlCancel" runat="server" meta:resourcekey="pnlCancelResource1">
                                                <asp:Label ID="Rs_ReasonforCancel"  Text="Reason for Cancel :"  runat="server" 
                                                    meta:resourcekey="Rs_ReasonforCancelResource1"></asp:Label>
                                                <asp:TextBox ID="txtCancelReason" runat="server"  CssClass ="Txtboxsmall"
                                                    meta:resourcekey="txtCancelReasonResource1"></asp:TextBox>
                                                <br />
                                                <asp:Button ID="btnCancelBill" runat="server" Text="Cancel Bill" CssClass="btn1"
                                                    onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                    OnClientClick="javascript:return ValidateReason();" 
                                                    ToolTip="Do you want to Cancel this Bill?" 
                                                    meta:resourcekey="btnCancelBillResource1" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" runat="server" />
        <input type="hidden" id="hdnBillStatus" name="bStatus" runat="server" />
        <asp:HiddenField ID="hdnCurRefAmount" runat="server" />
        <asp:HiddenField ID="hdnTemprefAmount" runat="server" />
        <asp:HiddenField ID="hdnCurrencyAmount" runat="server" />
        <asp:HiddenField ID="hdnBaseCurrencyID" runat="server" />
        <asp:HiddenField ID="hdntrTaskAssign" runat="server" />
        <uc5:Footer ID="Footer2" runat="server" />

        <script type="text/javascript" language="javascript">
            if (document.getElementById('hdntrTaskAssign').value == "0") {
                document.getElementById('trTaskAssign').style.display = "none";
            }
        </script>

        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
