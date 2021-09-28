
//Delta Function
function CallShowPopUp(id) {
    var POrgid;
    var PInvID;
    var PPatternID;
    var PVisitID;
    var PPatternClassName;
    var item = id.split('_');
    var LVisitID = item[0] + '_lblPVisitID';
    var LPatternID = item[0] + '_lblPatternID';
    var LInvID = item[0] + '_lblInvID';
    var LOrgID = item[0] + '_lblOrgID';
    var LPatternClassName = item[0] + '_lblPatternClassName';
    PVisitID = document.getElementById(LVisitID).innerHTML;
    PPatternID = document.getElementById(LPatternID).innerHTML;
    PInvID = document.getElementById(LInvID).innerHTML;
    POrgid = document.getElementById(LOrgID).innerHTML;
    PPatternClassName = document.getElementById(LPatternClassName).innerHTML;

    ShowPopUp(PVisitID, POrgid, PPatternID, PInvID,item[0], PPatternClassName);
    

    //BindGridView(PVisitID, POrgid, PPatternID, PInvID);
}
function ClosePopUp() {

}
function ShowPopUp(PVisitID, POrgid, PPatternID, PInvID, PPatternIDLabel, PPatternClassName) {
    document.getElementById('hdnPatternID').value = PPatternIDLabel;
    document.getElementById('hdnMappingPatternID').value = PPatternClassName;
    WebService.GetPatientInvestigationValuesHisiory(PVisitID, POrgid, PPatternID, PInvID, GetLabHistory);
} 

function GetLabHistory(result) {

    for (var n = 0; n < result.length; n++) {
        var TableInvValue = '';
        TableInvValue = GetInvestigationValues(result[n].Value);
        var row = document.getElementById('tblPatientTestHistory').insertRow(1);
        //alert("rwNumber1:" + rwNumber);
        //rwNumber = Attributes + rwNumber;
        var date = result[n].UOMCode;
        row.id = n;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);

        //alert("rwNumber1:" + rwNumber);
        //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + n + ");' src='../Images/Delete.jpg' />";
        //cell1.width = "6%";
        cell1.innerHTML = "<b>" + date + "</b> ";
        cell2.innerHTML = "<b>" + result[n].InvestigationName + "</b>";
        cell3.innerHTML = "<b>" + TableInvValue + "</b>";
        cell4.innerHTML = "<b>" + result[n].ReferenceRange + "</b>";
        cell5.innerHTML = "<b>" + result[n].Reason + "</b>";
        cell6.innerHTML = "<b>" + result[n].DisplayStatus + "</b>";
        cell7.innerHTML = "<b>" + result[n].KitName / result[n].InstrumentName + "</b>";
        //j++;
        //document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
        document.getElementById('tblPatientTestHistory').style.display = 'block';
    }
    document.getElementById('btnDummy').click();
}

function ClearPopUp() {

    var otable = document.getElementById('tblPatientTestHistory');
    while (otable.rows.length > 1) {
        otable.deleteRow(otable.rows.length - 1);
    }
}

function DrawGraph(vVisitId, vOrgId, vPatternId, vInvId) {
    $(document).ready(function() {
    getChartImage("1", vVisitId, vOrgId, vPatternId, vInvId);
    });
    function getChartImage(type,vVisitId,vOrgId,vPatternId,vInvId) {
        if (type < 0)
            return;
        var dataPassed = new Object();
        dataPassed.iType = type;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/DrawChart",
            //data: $.toJSON(dataPassed),
            data: "{VisitID:" + vVisitId + ",OrgID:" + vOrgId + ",PatternID:" + vPatternId + ",InvID:" + vInvId + "}",
            success:
                      function(msg) {
                          //var dataPath = $.evalJSON(msg).d;
                          var dataPath = '';
                          if (msg.d == undefined) {
                              dataPath = msg.substring(6, msg.length - 2);
                          }
                          else {
                              dataPath = msg.d;
                          }
                          dataPath = "../" + dataPath;
                          $("#ChartArea").attr("src", dataPath);
                      },
            error:
                      function(XMLHttpRequest, textStatus, errorThrown) {
                          alert(XMLHttpRequest.responseText);
                      }
        });
    }
}

