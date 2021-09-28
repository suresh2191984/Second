/* Event Functions */
var AgainPopup,AgainPopupMaster,PopupMasterTest ;
var AgainPopupDetail, UpdateMain = 0, AgainPopupMasterDetail;
var MasterUpdateMain, AgainMasterPopupList;
var UpdateMasterMain = 0,i;



function NewQuotationCollectSample() {
    debugger;
    document.getElementById('divBillingPart').style.display = "none";
    document.getElementById('divTestName').innerHTML = "";
    ClearPaymentControlEvents1();


    loadRegClientDetails();

    document.getElementById('txtSampleReceivetime').value = document.getElementById('hdnDate').value;


} 

function GetTestGroupName(FeeId, FeeType) {

    

    var ID = FeeId.split(',')[0];
    if (document.getElementById('hdnLoadPkgID').value != "") {
        var PreviousTest = document.getElementById('hdnLoadPkgID').value.split('|');
        for (i = 0; i < PreviousTest.length - 1; i++) {
            var PerviousTestID = PreviousTest[i].split('~');
            if (PerviousTestID[0] == ID) {

               // AddItems();

                return false;
            }


        }


    }

    $find('ModalPopupShow').show();



    
    document.getElementById('hdnPopupTestID').value = ID;
    if(document.getElementById('hdnPKGUpdateList').value!="" )
    {
        AgainPopupDetail = document.getElementById('hdnPKGUpdateList').value.split('%');
        for (UpdateMain = 0; UpdateMain < AgainPopupDetail.length-1; UpdateMain++) {

            var UpdateListID = AgainPopupDetail[UpdateMain].split('^');
            var ListID = UpdateListID[0].split('~')[0];
            if (ListID == ID) {
                AgainPopup = 'Y';
                document.getElementById('hdnPKGTest').value = UpdateListID[1];
            
            }
        }
    }
    if (document.getElementById('hdnPKGMasterUpdatelist').value != "") {
        AgainMasterPopupList = document.getElementById('hdnPKGMasterUpdatelist').value.split('%');
        for (UpdateMasterMain = 0; UpdateMasterMain < AgainMasterPopupList.length - 1; UpdateMasterMain++) {

            var UpdateMasterListID = AgainMasterPopupList[UpdateMasterMain].split('^');
            var UpdateMasterID = UpdateMasterListID[0].split('~')[0];
            if (UpdateMasterID == ID) {
                document.getElementById('hdnMasterPKGTest').value = UpdateMasterListID[1];
            
            }


        }
    
    
    }
    
    
    var Type = FeeId.split(',')[1];
    document.getElementById('PopUptxtTestName').innerHTML = FeeId.split(',')[2];
    var Defaultamount = FeeId.split(',')[3];
    document.getElementById('hdnDefaultAmount').value = Defaultamount;
    var samplecount = FeeId.split(',')[4];
    var TotalDefaultAmount = parseFloat(Defaultamount * samplecount);
    document.getElementById('PopUptxtAmount').innerHTML = TotalDefaultAmount.toFixed(2);
    document.getElementById('PopUptxtTotal').value = TotalDefaultAmount.toFixed(2);
    document.getElementById('PopUptxtCount').innerHTML = FeeId.split(',')[4];
    document.getElementById('PopUptxtSampleCount').value = samplecount;
     document.getElementById('PopUptxtSample').innerHTML = FeeId.split(',')[5];
     document.getElementById('PopUptxtDiscountValue').value = FeeId.split(',')[6];
     document.getElementById('PopUptxtDiscount').innerHTML = FeeId.split(',')[6];
     document.getElementById('hdnDiscountValuePopup').value = FeeId.split(',')[6];
//    var DiscountAmt = FeeId.split(',')[7];
//    document.getElementById('hdnPopupSampleCount').value = FeeId.split(',')[4];
//    if (AgainPopup != "Y") {
//        DiscountAmt = parseFloat(DiscountAmt * samplecount).toFixed(2);
//    }
//    var Amount = parseFloat(Defaultamount * samplecount).toFixed(2);
//    Amount = parseFloat(Amount - DiscountAmt).toFixed(2);

//    var TotalAmt = FeeId.split(',')[8];
       document.getElementById('PopUptxtFamount').innerHTML = FeeId.split(',')[8];
       document.getElementById('PopUptxtFinalAmount').value = FeeId.split(',')[8];
    document.getElementById('hdnDiscountTypePopup').value = FeeId.split(',')[9];
     document.getElementById('PopupDiscountType').value = FeeId.split(',')[9];
     document.getElementById('PopupDiscountType').disabled = true;   
//    TotalAmt = parseFloat(TotalAmt * samplecount).toFixed(2);
//    document.getElementById('PopUptxtAmount').innerHTML = TotalAmt;
//    document.getElementById('PopUptxtTotal').value = TotalAmt;
//   
    if (AgainPopup != 'Y') {

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
                    document.getElementById('hdnPKGTest').value += Item.InvestigationID + '~' + Item.InvestigationName + '~' +
		Item.Name + '~' + Item.CONV_Factor + '|';


                });

          },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
       
    }

    PopupQuotationTable();
    PopupMasterDetails(FeeId);
    AgainPopup = "";

}





