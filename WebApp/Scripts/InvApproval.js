
function fnPhlebHome() {
    window.location.href("../Phlebotomist/Home.aspx?IsPopup=Y");
    return false;
}

function displayProgress() {
    document.getElementById("modal").style.display = "block";
    $find("mpeAttributeLocation").hide();
}

function HideAbnormalPopup() {
    document.getElementById('hdnSaveandNext').value = 'N';
    $find("mpeAttributeLocation").hide();
    return false;
}

function NeedRefmobileNo(Alertmsg, Requestpath, path) {
    alert(Alertmsg);
    window.location.href(Requestpath+path);
    return false;
}
function fnGetpatientInvestigationForVisit() {
    //debugger;
    try {
        var VisitID = document.getElementById('hdnVID').value;
        //var OrgID = '<%=Session["OrgID"]%>';
        var OrgID = document.getElementById('hdnOrgID').value;
        var LocationID = 0;
        var Guid = document.getElementById('hdnGuid').value;

        //if ($('#tblOrderedInvestigaion tr').length == 1) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetpatientInvestigationForVisit",
            contentType: "application/json; charset=utf-8",
            data: "{ 'visitID': '" + VisitID + "','orgID': '" + OrgID + "','LocationID': '" + LocationID + "','gUID': '" + Guid + "'}",
            dataType: "json",
            success: fnAjaxGetpatientInvestigationForVisit,
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Error");
                return false;
            }
        });
        //}
        showResponses('ACX2plus21', 'ACX2minus21', 'ACX2responses211', 1);
    }
    catch (e) {

    }
}
function fnAjaxGetpatientInvestigationForVisit(result) {
    try {
        //debugger;
        var oTable;

        if (result != "[]") {
            spanArray = [];
            spanArray.push(result);

            var lstPendingList = $.grep(result.d, function(v) {
                return (v.Status != "Completed" && v.Status != "Approve");
            });
            if (lstPendingList.length > 0) {
                var Orderedinvestigation = "";
                Orderedinvestigation = "<tr>"
                $.each(lstPendingList, function(i, item) {
                    // alert("Mine is " + i + "|" + item.InvestigationName + "|" + item.DisplayStatus);
                    if (i % 3 != 0) {
                        Orderedinvestigation = Orderedinvestigation + "<td>" + item.InvestigationName + " (" + item.DisplayStatus + ")</td> ";
                    }
                    else {
                        Orderedinvestigation = Orderedinvestigation + "</tr><tr><td>" + item.InvestigationName + " (" + item.DisplayStatus + ") ";
                    }
                });
                Orderedinvestigation = Orderedinvestigation + "</tr>";
                $('#tblOrderedInvestigaion tbody').append(Orderedinvestigation);
                //$('#tblUrinalysis tbody').append(strtable);

                //            oTable = $('#tblOrderedInvestigaion').dataTable({
                //                "bDestroy": true,
                //                "bAutoWidth": false,
                //                "bProcessing": true,
                //                "aaData": lstPendingList,
                //                "sDom": '<"H"Tfr>t<ip>',
                //                "bFilter": false,
                //                "bInfo": false,
                //                "aoColumns": [{
                //                    "mDataProp": "ReferredType",
                //                    "mRender": function(data, type, full) {
                //                        if (data === "Recheck") {
                //                            return full['InvestigationName'] + ', <span style="background-color:Yellow; color:Black;">RR</span>';
                //                        }
                //                        else if (data === "Retest") {
                //                            return full['InvestigationName'] + ', <span style="background-color:Yellow; color:Black;">RC</span>';
                //                        }
                //                        else {
                //                            return full['InvestigationName'];
                //                        }
                //                    }
                //                },
                //            { "mDataProp": "DisplayStatus"}],

                //                "bPaginate": false,
                //                "aaSorting": [[0, "asc"]],
                //                "bJQueryUI": true

                //            });
            }
            $('#tblOrderedInvestigaion').show();
        }
        else {
            var Orderedinvestigation = "";
            Orderedinvestigation = "<tr>"
            Orderedinvestigation = Orderedinvestigation + "</tr><tr><td>No Pending Items<td>";
            Orderedinvestigation = Orderedinvestigation + "</tr>";
            $('#tblOrderedInvestigaion tbody').append(Orderedinvestigation);
            $('#tblOrderedInvestigaion').show();
        }
    }
    catch (e) {

    }
}

var arrPatientValuesHistory = [];
var arrlstGrpMedRem = [];
var s;
function fnGetInvestigatonResultsCapture(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, taskID, IsTrustedDetails, status, LID) {
    //debugger;
    try {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetInvestigatonResultsCapture",
            contentType: "application/json; charset=utf-8",
            data: "{ 'VID': '" + vid + "','OrgID': '" + OrgID + "','RoleID': '" + RoleID + "','gUID': '" + gUID + "','DeptID': '" + DeptID + "','InvIDs': '" + InvIDs + "','LocationID': '" + ILocationID + "','taskID': '" + 0 + "','IsTrustedDetails': '" + IsTrustedDetails + "','status': '" + status + "','LID': '" + LID + "'}",
            dataType: "json",
            success: fnAjaxGetInvestigatonResultsCapture,
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Error");
                return false;
            }
        });
    }
    catch (e) {

    }
}

