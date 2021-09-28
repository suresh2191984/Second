 
var saveSate = false;
function EditDemoGraphic()
{

if($("#drpAction").val()=="1")
{
// var showMsg = false;
 var haschecked=$("#example tr:not(:first)").find("input[class$='ALL']").is(":checked");
 if(!haschecked)
 {
 alert('Please select any one booking for edit');
 return false;
 }
 
 $("#example tr:not(:first)").each(function(i, n) {
        var $row = $(n);
       
        var checked = $row.find("input[class$='ALL']").is(":checked");
       
        if (checked) {

        var wholeData=  $row.find("input[class$='ALL']").attr('id');
       $("#rdoPatientSave").click();
         BindFields(wholeData);
        }
        
         
       

    });
   
  


document.getElementById('trBilling').style.display = 'none';
}
else if($("#drpAction").val()=="2")
{
var hascheckedcan=$("#example tr:not(:first)").find("input[class$='ALL']").is(":checked");
 if(!hascheckedcan)
 {
 alert('Please select any one booking for cancel');
 return false;
 }

 $("#example tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        var checked = $row.find("input[class$='ALL']").is(":checked");
        if (checked) {

       var wholeDataFrt=  $row.find("input[class$='ALL']").attr('id');
       
CancelTask(wholeDataFrt);
        }
         



    });
 
}

}

function AjaxGetFieldDataSucceeded(lstOfData) {

document.getElementById('printDiv').style.display = 'block';
   var Items = lstOfData.d;
   var i = 0;
   $('#example').dataTable({
       "bDestroy": true,
       "bProcessing": true,
       "aaData":lstOfData.d,
       "sZeroRecords": "No records found",
       "sPaginationType": "full_numbers",
       "bSort": false,
       dom: 'Bfrtip',
                            buttons: [
//            {
//                extend: 'copyHtml5',
//                exportOptions: {
//                columns: [1, 2]
//                }
//            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                columns: [1, 2,3,4,5,6,7,8,9,10,11,12]
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: [1, 2,3,4,5,6,7,8,9,10,11,12]
                }
            }
        ],
       "paging": true,
       //            "bPaginate": true,
       "bLengthChange": false,
       "bInfo": false,
        "stateSave": saveSate,
       "bFilter": false,
       
       "aoColumns": [

                   {"sTitle": "S.No", "mData": "Remarks",
                       "mRender": function(data, type, full) {
                       
                           if(type === 'display'){
      i =  i +1;
      if(full.BookingStatus=="Completed" ||full.BookingStatus=="Cancelled"){
      
       data= '<input type="radio" value="rgr" name="Good"  disabled="true" Class="ALL" ID="'+data+'">' + i + '</input>';
      }
      else
      {
                           data= '<input type="radio" value="rgr" name="Good" onclick="IsAlreadyPicked('+full.BookingID+')" Class="ALL" ID="'+data+'">' + i + '</input>';
                           }
    }
                             return data;
                       }
                      
                   },
                          { "sTitle": "Booking No", "mData": "BookingID", "sClass": "center", "sWidth": "10%"
,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="BookingID">' + data + '</label>';
//                              }
                          },
                          { "sTitle": "Patient Name", "mData": "PatientName" 
//                          ,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="PatientName">' + data + '</label>';

                          //    }
                          },
                          { "sTitle": "Age & Sex", "mData": "Age" 
//                          ,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="PatientName">' + data + '</label>';

                          //    }
                          },
                          { "sTitle": "Address", "mData": "CollectionAddress" 
//                          ,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="PatientName">' + data + '</label>';

                          //    }
                          },
                          { "sTitle": "Mobile No", "mData": "PhoneNumber", "sClass": "center", "sWidth": "10%"
//                          ,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="PhoneNumber">' + data + '</label>';
                          //    }
                          },
                           { "sTitle": "Location", "mData": "CollectionAddress2", "sClass": "center", "sWidth": "30%"
//                           ,
//                               "mRender": function(data, type, full) {
//                                   return '<Label  ID="CollectionAddress2">' + data + '</label>';
                            //   }
                           },
                            { "sTitle": "Pincode", "mData": "Pincode", "sClass": "center", "sWidth": "5%"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="Pincode">' + data + '</label>';
                           //     }
                            },
                            { "sTitle": "Test", "mData": "Name"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="BillDescription">' + data + '</label>';
                           //     }
                            },
                            { "sTitle": "Collection Center", "mData": "BillDescription", "sClass": "center", "sWidth": "10%"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="BillDescription">' + data + '</label>';
                            //    }
                            },
                             { "sTitle": "Booking Date & Time", "mData": "CreatedAt", "sClass": "center", "sWidth": "10%",
                                 "mRender": function(data, type, full) {
                                
                                 
         return  formatJsonDateTime(data) ;
    
                                    
                                 }
                             },
                             { "sTitle": "Collection Date & Time", "mData": "CollectionTime", "sClass": "center", "sWidth": "10%",
                                 "mRender": function(data, type, full) {
                                     
         return  formatJsonDateTime(data) ;
    
                                 }
                             },
                              { "sTitle": "Technician", "mData": "UserName", "sClass": "center", "sWidth": "10%"
//                              ,
//                                  "mRender": function(data, type, full) {
//                                      return '<Label Type="Text" ID="UserName">' + data + ' </Label>';
                               //   }
                              }
                              ,
                              { "sTitle": "Status", "mData": "BookingStatus", "sClass": "center", "sWidth": "10%"
                              ,
                                  "mrender": function(data, type, full) 
                                  {
                                      return '<label type="text" id="bookingstatus" placeholder="'+full.CancelRemarks+'">' + data + ' </label>';
                                  }
                              }
                              ,
                               { "sTitle": "SelectAll <input type='checkbox' id='SelectALL'> </input>","sClass": "center", "sWidth": "10%","mData":"SelectALL",sDefaultContent: "",
 
                               "mRender": function(data, type, full)
                             {
                                if(type === 'display'){
     
//                               if(full.BookingStatus!=null)
//                               {
                                data= '<input type="Checkbox" value="tet" name="techni" Class="Tech" ID="'+data+'">'+'</input>';
//                               }
                           
                              
                              
                             
                             }
                             return data;
                             }
                               }
                              




                          ],
                         



   });
        
        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

        $('#ScrollArea').addClass('show');
        selectall();
        rsel();
    }
    function selectall()
    {
    
    $("#SelectALL").click(function(){
    $('.Tech').not(this).prop('checked', this.checked);
});
}
function rsel(){
 $('.Tech').click(function(){
            if($(".Tech").length == $(".Tech:checked").length) {
                $("#SelectALL").prop("checked", true);
            }else {
                $("#SelectALL").prop("checked", false);            
            }
        });
        }
 function uptechclick()
{ 

if($("#drpTech").val()=="0")  
alert("Please select Technician in Advance search");
else
{
$("#example tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        var checked = $row.find("input[class$='Tech']").is(":checked");
        if (checked) {

       var wholeDataFrt=  $row.find("input[class$='ALL']").attr('id');
       
       TechTask(wholeDataFrt);
}
        
     
        });
        }
        }
    
              
