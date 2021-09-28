/* author: Einstien Castro Stephen */
       
       var ssPopupStatus = 0; // set value

       function SmartPatientSearch(ele) {
           $(ele).toggle();
           ssloading(); // loading
           setTimeout(function() { // then show popup, deley in .5 second
               ssloadPopup(); // function show popup
           }, 500); // .5 second
           return false;
       }

       function ssloading() {
           $("div.ssloader").show();
       }
       function sscloseloading() {
           $("div.ssloader").fadeOut('normal');
       }

       function ssloadPopup() {
           if (ssPopupStatus == 0) { // if value is 0, show popup
               sscloseloading(); // fadeout loading
               $("#divSmartPatientSearch").fadeIn(0500); // fadein popup div
               $("#divSPSbackgroundPopup").css("opacity", "0.7"); // css opacity, supports IE7, IE8
               $("#divSPSbackgroundPopup").fadeIn(0001);
               ssPopupStatus = 1; // and set value to 1
           }
       }

       function ssdisablePopup() {
           if (ssPopupStatus == 1) { // if value is 1, close popup
               $("#divSmartPatientSearch").fadeOut("normal");
               $("#divSPSbackgroundPopup").fadeOut("normal");
               ssPopupStatus = 0;  // and set value to 0
               $("[id$='aPatientSearch']").toggle();
           }
       }


					function ssOver() {
					    $('span.CRecs_tooltip').show();
					}
					function ssOut() {
					    $('span.CRecs_tooltip').hide();
					}


					function SetSearch(ele) {
					    if ($(ele).attr('id') == 'rbtnPatientNo') {
					        $('#txtSSPatientName').hide();
					        $('#txtSSPatientNo').show();
					        $('#txtSSPatientName').val('');
					        $('#txtSSPatientNo').val('');
					    }
					    else {
					        $('#txtSSPatientNo').hide();
					        $('#txtSSPatientName').show();
					        $('#txtSSPatientName').val('');
					        $('#txtSSPatientNo').val('');
					    }
					}

					function SearchPatientDetails(ele) {
					    if ($('#rbtnPatientNo').attr('checked')) {
					        var patientNo = $.trim($("[id$='txtSSPatientNo']").val());
					        GetSSPatientDetails(1, '', patientNo);
					    }
					    else if ($('#rbtnPatientName').attr('checked')) {
					        var patientName = $.trim($("[id$='txtSSPatientName']").val());
					        GetSSPatientDetails(1, patientName, '');
					    }
					}

					function GetSSPatientDetails(OrgID, PatientName, PatientNo) {
					    try {
					        $.ajax({
					            type: "POST",
					            url: "../WebService.asmx/GetPatientTypeDetails",
					            data: "{'OrgID': " + OrgID + " ,'PatientName': '" + PatientName + "','PatientNo': '" + PatientNo + "'}",
					            contentType: "application/json; charset=utf-8",
					            dataType: "json",
					            success: function Success(data) {
					                var lstPatient = data.d;
					                BindPatientDetails(lstPatient);
					            },
					            error: function(xhr, ajaxOptions, thrownError) {
					                alert(xhr.status);
					            }
					        });
					    }
					    catch (e) {
					        return false;
					    }
					}

					function BindPatientDetails(lstPatient) {
					    $('#tbodyPatientRow').html('');
					    if (lstPatient.length > 0) {
					        if (lstPatient[0].PatientType != 'No Visit') {
					            $('#h3ErrorMsg').hide();
					            var patientRow = '';
					            $.each(lstPatient, function(index, value) {
					                patientRow += "<tr>";
					                if ($('#rbtnPatientName').attr('checked') == 'checked') {
					                    patientRow += "<td onclick='GetPatientDetailsByNo(this)' style='text-decoration:underline;cursor:pointer;'>" + value.PatientNumber + "</td>";
					                }
					                else {
					                    patientRow += "<td>" + value.PatientNumber + "</td>";
					                }
					                patientRow += "<td>" + value.Name + "</td>";
					                patientRow += "<td>" + value.SEX + "</td>";
					                patientRow += "<td>" + JSONDateWithTime(value.DOB) + "</td>";
					                patientRow += "<td>" + value.PatientType + "</td>";
					                patientRow += "<td>" + value.PatientStatus + "</td>";
					                if (value.CompressedName == null) {
					                    patientRow += "<td>" + '-' + "</td>";
					                }
					                else {
					                    patientRow += "<td>" + value.CompressedName + "</td>";
					                }
					                patientRow += "</tr>";
					            });
					            $('#tbodyPatientRow').append(patientRow);
					        }
					        else {
					            $('#h3ErrorMsg').html('No Visit For This Patient');
					            $('#h3ErrorMsg').show();
					        }
					    }
					    else {
					        $('#h3ErrorMsg').html('No Record Found');
					        $('#h3ErrorMsg').show();
					    }
					}

					function GetPatientDetailsByNo(ele) {
					    var patientNo = $(ele).html();
					    if (patientNo != '') {
					        GetSSPatientDetails(1, '', patientNo);
					    }
					}


					// DateTime Method
					function JSONDateWithTime(dateStr) {
					    jsonDate = dateStr;
					    var d = new Date(parseInt(jsonDate.substr(6)));
					    var m, day;
					    m = d.getMonth() + 1;
					    if (m < 10)
					        m = '0' + m
					    if (d.getDate() < 10)
					        day = '0' + d.getDate()
					    else
					        day = d.getDate();
					    var formattedDate = m + "/" + day + "/" + d.getFullYear();
					    var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
					    var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
					    var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
					    formattedDate = formattedDate + " " + formattedTime;
					    return formattedDate;
					}