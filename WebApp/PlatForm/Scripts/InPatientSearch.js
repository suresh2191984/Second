var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Error" : SListForAppMsg.Get("PlatForm_Error");
var cancelMsg = SListForAppMsg.Get("PlatForm_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatForm_Cancel");
var informMsg = SListForAppMsg.Get("PlatForm_Information") == null ? "Information" : SListForAppMsg.Get("PlatForm_Information");
var okMsg = SListForAppMsg.Get("PlatForm_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatForm_Ok");

// Page Load 
$(document).ready(function() {
    if ($("[id$='hdnTotalCount']").val() != '') {
        createPager($("[id$='hdnTotalCount']").val(), $('#divPager'));
    }
    else {
        $('#divPager').hide();
    }
});


var pno = 1;
var sort = 0;
var filter = 0;
var col = 2;
var searchtext;
var totalCount = 0;
var uid = "";
var rowPid = 0;
var gid = "";
var atid = "";
var atsid = "";
var projid = 0;
var pjname = "";
var fromDate = '';
var ToDate = '';
var AdfromDate1 = '';
var AdToDate1 = '';
var TPAID = '';
var ClientID = '';
var Purpose = '';

// Paging Method
function callPage(pageno) {
    pno = pageno;
    LoadData();
}

// Load All Datas
function LoadData() {
    totalCount = $("[id$='hdnTotalCount']").val();
    GetRegDate();
    GetAddDate();
    GetType();
    $('#divLoadingGif').show();
    var CurrentPageNo = pno;
    var VisitPurposeID = 0;
    if (getParameterByName('Emergency') == 'Y') {
        VisitPurposeID = 5;
    }
    var addFD = AdfromDate1;
    var addTD = AdToDate1;
    var regFD = fromDate;
    var regTD = ToDate;
    var Nationality = $("[id$='ddlNationality'] option:selected").val();
    if ($("[id$='purposeOfAdmission'] option:selected").val() != "0") {
        Purpose = $("[id$='purposeOfAdmission'] option:selected").text();
    }
    var DOB = $.trim($("[id$='txtDOB']").val());
    fnGetIPList(CurrentPageNo, VisitPurposeID, regFD, regTD, addFD, addTD, TPAID, ClientID,
    Nationality, Purpose, DOB);
}

// Get Values From Service
function fnGetIPList(CurrentPageNo, VisitPurposeID, regFD, regTD, addFD, addTD, TPAID, ClientID,
Nationality, Purpose, DOB) {
    $.ajax({
        type: "POST",
        url: "../PlatForm/CommonWebServices/CommonServices.asmx/GetIPPatient",
        data: "{ 'CurrentPageNo': '" + CurrentPageNo + "','VisitPurposeID': '" + VisitPurposeID
        + "','TPAID': '" + TPAID + "','ClientID': '" + ClientID
        + "','Nationality': '" + Nationality + "','Purpose': '" + Purpose + "','DOB': '" + DOB
        + "','regFD': '" + regFD + "','regTD': '" + regTD
        + "','addFD': '" + addFD + "','addTD': '" + addTD + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            var Items = data.d;
            fnBindIPRows(Items)
        },
        failure: function(msg) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_InPatientSearch_js_03") == null ? "failed" : SListForAppMsg.Get("PlatForm_Scripts_InPatientSearch_js_03");
            ValidationWindow(userMsg, errorMsg);
        }
    });
}