//                        $('#DeviceList').show();
//                        $('#tblAnalyzermappingDetails  tbody > tr').remove();
//                        $('#tblAnalyzermappingDetails').show();
                        
//    document.getElementById('printDiv').style.display = 'block';
//    var lsttempdata = lstOfData.d;
//    var tblexample = $("#example tbody")
//    tblexample.empty();
//    var str = "";
//    $.each(lsttempdata, function(key, value) {
//        var sNo, BookingID, PatientName, Age, DOB, PhoneNumber, CollectionTime, CollectionAddress, CollectionAddress2, BookingStatus, UserName, Comments, Priority;
//        var UserID, City, State, Pincode, Stateid, Cityid;
//        BookingID = value.BookingID;
//        PatientName = value.PatientName;
//        Age = value.Age;
//        DOB = formatJsonDate(value.DOB);
//        PhoneNumber = value.PhoneNumber;
//        CollectionTime = formatJsonDateTime(value.CollectionTime);
//        CollectionAddress = value.CollectionAddress;
//        CollectionAddress2 = value.CollectionAddress2;
//        UserName = value.UserName;
//        BookingStatus = value.BookingStatus;
//        Comments = value.Comments;
//        Priority = value.Priority;
//        City = value.City;
//        UserID = value.UserID;
//        State = value.State;
//        Pincode = value.Pincode;
//        Stateid = value.Stateid;
//        Cityid = value.Cityid;
//        sNo = key + 1;

