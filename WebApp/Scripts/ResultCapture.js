String.prototype.replaceAll = function(targetString, subString) {
    var inputString = this;
    inputString = inputString.replace(new RegExp(targetString, 'gi'), subString); //replace a string globally and case-insensitive

    return (inputString);
};
function CallAllReferenceRangeValidate() {
    try {
        var hdnlstNotYetResolvedRRParams = document.getElementById("hdnlstNotYetResolvedRRParams").value;
        if (hdnlstNotYetResolvedRRParams != null && hdnlstNotYetResolvedRRParams != "") {
            var lst = hdnlstNotYetResolvedRRParams.split('^');
            if (lst != null && lst.length > 0) {

                for (var i = 0; i < lst.length; i++) {
                    var lstChild = lst[i].split(',');
                    var txtValue = lstChild[0];
                    var hdnXmlContent = lstChild[1];
                    var hdnPanicXmlContent = lstChild[2];
                    var DecimalPlaces = lstChild[3];
                    var txtIsAbnormalId = lstChild[4];
                    var AutoApproveLoginId = lstChild[5];
                    var lblNameId = lstChild[6];
                    var lblUnitId = lstChild[7];
                    var Age = lstChild[8];
                    var Gender = lstChild[9];

                    validateResult(txtValue, hdnXmlContent, hdnPanicXmlContent, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
                }
            }
        }
    }
    catch (e) {
        return false;
    }
}
function CheckDeltaValidate(txtid, lbldelta, adeltasym) {
    try {

        var txtvalue = document.getElementById(txtid).value;
        var range = document.getElementById(lbldelta).innerHTML;
        if (txtvalue != undefined && txtvalue != '') {
            if (range != undefined && range != '') {
                var arrrange = range.split("~");
                if (arrrange.length == 2) {
                    if (parseInt(txtvalue) >= parseInt(arrrange[0]) && parseInt(txtvalue) <= parseInt(arrrange[1])) {
                        document.getElementById(adeltasym).style.background = '#008000';
                    }
                    else {
                        document.getElementById(adeltasym).style.background = '#FF0000';
                    }
                }

            }
        }
    }
    catch (e) {
        return false;
    }
}
function validateResult(txtid, xmlrange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender) {
    try {
        var txtidArray = new Array();
        var s = {};
         var lstReferenceRangeValue = document.getElementById("hdnRefrtype").value;
        var newtxtid = document.getElementById("hdnabnormalchange").value;
        document.getElementById("hdnabnormalchange").value = "";
        txtidArray = newtxtid.split("^");

        for (var i = 0; i < txtidArray.length; i++) {
            if (txtid != txtidArray[i]) {
                document.getElementById("hdnabnormalchange").value += txtidArray[i] + '^';
            }
        }
        var txtValue = document.getElementById(txtid).value;
        if (txtValue != null && $.trim(txtValue).length > 0 && !isNaN(txtValue)) {
        document.getElementById(txtid).value = +txtValue;
	  if (DecimalPlaces != null && $.trim(DecimalPlaces).length > 0 && !isNaN(DecimalPlaces)) {
                var decimalPlace = parseInt(DecimalPlaces);
               if (decimalPlace > 0) {
                   document.getElementById(txtid).value = parseFloat(document.getElementById(txtid).value).toFixed(decimalPlace);
              }
            }
		else
		{
	 	document.getElementById(txtid).value = txtValue;
		}
          }

        var pGender;
        var age

        if (Age != '') {
            age = Age;
        }
        else {
            if (document.getElementById('PatientDetail_lblAge') != null) {
                //age = document.getElementById('PatientDetail_lblAge').innerHTML;
                age = document.getElementById('PatientDetail_lblReferenceRangeAge').innerHTML;
            }
            else {
                age = '';
            }
        }
        if (Gender != '') {
            pGender = Gender;
        }
        else {
            if (document.getElementById('PatientDetail_hdnGender') != null) {
                pGender = document.getElementById('PatientDetail_hdnGender').value;
            }
            else {
                pGender = '';
            }
        }

        var rangeValue = document.getElementById(txtid).value;
        if (((document.getElementById(txtid).type == "text" || document.getElementById(txtid).type == "textarea") && document.getElementById(txtid).value == "") || (document.getElementById(txtid).type == "select-one" && document.getElementById(txtid).value == "0")) {
            if (document.getElementById('hdnComputationFieldList') != null && document.getElementById('hdnComputationFieldList').value.indexOf(txtid) >= 0) {
                document.getElementById(txtid).style.background = '#FABF8F';
            }
            else {
                document.getElementById(txtid).style.background = '#FFFFFF';
            }
            document.getElementById(txtIsAbnormalId).style.background = '#FFFFFF';
            var hdnOutOfRangeDetails = document.getElementById("hdnOutOfRangeDetails").value;
            var lstOutOfRangeDetails = {};
            if (hdnOutOfRangeDetails != "") {
                lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
            }
            if (lstOutOfRangeDetails[txtid] != undefined) {
                delete lstOutOfRangeDetails[txtid];
            }
            var hdnHighRangeDetails = document.getElementById("hdnHighRangeDetails").value;
            var lstHighRangeDetails = {};
            if (hdnHighRangeDetails != "") {
                lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
            }
            if (lstHighRangeDetails[txtid] != undefined) {
                lstHighRangeDetails[txtid] = "white";
            }
            document.getElementById("hdnOutOfRangeDetails").value = JSON.stringify(lstOutOfRangeDetails);
            document.getElementById("hdnHighRangeDetails").value = JSON.stringify(lstHighRangeDetails);

            return false;
        }
        arr = age.split(' ');
        pAge = arr[0];
        pAgeType = arr[1];

        if (document.getElementById(txtid).value != '') {
            var xmlContent = document.getElementById(xmlrange).value;
            var panicxmlContent = '';
            if (document.getElementById(panicxmlrange) != null) {
                panicxmlContent = document.getElementById(panicxmlrange).value;
            }

            var lblName = document.getElementById(lblNameId).innerHTML;
            var lblUnit = document.getElementById(lblUnitId).innerHTML;
            var IsExcludeAutoApproval = document.getElementById('hdnIsExcludeAutoApproval').value;
            var hdnOrgID = document.getElementById('hdnOrgID').value;
            if (lblName != null) {
                lblName = lblName.replaceAll("'", "");
            }
            var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + rangeValue + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID;
            //ValidateToXml(data);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/validateAllRange",
                data: "{rawDatas: '" + data + "',JsonStringData: '" + lstReferenceRangeValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function Success(data) {
                    ValidateUserResult(data.d);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    return false;
                }
            });
        }
    }
    catch (e) {
        return false;
    }
}
function ValidateUserResult(arg) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_Header_Alert") != null ? SListForAppMsg.Get("Scripts_Header_Alert") : "Alert";
    var userMsg = SListForAppMsg.Get("Scripts_ResultCapture_js_01") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_01") : "The Entered result value is out of Domain Range";

    try {
        if (arg != '') {
            var oDict = JSON.parse(arg);
            var txtControl = oDict["controlId"];
            var txtColor = oDict["color"];
            var fieldDetails = oDict["fieldDetails"];
            var isOutOfRange = oDict["isOutOfRange"];
            var txtIsAbnormalId = oDict["txtIsAbnormalId"];
            var rangeCode = oDict["rangeCode"];
            var ddlControl = oDict["ddlControlId"];
            var IsSensitive = oDict["IsSensitive"];
            if (document.getElementById(ddlControl) == null || document.getElementById(ddlControl) == undefined) {
                ddlControl = "";
            }
            if (txtColor == "") {
                txtColor = 'white';
            }
            if (rangeCode == "Alert") {
                txtColor = 'white';
                rangeCode = 'white';
                document.getElementById(txtControl).value = '';
                // alert('The Entered result value is out of Domain Range');
                ValidationWindow(userMsg, AlrtWinHdr);
            }
            if (txtColor == 'white') {
                if (document.getElementById('hdnComputationFieldList') != null && document.getElementById('hdnComputationFieldList').value.indexOf(txtControl) >= 0) {
                    document.getElementById(txtControl).style.background = '#FABF8F';
                }
                else {
                    if (txtControl != "") {
                        document.getElementById(txtControl).style.background = txtColor;
                    }
                    if (ddlControl != "") {
                        document.getElementById(ddlControl).style.background = txtColor;
                    }
                }
                document.getElementById(txtIsAbnormalId).style.background = txtColor;
            }
            else {
                if (txtControl != "") {
                    document.getElementById(txtControl).style.background = txtColor;
                }
                if (ddlControl != "") {
                    document.getElementById(ddlControl).style.background = txtColor;
                }
                if (rangeCode != "Auto") {
                    document.getElementById(txtIsAbnormalId).style.background = txtColor;
                }
                else {
                    /* NEED TO SHOW HIDE AutoApprove ICON*/
                    document.getElementById(txtIsAbnormalId).style.background = '#FFFFFF';
                }
            }
            var hdnSensitiveRangeDetails = document.getElementById("hdnSensitiveRangeDetails").value;
            var lstSensitiveRangeDetails = {};
            if (hdnSensitiveRangeDetails != "") {
                lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
            }
            if (txtControl != "") {
                if (lstSensitiveRangeDetails[txtControl] != undefined) {
                    delete lstSensitiveRangeDetails[txtControl];
                }
                lstSensitiveRangeDetails[txtControl] = IsSensitive;
            }
            else {
                if (lstSensitiveRangeDetails[ddlControl] != undefined) {
                    delete lstSensitiveRangeDetails[ddlControl];
                }
                lstSensitiveRangeDetails[ddlControl] = IsSensitive;
            }
            document.getElementById("hdnSensitiveRangeDetails").value = JSON.stringify(lstSensitiveRangeDetails);
            var hdnOutOfRangeDetails = document.getElementById("hdnOutOfRangeDetails").value;
            var lstOutOfRangeDetails = {};
            if (hdnOutOfRangeDetails != "") {
                lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
            }
            var hdnHighRangeDetails = document.getElementById("hdnHighRangeDetails").value;
            var lstHighRangeDetails = {};
            if (hdnHighRangeDetails != "") {
                lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
            }
            if (txtControl != "") {
                if (lstOutOfRangeDetails[txtControl] != undefined) {
                    delete lstOutOfRangeDetails[txtControl];
                }
                if (lstHighRangeDetails[txtControl] != undefined) {
                    delete lstHighRangeDetails[txtControl];
                }
                if (isOutOfRange == "True") {
                    lstOutOfRangeDetails[txtControl] = fieldDetails;
                }
                lstHighRangeDetails[txtControl] = rangeCode;
            }
            else {
                if (lstOutOfRangeDetails[ddlControl] != undefined) {
                    delete lstOutOfRangeDetails[ddlControl];
                }
                if (lstHighRangeDetails[ddlControl] != undefined) {
                    delete lstHighRangeDetails[ddlControl];
                }
                if (isOutOfRange == "True") {
                    lstOutOfRangeDetails[ddlControl] = fieldDetails;
                }
                lstHighRangeDetails[ddlControl] = rangeCode;
            }

            document.getElementById("hdnOutOfRangeDetails").value = JSON.stringify(lstOutOfRangeDetails);
            document.getElementById("hdnHighRangeDetails").value = JSON.stringify(lstHighRangeDetails);
            if(document.getElementById("hdnRuleMedRemarks").value == "Y")
            {
            CalculateGetMedicalRemarks(txtControl,rangeCode);
            }
            
        }
    }
    catch (e) {
        return false;
    }
}

