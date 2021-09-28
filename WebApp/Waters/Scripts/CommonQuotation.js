
function SelectedClient(source, eventArgs) {

    document.getElementById('hdnSelectedClientDetails').value = eventArgs.get_value();
    var alldetails = document.getElementById('hdnSelectedClientDetails').value.split("~");
    var ClientDetails = "";
    var Clientname = eventArgs.get_value().split('~')[0];
    var Clientcode = eventArgs.get_value().split('~')[1];
    var ClientID = eventArgs.get_value().split('~')[2];
    document.getElementById('hdnSelectedClientClientID').value = ClientID;
    var Orgid = document.getElementById('hdnOrgID').value;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetQuotationClientNameDetails",
        data: JSON.stringify({ ClientID: ClientID, Orgid: Orgid }),
        dataType: "json",
        async: false,
        success: function(data, value) {
            var GetData = JSON.parse(data.d[0]);
            var lstClientDetails = GetData.Second;
            var IsQuotationAvailable = lstClientDetails.split('~')[10];
            if (IsQuotationAvailable != 'N') {
                var a = confirm("Already pending quotation is available against the selected client.Do you wish to continue?");
                if (a == true) {
                    document.getElementById('txtClientName').value = lstClientDetails.split('~')[0];
                    document.getElementById('txtEmailID').value = lstClientDetails.split('~')[1];
                    document.getElementById('txtMobileNo').value = lstClientDetails.split('~')[2];
                    document.getElementById('txtTelephoneNo').value = lstClientDetails.split('~')[3];
                    document.getElementById('txtAddress').value = lstClientDetails.split('~')[4];
                    document.getElementById('txtSuburb').value = lstClientDetails.split('~')[5];
                    document.getElementById('txtCity').value = lstClientDetails.split('~')[6];
                    document.getElementById('ddState').value = lstClientDetails.split('~')[7];
                    document.getElementById('ddCountry').value = lstClientDetails.split('~')[8];
                    document.getElementById('txtPincode').value = lstClientDetails.split('~')[9];
                    document.getElementById('txtAddress1').value = lstClientDetails.split('~')[4];
                    document.getElementById('txtSuburb1').value = lstClientDetails.split('~')[5];
                    document.getElementById('txtCity1').value = lstClientDetails.split('~')[6];
                    document.getElementById('ddState1').value = lstClientDetails.split('~')[7];
                    document.getElementById('ddCountry1').value = lstClientDetails.split('~')[8];
                    document.getElementById('txtPincode1').value = lstClientDetails.split('~')[9];
                }
            }
            else {
                document.getElementById('txtClientName').value = lstClientDetails.split('~')[0];
                document.getElementById('txtEmailID').value = lstClientDetails.split('~')[1];
                document.getElementById('txtMobileNo').value = lstClientDetails.split('~')[2];
                document.getElementById('txtTelephoneNo').value = lstClientDetails.split('~')[3];
                document.getElementById('txtAddress').value = lstClientDetails.split('~')[4];
                document.getElementById('txtSuburb').value = lstClientDetails.split('~')[5];
                document.getElementById('txtCity').value = lstClientDetails.split('~')[6];
                document.getElementById('ddState').value = lstClientDetails.split('~')[7];
                document.getElementById('ddCountry').value = lstClientDetails.split('~')[8];
                document.getElementById('txtPincode').value = lstClientDetails.split('~')[9];
                document.getElementById('txtAddress1').value = lstClientDetails.split('~')[4];
                document.getElementById('txtSuburb1').value = lstClientDetails.split('~')[5];
                document.getElementById('txtCity1').value = lstClientDetails.split('~')[6];
                document.getElementById('ddState1').value = lstClientDetails.split('~')[7];
                document.getElementById('ddCountry1').value = lstClientDetails.split('~')[8];
                document.getElementById('txtPincode1').value = lstClientDetails.split('~')[9];
            }

        }

    });
    document.getElementById("chkSameAddress").checked = true;
    $("#trSameBIllingAddrOne").attr("style", "display:none");
    $("#trSameBIllingAddrTwo").attr("style", "display:none");
}