//        spnBookingID = "<span name='BookingID' >" + BookingID + "</span>";
//        spnPatientName = "<span name='PatientName'>" + PatientName + "</span>";
//        spnAge = "<span name='Age'>" + Age + "</span>";
//        spnDOB = "<span name='DOB'>" + DOB + "</span>";
//        spnPhoneNumber = "<span name='PhoneNumber'>" + PhoneNumber + "</span>";
//        spnCollectionTime = "<span name='CollectionTime'>" + CollectionTime + "</span>";
//        spnCollectionAddress = "<span name='CollectionAddress'>" + CollectionAddress + "</span>";
//        spnCollectionAddress2 = "<span name='Location'>" + CollectionAddress2 + "</span>";
//        spnPincode = "<span name='Pincode'>" + Pincode + "</span>";
//        spnUserName = "<span name='UserName'>" + UserName + "</span>";
//        spnBookingStatus = "<span name='BookingStatus'>" + BookingStatus + "</span>";
//        spnComments = "<span name='Comments'>" + Comments + "</span>";
//        spnPriority = "<span name='Priority'>" + Priority + "</span>";

////        spnCity = "<span name='City'>" + City + "</span>";
////        spnUserID = "<span name='UserID'>" + UserID + "</span>";
////        spnState = "<span name='State'>" + State + "</span>";

////        spnStateid = "<span name='Stateid'>" + Stateid + "</span>";
////        spnCityid = "<span name='Cityid'>" + Cityid + "</span>";
////        $("[name=spnCollectionAddress]").wrap(CollectionAddress);
//        var button = "<input type='button' name='Btnedit' value='Edit' class='Editbutton' onclick='editRow(this);'/>";
//        // var button = '<img src="../Images/calendar.gif" width="16" height="16" border="0" alt="Edit" name="Btnedit" value="Edit"  onclick="editRow(this);" />';
//        str = str + "<tr style='border: 1px solid black;'>";
//        //   str = str + "<td>" + sNo + "</td>";
//        str = str + "<td>" + spnBookingID + "</td>";
//        str = str + "<td>" + spnPatientName + "</td>";
//        str = str + "<td>" + spnAge + "</td>";
//        str = str + "<td>" + spnDOB + "</td>";
//        str = str + "<td>" + spnPhoneNumber + "</td>";
//        str = str + "<td><span id='test' css='testing'>" + spnCollectionTime + "</td>";
//        str = str + "<td style='padding:12px;width:120px;'>" + spnCollectionAddress + "</td>";
//        str = str + "<td>" + spnCollectionAddress2 + "</td>";
//        str = str + "<td>" + spnPincode + "</td>";
//        str = str + "<td>" + spnUserName + "</td>";
//        str = str + "<td>" + spnBookingStatus + "</td>";
//        str = str + "<td style='max-width: 70px;text-overflow: ellipsis;white-space: pre-line;overflow: hidden;'>" + spnComments + "</td>";
//        str = str + "<td>" + spnPriority + "</td>";
////        str = str + "<td style='display:none;'>" + spnCity + "</td>";
////        str = str + "<td style='display:none;'>" + spnUserID + "</td>";
////        str = str + "<td style='display:none;'>" + spnState + "</td>";
////        str = str + "<td style='display:none;'>" + spnStateid + "</td>";
////        str = str + "<td style='display:none;'>" + spnCityid + "</td>";
//        str = str + "<td align='center'>" + button + "</td>";
//        str = str + "</tr>";

//    }
//    );
//    $(tblexample).append(str);
//    if (tblexample.length > 0) {
//       
//        $('#example').show();
//        $('#printDiv').show();
//        document.getElementById('hdnWholeXls').value = document.getElementById('example').innerHTML;
//        //        var rowsTotal = $('#example tbody tr').length;
//        //        var rowsShown = 10;
//        //        var numPages = rowsTotal / rowsShown;
//        var a = document.getElementsByClassName("activebtn");
//        if ($(a).attr('rel') != null) {
//            //           
//            //            var currPage = $(a).attr('rel');
//            //            var startItem = currPage * rowsShown;
//            //            var endItem = startItem + rowsShown;

//            //            if (startItem < rowsTotal) {
//            Repagination();
//            //                $('#example tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
//            //                        css('display', 'table-row').animate({ opacity: 1 }, 300);
//        }
//        //            else { Pageination(); }
//        //        }


//        if ($(a).attr('rel') == null) {
//            Pageination();
//        }

//    }


