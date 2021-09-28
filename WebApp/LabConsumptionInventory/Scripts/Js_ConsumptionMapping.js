

function fun_AddConsumptionAndCalibration() {
    var lstNameValueConsumption = [];
    var autoInvestigationID = $("#hdnInvestigationID").val();
    var ddlMethodNameValue = $("#ddlMethodName option:selected").val();
    var ddlDeviceIDValue = $("#ddlAnalyzerName option:selected").val();
    var autoProductID = $("#hdnProductID").val();
    var txtProductText = $("#txtProductName").val();
    var txtConsumptionQtyText = $("#txtConsumptionQty").val();
    var ddlUOMIDText = $("#ddlUOMID option:selected").text();
    var ddlUOMIDValue = $("#ddlUOMID option:selected").val();
    var txtCalibrationText = $("#txtCalibration").val();
    if ($.trim(txtCalibrationText) == "") {
        txtCalibrationText = 0;
    }
    
    var ddlCalibrationUOMIDText = $("#ddlCalibrationUOMID option:selected").text();
    var ddlCalibrationUOMIDValue = $("#ddlCalibrationUOMID option:selected").val();
    var txtTestNameValue = $('#txtTestName').val();

 

    var hdnInvProductMapDetailID = $("#hdnInvestigationProductMapDetailID").val();
    var hdnInvProductMapID = $("#hdnInvestigationProductMapID").val();    
    var ActionFlag = $("#hdnActionFlag").val();
    var isCheckExitsDBProduct;
    
    try {

        $("#divConsumption").removeClass("hide");
        $("#divConsumption").addClass("show");

        $('#txtTestName').attr('readonly', true);
        document.getElementById("ddlMethodName").disabled = true;
        document.getElementById("ddlAnalyzerName").disabled = true;


        
        if ($.trim($('#btnAdd').val()) == "Add") {
            isCheckExitsDBProduct = fun_CheckExistsDBData(autoProductID);
            if (isCheckExitsDBProduct == true) {

                var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");

                var userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_02") == null ? "This Product already mapped , Please check." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_02");
                ValidationWindow(userMsg, errAlertTitle);               
                return false;
            }
        }
        
        lstNameValueConsumption.push({
            InvestigationProductMapDetailID: hdnInvProductMapDetailID,
            InvestigationProductMapID: hdnInvProductMapID,
            InvestigationID: autoInvestigationID,
            InvestigationName :txtTestNameValue,
            IsManualProcess: 0,
            MethodID: ddlMethodNameValue,
            DeviceID: ddlDeviceIDValue,

            ProductName: txtProductText,
            ProductID: autoProductID,
            ConsumptionQty: txtConsumptionQtyText,
            ConsumptionUOM: ddlUOMIDText,
            ConsumptionUOMID: ddlUOMIDValue,
            
            CalibrationQty: txtCalibrationText,
            CalibrationUOMID: ddlCalibrationUOMIDValue,
            CalibrationUOM: ddlCalibrationUOMIDText ,
            
            ActionFlag: ActionFlag
        });
        fun_CreateTable(lstNameValueConsumption);

     
        fun_AddbtnClear();
    }
    catch (ex) {
        console.error("fun_AddConsumptionAndCalibration", ex.message);
    }
    return false;
}

