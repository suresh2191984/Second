function ClientSelected(source, eventArgs) {
    ////debugger;
    document.getElementById('hdnClientID').value = eventArgs.get_value();
}
function SittingEpisodeSelected(source, eventArgs) {
    document.getElementById('txtEpisodeName').value = eventArgs.get_text();
    var str1 = eventArgs.get_value().split('#');
    var str = str1[0].split('~');
    if (str[17] == 'N') {
        var mesg = "The Study (" + str[3] + ") Period is already Expired, Please Contact Project Manager!";
        alert(mesg);
        document.getElementById('hdnEpisodeID').value = "";
        document.getElementById('txtEpisodeName').value = "";
        document.getElementById('txtEpisodeName').focus();
        return false;
    }
    document.getElementById('hdnEpisodeID').value = str[9];

    var OrgID = document.getElementById('hdnOrgID').value;
    var ClientID = document.getElementById('hdnClientID').value;
    var EpiosdeID = str[9];
    var pRateID = document.getElementById('hdnBaseRateID').value;
    WebService.GetEpisodeVisitDetails(OrgID, EpiosdeID, ClientID, pRateID, GetEpisodeVisitDetail);
    document.getElementById('tdSubjectVisitDetails').style.display = 'block';
}

function GetEpisodeVisitDetail(result) {
    ////debugger;

    while (count = document.getElementById('tblEpisodeVisitDetails').rows.length) {
        for (var j = 0; j < document.getElementById('tblEpisodeVisitDetails').rows.length; j++) {
            document.getElementById('tblEpisodeVisitDetails').deleteRow(j);
        }
    }
    //  $('[id$="ddlVisitName"]').remove(); 
    var sel = document.getElementById("ddlVisitName");
    var opts = sel.getElementsByTagName("option");
    for (var i = 0, j = opts.length; i < j; i++) {
        sel.removeChild(opts[0]);
    }
    if (result.length > 0) {
        var Headrow = document.getElementById('tblEpisodeVisitDetails').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);

        cell1.innerHTML = "S.No.";
        cell2.innerHTML = "Episode Name";
        cell3.innerHTML = "Episode No.";
        cell4.innerHTML = "Visit Name";
        cell5.innerHTML = "Visit No.";
        cell6.innerHTML = "Test Package";
        cell7.innerHTML = "FeeID";
        cell7.style.display = "none";
        $('[id$="ddlVisitName"]').append($("<option></option>").val(0).html('--Select--'));
        var Rowid = result.length;
        for (var n = 0; n < result.length; n++) {

            var ddlVisitNameValue = result[n].FeeID + '~' + result[n].EpisodeVisitId + '~' + result[n].PackageName + '~' + result[n].Amount;
            $('[id$="ddlVisitName"]').append($("<option></option>").val(ddlVisitNameValue).html(result[n].EpisodeVisitName));
            var TableInvValue = '';
            var row = document.getElementById('tblEpisodeVisitDetails').insertRow(1);


            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);

            cell1.innerHTML = Rowid;
            cell2.innerHTML = result[n].EpisodeName;
            cell3.innerHTML = result[n].EpisodeNumber;
            cell4.innerHTML = result[n].EpisodeVisitName;
            cell5.innerHTML = result[n].EpisodeVisitNumber;
            cell6.innerHTML = result[n].PackageName;
            cell7.innerHTML = result[n].FeeID;
            cell7.style.display = "none";
            document.getElementById('tblEpisodeVisitDetails').style.display = 'block';
            document.getElementById('tdEpisodeVisitDetails').style.display = 'block';
            //document.getElementById('tblSampleAttributes').style.display = 'block';
            Rowid--;
        }
    }
//    else {
//        document.getElementById('tblSampleAttributes').style.display = 'none';
//    }
}

//Sample Attributes Child Table
function LoadSampleAttributes() {
    ////debugger;
    var obj = document.getElementById('ddlVisitName');
    var value = obj.options[obj.selectedIndex].value;
    var InvID = value.split('~');
    var VisitName = obj.options[obj.selectedIndex].text;
    var OrgID = document.getElementById('hdnOrgID').value;
    var ItemAmount = InvID[3];
    var Type = 'PKG';
    var lstOrderedInves = [];
    lstOrderedInves.push({
        ID: InvID[0],
        Type: Type,
        OrgID: OrgID
    });
    if (lstOrderedInves.length > 0) {
        $('#hdnOrderedInvs').val(JSON.stringify(lstOrderedInves));
       // WebService.GetDeptToTrackSamplesWithID(document.getElementById('hdnOrderedInvs').value, OrgID, InvID[0], Type, GetDeptToTrackSamplesWithID);

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetDeptToTrackSamples",
            data: JSON.stringify({ Invs: document.getElementById('hdnOrderedInvs').value, pOrgID: OrgID, pInvID: InvID[0], pType: Type }),
            dataType: "json",
            success: function(data, value) {
                var GetData1 = data.d[0] == "[]" ? '' : JSON.parse(data.d[0]);
                var GetData2 = data.d[1] == "[]" ? '' : JSON.parse(data.d[1]);
                GetDeptToTrackSamplesWithID(GetData1, GetData2)
                //                var PatientName = GetData.First.split(':')[0];
                //                var isPatientDetails = GetData.Second;
                //                var PatientNumber = GetData.First.split(':')[1];
                document.getElementById('hdnOrderedInvs').value = '';
            },
            error: function(result) {
                alert("Error");
            }
        });
       
        document.getElementById('hdnOrderedInvs').value = "";
    }

}