function PopupQuotationTable() {
    var MainPkg, MainSubPkg;
    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "";
    var imain = 0,SNO=0;
    var TempPKGID, TempPKGName, TempPKGType,TempAmt;
    
    startHeaderTag = "<table id='PKGListTest' width='100%' Class='gridView'cellpadding='0' cellspacing='0'>";
    startHeaderTag += "<tr class='dataheader1'><th></th><th >Package Test details</th></tr>";

    newPaymentTables = startHeaderTag;
    endTag = "</table>";
    MainPkg = document.getElementById('hdnPKGTest').value.split("|");
    for (imain = 0; imain < MainPkg.length-1; imain++) {

                    MainSubPkg = MainPkg[imain].split("~");
                    TempPKGID = MainSubPkg[0];
                    TempPKGName = MainSubPkg[1];
                    TempPKGType = MainSubPkg[2];
                    TempAmt = MainSubPkg[3];
                    BodyTag += "<TR>"
                    BodyTag += "<TD ><input  id ='PKG " + SNO + "'  type='checkbox' value='" + TempPKGID + "~" + TempPKGName + "~" + TempPKGType + "~"+TempAmt+"'  onclick='CheckedTest(this.id,value);'/></TD>"
            // BodyTag += "<TD ><input  id ='" + SNO + "' value='" + TempPKGID + "~" + TempPKGName + "~" + TempPKGType + "' type='checkbox' onclick='CheckedTest(this.id,value);'/></TD>"
            BodyTag += "<TD align='left'>" + TempPKGName + "</TD>";
            SNO++;
            }
            
               
             FullTable = newPaymentTables + BodyTag + endTag;
             document.getElementById('PKGlist').innerHTML = FullTable;


             return false;


}


function PopupMasterDetails(FeeId) {
    

  

    var ID = FeeId.split(',')[0];
    var Type = FeeId.split(',')[1];
    if (AgainPopup != 'Y') {
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPKGQuotationMasterDetails",
            data: "{ 'ID': '" + ID + "','Type': '" + Type + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                var Items = data.d;
                var i = 0;
                $.each(Items, function(index, Item) {
                    document.getElementById('hdnMasterPKGTest').value += Item.InvestigationID + '~' + Item.InvestigationName + '~' +
		Item.Name + '~' + Item.CONV_Factor + '|';


                });

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
        
    }

    PopupMasterDetailsBind();
}

function PopupMasterDetailsBind() {
    var MainPkg, MainSubPkg;
    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "";
    var imain = 0, SNO = 0;
    var TempPKGID, TempPKGName, TempPKGType,InvestigationName,InvestigationType,Tempamt;

    startHeaderTag = "<table id='MasterTest' width='100%' Class='gridView'cellpadding='0' cellspacing='0'>";
    startHeaderTag += "<tr class='dataheader1'><th></th><th >Master Test details</th></tr>";

    newPaymentTables = startHeaderTag;
    endTag = "</table>";
    MainPkg = document.getElementById('hdnMasterPKGTest').value.split("|");
    for (imain = 0; imain < MainPkg.length - 1; imain++) {

        MainSubPkg = MainPkg[imain].split("~");
        TempPKGID = MainSubPkg[0];
        TempPKGName = MainSubPkg[1];
        TempPKGType = MainSubPkg[2];
        Tempamt = MainSubPkg[3];

        BodyTag += "<TR>"
        BodyTag += "<TD ><input  id ='" + SNO + "'  type='checkbox' value='" + TempPKGID + "~" + TempPKGName + "~" + TempPKGType + "~"+Tempamt+"'  onclick='CheckedMasterTest(this.id,value);'/></TD>"
        BodyTag += "<TD align='left'>" + TempPKGName + "</TD>";
        SNO++;
    }


    FullTable = newPaymentTables + BodyTag + endTag;
    document.getElementById('PKGMaster').innerHTML = FullTable;


    return false;


}


