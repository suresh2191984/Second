<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CentralStockReceivedByCategory.aspx.cs"
    Inherits="CentralReceiving_CentralStockReceivedByCategory" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Received By Category</title>
    <style>
    #panelCalculation fieldset{height:45px;}
    #panelCalculation fieldset legend{padding-bottom:10px;font-weight:bold;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script type="text/javascript" src="Scripts/CentralStockReceivedByCategory.js" ></script>
<script type="text/javascript" src="Scripts/DateMask.js"></script>
<script type="text/javascript" src="Scripts/Notification.js"></script>
<script type="text/javascript" src="../PlatForm/Scripts/Json_BrowserSupport.js"></script>
                    <div class="contentdata">
                        
                        <div id="divNotification" runat="server" class="notification">
                            <span onclick="HideNotification(this);" class="float-r bold pointer" style="color:#736812;font-family:Arial;padding:4px;">X</span>
                            <p class="float-l paddingL10" style="color:#C4B435"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_01%></p>
                        </div>
                        <table class="w-100p">
                            <tr>
                                <td class="w-100p v-top">
                                    <table id="stockReceivedTab" runat="server" class="w-100p">
                                        <tr>
                                            <td class="a=left w-8p">
                                                <asp:Label ID="lblPurchesOrder" runat="server" Text="Purchase Order No" meta:resourcekey="lblPurchesOrderResource2"></asp:Label>
                                            </td>
                                            <td class="w-8p">
                                                <asp:TextBox ID="txtPurchaseOrderNo" runat="server" MaxLength="255" 
                                                    ReadOnly="True" TabIndex="1" onKeyPress="return ValidateMultiLangChar(this);"
                                                    CssClass="small" meta:resourcekey="txtPurchaseOrderNoResource2"></asp:TextBox>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td class="a-left w-8p">
                                                <asp:Label ID="lblReceivedDate" runat="server" Text="Received Date" meta:resourcekey="lblReceivedDateResource2"></asp:Label>
                                            </td>
                                            <td class="w-12p">
                                                <asp:TextBox ID="txtReceivedDate" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="small datePickerPres" TabIndex="2" meta:resourcekey="txtReceivedDateResource2"></asp:TextBox>
                                            </td>
                                            <td class="a-left w-8p">
                                                <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" meta:resourcekey="lblSupplierNameResource2"></asp:Label>
                                            </td>
                                            <td class="w-8p">
                                                <asp:DropDownList onchange="javascript:funcChangeType();" ID="ddlSupplier" CssClass="small" TabIndex="3"
                                                    runat="server" meta:resourcekey="ddlSupplierResource2">
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtSupplierName" runat="server" ReadOnly="True" onKeyPress="return ValidateMultiLangChar(this);"
                                                    MaxLength="255" CssClass="small hide" meta:resourcekey="txtSupplierNameResource2"></asp:TextBox>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                <input type="hidden" id="hdnSupplierID" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblDCNumber" runat="server" Text="DC Number" meta:resourcekey="lblDCNumberResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDCNumber" runat="server" MaxLength="50" onKeyPress="return ValidateMultiLangChar(this);" TabIndex="4"
                                                    onBlur="return getvalidation(event);" CssClass="small" meta:resourcekey="txtDCNumberResource2"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteDcNumber" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                    MinimumPrefixLength="1" OnClientItemSelected="ChkDcSupplierCombination" ServiceMethod="GetSuppliernumcombination"
                                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtDCNumber" DelimiterCharacters=""
                                                    Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtInvoiceNo" runat="server" MaxLength="50" onKeyPress="return ValidateMultiLangChar(this);" TabIndex="5"
                                                    onBlur="return getvalidation(event);" CssClass="small" meta:resourcekey="txtInvoiceNoResource2"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteInvoiceNumber" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                    MinimumPrefixLength="1" OnClientItemSelected="ChkInvoiceSupplierCombination"
                                                    ServiceMethod="GetSuppliernumcombination" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                    TargetControlID="txtInvoiceNo" DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="Label2" runat="server" Text="Invoice Date" 
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td class="w-10p">
                                                <asp:TextBox ID="txtInvoiceDate" runat="server" TabIndex="6" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                    CssClass="small datePickerPres" meta:resourcekey="txtInvoiceDateResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" Columns="25" Rows="2" TabIndex="7" onKeyPress="return ValidateMultiLangChar(this);"
                                                    meta:resourcekey="txtCommentsResource2"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="panelCalculation" runat="server" GroupingText="Calculation" 
                            meta:resourcekey="panelCalculationResource1"  >
                            <input type="radio" name="calculation" checked="checked"  value="<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_02%>" id="rbtnCP" onclick="ChangeCalculation(this);" /><span style="vertical-align:top"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_03%></span>
                            <input type="radio" name="calculation" value="<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_02%>" id="rbtnMRP" onclick="ChangeCalculation(this);" /><span style="vertical-align:top"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_04%></span>
                        </asp:Panel>
                        <div id="divStockReceived" runat="server" ></div>
                        <table  width="100%" > <tr>
                        <td>
                        
                        
                      
                        <table class="w-100p" id="tbTotalCost">
                            <tr>
                                <td class="a-right w-85p">
                                    <asp:Label ID="lblAvailableCreditAmount" runat="server" 
                                        Text="Available Credit Amount" 
                                        meta:resourcekey="lblAvailableCreditAmountResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtAvailCreditAmount" Enabled="False" CssClass="small a-right" 
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
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtTotaltax" onkeyup="CalculateSupplierServiceTax('CL');" 
                                        onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="small a-right" onKeyDown="return validatenumber(event);" runat="server"
                                        Text="0.00" meta:resourcekey="txtTotaltaxResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblTotDiscountAmoun" runat="server" Text="Total Discount Amount" 
                                        meta:resourcekey="lblTotDiscountAmounResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtDiscountAmt" runat="server" CssClass="small a-right" 
                                       onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtDiscountAmtResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trTotalTaxAmount" runat="server">
                                <td class="a-right">
                                    <asp:Label ID="lblToTaxAmo" runat="server" Text="Total Tax Amount" 
                                        meta:resourcekey="lblToTaxAmoResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtTaxAmt" runat="server" CssClass="small a-right" Text="0.00" 
                                       onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtTaxAmtResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblPODiscount" runat="server" Text="PO Discount" 
                                        meta:resourcekey="lblPODiscountResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtTotalDiscount" CssClass="small a-right" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" Text="0.00" onkeyup="CalculatePODiscount('CL');" 
                                        meta:resourcekey="txtTotalDiscountResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total" 
                                        meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtGrandTotal" CssClass="small a-right" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" Text="0.00" meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblcrditAmt" runat="server" Text="Credit Amount To Be Used" 
                                        meta:resourcekey="lblcrditAmtResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtUseCreditAmount" runat="server" Text="0.00" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small a-right" meta:resourcekey="txtUseCreditAmountResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblNetTotal" runat="server" Text="Net Total" 
                                        meta:resourcekey="lblNetTotalResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtNetTotal" runat="server" CssClass="small a-right" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        Text="0.00" meta:resourcekey="txtNetTotalResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblRoundOffNetTotal" runat="server" Text="Rounded-Off Net Total" 
                                        meta:resourcekey="lblRoundOffNetTotalResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtGrandwithRoundof" onkeyup="CalculateRoundOff();" 
                                        CssClass="small a-right"  runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        Text="0.00" meta:resourcekey="txtGrandwithRoundofResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <asp:Label ID="lblRoundOfValue" runat="server" Text="RoundOff Value" 
                                        meta:resourcekey="lblRoundOfValueResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtRoundOffValue" runat="server" CssClass="small a-right"  Text="0.00" 
                                       onKeyPress="return ValidateSpecialAndNumeric(this);" Enabled="False" meta:resourcekey="txtRoundOffValueResource1"></asp:TextBox>
                                </td>
                            </tr>
                            
                            <tr id="trPackingSale" runat="server" class="hide a-right">
                                <td class="a-right">
                                    <input type="checkbox" id="chkPackingSale" onclick="CalculatePackingSale(this);" />
                                    <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale" 
                                        meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtPackingSale" Enabled="False" runat="server"  
                                        CssClass="small a-right"  Text="0.00" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        meta:resourcekey="txtPackingSaleResource1"></asp:TextBox>
                                </td>
                            </tr>
                            
                            <tr id="trExciseDuty" runat="server" class="hide a-right">
                                <td class="a-right">
                                    <input type="checkbox" id="chkExciseDuty" onclick="CalculateExciseDuty(this);" />
                                    <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty" 
                                        meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtExciseDuty" Enabled="False" CssClass="small a-right" onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                        runat="server" Text="0.00" meta:resourcekey="txtExciseDutyResource1"></asp:TextBox>
                                </td>
                            </tr >
                            
                            <tr id="trEduCess" runat="server" class="hide a-right">
                                <td class="hide">
                                    <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess" 
                                        meta:resourcekey="lblEduCessResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtEduCess" Enabled="False" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small a-right"  Text="0.00" meta:resourcekey="txtEduCessResource1"></asp:TextBox>
                                </td>
                            </tr>
                            
                            <tr id="trSecCess" runat="server" class="hide a-right">
                                <td class="hide">
                                    <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess" 
                                        meta:resourcekey="lblSecCessResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtSecCess" Enabled="False" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small a-right"  Text="0.00" meta:resourcekey="txtSecCessResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trTotal" runat="server" class="hide a-right">
                                <td class="a-right">
                                    <asp:Label ID="lblTotal" runat="server" Text="Total" 
                                        meta:resourcekey="lblTotalResource1"></asp:Label>
                                </td>
                                 <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtTotal" Enabled="False" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                        CssClass="small a-right"  Text="0.00" meta:resourcekey="txtTotalResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trCST" runat="server" class="hide a-right">
                                <td class="a-right">
                                    <asp:Label ID="lblCST" runat="server" Text="CST" 
                                        meta:resourcekey="lblCSTResource1"></asp:Label>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="txtCST" Enabled="False" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small a-right"  Text="0.00" meta:resourcekey="txtCSTResource1"></asp:TextBox>
                                </td>
                            </tr>
                          
                        </table>
                        </td>
                        
                        </tr>
                          <tr>
                            <td class="a-center">
                            <a class="btn" onclick="GetStockReceivedDatas();"><%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_05%></a>
                            <%--<input type="button" value="<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_05%>" class="btn" onclick="GetStockReceivedDatas();" />--%>
                            <asp:Button ID="btnRedirect" runat="server" CssClass="hide" 
                                    OnClick="btnRedirect_Click" meta:resourcekey="btnRedirectResource1" />
                            </td>
                            </tr>
                            
                        
                        
                        </table>
                        <asp:HiddenField ID="hdnProductList" runat="server" />
                        <asp:HiddenField ID="hdnGrandTotal" runat="server" />
                        <asp:HiddenField ID="hdnPageLoadval" runat="server" />
                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                        <asp:HiddenField ID="hdnILocationID" runat="server" />
                        <asp:HiddenField ID="hdnInventoryLocationID" runat="server" />
                        <asp:HiddenField ID="hdnLID" runat="server" />
                        <asp:HiddenField ID="hdnFromSupplier" runat="server" />
                        <asp:HiddenField ID="hdnStockOutFlowStatus" runat="server" />
                        <asp:HiddenField ID="hdnFlag" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnGetTaxList" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnSRID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnPOID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnSupplierName" runat="server" Value="0" />
                           <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
                            <asp:HiddenField ID="hdnbarCodeMapping" runat="server" Value="N" />
                              <asp:HiddenField ID="hdnExpiryDateFormatDDMMYYY" runat="server" Value="N" />
							  <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
                       
                    </div>
                
        <div id="divLoadingGif">
            <div id="divProgressBackgroundFilter">
            </div>
            <div align="center" id="divProcessMessage">
                <asp:Label ID="lblPleasewait" Text="Please wait... " runat="server" 
                    meta:resourcekey="lblPleasewaitResource1" />
                <br />
                <br />
                <asp:Image ID="imgLoadingGif" runat="server" 
                    ImageUrl="~/PlatForm/Images/working.gif" 
                    meta:resourcekey="imgLoadingGifResource1" />
            </div>
        </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />    
      <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
 </body>