function AddItems() {

    //debugger;


    objTestname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_12") == null ? "Select/Provide Test Name From List" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_12");
    objname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_07") == null ? "Provide Client Details" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_07");
    objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
    objperiod = SListForAppMsg.Get("Waters_QuotationMaster_aspx_09") == null ? "Provide Validity Period" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_09");
    objAlready = SListForAppMsg.Get("Waters_QuotationMaster_aspx_10") == null ? "The test has been already ordered" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_10");
    objSampletype = SListForAppMsg.Get("Waters_QuotationMaster_aspx_13") == null ? "Enter Sample Type" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_13");
    objSampleCount = SListForAppMsg.Get("Waters_QuotationMaster_aspx_14") == null ? "Enter Sample Count" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_14");
    var objDiscountValue = SListForAppMsg.Get("Waters_QuotationMaster_aspx_22") == null ? "Enter Discount Value" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_22");

    if ($('#txtClientName').val() == '') {

        // alert("Provide name");
        ValidationWindow(objname, objalert);
        //$('#txtClientName').focus();
        return false;

    }
    if ($('#txtValidityPeriod').val() == '') {
        ValidationWindow(objperiod, objalert);
        //alert("Provide Validity Period");
        //$('#txtValidityPeriod').focus();
        return false;

    }



    var vSno = SListForAppMsg.Get('Waters_QuotationMaster_aspx_01') == null ? "S.NO" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_01');
    var vTestName = SListForAppMsg.Get('Waters_QuotationMaster_aspx_02') == null ? "Test Name" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_02');
    var vSampleName = SListForAppMsg.Get('Waters_QuotationMaster_aspx_03') == null ? "Sample Type" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_03');
    var vSampleCount = SListForAppMsg.Get('Waters_QuotationMaster_aspx_04') == null ? "Sample Count" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_04');
    var vAmount = SListForAppMsg.Get('Waters_QuotationMaster_aspx_05') == null ? "Amount" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_05');
    var vAction = SListForAppMsg.Get('Waters_QuotationMaster_aspx_06') == null ? "Action" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_06');

    var ID;
    var name;
    var feeType;
    var amount;
    var SampleType;
    var SampleCount;
    var DiscountType;
    var DiscountValue;
    var FinalTestAmount;
    var imain = 0;
    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "";
    var TempCurrent;
    var TempHistory;
    var TempSubHistory;
    var main = 0;
    var TempFinal;
    var DiscountAmt = new Array();
    if (document.getElementById('hdnOrdereditems').value != "") {


        if ($('#ddSampleType').val() == '0') {
            ValidationWindow(objSampletype, objalert);
            //alert("Provide Validity Period");
            //$('#txtValidityPeriod').focus();
            return false;

        }


        if ($('#txtSampleCount').val() == '') {
            ValidationWindow(objSampleCount, objalert);
            //alert("Provide Validity Period");
            //$('#txtValidityPeriod').focus();
            return false;

        }



        if ($('#ddlDiscountType').val() != '0') {

            if ($('#txtDiscountValue').val() == '') {

                ValidationWindow(objDiscountValue, objalert);
                //alert("Provide Validity Period");
                //$('#txtValidityPeriod').focus();
                return false;
            }

        }




    }

    if (document.getElementById('ddSampleType').value != "0") {
        SampleType = document.getElementById('ddSampleType').value;
        SampleCount = document.getElementById('txtSampleCount').value;

        DiscountValue = document.getElementById('txtDiscountValue').value;
        var Tempdiscount = document.getElementById('ddlDiscountType');
        DiscountType = Tempdiscount.options[Tempdiscount.selectedIndex].value;

        if (document.getElementById('hdnOrdereditems').value == "") {

            ValidationWindow(objTestname, objalert);
            return false;

        }


        document.getElementById('hdnOrdereditems').value = document.getElementById('hdnOrdereditems').value + "," + SampleType + "," + SampleCount + "," + DiscountValue + "," + DiscountType;

        if (document.getElementById('hdnTestQuotationList').value == "") {

            document.getElementById('hdnAppendTest').value = document.getElementById('hdnAppendTest').value + document.getElementById('hdnOrdereditems').value + "|";



            TempHistory = document.getElementById('hdnAppendTest').value.split("|");
            if (TempHistory.length > 2 && document.getElementById('hdnOrdereditems').value != "") {


                for (main = 0; main < TempHistory.length; main++) {
                    TempCurrent = TempHistory[main].split(",");
                    for (var submain = main + 1; submain < TempHistory.length - 1; submain++) {
                        TempSubHistory = TempHistory[submain].split(",");
                        if ((TempCurrent[0]) == (TempSubHistory[0])) {
                            ValidationWindow(objAlready, objalert);
                            //alert("The test has been already ordered");

                            TempHistory[submain] = "";
                            TempFinal = "";

                            for (main = 0; main < TempHistory.length - 1; main++) {

                                if (TempHistory[main] != "")

                                    TempFinal += TempHistory[main] + "|";


                            }

                            document.getElementById('hdnAppendTest').value = TempFinal;
                            document.getElementById('hdnOrdereditems').value = "";
                            document.getElementById('hdnOrdereditems').value = "";
                            document.getElementById('ddSampleType').value = "0";
                            document.getElementById('txtSampleCount').value = "";
                            document.getElementById('txtDiscountValue').value = "";
                            document.getElementById('ddlDiscountType').selectedIndex = "0";
                            document.getElementById('txtTestName').value = "";
                            document.getElementById('hdnGrossValue').value = "0";

                            return false;
                        }
                    }




                }

            }

        }


    }


    if (document.getElementById('hdnTestQuotationList').value == "") {
        var arrGotValue = new Array();
        var arrMain = new Array();
        var arrsub = new Array();
        var HiddenFieldArray = new Array();
        var SNO = 1;

        var UpdateMain = 0, TempIndividualRate = 0;

        var UpdatedAmount = "", UpdatedDiscountValue = "", UpdatedCount = "", UpdatedDefaultAmt = 0, UpdatedDiscountCount = "";

        var IsPopup = "";
        var Type;
        var Discountvaluelist = "";
        var MainPkg, MainSubPkg;
        var TempPKGID, TempPKGName, TempPKGType;
        startHeaderTag = "<table id='waters' width='60%' Class='gridView'  border='1px;' cellpadding='0' cellspacing='0'>";
        if (document.getElementById('hdnAppendTest').value != "") {
            startHeaderTag += "<tr class='dataheader1'><th style='width:1%;'>" + vSno + "</th><th style='width:1%;'>" + vTestName + "</th><th style='width:1%;'>" + vSampleName + "</th><th style='width:1%;'>" + vSampleCount + "</th><th style='width:1%;'>" + vAmount + "</th><th style='width:1%;'>" + vAction + "</th></tr>";
        }
        newPaymentTables = startHeaderTag;
        endTag = "</table>";
        arrMain = document.getElementById('hdnAppendTest').value.split("|");
        document.getElementById('hdnTempTest').value = "";
        document.getElementById('hdnTempTest').value = '[';
        for (iMain = 0; iMain < arrMain.length - 1; iMain++) {

            arrsub = arrMain[iMain].split(",");

            ID = arrsub[0];
            name = arrsub[1].trim();
            feeType = arrsub[2];
            amount = arrsub[3];
            SampleType = arrsub[27];
            SampleCount = arrsub[28];
            DiscountValue = arrsub[29];
            DiscountType = arrsub[30];

            if (document.getElementById('hdnPKGUpdateList').value != "") {
                var UpdateList = document.getElementById('hdnPKGUpdateList').value.split('%');

                for (UpdateMain = 0; UpdateMain < UpdateList.length; UpdateMain++) {

                    var UpdateListID = UpdateList[UpdateMain].split('^');
                    var ListID = UpdateListID[0].split('~');
                    if ((ListID[0]) == ID) {

                        document.getElementById('hdnPKGList').value = UpdateListID[1];
                        // IsPopup = "Y";
                        UpdatedAmount = ListID[1];
                        UpdatedDiscountValue = ListID[2];
                        UpdatedCount = ListID[3];
                        UpdatedDefaultAmt = ListID[4];
                        UpdatedDiscountCount = ListID[5];
                        document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(UpdatedAmount);

                    }



                }



                if (UpdatedAmount != "" && UpdatedDiscountValue != "") {
                    IsPopup = "Y";

                }



            }


            if (feeType == "PKG" && IsPopup != "Y") {

                if (ID != undefined && feeType != undefined) {
                    Type = feeType;
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/GetPKGQuotationDetails",
                        data: "{ 'ID': '" + ID + "','Type': '" + Type + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var Items = data.d;
                            var i = 0;
                            $.each(Items, function(index, Item) {
                                document.getElementById('hdnPKGList').value += Item.InvestigationID + '~' + Item.InvestigationName + '~' +
		Item.Name + '~' + Item.CONV_Factor + '|';


                            });


                        },
                        failure: function(msg) {
                            ShowErrorMessage(msg);
                        }

                    });
                }




            }

            if (IsPopup == "N" || IsPopup == "") {
                if (DiscountType == "PERCENTAGE") {

                    FinalTestAmount = parseFloat((amount * DiscountValue) / 100).toFixed(2);
                    DiscountAmt[iMain] = FinalTestAmount;
                    FinalTestAmount = amount - FinalTestAmount;

                    FinalTestAmount = SampleCount * FinalTestAmount;
                    FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
                    document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);

                }
                else if (DiscountType == "VALUE") {


                FinalTestAmount = SampleCount * amount;
                FinalTestAmount = parseFloat(FinalTestAmount - DiscountValue).toFixed(2);
                    DiscountAmt[iMain] = DiscountValue;
                    DiscountAmt[iMain] = FinalTestAmount;
                    document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);

                }

                else {
                    FinalTestAmount = parseFloat(amount * SampleCount).toFixed(2);
                    DiscountAmt[iMain] = 0;
                    FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
                    document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);


                }

                if (DiscountValue == "") {

                    DiscountValue = 0;
                }

            }
            if (feeType == "PKG") {
                MainPkg = document.getElementById('hdnPKGList').value.split("|");
                for (imain = 0; imain < MainPkg.length - 1; imain++) {

                    MainSubPkg = MainPkg[imain].split("~");
                    TempPKGID = MainSubPkg[0];
                    TempPKGName = MainSubPkg[1];
                    TempPKGType = MainSubPkg[2];
                    TempIndividualRate = MainSubPkg[3];
                    if (IsPopup == "N" || IsPopup == "") {
                        HiddenFieldArray += '{' + '"ID":' + TempPKGID + ',' + '"Name":' + '"' + TempPKGName + '"' + ',' + '"Type":' + '"' + TempPKGType + '"' + ', "SampleType":' + '"' + arrsub[27] + '"' + ', "SampleCount":' + arrsub[28] + ', "DiscountValue":' + '"' + DiscountValue + '"' + ', "DiscountType":' + '"' + arrsub[30] + '"' + ',"Amount":' + '"' + FinalTestAmount + '"' + ', "status":' + '"Pending"' + ',"PkgID":' + '"' + ID + '"' + ', "PkgName":' + '"' + name + '"' + ',"AccessionNumber":' + '"0"' + '}';
                    } else {
                        HiddenFieldArray += '{' + '"ID":' + TempPKGID + ',' + '"Name":' + '"' + TempPKGName + '"' + ',' + '"Type":' + '"' + TempPKGType + '"' + ', "SampleType":' + '"' + arrsub[27] + '"' + ', "SampleCount":' + UpdatedCount + ', "DiscountValue":' + '"' + UpdatedDiscountCount + '"' + ', "DiscountType":' + '"' + arrsub[30] + '"' + ',"Amount":' + '"' + UpdatedAmount + '"' + ', "status":' + '"Pending"' + ',"PkgID":' + '"' + ID + '"' + ', "PkgName":' + '"' + name + '"' + ',"AccessionNumber":' + '"0"' + '}';

                    }
                    if (imain < MainPkg.length - 2) {

                        HiddenFieldArray += ',';
                    }
                    else if (iMain < arrMain.length - 2) {

                        HiddenFieldArray += ',';
                    }

                }




            }
            else {

                HiddenFieldArray += '{' + '"ID":' + arrsub[0] + ',' + '"Name":' + '"' + arrsub[1].trim() + '"' + ',' + '"Type":' + '"' + arrsub[2] + '"' + ', "SampleType":' + '"' + arrsub[27] + '"' + ', "SampleCount":' + arrsub[28] + ', "DiscountValue":' + '"' + DiscountValue + '"' + ', "DiscountType":' + '"' + arrsub[30] + '"' + ',"Amount":' + '"' + FinalTestAmount + '"' + ', "status":' + '"Pending"' + ', "PkgID":' + '"0"' + ', "PkgName":' + '""' + ',"AccessionNumber":' + '"0"' + '}';
                if (iMain < arrMain.length - 2) {

                    HiddenFieldArray += ',';
                }
            }

            document.getElementById('hdnTempTest').value += HiddenFieldArray;


            HiddenFieldArray = "";

            BodyTag += "<TR>";
            BodyTag += "<TD align='Center''>" + SNO + "</TD>";
            if (feeType == "PKG") {
                if (IsPopup != 'Y') {
                    BodyTag += "<TD ><input value ='" + name + "'  name='" + ID + "," + feeType + "," + name + "," + arrsub[3] + "," + SampleCount + "," + SampleType + "," + DiscountValue + "," + DiscountAmt[iMain] + " ," + FinalTestAmount + "," + arrsub[30] + "'  onclick='GetTestGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";
                }
                else {
                    BodyTag += "<TD ><input value ='" + name + "'  name='" + ID + "," + feeType + "," + name + "," + UpdatedDefaultAmt + "," + UpdatedCount + "," + SampleType + "," + UpdatedDiscountCount + "," + DiscountValue + " ," + UpdatedAmount + "," + arrsub[30] + "'  onclick='GetTestGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";

                }


            }
            else {

                BodyTag += "<TD align='Center''>" + name + "</TD>";
            }
            BodyTag += "<TD align='Center''>" + SampleType + "</TD>";


            if (IsPopup == "N" || IsPopup == "") {
                BodyTag += "<TD align='Center''>" + SampleCount + "</TD>";
                BodyTag += "<TD align='Center''>" + FinalTestAmount + "</TD>";
            }
            else {
                BodyTag += "<TD align='Center''>" + UpdatedCount + "</TD>";
                BodyTag += "<TD align='Center''>" + UpdatedAmount + "</TD>";
            }
            BodyTag += "<TD align='Center'><input value = 'Delete' name='" + ID + "~" + name + "' onclick='btnDeleteBillingItems_OnClick(name);' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>";
            BodyTag += "</TR>";
            SNO++;
            UpdatedAmount = "";
            UpdatedDiscountValue = "";
            IsPopup = "";
        }

        document.getElementById('hdnTempTest').value += "]";
        FullTable = newPaymentTables + BodyTag + endTag;
        document.getElementById('divGrid').innerHTML = FullTable;

        document.getElementById('hdnOrdereditems').value = "";
        document.getElementById('ddSampleType').value = "0";
        document.getElementById('txtSampleCount').value = "";
        
        
        document.getElementById('txtDiscountValue').value = "";
        document.getElementById('ddlDiscountType').selectedIndex = "0";
        document.getElementById('ddSampleType').disabled = true;
        document.getElementById('txtSampleCount').disabled = true;
        document.getElementById('ddlDiscountType').disabled = true;
        
        document.getElementById('txtTestName').value = "";
        var grossvalue = document.getElementById('hdnGrossValue').value;
        grossvalue = parseFloat(grossvalue).toFixed(2);
        document.getElementById('txtGross').value = grossvalue;
        document.getElementById('txtNetAmount').value = grossvalue;
        document.getElementById('hdnDiscountAmt').value = document.getElementById('hdnGrossValue').value;
        if (document.getElementById('chkFoc').checked) {
            document.getElementById('ddDiscountPercent').disabled = true;
            document.getElementById('txtAuthorised').disabled = true;
            document.getElementById('ddlTaxPercent').disabled = true;

        }
        document.getElementById('ddDiscountPercent').disabled = false;
        document.getElementById('txtAuthorised').disabled = false;
        document.getElementById('ddlTaxPercent').disabled = false;
        document.getElementById('hdnGrossValue').value = "0";
        var TempDiscountDropDown = document.getElementById('ddDiscountPercent');
        var DiscountDropDown = TempDiscountDropDown.options[TempDiscountDropDown.selectedIndex].value;
        var TempTaxDropDown = document.getElementById('ddlTaxPercent');
        var TaxDropDown = TempTaxDropDown.options[TempTaxDropDown.selectedIndex].value;



        if (DiscountDropDown != "0") {
            SetQuotationDiscountAmt();


        }
        if (TaxDropDown != "0") {

            SetQuotationTaxAmt();

        }

        return false;
    }
    else {
        LoadTestTable();
        return false;

    }
}