function Search_Gridview(strKey, strGV) {
  
    var strData = strKey.value.toLowerCase().split(" ");
    var tblData = document.getElementById(strGV);
    var rowData;
    for (var i = 1; i < tblData.rows.length; i++) {
        rowData = tblData.rows[i].innerHTML;
        var styleDisplay = 'none';
        for (var j = 0; j < strData.length; j++) {
            if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                styleDisplay = '';
            else {
                styleDisplay = 'none';
                break;
            }
        }
        tblData.rows[i].style.display = styleDisplay;
    }
}


function CheckedTest(id, value) {
    

   
    var MasterDetails = document.getElementById('hdnPKGTest').value.split("|");
    var ID = value;
    var CheckedTest = value.split("~");
    if (document.getElementById(id).checked) {
        document.getElementById('hdnPopupAmt').value =parseFloat(document.getElementById('hdnPopupAmt').value)+parseFloat(CheckedTest[3]);
        document.getElementById('hdnTestChckdDetails').value += value + '|';
        var Strhidden;
        var Strvalue;
        var main;



        for (main = 0; main < MasterDetails.length; main++) {
            Strhidden = MasterDetails[main].split("~");
            if ((Strhidden[0]) == (CheckedTest[0])) {

                MasterDetails[main] = "";


            }


        }


        CheckedTest = "";
        for (main = 0; main < MasterDetails.length; main++) {
            if (MasterDetails[main] != "") {
                CheckedTest += MasterDetails[main] + "|";

            }


        }
        document.getElementById('hdnPKGTest').value = CheckedTest;
    }

    else {
        var MasterDetails = document.getElementById('hdnTestChckdDetails').value.split("|");
        //var TempsEditedData = sEditedData.split("~");
        var Strhidden;
        var Strvalue;
        var main;



        for (main = 0; main < MasterDetails.length; main++) {
            Strhidden = MasterDetails[main].split("~");
            if ((Strhidden[0]) == (CheckedTest[0])) {

                MasterDetails[main] = "";


            }


        }


      var CheckedTest1 = "";
        for (main = 0; main < MasterDetails.length; main++) {
            if (MasterDetails[main] != "") {
                CheckedTest1 += MasterDetails[main] + "|";

            }


        }
        document.getElementById('hdnTestChckdDetails').value = CheckedTest1;




        document.getElementById('hdnPKGTest').value += ID + "|";

        document.getElementById('hdnPopupAmt').value = parseFloat(document.getElementById('hdnPopupAmt').value) - parseFloat(CheckedTest[3]);
    
    }


}


function CheckedMasterTest(id, value) {
   
    var MasterDetails = document.getElementById('hdnMasterPKGTest').value.split("|");
    var main = 0;
    var CheckedTest = value.split("~");
    var ID = value;
    var PopupAmt;
    if (document.getElementById(id).checked) {

        document.getElementById('hdnChckedMasterTest').value += value + '|';

        document.getElementById('hdnPopupMasterAmt').value = parseFloat(document.getElementById('hdnPopupMasterAmt').value) + parseFloat(CheckedTest[3]);


        //var TempsEditedData = sEditedData.split("~");
        var Strhidden;
        var Strvalue;
        var main;



        for (main = 0; main < MasterDetails.length; main++) {
            Strhidden = MasterDetails[main].split("~");
            if ((Strhidden[0]) == (CheckedTest[0])) {

                MasterDetails[main] = "";


            }


        }


        CheckedTest = "";
        for (main = 0; main < MasterDetails.length; main++) {
            if (MasterDetails[main] != "") {
                CheckedTest += MasterDetails[main] + "|";

            }


        }
        document.getElementById('hdnMasterPKGTest').value = CheckedTest;
    }

    else {

        var MasterDetails = document.getElementById('hdnChckedMasterTest').value.split("|");
        //var TempsEditedData = sEditedData.split("~");
        var Strhidden;
        var Strvalue;
        var main;



        for (main = 0; main < MasterDetails.length; main++) {
            Strhidden = MasterDetails[main].split("~");
            if ((Strhidden[0]) == (CheckedTest[0])) {

                MasterDetails[main] = "";


            }


        }


        var CheckedTest1 = "";
        for (main = 0; main < MasterDetails.length; main++) {
            if (MasterDetails[main] != "") {
                CheckedTest1 += MasterDetails[main] + "|";

            }


        }
        document.getElementById('hdnChckedMasterTest').value = CheckedTest1;


        document.getElementById('hdnMasterPKGTest').value += ID + "|";
        document.getElementById('hdnPopupMasterAmt').value = parseFloat(document.getElementById('hdnPopupMasterAmt').value).toFixed(2) - parseFloat(CheckedTest[3]).toFixed(2);
    
    }


}