function fun_CreateTable(lstCollection) {

    try {
        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");


        var boolValue = fun_validateTbl();
        if (boolValue == false) {
            var userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_02") == null ? "This Product already exists." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_02");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        $.each(lstCollection, function(i, obj) {

            Tbl_tr = $('<tr/>');
            var tdhdnConsumptionMapping = JSON.stringify(obj);
            var tdProdutName = $('<td/>').html("<span id='tdPrdoductName' >" + obj.ProductName + "</span>" + "<input type='hidden' id='hdntdProductID' value='" + obj.ProductID + "'/>");
            var tdConsumptionQty = $('<td/>').html("<span id='tdConsumptionQty'>" + obj.ConsumptionQty + "</span>");
            var tdConsumptionUOM = $('<td/>').html("<span id='tdConsumptionUOM'>" + obj.ConsumptionUOM + "</span>");
            var tdCalibrationQty = $('<td/>').html("<span id='tdCalibrationQty'>" + obj.CalibrationQty + "</span>");
            var tdCalibrationUOM = $('<td/>').html("<span id=''>" + obj.CalibrationUOM + "</span>" + "<input type='hidden' id='tdhdnConsumptionMapping' value='" + tdhdnConsumptionMapping + "'/>");

            var Action = $('<td/>').html('<input id="btnDelete" name="imgbtn" value="Delete" type="button" id="imgbtnDelete" class="ui-icon ui-icon-trash b-none pointerm pull-left marginL5 pointer" onclick = "fun_onTblDelete(this);"/>' );
            Tbl_tr.append(tdProdutName).append(tdConsumptionQty).append(tdConsumptionUOM).append(tdCalibrationQty).append(tdCalibrationUOM).append(Action);
            $('[id$="tblConsumption"] tbody').append(Tbl_tr);

        });
    }
    catch (ex) {
        console.error("fun_CreateTable", ex.message);
    }
    return false;

}




function fun_onTblDelete(DeleteRow) {
    try {
        $(DeleteRow).closest('tr').remove();
    }
    catch (ex) {
        console.error("onTblDelete", ex.message);
    }
    return false;
}

function fun_validateTbl() {
    var boolCheckDup = true;

    try {
        autoProID = $("#hdnProductID").val()
        $("[id$='tblConsumption'] tbody tr").each(function(i, n) {
            var currentRow = $(n);
            var ProductID = currentRow.find("input[id$='hdntdProductID']").val();
            if (parseInt(autoProID) == parseInt(ProductID)) {
                boolCheckDup = false;
                return boolCheckDup;
            }
        });

    }
    catch (ex) {
        console.error("onTblDelete", ex.message);
    }
    return boolCheckDup;
}

function fun_AddbtnClear() {
    try {
        $('#txtProductName').val('');
        $('#hdnProductID').val('');
        $('#txtConsumptionQty').val('');
        $('#txtCalibration').val('');
        $('#ddlCalibrationUOMID').val('0');
        $('#ddlUOMID').val('0');

        $("#hdnInvestigationProductMapDetailID").val('0');
        $("#hdnInvestigationProductMapID").val('0');
        $("#hdnActionFlag").val("INSERT");
        $('#btnAdd').val('Add');
        document.getElementById("txtProductName").disabled = false;
    }
    catch (ex) {
        console.error("fun_AddbtnClear", ex.message);
    }
}

function fun_ValidatebtnAdd() {
    var userMsg;
    try {
        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");

        if ($.trim($('#ddlAnalyzerName option:selected').val()) == "0") {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_05") == null ? "Please select  Device Name." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_05");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }

        if ($.trim($('#txtTestName').val()) == '') {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_03") == null ? "Investigation Name should not be empty." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_03");
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        
        if ($.trim($('#hdnInvestigationID').val()) == '') {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_04") == null ? "Please select valid Investigation Name." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_04");
            $('#txtTestName').val('');
            $('#txtTestName').focus();
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        

        
        if ($.trim($('#txtProductName').val()) == "") {

            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_06") == null ? "Product Name should not be empty." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_06");
            $('#txtProductName').val('');
            $('#txtProductName').focus();
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        if ($.trim($('#hdnProductID').val()) == "") {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_07") == null ? "Please select valid Product Name." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_07");
            $('#hdnProductID').val('');
            $('#hdnProductID').focus();
            ValidationWindow(userMsg, errAlertTitle);
            return false;

        }
        if ($.trim($('#txtConsumptionQty').val()) == "") {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_08") == null ? "Consumption Qty should not be empty." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_08");
            $('#txtConsumptionQty').focus();
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        if ($.trim($('#ddlUOMID').val()) == "0") {
            userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_09") == null ? "Please select Consumption UOM." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_08");
            $('#txtConsumptionQty').focus();
            ValidationWindow(userMsg, errAlertTitle);
            return false;
        }
        
   
            var ar = [];
            ar.push(funCheckInvestigationProductMappingStatus());
                $.when.apply(this, ar).done(function() {
                    fun_AddConsumptionAndCalibration();
                });           
        
      
       
    }
    catch (ex) {
        console.error("fun_AddbtnClear", ex.message);
    }
    return false;
}