function GetDeptToTrackSamplesWithID(result,result2) {
    while (count = document.getElementById('tblSampleAttributes').rows.length) {
        for (var j = 0; j < document.getElementById('tblSampleAttributes').rows.length; j++) {
            document.getElementById('tblSampleAttributes').deleteRow(j);
        }
    }
    if (result.length > 0) {
        var Headrow = document.getElementById('tblSampleAttributes').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        //    var cell4 = Headrow.insertCell(3);
        //    var cell5 = Headrow.insertCell(4);
        //    var cell6 = Headrow.insertCell(5);
        //    var cell7 = Headrow.insertCell(6);

        cell1.innerHTML = "Additive-Container";
        cell2.innerHTML = "Collected Time";
        cell3.innerHTML = "Shipping Condition";
        //    cell4.innerHTML = "Visit Name";
        //    cell5.innerHTML = "Visit No.";
        //    cell6.innerHTML = "Test Package";
        //    cell7.innerHTML = "FeeID";
        //    $('[id$="ddlVisitName"]').append($("<option></option>").val(0).html('--Select--'));
        for (var n = 0; n < result.length; n++) {

            //        $('[id$="ddlVisitName"]').append($("<option></option>").val(result[n].FeeID).html(result[n].EpisodeVisitName));
            var TableInvValue = '';
            var row = document.getElementById('tblSampleAttributes').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);

            var rowCount = n + 1;
            var textname = "txtCollectedTime" + rowCount;  //"chkSampleContainer" + rowCount;
            var ddmmyyyy = "ddmmyyyy";
            var arrow = "arrow";
            var tru = true;
            var twele = "12";
            var Yes = "Y";
            var SampleCodeSampleContainerID = result[n].SampleCode + '~' + result[n].SampleContainerID + '~' + result[n].RecSampleLocID + '~' + result[n].LocationName;
            var CollectedDate = document.getElementById('hdnCollectedDate').value;
            var chkSampleContainer = '<input id="chkSampleContainer' + SampleCodeSampleContainerID + '" type="checkbox"  title="' + result[n].SampleContainerName + '" size="10" style="width:40px;display:none" value="' + SampleCodeSampleContainerID + '" checked="true" class="Txtboxsmall"><span id="sp">' + result[n].SampleContainerName + '</span></input>';
            var txtCollectedTime = '<input   id="' + textname + '" type="text" maxlength="25" title="dd-MM-yyyy hh:mm:ssAM/PM" size="10" style="width:120px;"  class="Txtboxsmall" ToolTip="dd-MM-yyyy hh:mm:ssAM/PM"  onfocus="javascript:NewCssCal(' + "'" + textname + "'" + ',' + "'" + ddmmyyyy + "'" + ',' + "'" + arrow + "'" + ',' + tru + ',' + "'" + twele + "'" + ',' + "'" + Yes + "'" + ',' + "'" + Yes + "'" + ');" />';
            //            value = "' + CollectedDate + '" 
            var shippingConditionOption = "";
            var lstShippingCondition = JSON.parse($('input[id$="hdnShippingCondition"]').val());
            $.each(lstShippingCondition, function(i, obj) {
                if (obj.Value == '0') {
                    shippingConditionOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else {
                    shippingConditionOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
                }
            });
            var ddlShippingCondition = '<span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlShippingCondition" class="ddl" style="width: 120px;" title="Select Location">' + shippingConditionOption + '</select></span>';

            cell1.innerHTML = chkSampleContainer; // result[n].SampleContainerName;
            cell2.innerHTML = txtCollectedTime;
            cell3.innerHTML = ddlShippingCondition;
            //        cell2.innerHTML = result[n].EpisodeName;
            //        cell3.innerHTML = result[n].EpisodeNumber;
            //        cell4.innerHTML = result[n].EpisodeVisitName;
            //        cell5.innerHTML = result[n].EpisodeVisitNumber;
            //        cell6.innerHTML = result[n].PackageName;
            //        cell7.innerHTML = result[n].FeeID;

            document.getElementById('tblSampleAttributes').style.display = 'block';

            var txtUserTitle = 'dd-MM-yyyy hh:mm:ssAM/PM';

            //$('input[id$="textname"]')
            var Texttimevalue = $('input[id^="txtCollectedTime"]').val();
            $('input[id^="txtCollectedTime"]').watermark(txtUserTitle);




            if (result2.length > 0) {
                $('#hdnPatientInvSampleMapping').val(JSON.stringify(result2));
            }
            
            // $('input[id^="txtCollectedTime"]').mask("dd-MM-yyyy hh:mm:ssAM/PM");

            // $("#txtCollectedTime1").watermark(txtUserTitle);

            //  document.getElementById('tdEpisodeVisitDetails').style.display = 'block'; 
        }
    }
}