function RegistrationPopup(FeeId, FeeType) {

    //debugger;

    document.getElementById('PopUptxtTestName').innerHTML = FeeId.split(',')[2];
    document.getElementById('PopUptxtSample').innerHTML = FeeId.split(',')[3];
   // document.getElementById('PopUptxtSampleCollectedTime').innerHTML = document.getElementById('hdnDate').value;

    


    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "", FinalTestAmount,MainPkgData;
    var SNO = 1, i = 0;
    var arrsub = new Array();
    var vSno = SListForAppMsg.Get('Waters_QuotationMaster_aspx_01') == null ? "S.NO" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_01');
    var vSampleID = SListForAppMsg.Get('Waters_QuotationMaster_aspx_16') == null ? "Sample ID" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_16');
    var vSampleDesp = SListForAppMsg.Get('Waters_QuotationMaster_aspx_17') == null ? "Sample Description" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_17');
    var vVendor = SListForAppMsg.Get('Waters_QuotationMaster_aspx_18') == null ? "Vendor" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_18');
    var vQuality = SListForAppMsg.Get('Waters_QuotationMaster_aspx_19') == null ? "Quality & Condition" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_19');
    var vTemp = SListForAppMsg.Get('Waters_QuotationMaster_aspx_20') == null ? "Temperature" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_20');
    var vSampling = SListForAppMsg.Get('Waters_QuotationMaster_aspx_21') == null ? "Sampling Location" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_21');

    if (FeeId != "") {
        document.getElementById('hdnID').value = FeeId.split(',')[0];
        document.getElementById('hdnFeeType').value = FeeId.split(',')[1];
    }



    loadRegPopupDetails();
    




    startHeaderTag = "<table id='watersRegistration' width='100%' Class='gridView'  border='1px;' cellpadding='0' cellspacing='0'>";
    startHeaderTag += "<tr class='dataheader1'><th style='width:1%;'>" + vSno + "</th><th style='width:1%;'>" + vSampleID + "</th><th style='width:1%;'>" + vSampleDesp + "</th><th style='width:1%;'>" + vVendor + "</th><th style='width:1%;'>" + vQuality + "</th><th style='width:1%;'>" + vTemp + "</th><th style='width:1%;'>" + vSampling + "</th></tr>";
    newPaymentTables = startHeaderTag;
    endTag = "</table>";

    MainPkgData = document.getElementById('hdnPKGList').value.split('|');


    for (i = 0; i < MainPkgData.length - 1; i++) {

        arrsub = MainPkgData[i].split("~");
        var investigationid=arrsub[0];
        var SampleID = arrsub[1];

        var SampleDescrip = arrsub[2];
        var Temperature=arrsub[3];
        var Location = arrsub[4];
        var Vendor = arrsub[5];
        var Quality = arrsub[6];
        if (i == 0) {
            document.getElementById('PopUptxtSampleCollectedTime').innerHTML = arrsub[7];
        
        }

        BodyTag += "<TR>";
        BodyTag += "<TD align='Center''>" + SNO + "</TD>";
        BodyTag += "<TD align='Center''><input ID='SampleID' type='label' value='" + SampleID + "' ></TD>";
        BodyTag += "<TD align='Center'><input ID='SampleDesp' type='textbox' value='"+SampleDescrip+"' /></TD>";
        BodyTag += "<TD align='Center''><input ID='Vendor' type='textbox' value='" + Vendor + "' /></TD>";
        BodyTag += "<TD align='Center''><input ID='Quality' type='textbox' value='" + Quality + "'/></TD>";

        BodyTag += "<TD align='Center''><input ID='Temperature'  type='textbox' value='"+Temperature+"'/></TD>";
        BodyTag += "<TD align='Center''><input ID='Location' type='textbox' value='"+Location+"'/></TD>";
        BodyTag += "</TR>";
        SNO++;

    }
    FullTable = newPaymentTables + BodyTag + endTag;
    document.getElementById('PopUpPkg').innerHTML = FullTable;

    if (document.getElementById('PopUpPkg').innerHTML != "") {

        $find('ModalPopupShow1').show();
        document.getElementById('hdnPKGList').value = '';
    
    }

    return false;




}