function TestItemSelected(source, eventArgs) {


   var objAlert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
    var varGetVal = eventArgs.get_value();
    var arrGetVal = new Array();
    arrGetVal = varGetVal.split("^");
    document.getElementById('txtTestName').value = arrGetVal[1];
    //$('[id$="txtTestName"]').val(arrGetVal[1]);
    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var ID;
    var name;
    var feeType;
    var amount;
    var IsDicountableTest;
    var IsRepeatable;
    var Code;
    var IsOutSource;
    var outRInSourceLocation;
    var i;
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        if (list[i] != "") {
            ID = list[0];
            name = list[1].trim();
            feeType = list[2];
            Code = list[3];
            IsOutSource = list[4];
            outRInSourceLocation = list[5];
            document.getElementById('hdnID').value = ID;
            document.getElementById('hdnName').value = name;
            document.getElementById('hdnFeeTypeSelected').value = feeType;
            document.getElementById('hdnInvCode').value = Code;
            document.getElementById('hdnIsOutSource').value = IsOutSource;
            document.getElementById('hdnoutsourcelocation').value = outRInSourceLocation;

            var arrGotValue = new Array();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetBillingItemsDetails",
                data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: document.getElementById('hdnID').value, FeeType: document.getElementById('hdnFeeTypeSelected').value, Description: document.getElementById('txtTestName').value, ClientID: 0, VisitID: 0, Remarks: '', IsCollected: document.getElementById('hdnIsCollected').value, CollectedDatetime: document.getElementById('hdnCollectedDateTime').value, locationName: document.getElementById('hdnLocName').value }),
                dataType: "json",
                async: false,
                success: function(data, value) {
                    if (data.d.length > 0) {

                        // var GetData[] = (data.d[0]);
                        //  var lstClientDetails = data.d[0].Second;
                        arrGotValue = data.d[0].ProcedureName.split('^');
                        if (arrGotValue.length > 0) {

                            if (arrGotValue[3] < 0 || arrGotValue[3] == 0) {

                                //alert('hi');
                                ValidationWindow("Rate of the item is zero.", objAlert);
                                document.getElementById('txtTestName').value = "";
                                return false;


                            }


//                            if (arrGotValue[27] != "") {

//                                document.getElementById('ddSampleType').value = arrGotValue[27];

//                            }
//                            else {

//                                document.getElementById('ddSampleType').value = "0";
//                            
//                            }
                            document.getElementById('hdnOrdereditems').value = arrGotValue;
                            if (document.getElementById('hdnOrdereditems').value == "") {


                                ValidationWindow("Please select item from List", objAlert);
                            
                            
                            }
                            document.getElementById('ddSampleType').disabled = false;
                            document.getElementById('txtSampleCount').disabled = false;
                            document.getElementById('ddlDiscountType').disabled = false;
                            
                        }
                       
                        
                        
                    }
                },
                error: function(result) {
                    var objSelClient = SListForAppMsg.Get("Scripts_CommonBiling_js_10") == null ? "Select the Testname From List" : SListForAppMsg.Get("Scripts_CommonBiling_js_10");
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    ValidationWindow(objSelClient, objAlert);

                    //alert("Select the ClientName From List");
                }




            });



        }
    }
}

function btnDeleteBillingItems_OnClick(sEditedData) {
    objname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_11") == null ? "This test cannot be deleted, since status of the quotation is pending" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_11");
    objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");


    var TempsEditedData = sEditedData.split("~");
    var Strhidden;
    var Strvalue;
    var main;
    if (document.getElementById('hdnTestQuotationList').value == "") {
        Strvalue = document.getElementById('hdnAppendTest').value.split("|");


        for (main = 0; main < Strvalue.length; main++) {
            Strhidden = Strvalue[main].split(",");
            if ((Strhidden[0]) == (TempsEditedData[0])) {

                Strvalue[main] = "";


            }


        }


        TempsEditedData = "";
        for (main = 0; main < Strvalue.length; main++) {
            if (Strvalue[main] != "") {
                TempsEditedData += Strvalue[main] + "|";

            }


        }

        document.getElementById('hdnAppendTest').value = TempsEditedData;
       

         Strvalue = document.getElementById('hdnPKGUpdateList').value.split('%');
      //  Strvalue = document.getElementById('hdnAppendTest').value.split("|");


        for (main = 0; main < Strvalue.length; main++) {
           // Strhidden = Strvalue[main].split(",");
            var Dummysplit = Strvalue[main].split('^');
            var ListID = Dummysplit[0].split('~');
            if (((ListID[0]) == (sEditedData.split("~")[0]))) {

                Strvalue[main] = "";


            }


        }


        TempsEditedData = "";
        for (main = 0; main < Strvalue.length; main++) {
            if (Strvalue[main] != "") {
                TempsEditedData += Strvalue[main] + "%";

            }


        }

        document.getElementById('hdnPKGUpdateList').value = TempsEditedData;


        Strvalue = document.getElementById('hdnPKGMasterUpdatelist').value.split('%');
        //  Strvalue = document.getElementById('hdnAppendTest').value.split("|");


        for (main = 0; main < Strvalue.length; main++) {
            // Strhidden = Strvalue[main].split(",");
            var Dummysplit = Strvalue[main].split('^');
            var ListID = Dummysplit[0].split('~');
            if (((ListID[0]) == (sEditedData.split("~")[0]))) {

                Strvalue[main] = "";


            }


        }


        TempsEditedData = "";
        for (main = 0; main < Strvalue.length; main++) {
            if (Strvalue[main] != "") {
                TempsEditedData += Strvalue[main] + "%";

            }


        }
        document.getElementById('hdnPKGMasterUpdatelist').value = TempsEditedData;

        AddItems();


        SetQuotationDiscountAmt();
        SetQuotationTaxAmt();
    }
    else {
        var StrHistory;
        var History = document.getElementById('hdnTestHistory').value.split("|");
        for (main = 0; main < History.length; main++) {
            StrHistory = History[main].split("~");
            if ((StrHistory[0]) == (TempsEditedData[0])) {
                ValidationWindow(objname, objalert);

                //alert("This Test Cannot be deleted");

                return false;


            }
        }


        Strvalue = document.getElementById('hdnTestQuotationList').value.split("|");






        for (main = 0; main < Strvalue.length; main++) {
            Strhidden = Strvalue[main].split("~");
            if ((Strhidden[0]) == (TempsEditedData[0])) {

                Strvalue[main] = "";


            }


        }

        TempsEditedData = "";
        for (main = 0; main < Strvalue.length; main++) {
            if (Strvalue[main] != "") {
                TempsEditedData += Strvalue[main] + "|";

            }


        }

        document.getElementById('hdnTestQuotationList').value = TempsEditedData;
        document.getElementById('hdnOrdereditems').value = "";
        LoadTestTable();
        SetQuotationDiscountAmt();
        SetQuotationTaxAmt();
    }









}