//Create Collection of Subjects
function CollectSamplePageAddSample() {
    try {
        ////debugger;
        var errorMessage, sampleName, containerName,
         sampleStatusName, SubjectNo, SubjectName,
         collectedDateTime, DOB, Age, VisitName, AgeType, Gender;
        var sampleCode, containerID, investigationID, shippingConditionID, AgeTypeID, GenderID, VisitID;
        var lstSelectedInvName = "--";
        var lstSelectedInvID = "";
        var PStatusID, VTypeID, PStatus, VType;
        errorMessage = sampleName = containerName =
         sampleStatusName = SubjectNo = SubjectName =
         collectedDateTime = DOB = Age = VisitName = AgeType = "";
        sampleCode = containerID = investigationID = shippingConditionID = AgeTypeID = GenderID = VisitID = 0;
        var lstPatientDueChartList = [];
        var lstPatientInvSampleMapping = [];
        //        var ddlSampleNameOption = $('select[id$="ddlAddSampleName"] :selected');
        //        if (ddlSampleNameOption != null) {
        //            sampleCode = $(ddlSampleNameOption).val();
        //            sampleName = $(ddlSampleNameOption).text();
        //        }
        //        else {
        //            errorMessage += "Select sample name" + "\n";
        //        }

        /**Visit Name**/
        if (!document.getElementById('chkIsUnScheduleVisit').checked) {
            var ddlVisitNameOption = $('select[id$="ddlVisitName"] :selected');
            if (ddlVisitNameOption != null) {
                if ($(ddlVisitNameOption).val() != 0) {
                    VisitID = $(ddlVisitNameOption).val();
                    VisitName = $(ddlVisitNameOption).text();
                }
            }
            else {
                errorMessage += "Select Visit name" + "\n";
            }
        }
        else {
            VisitID = '0~-1~~0';
            VisitName = "UnShedule Visit";
        }
        /**Subject Number**/
        if ($('input[id$="txtSujectNo"]').val() != "") {
            SubjectNo = $('input[id$="txtSujectNo"]').val();
            /**Check Already Added or Not**/
            if ($('#tblCollectionOfSubjects tr').length > 1) {
                $('#tblCollectionOfSubjects tr.parentrow').each(function(i, n) {
                    $row = $(n);
                    count = count + 1;

                    var PriviousSubjectNo = $row.find('input[id$="hdnSubjectNo"]').val();
                    if (PriviousSubjectNo == SubjectNo) {
                        errorMessage += "This Subject is Already Added for Registration Queue" + "\n";
                        return false;
                    }
                });
            }
        }
        else {
            errorMessage += "Enter Subject Number" + "\n";
        }
        /**Subject Name**/
        if ($('input[id$="txtSubjectName"]').val() != "") {
            SubjectName = $('input[id$="txtSubjectName"]').val();
        }
        else {
            errorMessage += "Enter Subject Name" + "\n";
        }
        /**DOB**/
        var ddlDOBDWMYOption = $('select[id$="ddlDOBDWMY"] :selected');
        if (ddlDOBDWMYOption != null) {
            AgeTypeID = $(ddlDOBDWMYOption).val();
            AgeType = $(ddlDOBDWMYOption).text();
        }
        else {
            errorMessage += "Select DOB" + "\n";
        }
        /**Gender**/
        var ddlSexOption = $('select[id$="ddlSex"] :selected');
        if (ddlSexOption != null) {
            GenderID = $(ddlSexOption).val();
            Gender = $(ddlSexOption).text();
        }
        else {
            errorMessage += "Select Gender" + "\n";
        }
        /**Age Value**/
        if ($('input[id$="tDOB"]').val() != "") {
            DOB = $('input[id$="tDOB"]').val();
        }
        else {
            errorMessage += "Enter DOB" + "\n";
        }
        /**Age Type**/
        if ($('input[id$="txtDOBNos"]').val() != "") {
            Age = $('input[id$="txtDOBNos"]').val();
        }
        else {
            errorMessage += "Enter Age" + "\n";
        }

        var ddlPStatus = $('select[id$="ddlPStatus"] :selected');
        if (ddlPStatus != null) {
            PStatusID = $(ddlPStatus).val();
            PStatus = $(ddlPStatus).text();
        }
        else {
            errorMessage += "Select Patient Status" + "\n";
        }
        var ddlVType = $('select[id$="ddlVType"] :selected');
        if (ddlVType != null) {
            VTypeID = $(ddlVType).val();
            VType = $(ddlVType).text();
        }
        else {
            errorMessage += "Select Visit Type" + "\n";
        }

        /**Additive-Container**/
        if (!document.getElementById('chkIsUnScheduleVisit').checked) {
            if ($('table[id$="tblSampleAttributes"] input[type=checkbox]:checked').length <= 0) {
                errorMessage += "Select an Additive-Container" + "\n";
            }
            else {
                var $row;
                var investigationID = "";
                var isExistingInvName = false;
                var selectedSampleList = [];

                $('table[id$="tblSampleAttributes"] input[type=checkbox]:checked').each(function() {

                    var chkvalue = $(this).val();
                    var chkText = $(this).closest("tr").find('span[id$="sp"]').html();
                    var txtdate = $(this).closest("tr").find("input[type=text]").val(); // Date.parseLocale($(this).closest("tr").find("input[type=text]").val(), 'dd-MM-yyyy hh:mm:sstt');
                    var ddloption = $(this).closest("tr").find("select option:selected");
                    if (txtdate == "") {
                        errorMessage += "Provide Collected Date & Time" + "\n";
                        return false;
                    }

                    if ($(ddloption).val() != "0") {
                        var ddlValue = $(ddloption).val();
                    }
                    else {
                        errorMessage += "Select Shipping Condition for all Checked Additive-Container" + "\n";
                        return false;
                    }



                    var ddlText = $(ddloption).text();
                    //lstSelectedInvID = lstSelectedInvID + "|" + $(this).val() + "~";

                    selectedSampleList.push({
                        CheckBoxValue: chkvalue,
                        CheckBoxText: chkText,
                        CollectedDate: txtdate,
                        ShippingConditionID: ddlValue,
                        ShippingConditionText: ddlText
                    });
                });
            }
        }
        else {
            if ($('table[id$="tblUnSheduleOrderedInvs"] input[type=checkbox]:checked').length <= 0) {
                errorMessage += "Select an Additive-Container" + "\n";
            }
            else {
                var $row;
                var investigationID = "";
                var isExistingInvName = false;
                var selectedSampleList = [];

                $('table[id$="tblUnSheduleOrderedInvs"] input[type=checkbox]:checked').each(function() {

                    var chkvalue = $(this).val();
                    var chkText = $(this).closest("tr").find('span[id$="sp"]').html();
                    var txtdate = $(this).closest("tr").find("input[type=text]").val(); // Date.parseLocale($(this).closest("tr").find("input[type=text]").val(), 'dd-MM-yyyy hh:mm:sstt');
                    var ddloption = $(this).closest("tr").find("select option:selected");
                    if (txtdate == "") {
                        errorMessage += "Provide Collected Date & Time" + "\n";
                        return false;
                    }

                    if ($(ddloption).val() != "0") {
                        var ddlValue = $(ddloption).val();
                    }
                    else {
                        errorMessage += "Select Shipping Condition for all Checked Additive-Container" + "\n";
                        return false;
                    }



                    var ddlText = $(ddloption).text();
                    //lstSelectedInvID = lstSelectedInvID + "|" + $(this).val() + "~";

                    selectedSampleList.push({
                        CheckBoxValue: chkvalue,
                        CheckBoxText: chkText,
                        CollectedDate: txtdate,
                        ShippingConditionID: ddlValue,
                        ShippingConditionText: ddlText
                    });
                });
            }
        }
        if (document.getElementById('chkIsUnScheduleVisit').checked) {

            if ($('#tblBillingItems tr').length > 1) {
                $('#tblBillingItems tr:not(:first)').each(function(i, n) {
                    $row = $(n);
                    var FeeID = $row.find('input[id$="tblBillingItems_hdnFeeID"]').val();
                    var FeeType = $row.find('input[id$="tblBillingItems_hdnFeeType"]').val();
                    var Amount = $row.find('input[id$="tblBillingItems_hdnAmt"]').val();
                    var Description = $row.find('input[id^="tblBillingItems_hdnName"]').val();

                    lstPatientDueChartList.push({
                        FeeType: FeeType,
                        FeeID: FeeID,
                        Description: Description,
                        Status: 'Paid',
                        Unit: 1,
                        Amount: Amount

                    });
                });
            }
        }
        else {
            var lst = VisitID.split('~');
            var FeeID = lst[0];
            var EpisodeVisitId = lst[1];
            var Description = lst[2];
            var Amount = lst[3];
            //  var PatientID = lst[4];
            var FeeType = 'PKG';

            lstPatientDueChartList.push({
                FeeType: FeeType,
                FeeID: FeeID,
                Description: Description,
                Status: 'Paid',
                Unit: 1,
                Amount: Amount

            });

        }
        if (lstPatientDueChartList.length > 0) {
            $('#hdnLslstPatientDueChartList').val(JSON.stringify(lstPatientDueChartList));
        }
        if (document.getElementById('hdnPatientInvSampleMapping').value != "") {
            lstPatientInvSampleMapping = JSON.parse(document.getElementById('hdnPatientInvSampleMapping').value);
        }
        document.getElementById('hdnPatientInvSampleMapping').value

        if (errorMessage.length <= 0) {
            ////debugger;
            GenerateCollectionOfSubject(VisitName, VisitID, SubjectNo, SubjectName, DOB, Age, AgeTypeID, AgeType, GenderID, Gender, PStatusID, PStatus, VTypeID, VType, selectedSampleList, lstPatientDueChartList, lstPatientInvSampleMapping)
            alert('Subject Added in Registration Queue');
            document.getElementById('txtClient').readonly = true;
            document.getElementById('txtEpisodeName').readonly = true;
        }
        else {
            alert(errorMessage);
            return false;
        }
    }
    catch (e) {
        alert("There was a problem while adding Subjects");
        return false;
    }
    return false;
}