function loadRegPopupDetails() {

   
    var InvestigationID = 0;
    var Type = "";
    var QuotationID = "";
    var QuotationNo = "";
    if (document.getElementById('hdnID').value != "") {
        InvestigationID = document.getElementById('hdnID').value;
    }
    if (document.getElementById('hdnFeeType').value != "") {
        Type = document.getElementById('hdnFeeType').value;
    }

    if (document.getElementById('hdnSelectedQuotationID').value != "") {
        QuotationID = document.getElementById('hdnSelectedQuotationID').value;
    }
    if (document.getElementById('hdnSelectedQuotationNo').value != "") {

        QuotationNo = document.getElementById('hdnSelectedQuotationNo').value;
    }


    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetpkgSampleDetails",
        data: "{ 'QuotationID': '" + QuotationID + "','InvestigationID': '" + InvestigationID + "','Type': '" + Type + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            var Items = data.d;
            var i = 0;
            $.each(Items, function(index, Item) {
            document.getElementById('hdnPKGList').value += Item.InvestigationID + '~' + Item.SampleID + '~' + Item.SampleDescription + '~' + Item.Temperature + '~' + Item.Location + '~' + Item.Vendor + '~' + Item.Quality + '~' + Item.InvestigationsType + '|';

            });


        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }

    });


}