function formatJsonDateTime(jsonDate) {
    var monthNames = [
        "Jan", "Feb", "Mar",
        "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct",
        "Nov", "Dec"
    ];
    var oldDate = new Date(parseInt(jsonDate.slice(6, -2)));
    var month;
    var hours = oldDate.getHours();
    var minutes = oldDate.getMinutes();
    var ampm = hours >= 12 ? 'pm' : 'am';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0' + minutes : minutes;
    hours = hours < 10 ? '0' + hours : hours;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    
//    if ((1 + oldDate.getMonth()) == 12) {
//        month = monthNames[0 + oldDate.getMonth()]
//    }
//    else {
        month = monthNames[0 + oldDate.getMonth()]
//    }
    //var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
    //var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
    var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + strTime);
    return DateTime;
}

function formatJsonDate(jsonDate) {

    //    var dateString = jsonDate.substr(10);
    //    var currentTime = new Date(parseInt(dateString));
    //    var month = currentTime.getMonth() + 1;
    //    var day = currentTime.getDate();
    //    var year = currentTime.getFullYear();
    //    var date = day + "/" + month + "/" + year;
    //    return date;
    var monthNames = [
        "Jan", "Feb", "Mar",
        "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct",
        "Nov", "Dec"
    ];

    var month;
    var oldDate = new Date(parseInt(jsonDate.slice(6, -2)));
//    if ((1 + oldDate.getMonth()) == 12) {
//        month = monthNames[0 + oldDate.getMonth()]
//    }
//    else {
        month = monthNames[0 + oldDate.getMonth()]
//    }

        var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear());

    return DateTime;
}

function editRow(obj) {

    var row = $(obj).parent().parent();

    if ($(obj).val() == "Edit") {
        $(obj).val('Update');
        var Cancelbutton = "<input type='button' name='BtnCancel' value='Cancel' class='btnCancel' onclick='cancelRow(this);' />";
        $(obj).parent().append(Cancelbutton);
        loadEditItems(row);
        
    }
    else {
        Update(row);
    }
}

