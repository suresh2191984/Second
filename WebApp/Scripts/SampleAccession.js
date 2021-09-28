function ClientSelected(source, eventArgs) {
    ////debugger;
    document.getElementById('hdnClientID').value = eventArgs.get_value();
}
function SittingEpisodeSelected(source, eventArgs) {
    document.getElementById('txtEpisodeName').value = eventArgs.get_text();
    var str = eventArgs.get_value().split('~');

    document.getElementById('hdnEpisodeID').value = str[9];

    var OrgID = document.getElementById('hdnOrgID').value;
    var ClientID = document.getElementById('hdnClientID').value;
    var EpiosdeID = str[9];
    var pRateID = document.getElementById('hdnBaseRateID').value;
}
function ConsignmentSelected(source, eventArgs) {
    document.getElementById('hdnConsignmentNo').value = eventArgs.get_text();
}

function SetConsignContextKey() {
    var OrgID = document.getElementById('hdnOrgID').value;
    var sid = document.getElementById('hdnEpisodeID').value;
    var eps = ''; //document.getElementById('hdnClientByEpisodeID').value;
    var ClinetID = document.getElementById('hdnClientID').value;
    var sval = eps + '~' + sid + '~' + OrgID + '~' + ClinetID;
    if (sid != "" && ClinetID != "") {
        $find('AutoConsignment').set_contextKey(sval);
    }
}
function CheckConsignmentNo() {
    if (document.getElementById('txtConsignment').value == "") {
        document.getElementById('hdnConsignmentNo').value = "";
    }
}
function IsValid() {
    try {
        var Reason = '';
        var count = 0;
        var retvalue = 0;
        $('table[id$="grdChildResult"]  tr:not(:first)').each(function(i, n) {
            $row = $(this).closest("tr");
            count = count + 1;
            var len = $row.length;
            var ReceivedDate = $row.find('input[id$="txtReceivedDatetime"]').val();
            if (ReceivedDate == "") {
                alert("Please enter sample received date");
                retvalue = 1;
                return false;
            }
            var InvSampleStatusID = $row.find('input[id$="hdnInvSampleStatusID"]').val();
            if (InvSampleStatusID == 1) {
                var ddlStatus = $row.find('select[id$="ddlSampleStatus"] :selected');
                if (ddlStatus != null && ddlStatus.val() == "4") {
                    var ddlReason = $row.find('select[id$="ddlAddReason"] :selected');
                    if (ddlReason != null && ddlReason.val() == 0) {
                        alert("Please select reason");
                        retvalue = 1;
                        return false;
                        // Reason = $(ddlReason).val();
                        // VisitName = $(ddlVisitNameOption).text();
                    } 
                }
            } 

            var Volume = $row.find('input[id$="txtVolume"]').val();
            if (Volume != "" && Volume != "0") {
                var ddlUnits = $row.find('select[id$="ddlvolumeUnits"] :selected');
                if (ddlUnits != null && ddlUnits.val() == 0) {
                    alert("Please select unit");
                    retvalue = 1;
                    return false;
                }
            }
        });
        if (retvalue == 1) {
            return false;
        }
        else {
            if ($('table[id$="grdChildResult"]  tr').length > 1) {
                return TableToJson();
                //return true;
            }
        }
    }
    catch (e) {
        throw e;
    }
}
function TableToJson() {
    var lstobjSampleTracker = [];
    var lstPatientVisit = [];
    var sampleID = 0, sampleContainerID = 0, invSampleStatusDesc = "", barcodeNumber = "0", locationName = "", recSampleLocID = 0, collectedDateTime = "";
    var invSampleStatusID = 0;
    var investigationID = "", strInvID = "";
    var selectedStatusOption, selectedRecLocOption, selectedOutsourceLocOption, selectedResonOption;
    var referralID = -1;
    var $row;
    var $Childrow
    var lstCollectedSampleStatus = [];
    var tblAttributes = $('table[id$="grdChildResult"]');
    var vmValue, vmUnitId, shippingConditionId = 0;
    var count = 0;
    var VisitID = '';
    var SubjectNo = '';
    var SubjectName = '';
    var SDOB = '';
    var AgeValue = '';
    var GenderID = '';
    var CheckBoxValue = '';
    var CollectedDate = '';
    var ShippingConditionID = '';
    $('table[id$="grdChildResult"]  tr:not(:first)').each(function(i, n) {
        $row = $(this).closest("tr");
        count = count + 1;
        var len = $row.length;
        PatientVisitID = $row.find('input[id$="hdnPatientVisitID"]').val();
        SampleID = $row.find('input[id$="hdnSampleID"]').val();
        // InvSampleStatusID = $row.find('input[id$="hdnInvSampleStatusID"]').val(); //ddl
        var ddlStatus = $row.find('select[id$="ddlSampleStatus"] :selected');
        InvSampleStatusID = ddlStatus.val();

        Remarks = $row.find('input[id$="txtRemarks"]').val();

        var Orgid = document.getElementById('hdnOrgID').value;
        var CollectedIn = document.getElementById('hdnCollectedIn').value;
        var DeptID = document.getElementById('hdnDeptID').value;
        var CreatedBy = document.getElementById('hdnCreatedBy').value;

        var Reason = $row.find('select[id$="ddlAddReason"] :selected').text();
        var ReasonID = $row.find('select[id$="ddlAddReason"] :selected').val();
        var Units = $row.find('select[id$="ddlvolumeUnits"] :selected').val();
        var Volume = $row.find('input[id$="txtVolume"]').val();
        var InvSSID = $row.find('input[id$="hdnInvSampleStatusID"]').val();
        if (InvSampleStatusID != 13 && InvSSID==1) {
            lstobjSampleTracker.push({
                SampleID: SampleID,
                CreatedBy: CreatedBy,
                PatientVisitID: PatientVisitID,
                OrgID: Orgid,
                CollectedIn: CollectedIn,
                DeptID: DeptID,
                Remarks: Remarks,
                Reason: Reason,
                ReasonID: ReasonID,
                InvSampleStatusID: InvSampleStatusID,
                SampleVolume: Volume == "" ? 0 : Volume,
                SampleUnit: Units
            });
        }
    });

    var Orgid = document.getElementById('hdnOrgID').value;

    $('table[id$="grdResult"] input[type=checkbox]:checked').each(function() {
        PatientVisitID = $(this).closest("tr").find('input[id$="hdnParPatientVisitID"]').val();
        lstPatientVisit.push({
            EpisodeVisitId: PatientVisitID,
            IsDelete: 'Y'
        });
    });




    var AllowUpdate = 0;

    if (lstobjSampleTracker.length > 0) {
        $('#hdnLstSampleTracker').val(JSON.stringify(lstobjSampleTracker));
        AllowUpdate = 1;
    }
    if (lstPatientVisit.length > 0) {
        $('#hdnLstPatientVisit').val(JSON.stringify(lstPatientVisit));
        AllowUpdate = 1;
    }
    if (AllowUpdate == 0) {
        alert('Sample Collection Queue is Empty, please check the list!');
        return false;
    }
    if (confirm('Please confirm to proceed') == true) {
    }
    else {
        return false;
    }
    return true;
}