function GenerateCollectionOfSubject(VisitName, VisitID, SubjectNo, SubjectName, DOB, Age, AgeTypeID, AgeType, GenderID, Gender, PStatusID, PStatus, VTypeID, VType, selectedSampleList, lstPatientDueChartList, lstPatientInvSampleMapping) {
    try {

        var row = '<tr class="parentrow" style="height: 17px;">';
        var rowCount = $("#tblCollectionOfSubjects tr").length;
        var PatientID = document.getElementById('hdnPatientID').value == "" ? -1 : document.getElementById('hdnPatientID').value;
        VisitID = VisitID + '~' + PatientID;
        var AgeValue = Age + '~' + AgeTypeID;
        DOB = DOB == 'dd/MM/yyyy' ? "" : DOB;
        row += "<td align='left' >" + VisitName + "<input id='hdnVisitID' type='hidden' value='" + VisitID + "' /><input id='hdnPatientDueChartList'  value='" + JSON.stringify(lstPatientDueChartList) + "' type='hidden' /></td>";
        row += "<td align='left' >" + SubjectNo + "<input id='hdnSubjectNo' type='hidden' value='" + SubjectNo + "' /><input id='hdnPatientInvSampleMappingList'  value='" + JSON.stringify(lstPatientInvSampleMapping) + "' type='hidden' /></td>";
//        row += '<td align="left">' + SubjectNo + '<input id="hdnSubjectNo" type="hidden" value="' + SubjectNo + "' /><input id='hdnPatientInvSampleMappingList'  value='" + JSON.stringify(lstPatientInvSampleMapping) + "' type='hidden' /></td>";
        row += '<td align="left">' + SubjectName + '<input id="hdnSubjectName" type="hidden" value="' + SubjectName + '" /></td>';
        row += '<td align="left">' + DOB + '<input id="hdnDOB" type="hidden" value="' + DOB + '" /></td>';
        row += '<td align="left">' + Age + '- ' + AgeType + '<input id="hdnAgeValue" type="hidden" value="' + AgeValue + '" /></td>';
        row += '<td align="left">' + Gender + '<input id="hdnGenderID" type="hidden" value="' + GenderID + '" /></td>';
        row += '<td align="left">' + PStatus + '<input id="hdnPStatusID" type="hidden" value="' + PStatusID + '" /></td>';
        row += '<td align="left">' + VType + '<input id="hdnVTypeID" type="hidden" value="' + VTypeID + '" /></td>';
        var SampleAttributes = '';
        var j = selectedSampleList.length;
        var Childrow = '<table id="tblChildCollectSample" border="1" cellpadding="1" cellspacing="0">';
        for (var i = 0; i < j; i++) {

            Childrow += '<tr class="childrow"><td align="left" style="width: 30%;">' + selectedSampleList[i].CheckBoxText + '<input id="hdnCheckBoxValue" type="hidden" value="' + selectedSampleList[i].CheckBoxValue + '" /></td>';
            Childrow += '<td align="left" style="width: 30%;">' + selectedSampleList[i].CollectedDate + '<input id="hdnCollectedDate" type="hidden" value="' + selectedSampleList[i].CollectedDate + '" /></td>';
            Childrow += '<td align="left" style="width: 30%;">' + selectedSampleList[i].ShippingConditionText + '<input id="hdnShippingConditionID" type="hidden" value="' + selectedSampleList[i].ShippingConditionID + '" /></td></tr>';
            //  SampleAttributes += selectedSampleList[i].CheckBoxText + ' : ' + selectedSampleList[i].CollectedDate + ' : ' + selectedSampleList[i].ShippingConditionText + '<br>';

        }
        Childrow += "</table>";
        row += '<td align="center">' + Childrow + '</td>';
        var btnDeleteSample = '<input id="tblCollectionOfSubjects' + rowCount + 'btnDeleteSample" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onSampleDelete(this);" title="Click here to remove details"/>';

        row += '<td align="center">' + btnDeleteSample + '</td>';

        row += "</tr>";
        //$('[id$="pnlChildSamples"]').show();
        $("#tblCollectionOfSubjects ").append(row);
        document.getElementById('trCollectionOfSubjects').style.display = 'block';
        document.getElementById('tdbtnSave').style.display = 'block';

        ClearSubjectDetails();
        document.getElementById('hdnPatientInvSampleMapping').value = "";
    }
    catch (e) {
        throw e;
    }
}

function onSampleDelete(obj) {
    try {
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        // $('table[id$="tblCollectionOfSubjects"] tr:eq(' + rowIndex + ')').remove();
        $(row).remove();
        var rowCount = $("#tblCollectionOfSubjects tr").length;
        if (rowCount == 1) {
            document.getElementById('trCollectionOfSubjects').style.display = 'none';
        }
        else {
            document.getElementById('trCollectionOfSubjects').style.display = 'block';
        }

    }
    catch (e) {
        return false;
    }
    return false;
}