// Bind Inpatient Rows
function fnBindIPRows(Items) {
    $("[id$='divIPContainer']").empty();

    var strIPHeader = '';

    strIPHeader += "<tr class='gridHeader' >";
   // if ($("[id$='hdnLanguCode']").val() == "id-ID") {
//        strIPHeader += "<th  id='thSelect'>Pilih</th>";
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("patient name") != -1) {
//            strIPHeader += "<th  id='thName'>Nama</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("UHID") != -1) {

//            if ($("[id$='hdnNeedIPNumber']").val() == "Y") {
//                strIPHeader += "<th  id='thPNO'>No.RM/No.IP</th>";
//            }
//            else {
//                strIPHeader += "<th  id='thPNO'>No.RM</th>";
//            }

//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("visit number") != -1) {
//            strIPHeader += "<th id='thPNO'>Visit Number</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("dob") != -1) {
//            strIPHeader += "<th id='thPNO'>Tanggal Lahir</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("age") != -1) {
//            strIPHeader += "<th id='thAge'>Umur</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("room number") != -1) {
//            strIPHeader += "<th id='thRoomNO'>No Kamar / tempat tidur</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("phone number") != -1) {
//            strIPHeader += "<th id='thPHNO'>No. Telepon</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("address") != -1) {
//            strIPHeader += "<th id='thAdd'>Alamat</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("purpose of admission") != -1) {
//            strIPHeader += "<th id='thPOA'>Tujuan pendaftara</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("date of admission") != -1) {
//            strIPHeader += "<th id='thDOA'>Tanggal Pendaftaran<</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("current due") != -1) {
//            strIPHeader += "<th id='thCurDue'>Biaya Saat Ini</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("pre auth amount") != -1) {
//            strIPHeader += "<th id='thPreAmt'>Biaya Yang Dijamin</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("referred by") != -1) {
//            strIPHeader += "<th id='thRef'>Referred By</th>";
//        }
//        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("lengthofstay") != -1) {
//            strIPHeader += "<th id='thlengthofstay'>Lama Tinggal</th>";
//        }
//        if ($("[id$='hdnAuthentication']").val() != '' && $("[id$='hdnAuthentication']").val() == 'show') {
//            strIPHeader += "<th id='thAction'>Tindakan</th>";
//        }
//         
//    }

    // else {
    //----------------------------------------------------------------Localization changes-------------------------------------------------
    var objSno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_04") == null ? "S.No." : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_04");
    var objName = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_05") == null ? "Name" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_05");
    var objIpno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_06") == null ? "UHID. / Ip No." : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_06");
    var objPatientno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_07") == null ? "UHID" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_07");
    var objVisitno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_08") == null ? "Visit Number" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_08");
    var objDob = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_09") == null ? "DOB" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_09");
    var objAge = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_10") == null ? "Age" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_10");
    var objRoomno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_11") == null ? "Room/Bed No" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_11");
    var objPhoneno = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_12") == null ? "Phone Number" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_12");
    var objAddress = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_13") == null ? "Address" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_13");
    var objPhysicianName = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_14") == null ? "Physician Name" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_14");
    var objPurposeOfAdm = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_15") == null ? "Purpose Of Admission" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_15");
    var objDateOfAdm = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_16") == null ? "Date Of Admission" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_16");
    var objCurrDue = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_17") == null ? "Current Due" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_17");
    var objPreAuthAmt = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_18") == null ? "Pre Auth Amount" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_18");
    var objReferredBy = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_19") == null ? "Referred By" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_19");
    var objLengthofStay = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_20") == null ? "Length of Stay" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_20");
    var objAction = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_21") == null ? "Action" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_21");
    var objSelect = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_22") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_22");
    var Daycareno=SListForAppDisplay.Get("PlatForm_CommonControls_InPatientSearch_ascx_19") == null ? "Select" : SListForAppDisplay.Get("PlatForm_CommonControls_InPatientSearch_ascx_19");
   //----------------------------------------------------------------------------------------------------------------------------------------
        strIPHeader += "<th id='thSelect'>"+objSelect+"</th>";

        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("s.no") != -1) {
            strIPHeader += "<th id='thSNo'>" + objSno + "</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("patient name") != -1) {
            strIPHeader += "<th id='thName'>"+objName+"</th>";
        }
	/*Show the UHID in the gridview - Modified by Rajagopalan*/
        if (($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("patient number") != -1) || ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("uhid")!=-1)) {
            if ($("[id$='hdnNeedIPNumber']").val() == "Y"  && $("[id$='hdnIPDaycare']").val() == "N") {
                strIPHeader += "<th id='thPNO'>"+objIpno+"</th>";
            }
            else if($("[id$='hdnIPDaycare']").val() == "Y")
            { strIPHeader += "<th id='thPNO'>"+Daycareno+"</th>";}
            else {
                strIPHeader += "<th id='thPNO'>"+objPatientno+"</th>";
            }
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("visit number") != -1) {
            strIPHeader += "<th id='thPNO'>"+objVisitno+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("dob") != -1) {
            strIPHeader += "<th id='thPNO'>"+objDob+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("age") != -1) {
            strIPHeader += "<th id='thAge'>"+objAge+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("room number") != -1) {
            strIPHeader += "<th  id='thRoomNO'>"+objRoomno+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("phone number") != -1) {
            strIPHeader += "<th id='thPHNO'>"+objPhoneno+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("address") != -1) {
            strIPHeader += "<th id='thAdd'>"+objAddress+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("physician name") != -1) {
            strIPHeader += "<th id='thAdd'>"+objPhysicianName+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("purpose of admission") != -1) {
            strIPHeader += "<th id='thPOA'>"+objPurposeOfAdm+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("date of admission") != -1) {
            strIPHeader += "<th id='thDOA'>"+objDateOfAdm+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("current due") != -1) {
            strIPHeader += "<th id='thCurDue'>"+objCurrDue+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("pre auth amount") != -1) {
            strIPHeader += "<th id='thPreAmt'>"+objPreAuthAmt+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("referred by") != -1) {
            strIPHeader += "<th id='thRef'>"+objReferredBy+"</th>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("lengthofstay") != -1) {
            strIPHeader += "<th id='thlengthofstay'>"+objLengthofStay+"</th>";
        }
        if ($("[id$='hdnAuthentication']").val() != '' && $("[id$='hdnAuthentication']").val() == 'show') {
            strIPHeader += "<th id='thAction'>" + objAction + "</th>";
        }
  //  }
     if ($("[id$='hdnNeedOutSourceInvestigation']").val() == 'Y') {
            strIPHeader += "<th id='thPdf'></th>";
     }
    strIPHeader += "</tr>";

    var strIPRow = '';
    var rowNum =((pno-1)*10)+ 1;
    $.each(Items, function(index, IPRow) {
        var setStyle = '';
        if (IPRow.OCCUPATION.toLowerCase() == 'n') {
             setStyle = "<span class='ui-icon ui-icon-comment'></span>";
        }
        if (IPRow.IsCreditBill.toLowerCase() == "y") {
           setStyle = " <span class='ui-icon ui-icon-person'></span>";
        }

        strIPRow += "<tr>";
        var attr = "PID='" + IPRow.PatientID + "' orgID='" + IPRow.OrganizationID
                + "' PNO='" + IPRow.PatientNumber + "' SP='" + IPRow.Comments + "' PRS='" + IPRow.OCCUPATION + "'";
        strIPRow += "<td> "+setStyle+" <input " + attr + " type='radio' onclick='SetRowValue(this);' id='rdlIPSelect' /></td>";
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("s.no") != -1) {
            strIPRow += "<td>" + rowNum + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("patient name") != -1) {
            strIPRow += "<td class='a-left'>" + IPRow.Name + "</td>";
        }
	/*Show the UHID in the gridview - Modified by Rajagopalan*/
        if (($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("patient number") != -1) || ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("uhid")!=-1)) {

            var patientNumber = '';
            if (IPRow.PatientNumber != null && IPRow.PatientNumber != '') {
                patientNumber = "<td class='a-left'>" + IPRow.PatientNumber + "</td>";
            }
            if (IPRow.IPNumber != null && IPRow.PatientNumber != '' && $("[id$='hdnNeedIPNumber']").val() == "Y") {
                patientNumber = "<td class='a-left'>" + IPRow.PatientNumber + "/" + IPRow.IPNumber + "</td>";
            }
            strIPRow += patientNumber;
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("dob") != -1) {
            strIPRow += "<td class='a-left'>" + JSONDate(IPRow.DOB) + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("age") != -1) {
            strIPRow += "<td class='a-left'>" + IPRow.Age + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("visit number") != -1) {
            strIPRow += "<td class='a-left'>" + IPRow.VisitNumber + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("room number") != -1) {
            if (IPRow.BedDetail != null) {
                strIPRow += "<td class='a-left'>" + IPRow.BedDetail + "</td>";
            }
            else {
                strIPRow += "<td>" + "-" + "</td>";
            }
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("phone number") != -1) {
            if (IPRow.MobileNumber != null && IPRow.MobileNumber != '') {
                strIPRow += "<td class='a-left'>" + IPRow.MobileNumber + "</td>";
            }
            else {
                strIPRow += "<td>" + '-' + "</td>";
            }
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("address") != -1) {
            strIPRow += "<td class='a-left'>" + IPRow.Address + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("physician name") != -1) {
            strIPRow += "<td class='a-left'>" + IPRow.PhysicianName + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("purpose of admission") != -1) {
            if (IPRow.PurposeOfAdmissionName != null) {
                strIPRow += "<td class='a-left'>" + IPRow.PurposeOfAdmissionName + "</td>";
            }
            else {
                strIPRow += "<td>" + "-" + "</td>";
            }
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("date of admission") != -1) {
            strIPRow += "<td class='a-left'>" + ToExternalDateTime(JSONDateWithTime(IPRow.AdmissionDate)) + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("current due") != -1) {
            strIPRow += "<td class='a-right'>" + IPRow.DueDetails + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("pre auth amount") != -1) {
            strIPRow += "<td class='a-right'>" + IPRow.PreAuthAmount + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("referred by") != -1) {
            if (IPRow.InformationBy == '')
                strIPRow += "<td>" + "-" + "</td>";
            else
                strIPRow += "<td>" + IPRow.InformationBy + "</td>";
        }
        if ($("[id$='hdnDynamicColums']").val().toLowerCase().indexOf("lengthofstay") != -1) {
            strIPRow += "<td class='a-center'>" + IPRow.PatientCount + "</td>";
        }
        if ($("[id$='hdnAuthentication']").val() != '' 
        && $("[id$='hdnAuthentication']").val() == 'show'
        && IPRow.OCCUPATION.toLowerCase() != 'n') {
            strIPRow += "<td>" + "<img alt='Discharge' style='cursor:pointer;' PID=" + IPRow.PatientID + " src='../PlatForm/Images/report.gif' onclick='MoveToDischarge(this);'  />" + "</td>";
        }
        
        if ($("[id$='hdnNeedOutSourceInvestigation']").val() == 'Y') {
        
            strIPRow += "<td  class='a-center'>";
            
            if (IPRow.Group!='')
            {
              var PictureName = '';
              PictureName = $("[id$='hdnPdfFilePath']").val()
              PictureName = PictureName + IPRow.Group;
              PictureName = PictureName.replace("\\", "\\\\");
              strIPRow += "<td  class='a-center'><span class='ui-icon ui-icon-folder-open pointer' OnClick=\"javascript:return ShowReport('" + PictureName + "');\" /></td>";
            }
            else
            {
              strIPRow += "<td  class='a-center'></td>";
            }
            
             if (IPRow.Radiologi!='')
            {
              var PictureName = '';
              PictureName = $("[id$='hdnRadiologiPdfFilePath']").val()
              PictureName = PictureName + IPRow.Radiologi;
              PictureName = PictureName.replace("\\", "\\\\");
              strIPRow += "<td  class='a-center'><span class='ui-icon ui-icon-note pointer' OnClick=\"javascript:return ShowReport('" + PictureName + "');\" /></td>";
            }
            else
            {
              strIPRow += "<td  class='a-center'></td>";
            }
            //strIPRow += "</td>";
       }     
        strIPRow += "</tr>";
        rowNum = rowNum + 1;
    });

    var strIPContainer = '';

    strIPContainer += "<table id='tbodyIPSearch' class='gridView w-100p' >";
    strIPContainer += strIPHeader;
    strIPContainer += strIPRow;
    strIPContainer += "</table>";
    $("[id$='divIPContainer']").html(strIPContainer);

    createPager(totalCount, $('#divPager'));
    $('#divLoadingGif').hide();
}