function CalculateGetMedicalRemarks(txtControl,rangeCode) {
    vidctrl = txtControl.split('_')[0] + '_lblPVisitID';
    var TxtMedRemarks = txtControl.split('_')[0] + '_txtMedRemarks';
    var hdnRemarksId = txtControl.split('_')[0] + '_hdnMedicalRemarksID';
    PatientVisitID=document.getElementById(vidctrl).innerHTML;
    var hdnPatientGender = document.getElementById("hdnPatientGender").value;
    var hdnOrgID = document.getElementById('hdnOrgID').value;
    var x = txtControl.split("~");
    var invsplit = x[0];
    var GrpID = x[2];
    var abnormal=rangeCode;
    if(rangeCode='white')
    {
      abnormal='N';
    }
    
    var textvalue = document.getElementById(txtControl).value;
    var txtcrossctrl='';
     var TestResultsRule = [];
     var resval='0';
     var abnmlflag='Test^N';
    $.ajax({
        type: "POST",
        url: "../IntegrationServices.asmx/GetRuleMasterCrossParameter",
        data: "{ 'PatientVisitID': '" + PatientVisitID + "','GroupID': '" + GrpID + "','InvID': '" + invsplit + "','OrgID': '" + hdnOrgID + "','value': '" + textvalue + "','IsAbnormal': '" + abnormal + "','Gender': '" + hdnPatientGender + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(result) {
             if(result.d.length>0)
             {
                jQuery.each( result.d, function( i, val1 ) {
                resval=val1.ResultValue.toString();
                abnmlflag=val1.ResultInvestigation.toString();
                txtcrossctrl=txtControl.replace(invsplit,val1.ResultInvestigationID.toString());
                txtoldacc=txtControl.split('~')[5].split('_')[0];
                if($('[id*='+val1.ResultInvestigationID.toString()+']').length>0)
                {
                    abnmlflag='Test^N';
                    var accessionnumber= $('[id*='+val1.ResultInvestigationID.toString()+']')[0].id.split('~')[5].split('_')[0];
                    txtcrossctrl=txtcrossctrl.replace(txtoldacc,accessionnumber);
                    if(document.getElementById(txtcrossctrl).value!=undefined)
                    {
                    resval=document.getElementById(txtcrossctrl).value;    
                    } 
                    if(document.getElementById(txtcrossctrl).style.background!=undefined)
                    {
                        if(document.getElementById(txtcrossctrl).style.background =='red')
                        {
                          abnmlflag='Test^P';
                        }  
                        if(document.getElementById(txtcrossctrl).style.background =='yellow')
                        {
                          abnmlflag='Test^A';
                        }  
                        if(document.getElementById(txtcrossctrl).style.background =='lightpink')
                        {
                          abnmlflag='Test^L';
                        }  
                    } 
                }           
                TestResultsRule.push({
                                    TestResultsRuleId:val1.TestResultsRuleId,
                                    RuleMasterId:val1.RuleMasterId,
                                    ComponentName:'Test Result',
                                    ResultInvestigationID:val1.ResultInvestigationID,
                                    ResultInvestigation:abnmlflag,
                                    ResultType:'',
                                    ResultOptr:'',
                                    ResultValue1:'',
                                    Resultvalue2:'',
                                    ResultValue:resval,
                                    LogicalOperator:'',
                                    RemarksId:0
                                    });
                });
             }
        }
    });

    
    //lblPVisitID    
    var RemarksDetails = "";
    $.ajax({
        type: "POST",
        url: "../IntegrationServices.asmx/GetRuleMasterMedicalRemarks",
        data: "{ 'PatientVisitID': '" + PatientVisitID + "','GroupID': '" + GrpID + "','InvID': '" + invsplit + "','OrgID': '" + hdnOrgID + "','value': '" + textvalue + "','IsAbnormal': '" + abnormal + "','Gender': '" + hdnPatientGender + "','StrTestResultsRule':'"+JSON.stringify(TestResultsRule)+"'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {

            if (data.d.trim() != '') {
                RemarksDetails = data.d;
            }
        }
    });


    if (RemarksDetails.split('~').length>0 && RemarksDetails.split('~')[1] != '') {
        
            document.getElementById(TxtMedRemarks).value = RemarksDetails.split('~')[1];
           document.getElementById(hdnRemarksId).value = RemarksDetails.split('~')[0]; 
            //document.getElementById(hdnmedicalRemarks).value = MedicalRemarksList[0].RemarksID;
          
    }
   // else {
      //  document.getElementById(TxtMedRemarks).value = "";
      //  document.getElementById(hdnRemarksId).value="0";
        // document.getElementById(hdnmedicalRemarks).value = 0;
   // }
}