<style type="text/css">
        .divTable
        {
            width: 100%;
            display: block;
            height:450px;
            overflow:auto;
        }
        .divRow
        {
        	clear:left;
        	float:left;
            width: 99%;
        }
        .divColumn
        {
            float: left;
            display:inline;
            width:30%;
            padding-bottom: 15px;
            border-right:solid 1px black;
            border-left:solid 1px black;
        }
        
        #divProgressBackgroundFilter
        {
            position: fixed;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            overflow: hidden;
            padding: 0;
            margin: 0;
            background-color: #000;
            filter: alpha(opacity=50);
            opacity: 0.5;
            z-index: 1000;
        }
        
        #divProcessMessage
        {
            position: fixed;
            top: 30%;
            left: 43%;
            padding: 10px;
            width: 4%;
            height: auto;
            z-index: 1001;
            background-color: #fff;
            border: solid 1px #000;
        }
        .notification{clear:left;float:left;margin-bottom:20px;border:solid 1px black;width:550px;height:50px;background-color:#EDEBDD;display:none}
        #tblSRRow .thRow{font-size:12px;word-break:break-all;}
    </style>
 
 <script type="text/javascript" language="javascript">
      
    $(document).ready(function() {
        setTimeout(function() {
        ChangeCalculation_load('CP');
        }, 500);
    });
 </script>
</html>


