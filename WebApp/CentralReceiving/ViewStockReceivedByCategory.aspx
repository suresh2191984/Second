<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewStockReceivedByCategory.aspx.cs"  EnableEventValidation="false"
    Inherits="CentralReceiving_ViewStockReceivedByCategory" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View Stock Received By Category</title>

    <script type="text/javascript" src="../PlatForm/Scripts/Json_BrowserSupport.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">                       
                        <div id="divReceived" runat="server">
                            <table class="searchPanel w-100p">
                                <tr>
                                    <td colspan="2" class="a-center bold font18">
                                        <asp:Label ID="lblStockReceived" runat="server" Text="StockReceived" meta:resourcekey="lblStockReceivedResource2"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-70p">
                                        <table class="w-100p">
                                        <tr>
                                        <td>
                                        <asp:Image ID="imgOrgLogo" runat="server" class="hide"/>
                                        </td>
                                        </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOrgName" Font-Bold="True" Font-Size="Medium" runat="server" meta:resourcekey="lblOrgNameResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOrgTinnotxt" Font-Bold="True" Text="TIN No :" runat="server" meta:resourcekey="lblOrgTinnotxtResource2"></asp:Label>
                                                    <asp:Label ID="lblOrgTinno" runat="server" meta:resourcekey="lblOrgTinnoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOrgDlnotxt" Font-Bold="True" Text="DL No :" runat="server" meta:resourcekey="lblOrgDlnotxtResource2"></asp:Label>
                                                    <asp:Label ID="lblorgDlno" runat="server" meta:resourcekey="lblorgDlnoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="h-10">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorName" Font-Bold="True" Font-Size="Medium" runat="server"
                                                        meta:resourcekey="lblVendorNameResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorTinnotxt" Font-Bold="True" Text="TIN No :" runat="server"
                                                        meta:resourcekey="lblVendorTinnotxtResource2"></asp:Label>
                                                    <asp:Label ID="lblVendorTinno" runat="server" meta:resourcekey="lblVendorTinnoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource2"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="a-right w-30p paddingR20" width="30%">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblDate" runat="server" Text="Date" 
                                                        meta:resourcekey="lblDateResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblPONo" runat="server" Text="P.O No" 
                                                        meta:resourcekey="lblPONoResource1"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblPOID" runat="server" Text="Received No" 
                                                        meta:resourcekey="lblPOIDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblReceivedNo" runat="server" Text="Received No" 
                                                        meta:resourcekey="lblReceivedNoResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblReceivedID" runat="server" meta:resourcekey="lblReceivedIDResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblInvoiceNotxt" Text="Invoice No" runat="server" 
                                                        meta:resourcekey="lblInvoiceNotxtResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblInvoiceNo" runat="server" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label1" Text="DC No" runat="server" 
                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblDCNo" runat="server" meta:resourcekey="lblDCNoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblStatustxt" runat="server" Text="Status" 
                                                        meta:resourcekey="lblStatustxtResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="h-20">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">                               
                                <tr>
                                    <td colspan="3">
                                        <div id="divViewStock" runat="server"></div>
                                        <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                                        <input id="hdnCollectedItems" runat="server" type="hidden" />
                                        <input id="hdnConsumableItems" runat="server" type="hidden" />
                                        <input id="hdnStatus" runat="server" type="hidden" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="1" class="a-left">
                                        <table>
                                            <tr>
                                                <td class="v-top">
                                                    <asp:Label ID="lblNote" runat="server" Text="Note" meta:resourcekey="lblNoteResource2"></asp:Label>
                                                </td>
                                                <td class="v-bottom">
                                                    <asp:Label ID="lblNoBatchNo" runat="server" Text="NoBatchNo" meta:resourcekey="lblNoBatchNoResource2"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblNoExporMftDate" runat="server" Text="NoExporMftDate" meta:resourcekey="lblNoExporMftDateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="a-right w-20p" >
                                        <table class="w-100p">
                                            <tr id="trTotalSales" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblTotalSales2" runat="server" Text="TotalSales" meta:resourcekey="lblTotalSales2Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblTotalSales" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblTotalSalesResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblTotalDiscountAmount" runat="server" Text="TotalDiscountAmount"
                                                        meta:resourcekey="lblTotalDiscountAmountResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblTotalDiscount" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblTotalDiscountResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trTotalTaxAmount" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblTotalTaxAmount" runat="server" Text="TotalTaxAmount" meta:resourcekey="lblTotalTaxAmountResource1"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblTotaltax" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblTotaltaxResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr id="lbltotalExe" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblTotalExcise2" runat="server" Text="TotalExcise" meta:resourcekey="lblTotalExcise2Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblTotalExcise" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblTotalExciseResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trCess2" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblCessOnExcise2" runat="server" Text="CessOnExcise2" meta:resourcekey="lblCessOnExcise2Resource1"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblCessOnExcise" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblCessOnExciseResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trEdCess1" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblHighterEdCess2" runat="server" Text="HighterEdCess" meta:resourcekey="lblHighterEdCess2Resource1"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblHighterEdCess" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblHighterEdCessResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr runat="server" id="lblcst5">
                                                <td class="a-left">
                                                    <asp:Label ID="lblCST1" runat="server" Text="CST5" meta:resourcekey="lblCST5Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblCST" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblCSTResource2"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trSupplierServiceTax" runat="server">
                                                <td class="a-left">
                                                    <asp:Label ID="lblSupplierServiceTax" runat="server" Text="SupplierServiceTax(%)" meta:resourcekey="lblSupplierServiceTaxResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblTax" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblTaxResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblPODiscount2" runat="server" Text="PODiscount" meta:resourcekey="lblPODiscount2Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblDiscount" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblDiscountResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblCreditAmountToBeUsed2" runat="server" Text="CreditAmountToBeUsed"
                                                        meta:resourcekey="lblCreditAmountToBeUsed2Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblamountused" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblamountusedResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblTotal" runat="server" Text="Total" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblGrountTotal" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblGrountTotalResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblRoundOffValue1" runat="server" Text="RoundOffValue" meta:resourcekey="lblRoundOffValueResource2"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblRoundOffValue" CssClass="w-50" runat="server" Text="0.00" 
                                                        meta:resourcekey="lblRoundOffValueResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblGrandTotal" runat="server" Text="GrandTotal" meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                                                </td>
                                                 <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblGrandwithRoundof" CssClass="w-50" runat="server" Text="0.00" meta:resourcekey="lblGrandwithRoundofResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            
                                            <tr id="trPackingSale" runat="server" class="a-right" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale :" 
                                                        meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                                                </td>
                                                  <td>:</td>
                                                <td>
                                                    <asp:Label ID="lbltxtPackingSale" CssClass="w-70 Align" runat="server" 
                                                        Text="0.00" meta:resourcekey="lbltxtPackingSaleResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trExciseDuty" runat="server" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty :" 
                                                        meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                                                </td>
                                                  <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lbltxtExciseDuty" runat="server" CssClass="Align w-70" 
                                                        Text="0.00" meta:resourcekey="lbltxtExciseDutyResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trEduCess" runat="server" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess :" 
                                                        meta:resourcekey="lblEduCessResource1"></asp:Label>
                                                </td>
                                                  <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lbltxtEduCess" runat="server" CssClass="Align w-70" Text="0.00" 
                                                        meta:resourcekey="lbltxtEduCessResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trSecCess" runat="server" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess :" 
                                                        meta:resourcekey="lblSecCessResource1"></asp:Label>
                                                </td>
                                                  <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lbltxtSecCess" runat="server" CssClass="Align w-70" Text="0.00" 
                                                        meta:resourcekey="lbltxtSecCessResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trTotal" runat="server" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="Label2" runat="server" Text="Total" 
                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lbltxtTotal" runat="server" CssClass="Align  w-70" Text="0.00" 
                                                        meta:resourcekey="lbltxtTotalResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trCST" runat="server" style="visibility: hidden">
                                                <td class="a-left">
                                                    <asp:Label ID="lblCSTTax" runat="server" Text="CST :" 
                                                        meta:resourcekey="lblCSTTaxResource1"></asp:Label>
                                                </td>
                                                  <td>:</td>
                                                <td class="a-right">
                                                    <asp:Label ID="lbltxtCST" runat="server" CssClass="Align w-70" Text="0.00" 
                                                        meta:resourcekey="lbltxtCSTResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" id="commentsTD" runat="server">
                                    </td>
                                </tr>
                                <tr id="approvalTR" class="hide" runat="server">
                                    <td colspan="3">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="bold">
                                                    <asp:Label ID="lblApprovedDate" runat="server" Text="ApprovedDate" meta:resourcekey="lblApprovedDateResource1"></asp:Label>
                                                </td>
                                                <td id="approvedDateTD" class="w-80p bold a-left" runat="server">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bold">
                                                    <asp:Label ID="lblApprovedBy2" runat="server" Text="ApprovedBy" meta:resourcekey="lblApprovedBy2Resource1"></asp:Label>
                                                </td>
                                                <td id="approvedByTD" class="w-80p a-left" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="h-10">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center" colspan="3">
                                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource2"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="w-35p">
                                        <asp:Label CssClass="bold" ID="lblSign" runat="server" 
                                            Text="<br><br>Prepared By" meta:resourcekey="lblSignResource1"></asp:Label>
                                    </td>
                                    <td class="w-35p">
                                        <asp:Label CssClass="bold" ID="lblauthorized" runat="server" 
                                            Text="<br><br>Authorized By" meta:resourcekey="lblauthorizedResource1"></asp:Label>
                                    </td>
                                    <td class="w-28p">
                                        <asp:Label CssClass="bold" ID="lblapproved" runat="server" 
                                            Text="<br><br>Approved By" meta:resourcekey="lblapprovedResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        <table class="w-100p">
                            <tr>
                                <td class="a-right w-45p">
                                    <table id="trApproveBlock" class="w-100p hide" runat="server">
                                        <tr>
                                            <td>
                                                <input type="hidden" id="hdnApproveStockReceived" runat="server" />
                                                <asp:Button ID="btnApprove" Text="Approve" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource2" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="w-55p">
                                    <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        OnClick="btnBack_Click" meta:resourcekey="btnBackResource2" />
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                        Width="40px" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource2" />
                                    <asp:Button ID="btnInvoice" Text="MatchingInvoice" runat="server" CssClass="btn"
                                        onmouseout="this.className='btn'" OnClick="btnInvoice_Click" meta:resourcekey="btnInvoiceResource2" />
                                </td>
                            </tr>
                        </table>
                    </div>
             
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnGetTaxList" runat="server" />
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    
    </form>
