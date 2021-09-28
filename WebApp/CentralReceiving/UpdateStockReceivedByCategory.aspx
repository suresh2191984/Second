<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateStockReceivedByCategory.aspx.cs"
    Inherits="CentralReceiving_UpdateStockReceivedByCategory" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Received By Category</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script type="text/javascript" src="Scripts/CentralStockReceivedByCategory.js" ></script>
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td class="w-100p v-top">
                    <table id="stockReceivedTab" runat="server" class="dataheaderInvCtrl w-100p padding4">
                        <tr>
                            <td class="a-left w-8p">
                                <asp:Label ID="lblPurchesOrder" runat="server" Text="Purchase Order No" meta:resourcekey="lblPurchesOrderResource2"></asp:Label>
                            </td>
                            <td class="w-8p">
                                <asp:TextBox ID="txtPurchaseOrderNo" runat="server" MaxLength="255" CssClass="txtboxps" onKeyPress="return ValidateMultiLangChar(this);"
                                    TabIndex="1" meta:resourcekey="txtPurchaseOrderNoResource2"></asp:TextBox>
                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td class="a-left w-8p">
                                <asp:Label ID="lblReceivedDate" runat="server" Text="Received Date" meta:resourcekey="lblReceivedDateResource2"></asp:Label>
                            </td>
                            <td class="w-12p">
                                <asp:TextBox ID="txtReceivedDate" runat="server" CssClass="datePicker" onKeyPress="return ValidateSpecialAndNumeric(this);" TabIndex="2"
                                    meta:resourcekey="txtReceivedDateResource2"></asp:TextBox>
                            </td>
                            <td class="a-left w-8p">
                                <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" meta:resourcekey="lblSupplierNameResource2"></asp:Label>
                            </td>
                            <td class="w-8p">
                                <asp:DropDownList onchange="javascript:funcChangeType();" ID="ddlSupplier" Width="120px"
                                    TabIndex="3" runat="server" meta:resourcekey="ddlSupplierResource2">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtSupplierName" Style="display: none;" runat="server" ReadOnly="True" onKeyPress="return ValidateMultiLangChar(this);"
                                    MaxLength="255" CssClass="txtboxps" meta:resourcekey="txtSupplierNameResource2"></asp:TextBox>
                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                <input type="hidden" id="hdnSupplierID" runat="server" />
                                <input type="hidden" id="hdnStockReceivedNo" runat="server" value="0" />
                                <input type="hidden" id="hdnPOID" runat="server" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left">
                                <asp:Label ID="lblDCNumber" runat="server" Text="DC Number" meta:resourcekey="lblDCNumberResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDCNumber" runat="server" MaxLength="50" onKeyPress="return ValidateMultiLangChar(this);"
                                    TabIndex="4" onBlur="return getvalidation(event);" CssClass="txtboxps" meta:resourcekey="txtDCNumberResource2"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteDcNumber" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                    MinimumPrefixLength="1" OnClientItemSelected="ChkDcSupplierCombination" ServiceMethod="GetSuppliernumcombination"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtDCNumber"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td class="a-left">
                                <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceNo" runat="server" MaxLength="50" onKeyPress="return ValidateMultiLangChar(this);"
                                    TabIndex="5" onBlur="return getvalidation(event);" CssClass="txtboxps" meta:resourcekey="txtInvoiceNoResource2"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteInvoiceNumber" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                    MinimumPrefixLength="1" OnClientItemSelected="ChkInvoiceSupplierCombination"
                                    ServiceMethod="GetSuppliernumcombination" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    TargetControlID="txtInvoiceNo" DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td class="a-left">
                                <asp:Label ID="Label2" runat="server" Text="Invoice Date" 
                                    meta:resourcekey="Label2Resource1"></asp:Label>
                            </td>
                            <td class="w-10p">
                                <asp:TextBox ID="txtInvoiceDate" runat="server" CssClass="datePicker" 
                                    Width="115px" TabIndex="6" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    Enabled="False" meta:resourcekey="txtInvoiceDateResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left">
                                <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" Columns="25" Rows="2" onKeyPress="return ValidateMultiLangChar(this);"
                                    TabIndex="7" meta:resourcekey="txtCommentsResource2"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:Panel ID="panelCalculation" runat="server" GroupingText="Calculation" 
            meta:resourcekey="panelCalculationResource1">
            <input type="radio" name="calculation" value="CP" id="rbtnCP" onclick="ChangeCalculation(this);"
                runat="server" /> <span style="vertical-align: top"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_01%></span>
            <input type="radio" name="calculation" value="SP" id="rbtnMRP" onclick="ChangeCalculation(this);"
                runat="server" /> <span style="vertical-align: top"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_02%></span>
        </asp:Panel>
        <div id="divStockReceived" runat="server">
        </div>
        <table class="w-100p">
            <tr>
                <td>
                    <table class="w-100p a-right" id="tbTotalCost">
                        <tr>
                            <td class="a-right w-85p">
                                <asp:Label ID="lblAvailableCreditAmount" runat="server" 
                                    Text="Available Credit Amount" 
                                    meta:resourcekey="lblAvailableCreditAmountResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtAvailCreditAmount" Width="70px" CssClass="small" Style="text-align: right;"
                                    onKeyPress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" 
                                    meta:resourcekey="txtAvailCreditAmountResource1"></asp:TextBox>
                                <asp:HiddenField ID="hdnAvailableCreditAmount" runat="server" />
                            </td>
                        </tr>
                        <tr id="trSupplierServiceTax" runat="server">
                            <td class="a-right">
                                <asp:Label ID="lblSupplierService" runat="server" 
                                    Text="Supplier Service Tax(%)" meta:resourcekey="lblSupplierServiceResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtTotaltax" Width="70px" onkeyup="CalculateSupplierServiceTax('CL');"
                                    Style="text-align: right" CssClass="Txtboxsmall" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    runat="server" Text="0.00" meta:resourcekey="txtTotaltaxResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblTotDiscountAmoun" runat="server" Text="Total Discount Amount" 
                                    meta:resourcekey="lblTotDiscountAmounResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtDiscountAmt" runat="server" Style="text-align: right;" CssClass="small w-70 a-right"
                                    Text="0.00" onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtDiscountAmtResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trTotalTaxAmount" runat="server">
                            <td class="a-right">
                                <asp:Label ID="lblToTaxAmo" runat="server" Text="Total Tax Amount" 
                                    meta:resourcekey="lblToTaxAmoResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtTaxAmt" runat="server" CssClass="small a-right w-70" 
                                    Text="0.00" onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtTaxAmtResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblPODiscount" runat="server" Text="PO Discount" 
                                    meta:resourcekey="lblPODiscountResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtTotalDiscount" CssClass="small w-70 a-right" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    runat="server" Text="0.00" onkeyup="CalculatePODiscount('CL');" 
                                    meta:resourcekey="txtTotalDiscountResource1"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total" 
                                    meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtGrandTotal" CssClass="small w-70 a-right" onKeyPress="return ValidateSpecialAndNumeric(this);" runat="server"
                                    Text="0.00" meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblcrditAmt" runat="server" Text="Credit Amount To Be Used" 
                                    meta:resourcekey="lblcrditAmtResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtUseCreditAmount" runat="server" Text="0.00" 
                                    CssClass="small w-70 a-right" onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                    meta:resourcekey="txtUseCreditAmountResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblNetTotal" runat="server" Text="Net Total" 
                                    meta:resourcekey="lblNetTotalResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtNetTotal" runat="server" CssClass="small w-70 a-right" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    Text="0.00" meta:resourcekey="txtNetTotalResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblRoundOffNetTotal" runat="server" Text="Rounded-Off Net Total" 
                                    meta:resourcekey="lblRoundOffNetTotalResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtGrandwithRoundof" onkeyup="CalculateRoundOff();" CssClass="Align a-right w-70" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    runat="server" Text="0.00" meta:resourcekey="txtGrandwithRoundofResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="lblRoundOfValue" runat="server" Text="RoundOff Value" 
                                    meta:resourcekey="lblRoundOfValueResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td class="a-right">
                                <asp:TextBox ID="txtRoundOffValue" runat="server" CssClass="Align w-70 a-right" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtRoundOffValueResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trPackingSale" runat="server" class="hide a-right">
                            <td class="a-right">
                                <input type="checkbox" id="chkPackingSale" onclick="CalculatePackingSale(this);" />
                                <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale" 
                                    meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtPackingSale" runat="server" Style="clear: left;" CssClass="Align w-70 a-right float-l"
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtPackingSaleResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trExciseDuty" runat="server" class="hide">
                            <td class="a-right">
                                <input type="checkbox" id="chkExciseDuty" onclick="CalculateExciseDuty(this);" />
                                <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty" 
                                    meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtExciseDuty" runat="server" CssClass="Align w-70 a-right" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtExciseDutyResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trEduCess" runat="server" class="hide">
                            <td class="a-right">
                                <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess" 
                                    meta:resourcekey="lblEduCessResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtEduCess" runat="server" CssClass="Align w-70 a-right" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtEduCessResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trSecCess" runat="server" class="hide">
                            <td class="a-right">
                                <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess" 
                                    meta:resourcekey="lblSecCessResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtSecCess" runat="server" CssClass="Align a-right w-70" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtSecCessResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trTotal" runat="server" class="hide">
                            <td class="a-right">
                                <asp:Label ID="lblTotal" runat="server" Text="Total"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtTotal" runat="server" CssClass="a-right w-70" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtTotalResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trCST" runat="server" class="hide">
                            <td class="a-right">
                                <asp:Label ID="lblCST" runat="server" Text="CST" 
                                    meta:resourcekey="lblCSTResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtCST" runat="server" CssClass="a-right w-70" 
                                   onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtCSTResource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="a-center">
                <td>
                <a class="btn" onclick="GetStockReceivedDatas();"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_03%></a>
                    <%--<input type="button" value="<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_03%>" class="btn" onclick="GetStockReceivedDatas();" /></center>--%>
                    <asp:Button ID="btnSave" runat="server" class="hide" OnClick="btnSave_Click" 
                        meta:resourcekey="btnSaveResource1" />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnProductList" runat="server" />
        <asp:HiddenField ID="hdnGrandTotal" runat="server" />
        <asp:HiddenField ID="hdnGetTaxList" runat="server" />
        <asp:HiddenField ID="hdnFlag" runat="server" />
        <asp:HiddenField ID="hdncalTaxType" runat="server" />
        <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
        <asp:HiddenField ID="hdnMessages" runat="server" /> 
          <asp:HiddenField ID="hdnExpiryDateFormatDDMMYYY" runat="server" Value="N" />
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
        
    </div>
    <Attune:Attunefooter runat="server" ID="Attunefooter" />

    <script type="text/javascript" src="Scripts/UpdateStockReceivedByCategory.js"></script>
    <script type="text/javascript" src="../PlatForm/Scripts/DateMask.js"></script>
    <script type="text/javascript" src="../PlatForm/Scripts/Json_BrowserSupport.js"></script>

    </form>
</body>
</html>
