<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prescriptionStockReturn.aspx.cs" Inherits="Corporate_prescriptionStockReturn" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title> Stock Refund </title>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
     <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/InvOpBilling.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function Vallida() {
            document.getElementById('btnRefund').style.display = 'none';

        }
        
          
     
    </script>
</head>

    
    <body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
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
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        
                   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                           <%-- <tr>
                                <td width="5%" align="center">
                                    &nbsp;
                                </td>
                                <td width="16%" align="center">
                                    &nbsp;
                                </td>
                                <td colspan="3" align="center">
                                    <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                                    </label>
                                </td>
                                <td width="17%" align="center">
                                    &nbsp;
                                </td>
                                <td width="7%" align="center">
                                    &nbsp;
                                </td>
                            </tr>--%>
                         <tr>
                                <td colspan="6" align="center" style="height: 35px; font-weight: bold;
                                                    text-decoration: underline;">
                                                    Prescription Details
                                 </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>
                             <tr style="height: 15px;">
                                                <td style="width: 50px">
                                                    <asp:Label ID="Label1" runat="server" Text="Name" Font-Bold="True" 
                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPname" runat="server" meta:resourcekey="lblPnameResource1"></asp:Label>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label ID="lblNumber" runat="server" Text="Patient No" Font-Bold="True" 
                                                        meta:resourcekey="lblNumberResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPNumber" runat="server" 
                                                        meta:resourcekey="lblPNumberResource1"></asp:Label>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label ID="Label2" runat="server" Text="Doctor Name" Font-Bold="True" 
                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDoctorname" runat="server" 
                                                        meta:resourcekey="lblDoctornameResource1"></asp:Label>
                                                </td>
                                         </tr>
                             <tr style="height: 15px;">
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text="Gender" Font-Bold="True" 
                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text="Prescription No" Font-Bold="True" 
                                                    meta:resourcekey="Label4Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVoucherno" runat="server" 
                                                    meta:resourcekey="lblVouchernoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="Prescription Date" Font-Bold="True" 
                                                    meta:resourcekey="Label5Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVoucherDtae" runat="server" 
                                                    meta:resourcekey="lblVoucherDtaeResource1"></asp:Label>
                                            </td>
                                        </tr>
                             <tr style="height: 15px;">
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text="Age" Font-Bold="True" 
                                                    meta:resourcekey="Label6Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                            
                        
                          
                            <tr style="height: 15px;">
                                  <td colspan="6" align="center" >
                                    <asp:Label ID="lblResult" runat="server" BackColor="Red" Font-Bold="True" 
                                          meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                            </tr>
                                <tr style="height: 15px;">
                                  <td colspan="6">
                                   
                                </td>
                            </tr>
                                <tr style="height: 15px;">
                                  <td colspan="6">
                                    
                                </td>
                            </tr>
                                <tr style="height: 15px;">
                                  <td colspan="6">
                                   
                                </td>
                            </tr>
                        
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td id="tblDetails" colspan="6">
                                  <asp:GridView ID="gvBillingDetail" OnRowDataBound="gvBillingDetail_RowDataBound"
                                        runat="server" Width="95%" AutoGenerateColumns="False" 
                                        meta:resourcekey="gvBillingDetailResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <HeaderTemplate>
                                                    <asp:CheckBox onclick="ChkAllCheckBox(this.id);" ToolTip="Select All" ID="chkParSelect"
                                                        runat="server" meta:resourcekey="chkParSelectResource1" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" 
                                                        meta:resourcekey="chkSelectResource1" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ProductName" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" Text='<%# Bind("ProductName") %>' runat="server" 
                                                        meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BatchNo" 
                                                meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBatch" Text='<%# Bind("BatchNo") %>' runat="server" 
                                                        meta:resourcekey="lblBatchResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="ExpiryDate" 
                                                meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                       
                                                        <%# Eval("ExpiryDate", "{0:MMM/yyyy}")%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                           <%-- <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry" DataFormatString="{0: MMM, yyyy}" />--%>
                                            <asp:BoundField DataField="Quantity" HeaderText="Issued Qty" 
                                                DataFormatString="{0:F2}" meta:resourcekey="BoundFieldResource1" />
                                          <%-- <asp:BoundField DataField="Amount" HeaderText="Issued Rate" DataFormatString="{0:F2}" />--%>
                                            <asp:TemplateField HeaderText="Return Qty" 
                                                meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtReturnQuantity" Text="0.00" onkeydown="return validateNaN(event)"
                                                        runat="server" Width="80px" meta:resourcekey="txtReturnQuantityResource1"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnIssuedQuantity" Value='<%# Eval("Quantity") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Amount To Refund" 
                                                meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRefundAmount" Text="0.00" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                        Width="85px" meta:resourcekey="txtRefundAmountResource1"></asp:TextBox>
                                                </ItemTemplate>
                                              
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason for Refund" 
                                                meta:resourcekey="TemplateFieldResource7">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtReason" runat="server" Width="80px" 
                                                        meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnIssuedAmount" Value='<%# Eval("Amount") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnBillingDetailsID" Value='<%# Eval("providedby") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnFinalBillID" Value='<%# Eval("ParentProductID") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnFeeId" Value='<%# Eval("ProductID") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnRate" Value='<%# Eval("Amount") %>' runat="server" />
                                                    <asp:HiddenField ID="hfnStockOutFlowID" Value='<%# Eval("ID") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnUnitPrice" Value='<%# Eval("UnitPrice") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnSellingUnit" Value='<%# Eval("SellingUnit") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnExpiryDate" Value='<%# Eval("ExpiryDate") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnSellingPrice" Value='<%# Eval("Rate") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnProductKey" Value='<%# Eval("ProductKey") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnReturnQuantity" Value='<%# Eval("invoiceQty") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnLocationID" Value='<%# Eval("LocationID") %>' 
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnPrescriptionNo" Value='<%# Eval("PrescriptionNO") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                         <asp:TemplateField Visible="false" HeaderText="Return Qty" 
                                                meta:resourcekey="TemplateFieldResource8">
                                               <ItemTemplate>
                                                    <asp:Label ID="lblReturnQuantity" runat="server" 
                                                        Text='<%# Bind("invoiceQty") %>' meta:resourcekey="lblReturnQuantityResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trtotalamt" runat="server" visible ="false" >
                                <td colspan="6" >
                                    <table border="0" align="center" width="98%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="right" width="69%">
                                                <b>Total Refund Amount :</b>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTotalRefundAmount" Enabled="False" Font-Bold="True" Text="0.00"
                                                    runat="server" Width="82px" CssClass="Txtboxsmall"
                                                    meta:resourcekey="txtTotalRefundAmountResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                                    <asp:Button ID="btnRefund" Text="Refund" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnRefund_Click" 
                                        OnClientClick="Vallida();" meta:resourcekey="btnRefundResource1" />
                                    &nbsp;<asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn'"  OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="hdnIsPharmacisitCashier" value="N" runat="server" />
                        <input type="hidden" id="hdnOrderRefundNo" value="0" runat="server" />
                        <input type="hidden" id="hdnIsTaskBillOrPay" value="0" runat="server" />
                        <asp:HiddenField ID="hdnValues" runat="server" />
                        <asp:HiddenField ID="hdnVid" runat="server" />
                        <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                        <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
                        <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="hiddenTargetControlFormpeOthers"
                            PopupControlID="pnlOrderRefund"  BackgroundCssClass="modalBackground"
                            DynamicServicePath="" Enabled="True" />
                        <asp:Panel ID="pnlOrderRefund" runat="server" CssClass="modalPopup dataheaderPopup"
                            Width="15%" Height="10%" Style="display: none" meta:resourcekey="Panel1Resource1">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRefundNotxt" runat="server" Font-Bold="True" 
                                            Text="Refund Task Number is :" meta:resourcekey="lblRefundNotxtResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblRefundNo" runat="server" 
                                            meta:resourcekey="lblRefundNoResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" valign="bottom">
                                        <asp:Button ID="btnClose" CssClass="btn" Text="Ok" runat="server" 
                                            meta:resourcekey="btnCloseResource1"  />
                                         
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <uc5:Footer ID="Footer1" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function funcChkAmountQty(IssuedQuantity, IssuedAmount, ReturnQuantity, RefundAmount) {
            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pIssuedAmount = (document.getElementById(IssuedAmount).value);
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;
            var pRefundAmount = (document.getElementById(RefundAmount).value);

            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {
                alert('Provide return quantity less than or equal to issued quantity');
                document.getElementById(ReturnQuantity).focus();
                document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                return false;
            }
            var TempAmount = 0;
            if (pReturnQuantity > 0) {
                var TempAmount = (Number((pReturnQuantity) * Number(pIssuedAmount) / pIssuedQuantity).toFixed(2));
                TotalRefundAmount(TempAmount)
                document.getElementById(RefundAmount).value = Number(TempAmount).toFixed(2);
                TotalRefundAmount();
            }


        }

        function funcChkAmount(IssuedQuantity, IssuedAmount, ReturnQuantity, RefundAmount) {
            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pIssuedAmount = (document.getElementById(IssuedAmount).value);
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;
            var pRefundAmount = (document.getElementById(RefundAmount).value);

            var TempAmount = (Number(pReturnQuantity) * Number(pIssuedAmount));
            if (TempAmount != 0) {
                if (Number(TempAmount) < Number(pRefundAmount)) {
                    alert('Provide return amount less than or equal to issued amount');
                    document.getElementById(RefundAmount).focus();
                    document.getElementById(RefundAmount).value = Number(TempAmount).toFixed(2);
                    return false;
                }
                TotalRefundAmount();
            }

        }
        function funcReturnAllQty(chkselect, IssuedQuantity, IssuedAmount, ReturnQuantity, RefundAmount) {

            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pchkselect = document.getElementById(chkselect).checked;
            var pIssuedAmount = (document.getElementById(IssuedAmount).value);
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;
            var pRefundAmount = (document.getElementById(RefundAmount).value);
            var TempAmount = (Number(pReturnQuantity) * Number(pIssuedAmount));

            if (pchkselect == true) {
                document.getElementById(ReturnQuantity).value = pIssuedQuantity;
                pReturnQuantity = pIssuedQuantity;
            }
            else {
                document.getElementById(chkselect).checked = false;
                pReturnQuantity = 0
                document.getElementById(ReturnQuantity).value = 0;
            }


            var TempAmount = 0;

            var TempAmount = (Number((pReturnQuantity) * Number(pIssuedAmount) / pIssuedQuantity).toFixed(2));
            TotalRefundAmount(TempAmount)
            document.getElementById(RefundAmount).value = Number(TempAmount).toFixed(2);
            TotalRefundAmount();


        }
        function ChkAllCheckBox(chkobj) {
            
            var pchk = document.getElementById(chkobj).checked;

            var x = document.getElementById('hdnValues').value.split('^');
            for (k = 0; k < x.length; k++) {
                if (x[k] != "") {
                    val = x[k].split("~");
                    if (pchk == true) {
                        document.getElementById(val[4]).click();
                       
                    }
                    else {
                        document.getElementById(val[4]).click();
                    }

                    //document.getElementById(val[4]).click();

                }
            }
        }


        function TotalRefundAmount() {
            var temoTotal = 0.00;
            var x = document.getElementById('hdnValues').value.split('^');
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split("~");
                    temoTotal = format_number(Number((document.getElementById(y[3]).value), 2) + Number(temoTotal), 2);

                }

            }
            document.getElementById('txtTotalRefundAmount').value = getOPCustomRoundoff(Number(temoTotal).toFixed(2));

        }


        function INVconfirm() {
            var valw = document.getElementById('txtTotalRefundAmount').value;
            var agree = confirm("Are you sure want to Refunded the Amount(" + Number(valw).toFixed(2) + "?");
            if (agree)
                return true;
            else
                return false;

        }


        
        
    </script>

</body>

</html>