function QuotationCollectSample() {

    loadRegClientDetails();

    document.getElementById('divTestName').innerHTML = "";
    ClearPaymentControlEvents1();
    var startHeaderTag = "", newPaymentTables = "", endTag = "", BodyTag = "", FullTable = "", FinalTestAmount, MainPkgData;
    var SNO = 1, i = 0,Dropdown=0,LocationDropDown=0;
    var LoadSampleStatus = new Array();
    var arrsub = new Array();
    var LoadSubSampleStatus = new Array();
    var LoadLocation = new Array(),LoadSubLocation = new Array();
    var vSno = SListForAppMsg.Get('Waters_QuotationMaster_aspx_01') == null ? "S.NO" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_01');
    var vSampleID = SListForAppMsg.Get('Waters_QuotationMaster_aspx_16') == null ? "Sample ID" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_16');
    var vSampleDesp = SListForAppMsg.Get('Waters_QuotationMaster_aspx_17') == null ? "Sample Description" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_17');
    var vVendor = SListForAppMsg.Get('Waters_QuotationMaster_aspx_18') == null ? "Vendor" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_18');
    var vQuality = SListForAppMsg.Get('Waters_QuotationMaster_aspx_19') == null ? "Quality & Condition" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_19');
    var vTemp = SListForAppMsg.Get('Waters_QuotationMaster_aspx_20') == null ? "Temperature" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_20');
    var vSampling = SListForAppMsg.Get('Waters_QuotationMaster_aspx_21') == null ? "Sampling Location" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_21');
    var DateTime=document.getElementById('hdnDate').value;

    document.getElementById('divBillingPart').style.display = "none";

    if (document.getElementById('hdnIsApplyAll').value != 'Y') {
        loadCollectSample();
        loadLocationDetails();
        loadDropDownValues();
    }

    startHeaderTag = "<table id='watersCollectSample' width='100%' Class='gridView'  border='1px;' cellpadding='0' cellspacing='0'>";
    startHeaderTag += "<tr class='dataheader1'><th style='width:1%;'>" + vSno + "</th><th style='width:1%;'>Test Name</th><th style='width:1%;'>Sample</th><th style='width:1%;'>Container</th><th style='width:1%;'>SampleID</th><th style='width:1%;'>Barcode</th><th style='width:1%;'>Status</th><th style='width:1%;'>Location</th><th style='width:1%;'>Receive Time</th></tr>";
    newPaymentTables = startHeaderTag;
    endTag = "</table>";

        MainPkgData = document.getElementById('hdnCollectSampleList').value.split('|');


  for (i = 0; i < MainPkgData.length - 1; i++) {

        arrsub = MainPkgData[i].split("~");
        var investigationid = arrsub[0];
        var Investigationname=arrsub[1];
        var SampleID = arrsub[2];
        var SampleType = arrsub[3];
        var barcode = arrsub[4];
        var SampleCode = arrsub[5];
        var SampleContainer = arrsub[6];
        var DeptID = arrsub[7];
        var Type = arrsub[8];

//        var Uniqueid = arrsub[2];

        BodyTag += "<TR>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='ID' style='display:none;' value='" + investigationid + "'></TD>";
        BodyTag += "<TD align='Center''>"+SNO+"</TD>";
        BodyTag += "<TD align='Center''>" + Investigationname + "</TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='Investigationname' style='display:none;' value='" + Investigationname + "'></TD>";

        BodyTag += "<TD align='Center''>" + SampleType + "</TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='SampleType' style='display:none;' value='" + SampleType + "'></TD>";
        BodyTag += "<TD align='Center''>Box</TD>";
        BodyTag += "<TD align='Center''>" + SampleID + "</TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='SampleID' style='display:none;' value='" + SampleID + "'></TD>";
        BodyTag += "<TD align='Center''>" + barcode + "</TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='barcode' style='display:none;' value='" + barcode + "'></TD>";
        BodyTag += "<TD align='Center'><select type='select'/>";
        if (document.getElementById('hdnLoadSampleStatus').value != "") {

            LoadSampleStatus = document.getElementById('hdnLoadSampleStatus').value.split('|');

            for (Dropdown = 0; Dropdown < LoadSampleStatus.length - 1; Dropdown++) {

                LoadSubSampleStatus = LoadSampleStatus[Dropdown].split('~');
                BodyTag += "<option value='" + LoadSubSampleStatus[0] + "'>" + LoadSubSampleStatus[1] + "</option>"
            
            }
            


        }


        BodyTag +="</select></TD>";
        BodyTag += "<TD align='Center'><select type='select'/>";

        if (document.getElementById('hdnLocation').value != "") {

            LoadLocation = document.getElementById('hdnLocation').value.split('|');

            for (LocationDropDown = 0; LocationDropDown < LoadLocation.length - 1; LocationDropDown++) {

                LoadSubLocation = LoadLocation[LocationDropDown].split('~');

                if (document.getElementById('hdnDefaultLocationID').value == LoadSubLocation[0]) {

                    BodyTag += "<option value='" + LoadSubLocation[0] + "' selected='true'>" + LoadSubLocation[1] + "</option>"

                }

                else {

                    BodyTag += "<option value='" + LoadSubLocation[0] + "'>" + LoadSubLocation[1] + "</option>"
                }

            }



        }
        BodyTag += "</select></TD>"
        BodyTag += "<TD align='Center''><input id='" + SampleID + "' type='text' class='date' value='" + DateTime + "' onclick=NewCssCal(this.id,'ddmmyyyy','arrow',true,12,'','past')  onchange='Checkdate(this.id)' /></TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='SampleCode' style='display:none;' value='" + SampleCode + "'></TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='SampleContainer' style='display:none;' value='" + SampleContainer + "'></TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='DeptID' style='display:none;' value='" + DeptID + "'></TD>";
        BodyTag += "<TD align='Center'' style='display:none;'><input type='textbox' ID='Type' style='display:none;' value='" + Type + "'></TD>";
        BodyTag += "</TR>";
        SNO++;

   }
    FullTable = newPaymentTables + BodyTag + endTag;
    document.getElementById('divCollectSample').innerHTML = FullTable;
    document.getElementById('txtSampleReceivetime').value = DateTime;
    $('#hdnIsApplyAll').val('');
    $('#chkSampleReceivetime').prop('checked', false);
    
    
    
    return false;

}