function SaveSubjectsList() {
    try {
        if ($('#tblCollectionOfSubjects tr').length > 1) {
            var consignmentNo = document.getElementById('txtConsignment').value;
            if (consignmentNo != "") {
                if (confirm('Do you want to Register this Patient-Samples under the Consignment Number:' + consignmentNo + '?')) {
                    TableToJson();
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                if (confirm('Do you want to Register this Patient-Samples?')) {
                    TableToJson();
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        else {
            alert('Kindly Add Subjects in Registration Queue');
            return false;
        }
    }
    catch (e) {
        alert("There was a problem while Saving Patient along with samples");
        return false;
    }
}

function TableToJson() {
    try {
        var lstPatientInvSample = [];
        var lstSampleTracker = [];
        var lstPatientInvSampleMapping = [];
        var lstInvestigationValues = [];

        var lstobjPatient = [];
        var lstPatientDueChart = [];
        var lstInv = [];
        var lstFinalBill = [];

        var STRlstPatientDueChartList = [];
        var STRlstPatientInvSampleMapping = [];

        var sampleID = 0, sampleContainerID = 0, invSampleStatusDesc = "", barcodeNumber = "0", locationName = "", recSampleLocID = 0, collectedDateTime = "";
        var invSampleStatusID = 0;
        var investigationID = "", strInvID = "";
        var selectedStatusOption, selectedRecLocOption, selectedOutsourceLocOption, selectedResonOption;
        var referralID = -1;
        var $row;
        var $Childrow
        var lstCollectedSampleStatus = [];
        var tblAttributes = $('table[id$="tblCollectionOfSubjects"]');
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
        var PStatusID = '';
        var VTypeID = '';

        if ($('#tblCollectionOfSubjects tr').length > 1) {

            $('#tblCollectionOfSubjects tr.parentrow').each(function(i, n) {
                $row = $(n);
                count = count + 1;
                var len = $row.length;

                VisitID = $row.find('input[id$="hdnVisitID"]').val();
                SubjectNo = $row.find('input[id$="hdnSubjectNo"]').val();
                SubjectName = $row.find('input[id$="hdnSubjectName"]').val();
                SDOB = $row.find('input[id$="hdnDOB"]').val();
                AgeValue = $row.find('input[id$="hdnAgeValue"]').val();
                GenderID = $row.find('input[id$="hdnGenderID"]').val();
                PStatusID = $row.find('input[id$="hdnPStatusID"]').val();
                VTypeID = $row.find('input[id$="hdnVTypeID"]').val();
                SDOB = SDOB == "" ? '01/01/1800' : SDOB;

                STRlstPatientDueChartList = JSON.parse($row.find('input[id$="hdnPatientDueChartList"]').val()); // JSON.parse($('input[id$="hdnPatientDueChartList"]').val());
                STRlstPatientInvSampleMapping = JSON.parse($row.find('input[id$="hdnPatientInvSampleMappingList"]').val());


                var newDOB = Date.parseLocale(SDOB, 'dd/MM/yyyy');
                // var newDOB = Date.parseLocale(String(DOB), 'dd-MM-yyyy');
                var EpisodeID = document.getElementById('hdnEpisodeID').value;
                //                var d = SDOB;
                //                var d1 = Date.parse(d);
                //                var dt = new Date(d1);

                var lst = VisitID.split('~');
                var FeeID = lst[0];
                var EpisodeVisitId = lst[1];
                var PacckageName = lst[2];
                var Amount = lst[3];
                var PatientID = lst[4];
                var FeeType = 'PKG';

                lstobjPatient.push({
                    Name: SubjectName,
                    SEX: GenderID,
                    DOB: newDOB,
                    Age: AgeValue,
                    PatientID: PatientID,
                    PatientNumber: 0,
                    EpisodeVisitId: EpisodeVisitId,
                    PatientIdentifyID: count,
                    //RelationTypeId: FeeID,
                    ReferedHospitalID: EpisodeID,
                    URNO: SubjectNo,
                    PStatusID: PStatusID,
                    VistTypeID: VTypeID
                });

                var tblAttributesvalue = $row.find('table[id$="tblChildCollectSample"] tr.childrow');
                $(tblAttributesvalue).each(function(j, m) {
                    $Childrow = $(m);

                    var CheckBoxValue = $Childrow.find('input[id$="hdnCheckBoxValue"]').val();
                    var CollectedDate = $Childrow.find('input[id$="hdnCollectedDate"]').val();
                    var ShippingConditionID = $Childrow.find('input[id$="hdnShippingConditionID"]').val();
                    var sVal = CheckBoxValue.split('~');
                    var RecSampleLocID = sVal[2];
                    var LocationName = sVal[3];
                    CollectedDate = Date.parseLocale(CollectedDate, 'dd-MM-yyyy hh:mm:sstt');
                    //                    var t = CollectedDate;
                    //                    var t1 = Date.parse(t);
                    //                    var tt = new Date(t1);
                    lstPatientInvSample.push({
                        SampleID: sVal[0],
                        SampleContainerID: sVal[1],
                        SampleConditionID: ShippingConditionID,
                        CollectedDateTime: CollectedDate,
                        LocationName: LocationName,
                        RecSampleLocID: RecSampleLocID,
                        //FeeID: FeeID, //new 
                        InvSampleStatusDesc: "Collected",
                        BarcodeNumber: "0",
                        VmUnitID: 0,
                        VmValue: 0,
                        PatientIdentifyID: count
                    });

                });


                $.each(STRlstPatientDueChartList, function(i, obj) {
                    obj.Value
                    lstPatientDueChart.push({
                        FeeType: obj.FeeType,
                        FeeID: obj.FeeID,
                        Description: obj.Description,
                        Status: 'Paid',
                        Unit: 1,
                        Amount: obj.Amount,
                        PatientIdentifyID: count

                    });

                    lstInv.push({
                        Name: obj.Description,
                        ID: obj.FeeID,
                        Status: 'Ordered',
                        Type: obj.FeeType,
                        // OrgID: OrgID,
                        // StudyInstanceUId: StudyInstanceUId,
                        // UID: UID
                        PatientIdentifyID: count
                    });

                    lstFinalBill.push({
                        GrossBillValue: obj.Amount,
                        NetValue: obj.Amount,
                        Due: obj.Amount,
                        IsCreditBill: 'Y',
                        PatientIdentifyID: count
                    });

                    lstInvestigationValues.push({
                        InvestigationID: obj.FeeID,
                        Status: obj.FeeType,
                        Value: "Collected",
                        ReferralID: "-1",
                        PatientIdentifyID: count
                    });
                });

                $.each(STRlstPatientInvSampleMapping, function(i, obj) {
                    lstPatientInvSampleMapping.push({
                        ID: obj.InvestigationID,
                        SampleID: obj.SampleCode,
                        Type: obj.Action,
                        Barcode: "0",
                        PatientIdentifyID: count
                    });
                });

            });

            if (lstobjPatient.length > 0) {
                $('#hdnLstobjPatient').val(JSON.stringify(lstobjPatient));
            }
            if (lstPatientDueChart.length > 0) {
                $('#hdnLslstPatientDueChart').val(JSON.stringify(lstPatientDueChart));
            }
            if (lstInv.length > 0) {
                $('#hdnLslstInv').val(JSON.stringify(lstInv));
            }
            if (lstFinalBill.length > 0) {
                $('#hdnLslstFinalBill').val(JSON.stringify(lstFinalBill));
            }
            if (lstPatientInvSample.length > 0) {
                $('#hdnLslstPatientInvSample').val(JSON.stringify(lstPatientInvSample));
            }
            if (lstInvestigationValues.length > 0) {
                $('#hdnLslstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
            }
            if (lstPatientInvSampleMapping.length > 0) {
                $('#hdnLslstPatientInvSampleMapping').val(JSON.stringify(lstPatientInvSampleMapping));
            }
        }

    }
    catch (e) {
        throw e;
    }

}

function ClearSubjectDetails() {
    document.getElementById('txtSujectNo').value = '';
    document.getElementById('txtSubjectName').value = '';
    document.getElementById('tDOB').value = '';
    document.getElementById('txtDOBNos').value = '';
    document.getElementById('ddlSex').selectedvalue = 1;
    document.getElementById('ddlDOBDWMY').value = "Year(s)";
    document.getElementById('ddlVisitName').value = "0";
    document.getElementById('hdnPatientID').value = "";


    while (count = document.getElementById('tblSampleAttributes').rows.length) {
        for (var j = 0; j < document.getElementById('tblSampleAttributes').rows.length; j++) {
            document.getElementById('tblSampleAttributes').deleteRow(j);
        }
    }
    while (count = document.getElementById('tblUnSheduleOrderedInvs').rows.length) {
        for (var j = 0; j < document.getElementById('tblUnSheduleOrderedInvs').rows.length; j++) {
            document.getElementById('tblUnSheduleOrderedInvs').deleteRow(j);
        }
    }
    while (count = document.getElementById('tblBillingItems').rows.length) {
        for (var j = 0; j < document.getElementById('tblBillingItems').rows.length; j++) {
            document.getElementById('tblBillingItems').deleteRow(j);
        }
    }
    ClearBillingItems();
    document.getElementById('chkIsUnScheduleVisit').checked = false;
    ClickUnScheduleVisit();
}


function CallBillItems(OrgID) {
    if (!validateEvents('Before')) {
        SetRateCard();
        var radio = "ALL";
        var pvalue = 'OP'; document.getElementById('hdnOPIP').value;
        var sRateID = document.getElementById('hdnRateID').value;
        var LocationID = 67;  //document.getElementById('hndLocationID').value;
        var pVisitID = -1;
        var IsMapped = "N";
        if (Number(document.getElementById('hdnRateID').value) > 0) {
            IsMapped = "Y"
        }
        var BasePage = "LAB";
        var sval = "COM";
        sval = sval + '~' + OrgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + "~" + BasePage;
        $find('AutoCompleteExtender3').set_contextKey(sval);
    }

}
function SetRateCard() {

    document.getElementById("hdnRateID").value = Number(document.getElementById("hdnBaseRateID").value);
    document.getElementById("hdnRateClientID").value = Number(document.getElementById("hdnBaseClientID").value);
    document.getElementById("hdnMappingClientID").value = -1;
}





function CheckEpisode() {

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
    if (document.getElementById('ddlShipping').value == "0") {
        document.getElementById('ddlShipping').value = "0";
        document.getElementById('ddlShipping').focus();
        alert("Select Shipping Type");
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


function ConsignmentSelected(source, eventArgs) {
    ////debugger;
    document.getElementById('hdnConsignmentNo').value = eventArgs.get_text();

    var ConsignmentNo = document.getElementById('hdnConsignmentNo').value;
    var OrgID = document.getElementById('hdnOrgID').value;
    var sid = document.getElementById('hdnEpisodeID').value;
    var eps = ''; //document.getElementById('hdnClientByEpisodeID').value;
    var ClinetID = document.getElementById('hdnClientID').value;
    var pType = "CONSIGNMENT"
    //   var sval = eps + '~' + sid + '~' + OrgID + '~' + ClinetID;
    WebService.GetConsignmentNoDetails(eps, sid, OrgID, pType, ConsignmentNo, GetConsignmentNoDetail);

}
function GetConsignmentNoDetail(result) {
    ////debugger;
    var lstConsignmentwithSampleCondition = [];
    while (count = document.getElementById('tblConsignmentNoDetail').rows.length) {
        for (var j = 0; j < document.getElementById('tblConsignmentNoDetail').rows.length; j++) {
            document.getElementById('tblConsignmentNoDetail').deleteRow(j);
        }
        document.getElementById('tblConsignmentNoDetail').style.display = 'none';
        document.getElementById('trConsignmentNoDetail').style.display = 'none';
    }
    //  $('[id$="ddlVisitName"]').remove(); 


    if (result.length > 0) {
        var Headrow = document.getElementById('tblConsignmentNoDetail').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);


        cell1.innerHTML = "Reg.TrackID.";
        cell2.innerHTML = "Consignment No";
        cell3.innerHTML = "Samples Shipping Condition";
        cell4.innerHTML = "Samples Count";


        var Rowid = result.length;
        for (var n = 0; n < result.length; n++) {
            var TableInvValue = '';
            var row = document.getElementById('tblConsignmentNoDetail').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);

            cell1.innerHTML = result[n].RegTrackID;
            cell2.innerHTML = result[n].ConsignmentNo;
            cell3.innerHTML = result[n].StatusDesc;
            cell4.innerHTML = result[n].SamplesCount;

            document.getElementById('tblConsignmentNoDetail').style.display = 'block';
            document.getElementById('trConsignmentNoDetail').style.display = 'block';
            Rowid--;

            lstConsignmentwithSampleCondition.push({
                SampleConditionID: result[n].ShippingConditionID,
                ConsignmentNo: result[n].ConsignmentNo
            });
        }
        if (lstConsignmentwithSampleCondition.length > 0) {
            $('#hdnConsignmentwithSampleCondition').val(JSON.stringify(lstConsignmentwithSampleCondition));
        }
        else {
            document.getElementById('hdnConsignmentwithSampleCondition').value = '';
        }
    }
}
function clearConsignmentValues(ClearType) {
    var result = '';
    GetConsignmentNoDetail(result);
    document.getElementById('hdnConsignmentNo').value = '';
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

/*******UnScheduleVisit Part******/

function ClickUnScheduleVisit() {
    if (document.getElementById('chkIsUnScheduleVisit').checked) {
        document.getElementById('ddlVisitName').value = "0";
        LoadSampleAttributes();
        document.getElementById('ddlVisitName').disabled = true;
        document.getElementById('tdUnScheduleVisit').style.display = "block";
        document.getElementById('tdBillingItems').style.display = "block";

    }
    else {
        document.getElementById('ddlVisitName').disabled = false;
        document.getElementById('tdUnScheduleVisit').style.display = "none";
        document.getElementById('tdBillingItems').style.display = "none";
        document.getElementById('tdUnSheduleOrderedInvs').style.display = "none";
        
    }

}
function SelectedTest(source, eventArgs) {
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                //document.getElementById('lblInvType').innerHTML = list[2];
            }
        }
    }
}


function BillingItemSelected(source, eventArgs) {

    var varGetVal = eventArgs.get_value();
    var arrGetVal = new Array();
    arrGetVal = varGetVal.split("^");
    $('[id$="txtTestName"]').val(arrGetVal[1]);

    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var ID;
    var name;
    var feeType;
    var amount;
    var IsDicountableTest;
    var IsRepeatable;
    var Code;
    var IsOutSource;
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        if (list[i] != "") {
            ID = list[0];
            name = list[1].trim();
            feeType = list[2];
            Code = list[3];
            IsOutSource = list[4];

            document.getElementById('hdnID').value = ID;
            document.getElementById('hdnName').value = name;
            document.getElementById('hdnFeeTypeSelected').value = feeType;
            document.getElementById('hdnInvCode').value = Code;
            document.getElementById('hdnIsOutSource').value = IsOutSource;
            //            $('[id$="hdnID"]').val(ID);

        }

    }
    else {
        $('[id$="hdnID"]').val(-1);
        $('[id$="hdnFeeTypeSelected"]').val("OTH");
    }
}

function AddItems() {
    var FeeID = document.getElementById('hdnID').value;
    var RetValue = 0;
    var errorMessage;
    if (document.getElementById('hdnID').value != "-1" && document.getElementById('txtTestName').value != "") {
        if ($('#tblBillingItems tr').length > 1) {
            $('#tblBillingItems tr:not(:first)').each(function(i, n) {
                $row = $(n);
                var PriviousFeeID = $row.find('input[id$="tblBillingItems_hdnFeeID"]').val();
                if (PriviousFeeID == FeeID) {
                    errorMessage = "This Item is Already Added" + "\n";
                    alert(errorMessage);
                    RetValue = 1;
                    ClearBillingItems();
                    return false;
                }
            });
            if (RetValue == 0) {
                AddBillingItemsDetails();
                //                GenerateBillingItemsTable();
            }

        }
        else {
            AddBillingItemsDetails();
            //            GenerateBillingItemsTable();
        }

    }
    else {
        alert('Enter Ordered Items');
        document.getElementById('txtTestName').focus();
        return false;
    }
}

function AddBillingItemsDetails() {
    var arrGotValue = new Array();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetBillingItemsDetails",
        data: JSON.stringify({ OrgID: $('[id$="hdnOrgID"]').val(), FeeID: $('[id$="hdnID"]').val(), FeeType: $('[id$="hdnFeeTypeSelected"]').val(), Description: $('[id$="txtTestName"]').val(), ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '' }),
        dataType: "json",
        success: function(data) {
            for (var i = 0; i < data.d.length; i++) {
                arrGotValue = data.d[0].ProcedureName.split('^');
                if (arrGotValue.length > 0) {
                    ID = arrGotValue[0];
                    name = arrGotValue[1].trim();
                    feeType = arrGotValue[2];
                    amount = arrGotValue[3];
                    IsOutSource = $('[id$="hdnIsOutSource"]').val();
                    $('[id$="hdnID"]').val(ID);
                    $('[id$="hdnName"]').val(name);
                    $('[id$="hdnFeeTypeSelected"]').val(feeType);
                    $('[id$="hdnAmt"]').val(amount);

                }
            }
            GenerateBillingItemsTable();
        },
        error: function(result) {
            alert("Error");
        }
    });
}