function Update(row) {

    var UPatientName = $(row).find("[name=gvetxtPatientName]").val();
    var UUserId = $(row).find("[name=gveddluserName]").val();
    var UUser = $(row).find("[name=gveddluserName] option:selected").text();
    var UPhoneNumber = $(row).find("[name=gvetxtPhoneNumber]").val();
    var UCollectionTime = $(row).find("[name=gvetxtCollectionTime]").val();
    var UCollectionAddress = $(row).find("[name=gvetxtCollectionAddress]").val();
    var ULocation = $(row).find("[name=gvetxtLocation]").val();
    var UBookingStatus = $(row).find("[name=gveddlBookingStatus] option:selected").text();
    var UComments = $(row).find("[name=gvetxtComments]").val();
    var UPriority = $(row).find("[name=gveddlPriority] option:selected").text();
    var UPriorityID = $(row).find("[name=gveddlPriority]").val();
    var UBookingId = $(row).find("[name=BookingID]").html();
    var UCityId = document.getElementById('hdnCityID').value;
    $.ajax({
        type: "POST",
        url: "../HCService.asmx/SaveServiceQuotationDetails",
        data: "{BookingId:'" + UBookingId + "',PatientName:'" + UPatientName + "',UserName:'" + UUser + "',UserId:'" + UUserId + "',BookingStatus:'" + UBookingStatus + "',CollectionAddress:'" + UCollectionAddress + "',PhoneNumber:'" + UPhoneNumber + "',Comments:'" + UComments + "',CollectionTime:'" + UCollectionTime + "',Location:'" + ULocation + "',Priority:'" + UPriorityID + "',CityID:'" + UCityId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function(response) {
            alert(response.d);
        }
    });

    function OnSuccess(response) {
        alert('Booking ID : ' + response.d + ' Updated successfully ');

    }
    //cancelRow(row);
    GetData();

}
function changedate() {
    NewCssCal('gvechangetime', 'ddmmyyyy', 'arrow', true, 12);
}
function loadEditItems(row) {
    var spnPatientName = $(row).find("[name=PatientName]");
    $(spnPatientName).css("display", "none");
    var gvetxtPatientName = "<input type='text' class='t-small' name='gvetxtPatientName' value='" + $(spnPatientName).html() + "' />";
    $(spnPatientName).parent().append(gvetxtPatientName);

    var spnPhoneNumber = $(row).find("[name=PhoneNumber]");
    $(spnPhoneNumber).css("display", "none");
    var gvetxtPhoneNumber = "<input type='text' class='t-small' name='gvetxtPhoneNumber' value='" + $(spnPhoneNumber).html() + "' />";
    $(spnPhoneNumber).parent().append(gvetxtPhoneNumber);

    var spnCollectionTime = $(row).find("[name=CollectionTime]");
    $(spnCollectionTime).css("display", "none");
    var gvetxtCollectionTime = "<input type='text' class='dateTimePickerFutureDate' id='gvechangetime' style='width:100px' name='gvetxtCollectionTime'  value='" + $(spnCollectionTime).html() + "'  />"
    +  '<a><img  name="ImgCal" src="../Images/calendar.gif" width="16" height="16" border="0" alt="Pick a date" onclick="changedate();" ></a>'; //onclick="changedate();"

    $(spnCollectionTime).parent().append(gvetxtCollectionTime);

    var spnCollectionAddress = $(row).find("[name=CollectionAddress]");
    $(spnCollectionAddress).css("display", "none");
    var gvetxtCollectionAddress = "<input type='text'  syle='width:20px;' name='gvetxtCollectionAddress' value='" + $(spnCollectionAddress).html() + "' />";
    $(spnCollectionAddress).parent().append(gvetxtCollectionAddress);

    var spnLocation = $(row).find("[name=Location]");
    $(spnLocation).css("display", "none");
    var gvetxtLocation = "<input type='text'  name='gvetxtLocation' id='txtgvLocation' onkeyup='return AutoLocation();' value='" + $(spnLocation).html() + "'/>"; // onkeyup='return PopulateAutoComplete(this, \"hdnCityID\");'
    $(spnLocation).parent().append(gvetxtLocation);

    var spnPincode = $(row).find("[name=Pincode]");
    $(spnPincode).css("display", "none");
    var gvetxtPincode = "<input type='text' class='t-small' name='gvetxtPincode' id='txtgvPincode' value='" + $(spnPincode).html() + "' onkeyup='return Autopincode();' />";
    $(spnPincode).parent().append(gvetxtPincode);

    var spnUserName = $(row).find("[name=UserName]");
    $(spnUserName).css("display", "none");
    var strUser = $("#ddlUser").html();
    var tempUser = strUser.replace('>' + strUser + '</option>', ' selected="selected">' + $(spnUserName).html() + '</option>');
    tempUser = "<select class='s-ddl ddl' type='text' name='gveddluserName'>" + tempUser + '</select>';
    $(spnUserName).parent().append(tempUser);
    $('[name=gveddluserName] option').filter(function() {
        return ($(this).text() == $(spnUserName).html()); //To select Blue
    }).prop('selected', true)


    var spnBookingStatus = $(row).find("[name=BookingStatus]");
    $(spnBookingStatus).css("display", "none");
    var str = $("#ddlStatus").html();
    tempstr = str.replace('>' + spnBookingStatus + '</option>', ' selected="' + $(spnBookingStatus).text() + '">' + $(spnBookingStatus).text() + '</option>');
    var tempstr = "<select class='s-ddl ddl' type='text' name='gveddlBookingStatus'>" + tempstr + '</select>';
    $(spnBookingStatus).parent().append(tempstr);
    $('[name=gveddlBookingStatus] option').filter(function() {
        return ($(this).text() == $(spnBookingStatus).html()); //To select Blue
    }).prop('selected', true)

    var spnComments = $(row).find("[name=Comments]");
    $(spnComments).css("display", "none");
    var gvetxtComments = "<input type='text' class='t-small' name='gvetxtComments' value='" + $(spnComments).html() + "' />";
    $(spnComments).parent().append(gvetxtComments);

    var spnPriority = $(row).find("[name=Priority]");
    $(spnPriority).css("display", "none");
    var strPriority = $("#ddlPriority").html();
    tempstr = strPriority.replace('>' + spnPriority + '</option>', ' selected="selected">' + $(spnPriority).text() + '</option>');
    var tempstr = "<select type='text' class='s-ddl ddl' name='gveddlPriority'>" + tempstr + '</select>';
    $(spnPriority).parent().append(tempstr);
    $('[name=gveddlPriority] option').filter(function() {
        if ($(spnPriority).html() == '1') {
            return ($(this).text() == 'Urgent');
        }
        else if ($(spnPriority).html() == '2') {
            return ($(this).text() == 'Fasting');
        } else {
            return ($(this).text() == 'Normal');
        }

    }).prop('selected', true)

}