function loadCollectSample() {



var QuotationID=document.getElementById('hdnSelectedQuotationID').value;
var OrgID = document.getElementById('hdnOrgID').value;
var VisitID = document.getElementById('hdnVisitID').value;


    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetRegistrationSampleCollect",
        data: "{ 'QuotationID': '" + QuotationID + "','OrgID': '" + OrgID + "','VisitID': '" + VisitID + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            var Items = data.d;
            var i = 0;
            $.each(Items, function(index, Item) {
            document.getElementById('hdnCollectSampleList').value += Item.ID + '~' + Item.Name + '~' +
		Item.Status + '~' + Item.SampleTypeID + '~' + Item.DiscountTypeID + '~' + Item.DiscountValue + '~' + Item.OrgID + '~' + Item.SampleCount + '~' + Item.InvestigationsType + '|';
   });


        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }

    });


}


function loadDropDownValues() {


    



var QuotationID = document.getElementById('hdnSelectedQuotationID').value;
var OrgID=document.getElementById('hdnOrgID').value;

$.ajax({
    type: "POST",
    url: "../OPIPBilling.asmx/LoadQuotationDropDownValues",
    data: "{'OrgID': '" + OrgID + "' }",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    async: false,
    success: function(data) {
        var Items = data.d;
        var i = 0;
        $.each(Items, function(index, Item) {
        if (Item.Code == "SampleReceived") {
                document.getElementById('hdnLoadSampleStatus').value += Item.Code + '~' + Item.DisplayText + '|';
            }

        });


    },
    failure: function(msg) {
        ShowErrorMessage(msg);
    }

});


}


function loadLocationDetails(){


    



    var RoleID = document.getElementById('hdnRoleID').value;
    var iOrgID = document.getElementById('hdnOrgID').value;

    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetLocationDetails",
        data: "{'iOrgID': '" + iOrgID + "','RoleID': '" + RoleID + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            var Items = data.d;
            var i = 0;
            $.each(Items, function(index, Item) {
            document.getElementById('hdnLocation').value += Item.AddressID + '~' + Item.Location + '|';

            });


        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }

    });


}

function UpdatePKGList() {


    GetPopUpValues();
var QuotationID = document.getElementById('hdnSelectedQuotationID').value;
var OrgID=document.getElementById('hdnOrgID').value;


$.ajax({
    type: "POST",
    contentType: "application/json; charset=utf-8",
    url: "../OPIPBilling.asmx/UpdatepkgSampleDetails",
    data: JSON.stringify({ LstQuotationSampleScheduling: dtPkgDetail, QuotationID: QuotationID, OrgID: OrgID }),
    dataType: "json",
    async: false,
    success: function() {

    }
});



$find('ModalPopupShow1').hide();


return false;
    







}


var dtPkgDetail = [];

function GetPopUpValues() {

    debugger;


    $("#watersRegistration tr:not(:first)").each(function(i, n) {
        var $row = $(n);


        var SampleId = $row.find("#SampleID").val();
            var SampleDescrip = $row.find("#SampleDesp").val();
            var Vendor = $row.find("#Vendor").val();
            var Quality = $row.find("#Quality").val();
            var Temperature = $row.find("#Temperature").val();
            var Location = $row.find("#Location").val();

            dtPkgDetail.push({
                SampleId: SampleId,
                SampleDescrip: SampleDescrip,
                Vendor: Vendor,
                Quality:Quality,
                Temperature: Temperature,
                Location: Location

            });

        });


}

function CancelRegistrationPopup() {

    $find('ModalPopupShow1').hide();

    document.getElementById('hdnPKGList').value = '';

    return false;


}




function SaveData() {

    debugger;

    var HiddenFieldArray = new Array();



    $("#watersCollectSample tr:not(:first)").each(function(i, n) {
        var $row = $(n);


        var ID = $row.find("#ID").val();
        var Investigationname = $row.find("#Investigationname").val();
        var SampleID = $row.find("#SampleID").val();
        var SampleType = $row.find("#SampleType").val();
        var barcode = $row.find("#barcode").val();
        var SampleCode = $row.find("#SampleCode").val();
        var SampleContainer = $row.find("#SampleContainer").val();
        var DeptID = $row.find("#DeptID").val();
        var Type = $row.find("#Type").val();
        var Date = $row.find('#' + SampleID).val();


        HiddenFieldArray += ID + '~' + Investigationname + '~' + SampleID + '~' + SampleType + '~' + barcode + '~' + SampleCode + '~' + SampleContainer + '~' + DeptID + '~' + Type + '~' + Date + '|';

    });

    document.getElementById('hdnFinalTestList').value = HiddenFieldArray;
    HiddenFieldArray = "";
}