// Paging Creator
function createPager(count, id) {
    var Prev = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_02") == null ? "Prev" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_02");
    var Next = SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_01") == null ? "Next" : SListForAppDisplay.Get("PlatForm_Scripts_InPatientSearch_js_01");
    var lastPno = ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1);
    $(id).html('');
    if (count != 0) {
        totalCount = count;
        var aFirst, aPrev;
        if (pno == 1) {
            aPrev = $("<a id=\"aP\" style=\"margin-left:5px;\" tabindex=\"12\"></a>");
            
//            if($("[id$='hdnLanguCode']").val()=='id-ID')
//            {
//              $(aPrev).html('Sebelumnya');
//            }
//            else 
//            {
              $(aPrev).html('Prev');
            //}
           
            aFirst = $("<a id=\"aF\" tabindex=\"11\"></a>");
            $(aFirst).html('&lt;&lt;');
        }
        else {
            aPrev = $("<a id=\"aP\" style=\"cursor:pointer;margin-left:5px;\" tabindex=\"12\"></a>");
//            if($("[id$='hdnLanguCode']").val()=='id-ID')
//            {
//              $(aPrev).html('Sebelumnya');
//            }
//            else 
          //  {
              $(aPrev).html('Prev');
         //  }
            $(aPrev).click(function() {
                callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
            });
            $(aPrev).keypress(function() {
                if (event.keyCode == 13) {
                    callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                }
            });
            aFirst = $("<a id=\"aF\" style=\"cursor:pointer;\" tabindex=\"11\"></a>");
            $(aFirst).click(function() {
                callPage(1);
            });

            $(aFirst).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(1);
                }
            });
            aFirst.html('&lt;&lt;');
        }
        $(id).append(aFirst);
        var newSpace1 = $("<span>");
        $(newSpace1).html('&nbsp&nbsp');
        $(id).append(newSpace1);
        $(id).append(aPrev);
        var newSpace2 = $("<span>");
        $(newSpace2).html('&nbsp&nbsp');
        $(id).append(newSpace2);
        if (pno > 2 && (count / 10) > 3) {
            var newDots = $("<span>");
            $(newDots).html('...');
            $(id).append(newDots);
            var newSpace = $("<span>");
            $(newSpace).html('&nbsp&nbsp');
            $(id).append(newSpace);
        }
        for (var i = 1; i <= ((count % 10) == 0 ? (count / 10) : (count / 10) + 1); i++) {
            var forCond1 = (parseInt(pno) + 2);
            if (parseInt(pno) == 1) {
                forCond1 = (parseInt(pno) + 3);
            }
            var forCond2 = parseInt(i) + 2;
            if (parseInt(pno) == parseInt((count % 10) == 0 ? (count / 10) : (count / 10) + 1)) {
                forCond2 = parseInt(i) + 3;
            }
            if ((parseInt(pno)) < forCond2 && forCond1 > parseInt(i)) {
                var newA
                if (pno == i) {
                    newA = $("<a id=\"a" + i + "\" style=\"cursor:pointer;\" tabindex=\"12\"></a>");
                    //$(newA).attr('class', 'Selected');
                    $(newA).addClass('Selected');
                }
                else {
                    newA = $("<a id=\"a" + i + "\" style=\"cursor:pointer;\" tabindex=\"12\"></a>");
                    $(newA).click(function() {
                        var cRow = this.id.split('a')[1];
                        callPage(cRow);
                    });
                    $(newA).keypress(function() {
                        if (event.keyCode == 13) {
                            var cRow = this.id.split('a')[1];
                            callPage(cRow);
                        }
                    });
                }
                $(newA).html(i);
                var newSpace = $("<span></span>");
                $(newSpace).html('&nbsp&nbsp');
                $(id).append(newA);
                $(id).append(newSpace);
            }
        }
        if ((parseInt(pno) + 1) < (count / 10) && (count / 10) > 3) {
            var newDots = $("<span></span>");
            $(newDots).html('...');
            $(id).append(newDots);
            var newSpace = $("<span></span>");
            $(newSpace).html('&nbsp&nbsp');
            $(id).append(newSpace);
        }
        var aLast, aNext;
        if (pno == ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1)) {
            aLast = $("<a style=\"cursor:text;\" id=\"aL\" tabindex=\"13\"></a>");
            $(aLast).html('&gt;&gt;');

            aNext = $("<a id=\"aN\" style=\"margin-right:5px;\" tabindex=\"12\"></a>");
//            if($("[id$='hdnLanguCode']").val()=='id-ID')
//            {
//              $(aNext).html('Selanjutnya');
//            }
//            else 
//            {
               $(aNext).html('Next');
          //  }

        }
        else {
            aLast = $("<a id=\"aL\" style=\"cursor:pointer;margin-right:5px;\" tabindex=\"13\"></a>");
            $(aLast).html('&gt;&gt;');
            $(aLast).click(function() {
                callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
            });
            $(aLast).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                }
            });
            aNext = $("<a id=\"aN\" style=\"cursor:pointer;margin-right:5px;\" tabindex=\"12\"></a>");