function cancelRow(obj) {
    GetData();
//    var row = $(obj).parent().parent();
//    //    var spnuserName = $(row).find("[name=UserName]");
//    showOrHideSpan(row, "PatientName", "block");
//    showOrHideSpan(row, "UserName", "block");
//    showOrHideSpan(row, "BookingStatus", "block");
//    showOrHideSpan(row, "CollectionAddress", "block");
//    showOrHideSpan(row, "PhoneNumber", "block");
//    showOrHideSpan(row, "Comments", "block");
//    showOrHideSpan(row, "CollectionTime", "block");
//    showOrHideSpan(row, "Location", "block");
//    showOrHideSpan(row, "Pincode", "block");
//    showOrHideSpan(row, "Priority", "block");
//    showOrHideSpan(row, "ImgCal", "none");

//    showOrHideSpan(row, "gvetxtPatientName", "none");
//    showOrHideSpan(row, "gveddluserName", "none");
//    showOrHideSpan(row, "gveddlBookingStatus", "none");
//    showOrHideSpan(row, "gvetxtCollectionAddress", "none");
//    showOrHideSpan(row, "gvetxtPhoneNumber", "none");
//    showOrHideSpan(row, "gvetxtComments", "none");
//    showOrHideSpan(row, "gvetxtCollectionTime", "none");
//    showOrHideSpan(row, "gvetxtLocation", "none");
//    showOrHideSpan(row, "gvetxtPincode", "none");
//    showOrHideSpan(row, "gveddlPriority", "none");
//    document.getElementById('hdnCityID').value = '';
//    //if ($(obj).val() == "Cancel") {
//    showOrHideSpan(row, "BtnCancel", "none");
//    var btn = $(row).find("[name=Btnedit]");
//    $(btn).val('Edit');
//    
//    //}
}

function showOrHideSpan(row, spnname, showorhide) {
    $(row).find("[name=" + spnname + "]").css("display", showorhide);
}





function Autopincode() {
    $("#txtgvPincode").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: '../HCService.asmx/GetLocationforHomeCollectionpincode',
                data: "{'pincode': '" + $("#txtgvPincode").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    $("#txtgvLocation").val(data.d[0].LocationName);
                    $("#txtgvLocation").text(data.d[0].LocationName);

                },
                error: function(response) {
                    alert(response.responseText);
                },
                failure: function(response) {
                    alert(response.responseText);
                }
            });
        },
        select: function(e, i) {

            $("#txtgvLocation").val(i.item.val);
            $("#txtgvLocation").text(i.item.val);
        },
        minLength: 1
    });

}

function AutoLocation() {
    monkeyPatchAutocompleteTableApp1();
    $("#txtgvLocation").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: '../HCService.asmx/NewGetLocationforHomeCollection',
                data: "{ 'prefixText': '" + $("#txtgvLocation").val() + "',contextKey:'Y'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    index = 0;
                    var autoCompleteArray = new Array();
                    autoCompleteArray = $.map(data.d, function(item) {
                        return {
                            label: item.locationName,
                            val: item.description

                        };
                    });
                    response(autoCompleteArray);
                }
            });
        },
        select: function(e, i) {

            $("#hdnCityID").val(i.item.val)
            $("#txtgvPincode").val(i.item.val.split('~')[0]);
            $("#txtgvPincode").text(i.item.val.split('~')[0]);
            var len = i.item.label.length;
            len = len + 2;
            $("#txtgvLocation").width(len * 7);
        },
        minLength: 1
    });

}

function monkeyPatchAutocompleteTableApp1() {

    var oldFn = $.ui.autocomplete.prototype._renderItem;
    $.ui.autocomplete.prototype._renderItem = function(ul, item) {

        var re = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + this.term + ")(?![^<>]*>)(?![^&;]+;)", "gi");
        var t = item.label.replace(re, "<span style='font-weight:bold;'>$1</span>");
        //        if (index == 0) {
        //            ul.prepend("<table class='gridView'><tr><td class='gridHeader activeheader'>Location</td><td class='hide'> Value </td></li></td></tr></table>")
        //            index = 1;
        //        }
        return $("<li></li>")
                  .data("item.autocomplete", item)
                       .append("<table class='tableNew'><tr><td>" + item.label + "</td><td class='hide'>" + item.val + "</td></td></a></td></tr></table>")

                  .appendTo(ul);
        //}
    };
}