function fnAjaxGetInvestigatonResultsCapture(result) {
    try {
        //debugger;
        var oTable;
        var pdfshow = result.d[0].PdfStatus;
        if (pdfshow == "Y") {
            document.getElementById('Image1').style.display = 'block';
        }
        else {
            document.getElementById('Image1').style.display = 'none';
        }
        var OrgID = document.getElementById("hdnOrgID").value;
        var VID = document.getElementById("hdnVID").value;
        if (result != "[]") {
            spanArray = [];
            spanArray.push(result);

            //                    // Validation Rule 
            //                    var ValidationRuleList = $.grep(result.d, function(v) {
            //                        return v.ValidationRule != null && v.ValidationRule != "";
            //                    });

            //                    var hdnValidationRule = document.getElementById("hdnValidationRule");
            var lstIsDelta = $.grep(result.d, function(v) {
                return (v.MethodName == "Y");
            });
            if (lstIsDelta.length > 0)
                fnGetPatientInvestigationValuesHistory();
            //                    for (o = 0; o < ValidationRuleList.length; o++) {
            //                        if (hdnValidationRule.value.indexOf(ValidationRuleList[o].ValidationRule) == -1) {
            //                            //debugger;
            //                            if (hdnValidationRule.value == "") {
            //                                hdnValidationRule.value = ValidationRuleList[o].ValidationRule;
            //                            }
            //                            else {
            //                                hdnValidationRule.value = hdnValidationRule.value + "^" + ValidationRuleList[o].ValidationRule;
            //                            }
            //                        }
            //                    }

            //                    var ValidationTextList = $.grep(result.d, function(v) {
            //                        return v.ValidationText != null && v.ValidationText != "";
            //                    });



            //To Get Group Investigations
            var lstGrpInves = $.grep(result.d, function(v) {
                return (v.RootGroupID != 0 && v.InvestigationID != 0);
            });
            var hdnValidationText = document.getElementById("hdnValidationText");
            var hdnValidationRule = document.getElementById("hdnValidationRule");

            var hdnValidationTextOnLoad = document.getElementById("hdnValidationTextOnLoad");
            var hdnValidationRuleOnLoad = document.getElementById("hdnValidationRuleOnLoad");


            var dupes = {};
            $.each(lstGrpInves, function(i, el) {
                //debugger;
                if (!dupes[el.GroupID]) {
                    dupes[el.GroupID] = true;
                    arrlstGrpMedRem.push({
                        PatientVisitID: $('#hdnVID').val(),
                        GroupName: el.GroupName,
                        GroupComment: el.GroupComment,
                        GroupMedicalRemarks: el.GroupMedicalRemarks,
                        OrgID: $('#hdnOrgID').val(),
                        RootGroupID: el.RootGroupID,
                        GroupID: el.GroupID
                    });
                    if (el.ValidationText != null && el.ValidationText != '') {
                        hdnValidationText.value = hdnValidationText.value + el.ValidationText;
                    }
                    if (el.ValidationRule != null && el.ValidationRule != '') {
                        if (hdnValidationRule.value == "") {
                            hdnValidationRule.value = el.ValidationRule;
                        }
                        else {
                            hdnValidationRule.value = hdnValidationRule.value + "^" + el.ValidationRule;
                        }
                    }

                    //Calculation only for group - creatinine,abo,corrected calcium,lipid studies
                    //if (el.GroupID == '411' || el.GroupID == '410' || el.GroupID == '517' || el.GroupID == '390' || el.GroupID == '488' || el.GroupID == '518') {
                    if (el.IsFormulaCalculateOnDevice == false) {
                        if (el.ValidationText != null && el.ValidationText != '') {
                            hdnValidationTextOnLoad.value = hdnValidationTextOnLoad.value + el.ValidationText;
                        }
                        if (el.ValidationRule != null && el.ValidationRule != '') {
                            if (hdnValidationRuleOnLoad.value == "") {
                                hdnValidationRuleOnLoad.value = el.ValidationRule;
                            }
                            else {
                                hdnValidationRuleOnLoad.value = hdnValidationRuleOnLoad.value + "^" + el.ValidationRule;
                            }
                        }
                    }
                }
            });


            oTable = $('#tblInvestigatonResultsCapture').dataTable({
                "bDestroy": true,
                "bAutoWidth": false,
                "bProcessing": true,
                "aaData": result.d,
                "sDom": '<"H"Tfr>t<ip>',
                "bFilter": false,
                "bInfo": false,
                "bscrollY": "200px",
                "bscrollCollapse": true,
                "aoColumns": [
                    { "mDataProp": "InvestigationID" },
                    { "mDataProp": "InvestigationName",
                        "mRender": function(data, type, full) {
                            return String(data).replace(/&/g, '&amp;');
                        }
                    },
                    { "mDataProp": "Value",
                        "mRender": function(data, type, full) {

                            //debugger;
                            if (full["PatternID"] == 44) {
                                if (data != null) {
                                    try {
                                        isXML = $.parseXML(data).validateOnParse;
                                    } catch (err) {
                                        isXML = false;
                                    }
                                }
                                if (isXML) {
                                    var xml = $.parseXML(data);
                                    var html = '<table id="tblCulturePattern" style="background-color:Transparent;" width="97%"><tbody>';
                                    $(xml).find('InvestigationDetails').each(function() {
                                        var ReportStatus = $(this).find('ReportStatus').text();
                                        var ClinicalHistory = $(this).find('ClinicalHistory').text();
                                        var Gross = $(this).find('Gross').text();
                                        var CultureReport = $(this).find('CultureReport').text();
                                        var ResistanceDetected = $(this).find('ResistanceDetected').text();

                                        var SampleName = $(this).find('SampleName').text();
                                        html += '<tr><td width=50% style="font-weight:bold;">Report Status: </td><td width=40% colspan="2">' + ReportStatus + '</td></tr>';
                                        if (SampleName != undefined && SampleName != '') {
                                            html += '<tr><td width=50% style="font-weight:bold;">Specimen</td><td width=40% colspan="2">' + SampleName + '</td></tr>';
                                        }
                                        if (ClinicalHistory != undefined && ClinicalHistory != '') {
                                            html += '<tr><td width=50% style="font-weight:bold;">Clinical History: </td><td width=40% colspan="2">' + ClinicalHistory + '</td></tr>';
                                        }                                        
                                        if (Gross != undefined && Gross != '') {
                                            html += '<tr><td width=50% style="font-weight:bold;">Gross: </td><td width=40% colspan="2">' + Gross + '</td></tr>';
                                        }
                                        var StainDetails = $(this).find('StainDetails');
                                        if (StainDetails != undefined && StainDetails != '') {
                                            if ($(StainDetails).find('Stain').length > 0) {
                                                html += '<tr><td width=90% colspan="3" align="center" style="font-weight:bold;">Stain Details</td></tr>';
                                                //html += '<tr><td width=50% style="font-weight:bold;">Stain Type</td><td width=40% colspan="2" style="font-weight:bold;">Results</td></tr>';
                                            }
                                        }
                                        $(this).find('StainDetails').each(function() {
                                            $(this).find('Stain').each(function() {
                                                var stainType = '';
                                                if (typeof ($(this).attr('Type')) != 'undefined') {
                                                    stainType = $(this).attr('Type');
                                                }
                                                var stainResult = '';
                                                if (typeof ($(this).attr('Result')) != 'undefined') {
                                                    stainResult = $(this).attr('Result');
                                                }
                                                html += '<tr><td width=50%>' + stainType + '</td><td width=40% colspan="2">' + stainResult + '</td></tr>';
                                            });
                                        });
                                        //                                        var OrganDetails = $(this).find('OrganDetails');
                                        //                                        if (OrganDetails != undefined && OrganDetails != '') {
                                        //                                            html += '<tr><td width=90% colspan="2" align="center">Stain Details</td></tr>';
                                        //                                            html += '<tr><td width=50%>Stain Type</td><td width=40%>Results</td></tr>';
                                        //                                        }
                                        if (CultureReport != undefined && CultureReport != '') {
                                            html += '<tr><td width=50% style="font-weight:bold;">Culture: </td><td width=40% colspan="2">' + CultureReport + '</td></tr>';
                                        }
                                        if (ResistanceDetected != undefined && ResistanceDetected != '') {
                                            html += '<tr><td width=50% style="font-weight:bold;">ResistanceDetected</td><td width=40% colspan="2">' + ResistanceDetected + '</td></tr>';
                                        }
                                        //                                        if (ColonyCount != undefined && ColonyCount != '') {
                                        //                                            html += '<tr><td width=50% style="font-weight:bold;">ColonyCount</td><td width=40% colspan="2">' + ColonyCount + '</td></tr>';
                                        //                                        }
                                        var Name = '';
                                        var Family = '';
                                        $(this).find('OrganDetails').each(function() {
                                            var ColonyCount = $(this).find('ColonyCount').text();
                                            if (ColonyCount != undefined && ColonyCount != '') {
                                                //(this).find('ColonyCount').each(function() {
                                                html += '<tr><td width=50% style="font-weight:bold;">ColonyCount</td><td width=40% colspan="2">' + ColonyCount + '</td></tr>';
                                                //});
                                            }
                                            $(this).find('Organ').each(function() {
                                                var DrugName = '';
                                                var Zone = '';
                                                var Sensitivity = '';
                                                if (typeof ($(this).attr('Name')) != 'undefined' && $(this).attr('Name') != Name) {
                                                    Name = $(this).attr('Name');
                                                    html += '<tr><td width=90% colspan="3" align="left" style="font-weight:bold;"><u>Sensitivity For: ' + Name + '</u></td></tr>';
                                                    html += '<tr><td width=30%><b><u>Antimicrobial</u></b></td><td width=30%><b><u>Sensitivity</u></b></td><td width=30%></td></tr>';
                                                }
                                                //                                                if (typeof ($(this).attr('Family')) != 'undefined' && $(this).attr('Family') != Family) {
                                                //                                                    Family = $(this).attr('Family');                                                   
                                                //                                                }
                                                if (typeof ($(this).attr('DrugName')) != 'undefined') {
                                                    DrugName = $(this).attr('DrugName');
                                                }
                                                //if ($(this).attr('DrugName') == DrugName) {
                                                if (typeof ($(this).attr('Zone')) != 'undefined') {
                                                    Zone = $(this).attr('Zone');
                                                }
                                                if (typeof ($(this).attr('Sensitivity')) != 'undefined') {
                                                    Sensitivity = $(this).attr('Sensitivity');
                                                }
                                                //}
                                                if (Zone != '' || Sensitivity != '') {
                                                    if (typeof ($(this).attr('Family')) != 'undefined' && $(this).attr('Family') != Family) {
                                                        Family = $(this).attr('Family');
                                                        //html += '<tr><td width=90% colspan="3" align="center" style="font-weight:bold;">' + Family + '</td></tr>';                                                        
                                                    }
                                                    html += '<tr><td width=30%>' + DrugName + '</td><td width=30%>' + Sensitivity + '</td><td width=30%>' + Zone + '</td></tr>';
                                                }
                                            });
                                        });
                                    });
                                    html += '</tbody></table>';
                                    //$('#page-wrap').append($(html));
                                    return html
                                }
                            }

                            if (full["DeviceID"] != "" && full["DeviceErrorCode"] == "Y") {
                                return data + " <span style='background-color:Red; color:White; text-align:right;' title='Device Error'>FLG</span>  <img align='right' alt='Device Value' id='imgDeviceValue' style='cursor: pointer;' src = '../Images/report.gif' onclick = 'javascript:GetDeviceValue(" + OrgID + "," + VID + "," + full["InvestigationID"] + ");' title='Click to view Device Value' /> ";
                            }
                            else if (full["DeviceID"] != "" && full["DeviceErrorCode"] == "N") {
                                return data + " <img align='right' alt='Device Value' id='imgDeviceValue' style='cursor: pointer;' src = '../Images/report.gif' onclick = 'javascript:GetDeviceValue(" + OrgID + "," + VID + "," + full["InvestigationID"] + ");' title='Click to view Device Value' />";
                            }
                            else {
                                //                                if (data == null && full["ValidationText"] != null) {
                                //                                    //debugger;
                                //                                    return CalculateComputationValue(full["ValidationText"]);
                                //                                }
                                //                                else {
                                //                                    return data;
                                //                                }
                                return data;
                            }
                        }
                    },
                    { "mDataProp": "UOMCode" },
                    { "mDataProp": "ReferenceRange" },
                    { "mDataProp": "Reason" },
                    { "mDataProp": "MedicalRemarks",
                        "mRender": function(data, type, full) {
                            if (full["GroupName"] == null && full["DeptName"] == null && full["InvestigationID"] == 0) {   // - GroupHeader                           
                                return '<asp:HyperLink ID="hylnkGrpRemarks" runat="server" Text="Add Group Remarks" onclick="javascript:fnOpenGrpRemarksDiv(' + full['RootGroupID'] + ');" style="color:Blue; cursor:pointer; text-decoration:underline;"></asp:HyperLink> ';
                            }
                            else {
                                return data;
                            }
                        }
                    },
                    { "mDataProp": "MethodName",
                        "mRender": function(data, type, full) {
                            var deltavalues = "";
                            //debugger;
                            if (arrPatientValuesHistory[0] != undefined && arrPatientValuesHistory[0].length > 0 && data == "Y") {
                                var arrPatientInvestigationValuesHistory = $.grep(arrPatientValuesHistory[0], function(v) {
                                    return v.InvestigationID == full["InvestigationID"];
                                });
                                if (arrPatientInvestigationValuesHistory.length > 0) {
                                   var arrPatientInvestigationValuesHistorylength = arrPatientInvestigationValuesHistory.length;
                                    for (k = 0; k < arrPatientInvestigationValuesHistorylength; k++) {
                                        deltavalues = arrPatientInvestigationValuesHistory[k].Value + "-(" + arrPatientInvestigationValuesHistory[k].UOMCode + ")\n";
                                    }
                                }
                            }
                            return deltavalues;
                        }
                    },
                    { "mDataProp": "DisplayStatus",
                        "mRender": function(data, type, full) {
                            if (full["GroupName"] == null && full["DeptName"] == null && full["InvestigationID"] == 0) {   // - GroupHeader
                                var ddlGrpStatusid = 'ddlGrpStatus_' + full["RootGroupID"];
                                return fnCreateGrpStatus(ddlGrpStatusid, full);
                            }
                            else {
                                return data;
                            }
                        }
                    },
                    { "mDataProp": "IsAbnormal" },
                    { "mDataProp": "IsSensitive" },
                    { "mDataProp": "IsFormulaField" },
                    { "mDataProp": "PatternID" },
                    { "mDataProp": "ResultValueType" },
                    { "mDataProp": "DecimalPlaces" },
                    { "mDataProp": "Status"}],

                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    //debugger;
                    if (aData["GroupName"] != null) {   // - GroupContent
                        $(nRow).css('background-color', 'LightBlue');
                        if (aData["InvestigationID"] != null) {
                            $(nRow).attr("id", 'rowNum' + aData["InvestigationID"]);
                            if (aData["IsFormulaField"] == "A") {
                                $(nRow).css('background-color', 'Gray');
                            }
                            if (aData["IsAbnormal"] == "A") {
                                $('td:eq(2)', nRow).css('background-color', 'yellow');
                                //$(nRow).css('background-color', 'yellow');
                                $('td:eq(2)', nRow).title = 'Higher Abnormal Range';
                            }
                            else if (aData["IsAbnormal"] == "L") {
                                $('td:eq(2)', nRow).css('background-color', 'LightPink');
                                $('td:eq(2)', nRow).title = 'Lower Abnormal Range';
                            }
                            else if (aData["IsAbnormal"] == "P") {
                                $('td:eq(2)', nRow).css('background-color', 'red');
                                $('td:eq(2)', nRow).title = 'Panic Range';
                            }
                            else {
                                if (aData["IsAbnormal"] == "N" && aData["IsFormulaField"] == "Y") {
                                    $('td:eq(2)', nRow).title = 'Formula Field';
                                    //$('td:eq(2)', nRow).css('background-color', '#FABF8F');
                                    $('td:eq(2)', nRow).css('background-color', '');
                                }
                                else if (aData["IsAbnormal"] == "N" && aData["IsFormulaField"] == "N") {
                                    $('td:eq(2)', nRow).title = 'Normal Range ';
                                    $('td:eq(2)', nRow).css('background-color', '');
                                }
                            }
                        }
                        //                                $('td', nRow).on('click', function() {
                        //                                    $("#somediv").dialog({
                        //                                        width: 900,
                        //                                        height: 600,
                        //                                        modal: true,
                        //                                        close: function() {
                        //                                            $("#thedialog").attr('src', "about:blank");
                        //                                        }
                        //                                    });
                        //                                });
                    }
                    else if (aData["GroupName"] == null && aData["DeptName"] == null) {   // - GroupHeader
                        $(nRow).css('background-color', '#E2E4FF');
                        //                                if (aData["InvestigationID"] != null) {
                        //                                    $(nRow).attr("id", 'rowNum' + aData["InvestigationID"]);
                        //                                    //formValidationRule('rowNum' + aData["InvestigationID"], aData);
                        //                                }
                    }
                    else if (aData["GroupName"] == null && aData["DeptName"] != null && aData["InvestigationID"] == 0) {   // - DeptHeader
                        $(nRow).css('background-color', '#99B3FF');
                        //                                if (aData["InvestigationID"] != null) {
                        //                                    $(nRow).attr("id", 'rowNum' + aData["InvestigationID"]);
                        //                                    //formValidationRule('rowNum' + aData["InvestigationID"], aData);
                        //                                }
                    }
                    else {   // - Investigation
                        //debugger;
                        if (aData["InvestigationID"] != null) {
                            $(nRow).css('background-color', '#ffffff');
                            $(nRow).attr("id", 'rowNum' + aData["InvestigationID"]);
                            //formValidationRule('rowNum' + aData["InvestigationID"], aData);
                            if (aData["IsFormulaField"] == "A") {
                                $(nRow).css('background-color', 'Gray');
                            }
                            if (aData["IsAbnormal"] == "A") {
                                $('td:eq(2)', nRow).css('background-color', 'yellow');
                                $('td:eq(2)', nRow).title = 'Higher Abnormal Range';
                            }
                            else if (aData["IsAbnormal"] == "L") {
                                $('td:eq(2)', nRow).css('background-color', 'LightPink');
                                $('td:eq(2)', nRow).title = 'Lower Abnormal Range';
                            }
                            else if (aData["IsAbnormal"] == "P") {
                                $('td:eq(2)', nRow).css('background-color', 'red');
                                $('td:eq(2)', nRow).title = 'Panic Range';
                            }
                            else {
                                if (aData["IsAbnormal"] == "N" && aData["IsFormulaField"] == "Y") {
                                    $('td:eq(2)', nRow).title = 'Formula Field';
                                    //$('td:eq(2)', nRow).css('background-color', '#FABF8F');
                                    $('td:eq(2)', nRow).css('background-color', '');
                                }
                                else if (aData["IsAbnormal"] == "N" && aData["IsFormulaField"] == "N") {
                                    $('td:eq(2)', nRow).title = 'Normal Range';
                                    $('td:eq(2)', nRow).css('background-color', '');
                                }
                            }
                        }
                    }
                    return nRow;
                    //CalculateComputationValue(aData["ValidationText"]);
                },



                "aoColumnDefs": [{
                    "aTargets": [2],
                    "fnCreatedCell": function(nTd, sData, oData, iRow, iCol) {
                        //debugger;
                        if (oData["InvestigationID"] != 0) {
                            var id = "cellNum" + oData["InvestigationID"];
                            $(nTd).attr("id", id);
                            var hdnValidationText = document.getElementById("hdnValidationText");
                            var ValRule = "";
                            ValRule = hdnValidationText.value;
                            //alert(ValRule);
                            var Re = new RegExp("\\'\\[" + oData["InvestigationID"] + "]'", "g");
                            ValRule = ValRule.replace(Re, "'" + id + "'");
                            var Re1 = new RegExp("\\" + "[" + oData["InvestigationID"] + "]" + "", "g");
                            ValRule = ValRule.replace(Re1, "document.getElementById('" + id + "').innerText");
                            hdnValidationText.value = ValRule;



                            var hdnValidationTextOnLoad = document.getElementById("hdnValidationTextOnLoad");
                            var ValRule1 = "";
                            ValRule1 = hdnValidationTextOnLoad.value;
                            //alert(ValRule);
                            //var Re2 = new RegExp("\\" + "'[" + oData["InvestigationID"] + "]'" + "", "g");
                            //ValRule1 = ValRule1.replace("'[" + oData["InvestigationID"] + "]'", "'" + id + "'");
                            var Re2 = new RegExp("\\'\\[" + oData["InvestigationID"] + "]'", "g");
                            ValRule1 = ValRule1.replace(Re2, "'" + id + "'");
                            var Re3 = new RegExp("\\" + "[" + oData["InvestigationID"] + "]" + "", "g");
                            ValRule1 = ValRule1.replace(Re1, "document.getElementById('" + id + "').innerText");
                            hdnValidationTextOnLoad.value = ValRule1;


                            //                                if (oData["IsAbnormal"] == "A") {
                            //                                    // $(nTd).css('background-color', 'yellow');

                            //                                    nTd.title = 'Higher Abnormal Range';
                            //                                }
                            //                                else if (oData["IsAbnormal"] == "L") {
                            //                                    // $(nTd).css('background-color', 'LightPink');
                            //                                    nTd.title = 'Lower Abnormal Range';
                            //                                }
                            //                                else if (oData["IsAbnormal"] == "P") {
                            //                                    // $(nTd).css('background-color', 'red');
                            //                                    nTd.title = 'Panic Range';
                            //                                }
                            //                                else if (oData["IsAbnormal"] == "N") {
                            //                                    nTd.title = 'Normal Range';
                            //                                }
                        }
                    }
                },
                // "aoColumnDefs": [
                        {"sClass": "hide_column", "aTargets": [0, 9, 10,11, 12, 13, 14, 15]}],     // 0 - InvestigationID, 9 - IsAbnormal, 10 - IsSensitive, 11 - IsFormulaField, 12 -PatternID, 13 - ResultValueType, 14 - DecimalPlaces ,15 - Status



                "bPaginate": false,
                "bSort": false,
                "aaSorting": [],
                "bJQueryUI": true

            });

            //                    debugger;
            //                    var table = $('#tblInvestigatonResultsCapture').DataTable();
            //                    new $.fn.dataTable.FixedHeader(table);
            //                    $("#tblInvestigatonResultsCapture tbody tr").each(function() {
            //                        //debugger;
            //                        var pos = oTable.fnGetPosition(this);
            //                        var aData = oTable.fnGetData(pos);
            //                        if (aData["InvestigationID"] != 0) {
            //                            oTable.fnUpdate('Approve', pos, 8,false,false);
            //                        }
            //                    });
            fnParseXMLAndUpdateStatus();
            //fnCalculateComputationValue(oTable, false);
            //fnCalculateComputationValue1(oTable, false);
            //debugger;
            s = ' function fnCalculateValue(id) { ' + document.getElementById('hdnValidationTextOnLoad').value + '}';
            eval(s);
            fnCalculateValue('cellNum7951');
            fnUpdateValue(oTable, 'N','cellNum7951');
            //fnCreateGrpStatus();
            //                    var count = $("#tblInvestigatonResultsCapture tbody tr").length;
            //                    var select = '<select><option value="a">A</option><option value="b">B</option></select>';
            //                    for (var rowNum = 0; rowNum < count; rowNum++) {
            //                        CalculateComputationValue();
            //                        //oTable.fnUpdate(select, rowNum, 3, true, true);
            //                    }

            $('#tblInvestigatonResultsCapture').show();
            $('#divInv').show();
            $('#modal').hide();
        }

    }
    catch (e) {
        alert("Unable to Load");
        $('#modal').hide();
        //fnPhlebHome();	

    }
}
function fnParseXMLAndUpdateStatus() {
    try {
        var oTable = $("#tblInvestigatonResultsCapture").dataTable();
        $("#tblInvestigatonResultsCapture > tbody > tr").each(function() {
            //debugger;
            // get the position of the current data from the node
            var aPos = oTable.fnGetPosition(this);
            // get the data array
            var aData = oTable.fnGetData(aPos);
            var ReferenceRange = aData["ReferenceRange"];
            var isXML = false;
            if (ReferenceRange != null) {
                try {
                    //isXML = $.parseXML(ReferenceRange).validateOnParse;
                    var xml = $.parseXML(ReferenceRange);
                    isXML = true;
                } catch (err) {
                    isXML = false;
                }

                //Update XML
                //debugger;
                if (isXML) {
                    var refrange = fnGetReferenceRange(aData);
                    if (refrange.indexOf("<br>") > -1 && refrange.charAt(refrange.length - 1) == '>') {
                        refrange = refrange.substr(0, refrange.length - 4);
                    }
                    //refrange = refrange.replace("<br>", "\n");
                    oTable.fnUpdate(refrange, aPos, 4, false, false);    // 4 - Represents 4 column(ReferenceRange Column) in datatable
                }
                else if (ReferenceRange.indexOf("<br>") > -1) {
                    if (ReferenceRange.charAt(ReferenceRange.length - 1) == '>') {
                        ReferenceRange = ReferenceRange.substr(0, ReferenceRange.length - 4);
                    }
                    //ReferenceRange = ReferenceRange.replace("<br>", "\n");
                    oTable.fnUpdate(ReferenceRange, aPos, 4, false, false);    // 4 - Represents 4 column(ReferenceRange Column) in datatable
                }
            }

            if (aData["Status"] != null && aData["Status"] != '' && (aData["Status"] == "Approve" || aData["Status"] == "PartiallyApproved")) {
                oTable.fnUpdate("A", aPos, 11, true, true);   // 11 - Represents 11th column(IsFormulaField Column) in datatable
            } 
            
            //Update Status
            //debugger;
            var Status = $('#hdnStatus').val();
            var DisplayStatus = $('#hdnDisplayStatus').val();


            if (aData["ValidationRule"] != null && aData["ValidationRule"] != '') {
                var ValRule = aData["ValidationRule"].split("^");
                var VarLength = ValRule.length;
                var IsFormulaField = 'N';
                for (i = 0; i < VarLength; i++) {
                    var childInv = ValRule[i].split("=")[0];
                    var childinvid = childInv.replace(/[\[\]\"']+/g, '');
                    if (childinvid == aData["InvestigationID"]) {
                        if (aData["Status"] != null && aData["Status"] != '' && (aData["Status"] == "Approve" || aData["Status"] == "PartiallyApproved")) {
                            oTable.fnUpdate("A", aPos, 11, true, true);   // 11 - Represents 11th column(IsFormulaField Column) in datatable
                        }
                        else
                            oTable.fnUpdate("Y", aPos, 11, true, true);   // 11 - Represents 11th column(IsFormulaField Column) in datatable
                        break;
                    }
                }
            }

            if (aData["InvestigationID"] != 0 && Status != "0" && DisplayStatus != "0") {
                if (aData["Status"] != null && aData["Status"] != '' && (aData["Status"] == "Approve")) {
                    oTable.fnUpdate("Approved", aPos, 8, false, false);     // 8 - Represents 8th column(DisplayStatus Column) in datatable
                    oTable.fnUpdate(Status, aPos, 15, false, false);           // 15 - Represents 15th column(Status Column) in datatable
                }
                else {
                    oTable.fnUpdate("Approve", aPos, 8, false, false);         // 8 - Represents 8th column(DisplayStatus Column) in datatable
                    oTable.fnUpdate(Status, aPos, 15, false, false);           // 15 - Represents 15th column(Status Column) in datatable
                }
            }
        });
    }
    catch (e) {

    }
}


//            function formValidationRule(rowID, aData) {
//                //debugger;
//                var hdnValidationRule = document.getElementById("hdnValidationRule");
//                if (hdnValidationRule.value != "" && aData["ValidationText"] != null && aData["ValidationText"] != "") {
//                    if (hdnValidationRule.value.indexOf(aData["InvestigationID"]) > -1) {
//                        hdnValidationRule.value = replaceAll(hdnValidationRule.value,aData["InvestigationID"], rowID);
//                    }
//                }
//            }


function ChangeComputationFieldEditOption(txtid) {
    try {
        var lstEditableFormulaFields = '';
        if (document.getElementById('hdnEditableFormulaFields') != null) {
            lstEditableFormulaFields = document.getElementById('hdnEditableFormulaFields').value;
            if (lstEditableFormulaFields.indexOf(txtid) >= 0) {
                //document.getElementById(txtid).readOnly = true;
                lstEditableFormulaFields = lstEditableFormulaFields.replace(txtid + "^", "").replace(txtid, "");
                document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                //ChecKGroupSum(txtid);
            }
            else {
                document.getElementById(txtid).readOnly = false;
                lstEditableFormulaFields = lstEditableFormulaFields + txtid + "^";
                document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
            }
        }
    }
    catch (e) {
        return false;
    }
}


function replaceAll(txt, replace, with_this) {
    return txt.replace(new RegExp(replace, 'g'), with_this);
}

function fnCalculateComputationValue(oTable, IsEdit) {
    try {
        //debugger;
        // var t = jQuery.noConflict();
        var table = $('#tblInvestigatonResultsCapture').DataTable();
        //var oTable = $("#tblInvestigatonResultsCapture").dataTable();             
        var hdnValidationRule = document.getElementById("hdnValidationRule");
        //var ValRule = ValidationText.split("^");
        var ValRule = "";
        if (hdnValidationRule.value != "") {
            ValRule = hdnValidationRule.value.split("^");
        }
        var comVal;
        var TobeContinue = false;
        var ValRulelength = ValRule.length;
        for (i = 0; i < ValRulelength; i++) {
            var parentInv = ValRule[i].split("=")[1];
            var childInv = ValRule[i].split("=")[0];
            var matches = parentInv.match(/\[(.*?)\]/g);
            var indexes;
            var childinvid = childInv.replace(/[\[\]\"']+/g, '');
            //var childindexes = $("#myTable").fnGetPosition($("#16"));
            //var childindexes = table.fnGetPosition($("#rownum4756").get(0));
            //childindexes = table.fnGetPosition($("#rownum4756"));
            var childID = "rowNum" + childinvid;
            var childObj = document.getElementById(childID);
            //document.getElementById("cellNum5579").innerHTML = '100';
            var childindexes = oTable.fnGetPosition(childObj);
            //                    var childindexes = table.rows().eq(0).filter(function(rowIdx) {
            //                        return table.cell(rowIdx, 0).data() === parseInt(childinvid) ? true : false;
            //                    });
            childrow = oTable.fnGetData(childindexes);

            //Update IsFormulaField
            oTable.fnUpdate("Y", childindexes, 11, true, true);   // 11 - Represents 11th column(IsFormulaField Column) in datatable

            //childrow = table.rows(childindexes).data();
            if ((childrow != undefined) && (childrow["Value"] == null || childrow["Value"] == "" || IsEdit)) {
            var matlength = matches.length;
            for (j = 0; j < matlength; j++) {
                    var invid = matches[j].replace(/[\[\]\"']+/g, '');
                    var parentID = "rowNum" + invid;
                    var parentObj = document.getElementById(parentID);
                    var parentindexes = oTable.fnGetPosition(parentObj);

                    //                            indexes = table.rows().eq(0).filter(function(rowIdx) {
                    //                                return table.cell(rowIdx, 0).data() === parseInt(invid) ? true : false;
                    //                            });
                    //var row = table.rows(indexes).data();
                    var row = oTable.fnGetData(parentindexes);
                    var val = row["Value"];
                    parentInv = parentInv.replace(matches[j], val);
                    if (val == null) {
                        TobeContinue = true;
                    }
                }
                if (parentInv.indexOf(null) == -1) {
                    var comVal = eval(parentInv);
                    var DecimalPlaces = childrow["DecimalPlaces"];
                    if (DecimalPlaces != null && !isNaN(DecimalPlaces)) {
                        var decimalPlace = parseInt(DecimalPlaces);
                        if (decimalPlace > 0) {
                            comVal = parseFloat(comVal).toFixed(decimalPlace);
                        }
                        else if (decimalPlace == 0) {
                            comVal = Math.round(comVal);
                        }
                    }


                    //childrow = table.rows(childindexes).data();

                    //                    childrow[0].Value = comVal;
                    //                    childrow[0].innerHTML = comVal;

                    //fnParseXML(comVal, childrow, oTable, childindexes);
                    if (childrow["IOMReferenceRange"] != null && childrow["IOMReferenceRange"] != "") {
                        fnvalidateResultValue(comVal, childrow, oTable, childindexes);
                    }
                    else {
                        //Update Result Value
                        oTable.fnUpdate(comVal, childindexes, 2, false, false);   // 2 - Represents 2 column(Value Column) in datatable
                    }
                    fnAutoMedComments(comVal, childrow, oTable, childindexes, "N");
                    //parentInv = parentInv.replace(/\"
                    //return comVal;
                }
            }
        }
        if (TobeContinue) {
            fnCalculateComputationValue(oTable, IsEdit);
        }
    }
    catch (e) {

    }
}

//               function fnCalculateValue() {
//                   //debugger;
//                   var txtEditable1 = false;
//if (document.getElementById('hdnEditableFormulaFields') != null) {
//    txtEditable1 = document.getElementById('hdnEditableFormulaFields').value.indexOf('cellNum8574') >= 0 ? true : false;
//}
//if (!txtEditable1) {
//    var temp1 = (((parseFloat(document.getElementById('cellNum4830').innerText)) * (parseFloat(document.getElementById('cellNum4362').innerText))) / 1000).toFixed(2);
//    if (isNaN(temp1)) {
//        document.getElementById('cellNum8574').innerText = '';
//    } else {
//        document.getElementById('cellNum8574').innerText = (((parseFloat(document.getElementById('cellNum4830').innerText)) * (parseFloat(document.getElementById('cellNum4362').innerText))) / 1000).toFixed(2);
//    }
//}
//var txtEditable2 = false;
//if (document.getElementById('hdnEditableFormulaFields') != null) {
//    txtEditable2 = document.getElementById('hdnEditableFormulaFields').value.indexOf('cellNum6113') >= 0 ? true : false;
//}
//if (!txtEditable2) {
//    var temp2 = ((parseFloat(document.getElementById('cellNum8575').innerText)) * ((parseFloat(document.getElementById('cellNum2005').innerText)) / 100)).toFixed(1);
//    if (isNaN(temp2)) {
//        document.getElementById('cellNum6113').innerText = '';
//    } else {
//        document.getElementById('cellNum6113').innerText = ((parseFloat(document.getElementById('cellNum8575').innerText)) * ((parseFloat(document.getElementById('cellNum2005').innerText)) / 100)).toFixed(1);
//    }
//}
//var txtEditable3 = false;
//if (document.getElementById('hdnEditableFormulaFields ') != null)
//{
//txtEditable3 = document.getElementById('hdnEditableFormulaFields ').value.indexOf('cellNum8671 ') >= 0 ? true : false;
//}
// if(!txtEditable3){ var temp3 = ((parseFloat(document.getElementById('cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2008 ').innerText))/100)).toFixed(1); if(isNaN(temp3)) {document.getElementById('
//cellNum8671 ').innerText = '';} else {document.getElementById('
//cellNum8671 ').innerText = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2008 ').innerText))/100)).toFixed(1);}} var txtEditable4 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable4 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum8670 ') >= 0 ? true : false;} if(!txtEditable4){ var temp4 = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum4055 ').innerText))/100)).toFixed(1); if(isNaN(temp4)) {document.getElementById('
//cellNum8670 ').innerText = '';} else {document.getElementById('
//cellNum8670 ').innerText = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum4055 ').innerText))/100)).toFixed(1);}} var txtEditable5 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable5 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum8669 ') >= 0 ? true : false;} if(!txtEditable5){ var temp5 = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2006 ').innerText))/100)).toFixed(1); if(isNaN(temp5)) {document.getElementById('
//cellNum8669 ').innerText = '';} else {document.getElementById('
//cellNum8669 ').innerText = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2006 ').innerText))/100)).toFixed(1);}} var txtEditable6 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable6 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum2011 ') >= 0 ? true : false;} if(!txtEditable6){ var temp6 = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2007 ').innerText))/100)).toFixed(1); if(isNaN(temp6)) {document.getElementById('
//cellNum2011 ').innerText = '';} else {document.getElementById('
//cellNum2011 ').innerText = ((parseFloat(document.getElementById('
//cellNum8575 ').innerText))*((parseFloat(document.getElementById('
//cellNum2007 ').innerText))/100)).toFixed(1);}} var txtEditable7 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable7 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum2006 ') >= 0 ? true : false;} if(!txtEditable7){ var temp7 = 100-((parseFloat(document.getElementById('
//cellNum4055 ').innerText))+(parseFloat(document.getElementById('
//cellNum2005 ').innerText))+(parseFloat(document.getElementById('
//cellNum2007 ').innerText))+(parseFloat(document.getElementById('
//cellNum2008 ').innerText))); if(isNaN(temp7)) {document.getElementById('
//cellNum2006 ').innerText = '';} else {document.getElementById('
//cellNum2006 ').innerText = 100-((parseFloat(document.getElementById('
//cellNum4055 ').innerText))+(parseFloat(document.getElementById('
//cellNum2005 ').innerText))+(parseFloat(document.getElementById('
//cellNum2007 ').innerText))+(parseFloat(document.getElementById('
//cellNum2008 ').innerText)));}} var txtEditable8 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable8 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum4810 ') >= 0 ? true : false;} if(!txtEditable8){ var temp8 = ((parseFloat(document.getElementById('
//cellNum6009 ').innerText))/(parseFloat(document.getElementById('
//cellNum4830 ').innerText))).toFixed(0); if(isNaN(temp8)) {document.getElementById('
//cellNum4810 ').innerText = '';} else {document.getElementById('
//cellNum4810 ').innerText = ((parseFloat(document.getElementById('
//cellNum6009 ').innerText))/(parseFloat(document.getElementById('
//cellNum4830 ').innerText))).toFixed(0);}} var txtEditable9 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable9 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum4811 ') >= 0 ? true : false;} if(!txtEditable9){ var temp9 = ((parseFloat(document.getElementById('
//cellNum6009 ').innerText))/(parseFloat(document.getElementById('
//cellNum8574 ').innerText))).toFixed(0); if(isNaN(temp9)) {document.getElementById('
//cellNum4811 ').innerText = '';} else {document.getElementById('
//cellNum4811 ').innerText = ((parseFloat(document.getElementById('
//cellNum6009 ').innerText))/(parseFloat(document.getElementById('
//cellNum8574 ').innerText))).toFixed(0);}}var txtEditable1 = false;if (document.getElementById('
//hdnEditableFormulaFields ') != null) {txtEditable1 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum5461 ') >= 0 ? true : false;}if (!txtEditable1) {var temp1 = ((parseFloat(document.getElementById('
//cellNum4861 ').innerText.replace(' < ', ''))) / (parseFloat(document.getElementById('
//cellNum4859 ').innerText))).toFixed(2);if (isNaN(temp1)) { document.getElementById('
//cellNum5461 ').innerText = ''; }else {document.getElementById('
//cellNum5461 ').innerText = ((parseFloat(document.getElementById('
//cellNum4861 ').innerText.replace(' < ', ''))) / (parseFloat(document.getElementById('
//cellNum4859 ').innerText))).toFixed(2); document.getElementById('
//cellNum5461 ').innerText = document.getElementById('
//cellNum4861 ').innerText.indexOf(' < ') >= 0 ? ' < ' + document.getElementById('
//cellNum5461 ').innerText : document.getElementById('
//cellNum5461 ').innerText;}}var txtEditable1 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable1 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum5579 ') >= 0 ? true : false;} if(!txtEditable1){ var temp1 = ((parseFloat(document.getElementById('
//cellNum4759 ').innerText))/(parseFloat(document.getElementById('
//cellNum5577 ').innerText))).toFixed(2); if(isNaN(temp1)) {document.getElementById('
//cellNum5579 ').innerText = '';} else {document.getElementById('
//cellNum5579 ').innerText = ((parseFloat(document.getElementById('
//cellNum4759 ').innerText))/(parseFloat(document.getElementById('
//cellNum5577 ').innerText))).toFixed(2);}} var txtEditable2 = false; if(document.getElementById('
//hdnEditableFormulaFields ') != null){txtEditable2 = document.getElementById('
//hdnEditableFormulaFields ').value.indexOf('
//cellNum5578 ') >= 0 ? true : false;} if(!txtEditable2){ var temp2 = (((parseFloat(document.getElementById('
//cellNum4759 ').innerText))-(parseFloat(document.getElementById('
//cellNum5577 ').innerText)))-((parseFloat(document.getElementById('
//cellNum3057 ').innerText))/2.2)).toFixed(2); if(isNaN(temp2)) {document.getElementById('
//cellNum5578 ').innerText = '';} else {document.getElementById('
//cellNum5578 ').innerText = (((parseFloat(document.getElementById('
//cellNum4759 ').innerText))-(parseFloat(document.getElementById('
//cellNum5577 ').innerText)))-((parseFloat(document.getElementById('
//cellNum3057 ').innerText))/2.2)).toFixed(2);}}
//                }

function fnUpdateValue(oTable, IsEdit,id) {
    try {
        // debugger;
        // var t = jQuery.noConflict();
        var table = $('#tblInvestigatonResultsCapture').DataTable();
        //var oTable = $("#tblInvestigatonResultsCapture").dataTable();
        var hdnValidationRule = "";
        if (IsEdit == 'Y')
            hdnValidationRule = document.getElementById("hdnValidationRule");
        else
            hdnValidationRule = document.getElementById("hdnValidationRuleOnLoad");
        //var ValRule = ValidationText.split("^");
        var ValRule = "";
        if (hdnValidationRule.value != "" && hdnValidationRule.value != null) {
            ValRule = hdnValidationRule.value.split("^");
        }
        var comVal;
        var TobeContinue = false;

        var pGender = document.getElementById('PatientDetail_hdnGender').value;
        //var age = document.getElementById('PatientDetail_lblAge').innerHTML;
        var age = document.getElementById('PatientDetail_lblReferenceRangeAge').innerHTML;
        var arr = age.split(' ');
        var pAge = arr[0];
        var pAgeType = arr[1];
        var rangeValue = comVal;
        var txtid, panicxmlContent, txtIsAbnormalId, lblName, lblUnit = "";
        var agedays = document.getElementById('PatientDetail_hdnAgeDays').value;
        var IsExcludeAutoApproval = document.getElementById('hdnIsExcludeAutoApproval').value;
        var hdnOrgID = document.getElementById('hdnOrgID').value;
        var fulldata = "";
        var valrulelength = ValRule.length;
        for (i = 0; i < valrulelength; i++) {
            var childInv = ValRule[i].split("=")[0];
            var childinvid = childInv.replace(/[\[\]\"']+/g, '');
            var childID = "rowNum" + childinvid;
            var childObj = document.getElementById(childID);
            var childindexes = oTable.fnGetPosition(childObj);
            childrow = oTable.fnGetData(childindexes);
            //Update IsFormulaField
            //oTable.fnUpdate("Y", childindexes, 11, true, true);   // 11 - Represents 11th column(IsFormulaField Column) in datatable
            //Update Result Value
            var cellId = "cellNum" + childrow["InvestigationID"];
            comVal = document.getElementById(cellId).innerHTML;
            var DeviceId = childrow["DeviceID"];
            var IsFormulaField = childrow["IsFormulaField"];
            // if ((IsEdit != 'Y' && comVal != "" && DeviceId == "" && IsFormulaField == "Y") || (IsEdit == 'Y' && comVal != "")) {
            if (id != cellId) {
                //fnParseXML(comVal, childrow, oTable, childindexes);
                //if (childrow["IOMReferenceRange"] != null && childrow["IOMReferenceRange"] != "") {
                    //fnvalidateResultValue(comVal, childrow, oTable, childindexes);
                    var xmlContent = childrow["IOMReferenceRange"];
                    var AutoApproveLoginId = childrow["AutoApproveLoginID"];
                    var IsRemarks = childrow["HeaderName"];
                    var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + comVal + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID + "|" + agedays + "|" + childinvid + "|" + age + "|" + IsRemarks;
                    fulldata = fulldata + data + "^";
                //                }
                //                else {
                //                    oTable.fnUpdate(comVal, childindexes, 2, false, false);   // 2 - Represents 2 column(Value Column) in datatable
                //                }
            }
            //fnAutoMedComments(comVal, childrow, oTable, childindexes);
        }
        //debugger;
        if (fulldata != "") {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ValidateValue",
                data: "{xmlFullData: '" + fulldata + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    //debugger;
                    if (data.d != '') {
                        var dict = JSON.parse(data.d);
                        var ValRulelen = ValRule.length;
                        for (e = 0; e < ValRulelen; e++) {
                            var childInv = ValRule[e].split("=")[0];
                            var childinvid = childInv.replace(/[\[\]\"']+/g, '');
                            var childID = "rowNum" + childinvid;
                            var childObj = document.getElementById(childID);
                            var childindexes = oTable.fnGetPosition(childObj);
                            var childrow = oTable.fnGetData(childindexes);
                            var cellId = "cellNum" + childrow["InvestigationID"];
                            var comVal = document.getElementById(cellId).innerHTML;
                            
                            var DecimalPlaces = childrow["DecimalPlaces"];
                            if (comVal != null && comVal != "" && !isNaN(comVal)) {
                            if (DecimalPlaces != null && !isNaN(DecimalPlaces)) {
                                var decimalPlace = parseInt(DecimalPlaces);
                                if (decimalPlace > 0) {
                                    if (comVal.indexOf('<') >= 0) {
                                        comVal = parseFloat(comVal.replace('<', '')).toFixed(decimalPlace);
                                        comVal = '<' + comVal;
                                    }
                                    else {
                                        comVal = parseFloat(comVal).toFixed(decimalPlace);
                                    }
                                }
                                else if (decimalPlace == 0) {
                                    if (comVal.indexOf('<') >= 0) {
                                        //InvValue = parseFloat(InvValue.replace('<', '')).toFixed(decimalPlace);
                                        comVal = Math.round(parseFloat(comVal.replace('<', '')));
                                        comVal = '<' + InvValue;
                                    }
                                    else {
                                        //InvValue = parseFloat(InvValue).toFixed(decimalPlace);
                                        comVal = Math.round(comVal);
                                        }
                                    }
                                }
                            }
                            var interpretationResult = 0;
                            var oDict = dict[childinvid];
                            if (oDict != undefined) {
                                //debugger;
                                var txtColor = oDict["color"];
                                var rangeCode = oDict["rangeCode"];
                                var IsSensitive = oDict["IsSensitive"];
                                var MedRemarks = oDict["MedRemarks"];
                                if (rangeCode != "A" && rangeCode != "L" && rangeCode != "P") {
                                    rangeCode = "N";
                                }
                                var result = oDict["InterpretationRange"];
                                if (result != "" && result.indexOf('~') > -1) {
                                    var lstResult = result.split('~');
                                    if (lstResult[0] == "Interpretation") {
                                        interpretationResult = lstResult[1];
                                    }
                                    else {
                                        interpretationResult = lstResult[1] + "," + comVal;
                                    }
                                }
                                interpretationResult = interpretationResult == 0 ? comVal : interpretationResult;
                                oTable.fnUpdate(interpretationResult, childindexes, 2, false, false);   // 2 - Represents 2 column(Value Column) in datatable
                                oTable.fnUpdate(rangeCode, childindexes, 9, true, true);   // 9 - Represents 8th column(IsAbnormal Column) in datatable
                                oTable.fnUpdate(IsSensitive, childindexes, 10, false, false); // 10 - Represents 9th column(IsSensitive Column) in datatable
                                //if (MedRemarks != "") {
                                oTable.fnUpdate(MedRemarks, childindexes, 6, false, false);     // 6 - Represents 6th Column (Medical Remarks Column) in Datatable                        
                                //}
                            }
                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //debugger;
                    //alert(9);
                    return false;
                }
            });
        }
    }
    catch (e) {
        //debugger;
        //alert(e);
    }

}
function fnvalidateValue(comVal, childrow, oTable, childindexes) {
    try {

        var pGender = document.getElementById('PatientDetail_hdnGender').value;
        //var age = document.getElementById('PatientDetail_lblAge').innerHTML;
        var age = document.getElementById('PatientDetail_lblReferenceRangeAge').innerHTML;
        var arr = age.split(' ');
        var pAge = arr[0];
        var pAgeType = arr[1];
        var rangeValue = comVal;
        var txtid, panicxmlContent, txtIsAbnormalId, lblName, lblUnit = "";
        var agedays = document.getElementById('PatientDetail_hdnAgeDays').value;
        var IsExcludeAutoApproval = document.getElementById('hdnIsExcludeAutoApproval').value;
        var hdnOrgID = document.getElementById('hdnOrgID').value;

        var xmlContent = childrow["IOMReferenceRange"];
        var AutoApproveLoginId = childrow["AutoApproveLoginID"];
        var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + rangeValue + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID + "|" + agedays;

    }
    catch (e) {

    }
}
function fnvalidateResultValue(comVal, childrow, oTable, childindexes) {
    try {
        //debugger;
        var xmlContent = childrow["IOMReferenceRange"];
        var pGender = document.getElementById('PatientDetail_hdnGender').value;
        //var age = document.getElementById('PatientDetail_lblAge').innerHTML;
        var age = document.getElementById('PatientDetail_lblReferenceRangeAge').innerHTML;
        var arr = age.split(' ');
        var pAge = arr[0];
        var pAgeType = arr[1];
        var txtid, panicxmlContent, txtIsAbnormalId, lblName, lblUnit = "";
        var agedays = document.getElementById('PatientDetail_hdnAgeDays').value;
        var AutoApproveLoginId = childrow["AutoApproveLoginID"];
        var IsExcludeAutoApproval = document.getElementById('hdnIsExcludeAutoApproval').value;
        var hdnOrgID = document.getElementById('hdnOrgID').value;
       var hdnInterRefRange = "";
       
        var isInterpretationRange = xmlContent.indexOf("resultsinterpretationrange") > -1 ? true : false;
        var interpretationResult = 0;
        if (isInterpretationRange) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ValidateInterpretationRange",
                data: "{ReferenceRange: '" + xmlContent + "', Value:'" + comVal + "', Gender:'" + pGender + "', Age:'" + age + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var result = data.d;
                    if (result != "") {
                        var lstResult = result.split('~');
                        if (lstResult[0] == "Interpretation") {
                            interpretationResult = lstResult[1];
                        }
                        else {
                            interpretationResult = lstResult[1] + "," + comVal;
                            hdnInterRefRange = lstResult[1];
                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    return false;
                }
            });
            interpretationResult = interpretationResult == 0 ? comVal : interpretationResult;
            oTable.fnUpdate(interpretationResult, childindexes, 2, false, false);   // 2 - Represents 2 column(Value Column) in datatable
        }
        else {
            oTable.fnUpdate(comVal, childindexes, 2, false, false);   // 2 - Represents 2 column(Value Column) in datatable
        }

        var rangeValue = ConvertResultValue(comVal);
        if (hdnInterRefRange != "" && hdnInterRefRange != null) {
            rangeValue = ConvertResultValue(hdnInterRefRange);
        }
	 var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + rangeValue + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID + "|" + agedays + "|" + age;
        //ValidateToXml(data);
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/ValidateResultValue",
            data: "{xmlData: '" + data + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {
                //debugger;                   
                if (data.d != '') {
                    var oDict = JSON.parse(data.d);
                    var txtColor = oDict["color"];
                    var rangeCode = oDict["rangeCode"];
                    var IsSensitive = oDict["IsSensitive"];
                    if (rangeCode != "A" && rangeCode != "L" && rangeCode != "P") {
                        rangeCode = "N";
                    }
                    oTable.fnUpdate(rangeCode, childindexes, 9, true, true);   // 9 - Represents 8th column(IsAbnormal Column) in datatable
                    oTable.fnUpdate(IsSensitive, childindexes, 10, false, false); // 10 - Represents 9th column(IsSensitive Column) in datatable                       
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                return false;
            }
        });
    }
    catch (e) {

    }
}

function fnOpenReason() {
    try {
        var ddldivupstatus = $('#ddldivupstatus');
        var SelectedDisplayStatus = $("#ddldivupstatus option:selected").text();
        if (SelectedDisplayStatus == 'Reject') {
            $('#divReason').show();
        }
        else {
            $('#divReason').hide();
        }
    }
    catch (e) {

    }
}
function fnOpenGrpRemarksDiv(RootGroupID) {
    try {
        //debugger;
        //var OrgID = '<%=Session["OrgID"]%>';
        var OrgID = document.getElementById('hdnOrgID').value;
        //var RoleID = '<%=Session["RoleID"]%>';
        var RoleID = document.getElementById('hdnRoleID').value;
        $('#divGroupComment').show();
        var vContextKey = "0~GRP~" + OrgID + "~" + RoleID + "";
        $find('aceDivGrpCmt').set_contextKey(vContextKey);
        $find('aceDivGrpMed').set_contextKey(vContextKey);

        var lstGrpMedRem = $.grep(arrlstGrpMedRem, function(v) {
            return (v.RootGroupID == RootGroupID);
        });

        if (lstGrpMedRem.length > 0) {
            $('#txtDivGrpCmt').val(lstGrpMedRem[0].GroupComment);
            $('#txtDivGrpMed').val(lstGrpMedRem[0].GroupMedicalRemarks);
            $('#lblDivGrpCmtName').text(lstGrpMedRem[0].GroupName);
            $('#lblDivGrpcmtRotGrpID').text(lstGrpMedRem[0].RootGroupID);
        }
    }
    catch (e) {

    }
}
function fnCloseGrpRemarksDiv() {
    try {
        $('#divGroupComment').hide();
    }
    catch (e) {

    }
}

function fnSetGrpRemarks() {
    try {
        //debugger;
        var RoorGroupID = $('#lblDivGrpcmtRotGrpID').text();
        $.each(arrlstGrpMedRem, function(i, obj) {
            if (obj.RootGroupID == RoorGroupID) {
                isExists = true;
                arrayIndex = i;
                return false;
            }
        });
        if (isExists) {
            arrlstGrpMedRem.splice(arrayIndex, 1);
            //                    var oarrlstGrpMedRem = arrlstGrpMedRem[arrayIndex];
            //                    if (oarrlstGrpMedRem.ContainerCount == 1) {
            //                        arrlstGrpMedRem.splice(arrayIndex, 1);
            //                    }
            //                    else {
            //                        oarrlstGrpMedRem.ContainerCount = arrlstGrpMedRem.ContainerCount - 1;
            //                        arrlstGrpMedRem.splice(arrayIndex, 1);
            //                        arrlstGrpMedRem.splice(arrayIndex, 0, oarrlstGrpMedRem);
            //                    }                    
        }
        arrlstGrpMedRem.push({
            PatientVisitID: $('#hdnVID').val(),
            GroupName: $('#lblDivGrpCmtName').text(),
            GroupComment: $('#txtDivGrpCmt').val(),
            GroupMedicalRemarks: $('#txtDivGrpMed').val(),
            OrgID: $('#hdnOrgID').val(),
            RootGroupID: $('#lblDivGrpcmtRotGrpID').text()
        });
        if (arrlstGrpMedRem.length > 0) {
            $('#hdnLstGrpRem').val(JSON.stringify(arrlstGrpMedRem));
        }
        $('#divGroupComment').hide();
    }
    catch (e) {

    }
}

function fnGetReferenceRange(childrow) {
    //debugger;
    try {
        //var uomCode = full["UOMCode"];
        //var xmlData = full["ReferenceRange"];
        var uomCode = childrow["UOMCode"];
        var xmlData = childrow["ReferenceRange"];
        var gender = document.getElementById('PatientDetail_hdnGender').value;
        //var age = document.getElementById('PatientDetail_lblAge').innerHTML;
        var age = document.getElementById('PatientDetail_lblReferenceRangeAge').innerHTML;
        var agedays = document.getElementById('PatientDetail_hdnAgeDays').value;
        var refrange;
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/ConvertXmlToString",
            contentType: "application/json; charset=utf-8",
            data: "{ 'xmlData': '" + xmlData + "','uom': '" + uomCode + "','Gender': '" + gender + "','Age': '" + age + "','AgeDays': '" + agedays + "'}",
            dataType: "json",
            async: false,
            success: function(data) {
                //debugger;
                refrange = data.d;
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Error");
                return "";
            }
        });
        return refrange
    }
    catch (e) {

    }
}

//Function to get the medical remarks based on investigationid and value
function fnAutoMedComments(textvalue, childrow, oTable, childindexes, isFrompopup) {
    //debugger;
    try {
        var autoMedicalComments = document.getElementById("hdnAutoMedicalComments").value;
        if (autoMedicalComments == 'Y') {
            //var textvalue = document.getElementById(id).value;
            var hdnPatientGender = document.getElementById("hdnPatientGender").value;
            var hdnpagearraw = document.getElementById("hdnpagearraw").value;
            var hdnOrgID = document.getElementById('hdnOrgID').value;
            //var TxtMedRemarks = id.split('_')[0] + '_txtMedRemarks';
            //var x = id.split("~");
            var invsplit = childrow["InvestigationID"];

            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/GetMedicalComments",
                data: "{ 'Invid': '" + invsplit + "','TxtValue': '" + textvalue + "','OrgID': '" + hdnOrgID + "','Gender': '" + hdnPatientGender + "','Age':'" + hdnpagearraw + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    if (isFrompopup == "N")
                        oTable.fnUpdate(data.d, childindexes, 6, false, false);     // 6 - Represents 6th Column (Medical Remarks Column) in Datatable
                    else {
                        $('#txtdivupMedRem').val(data.d);
                    }
                }
            });
        }
    }
    catch (e) {

    }
}

function fnGetPatientInvestigationValuesHistory() {
    try {
        //debugger;
        var hdnOrgID = document.getElementById('hdnOrgID').value;
        var VisitID = document.getElementById('hdnVID').value;
        var PatternID = 0;
        var InvID = 0;
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetPatientInvestigationValuesHisiory",
            data: "{ 'patientVisitID': '" + VisitID + "','OrgID': '" + hdnOrgID + "','PatternID': '" + PatternID + "','InvID':'" + InvID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                if (data.d != "[]" && data.d.length > 0) {
                    arrPatientValuesHistory.push(data.d);
                }
            }
        });
    }
    catch (e) {

    }
}