</body>
</html>
<script type="text/javascript">

    $(function() {
        if ($('#hdnGetTaxList').val() != '') {
            var myJSONText = $('#hdnGetTaxList').val();
            var Tax = JSON.parse(myJSONText);
            BindTaxTypes(Tax);
        }
    });


    function BindTaxTypes(Taxmaster) {
    var strPackingSale=SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_02")== null ? "Packing Sale" :SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_02");
    var strExciseDuty = SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_03") == null ? "Excise Duty" : SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_03");
    var strEduCess = SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_04") == null ? "Edu Cess" : SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_04");
    var strSecCess = SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_05") == null ? "Sec Cess" : SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_05");
    var strCST = SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_06") == null ? "CST" : SListForAppDisplay.Get("CentralReceiving_ViewStockReceivedByCategory_aspx_06");
    
           $.each(Taxmaster, function(index, Tax) {
            switch (Tax.TaxName) {
                case "PackingSale":
                    $('#trPackingSale').css("visibility", "visible");
                    $('#lblPackingSale').html(strPackingSale +"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "ExciseDuty":
                    $('#trExciseDuty').css("visibility", "visible");
                    $('#lblExciseDuty').html(strExciseDuty + "(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "EduCess":
                    $('#trEduCess').css("visibility", "visible");
                    $('#lblEduCess').html(strEduCess+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "SecCess":
                    $('#trSecCess').css("visibility", "visible");
                    $('#lblSecCess').html(strSecCess + "(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "CST":
                    $('#trTotal').css("visibility", "visible");
                    $('#trCST').css("visibility", "visible");
                    $('#lblCSTTax').html(strCST + "(" + Tax.TaxPercent + "%" + ")");
                    break;

                default:
                    break;
            }
        });
        $('#lbltxtTotal').html(TotalCalculation($('#lblGrountTotal').html(), $('#lbltxtPackingSale').html(), $('#lbltxtExciseDuty').html(), $('#lbltxtEduCess').html(), $('#lbltxtSecCess').html()));
    }


    function TotalCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess) {
        var TotalSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
        var Total = parseFloat(TotalSum).toFixed(2);
        return Total;
    }


    function CallPrint() {
        var WinPrint = window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write($('#divReceived').html());
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }

    
</script>