//            if($("[id$='hdnLanguCode']").val()=='id-ID')
//            {
//              $(aNext).html('Selanjutnya');
//            }
//            else 
//            {
               $(aNext).html(Next);
         //   }
            $(aNext).click(function() {
                callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
            });
            $(aNext).keypress(function(event) {
                if (event.keyCode == 13) {
                    callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
                }
            });
        }
        $(id).append(aNext);
        var newSpace4 = $("<span></span>");
        $(newSpace4).html('&nbsp&nbsp');
        $(id).append(newSpace4);
        $(id).append(aLast);
    }
}

// Get Registered Date
function GetRegDate() {
    if ($("[id$='ddlRegisterDate'] option:selected").val() != "-1") {
        if ($("[id$='txtFromDate']").val() != "" && $("[id$='txtToDate']").val() != "") {
            fromDate = $("[id$='txtFromDate']").val();
            ToDate = $("[id$='txtToDate']").val();
        }
        else if ($("[id$='txtFromPeriod']").val() != "" && $("[id$='txtToPeriod']").val() != "") {
            fromDate = $("[id$='txtFromPeriod']").val()
            ToDate = $("[id$='txtToPeriod']").val()
        }
        else if ($("[id$='ddlRegisterDate'] option:selected").text() == "Today" || $("[id$='ddlRegisterDate'] option:selected").val() == "4") {
            fromDate = "CurrentFromDate";
            ToDate = "CurrentToDate";
        }
        else {
            fromDate = $("[id$='txtFromDate']").val();
            ToDate = $("[id$='txtToDate']").val();
        }
    }
}

