

function GvSLUnload(obj) {

    var lstInvDevices = [];
    try {
        var btnID = obj.id;

        var gvDeviceID = $('#' + obj.id.replace("_btnUnload", "_hdnSLDeviceID")).val();
        var gvhdnSLDeviceStockUsageID = $('#' + obj.id.replace("_btnUnload", "_hdnSLDeviceStockUsageID")).val();

        var gvhdnSLProuductID = $('#' + obj.id.replace("_btnUnload", "_hdnSLProuductID")).val();
        var gvtxtBarCode = $('#' + obj.id.replace("_btnUnload", "_txtBarCode")).val();

        lstInvDevices.push({
            DeviceStockUsageID: gvhdnSLDeviceStockUsageID,
            DeviceID: gvDeviceID,
            ItemBarcodeNo: gvtxtBarCode,
            ProductID: gvhdnSLProuductID
        });

        if (lstInvDevices.length > 0) {
            $('[id$="hdnDevicesUnloadData"]').val(JSON.stringify(lstInvDevices));
        }

    }
    catch (ex) {
        console.error("GvUnload", ex.message);
    }
}

function GvBulkSLUnload() {

    var lstInvDevices = [];

    try {
        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");

        $('[id$="gvStockLoaded"] tbody tr').each(function(i, n) {
            var currentRow = $(n);
            if (i > 0) {

                if (currentRow.find("input[id$='cbLoad']").is(':checked') == true) {

                    var gvhdnSLDeviceID = $.trim(currentRow.find("input[id$='hdnSLDeviceID']").val());
                    var gvhdnSLDeviceStockUsageID = $.trim(currentRow.find("input[id$='hdnSLDeviceStockUsageID']").val());
                    var gvhdnSLProuductID = $.trim(currentRow.find("input[id$='hdnSLProuductID']").val());
                    var gvtxtBarCode = $.trim(currentRow.find("input[id$='txtBarCode']").val());
                    //currentRow[0].cells[0].childNodes[1].children[0].checked

                    lstInvDevices.push({
                        DeviceStockUsageID: gvhdnSLDeviceStockUsageID,
                        DeviceID: gvhdnSLDeviceID,
                        ItemBarcodeNo: gvtxtBarCode,
                        ProductID: gvhdnSLProuductID
                    });
                }
            }


        });



        if (lstInvDevices.length > 0) {
            $('[id$="hdnDevicesUnloadData"]').val(JSON.stringify(lstInvDevices));
        }
        else {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_02") == null ? "Please select atleast any one row" : SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_02");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
    } catch (ex) {
             console.error("GvBulkSLUnload", ex.message);
    }

}


function GvStockToLoad(obj) {

    var lstInvDevices = [];
    try {
        var btnID = obj.id;

        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");

        var gvSTLDeviceID = $('#' + obj.id.replace("_btnSTLLoad", "_hdnSTLDeviceID")).val();
        var gvhdnSTLProuductID = $('#' + obj.id.replace("_btnSTLLoad", "_hdnSTLProductID")).val();
        var gvSTLtxtBarCode = $('#' + obj.id.replace("_btnSTLLoad", "_txtSTLBarCode")).val();
        var gvStockReceivedBarcodeDetailsID = $('#' + obj.id.replace("_btnSTLLoad", "_hdnStockReceivedBarcodeDetailsID")).val();

        if ($.trim(gvSTLtxtBarCode) == "") {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_01") == null ? "Barcode should not be empty , Please check." : SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_01");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }

        lstInvDevices.push({
            DeviceStockUsageID: 0,
            DeviceID: gvSTLDeviceID,
            ItemBarcodeNo: gvSTLtxtBarCode,
            ProductID: gvhdnSTLProuductID,
            StockReceivedBarcodeDetailsID: gvStockReceivedBarcodeDetailsID
        });

        if (lstInvDevices.length > 0) {
            $('[id$="hdnSTLloadData"]').val(JSON.stringify(lstInvDevices));
        }
       
    }
    catch (ex) {
        console.error("GvStockToLoad", ex.message);
    }
}