function SetQuotationDiscountAmt() {





    document.getElementById('ddlDiscountReason').disabled = false;
    var TempDiscountPercent = document.getElementById('ddDiscountPercent');

    var DiscountPercent = TempDiscountPercent.options[TempDiscountPercent.selectedIndex].value;


    var TempDiscountid = DiscountPercent.split("~");

    var TempDiscountpercentvalue = TempDiscountid[0];
    var Discountpercentvalue = parseFloat(TempDiscountpercentvalue).toFixed(2);

    document.getElementById('hdnDiscountPercent').value = Discountpercentvalue;


    var Discountid = TempDiscountid[1];



    var GrossAmt = document.getElementById('hdnDiscountAmt').value;
    //var GrossAmt = $("#txtgross").val();
    var TotalDiscountPercent = "";

    if (GrossAmt != "") {


        TotalDiscountPercent = parseFloat((GrossAmt * Discountpercentvalue) / 100).toFixed(2);

        document.getElementById('hdnTotalDiscount').value = TotalDiscountPercent;
        FinalNetCalculations();



        //document.getElementById('txtDiscount').value = TotalDiscountPercent;



    }
    else {

        //alert("HI");


    }



}

function SetQuotationTaxAmt() {


    var GrossAmt = document.getElementById('hdnDiscountAmt').value;

    var TempTaxAmt = document.getElementById('ddlTaxPercent');

    var TaxPercent = TempTaxAmt.options[TempTaxAmt.selectedIndex].value;

    var NetAmt;


    var TaxAmt;
    TaxAmt = parseFloat(GrossAmt * TaxPercent / 100).toFixed(2);
    document.getElementById('txtTax').value = TaxAmt;

    document.getElementById('hdnTaxAmount').value = TaxAmt;


    FinalNetCalculations();






    //document.getElementById('txtNetAmount').value = NetAmt;






}

function FinalNetCalculations() {



    var Grossamount = document.getElementById('hdnDiscountAmt').value;
    Grossamount = parseFloat(Grossamount).toFixed(2);
    var DefaultRound = ToInternalFormat($('#hdnDefaultRoundoff'));
    var roundOffAmt = "";

    var DiscountAmount = document.getElementById('hdnTotalDiscount').value;
    if (DiscountAmount != "") {
        DiscountAmount = parseFloat(DiscountAmount).toFixed(2);
    }
    var Finalnetamount = "";
    var FinalTaxnetamount = "";
    if (DiscountAmount == "") {
        DiscountAmount = "0";
    }
    var TaxAmount = document.getElementById('hdnTaxAmount').value;
    TaxAmount = parseFloat(TaxAmount).toFixed(2);
    if (TaxAmount == "") {
        TaxAmount = "0";
    }

    FinalTaxnetamount = parseFloat(Grossamount) + parseFloat(TaxAmount);
    Finalnetamount = FinalTaxnetamount - DiscountAmount;
    if (Number(Finalnetamount) - Number(getOPCustomRoundoff(Finalnetamount.toFixed(2))) > 0)
        roundOffAmt = Number(Finalnetamount).toFixed(2) - Number(getOPCustomRoundoff(Finalnetamount)).toFixed(2);
    else
        roundOffAmt = Number(getOPCustomRoundoff(Finalnetamount)).toFixed(2) - Number(Finalnetamount).toFixed(2);

    // roundOffAmt = (Number(getOPCustomRoundoff(Finalnetamount)) - Number(Finalnetamount));
    Finalnetamount = parseFloat(Finalnetamount).toFixed(2);
    roundOffAmt = parseFloat(roundOffAmt).toFixed(2);
    document.getElementById('txtNetAmount').value = getOPCustomRoundoff(Finalnetamount);

    document.getElementById('txtRoundoffAmt').value = roundOffAmt;


    // document.getElementById('txtNetAmount').value = Finalnetamount.toFixed(2);



}
function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {

    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vCheck = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_48') == null ? "Please check,'" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_48');
    var vEmailAddress = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_49') == null ? "'email address is not valid!" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_49');
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {

                    ValidationWindowEmail('Please enter a valid EmailId', AlertType);

                    return false;
                }
            }
        }
    }
    CheckEmailSend();
    return true;
}