// Get Addmission Date
function GetAddDate() {
    if ($("[id$='ddlAdmissionDate'] option:selected").val() != "-1") {
        if ($("[id$='AdtxtFromDate']").val() != "" && $("[id$='AdtxtToDate']").val() != "") {
            AdfromDate1 = $("[id$='AdtxtFromDate']").val();
            AdToDate1 = $("[id$='AdtxtToDate']").val();
        }
        else if ($("[id$='AdtxtFromPeriod']").val() != "" && $("[id$='AdtxtToPeriod']").val() != "") {
            AdfromDate1 = $("[id$='AdtxtFromPeriod']").val();
            AdToDate1 = $("[id$='AdtxtToPeriod']").val();
        }
        else if ($("[id$='ddlAdmissionDate'] option:selected").text() == "Today" || $("[id$='ddlAdmissionDate'] option:selected").val() == "4") {
            AdfromDate1 = "CurrentFromDate";
            AdToDate1 = "CurrentToDate";
        }
        else {
            AdfromDate1 = $("[id$='AdtxtFromDate']").val();
            AdToDate1 = $("[id$='AdtxtToDate']").val();
        }
    }
}

// Get Insurance Type
function GetType() {

    if ($("[id$='ddlType'] option:selected").text() == "Any") {
        TPAID = "";
        ClientID = "";
    }
    else if ($("[id$='ddlType'] option:selected").text() == "Client") {
        if ($("[id$='ddlCorporate'] option:selected").text() == "All") {
            ClientID = "-1";
            TPAID = "-1";
        }
        else {
            ClientID = $("[id$='ddlCorporate'] option:selected").val();
            TPAID = "-1";
        }
    }
    else if ($("[id$='ddlType'] option:selected").text() == "Insurance") {

        if ($("[id$='ddlTpaName'] option:selected").text() == "All") {
            ClientID = "-1";
            TPAID = "";
        }
        else {
            ClientID = "-1";
            TPAID = $("[id$='ddlTpaName'] option:selected").val();
        }
    }
}