function onChangingIsAbnormal(txtIsAbnormalId, txtid, ddlid, xmlrange, panicxmlrange, lblNameId, lblUnitId) {

    var AlrtWinHdr = SListForAppMsg.Get("Scripts_Header_Alert") != null ? SListForAppMsg.Get("Scripts_Header_Alert") : "Alert";
    var userMsg = SListForAppMsg.Get("Scripts_ResultCapture_js_02") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_02") : "Resetting abnormal flag due to empty result";
    try {
        if ((document.getElementById(txtid).type == "text" && document.getElementById(txtid).value == "") || (document.getElementById(txtid).type == "select-one" && document.getElementById(txtid).value == "0")) {
            //alert("Resetting abnormal flag due to empty result");
            ValidationWindow(userMsg, AlrtWinHdr);
            document.getElementById(txtIsAbnormalId).style.background = '#FFFFFF';
        }
        else {
            var lblName = document.getElementById(lblNameId).innerHTML;
            var lblUnit = document.getElementById(lblUnitId).innerHTML;
            var oDict = {};
            var txtColor = "white";
            var fieldDetails = lblName + " : " + document.getElementById(txtid).value + " " + lblUnit + "<br>";
            var isOutOfRange = "False";
            var rangeCode = "N";
            var backColor = document.getElementById(txtIsAbnormalId).style.backgroundColor;
            if (backColor == "white") {
                txtColor = "lightpink";
                isOutOfRange = "True";
                rangeCode = "L";
            }
            else if (backColor == "lightpink") {
                txtColor = "Yellow";
                isOutOfRange = "True";
                rangeCode = "A";
            }
            else if (backColor == "yellow") {
                txtColor = "Red";
                isOutOfRange = "True";
                rangeCode = "P";
            }

            oDict["controlId"] = txtid;
            oDict["color"] = txtColor;
            oDict["fieldDetails"] = fieldDetails;
            oDict["isOutOfRange"] = isOutOfRange;
            oDict["txtIsAbnormalId"] = txtIsAbnormalId;
            oDict["rangeCode"] = rangeCode;
            oDict["ddlControlId"] = ddlid;
            oDict["IsSensitive"] = "N";
            ValidateUserResult(JSON.stringify(oDict));
            //            var hdnabnormalchangelist = {};
            //            hdnabnormalchangelist + = txtid;
            document.getElementById("hdnabnormalchange").value += txtid + '^';
            var hdn = document.getElementById("hdnabnormalchange").value;

        }
        return false;
    }
    catch (e) {
        return false;
    }
}
function LoadAbnormalValue(txtControl, ddlControl, rangeCode, testName, testUOM) {
    try {
        var hdnHighRangeDetails = document.getElementById("hdnHighRangeDetails").value;
        var lstHighRangeDetails = {};
        if (hdnHighRangeDetails != "") {
            lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
        }
        if (txtControl != "") {
            if (lstHighRangeDetails[txtControl] == undefined) {
                lstHighRangeDetails[txtControl] = rangeCode;
            }
        }
        else {
            if (lstHighRangeDetails[ddlControl] == undefined) {
                lstHighRangeDetails[ddlControl] = rangeCode;
            }
        }
        document.getElementById("hdnHighRangeDetails").value = JSON.stringify(lstHighRangeDetails);

        var hdnOutOfRangeDetails = document.getElementById("hdnOutOfRangeDetails").value;
        var lstOutOfRangeDetails = {};
        if (hdnOutOfRangeDetails != "") {
            lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
        }
        if (txtControl != "") {
            if (lstOutOfRangeDetails[txtControl] != undefined) {
                delete lstOutOfRangeDetails[txtControl];
            }
        }
        else {
            if (lstOutOfRangeDetails[ddlControl] != undefined) {
                delete lstOutOfRangeDetails[ddlControl];
            }
        }
        if (txtControl != "") {
            if (ddlControl != "") {
                var objDDL = document.getElementById(ddlControl);
                var txtValue = document.getElementById(txtControl).value != "" ? document.getElementById(txtControl).value : "";
                lstOutOfRangeDetails[txtControl] = testName + " : " + objDDL.options[objDDL.selectedIndex].text + " " + testUOM + "<br>";
            }
            else {
                lstOutOfRangeDetails[txtControl] = testName + " : " + document.getElementById(txtControl).value + " " + testUOM + "<br>";
            }
        }
        else {
            var objDDL = document.getElementById(ddlControl);
            lstOutOfRangeDetails[ddlControl] = testName + " : " + objDDL.options[objDDL.selectedIndex].text + " " + testUOM + "<br>";
        }
        document.getElementById("hdnOutOfRangeDetails").value = JSON.stringify(lstOutOfRangeDetails);
    }
    catch (e) {
        return false;
    }
}
function LoadAbnormalValue(txtControl, ddlControl, rangeCode, testName, testUOM, IsAutoAuthorize) {
    try {
        var hdnHighRangeDetails = document.getElementById("hdnHighRangeDetails").value;
        var lstHighRangeDetails = {};
        if (hdnHighRangeDetails != "") {
            lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
        }
        if (rangeCode == 'N') {
            rangeCode = 'white';
        }
        if (IsAutoAuthorize == 'Y') {
            if (rangeCode == 'A') {
                rangeCode = 'AutoA';
            }
            else if (rangeCode == 'P') {
                rangeCode = 'AutoP';
            }
            else if (rangeCode == 'L') {
                rangeCode = 'AutoL';
            }
            else {
                rangeCode = 'Autowhite';
            }
        }
        if (txtControl != "") {
            if (lstHighRangeDetails[txtControl] == undefined) {
                lstHighRangeDetails[txtControl] = rangeCode;
            }
        }
        else {
            if (lstHighRangeDetails[ddlControl] == undefined) {
                lstHighRangeDetails[ddlControl] = rangeCode;
            }
        }
        document.getElementById("hdnHighRangeDetails").value = JSON.stringify(lstHighRangeDetails);

        var hdnOutOfRangeDetails = document.getElementById("hdnOutOfRangeDetails").value;
        var lstOutOfRangeDetails = {};
        if (hdnOutOfRangeDetails != "") {
            lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
        }
        if (txtControl != "") {
            if (lstOutOfRangeDetails[txtControl] != undefined) {
                delete lstOutOfRangeDetails[txtControl];
            }
        }
        else {
            if (lstOutOfRangeDetails[ddlControl] != undefined) {
                delete lstOutOfRangeDetails[ddlControl];
            }
        }
        if (txtControl != "") {
            if (ddlControl != "") {
                var objDDL = document.getElementById(ddlControl);
                var txtValue = document.getElementById(txtControl).value != "" ? document.getElementById(txtControl).value : "";
                lstOutOfRangeDetails[txtControl] = testName + " : " + objDDL.options[objDDL.selectedIndex].text + " " + testUOM + "<br>";
            }
            else {
                lstOutOfRangeDetails[txtControl] = testName + " : " + document.getElementById(txtControl).value + " " + testUOM + "<br>";
            }
        }
        else {
            var objDDL = document.getElementById(ddlControl);
            lstOutOfRangeDetails[ddlControl] = testName + " : " + objDDL.options[objDDL.selectedIndex].text + " " + testUOM + "<br>";
        }
        document.getElementById("hdnOutOfRangeDetails").value = JSON.stringify(lstOutOfRangeDetails);
    }
    catch (e) {
        return false;
    }
}
function checkreasonifempty(id, hdnid) {
    try {
        var values = document.getElementById(id).value;
        var texts = document.getElementById(id).options[document.getElementById(id).selectedIndex].text;
        document.getElementById(hdnid).value = values + '~' + texts;
    }
    catch (e) {
        return false;
    }
}
function onChangeOpinionUser(id, hdnid) {
    try {
        var values = document.getElementById(id).value;
        document.getElementById(hdnid).value = values;
    }
    catch (e) {
        return false;
    }
}
function expandBox(id) {
    try {
        if (document.getElementById(id).value != '') {
            document.getElementById(id).style.height = "80px";
        }
    }
    catch (e) {
        return false;
    }
}
function collapseBox(id) {
    try {
        document.getElementById(id).style.height = "30px";
    }
    catch (e) {
        return false;
    }
}
function SelectedRemarksGrpTech(source, eventArgs) {
    try {
        RemarksDetails = eventArgs.get_value();
        var arrValue = RemarksDetails.split("~");
        if (document.getElementById('hdnAppTechRemarksID' + '~' + arrValue[0]) != null) {
            document.getElementById('hdnAppTechRemarksID' + '~' + arrValue[0]).value = RemarksDetails;
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    catch (e) {
        return false;
    }
}
function GetInvMedicalRemarksGrpMed(source, eventArgs) {
    try {
        RemarksDetails = eventArgs.get_value();
        var arrValue = RemarksDetails.split("~");
        if (document.getElementById('hdnAppMedRemarksID' + '~' + arrValue[0]) != null) {
            document.getElementById('hdnAppMedRemarksID' + '~' + arrValue[0]).value = RemarksDetails;
            document.getElementById('hdnInvMedRemGrpIDList').value = document.getElementById('hdnInvMedRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    catch (e) {
        return false;
    }
}
function showDeltaTableGraph(plusImg, minusImg, responses, status) {
    try {
        var obj1 = document.getElementById(plusImg);
        var obj2 = document.getElementById(minusImg);
        var obj3 = document.getElementById(responses);
        if (status == 1) {
            document.getElementById('trDeltaGraph').style.display = 'block';
            document.getElementById('trDeltaTable').style.display = 'none';
            document.getElementById('btnSetValues').style.display = 'none';
            obj2.style.display = 'block';
            obj1.style.display = 'none';
        }
        else {
            document.getElementById('trDeltaGraph').style.display = 'none';
            document.getElementById('trDeltaTable').style.display = 'block';
            document.getElementById('btnSetValues').style.display = 'block';
            obj2.style.display = 'none';
            obj1.style.display = 'block';
        }
    }
    catch (e) {
        return false;
    }
}
function txtBoxValidation() {
    try {
        if (document.getElementById('txtSearchTxt').value == '') {
            //alert('Provide patient visit number to search');
            document.getElementById('txtSearchTxt').focus();
            return false;
        }
        return true;
    }
    catch (e) {
        return false;
    }
}
function getFocus() {
    try {
        document.getElementById('txtSearchTxt').focus();
    }
    catch (e) {
        return false;
    }
}
function setDropdownValues(ddlid, hdnid, dbValue) {
    try {
        var DDLValues = '';
        var isExists = false;
        var isDDLOptionExists = false;
        if (document.getElementById('hdnDDLValues') != null) {
            DDLValues = document.getElementById('hdnDDLValues').value;
            var lstDDLValues = DDLValues.split('^');
            for (var i = 0; i < lstDDLValues.length; i++) {
                if (lstDDLValues[i] != null && lstDDLValues[i].indexOf(ddlid) >= 0) {
                    var ddlValue = lstDDLValues[i].split('|')[1];
                    var senderDDL = document.getElementById(ddlid);
                    for (var i = 0; i < senderDDL.options.length; i++) {
                        if (senderDDL.options[i].text === ddlValue) {
                            senderDDL.selectedIndex = i;
                            isDDLOptionExists = true;
                            break;
                        }
                    }
                    if (isDDLOptionExists) {
                        document.getElementById(hdnid).value = ddlValue;
                    }
                    isExists = true;
                    break;
                }
            }
        }
        if (!isExists) {
            isDDLOptionExists = false;
            var senderDDL = document.getElementById(ddlid);
            for (var i = 0; i < senderDDL.options.length; i++) {
                if (senderDDL.options[i].text == dbValue.trim()) {
                    senderDDL.selectedIndex = i;
                    isDDLOptionExists = true;
                    break;
                }
            }
            if (isDDLOptionExists) {
                document.getElementById(hdnid).value = dbValue;
                document.getElementById('hdnDDLValues').value = document.getElementById('hdnDDLValues').value + ddlid + '|' + dbValue + '^';
            }
        }
    }
    catch (e) {
        return false;
    }
}
function appendDDLHdn(ddlid, hdnid) {
    try {
        var senderDDL = document.getElementById(ddlid);
        var senderHDN = document.getElementById(hdnid);
        document.getElementById(hdnid).value = senderDDL.options[senderDDL.selectedIndex].text;
        var DDLValues = '';
        var isExists = false;
        var existingValue = '';
        if (document.getElementById('hdnDDLValues') != null) {
            DDLValues = document.getElementById('hdnDDLValues').value;
            var lstDDLValues = DDLValues.split('^');
            for (var i = 0; i < lstDDLValues.length; i++) {
                if (lstDDLValues[i] != null && lstDDLValues[i].indexOf(ddlid) >= 0) {
                    document.getElementById('hdnDDLValues').value = document.getElementById('hdnDDLValues').value.replace(lstDDLValues[i] + "^", "").replace(lstDDLValues[i], "");
                    break;
                }
            }
        }
        document.getElementById('hdnDDLValues').value = document.getElementById('hdnDDLValues').value + ddlid + '|' + senderDDL.options[senderDDL.selectedIndex].text + '^';

    }
    catch (e) {
        return false;
    }
}
function formatResult(txtid, DecimalPlaces) {
    try {
        var txtValue = document.getElementById(txtid).value;
        if (txtValue != null && $.trim(txtValue).length > 0 && !isNaN(txtValue)) {
            document.getElementById(txtid).value = +txtValue;
            if (DecimalPlaces != null && $.trim(DecimalPlaces).length > 0 && !isNaN(DecimalPlaces)) {
                var decimalPlace = parseInt(DecimalPlaces);
                if (decimalPlace > 0) {
                    document.getElementById(txtid).value = parseFloat(document.getElementById(txtid).value).toFixed(decimalPlace);
                }
            }
        }
    }
    catch (e) {
        return false;
    }
}
function changeGroupComment(x, GrpName, CtlGrpCmtID, vRemarkCtl, vMedRemarkCtl) {
    try {
        var Arraymain = new Array()
        Arraymain = x.split('_');
        document.getElementById("groupCommentDIV").style.display = "block";
        document.getElementById("groupCommentLBL").innerHTML = GrpName;
        document.getElementById("groupCommentHDN").value = GrpName + '~' + x;

        document.getElementById("groupMedCommentHDN").value = GrpName + "~" + x + "~" + "_Med";
        document.getElementById("txtGrpCommentMed").value = "";

        document.getElementById("groupCommentTXT").value = "";
        document.getElementById("groupCommentTXT").focus();

        var vContextKey = document.getElementById(CtlGrpCmtID).value;
        $find('AutoCompleteExtender1').set_contextKey(vContextKey);
        $find('AutoCompleteExtender2').set_contextKey(vContextKey);

        if (document.getElementById(vRemarkCtl) != null && document.getElementById(vRemarkCtl).value != '') {
            document.getElementById('groupCommentTXT').value = document.getElementById(vRemarkCtl).value;
        }
        if (document.getElementById(vRemarkCtl) != null) {
            document.getElementById('hdnGrpTechRemChangedCtl').value = document.getElementById(vRemarkCtl).id;
        }

        if (document.getElementById(vMedRemarkCtl) != null && document.getElementById(vMedRemarkCtl).value != '') {
            document.getElementById('txtGrpCommentMed').value = document.getElementById(vMedRemarkCtl).value;
        }
        if (document.getElementById(vMedRemarkCtl) != null) {
            document.getElementById('hdnGrpMedRemChangedCtl').value = document.getElementById(vMedRemarkCtl).id;
        }
    }
    catch (e) {
        return false;
    }
}
function setGroupComment() {
    try {
        //InvRemarks
        var vtechCtrl = document.getElementById('hdnGrpTechRemChangedCtl').value;
        var vmedCtrl = document.getElementById('hdnGrpMedRemChangedCtl').value;
        if (vtechCtrl != null && vtechCtrl != '') {
            document.getElementById(vtechCtrl).value = document.getElementById('groupCommentTXT').value;
        }
        if (vmedCtrl != null && vmedCtrl != '') {
            document.getElementById(vmedCtrl).value = document.getElementById('txtGrpCommentMed').value;
        }
        //InvRemarks

        z = document.getElementById("groupCommentHDN").value;
        var Arraymain = new Array()
        Arraymain = z.split('~');
        document.getElementById("groupCommentHDN1").value += Arraymain[0].trim() + "~" + document.getElementById("groupCommentTXT").value + "^";
        document.getElementById("groupCommentTXT").value = "";

        document.getElementById("groupMedCommentHDN1").value += Arraymain[0].trim() + "~" + document.getElementById("txtGrpCommentMed").value + "^";
        document.getElementById("txtGrpCommentMed").value = "";

        document.getElementById("groupCommentDIV").style.display = "none";
    }
    catch (e) {
        return false;
    }
}
function setGroupCommentClose() {
    try {
        document.getElementById("groupCommentDIV").style.display = "none";
    }
    catch (e) {
        return false;
    }
}
function GetQCValue(Qcvalue) {
    ValidationWindow("QC Value is '" + Qcvalue + "'", "QC Value");
}
function GetDeviceValue(OrgId, VisitId, InvestigationID) {

    var AlrtWinHdr = SListForAppMsg.Get("Scripts_Header_Alert") != null ? SListForAppMsg.Get("Scripts_Header_Alert") : "Alert";
    var userMsg = SListForAppMsg.Get("Scripts_ResultCapture_js_03") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_03") : "Device value for  ";
    var userMsg1 = SListForAppMsg.Get("Scripts_ResultCapture_js_04") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_04") : "  is  ";
    var userMsg2 = SListForAppMsg.Get("Scripts_ResultCapture_js_05") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_05") : " \nError Code: ";
    var userMsg3 = SListForAppMsg.Get("Scripts_ResultCapture_js_06") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_06") : " \nError Description: ";
    var userMsg4 = SListForAppMsg.Get("Scripts_ResultCapture_js_07") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_07") : " No Device Value Found ";

    try {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetDeviceValue",
            data: "{OrgId: " + OrgId + ", VisitId:'" + VisitId + "', InvestigationID:'" + InvestigationID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function Success(data) {
                var lstDeviceValue = data.d;
                if (lstDeviceValue.length > 0) {
                    $.each(lstDeviceValue, function(i, obj) {
                        ValidationWindow(userMsg + obj.Name + userMsg1 + obj.DeviceValue + userMsg2 + obj.ErrorCode + userMsg3 + obj.ErrorDescription, AlrtWinHdr);

                        //alert("Device value for " + obj.Name + " is " + obj.DeviceValue + "\nError Code: " + obj.ErrorCode + "\nError Description: " + obj.ErrorDescription);
                    });
                }
                else {
                    //alert("No Device Value Found");
                    ValidationWindow(userMsg4, AlrtWinHdr);
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                //alert(xhr.status);
                ValidationWindow(xhr.status, AlrtWinHdr);
            }
        });
    }
    catch (e) {
        return false;
    }
}
function changedstatus(id, reasonid) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_Header_Alert") != null ? SListForAppMsg.Get("Scripts_Header_Alert") : "Alert";
    var userMsg = SListForAppMsg.Get("Scripts_ResultCapture_js_08") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_08") : "Recollect is not allowed more than twice ";
    var userMsg1 = SListForAppMsg.Get("Scripts_ResultCapture_js_09") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_09") : "Ordered test should not be reflexed ";
    var userMsgError = SListForAppMsg.Get("Scripts_ResultCapture_js_11") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_11") : "New Error ";

    try {
        var values = document.getElementById(id).value.split("_");
        var roleName = document.getElementById('hdnRoleName').value;
        var RoleID = document.getElementById('hdnRoleID').value;

        var pType = id.split('~')[2];
        if (pType != undefined && pType != null && pType != '0') {
            var parentType = 'Grp';
            var parentId = id.split('~')[3];
        }
        else {
            parentType = 'Inv';
            parentId = id.split('~')[0];
        }
        var AccNo = id.split('~')[5];
        if (AccNo != undefined || AccNo != null) {
            var AccessionNumber = AccNo.split("_")[0];
        }
        else {
            AccNo = id.split('~')[4];
            AccessionNumber = AccNo.split("_")[0];
        }

        var Vid;
        var ClientId;
        var Gender;
        var ctrID = id.split('_')[0];
        if (document.getElementById('PatientDetail_hdnVID') != null) {
            Vid = document.getElementById('PatientDetail_hdnVID').value;
            ClientId = document.getElementById('PatientDetail_hdnClientID').value;
            Gender = document.getElementById('PatientDetail_hdnGender').value;
        }
        else {
            if (document.getElementById(ctrID + '_lblPVisitID') != null) {
                Vid = document.getElementById(ctrID + '_lblPVisitID').innerHTML;
            }
            if (document.getElementById(ctrID + '_hdnClientID') != null) {
                ClientId = document.getElementById(ctrID + '_hdnClientID').value;
            }
            if (document.getElementById(ctrID + '_lblSex') != null) {
                Gender = document.getElementById(ctrID + '_lblSex').innerHTML;
            }
        }

        var OrgID = document.getElementById('hdnOrgID').value;

        var gen = '';

        if (Gender == "Male") {
            gen = "M";
        }
        else if (Gender = "Female") {
            gen = "F";
        }
        var InvId = id.split('~')[0];

        if (values[0] == "Retest") {
            chkRecollectCount(Vid, parentId, OrgID, roleName, id);
        }

        if (values[0] == "Retest" && document.getElementById('hdnRecollectCountFlag').value == "1") {
            //alert('Recollect is not allowed more than twice');
            ValidationWindow(userMsg, AlrtWinHdr);
            document.getElementById('hdnRecollectCountFlag').value = 0;
            return false;
        }
        if (values != null && values.length > 1) {
            if (values[0] == "Co-authorize" || values[0] == "Second Opinion") {
                var ddlcoauthId = id.replace("ddlstatus", "ddlOpinionUser");
                var ddlcoauth = document.getElementById(ddlcoauthId);
               // if ($('input[id$="hdnLstCoAuthorizeUser"]').val().length > 0) {
                    lstCoAuthorizeUser = getuserByrole(OrgID, RoleID);
                   // var lstCoAuthorizeUser = JSON.parse($('input[id$="hdnLstCoAuthorizeUser"]').val());
                    

                                    
                    ddlcoauth.options.length = 1;
                    $.each(lstCoAuthorizeUser, function(i, obj) {
                        newListItem = document.createElement("option");
                        ddlcoauth.options.add(newListItem);
                        newListItem.text = obj.Name;
                        newListItem.value = obj.LoginID;
                    });
                //}
            }
            //Added By Arivalagan.kk//For SynopticTest //
            else if (values[0] == "Synoptic") {
                var DispConf = SListForAppMsg.Get("Scripts_ResultCapture_js_10") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_10") : "Do you want to proceed with Synoptic Test?? ";
                var OkMsg = SListForAppMsg.Get('Scripts_Ok') == null ? "OK" : SListForAppMsg.Get('Scripts_Ok');
                var CancelMsg = SListForAppMsg.Get('Scripts_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Scripts_Cancel');
                //var Information = SListForAppMsg.Get('Scripts_Information') == null ? "Information" : SListForAppMsg.Get('Scripts_Information');
                var error = SListForAppMsg.Get('Scripts_Error') == null ? "Alert" : SListForAppMsg.Get('Scripts_Error');
                //                var ans = window.confirm('Do you want to proceed with Reflex Test??');

                var sval1;
                var prefixText = '';
                sval = OrgID;
                var lstPreviousInvestigations = [];
                var lstTotalItems = [];
                var ArrayItems;
                var Items;
                var SamplesItems;
                var TotalItems;
                var OrderedSynoptictest = 0;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../OPIPBilling.asmx/GetPatientOrderedInvestigation",
                    data: JSON.stringify({ prefixText: prefixText, contextKey: 'INV' + '~' + Vid + '~' + InvId + '~' + AccessionNumber + '~'
                        + parentType
                    }),
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        ArrayItems = data.d;
                        TotalItems = ArrayItems[2];
                        if (TotalItems.length > 0) {
                            for (var i = 0; i < TotalItems.length; i++) {
                                if (TotalItems[i].ID == InvId && TotalItems[i].ReferredType == 'SynopticTest') {
                                    ValidationWindow("Synoptic test cannot be ordered for a synoptic parameter", AlrtWinHdr);
                                    if (roleName == "Lab Technician") {
                                        setCompleteStatus(id);
                                        OrderedSynoptictest = 1;
                                        return false;
                                    }
                                    else {
                                        setValidateStatus(id);
                                        OrderedSynoptictest = 1;
                                        return false;
                                    }
                                }
                            }
                        }
                    },
                    error: function(result) {
                        // alert("New Error");
                        ValidationWindow(userMsgError, AlrtWinHdr);
                    }
                });

                if (OrderedSynoptictest == 0) {
                    var ans = ConfirmWindow(DispConf, error, OkMsg, CancelMsg);
                    if (ans == true) {
                        document.getElementById('ucSynopticTest_hdnDisableDropDown').value = id;
                        document.getElementById('ucSynopticTest_hdnSynopticType').value = values[0];
                        $('#ucSynopticTest_hdnTotalItems').val('');
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../OPIPBilling.asmx/GetPatientOrderedInvestigation",
                            data: JSON.stringify({ prefixText: prefixText, contextKey: 'INV' + '~' + Vid + '~' + InvId + '~' + AccessionNumber + '~'
                        + parentType
                            }),
                            dataType: "json",
                            async: false,
                            success: function(data) {
                                ArrayItems = data.d;
                                Items = ArrayItems[0];
                                SamplesItems = ArrayItems[1];
                                TotalItems = ArrayItems[2];
                                if (TotalItems[0].InvestigationName == 'OrderedTest') {
                                    //alert('Ordered test should not be reflexed');
                                    ValidationWindow(userMsg1, AlrtWinHdr);
                                    if (roleName == "Lab Technician") {
                                        setCompleteStatus(id);
                                        return false;
                                    }
                                    else {
                                        setValidateStatus(id);
                                        return false;
                                    }
                                }
                                if (TotalItems.length > 0) {
                                    $('#ucSynopticTest_hdnTotalItems').val(JSON.stringify(TotalItems));
                                }
                                $('#ucSynopticTest_grdSynopticTestOrderedInv tbody tr').children().remove();
                                if (TotalItems.length > 0) {
                                    var list = TotalItems;
                                    if (list.length > 0) {
                                        $("#ucSynopticTest_grdSynopticTestOrderedInv").append("<tr class='dataheader1'><td><span id='lblSelect' align='left'>Select</span></td><td><span id ='lblInvestName'>Investigation Name</span></td><td><span id ='lblPatStatus'>Status</span></td><td style='display:none';><span id='lblGroupID' align='left'>GroupID</span></td></tr>");
                                        for (var i = 0; i < list.length; i++) {
                                            var AccessionNumber = list[i].AccessionNumber;
                                            var InvestigationName = list[i].InvestigationName;
                                            var Status = list[i].Status;
                                            var ID = list[i].ID;
                                            var UID = list[i].UID;
                                            var LabNo = list[i].LabNo;
                                            var GroupID = list[i].GroupID;
                                            if (InvId == ID) {
                                                $("#ucSynopticTest_grdSynopticTestOrderedInv").append("<tr style='background-color:#F9B7FF;'><td><input type='radio' id='rdSynopticSelinv' checked='checked' onclick='SynopticTestSelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                            }
                                            else {
                                                $("#ucSynopticTest_grdSynopticTestOrderedInv").append("<tr style='background-color:#F9B7FF; display:none'><td><input type='radio' id='rdSynopticSelinv' onclick='SynopticTestSelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                            }
                                            $('#ucSynopticTest_grdSynopticTestOrderedInv').css('visibility', 'visible');

                                            if (InvId == ID) {
                                                $('#ucSynopticTest_grdSynopticTestOrderedInv tbody tr:not(:first)').each(function(i, n) {
                                                    var $row = $(n);
                                                    var AccessionNo = $row.find($('span[id$="lblAccNo"]')).html();
                                                    var ParentInvName = $row.find($('span[id$="lblInvName"]')).html();
                                                    var ParentStatus = $row.find($('span[id$="lblStatus"]')).html();
                                                    var Vid1 = Vid;
                                                    document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value = AccessionNo;
                                                    document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value = ParentInvName;
                                                    document.getElementById('ucSynopticTest_hdnParentInvID').value = ID;
                                                    document.getElementById('ucSynopticTest_hdnStatus').value = ParentStatus;
                                                    document.getElementById('ucSynopticTest_hdnVID').value = Vid;
                                                    document.getElementById('ucSynopticTest_hdnUID').value = UID;
                                                    document.getElementById('ucSynopticTest_hdnLabNo').value = LabNo;
                                                    sval1 = "COMSynoptic" + '~' + ClientId + '~' + '~' + '~' + '' + gen;
                                                    $find('ucSynopticTest_AutoCompleteExtender1').set_contextKey(sval1);
                                                });
                                            }
                                            document.getElementById('ucSynopticTest_btnAddSynopticTest').style.display = 'block';
                                            document.getElementById('ucSynopticTest_btnSaveSynopticTest').style.display = 'block';
                                            lstPreviousInvestigations.push({
                                                AccessionNumber: AccessionNumber,
                                                InvestigationName: InvestigationName,
                                                Status: Status,
                                                Id: ID
                                            });
                                            if (lstPreviousInvestigations.length > 0) {
                                                $('#hdnLstInvestigationQueue').val(JSON.stringify(lstPreviousInvestigations));
                                                showSynopticTestPopUp();
                                                document.getElementById('ucSynopticTest_btnSaveSynopticTest').style.display = 'none';
                                            }
                                            else {
                                                hideSynopticTestPopUp();
                                            }
                                        }
                                    }
                                }
                                if (ArrayItems[1].length > 0) {
                                    var list = ArrayItems[1];
                                    if (list.length > 0) {
                                        $('#ucSynopticTest_grdSynopticTestINV').children().remove();
                                        var RowsCount = $("#ucSynopticTest_grdSynopticTestINV tr").length;
                                        if (RowsCount == 0) {
                                            $("#ucSynopticTest_grdSynopticTestINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>ID</span></td><td><span id='lblName'>SynopticTest Investigation</span></td><td><span id ='lbltype'>Type</span></td><td><span id ='lblParentINVName'>Parent Investigation</span></td><td><span id ='lblReferredType'>Referred Type</span></td><td><span id='lblIsReportable'>IsReportable</span></td><td><span id='lblIsBillable'>IsBillable</span></td><td style='display:none';><span id='lblAccNo'>AccessionNumber</span></td><td><span id ='lblDelete'>Delete</span></td></tr>");
                                        }
                                        for (var i = 0; i < list.length; i++) {
                                            var ParentID = list[i].ID;
                                            var ChildID = list[i].InvestigationID;
                                            var ParentName = list[i].PerformingPhysicain;
                                            var ChildName = list[i].Name;
                                            var Type = list[i].Type;
                                            var IsReportable = list[i].InvestigationsType;
                                            var IsBillable = list[i].Isbillable;
                                            document.getElementById('ucSynopticTest_hdnParentInvID').value = ParentID;
                                            document.getElementById('ucSynopticTest_hdnSynopticID').value = ChildID;
                                            document.getElementById('ucSynopticTest_hdnSynopticName').value = ParentName;
                                            document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value = 'INV';
                                            document.getElementById('ucSynopticTest_btnAddSynopticTest').style.display = 'block';
                                            document.getElementById('ucSynopticTest_btnSaveSynopticTest').style.display = 'block';
                                            $("#ucSynopticTest_grdSynopticTestINV").append("<tr id=tr_"
                                        + ChildID + "><td style='display:none';><span id='lblinvID'>"
                                        + ChildID + "</span></td><td><span id='lblName'>"
                                        + ChildName + "</td></span><td><span id ='lbltype'>"
                                        + 'INV' + "</span></td><td><span id ='lblparentInvName'>"
                                        + ParentName + "</span></td><td><span id ='lblReflexType'>"
                                        + document.getElementById('ucSynopticTest_hdnSynopticType').value
                                        + "</span></td><td><span id ='lblIsReportable'>"
                                        + IsReportable + "</span></td><td><span id ='lblIsBillable'>"
                                        + IsBillable + "</span></td><td style='display:none';><span id ='lblAccNo'>"
                                        + document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value
                                        + "</span></td><td><input id=td_" + ChildID
                                        + " onclick=deleteRow(this); value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'><input type='hidden' id='hdnUID' value='"
                                        + document.getElementById('ucSynopticTest_hdnUID').value
                                        + "'><input type='hidden' id='hdnLabNo' value='" + document.getElementById('ucSynopticTest_hdnLabNo').value
                                        + "'><input type='hidden' id='hdnVID' value='" + document.getElementById('ucSynopticTest_hdnVID').value + "'></td></tr>");
                                        }
                                    }
                                }
                            },
                            error: function(result) {
                                // alert("New Error");
                                ValidationWindow(userMsgError, AlrtWinHdr);
                            }
                        });
                        return true;
                    }
                    else {
                        if (roleName == "Lab Technician") {
                            setCompleteStatus(id);
                            return false;
                        }
                        else {
                            setValidateStatus(id);
                            return false;
                        }
                    }
                }
            }
            //End Added by Arivalagan.kk//SynopticTest //
            else if (values[0] == "Reflexwithnewsample" || values[0] == "Reflexwithsamesample") {
                var DispConf = SListForAppMsg.Get("Scripts_ResultCapture_js_10") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_10") : "Do you want to proceed with Reflex Test?? ";
                var OkMsg = SListForAppMsg.Get('Scripts_Ok') == null ? "OK" : SListForAppMsg.Get('Scripts_Ok');
                var CancelMsg = SListForAppMsg.Get('Scripts_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Scripts_Cancel');
                //var Information = SListForAppMsg.Get('Scripts_Information') == null ? "Information" : SListForAppMsg.Get('Scripts_Information');
                var error = SListForAppMsg.Get('Scripts_Error') == null ? "Alert" : SListForAppMsg.Get('Scripts_Error');
                //                var ans = window.confirm('Do you want to proceed with Reflex Test??');
                var ans = ConfirmWindow(DispConf, error, OkMsg, CancelMsg);
                if (ans == true) {
                    document.getElementById('ucReflexTest_hdnDisableDropDown').value = id;

                    if (values[0] == "Reflexwithnewsample") {
                        document.getElementById('ucReflexTest_hdnReflexType').value = values[0];
                    }
                    else {
                        document.getElementById('ucReflexTest_hdnReflexType').value = values[0];
                    }
                    var sval1;
                    var prefixText = '';
                    sval = OrgID;
                    var lstPreviousInvestigations = [];
                    var lstTotalItems = [];
                    var ArrayItems;
                    var Items;
                    var SamplesItems;
                    var TotalItems;
                    $('#ucReflexTest_hdnTotalItems').val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../OPIPBilling.asmx/GetPatientOrderedInvestigation",
                        data: JSON.stringify({ prefixText: prefixText, contextKey: 'INV' + '~' + Vid + '~' + InvId + '~' + AccessionNumber + '~'
                        + parentType
                        }),
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            ArrayItems = data.d;
                            Items = ArrayItems[0];
                            SamplesItems = ArrayItems[1];
                            TotalItems = ArrayItems[2];
                            if (TotalItems[0].InvestigationName == 'OrderedTest') {
                                //alert('Ordered test should not be reflexed');
                                ValidationWindow(userMsg1, AlrtWinHdr);
                                if (roleName == "Lab Technician") {
                                    setCompleteStatus(id);
                                    return false;
                                }
                                else {
                                    setValidateStatus(id);
                                    return false;
                                }
                            }
                            if (TotalItems.length > 0) {
                                $('#ucReflexTest_hdnTotalItems').val(JSON.stringify(TotalItems));
                            }
                            $('#ucReflexTest_grdReflexOrderedInv tbody tr').children().remove();
                            if (TotalItems.length > 0) {
                                var list = TotalItems;
                                if (list.length > 0) {
                                    $("#ucReflexTest_grdReflexOrderedInv").append("<tr class='dataheader1'><td><span id='lblSelect' align='left'>Select</span></td><td><span id ='lblInvestName'>Investigation Name</span></td><td><span id ='lblPatStatus'>Status</span></td><td style='display:none';><span id='lblGroupID' align='left'>GroupID</span></td></tr>");
                                    for (var i = 0; i < list.length; i++) {
                                        var AccessionNumber = list[i].AccessionNumber;
                                        var InvestigationName = list[i].InvestigationName;
                                        var Status = list[i].Status;
                                        var ID = list[i].ID;
                                        var UID = list[i].UID;
                                        var LabNo = list[i].LabNo;
                                        var GroupID = list[i].GroupID;
                                        if (InvId == ID) {
                                            $("#ucReflexTest_grdReflexOrderedInv").append("<tr style='background-color:#F9B7FF;'><td><input type='radio' id='rdReflexSelinv' checked='checked' onclick='SelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                        }
                                        else {
                                            $("#ucReflexTest_grdReflexOrderedInv").append("<tr style='background-color:#F9B7FF; display:none'><td><input type='radio' id='rdReflexSelinv' onclick='SelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                        }
                                        $('#ucReflexTest_grdReflexOrderedInv').css('visibility', 'visible');

                                        if (InvId == ID) {
                                            $('#ucReflexTest_grdReflexOrderedInv tbody tr:not(:first)').each(function(i, n) {
                                                var $row = $(n);
                                                var AccessionNo = $row.find($('span[id$="lblAccNo"]')).html();
                                                var ParentInvName = $row.find($('span[id$="lblInvName"]')).html();
                                                var ParentStatus = $row.find($('span[id$="lblStatus"]')).html();
                                                var Vid1 = Vid;
                                                document.getElementById('ucReflexTest_hdnReflexAccessionNo').value = AccessionNo;
                                                document.getElementById('ucReflexTest_hdnReflexPrntInvName').value = ParentInvName;
                                                document.getElementById('ucReflexTest_hdnParentInvID').value = ID;
                                                document.getElementById('ucReflexTest_hdnStatus').value = ParentStatus;
                                                document.getElementById('ucReflexTest_hdnVID').value = Vid;
                                                document.getElementById('ucReflexTest_hdnUID').value = UID;
                                                document.getElementById('ucReflexTest_hdnLabNo').value = LabNo;
                                                sval1 = "COM" + '~' + ClientId + '~' + '~' + '~' + '' + gen;
                                                $find('ucReflexTest_AutoCompleteExtender3').set_contextKey(sval1);

                                            });
                                        }

                                        document.getElementById('ucReflexTest_btnAddReflex').style.display = 'block';

                                        lstPreviousInvestigations.push({
                                            AccessionNumber: AccessionNumber,
                                            InvestigationName: InvestigationName,
                                            Status: Status,
                                            Id: ID
                                        });
                                        if (lstPreviousInvestigations.length > 0) {
                                            $('#hdnLstInvestigationQueue').val(JSON.stringify(lstPreviousInvestigations));
                                            showReflexPopUp();
                                        }
                                        else {
                                            hideReflexPopUp();
                                        }
                                    }
                                }
                            }
                            if (ArrayItems[1].length > 0) {
                                var list = ArrayItems[1];
                                if (list.length > 0) {
                                    $('#ucReflexTest_grdReflexordINV').children().remove();
                                    var RowsCount = $("#ucReflexTest_grdReflexordINV tr").length;
                                    if (RowsCount == 0) {
                                        $("#ucReflexTest_grdReflexordINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>ID</span></td><td><span id='lblName'>Reflex Investigation</span></td><td><span id ='lbltype'>Type</span></td><td><span id ='lblParentINVName'>Parent Investigation</span></td><td><span id ='lblReferredType'>Referred Type</span></td><td><span id='lblIsReportable'>IsReportable</span></td><td><span id='lblIsBillable'>IsBillable</span></td><td style='display:none';><span id='lblAccNo'>AccessionNumber</span></td><td><span id ='lblDelete'>Delete</span></td></tr>");
                                    }
                                    for (var i = 0; i < list.length; i++) {
                                        var ParentID = list[i].ID;
                                        var ChildID = list[i].InvestigationID;
                                        var ParentName = list[i].PerformingPhysicain;
                                        var ChildName = list[i].Name;
                                        var Type = list[i].Type;
                                        var IsReportable = list[i].InvestigationsType;
                                        var IsBillable = list[i].Isbillable;
                                        document.getElementById('ucReflexTest_hdnParentInvID').value = ParentID;
                                        document.getElementById('ucReflexTest_hdnReflexID').value = ChildID;
                                        document.getElementById('ucReflexTest_hdnReflexName').value = ParentName;
                                        document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = 'INV';
                                        document.getElementById('ucReflexTest_btnAddReflex').style.display = 'block';
                                        $("#ucReflexTest_grdReflexordINV").append("<tr id=tr_" + ChildID + "><td style='display:none';><span id='lblinvID'>" + ChildID + "</span></td><td><span id='lblName'>" + ChildName + "</td></span><td><span id ='lbltype'>" + Type + "</span></td><td><span id ='lblparentInvName'>" + ParentName + "</span></td><td><span id ='lblReflexType'>" + document.getElementById('ucReflexTest_hdnReflexType').value + "</span></td><td><span id ='lblIsReportable'>" + IsReportable + "</span></td><td><span id ='lblIsBillable'>" + IsBillable + "</span></td><td style='display:none';><span id ='lblAccNo'>" + document.getElementById('ucReflexTest_hdnReflexAccessionNo').value + "</span></td><td><input id=td_" + ChildID + " onclick=deleteRow(this); value = 'Delete' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'><input type='hidden' id='hdnUID' value='" + document.getElementById('ucReflexTest_hdnUID').value + "'><input type='hidden' id='hdnLabNo' value='" + document.getElementById('ucReflexTest_hdnLabNo').value + "'><input type='hidden' id='hdnVID' value='" + document.getElementById('ucReflexTest_hdnVID').value + "'></td></tr>");
                                    }
                                }
                            }
                        },
                        error: function(result) {
                            // alert("New Error");
                            ValidationWindow(userMsgError, AlrtWinHdr);
                        }
                    });
                    return true;
                }
                else {
                    if (roleName == "Lab Technician") {
                        setCompleteStatus(id);
                        return false;
                    }
                    else {
                        setValidateStatus(id);
                        return false;
                    }
                }
            }
            else if (values[0] == "Recheck") {
                if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {
                    var objReason = document.getElementById(reasonid);
                    lstRejectReason = getStatuswiseReason(OrgID, values[1]);
                        objReason.options.length = 1;
                        $.each(lstRejectReason, function(i, obj) {
                           // if ($('input[id$="Reasonloading"]').val() == "Y") {
                               // if (obj.ReasonTypeCode == 'RR') {
                                    newListItem = document.createElement("option");
                                    objReason.options.add(newListItem);
                                    newListItem.text = obj.ReasonDesc;
                                    newListItem.value = obj.ReasonID;
                                //}
                            //}
                           // else 
                            //{
                                //newListItem = document.createElement("option");
                               // objReason.options.add(newListItem);
                               // newListItem.text = obj.ReasonDesc;
                                //newListItem.value = obj.ReasonID;
                             
                            //}

                        });
                    //}
                }

            }
            else if (values[0] == "Retest") {
                if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {
                    var objReason = document.getElementById(reasonid);
                    //if ($('input[id$="hdnlstreasons"]').val().length > 0) {
                        //var lstRejectReason = JSON.parse($('input[id$="hdnlstreasons"]').val());
                        //var values = document.getElementById(id).value;

                    lstRejectReason = getStatuswiseReason(OrgID, values[1]);
                        objReason.options.length = 1;
                        $.each(lstRejectReason, function(i, obj) {
                       // if ($('input[id$="Reasonloading"]').val() == "Y") {
                           // if (obj.ReasonTypeCode == 'RC') {

                                    newListItem = document.createElement("option");
                                    objReason.options.add(newListItem);
                                    newListItem.text = obj.ReasonDesc;
                                    newListItem.value = obj.ReasonID;
                                //}
                            //}
                            //else 
                            //{
                                //newListItem = document.createElement("option");
                                //objReason.options.add(newListItem);
                                //newListItem.text = obj.ReasonDesc;
                                //newListItem.value = obj.ReasonID;
                             //}

                        });
                        document.getElementById(ctrID + '_ddlStatusReason').style.display = 'block';
                        document.getElementById(ctrID + '_lblReason').style.display = 'block';
                    //}
                    }
                //}
                //////////Vijayalakshmi.M/////////////
                else {
                    document.getElementById(ctrID + '_ddlStatusReason').style.display = 'none';
                    document.getElementById(ctrID + '_lblReason').style.display = 'none';
                }
                //////////////End///////////////////
            }
            else {
                var objReason = document.getElementById(reasonid);
                if ($('input[id$="hdnlstreasons"]').val().length > 0) {
                    var lstRejectReason = JSON.parse($('input[id$="hdnlstreasons"]').val());
                    //var values = document.getElementById(id).value;


                    objReason.options.length = 1;
                    $.each(lstRejectReason, function(i, obj) {
                        if (obj.StatusID == values[1]) {

                            newListItem = document.createElement("option");
                            objReason.options.add(newListItem);
                            newListItem.text = obj.ReasonDesc;
                            newListItem.value = obj.ReasonID;
                        }
                    });
                }
            }
        }
    }
    catch (e) {
        return false;
    }
}

function setValidateStatus(id) {
    try {
        var x = id.split("_");
        var type = document.getElementById(id).type;
        var resultValue = "";
        if (type.indexOf("select") >= 0) {
            var ddl = document.getElementById(id);
            if (ddl.selectedIndex > 0) {
                resultValue = ddl.options[ddl.selectedIndex].text;
            }
        }
        else {
            resultValue = document.getElementById(id).value;
        }
        if (resultValue.trim() != "") {
            var len = document.getElementById(x[0] + "_ddlstatus").options.length;
            var drpdwn = document.getElementById(x[0] + "_ddlstatus");
            if (x[1] == "txtValue") {
                var txtValue = document.getElementById(x[0] + "_txtValue");
                var txtValuLen = txtValue.value.length;

                var isValidatedExists = 'false';
                var isReflexExists = 'false';
                var ValidatedValue = 0;
                var ReflexValue = 0;
                for (var i = 0; i < len; i++) {
                    var drpdwnVal = drpdwn.options[i].value.split("_");
                    //if (drpdwn.options[i].text == 'Completed') {
                    if (drpdwnVal[0] == 'Validate') {
                        isValidatedExists = 'true';
                        ValidatedValue = drpdwn.options[i].value;
                    }
                    //if (drpdwn.options[i].text == 'Pending') {
                    if (drpdwnVal[0] == 'Reflexwithnewsample' || drpdwnVal[0] == 'Reflexwithsamesample') {
                        isReflexExists = 'true';
                        ReflexValue = drpdwn.options[i].value;
                    }
                }
                if (len > 0 && isValidatedExists == 'true' && txtValuLen > 0) {
                    if (document.getElementById("hdnDefaultDropDownStatus") != null
                    && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                        var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                        document.getElementById(x[0] + "_ddlstatus").value = status;
                    }
                    else {
                        document.getElementById(x[0] + "_ddlstatus").value = ValidatedValue;
                    }
                } else if (isReflexExists == 'true') {
                    document.getElementById(x[0] + "_ddlstatus").value = ReflexValue;
                }
            }
            else {
                var isValidatedExists = 'false';
                var isReflexExists = 'false';
                var ValidatedValue = 0;
                //***********Added By Arivalaga.kk**************//
                var isApprovedExists = 'false';
                var ApprovedValue = 0;
                //**********End *Added By Arivalaga.kk**************//
                var ReflexValue = 0;
                for (var i = 0; i < len; i++) {
                    var drpdwnVal = drpdwn.options[i].value.split("_");
                    //if (drpdwn.options[i].text == 'Completed') {
                    if (drpdwnVal[0] == 'Validate') {
                        isValidatedExists = 'true';
                        ValidatedValue = drpdwn.options[i].value;
                    }
                    //if (drpdwn.options[i].text == 'Pending') {
                    if (drpdwnVal[0] == "Reflexwithnewsample" || drpdwnVal[0] == "Reflexwithsamesample") {
                        isReflexExists = 'true';
                        ReflexValue = drpdwn.options[i].value;
                    }
                    if (drpdwnVal[0] == "Approve") {
                        isApprovedExists = 'true';
                        ApprovedValue = drpdwn.options[i].value;
                    }
                }
                if (document.getElementById("hdnDefaultDropDownStatus") != null
                && document.getElementById("hdnDefaultDropDownStatus").value != ""
                && document.getElementById("hdnDefaultDropDownStatus").value != "Approve") {
                    if (len > 0 && isValidatedExists == 'true') {
                        if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                            var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                            document.getElementById(x[0] + "_ddlstatus").value = status;
                        }
                        else {
                            document.getElementById(x[0] + "_ddlstatus").value = ValidatedValue;
                        }
                    } else if (isReflexExists == 'true') {
                        document.getElementById(x[0] + "_ddlstatus").value = ReflexValue;
                    }
                }
                else {
                    if (len > 0 && isApprovedExists == 'true') {
                        if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                            var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                            document.getElementById(x[0] + "_ddlstatus").value = status;
                        }
                        else {
                            document.getElementById(x[0] + "_ddlstatus").value = ApprovedValue;
                        }
                    }
                }
                //**********End *Added By Arivalaga.kk**************//
            }
        }
    }
    catch (e) {
        return false;
    }
    return true;
}