function EnableDiscountValue() {

    if (document.getElementById('ddlDiscountType').selectedIndex == "0") {

        document.getElementById('txtDiscountValue').disabled = true;
    }
    else {

        document.getElementById('txtDiscountValue').disabled = false;
    }




}
function onchangeState() {
    $('#hdnPatientStateID').val($('#ddState').val());
    $('#hdnPatientStateID1').val($('#ddState1').val());
}
function loadState(obj) {

    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
    if (obj != 0) {
        $("select[id$=ddState] > option").remove();
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetStateByCountry",
            data: "{ 'CountryID': '" + parseInt($('#ddCountry').val()) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;

                $('#ddState').attr("disabled", false);
                // $('#ddState').append('<option value="-1">--Select--</option>');
                $('#ddState').append('<option value="-1">' + objSelect + '</option>');
                $.each(Items, function(index, Item) {
                    $('#ddState').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
                    $('#lblCountryCode').html("+" + Item.ISDCode);
                    // document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
                });
                if (obj != "0") {
                    if (Number($('#hdnPatientID').val()) > 0 && Number($('#hdnPatientStateID').val()) > 0) {
                        $('#ddState').val($('#hdnPatientStateID').val());
                    }
                    else {
                        onchangeState();
                    }
                }
                else {
                    $('#ddState').val($('#hdnDefaultStateID').val());
                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    else {
        document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
        document.getElementById('ddState').value = document.getElementById('hdnDefaultStateID').value;
    }
}


function SelectedQuotationNumber(source, eventArgs) {

    //debugger;
    var QuotationNo = eventArgs.get_value().split('~')[0];
    var QuotationID = eventArgs.get_value().split('~')[1];  
    document.getElementById('hdnSelectedQuotationID').value = QuotationID;
    document.getElementById('hdnSelectedQuotationNo').value = QuotationNo;
    var ClientID = eventArgs.get_value().split('~')[2];
    document.getElementById('hdnClientID').value = ClientID;
    var PermanentDetails, TempDetails;
    var Orgid = document.getElementById('hdnOrgID').value;
    var Type = "";
    var SampleType = "";
    
    if (document.getElementById('hdnRegPageType').value != "") {
        Type = document.getElementById('hdnRegPageType').value;
        SampleType = eventArgs.get_value().split('~')[3];
    }
    else {

        Type = "";
    
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetQuotationNumberDetails",
        data: JSON.stringify({ QuotationID: QuotationID, ClientID: ClientID, Orgid: Orgid, Type: Type, SampleType: SampleType }),
        dataType: "json",
        async: false,
        success: function(data, value) {
            //            var GetData = JSON.parse(data.d[0]);
            //            var lstClientDetails = GetData.Second;
            if (document.getElementById('hdnRegPageType').value != "REG") {
                var TempGetData = JSON.parse(data.d[0]);
                var GetData = TempGetData.Second;
                var PreTestlist = JSON.parse(data.d[1]);
                var Testlist = PreTestlist.Second;
                var TempAmountDetails = JSON.parse(data.d[2]);
                var AmountDetails = TempAmountDetails.Second;
                var TempWaters = JSON.parse(data.d[3]);
                var TempAddrs = JSON.parse(data.d[4]);
                var TempAddrsDetails = TempAddrs.Second;
                var Waters = TempWaters.Second;
                var waterDetails = Waters.split('~');
                var Details = AmountDetails.split(',');
                var ClientDetails = GetData.split('~');
                document.getElementById('txtClientName').value = ClientDetails[0];
                document.getElementById('txtAddress').value = ClientDetails[1];
                document.getElementById('txtCity').value = ClientDetails[2];
                document.getElementById('txtEmailID').value = ClientDetails[3];
                document.getElementById('txtTelephoneNo').value = ClientDetails[4];
                document.getElementById('txtMobileNo').value = ClientDetails[5];
                if (ClientDetails[6] != "") {
                    document.getElementById('txtSuburb').value = ClientDetails[6];
                }
                if (ClientDetails[7] != "0") {
                    document.getElementById('txtPincode').value = ClientDetails[7];
                }
                if (ClientDetails[12] == "N") {
                    document.getElementById("chkSameAddress").checked = false;
                    $("#trSameBIllingAddrOne").attr("style", "display:table-row");
                    $("#trSameBIllingAddrTwo").attr("style", "display:table-row");


                }
                else if (ClientDetails[12] == "Y") {

                    document.getElementById("chkSameAddress").checked = true;
                    $("#trSameBIllingAddrOne").attr("style", "display:none");
                    $("#trSameBIllingAddrTwo").attr("style", "display:none");


                }
                document.getElementById("chkSameAddress").disabled = true;

                var dateFrom = ClientDetails[15];
                var dateTo = ClientDetails[13];
                var dateCheck = document.getElementById('hdnCurrentDate').value;

                var d1 = dateFrom.split("/");
                var d2 = dateTo.split("/");
                var c = dateCheck.split("/");

                var from = new Date(d1[2], d1[1] - 1, d1[0]);  // -1 because months are from 0 to 11
                var to = new Date(d2[2], d2[1] - 1, d2[0]);
                var check = new Date(c[2], c[1] - 1, c[0]);
                //            if (day <= mday && month <= mmonth && year <= myear)
                if (check >= from && check <= to) {

                    document.getElementById('txtValidityPeriod').value = ClientDetails[13];
                    document.getElementById('txtValidityPeriod').disabled = true;
                    document.getElementById('hdnIsExpired').value = "N";
                    //  $('#btnFinish').val('Update Quotation');
                    $("#btnFinish").prop('value', 'Update Quotation');
                    document.getElementById('FileUpload1').disabled = true;
                    document.getElementById('chkEmail').disabled = true;
                    document.getElementById('chkSMS').disabled = true;
                }
                else {
                    document.getElementById('txtValidityPeriod').value = document.getElementById('hdnFutureDate').value;
                    document.getElementById('txtValidityPeriod').disabled = false;
                    document.getElementById('hdnIsExpired').value = "Y";
                    document.getElementById('FileUpload1').disabled = false;
                }
                if (ClientDetails[16] == 'Rejected') {
                    document.getElementById('txtValidityPeriod').value = document.getElementById('hdnFutureDate').value;
                    document.getElementById('txtValidityPeriod').disabled = false;
                    document.getElementById('hdnIsExpired').value = "Y";
                    $("#btnFinish").prop('value', 'Generate Quotation');
                }

                document.getElementById('hdnSelectedClientClientID').value = ClientDetails[14];

                document.getElementById('txtAddress1').value = TempAddrsDetails.split('~')[0];
                document.getElementById('txtCity1').value = TempAddrsDetails.split('~')[1];



                if (TempAddrsDetails.split('~')[6] != "") {
                    document.getElementById('txtSuburb1').value = TempAddrsDetails.split('~')[5];
                }
                if (TempAddrsDetails.split('~')[7] != "") {
                    document.getElementById('txtPincode1').value = TempAddrsDetails.split('~')[6];
                }
                document.getElementById('ddState1').value = TempAddrsDetails.split('~')[7];
                document.getElementById('ddCountry1').value = TempAddrsDetails.split('~')[8];
                if (ClientDetails[8] != '') {
                    if (document.getElementById('ddlClientSource') != null) {
                        document.getElementById('ddlClientSource').value = ClientDetails[8];
                    }
                }

                document.getElementById('txtOthers').value = ClientDetails[9];
                document.getElementById('ddCountry').value = ClientDetails[11];
                document.getElementById('hdnPatientStateID').value = ClientDetails[10];
                document.getElementById('ddState').value = ClientDetails[10];

                document.getElementById('hdnPatientID').value = "1";
                if (ClientDetails[10] == "") {
                    loadState("11");
                }

                if (Details[2] != '') {
                    if (document.getElementById('ddDiscountPercent') != null) {
                        document.getElementById('ddDiscountPercent').disabled = false;
                        document.getElementById('ddDiscountPercent').value = Details[2];
                    }
                }

                if (Details[3] != '') {
                    document.getElementById('ddlTaxPercent').disabled = false;
                    if (document.getElementById('ddlTaxPercent') != null) {
                        $("#ddlTaxPercent option:selected").text(Details[3]);
                    }
                }
                document.getElementById('txtTax').value = Details[4];
                document.getElementById('txtNetAmount').value = Details[5];
                document.getElementById('txtGross').value = Details[6];
                document.getElementById('hdnGrossValue').value = Details[6];
                document.getElementById('hdnDiscountAmt').value = Details[6];
                document.getElementById('txtSalesPerson').value = waterDetails[0];
                document.getElementById('txtBranch').value = waterDetails[1];
                document.getElementById('txtRemarks').value = waterDetails[2];
                if (waterDetails[3] == "Y") {
                    document.getElementById('chkSMS').Checked = true;

                }
                if (waterDetails[4] == "Y") {
                    document.getElementById('chkEmail').Checked = true;

                }



                var TempDetails = ClientDetails[1];


                document.getElementById('hdnTestQuotationList').value = Testlist;
                document.getElementById('hdnLoadPkgID').value = Testlist;
                document.getElementById('hdnTestHistory').value = Testlist;
                document.getElementById('txtClientName').disabled = true;
                document.getElementById('txtAddress').disabled = true;
                document.getElementById('txtCity').disabled = true;
                document.getElementById('txtEmailID').disabled = true;
                document.getElementById('txtTelephoneNo').disabled = true;
                document.getElementById('txtMobileNo').disabled = true;
                document.getElementById('txtSuburb').disabled = true;
                document.getElementById('txtPincode').disabled = true;
                document.getElementById('ddCountry').disabled = true;
                document.getElementById('ddState').disabled = true;
                document.getElementById('ddlClientSource').disabled = true;
                document.getElementById('txtOthers').disabled = true;
                document.getElementById('txtSalesPerson').disabled = true;
                document.getElementById('txtBranch').disabled = true;
                document.getElementById('txtRemarks').disabled = true;


                if (document.getElementById('chkSameAddress').checked == false) {


                    document.getElementById('txtCity1').disabled = true;
                    document.getElementById('txtAddress1').disabled = true;
                    document.getElementById('txtSuburb1').disabled = true;
                    document.getElementById('txtPincode1').disabled = true;
                    document.getElementById('ddCountry1').disabled = true;
                    document.getElementById('ddState1').disabled = true;


                }

                if (Details[0] == "Y") {
                    // $('#chkFoc').prop("checked") == true;
                    document.getElementById('chkFoc').checked = true;
                    $("#txtFoc").prop('disabled', false);
                    $("#txtTax").prop('disabled', true);
                    $("#ddDiscountPercent").prop('disabled', true);
                    $("#ddlDiscountReason").prop('disabled', true);
                    $("#txtAuthorised").prop('disabled', true);
                    $("#ddlTaxPercent").prop('disabled', true);
                    $("#txtGross").prop('disabled', true);
                    $("#txtTax").prop('disabled', true);
                    $("#txtRoundoffAmt").prop('disabled', true);
                    $("#txtNetAmount").prop('disabled', true);

                    document.getElementById('txtFoc').value = Details[1];



                }

            }

            else {

                var TempGetData = JSON.parse(data.d[0]);
                var GetData = TempGetData.Second;
                document.getElementById('hdnSelectedClientDetails').value = GetData;
                var PreTestlist = JSON.parse(data.d[1]);
                var Testlist = PreTestlist.Second;
                //var CollectedDate = Testlist.split('~');
                var QuotationBill = JSON.parse(data.d[2]);
                var IndividualQuotationBill = QuotationBill.Second;
                var TempAmountDetails = JSON.parse(data.d[3]);
                var AmountDetails = TempAmountDetails.Second;
                var TempAmountDetails = JSON.parse(data.d[3]);
                var AmountDetails = TempAmountDetails.Second;
                var TempOrderedInvestigationDetails = JSON.parse(data.d[4]);
                var OrderedInvestigationDetails = TempOrderedInvestigationDetails.Second;

                loadRegClientDetails();

//                var RegQuotationDetails = GetData.split('~');
//                document.getElementById('txtClient').value = RegQuotationDetails[0];
//                document.getElementById('txtRegAddress').value = RegQuotationDetails[1];
//                document.getElementById('txtRegCity').value = RegQuotationDetails[2];
//                document.getElementById('ddState').value = RegQuotationDetails[3];
//                document.getElementById('ddCountry').value = RegQuotationDetails[4];
//                document.getElementById('txtRegCollectedTime').value = document.getElementById('hdnDate').value;
//                document.getElementById('ddlClientName').value = RegQuotationDetails[7];


//                document.getElementById('hdnSelectedClientID').value = RegQuotationDetails[7];


                var CollecteddTime = OrderedInvestigationDetails.split('|');

                var CrtCollectedTime = CollecteddTime[0].split('~');

                document.getElementById('txtRegCollectedTime').value = CrtCollectedTime[9];

                if (IndividualQuotationBill.split(',')[0] == "Y") {



                }

                else {


                }

                document.getElementById('billPart_ddDiscountPercent').value = IndividualQuotationBill.split(',')[2];
                // document.getElementById('billPart_ddlTaxPercent').value = IndividualQuotationBill.split(',')[3];

                //                if (IndividualQuotationBill.split(',')[3] != "0") {

                //                     $("#billPart_ddlTaxPercent option:selected").text(IndividualQuotationBill.split(',')[3]);
                //                }
                document.getElementById('billPart_txtTax').value = IndividualQuotationBill.split(',')[4];

                document.getElementById('billPart_hdnNetAmount').value = IndividualQuotationBill.split(',')[5];
                document.getElementById('billPart_txtNetAmount').value = document.getElementById('billPart_hdnNetAmount').value;
                //document.getElementById('hdnNetAmount').value = document.getElementById('billPart_hdnNetAmount').value;

                //document.getElementById('billPart_hdnDue').value = IndividualQuotationBill.split(',')[5];
                //document.getElementById('billPart_txtDue').value = document.getElementById('billPart_hdnDue').value;
                document.getElementById('HdnCoPay').value = '';
                document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = IndividualQuotationBill.split(',')[5];
                document.getElementById('billPart_PaymentType_txtAmount').value = IndividualQuotationBill.split(',')[5];
                //document.getElementById('<%= billPart_PaymentType_txtAmount.ClientID %>').value = IndividualQuotationBill.split(',')[5];
                document.getElementById('billPart_txtDiscount').value = IndividualQuotationBill.split(',')[7];
                if (IndividualQuotationBill.split(',')[7] != "0") {
                    document.getElementById('billPart_hdnDiscountableTestTotal').value = IndividualQuotationBill.split(',')[7];
                } else
                { document.getElementById('billPart_hdnDiscountableTestTotal').value = "0"; }
                document.getElementById('billPart_txtRoundoffAmt').value = IndividualQuotationBill.split(',')[8];
                document.getElementById('txtRegSalesPerson').value = AmountDetails.split('~')[0];
                document.getElementById('txtRegBranch').value = AmountDetails.split('~')[1];
                if (OrderedInvestigationDetails != "") {

                    document.getElementById('hdnAppendTest').value = OrderedInvestigationDetails;

                }
               

                document.getElementById('hdnTestQuotationList').value = Testlist;
                // document.getElementById('QuotationDetails').disabled = true;
                // $("#QuotationDetails").attr('disabled', true);
                // $("#QuotationDetails").prop('disabled', true);


            }



//            document.getElementById('txtQuotationNo').readOnly = true;
//            document.getElementById('ddlClientName').disabled = true;
//            document.getElementById('txtRegAddress').readOnly = true;
//            document.getElementById('txtRegCity').readOnly = true;
//            document.getElementById('ddState').disabled = true;
//            document.getElementById('ddCountry').disabled = true;
//            document.getElementById('txtRegCollectedTime').readOnly = true;
//            document.getElementById('txtRegSalesPerson').readOnly = true;
//            document.getElementById('txtRegBranch').readOnly = true;
//            // document.getElementById('txtRegBranch').readOnly = true;
//            document.getElementById('chkRegEmail').disabled = true;
//            document.getElementById('chkRegSMS').disabled = true;
//            document.getElementById('FileUpload1').disabled = true;




        }

    });



    LoadTestTable();


}


function loadTempState(obj) {

    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
    if (obj != 0) {
        $("select[id$=ddState1] > option").remove();
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetStateByCountry",
            data: "{ 'CountryID': '" + parseInt($('#ddCountry1').val()) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;

                $('#ddState1').attr("disabled", false);
                // $('#ddState').append('<option value="-1">--Select--</option>');
                $('#ddState1').append('<option value="-1">' + objSelect + '</option>');
                $.each(Items, function(index, Item) {
                    $('#ddState1').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
                    $('#lblCountryCode').html("+" + Item.ISDCode);
                    // document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
                });
                if (obj != "0") {
                    if (Number($('#hdnPatientID').val()) > 0 && Number($('#hdnPatientStateID').val()) > 0) {
                        $('#ddState1').val($('#hdnPatientStateID').val());
                    }
                    else {
                        onchangeState();
                    }
                }
                else {
                    $('#ddState1').val($('#hdnDefaultStateID').val());
                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    else {
        document.getElementById('ddCountry1').value = document.getElementById('hdnDefaultCountryID').value;
        document.getElementById('ddState1').value = document.getElementById('hdnDefaultStateID').value;
    }
}

function LoadTestTable() {


   // debugger;



    var i = 0;
    var arrMain = new Array();
    var arrsub = new Array();
    var DiscountAmt = "";
    var IsPopup = "";
    if (document.getElementById('hdnRegPageType').value != "REG") {
        document.getElementById('hdnLoadNewTestID').value = "";
        document.getElementById('hdnGrossValue').value = "0";
    }
    var imain;
    var MainPkg, MainSubPkg;
    var TempPKGID, TempPKGName, TempPKGType;
    
    var ID, name, feeType, amount, SampleType, SampleCount, DiscountValue, DiscountType;
    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "", FinalTestAmount;
    var SNO = 1;
    var Type;
    var HiddenFieldArray = new Array();
    var UpdatedAmount = "", UpdatedDiscountValue = "", UpdatedCount = "", UpdatedDefaultAmt = 0, UpdatedDiscountCount = "";
    var iMain, NewSubList, TempHistory;
    var vSno = SListForAppMsg.Get('Waters_QuotationMaster_aspx_01') == null ? "S.NO" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_01');
    var vTestName = SListForAppMsg.Get('Waters_QuotationMaster_aspx_02') == null ? "Test Name" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_02');
    var vSampleName = SListForAppMsg.Get('Waters_QuotationMaster_aspx_03') == null ? "Sample Type" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_03');
    var vSampleCount = SListForAppMsg.Get('Waters_QuotationMaster_aspx_04') == null ? "Sample Count" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_04');
    var vAmount = SListForAppMsg.Get('Waters_QuotationMaster_aspx_05') == null ? "Amount" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_05');
    var vAction = SListForAppMsg.Get('Waters_QuotationMaster_aspx_06') == null ? "Action" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_06');
    var Newtest="", TempID, Tempname, TempfeeType, TempSampleType, TempSampleCount, TempDiscountType, TempDiscountValue, Tempamount;
    startHeaderTag = "<table id='waters1' width='60%' Class='gridView'  border='1px;' cellpadding='0' cellspacing='0'>";
    if (document.getElementById('hdnRegPageType').value != 'REG') {
        startHeaderTag += "<tr class='dataheader1'><th style='width:1%;'>" + vSno + "</th><th style='width:1%;'>" + vTestName + "</th><th style='width:1%;'>" + vSampleName + "</th><th style='width:1%;'>" + vSampleCount + "</th><th style='width:1%;'>" + vAmount + "</th><th style='width:1%;'>" + vAction + "</th></tr>";
    }
    else {
        startHeaderTag += "<tr class='dataheader1'><th style='width:1%;'>" + vSno + "</th><th style='width:1%;'>" + vTestName + "</th><th style='width:1%;'>" + vSampleName + "</th><th style='width:1%;'>" + vSampleCount + "</th><th style='width:1%;'>" + vAmount + "</th></tr>";
    }
    newPaymentTables = startHeaderTag;
    endTag = "</table>";
    if (document.getElementById('hdnOrdereditems').value != "") {
        Newtest = document.getElementById('hdnOrdereditems').value.split(",");
    }
    if (Newtest != "") {
        TempID = Newtest[0];
        document.getElementById('hdnLoadNewTestID').value = TempID;
        Tempname = Newtest[1].trim();
        TempfeeType = Newtest[2];
        Tempamount = Newtest[3];
        document.getElementById('hdnNewAmount').value += TempID + '~' + Tempamount + '|';
        TempSampleType = Newtest[27];
        TempSampleCount = Newtest[28];
        TempDiscountValue = Newtest[29];
        TempDiscountType = Newtest[30];


        if (TempDiscountType == "PERCENTAGE") {

            FinalTestAmount = parseFloat((Tempamount * TempDiscountValue) / 100).toFixed(2);
            DiscountAmt = FinalTestAmount;
            FinalTestAmount = Tempamount - FinalTestAmount;
            FinalTestAmount = TempSampleCount * FinalTestAmount;
            FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
            // document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);

        }
        else if (TempDiscountType == "VALUE") {


        FinalTestAmount = TempSampleCount * Tempamount;
        FinalTestAmount = parseFloat(FinalTestAmount - TempDiscountValue).toFixed(2);
         DiscountAmt = TempDiscountValue;
            FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);

            // document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);

        }

        else {
            FinalTestAmount = parseFloat(Tempamount * TempSampleCount).toFixed(2);
            DiscountAmt = 0;
            FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
            // document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);


        }

        if (TempDiscountValue == "") {

            TempDiscountValue = 0;
        }


        NewSubList = TempID + '~' + Tempname + '~' + TempfeeType + '~' + TempSampleType + '~' + TempSampleCount + '~' + TempDiscountType + '~' + TempDiscountValue + '~' + FinalTestAmount + '~' + DiscountAmt + '~';

        TempHistory = document.getElementById('hdnTestQuotationList').value.split("|");
        if (TempHistory.length > 1 && document.getElementById('hdnOrdereditems').value != "") {


            for (main = 0; main < TempHistory.length; main++) {
                TempCurrent = TempHistory[main].split("~");
                var TempNewSubList = NewSubList.split("~");
                if ((TempCurrent[0]) == (TempNewSubList[0])) {

                    alert("The test has been already ordered");




                    NewSubList = "";


                    document.getElementById('hdnOrdereditems').value = "";
                    document.getElementById('hdnOrdereditems').value = "";
                    document.getElementById('ddSampleType').value = "0";
                    document.getElementById('txtSampleCount').value = "";
                    document.getElementById('txtDiscountValue').value = "";
                    document.getElementById('ddlDiscountType').selectedIndex = "0";
                    document.getElementById('txtTestName').value = "";
                    document.getElementById('hdnGrossValue').value = "0";

                    return false;
                }
            }






        }
        document.getElementById('hdnAppendTest').value = document.getElementById('hdnAppendTest').value + NewSubList + '|';
        document.getElementById('hdnTestQuotationList').value = document.getElementById('hdnTestQuotationList').value + NewSubList + '|';

    }
    if (document.getElementById('hdnRegPageType').value != "REG") {

        document.getElementById('hdnTempTest').value = "";
        document.getElementById('hdnTempTest').value = '[';

        if (document.getElementById('hdnIsExpired').value == "N") {
            arrMain = document.getElementById('hdnAppendTest').value.split("|");
        }
        else if (document.getElementById('hdnIsExpired').value == "Y") {

            var ForamountUpdatebasedOncrrdate = new Array();    //This Section of code is for Retriving the amount of test based on current date in case of expired Quotation
            var SubForamountUpdatebasedOncrrdate = new Array();

            ForamountUpdatebasedOncrrdate = document.getElementById('hdnTestQuotationList').value.split("|");


            document.getElementById('hdnTestQuotationList').value = "";
            for (iMain = 0; iMain < ForamountUpdatebasedOncrrdate.length - 1; iMain++) {

                arrsub = ForamountUpdatebasedOncrrdate[iMain].split("~");
                ID = arrsub[0];
                name = arrsub[1].trim();
                feeType = arrsub[2];
                SampleType = arrsub[3];
                SampleCount = arrsub[4];
                DiscountType = arrsub[5];
                DiscountValue = arrsub[6];
                amount = arrsub[7];

                if (DiscountType == 'PERCENTAGE') {
                    FinalTestAmount = parseFloat((amount * DiscountValue) / 100).toFixed(2);
                    DiscountAmt = FinalTestAmount;
                    FinalTestAmount = amount - FinalTestAmount;
                    FinalTestAmount = SampleCount * FinalTestAmount;
                    FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
                    arrsub[7] = FinalTestAmount;

                }


                else if (DiscountType == "VALUE") {


                    FinalTestAmount = SampleCount * amount;
                    FinalTestAmount = parseFloat(FinalTestAmount - DiscountValue).toFixed(2);
                    DiscountAmt = DiscountValue;
                    FinalTestAmount = parseFloat(FinalTestAmount).toFixed(2);
                    arrsub[7] = FinalTestAmount;

                    // document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(FinalTestAmount);

                }

                document.getElementById('hdnTestQuotationList').value = document.getElementById('hdnTestQuotationList').value + arrsub[0]+'~'+ arrsub[1]+'~'+ arrsub[2]+'~' + arrsub[3]+'~' + arrsub[4]+'~'+ arrsub[5]+'~'+ arrsub[6]+'~'+ arrsub[7]+'|';

            }







            arrMain = document.getElementById('hdnTestQuotationList').value.split("|");

        }

        for (iMain = 0; iMain < arrMain.length - 1; iMain++) {

            arrsub = arrMain[iMain].split("~");
            ID = arrsub[0];
            name = arrsub[1].trim();
            feeType = arrsub[2];
            SampleType = arrsub[3];
            SampleCount = arrsub[4];
            DiscountType = arrsub[5];
            DiscountValue = arrsub[6];
            amount = arrsub[7];
            if (document.getElementById('hdnPKGUpdateList').value != "") {
                var UpdateList = document.getElementById('hdnPKGUpdateList').value.split('%');

                for (UpdateMain = 0; UpdateMain < UpdateList.length; UpdateMain++) {

                    var UpdateListID = UpdateList[UpdateMain].split('^');
                    var ListID = UpdateListID[0].split('~');
                    if ((ListID[0]) == ID) {
                        document.getElementById('hdnLoadNewTestID').value = ListID[0];
                        document.getElementById('hdnPKGList').value = UpdateListID[1];
                        UpdatedAmount = ListID[1];
                        UpdatedDiscountValue = ListID[2];
                        UpdatedCount = ListID[3];
                        UpdatedDefaultAmt = ListID[4];
                        UpdatedDiscountCount = ListID[5];
                        //document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(UpdatedAmount);

                    }



                }

                if (UpdatedAmount != "" && UpdatedDiscountValue != "") {
                    IsPopup = "Y";

                }



            }


            if (feeType == "PKG") {

                if (ID != undefined && feeType != undefined && IsPopup != "Y") {
                    Type = feeType;
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/GetPKGQuotationDetails",
                        data: "{ 'ID': '" + ID + "','Type': '" + Type + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var Items = data.d;
                            var i = 0;
                            $.each(Items, function(index, Item) {
                                document.getElementById('hdnPKGList').value += Item.InvestigationID + '~' + Item.InvestigationName + '~' +
		Item.Name + '|';


                            });


                        },
                        failure: function(msg) {
                            ShowErrorMessage(msg);
                        }

                    });
                }

                MainPkg = document.getElementById('hdnPKGList').value.split("|");

                for (imain = 0; imain < MainPkg.length - 1; imain++) {

                    MainSubPkg = MainPkg[imain].split("~");
                    TempPKGID = MainSubPkg[0];
                    TempPKGName = MainSubPkg[1];
                    TempPKGType = MainSubPkg[2];
                    if (document.getElementById('hdnLoadNewTestID').value == ID && feeType == "PKG" && IsPopup == "Y") {
                        HiddenFieldArray += '{' + '"ID":' + TempPKGID + ',' + '"Name":' + '"' + TempPKGName + '"' + ',' + '"Type":' + '"' + TempPKGType + '"' + ', "SampleType":' + '"' + SampleType + '"' + ', "SampleCount":' + UpdatedCount + ', "DiscountValue":' + '"' + UpdatedDiscountValue + '"' + ', "DiscountType":' + '"' + DiscountType + '"' + ',"Amount":' + '"' + UpdatedAmount + '"' + ', "status":' + '"Pending"' + ',"PkgID":' + '"' + ID + '"' + ', "PkgName":' + '"' + name + '"' + ',"AccessionNumber":' + '"0"' + '}';

                    }
                    else {

                        HiddenFieldArray += '{' + '"ID":' + TempPKGID + ',' + '"Name":' + '"' + TempPKGName + '"' + ',' + '"Type":' + '"' + TempPKGType + '"' + ', "SampleType":' + '"' + SampleType + '"' + ', "SampleCount":' + SampleCount + ', "DiscountValue":' + '"' + DiscountValue + '"' + ', "DiscountType":' + '"' + DiscountType + '"' + ',"Amount":' + '"' + amount + '"' + ', "status":' + '"Pending"' + ',"PkgID":' + '"' + ID + '"' + ', "PkgName":' + '"' + name + '"' + ',"AccessionNumber":' + '"0"' + '}';
                    }
                    if (imain < MainPkg.length - 2) {

                        HiddenFieldArray += ',';
                    }
                    else if (iMain < arrMain.length - 2) {

                        HiddenFieldArray += ',';
                    }

                }






            }

            else {

                HiddenFieldArray += '{' + '"ID":' + ID + ',' + '"Name":' + '"' + name + '"' + ',' + '"Type":' + '"' + feeType + '"' + ', "SampleType":' + '"' + SampleType + '"' + ', "SampleCount":' + SampleCount + ', "DiscountValue":' + '"' + DiscountValue + '"' + ', "DiscountType":' + '"' + DiscountType + '"' + ',"Amount":' + '"' + amount + '"' + ', "status":' + '"Pending"' + ', "PkgID":' + '"0"' + ', "PkgName":' + '""' + ',"AccessionNumber":' + '"0"' + '}';
                if (iMain < arrMain.length - 2) {

                    HiddenFieldArray += ',';
                }
            }
            document.getElementById('hdnTempTest').value += HiddenFieldArray;

            HiddenFieldArray = "";
        }
        document.getElementById('hdnTempTest').value += "]";

    }

    arrMain = "";
    arrsub = "";


    arrMain = document.getElementById('hdnTestQuotationList').value.split("|");
    for (iMain = 0; iMain < arrMain.length - 1; iMain++) {

        arrsub = arrMain[iMain].split("~");
        ID = arrsub[0];
        name = arrsub[1].trim();
        feeType = arrsub[2];
        SampleType = arrsub[3];
        SampleCount = arrsub[4];
        DiscountType = arrsub[5];
        DiscountValue = arrsub[6];
        amount = arrsub[7];
        BodyTag += "<TR>";
        BodyTag += "<TD align='Center''>" + SNO + "</TD>";
        if (document.getElementById('hdnRegPageType').value != "REG") {
            if (document.getElementById('hdnNewAmount').value != "" && feeType == "PKG") {
                var TempIDAmount = document.getElementById('hdnNewAmount').value.split('|');
                for (i = 0; i < TempIDAmount.length - 1; i++) {
                    var TempTestAmount = TempIDAmount[i].split('~');
                    if (TempTestAmount[0] == ID) {
                        Tempamount = TempTestAmount[1];

                    }


                }

            }
        }

        if (feeType == "PKG" && IsPopup == "Y") {


            if (document.getElementById('hdnPKGUpdateList').value != "") {
                var UpdateList = document.getElementById('hdnPKGUpdateList').value.split('%');

                for (UpdateMain = 0; UpdateMain < UpdateList.length; UpdateMain++) {

                    var UpdateListID = UpdateList[UpdateMain].split('^');
                    var ListID = UpdateListID[0].split('~');
                    if ((ListID[0]) == ID) {
                        document.getElementById('hdnPopUpPkgID').value = ListID[0];
                        // document.getElementById('hdnPKGList').value = UpdateListID[1];
                        UpdatedAmount = ListID[1];
                        UpdatedDiscountValue = ListID[2];
                        UpdatedCount = ListID[3];
                        UpdatedDefaultAmt = ListID[4];
                        UpdatedDiscountCount = ListID[5];
                        //document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(UpdatedAmount);
                        if (UpdatedAmount != "" && UpdatedDiscountValue != "") {
                            BodyTag += "<TD ><input value ='" + name + "'  name='" + ID + "," + feeType + "," + name + "," + UpdatedDefaultAmt + "," + UpdatedCount + "," + SampleType + "," + UpdatedDiscountCount + "," + DiscountValue + " ," + UpdatedAmount + "," + DiscountType + "'  onclick='GetTestGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";

                        }

                    }





                }





            }


        }

        if (document.getElementById('hdnPopUpPkgID').value != ID && feeType == "PKG" && document.getElementById('hdnRegPageType').value != "REG") {
            DiscountAmt = arrsub[8];
            BodyTag += "<TD ><input value ='" + name + "'    name='" + ID + "," + feeType + "," + name + "," + Tempamount + "," + SampleCount + "," + SampleType + "," + DiscountValue + "," + DiscountAmt + "," + amount + "," + DiscountType + "'  onclick='GetTestGroupName(name);' type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";
            //BodyTag += "<TD align='Center''>" + name + "</TD>";
        }
        //        else if (document.getElementById('hdnLoadNewTestID').value == ID && feeType == "PKG" && IsPopup == "Y")
        //        {
        //            BodyTag += "<TD ><input value ='" + name + "'  name='" + ID + "," + feeType + "," + name + "," + UpdatedDefaultAmt + "," + UpdatedCount + "," + SampleType + "," + UpdatedDiscountCount + "," + DiscountValue + " ," + UpdatedAmount + "," + DiscountType + "'  onclick='GetTestGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";
        //        
        //        }

        else if (feeType != "PKG") {
            BodyTag += "<TD align='Center''>" + name + "</TD>";

        }
        if (document.getElementById('hdnRegPageType').value == "REG" && feeType=="PKG" ) {

            BodyTag += "<TD ><input value ='" + name + "' name='" + ID + ","+feeType+","+name+","+SampleType+"'  onclick='RegistrationPopup(name);'  type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";
        }

        BodyTag += "<TD align='Center''>" + SampleType + "</TD>";
        if (document.getElementById('hdnPopUpPkgID').value == ID && feeType == "PKG" && IsPopup == "Y") {
            BodyTag += "<TD align='Center''>" + UpdatedCount + "</TD>";
            BodyTag += "<TD align='Center''>" + UpdatedAmount + "</TD>";
        }
        else {

            BodyTag += "<TD align='Center''>" + SampleCount + "</TD>";
            BodyTag += "<TD align='Center''>" + amount + "</TD>";
        }
        if (document.getElementById('hdnRegPageType').value != "REG") {
            BodyTag += "<TD align='Center'><input value = 'Delete' name='" + ID + "~" + name + "' onclick='btnDeleteBillingItems_OnClick(name);' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>";
        } else {
           // BodyTag += "<TD align='Center'><input value = 'Update' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";

        }
        BodyTag += "</TR>";
        SNO++;
        //        if (document.getElementById('hdnLoadNewTestID').value == ID && IsPopup != "Y" && feeType == "PKG") {
        //            document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(amount);
        //        }
        //        else

        if (document.getElementById('hdnRegPageType').value != "REG") {

            if (document.getElementById('hdnLoadNewTestID').value == ID && IsPopup == "Y" && feeType == "PKG") {

                document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(UpdatedAmount);
            }
            else {
                document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(amount);

            }
            document.getElementById('hdnPopUpPkgID').value = "";
        }
        else {

            document.getElementById('hdnGrossValue').value = parseFloat(document.getElementById('hdnGrossValue').value) + parseFloat(amount);
            document.getElementById('billPart_txtGross').value = parseFloat(document.getElementById('hdnGrossValue').value).toFixed(2);

            //document.getElementById('billPart_txtNetAmount').value = document.getElementById('hdnGrossValue').value;
            //document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = document.getElementById('hdnGrossValue').value;
            //document.getElementById('<%= billPart_PaymentType_txtAmount.ClientID %>').value = document.getElementById('hdnGrossValue').value;
           // document.getElementById('billPart_PaymentType_txtAmount').value = document.getElementById('hdnGrossValue').value;
           // document.getElementById('billPart_hdnNetAmount').value = document.getElementById('hdnGrossValue').value;
            
            
        
        }
    }

    if (document.getElementById('hdnRegPageType').value != "REG") {
        FullTable = newPaymentTables + BodyTag + endTag;
        document.getElementById('divGrid').innerHTML = FullTable;
        document.getElementById('ddSampleType').value = "0";
        document.getElementById('txtSampleCount').value = "";
        document.getElementById('txtDiscountValue').value = "";
        document.getElementById('ddSampleType').disabled = true;
        document.getElementById('txtSampleCount').disabled = true;
        document.getElementById('ddlDiscountType').disabled = true;
        document.getElementById('ddlDiscountType').selectedIndex = "0";
        document.getElementById('txtTestName').value = "";
        document.getElementById('hdnFeeTypeSelected').value = "";
        document.getElementById('hdnOrdereditems').value = "";
        var grossvalue = document.getElementById('hdnGrossValue').value;
        grossvalue = parseFloat(grossvalue).toFixed(2);
        document.getElementById('txtGross').value = grossvalue;
        document.getElementById('txtNetAmount').value = grossvalue;
        document.getElementById('hdnDiscountAmt').value = document.getElementById('hdnGrossValue').value;
        document.getElementById('hdnPendingQuotation').value = "Y";
        if (document.getElementById('chkFoc').checked) {
            document.getElementById('ddDiscountPercent').disabled = true;
            document.getElementById('txtAuthorised').disabled = true;
            document.getElementById('ddlTaxPercent').disabled = true;
        }
        else {

            document.getElementById('ddDiscountPercent').disabled = false;
            document.getElementById('txtAuthorised').disabled = false;
            document.getElementById('ddlTaxPercent').disabled = false;
        }

        var TempDiscountDropDown = document.getElementById('ddDiscountPercent');
        var DiscountDropDown = TempDiscountDropDown.options[TempDiscountDropDown.selectedIndex].value;
        var TempTaxDropDown = document.getElementById('ddlTaxPercent');
        var TaxDropDown = TempTaxDropDown.options[TempTaxDropDown.selectedIndex].value;
        if (DiscountDropDown != "0") {
            SetQuotationDiscountAmt();


        }
        if (TaxDropDown != "0") {

            SetQuotationTaxAmt();

        }
    }
    else {

        FullTable = newPaymentTables + BodyTag + endTag;
        document.getElementById('divTestName').innerHTML = FullTable;
        document.getElementById('billPart_hdnGrossValue').value = document.getElementById('hdnGrossValue').value;
        document.getElementById('billPart_hdnDiscountableTestTotal').value = document.getElementById('hdnGrossValue').value;
        SetNetValue("ADD");
        PaymentTypeValidation();
    
    }


    return false;
}