function Checkdate(value) {

    //debugger;





    $("#watersCollectSample tr:not(:first)").each(function(i, n) {
        var $row = $(n);


        var ID = $row.find("#ID").val();
        var Investigationname = $row.find("#Investigationname").val();
        var SampleID = $row.find("#SampleID").val();



        if (value == SampleID) {

            var ChangedDateTime = $row.find('#' + SampleID).val();

            //var ChangedDateTime = value;

        }




    });


     var CurrentDateTime = $('#hdnDate').val();
    // var ChangedDateTime = value;
     var CollectedDateTime = $('#txtRegCollectedTime').val();

     var CurrentDate = CurrentDateTime.split(" ")[0];
     var CurrentTime = CurrentDateTime.split(" ")[1];

     var ChangedDate = ChangedDateTime.split(" ")[0];
     var ChangedTime = ChangedDateTime.split(" ")[1];

     var CollectedDate = CollectedDateTime.split(" ")[0];
     var CollectedTime = CollectedDateTime.split(" ")[1];



     var d1 = CollectedDate.split("-"); // For Collecteddate
     
     var d2 = CurrentDate.split("-"); //For CurrentDate
     
     var c = ChangedDate.split("-");//for Changeddate
     


 //b.Subtract(a).TotalMinutes)

     var AmFormatHours = CollectedTime.split(':')[0];
     var AmFormatMinutes = CollectedTime.split(':')[1];
     var AmFormatSeconds = CollectedTime.split(':')[2];

     if (AmFormatHours > 12) {

         AmFormatHours = parseFloat(AmFormatHours) - 12;
         CollectedTime = AmFormatHours + ':' + AmFormatMinutes + ':' + AmFormatSeconds + 'PM';


     }
     else {
         CollectedTime = AmFormatHours + ':' + AmFormatMinutes + ':' + AmFormatSeconds + 'AM';
     }
     
     var d1Hours=CollectedTime.split(':')[0];
     var d1Minutes=CollectedTime.split(':')[1];

     var d2hrs = CurrentTime.split(":");
     var chrs = ChangedTime.split(":");
     var d1hrs = CollectedTime.split(":");


     var from = new Date(d1[0], d1[1] - 1, d1[2], d1hrs[0]);
     var to = new Date(d2[2], d2[1] - 1, d2[0], d2hrs[0]);
     var check = new Date(c[2], c[1] - 1, c[0]);

     if (check >= from && check <= to) {



     }
     else {

         alert('hi');
     }


 }


 function ApplyReceiveTime() {


     debugger;

     //if ($(chkSampleReceivetime).prop("checked") == true) {

         var date = document.getElementById('txtSampleReceivetime').value;


        // var Dummy = isFutureDate(date);
//         if (Dummy == false) {

//             return false;
//         }




         if ($('#chkSampleReceivetime').prop('checked') == true) {


             $('#hdnDate').val($('#txtSampleReceivetime').val());


             $('#hdnIsApplyAll').val('Y');
             document.getElementById('divCollectSample').innerHTML = '';


             QuotationCollectSample();

             $('#chkSampleReceivetime').prop('checked', true);



             return false;




         }
    // }









}

function isFutureDate(idate) {

    var CollectedDate = document.getElementById('txtRegCollectedTime').value;//Sample collected date
    var dateFrom = idate;//selected date
    //var dateTo = ClientDetails[13];
    var dateCheck = document.getElementById('hdnCurrentDate').value;//Current Date

    var d1 = CollectedDate.split("-");
    var d2 = dateFrom.split("-");
    var c = dateCheck.split("-");
    CollectedDate = d1[1] +'-'+d1[0]+'-'+ d1[2];
    dateFrom = d2[1]+'-'+ d2[0]+'-'+ d2[2];
    dateCheck = c[1] + '-' + c[0] + '-' + c[2];//To alterthe format according to the date function

   // var c = new Date();

    var from = new Date(dateFrom);  // -1 because months are from 0 to 11
   var CollectedDateformat = new Date(CollectedDate);
    var check = new Date(dateCheck);

    if (check >= from && CollectedDateformat <= from) {

        //        alert('greater');
        return true;



    }
    else {
        alert('Lesser');
        return false;
    
    }

}
 