function fun_ReadTbltblConsumption() {
    var lstConsumptionCollection = [];

    try {
        $("[id$='tblConsumption'] tbody tr").each(function(i, val) {
            var currentRow = $(val);
            var lsttdhdnConsumptionMapping = $.parseJSON(currentRow.find("input[id$='tdhdnConsumptionMapping']").val());                 
                 
                 
            lstConsumptionCollection.push({
                InvestigationProductMapDetailID:lsttdhdnConsumptionMapping.InvestigationProductMapDetailID,
                InvestigationProductMapID :lsttdhdnConsumptionMapping.InvestigationProductMapID,
                InvestigationID: lsttdhdnConsumptionMapping.InvestigationID,
                IsManualProcess: lsttdhdnConsumptionMapping.IsManualProcess,
                MethodID: lsttdhdnConsumptionMapping.MethodID,
                DeviceID: lsttdhdnConsumptionMapping.DeviceID,
                ProductName: lsttdhdnConsumptionMapping.ProductName,
                ProductID: lsttdhdnConsumptionMapping.ProductID,
                ConsumptionQty: lsttdhdnConsumptionMapping.ConsumptionQty,
                ConsumptionUOM: lsttdhdnConsumptionMapping.ConsumptionUOM,
                ConsumptionUOMID: lsttdhdnConsumptionMapping.ConsumptionUOMID,
                CalibrationQty: lsttdhdnConsumptionMapping.CalibrationQty,
                CalibrationUOMID: lsttdhdnConsumptionMapping.CalibrationUOMID,
                CalibrationUOM: lsttdhdnConsumptionMapping.CalibrationUOM,
                ActionFlag: lsttdhdnConsumptionMapping.ActionFlag
            });

         
        });

        if (lstConsumptionCollection.length > 0) {
            $("#hdnlstInvestigationProductMappingDetails").val(JSON.stringify(lstConsumptionCollection));
        }
        else {

            var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");
            var userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_11") == null ? "Please check, No recordes found." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_11");
            ValidationWindow(userMsg, errAlertTitle);       
          
            return false;
        }
    }
    catch (ex) {
        console.error("fun_AddbtnClear", ex.message);
    }
}

