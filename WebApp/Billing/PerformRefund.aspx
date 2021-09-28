<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="PerformRefund.aspx.cs"
    Inherits="Billing_PerformRefund" meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Perform Refund</title>

    <style type="text/css">
        .fontSizes
        {
            font-size: 12px;
            font-family: Verdana, Arial;
        }
        .style2
        {
            height: 38px;
        }
        .style3
        {
            height: 28px;
        }
        .style4
        {
            height: 33px;
        }
        .tableWidth
        {
            width: 200px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function Reject() {
            if (document.getElementById('rblAcc_1').checked) {
                document.getElementById('trReject').style.display = "block";
                document.getElementById('txtReject').focus();
            }
            else {
                document.getElementById('trReject').style.display = "none";
                document.getElementById('txtReject').value = "";
            }
        }
        function sumAmount(ID) {
            var sum = 0;
            var s = ToInternalFormat($('#' + document.getElementById(ID).id));
            var lblReceiveAmountId = ID.replace("TxtRfdAmt", "lblRfdAmt")
            var ReceivedAmount = ToInternalFormat($('#' + document.getElementById(lblReceiveAmountId).id));

            if (s == "" || s == 0) {
                document.getElementById(ID).value = "0.00";
                ToTargetFormat($('#' + document.getElementById(ID).id));
                return false;
            }
            if (Number(s) > Number(ReceivedAmount)) {
                alert('Amount Can not be greater than Requested Amount');
                document.getElementById(ID).focus();
                return false;
            }
        }
        function blacktext(e) {
            if (!((e.keyCode >= 48) && (e.keyCode <= 57))) {
                if (e.keyCode == 46) {
                    return true;
                }
                else {
                    e.keyCode = 0;
                }
            }
        }
        function limitlength(obj, length) {
            var maxlength = length
            if (obj.value.length > maxlength)
                obj.value = obj.value.substring(0, maxlength)
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
        function getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10,v11) {
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
               + "&PNumber=" + v4
               + "&IsPopup=Y"
               + "&RefundAmount=" + v5
               + "&RefundVoucherNo=" + v6
               + "&VID=" + v7
               + "&PatientID=" + v8
               + "&btype=" + v9
               + "&FinallBillID=" + v10
               + "&RefFlag=" + v11;
                window.open(strURL, "", strFeatures, true);
            }
            else {
            
            }
        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <ul>
                            <li>
                                <asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1" Visible="false"></asp:Label>
                            </li>
                        </ul>
                      
                        <table class="w-100p">
                            <tr>
                                <tr>
                                    <td class="v-top w-50p">
                                        <asp:Panel ID="pnlas" runat="server" CssClass="dataheader3" GroupingText="Patient Details">
                                            <table class="w-100p">
                                                <tr class="a-left">
                                                    <td>
                                                        <asp:Label ID="re_" Text="Patient No" runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="re_age" Text="Patient Age" runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="labAge" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="re_sex" Text="Sex" runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lalSex" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_BillNo" Text="Bill No " runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="re_BillDate" Text="Bill Date " runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lalBillDate" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="re_BilledBy" Text="BilledBy  " runat="server" />
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td colspan="4">
                                                        <asp:Label ID="lalBilledBy" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                    <td class="v-top w-30p">
                                        <asp:Panel ID="Panel5" runat="server" CssClass="dataheader3 amtDetails" GroupingText="Amount Details">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblAmtReceivedText" runat="server" Text="Amount Received from the Patient is"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblTotAmtReceived" CssClass="errormsg" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblAmtRefundedText" runat="server" Text="Amount Refunded to the Patient is "></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblTotAmtRefunded" CssClass="errormsg" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td>
                                                        <asp:Label ID="lblRefAmt" runat="server" Text="Refundable Amount is "></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblRefundableAmt" CssClass="errormsg" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDueAmt" runat="server" Text="Due Amount"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbltxtDueAmt" CssClass="errormsg" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </tr>
                        </table>
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Panel CssClass="dataheader2" ID="grdPanel" runat="server" meta:resourcekey="grdPanelResource1">
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:GridView ID="grdResult" OnRowDataBound="grdResult_RowDataBound" CellPadding="2" 
													AutoGenerateColumns="False" DataKeyNames="BillingDetailsID" ForeColor="#333333"
                                                        CssClass="mytable1 gridView w-100p" runat="server">
                                                        <RowStyle BackColor="White" HorizontalAlign="Left" Font-Bold="True" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Description">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("FeeDescription") %>'></asp:Label></ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Billed Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount","{0:0.00}") %>'></asp:Label></ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Reqest Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRfdAmt" runat="server" Text='<%# Bind("RefundedAmt") %>'></asp:Label></ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Amount To Refund">
                                                                <ItemTemplate>
                                                                    <asp:TextBox onblur="return sumAmount(this.id);"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                                        ID="TxtRfdAmt" Width="100px" Text='<%# Bind("RefundedAmt") %>' runat="server"></asp:TextBox></ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Reason" HeaderStyle-Width="160px">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlType" runat="server" Enabled="false" Width="150px">
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr id="trCancelForReason" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label runat="server" ID="lblReson" Text="Reason for Cancel :" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblCancelForReason"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                    <asp:Panel ID="pnlAssign" CssClass="dataheader3" GroupingText="Payment Details" runat="server">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_SelectModeofPayment" Text="Select Mode of Payment" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rblPaymode" RepeatDirection="Horizontal"
                                                        runat="server">
                                                        <asp:ListItem Selected="True" Value="1" Text="Cash"></asp:ListItem>
                                        <asp:ListItem Text="Credit Card" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Cheque" Value="3" Enabled="false"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_SelectPayingCurrency" Text="Select Paying Currency" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlBaseCurrency" ToolTip="Select Currency" runat="server" CssClass="ddlmedium">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_RefundableAmountis" Text="Refundable Amount is:(" runat="server">
                                                    </asp:Label><asp:Label ID="lblCurName" runat="server"></asp:Label>)
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCurrChange" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="a-center">
                                                    <div id="chequediv" runat="server" style="display: none">
                                                        <table>
                                                            <tr class="a-center">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Rs_ChequeNo" Text="Cheque No." runat="server"></asp:Label>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Rs_Bank" Text="Bank" runat="server"></asp:Label>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Rs_Remarks" Text="Remarks" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td nowrap="nowrap">
                                                                    <asp:TextBox runat="server" ID="txtNumber"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                        autocomplete="off" Width="130px" MaxLength="19"></asp:TextBox>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:TextBox runat="server" ID="txtBankType" Width="220px">
                                                                    </asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                                        MinimumPrefixLength="1" ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx"
                                                                        TargetControlID="txtBankType" DelimiterCharacters="" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:TextBox ID="txtRemarks" runat="server" Width="150px" autocomplete="off"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr id="trCancel" runat="server" style="display: none;">
                                <td class="a-center">
                                    <table>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Button ID="btnCancelRfd" runat="server" Text=" Cancel" CssClass="btn" OnClick="btnCancelRefund_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trRefundMode" runat="server">
                                <td class="a-center">
                                    <asp:Panel CssClass="dataheader2" BorderWidth="1px" ID="Panel4" runat="server" Visible="False">
                                        <table>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnRefund" runat="server" Text=" Submit " CssClass="btn" OnClick="btnRefund_Click" />
                                                    &nbsp;<asp:Button ID="btnCancelRefund" runat="server" Text=" Cancel" CssClass="btn"
                                                        OnClick="btnCancelRefund_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Panel CssClass="dataheader2" ID="Panel2" runat="server" meta:resourcekey="Panel2Resource1">
                                        <table class="w-100p">
                                            <tr>
                                                <td id="tdApprove" runat="server">
                                                    <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rblAcc" RepeatDirection="Horizontal"
                                                        runat="server" meta:resourcekey="rblAccResource1">
                                                        <asp:ListItem Selected="True" Value="1" Text="Approve" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="Reject" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnOk" runat="server" Text=" Ok " CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn1'" OnClick="btnOk_Click" meta:resourcekey="btnOkResource1" />
                                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text=" Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr id="trReject" style="display: none">
                                <td>
                                    <asp:Panel CssClass="dataheader2" BorderWidth="1px" GroupingText="Reason for Reject (max length is 250 characters)"
                                        ID="Panel3" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtReject" Width="500px" onkeyup="return limitlength(this, 250)"
                                                        TextMode="MultiLine" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="a-center">
                                    &nbsp;<asp:Button ID="btnCancel1" runat="server" Visible="false" Text=" Cancel" CssClass="btn1"
                                        onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                        OnClick="btnCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
               
        <asp:HiddenField ID="hdnPatientNo" runat="server" />
    <asp:HiddenField ID="hdnOldValues" runat="server" />
        <asp:HiddenField ID="hdnFinalBillId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnCancelBill" runat="server" Value="N" />
       <Attune:Attunefooter ID="Attunefooter" runat="server" /> 