function showReflexPopUp() {
    $find('ucReflexTest_ModalPopupExtender2').show();
}
function hideReflexPopUp() {
    $find('ucReflexTest_ModalPopupExtender2').hide();
}
function showSynopticTestPopUp() {
    $find('ucSynopticTest_SynopticTestModalPopupExtender').show();
}
function hideSynopticTestPopUp() {
    $find('ucSynopticTest_SynopticTestModalPopupExtender').hide();
}
///////////////////////////////////////////////
var lstSynopticTestorderedInvestigation = [];
function SynopticTestSelectSingleRadiobutton(rb) {

    try {
        var rdBtn = document.getElementById(rb);
        $('#ucSynopticTest_grdSynopticTestOrderedInv tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var AccessionNo = $row.find($('span[id$="lblAccNo"]')).html();
            var ParentInvName = $row.find($('span[id$="lblInvName"]')).html();
            var ParentStatus = $row.find($('span[id$="lblStatus"]')).html();
            var Vid = document.getElementById('PatientDetail_hdnVID').value;
            document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value = AccessionNo;
            document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value = ParentInvName;
            document.getElementById('ucSynopticTest_hdnStatus').value = ParentStatus;
            document.getElementById('ucSynopticTest_hdnVID').value = Vid;

            var Gender = document.getElementById('PatientDetail_hdnGender').value;
            var ClientID = document.getElementById('PatientDetail_hdnClientID').value;

            var gen;
            var sval;
            if (Gender == "Male") {
                gen = "M";
            }
            else if (Gender = "Female") {
                gen = "F";
            }
            sval = "COMSynoptic" + '~' + ClientID + '~' + '~' + '~' + '' + gen;
            $find('ucSynopticTest_AutoCompleteExtender1').set_contextKey(sval);

        });
        $('#ucSynopticTest_grdSynopticTestINV tbody tr').children().remove();
        var rdBtnList = document.getElementsByTagName("input");
        for (i = 0; i < rdBtnList.length; i++) {
            if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                rdBtnList[i].checked = false;
            }
        }
        //debugger;
        lstSynopticTestorderedInvestigation.pop();
        var string = document.getElementById('ucSynopticTest_hdnLstorderedInvestigationSynoptic').value;
        var lstorderedInvestigationSynoptic = JSON.parse(string);
        if (lstorderedInvestigationSynoptic.length > 0) {
            $("#ucSynopticTest_grdSynopticTestINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>ID</span></td><td><span id='lblName'>Reflex Investigation</span></td><td><span id ='lbltype'>Type</span></td><td><span id ='lblParentINVName'>Parent Investigation</span></td><td><span id ='lblReferredType'>Referred Type</span></td><td><span id ='lblDelete'>Delete</span></td></tr>");
            for (i = 0; i < lstorderedInvestigationSynoptic.length; i++) {
                if (lstorderedInvestigationSynoptic[i].ReferredAccessionNo == ParentAccesionNumber) {
                    if (lstorderedInvestigationSynoptic[i].ReferredType == "Master") {
                        document.getElementById('ucSynopticTest_btnAddSynopticTest').style.display = 'block';
                        document.getElementById('ucSynopticTest_btnSaveSynopticTest').style.display = 'block';
                        lstorderedInvestigation.push({
                            VisitID: lstorderedInvestigationSynoptic[i].Vid,
                            InvestigationID: lstorderedInvestigationSynoptic[i].ID,
                            Name: lstorderedInvestigationSynoptic[i].InvestigationName,
                            Type: lstorderedInvestigationSynoptic[i].Type,
                            AccessionNumber: lstorderedInvestigationSynoptic[i].AccessionNumber
                        });
                        document.getElementById('ucSynopticTest_hdnLstInvestigationQueue').value = JSON.stringify(lstSynopticTestorderedInvestigation);
                    }
                    $("#ucSynopticTest_grdSynopticTestINV").append("<tr id=tr_"
                    + lstorderedInvestigationSynoptic[i].ID + " ><td style='display:none';><span id='lblinvID'>"
                    + lstorderedInvestigationSynoptic[i].ID + "</span></td><td><span id='lblName'>"
                    + lstorderedInvestigationSynoptic[i].InvestigationName + "</span></td><td><span id ='lbltype'>"
                    + lstorderedInvestigationSynoptic[i].Type + "</span></td><td><span id ='lblParentINVName'>"
                    + lstorderedInvestigationSynoptic[i].Name + "</span></td><td><span id ='lblReferredType'>"
                    + lstorderedInvestigationSynoptic[i].ReferredType + "</span></td><td><input id=td_"
                    + document.getElementById('ucSynopticTest_hdnSynopticID').value + " onclick=deleteRow(this); value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'></td></tr>");
                }
            }
        }
    }
    catch (e) {
        return false;
    }
}