function checkisempty() {
    if (document.getElementById('hdnClientID').value == "") {
        document.getElementById('txtClient').value = "";
        document.getElementById('txtClient').focus();
        alert("Select Site Name");
        return false;
    }
    if (document.getElementById('txtClient').value == "") {
        document.getElementById('txtClient').value = "";
        document.getElementById('txtClient').focus();
        alert("Select Site Name");
        return false;
    }
    if (document.getElementById('hdnEpisodeID').value == "") {
        document.getElementById('txtEpisodeName').value = "";
        document.getElementById('txtEpisodeName').focus();
        alert("Enter Episode Name");
        return false;
    }
    if (document.getElementById('txtEpisodeName').value == "") {
        document.getElementById('txtEpisodeName').value = "";
        document.getElementById('txtEpisodeName').focus();
        alert("Enter Episode Name");
        return false;
    }
    if (document.getElementById('hdnConsignmentNo').value == "") {
        document.getElementById('txtConsignment').value = "";
        document.getElementById('txtConsignment').focus();
        alert("Enter Consignment No");
        return false;
    }
    if (document.getElementById('txtConsignment').value == "") {
        document.getElementById('txtConsignment').value = "";
        document.getElementById('txtConsignment').focus();
        alert("Enter Consignment No");
        return false;
    }

    return true;
}
function CallShowPopUp(id) {
    document.getElementById('btnDummy1').click();

    var CtrlID = id;
    var obj = document.getElementById(CtrlID);

}
function ClearPopUp1() {

}

function SelectedTemp(source, eventArgs) {

    document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
    Tblist();

}

function Tblist() {
    document.getElementById('trPatientDetails').style.display = "block";
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    document.getElementById('lblPatientDetails').innerHTML = '';
    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Name</th>"
                           + "<th style='width:50px;'>Number</th>"
                           + "<th style='width:300px;'>Address</th>"
                           + "<th style='Widht:100px;'>Phone</th> </thead>";
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[8] + ',' + x[9] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";



    var tab = table + tr + end;
    document.getElementById('lblPatientDetails').innerHTML = tab;
    tbshow();


}
function SelectedTempClient(source, eventArgs) {
    document.getElementById('hdnSelectedClientTempDetails').value = eventArgs.get_value();
    TbClientlist();

}
function TbClientlist() {
    var y = '';
    var x = document.getElementById('hdnSelectedClientTempDetails').value.split("###");


}