<%--    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function ToInternalFormat(pControl) {
            // debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.asNumber({ region: "<%=LanguageCode%>" });
            }
        }

        function ToTargetFormat(pControl) {
            // debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }

        // Added By jayaramanan L //

        function ValidationWindowCustom(message, tt, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) {
            //var def = $.Deferred();
            jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11);
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");

            }
        }).dialog("open");
            return false;
            // return def.promise();
        }

        function getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) {
            //   var vValidateRefundAmtAlert = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10') == null ? "Do you wish to take Print?" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10');
            var objvarAlert = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_13") == null ? "Alert" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_13");
            var i;
            var objvar13 = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_16") == null ? "Do you wish to take Print?" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_16");
            var btnoktext = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_14") == null ? "OK" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_14");
            var btnclosetext = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_15") == null ? "Close" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_15");
            var ans;
            var a;
            var oldpath = window.location.href;
            var curpath = window.location.href;
            a = curpath.indexOf("WebApp");
            curpath = curpath.substring(0, a);
            //ans = window.confirm('Do you wish to take Print?');
            ans = ConfirmWindow(objvar13, objvarAlert, btnoktext, btnclosetext);
            if (ans == true) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";

                var strURL = "../Billing/RefundVoucher.aspx?BillNo="
               + v1
               + "&BilledAmt=" + v2
               + "&Name=" + v3
               + "&PNumber=" + v4
               + "&IsPopup=Y"
               + "&RefundAmount=" + v5
               + "&RefundVoucherNo=" + v6
               + "&VID=" + v7
               + "&PatientID=" + v8
               + "&btype=" + v9
               + "&FinallBillID=" + v10
               + "&RefFlag=" + v11;
                window.open(strURL, "", strFeatures, true);
            }
            else {
            }
        }

        // End //

        
    </script>

    </form>
</body>
</html>