function fun_EditConsumptiontbl(editRow) {
    var lstGVJsondata = [];
       
    try {
        var gvhdnInvProMapDetailID = $(editRow).closest('tr').find("input[id$='hdnInvProMapDetailID']").val();
        lstGVJsondata = $.parseJSON($("#hdnGVJsonData").val());


        for (var R = 0; R < lstGVJsondata.length; R++) 
		{
		    if (lstGVJsondata[R].InvestigationID == $("#hdnInvestigationID").val() && lstGVJsondata[R].DeviceID == $("#ddlAnalyzerName option:selected").val() && lstGVJsondata[R].MethodID == $("#ddlMethodName option:selected").val()) {
		        if (lstGVJsondata[R].InvestigationProductMapDetailID == gvhdnInvProMapDetailID) {

		            $("#hdnInvestigationID").val(lstGVJsondata[R].InvestigationID);
		            $('#txtTestName').val(lstGVJsondata[R].InvestigationName);
		            $("#ddlMethodName").val(lstGVJsondata[R].MethodID);
		            $("#ddlAnalyzerName").val(lstGVJsondata[R].DeviceID);
		            $("#txtProductName").val(lstGVJsondata[R].ProductName);
		            $("#hdnProductID").val(lstGVJsondata[R].ProductID);
		            $("#txtConsumptionQty").val(lstGVJsondata[R].ConsumptionQty);
		            $("#ddlUOMID").val(lstGVJsondata[R].ConsumptionUOMID);
		            $("#txtCalibration").val(lstGVJsondata[R].CalibrationQty)
		            $("#ddlCalibrationUOMID").val(lstGVJsondata[R].CalibrationUOMID)
		            $("#hdnInvestigationProductMapDetailID").val(lstGVJsondata[R].InvestigationProductMapDetailID);
		            $("#hdnInvestigationProductMapID").val(lstGVJsondata[R].InvestigationProductMapID);
		            $("#hdnActionFlag").val(lstGVJsondata[R].ActionFlag);

		            $('#txtTestName').attr('readonly', true);
		            document.getElementById("ddlMethodName").disabled = true;
		            document.getElementById("ddlAnalyzerName").disabled = true;
		            document.getElementById("txtProductName").disabled = true;
		            $('#btnAdd').val('Update');
		            $(editRow).closest('tr').css('background-color', '#FFF8DC');
		            $('#' + $(editRow).closest('tr').find("input[id$='btnDelete']").attr('id')).hide();
		            break;

		        }
		    }
		    else if ($.trim($("#hdnInvestigationID").val()) == "" && $("#ddlAnalyzerName option:selected").val() == "0") {
		    if (lstGVJsondata[R].InvestigationProductMapDetailID == gvhdnInvProMapDetailID) {

		        $("#hdnInvestigationID").val(lstGVJsondata[R].InvestigationID);
		        $('#txtTestName').val(lstGVJsondata[R].InvestigationName);
		        $("#ddlMethodName").val(lstGVJsondata[R].MethodID);
		        $("#ddlAnalyzerName").val(lstGVJsondata[R].DeviceID);
		        $("#txtProductName").val(lstGVJsondata[R].ProductName);
		        $("#hdnProductID").val(lstGVJsondata[R].ProductID);
		        $("#txtConsumptionQty").val(lstGVJsondata[R].ConsumptionQty);
		        $("#ddlUOMID").val(lstGVJsondata[R].ConsumptionUOMID);
		        $("#txtCalibration").val(lstGVJsondata[R].CalibrationQty)
		        $("#ddlCalibrationUOMID").val(lstGVJsondata[R].CalibrationUOMID)
		        $("#hdnInvestigationProductMapDetailID").val(lstGVJsondata[R].InvestigationProductMapDetailID);
		        $("#hdnInvestigationProductMapID").val(lstGVJsondata[R].InvestigationProductMapID);
		        $("#hdnActionFlag").val(lstGVJsondata[R].ActionFlag);

		        $('#txtTestName').attr('readonly', true);
		        document.getElementById("ddlMethodName").disabled = true;
		        document.getElementById("ddlAnalyzerName").disabled = true;
		        document.getElementById("txtProductName").disabled = true;
		        $('#btnAdd').val('Update');
		        $(editRow).closest('tr').css('background-color', '#FFF8DC');
		        $('#' + $(editRow).closest('tr').find("input[id$='btnDelete']").attr('id')).hide();
		        break;

		    }
		    
		    }
		    else {

		        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");

		        var userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_12") == null ? "Please check, Edited row InvestigatioName,Devices or Method name mismatch." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_12");
		        ValidationWindow(userMsg, errAlertTitle);
		        return false;
		    }			
        
        
        }

        //$(editRow).closest('tr').remove();
        
    }
    catch (ex) {
        console.error("fun_EditConsumptiontbl", ex.message);
    }
    return false;
}



function fun_updateInvestigationProductMappingStatus(obj)
{       
        var IPMS_InvestigationProductMapID;        
        var IPMS_ProductID;
        
    try {

        var errAlertTitle = SListForAppMsg.Get("LabConsumptionInventory_Alert") == null ? "Alert" : SListForAppMsg.Get("LabConsumptionInventory_Alert");


        var gvhdnInvProMapDetailID = $(obj).closest('tr').find("input[id$='hdnInvProMapDetailID']").val();
            lstGVJsondata = $.parseJSON($("#hdnGVJsonData").val());


        for (var R = 0; R < lstGVJsondata.length; R++) {

            if (lstGVJsondata[R].InvestigationProductMapDetailID == gvhdnInvProMapDetailID) {
                IPMS_InvestigationProductMapID = lstGVJsondata[R].InvestigationProductMapID;
                IPMS_ProductID =lstGVJsondata[R].ProductID;
                break;
            
            }        
        
        }


        var param = { InvestigationProductMapDetailID: gvhdnInvProMapDetailID, InvestigationProductMapID: IPMS_InvestigationProductMapID, ProductID: IPMS_ProductID, Orgid: $("#hdnOrgid").val() };
        $.ajax({
            url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/UpdateInvestigationProductMappingStatus",
            data: JSON.stringify(param),
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",

            success: function(data) {
                //alert(data.d);
                $(obj).closest('tr').remove();
                //fun_ClearALL();

                var userMsg = SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_13") == null ? "Deleted successfully." : SListForAppMsg.Get("LabConsumptionInventory_ConsumptionMapping_aspx_13");
                ValidationWindow(userMsg, errAlertTitle);

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var err = eval("(" + XMLHttpRequest.responseText + ")");
                console.error("fun_updateInvestigationProductMappingStatus", err);
            }
        });
        $("#hdnCheckExists").val('');
	}
	catch(ex)
	{
		console.error("fun_CheckExistsDBData", ex.message);
	}
	return false;
}