function GvBulkStockToLoad(obj) {
    var lstInvDevices = [];

    try {
        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");
        var CheckBool = true;
        var userMsg = "";
        var gvlblProductName = "";

        $('[id$="gvStockToLoaded"] tbody tr').each(function(i, n) {
            var currentRow = $(n);
            if (i > 0) 
            {

                if (currentRow.find("input[id$='cbSTLLoad']").is(':checked') == true && $.trim(currentRow.find("input[id$='txtSTLBarCode']").val()) != "") {

                    var gvhdnSLDeviceID = $.trim(currentRow.find("input[id$='hdnSTLDeviceID']").val());
                    var gvhdnSLDeviceStockUsageID = 0;
                    var gvhdnSLProuductID = $.trim(currentRow.find("input[id$='hdnSTLProductID']").val());
                    var gvtxtBarCode = $.trim(currentRow.find("input[id$='txtSTLBarCode']").val());
                    var gvStockReceivedBarcodeDetailsID =  $.trim(currentRow.find("input[id$='hdnStockReceivedBarcodeDetailsID']").val());
                                       

                    lstInvDevices.push({
                        DeviceStockUsageID: gvhdnSLDeviceStockUsageID,
                        DeviceID: gvhdnSLDeviceID,
                        ItemBarcodeNo: gvtxtBarCode,
                        ProductID: gvhdnSLProuductID,
                        StockReceivedBarcodeDetailsID: gvStockReceivedBarcodeDetailsID
                    });

                }
                else if (CheckBool == true) {

                    gvlblProductName = $.trim(currentRow.find("span[id$='lblProductName']").text());
                    userMsg = SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_02") == null ? " barcode is empty , Please check !." : SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_02");
                    userMsg = gvlblProductName + userMsg;             
                    CheckBool = false;
                }
            }            

        });


        if (CheckBool == false && $("#gvStockToLoaded_ctl01_cbhdrSTLLoad").is(':checked') == true) {
        
            ValidationWindow(userMsg, errAlertTitle);         
            return false;
        }

        if (lstInvDevices.length > 0) {
            $('[id$="hdnSTLloadData"]').val(JSON.stringify(lstInvDevices));
        } else {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_03") == null ? " Please select  product barcode." : SListForAppMsg.Get("LabConsumptionInventory_DevicesStockUsage_aspx_03");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }

    
    }
    catch (ex) {
        console.error("GvBulkStockToLoad", ex.message);
    }


}


//function GvBulkStockToLoad(obj) {
//    var lstInvDevices = [];
//    try {

//        $('[id$="gvStockToLoaded"] tbody tr').each(function(i, n) {
//            var currentRow = $(n);
//            if (i > 0) {

//                if (currentRow.find("input[id$='cbSTLLoad']").is(':checked') == true) {

//                    var gvhdnSLDeviceID = $.trim(currentRow.find("input[id$='hdnSTLDeviceID']").val());
//                    var gvhdnSLDeviceStockUsageID = 0;
//                    var gvhdnSLProuductID = $.trim(currentRow.find("input[id$='hdnSTLProductID']").val());
//                    var gvtxtBarCode = $.trim(currentRow.find("input[id$='txtSTLBarCode']").val());                    

//                    lstInvDevices.push({
//                        DeviceStockUsageID: gvhdnSLDeviceStockUsageID,
//                        DeviceID: gvhdnSLDeviceID,
//                        ItemBarcodeNo: gvtxtBarCode,
//                        ProductID: gvhdnSLProuductID
//                    });
//                }
//            }

//        });


//        if (lstInvDevices.length > 0) {
//            $('[id$="hdnSTLloadData"]').val(JSON.stringify(lstInvDevices));
//        } else {
//            ValidationWindow("Please select load product !.", "Alert");
//            return false;
//        }

//    
//    }
//    catch (ex) {
//        console.error("GvBulkStockToLoad", ex.message);
//    }
//}

function gvCheckboxClick(obj) {

    //var checkboxID = obj.id;
    $('#' + obj.id.replace("_cbSTLLoad", "_txtSTLBarCode")).val('');
    obj.id.is(':checked') = false;
    return false;

}

var lstNearestExpiryProduct;

function funGetNearestExpiryProduct(ProductID,ReceivedUniqueNumber) {
  lstNearestExpiryProduct=[];

    try {
        var param = {strProductID : ProductID ,strOrgID: $("#hdnOrgid").val(),strReceivedUniqueNumber:ReceivedUniqueNumber };

            
            return $.ajax({
                url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetNearestExpiryProduct",
                data: JSON.stringify(param),
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",

                success: function(data) {
                    lstNearestExpiryProduct = JSON.parse(data.d);                    
                    return false;
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var err = eval("(" + XMLHttpRequest.responseText + ")");
                    console.error("funGetGetNearestExpiryProduct", err);
                }
            });
    }
    catch (ex) {
        console.error("funGetGetNearestExpiryProduct", ex.message);
    }
    return false;
}

function BindNearestExpiryProduct()
{
$("#tblNearestExpiryProduct tbody tr").remove(); 
    
    if (lstNearestExpiryProduct.length >0)
    {
    
   $.each(lstNearestExpiryProduct, function(i, obj) {

            Tbl_tr = $('<tr/>');
           
             var tdProductName = $('<td/>').html("<span >" + obj.ProductName + "</span>");
             var tdBatchNo = $('<td/>').html("<span >" + obj.BatchNo + "</span>");
             var tdTotalQty = $('<td/>').html("<span >" + obj.TotalQty + "</span>");
             
             var DateSplit = (new Date(obj.ExpiryDate.match(/\d+/)[0] * 1).toLocaleDateString()) == "01/01/1753" ? "**" : (new Date(obj.ExpiryDate.match(/\d+/)[0] * 1).toDateString().split(" "));
             var tdExpiryDate = $('<td/>').html("<span >" + DateSplit[1]+"/"+ DateSplit[3]+ "</span>");               
            Tbl_tr.append(tdProductName).append(tdBatchNo).append(tdTotalQty).append(tdExpiryDate);
            $('[id$="tblNearestExpiryProduct"] tbody').append(Tbl_tr);

        });
        
     OpenmodelPopup("");   
     }
}