function BindFields(input)
{
var Inp=[];
var Inp=input.split('~');
document.getElementById('hdnBookingID').value=Inp[0];

document.getElementById('txtPatientName').value =Inp[1];
document.getElementById('ddlSex').value=Inp[2];
document.getElementById('txtDOBNos').value = Inp[3].split(' ')[0];
                document.getElementById('ddlDOBDWMY').value = Inp[3].split(' ')[1];
                document.getElementById('tDOB').value =Inp[4];
                document.getElementById('txtSuburb').value = Inp[6];

                document.getElementById('txtpincode').value = Inp[5];
                document.getElementById('txtstate').value = Inp[8].split(':')[0];
                document.getElementById('hdnStateID').value=Inp[8].split(':')[1];
                 
                
                document.getElementById('txtCity').value=Inp[7].split(':')[0];
                document.getElementById('hdnCityID').value=Inp[7].split(':')[1]
                if(Inp[9]!=0)
                {
                document.getElementById('ddlOrg1').value=Inp[9];
                 
                }
                $('#ddlLocation').val(Inp[10]);
                $('#ddlUser').val(Inp[13]);
                document.getElementById('txtTime').value=Inp[12];
                document.getElementById('txtMobile').value=Inp[14];
                document.getElementById('txtTelephoneNo').value=Inp[15];
                 document.getElementById('txtAddress').value=Inp[11];
                 document.getElementById('txtEmail').value=Inp[18];
                 document.getElementById('txtFeedback').value=Inp[20];
                 $('#ddlUrnType').val(Inp[16]);
                document.getElementById('txtURNo').value =Inp[17];
                 $('#ddSalutation').val(Inp[22]);
                 var Dispatch=[];
               Dispatch=  Inp[19].split(',');
               if(Dispatch.length>0)
               $.each(Dispatch, function (index, value) {
  if(value=="Email")
  {
  document.getElementById('chkDespatchMode_0').checked=true;
  }
  if(value=="Sms")
  {
  document.getElementById('chkDespatchMode_1').checked=true;
  }
  if(value=="Courier")
  {
  document.getElementById('chkDespatchMode_2').checked=true;
  }
  document.getElementById('txtInternalExternalPhysician').value=Inp[21];
  document.getElementById("btnSave").style.display = 'none';
  document.getElementById("BtnUpdateBook").style.display = 'table-row';
  
  
  
});

//                 
}