function GenerateBillingItemsTable() {
    try {

        var row = '<tr class="parentrow" style="height: 17px;">';
        var rowCount = $("#tblBillingItems tr").length;
        var ID = $('[id$="hdnID"]').val();
        var name = $('[id$="hdnName"]').val();
        var feeType = $('[id$="hdnFeeTypeSelected"]').val();
        var amount = $('[id$="hdnAmt"]').val();

        row += '<td align="left" >' + name + '<input id="tblBillingItems_hdnName_' + name + '" type="hidden" value="' + name + '" /><input id="tblBillingItems_hdnFeeID" type="hidden" value="' + ID + '" /><input id="tblBillingItems_hdnFeeType" type="hidden" value="' + feeType + '" /><input id="tblBillingItems_hdnAmt" type="hidden" value="' + amount + '" /></td>';


        var btnDeleteSample = '<input id="tblBillingItems' + rowCount + 'btnDeleteSample" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onBillingItemsDelete(this);" title="Click here to remove details"/>';

        row += '<td align="center">' + btnDeleteSample + '</td>';

        row += "</tr>";
        //$('[id$="pnlChildSamples"]').show();
        $("#tblBillingItems").append(row);
        document.getElementById('tdBillingItems').style.display = 'block';
        //document.getElementById('tdbtnSave').style.display = 'block';

        ClearBillingItems();
    }
    catch (e) {
        throw e;
    }
}
function ClearBillingItems() {
    document.getElementById('hdnID').value = "-1";
    document.getElementById('txtTestName').value = "";
    document.getElementById('hdnName').value = "";
    document.getElementById('hdnFeeTypeSelected').value = "";
    document.getElementById('hdnAmt').value = "";
    if (document.getElementById('tdUnScheduleVisit').style.display == 'block') {
        document.getElementById('txtTestName').focus();
    }
}