//Beta Function
function CallShowBetaPopUp(id) {
    document.getElementById('trDeltaTable').style.display = 'block';
    document.getElementById('trDeltaGraph').style.display = 'none';
    document.getElementById('DeltaPlus').style.display = 'block';
    document.getElementById('DeltaMinus').style.display = 'none';
    var POrgid;
    var PInvID;
    var PPatternID;
    var PVisitID;
    var PPatternClassName;
    var item = id.split('_');
    var LVisitID = item[0] + '_lblPVisitID';
    var LPatternID = item[0] + '_lblPatternID';
    var LInvID = item[0] + '_lblInvID';
    var LOrgID = item[0] + '_lblOrgID';
    var LPatternClassName = item[0] + '_lblPatternClassName';
    PVisitID = document.getElementById(LVisitID).innerHTML;
    PPatternID = document.getElementById(LPatternID).innerHTML;
    PInvID = document.getElementById(LInvID).innerHTML;
    POrgid = document.getElementById(LOrgID).innerHTML;
    PPatternClassName = document.getElementById(LPatternClassName).innerHTML;

    //if (PPatternID == 1) {
        DrawGraph(PVisitID, POrgid, PPatternID, PInvID);
    //}

    //ShowPopUp(PVisitID, POrgid, PPatternID, PInvID);

    // BindGridView(PVisitID, POrgid, PPatternID, PInvID, item[0]);
    BindGridViewNew(PVisitID, POrgid, PPatternID, PInvID, item[0], PPatternClassName);
}
function ClosePopUp() {

}