///////////////////////////////////////////////
var lstorderedInvestigation = [];
function SelectSingleRadiobutton(rb) {

    try {
        var rdBtn = document.getElementById(rb);
        $('#ucReflexTest_grdReflexOrderedInv tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var AccessionNo = $row.find($('span[id$="lblAccNo"]')).html();
            var ParentInvName = $row.find($('span[id$="lblInvName"]')).html();
            var ParentStatus = $row.find($('span[id$="lblStatus"]')).html();
            var Vid = document.getElementById('PatientDetail_hdnVID').value;
            document.getElementById('ucReflexTest_hdnReflexAccessionNo').value = AccessionNo;
            document.getElementById('ucReflexTest_hdnReflexPrntInvName').value = ParentInvName;
            document.getElementById('ucReflexTest_hdnStatus').value = ParentStatus;
            document.getElementById('ucReflexTest_hdnVID').value = Vid;

            var Gender = document.getElementById('PatientDetail_hdnGender').value;
            var ClientID = document.getElementById('PatientDetail_hdnClientID').value;

            var gen;
            var sval;
            if (Gender == "Male") {
                gen = "M";
            }
            else if (Gender = "Female") {
                gen = "F";
            }
            sval = "COM" + '~' + ClientID + '~' + '~' + '~' + '' + gen;
            $find('ucReflexTest_AutoCompleteExtender3').set_contextKey(sval);

        });
        $('#ucReflexTest_grdReflexordINV tbody tr').children().remove();
        var rdBtnList = document.getElementsByTagName("input");
        for (i = 0; i < rdBtnList.length; i++) {
            if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                rdBtnList[i].checked = false;
            }
        }
        //debugger;
        lstorderedInvestigation.pop();
        //document.getElementById('ucReflexTest_btnAddReflex').style.display = 'none';
        var string = document.getElementById('ucReflexTest_hdnLstorderedInvestigationReflex').value;
        var lstorderedInvestigationReflex = JSON.parse(string);
        if (lstorderedInvestigationReflex.length > 0) {
            $("#ucReflexTest_grdReflexordINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>ID</span></td><td><span id='lblName'>Reflex Investigation</span></td><td><span id ='lbltype'>Type</span></td><td><span id ='lblParentINVName'>Parent Investigation</span></td><td><span id ='lblReferredType'>Referred Type</span></td><td><span id ='lblDelete'>Delete</span></td></tr>");
            for (i = 0; i < lstorderedInvestigationReflex.length; i++) {
                if (lstorderedInvestigationReflex[i].ReferredAccessionNo == ParentAccesionNumber) {
                    if (lstorderedInvestigationReflex[i].ReferredType == "Master") {
                        document.getElementById('ucReflexTest_btnAddReflex').style.display = 'block';
                        lstorderedInvestigation.push({
                            VisitID: lstorderedInvestigationReflex[i].Vid,
                            InvestigationID: lstorderedInvestigationReflex[i].ID,
                            Name: lstorderedInvestigationReflex[i].InvestigationName,
                            Type: lstorderedInvestigationReflex[i].Type,
                            AccessionNumber: lstorderedInvestigationReflex[i].AccessionNumber
                        });
                        document.getElementById('ucReflexTest_hdnLstInvestigationQueue').value = JSON.stringify(lstorderedInvestigation);
                    }
                    $("#ucReflexTest_grdReflexordINV").append("<tr id=tr_" + lstorderedInvestigationReflex[i].ID + " ><td style='display:none';><span id='lblinvID'>" + lstorderedInvestigationReflex[i].ID + "</span></td><td><span id='lblName'>" + lstorderedInvestigationReflex[i].InvestigationName + "</span></td><td><span id ='lbltype'>" + lstorderedInvestigationReflex[i].Type + "</span></td><td><span id ='lblParentINVName'>" + lstorderedInvestigationReflex[i].Name + "</span></td><td><span id ='lblReferredType'>" + lstorderedInvestigationReflex[i].ReferredType + "</span></td><td><input id=td_" + document.getElementById('ucReflexTest_hdnReflexID').value + " onclick=deleteRow(this); value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'></td></tr>");
                    //document.getElementById('ucReflexTest_grdReflexordINV').append("<tr id=tr_" + i + "><td><span id='lblinvID'>" + lstorderedInvestigation[i].ID + "</span></td><td><span id='lblName'>" + lstorderedInvestigation[i].InvestigationName + "<td><span id ='lbltype'>" + lstorderedInvestigation[i].Type + "</span></td></tr>");
                }
            }
        }
    }
    catch (e) {
        return false;
    }
}