function fun_ClearALL() {
    try {        
        

        $('#txtTestName').val('');         
        $("#hdnInvestigationID").val('');
        $('#txtTestName').attr('readonly', false);

        $('#ddlAnalyzerName').val('0');
        document.getElementById("ddlAnalyzerName").disabled = false;
        
        $('#ddlMethodName').val('0');
        document.getElementById("ddlMethodName").disabled = false;

       

        $('#txtProductName').val('');
        $('#hdnProductID').val('');
        
        $('#txtConsumptionQty').val('');
        $('#ddlUOMID').val('0');
        
        $('#txtCalibration').val('');
        $('#ddlCalibrationUOMID').val('0');
        

        $("#hdnInvestigationProductMapDetailID").val('0');
        $("#hdnInvestigationProductMapID").val('0');
        
        $("#hdnActionFlag").val("INSERT");
        $('#btnAdd').val('Add');
        $('#hdnCheckExists').val('');
        

        
    }
    catch (ex) {
        console.error("fun_AddbtnClear", ex.message);
    }
    return false;
}





function funCheckInvestigationProductMappingStatus() {

    try {
        var param = { InvestigationID: $("#hdnInvestigationID").val(), DevicesID: $("#ddlAnalyzerName option:selected").val(), MethodID: $("#ddlMethodName option:selected").val(), OrgID: $("#hdnOrgid").val() };

       // Attune.Kernel.LabConsumption_Inventory.LabConsumptionInventory.CheckInvestigationProductMappingStatus($("#hdnInvestigationID").val(), $("#ddlAnalyzerName option:selected").val(), $("#ddlMethodName option:selected").val(), $("#hdnOrgid").val(), OnSuccess, OnFailure);

        if ($.trim($("#hdnCheckExists").val()) == "") {
            return $.ajax({
                url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/CheckInvestigationProductMappingStatus",
                data: JSON.stringify(param),
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",

                success: function(data) {

                    $("#hdnCheckExists").val(data.d);
                    return false;
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var err = eval("(" + XMLHttpRequest.responseText + ")");
                    console.error("funCheckInvestigationProductMappingStatus", err);
                }
            });
        }
      

    }
    catch (ex) {
        console.error("funCheckInvestigationProductMappingStatus", ex.message);
    }
    return false;
}



function fun_CheckExistsDBData(ProductID) {
    var lstGVJsondata = [];
    var BoolIsCheckFlag = false;

   //  alert($.trim($("#hdnCheckExists").val()));

    try {
        if ($.trim($("#hdnCheckExists").val()) != "") {

            lstGVJsondata = $.parseJSON($("#hdnCheckExists").val());

            for (var R = 0; R < lstGVJsondata.length; R++) {

                if (parseInt(lstGVJsondata[R].ProductID) == parseInt(ProductID)) {
                    BoolIsCheckFlag = true;
                    return BoolIsCheckFlag;
                }
            }
        }

    }
    catch (ex) {
        console.error("fun_CheckExistsDBData", ex.message);
    }
    return BoolIsCheckFlag;
}


function DDlUomOnchange() {

    $("#ddlCalibrationUOMID").val($("#ddlUOMID option:selected").val());
    $('#ddlCalibrationUOMID option:not(:selected)').prop('disabled', true);    
    return false;
}