function lnkEdit_OnClientClick(id) {
    var ColorFlag;
    var linkId = document.getElementById(id);
    if (linkId != null) {
       
        if (linkId.style.color == "red") {
            linkId.style.color = "Green";
            ColorFlag =0;
        }
        else {
            linkId.style.color = "red";
            ColorFlag =1;
        }
    }

    
    var item = id.split('_');

    var hdnReadonly = item[0] + '_hdnReadonly';


    document.getElementById(hdnReadonly).value = "True";

    var txtReason = item[0] + '_txtReason';
    var txtResult = item[0] + '_txtResult';
    var txtControl = item[0] + '_txtControl';
    var txtPatient = item[0] + '_txtPatient';
    var txtValue = item[0] + '_txtValue';
    var txtmins = item[0] + '_txtmins';
    var txtSecs = item[0] + '_txtSecs';
    var txtSource = item[0] + '_txtSource';
    var txtClinicalDiagnosis = item[0] + '_txtClinicalDiagnosis';
    var txtClinicalNotes = item[0] + '_txtClinicalNotes';
    var txtCultureReport = item[0] + '_txtCultureReport';
    var txtSample = item[0] + '_txtSample';
    var txtMicroscopy = item[0] + '_txtMicroscopy';
    var txtGrowth = item[0] + '_txtGrowth';
    var txtColonyCount = item[0] + '_txtColonyCount';
    var txtOrgan = item[0] + '_txtOrgan';
    var txtSpecimen = item[0] + '_txtSpecimen';
    var txtKohMount = item[0] + '_txtKohMount';
    var txt10KohMount = item[0] + '_txt10KohMount';
    var txtLPCB = item[0] + '_txtLPCB';
    var txtGlucose = item[0] + '_txtGlucose';
    var txtLDH = item[0] + '_txtLDH';
    var txtDilution = item[0] + '_txtDilution';
    var txtReason = item[0] + '_txtReason';
    var txtMedRemarks = item[0] + '_txtMedRemarks';

    var txtOrgan = item[0] + '_txtOrgan';

    var ClinicalNotes = item[0] + '_txtClinicalNotes';
    var txtSpecimenNo = item[0] + '_txtSpecimenNo';
    
    if (document.getElementById(item[0] + '_txtBox') != null) {
        document.getElementById(item[0] + '_txtBox').readOnly = false;
    }
    if (document.getElementById(item[0] + '_txtGlucose') != null) {
        document.getElementById(item[0] + '_txtGlucose').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox0') != null) {
        document.getElementById(item[0] + '_TextBox0').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox1') != null) {
        document.getElementById(item[0] + '_TextBox1').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox2') != null) {
        document.getElementById(item[0] + '_TextBox2').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox3') != null) {
        document.getElementById(item[0] + '_TextBox3').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox4') != null) {
        document.getElementById(item[0] + '_TextBox4').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox5') != null) {
        document.getElementById(item[0] + '_TextBox5').readOnly = false;
    }
    if (document.getElementById(item[0] + '_TextBox6') != null) {
        document.getElementById(item[0] + '_TextBox6').readOnly = false;
    }

    if (document.getElementById(item[0] + '_ddlTime0') != null) {
        document.getElementById(item[0] + '_ddlTime0').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime1') != null) {
        document.getElementById(item[0] + '_ddlTime1').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime2') != null) {
        document.getElementById(item[0] + '_ddlTime2').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime3') != null) {
        document.getElementById(item[0] + '_ddlTime3').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime4') != null) {
        document.getElementById(item[0] + '_ddlTime4').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime5') != null) {
        document.getElementById(item[0] + '_ddlTime5').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime6') != null) {
        document.getElementById(item[0] + '_ddlTime6').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlTime7') != null) {
        document.getElementById(item[0] + '_ddlTime7').disabled = false;
    }

    if (document.getElementById(item[0] + '_ddlMin0') != null) {
        document.getElementById(item[0] + '_ddlMin0').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin1') != null) {
        document.getElementById(item[0] + '_ddlMin1').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin2') != null) {
        document.getElementById(item[0] + '_ddlMin2').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin3') != null) {
        document.getElementById(item[0] + '_ddlMin3').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin4') != null) {
        document.getElementById(item[0] + '_ddlMin4').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin5') != null) {
        document.getElementById(item[0] + '_ddlMin5').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin6') != null) {
        document.getElementById(item[0] + '_ddlMin6').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlMin7') != null) {
        document.getElementById(item[0] + '_ddlMin7').disabled = false;
    }

    if (document.getElementById(item[0] + '_DropDownList0') != null) {
        document.getElementById(item[0] + '_DropDownList0').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList1') != null) {
        document.getElementById(item[0] + '_DropDownList1').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList2') != null) {
        document.getElementById(item[0] + '_DropDownList2').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList3') != null) {
        document.getElementById(item[0] + '_DropDownList3').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList4') != null) {
        document.getElementById(item[0] + '_DropDownList4').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList5') != null) {
        document.getElementById(item[0] + '_DropDownList5').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList6') != null) {
        document.getElementById(item[0] + '_DropDownList6').disabled = false;
    }
    if (document.getElementById(item[0] + '_DropDownList7') != null) {
        document.getElementById(item[0] + '_DropDownList7').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData') != null) {
        document.getElementById(item[0] + '_ddlData').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData0') != null) {
        document.getElementById(item[0] + '_ddlData0').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData1') != null) {
        document.getElementById(item[0] + '_ddlData1').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData2') != null) {
        document.getElementById(item[0] + '_ddlData2').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData3') != null) {
        document.getElementById(item[0] + '_ddlData3').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData4') != null) {
        document.getElementById(item[0] + '_ddlData4').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData5') != null) {
        document.getElementById(item[0] + '_ddlData5').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlData6') != null) {
        document.getElementById(item[0] + '_ddlData6').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddldata7') != null) {
        document.getElementById(item[0] + '_ddldata7').disabled = false;
    }

    if (document.getElementById(item[0] + '_ddlstatus') != null) {
        document.getElementById(item[0] + '_ddlstatus').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlStatusReason') != null) {
        document.getElementById(item[0] + '_ddlStatusReason').disabled = false;
    }
    //for Widal Test
    if (document.getElementById(item[0] + '_txtdilution1') != null) {
        document.getElementById(item[0] + '_txtdilution1').readOnly = false;
    }
    if (document.getElementById(item[0] + '_txtdilution2') != null) {
        document.getElementById(item[0] + '_txtdilution2').readOnly = false;
    }
    if (document.getElementById(item[0] + '_txtdilution3') != null) {
        document.getElementById(item[0] + '_txtdilution3').readOnly = false;
    }
    if (document.getElementById(item[0] + '_txtdilution4') != null) {
        document.getElementById(item[0] + '_txtdilution4').readOnly = false;
    }

    if (document.getElementById(item[0] + '_ddlresult1') != null) {
        document.getElementById(item[0] + '_ddlresult1').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlresult2') != null) {
        document.getElementById(item[0] + '_ddlresult2').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlresult3') != null) {
        document.getElementById(item[0] + '_ddlresult3').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlresult4') != null) {
        document.getElementById(item[0] + '_ddlresult4').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlstatus') != null) {
        document.getElementById(item[0] + '_ddlstatus').disabled = false;
    }
    if (document.getElementById(item[0] + '_ddlStatusReason') != null) {
        document.getElementById(item[0] + '_ddlStatusReason').disabled = false;
    }
 
    //Blood Group & Rh Type (HematPattern6.ascx)
    if (document.getElementById(item[0] + '_ddlData1') != null) {
        document.getElementById(item[0] + '_ddlData1').readOnly = false;
    }
    if (document.getElementById(item[0] + '_ddlData2') != null) {
        document.getElementById(item[0] + '_ddlData2').readOnly = false;
    }

    var ObjtxtReason = document.getElementById(txtReason);
    if (ObjtxtReason != null) {
        document.getElementById(txtReason).readOnly = false;
    }

    var ObjtxtResult = document.getElementById(txtResult);
    if (ObjtxtResult != null) {
        document.getElementById(txtResult).readOnly = false;
    }
    var ObjtxtControl = document.getElementById(txtControl);
    if (ObjtxtControl != null) {
        document.getElementById(txtControl).readOnly = false;
    }
    var ObjtxtPatient = document.getElementById(txtPatient);
    if (ObjtxtPatient != null) {
        document.getElementById(txtPatient).readOnly = false;
    }
    var isNonEditable = false;
    if (document.getElementById(item[0] + '_hdnIsNonEditable') != null && document.getElementById(item[0] + '_hdnIsNonEditable').value == "True") {
        isNonEditable = true;
    }
    else {
        isNonEditable = false;
    }
    var ObjtxtValue = document.getElementById(txtValue);
     if (ObjtxtValue != null && ColorFlag==0) {
        document.getElementById(txtValue).readOnly = isNonEditable;
    }
    if (ObjtxtValue != null && ColorFlag==1) {
        document.getElementById(txtValue).readOnly = true;
    }
    var Objtxtmins = document.getElementById(txtmins);
    if (Objtxtmins != null) {
        document.getElementById(txtmins).readOnly = false;
    }
    var ObjtxtSecs = document.getElementById(txtSecs);
    if (ObjtxtSecs != null) {
        document.getElementById(txtSecs).readOnly = false;
    }
    var ObjtxtSource = document.getElementById(txtSource);
    if (ObjtxtSource != null) {
        document.getElementById(txtSource).readOnly = false;
    }
    var ObjtxtClinicalDiagnosis = document.getElementById(txtClinicalDiagnosis);
    if (ObjtxtClinicalDiagnosis != null) {
        document.getElementById(txtClinicalDiagnosis).readOnly = false;
    }
    var ObjtxtClinicalNotes = document.getElementById(txtClinicalNotes);
    if (ObjtxtClinicalNotes != null) {
        document.getElementById(txtClinicalNotes).readOnly = false;
    }
    var ObjtxtCultureReport = document.getElementById(txtCultureReport);
    if (ObjtxtCultureReport != null) {
        document.getElementById(txtCultureReport).readOnly = false;
    }
    var ObjtxtSample = document.getElementById(txtSample);
    if (ObjtxtSample != null) {
        document.getElementById(txtSample).readOnly = false;
    }
    var ObjtxtMicroscopy = document.getElementById(txtMicroscopy);
    if (ObjtxtMicroscopy != null) {
        document.getElementById(txtMicroscopy).readOnly = false;
    }
    var ObjtxtGrowth = document.getElementById(txtGrowth);
    if (ObjtxtGrowth != null) {
        document.getElementById(txtGrowth).readOnly = false;
    }
    var ObjtxtColonyCount = document.getElementById(txtColonyCount);
    if (ObjtxtColonyCount != null) {
        document.getElementById(txtColonyCount).readOnly = false;
    }
    var ObjtxtOrgan = document.getElementById(txtOrgan);
    if (ObjtxtOrgan != null) {
        document.getElementById(txtOrgan).readOnly = false;
    }
    var ObjtxtSpecimen = document.getElementById(txtSpecimen);
    if (ObjtxtSpecimen != null) {
        document.getElementById(txtSpecimen).readOnly = false;
    }
    var ObjtxtKohMount = document.getElementById(txtKohMount);
    if (ObjtxtKohMount != null) {
        document.getElementById(txtKohMount).readOnly = false;
    }
    var Objtxt10KohMount = document.getElementById(txt10KohMount);
    if (Objtxt10KohMount != null) {
        document.getElementById(txt10KohMount).readOnly = false;
    }
    var ObjtxtLPCB = document.getElementById(txtLPCB);
    if (ObjtxtLPCB != null) {
        document.getElementById(txtLPCB).readOnly = false;
    }
    var ObjtxtGlucose = document.getElementById(txtGlucose);
    if (ObjtxtGlucose != null) {
        document.getElementById(txtGlucose).readOnly = false;
    }
    var ObjtxtLDH = document.getElementById(txtLDH);
    if (ObjtxtLDH != null) {
        document.getElementById(txtLDH).readOnly = false;
    }
    var ObjtxtDilution = document.getElementById(txtDilution);
    if (ObjtxtDilution != null) {
        document.getElementById(txtDilution).readOnly = false;
    }
    var ObjtxtReason = document.getElementById(txtReason);
    if (ObjtxtReason != null) {
        document.getElementById(txtReason).readOnly = false;
    }
    var ObjtxtMedRemarks = document.getElementById(txtMedRemarks);
    if (ObjtxtMedRemarks != null) {
        document.getElementById(txtMedRemarks).readOnly = false;
    }
    var ObjtxtOrgan = document.getElementById(txtOrgan);
    if (ObjtxtOrgan != null) {
        document.getElementById(txtOrgan).readOnly = false;
    }
    var ObjClinicalNotes = document.getElementById(ClinicalNotes);
    if (ObjClinicalNotes != null) {
        document.getElementById(ClinicalNotes).readOnly = false;
    }
    var ObjtxtSpecimenNo = document.getElementById(txtSpecimenNo);
    if (ObjtxtSpecimenNo != null) {
        document.getElementById(txtSpecimenNo).readOnly = false;
    }    
}

