function PrintBillDetails(id) {
    if ($.trim($('[id$="hdfBillType1"]').val()) == '') {
        alert('Add Test to Print Service Quotation');
        return false;
    }
    var objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    //alert('Booking Number:' + id);
    var msg = 'Booking Number:' + id;
    ValidationWindow(msg, objAlert)
    PrintBillItemsTable();
    var prtContent = document.getElementById('divPrint');
    var WinPrint = window.open('', '', 'left=0,top=0,width=500,height=500,toolbar=0,scrollbars=0,status=0');
    WinPrint.document.write(prtContent.innerHTML);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();
    PrintBillClear();
    CreateBillItemsTable(0);
    document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
    document.getElementById('lblPrintCCBillDetail').innerHTML = "";
    ServiceQuotationClearControls();
        return false;
}
function clearPageControlsValue(ClearType) {
    document.getElementById('txtClient').value = "";
    document.getElementById('hdnOPIP').value = "OP";
    document.getElementById('hdnPreviousVisitDetails').value = '';
    document.getElementById('hdnPatientID').value = "-1";
    document.getElementById('hdnVisitPurposeID').value = "-1";
    document.getElementById('hdnClientID').value = "-1";
    document.getElementById('hdnTPAID').value = "-1";
    document.getElementById('hdnClientType').value = "CRP";
    document.getElementById('hdnReferedPhyID').value = "0";
    document.getElementById('hdnReferedPhyName').value = "";
    document.getElementById('hdnReferedPhysicianCode').value = "0";
    document.getElementById('hdnReferedPhyType').value = "";
    document.getElementById('hdnBillGenerate').value = "N";
    document.getElementById('hdnLstPatientInvSample').value = "";
    document.getElementById('hdnLstSampleTracker').value = "";
    document.getElementById('hdnLstPatientInvSampleMapping').value = "";
    document.getElementById('hdnLstInvestigationValues').value = "";
    document.getElementById('hdnLstCollectedSampleStatus').value = "";
    document.getElementById('hdnPatientAlreadyExists').value = 0;
    document.getElementById('hdnPatientAlreadyExistsWebCall').value = 0;
    document.getElementById('hdnVisitID').value = "-1";
    document.getElementById('hdnFinalBillID').value = "-1";
    document.getElementById('hdnCashClient').value = "";
    document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnBaseClientID').value;
    document.getElementById('hdnRateID').value = document.getElementById('hdnBaseRateID').value;
    document.getElementById('hdnMappingClientID').value = "-1";
    document.getElementById('hdnIsMappedItem').value = "N";
    document.getElementById('hdfReferalHospitalID').value = "0";
    clearBillPartValues();
}


function validateEvents(obj) {
    
}

function clearSQControls(clear) {
    if (clear == 1) {
        if (window.confirm("Are you sure you want to clear?")) {
            clearPageControlsValue('N');
            //clearControls();
            document.getElementById('txtName').value = "";
            document.getElementById('tDOB').value = "dd//MM//yyyy";
            document.getElementById('ddlSex').value = "M";
            document.getElementById('txtDOBNos').value = "";
            document.getElementById('txtMobileNumber').value = "";
            document.getElementById('txtPhone').value = "";
            document.getElementById('txtEmail').value = "";
            document.getElementById('ddlDOBDWMY').value = "Year(s)";
            document.getElementById('ddSalutation').value = "7";
            document.getElementById('chkboxPrintQuotation').checked = true;
            document.getElementById('txtInternalExternalPhysician').value = "";
            document.getElementById('hdnReferedPhyID').value = "";
            document.getElementById('hdnReferedPhyName').value = "";
            document.getElementById('hdnReferedPhysicianCode').value = "";
            document.getElementById('hdnReferedPhyType').value = "";
            $('#billPart_spanAddItems').hide();
            $('billPart_tdAttributes').hide();
            $('billPart_dvHealhcard').hide();
            $('billPart_LnkAttributes').hide();
            $('billPart_LnkHistory').hide();
            $('billPart_PanelHistory').hide();
            $('billPart_tdBillDetails').hide();
            $('billPart_tdGrossBillDetails').hide();
            $('billPart_PanelAttributes').hide();
            $('billPart_table_GroupItem').hide();
            $('billPart_Panel1').hide();
        }
    } else {
        clearPageControlsValue('N');
        //clearControls();
        document.getElementById('txtName').value = "";
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('ddlSex').value = "M";
        document.getElementById('txtDOBNos').value = "";
        document.getElementById('txtMobileNumber').value = "";
        document.getElementById('txtPhone').value = "";
        document.getElementById('txtEmail').value = "";
        document.getElementById('ddlDOBDWMY').value = "Year(s)";
        document.getElementById('ddSalutation').value = "7";
        document.getElementById('chkboxPrintQuotation').checked = true;
        document.getElementById('txtInternalExternalPhysician').value = "";
        document.getElementById('hdnReferedPhyID').value = "";
        document.getElementById('hdnReferedPhyName').value = "";
        document.getElementById('hdnReferedPhysicianCode').value = "";
        document.getElementById('hdnReferedPhyType').value = "";
        $('#billPart_spanAddItems').hide();
        $('billPart_tdAttributes').hide();
        $('billPart_dvHealhcard').hide();
        $('billPart_LnkAttributes').hide();
        $('billPart_LnkHistory').hide();
        $('billPart_PanelHistory').hide();
        $('billPart_tdBillDetails').hide();
        $('billPart_tdGrossBillDetails').hide();
        $('billPart_PanelAttributes').hide();
        $('billPart_table_GroupItem').hide();
        $('billPart_Panel1').hide();
    }
}
