<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductSupplierRateMapping.aspx.cs"
    Inherits="Quotation_ProductSupplierRateMapping" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="Scripts/Quotation.js" type="text/javascript"></script>
</head>
<body id="Body1" runat="server">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/Quotation/WebService/Quotation.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
    
<script language="javascript" type="text/javascript">
    var errorMsg = SListForAppMsg.Get('Quotation_Error') == null ? "Alert" : SListForAppMsg.Get('Quotation_Error');
    var informMsg = SListForAppMsg.Get('Quotation_Information') == null ? "Information" : SListForAppMsg.Get('Quotation_Information');
    var okMsg = SListForAppMsg.Get('Quotation_Ok') == null ? "Ok" : SListForAppMsg.Get('Quotation_Ok')
    var cancelMsg = SListForAppMsg.Get('Quotation_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Quotation_Cancel');
    var updatebtn = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_02") == null ? "Update" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01")
    var Status = '';
    function GetMappedProducts(str) {
        ClearQuotation();
        //debugger;
            //document.getElementById('tdShowHide').style.display = 'block';
        $('#tdShowHide').removeClass().addClass('show');        
        showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responses4', 0);
        var strArray = str.split('^');
        var Quotation = strArray[0];
        var OrgID = Number(strArray[1]);
        var QuotationNo = document.getElementById(strArray[2]).innerHTML;
        var lblValidFrom = document.getElementById(strArray[3]).innerHTML;
        var lblValidTo = document.getElementById(strArray[4]).innerHTML;
        var lblComments = document.getElementById(strArray[5]).innerHTML;
        var lblStatus = document.getElementById(strArray[6]).innerHTML;
        var lblIsActive = document.getElementById(strArray[7]).innerHTML;
        var lblSupplierId = document.getElementById(strArray[8]).innerHTML;
        document.getElementById('hdnApproved').value = lblStatus;

        if (lblStatus == "Rejected") {
            showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responses4', 1);
            ValidationWindow("Selected Qutation Status is Rejected", errorMsg);
            return false;
        }
        $('#btnReject').removeClass("hide");
        var QuotationID = Number(document.getElementById(Quotation).innerHTML);
        var SupID = document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].value
        SupID = lblSupplierId;
        $('#DropSupplierName').val(SupID);
        document.getElementById('hdnQuotationID').value = QuotationID;
        Attune.Kernel.Quotation.QuotationService.GetMappedProducts(OrgID, SupID, QuotationID, QuotationNo, GetListItems);
        document.getElementById('txtQuotationNo').value = QuotationNo;
        document.getElementById('txtValidFrom').value = lblValidFrom;
        document.getElementById('txtValidTo').value = lblValidTo;
        document.getElementById('txtComments').value = lblComments;
        document.getElementById('tblQuotationID').value = QuotationID;
        document.getElementById('chkActive').checked = lblIsActive == "Y" ? true : false;
        document.getElementById('hdnSetListTable').value = "";
        document.getElementById('hdnbeforeTable').value = "";
        document.getElementById('hdnSupID').value = SupID;
        document.getElementById('hdnQuotID').value = QuotationID;
        if ((document.getElementById('hdnAdmin').value != "Administrator" || document.getElementById('hdnAdmin').value != "InventoryAdmin") && (lblStatus == "Closed" || lblStatus == "Approved" || lblStatus=="Pending") && document.getElementById('hdnConfig').value == "Y") {

            document.getElementById('txtProductName').disabled = true;
            document.getElementById('txtQuotationNo').disabled = true;
            document.getElementById('txtValidFrom').disabled = true;
            document.getElementById('txtValidTo').disabled = true;
            document.getElementById('txtComments').disabled = true;
            
            //document.getElementById('drpUnit').disabled = true;
            document.getElementById('txtInverseQuantity').disabled = true;
            document.getElementById('chkRate').disabled = true;
            document.getElementById('add').disabled = true;
            //                document.getElementById('txtSellingPrice').disabled = true;
            //                document.getElementById('txtMRP').disabled = true;
            document.getElementById('chkActive').disabled = true;

            if (lblStatus == 'Pending') {
                
                document.getElementById('btnSave').disabled = false;
                
            }
            else {
                document.getElementById('btnSave').disabled = true;
            }
            
        }
        else {
            document.getElementById('btnSave').disabled = false;
            document.getElementById('txtQuotationNo').disabled = false;
            document.getElementById('txtValidFrom').disabled = false;
            document.getElementById('txtValidTo').disabled = false;
            document.getElementById('txtComments').disabled = false;
            document.getElementById('txtProductName').disabled = false;
            document.getElementById('drpUnit').disabled = false;
            document.getElementById('txtInverseQuantity').disabled = false;
            document.getElementById('chkRate').disabled = false;
            //                document.getElementById('txtSellingPrice').disabled = false;
            //                document.getElementById('txtMRP').disabled = false;
            document.getElementById('chkActive').disabled = false;
            document.getElementById('add').disabled = false;
        }
        document.getElementById('txtQuotationNo').disabled = true;
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $('#btnSave').attr('class', 'hide');
            $('#tblQuotation').attr('class', 'hide');
        }



        return false;
    }


    var userMsg;
    var m;
    var flg = "0";
    function SetSupplier() {

        var pSupID = document.getElementById('DropSupplierName').value;

        if (Number(pSupID) > 0) {

            $find('AutoCompleteExtender2').set_contextKey(pSupID);
        }
        else {
            document.getElementById('DropSupplierName').focus();
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01") == null ? "Select supplier name" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01")
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }

    function SetEmptySupplier() {

        var pSupID = 0;
        $find('AutoCompleteExtender4').set_contextKey(pSupID);
    
    }
    function datediff() {

        return true;
    }

    function grddatediff() {
        var gridObj = document.getElementById('grdQuotation');
        if (gridObj != null) {
            for (i = 1; i < gridObj.rows.length; i++) {
                var fromObj = gridObj.rows[i].cells[3].childNodes[1].id;
                var toObj = gridObj.rows[i].cells[4].childNodes[1].id;
                var objActive = gridObj.rows[i].cells[6].childNodes[1].id;
                var isActive = document.getElementById(objActive).outerText;
                var lblQID = gridObj.rows[i].cells[1].childNodes[1].id;
                if (isActive != null && fromObj != null && toObj != null) {
                    if (isActive == "Y") {
                        if (document.getElementById('hdnQuotationID').value != document.getElementById(lblQID).innerHTML) {
                            if (document.getElementById('chkActive').checked == false && document.getElementById('hdnAdmin').value == "Administrator") {
                                //                                    var confirmDate = confirm('Already quotation exists in active status. \n Continue to save and deactivate existing !!');
                                //                                    if (confirmDate == true) {
                                //                                        return true;
                                //                                    }
                                //                                    else { return false; }
                            }
                        }
                        else {
                            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_21") == null ? "Confirm to update the details !!" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_21")
                            var confirmDate = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
                            if (confirmDate == true) {
                                return true;
                            }
                            else { return false; }
                        }
                    }
                }
            }
        }
        return true;
    }

    //        function OnSelectQuotation(source, eventArgs) {
    //         userMsg = SListForApplicationMessages.Get('Inventory\\ProductSupplierRateMapping.aspx_1');
    //                      if(userMsg !=null)
    //                            {
    //                            alert (userMsg );
    //                           return false ;
    //                            }
    //                else
    //                    {       
    //            alert('Quotation number is invalid or already exists');
    //                        return false ;
    //            }
    //            document.getElementById('txtQuotationNo').value = "";
    //            return false;
    //        }
    function clearVal() {
        document.getElementById('add').value = 'Add';
        document.getElementById('add').text = 'Add';
        
        document.getElementById('txtSellingPrice').value = "0.00";
        document.getElementById('txtDiscount').value = "0.00";
        document.getElementById('txtTax').value = "0.00";
        document.getElementById('txtMRP').value = "0.00";
        document.getElementById('hdnIsdefault').value = "";
        document.getElementById('txtProductName').value = "";
        document.getElementById('hdnProductID').value = "";
        document.getElementById('txtRate').value = "0.00";
        document.getElementById('hdnID').value = "";
        document.getElementById('drpUnit').value = "0";
        document.getElementById('txtInverseQuantity').value = "0";
        document.getElementById('chkIsDefault').checked = false;
        $('#tdmrpval').removeClass().addClass("hide");
        $('#idTaxVal').removeClass().addClass("hide");
        $('#idDiscountVal').removeClass().addClass("hide");
        $('#tdspval').removeClass().addClass("hide");
        $('#idRateVal').removeClass().addClass("hide");
        $('#tdMrphed').removeClass().addClass("hide");
        $('#idtax').removeClass().addClass("hide");
        $('#idDiscount').removeClass().addClass("hide");
        $('#idRate').parent().removeClass().addClass("w-1p");
        $('#idDiscount').parent().removeClass().addClass("w-1p");
        $('#idtax').parent().removeClass().addClass("w-1p");
        $('#tdSellingPricehed').removeClass().addClass("hide");
        $('#idRate').removeClass().addClass("hide");
        //  document.getElementById('tdIsDefault').style.display = "none";
        document.getElementById('drpUnit').disabled = false;
        document.getElementById('chkRate').disabled = false;
        document.getElementById('chkRate').checked = false;
    }


    function ProductItemSelected(sender, args) {


        var ProductCategory = document.forms[0][sender.get_element().name].value; //$("#" + sender.get_element().name).val(); //document.getElementById(sender.get_element().name).value;  //
        var Product = '';
        var result = '';

        if (ProductCategory == '' || ProductCategory == undefined) {

            Product = ProductCategory;
            document.forms[0][sender.get_element().name].value = Product;

        }
        else {

            result = ProductCategory.match(/[^[\]]+(?=])/g)
            if (result != null) {
                Product = ProductCategory.replace(/\s*\[.*?\]\s*/g, '');
                document.forms[0][sender.get_element().name].value = Product;
                // $('#' + sender.get_element().name).val(Product);
            }
            else {

                Product = ProductCategory;
                document.forms[0][sender.get_element().name].value = Product;

            }
        }
    }
    var OrderedUnitValues;
    function OnSelectProducts(source, eventArgs) {
        //debugger;
        clearVal();
        var tName = eventArgs.get_text().trim();
        var tProductID = eventArgs.get_value().split('~')[1].trim();

        document.getElementById('hdnIsdefault').value = eventArgs.get_value().split('~')[0].trim();
        document.getElementById('txtProductName').value = tName;
        document.getElementById('hdnProdName').value = tName;
        document.getElementById('hdnProductID').value = tProductID;
        if (!chkProductList()) {
            fn_Clear();
            return false;
        }
        document.getElementById('hdnParentproductid').value = eventArgs.get_value().split('~')[3].trim();
        document.getElementById('hdnlsunit').value = eventArgs.get_value().split('~')[2].trim();
        document.getElementById('hdnlsu').value = eventArgs.get_value().split('~')[2].trim();
        document.getElementById('hdnautocompvalue').value = eventArgs.get_value().split('~')[2].trim();
        document.getElementById('hdnTaxPercent').value = eventArgs.get_value().split('~')[6].trim();
        document.getElementById('hdnOrdUnit').value = eventArgs.get_value().split('~')[7].trim();
        document.getElementById('hdnOrdCUnit').value = eventArgs.get_value().split('~')[8].trim();
        OrderedUnitValues = eventArgs.get_value().split('~')[9].trim();
//        if ($('#hdnOrdConfig').val() == 'Y') { 
//            document.getElementById('txtInverseQuantity').value = eventArgs.get_value().split('~')[8].trim();
//            document.getElementById('chkRate').checked = true;
//            fnchkRate('chkRate');
//        }
//        else {
//            document.getElementById('txtInverseQuantity').value = 1;
//        }


        document.getElementById('txtInverseQuantity').value = eventArgs.get_value().split('~')[8].trim();
        document.getElementById('chkRate').checked = true;
        fnchkRate('chkRate');
        
        document.getElementById('txtInverseQuantity').disabled = false;
        ToTargetFormat($('#hdnTaxPercent'));
      
        
//        var pOldList = eventArgs.get_value().split('~')[5].trim().split("#");
//        for (j = 0; j < pOldList.length; j++) {
//            if (pOldList[j] != "" && pOldList[j].trim() != document.getElementById('hdnQuotationID').value) {
//                clearVal();
//                var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_03") == null ? "This product already in approved status or mapped to another quotation" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_03")
//                ValidationWindow(userMsg, errorMsg);
//                 return false;
//              
//            }
//        }

        //            if (eventArgs.get_value().split('~')[5].trim() == 'Y') {
        //                alert('This product already in approved status or mapped to another Quotation');
        //                clearVal();
        //                document.getElementById('txtProductName').focus();
        //                return false;
        //            }

        if (eventArgs.get_value().split('~')[2].trim() == 'NAN') {
            //alert('This product is not have least selling unit so Please select');
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_05") == null ? "Select least sellable unit" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_05")
            ValidationWindow(userMsg, errorMsg);
             return false;
          
        }

        else {
//                    if ($('#hdnOrdConfig').val() == 'Y') {
//                        document.getElementById('drpUnit').value = eventArgs.get_value().split('~')[7];
//                        document.getElementById('drpUnit').disabled = true;
//                    }
//                    else {
//                        document.getElementById('drpUnit').value = eventArgs.get_value().split('~')[2];
//                        document.getElementById('drpUnit').disabled = true;
            //                    }

            document.getElementById('drpUnit').value = eventArgs.get_value().split('~')[7];
        //document.getElementById('drpUnit').disabled = true;
                   
            document.getElementById('txtInverseQuantity').disabled = true;
            document.getElementById('hdnlsu').value = eventArgs.get_value().split('~')[2];
            document.getElementById('hdnOrdUnit').value = eventArgs.get_value().split('~')[7].trim();
            //document.getElementById('hdnOrdCUnit').value = eventArgs.get_value().split('~')[8].trim();
            var i;
            var x = document.getElementById('hdnSetListTable').value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[2] == document.getElementById('hdnProductID').value) {
                        if (y[4].trim() == eventArgs.get_value().split('~')[2].trim()) {
                            document.getElementById('drpUnit').value = "0";
                       // document.getElementById('drpUnit').disabled = false;
                            document.getElementById('txtInverseQuantity').value = 0.00;
                            document.getElementById('txtInverseQuantity').disabled = false;
                        }
                    }
                }
            }
        }
        ProductItemSelected(source, eventArgs);
    ConvertOrderUnitList(OrderedUnitValues, "");
        //$('#idDiscountVal').removeClass().addClass("hide");
        //$('#idTaxVal').removeClass().addClass("hide");
        //$('#idDiscount').removeClass().addClass("hide");
        //$('#idtax').removeClass().addClass("hide");   
    }
    function GetAprdMappedProducts(OrgID, SupID, strQID) {
        var QuotationID = strQID.split('~')[0];
        var QuotationNo = strQID.split('~')[1];
        showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responses4', 0);

        Attune.Kernel.Quotation.QuotationService.GetMappedProducts(OrgID, SupID, QuotationID, QuotationNo, GetListItems);
    }
    var flagMappedProduct;

    function GetListItems(lstInventoryItemsBasket) {
        flagMappedProduct = "0";
        var _Flag;
        if (lstInventoryItemsBasket.length > 0) {
            for (var i = 0; i < lstInventoryItemsBasket.length; i++) {
                document.getElementById('hdnSetListTable').value += lstInventoryItemsBasket[i].Description + "^";
                document.getElementById('hdnbeforeTable').value += lstInventoryItemsBasket[i].Description + "^";
            }
            _Flag = 'hideaction';
        }
        Tblist(_Flag);
        flagMappedProduct = "1";

    }

    function checktoupdate() {
        var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_18") == null ? "Are You Sure to Update the selected least selling units" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_18")
       if (ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg)) {
            return true;
        }
        else {
            $('#add').removeClass().addClass("show small");
            $('#btnlsu').removeClass().addClass("hide");
            return true;
        }

    }
    function isdefaultlsu(tempval) {
        document.getElementById('hdnupdate').value = tempval;
        if (document.getElementById('hdnupdate').value == "Y") {
        }
    }
    function checkQuotation() {
        if (document.getElementById('txtQuotationNo').value.trim() == "" && document.getElementById('hdnCorpOrg').value.trim() != "Y") {
         
            document.getElementById('txtQuotationNo').focus();
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_06") == null ? "Provide quotation number" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_06")
            ValidationWindow(userMsg, errorMsg);
               
                return false;
            
        }
        if (document.getElementById('txtValidFrom').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_07") == null ? "Provide Valid From date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_07")
            ValidationWindow(userMsg, errorMsg);
               
                return false;
           
        }
        if (document.getElementById('txtValidTo').value.trim() == "") {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_08") == null ? "Provide Valid To date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_08")
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        else {
            return true;
        }
    }
    function checkIsEmpty() {
        //debugger;
        flg = "1";
        if (checkQuotation() == true) {
            if (datediff() == true) {

                var Supnme = document.getElementById('DropSupplierName');

                if (Supnme.options[Supnme.selectedIndex] == 0) {
                    //document.getElementById('DropSupplierName').focus();
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01") == null ? "Select supplier name" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01")
                    ValidationWindow(userMsg, errorMsg);
                       return false;
                  
                }
                if (document.getElementById('txtProductName').value.trim() == "") {
                    //document.getElementById('txtProductName').focus();
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_09") == null ? "Provide product name" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_09")
                    ValidationWindow(userMsg, errorMsg);
                        return false;
                }

                var UnitText = document.getElementById('drpUnit');
                if (UnitText.value == "0") {
                    document.getElementById('drpUnit').focus();
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_10") == null ? "Select Unit" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_10")
                    ValidationWindow(userMsg, errorMsg);
                        return false;
                }
                if (document.getElementById('txtInverseQuantity').value.trim() == "0") {
                    document.getElementById('txtInverseQuantity').focus();
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_11") == null ? "Provide inverse quantity" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_11")
                    ValidationWindow(userMsg, errorMsg);
                        return false;
                    
                }
                if (document.getElementById('hdnCorpOrg').value == "Y") {
                    if (document.getElementById('txtSellingPrice').value == "0" || document.getElementById('txtSellingPrice').value == "") 
                    {
                        document.getElementById('txtSellingPrice').focus();
                        var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_30") == null ? "Provide Selling Price" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_30")
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                    if (document.getElementById('txtMRP').value == "0" || document.getElementById('txtMRP').value == "") {
                        document.getElementById('txtMRP').focus();
                        var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_31") == null ? "Provide MRP" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_31")
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                }
                if (document.getElementById('chkRate').checked == true) {
                    if (isRateEntered() == true) {
                        var CostPrice = document.getElementById('txtRate').value;
                        var SellingPrice = document.getElementById('txtSellingPrice').value;
                        var MRP = document.getElementById('txtMRP').value;
                    }
                    else {
                        return false;
                    }
                }
                if (document.getElementById('hdnlsunit').value.trim() == 'NAN') {
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_22") == null ? "Confirm to update the Least Selling units" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_22")
                    if (ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg)) {
                        var parentid = document.getElementById('hdnParentproductid').value
                        var lsunits = document.getElementById('drpUnit').value.split("~")[0];
                        Attune.Kernel.Quotation.QuotationService.Updatelsunits(parentid, lsunits, isdefaultlsu);
                    }
                }
                
                if ($('#add').val() == updatebtn) {

                    BindProductList();
                }
                else {
                    ShowSalesDtls();
                }

                if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
                    $('#btnReject').hide();
                    $('#btnClose').hide();
                }

            }
	    flg =0;
            return true;
        }
    }
    function isRateEntered() {
        if (document.getElementById('txtRate').value <= 0 || document.getElementById('txtRate').value == "") {
            document.getElementById('txtRate').focus();
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_12") == null ? "Provide Rate" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_12")
            ValidationWindow(userMsg, errorMsg);
                return false;
        }
        return true;
    }

    function BindProductList() {
        //debugger;
        $('#dvProductMap').show();
        if (document.getElementById('add').value == 'update') {
            Deleterows();
            document.getElementById('txtProductName').disabled = false;
        }
        else {

            var Supnme = document.getElementById('DropSupplierName');
            var SupName = "";
            var SupID = document.getElementById('DropSupplierName').value;
            var ProductName = document.getElementById('txtProductName').value;
            var ProductId = document.getElementById('hdnProductID').value;
            //var Rate = parseFloat(document.getElementById('txtRate').value).toFixed(2);
            //var Rate = document.getElementById('txtRate').value;
            //var Rate = document.getElementById('txtRate').value == "" ? 0 : ToTargetFormat($("#txtRate")); // document.getElementById('txtMRP').value;
            var Rate = (parseFloat(ToInternalFormat($('#txtRate')))).toFixed(2);
            $('#hdnTempValue').val(Rate);
            Rate = ToTargetFormat($('#hdnTempValue'));
            var UnitText = document.getElementById('drpUnit');
            var ddlRecUnitval = "";
            if ($('#drpUnit').val() != null)
                ddlRecUnitval = $('#drpUnit').val().split('~');
            //var ddlRecUnitval = $('#drpUnit').val().split('~');
            var ConQty = $.trim(ddlRecUnitval[0]);
            var Unit = ConQty;  //UnitText.value;
            var UnitID = document.getElementById('hdnID').value;
            var InvQuantity = document.getElementById('txtInverseQuantity').value;
            var IsDefault = document.getElementById('chkIsDefault').checked ? "Y" : "N";
            //var pRate = parseFloat(document.getElementById('txtRate').value).toFixed(2);
            var pRate = document.getElementById('txtRate').value == "" ? 0 : parseFloat(ToInternalFormat($("#txtRate"))).toFixed(2); // document.getElementById('txtMRP').value;
            var pStatuss = document.getElementById('hdnProductStatus').value;
            var pChkStatuss = document.getElementById('hdnchkboxStatus').value;
            var plsu = document.getElementById('hdnlsu').value;
            var pName = document.getElementById('hdnProdName').value;
            var OrdUnit = document.getElementById('hdnOrdUnit').value;
            var OrdCUnit = document.getElementById('hdnOrdCUnit').value;
            var pSellingPrice = '0.00';
            var pMRP = '0.00';
            var pDiscount = '0.00';
            var pTax = '0.00';

            var pLstDayQty = $('#hdnLstDayQty').val();
            var pLstMonthQty = $('#hdnLstMonthQty').val();
            var pLstQtrQty = $('#hdnLstQtrQty').val();
            var pProductIs = $('#hdnProductIs').val();
            var pProductUnit = "";
            if ($('#drpUnit').val() != null)
                pProductUnit = $('#drpUnit').val();
            //var pProductUnit = $('#drpUnit').val();
            if (document.getElementById('txtSellingPrice').value.trim() != '') {

                pSellingPrice = (parseFloat(ToInternalFormat($('#txtSellingPrice')))).toFixed(2);
                $('#hdnTempValue').val(pSellingPrice);
                pSellingPrice = ToTargetFormat($('#hdnTempValue'));
            }
            if (document.getElementById('txtMRP').value.trim() != '') {

                pMRP = (parseFloat(ToInternalFormat($('#txtMRP')))).toFixed(2);
                $('#hdnTempValue').val(pMRP);
                pMRP = ToTargetFormat($('#hdnTempValue'));
            }
            if (document.getElementById('txtDiscount').value.trim() != '') {

                pDiscount = (parseFloat(ToInternalFormat($('#txtDiscount')))).toFixed(2);
                $('#hdnTempValue').val(pDiscount);
                pDiscount = ToTargetFormat($('#hdnTempValue'));
            }
            if (document.getElementById('txtTax').value.trim() != '') {

                pTax = (parseFloat(ToInternalFormat($('#txtTax')))).toFixed(2);
                $('#hdnTempValue').val(pTax);
                pTax = ToTargetFormat($('#hdnTempValue'));
            }

            var SelectUnit = "I";
            if (Number(pRate).toFixed(2) > 0) {
                SelectUnit = "R";
            }
            if ($('#hdnOrdConfig').val() == 'Y') {
                UnitText = document.getElementById('hdnlsunit');
                Unit = UnitText.value;
                //UnitID = document.getElementById('hdnlsu').value;
                InvQuantity = 1;
                document.getElementById('hdnSetListTable').value += SupName + "~" + ProductName + "~" +
                        ProductId + "~" + Rate + "~" + OrdUnit + "~" + OrdCUnit + "~" + IsDefault + "~" + SupID + "~"
                        + UnitID + "~" + SelectUnit + "~" + pStatuss + "~" + pChkStatuss + "~" + plsu + "~" + pName + "~"
                        + pSellingPrice + "~" + pMRP + "~" + pDiscount + "~" + pTax + "~" + pLstDayQty + "~" + pLstMonthQty + "~"
                        + pLstQtrQty + "~" + pProductIs + "~" + OrderedUnitValues + "^";

                document.getElementById('hdnSetListTable').value += SupName + "~" + ProductName + "~" +
                        ProductId + "~" + Rate + "~" + Unit + "~" + InvQuantity + "~" + IsDefault + "~" + SupID + "~"
                        + UnitID + "~" + SelectUnit + "~" + pStatuss + "~" + pChkStatuss + "~" + plsu + "~" + pName + "~"
                        + pSellingPrice + "~" + pMRP + "~" + pDiscount + "~" + pTax + "~" + pLstDayQty + "~" + pLstMonthQty + "~"
                        + pLstQtrQty + "~" + pProductIs + "~" + OrderedUnitValues + "^";
            }
            else {
                document.getElementById('hdnSetListTable').value += SupName + "~" + ProductName + "~" +
                        ProductId + "~" + Rate + "~" + Unit + "~" + InvQuantity + "~" + IsDefault + "~" + SupID + "~"
                        + UnitID + "~" + SelectUnit + "~" + pStatuss + "~" + pChkStatuss + "~" + plsu + "~" + pName + "~"
                        + pSellingPrice + "~" + pMRP + "~" + pDiscount + "~" + pTax + "~" + pLstDayQty + "~" + pLstMonthQty + "~"
                        + pLstQtrQty + "~" + pProductIs + "~" + OrderedUnitValues + "^";

            }
            

            Tblist('');
        }
        fn_Clear();
    }
    function fn_Clear() {
        document.getElementById('add').value = 'Add';
        document.getElementById('txtSellingPrice').value = "0.00";
        document.getElementById('txtDiscount').value = "0.00";
        document.getElementById('txtTax').value = "0.00";
        document.getElementById('txtMRP').value = "0.00";
        document.getElementById('hdnIsdefault').value = "";
        document.getElementById('txtProductName').value = "";
        document.getElementById('hdnProductID').value = "";
        document.getElementById('txtRate').value = "0.00";
        document.getElementById('hdnID').value = "";
        document.getElementById('drpUnit').value = "0";
        document.getElementById('txtInverseQuantity').value = "0";
        document.getElementById('chkIsDefault').checked = false;
        document.getElementById('drpUnit').disabled = false;
        document.getElementById('chkRate').checked = false;
        $('#tdmrpval').removeClass().addClass("hide");
        $('#idTaxVal').removeClass().addClass("hide");
        $('#idDiscountVal').removeClass().addClass("hide");
        $('#tdspval').removeClass().addClass("hide");
        $('#idRateVal').removeClass().addClass("hide");
        $('#tdMrphed').removeClass().addClass("hide");
        $('#idtax').removeClass().addClass("hide");
        $('#idDiscount').removeClass().addClass("hide");
        $('#tdSellingPricehed').removeClass().addClass("hide");
        $('#idRate').removeClass().addClass("hide");
        $('#idRate').parent().removeClass().addClass("w-1p");
        $('#idDiscount').parent().removeClass().addClass("w-1p");
        $('#idtax').parent().removeClass().addClass("w-1p");
        //$('#tdIsDefault').removeClass().addClass("displaytd");
        //document.getElementById('txtProductName').focus();
//        OrderedUnitValues = "";
    }
    function checkCodes() {
        var tbl = document.getElementById('tblProductMap');
        var searchText = document.getElementById('txtSearchProduct').value.toUpperCase().trim();
        var isTrue = 1;
        for (var i = 1; i < tbl.rows.length; i++) {
            var tblRow = tbl.rows[i];
            var tblCell = tblRow.cells[13];
            var tblSpan = tblCell.innerHTML;
            if (searchText != "") {
                if (tblSpan.toLowerCase().indexOf(searchText.toLowerCase()) == 0) {
                    // tblRow.style.display = "block";
                    $('#' + tblRow).removeClass().addClass('displaytr');
                }
                else {
                    //tblRow.style.display = "none";
                    $('#' + tblRow).removeClass().addClass('hide');
                }
            }
            else {
                //tblRow.style.display = "block";
                $('#' + tblRow).removeClass().addClass('displaytr');
            }
        }
    }
    function ShowSalesDtls() {
        var _ProductID = document.getElementById('hdnProductID').value;
        var Parameters = { ProductID: _ProductID };
        try {
            $.ajax({
                type: "POST",
                url: "../Quotation/WebService/Quotation.asmx/GetProductSaleCount",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {

                    //Reset Old hidden values
                    $('#hdnLstDayQty').val("0");
                    $('#hdnLstMonthQty').val("0");
                    $('#hdnLstQtrQty').val("0");
                    $('#hdnProductIs').val("");

                    if (data != null && data != undefined && data.d != null) {
                        //$('#lblProductName').text(ProductName);
                        var TotalQty = 0;
                        for (var i = 0; i < data.d.length; i++) {
                            if (data.d[i].Period == 'D') {
                                $('#hdnLstDayQty').val(data.d[i].Quantity);
                            }
                            if (data.d[i].Period == 'M') {
                                $('#hdnLstMonthQty').val(data.d[i].Quantity);
                            }
                            if (data.d[i].Period == 'Q') {
                                $('#hdnLstQtrQty').val(data.d[i].Quantity);
                            }
                            TotalQty += parseInt(data.d[i].Quantity);
                        }
                    }
                    if (TotalQty == 0) {
                        $('#hdnProductIs').val("New");
                    }
                    else {
                        $('#hdnProductIs').val("Existing");
                    }
                    BindProductList();
                    // $find('MPProductSales').show();
                },
                failure: function(xhr, ajaxOptions, thrownError) {
                   ValidationWindow(xhr.status,errorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }
    }
    var objSNo = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_04") == null ? "S.No" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_04");
    var objProductName = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_05") == null ? "Product Name" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_05");
    var objUnit = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_06") == null ? "Unit" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_06");
    var objInverseQty = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_07") == null ? "Inverse Qty/LSU" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_07");
    var objCostPrice = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_08") == null ? "Cost Price" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_08");
    var objSellingPrice = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_09") == null ? "Selling Price" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_09");
    var objDiscount = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_10") == null ? "Discount" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_10");
    var objTax = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_11") == null ? "Tax" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_11");
    var objMRP = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_12") == null ? "MRP" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_12");
    var objIsDefault = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_13") == null ? "IsDefault" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_13");
    var objStatus = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_14") == null ? "Status" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_14");
    var objSoldYesterDay = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_15") == null ? "Sold Yesterday" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_15");
    var objSoldLastMonth = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_16") == null ? "Sold Last Month" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_16");
    var objSoldLastQuater = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_17") == null ? "Sold Last Quater" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_17");
    var objProductIs = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_18") == null ? "ProductIs" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_18");
    var objAction = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_19") == null ? "Action" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_19");
    var objProdName = SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_20") == null ? "ProdName" : SListForAppDisplay.Get("Quotation_ProductSupplierRateMapping_aspx_20");

    function ChildGridList(_action) {
        var isApproved = document.getElementById('hdnApproved').value;
        var isAdmin = document.getElementById('hdnAdmin').value;
        var Config = document.getElementById('hdnConfig').value;
        var RateConfig = document.getElementById('hdnRateConfig').value;
        var pParentProIDs = document.getElementById('hdnUnProducts').value.split("^");
        var pList = document.getElementById('hdnSetListTable').value.split("^");
        var Headrow = document.getElementById('tblProductMap').insertRow(0);
        var hideCheck = document.getElementById('hdnChkFlag').value;
        var IsCorpOrg = document.getElementById('hdnCorpOrg').value.trim();
        //var drpUnitVal = $('#drpUnit').val();
        var drpUnitVal = "";
        if ($('#drpUnit').val() != null)
            drpUnitVal = $('#drpUnit').val();
        Headrow.id = "HeadID";
            Headrow.className = "bold";
            Headrow.className = "gridHeader";

        var cell0 = Headrow.insertCell(0);
        var cell1 = Headrow.insertCell(1);
        var cell2 = Headrow.insertCell(2);
        var cell3 = Headrow.insertCell(3);

        //Inserting Salescount in between InverseQty and Costprice";

        var cell4 = Headrow.insertCell(4);
        var cell5 = Headrow.insertCell(5);
        var cell6 = Headrow.insertCell(6);
        var cell7 = Headrow.insertCell(7);
        var cell8 = Headrow.insertCell(8);
        var cell9 = Headrow.insertCell(9);
        var cell10 = Headrow.insertCell(10);
        var LstDayQty = Headrow.insertCell(11);
        var LstMonthQty = Headrow.insertCell(12);
        var LstQtrQty = Headrow.insertCell(13);
        var ProductIs = Headrow.insertCell(14);
        var cell11 = Headrow.insertCell(15);
        var cell12 = Headrow.insertCell(16);
        var cell13 = Headrow.insertCell(17);



        cell0.innerHTML = objSNo;
        cell1.innerHTML = objProductName; //&nbsp;&nbsp;&nbsp; <input type='text' style='width:100px' name='SearchProduct' onkeyup='checkCodes();' id='txtSearchProduct' />";
        //cell1.style.width = "220px";
        cell2.innerHTML = objUnit;
        cell3.innerHTML = objInverseQty;
        cell4.innerHTML = objCostPrice;
        cell5.innerHTML = objSellingPrice;
        cell6.innerHTML = objDiscount;
        cell7.innerHTML = objTax;
        cell8.innerHTML = objMRP;
        cell9.innerHTML = objIsDefault;
        cell10.innerHTML = objStatus;
        LstDayQty.innerHTML = objSoldYesterDay;
        LstMonthQty.innerHTML = objSoldLastMonth;
        LstQtrQty.innerHTML = objSoldLastQuater;
        ProductIs.innerHTML = objProductIs;
        cell11.innerHTML = objAction;
        cell12.innerHTML = "<input id='chkAll' name='chkAll' onclick='chkSelectAll(document.form1.chkAll);' value='<%=Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_21%>' type='checkbox'>SelectAll</input>";
        cell13.innerHTML = objProdName;


        //$(cell12).removeClass.addClass("hide");
        $(cell12).removeClass().addClass("hide");
        $(cell13).removeClass().addClass("hide");
        $(cell5).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
        $(cell6).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
        $(cell7).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
        $(cell8).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");

        $(cell5).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");
        $(cell8).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");

        if (isAdmin != "Administrator" && isApproved == "Approved" && Config == "Y") {
            $(cell11).removeClass().addClass("hide");
            $(cell12).removeClass().addClass("hide");
        }
        if (isAdmin != "Administrator" && isApproved != "Approved" && Config == "Y") {
            $(cell11).removeClass().addClass("displaytd");
            $(cell12).removeClass().addClass("hide");
            //cell11.style.display = "table-cell";
            // cell12.style.display = "none";
        }
        if (Config == "N") {
            $(cell11).removeClass().addClass("displaytd");
            $(cell12).removeClass().addClass("displaytd");
        }

        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $(cell5).removeClass().addClass("hide");
            $(cell8).removeClass().addClass("hide");
        }
        if (_action == 'hideaction') {
            if (IsCorpOrg == 'Y') {
                $(cell11).removeClass().addClass("displaytd");
               // $(cell12).removeClass().addClass("displaytd");
            }
            else {
            $(cell11).removeClass().addClass("hide");
            $(cell12).removeClass().addClass("hide");
            }
            $('#dvProductMap').show();
        }

            if ($('#hdnShowSellingPrice').val() == 'Y') {
                $(cell5).removeClass().addClass("displaytd");
                $(cell8).removeClass().addClass("displaytd");
            }
        var Inverseqty = '';
        var cost = '';
        var isChild = false;
        var pCount = pParentProIDs.length - 1;
        for (j = 0; j < pParentProIDs.length; j++) {
            if (pParentProIDs[j] != "") {
                var row = document.getElementById('tblProductMap').insertRow(1);
                row.style.height = "10px";
                var cell0 = row.insertCell(0);
                var cell1 = row.insertCell(1);
                var cell2 = row.insertCell(2);
                var cell3 = row.insertCell(3);

                //Inserting Salescount in between InverseQty and Costprice";


                var cell4 = row.insertCell(4);
                var cell5 = row.insertCell(5);
                var cell6 = row.insertCell(6);
                var cell7 = row.insertCell(7);
                var cell8 = row.insertCell(8);
                var cell9 = row.insertCell(9);
                var cell10 = row.insertCell(10);
                var LstDayQty = row.insertCell(11);
                var LstMonthQty = row.insertCell(12);
                var LstQtrQty = row.insertCell(13);
                var ProductIs = row.insertCell(14);
                var cell11 = row.insertCell(15);
                var cell12 = row.insertCell(16);
                var cell13 = row.insertCell(17);

                cell4.align = "right";
                cell5.align = "right";
                cell6.align = "right";
                cell7.align = "right";
                cell8.align = "right";
                isChild = false;



                //$(cell4).removeClass().addClass("hide");

                for (s = 0; s < pList.length; s++) {
                    if (pList[s] != "") {
                        y = pList[s].split('~');
                        Status = y[10];
                        $('#hdnTempValue').val(y[3]);
                        y[3] = ToTargetFormat($('#hdnTempValue'));
                        $('#hdnTempValue').val(y[14]);
                        y[14] = ToTargetFormat($('#hdnTempValue'));
                        $('#hdnTempValue').val(y[16]);
                        y[16] = ToTargetFormat($('#hdnTempValue'));
                        $('#hdnTempValue').val(y[17]);
                        y[17] = ToTargetFormat($('#hdnTempValue'));
                        $('#hdnTempValue').val(y[15]);
                        y[15] = ToTargetFormat($('#hdnTempValue'));
                        if (pParentProIDs[j] == y[2]) {
                            cell0.innerHTML = pCount;
                            if (isChild == false) {
                                cell1.innerHTML = "<span>" + y[1] + "</span>";
                                cell2.innerHTML = y[4];
                                cell3.innerHTML = y[5] + " (" + y[12] + ")";
                                Inverseqty = y[5];
                                cost = y[3].replace(/,/g, '');
                                cell4.innerHTML = "--";
                                cell5.innerHTML = "--";
                                cell6.innerHTML = '--';
                                cell7.innerHTML = '--';
                                cell8.innerHTML = '--';
                                if (y[9] == "R") {
                                    cell4.innerHTML = y[3];
                                    cell5.innerHTML = y[14];
                                    cell6.innerHTML = y[16];
                                    cell7.innerHTML = y[17];
                                    cell8.innerHTML = y[15];
                                }

                                cell9.innerHTML = y[6];
                                cell10.innerHTML = y[10];

                                cell11.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] +"~" +y[22]+ "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' class='ui-icon ui-icon-pencil b-none pointer pull-left' /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='ui-icon ui-icon-trash b-none pointerm pull-left marginL5'  />"

                                var str = "chkAllChild" + s;


                                // cell12.innerHTML = "<input id='" + str + "' name='chkAll' onclick='chkStatus(value,this.id);'  value='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "' type='checkbox'  />";
                                cell12.innerHTML = "<input id='" + str + "' name='chkAll' onclick='chkStatus(value,this.id);'  value='" + y[0] + "~" + "" + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "' type='checkbox'  checked/>";
                                cell13.innerHTML = y[13];
                                LstDayQty.innerHTML = "<span id='D" + y[2] + "'>" + y[18] + "</span>";
                                LstMonthQty.innerHTML = "<span id='M" + y[2] + "'>" + y[19] + "</span>";
                                LstQtrQty.innerHTML = "<span id='Q" + y[2] + "'>" + y[20] + "</span>";
                                ProductIs.innerHTML = "<span id='ProductIs" + y[2] + "'>" + y[21] + "</span>";
                                //cell13.style.display = "none";
                                //cell12.style.display = "none";
                                $(cell13).removeClass().addClass("hide");
                                $(cell12).removeClass().addClass("hide");

                                $(cell5).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(cell6).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(cell7).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(cell8).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");


                                $(cell5).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");
                                $(cell8).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");
                                

                                    if ($('#hdnShowSellingPrice').val() == 'Y') {
                                        $(cell5).removeClass().addClass("displaytd");
                                        $(cell8).removeClass().addClass("displaytd");
                                    }

                                if (y[10] == 'Approved' && isAdmin != "Administrator") {
                                    document.getElementById(str).disabled = true;
                                }
                                if (y[10] == 'Approved' && Config == "N") {
                                    document.getElementById(str).disabled = false;
                                }
                                document.getElementById(str).checked = y[11] == "Y" ? true : false;

                                if (isAdmin != "Administrator" && isApproved == "Approved" && Config == "Y") {
                                    $(cell11).removeClass().addClass("hide");
                                    $(cell12).removeClass().addClass("hide");

                                }
                                if (isAdmin != "Administrator" && isApproved != "Approved" && Config == "Y") {
                                    $(cell11).removeClass().addClass("displaytd");
                                    $(cell12).removeClass().addClass("hide");
                                }
                                if (Config == "N") {

                                    $(cell11).removeClass().addClass("displaytd");
                                    $(cell12).removeClass().addClass("displaytd");
                                }
                                if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
                                    $(cell5).removeClass().addClass("hide");
                                    $(cell8).removeClass().addClass("hide");
                                }
                                if (_action == 'hideaction') {
                                    //$(cell9).removeClass().addClass("hide");
                                    // $(cell10).removeClass().addClass("hide");
                                    if (IsCorpOrg == 'Y') {
                                        $(cell11).removeClass().addClass("displaytd");
                                       // $(cell12).removeClass().addClass("displaytd");
                                    }
                                    else {
                                        $(cell11).removeClass().addClass("hide");
                                        $(cell12).removeClass().addClass("hide");
                                    }
                                }
                                isChild = true;
                            }
                            else {
                                var Chrow = document.getElementById('tblProductMap').insertRow(2);
                                Chrow.style.height = "10px";
                                //Chrow.style.fontSize = "10px";
                                var chcell10 = Chrow.insertCell(0);
                                var chcell11 = Chrow.insertCell(1);
                                var chcell12 = Chrow.insertCell(2);
                                var chcell13 = Chrow.insertCell(3);

                                //Inserting Salescount in between InverseQty and Costprice";


                                var chcell14 = Chrow.insertCell(4);
                                var chcell15 = Chrow.insertCell(5);
                                var chcell16 = Chrow.insertCell(6);
                                var chcell17 = Chrow.insertCell(7);
                                var chcell18 = Chrow.insertCell(8);
                                var chcell19 = Chrow.insertCell(9);
                                var chcell110 = Chrow.insertCell(10);
                                var LstDayQty = Chrow.insertCell(11);
                                var LstMonthQty = Chrow.insertCell(11);
                                var LstQtrQty = Chrow.insertCell(13);
                                var ProductIs = Chrow.insertCell(14);

                                var chcell111 = Chrow.insertCell(15);
                                var chcell112 = Chrow.insertCell(16);
                                var chcell113 = Chrow.insertCell(17);

                                chcell14.align = "right";
                                chcell15.align = "right";
                                chcell16.align = "right";
                                chcell17.align = "right";
                                chcell18.align = "right";
                                
                                
                                chcell12.innerHTML = y[4];
                                chcell13.innerHTML = y[5] + " (" + y[12] + ")";
                                chcell14.innerHTML = "--";
                                chcell15.innerHTML = "--";
                                chcell16.innerHTML = "--";
                                chcell17.innerHTML = "--";
                                chcell18.innerHTML = "--";
                                if (y[9] == "R") {                                    
                                    chcell14.innerHTML = cost / Inverseqty;
                                    chcell15.innerHTML = y[14];
                                    chcell16.innerHTML = y[16];
                                    chcell17.innerHTML = y[17];
                                    chcell18.innerHTML = y[15];
                                }
                                chcell19.innerHTML = y[6];
                                chcell110.innerHTML = y[10];
                                chcell111.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' class='ui-icon ui-icon-pencil b-none pointer pull-left' /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='ui-icon ui-icon-trash b-none pointerm pull-left marginL5'   />"

                                var str = "chkAllChild" + s;

                                chcell112.innerHTML = "<input id='" + str + "' name='chkAll' onclick='chkStatus(value,this.id);' value='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "' type='checkbox'/>";
                                chcell113.innerHTML = y[13];
                                LstDayQty.innerHTML = "<span id='D" + y[2] + "'>" + y[18] + "</span>";
                                LstMonthQty.innerHTML = "<span id='M" + y[2] + "'>" + y[19] + "</span>";
                                LstQtrQty.innerHTML = "<span id='Q" + y[2] + "'>" + y[20] + "</span>";
                                ProductIs.innerHTML = "<span id='ProductIs" + y[2] + "'>" + y[21] + "</span>";
                                
                                
                                $(chcell113).removeClass().addClass("hide");

                                $(chcell15).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(chcell16).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(chcell17).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");
                                $(chcell18).removeClass().addClass(RateConfig == "N" ? "hide" : "displaytd");

                                $(chcell15).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");
                                $(chcell18).removeClass().addClass(IsCorpOrg == "Y" ? "displaytd" : "hide");
                                

                                if (y[10] == 'Approved' && isAdmin != "Administrator") {
                                    document.getElementById(str).disabled = true;
                                }
                                if (y[10] == 'Approved' && Config == "N") {
                                    document.getElementById(str).disabled = false;
                                }
                                document.getElementById(str).checked = y[11] == "Y" ? true : false;

                                if (isAdmin != "Administrator" && isApproved == "Approved" && Config == "Y") {
                                    $(chcell111).removeClass().addClass("hide");
                                    $(chcell112).removeClass().addClass("hide");
                                }
                                if (isAdmin != "Administrator" && isApproved != "Approved" && Config == "Y") {
                                    $(chcell111).removeClass().addClass("displaytd");
                                    $(chcell112).removeClass().addClass("hide");
                                }
                                if (Config == "N") {
                                    $(chcell111).removeClass().addClass("displaytd");
                                    $(chcell112).removeClass().addClass("displaytd");
                                }
                                if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
                                    $(cell5).removeClass().addClass("hide");
                                    $(cell8).removeClass().addClass("hide");
//                                    $(chcell15).removeClass().addClass("hide");
//                                    $(chcell18).removeClass().addClass("hide");
                                }
                                if (_action == 'hideaction') {
                                    //$(cell9).removeClass().addClass("hide");
                                    // $(cell10).removeClass().addClass("hide");
//                                    $(chcell113).removeClass().addClass("hide");
                                    $(chcell111).removeClass().addClass("hide");
                                    $(chcell112).removeClass().addClass("hide");
                                    }

                                    if ($('#hdnShowSellingPrice').val() == 'Y') {
                                        $(cell5).removeClass().addClass("displaytd");
                                        $(cell8).removeClass().addClass("displaytd");
                                }
                            }
                        }
                    }
                }
                pCount--;
            }
        }
    }

    function Tblist(_action) {
        //alert(1);
        while (count = document.getElementById('tblProductMap').rows.length) {
            for (var j = 0; j < document.getElementById('tblProductMap').rows.length; j++) {
                document.getElementById('tblProductMap').deleteRow(j);
            }
        }
        var x = document.getElementById('hdnSetListTable').value.split("^");
        document.getElementById('hdnSaveTable').value = document.getElementById('hdnSetListTable').value;

        if (flagMappedProduct == "0" && document.getElementById('hdnSetListTable').value == "") {
            $('#btnSaveID').removeClass().addClass("hide");
            $('#tblProductMap').removeClass().addClass("hide");
            //document.getElementById('btnSaveID').style.display = 'none';
            //document.getElementById('tblProductMap').style.display = 'none';
        }
        else {
            $('#btnSaveID').removeClass().addClass("show");
            $('#tblProductMap').removeClass().addClass("displaytb gridView w-100p");
        }
        for (i = 0; i < x.length; i++) {
            m = document.getElementById('hdnUnProducts').value.split("^");
            if (x[i] != "") {
                y = x[i].split('~');

                BindUniqueProducts(y[2]);
            }
        }

        ChildGridList(_action);
        if (getApprovedProducts() == true) {
            document.getElementById('chkAll').checked = false;
        }

        if (document.getElementById('hdnSetListTable').value != "") {
            $('#btnSaveID').removeClass().addClass("show");

        }
        else {
        }
        document.getElementById("chkRate").disabled = false;
    }
    function BindUniqueProducts(objVal) {
        document.getElementById('hdnUnProducts').value = objVal + "^";
        for (k = 0; k < m.length; k++) {
            if (m[k].trim() != "" && m[k].trim() != objVal) {
                document.getElementById('hdnUnProducts').value += m[k] + "^";
            }
        }
    }

    function Deleterows() {

        var RowEdit = document.getElementById('hdnRowEdit').value;

        //            var pSellingPrice = '0.00';
        //            var pMRP = '0.00';
        //            var pDiscount = '0.00';
        //            var pTax = '0.00';

        //            var y = '';
        //            for (i = 0; i < RowEdit.length; i++) {
        //                if (RowEdit[i] != "") {
        //                    y = RowEdit[i].split('~');

        //                    $('#hdnTempValue').val(y[3]);
        //                    y[3] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2); 
        //                    $('#hdnTempValue').val(y[14]);
        //                    y[14] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
        //                    $('#hdnTempValue').val(y[16]);
        //                    y[16] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
        //                    $('#hdnTempValue').val(y[17]);
        //                    y[17] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
        //                    $('#hdnTempValue').val(y[15]);
        //                    y[15] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);

        //                   
        //                    
        //                   var names =  y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21]

        //                }
        //            }
        //            RowEdit = names;


        var x = document.getElementById('hdnSetListTable').value.split("^");
        if (RowEdit != "") {
            var Supnme = document.getElementById('DropSupplierName');
            var SupName = Supnme.options[Supnme.selectedIndex].text;
            var SupID = Supnme.options[Supnme.selectedIndex].value;
            var ProductName = document.getElementById('txtProductName').value;
            var ProductId = document.getElementById('hdnProductID').value;
            var Rate = document.getElementById('txtRate').value;
            var pRate = document.getElementById('txtRate').value;
            var UnitText = document.getElementById('drpUnit');
            var Unit = document.getElementById('drpUnit').value.split("~")[0];
            var UnitID = document.getElementById('hdnID').value;
            var InvQuantity = document.getElementById('txtInverseQuantity').value;
            var IsDefault = document.getElementById('chkIsDefault').checked ? "Y" : "N";
            var SelectUnit = document.getElementById('hanRateType').value;
            var pStatuss = document.getElementById('hdnProductStatus').value;
            var pChkStatuss = document.getElementById('hdnchkboxStatus').value;
            var plsu = document.getElementById('hdnlsu').value;
            var OrdUnit = document.getElementById('hdnOrdUnit').value;
            var OrdCUnit = document.getElementById('hdnOrdCUnit').value;
            var pName = document.getElementById('hdnProdName').value;
            //var pSellingPrice = document.getElementById('txtSellingPrice').value;
            //var pMRP = document.getElementById('txtMRP').value;
            //var pDiscount = document.getElementById('txtDiscount').value;
            //var pTax = document.getElementById('txtTax').value;
            document.getElementById('add').text = 'Add';
            var pLstDayQty = $('#hdnLstDayQty').val();
            var pLstMonthQty = $('#hdnLstMonthQty').val();
            var pLstQtrQty = $('#hdnLstQtrQty').val();
            var pProductIs = $('#hdnProductIs').val();
            var pProductUnit = "";
            if ($('#drpUnit').val() != null)
                pProductUnit = $('#drpUnit').val();
            var SelectUnit = "I";
            $('#hdnTempValue').val(pRate);
            pRate = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            //                $('#hdnTempValue').val(pSellingPrice);
            //                pSellingPrice = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            //                $('#hdnTempValue').val(pMRP);
            //                pMRP = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            //                $('#hdnTempValue').val(pDiscount);
            //                pDiscount = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            //                $('#hdnTempValue').val(pTax);
            //                pTax = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            if (Number(pRate).toFixed(2) > 0) {
                SelectUnit = "R";
            }

            if (document.getElementById('txtRate').value.trim() != '')
                Rate = document.getElementById('txtRate').value == "" ? 0 : ToTargetFormat($("#txtRate")); // document.getElementById('txtMRP').value;


            if (document.getElementById('txtSellingPrice').value.trim() != '')
                pSellingPrice = document.getElementById('txtSellingPrice').value == "" ? 0 : ToTargetFormat($("#txtSellingPrice")); // document.getElementById('txtMRP').value;

            if (document.getElementById('txtMRP').value.trim() != '')
                pMRP = document.getElementById('txtMRP').value == "" ? 0 : ToTargetFormat($("#txtMRP")); // document.getElementById('txtMRP').value;

            if (document.getElementById('txtDiscount').value.trim() != '')
                pDiscount = document.getElementById('txtDiscount').value == "" ? 0 : ToTargetFormat($("#txtDiscount")); // document.getElementById('txtMRP').value;

            if (document.getElementById('txtTax').value.trim() != '')
                pTax = document.getElementById('txtTax').value == "" ? 0 : ToTargetFormat($("#txtTax")); // document.getElementById('txtMRP').value;



            document.getElementById('hdnSetListTable').value = SupName + "~" + ProductName + "~" +
                        ProductId + "~" + Rate + "~" + Unit + "~" + InvQuantity + "~" + IsDefault +
                       "~" + SupID + "~" + UnitID + "~" + SelectUnit + "~" + pStatuss + "~" + pChkStatuss + "~" + plsu + "~" + pName + "~" + pSellingPrice
                       + "~" + pMRP + "~" + pDiscount + "~" + pTax + "~" + pLstDayQty + "~" + pLstMonthQty + "~" + pLstQtrQty + "~" + pProductIs + "~" + OrderedUnitValues + "^";

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        document.getElementById('hdnSetListTable').value += x[i] + "^";
                    }
                }
            }
            Tblist('');
        }
    }
    function btnEdit_OnClick(sEditedData) {
        //debugger;
        var RateConfig = document.getElementById('hdnRateConfig').value;
        var chkRates = document.getElementById("chkRate");
        var IsCorpOrg = document.getElementById('hdnCorpOrg').value.trim();
        chkRates.checked = false;
        $('#tdmrpval').removeClass().addClass("hide");
        $('#idTaxVal').removeClass().addClass("hide");
        $('#idDiscountVal').removeClass().addClass("hide");
        $('#tdspval').removeClass().addClass("hide");
        $('#idRateVal').removeClass().addClass("hide");
        $('#tdMrphed').removeClass().addClass("hide");
        $('#idtax').removeClass().addClass("hide");
        $('#idDiscount').removeClass().addClass("hide");
        $('#tdSellingPricehed').removeClass().addClass("hide");
        $('#idRate').removeClass().addClass("hide");
        $('#idRate').parent().removeClass().addClass("w-1p");
        $('#idDiscount').parent().removeClass().addClass("w-1p");
        $('#idtax').parent().removeClass().addClass("w-1p");
        $('#tdIsDefault').removeClass().addClass("hide");

        var y = sEditedData.split('~');
        document.getElementById('add').text = 'Update';
        document.getElementById('add').value = 'update';
        
        document.getElementById('hdnRowEdit').value = sEditedData;
        document.getElementById('txtProductName').value = y[1];
        document.getElementById('hdnProductID').value = y[2];
        document.getElementById('txtRate').value = 0.00;
        document.getElementById('txtSellingPrice').value = 0.00;
        document.getElementById('txtDiscount').value = 0.00;
        document.getElementById('txtTax').value = 0.00;
        document.getElementById('txtMRP').value = 0.00;
        document.getElementById('txtSellingPrice').value = y[14];
        document.getElementById('txtMRP').value = y[15];
        document.getElementById('txtDiscount').value = y[16];
        document.getElementById('txtTax').value = y[17];
    document.getElementById('drpUnit').value = y[4]+"~"+y[5];
        document.getElementById('hdnID').value = y[8];
        document.getElementById('txtInverseQuantity').value = y[5];
        document.getElementById('chkIsDefault').checked = y[6] == "Y" ? true : false;
        document.getElementById('hdnIsdefault').value = y[6];
        document.getElementById('hanRateType').value = y[9];
        OrderedUnitValues = y[22];
        ConvertOrderUnitList(OrderedUnitValues, y[4]);
        if (y[9] == "R") {
            document.getElementById('txtRate').value = y[3];
            $('#hdnTempValue').val(y[3]);
            y[3] = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);

            if (y[3] > 0) {
                var chkRate = document.getElementById("chkRate");
                chkRate.checked = true;
                chkRate.disabled = true;
                $('#tdmrpval').removeClass().addClass("displaytd");
                $('#idTaxVal').removeClass().addClass(" show");
                $('#idDiscountVal').removeClass().addClass("show");
                $('#tdspval').removeClass().addClass("displaytd");
                $('#idRateVal').removeClass().addClass("displaytd");
            $('#tdMrphed').removeClass().addClass("displaytd");
                $('#idtax').removeClass().addClass("displaytd");
                $('#idDiscount').removeClass().addClass("show");
                $('#tdSellingPricehed').removeClass().addClass("displaytd");
                $('#idRate').removeClass().addClass("show");
                $('#idRate').parent().addClass("w-7p");
                $('#idDiscount').parent().addClass("w-7p");
                $('#idtax').parent().addClass("w-7p");
                //$('#tdIsDefault').removeClass().addClass("displaytd");
                if (IsCorpOrg == 'Y') {
                        $('#idMRPVal').removeClass().addClass("show");
                        $('#idSpVal').removeClass().addClass("show");
                        $('#idSp').removeClass().addClass("show");
                        $('#idMrp').removeClass().addClass("show");
                }
            }
        }
        $('#txtSellingPrice').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
        $('#txtMRP').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
        $('#lblSellingPrice').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
        $('#lblMRP').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
            $('#txtDiscount').removeClass().addClass(RateConfig == "N" ? "hide" : "show mini");
            $('#txtTax').removeClass().addClass(RateConfig == "N" ? "hide" : "show mini");
        $('#lblDiscount').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
        $('#lblTax').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
    $('#drpUnit').val(y[4]+"~"+y[5]);
        document.getElementById('hdnProductStatus').value = y[10];
        document.getElementById('hdnchkboxStatus').value = y[11];
        document.getElementById('hdnlsu').value = y[12];
        document.getElementById('hdnProdName').value = y[13];
        document.getElementById('hdnOrdUnit').value = y[14];
        document.getElementById('hdnOrdCUnit').value = y[15];

        var ProductID = $.trim(y[2]);
        $('#hdnLstDayQty').val(y[18]);
        $('#hdnLstMonthQty').val(y[19]);
        $('#hdnLstQtrQty').val(y[20]);
        $('#hdnProductIs').val(y[21]);

        document.getElementById('txtProductName').disabled = true;
    }

    function fnchkRate(ID) {

        var IsCorpOrg = document.getElementById('hdnCorpOrg').value.trim();
            var IsShowSellingPrice = document.getElementById('hdnShowSellingPrice').value.trim();
        $('#tdmrpval').removeClass().addClass("hide");
        $('#idTaxVal').removeClass().addClass("hide");
        $('#idDiscountVal').removeClass().addClass("hide");
        $('#tdspval').removeClass().addClass("hide");
        $('#idRateVal').removeClass().addClass("hide");
        $('#tdMrphed').removeClass().addClass("hide");
        $('#idtax').removeClass().addClass("hide");
        $('#idDiscount').removeClass().addClass("hide");
        $('#tdSellingPricehed').removeClass().addClass("hide");
        $('#idRate').removeClass().addClass("hide");
        $('#idRate').parent().removeClass().addClass("w-1p");
        $('#idDiscount').parent().removeClass().addClass("w-1p");
        $('#idtax').parent().removeClass().addClass("w-1p");
        //$('#tdIsDefault').removeClass().addClass("hide");
        document.getElementById('txtRate').value = 0.00;
        document.getElementById('txtSellingPrice').value = 0.00;
        document.getElementById('txtMRP').value = 0.00;
        document.getElementById('txtDiscount').value = 0.00;
        document.getElementById('txtTax').value = 0.00;
        // document.getElementById('txtTax').readOnly = true;
        if (chkAddUnitinList('Rate')) {
            var chkRate = document.getElementById(ID);
            if (chkRate.checked == true) {
                document.getElementById('txtTax').value = document.getElementById('hdnTaxPercent').value;
                $('#tdmrpval').removeClass().addClass("displaytd");
                $('#idTaxVal').removeClass().addClass("show");
                $('#idDiscountVal').removeClass().addClass("show");
                $('#tdspval').removeClass().addClass("displaytd");
                $('#idRateVal').removeClass().addClass("displaytd");
                $('#tdMrphed').removeClass().addClass("displaytd");
                $('#idtax').removeClass().addClass("displaytd");
                $('#idDiscount').removeClass().addClass("show");
                $('#tdSellingPricehed').removeClass().addClass("displaytd");
                $('#idRate').removeClass().addClass("show");
                $('#idRate').parent().addClass("w-7p");
                $('#idDiscount').parent().addClass("w-7p");
                $('#idtax').parent().addClass("w-7p");
                //$('#tdIsDefault').removeClass().addClass("displaytd");
                if (IsCorpOrg == 'Y') {
                        $('#idMRPVal').removeClass().addClass("show");
                        $('#idSpVal').removeClass().addClass("show");
                        $('#idSp').removeClass().addClass("show");
                        $('#idMrp').removeClass().addClass("show");
                    }
                    if (IsShowSellingPrice == 'Y') {
                        $('#idMRPVal').removeClass().addClass("show");
                        $('#idSpVal').removeClass().addClass("show");
                        $('#idSp').removeClass().addClass("show");
                        $('#idMrp').removeClass().addClass("show");
                }
            }
        }
        HideSellingPrice();
    }
    function fnchkIsDefault() {

        if (document.getElementById('hdnIsdefault').value == "Y") {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_23") == null ? "Product Default to other Supplier!! \n Do you want to continue?" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_23")
            var Isdefault = Confirmwindow(userMsg, informMsg, okMsg, cancelMsg);
            if (Isdefault != true) {
                document.getElementById('chkIsDefault').checked = false;
                return;
            }
            document.getElementById('chkIsDefault').checked = true;
            return;
        }
    }

    function chkProductList() {
        var pParentProIDs = document.getElementById('hdnProductID').value;
        var x = document.getElementById('hdnSetListTable').value.split("^");
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if ($('#hdnOrdConfig').val() == 'Y') {
                    if (pParentProIDs.trim() == y[2]) {
                        var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_19") == null ? "This product already added" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_19")
                        ValidationWindow(userMsg, errorMsg);
                            return false;
                       
                        document.getElementById('txtProductName').value = "";
                        return false;
                    }
                }
            }
        }
        return true;
    }


    function chkAddUnitinList(Objtemp) {
        var pParentProIDs = document.getElementById('hdnProductID').value;
        var x = document.getElementById('hdnSetListTable').value.split("^");
        var pUnit = document.getElementById('drpUnit').value.split("~")[0];
        var chkbox = document.getElementById('chkRate').checked == true ? 'Y' : 'N';
        var RateConfig = document.getElementById('hdnRateConfig').value;
        if (RateConfig != null && RateConfig != "") {
            $('#txtSellingPrice').removeClass().addClass(RateConfig == "N" ? "hide" : "show amount");
            $('#txtMRP').removeClass().addClass(RateConfig == "N" ? "hide" : "show amount");
            $('#lblSellingPrice').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
            $('#lblMRP').removeClass().addClass(RateConfig == "N" ? "hide" : "show");
            $('#txtDiscount').removeClass().addClass(RateConfig == "N" ? "hide" : "show mini");
            $('#txtTax').removeClass().addClass(RateConfig == "N" ? "hide" : "show mini");
        }
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (pParentProIDs.trim() == y[2] && y[4].trim() == pUnit.trim() && Objtemp == "Unit") {
                   
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_24") == null ? "This unit already added" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_24")
                    ValidationWindow(userMsg, errorMsg);
                        return false;
                  
                    document.getElementById('drpUnit').value = "0";
                    return false;
                }
                if (pParentProIDs.trim() == y[2] && chkbox == 'Y' && Number(y[3].trim()).toFixed(2) > 0 && Objtemp == "Rate" && y[9].trim() == "R") {
                    
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_25") == null ? "Rate already added to this product" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_25")
                    ValidationWindow(userMsg, errorMsg);
                        return false;
                  
                    document.getElementById('chkRate').checked = false;
                    return false;
                }

            }

        }
        return true;
    }

    function chkRateList(objType) {
        var isRate = false;
        var pParentProIDs = document.getElementById('hdnUnProducts').value.split("^");
        var x = document.getElementById('hdnSetListTable').value.split("^");

        for (j = 0; j < pParentProIDs.length; j++) {
            if (pParentProIDs[j] != "") {
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');

                        if (pParentProIDs[j] == y[2] && Number(y[3].trim()).toFixed(2) > 0 && objType == "IsRate" && y[9].trim() == "R") {
                            isRate = true;
                        }

                    }
                }
            }
        }
        if (isRate == false) {

            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_25") == null ? "Rate already added to this product" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_25")
            ValidationWindow(userMsg, errorMsg);
                
                return false;
            
        }
        return isRate;
    }

    function isNumeric(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        if (txtVal == "") {
            flag = 1;
        }
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }





    function ValidateRate() {
        if (document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].value == "" || document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].value == "0") {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01") == null ? "Select supplier name" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_01")
            ValidationWindow(userMsg, errorMsg);
                return false;
           
        }
        if (document.getElementById('txtQuotationNo').value.trim() == "" && document.getElementById('hdnCorpOrg').value.trim() != "Y") {
            document.getElementById('txtQuotationNo').focus();
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_13") == null ? "Provide Quotation no" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_13")
            ValidationWindow(userMsg, errorMsg);
                return false;
          

        }
        if (document.getElementById('txtValidFrom').value.trim() == "") {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_07") == null ? "Provide Valid From date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_07")
            ValidationWindow(userMsg, errorMsg);
                return false;
        }
        if (document.getElementById('txtValidTo').value.trim() == "") {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_08") == null ? "Provide Valid To date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_08")
            ValidationWindow(userMsg, errorMsg);
                return false;
           
        }
        //   if (ExcedDate('txtValidFrom', '', 0, 0) == false || ExcedDate('txtValidTo', 'txtValidFrom', 1, 1) == false) {
        if (ExcedDate('txtValidTo', 'txtValidFrom', 1, 1) == false) {
            return false;
        }
        var flag = 0;
        var prodName = "";
        var tblValues = document.getElementById('hdnSaveTable').value.split("^");
        for (k = 0; k < tblValues.length; k++) {
            if (tblValues[k] != "") {
                var firstRow = tblValues[k];
                var prodID = tblValues[k].split("~")[2];
                for (i = 0; i < tblValues.length; i++) {
                    if (Number(tblValues[i].split("~")[2]) == Number(prodID)) {
                        if (tblValues[i].split("~")[9] == "R") {
                            flag = 1;
                        }
                    }
                }
                prodName = tblValues[k].split("~")[1];
                if (flag == 0) {
                    var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_14") == null ? "Enter the rate to product '" + prodName + "'" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_14")
                    userMsg = userMsg.replace('{0}', prodName);
                  //  ValidationWindow(userMsg, errorMsg);
                  //  return false;
                }
                flag = 0;
            }
        }
        if (document.getElementById('hdnChkFlag').value == "1" || document.getElementById('hdnConfig').value == "N" || (document.getElementById('hdnChkFlag').value == "0" && document.getElementById('hdnConfig').value == "Y" && document.getElementById('hdnAdmin').value == "Administrator")) {
            var aprvdFlag = "0";
            var tbl = document.getElementById('tblProductMap').rows.length;
            var Tb = document.getElementById('tblProductMap');
            if (tbl > 0) {
                document.getElementById('hdnCheckedStatus').value = "";
                for (i = 1; i < tbl; i++) {
                    if (Tb.rows[i].cells[16].childNodes[0] != null) {
                        var id = Tb.rows[i].cells[16].childNodes[0].id;
                        //Checkbox column disabled
                        //  if (document.getElementById(id).checked == true) { 
                        aprvdFlag = "1";
                        document.getElementById('hdnCheckedStatus').value += Tb.rows[i].cells[16].childNodes[0].value.split('^')[0] + "^";
                        //  }
                    }
                }
            }
        }
        if (aprvdFlag == "0") {
            if (document.getElementById('hdnSetListTable').value != "") {
                document.getElementById('hdnCheckedStatus').value = "";
                var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_26") == null ? "Select atleast one product to approve" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_26")
                ValidationWindow(userMsg, errorMsg);
                    return false;
              
            }
        }

        if (flg != "1") {
            if (grddatediff() == true) {
                document.getElementById('txtQuotationNo').disabled = false;
                document.getElementById('txtValidFrom').disabled = false;
                document.getElementById('txtValidTo').disabled = false;
                document.getElementById('txtComments').disabled = false;
                document.getElementById('txtProductName').disabled = false;
                document.getElementById('drpUnit').disabled = false;
                document.getElementById('txtInverseQuantity').disabled = false;
                document.getElementById('chkRate').disabled = false;
                document.getElementById('add').disabled = false;
                document.getElementById('chkActive').disabled = false;

                $('#btnSave').removeClass().addClass('hide');
                return true;
            }
            else { return false };
        }
        else {
            document.getElementById('txtQuotationNo').disabled = false;
            document.getElementById('txtValidFrom').disabled = false;
            document.getElementById('txtValidTo').disabled = false;
            document.getElementById('txtComments').disabled = false;
            document.getElementById('txtProductName').disabled = false;
            document.getElementById('drpUnit').disabled = false;
            document.getElementById('txtInverseQuantity').disabled = false;
            document.getElementById('chkRate').disabled = false;
            document.getElementById('add').disabled = false;
            document.getElementById('chkActive').disabled = false;

            $('#btnSave').removeClass().addClass('hide');
        }
        flg = "0";
        $('#btnSave').removeClass().addClass('hide');
    }
      
        function GetSellingPriceVal() {
            var txtVal = document.getElementById('txtSellingPrice').value.trim();
            document.getElementById('txtMRP').value = txtVal;
        }
       