function SelectedPatient(source, eventArgs) {


    var isPatientDetails = "";

    isPatientDetails = eventArgs.get_value();

    var PatientName = eventArgs.get_text().split(':')[0];
    var PatientNumber = eventArgs.get_text().split(':')[1];
    var PatientVisitType = eventArgs.get_text().split(':')[2];

    var PatientTITLECode = isPatientDetails.split('~')[0];
    var PatientAge = isPatientDetails.split('~')[3];
    var PatientDOB = isPatientDetails.split('~')[4];
    var PatientSex = isPatientDetails.split('~')[5];
    var PatientMaritalStatus = isPatientDetails.split('~')[6];

    var PatientID = isPatientDetails.split('~')[14];
    var PatientEmailID = isPatientDetails.split('~')[15];
    var SujectNo = isPatientDetails.split('~')[16];
    var VisitPurpose = 3
    var PatientPreviousDue = isPatientDetails.split('~')[19];


    //document.getElementById('ddSalutation').value = PatientTITLECode
    document.getElementById('txtSujectNo').value = SujectNo;
    document.getElementById('txtSubjectName').value = PatientName;
    //  document.getElementById('hdnPatientNumber').value = PatientNumber
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    //document.getElementById('ddMarital').value = PatientMaritalStatus;
    document.getElementById('hdnPatientID').value = PatientID;
    var textBox = $get('tDOB');
    if (textBox.AjaxControlToolkitTextBoxWrapper) {
        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
    }
    else {
        textBox.value = PatientDOB;
    }
    document.getElementById('lblPatientDetails').innerHTML = '';
    document.getElementById('trPatientDetails').style.display = "none";

}





//

var ns4 = document.layers
var ie4 = document.all
var ns6 = document.getElementById && !document.all


var dragswitch = 0
var nsx
var nsy
var nstemp

function drag_dropns(name) {
    if (!ns4)
        return
    temp = eval(name)
    temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
    temp.onmousedown = gons
    temp.onmousemove = dragns
    temp.onmouseup = stopns
}

function gons(e) {
    temp.captureEvents(Event.MOUSEMOVE)
    nsx = e.x
    nsy = e.y
}
function dragns(e) {
    if (dragswitch == 1) {
        temp.moveBy(e.x - nsx, e.y - nsy)
        return false
    }
}

function stopns() {
    temp.releaseEvents(Event.MOUSEMOVE)
}

//drag drop function for ie4+ and NS6////
/////////////////////////////////


function drag_drop(e) {
    if (ie4 && dragapproved) {
        crossobj.style.left = tempx + event.clientX - offsetx
        crossobj.style.top = tempy + event.clientY - offsety
        return false
    }
    else if (ns6 && dragapproved) {
        crossobj.style.left = tempx + e.clientX - offsetx + "px"
        crossobj.style.top = tempy + e.clientY - offsety + "px"
        return false
    }
}

function initializedrag(e) {
    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
    var firedobj = ns6 ? e.target : event.srcElement
    var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
    while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
        firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
    }

    if (firedobj.id == "dragbar") {
        offsetx = ie4 ? event.clientX : e.clientX
        offsety = ie4 ? event.clientY : e.clientY

        tempx = parseInt(crossobj.style.left)
        tempy = parseInt(crossobj.style.top)

        dragapproved = true
        document.onmousemove = drag_drop
    }
}

////drag drop functions end here//////

function hidebox() {
    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

    crossobj.style.display = "none"

}
function Itemhidebox() {
    crossobj = ns6 ? document.getElementById("ShowBillingItems") : document.all.ShowBillingItems

    crossobj.style.display = "none"

}

function tbItemshow() {
    document.onmouseup = new Function("dragapproved=false")

    document.getElementById("ShowBillingItems").style.display = "block";
}

function tbshow() {
    document.onmouseup = new Function("dragapproved=false")

    document.getElementById("showimage").style.display = "block";
}
function Make_OnClick(sEditedData) {
}

function clearPageControlsValue(ClearType) {
    if (document.getElementById('hdnIsEditMode').value == 'N') {
        if (ClearType == "N") {
            document.getElementById('txtSubjectName').value = "";
            if (document.getElementById('txtSubjectName') != null) {
                try {
                    document.getElementById('txtSubjectName').focus();
                }
                catch (err) { }
            }
        }
        //document.getElementById('txtSujectNo').value = ''; 
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('txtDOBNos').value = "";
        document.getElementById('ddlDOBDWMY').value = "Year(s)";
        document.getElementById('ddlSex').selectedvalue = 1;
        document.getElementById('hdnPatientID').value = '';
    }
}
function alpha(e) {
    var k;
    document.all ? k = e.keyCode : k = e.which;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
}
function Test() {
    alert(document.getElementById('hdnPatientID').value);
}