function SelectedRemarks(source, eventArgs) {
    try {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnRemarksID') != null) {
            document.getElementById('hdnRemarksID').value = RemarksDetails;  //RemarksID;
        }
    }
    catch (e) {
        return false;
    }
}
function GetInvMedicalRemarks(source, eventArgs) {
    try {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    catch (e) {
        return false;
    }
}
function isNumericss(e, Id) {
    try {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
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
    catch (e) {
        return false;
    }
}
function expandDropDownList1(elementRef) {
    try {
        elementRef.style.width = '200px';
    }
    catch (e) {
        return false;
    }
}

function collapseDropDownList1(elementRef) {
    try {
        elementRef.style.width = '100px';
    }
    catch (e) {
        return false;
    }
}
function ReplaceNumberWithCommas(txtId) {
    try {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/ReplaceNumberWithCommas",
            data: "{resultValue:'" + document.getElementById(txtId).value + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {
                document.getElementById(txtId).value = data.d;
            },
            error: function(xhr, ajaxOptions, thrownError) {
            }
        });
    }
    catch (e) {
        return false;
    }
}
function replaceAll(find, replace, str) {
    try {
        while (str.trim().indexOf(find) > -1) {
            str = str.replace(find, replace);
        }
    }
    catch (e) {
        return str;
    }
    return str;
}
function SaveResultValue(txtId, hdnResultValueId) {
    try {
        var yourNumber = document.getElementById(txtId).value;
        yourNumber = replaceAll(',', '', yourNumber);
        yourNumber = replaceAll('<', '', yourNumber);
        yourNumber = replaceAll('>', '', yourNumber);
        yourNumber = replaceAll('below', '', yourNumber);
        yourNumber = replaceAll('Below', '', yourNumber);
        yourNumber = replaceAll('BELOW', '', yourNumber);
        yourNumber = replaceAll('above', '', yourNumber);
        yourNumber = replaceAll('Above', '', yourNumber);
        yourNumber = replaceAll('ABOVE', '', yourNumber);
        yourNumber = replaceAll(' ', '', yourNumber);
        document.getElementById(hdnResultValueId).value = yourNumber;
    }
    catch (e) {
        return false;
    }
}
function CheckDifferentStatus() {
    try {
        var lstStatus = [];
        $.each($("select[id$='ddlstatus'] option:selected"), function(n, i) {
            if ($.inArray($(this).text(), lstStatus) == -1) {
                lstStatus.push($(this).text());
            }
        });
        if (lstStatus.length > 1) {
            var Disp1Conf = SListForAppMsg.Get("Scripts_ResultCapture_js_12") != null ? SListForAppMsg.Get("Scripts_ResultCapture_js_12") : "Found different status. Are you sure you want to continue";
            //            var result = confirm("Found different status. Are you sure you want to continue");
            var result = confirm(Disp1Conf);
            return result;
        }
        return true;
    }
    catch (e) {
        return true;
    }
}
function clearHdnDCcheck() {
    try {
        document.getElementById("hdnDCcheck").value = "false";
    }
    catch (e) {
        return true;
    }
}
function ValidateInterpretationRange(patternId, txtId, ddlId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender) {
    try {
        var pGender = "";
        var age = "";

        if (Age != '') {
            age = Age;
        }
        else {
            if (document.getElementById('PatientDetail_lblAge') != null) {
                age = document.getElementById('PatientDetail_lblAge').innerHTML;
            }
            else {
                age = '';
            }
        }
        if (Gender != '') {
            pGender = Gender;
        }
        else {
            if (document.getElementById('PatientDetail_hdnGender') != null) {
                pGender = document.getElementById('PatientDetail_hdnGender').value;
            }
            else {
                pGender = '';
            }
        }
        var resultValue = "";
        if (patternId == 1 || patternId == 2 || patternId == 46 || patternId == 49) {
            resultValue = document.getElementById(txtId).value;
        }
        else if (patternId == 3) {
            txtId = ddlId;
            resultValue = document.getElementById(ddlId).value;
        }

        if (resultValue != '') {
            var xmlContent = document.getElementById(xmlRange).value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ValidateInterpretationRange",
                data: "{ReferenceRange: '" + xmlContent + "', Value:'" + resultValue + "', Gender:'" + pGender + "', Age:'" + age + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var result = data.d;
                    if (result != "") {
                        var lstResult = result.split('~');
                        if (lstResult[0] == "Interpretation" && resultValue != lstResult[1]) {
                            validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
                        }
                        else if (resultValue != lstResult[1] + "," + resultValue) {
                            validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
                        }
                        if (patternId == 1 || patternId == 46 || patternId == 49) {
                            if (lstResult[0] == "Interpretation") {
                                document.getElementById(txtId).value = lstResult[1];
                            }
                            else {
                                var lstresultinter = resultValue.split(',');
                                if (lstresultinter.length == 2) {
                                    resultValue = lstresultinter[1];
                                }
                                document.getElementById(txtId).value = lstResult[1] + "," + resultValue;
                            }
                        }
                        else if (patternId == 2) {
                            if (lstResult[0] != "Interpretation") {
                                document.getElementById(ddlId).value = lstResult[1];
                            }
                        }
                        else if (patternId == 3) {
                            if (lstResult[0] == "Interpretation") {
                                document.getElementById(ddlId).value = lstResult[1];
                            }
                        }
                    }
                    else {
                        validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
                    return false;
                }
            });
        }
        else {
            validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
        }
    }
    catch (e) {
        validateResult(txtId, xmlRange, panicxmlrange, DecimalPlaces, txtIsAbnormalId, AutoApproveLoginId, lblNameId, lblUnitId, Age, Gender);
        return false;
    }
}
function TestPopulated(sender, e) {
    try {
        var behavior = $find('AutoInvestigations');
        var target = behavior.get_completionList();
        for (i = 0; i < target.childNodes.length; i++) {
            var text = target.childNodes[i]._value;
            var ItemArray;
            ItemArray = text.split('~');
            if (ItemArray[2].trim().toLowerCase() == 'inv') {
                target.childNodes[i].style.color = "Black";
            }
            else if (ItemArray[2].trim().toLowerCase() == 'pkg') {
                target.childNodes[i].style.color = "blue";
            }
            else {
                target.childNodes[i].style.color = "MediumVioletRed";
            }
        }
    }
    catch (e) {
    }
}
function AddNoGraphVisit(visitNumber) {
    try {
        document.getElementById("hdnNoGraphAttached").value = "true";
    }
    catch (e) {
    }
}
function setCompleteStatus(id) {
    var x = id.split("_");
    if (document.getElementById(id).value.trim() != "") {
        var len = document.getElementById(x[0] + "_ddlstatus").options.length;
        var drpdwn = document.getElementById(x[0] + "_ddlstatus");
        if (x[1] == "txtValue") {
            var txtValue = document.getElementById(x[0] + "_txtValue");
            var txtValuLen = txtValue.value.length;

            var isCompletedExists = 'false';
            var CompletedValue = 0;
            var PendingValue = 0;
            for (var i = 0; i < len; i++) {
                if (drpdwn.options[i].text == 'Completed') {
                    isCompletedExists = 'true';
                    CompletedValue = drpdwn.options[i].value;
                }
                if (drpdwn.options[i].text == 'Pending') {

                    PendingValue = drpdwn.options[i].value;
                }
            }
            if (len > 0 && isCompletedExists == 'true' && txtValuLen > 0) {

                document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                return true;
            } else {
                document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                return true;
            }
        }
        else {
            var isCompletedExists = 'false';
            var CompletedValue = 0;
            var PendingValue = 0;
            for (var i = 0; i < len; i++) {
                if (drpdwn.options[i].text == 'Completed') {
                    isCompletedExists = 'true';
                    CompletedValue = drpdwn.options[i].value;
                }
                if (drpdwn.options[i].text == 'Pending') {

                    PendingValue = drpdwn.options[i].value;
                }
            }
            if (len > 0 && isCompletedExists == 'true') {

                document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                return true;
            } else {
                document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                return true;
            }

        }
    }
    return false;
}