</script>

<script type="text/javascript" language="javascript">

    function btnDelete(sEditedData) {
        var i;
        var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_20") == null ? "Confirm to delete!!" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_20")
        var IsDelete = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
        if (IsDelete == true) {
            var x = document.getElementById('hdnSetListTable').value.split("^");
            document.getElementById('hdnSetListTable').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnSetListTable').value += x[i] + "^";
                    }
                }
            }
            document.getElementById('hdnUnProducts').value = "";
            Tblist('');
        }
        else {
            return false;
        }
    }

    function chkSelectAll(obj) {
        document.getElementById('hdnCheckedStatus').value = "";
        var chkAll = document.getElementById('chkAll');
        if (chkAll.checked == true) {
            for (i = 0; i < obj.length; i++) {
                if (obj[i].disabled == false && document.getElementById('hdnConfig').value == "Y") {
                    obj[i].checked = true;
                }
                if (document.getElementById('hdnConfig').value == "N") {
                    obj[i].checked = true;
                }
            }
        }
        else {
            for (i = 0; i < obj.length; i++) {
                if (obj[i].disabled == false && document.getElementById('hdnConfig').value == "Y") {
                    obj[i].checked = false;
                }
                if (document.getElementById('hdnConfig').value == "N") {
                    obj[i].checked = false;
                }
            }
        }
    }

    function chkStatus(str, objID) {
        var i;
        var pChkBox = "N";

        if (document.getElementById(objID).checked) {
            pChkBox = "Y";
        }


        var x = document.getElementById('hdnSetListTable').value.split("^");
        document.getElementById('hdnSetListTable').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] == str) {
                    var pval = str.split("~");
                    var plistVal = pval[0] + "~" + pval[1] + "~" + pval[2] + "~" + pval[3] + "~" + pval[4] + "~" + pval[5] + "~" +
                                       pval[6] + "~" + pval[7] + "~" + pval[8] + "~" + pval[9] + "~" + pval[10] + "~" + pChkBox + "~" +
                                       pval[12] + "~" + pval[13] + "~" + pval[14] + "~" + pval[15] + "~" + pval[16] + "~" + pval[17];

                    document.getElementById('hdnSetListTable').value += plistVal + "^";
                }
                else {
                    document.getElementById('hdnSetListTable').value += x[i] + "^";
                }
            }
        }
        Tblist('');
    }



    function isSpclChar(e) {
        var key;
        var isCtrl = false;
        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }
        //*************To block slash(/) into text box change the key value to 48***************************//
        if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }
        return isCtrl;
    }

    function getApprovedProducts() {
        var pList = document.getElementById('hdnSetListTable').value.split("^");
        for (i = 0; i < pList.length; i++) {
            if (pList[i] != "") {
                if (pList[i].split('~')[10] != "Approved") {
                    return true;
                    break;
                }
            }
        }
        document.getElementById('chkAll').checked = true;
        //            document.getElementById('chkAll').disabled = true;
    }


    function chkValidDate(ID) {
        if (test(ID) == true) {
            //   ExcedDate(ID, '', 0, 0);
        }
        else {
            return false;
        }
    }
    function test(ID) {
        var obj = document.getElementById(ID);
        if (obj.value != '' && obj.value != '__/__/____') {
            dobDt = obj.value.split('/');
            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            if (dobDtTime == "NaN") {
                var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15") == null ? "Invalid date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15")
                ValidationWindow(userMsg, errorMsg);
                    
                obj.value = "";
                obj.focus();
                return false;
            }
            else {
                return true;
            }
        }
    }
    function chkValidDate1(ID) {
        var arrFromdate = $("#txtValidFrom").val().split('/');
        var arrTodate = $("#txtValidTo").val().split('/');
        var FromDate = new Date(arrFromdate[2] + '/' + arrFromdate[1] + '/' + arrFromdate[0]);
        var ToDate = new Date(arrTodate[2] + '/' + arrTodate[1] + '/' + arrTodate[0]);

        if ($.trim($("#txtValidFrom").val()) == "") {
            ValidationWindow("Please Select From Date", errorMsg);
            $("#txtValidTo").val(''); 
            return false;
        
         }

        if (ToDate =="Invalid Date" || FromDate =="Invalid Date" || FromDate > ToDate) {
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15") == null ? "Invalid date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15")
            ValidationWindow(userMsg, errorMsg);
            return false;
        }

        CheckQuatationSupplierDateValidation();
    }
    function test1(ID) {
        var obj = document.getElementById(ID);
        if (obj.value != '' && obj.value != '__/__/____') {
            dobDt = obj.value.split('/');
            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            if (dobDtTime == "NaN") {
                var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15") == null ? "Invalid date" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_15")
                ValidationWindow(userMsg, errorMsg);
                  
                    return false;
               
                obj.value = "";
                obj.focus();
                return false;
            }
            else {
                return true;
            }
        }
    }
    function ClearQuotation(val) {
        $('#btnReject').removeClass("hide").addClass("hide");
        document.getElementById('hdnStatus').value = "0";
        document.getElementById('hdnUnProducts').value = "";
        document.getElementById('hdnApproved').value = "";
        document.getElementById('txtProductName').value = "";
        document.getElementById('hdnProductID').value = "";
        document.getElementById('drpUnit').selectedIndex = 0;
        document.getElementById('txtInverseQuantity').value = "0";
        document.getElementById('chkRate').checked = false;
        document.getElementById('txtRate').value = "0";
        document.getElementById('txtSellingPrice').value = "0";
        document.getElementById('txtDiscount').value = "0";
        document.getElementById('txtTax').value = "0";
        document.getElementById('txtMRP').value = "0";
        document.getElementById('chkIsDefault').checked = false;
        document.getElementById('hdnProdName').value = "";
        document.getElementById('hdnlsu').value = "";
        document.getElementById('hdnOrdUnit').value = "";
        document.getElementById('hdnOrdCUnit').value = "0";
        document.getElementById('chkActive').checked = false;

        document.getElementById('hdnSetListTable').value = "";
        document.getElementById('txtQuotationNo').value = "";

        document.getElementById('txtComments').value = "";
        document.getElementById('tblQuotationID').value = "0";
        document.getElementById('hdnQuotationID').value = "0";

        document.getElementById('txtValidFrom').value = "";
        document.getElementById('txtValidTo').value = "";
        $('#txtQuotationNo').removeAttr("disabled");
        //$('#tblQuotation').removeClass().addClass("show");

        if (val == 'Clear') {
            $('#tblQuotation').attr('class', 'displaytb');
            $('#dvProductMap').hide();
            $('#DropSupplierName').val('0');
            $('#btnSave').removeClass().addClass("btn");
            //$('#btnSave').attr('class', 'show');
        }
        if (val == 'ClearTable') {
            $('#tblQuotation').attr('class', 'displaytb');
            $('#dvProductMap').hide();
            $('#btnSave').removeClass().addClass("btn");
            document.getElementById('btnSave').disabled = false;
            document.getElementById('txtQuotationNo').disabled = false;
            document.getElementById('txtValidFrom').disabled = false;
            document.getElementById('txtValidTo').disabled = false;
            document.getElementById('txtComments').disabled = false;
            document.getElementById('txtProductName').disabled = false;
            document.getElementById('drpUnit').disabled = false;
            document.getElementById('txtInverseQuantity').disabled = false;
            document.getElementById('chkRate').disabled = false;
            document.getElementById('chkActive').disabled = false;
            document.getElementById('add').disabled = false;
        }
        return false;
    }

    //*************Check the Quotation no *************///
    function CheckQuatationNo() {
        var count = 0;
        var txtQuatno = document.getElementById('txtQuotationNo').value.trim();
        if (txtQuatno != "") {
            $.ajax({
                type: "POST",
                url: "../Quotation/WebService/Quotation.asmx/GetAllQuotations",
                data: "{prefixText: '" + txtQuatno + "',count: '" + 100 + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var lstLocation = data.d;
                    if (lstLocation.length > 0) {
                        count = 1;
                    }
                }
            });
            if (count == "1") {
                var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_02") == null ? "Quotation number is invalid or already exists" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_02")
                ValidationWindow(userMsg, errorMsg);
                    
                document.getElementById('txtQuotationNo').value = "";
                document.getElementById('txtQuotationNo').focus();
                return false;
            }
        }
    }
    // ********** End ************//


    function CheckQuatationSupplierDateValidation() {
        var count = 0;
        var SupplierId = document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].value;
        var txtValFrom = document.getElementById('txtValidFrom').value.trim();
        var txtValTo = document.getElementById('txtValidTo').value.trim();
        var Validdate = SupplierId + "~" + txtValFrom + "~" + txtValTo;
        var QuotationId = document.getElementById('hdnQuotationID').value;
        if (txtValFrom != "" && txtValTo != "" && SupplierId != 0) {
            $.ajax({
                type: "POST",
                url: "../Quotation/WebService/Quotation.asmx/GetQuotationsuppliervalidate",
                data: "{QuotationId:'" + QuotationId + "',SupplierId: '" + SupplierId + "',ValidFrom: '" + txtValFrom + "',ValidTo: '" + txtValTo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    if (data.d > 0) {
                        count = 1;
                    }
                }
            });

            if (count > 0) {
                //var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_16") == null ? "This Supplier already have the Quotation between these given dates" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_16")
                ValidationWindow('Quotation already in "Approved" status against the supplier</br><b align="center">(or)<b></br> The Supplier Already Have The Quotation Between These Given Dates ', errorMsg);
                document.getElementById('txtValidFrom').value = "";
                document.getElementById('txtValidTo').value = "";
                return false;
            }
        }
        else {
            document.getElementById('txtValidFrom').value = "";
            document.getElementById('txtValidTo').value = "";
            var userMsg = SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_17") == null ? "Select the Supplier" : SListForAppMsg.Get("Quotation_ProductSupplierRateMapping_aspx_17")
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    // ********** End ************//

  

</script>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $('#tdSellingPricehed').attr('class', 'hide');
            $('#tdMrphed').attr('class', 'hide');
            $('#tdspval').attr('class', 'hide');
            $('#tdmrpval').attr('class', 'hide');
        }
        //            else {
        //                //$("#dvBillLevdiscount").hide();
        //            }
    });
    $('#DropSupplierName').change(function() {

        HideSellingPrice();
    });

    function HideSellingPrice(getval) {
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $('#tdSellingPricehed').attr('class', 'hide');
            $('#tdMrphed').attr('class', 'hide');
            $('#tdspval').attr('class', 'hide');
            $('#tdmrpval').attr('class', 'hide');

        }
    }
    function HideFillTable(getval) {
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            if (getval == 'hideButton') {
                //alert(1);
                $('tblProductMap').attr('class', 'hide');
                $('#btnSaveID').attr('class', 'hide');
            }
        }
    }
    function HidedvProductMap() {
        $('#dvProductMap').hide();
    }

    function ViewQuotationList(QuotationId, SupllierId) {

//        var strFeatures = "left=25px,top=10px,height=1200px,width=800px,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no";
//        var strURL = "../Quotation/ViewQuotation.aspx?QID=" + QuotationId + "&SID=" + SupllierId + "&View=Print&IsPopup=Y", "S", "height=950,width=1024,scrollbars=yes,status=no,resizable=yes'";

//        var WinPrint = window.open(strURL, "", strFeatures, true);
//        WinPrint.print();
//        
        window.open("../Quotation/ViewQuotation.aspx?QID=" + QuotationId + "&SID=" + SupllierId + "&View=Print&IsPopup=Y", "S", "height=950,width=1024,scrollbars=yes,status=no,resizable=yes");
        return false;
    }



    $(document).ready(function() {
        setTimeout(function() {
        if ($('#hdnAprdMappedProducts').val() != '' && $('#hdnAprdMappedProducts').val() != 'N') {
                var SplitValue = $('#hdnAprdMappedProducts').val().split(',');
                GetAprdMappedProducts(SplitValue[0], SplitValue[1], SplitValue[2]);
            }

        }, 500);
    });
    </script>
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" 
                                meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" 
                                ImageUrl="~/PlatForm/Images/working.gif" 
                                meta:resourcekey="imgProgressbarResource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="w-100p searchPanel">
                    <tr id="Tr1" runat="server" class="panelHeader">
                        <td id="tdShowHide" runat="server" colspan="2" class="colorforcontent">
                            <div id="ACX2OPPmt1" runat="server">
                                &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" align="top" class="pointer"
                                    onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',1);" />
                                <span class="dataheader1txt" "pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',1);">
                                    &nbsp;<%= Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_01 %> </span>
                            </div>
                            <div id="ACX2minusOPPmt1" class="hide" runat="server">
                                &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" align="top" class="pointer"
                                    onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',0);" />
                                <span class="dataheader1txt" "pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',0);">
                                    &nbsp;<%= Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_01 %></span>
                            </div>
                        </td>
                    </tr>
                    <tr id="ACX2responses4" runat="server" class="hide">
                        <td id="Td3" runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table cellpadding="5px" class="panelHeader" cellspacing="2">
                                            <tr class="a-left">
                                                <td>
                                                    <asp:Label ID="lblSearchSupplier" Font-Bold="False" Text="Supplier Name:" 
                                                        runat="server" meta:resourcekey="lblSearchSupplierResource1" />
                                                </td>
                                                <td id="td4" runat="server">
                                                    <asp:DropDownList ID="ddlsearchsupplier" ToolTip="Select Supplier" runat="server"
                                                        CssClass="small"  OnSelectedIndexChanged="ddlsearchsupplier_SelectedIndexChanged"
                                                        AutoPostBack="True" meta:resourcekey="ddlsearchsupplierResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblsearchQuotation" Font-Bold="False" Text="Quotation No:" 
                                                        runat="server" meta:resourcekey="lblsearchQuotationResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtsearchquotation" AutoPostBack="True" OnTextChanged="ddlsearchsupplier_SelectedIndexChanged"
                                                        runat="server" CssClass="small" 
                                                        onkeypress="return ValidateMultiLangChar(this);"
                                                        meta:resourcekey="txtsearchquotationResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtsearchquotation"
                                                        BehaviorID="AutoCompleteExLstGrp1" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="False"
                                                        ServiceMethod="GetAllQuotations" ServicePath="~/Quotation/WebService/Quotation.asmx" OnClientItemSelected="ClearSearchItems"
                                                        DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                 <td>
                                                    <asp:Label ID="lblProduct" Font-Bold="False" Text="Product Name:" 
                                                        runat="server" meta:resourcekey="lblProductResource1" />
                                                </td>
                                              <td>
                                                <asp:TextBox ID="txtProduct" AutoPostBack="true" onfocus="SetEmptySupplier()" OnTextChanged="ddlsearchsupplier_SelectedIndexChanged" CssClass="small" onkeypress="return ValidateMultiLangChar(this);"
                                                 runat="server" ></asp:TextBox>
                                             <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtProduct"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                MinimumPrefixLength="1" CompletionInterval="1" UseContextKey="false" 
                                                FirstRowSelected="True" ServiceMethod="GetAllProducts" ServicePath="~/Quotation/WebService/Quotation.asmx"
                                                DelimiterCharacters="" OnClientItemSelected="SelectProduct" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            </td>  
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdQuotation" runat="server" AutoGenerateColumns="False" PageSize="5"
                                            AllowPaging="True" CssClass="gridView w-100p" OnRowDataBound="grdQuotation_RowDataBound"
                                            OnPageIndexChanging="grdQuotation_PageIndexChanging" 
                                            meta:resourcekey="grdQuotationResource1">
                                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="gridHeader" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSno" runat="server" Text='<%# Container.DataItemIndex + 1 %>' 
                                                            meta:resourcekey="lblSnoResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quotation ID" HeaderStyle-CssClass="hide" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQuotationID" runat="server" Text='<%# Bind("QuotationID") %>' 
                                                            meta:resourcekey="lblQuotationIDResource1" />
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="hide" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quotation No." 
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQuotationNo" class="pointer" ForeColor="Blue" runat="server" 
                                                            Text='<%# Bind("QuotationNo") %>' meta:resourcekey="lblQuotationNoResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 
                                                <asp:TemplateField HeaderText="Supplier Name" 
                                                    meta:resourcekey="TemplateFieldResource12">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSupplierName" Text='<%# Bind("SupplierName") %>' runat="server" />
                                                        <asp:HiddenField ID="hdnSupplierID" runat="server" Value='<%# Bind("SupplierID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Valid From" 
                                                    meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblValidFrom" Text='<%# Bind("ValidFrom","{0:d}") %>' 
                                                            runat="server" meta:resourcekey="lblValidFromResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Valid  To" 
                                                    meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblValidTo" Text='<%# Bind("ValidTo","{0:d}") %>' runat="server" 
                                                            meta:resourcekey="lblValidToResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comments" 
                                                    meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblComments" Text='<%# Bind("Comments") %>' runat="server" 
                                                            meta:resourcekey="lblCommentsResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status" 
                                                    meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" Text='<%# Bind("Status") %>' runat="server" 
                                                            meta:resourcekey="lblStatusResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="IsActive" 
                                                    meta:resourcekey="TemplateFieldResource8">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>' 
                                                            meta:resourcekey="lblIsActiveResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField Visible="False" HeaderText="Action" 
                                                    meta:resourcekey="TemplateFieldResource9">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Show" OnClientClick="return false;"
                                                            
                                                            Style='background-color: Transparent; color: Blue; border-style: none; cursor: pointer' 
                                                            meta:resourcekey="btnEditResource1"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="View" meta:resourcekey="TemplateFieldResource10">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="likQuotationView" Text="View" runat="server" 
                                                            meta:resourcekey="likQuotationViewResource1"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status"  HeaderStyle-CssClass="hide"
                                                
                                                    meta:resourcekey="TemplateFieldResource11">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSupplierId" Text='<%# Bind("SupplierId") %>' runat="server" 
                                                            meta:resourcekey="lblSupplierIdResource1" />
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="hide" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr id="trhidden" style="visibility: hidden">
                                    <td>
                                        dfsdf
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="DivSupplier" runat="server">
                                <table id="tblSupplierDiv" runat="server" class="w-100p">
                                    <tr  runat="server">
                                        <td runat="server">
                                            <table class="w-70p">
                                                <tr class="v-top" "a-left">
                                                    <td>
                                                        <asp:Label ID="Rs_SupplierName" Text="Supplier Name" runat="server" 
                                                            meta:resourcekey="Rs_SupplierNameResource1" />
                                                    </td>
                                                    <td id="tdSupplier" runat="server">
                                                        <asp:DropDownList ID="DropSupplierName" ToolTip="Select Supplier"
                                                            runat="server" onchange="javascript:return ClearQuotation('ClearTable');" TabIndex="1" CssClass="small" 
                                                            meta:resourcekey="DropSupplierNameResource1">
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="tblQuotationNo" Text="Quotation No." runat="server" 
                                                            meta:resourcekey="tblQuotationNoResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtQuotationNo" runat="server" CssClass="small" onblur="javascript:return CheckQuatationNo();"
                                                            onkeypress="return ValidateMultiLangChar(this);" TabIndex="2" meta:resourcekey="txtQuotationNoResource1"></asp:TextBox>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" runat="server" id="imgQuotationNo" />
                                                       
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtQuotationNo"
                                                            BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="False"
                                                            ServiceMethod="GetAllQuotations" ServicePath="~/Quotation/WebService/Quotation.asmx"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <%-- onkeydown="javascript:return CheckSupplier(this.id);"--%>
                                                <tr valign="top" align="left">
                                                    <td id="td2" runat="server">
                                                        <asp:Label ID="tblValidFrom" Text="Valid From" runat="server" 
                                                            meta:resourcekey="tblValidFromResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtValidFrom" CssClass="small datePicker" onkeypress="return ValidateSpecialAndNumeric(this);" onblur="return chkValidDate(this.id);"
                                                            MaxLength="10" TabIndex="3" meta:resourcekey="txtValidFromResource1"></asp:TextBox>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="tblValidTo" Text="Valid To" runat="server" 
                                                            meta:resourcekey="tblValidToResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtValidTo" CssClass="small datePicker" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);" onchange="return chkValidDate1(this.id);"
                                                            MaxLength="10" TabIndex="4" meta:resourcekey="txtValidToResource1"></asp:TextBox>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr valign="top" align="left">
                                                    <td>
                                                        <asp:Label ID="tblComments" Text="Comments" runat="server" 
                                                            meta:resourcekey="tblCommentsResource1" />
                                                    </td>
                                                    <td>
                                                        <textarea id="txtComments" tabindex="5" runat="server" rows="2" cols="23" meta:resourcekey="txtCommentsResource1"></textarea>
                                                    </td>
                                                    <td class="hide">
                                                        <asp:CheckBox ID="chkActive" Text="Activate" TabIndex="6" TextAlign="Left" 
                                                            runat="server" meta:resourcekey="chkActiveResource1" />
                                                    </td>
                                                    <td class="hide">
                                                        <asp:TextBox ID="tblQuotationID" CssClass="small" Text="0" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                                            meta:resourcekey="tblQuotationIDResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" Height="26px"
                                                            OnClientClick="javascript:return ClearQuotation('Clear');" meta:resourcekey="btnClearResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblQuotation" class="w-100p searchPanel">
                                    <tr id="test" runat="server" class="panelHeader lh20">
                                        <td class="w-20p a-center">
                                            <asp:Label ID="Rs_ProductName" CssClass="small" Text="Search Product" 
                                                runat="server" meta:resourcekey="Rs_ProductNameResource1" />
                                        </td>
                                        <td class="w-13p a-center" >
                                            <asp:Label ID="Rs_Unit" CssClass="mini" Text="OrderedUnit" runat="server" 
                                                meta:resourcekey="Rs_UnitResource1" />
                                        </td>
                                        <td class="w-7p">
                                            <asp:Label ID="Rs_InverseQuantity"  runat="server" 
                                                Text="Conversion  Qty" meta:resourcekey="Rs_InverseQuantityResource1" />
                                        </td>
                                        <td class="w-7p">
                                            <asp:Label ID="lblEnter"  Text="Provide Rate" runat="server" 
                                                meta:resourcekey="lblEnterResource1" />
                                        </td>
                                        <td  >
                                            <div id="idRate" class="hide">
                                                <asp:Label ID="Rs_ProductRate"  Text="Cost Price" runat="server" 
                                                    meta:resourcekey="Rs_ProductRateResource1" /></div>
                                        </td>
                                        <td id="tdSellingPricehed"  >
                                            <div id="idSp" class="hide">
                                                <asp:Label ID="lblSellingPrice"  Text="Selling Price" 
                                                    runat="server" meta:resourcekey="lblSellingPriceResource1" /></div>
                                        </td>
                                        <td  >
                                            <div id="idDiscount" class="hide">
                                                <asp:Label ID="lblDiscount"  Text="Discount(%)" runat="server" 
                                                    meta:resourcekey="lblDiscountResource1" /></div>
                                        </td>
                                        <td  >
                                            <div id="idtax" class="hide">
                                                <asp:Label ID="lblTax"  Text="Tax(%)" runat="server" 
                                                    meta:resourcekey="lblTaxResource1" /></div>
                                        </td>
                                        <td id="tdMrphed">
                                            <div id="idMrp" class="hide">
                                                <asp:Label ID="lblMRP" Text="MRP" runat="server" 
                                                    meta:resourcekey="lblMRPResource1" /></div>
                                        </td>
                                        <td class="w-9p">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="lh25">
                                        <td class="paddingT7">
                                            <asp:TextBox ID="txtProductName" onfocus="SetSupplier();" CssClass="large bg-searchimage" onkeypress="return ValidateMultiLangChar(this);"
                                                runat="server" TabIndex="7" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProductName"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                MinimumPrefixLength="1" CompletionInterval="1" OnClientItemSelected="OnSelectProducts"
                                                FirstRowSelected="True" ServiceMethod="GetAllProducts" ServicePath="~/Quotation/WebService/Quotation.asmx"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            <asp:HiddenField ID="hdnProductID" runat="server" />
                                            <asp:HiddenField ID="hdnTaxPercent" runat="server" />
                                        </td>
                                        <td class="paddingT7">
                                            <asp:DropDownList TabIndex="8" CssClass="small" onchange="ChangeConvesionQty();return chkAddUnitinList('Unit');"
                                                ID="drpUnit" runat="server" meta:resourcekey="drpUnitResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="paddingT7">
                                            <asp:TextBox ID="txtInverseQuantity" CssClass="mini" TabIndex="9" runat="server"
                                                onkeypress="return ValidateSpecialAndNumeric(this);" Text="0" meta:resourcekey="txtInverseQuantityResource1"></asp:TextBox>
                                        </td>
                                        <td class="paddingT7">
                                            <asp:CheckBox TabIndex="10" ID="chkRate" runat="server" onClick="fnchkRate(this.id);"
                                                meta:resourcekey="chkRateResource1" />
                                        </td>
                                        <td class="paddingT7">
                                            <div id="idRateVal" class="hide">
                                                <asp:TextBox ID="txtRate" CssClass="mini" TabIndex="11" runat="server" Text="0.00"
                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtRateResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td class="paddingT7" id="tdspval" >
                                            <div id="idSpVal" class="hide">
                                                <asp:TextBox ID="txtSellingPrice" TabIndex="12" CssClass="mini" runat="server" Text="0"
                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtSellingPriceResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td class="paddingT7">
                                            <div id="idDiscountVal" class="hide">
                                                <asp:TextBox ID="txtDiscount" TabIndex="13" CssClass="mini" runat="server" Text="0"
                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td class="paddingT7">
                                            <div id="idTaxVal" class="hide">
                                                <asp:TextBox ID="txtTax" TabIndex="14" CssClass="mini" runat="server" Text="0" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                    meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td class="paddingT7" id="tdmrpval" >
                                            <div id="idMRPVal" class="hide">
                                                <asp:TextBox ID="txtMRP" TabIndex="15" CssClass="mini" runat="server" Text="0" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                    meta:resourcekey="txtMRPResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td id="tdIsDefault" class="paddingT7 hide">
                                            <asp:CheckBox ID="chkIsDefault" TabIndex="16" runat="server" onClick="fnchkIsDefault();"
                                                Text="Default Product" CssClass="paddingT7" meta:resourcekey="chkIsDefaultResource1" />
                                        </td>
                                          <td  id="td1" runat="server" class="a-left" >
                                            <%--<input id="add" title="Add" tabindex="17" class="btn" name="add" onclick="javascript:return checkIsEmpty();"
                                                type="button" value="<%=Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_22  %>"   />--%>
                                                <a id="add" runat="server" class="btn" value="" onclick="javascript:return checkIsEmpty();"><%=Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_22  %></a>
                                                <%--<asp:Button id="add" runat="server" class="btn" Text="Add"  onClientClick="javascript:return checkIsEmpty();" meta:resourcekey="btnaddresourcekey" />--%>
                                            <asp:HiddenField ID="hdnSetListTable" runat="server" />
                                            <asp:HiddenField ID="hdnbeforeTable" runat="server" />
                                            <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnRowEdit" runat="server" />
                                            <asp:HiddenField ID="hdnIsdefault" runat="server" />
                                            <asp:HiddenField ID="hdnParentproductid" runat="server" />
                                            <asp:HiddenField ID="hdnlsunit" runat="server" />
                                            <asp:HiddenField ID="hdnupdate" runat="server" />
                                            <asp:HiddenField ID="hdnautocompvalue" runat="server" />
                                            <input id="hanRateType" runat="server" type="hidden" value="0" />
                                                <input id="hdnUnProducts" runat="server" type="hidden" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="dvProductMap" class="marginT10">
                                    <table id="tblProductMap" class="w-100p gridView">
                                    </table>
                                    <table class="w-100p">
                                        <tr>
                                            <td id="btnSaveID" align="center" class="hide">
                                                <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" OnClientClick="javascript:return ValidateRate();"
                                                    Text="Save" meta:resourcekey="btnSaveResource1" />
                                                &nbsp;
                                                <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn hide" Visible="False"
                                                    OnClick="btnReject_Click" meta:resourcekey="btnRejectResource1" />
                                                &nbsp;
                                                <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" Visible="False"
                                                    OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1" />
                                                <asp:HiddenField ID="hdnSaveTable" runat="server" />
                                                <asp:HiddenField ID="hdnChkFlag" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnCheckedStatus" runat="server" />
                                                <input id="hdnProductStatus" runat="server" type="hidden" value="Pending" />
                                                <input id="hdnchkboxStatus" runat="server" type="hidden" value="N" />
                                                <asp:HiddenField ID="hdnSupID" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnQuotID" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnStatus" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnlsu" runat="server" />
                                                <asp:HiddenField ID="hdnProdName" runat="server" />
                                                <asp:HiddenField ID="hdnAdmin" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnQuotationID" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnApproved" runat="server" />
                                                <asp:HiddenField ID="hdnConfig" runat="server" Value="Y"/>
                                                <asp:HiddenField ID="hdnLstDayQty" runat="server" />
                                                <asp:HiddenField ID="hdnLstMonthQty" runat="server" />
                                                <asp:HiddenField ID="hdnLstQtrQty" runat="server" />
                                                <asp:HiddenField ID="hdnProductIs" runat="server" />
                                                <asp:HiddenField ID="hdnRateConfig" runat="server" value="" />
                                                <asp:HiddenField ID="hdnCorpOrg" runat="server"  />
                                                <asp:HiddenField ID="hdnShowSellingPrice" runat="server" />
                                                &nbsp;&nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource1"
                                                    OnClick="btnCancel_Click" Text="Home" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="pnlProductSales" runat="server" 
            CssClass="hide" 
            meta:resourcekey="pnlProductSalesResource1">
            <table class="w-100p">
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblProductName" runat="server" 
                            meta:resourcekey="lblProductNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                         <asp:Label ID="lblLdq" runat="server" text="Last day quantity :" meta:resourcekey="lblLdqResource1"
                            ></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbllastDayQty" runat="server" 
                            meta:resourcekey="lbllastDayQtyResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLmq" runat="server" text="Last month quantity :" meta:resourcekey="lblLmqResource1"
                            ></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbllastMonthQty" runat="server" 
                            meta:resourcekey="lbllastMonthQtyResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLqq" runat="server" text="Last quater quantity :" meta:resourcekey="lblLqqResource1"
                            ></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbllastQuaterQty" runat="server" 
                            meta:resourcekey="lbllastQuaterQtyResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="a-center">
                        <%--<input id="btnPopUpClose" class="btn" runat="server" type="button" value="<%=Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_23  %>"  meta:resourcekey="CloseResource1"/>--%>
                   <a id="btnPopUpClose" runat="server" class="btn" ><%=Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_23  %></a>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <input type="hidden" id="lstDayQty" runat="server" />
        <input type="hidden" id="lstQtrQty" runat="server" />
        <input type="hidden" id="lstMonthQty" runat="server" />
        <ajc:ModalPopupExtender ID="MPProductSales" BehaviorID="MPProductSales" runat="server"
            CancelControlID="btnPopUpClose" BackgroundCssClass="modalBackground" DropShadow="false"
            PopupControlID="pnlProductSales" TargetControlID="btnDummy" Enabled="True">
        </ajc:ModalPopupExtender>
        <asp:Button ID="btnDummy" runat="server" CssClass="hide" 
            meta:resourcekey="btnDummyResource1" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTempValue" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsSellingPriceTypeRuleApply" runat="server" Value="N" />
    <asp:HiddenField ID="hdnOrdUnit" runat="server" Value="" />
    <asp:HiddenField ID="hdnOrdCUnit" runat="server" Value="0" />
     <asp:HiddenField ID="hdnOrdConfig" runat="server" Value="N" />
          <asp:HiddenField ID="hdnAprdMappedProducts" runat="server" Value="N" />
          <asp:HiddenField ID="hdnProductSearchID" runat="server" Value="0" />
          
    </form>
          <script type="text/javascript" language="javascript">

              function SelectProduct(source, eventArgs) {
                  var ProductDetails = eventArgs.get_value();
                  if(ProductDetails !='')
                  {
                  var ProductID=ProductDetails.split('~')[1];
                  $("#hdnProductSearchID").val(ProductID);
              }
             
              $("#ddlsearchsupplier").val('0');
              $("#txtsearchquotation").val('');
          }

          function ClearSearchItems() {
              $("#txtProduct").val('');
              $("#ddlsearchsupplier").val('0');
          }
          </script>
</body>
</html>