function UpdateFunc()
{
DispatchChecked();
var BookingList=[];
var BookingID=document.getElementById('hdnBookingID').value;
var PatientName=document.getElementById('txtPatientName').value;
var SEX=document.getElementById('ddlSex').value;
var Age=document.getElementById('txtDOBNos').value + ' '+document.getElementById('ddlDOBDWMY').value;

var DOB =yyyymmdd(document.getElementById('tDOB').value);
var Pincode=document.getElementById('txtpincode').value;
var CollectionAddress2=document.getElementById('txtSuburb').value;
var City=document.getElementById('txtCity').value;
var State=document.getElementById('txtstate').value;
var CityID= document.getElementById('hdnCityID').value;
var StateID;
if( document.getElementById('hdnStateID').value=='')
{
StateID= 0;
}
else
{
 StateID= document.getElementById('hdnStateID').value;
}

var BookingOrgID=document.getElementById('ddlOrg1').value;
var OrgAddressID=$('#ddlLocation').val();
var CollectionAddress=document.getElementById('txtAddress').value;

var COlltime=[];
var AMrPM='';
var time ='';
COlltime=document.getElementById('txtTime').value.split(' ');
if(COlltime.length <=2)
{
AMrPM=COlltime[1].slice(-2);
time=COlltime[1].replace(COlltime[1].slice(-2),'');
}
else
{
AMrPM=COlltime[2];
time=COlltime[1];
}
var CollectionTime= yyyymmdd(COlltime[0].replace(/-/g,'/'))+' ' +time +' '+ AMrPM; 
// document.getElementById('txtTime').value;
var UserID=$('#ddlUser').val();
var PhoneNumber= document.getElementById('txtMobile').value;
                
 var LandLineNumber=document.getElementById('txtTelephoneNo').value;
var EMail=document.getElementById('txtEmail').value;
var DispatchValue=document.getElementById('hdnDispatch').value;
var URNTypeID= $('#ddlUrnType').val();
 var URNO=document.getElementById('txtURNo').value;
var Comments=document.getElementById('txtFeedback').value;
var TokenID="U";

var RefPhysicianName=document.getElementById('txtInternalExternalPhysician').value;

BookingList.push({
BookingID:BookingID,
PatientName:PatientName,
SEX:SEX,
Age:Age,
DOB:DOB,
Pincode:Pincode,
CollectionAddress2:CollectionAddress2,
City: City,
State:State,
CityID:CityID,
StateID: StateID,
BookingOrgID:BookingOrgID,
OrgAddressID:OrgAddressID,
                
CollectionAddress:CollectionAddress,
CollectionTime:CollectionTime,
UserID:UserID,
PhoneNumber: PhoneNumber,
                
LandLineNumber:LandLineNumber,
EMail:EMail,
DispatchValue:DispatchValue,
URNTypeID: URNTypeID,
URNO:URNO,
Comments:Comments,
TokenID:TokenID,
RefPhysicianName:RefPhysicianName


});

 $.ajax({
        type: "POST",
        url: "../HCService.asmx/SaveServiceQuotationDetails",
        data: JSON.stringify({ lstBookings: BookingList }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        error:function (x)
        {
        var d=x;
        },
        failure: function(response) {
            alert(response.d);
            return false;
        }
    });

    function OnSuccess(response) {
        alert('Booking ID : ' + response.d + ' Updated successfully ');
      //  $("#rdoPatientSave").click();
document.getElementById("btnSave").style.display = 'table-row';
  document.getElementById("BtnUpdateBook").style.display = 'none';
  
    }


}


function yyyymmdd(date)
{

var d=new Date(date.split("/").reverse().join("-"));
var dd=d.getDate();
if(dd.toString().length<=1)
{
dd='0'+dd;
}
var mm=d.getMonth()+1;
var mlen=mm.toString().length;
if(mlen<=1)
{
mm='0'+mm;
}
var yy=d.getFullYear();
var newdate=yy+"/"+mm+"/"+dd;
return newdate;
}


function IsAlreadyPicked(BookingID)
{
$.ajax({

                    type: "POST",
                    url: "../HCService.asmx/IsTaskAlreadyExists",

                    data: "{'BookingID': '" + BookingID + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function(data) {
                    if(data.d=='Y')
                    {
                    alert("The task has been picked by the technician already");
                    
                     $("#example tr:not(:first)").each(function(i, n) {
                          var $row = $(n);
        $row.find("input[class$='ALL']").attr("checked",false);
       
        



    });
                    
                    
                    }
                       

                    }


                });


}
function ClearFields()
{
document.getElementById("txtBookNos").value=""
document.getElementById("txtMob").value="";
document.getElementById("txtLoc").value="";
document.getElementById('txtPinCodeBo').value="";
$('#drpStatusBo').val(0);
$('#drpLocAdv').val(-1);
$('#drpOrgAdv').val(-1);


}

function drpCancelTaskDisplay(inp)
{
var s=$("#"+inp).val();
if(s=="2")
{
document.getElementById('drpCancelStatus').style.display="table-row";

}
else
{
document.getElementById('drpCancelStatus').style.display="none";
}
}

function CancelTask(input)
{
var BookingListData=[];
var data=input.split('~');
var BookingID=data[0];

var CancelRemarks=$("#drpCancelStatus option:selected").text();
var BookingStatus='C';
var TokenID='C';
BookingListData.push({
BookingID:BookingID,
Comments:CancelRemarks,
BookingStatus:BookingStatus,
TokenID:TokenID
});


 $.ajax({
        type: "POST",
        url: "../HCService.asmx/SaveServiceQuotationDetails",
        data: JSON.stringify({ lstBookings: BookingListData }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        error:function (x)
        {
        var d=x;
        },
        failure: function(response) {
            alert(response.d);
            return false;
        }
    });

    function OnSuccess(response) {
        alert('Booking ID : ' + response.d + ' Cancel successfully ');
        saveSate=true;
        $("#btnSaveBook").click();
        document.getElementById('drpCancelStatus').style.display="none";
        $('#drpAction').val('1');
        
        return false;

    }
    

}
function TechTask(input)
{
var BookingListData=[];
var data=input.split('~');
var BookingID=data[0];

var Techid=$('#drpTech').val();
var TokenID='S';
BookingListData.push({
BookingID:BookingID,

UserID:Techid,
TokenID:TokenID
});


 $.ajax({
        type: "POST",
        url: "../HCService.asmx/SaveServiceQuotationDetails",
        data: JSON.stringify({ lstBookings: BookingListData }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        error:function (x)
        {
        
        var d=x;
        },
        failure: function(response) {
            alert(response.d);
            return false;
        }
    });

    function OnSuccess(response) {
        
        saveSate=true;
        $("#btnSaveBook").click();
       
        
        return false;

    }
}