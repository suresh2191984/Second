<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillCollect.aspx.cs" Inherits="InPatient_BillCollect" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Collect Payments</title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ValidateOTH() {
            if (document.form1.txtDesc.value == '') {
                alert('Provide description for miscellaneous ');
                document.form1.txtDesc.focus();
                return false;
            }
            if (document.form1.txtAmt.value == '') {
                alert('Provide amount for miscellaneous ');
                document.form1.txtAmt.focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />

    <script type="text/javascript">
        animatedcollapse.addDiv('Due', 'fade=1,height=1%');
        animatedcollapse.init();

        function CheckBilling() {
            var returndatavalue = SaveValidation();

            if (returndatavalue == true) {
                if (Number(document.getElementById('txtGrandTotal').value) < Number(document.getElementById('txtAmountRecieved').value)) {

                alert('Amount received greater than current total');
                    document.getElementById('txtAmountRecieved').value = '';
                    document.getElementById('hdnAmountReceived').value = '0';
                    return false;
                }
                if (document.getElementById('chkisCreditTransaction').checked == false) {

                    if (Number(document.getElementById('txtAmountRecieved').value) <= 0) {

                alert('Provide received amount');
                        return false;
                    }
                }
                document.getElementById('btnSave').style.display = 'none';
                return true;
            }
            else {
                return false;
            }
        }

        function DefaultText(id) {

            document.getElementById(id).value = "";

        }

        function totalCalculate() {
            var GrossAmount = document.getElementById('<%= hdnGross.ClientID %>').value;
            var DiscountAmount = document.getElementById('<%= txtDiscount.ClientID  %>').value;
            var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0) {
                alert('Discount cannot be greater than gross amount');
                document.getElementById('<%= txtDiscount.ClientID  %>').value = 0;
                GrandTotal.value = document.getElementById('<%= hdnGross.ClientID %>').value;
            }
            else {
                GrandTotal.value = format_number((Number(GrossAmount) - Number(DiscountAmount)), 2);
            }
        }

        function AmountRecieved() {
            var grandTotal = document.getElementById('txtGrandTotal').value;
            var amountRecieved = document.getElementById('txtAmountRecieved').value;
        }

        function ChangeFormat() {
            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
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

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var sVal = document.getElementById('txtAmountRecieved').value;
            var sNetValue = document.getElementById('txtGrandTotal').value;
            var tempService = document.getElementById('txtServiceCharge').value;

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 2);

            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                document.getElementById('txtServiceCharge').value = format_number(Number(ServiceCharge) + Number(tempService), 2);
                document.getElementById('hdnServiceCharge').value = format_number(Number(ServiceCharge) + Number(tempService), 2);
                document.getElementById('txtAmountRecieved').value = sVal;
                document.getElementById('hdnAmountReceived').value = sVal;
                document.getElementById('txtGrandTotal').value = sNetValue;

                return true;
            }
            else {
                alert('Amount provided is greater than net amount');
                return false;
            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var sVal = document.getElementById('txtAmountRecieved').value;
            sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
            var tempService = document.getElementById('txtServiceCharge').value;
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            document.getElementById('txtServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);
            document.getElementById('hdnServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);

            document.getElementById('txtAmountRecieved').value = sVal;
            document.getElementById('hdnAmountReceived').value = sVal;
        }

        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }
        
    </script>

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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="3" align="right">
                                    <asp:Button ID="btnBack" runat="server" CssClass="btn" OnClick="btnBack_Click" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Back" 
                                        meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="letf" class="dataheader2">
                                    <asp:Panel ID="trABI" runat="server" CssClass="defaultfontcolor" 
                                        meta:resourcekey="trABIResource1">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="left" colspan="2" height="23" class="colorforcontent">
                                                    <div id="ACX2plusOmc" style="display: none">
                                                        &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',1);"
                                                            src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                        <span class="dataheader1txt" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',1);"
                                                            style="cursor: pointer">&nbsp;More Payments</span>
                                                    </div>
                                                    <div id="ACX2minusOmc" style="display: block">
                                                        &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',0);"
                                                            src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                        <span class="dataheader1txt" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',0);"
                                                            style="cursor: pointer">&nbsp;<asp:Label ID="Rs_MorePayments" 
                                                            Text="More Payments" runat="server" meta:resourcekey="Rs_MorePaymentsResource1"></asp:Label></span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="ACX2responsesOmc" class="tablerow" style="display: block">
                                                <td>
                                                   <asp:Label ID="Rs_Description" Text="Description" runat="server" 
                                                        meta:resourcekey="Rs_DescriptionResource1"></asp:Label>&nbsp;<asp:TextBox 
                                                        ID="txtDesc" CssClass="Txtboxsmall" runat="server" MaxLength="45" TabIndex="11" 
                                                        meta:resourcekey="txtDescResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                  <asp:Label ID="Rs_Amount" Text="Amount" runat="server" 
                                                        meta:resourcekey="Rs_AmountResource1"></asp:Label>&nbsp;<asp:TextBox 
                                                        ID="txtAmt" CssClass="Txtboxsmall" runat="server" MaxLength="10"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                        TabIndex="12" meta:resourcekey="txtAmtResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddAmt" runat="server" CssClass="btn" OnClientClick="return ValidateOTH();"
                                                        OnClick="btnAddAmt_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        TabIndex="13" Text="Add" meta:resourcekey="btnAddAmtResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right" class="dataheader2">
                                    <asp:GridView ID="gvIndents" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvIndents_RowDataBound"
                                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                        CellPadding="3" Font-Bold="False" meta:resourcekey="gvIndentsResource1">
                                        <RowStyle ForeColor="#000066" />
                                        <Columns>
                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                meta:resourcekey="BoundFieldResource3" />
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Description" DataField="Description" 
                                                meta:resourcekey="BoundFieldResource4">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Comments" DataField="Comments" 
                                                meta:resourcekey="BoundFieldResource5">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="From" DataField="FromDate" 
                                                DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                meta:resourcekey="BoundFieldResource6">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="To" DataField="ToDate" 
                                                DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                meta:resourcekey="BoundFieldResource7">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="UnitPrice" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                        Text='<%# Eval("AMOUNT") %>'  onkeypress="return ValidateOnlyNumeric(this);"  
                                                        Width="60px" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity" 
                                                meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                        Text='<%# Eval("unit") %>'  onkeypress="return ValidateOnlyNumeric(this);"  
                                                        Width="60px" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount" 
                                                meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                        Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                        meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td width="22%">
                                    &nbsp;
                                </td>
                                <td width="31%" align="right">
                                    <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" 
                                        class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />
                                </td>
                                <td width="20%" align="right" class="details_value">
                                    <asp:HiddenField ID="hdnGross" runat="server" />
                                    <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1"  CssClass ="Txtboxsmall"
                                        Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                    <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount" 
                                        class="defaultfontcolor" meta:resourcekey="lblDiscountResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtDiscount" runat="server" TabIndex="4" onkeyup="totalCalculate();"
                                        Text="0.00" CssClass="Txtboxsmall" onblur="ChangeFormat();" 
                                         onkeypress="return ValidateOnlyNumeric(this);"  
                                        meta:resourcekey="txtDiscountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" 
                                        meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                        CssClass="Txtboxsmall" 
                                        meta:resourcekey="txtServiceChargeResource1" />
                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                   <asp:Label ID="Rs_SurgeryAdvanceReceived" Text="Surgery Advance Received" 
                                        runat="server" meta:resourcekey="Rs_SurgeryAdvanceReceivedResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                        CssClass="Txtboxsmall" 
                                        meta:resourcekey="txtRecievedAdvanceResource1" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" 
                                        class="defaultfontcolor" meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" TabIndex="8" 
                                        CssClass="Txtboxsmall" meta:resourcekey="txtGrandTotalResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" 
                                        class="defaultfontcolor" meta:resourcekey="lblAmountRecievedResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" ReadOnly="True" 
                                        CssClass="Txtboxsmall" meta:resourcekey="txtAmountRecievedResource1" />
                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right" colspan="2">
                                    <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                                        class="defaultfontcolor" onclick="checkIsCredit();" 
                                        meta:resourcekey="chkisCreditTransactionResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <uc13:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:Button ID="btnSave" runat="server" Text="Generate Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return CheckBilling();" 
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" Width="77px" />
                                    &nbsp;<asp:Button ID="btnClose" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Close" OnClick="btnClose_Click" 
                                        meta:resourcekey="btnCloseResource1" Width="62px" />
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