function chkRecollectCount(Vid, InvId, OrgID, roleName, id) {
    var _Validation = 0;
    //var contextKey = document.getElementById('hdnorgIDCl').value + '~' + 'LogisticsZone' + '~' + document.getElementById('hdnZoneID').value;
    if (Vid != "") {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/chkRecollectCount",
            data: "{ 'VisitId': '" + Vid + "','ID': '" + InvId + "','pOrgID': '" + OrgID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                Items = data.d[0];
                if (Items.Status == "Yes") {
                    _Validation = 1;
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });

        if (_Validation == 1) {
            if (roleName == "Lab Technician") {
                setCompleteStatus(id);
                document.getElementById('hdnRecollectCountFlag').value = 1;
                return false;
            }
            else {
                setValidateStatus(id);
                document.getElementById('hdnRecollectCountFlag').value = 1;
                return false;
            }
        }
    }

}

function CheckDCCount() {
    var hdnTotDc = document.getElementById('hdnTotDc');

    if (hdnTotDc.Value == "0" || hdnTotDc.Value == undefined) {
        return true;
    }
    else {
        if (hdnTotDc.Value < 100) {
            //alert('Sum of following test values are Less than 100:\n\n1.Neutrophils\n2.Lymphocytes\n3.Eosinophils\n4.Basophils\n5.Monocytes\n6.RDW-CV\n7.Atypical Lymphocytes\n8.Promyelocytes\n9.Blast\n10.Band Forms\n\n\t');
            return true;
        }

        else if (hdnTotDc.Value > 100) {
            // alert('Sum of following test values are greater than 100:\n\n1.Neutrophils\n2.Lymphocytes\n3.Eosinophils\n4.Basophils\n5.Monocytes\n6.RDW-CV\n7.Atypical Lymphocytes\n8.Promyelocytes\n9.Blast\n10.Band Forms\n\n\t');
            return true;
        }
        else {
            return true;
        }
    }

}
function ConvertResultValue(yourNumber) {
    try {
        if (yourNumber.indexOf('<') != -1) {
            yourNumber = replaceAll(yourNumber, '<', '');
            yourNumber = parseFloat(yourNumber) - 0.0001;
        }
        if (yourNumber.indexOf('>') != -1) {
            yourNumber = replaceAll(yourNumber, '>', '');
            yourNumber = parseFloat(yourNumber) + 0.0001;
        }
        if (yourNumber.indexOf(',') != -1) {
            yourNumber = replaceAll(yourNumber, ',', '');
        }
        if (yourNumber.indexOf('below') != -1) {
            yourNumber = replaceAll(yourNumber, 'below', '');
        }
        if (yourNumber.indexOf('Below') != -1) {
            yourNumber = replaceAll(yourNumber, 'Below', '');
        }
        if (yourNumber.indexOf('BELOW') != -1) {
            yourNumber = replaceAll(yourNumber, 'BELOW', '');
        }
        if (yourNumber.indexOf('above') != -1) {
            yourNumber = replaceAll(yourNumber, 'above', '');
        }
        if (yourNumber.indexOf('Above') != -1) {
            yourNumber = replaceAll(yourNumber, 'Above', '');
        }
        if (yourNumber.indexOf('ABOVE') != -1) {
            yourNumber = replaceAll(yourNumber, 'ABOVE', '');
        }
        //yourNumber = replaceAll(yourNumber, ' ', '');
        return yourNumber;
    }
    catch (e) {
        return yourNumber;
    }
}
function LoadSensitiveValue(txtControl, ddlControl, isSensitive, testName, testUOM) {
    //debugger;
    try {
        var hdnSensitiveRangeDetails = document.getElementById("hdnSensitiveRangeDetails").value;
        var lstSensitiveRangeDetails = {};
        if (hdnSensitiveRangeDetails != "") {
            lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
        }
        if (txtControl != "") {
            if (lstSensitiveRangeDetails[txtControl] == undefined) {
                lstSensitiveRangeDetails[txtControl] = isSensitive;
            }
        }
        else {
            if (lstSensitiveRangeDetails[ddlControl] == undefined) {
                lstSensitiveRangeDetails[ddlControl] = isSensitive;
            }
        }
        document.getElementById("hdnSensitiveRangeDetails").value = JSON.stringify(lstSensitiveRangeDetails);
    }
    catch (e) {
        return false;
    }
}

//Added by Jegan for Autoauthorization

function chkAutoAuthorization(Vid, OrgID, hdnAutoAuthCount, InvId, patternid) {
    var _Validation = 0;
    //var contextKey = document.getElementById('hdnorgIDCl').value + '~' + 'LogisticsZone' + '~' + document.getElementById('hdnZoneID').value;
    if (Vid != "") {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetAutoAuthorizationStatus",
            data: "{ 'VisitID': '" + Vid + "','OrgID':'" + OrgID + "','AutoAuthorizationCount':'" + hdnAutoAuthCount + "','InvID': '" + InvId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {

                if (data.d == 1) {//Auto Authorizatin true
                    _Validation = 1;
                    //  $("#hdnAutoAuthStatus").val(_Validation);
                    document.getElementById(patternid + "_hdnAutoAuthStatus").value = _Validation;
                    // alert($("#hdnAutoAuthStatus").val());
                }
                else {
                    //$("#hdnAutoAuthStatus").val(0);
                    document.getElementById(patternid + "_hdnAutoAuthStatus").value = 0;
                }
            },
            failure: function(msg) {

                ShowErrorMessage(msg);
            }
        });

    }
}