//Using Javascript:
function BindGridViewNew(PVisitID, POrgid, PPatternID, PInvID, PPatternIDLabel, PPatternClassName) {
    try {
        document.getElementById('hdnPatternID').value = PPatternIDLabel;
        document.getElementById('hdnPatientVisitID').value = PVisitID;
        document.getElementById('hdnMappingPatternID').value = PPatternClassName;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetPatientInvestigationValuesHisiory",
            data: "{patientVisitID:" + PVisitID + ",OrgID:" + POrgid + ",PatternID:" + PPatternID + ",InvID:" + PInvID + "}",
            success:
                      function(data) {
            ClearPopUp1();
                          GetPatientTestHistory(data.d);
                      },
            error:
                      function(XMLHttpRequest, textStatus, errorThrown) {
                          alert(XMLHttpRequest.responseText);
                      }
        });
        //WebService.GetPatientInvestigationValuesHisiory(PVisitID, POrgid, PPatternID, PInvID, GetLabHistory1);
    }
    catch (e) {
    }
}
function GetPatientTestHistory(result) {
    try {
        //for (var n = 0; n < result.length; n++) {
        for (var n = (result.length) - 1; n >= 0; n--) {
            var TableInvValue = '';
            TableInvValue = GetInvestigationValues(result[n].Value);
            var row = document.getElementById('tblPatientTestHistory1').insertRow(1);
            //alert("rwNumber1:" + rwNumber);
            //rwNumber = Attributes + rwNumber;
            var date = result[n].UOMCode;
            row.id = n;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            var cell9 = row.insertCell(8);

            //alert("rwNumber1:" + rwNumber);
            //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + n + ");' src='../Images/Delete.jpg' />";
            //cell1.width = "6%";
            
            if (result[n].VisitID == document.getElementById('hdnPatientVisitID').value) {

                cell1.innerHTML = '<input type="Radio" name="rdsequence" style = "background-color;Green" onclick="javascript:SetRadioIndex(' + result[n].PatientInvID + ',this);" runat="server" value="' + result[n].PatientInvID + '"/>';
            }
            else {
                cell1.innerHTML = '<input type="Radio" name="rdsequence" id=' + n + ' onclick="javascript:SetRadioIndex(this.id);" runat="server" value="' + result[n].PatientInvID + '" visible="false"/>';
               
            }

            cell2.innerHTML = result[n].VisitID;
            cell3.innerHTML = date;
            cell4.innerHTML = result[n].InvestigationName;
            cell5.innerHTML = TableInvValue; //result[n].Value;
            cell6.innerHTML = result[n].ReferenceRange;
            cell7.innerHTML = result[n].Reason;
            cell8.innerHTML = result[n].DisplayStatus;
            var strKitName;
            var strInstrumentName;
            if (result[n].KitName == null || result[n].KitName == '') {
                strKitName = '';
            }
            else {
                strKitName = result[n].KitName;
            }
            if (result[n].InstrumentName == null || result[n].InstrumentName == '') {
                strInstrumentName = '';
            }
            else {
                strInstrumentName = result[n].InstrumentName;
            }
            if (strKitName != '' && strInstrumentName != '') {
                cell9.innerHTML = strKitName + '/' + strInstrumentName;
            }
            else {
                cell9.innerHTML = '';
            }
            if (result[n].ConvValue == "Y") {
                cell1.style.color = 'Green';
                cell2.style.color = 'Green';
                cell3.style.color = 'Green';
                cell4.style.color = 'Green';
                cell5.style.color = 'Green';
                cell6.style.color = 'Green';
                cell7.style.color = 'Green';
                cell8.style.color = 'Green';
                cell9.style.color = 'Green';

            }
            else {
                cell1.style.color = 'Blue';
                cell2.style.color = 'Blue';
                cell3.style.color = 'Blue';
                cell4.style.color = 'Blue';
                cell5.style.color = 'Blue';
                cell6.style.color = 'Blue';
                cell7.style.color = 'Blue';
                cell8.style.color = 'Blue';
                cell9.style.color = 'Blue';
            }
//            if (n == result.length - 1) {
//                cell1.style.color = 'Green';
//                cell2.style.color = 'Green';
//                cell3.style.color = 'Green';
//                cell4.style.color = 'Green';
//                cell5.style.color = 'Green';
//                cell6.style.color = 'Green';
//                cell7.style.color = 'Green';
//                cell8.style.color = 'Green';
//                cell9.style.color = 'Green';
//            }

            //j++;
            //document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
            document.getElementById('tblPatientTestHistory1').style.display = 'block';
        }
        document.getElementById('btnDummy1').click();
    }
    catch (e) {
    }
}
function GetInvestigationValues(Values) {
   // //debugger;
    var PpatternID = document.getElementById('hdnMappingPatternID').value;
    var TableInvValue = '';
    switch (PpatternID) {
        case 'Investigation_checkInvest':
            TableInvValue = Values;
            break;
        case 'Investigation_BioPattern2':
            TableInvValue = Values;
            break;
        case 'Investigation_BioPattern3':
            TableInvValue = Values;
            break;
        case 'Investigation_HematPattern6':
            TableInvValue = Values;
            break;
        case 'Investigation_HematPattern10':
            //TableInvValue = Values;
            var ListInvValue = Values.split('^');
            var i = 1;
            var ControlPT = '';
            var PatientPT = '';
            var INR = '';
            for (var count = 0; count < ListInvValue.length - 1; count++) {
                if (ListInvValue[count] != '') {

                    var SplitListInvValue = ListInvValue[count].split('~');
                    if (SplitListInvValue[0].indexOf('-Control PT') > 0) {
                        ControlPT = SplitListInvValue[1];
                    }
                    else if (SplitListInvValue[0].indexOf('-Patient PT') > 0) {
                        PatientPT = SplitListInvValue[1];
                    }
                    else if (SplitListInvValue[0].indexOf('INR') >= 0) {
                        INR = SplitListInvValue[1];
                    }
                }
            }
            TableInvValue = ControlPT + "," + PatientPT + "," + INR;
            break;
        case 'Investigation_AntibodyWithMethod':
            var ListInvValue = Values.split('^');
            var i = 1;
            var ControlPT = '';
            var PatientPT = '';
            var INR = '';
            var value1 = ListInvValue[0].split('~');
            value1 = value1[1];
            var value2 = ListInvValue[1].split('~');
            value2 = value2[1];

            for (var count = 0; count < ListInvValue.length - 1; count++) {
                if (ListInvValue[count] != '') {

                    var SplitListInvValue = ListInvValue[count].split('~');
                    switch (count) {
                        case '0':
                            var value1 = SplitListInvValue[1];
                            break;
                        case '1':
                            var value2 = SplitListInvValue[1];
                            break;
                    }
                }
            }
            TableInvValue = value2 + "," + value1;
            break;
        case 'Investigation_ClinicalPattern12':
            TableInvValue = Values;
            break;
        case 'Investigation_BleedingTime':
            TableInvValue = Values;
            break;
    }
    return TableInvValue;

}
function ClearPopUp1() {

    var otable = document.getElementById('tblPatientTestHistory1');
    while (otable.rows.length > 1) {
        otable.deleteRow(otable.rows.length - 1);
    }
}
function SetRadioIndex(id) {
    document.getElementById('hdnPatientInvID').value = id;
}
function htmlDecode(input) {
    try {
        var e = document.createElement('div');
        e.innerHTML = input;
        return e.childNodes[0].nodeValue;
    }
    catch (e) {
        return false;
    }
    return false;
}
function SetValues() {
    var id = parseInt(document.getElementById('hdnPatientInvID').value);
    var Setcount = 0;
    var PpatternID = '';
    var PatternIDLabel = '';

    PpatternID = document.getElementById('hdnMappingPatternID').value;

    PatternIDLabel = document.getElementById('hdnPatternID').value;

    var txtRefRange = PatternIDLabel + '_txtRefRange';
    var txtReason = PatternIDLabel + '_txtReason';

    var table = document.getElementById('tblPatientTestHistory1');

    //var rows = document.getElementById("tblPatientTestHistory1").rows;
    for (var r = 0, n = table.rows.length; r < n; r++) {
        for (var c = 0, m = table.rows[r].cells.length - 1; c < m; c++) {
            // alert(table.rows[r].cells[c].innerHTML);
            // alert(table.rows[r].cells[c].nextSibling.innerText);
            //if (document.getElementById('hdnPatientInvID').value == table.rows[r].cells[0].childNodes[0].defaultValue) {

            if (document.getElementById('hdnPatientInvID').value == id) {
                var TableInvValue = '';
                var finid = (id + 1);
                TableInvValue = table.rows[finid].cells[4].innerHTML;

                switch (PpatternID) {
                    case 'Investigation_checkInvest':
                        var txtValue = PatternIDLabel + '_txtValue';
                        document.getElementById(txtValue).value = htmlDecode(TableInvValue);
                        document.getElementById(txtValue).onblur();
                        break;
                    case 'Investigation_BioPattern2':
                        var tr = 0;
                        var ddlData = PatternIDLabel + '_ddlData';
                        var txtResult = PatternIDLabel + '_txtValue';
                        var hdnddlData = PatternIDLabel + '_hdnddlData';
                        var ddlDataValue = document.getElementById(hdnddlData).value;
                        var SplitValue = TableInvValue.split(',');
                        if (SplitValue.length > 0) {
                            for (var count = 0; count < SplitValue.length - 1; count++) {
                                    document.getElementById(ddlData).value = SplitValue[0];
                                    tr = 1;
                                    break;
                            }
                            if (tr == 1) {
                                if (SplitValue[1] != '') {
                                    document.getElementById(txtResult).value = htmlDecode(SplitValue[1]);
                                    document.getElementById(txtResult).onblur();
                                }
                            }
                            else {
                                document.getElementById(txtResult).value = htmlDecode(SplitValue[0]);
                                document.getElementById(txtResult).onblur();
                            }
                        }
                        break;
                    case 'Investigation_BioPattern3':
                        var ddlData = PatternIDLabel + '_ddlData';
                        var hdnddlData = PatternIDLabel + '_hdnddlData';
                        var ddlDataValue = document.getElementById(hdnddlData).value;
                        var ListDataValue = ddlDataValue.split('~');
                        var SplitValue = TableInvValue.split(',');
                        if (ListDataValue.length > 0 && SplitValue.length > 0) {
                            for (var count = 0; count < ListDataValue.length - 1; count++) {
                                if (ListDataValue[count] == SplitValue[0]) {
                                    document.getElementById(ddlData).value = SplitValue[0];
                                    document.getElementById(ddlData).onchange();
                                    tr = 1;
                                    break;
                                }
                            }
                        }
                        break;
                    case 'Investigation_HematPattern6':
                        var ddlData1 = PatternIDLabel + '_ddlData1';
                        var ddlData2 = PatternIDLabel + '_ddlData2';
                        var hdnddlData1 = PatternIDLabel + '_hdnddlData1';
                        var hdnddlData2 = PatternIDLabel + '_hdnddlData2';
                        var ddlData1Value = document.getElementById(hdnddlData1).value;
                        var ddlData2Value = document.getElementById(hdnddlData2).value;
                        var ListData1Value = ddlData1Value.split('~');
                        var ListData2Value = ddlData1Value.split('~');
                        var SplitValue = TableInvValue.split(' ');
                        if (ListData1Value.length > 0 && SplitValue.length > 0) {
                            for (var count = 0; count < ListData1Value.length - 1; count++) {
                                if (ListData1Value[count] == SplitValue[0]) {

                                    document.getElementById(ddlData2).value = SplitValue[0];
                                    break;
                                }
                            }
                        }
                        if (ListData2Value.length > 0 && SplitValue.length > 0) {
                            for (var count = 0; count < ListData2Value.length - 1; count++) {
                                if (ListData2Value[count] == SplitValue[0]) {
                                    document.getElementById(ddlData1).value = SplitValue[0];
                                    break;
                                }
                            }
                        }
                        break;
                    case 'Investigation_HematPattern10':
                        var txtControl = PatternIDLabel + '_txtControl';
                        var txtPatient = PatternIDLabel + '_txtPatient';
                        var txtINR = PatternIDLabel + '_txtINR';
                        var ListInvValue = TableInvValue.split(',');
                        document.getElementById(txtControl).value = ListInvValue[0];
                        document.getElementById(txtPatient).value = ListInvValue[1];
                        document.getElementById(txtINR).value = ListInvValue[2];
                        break;
                    case 'Investigation_AntibodyWithMethod':
                        var tr = 0;
                        var ddlData = PatternIDLabel + '_ddlData';
                        var txtResult = PatternIDLabel + '_txtResult';
                        var hdnddlData1 = PatternIDLabel + '_hdnddlData1';
                        var ddlData1Value = document.getElementById(hdnddlData1).value;
                        var ListData1Value = ddlData1Value.split('~');
                        var ListInvValue = TableInvValue.split(',');
                        if (ListData1Value.length > 0 && ListInvValue.length > 0) {
                            for (var count = 0; count < ListData1Value.length - 1; count++) {
                                if (ListData1Value[count] == ListInvValue[0]) {
                                    document.getElementById(ddlData).value = ListInvValue[0];
                                    tr = 1;
                                    break;
                                }
                            }
                            if (tr == 1) {
                                if (ListInvValue[1] != '') {
                                    document.getElementById(txtResult).value = ListInvValue[1];
                                }
                            }
                            else {
                                document.getElementById(txtResult).value = ListInvValue[0];
                            }
                        }
                        break;
                    case 'Investigation_ClinicalPattern12':
                        var tr = 0;
                        var ddlData = PatternIDLabel + '_ddlData';
                        var txtResult = PatternIDLabel + '_txtResult';
                        var hdnddlData = PatternIDLabel + '_hdnddlData';
                        var ddlDataValue = document.getElementById(hdnddlData).value;
                        var ListDataValue = ddlDataValue.split('~');
                        var SplitValue = TableInvValue.split(',');
                        if (ListDataValue.length > 0 && SplitValue.length > 0) {
                            for (var count = 0; count < ListDataValue.length - 1; count++) {
                                if (ListDataValue[count] == SplitValue[0]) {
                                    document.getElementById(ddlData).value = SplitValue[0];
                                    tr = 1;
                                    break;
                                }
                            }
                            if (tr == 1) {
                                if (SplitValue[1] != '') {
                                    document.getElementById(txtResult).value = SplitValue[1];
                                }
                            }
                            else {
                                document.getElementById(txtResult).value = SplitValue[0];
                            }
                        }
                        break;
                    case 'Investigation_BleedingTime':
                        var txtSecsCtrl = PatternIDLabel + '_txtSecs';
                        var txtminsCtrl = PatternIDLabel + '_txtmins';
                        var txtSecs = '';
                        var txtmins = '';

                        var ListInvValue = TableInvValue.split(' ');

                        if (ListInvValue.length == 2) {
                            if (ListInvValue[1] == "mm/h") {
                                txtSecs = ListInvValue[0];
                            }

                            else if (ListInvValue[1] == "mm/30min") {
                                txtmins = ListInvValue[0];
                            }
                        }

                        if (ListInvValue.length == 4) {
                            switch (ListInvValue[1]) {
                                case "mm/h":
                                    txtSecs = ListInvValue[0];
                                    break;

                                case "mm/30min":
                                    txtmins = ListInvValue[0];
                                    break;
                            }
                            switch (ListInvValue[3]) {
                                case "mm/h":
                                    txtSecs = ListInvValue[2];
                                    break;

                                case "mm/30min":
                                    txtmins = ListInvValue[2];
                                    break;
                            }
                        }
                        if (ListInvValue.length == 2) {
                            if (ListInvValue[1] == "Secs") {
                                txtSecs = ListInvValue[0];
                            }
                            else if (ListInvValue[1] == "Mins") {
                                txtmins = ListInvValue[0];
                            }
                        }
                        if (ListInvValue.length == 4) {
                            switch (ListInvValue[1]) {
                                case "Secs":
                                    txtSecs = ListInvValue[0];
                                    break;

                                case "Mins":
                                    txtmins = ListInvValue[0];
                                    break;

                            }
                            switch (ListInvValue[3]) {
                                case "Secs":
                                    txtSecs = ListInvValue[2];
                                    break;

                                case "Mins":
                                    txtmins = ListInvValue[2];
                                    break;
                            }
                        }
                        document.getElementById(txtSecsCtrl).value = txtSecs;
                        document.getElementById(txtminsCtrl).value = txtmins;
                }
                //alert(table.rows[r].cells[c].innerHTML);
                //document.getElementById(txtValue).value = table.rows[r].cells[4].innerHTML
                lnkEdit_OnClientClick(PatternIDLabel)
                Setcount = 1;
                break;

            }
            else {
                break;
            }
        }
    }
    if (Setcount = 0) {
        alert("Please Choose Test");
        return false;
    }
    document.getElementById('btnpopClose1').click();
}