function onBillingItemsDelete(obj) {
    try {
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        // $('table[id$="tblCollectionOfSubjects"] tr:eq(' + rowIndex + ')').remove();
        $(row).remove();
        var rowCount = $("#tblBillingItems tr").length;
        if (rowCount == 1) {
            document.getElementById('tdBillingItems').style.display = 'none';
        }
        else {
            document.getElementById('tdBillingItems').style.display = 'block';
        }
        document.getElementById('hdnOrderedInvs').value = "";
        UnsheduleInvsGetDeptToTrackSamplesWithID('','');
        document.getElementById('tdUnSheduleOrderedInvs').style.display = 'none';

    }
    catch (e) {
        return false;
    }
    return false;
}
function GetSamplesForInves() {
    var OrgID = document.getElementById('hdnOrgID').value;
    var lstOrderedInves = [];
    var STRlstOrderedInves;
    var InvID = '0';
    var Type = 'COM';

    if ($('#tblBillingItems tr').length > 1) {
        $('#tblBillingItems tr:not(:first)').each(function(i, n) {
            $row = $(n);
            var FeeID = $row.find('input[id$="tblBillingItems_hdnFeeID"]').val();
            var FeeType = $row.find('input[id$="tblBillingItems_hdnFeeType"]').val();
            lstOrderedInves.push({
                ID: FeeID,
                Type: FeeType,
                OrgID: OrgID
            });

        });
        if (lstOrderedInves.length > 0) {
            $('#hdnOrderedInvs').val(JSON.stringify(lstOrderedInves));
            //WebService.GetDeptToTrackSamplesWithID(document.getElementById('hdnOrderedInvs').value, OrgID, InvID, Type, UnsheduleInvsGetDeptToTrackSamplesWithID);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/GetDeptToTrackSamples",
                data: JSON.stringify({ Invs: document.getElementById('hdnOrderedInvs').value, pOrgID: OrgID, pInvID: InvID[0], pType: Type }),
                dataType: "json",
                success: function(data, value) {
                    var GetData1 = JSON.parse(data.d[0]);
                    var GetData2 = JSON.parse(data.d[1]);
                    UnsheduleInvsGetDeptToTrackSamplesWithID(GetData1, GetData2)
                    //                var PatientName = GetData.First.split(':')[0];
                    //                var isPatientDetails = GetData.Second;
                    //                var PatientNumber = GetData.First.split(':')[1];

                },
                error: function(result) {
                    alert("Error");
                }
            });

            document.getElementById('hdnOrderedInvs').value =
             "";
        }

    }


}