function DiscountAuthSelected(source, eventArgs) {

    document.getElementById('hdnDiscountApprovedBy').value = eventArgs.get_value();
}



function getOPCustomRoundoff(netRound) {
    //var DefaultRound = document.getElementById('hdnDefaultRoundoff').value;
    var DefaultRound = ToInternalFormat($('#hdnDefaultRoundoff'));
    // var RoundType = document.getElementById('hdnRoundOffType').value;
    var RoundType = ToInternalFormat($('#hdnRoundOffType'));
    if (RoundType == "0") {
        RoundType = "none";
    }
    if (RoundType != undefined) {
        if (RoundType.toLowerCase() == "lower value") {
            result = (Math.floor(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
        }
        else if (RoundType.toLowerCase() == "upper value") {
            var lastdigit = Math.round(netRound % 10);
            if (lastdigit < 5.00) {
                result = (Math.floor(Number(netRound) / Number(5.00))) * (Number(5.00));
            }
            else if (lastdigit > 5.00) {
                result = (Math.ceil(Number(netRound) / Number(10.00))) * (Number(10.00));
            }
            else {
                result = (Math.floor(Number(netRound) / Number(10.00))) * (Number(10.00));
            }
        }
        else if (RoundType.toLowerCase() == "none") {
            result = format_number_withSignNone(netRound, 2);
        }
        else {
            result = parseFloat(netRound).toFixed(2);
        }
    }
    result = parseFloat(result).toFixed(2);
    return result;
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
    return (regex.test(field)) ? true : false;
}

function ValidationWindowEmail(message, tt) {
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
                        document.getElementById('txtEmailID').focus();
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


}

function LoadRegistrationTable() { 









}

function ConverttoUpperCase(id) {
    var lowerCase = document.getElementById(id).value;
    var upperCase = lowerCase.toUpperCase();
    document.getElementById(id).value = upperCase;
}
function loadRegClientDetails() {


    var GetData = document.getElementById('hdnSelectedClientDetails').value;
    var RegQuotationDetails = GetData.split('~');
    document.getElementById('txtClient').value = RegQuotationDetails[0];
    document.getElementById('txtRegAddress').value = RegQuotationDetails[1];
    document.getElementById('txtRegCity').value = RegQuotationDetails[2];
    document.getElementById('ddState').value = RegQuotationDetails[3];
    document.getElementById('ddCountry').value = RegQuotationDetails[4];
//    if (document.getElementById('hdnIsApplyAll').value == "Y") {

//        document.getElementById('txtRegCollectedTime').value = document.getElementById('hdnDate').value;
//    }

    if (RegQuotationDetails[5] != "") {
        if (RegQuotationDetails[5] == "N") {

            document.getElementById('chkRegSMS').checked = false;

        }
        else {

            document.getElementById('chkRegSMS').checked = true;

        }


    }

    if (RegQuotationDetails[6] != "") {
        if (RegQuotationDetails[6] == "N") {

            document.getElementById('chkRegEmail').checked = false;

        }
        else {

            document.getElementById('chkRegEmail').checked = true;

        }


    }
    
    document.getElementById('ddlClientName').value = RegQuotationDetails[7];


    document.getElementById('txtQuotationNo').readOnly = true;
    document.getElementById('ddlClientName').disabled = true;
    document.getElementById('txtRegAddress').readOnly = true;
    document.getElementById('txtRegCity').readOnly = true;
    document.getElementById('ddState').disabled = true;
    document.getElementById('ddCountry').disabled = true;
    document.getElementById('txtRegCollectedTime').readOnly = true;
    document.getElementById('txtRegSalesPerson').readOnly = true;
    document.getElementById('txtRegBranch').readOnly = true;
    // document.getElementById('txtRegBranch').readOnly = true;
    document.getElementById('chkRegEmail').disabled = true;
    document.getElementById('chkRegSMS').disabled = true;
    document.getElementById('FileUpload1').disabled = true;








}