function validatenumberOnly(evt, txtID) {
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    if (!evt.shiftKey && ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 110) ||
            (keyCode == 8) || (keyCode == 9) || (keyCode == 12) ||
            (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) ||
            (keyCode == 109) || (keyCode == 189))) {

        var txtValue = document.getElementById(txtID).value;

        if ((keyCode == 110 || keyCode == 190) && (txtValue.length != 0 && txtValue.indexOf(".") != -1)) {
            return false;
        }

        if ((keyCode == 109 || keyCode == 189) && (txtValue.length != 0 && txtValue.indexOf("-") != -1)) {
            return false;
        }


        return true;
    }
    else {
        return false;
    }
}
function fnLoadInvBulkdata(InvestigationID, orgID, ddlBulkData) {
    try {
        //debugger;
        var guid = '0';
        var patientVisitID = 0;
        var GroupID = 0;
        //var InvestigationID1 = 4089;
        var lstInvPackageMapping = [];
        lstInvPackageMapping.push({
            ID: InvestigationID,
            PackageID: GroupID,
            Type: ""
        });
        var strlstInvPackageMapping = JSON.stringify(lstInvPackageMapping);
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetInvBulkData",
            data: "{'guid':'" + guid + "','InvestigationID':'" + InvestigationID + "', 'patientVisitID': '" + patientVisitID + "','orgID': '" + orgID + "','GroupID': '" + GroupID + "','strlstInvPackageMapping':'" + strlstInvPackageMapping + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                if (data.d != "[]" && data.d.length > 0) {
                    var list = data.d;
                    if (list.length > 0) {
                        var list1 = list[0];
                        if (list1.length > 0) {
                            var ddldivupData = document.getElementById(ddlBulkData);
                            $(ddldivupData).empty();
                            deptListItem = document.createElement("option");
                            ddldivupData.options.add(deptListItem);
                            deptListItem.text = "Select";
                            deptListItem.value = "Select";
                            var list1length= list1.length;
                            for (l = 0; l < list1length; l++) {
                                deptListItem = document.createElement("option");
                                ddldivupData.options.add(deptListItem);
                                deptListItem.text = list1[l].Value;
                                deptListItem.value = list1[l].Value;
                            }
                        }
                    }
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Unable to load");
            }
        });
    }
    catch (e) {

    }
}