function UnsheduleInvsGetDeptToTrackSamplesWithID(result,result2) {
    while (count = document.getElementById('tblUnSheduleOrderedInvs').rows.length) {
        for (var j = 0; j < document.getElementById('tblUnSheduleOrderedInvs').rows.length; j++) {
            document.getElementById('tblUnSheduleOrderedInvs').deleteRow(j);
        }
    }
    var lstInvSampleMapping = [];
    if (result.length > 0) {
        var Headrow = document.getElementById('tblUnSheduleOrderedInvs').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);


        cell1.innerHTML = "Additive-Container";
        cell2.innerHTML = "Collected Time";
        cell3.innerHTML = "Shipping Condition";

        for (var n = 0; n < result.length; n++) {
            var TableInvValue = '';
            var row = document.getElementById('tblUnSheduleOrderedInvs').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);

            var rowCount = n + 1;
            var textname = "txtCollectedTime" + rowCount;  //"chkSampleContainer" + rowCount;
            var ddmmyyyy = "ddmmyyyy";
            var arrow = "arrow";
            var tru = true;
            var twele = "12";
            var Yes = "Y";
            var SampleCodeSampleContainerID = result[n].SampleCode + '~' + result[n].SampleContainerID + '~' + result[n].RecSampleLocID + '~' + result[n].LocationName;
            var CollectedDate = document.getElementById('hdnCollectedDate').value;
            var chkSampleContainer = '<input id="chkSampleContainer' + SampleCodeSampleContainerID + '" type="checkbox"  title="' + result[n].SampleContainerName + '" size="10" style="width:40px;display:none" value="' + SampleCodeSampleContainerID + '" checked="true" class="Txtboxsmall"><span id="sp">' + result[n].SampleContainerName + '</span></input>';
            var txtCollectedTime = '<input   id="' + textname + '" type="text" maxlength="25" title="dd-MM-yyyy hh:mm:ssAM/PM" size="10" style="width:120px;"  class="Txtboxsmall" ToolTip="dd-MM-yyyy hh:mm:ssAM/PM"  onfocus="javascript:NewCssCal(' + "'" + textname + "'" + ',' + "'" + ddmmyyyy + "'" + ',' + "'" + arrow + "'" + ',' + tru + ',' + "'" + twele + "'" + ',' + "'" + Yes + "'" + ',' + "'" + Yes + "'" + ');" />';
            //            value = "' + CollectedDate + '" 
            var shippingConditionOption = "";
            var lstShippingCondition = JSON.parse($('input[id$="hdnShippingCondition"]').val());
            $.each(lstShippingCondition, function(i, obj) {
                if (obj.Value == '0') {
                    shippingConditionOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else {
                    shippingConditionOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
                }
            });
            var ddlShippingCondition = '<span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlShippingCondition" class="ddl" style="width: 120px;" title="Select Location">' + shippingConditionOption + '</select></span>';

            cell1.innerHTML = chkSampleContainer;
            cell2.innerHTML = txtCollectedTime;
            cell3.innerHTML = ddlShippingCondition;
            document.getElementById('tblUnSheduleOrderedInvs').style.display = 'block';
            document.getElementById('tdUnSheduleOrderedInvs').style.display = 'block';

            var txtUserTitle = 'dd-MM-yyyy hh:mm:ssAM/PM';

            var Texttimevalue = $('input[id^="txtCollectedTime"]').val();
            $('input[id^="txtCollectedTime"]').watermark(txtUserTitle);

//            var lstName = result[n].InvestigtionName.split('');
//            lstInvSampleMapping.push({
//                ID: lstName[0],
//                Type: lstName[2],
//                SampleID: lstName[3]
//            });

        }
//        if (lstInvSampleMapping.length > 0) {
//            $('#hdnInvSampleMapping').val(JSON.stringify(lstInvSampleMapping));
        //        }

        if (result2.length > 0) {
            $('#hdnPatientInvSampleMapping').val(JSON.stringify(result2));
        }

    }
    else {
        if (document.getElementById('hdnOrderedInvs').value != "") {
            alert('Samples does not Map for this Oredered Items!');
            return false;
        }
    }
}


function TestDrive() {

    var arrGotValue = new Array();
    var OrgID = document.getElementById('hdnOrgID').value;
    var PatientID = 123; // document.getElementById('hdnPatientID').value;
    sval = OrgID + '~' + PatientID;

    var OrgID = document.getElementById('hdnOrgID').value;
    var lstOrderedInves = [];
    var STRlstOrderedInves;
    var InvID = '0';
    var Type = 'COM';

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/GetDeptToTrackSamples",
        data: JSON.stringify({ Invs: '', pOrgID: OrgID, pInvID: PatientID, pType: sval }),
        dataType: "json",
        success: function(data, value) {
            var GetData = JSON.parse(data.d[0]);
            var GetData2 = JSON.parse(data.d[1]);
            var PatientName = GetData.First.split(':')[0];
            var isPatientDetails = GetData.Second;
            var PatientNumber = GetData.First.split(':')[1];

        },
        error: function(result) {
            alert("Error");
        }
    });
}






















function InvPopulated(sender, e) {

    var behavior = $find('GeneralBillItemsAutoCompleteExtender');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArray;
        ItemArray = text.split('^');
        if (ItemArray[4].trim().toLowerCase() == 'y') {
            // target.childNodes[i].className = "focus"
        }
    }
}
function boxExpand(me) {
    // alert(me);
    boxValue = me.value.length;
    // alert(boxValue);
    boxSize = me.size;
    minNum = 30;
    maxNum = 500;


    if (boxValue > minNum) {
        me.size = boxValue
    }
    else
        if (boxValue < minNum || boxValue != minNnum) {
        me.size = minNum
    }
}