// Get Row Selected Value
function SetRowValue(ele) {
    $("[id$='tbodyIPSearch'] tbody  tr td input:radio").each(function() {
        $(this).prop('checked', false);
    });
    $(ele).prop('checked', true);
    $("[id$='pid']").val($(ele).attr('PID'));
    $("[id$='patOrgID']").val($(ele).attr('orgID'));
    $("[id$='PNumber']").val($(ele).attr('PNO'));
    $("[id$='hdnIsSurgeryPatient']").val($(ele).attr('SP'));
    $("[id$='hdnPatientRegistrationStatus']").val($(ele).attr('PRS'));
    $("[id$='hdnIsSurService']").val($(ele).attr('SurService'));
}

// Click Discharge Image
function MoveToDischarge(ele) {
    var patientID = $(ele).attr('PID');
    if (patientID != '') {
        try {
            $.ajax({
                type: "POST",
                url: "../PlatForm/CommonWebServices/CommonServices.asmx/MoveToDischarge",
                data: "{PID: '" + patientID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function Success(data) {
                    var lstDischarge = data.d;
                    if (lstDischarge == 'alert') {
                        ShowAlertMsg('CommonControls\\\\InPatientSearch.ascx.cs_1');
                    }
                    else {
                        window.location.href = lstDischarge;
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(xhr.status,errorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }
    }
}

//Get QueryString Value
function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}