function fnChangeDepInvStatus(oTable, InvestigationID, Status, DisplayStatus) {
    try {
        //debugger;
        var matches;
        var matches1;
        var hdnValidationRule = document.getElementById("hdnValidationRule");
        var ValRule = "";
        if (hdnValidationRule.value != "") {
            ValRule = hdnValidationRule.value.split("^");
        }
        var ValRulelength = ValRule.length;
        for (b = 0; b < ValRulelength; b++) {
            var parentInv = ValRule[b].split("=")[1];
            var childInv = ValRule[b].split("=")[0];
            var contains = (ValRule[b].indexOf(InvestigationID) > -1);
            if (contains == true) {
                //matches = ValRule[b].match(/\[(.*?)\]/g);
                fnChangeDepInvStatus1(ValRule, parentInv, oTable, Status, DisplayStatus);
            }
        }
    }
    catch (e) {

    }
}

function fnChangeDepInvStatus1(ValRule, parentInv, oTable, Status, DisplayStatus) {
    //var a = ddlInvId[0];
    //debugger;
    try {
    var parentInvlength = parentInv.length;
    for (var h = 0; h < parentInvlength; h++) {
        var numb1 = parentInv.match(/\[(.*?)\]/g);
            var numb1length =numb1.length;
            for (var g = 0; g < numb1length; g++) {
                var contains = (ValRule[h].indexOf(numb1[g]) > -1);
                if (contains == true) {
                    var numb = ValRule[h].match(/\[(.*?)\]/g);
                    var numblength = numb.length;
                    for (var k = 0; k < numblength; k++) {
                        var childinvid = numb[k].replace(/[\[\]\"']+/g, '');
                        var childID = "rowNum" + childinvid;
                        var childObj = document.getElementById(childID);
                        var childindexes = oTable.fnGetPosition(childObj);
                        childrow = oTable.fnGetData(childindexes);

                        //Update Status
                        oTable.fnUpdate(DisplayStatus, childindexes, 8, false, false);   // 8 - Represents 8th column(DisplayStatus Column) in datatable
                        oTable.fnUpdate(Status, childindexes, 15, false, false);   // 15 - Represents 15th column(Status Column) in datatable
                    }
                }
            }
        }
    }
    catch (e) {
        throw e;
    }
}

function fnCreateGrpStatus(ddlGrpStatusid, full) {
    try {

        //debugger;

        var select = '<select id=' + ddlGrpStatusid + ' onchange = fnChangeGrpStatus(' + full["RootGroupID"] + ');>';
        var hdnLstStatus = $("#hdnLstStatus");
        var LstStatus = JSON.parse(hdnLstStatus.val());
        //+ '<option value="2010">2010</option>' + '<option value="2011">2011</option>' + '<option value="2012">2012</option>' + '</select> ';
        var LstStatuslength = LstStatus.length;
        for (var i = 0; i < LstStatuslength; i++) {
            select = select + '<option value=' + LstStatus[i].StatuswithID + '>' + LstStatus[i].DisplayText + '</option>';
        }
        select = select + '</select> ';

        return select;
    }
    catch (e) {

    }
}
function fnChangeGrpStatus(RootGroupID) {
    try {
        //debugger;
        var RootGroupID = RootGroupID;
        var ddlGrpStatusid = 'ddlGrpStatus_' + RootGroupID;
        var SelectedDisplayStatus = $('#' + ddlGrpStatusid + ' option:selected').text();
        var SelectedStatus = $('#' + ddlGrpStatusid + ' option:selected').val();
        $("#tblInvestigatonResultsCapture > tbody > tr").each(function() {
            var oTable = $("#tblInvestigatonResultsCapture").dataTable();
            var pos = oTable.fnGetPosition(this);
            var rowData = oTable.fnGetData(pos);
            if (rowData["RootGroupID"] == RootGroupID && rowData["InvestigationID"] != 0 && rowData["IsFormulaField"]!="A" ) {
                oTable.fnUpdate(SelectedDisplayStatus, pos, 8, false, false);  // 8 - Represents 8th column(DisplayStatus Column) in datatable
                oTable.fnUpdate(SelectedStatus.split("_")[0], pos, 15, false, false);   // 15 - Represents 15th column(Status Column) in datatable
            }
        });

    }
    catch (e) {

    }
}
function fnSave() {
    try {
        //alert("Ram");
        //debugger;
        if (CheckDCCount()) {
            var lstPatientInvestigation = [];
            var lstInvestigationValues = [];
            var lstTestName = "";
            $('#hdnLstInvestigationValues').val();
            $('#hdnLstPatientInvestigation').val();
            $("#hdnSaveToDispatch").val("1");
            $("#tblInvestigatonResultsCapture > tbody > tr").each(function() {
                //debugger;
                var oTable = $("#tblInvestigatonResultsCapture").dataTable();
                var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                if (rowData["IsFormulaField"] != "A") {
                    if (rowData["InvestigationID"] != 0) {
                        lstPatientInvestigation.push({
                            InvestigationID: rowData["InvestigationID"],
                            //PatientVisitID: PatientVisitID,
                            Status: rowData["Status"],
                            //ReferenceRange: rowData["ReferenceRange"],
                            ReferenceRange: rowData["ReferenceRange"],
                            Reason: rowData["Reason"],
                            MedicalRemarks: rowData["MedicalRemarks"],
                            //OrgID: OrgID,
                            AutoApproveLoginID: rowData["AutoApproveLoginID"],
                            AccessionNumber: rowData["AccessionNumber"],
                            //UID: rowData["ConvReferenceRange"],
                            //LabNo: rowData["ConvReferenceRange"],
                            //LoginID: rowData["ConvReferenceRange"],
                            GroupID: rowData["GroupID"],
                            IsAbnormal: rowData["IsAbnormal"],
                            //RemarksID: rowData["ConvReferenceRange"],
                            GroupName: rowData["GroupName"],
                            ConvReferenceRange: rowData["ConvReferenceRange"],
                            //InvStatusReasonID: rowData["ConvReferenceRange"],
                            IsSensitive: rowData["IsSensitive"],
                            ManualAbnormal: rowData["ManualAbnormal"],
                            CONV_Factor: rowData["CONV_Factor"],
                            CONVFactorDecimalPt: rowData["CONVFactorDecimalPt"]
                        });
                        if (rowData["Value"].toString() != null && rowData["Value"].toString() != "" && rowData["Value"].toString() != "Select") {
                            lstInvestigationValues.push({
                                InvestigationID: rowData["InvestigationID"],
                                Name: rowData["InvestigationName"],
                                //PatientVisitID: PatientVisitID,
                                Value: rowData["Value"],
                                UOMCode: rowData["UOMCode"],
                                //CreatedBy,
                                GroupID: rowData["GroupID"],
                                GroupName: rowData["GroupName"],
                                //Orgid,
                                Status: rowData["Status"],
                                PackageID: rowData["PackageID"],
                                PackageName: rowData["PackageName"],
                                //Dilution,
                                //UID,
                                DeviceID: rowData["DeviceID"],
                                DeviceValue: rowData["DeviceValue"],
                                DeviceActualValue: rowData["DeviceActualValue"],
                                ConvUOMCode: rowData["CONV_UOMCode"],
                                //ConvValue,
                                CONV_Factor: rowData["CONV_Factor"],
                                CONVFactorDecimalPt: rowData["CONVFactorDecimalPt"]

                            });
                        }
                        if (rowData["IsAbnormal"] != "N" && rowData["IsAbnormal"] != null && rowData["IsAbnormal"] != '') {
                            lstTestName += rowData["InvestigationName"] + ":" + rowData["Value"] + "</br>";
                        }
                    }
                }
            });

            if (lstTestName != "") {
                $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
                $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
                if (lstPatientInvestigation.length > 0 && lstInvestigationValues.length > 0) {
                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
                    $find('mpeAttributeLocation').show();
                    document.getElementById('btnSaveConfirm').focus();
                    //document.getElementById('btnSaveConfirm').select();                        
                    return false;
                }
            }

            else {
                $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
                $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
                $find('mpeAttributeLocation').hide();
                return true;
            }

            //                else {
            //                    alert("There was a problem while saving");
            //                    return false;         
            //                }
            //return false;
        }
        else {
            return false;
        }
    }
    catch (e) {
        alert("Unable to Save");
        //fnPhlebHome();
        return false;
    }
}
function CheckSaveAndNext() {
    document.getElementById('hdnSaveandNext').value = 'Y';
    if (!fnSave()) {
        return false;
    }
}

function setAutoComments(sender, eventArgs) {
    var Values = "";
    Values = eventArgs.get_text();
    var TitleValue = sender.get_element();
    var ids = TitleValue.id.split('_');
    if (Values != null && Values != '') {
        document.getElementById('txtdivupFishPatternValue').value += Values.trim();
        document.getElementById('txtdivupFishPatternCode').value = '';
    }
}
function setAutoMedicalRemarks(sender, eventArgs) {
    var Values = "";
    Values = eventArgs.get_text();
    var TitleValue = sender.get_element();
    var ids = TitleValue.id.split('_');
    if (Values != null && Values != '') {
        document.getElementById('txtdivupMedRem').value += Values.trim();
        document.getElementById('txtdivupcode').value = '';
    }
}
function onListPopulated22(sender, eventArgs) {
    var completionList = sender.get_completionList();
    completionList.style.width = '230';
}

$(document).ready(function() {
    //debugger;
    $("#tblInvestigatonResultsCapture > tbody").delegate("tr", "dblclick", function() {
        //$("#tblInvestigatonResultsCapture tbody td").click(function() {
        //$("#tblInvestigatonResultsCapture tbody tr td:eq(2)").click(function() {
        //$('#tblInvestigatonResultsCapture tbody td').click( function () {
        //debugger;
        //$row = $(this).closest('tr');
        //var OrgID = '<%=Session["OrgID"]%>';
        var OrgID = document.getElementById('hdnOrgID').value;
        //var RoleID = '<%=Session["RoleID"]%>';
        var RoleID = document.getElementById('hdnRoleID').value;
        var oTable = $("#tblInvestigatonResultsCapture").dataTable();

        if ($(this).parents("#tblCulturePattern").length == 1) {
            var $row = $(this).parents("#tblCulturePattern").closest('tr');
            // get the position of the current row
            if ($row[0] != undefined) {
                //var aPos = $row[0].rowIndex
                var aPos = oTable.fnGetPosition($row[0]);
                //var aPos = $(this).parents("#tblCulturePattern").closest('tr').rowIndex;
                // get the row data 
                var aData = oTable.fnGetData(aPos);
            }
            else {
                alert("Unable to load Culture Pattern");
                $('#modal').hide();
                return false;
            }
        } else {
            // get the position of the current row
            var aPos = oTable.fnGetPosition(this);

            // get the row data 
            var aData = oTable.fnGetData(aPos);
        }



        var InvestigationID = aData["InvestigationID"];
        var InvestigationName = aData["InvestigationName"];
        var Value = aData["Value"];
        var ReferenceRange = aData["ReferenceRange"];
        var ResultValueType = aData["ResultValueType"];
        var PatternID = aData["PatternID"];
        var Reason = aData["Reason"];
        var MedicalRemarks = aData["MedicalRemarks"];
        var Status = aData["Status"];
        var DisplayStatus = aData["DisplayStatus"];
        var ValidationRule = aData["ValidationRule"];
        var ValidationText = aData["ValidationText"];
        //debugger;
        //Open Modal DialogBox to Edit the Values.
        var hdnEditComputation = document.getElementById("hdnEditComputation").value;
        if ((InvestigationID != null && InvestigationID != 0 && aData["IsFormulaField"] == "N") || (InvestigationID != null && InvestigationID != 0 && aData["IsFormulaField"] == "Y" && hdnEditComputation == "N")) {
            $("#divupPattern1").hide();
            $("#divupPattern2").hide();
            $("#divupPattern3").hide();
            $("#divupFishPattern2").hide();
            $("#divupDefault").hide();
            $('#divReason').hide();
			$('#divRefRange').show();
            $('#divStatus').show();
            //Load Investigation Name And Value
            $("#lbldivupInvName").text(InvestigationName);
            if (PatternID == 1) {
                $("#divupPattern1").show();
                //                if (ResultValueType == 'N') {
                //                    $('#txtdivupInvValue').keydown(function(event) {
                //                        return validatenumberOnly(event, 'txtdivupInvValue');
                //                    });
                //                }
                //                else {
                //                    $('#txtdivupInvValue').unbind("keydown");
                //                }
                if (aData["IsFormulaField"] == "Y") {
                    var id = "cellNum" + InvestigationID;
                    ChangeComputationFieldEditOption(id);
                }
                $("#txtdivupInvValue").val(Value);
                if (aData["HeaderName"] == "Y") {
                    $('#txtdivupInvValue').keyup(function(event) {
                        fnAutoMedComments($(this).val(), aData, oTable, aPos, "Y");
                    });
                }
                else {
                    $('#txtdivupInvValue').unbind("keyup");
                }
            }
            else if (PatternID == 2) {
                $("#divupPattern2").show();
                fnLoadInvBulkdata(InvestigationID, OrgID, "ddldivupPatt2Data");
                if (Value != null && Value != "") {
                    var val = Value.split(",");
                    if ($('#ddldivupPatt2Data option[value=' + val[0] + ']').length > 0) {
                        $("#txtdivupPatt2Value").val(val[1]);
                        $("#ddldivupPatt2Data").val(val[0]);
                    }
                    else {
                        $("#txtdivupPatt2Value").val(val[0]);
                        //$("#ddldivupPatt2Data").val(val[0]);
                    }
                }
            }
            else if (PatternID == 3) {
                $("#divupPattern3").show();
                fnLoadInvBulkdata(InvestigationID, OrgID, "ddldivupPatt3Data");
                //document.getElementById("ddldivupPatt3Data").value = Value;
                //debugger;
                //$("#dldivupPatt3Data option:equals(" + Value + ")").attr('selected', 'selected');
                if (Value != null && Value != "") {
                    $("#ddldivupPatt3Data").val(Value);
                }
                if (aData["HeaderName"] == "Y") {
                    $('#ddldivupPatt3Data').change(function(event) {
                        fnAutoMedComments($(this).val(), aData, oTable, aPos, "Y");
                    });
                }
                else {
                    $('#ddldivupPatt3Data').unbind("keyup");
                }
            }
            else if (PatternID == 48) {
                var ContextKey = InvestigationID + "~" + "0" + "~" + OrgID + "~" + "";
                $find('acedivupFishPatternAutoComments').set_contextKey(ContextKey)
                $('#txtdivupFishPatternCode').val('');
                $("#divupFishPattern2").show();
                $("#txtdivupFishPatternValue").val(Value);
            }
            else if (PatternID == 44) {


                var gUID = document.getElementById('hdnGuid').value;
                var OrgID = document.getElementById('hdnOrgID').value;
                var VisitID = document.getElementById('hdnVID').value;
                var hdnLstPatientInvestigationCulture = document.getElementById('hdnLstPatientInvestigationCulture');
                //var hdnCultureRowPosition = document.getElementById('hdnCultureRowPosition');
                $("#hdnCultureRowPosition").val(aPos);
                var patientinvestigation = [];
                var lstpatientinvestigation = [];
                patientinvestigation.push({
                    InvestigationID: aData["InvestigationID"],
                    InvestigationName: aData["InvestigationName"],
                    GroupID: aData["GroupID"],
                    GroupName: aData["GroupName"],
                    DeptID: aData["DeptID"],
                    DeptName: aData["DeptName"],
                    CONV_UOMID: aData["CONV_UOMID"],
                    UOMCode: aData["UOMCode"],
                    ReferenceRange: aData["ReferenceRange"],
                    AutoApproveLoginID: aData["AutoApproveLoginID"],
                    RefSuffixText: aData["RefSuffixText"],
                    PatternID: aData["PatternID"],
                    PatternName: aData["PatternName"],
                    GroupComment: aData["GroupComment"],
                    ValidationText: aData["ValidationText"],
                    IsAbnormal: aData["IsAbnormal"],
                    InvValidationText: aData["InvValidationText"],
                    Reason: aData["Reason"],
                    MedicalRemarks: aData["MedicalRemarks"],
                    GroupMedicalRemarks: aData["GroupMedicalRemarks"],
                    ResultValueType: aData["ResultValueType"],
                    DecimalPlaces: aData["DecimalPlaces"],
                    PackageID: aData["PackageID"],
                    PackageName: aData["PackageName"],
                    SequenceNo: aData["SequenceNo"],
                    AccessionNumber: aData["AccessionNumber"],
                    Display: aData["Display"],
                    RootGroupID: aData["RootGroupID"],
                    Status: aData["Status"],
                    IsCoAuthorized: aData["IsCoAuthorized"],
                    UserID: aData["UserID"],
                    CONV_UOMID: aData["CONV_UOMID"],
                    CONV_UOMCode: aData["CONV_UOMCode"],
                    CONV_Factor: aData["CONV_Factor"],
                    CONVFactorDecimalPt: aData["CONVFactorDecimalPt"],
                    ConvReferenceRange: aData["ConvReferenceRange"],
                    IsSensitive: aData["IsSensitive"],
                    MethodName: aData["MethodName"],
                    Value: aData["Value"]
                    //                            DeviceID: aData["DeviceID"],
                    //                            //ValidationRule: aData["ValidationRule"],
                    //                            IOMReferenceRange: aData["IOMReferenceRange"],
                    //                            DeviceErrorCode: aData["DeviceErrorCode"],
                    //                            IsFormulaField: aData["IsFormulaField"],
                    //                            DisplayStatus: aData["DisplayStatus"],
                    //                            DeviceValue: aData["DeviceValue"],
                    //                            DeviceActualValue: aData["DeviceActualValue"]
                });
                hdnLstPatientInvestigationCulture.value = JSON.stringify(patientinvestigation);
                //                $.ajax({
                //                    type: "POST",
                //                    url: "InvApproval.aspx/LoadUserControl",
                //                    //data: JSON.stringify({ message: aData }),
                //                    //data: "{lstpatientinvestigation: '" + lstpatientinvestigation + "', gUID :'" + gUID + "'}",
                //                    data: "{lstpatientinvestigation: '" + lstpatientinvestigation + "', gUID :'" + gUID + "',OrgID:'" + OrgID + "',VisitID:'" + VisitID + "'}",
                //                    //data: "{ReferenceRange: '" + xmlContent + "', Value:'" + comVal + "', Gender:'" + pGender + "', Age:'" + age + "'}",
                //                    contentType: "application/json; charset=utf-8",
                //                    dataType: "json",
                //                    success: function Success(data) {
                //                        $('#divCultandSens').html(data.d);
                //                    },
                //                    error: function(xhr, ajaxOptions, thrownError) {
                //                        alert("Unable to load");
                //                    }
                //                });
                //document.getElementById('tdCulturename').innerText = aData["InvestigationName"];
                __doPostBack('lnkShowCulture', '');
            }
            if (PatternID != 44) {
                //Load ReferenceRange
                if (ReferenceRange != null && ReferenceRange != "") {
                    //$("#lbldivupRefRangeItem").text(ReferenceRange.replace("<br>", "\n"));
                    //$("#lbldivupRefRangeItem").html(replaceAll(ReferenceRange, '<br>', '<br/>'));
                    $("#lbldivupRefRangeItem").html(ReferenceRange);
            }
            else {
                $("#lbldivupRefRangeItem").text("-");
            }

            //Load MedicalRemarks
            var ContextKey = InvestigationID + "~" + "INV" + "~" + OrgID + "~" + RoleID;
            $find('acedivupMedRem').set_contextKey(ContextKey)
            if (MedicalRemarks != null) {
                $('#txtdivupMedRem').val(MedicalRemarks);
            }
            else {
                $('#txtdivupMedRem').val("");
            }

            //Load Status
            //$("#ddldivupstatus option").find("[text='" + DisplayStatus + "']").attr('selected', 'selected');
            //$("#ddldivupstatus").val("Approve_1");
            $('#ddldivupstatus option').filter(function() {
                return $.trim($(this).text()) == DisplayStatus;
            }).attr('selected', 'selected');

            $('#divUpdate').dialog({
                autoOpen: false,
                width: 400,
                height: 430,
                modal: true,
                buttons: {
                    "Update": function() {
                        //debugger;
                            var InvValue = "";
                        if (PatternID == 1) {
                            InvValue = $("#txtdivupInvValue").val().trim();
                                //if (ResultValueType == 'N') {
                                if (InvValue != null && InvValue != "" && !isNaN(InvValue)) {
                                    var DecimalPlaces = aData["DecimalPlaces"];
                                    if (DecimalPlaces != null && !isNaN(DecimalPlaces)) {
                                        var decimalPlace = parseInt(DecimalPlaces);
                                        if (decimalPlace > 0) {
                                            if (InvValue.indexOf('<') >= 0) {
                                                InvValue = parseFloat(InvValue.replace('<', '')).toFixed(decimalPlace);
                                                InvValue = '<' + InvValue;
                                            }
                                            else {
                                                InvValue = parseFloat(InvValue).toFixed(decimalPlace);
                                            }
                                        }
                                        else if (decimalPlace == 0) {
                                            if (InvValue.indexOf('<') >= 0) {
                                                //InvValue = parseFloat(InvValue.replace('<', '')).toFixed(decimalPlace);
                                                InvValue = Math.round(parseFloat(InvValue.replace('<', '')));
                                                InvValue = '<' + InvValue;
                                            }
                                            else {
                                                //InvValue = parseFloat(InvValue).toFixed(decimalPlace);
                                                InvValue = Math.round(InvValue).toString();
                                            }
                                        }
                                    }
                                }
                            }
                        else if (PatternID == 2) {
                            //var ddldivupPatt3Data =  $("#ddldivupPatt3Data").value;
                            //var
                            //InvValue = $("#ddldivupPatt3Data").val();
                            ddlValue = $("#ddldivupPatt2Data").val() == "0" ? "0" : $("#ddldivupPatt2Data").val();
                            txtValue = $("#txtdivupPatt2Value").val().trim();
                            if (ddlValue != "0") {
                                InvValue = txtValue == "" ? ddlValue : ddlValue + "," + txtValue;
                            }
                            else {
                                InvValue = txtValue;
                            }
                        }
                        else if (PatternID == 3) {
                            InvValue = $("#ddldivupPatt3Data").val();
                        }
                        else if (PatternID == 48) {
                            InvValue = $("#txtdivupFishPatternValue").val().trim();
                        }
                            if (InvValue != "") {
                        var InvMedicalRemarks = $("#txtdivupMedRem").val().trim();
                        var InvStatus = $("#ddldivupstatus").val().split('_');
                        var SelectedStatus = $("#ddldivupstatus option:selected").text();

                        var Reason;
                        if (SelectedStatus == "Reject") {
                            Reason = $('#ddldivupReason option:selected').text();
                        }
                        else {
                            Reason = "";
                        }


                        //Update Parent Investigation Starts//
                        //Update Value
                        if (Value != InvValue) {
                            //Update IsAbnormal
                            if (aData["IOMReferenceRange"] != null && aData["IOMReferenceRange"] != "") {
                                fnvalidateResultValue(InvValue, aData, oTable, aPos);
                            }
                            else {
                                oTable.fnUpdate(InvValue, aPos, 2, false, false);   // 2 - Represents 2nd Column (Value Column) in Datatable 
                            }
                        }

                        //Update Medical Comments
                        if (InvMedicalRemarks == "" || InvMedicalRemarks == null) {
                            if (Value != InvValue) {
                                        fnAutoMedComments(InvValue, aData, oTable, aPos, "N");
                            }
                            else {
                                oTable.fnUpdate(InvMedicalRemarks, aPos, 6, false, false);   // 6 - Represents 6th Column (Medical Remarks Column) in Datatable
                            }
                        }
                        else {
                            oTable.fnUpdate(InvMedicalRemarks, aPos, 6, false, false);   // 6 - Represents 6th Column (Medical Remarks Column) in Datatable
                        }

                        //Update Status
                        oTable.fnUpdate(InvStatus[0], aPos, 15, false, false);   // 15 - Represents 15th Column (Status Column) in Datatable
                        oTable.fnUpdate(SelectedStatus, aPos, 8, false, false);  // 8 - Represents 8th Column (DisplayStatus Column) in Datatable

                        //Update Reason
                        if (SelectedStatus == "Reject") {
                            oTable.fnUpdate(Reason, aPos, 5, false, false);  // 5 - Represents 5th Column (Reason Column) in Datatable
                        }
                        //Update Parent Investigation Ends//

                        //Update Computation Investigation Starts
                        if (Value != InvValue && ValidationText != "" && ValidationText != null) {
                            //fnCalculateComputationValue(oTable, true);
                            try {
                                        var id = "cellNum" + InvestigationID;
                                        document.getElementById('hdnDCcheck').value = "false";
                                        s = ' function fnCalculateValue(id) { ' + document.getElementById('hdnValidationText').value + '}';
                                        eval(s);
                                        fnCalculateValue(id);
                                    }
                                    catch (e) {
                                        alert(e)
                                    }
                                    fnUpdateValue(oTable, 'Y',id);
                        }
                        if (ValidationText != "" && ValidationText != null) {
                            fnChangeDepInvStatus(oTable, InvestigationID, InvStatus[0], SelectedStatus);
                        }
                        //Update Computation Investigation Ends

                                if (aData["IsFormulaField"] == "Y") {
                                    var lstEditableFormulaFields = '';
                                    if (document.getElementById('hdnEditableFormulaFields') != null) {
                                        lstEditableFormulaFields = document.getElementById('hdnEditableFormulaFields').value;
                                        if (lstEditableFormulaFields.indexOf(id) >= 0) {
                                            lstEditableFormulaFields = lstEditableFormulaFields.replace(id + "^", "").replace(id, "");
                                            document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                                        }
                                    }
                                }
                                $(this).dialog("close");
                            }
                            else {
                                alert("Value must not be empty");
                            }
                    },
                    "Cancel": function() {
                        $(this).dialog("close");
                    }
                }
            });
            }
            //            $('#divCultandSensHd').dialog({
            //                autoOpen: false,
            //                width: 600,
            //                height: 500,
            //                modal: true,
            //                buttons: {
            //                    "Update": function() {
            //                        //debugger;

            //                        SaveCultureSensitivityV2Details(InvestigationID, "4623~0~0");
            //                        var VisitID = document.getElementById('hdnVID').value;
            //                        $.ajax({
            //                            type: "POST",
            //                            url: "InvApproval.aspx/GetCultSensResult",
            //                            //data: JSON.stringify({ message: aData }),
            //                            //data: "{lstpatientinvestigation: '" + lstpatientinvestigation + "', gUID :'" + gUID + "'}",
            //                            data: "{VisitID:'" + VisitID + "'}",
            //                            //data: "{ReferenceRange: '" + xmlContent + "', Value:'" + comVal + "', Gender:'" + pGender + "', Age:'" + age + "'}",
            //                            contentType: "application/json; charset=utf-8",
            //                            dataType: "json",
            //                            success: function Success(data) {
            //                                $('#divCultandSens').html(data.d);
            //                            },
            //                            error: function(xhr, ajaxOptions, thrownError) {
            //                                alert("Unable to load");
            //                            }
            //                        });


            //                        //                                $(this).dialog("close");
            //                    },
            //                    "Cancel": function() {
            //                        $(this).dialog("close");
            //                    }
            //                }
            //            });
            if (PatternID != 44) {
                $('#divUpdate').dialog("open");
            }
            else {
                //$('#divCultandSensHd').dialog("open");
            }
        }
        else if (InvestigationID != null && InvestigationID != 0 && aData["IsFormulaField"] == "Y") {
            $("#divupPattern1").hide();
            $("#divupPattern2").hide();
            $("#divupPattern3").hide();
            $("#divupFishPattern2").hide();
            $("#divupDefault").hide();
            $('#divReason').hide();
            $('#divRefRange').hide();
            $('#divStatus').hide();
            $("#lbldivupInvName").text('');
            //Load MedicalRemarks
            var ContextKey = InvestigationID + "~" + "INV" + "~" + OrgID + "~" + RoleID;
            $find('acedivupMedRem').set_contextKey(ContextKey)
            if (MedicalRemarks != null) {
                $('#txtdivupMedRem').val(MedicalRemarks);
            }
            else {
                $('#txtdivupMedRem').val("");
            }
            $('#divUpdate').dialog({
                autoOpen: false,
                width: 400,
                height: 430,
                modal: true,
                buttons: {
                    "Update": function() {
                        //Update Medical Comments
                        var InvMedicalRemarks = $("#txtdivupMedRem").val().trim();
                        oTable.fnUpdate(InvMedicalRemarks, aPos, 6, false, false);   // 6 - Represents 6th Column (Medical Remarks Column) in Datatable
                        $(this).dialog("close");
                    }
                }
            });
            $('#divUpdate').dialog("open");
        }
    });
});

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
        yourNumber = replaceAll(yourNumber, ',', '');
        yourNumber = replaceAll(yourNumber, 'below', '');
        yourNumber = replaceAll(yourNumber, 'Below', '');
        yourNumber = replaceAll(yourNumber, 'BELOW', '');
        yourNumber = replaceAll(yourNumber, 'above', '');
        yourNumber = replaceAll(yourNumber, 'Above', '');
        yourNumber = replaceAll(yourNumber, 'ABOVE', '');
        //yourNumber = replaceAll(yourNumber, ' ', '');
        return yourNumber;
    }
    catch (e) {
        return yourNumber;
    }
}

function UpdateCultureValue(InvValue, InvMedicalRemarks, InvStatus, SelectedStatus) {
    //debugger;
    var oTable = $("#tblInvestigatonResultsCapture").dataTable();
    var aPos = parseInt($("#hdnCultureRowPosition").val());
    oTable.fnUpdate(InvStatus, aPos, 15, false, false);   // 15 - Represents 15th Column (Status Column) in Datatable
    oTable.fnUpdate(SelectedStatus, aPos, 8, false, false);  // 8 - Represents 8th Column (DisplayStatus Column) in Datatable
    oTable.fnUpdate(InvMedicalRemarks, aPos, 6, false, false);   // 6 - Represents 6th Column (Medical Remarks Column) in Datatable
    oTable.fnUpdate(InvValue, aPos, 2, false, false);   // 2 - Represents 2nd Column (Value Column) in Datatable
    $('#mpeShowCulture').hide();
    //$find("mpeShowCulture").hide();
}
//            //          $("#tblInvestigatonResultsCapture tbody tr").click(function(e) {

//            //              $('#divUpdate').dialog({
//            //                  autoOpen: false,
//            //                  width: 300,
//            //                  height: 100,
//            //                  modal: true,
//            //                  buttons: {
//            //                      "Update": function() {

//            //                      },
//            //                      "Cancel": function() {
//            //                          $(this).dialog("close");
//            //                      }
//            //                  }
//            //              });
//            //              //simple dialog example here
//            //              $('#divUpdate').dialog("open");
//            //          });
//        });
//        //        /* Add events */
//        //        //var h = jQuery.noConflict();
//        //$('#submit tbody td ').click(function() {
//
// This function will be executed when the user scrolls the page.
$(window).scroll(function(e) {
    // Get the position of the location where the scroller starts.
    var scroller_anchor = $(".scroller_anchor").offset().top;

    // Check if the user has scrolled and the current position is after the scroller's start location and if its not already fixed at the top 
    if ($(this).scrollTop() >= scroller_anchor && $('.scroller').css('position') != 'fixed') {    // Change the CSS of the scroller to hilight it and fix it at the top of the screen.
        $('.scroller').css({
            'background': '#CCC',
            'position': 'fixed',
            'top': '0px',
            'width': '1330px'
        });
        $('.viewtrf').css({
            'position': 'fixed',
            'top': '0px',
            'left': '1200'
        });
        // Changing the height of the scroller anchor to that of scroller so that there is no change in the overall height of the page.
        $('.scroller_anchor').css('height', '50px');
    }
    else if ($(this).scrollTop() < scroller_anchor && $('.scroller').css('position') != 'relative') {    // If the user has scrolled back to the location above the scroller anchor place it back into the content.

        // Change the height of the scroller anchor to 0 and now we will be adding the scroller back to the content.
        $('.scroller_anchor').css('height', '0px');

        // Change the CSS and put it back to its original position.
        $('.scroller').css({
            'background': '#CCC',
            'position': 'relative',
            'width': '1330px'
        });
        $('.viewtrf').css({
            'position': 'relative',
            'left': '0'
        });
    }
});

function fnGetPreviousReport() {
    try {
        var VisitID = document.getElementById('hdnVID').value;
        var OrgID = document.getElementById('hdnOrgID').value;
        var LocationID = 0;

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetPreviousReport",
            contentType: "application/json; charset=utf-8",
            data: "{ 'orgID': '" + OrgID + "','LocationID': '" + LocationID + "','visitID': '" + VisitID + "'}",
            dataType: "json",
            success: fnAjaxGetPreviousReport,
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Error");
                return false;
            }
        });
    }
    catch (e) {

    }
}
function fnAjaxGetPreviousReport(result) {
    try {
        if (result != "[]" && result.d.length > 0) {
            var PDFPath = result.d[0].ReportPath;
            var iframe = document.getElementById("ifPDF");
            var src = 'ReportPdf.aspx?pdf=' + PDFPath;
            iframe.src = src;
            $find("modalPopUp").show();
        }
    }
    catch (e) {

    }
}
function ClosePopUp() {
    $find('modalPopUp').hide();
}
   