<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homecollectiontaskscheduler.aspx.cs" Inherits="HomeCollection_homecollectiontaskscheduler" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="~/SampleCollectionPerson/Controls/SPBookingSlot.ascx" TagName="Schd" TagPrefix="SCPBooking" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <!-- <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />-->
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
<%--<script type="text/javascript" src = "http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer ></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    
   
    <script src="https://cdn.datatables.net/s/dt/dt-1.10.10,se-1.1.0/datatables.min.js" type="text/javascript"></script>
    <link href="https://cdn.datatables.net/s/dt/dt-1.10.10,se-1.1.0/datatables.min.css" rel="stylesheet" type="text/css" />
    <script src="https://gyrocode.github.io/jquery-datatables-checkboxes/1.2.11/js/dataTables.checkboxes.min.js" type="text/javascript"></script>
    <link href="https://gyrocode.github.io/jquery-datatables-checkboxes/1.2.11/css/dataTables.checkboxes.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/dataTables.buttons.min.js"></script>
<link href="https://cdn.datatables.net/select/1.3.1/css/select.dataTables.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.datatables.net/colreorder/1.5.3/css/colReorder.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/searchpanes/1.2.2/js/dataTables.searchPanes.min.js"></script> 
--%>   
 <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
    <style>
        .high {
            color: palevioletred;
        }
        .low {
            color: skyblue;
        }
        .lightRed {
  background-color: #f0aaaa !important;
        }
    </style> 

<!--datatable-->
<script type="text/javascript" src = "script/jquery.dataTables.min.js" defer ></script>
<script type="text/javascript" src="script/jquery.min.js"></script>
    
   
    <script src="script/datatables.min.js" type="text/javascript"></script>
    <link href="script/datatables.min.css" rel="stylesheet" type="text/css" />
    <script src="script/dataTables.checkboxes.min.js" type="text/javascript"></script>
    <link href="script/dataTables.checkboxes.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="script/dataTables.buttons.min.js"></script> 
<script type="text/javascript" src="script/jszip.min.js"></script>
<script type="text/javascript" src="script/dataTables.buttons.min.js"></script>
<link href="script/select.dataTables.min.css" rel="stylesheet" type="text/css" />
<link href="script/colReorder.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script type="script/dataTables.searchPanes.min.js"></script> 

<!--datatable-->

 <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/HCCommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    
   <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <link href="js/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="js/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="css/dataTables.checkboxes.css" rel="stylesheet" type="text/css" />
    <script src="js/dataTables.checkboxes.js" type="text/javascript"></script>

     <link href="js/dataTables.checkboxes.min.js.map" />

    <script src="js/dataTables.checkboxes.min.js" type="text/javascript"></script>

    <script src="css/jquery.min.js" type="text/javascript"></script>

 <script type="text/javascript" language="javascript">
     function popupprint() {
         var prtContent = document.getElementById('divPrintarea');
         var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
         //alert(WinPrint);
         WinPrint.document.write(prtContent.innerHTML);
         WinPrint.document.close();
         WinPrint.focus();
         WinPrint.print();
         WinPrint.close();
     }

     function SelectedClient(source, eventArgs) {
         // debugger;
         var Name = eventArgs.get_text();
         var ID = eventArgs.get_value();
         document.getElementById('hdnClientID').value = eventArgs.get_value().split('^')[5];
     }
     function PhysicianSelectedInternal(source, eventArgs) {

         //debugger;
         var PhysicianID;
         var PhysicianName;
         var PhysicianCode;
         var PhysicianType;
         document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
         var PhyType;
         var list = eventArgs.get_value().split('^');
         if (list.length > 0) {
             for (i = 0; i < list.length; i++) {
                 if (list[i] != "") {
                     PhysicianID = list[1];
                     PhysicianName = list[2];
                     PhysicianCode = list[3];
                     PhysicianType = list[0].trim();
                     PhyType = list[4];
                 }
             }
         }
         document.getElementById('hdnReferedPhyID').value = PhysicianID;
         document.getElementById('hdnReferedPhyName').value = PhysicianName;
     }
    </script>
    <script type="text/javascript" language="javascript">
        var accessToken = "";
        function GetData() {
            $(document).ready(function() {


               
                 GetAccessToken();
                $("#dataexample").dataTable().fnDestroy();

                try {
                    //            pCollectionFromDate = '1753-01-01 00:00:00';
                    //            pCollectionToDate = '1753-01-01 00:00:00';
                    //            pFromDate = '1753-01-01 00:00:00';
                    //            pToDate = '1753-01-01 00:00:00';
                    //            CollecOrgID = 202;
                    //            LoginOrgID = 355;
                    //            BookingStatus = '0';
                    //            Task = 'Search';
                    //            Location = '';
                    //            Pincode = '';
                    //            UserID = 0;
                    //            MobileNumber = '';
                    //            TelePhone = '';
                    //            pName = '';
                    //            PageSize = 5;
                    //            currentPageNo = 1;
                    //            BookingNumber = 0;
                    //    $('#dataexample').DataTable().clear().draw();
                    //   var table;
                    //   $('#dataexample').empty();

                    var today = new Date();
                    var dd = today.getDate();
                    var mm = today.getMonth() + 1; //January is 0!
                    var yyyy = today.getFullYear();

                    if (dd < 10) {
                        dd = '0' + dd
                    }

                    if (mm < 10) {
                        mm = '0' + mm
                    }

                    today = yyyy + '/' + mm + '/' + dd;



                    var PatientID = 0;
                    var BFromDate = ""; //'01/06/2015';
                    var BToDate = ""; //'21/06/2015';
                    var OrgID;



                    var UserID = document.getElementById('drpTech').value;

                    var CollecOrgAddrID;
                    var Location;
                    var Pincode;
                    var BookingStatus;
                    var pFromDate;
                    var pToDate;
                    var pCollectionFromDate;
                    var pCollectionToDate;


                    var UserID = document.getElementById('drpTech').value;
                    CollecOrgAddrID = document.getElementById('ddlLocation').value;
                    OrgID = document.getElementById('ddlOrg').value;
//                    if (hdnPinLoc.value == "Y") {
//                        Location = document.getElementById("txtConfigLoc").value;
//                        Pincode = document.getElementById('txtConfpincode').value;
//                    } else {
//                    Location = document.getElementById("txtLoc").value;
//                    Pincode = document.getElementById('txtpincode').value;
                       if (document.getElementById('txtConfigLoc').value != "")
                        Location = document.getElementById('txtConfigLoc').value
                    else
                    Location = document.getElementById("txtLoc").value;
                    if (document.getElementById('txtConfpincode').value != "")
                        Pincode = document.getElementById('txtConfpincode').value 
                    else
                    Pincode = document.getElementById('txtpincode').value;
                    //}
                    BookingStatus = document.getElementById("drpStatusBo").value;
                    pFromDate = document.getElementById('txtFromDateBook').value;
                    pToDate = document.getElementById('txtToDateBook').value;
                    pCollectionFromDate = document.getElementById('txtFromDate').value;
                    pCollectionToDate = document.getElementById('txtToDate').value;
                    var CollecOrgID = OrgID;

                    if ($('#drpCollection').val() == 3) {
                        pCollectionFromDate = document.getElementById('txtFromPeriod').value;
                        pCollectionToDate = document.getElementById('txtToPeriod').value;

                    }
                    else if ($('#drpCollection').val() == 4) {

                        pCollectionFromDate = today + ' 00:00 AM';
                        pCollectionToDate = today + ' 23:59 PM';
                    }
		else if ($('#drpCollection').val() == 0 && $('#drpCollection').text()=="This Week") {
                        pCollectionFromDate = document.getElementById('txtFromDate').value;
                        pCollectionToDate =  document.getElementById('txtToDate').value;

                    }

                    if ($('#drpBooked').val() == 3) {
                        pFromDate = document.getElementById('txtFromPeriodBook').value;
                        pToDate = document.getElementById('txtToPeriodBook').value;
                    }

                    else if ($('#drpBooked').val() == 4) {
                        pFromDate = today + ' 00:00 AM';
                        pToDate = today + ' 23:59 PM';
                    }



                    var LoginOrgID = CollecOrgAddrID;



                    var BookingNumber = document.getElementById("txtBookNos").value;
                    var MobileNumber = document.getElementById("txtMob").value;

                    var Task = "Search";
                    var TelePhone = "";
                    var pName = "";

                    var PageSize = 5;
                    var currentPageNo = 1;

                    if (BookingNumber == "" || BookingNumber == null) {
                        BookingNumber = 0;
                    }
                    var clientID = document.getElementById("hdnClientID").value;
                    if (clientID == "" || clientID == null) {
                        clientID = "0";
                    }
                    var NameClient = pName + "|" + clientID;
                    //  ContextInfo.AdditionalInfo =clientID.ToString();
                    
                    $.ajax({
                        //     @CollectionTime='1753-01-01 00:00:00',@toTime='1753-01-01 00:00:00',@UserID=0,@CollecOrgID=202,@Location=N'',@Pincode=N'',@LoginOrgID=355,@BookedFrom='1753-01-01 00:00:00',@BookedTo='1753-01-01 00:00:00',@Status=N'0',@Task=N'Search',@ContextInfo=@p12,@MobileNumber=N'',@TelePhone=N'',@pName=N'',@pageSize=5,@startRowIndex=1,@BookingNumber=0

                        type: "POST",
                        url: "../HCService.asmx/GetHCBookingDetails",

                        contentType: "application/json; charset=utf-8",
                        data: "{CollecttionFromdate:'" + pCollectionFromDate + "',CollecttionTodate:'" + pCollectionToDate + "',Fromdate:'" + pFromDate + "',Todate:'" + pToDate + "',CollecOrgID:'" + CollecOrgID + "',LoginOrgID:'" + LoginOrgID + "',Status:'" + BookingStatus + "',Task:'" + Task + "',Location:'" + Location + "',Pincode:'" + Pincode + "',UserID:'" + UserID + "',MobileNumber:'" + MobileNumber + "',TelePhone:'" + TelePhone + "',pName:'" + NameClient + "',PageSize:'" + PageSize + "',currentPageNo:'" + currentPageNo + "',BookingNumber:" + BookingNumber + "}",
                        dataType: "json",
                        async: true,
                        paging: true,
                        success: function(data) {
                            var Items = data.d;
                            $('#AddVaccDetails').show();
                            document.getElementById('imgBtnXL').style.display = "block";
                            //    alert(JSON.stringify(Items));
                            var rows_selected = [];
                            //  $('#PTResults').DataTable().ajax.reload();
                            //  $("#example").DataTable().ajax.reload();
                            //   table = $('#example').DataTable();
                            // to reload
                            //  table.ajax.reload();
                            //                        if (data.success) {

                            //                            $('#dataexample').DataTable().ajax.reload();
                            //                        }
                            var i = 0;

                            var table = $('#dataexample').DataTable({

                                'data': data.d,
                                "bLengthChange": false,
                                "bInfo": false,
                                "bFilter": false,
                                 "scrollY": true,
                                "autoWidth": true,
                                "scrollX": true,
                                "pageLength": 6,
                                "destroy": true,
                                "retrieve": true,
                                "autoWidth": false,
                                "select": true,
                                "colReorder": true,
                                "language": {
                                    'searchPanes': {
                                        'emptyPanes': 'There are no panes to display. :/'
                                    }
                                },
                                //                            "aoColumns": [

                                //                   { "sTitle": "S.No" },
                                //                    { "sTitle": "Booking Number" }
                                //                   ],

                                'columnDefs': [
                        {
                            "sWidth": "10px",
                            'targets': [2, 3, 4, 5, 6, 7, 8, 9]
                        },
                           {
                               "sWidth": "5px",
                               'targets': [12, 13, 14, 15, 16]
                           },
                            {
                                "sWidth": "2%", 'targets': 0,
                              //  'searchable': false,
                                'orderable': false,
                                'className': 'dt-body-center',
                                "mRender": function(data, type, full) {
                                    // i = i + 1;
                                    if (full.BookingStatus == 'Assigned' || full.BookingStatus == 'Booked' || full.BookingStatus == 'Canceled' || full.BookingStatus == 'Trip Can-celled') {
                                        data = '<input type="checkbox" name="select_all" Class="Techni" id="' + +full.BookingID + '~' + full.PatientName + '~' + full.Age + '~' + full.CollectionAddress + '~' + full.PhoneNumber + '~' + full.CollectionAddress2 + '~' + full.Name + '~' + full.BillDescription + '~' + full.DOB + '~' + full.Remarks + '~' + full.BookingStatus +  '~' + full.PaymentStatus + '">' + '</input>';
                                    }
                                    else {
                                        data = '<input type="checkbox" name="select_all" Class="Techni" disabled="true" id="' + full + '"/>';
                                    }

                                   

                                    return data;

                                }
                            },
                           {
                               "sWidth": "2%", 'targets': 1,
                              // 'searchable': false,
                               'orderable': false,
                               'className': 'dt-body-center'
                           },
                            { "sWidth": "2%", 'targets': 11,
                                //  'searchable': false,
                                'orderable': false,
                                'className': 'dt-body-center',
                                "mRender": function(data, type, full) {


                                    return formatJsonDateTime(data);


                                }
                            },
                              {
                                  "sWidth": "2%", 'targets': 13,
                                  //    'searchable': false,
                                  'orderable': false,
                                  'className': 'dt-body-center',
                                  "mRender": function(data, type, full) {
                                        
                                    //return formatJsonDateTime(data);
                                    if(formatJsonDateTime(data)!= null){
                                    if(full.BookingStatus == "Completed"){
                                     data = '<a  id="' + full.BookingID + '~' + formatJsonDateTime(data) + '~' + full.ReferenceType + '~' + full.Pincode + '"  style="text-decoration:none" >'+ formatJsonDateTime(data) +'</a>';
                                    }
                                    else{
                                    data = '<a href="#"  id="' + full.BookingID + '~' + formatJsonDateTime(data) + '~' + full.ReferenceType + '~' + full.Pincode + '" onclick="javascript:onClickCollDate(this);" style="text-decoration:underline" >'+ formatJsonDateTime(data) +'</a>';
                                    } 
                                    }
                                    else{
                                     data = '<a href="#" id="' + full.BookingID + '~' + formatJsonDateTime(data) + '~' + full.ReferenceType + '~' + full.Pincode + '" onclick="javascript:onClickCollDate(this);" style="text-decoration:underline" >Schedule</a>';
                                    }
                                    //  return if formatJsonDateTime(data) == '31/Dec/9999 11:59 pm') then '' else formatJsonDateTime(data) endif));
                                return data;

                                  }
                              },
                            {

                                "sWidth": "2px", 'targets': 18,
                                //   'searchable': false,
                                'orderable': false,
                                'className': 'dt-body-center',
                                "mRender": function(data, type, full) {
                                        if (full.PatientNumber != null) {

                                            var PatNum = full.PatientNumber.split('|');
                                            data = PatNum[1];
                                            return data;
                                        }
                                        else {
                                            return data;
                                        }
                                    }
                                },
                            {
                                "sWidth": "2px", 'targets': 19,
                                //   'searchable': false,
                                'orderable': false,
                                //   'className': 'dt-body-center',
                                "mRender": function(data, type, full) {
                                    if (full.BookingStatus == "Completed" || full.BookingStatus == "Cancelled") {

                                        data = '<input id="btnEdit" value="Edit" type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer inline-block" disabled = "disabled" />';
                                    }
                                    else {
                                        data = '<input id="btnEdit" value="Edit" type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer inline-block" onclick="EditVaccination(this,name);"  name="' + full.BookingID + '~' + full.PatientName + '~' + full.Age + '~' + full.CollectionAddress + '~' + full.PhoneNumber + '~' + full.CollectionAddress2 + '~' + full.Name + '~' + full.BillDescription + '~' + full.DOB + '~' + full.Remarks + '~' + full.BookingStatus + '"/>';
                                       
                                    }
                                   
                                    return data;
                                }

                            }

],



                                'columns': [








        { 'data': 'BookingNumber' },
         { 'data': 'BookingID' },
         { 'data': 'PatientName' },
          { 'data': 'Age' },
           { 'data': 'CollectionAddress' },
 { 'data': 'PhoneNumber' },


         { 'data': 'CollectionAddress2' },
          { 'data': 'Pincode' },
           { 'data': 'Name' },
            { 'data': 'CancelRemarks' },
              { 'data': 'BillDescription' },

           { 'data': 'CreatedAt' },
            { 'data': 'NRICNumber' },
          { 'data': 'CollectionTime' },
           { 'data': 'Altmobilenoone' },
           { 'data': 'UserName' },
         { 'data': 'BookingStatus' },
          { 'data': 'Altmobilenotwo' },
          

  { 'data': 'PatientNumber' }
      ],
                                
                              
                                'dom': 'Bfrtip',
                                'buttons': [
                        {
                            'extend': 'copy',
                            'text': 'copy',
                            'className': 'btn btn-primary',
                            'exportOptions': {
                                'columns': 'th:not(:last-child)'
                            }
                        },
                        {
                            'extend': 'csv',
                            'text': 'csv',
                            'className': 'btn btn-warning',
                            'exportOptions': {
                                'columns': 'th:not(:last-child)'
                            }
                        },
                        {
                            'extend': 'excel',
                            'text': 'excel',
                            'className': 'btn btn-danger',
                            'title': 'Scheduler page',
                            'download': 'open',
                            'ovrientation': 'landscape',
                            'exportOptions': {
                               
                                'columns': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                            }
                        },
                        {
                            'extend': 'pdf',
                            'text': 'pdf',
                            'className': 'btn btn-success',
                            'exportOption': {
                                'columns': 'th:not(:last-child)'
                            }
                        },
                        {

                            'extend': 'print',
                            'text': 'print',
                            'className': 'btn btn-btn-info',
                            'exportOptions': {
                                'columns': 'th:not(:last-child)'
                            }
                        }
                    ],

                                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                    // Get row ID
                                    var rowId = data[0];

                                    // If row ID is in the list of selected row IDs
                                    if ($.inArray(rowId, rows_selected) !== -1) {
                                        $(row).find('input[type="checkbox"]').prop('checked', true);
                                        $(row).addClass('selected');
                                    }

   if (aData['PatientNumber'] != null) {
                                        $('td', nRow).css('background-color', '#FFB6C1');
                                    }
                                },
                              
                                'order': [[1, 'desc']]

                            });

                            var $chkbox_all = $('tbody input[type="checkbox"]', $table);
                            var $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table);
                            var chkbox_select_all = $('thead input[name="select_all"]', $table).get(0);

                            // If none of the checkboxes are checked
                            if ($chkbox_checked.length === 0) {
                                chkbox_select_all.checked = false;
                                if ('indeterminate' in chkbox_select_all) {
                                    chkbox_select_all.indeterminate = false;
                                }

                                // If all of the checkboxes are checked
                            } else if ($chkbox_checked.length === $chkbox_all.length) {
                                chkbox_select_all.checked = true;
                                if ('indeterminate' in chkbox_select_all) {
                                    chkbox_select_all.indeterminate = false;
                                }

                                // If some of the checkboxes are checked
                            } else {
                                chkbox_select_all.checked = true;
                                if ('indeterminate' in chkbox_select_all) {
                                    chkbox_select_all.indeterminate = true;
                                }
                            }

                            var $table = table.table().node();

                            $('#dataexample tbody').on('click', 'input[type="checkbox"]', function(e) {
                                var $row = $(this).closest('tr');

                                // Get row data
                                var data = table.row($row).data();

                                // Get row ID
				var rowId;
				if(data==undefined)
                                  rowId =$row.context.id
				else
                                 rowId = data[0];

                                // Determine whether row ID is in the list of selected row IDs 
                                var index = $.inArray(rowId, rows_selected);

                                // If checkbox is checked and row ID is not in list of selected row IDs
                                if (this.checked && index === -1) {
                                    rows_selected.push(rowId);

                                    // Otherwise, if checkbox is not checked and row ID is in list of selected row IDs
                                } else if (!this.checked && index !== -1) {
                                    rows_selected.splice(index, 1);
                                }

                                if (this.checked) {
                                    $row.addClass('selected');
                                } else {
                                    $row.removeClass('selected');
                                }

                                // Update state of "Select all" control
                                //    updateDataTableSelectAllCtrl(table);

                                // Prevent click event from propagating to parent
                                e.stopPropagation();
                            });

                            // Handle click on table cells with checkboxes
                            $('#dataexample').on('click', 'tbody td, thead th:first-child', function(e) {
                                $(this).parent().find('input[type="checkbox"]').trigger('click');
                            });

                            // Handle click on "Select all" control
                            $('thead input[name="select_all"]', table.table().container()).on('click', function(e) {
                                if (this.checked) {
                                    $('tbody input[type="checkbox"]:not(:checked)', table.table().container()).trigger('click');
                                } else {
                                    $('tbody input[type="checkbox"]:checked', table.table().container()).trigger('click');
                                }

                                // Prevent click event from propagating to parent
                                e.stopPropagation();
                            });
			$('#ddlTechni')[0].selectedIndex=0;
                $('#ddlStat')[0].selectedIndex=0;
                        },
                        failure: function(msg) {
                            //alert('error');
                            return false;
                        }

                    });

                    //       });
                }
                catch (e) {
                    alert("Error");
                }
            });
        }
//            function EditVaccination(obj, ele) {

//                if ($("#dataexample")[0].rows.length > 1) {
//                    $('[id$="dataexample"] tbody tr').each(function(i, n) {
//                        var currentRow = $(n);
//                        currentRow.find("input:button[id$='btnEdit']").hide();


//                    });
//                    var TempTable = ele;//.split('~');
//                    alert(JSON.stringify(TempTable));
//                }
        //            }
        function EditVaccination(obj, ele) {

            //   $('#VaccinationMaster_btnVaccAdd').val('Update').show();
            //   $('#VaccinationMaster_btnVaccAdd').text(strUpdate);
            //  $('#VaccinationMaster_btnVaccSave').val('Save').hide();

            if ($("#dataexample")[0].rows.length > 1) {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    currentRow.find("input:button[id$='btnEdit']").hide();


                });
            }
            // assigning to the textbox

            var TempTable = ele.split('~');
            var DataTable = [];
            DataTable.push({

                BookingID: TempTable[0],
                TitleCode: TempTable[36],
                PatientName: TempTable[1],
                Sex: TempTable[11],
                Age: TempTable[12].split(' ')[0],
                ddlDOBDWMY: TempTable[12].split(' ')[1],
                DOB: TempTable[13],
                Loc: TempTable[15],
                Pincode: TempTable[14],
                CollectionAddress: TempTable[3],
                CollectionAddress2: TempTable[20],
                City: TempTable[34],
                State: TempTable[35],
                PhoneNumber: TempTable[23],
                Comments: TempTable[29],
                LandLineNumber: TempTable[24],
                EMail: TempTable[27],
                CollectionTime: TempTable[21],
                UserID: TempTable[22],
                DispatchValue: TempTable[28],
                UrnTypeID: TempTable[25],
                URNO: TempTable[26],
                RefPhysicianName: TempTable[30],
                BookingStatus: TempTable[31],
                ExtRefNo: TempTable[37],
                ClientName: TempTable[38],
				  ddlLoc: TempTable[7]
            });
            EditVaccDetails(DataTable);
        }
            function enable() {
                //   $('#printDiv > tr').remove();
                $('#dataexample > tr').remove();
              //  $('[id$="dataexample"] tbody tr').remove();
            }
    </script>
    <style type="text/css">
   /* .contentdata
    {
        min-height: 380px !important;
    }*/
    .style1
    {
        height: 32px;
    }
    #tbmain textarea
    {
        width: 148px;
        height: 19px;
    }
    #td input, #tdbtnSearch input, #tdbtnUpdate input
    {
        margin: 0 10px;
    }
    #tdChkNewPatient input
    {
        margin: 0 3px 0 0;
    }
    .button
    {
        display: block;
        width: 16px;
        height: 16px;
        background: url('../Images/calendar.gif') top left;
        border: 0;
    }
    .Editbutton
    {
        display: inline;
        width: 16px;
        height: 16px;
        background: url('../Images/edit.png') top left;
        border: 0;
        font-size: 0;
        cursor: pointer;
        margin: 0 5px 0 0;
    }
    .button:hover
    {
        background-position: bottom;
        cursor: pointer;
    }
        .modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 20px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 80%;
}
/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 20px;
  font-weight: bold;
}
.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
    .header
    {
        background-color: #2FBDF1;
        height: 25px!important;
        color: White;
        line-height: 20px;       
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
    }
    .body
    {    
        height:400px;       
        overflow-y:scroll;       
    }
    .footer
    {
        padding: 6px;
    }     
</style>

</head>
<body >
  <form id="form1" runat="server">
        
   
     <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Release"
        CombineScripts="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
            <asp:ServiceReference Path="~/HCService.asmx" />
        </Services>
    </cc1:ToolkitScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
   
      <div class=" " style="height:100%;">
           
                <asp:UpdatePanel ID="pp" runat="server">
                    <ContentTemplate>
                    
                        <table id="tblVaccinationDetails" runat="server" width="100%" class="dataheader3"
                            style="border: none; display: none;">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" runat="server">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblPatient" runat="server" Text="Patient" ></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <asp:DropDownList CssClass="mini ddl" ID="ddSalutation" runat="server" >
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="Td2" runat="server">
                                    <asp:TextBox ID="txtPatientName" runat="server" ToolTip="Enter a Patient Name" TabIndex="1"
                                        onkeyup="javascript:GetPatientSearchList();" onchange="ClearPatientId();" onblur="javascript:ConverttoUpperCase(this.id);"
                                        CssClass="Txtboxsmall" ></asp:TextBox>&nbsp;<img
                                            id="imgMan" src="../Images/starbutton.png" alt="" />
                                </td>
                                <td id="tdBookingNo1" runat="server" style="display: none;">
                                    <asp:Label ID="Label6" runat="server" Text="Booking Number" ></asp:Label>
                                </td>
                                <td id="tdBookingNo2" runat="server" style="display: none;">
                                    <asp:TextBox ID="txtBookingNumber" CssClass="Txtboxsmall" runat="server" MaxLength="250"
                                        TabIndex="5" ></asp:TextBox>
                                </td>
                                <td id="tdsex1" runat="server">
                                    <asp:Label ID="lblSex" runat="server" Text="Gender" AssociatedControlID="ddlSex"
                                        AccessKey="X"></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td id="tdsex2" runat="server">
                                    <asp:DropDownList Width="153px" ID="ddlSex" runat="server" CssClass="ddl" TabIndex="2"
                                        >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" />
                                </td>
                                <td id="tdAge1" runat="server" align="left">
                                    <asp:Label ID="lblAge" runat="server" Text="Age" ></asp:Label>
                                </td>
                                <td id="tdAge2" runat="server" align="left" style="/* display: table-cell; */width: 190px;">
                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onkeyup="setDOBYear(this.id,'HC');"
                                        TabIndex="3" onkeypress="return blockNonNumbers(this, event, true, false);" CssClass="Txtboxsmall"
                                        Width="18%" runat="server" MaxLength="3" Style="text-align: justify"  />
                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" Width="105px"
                                        runat="server" CssClass="ddl" >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td id="tdlblDOB" runat="server" align="left">
                                    <asp:Label ID="lblDOB" runat="server" Text="DOB" AssociatedControlID="tDOB" AccessKey="B"
                                        ></asp:Label>
                                </td>
                                <td id="tdtxtDOB" align="left" runat="server">
                                    <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"
                                        ></asp:Label>
                                    <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server"
                                        >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                    <asp:TextBox CssClass="Txtboxsmall" ID="tDOB" runat="server" ToolTip="dd/MM/yyyy"
                                        onblur="javascript:countQuickAge(this.id);" Width="148px" Style="text-align: justify"
                                        onkeypress="return RestrictInput(event)" ValidationGroup="MKE"  />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="trSaveDate" style="height: 35px;" runat="server">
                                <td id="Td3" nowrap="nowrap" runat="server">
                                    <asp:Label ID="Label1" runat="server" Text="PinCode" nowrap="nowrap" ></asp:Label>
                                </td>
                                <td id="Td4" runat="server">
                                    <asp:TextBox ID="txtPinCodeBo" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        TabIndex="4" ToolTip="Enter Pincode" MaxLength="6" CssClass="Txtboxsmall" onblur="showlocation();ValidatePincodeAndLocation();"
                                        ></asp:TextBox>
                                         <asp:TextBox ID="txtConfPinCodeBo" runat="server" 
                                        TabIndex="4" ToolTip="Enter Pincode" MaxLength="6" CssClass="Txtboxsmall" 
                                        ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <!--  <img src="../Images/starbutton.png" alt="" align="middle" />  -->
                                </td>
                                <td id="td41" runat="server">
                                    <asp:Label ID="Label3" runat="server" Text="Location" ></asp:Label>
                                </td>
                                <td id="td42" runat="server">
                                    <asp:TextBox ID="txtSuburb" runat="server" TabIndex="5" MaxLength="250" CssClass="Txtboxsmall"
                                        onblur="javascript:ValidatePincodeAndLocation();" ></asp:TextBox>
                                          <asp:TextBox ID="txtConfLoc" runat="server" TabIndex="5" MaxLength="250" CssClass="Txtboxsmall" 
                                        ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutocompleteGetLocationforHomeCollection" runat="server"
                                        TargetControlID="txtSuburb" EnableCaching="False" OnClientItemSelected="SelectTab"
                                        CompletionListCssClass="listtwo" CompletionInterval="5" CompletionListItemCssClass="listitemtwo"
                                        CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetLocationforHomeCollection"
                                        ServicePath="~/HCService.asmx" Enabled="True" DelimiterCharacters="">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td id="td43" runat="server">
                                    <asp:Label ID="Label4" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                        AccessKey="y" ></asp:Label>
                                </td>
                                <td id="td52" runat="server" width="14%">
                                    <asp:TextBox ID="textcity" Style="background-color: #F2F2F2" CssClass="Txtboxsmall"
                                        runat="server" MaxLength="250" ></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" />
                                </td>
                                <td id="Td5" nowrap="nowrap" runat="server">
                                    <asp:Label ID="Label5" runat="server" Text="State" nowrap="nowrap" ></asp:Label>
                                </td>
                                <td id="Td6" width="18%" runat="server">
                                    <asp:TextBox ID="textstate" runat="server" CssClass="Txtboxsmall" ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="loc" runat="server">
                                <td id="Td7" runat="server">
                                    <asp:Label ID="lblOrga" runat="server" Text="Organization" ></asp:Label>
                                </td>
                                <td id="Td8" runat="server">
                                    <span>
                                        <asp:DropDownList ID="ddlOrg1" runat="server" TabIndex="6" Width="153px" CssClass="ddlsmall"
                                            onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);">
                                        </asp:DropDownList>
                                        <ajc:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="ddlOrg1"
                                            Category="Org" PromptText="------Select------" ServicePath="~/OPIPBilling.asmx"
                                            ServiceMethod="GetOrganizationsHome" Enabled="True" />
                                    </span>
                                </td>
                                <td id="tdloc1" runat="server" align="left">
                                    <asp:Label ID="lblLocation" runat="server" Text="Collection Centre" ></asp:Label>
                                </td>
                                <td id="tdloc2" runat="server" align="left">
                                    <asp:DropDownList ID="ddlLoc" runat="server" CssClass="ddlsmall" TabIndex="7">
                                    </asp:DropDownList>
                                    <ajc:CascadingDropDown ID="CascadeddlLoc" runat="server" TargetControlID="ddlLoc"
                                        ParentControlID="ddlOrg1" PromptText="------Select------" ServiceMethod="GetLocationName"
                                        ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                        Enabled="True" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td id="tdaddtxt" runat="server" nowrap="nowrap">
                                    <asp:Label ID="Label7" runat="server" nowrap="nowrap" Text="Collection Address" ></asp:Label>
                                </td>
                                <td id="tdtxtAddress" runat="server" >
                                    <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" MaxLength="250"
                                Width="158px" Height="30px" TabIndex="8" placeholder="Maximum of 250 characters  "></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" />
                                </td>
                                 <td id="Td49" runat="server">
                                    <asp:Label ID="lblExtRefN" runat="server" Text="External Ref.No."  ></asp:Label>
                                </td>
                                <td id="Td50" colspan="3" runat="server">
                                    <asp:TextBox ID="txtExtRefNo" runat="server"  TabIndex="18" MaxLength="50" ReadOnly="True" 
                                         ></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="Tr2" style="height: 35px;" runat="server">
                                <td id="tdtime" runat="server" align="left">
                                    <asp:Label ID="Label8" runat="server" Text="Collection Date & Time" ></asp:Label>
                                </td>
                                <td id="tdtimetxt" runat="server">
                                    <asp:TextBox ID="txtTime" runat="server" Width="130px" ToolTip="Collection Date"
                                        TabIndex="9" CssClass="Txtboxsmall" onblur="javascript:IsCollectionDt();"  ></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtTime','ddmmyyyy','arrow',true,12);document.getElementById('txtTime').focus();">
                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" style="vertical-align: middle;"
                                            alt="Pick a date"></a><!--onblur="javascript:timevalidate();"-->
                                   <%-- <img src="../Images/starbutton.png" alt="" />--%><img id="ImgCollDt" src="../Images/starbutton.png" alt="" runat ="server" />
                                </td>
                                <td id="Td9" runat="server">
                                    <asp:Label ID="Label9" runat="server" Text="Technican" ></asp:Label>
                                </td>
                                <td id="td53" runat="server">
                                    <asp:DropDownList ID="ddlUser" runat="server" CssClass="ddlsmall" TabIndex="10" onchange="javascript:ChangeUsers();"
                                       >
                                       <asp:ListItem Text="---Select ALL---" Value=0 Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                   <img id="userImage" src="../Images/starbutton.png" alt="" align="middle" runat="server" />
                                </td>
                                <td id="Td10" width="6%" runat="server">
                                    <asp:Label ID="lblmobi" runat="server" Text="Mobile" ></asp:Label>
                                </td>
                                <td id="Td11" width="17%" runat="server">
                                    <asp:TextBox ID="txtMobile" runat="server" ToolTip="enter a patient mobile number"
                                        TabIndex="11" MaxLength="13" onchange="CheckSMS();" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        CssClass="Txtboxsmall" ></asp:TextBox>
                                    &nbsp;<img id="img1" src="../images/starbutton.png" alt="" />
                                </td>
                                <td id="Td12" nowrap="nowrap" width="6%" runat="server">
                                    <asp:Label ID="label10" runat="server" nowrap="nowrap" Text="Land Line" ></asp:Label>
                                </td>
                                <td id="Td13" width="18%" runat="server">
                                    <asp:TextBox ID="txtTelephoneNo" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        ToolTip="enter a patient telephone number" MaxLength="15" TabIndex="12" CssClass="Txtboxsmall"
                                        ></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td id="Td14" nowrap="nowrap" runat="server">
                                    <asp:Label ID="lblEmail" runat="server" AccessKey="E" AssociatedControlID="txtEmail"
                                        Text="&lt;u&gt;E&lt;/u&gt;-mail" ></asp:Label>
                                </td>
                                <td id="Td15" nowrap="nowrap" runat="server">
                                    <asp:TextBox ID="txtEmail" runat="server" autocomplete="off" TabIndex="13" onchange="CheckEmail();"
                                        onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');" CssClass="small"
                                        ></asp:TextBox> <img id="ImgEmail" src="../Images/starbutton.png" alt="" align="middle" runat="server" />
                                </td>
                                <td id="tdRefDrPart" runat="server">
                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                        Text="Ref Dr." ></asp:Label>
                                </td>
                                <td id="tdRefDrParttxt" runat="server">
                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" TabIndex="14" CssClass="AutoCompletesearchBox Txtboxsmall"
                                        onFocus="return getrefhospid(this.id);"></asp:TextBox> <img id="ImgRefDr" src="../Images/starbutton.png" alt="" runat="server" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" OnClientShown="DocPopulated"
                                        FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="PhysicianSelectedInternal"
                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected"
                                        TargetControlID="txtInternalExternalPhysician" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td id="Td16" runat="server">
                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server"  />
                                </td>
                                <td id="Td17" runat="server">
                                    <asp:DropDownList ID="ddlUrnType" runat="server" TabIndex="15" onChange="javascript:return enableurntxt();"
                                        CssClass="ddlsmall" >
                                    </asp:DropDownList>
                                </td>
                                <td id="Td18" runat="server">
                                    <asp:Label ID="Rs_URN" Text="URN No" runat="server"  />
                                </td>
                                <td id="Td19" runat="server">
                                    <input type="hidden" id="hdnUrn" runat="server" value="0" >
                                        <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" 
                                            CssClass="Txtboxsmall" MaxLength="50" onblur="ConverttoUpperCase(this.id);"></asp:TextBox>
                                    </input>
                                    
                                </td>
                            </tr>
                            <tr id="tdemail" runat="server">
                                <td id="Td20" colspan="1" nowrap="nowrap" runat="server">
                                    <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode" ></asp:Label>
                                </td>
                                <td id="Td21" colspan="1" nowrap="nowrap" runat="server">
                                    <asp:CheckBoxList ID="chkDespatchMode" TabIndex="16" runat="server" onclick="DispatchChecked()"
                                        RepeatDirection="Horizontal" >
                                    </asp:CheckBoxList>
                                </td>
                                <td id="Td22" runat="server">
                                    <asp:Label ID="lblFeedback" runat="server" Text="Comments" ></asp:Label>
                                </td>
                                <td id="Td23"  runat="server">
                                    <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" TabIndex="17" Width="168px"
                                        Height="30px" placeholder="Maximum of 100 characters" MaxLength="200" ></asp:TextBox>
                                </td>
                                  <td id="td44" runat="server" >
                                                    <asp:Label ID="Rs_ClientName1" runat="server" AccessKey="C" AssociatedControlID="txtClientName1"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourcekey="Rs_ClientName1Resource1"></asp:Label>
                                                </td>
                                                <td id="td45" runat="server"  >
                            <%-- <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            TabIndex="23" CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>--%>
                            <%-- <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    style="height: 20px;"     onblur="ClearRate();" onfocus="CheckOrderedItems();" meta:resourcekey="txtClientResource1" ></asp:TextBox>
                                                        <div id="clientwidthauto" ></div>
                                                 <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1" 
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3css"
                                                        CompletionListItemCssClass="wordWheel itemsMaincss"   DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemOver="SelectedTempClient"
                                                        OnClientItemSelected="ClientSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="txtClient" CompletionListElementID="clientwidthauto" >
                                                    </ajc:AutoCompleteExtender>--%>
                            <%--  <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                       style="height: 20px;"   meta:resourcekey="txtClientResource1" ></asp:TextBox>
                                                        <asp:HiddenField ID="hdnClientID" runat="server" />
                                    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                        Enabled="True" OnClientItemOver="SelectedTempClient">
                                                    </ajc:AutoCompleteExtender>--%>
                            <asp:TextBox ID="txtClientName1" runat="server" onBlur="return ClearFields();" Style="height: 20px;" Enabled="false"
                                meta:resourcekey="txtClientName1Resource1" ></asp:TextBox>
                            <asp:HiddenField ID="hdnClientID1" runat="server" />
                            <input type="hidden" runat="server" value="N" id="hdnIsCashClient1" />
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp1" runat="server" CompletionInterval="1"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedClient"
                                ServiceMethod="GetClientName" ServicePath="~/WebService.asmx" TargetControlID="txtClientName1">
                            </cc1:AutoCompleteExtender>
                                                </td>
                                <td id="tdStatus" runat="server">
                                    <asp:Label ID="Label11" runat="server" Text="Status" ></asp:Label>
                                </td>
                                <td id="tdddlStatus" runat="server">
                                    <asp:DropDownList ID="ddlstats" runat="server" CssClass="ddlsmall" onchange ="getddlstats()" >
                                 
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td id="Td24" style='height: 10px;' runat="server">
                                </td>
                            </tr>
                            <tr id="Tr5" runat="server">
                                <td id="Td25" runat="server">
                                </td>
                                <td id="Td26" runat="server">
                                </td>
                                <td id="Td27" runat="server">
                                </td>
                                <td id="Td28" colspan="8" runat="server">
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                        Style="margin-left: 0px" TabIndex="19"  />
                                        <asp:Button ID="update" CssClass="btn" runat="server" OnClientClick="return setVaccValues(this.id);" Text="Update"  />
                                </td>
                            </tr>
                        </table>
                        <div id="divsearch" style="display: none;" runat="server">
                            <table id="Table1" width="100%" cellpadding="0" cellspacing="0" border="0" runat="server" class="defaultfontcolor" style="border: none;">
                                <tr id="Tr6" runat="server">
                                    <td id="Td29" runat="server"> 
                                        <table id="Table2" width="100%" class="dataheader3 maintblBook" runat="server">
                                            <tr id="Tr7" runat="server">
                                                <td id="Td30" runat="server">
                                                    <tr id="Tr8" runat="server">
                                                        <td id="Td31" runat="server">
                                                            <asp:Label ID="lblOrg" runat="server" Text="Organization"></asp:Label>
                                                        </td>
                                                        <td id="Td32" runat="server">
                                                            <span>
                                                                <asp:DropDownList ID="ddlOrg" runat="server" TabIndex="11" Width="150px" normalWidth="150px" onchange ="getddlLoc()"
                                                                    CssClass="ddlsmall" onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);">
                                                                     <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <ajc:CascadingDropDown ID="CasddlOrg" runat="server" TargetControlID="ddlOrg" Category="Org"
                                                                    ServicePath="~/OPIPBilling.asmx" PromptText="------Select------" ServiceMethod="GetOrganizationsHome"
                                                                    Enabled="True" /> <!---->
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </span>
                                                        </td>
                                                        <td id="Td33" runat="server">
                                                            <asp:Label ID="lblCollcenter" runat="server" Text="Collection center"></asp:Label>
                                                        </td>
                                                        <td id="Td34" runat="server">
                                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" TabIndex="12" onchange ="getddlLoc()">
                                                             <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <ajc:CascadingDropDown ID="Casdropddllocation" runat="server" TargetControlID="ddlLocation"
                                                                ParentControlID="ddlOrg"  ServiceMethod="GetLocationName"   PromptText="------Select------"
                                                                ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                                                Enabled="True" />
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td id="Td35" runat="server">
                                                            <asp:Label ID="lblTech" runat="server" Text="Technician"></asp:Label>
                                                        </td>
                                                        <td id="Td36" runat="server">
                                                            <asp:DropDownList ID="drpTech" runat="server" CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        <img id="userImage1" src="../Images/starbutton.png" alt="" align="middle" runat="server" />
                                                        </td>
                                                        <td id="Td37" runat="server">
                                                            <asp:Label ID="lblMob" runat="server" Text="Mobile number"></asp:Label>
                                                        </td>
                                                        <td id="Td38" runat="server">
                                                            <asp:TextBox ID="txtMob" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr9" style="height: 35px;" runat="server">
                                                        <td id="Td39" runat="server">
                                                            <asp:Label ID="lblColl" runat="server" Text="Collection"></asp:Label>
                                                            <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                            <asp:HiddenField ID="hdnBTempFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnBTempTo" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                            <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                            <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                            <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                            <asp:HiddenField runat="server" ID="hdnloginRoleName" />
                                                        </td>
                                                        <td id="Td40" runat="server">
                                                            <asp:DropDownList ID="drpCollection" runat="server" onChange="javascript:return ShowRegDate();"
                                                                CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            <div id="divRegDate" style="display: none" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromDate" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToDate"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="divRegCustomDate" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromPeriod" runat="server"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                  <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriod"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                   <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td id="TdlblBookon" runat="server">
                                                            <asp:Label ID="lblBookon" runat="server" Text="Booked on"></asp:Label>
                                                        </td>
                                                        <td id="TddrpBooked" runat="server">
                                                            <asp:DropDownList ID="drpBooked" runat="server" onChange="javascript:return ShowRegDateBook();"
                                                                CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            <div id="divRegDateBook" style="display: none" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label12" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromDateBook" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label13" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToDateBook"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="divRegCustomDateBook" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label14" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromPeriodBook" runat="server"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcFromBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                 <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFromBook" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label15" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriodBook"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcToBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcToBook" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td id="TdlblStatus" runat="server">
                                                            <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                                                        </td>
                                                        <td id="TddrpStatusBo" runat="server">
                                                            <asp:DropDownList ID="drpStatusBo" runat="server" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td id="Td1lblBookno" runat="server">
                                                            <asp:Label ID="lblBookno" runat="server" Text="Booking No"></asp:Label>
                                                        </td>
                                                        <td id="Td1txtBookNos" runat="server">
                                                            <asp:TextBox ID="txtBookNos" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                            
                                                    <tr id="Tr3lblPincode" runat="server" style="height: 35px;">
                                                     <td id="tdClientPart" runat="server">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClientName"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td id="tdClientParttxt" runat="server" style="height: 35px;">
                                                    <%-- <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            TabIndex="23" CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>--%>
                                                    <%-- <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    style="height: 20px;"     onblur="ClearRate();" onfocus="CheckOrderedItems();" meta:resourcekey="txtClientResource1" ></asp:TextBox>
                                                        <div id="clientwidthauto" ></div>
                                                 <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1" 
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3css"
                                                        CompletionListItemCssClass="wordWheel itemsMaincss"   DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemOver="SelectedTempClient"
                                                        OnClientItemSelected="ClientSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="txtClient" CompletionListElementID="clientwidthauto" >
                                                    </ajc:AutoCompleteExtender>--%>
                                                    <%--  <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                       style="height: 20px;"   meta:resourcekey="txtClientResource1" ></asp:TextBox>
                                   <asp:HiddenField ID="hdnClientID" runat="server" />
                                    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                        Enabled="True" OnClientItemOver="SelectedTempClient">
                                                    </ajc:AutoCompleteExtender>--%>
                                                    <asp:TextBox ID="txtClientName" runat="server" onBlur="return ClearFields();" Style="height: 20px;"
                                                        meta:resourcekey="txtClientNameResource1" CssClass="AutoCompletesearchBox Txtboxsmall"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnClientID" runat="server" />
                                                    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedClient"
                                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtClientName">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                                        <td id="Td1lblPincode" runat="server">
                                                            <asp:Label ID="lblPincode" runat="server" Text="Pincode"></asp:Label>
                                                        </td>
                                                        <td id="Td1txtpincode" runat="server">
                                                            <asp:TextBox ID="txtpincode" runat="server" CssClass="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                             style="height: 20px;"   ToolTip="Enter Pincode" MaxLength="6" onblur="showlocation();ValidatePincodeAndLocation();"></asp:TextBox>
                                                                 <asp:TextBox ID="txtConfpincode" runat="server" CssClass="Txtboxsmall"  
                                                                 style="height: 20px;"  ToolTip="Enter Pincode" MaxLength="6" ></asp:TextBox>
                                                        </td>
                                                        <td id="Td1lblLoc" runat="server">
                                                            <asp:Label ID="lblLoc" runat="server" Text="Location"></asp:Label>
                                                        </td>
                                                        <td id="Td2txtLoc" runat="server" style="height: 35px;">
                                                            <asp:TextBox ID="txtLoc" runat="server" onblur="javascript:ValidatePincodeAndLocation();"
                                                             style="height: 20px;"     CssClass="Txtboxsmall"></asp:TextBox>
                                                              <asp:TextBox ID="txtConfigLoc" runat="server"  
                                                           style="height: 20px;"       CssClass="Txtboxsmall" ></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteHCGetLoc" runat="server" TargetControlID="txtLoc"
                                                                EnableCaching="False" OnClientItemSelected="SelectTab" CompletionListCssClass="listtwo"
                                                                CompletionInterval="5" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                ServiceMethod="GetLocationforHomeCollection" ServicePath="~/HCService.asmx" Enabled="True"
                                                                DelimiterCharacters="">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td id="td2Label2" runat="server">
                                                            <asp:Label ID="Label2" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                                Visible="False" AccessKey="y"></asp:Label>
                                                        </td>
                                                        <td id="td22txtCity" runat="server" width="14%">
                                                            <asp:TextBox ID="txtCity" Style="background-color: #F2F2F2" CssClass="Txtboxsmall"
                                                                Visible="False" runat="server" MaxLength="250"></asp:TextBox>
                                                        </td>
                                                        <td id="Td23lblstate" nowrap="nowrap" runat="server">
                                                            <asp:Label ID="lblstate" runat="server" Text="State" nowrap="nowrap" Visible="False"></asp:Label>
                                                        </td>
                                                        <td id="Td24txtstate" width="18%" runat="server">
                                                            <asp:TextBox ID="txtstate" runat="server" CssClass="Txtboxsmall" Visible="False"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr434" style="height: 35px;" runat="server">
                                                        <td id="Td254" runat="server">
                                                        </td>
                                                        <td id="Td264" runat="server">
                                                        </td>
                                                        <td id="Td274" runat="server">
                                                        </td>
                                                        <td id="Td28btnClearSearch" runat="server">
                                                            <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                                                Style="margin-left: 0px;" TabIndex="18"  />
                                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="GetData();return false;"
                                                             Style="margin-left: 0px;" />
                                                                </td>
                                                            <td id="Td294" runat="server">
                                                            </td>
                                                            <td runat="server">
                                         <asp:ImageButton ID="imgBtnXL" style="display: none;" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                ToolTip="Save As Excel" OnClick="lnkExportXL_Click" TabIndex="13" meta:resourcekey="imgBtnXLResource1" />
                            <asp:LinkButton ID="lnkExportXL" style="display: none;" Text="Export To XL" Font-Underline="True"
                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                OnClick="lnkExportXL_Click" TabIndex="14" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                    </td>
                                                            <td id="Td304" runat="server">
                                                            </td>
                                                           
                                                            <td id="Td324" runat="server">
                                                            </td>
                                                    </tr>
                                                    <tr id="Tr54" runat="server">
                                                        <td id="Td334" runat="server">
                                                        </td>
                                                      
                                                        <td id="Td354" runat="server">
                                                        </td>
                                                        <td id="Td364" runat="server">
                                                        </td>
                                                        <td id="Td374" runat="server">
                                                        </td>
                                                        <td id="Td384" runat="server">
                                                        </td>
                                                        <td id="Td394" runat="server">
                                                        </td>
                                                        <td id="Td404" runat="server">
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                        </table>
                                   </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                            <br />
                            <table id="btnSearchArea" class="dataheader3 w-100p" runat="server" width="100%"
                                style="border: none;">
                                <tr id="Tr75" runat="server" class="w-100p">
                                    <td id="Td445" runat="server">
                                        <asp:Label ID="lblTechni" runat="server" Text="Technician"></asp:Label>
                                    </td>
                                    <td id="Td455" runat="server">
                                        <asp:DropDownList ID="ddlTechni" runat="server" CssClass="ddlsmall">
                                           
                                        </asp:DropDownList>
                                    </td>
                                    <td id="Td465" runat="server">
                                        <asp:Label ID="lblStat" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td id="Td475" runat="server">
                                        <asp:DropDownList ID="ddlStat" runat="server" CssClass="ddlsmall">
                                          
                                        </asp:DropDownList>
                                    </td>
                                    <td id="Td485" runat="server">
                                        <asp:Button ID="btnApply" CssClass="btn" runat="server" Text="Apply" OnClientClick="return uptechApplyclick(this.id);" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                       
      
  <div id="divPrintarea" runat="server" style="overflow: auto; height: auto;" visible="False">
                    <asp:GridView ID="grdResult" runat="server" CssClass="gridView w-95p" EmptyDataText="Collection Details Not Available"
                        AutoGenerateColumns="False" Width="100%" meta:resourcekey="grdResultResource1">
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                            PageButtonCount="5" PreviousPageText="" />
                                                                        <Columns>
                                                                         <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                            <asp:BoundField Visible="False" DataField="BookingID" 
                                                                                HeaderText="HomeCollectionDetailsID" meta:resourcekey="BoundFieldResource18"
                                                                                />
                                                                            <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" 
                                                                                meta:resourcekey="BoundFieldResource19" />
                                                                         
                                                                            <asp:BoundField DataField="BookingID" HeaderText="Booking Number" 
                                                                                meta:resourcekey="BoundFieldResource20"  />
                                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" 
                                                                                Visible="False" meta:resourcekey="BoundFieldResource21" />
                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                                                meta:resourcekey="BoundFieldResource22"  />
                                                                            <asp:BoundField DataField="Age" HeaderText="Age/Gender" 
                                                                                meta:resourcekey="BoundFieldResource23" />
                                                                            <asp:BoundField DataField="DOB" HeaderText="DOB" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource24"  />
                                                                              <asp:BoundField DataField="CollectionAddress" HeaderText="Address" 
                                                                                meta:resourcekey="BoundFieldResource25" />
                                                                            <asp:BoundField DataField="PhoneNumber" HeaderText="Mobile No" 
                                                                                meta:resourcekey="BoundFieldResource26" />
                                                                               <asp:BoundField DataField="CollectionAddress2" HeaderText="Location" 
                                                                                meta:resourcekey="BoundFieldResource27" />
                                                                                  <asp:BoundField DataField="Pincode" HeaderText="Pincode" 
                                                                                meta:resourcekey="BoundFieldResource28"  />
                                                                                     <asp:BoundField DataField="Name" HeaderText="Test" 
                                                                                meta:resourcekey="BoundFieldResource29"  />
                                                                                 <asp:BoundField DataField="cancelRemarks" HeaderText="ClientName" 
                                                                                 meta:resourcekey="BoundFieldResource47"
                                                                                 />
                                                                                        <asp:BoundField DataField="BillDescription" 
                                                                                HeaderText="Collection Center" meta:resourcekey="BoundFieldResource30"  />
                                                                                           <asp:BoundField DataField="CreatedAt" 
                                                                                HeaderText="Booking Date & Time" DataFormatString="{0:dd/MMM/yy hh:mm tt}" 
                                                                                meta:resourcekey="BoundFieldResource31"  />
                                                                               <asp:BoundField DataField="NRICNumber" HeaderText="Scheduled Slot"  />
                                                                            <asp:BoundField DataField="CollectionTime" HeaderText="Collection Date & Time" 
                                                                                DataFormatString="{0:dd/MMM/yy hh:mm tt}" meta:resourcekey="BoundFieldResource32"
                                                                                 />
                                                                            <asp:BoundField DataField="SourceType" HeaderText="Source Type" 
                                                                                meta:resourcekey="BoundFieldResource33"  />
                                                                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" 
                                                                                meta:resourcekey="BoundFieldResource35" />
                                                                            <asp:BoundField DataField="UserName" HeaderText="Technician" 
                                                                                meta:resourcekey="BoundFieldResource36"  />
                                                                            <asp:BoundField DataField="BookingStatus" HeaderText="Status" 
                                                                                meta:resourcekey="BoundFieldResource37"  />
                                                                            <asp:BoundField DataField="Altmobilenotwo" HeaderText="External Ref. No." 
                                                                                meta:resourcekey="BoundFieldResource38" />
                                                                                   <asp:BoundField DataField="NRICType" HeaderText="VisitNumber" 
                                                                          meta:resourcekey="BoundFieldResource7" 
                                                                                 />
                                                                            <asp:BoundField DataField="City"  Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource39" />
                                                                            <asp:BoundField DataField="Comments" HeaderText="Comments" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource40"  />
                                                                            <asp:BoundField DataField="Priority" HeaderText="Priority" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource41"  />
                                                                            <asp:BoundField DataField="State" HeaderText="State" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource42"  />
                                                                            <asp:BoundField DataField="Pincode" HeaderText="Pincode" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource43"  />
                                                                            <asp:BoundField DataField="stateid" HeaderText="StateID" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource44"  />
                                                                            <asp:BoundField DataField="CityID" HeaderText="CityID" Visible="False" 
                                                                                meta:resourcekey="BoundFieldResource46"  />
                                                                            <asp:BoundField DataField="BillDescription" HeaderText="BillDescription" 
                                                                                Visible="False" meta:resourcekey="BoundFieldResource6" 
                                                                                 />
                                                                         
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
             
                    </ContentTemplate>
                       <Triggers>
                 <%--  <asp:PostBackTrigger ControlID="btnSearch" />--%>
                       <asp:PostBackTrigger ControlID="imgBtnXL" />
                        <asp:PostBackTrigger ControlID="lnkExportXL" />
                    </Triggers>  
                    </asp:UpdatePanel>
                </div>    
              <div id="ScrollArea" style="width:100%; margin-bottom:10px">
                  <table id="AddVaccDetails" runat="server" style="border: none;display: none;width:100%;">
                                            <tr>
                                            <td>
                 <table id="dataexample" class="w-100p gridView" cellspacing="0" >
 <thead>
      <tr>
         <th class="select-checkbox"><input name="select_all" value="1" type="checkbox" Class="Techni"></th>
       
                                                                <th width="5px;">Booking Number
                                                                   
                                                                </th>
                                                                 
                                                                <th>Patient Name
                                                                 
                                                                </th>
                                                                <th>Age & Sex
                                                                  
                                                                </th>
                                                                <th>Address
                                                                  
                                                                </th>
                                                                <th>Mobile No
                                                                  
                                                                </th>
                                                                <th>Location
                                                                   
                                                                </th>
                                                                <th>PinCode
                                                                 
                                                                </th>
                                                                <th>Test
                                                                  
                                                                </th>
                                                                  <th>Client Name
                                                                  
                                                                </th>
                                                                <th>Collection Center
                                                                  
                                                                </th>
                                <th>
                                    Booking Date & Time
                                </th>
                                <th>
                                   Scheduled Slot
                                                                </th>
                                                                <th>Collection Date & Time
                                                                  
                                                                </th>
                                                                <th>Payment Status
                                                                   
                                                                </th>
                                                                <th>Technician
                                                                  
                                                                </th>
                                                                <th>Status
                                                                   
                                                                </th>
                                                                 <th>External Ref. No.
                                                                  
                                                                </th>
                                                                  <th>VisitNumber
                                                                </th>
                                                                <th>Action
                                                                 
                                                                </th>
       
      </tr>
   </thead>

</table>
</td></tr>
</table>
</div> 
    <div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
   <div class="header">
                            ReSchedule / Booking Slot Selection
                        </div>
                        <div class="body">
                            <SCPBooking:Schd ID="spBooking" runat="server" />
                        </div>
                        <br />
                        <div class="footer" align="center">
                            <input type="button" id="btnCreate" value="Update Booking" onclick="javascript:onConfirmBookingSlot();" />
                            <input type="button" id="btnClose" value="Close" onclick="javascript:onClickClose();" />
                        </div>
  </div>
</div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnLoginID" runat="server" />
      <asp:HiddenField ID="hdnHomeCollDtdID" runat="server" />
                <asp:HiddenField ID="hdnPatientID" runat="server" />
                <asp:HiddenField ID="hdnDOB" runat="server" />
                <asp:HiddenField ID="hdnNewDOB" runat="server" />
                <input id="hdnOrgID" type="hidden" value="0" runat="server" />
                <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
                 <input id="hdnReferedPhyName" type="hidden"  runat="server" />
                <asp:HiddenField ID="hdnPatientName" runat="server" />
                <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
                <asp:HiddenField ID="hdnstatus" runat="server" />
                <asp:HiddenField ID="hdnrdosave" runat="server" />
                <input id="hdnGender" runat="server" value="" type="hidden" />
                <asp:HiddenField ID="hdnrdosearch" runat="server" />
                <asp:HiddenField ID="hdnRoleUser" runat="server" />
                <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" />
                <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
                <%--  <asp:HiddenField ID="hdnorgids1" runat="server" Value="0" />--%>
                <asp:HiddenField ID="hdnlocid" runat="server" Value="0" />
                <asp:HiddenField ID="hdnBookingNumber" runat="server" />
                <asp:HiddenField ID="hdnSelectedBookingID" runat="server" />
                <asp:HiddenField ID="hdncurdatetime" runat="server" />
                <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
                <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
                <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
                <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
                <input type="hidden" runat="server" id="hdnRoundOffType" />
                <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
                <input id="hdnBookingID" runat="server" type="hidden" />
                 <input id="hdnPinLoc" runat="server" type="hidden" value="N" />
                <input id="hdnBookingStatus" value ="" runat="server" type="hidden" />
                <asp:HiddenField ID="hdnMessages" runat="server" />
                <%-- <uc5:footer id="Footer1" runat="server" />--%>
                <asp:HiddenField ID="hdnuserselectedval" Value="0" runat="server" />
                <asp:Button ID="btnNoLog" runat="server" Style="display: none" 
                    meta:resourcekey="btnNoLogResource2"  />
                <asp:HiddenField ID="hdnDoFrmVisit" runat="server" />
                <asp:HiddenField ID="hdnDecimalAgeHC" runat="server" />
                <asp:HiddenField ID="hdnSelectTypeID" runat="server" />
                  <asp:HiddenField ID="hdnHCTechScheduler" runat="server" />
        <asp:HiddenField ID="hdnIsMandatoryEmailandRefDr" runat="server" />
                 <asp:HiddenField ID="hdnIsNonMandatoryCollectionDt" runat="server" />
                <%--Added for Mobile APP--%>
                <input id="hdnStateID" runat="server" type="hidden" />
                <input id="hdnCityID" runat="server" type="hidden" />
                <input id="hdnDispatch" runat="server" type="hidden" />
                <input id="hdnstate" runat="server" type="hidden" />
                <input id="hdnWholeXls" runat="server" type="hidden" value="" />
                <input id="hdnBookedID" runat="server" type="hidden" value="0" />
                <input id="hdnPageID" runat="server" type="hidden" value="0" />
                 <input id="hdnSlottime" runat="server" type="hidden" value="0" />
                    <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientName" type="hidden" value="" runat="server" />
        <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
          <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    function DispatchChecked() {

        var checked_checkboxes = $("[id*=chkDespatchMode] input:checked");
        var message = "";
        checked_checkboxes.each(function() {
            var value = $(this).val();
            var text = $(this).closest("td").find("label").html();
            message += text;
            message += ",";
        });
        document.getElementById('hdnDispatch').value = '';
        document.getElementById('hdnDispatch').value = message;

        return false;
    }
    function SelectTab(source, eventArgs) {

        var location = eventArgs.get_value().split('|')[0];
        var locationdetails = location.split('~');
        document.getElementById('txtpincode').value = locationdetails[0];
        document.getElementById('txtPinCodeBo').value = locationdetails[0];

        document.getElementById('txtCity').value = locationdetails[1];
        document.getElementById('txtstate').value = locationdetails[2];
        //Regarding MobileAPP
        document.getElementById('hdnCityID').value = locationdetails[3];
        document.getElementById('hdnStateID').value = locationdetails[4];
        document.getElementById('hdnstate').value = locationdetails[2]

    }
    function Repagination() {
        //        $("#nav").empty();
        var rowsShown = 10;
        var rowsTotal = $('#dataexample tbody tr').length;
        var numPages = rowsTotal / rowsShown;
        var a = document.getElementsByClassName("activebtn");

        $(this).addClass('activebtn');
        var rowsShown = 10;
        if ($(a).attr('rel') != null) {
            var currPage = $(a).attr('rel');
            //var currPage = 5;
            var startItem = currPage * rowsShown;
            var endItem = startItem + rowsShown;
            $('#dataexample tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
        }
        else { $("#nav").empty(); }
    }

    function Pageination() {
        $("#nav").empty();
        var rowsShown = 10;
        var rowsTotal = $('#dataexample tbody tr').length;
        var numPages = rowsTotal / rowsShown;
        for (i = 0; i < numPages; i++) {
            var pageNum = i + 1;
            $('#nav').append('<a href="#" rel="' + i + '">' + pageNum + '</a> ');
        }
        $('#dataexample tbody tr').hide();
        $('#dataexample tbody tr').slice(0, rowsShown).show();
        $('#nav a:first').addClass('activebtn');
        $('#nav a').bind('click', function() {

            $('#nav a').removeClass('activebtn');
            $(this).addClass('activebtn');
            var currPage = $(this).attr('rel');
            var startItem = currPage * rowsShown;
            var endItem = startItem + rowsShown;
            $('#dataexample tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
        });

    }

    function checkCodes() {
        if (hdnPinLoc.value != "Y")
    {
        var searchText = document.getElementById('txtPinCodeBo').value.toUpperCase().trim();
        searchTable(searchText);
        }
    }
    function clearClick() {
     document.getElementById('txtClientName').value = "";
      document.getElementById('hdnBookingStatus').value = '';
      document.getElementById('txtpincode').value = "";
      document.getElementById('txtLoc').value = "";
      document.getElementById("txtBookNos").value = "";
      document.getElementById("txtMob").value = "";
      document.getElementById("txtConfpincode").value = "";
	document.getElementById("txtConfigLoc").value = "";
$('#drpStatusBo').val(0);
 $('#drpBooked').val(0);
$('#drpCollection').val(0);
document.getElementById("txtFromDateBook").value="";
document.getElementById("txtToDateBook").value="";
document.getElementById("txtFromPeriodBook").value="";
document.getElementById("txtToPeriodBook").value="";
document.getElementById("txtFromDate").value="";
document.getElementById("txtToDate").value="";
document.getElementById("txtFromPeriod").value="";
document.getElementById("txtToPeriod").value="";
document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

	   drpTech.value = 0;
        $('#AddVaccDetails').show();
        $('dataexample').show();
          GetData();
    }

    function searchTable(inputVal) {
        var table = $('#dataexample');
        if (inputVal.length > 0) {
            table.find('tr').each(function(index, row) {
                var allCells = $(row).find('td');
                if (allCells.length > 0) {
                    var found = false;
                    allCells.each(function(index, td) {
                        var regExp = new RegExp(inputVal, 'i');
                        if (regExp.test($(td).text())) {
                            found = true;
                            return false;
                        }
                    });
                    if (found == true) $(row).show(); else $(row).hide();
                }
                //$(row).css('display', 'table-row');
                //Pageination();
            });
        }
        else {
            $('#tfooterdataexample').css('display', 'table-row');
            Pageination();
        }
    }

    function ForFutureDate(CDate) {
        //debugger;
        var MyDate = CDate;
        var sysDate = document.getElementById('hdncurdatetime').value;
        var curDay = parseInt(sysDate.split(' ')[0].split('/')[0]);
        var curMon = parseInt(sysDate.split(' ')[0].split('/')[1]);
        var curYear = parseInt(sysDate.split(' ')[0].split('/')[2]);
        var curhour = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[0]);
        var curminute = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[1]);
        var hour = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[0];
        var minute = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[1];
        var AMPM = MyDate.split(' ')[1].substring(5, 7);
        var campm = sysDate.split(' ')[2];
        minute = parseInt(minute);
        if (AMPM == 'PM') {
            hour = parseInt(hour) + 12;
        }
        if (campm == 'PM' && curhour != 12) {
            curhour = parseInt(curhour) + 12;
        }
        DateOnly = MyDate.split('-');
        var Day = parseInt(DateOnly[0]);
        var Mon = parseInt(DateOnly[1]);
        var Year = parseInt(DateOnly[2]);

        if ((Day < curDay && Mon == curMon && Year == curYear) || (Mon < curMon && Year == curYear) || (Year < curYear)
             || (hour < curhour && Day == curDay && Mon == curMon) || (minute < curminute && hour == curhour && Day == curDay && Mon == curMon)) {
            ValidationWindow("Dont select Collection date and Time as past Date.", "Alert");
            return false;
        }

    }
    
    
</script>
  <script language="javascript" type="text/javascript">
      function CheckEmail() {
          //var elements = document.getElementById('chkDespatchMode');
          if (document.getElementById('txtEmail').value != '') {
              document.getElementById('chkDespatchMode_0').checked = true;
              //elements.cells[0].childNodes[0].checked = true;
          }
          else {
              //elements.cells[0].childNodes[0].checked = false;
              document.getElementById('chkDespatchMode_0').checked = false;

          }

      }
      function enableurntxt() {
          var comp = document.getElementById('ddlUrnType');
          if (comp.value != 0) {
              document.getElementById('txtURNo').disabled = false;
              document.getElementById('txtURNo').style.backgroundColor = "white";
              return false;
          }
          else
              document.getElementById('txtURNo').disabled = true;
          document.getElementById('txtURNo').style.backgroundColor = "#F2F2F2";
      }
        </script>
<script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.table2excel.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>

<script src="../Scripts/HCTable.js" type="text/javascript"></script>
<script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    //////Date Year - week - Custom



    function ShowRegDate() {
        document.getElementById('txtFromDate').value = "";
        document.getElementById('txtToDate').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpCollection').value == "0" && $('#drpCollection :selected').text()=="This Week") {

            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "1") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "2") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';

        }
        if (document.getElementById('drpCollection').value == "3") {
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpCollection').value == "0" && $('#drpCollection :selected').text()!="This Week") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }
        if (document.getElementById('drpCollection').value == "4") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }

        if (document.getElementById('drpCollection').value == "5") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "6") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "7") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
    }




    function ShowRegDateBook() {
        document.getElementById('txtFromDateBook').value = "";
        document.getElementById('txtToDateBook').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpBooked').value == "0"  && $('#drpBooked :selected').text()=="This Week") {

            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "1") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayMonth').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "2") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayYear').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';

        }
        if (document.getElementById('drpBooked').value == "3") {
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpBooked').value == "0"  && $('#drpBooked :selected').text()!="This Week") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }
        if (document.getElementById('drpBooked').value == "4") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }

        if (document.getElementById('drpBooked').value == "5") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastWeekLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "6") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastMonthLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "7") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastYearLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
    }
    function getDateTimeNow() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hour = now.getHours();
        var minute = now.getMinutes();
        var second = now.getSeconds();
        var AMrPM = "";
        if (month.toString().length == 1) {
            var month = '0' + month;
        }
        if (day.toString().length == 1) {
            var day = '0' + day;
        }
        if (hour.toString().length == 1) {
            var hour = '0' + hour;
        }
        if (minute.toString().length == 1) {
            var minute = '0' + minute;
        }
        if (second.toString().length == 1) {
            var second = '0' + second;
        }
        if (hour >= 12) {
            AMrPM = 'PM';
        }
        else {
            AMrPM = 'AM';
        }
        var dateTime = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ' ' + AMrPM;
        return dateTime;
    }
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
     //   debugger;
       // console.log(DateTime);
        if (DateTime == '31/Dec/9999 11:59 pm') { DateTime=null }else {DateTime} 
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
    function monkeyPatchAutocompleteTableApp() {

        var oldFn = $.ui.autocomplete.prototype._renderItem;
        $.ui.autocomplete.prototype._renderItem = function(ul, item) {
            //debugger;

            var re = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + this.term + ")(?![^<>]*>)(?![^&;]+;)", "gi");
            var t = item.label.replace(re, "<span style='font-weight:bold;'>$1</span>");
            if (index == 0) {
                //ul.prepend("<table><tr><td><li style='padding:0;margin:0;'><div class='borderGrey lh25 bold' style='min-width:640px;padding:0;margin:0;background:#f5f5f5;'><div class='borderGreyR w-30p inline-block'>Patient Name</div><div class='borderGreyR w-20p inline-block'>Patient Number</div><div class='borderGreyR w-28p inline-block'>Mobile Number</div><div class='w-20p inline-block'> Age </div></div></li></td></tr></table>")---<td class='w-25p activeheader'>Patient Number</td>
                //ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")
                // ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide w-30p'> Address </td></li></td></tr></table>")
                ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")

                index = 1;
            }
            //return $("<li></li>")
            return $("<tr></tr>")
                  .data("item.autocomplete", item)
            //   .append("<td class='borderGreyR w-30p  table-cell'>" + item.BookingID + "</td><td  class='borderGreyR w-30p table-cell'>" + item.PatientName + "</td><td  class='borderGreyR w-30p table-cell'>" + item.MobileNumber + "</td><td class='w-30p table-cell'>" + item.Age + "</td><td class=' w-30p hide'>" + item.Address + "</td></td></a></td>")
									     .append("<td class='borderGreyR w-12p  table-cell'>" + item.BookingID + "</td><td  class='borderGreyR w-25p table-cell'>" + item.PatientName + "</td><td  class='borderGreyR w-25p table-cell'>" + item.PatientNumber + "</td><td  class='borderGreyR w-30p table-cell'>" + item.MobileNumber + "</td><td class='w-30p table-cell'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")
            //.append("<td class='borderGreyR w-12p  table-cell'>" + item.BookingID + "</td><td class='borderGreyR w-25p table-cell'>" + item.PatientName + "</td><td class='borderGreyR w-25p inline-block'>" + item.PatientNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.MobileNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")----<td  class='borderGreyR w-25p table-cell'>" + item.PatientNumber + "</td>

                  .appendTo(ul);

            //}
        };
    }

    function ClearPatientId() {
        document.getElementById('hdnSelectedPatientID').value = '';
    }
    function changedate() {
        NewCssCal('txtTime', 'ddmmyyyy', 'arrow', true, 12);
    }
    function showlocation() {

        var value = document.getElementById('txtPinCodeBo').value;
        if (value == '' || value == null) {
            var value = document.getElementById('txtpincode').value;

        }

        $.ajax({
            type: "POST",
            url: "../HCService.asmx/GetLocationforHomeCollectionpincode",
            data: '{"pincode": "' + value + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                $.each(data.d, function(key, jsonvalue) {
                  

                    $("#txtpincode").val(jsonvalue.Pincode);
                    $("#txtSuburb").val(jsonvalue.LocationName);
                    $("#txtCity").val(jsonvalue.CityName);
                    $("#txtstate").val(jsonvalue.StateName);
                    $("#hdnStateID").val(jsonvalue.StateID);
                    $("#hdnCityID").val(jsonvalue.CityID);

                    $("#txtLoc").val(jsonvalue.LocationName);

                });

            }


        });

    }
    function ChangeUsers() {
        var UserID = document.getElementById('ddlUser').value;
        //alert(UserID);
        document.getElementById('hdnUserID').value = UserID;
    }
    function IsCollectionDt() {
        if (document.getElementById('hdnIsNonMandatoryCollectionDt').value != 'Y') {
            timevalidate()
        }
    }
            

    function timevalidate() {
        var userid = document.getElementById('ddlUser').value;
        var collectiontime = document.getElementById('txtTime').value;
        var temptime = document.getElementById('hdnSlottime').value;
if (collectiontime != temptime)
{
        $.ajax({

            type: "POST",
            url: "../HCService.asmx/GetHomeCollectionTime",

            // data:{userid:userid,collectiontime:collectiontime},
            // data: "{'userid': '" + userid + "','collectiontime':'"+ collectiontime +"'}",

            data: JSON.stringify({ "userid": userid, "collectiontime": collectiontime }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function(data) {
                $.each(data.d, function(key, jsonvalue) {

                    if (jsonvalue.PatientID > 0) {

                        var colltime = confirm('Already ' + jsonvalue.PatientID + ' patient(s) booked for the same time slot. Are you sure you want to continue?.');
                        if (colltime) {
                            document.getElementById('ddlPriority').focus();
                            return false;
                        }
                        else {

                            document.getElementById('txtTime').focus();
                            return false;
                        }
                    }

                });

            }


        });
        
        }
    }
</script>
<script language="javascript" type="text/javascript">
    function expandDropDownListPage(elementRef) {
        elementRef.style.width = '210px';
    }

    function collapseDropDownList(elementRef) {
        elementRef.style.width = elementRef.normalWidth;

    }
    function getrefhospid(source, eventArgs) {


        var sval = 0;

        var OrgID = document.getElementById('hdnOrgID').value;
        var rec = "0"; //document.getElementById('hdfReferalHospitalID').value;
        var sval = "RPH" + "^" + OrgID + "^" + rec;
        $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);

    }
    function GetPatientSearchList() {
        //debugger;
        var PatientNamesearch = $('#txtPatientName').val();
       // var rdoSearchType = $("#rblSearchType").find(":checked").val();
        var rdoSearchType = "4";
        if (rdoSearchType != "4") {// If value is 4 then Search Type is none.
            monkeyPatchAutocompleteTableApp();
            $('#txtPatientName').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        url: "../HCService.asmx/GetPatientListforBookings",
                        data: "{'prefixText':'" + PatientNamesearch + "','contextKey':'Y','flag':" + rdoSearchType + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        crossDomain: true,
                        success: function(result) {
                             
                            index = 0;
                            var autoCompleteArray = new Array();
                            autoCompleteArray = $.map(result.d, function(item) {

                                var Name = item.split(',')[1].split(':')[1].split('~');
                                return {
                                    label: Name[0],
                                    PatientName: Name[1],
                                    PatientNumber: Name[3],
                                    MobileNumber: Name[5],
                                    DOB: Name[7],
                                    Age: Name[9],
                                    Address: Name[23],
                                    City: Name[27],
                                    TelephoneNo: Name[31],
                                    Sex: Name[11],
                                    EMail: Name[13],
                                    pincode: Name[21],
                                    location: Name[25],
                                    state: Name[17],
                                    CityID: Name[15],
                                    StateID: Name[19],
                                    BookingID: Name[33]
                                };
                            });
                            response(autoCompleteArray);
                        }
                    });
                },
                minlength: 0,
                select: function(event, ui) {
                    $('#txtPatientName').val(ui.item.PatientName);
                    IAmSelected(ui, event);
                    return false;
                }
            });
        }
    }
    </script>
<script language="javascript" type="text/javascript">
    $(window).on('beforeunload', function() {
        $('#preloader').hide();
    });
    </script>
    <script type="text/javascript" language="javascript">
        //   var strUpdate = SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_05") == null ? "Update" : SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_05");
        //   var strModify = SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_06") == null ? "Modify" : SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_06");
        function reformatDateString(s) {
            var b = s.split(/\D/);
            return b.reverse().join('-');
        }

        function getddlstats() {
            var selectedValue = document.getElementById('ddlstats').value;
            var tempstatus = document.getElementById('hdnBookingStatus').value;
            //alert(tempstatus + ', ' + selectedValue);

            if (selectedValue != 'A' && selectedValue != 'C' && selectedValue != 'TC') {
                $('#ddlstats option').prop('selected', function() {
                    return this.defaultSelected;
                });
                ValidationWindow('We can allow only Assigned or Cancelled or Trip Cancelled', 'Information');
            }
            else if (tempstatus == 'TS' || tempstatus == 'RD' || tempstatus == 'IP') {
                $('#ddlstats option').prop('selected', function() {
                    return this.defaultSelected;
                });
                ValidationWindow('Trip Started already', 'Information');
            }
        }

        function getddlLoc() {
        if (ddlOrg.options[ddlLocation.selectedIndex].text == '--Select--' && $('#ddlOrg').val()==null) {
                     ValidationWindow('You have to choose any one Collection Center', 'Information');
                    document.getElementById('ddlOrg').focus();
                    return false;
                    }
                    if (ddllocation.options[ddlLocation.selectedIndex].text == '--Select--' && $('#ddllocation').val() == null) {
                        ValidationWindow('You have to choose any one Collection Center', 'Information');
                        document.getElementById('ddllocation').focus();
                        return false;
                    }
            var selectedValue = document.getElementById('ddlOrg').value;
            
            var tempstatus = document.getElementById('ddllocation').value;
            //alert(tempstatus + ', ' + selectedValue);

            if (selectedValue == 0 || tempstatus ==0) {
                $('#ddlLocation option').prop('selected', function() {
                    return this.defaultSelected;
                });
                ValidationWindow('You have to choose any one Collection Center', 'Information');
            }
           
        }


        function setVaccValues(id) {
            var ButtonName = id;
            var PageContextkey = [];
            var BookingListData = [];
            var OrgID = document.getElementById('hdnOrgID').value;
            var PageID = document.getElementById('hdnPageID').value;
            var RoleID = document.getElementById('hdnRoleId').value;
            DispatchChecked();
            var BookingList = [];
            var BookingID = document.getElementById('hdnBookingID').value;
            var TitleCode = $('#ddSalutation').val();
            var PatientName = document.getElementById('txtPatientName').value;
            var Sex = document.getElementById('ddlSex').value;
            var Age1 = document.getElementById('txtDOBNos').value + ' ' + document.getElementById('ddlDOBDWMY').value;

            var Age = Age1.trim();
            var Pincode = "";
            var CollectionAddress2 = "";
            if (hdnPinLoc.value == "Y") {
                Pincode = document.getElementById('txtConfPinCodeBo').value;
                CollectionAddress2 = document.getElementById('txtConfLoc').value;
            }
            else {
                Pincode = document.getElementById('txtPinCodeBo').value;
                CollectionAddress2 = document.getElementById('txtSuburb').value;
            }
            var City = document.getElementById('textcity').value;
            var State = document.getElementById('textstate').value.trim();
            var CityID;
            if (document.getElementById('hdnCityID').value == '') {
                CityID = 0;
            }
            else {
                CityID = document.getElementById('hdnCityID').value;
            }

            var StateID;
            if (document.getElementById('hdnStateID').value == '') {
                StateID = 0;
            }
            else {
                StateID = document.getElementById('hdnStateID').value;
            }

            var BookingOrgID = document.getElementById('ddlOrg1').value;
            var OrgAddressID = $('#ddlLocation').val();
            var CollectionAddress = document.getElementById('txtAddress').value;
            var CollectionTime = '';

            var COlltime = [];
            var AMrPM = '';
            var time = '';
            COlltime = document.getElementById('txtTime').value.split(' ');
             
            if (document.getElementById('txtTime').value != '') {
            if (COlltime.length <= 2) {
                AMrPM = COlltime[1].slice(-2);
                time = COlltime[1].replace(COlltime[1].slice(-2), '');
            }
            else {
                AMrPM = COlltime[2];
                time = COlltime[1];
            }
            CollectionTime = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time + ' ' + AMrPM;
        }
        else {
            CollectionTime = '9999-12-31 23:59:59';
        }
            var strdate = document.getElementById('tDOB').value;

            var testdate = reformatDateString(strdate);

            var DOB = testdate;

            if ($('#ddlUser').val() == '') {
                var UserID = '';
            }
            else {
                var UserID = $('#ddlUser').val();
            }
            var PhoneNumber = document.getElementById('txtMobile').value;

            var LandLineNumber = document.getElementById('txtTelephoneNo').value;
            var EMail = document.getElementById('txtEmail').value;
            var DispatchValue = document.getElementById('hdnDispatch').value;
            var URNTypeID = $('#ddlUrnType').val();
            var URNO = document.getElementById('txtURNo').value;
            var Comments = document.getElementById('txtFeedback').value;
            var TokenID = "U";

            var RefPhysicianName = document.getElementById('txtInternalExternalPhysician').value;
            //   var BookingStatus = $('#ddlstats').val();
            var BookingStatus = $("#ddlstats :selected").text();
            var ActionType = "hcr";
            switch (BookingStatus) {
                case "A": ActionType = "hca";
                    break;
                case "RS": ActionType = "BR";
                    break;
                case "C": ActionType = "BC";
                    break;
                //  default: ActionType = "hcr";  

            }
            var BselectedValue = document.getElementById('ddlstats').value;
            if(BselectedValue == "C"){
             ActionType = "BC";
            }
            var ExtRefNo = document.getElementById('txtExtRefNo').value;
            var ClientName = document.getElementById('txtClientName1').value;
            //        if ($('#ddlstats').val() != 'A' && $('#ddlstats').val() != 'C') {
            //            alert('We can allow only Assigned or Cancelled.');
            //            return false;
            //        }
            var Flag = 1;
            BookingList.push({
                TitleCode: TitleCode,
                PatientName: PatientName,
                Sex: Sex,
                DOB: DOB,
                Age: Age,
                LandLineNumber: LandLineNumber,
                PhoneNumber: PhoneNumber,
                EMail: EMail,
                OrgAddressID: parseInt(OrgAddressID),
                CollectionAddress: CollectionAddress,
                UserID: parseInt(UserID),
                CollectionTime: CollectionTime,
                BookingOrgID: parseInt(BookingOrgID),
                BookingStatus: BookingStatus,
                CollectionAddress2: CollectionAddress2,
                City: City,
                BookingID: parseInt(BookingID),
                Comments: Comments,
                State: State,
                Pincode: Pincode,
                CityID: CityID,
                StateID: StateID,

                URNTypeID: parseInt(URNTypeID),
                URNO: URNO,

                DispatchValue: DispatchValue,


                TokenID: TokenID,
                RefPhysicianName: RefPhysicianName,
                ExtRefNo: ExtRefNo,
                ClientName:ClientName

            });
           
            PageContextkey.push({
                ID: OrgAddressID,
                PatientID: BookingID,
                RoleID: RoleID,
                OrgID: OrgID,
                PatientVisitID: BookingID,
                PageID: PageID,
                ButtonName: ButtonName,
                ActionType: ActionType
            });

            var _flag = true;
            if ($("#dataexample")[0].rows.length > 1) {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var gBookingID = currentRow.find("span[id$='BookingID']").html();
                    var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                    var gPatientName = currentRow.find("span[id$='PatientName']").html();
                    var gSex = currentRow.find("span[id$='Sex']").html();
                    var gAge = currentRow.find("span[id$='Age']").html();
                    var gDOB = currentRow.find("span[id$='DOB']").html();
                    var gLoc = currentRow.find("span[id$='Loc']").html();
                    var gCity = currentRow.find("span[id$='City']").html();
                    var gState = currentRow.find("span[id$='State']").html();
                    var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                    var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                    var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                    var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                    var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                    var gPincode = currentRow.find("span[id$='Pincode']").html();
                    var gName = currentRow.find("span[id$='Name']").html();
                    var gEMail = currentRow.find("span[id$='EMail']").html();
                    var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                    var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                    var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                    var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                    var gUserName = currentRow.find("span[id$='UserName']").html();
                    var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                    var gRemarks = currentRow.find("span[id$='Remarks']").html();
                    var gComments = currentRow.find("span[id$='Comments']").html();
                    var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();
                    var gClientName = currentRow.find("span[id$='ClientName']").html();
                    
                    if (PatientName == gPatientName) {
                        _flag = false;
                    }
                });
            }
            if (_flag) {

                //  var lstBookings = BookingList;
                saveVaccDetails();
            }
            //        else {
            //            var userMsg = SListForAppMsg.Get("ServiceMaster_Controls_VaccinationMaster_ascx_03") == null ? "Item Already Exist" : SListForAppMsg.Get("ServiceMaster_Controls_VaccinationMaster_ascx_03");
            //            ValidationWindow(userMsg, errorMsg);
            //        }
            $('#btnVaccUpdate').hide();

            if ($("#dataexample")[0].rows.length > 1) {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    currentRow.find("input:button[id$='btnEdit']").show();


                });
            }

            function saveVaccDetails() {

                $.ajax({
                    type: "POST",

                    url: "../HCService.asmx/UpdateHCBookingDetails",
                    data: JSON.stringify({ lstBookings: BookingList, lstPageContext: PageContextkey }),
                    //    url:"../HCService.asmx/UpdateHCBulkBookingDetails",
                    //  data: "lstBookings: " + JSON.stringify(BookingList), 
                    //      data: JSON.stringify({ lstBookings: BookingList }),
                    //  data: JSON.stringify({ lstBookings: BookingList }),
                    //  data: { lstBookings: lstBookingList },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //    async: true,
                    //    cache: false,
                    success: OnSuccess,
                    failure: function(response) {
                        alert(response.d);
                    }

                    //           success: OnSuccess,
                    //            error: function(x) {
                    //                var d = x;
                    //            },
                    //            failure: function(response) {
                    //                alert(response.d);
                    //                return false;
                    //            }
                });
            }
            function OnSuccess(response) {
                ValidationWindow('Booking ID : ' + response.d + ' Updated successfully ', 'Information');
                GetData();
                // $('#tblVaccinationDetails').show();
                $('#AddVaccDetails').show();
                $('#dataexample').show();
            }
            //        function OnSuccess(response) {
            //            alert('Booking ID : ' + response.d + ' Updated successfully ');

            //            $('#tblVaccinationDetails').show();
            //            $('#AddVaccDetails').show();
            //            $('#tblVaccinationList').show();
            //        }



            //   VaccClear();

            $('#hdnBookingID').val('0');
        }
        //   }

        function EditVaccTemp(obj, ele) {

            //    $('#VaccinationMaster_btnVaccAdd').val('Modify').show();
            //   $('#VaccinationMaster_btnVaccAdd').text(strModify);
            if ($("#dataexample")[0].rows.length > 1) {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    currentRow.find("input:button[id$='btnEdit']").hide();


                });
            }
            var TempTable = ele.split('~');
            var DataTable = [];
            DataTable.push({
                BookingID: TempTable[0],
                TitleCode: TempTable[36],
                PatientName: TempTable[1],
                Sex: TempTable[11],
                Age: TempTable[12],
                //   ddlDOBDWMY: TempTable[12].split(' ')[1],
                DOB: TempTable[13],
                Loc: TempTable[15],
                Pincode: TempTable[14],
                CollectionAddress: TempTable[3],
                CollectionAddress2: TempTable[20],
                City: TempTable[34],
                State: TempTable[35],
                PhoneNumber: TempTable[23],
                Comments: TempTable[29],
                LandLineNumber: TempTable[24],
                EMail: TempTable[27],
                CollectionTime: TempTable[21],
                UserID: TempTable[22],
                DispatchValue: TempTable[28],
                UrnTypeID: TempTable[25],
                URNo: TempTable[26],
                RefPhysicianName: TempTable[30],
                BookingStatus: TempTable[31],
                ExtRefNo: TempTable[36],
                ClientName:TempTable[37]
            });
            EditVaccDetails(DataTable);
        }
     
        /* text assingn in */
        function EditVaccDetails(DataTable) {
            document.getElementById('hdnBookingStatus').value = '';
            $('#tblVaccinationDetails').show();
            $('#divsearch').hide();
            //       
            var BookingID = '0', PatientName = '', Sex = '', Age = '', DOB = '', Pincode = '', CollectionAddress2 = '', City = '', State = '',
CityID = '', StateID = '', BookingOrgID = '', OrgAddressID = '', CollectionAddress = '', CollectionTime = '', UserID = '', PhoneNumber = '',
Loc = '', ddlDOBDWMY = '', CollectionTime = '', BookingStatus = '', TitleCode = '',

LandLineNumber = '', EMail = '', DispatchValue = '', UrnTypeID = '', URNO = '', Comments = '', TokenID = '', RefPhysicianName = '', Remarks = '', ExtRefNo = '', ddlLoc = '', ClientName = ''

            $.each(DataTable, function(i, obj) {

                BookingID = obj.BookingID;
                TitleCode = obj.TitleCode;
                PatientName = obj.PatientName;
                Loc = obj.Loc;

                Sex = obj.Sex;
                Age = obj.Age;
                ddlDOBDWMY = obj.ddlDOBDWMY;
                DOB = obj.DOB;
                Pincode = obj.Pincode;

                City = obj.City;
                State = obj.State;
                Remarks = obj.Remarks;
                PhoneNumber = obj.PhoneNumber;
                CollectionAddress = obj.CollectionAddress;
                EMail = obj.EMail;
                Comments = obj.Comments;
                LandLineNumber = obj.LandLineNumber;
                CollectionTime = obj.CollectionTime;
                UserID = obj.UserID;
                DispatchValue = obj.DispatchValue;
                UrnTypeID = obj.UrnTypeID;
                URNO = obj.URNO;
                RefPhysicianName = obj.RefPhysicianName;
                BookingStatus = obj.BookingStatus;
                ExtRefNo = obj.ExtRefNo;
                ddlLoc = obj.ddlLoc;
                ClientName = obj.ClientName;
            });

            document.getElementById('hdnBookingID').value = BookingID;
            $("#ddSalutation > [value=" + TitleCode + "]").attr("selected", "true");
            // $('#ddSalutation').val(TitleCode);
            document.getElementById('txtPatientName').value = PatientName;
            document.getElementById('ddlSex').value = Sex;
            document.getElementById('txtDOBNos').value = Age;
            document.getElementById('ddlDOBDWMY').value = ddlDOBDWMY;
            document.getElementById('tDOB').value = DOB;
            
            if (hdnPinLoc.value == "Y") {
                document.getElementById('txtConfLoc').value = Loc;
                document.getElementById('txtConfPinCodeBo').value = Pincode; 
                document.getElementById('txtSuburb').value = Loc;
            document.getElementById('txtPinCodeBo').value = Pincode;
            }
            else {
            document.getElementById('txtSuburb').value = Loc;

            document.getElementById('txtPinCodeBo').value = Pincode;
            document.getElementById('txtConfLoc').value = Loc;
                document.getElementById('txtConfPinCodeBo').value = Pincode; 
            }
            document.getElementById('textstate').value = State;
            //    document.getElementById('hdnStateID').value = Inp[8].split(':')[1];


            document.getElementById('textcity').value = City;
            //  $('#ddlLocation').val(Inp[10]);
            $('#ddlUser').val(UserID);
           
            var nullvalue = "";
            if (CollectionTime != '31/12/9999 11:59 PM') {
                nullvalue = CollectionTime;
            }
           
            document.getElementById('txtTime').value = nullvalue;
            
            document.getElementById('hdnSlottime').value = CollectionTime;
            
            document.getElementById('txtMobile').value = PhoneNumber;
            document.getElementById('txtTelephoneNo').value = LandLineNumber;
            document.getElementById('txtAddress').value = CollectionAddress;
            document.getElementById('txtEmail').value = EMail;
            document.getElementById('txtFeedback').value = Comments;
            //  if (UrnTypeID
            $("#ddlUrnType > [value=" + UrnTypeID + "]").attr("selected", "true");
            //  $('#ddlUrnType').val(UrnTypeID);
			  // $("#ddlLoc").Text = ddlLoc;

     //   $("#ddlLoc option:selected").text() = ddlLoc;

        $("#ddlLoc option:contains("+ ddlLoc +")").attr('selected', 'selected');
            document.getElementById('txtURNo').value = URNO;
            document.getElementById('hdnBookingStatus').value = BookingStatus;

            $("#ddlstats > [value=" + BookingStatus + "]").attr("selected", "true");
            //   $('#ddlstats').val(BookingStatus);
            document.getElementById('txtInternalExternalPhysician').value = RefPhysicianName;
            document.getElementById('txtExtRefNo').value = ExtRefNo;
            document.getElementById('txtClientName1').value = ClientName;
            if (document.getElementById('txtEmail').value != '') {
                document.getElementById('chkDespatchMode_0').checked = true;
            }
            else {
                //elements.cells[0].childNodes[0].checked = false;
                document.getElementById('chkDespatchMode_0').checked = false;

            }
            if (document.getElementById('txtMobile').value != '') {
                document.getElementById('chkDespatchMode_1').checked = true;
            }
            else {
                //elements.cells[0].childNodes[0].checked = false;
                document.getElementById('chkDespatchMode_1').checked = false;

            }
            var Dispatch = [];
            if (DispatchValue != '') {
                Dispatch = DispatchValue.split(',');
            }
            else {
                Dispatch = '';
            }
            if (Dispatch.length > 0) {
                $.each(Dispatch, function(index, value) {
                    if (Dispatch[0] == "Email") {
                        document.getElementById('chkDespatchMode_0').checked = true;
                    }
                    if (Dispatch[1] == "Sms") {
                        document.getElementById('chkDespatchMode_1').checked = true;
                    }
                    if (Dispatch[2] == "Courier") {
                        document.getElementById('chkDespatchMode_2').checked = true;
                    }




                });


            }
            if (DataTable[0].BookingID == '0') {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);

                    var gBookingID = currentRow.find("span[id$='BookingID']").html();
                    var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                    var gPatientName = currentRow.find("span[id$='PatientName']").html();
                    var gSex = currentRow.find("span[id$='Sex']").html();
                    var gAge = currentRow.find("span[id$='Age']").html();
                    var gDOB = currentRow.find("span[id$='DOB']").html();
                    var gLoc = currentRow.find("span[id$='Loc']").html();
                    var gCity = currentRow.find("span[id$='City']").html();
                    var gState = currentRow.find("span[id$='State']").html();
                    var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                    var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                    var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                    var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                    var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                    var gPincode = currentRow.find("span[id$='Pincode']").html();
                    var gName = currentRow.find("span[id$='Name']").html();
                    var gEMail = currentRow.find("span[id$='EMail']").html();
                    var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                    var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                    var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                    var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                    var gUserName = currentRow.find("span[id$='UserName']").html();
                    var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                    var gRemarks = currentRow.find("span[id$='Remarks']").html();
                    var gComments = currentRow.find("span[id$='Comments']").html();
                    if (BookingID == gBookingID && PatientName == gPatientName) {
                        currentRow.remove();
                    }
                    var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();
                    var gClientName = currentRow.find("span[id$='ClientName']").html();

                });
            }
            if (DataTable[0].BookingID != '0') {
                $('[id$="dataexample"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var gBookingID = currentRow.find("span[id$='BookingID']").html();
                    var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                    var gPatientName = currentRow.find("span[id$='PatientName']").html();
                    var gSex = currentRow.find("span[id$='Sex']").html();
                    var gAge = currentRow.find("span[id$='Age']").html();
                    var gDOB = currentRow.find("span[id$='DOB']").html();
                    var gLoc = currentRow.find("span[id$='Loc']").html();
                    var gCity = currentRow.find("span[id$='City']").html();
                    var gState = currentRow.find("span[id$='State']").html();
                    var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                    var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                    var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                    var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                    var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                    var gPincode = currentRow.find("span[id$='Pincode']").html();
                    var gName = currentRow.find("span[id$='Name']").html();
                    var gEMail = currentRow.find("span[id$='EMail']").html();
                    var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                    var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                    var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                    var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                    var gUserName = currentRow.find("span[id$='UserName']").html();
                    var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                    var gRemarks = currentRow.find("span[id$='Remarks']").html();
                    var gComments = currentRow.find("span[id$='Comments']").html();
                    if (BookingID == gBookingID && PatientName == gPatientName) {
                        currentRow.remove();
                        //currentRow.css("background", "#4DDBFF");
                    }
                    var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();
                    var gClientName = currentRow.find("span[id$='ClientName']").html();

                });
            }
        }
</script>
<script type="text/javascript" language="javascript">







    $(function() {
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                //$(".datePicker").datepicker("option", "maxDate", selectedDate);

                //var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });

    });
    function updateDataTableSelectAllCtrl(table) {
        var $table = table.table().node();
        var $chkbox_all = $('tbody input[type="checkbox"]', $table);
        var $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table);
        var chkbox_select_all = $('thead input[name="select_all"]', $table).get(0);

        // If none of the checkboxes are checked
        if ($chkbox_checked.length === 0) {
            chkbox_select_all.checked = false;
            if ('indeterminate' in chkbox_select_all) {
                chkbox_select_all.indeterminate = false;
            }

            // If all of the checkboxes are checked
        } else if ($chkbox_checked.length === $chkbox_all.length) {
            chkbox_select_all.checked = true;
            if ('indeterminate' in chkbox_select_all) {
                chkbox_select_all.indeterminate = false;
            }

            // If some of the checkboxes are checked
        } else {
            chkbox_select_all.checked = true;
            if ('indeterminate' in chkbox_select_all) {
                chkbox_select_all.indeterminate = true;
            }
        }
    }
 function uptechApplyclick(id) { 
var ButtonName = id; 
var OrgID    = document.getElementById('hdnOrgID').value;
var PageID = document.getElementById('hdnPageID').value;
var RoleID = document.getElementById('hdnRoleId').value; 
//if ($("#ddlTechni").val() == "0")  
//alert("Please select Technician in Group Filter search");
//else {
    var DataTable = [];
    var BookingListData = [];
    var PageContextkey = [];
    $("#dataexample tr:not(:first)").each(function(i, n) {
        var $row = $(n);

        var checked = $row.find("input[type='checkbox']").is(":checked");
        // $("[id*=chkDespatchMode] input:checked");
        if (checked) {
            var BookingID = '0', PatientName = '', Sex = '', Age = '', DOB = '', Pincode = '', CollectionAddress2 = '', City = '', State = '',
            CityID = '', StateID = '', BookingOrgID = '', OrgAddressID = '', CollectionAddress = '', CollectionTime = '', UserID = '', PhoneNumber = '',
            Loc = '', ddlDOBDWMY = '', CollectionTime = '', BookingStatus = '', TitleCode = '',

            LandLineNumber = '', EMail = '', DispatchValue = '', URNTypeID = '', URNO = '', Comments = '', TokenID = '', RefPhysicianName = '', Remarks = '', ExtRefNo = ''



            ////       var wholeData=  $row.find("input[class$='Techni']").attr('id');

            //       TechniTask(wholeData);

            //              $("input[type='checkbox']":'checked').each(function(data) {
            //               var rowData = dataexample..row(this).data();
            // Iterate over all selected checkboxes
            // Handle table draw event
            //            table.on('draw', function() {
            //                // Update state of "Select all" control
            //                updateDataTableSelectAllCtrl(table);
            //            });
            //            $.each(rows_selected, function(index, rowId) {
            //                // Create a hidden element 
            //                $(form).append(
            //             $('<input>')
            //                .attr('type', 'hidden')
            //                .attr('name', 'id[]')
            //                .val(rowId)
            //         );
            //            });
            //            alert(rowId);

            // Handle form submission event
            // Handle click on checkbox
            //Loop through all checked CheckBoxes in GridView.
            //            $("#dataexample input[type=checkbox]:checked").each(function () {
            //                var row = $(this).closest("tr")[0];
            //                message += row.cells[1].innerHTML;
            //                message += "   " + row.cells[2].innerHTML;
            //                message += "   " + row.cells[3].innerHTML;
            //                message += "\n";
            //            });
//            var rowData;
//            table = $('#dataexample').DataTable();
//            $("#dataexample input[type=checkbox]:checked").each(function(e) {
//                rowData = $(this).closest("tr")[0];
//                // Get row data
//                var data = table.row($row).data();
//                debugger;
//                // Get row ID
//                var rowId = data[0];
            //            });
            var rowData = $row.find("input[class$='Techni']").attr('id');
           //  var rowData = $row.find("input[type='checkbox']").attr('id');
            // alert($row[0].innertext);
            // alert(rowData);
            //  alert(rowId);
            // $table

            //   var BookingID = '';
            //   var BookingStatus = '';
            //   var UserID = '';
            //   var TokenID = '';
            //   var PatientName = '';
            var Tempdata = rowData.split('~');

          //  alert(Tempdata);










            //    DataTable.push({
            
              var Tempdata = rowData.split('~');
            BookingID = parseInt(Tempdata[0]);
            if ($('#ddlStat').val() == 0) {
                BookingStatus = Tempdata[31];
            }
            else {
                if ($('#ddlStat').val() != 'A' && $('#ddlStat').val() != 'C' && $('#ddlStat').val() != 'TC') {
                    ValidationWindow('We can allow Assigned or Cancelled or Trip Cancelled status only.', 'Information');
                    return false;
                }
                else if (Tempdata[31] == 'TS' && Tempdata[31] == 'IP' && Tempdata[31] == 'RD') {
                    ValidationWindow('We can allow Assigned or Cancelled or Trip Cancelled status only.', 'Information');
                    return false;
                }
                else {
                    BookingStatus = $('#ddlStat').val();
                }
            }

            //  BookingStatus = $('#ddlStat').val();
            if ($('#ddlTechni').val() == 0) {
                UserID = Tempdata[22];
            }
            else {
                UserID = $('#ddlTechni').val();
            }

            //    UserID = parseInt($('#ddlTechni').val());
            TokenID = 'S';
            //    alert(Tempdata[30]);
            //    TitleCode = Tempdata[30];
            TitleCode = Tempdata[36];
            PatientName = Tempdata[1];
            Sex = Tempdata[11];

            var strdate = Tempdata[13];

            var testdate = reformatDateString(strdate);
            var d = new Date(testdate);
            DOB = d.toJSON();
            var DOB1 = d.toISOString();

            Age = Tempdata[12];
            LandLineNumber = Tempdata[24];
            PhoneNumber = Tempdata[23];
            EMail = Tempdata[27];
            Loc = Tempdata[15];
            Pincode = Tempdata[14];
            if (parseInt(Tempdata[32]) == '') {
                CityID = 0;
            }
            else {
                CityID = parseInt(Tempdata[32]);
            }
            if (parseInt(Tempdata[33]) == '') {
                StateID = 0;
            }
            else {
                StateID = parseInt(Tempdata[33]);
            }
            CollectionAddress = Tempdata[3];
            CollectionAddress2 = Tempdata[15];
            City = Tempdata[34];
            State = Tempdata[35];

            Comments = Tempdata[29];


            OrgAddressID = parseInt(Tempdata[19]);
            var CollectionTimetes = '';

            var COlltime = [];
            var AMrPM = '';
            var time = '';
            COlltime = Tempdata[21].split(' ');
            //    alert(COlltime);
 
if (Tempdata[21] != '') {

                if (COlltime.length <= 2) {


                AMrPM = COlltime[1].slice(-2);
                time = COlltime[1].replace(COlltime[1].slice(-2), '');
                //   alert(AMrPM);
            }
            else {


                    AMrPM = COlltime[2];
                    time = COlltime[1];
                    //   alert(AMrPM);
                }
                //   var CollectionTimetes = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time; /;/ + ' ' + AMrPM;
                CollectionTimetes = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time + ' ' + AMrPM;
            }
            else {
                CollectionTimetes = '9999-12-31 23:59:59';
            }

            //    alert(CollectionTimetes);
            //   alert(AMrPM);










            //  CollectionTime = Tempdata[21];
            //  var strdate1 = Tempdata[21];

            //  var testdate1 = reformatDateString(strdate1);
           
            var date = new Date(CollectionTimetes); //).format("YYYY-MM-DD HH:mm:ss");
            //  var date = new date(COlltime);
            // var d1 = checkZero(date.getDate()) + "/" + checkZero((date.getMonth() + 1)) + "/" + checkZero(date.getFullYear()) + " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" + checkZero(date.getSeconds());
            var d1 = date;
            function checkZero(data) {
                if (data.length == 1) {
                    data = "0" + data;
                }
                return data;
            }
            //  alert(date);
            //    var testdate1 = reformatDateString(d1);
            //    var CollectionTime1 = d1.toJSON();
            //    alert( CollectionTime1);
            //   var CollectionTime = CollectionTimetes.toISOString();
            //   alert(CollectionTime);
            //   var CollectionTime = Tempdata[21];
            //  alert(CollectionTime);
            var CollectionTime = CollectionTimetes;
            //  alert('Colltime '+CollectionTime);
            BookingOrgID = parseInt(Tempdata[18]);
            DispatchValue = Tempdata[28];
            URNTypeID = parseInt(Tempdata[25]);
            URNO = Tempdata[26];
            RefPhysicianName = Tempdata[30];
            ExtRefNo = Tempdata[37];
            ClientName = Tempdata[38];
            var ActionType = "";
            switch (BookingStatus) {
                case "A": ActionType = "hca";
                    break;
                case "RS": ActionType = "BR";
                    break;
                case "C": ActionType = "BC";
                    break;
            }

            BookingListData.push({
                TitleCode: TitleCode,
                PatientName: PatientName,
                Sex: Sex,
                DOB: DOB,
                Age: Age,
                LandLineNumber: LandLineNumber,
                PhoneNumber: PhoneNumber,
                EMail: EMail,
                OrgAddressID: OrgAddressID,
                CollectionAddress: CollectionAddress,
                UserID: UserID,
                CollectionTime: CollectionTime,
                BookingOrgID: BookingOrgID,
                BookingStatus: BookingStatus,
                CollectionAddress2: CollectionAddress2,
                City: City,
                BookingID: BookingID,
                Comments: Comments,
                State: State,
                Pincode: Pincode,
                CityID: CityID,
                StateID: StateID,

                URNTypeID: URNTypeID,
                URNO: URNO,

                DispatchValue: DispatchValue,


                TokenID: TokenID,
                RefPhysicianName: RefPhysicianName,
                ExtRefNo: ExtRefNo,
                ClientName:ClientName

            });
            PageContextkey.push({
                ID: OrgAddressID,
                PatientID: BookingID,
                RoleID: RoleID,
                OrgID: OrgID,
                PatientVisitID: BookingID,
                PageID: PageID,
                ButtonName: ButtonName,
                ActionType: ActionType
            });


        }
    });
           
     $('#ddlTechni').val(0);
$('#ddlStat').val(0);
           $.ajax({
               type: "POST",
               url: "../HCService.asmx/UpdateHCBulkBookingDetails",
                 data: JSON.stringify({ lstBookings: BookingListData, lstPageContext: PageContextkey}),
           //  data:{ lstBookings: BookingListData },
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: OnSuccess,
               error: function(x) {

                   var d = x;
               },
               failure: function(response) {
                   alert(response.d);
                   return false;
               }
           });
           function OnSuccess(response) {

               ValidationWindow('Updated Successfully', 'Information');
			   GetData();
               return false;
               
               $('#AddVaccDetails').show();
               $('#dataexample').show();
           }
           
   // }
}

function ClearFields() {
    if (document.getElementById('txtClientName').value.trim() == "") {
        document.getElementById('hdnClientID').value = "";
    }
}
function ValidatePincodeAndLocation() {
    //if (document.getElementById('rdoPatientSave').checked == true) {
    if (document.getElementById('txtSuburb').value == '') {
        document.getElementById('txtpincode').value = '';
        document.getElementById('txtCity').value = ''
        document.getElementById('txtstate').value = '';
        document.getElementById('hdnCityID').value = '';
        document.getElementById('hdnStateID').value = '';
        document.getElementById('hdnstate').value = '';
        document.getElementById('hdnCountryID').value = '';
    }
    else if (document.getElementById('txtpincode').value == '') {
        document.getElementById('txtSuburb').value = '';
        document.getElementById('txtCity').value = ''
        document.getElementById('txtstate').value = '';
        document.getElementById('hdnCityID').value = '';
        document.getElementById('hdnStateID').value = '';
        document.getElementById('hdnstate').value = '';
        document.getElementById('hdnCountryID').value = '';
    }
    // }

}


     
 

 
 

 

</script>
<script type="text/javascript">
// Get the modal
var gblBookingID = "";
function onClickCollDate(Currval)
{
    var CheckDate="";
    var rowData = $(Currval).attr('id');
    var Tempdata = rowData.split('~');
    gblBookingID = parseInt(Tempdata[0]);
    var BookingDate = Tempdata[1];
    var UserN = Tempdata[2];
    var Pincd = Tempdata[3];
//alert(BookingDate);
    var arrayF = new Array();
    if(BookingDate!= "null"){
   // alert(1);
                arrayF = BookingDate.split('/');
                CheckDate = (arrayF[0] + "/" + arrayF[1] + "/" + arrayF[2].substring(0, 4));
     }
       else{
                //alert(2);
                var datetime = new Date();
                var month = datetime.getMonth() + 1;
                var day = datetime.getDate();
                var year = datetime.getFullYear();
              CheckDate =   day + "/" + month + "/" + year; 
      }
    $("input[id*=txtPincode]").val(Pincd);
    $("input[id*=txtname]").val(UserN);
    $("input[id*=txtDate]").val(CheckDate);
    $( "input[id*=txtPincode]" ).prop( "disabled", true );
    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("close")[0];
     modal.style.display = "block";
      $("input[id*=ck]").click();
   //$("input[id*=tr12]").hide();
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
      modal.style.display = "none";
    }
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
}
function onClickClose(Cur)
{
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
}
function onConfirmBookingSlot(){   
        var gblBookingDate ="";
        var gblResourceID="";
        var gblSlot ="";
        var gblpincode="";
        var gblResourceName ="";
       gblBookingDate = $("input[id*=hdngblBookingDate]").val();
       gblResourceID = $("input[id*=hdngblResourceID]").val();
       gblSlot = $("input[id*=hdngblSlot]").val();
       gblpincode = $("input[id*=hdngblpincode]").val(); 
       gblResourceName = $("input[id*=hdnTechName]").val(); 
        var objSCPdate =  gblBookingDate;
        var objSCPhours =  gblSlot;
        var arrayF = new Array();
            objSCPdate = objSCPdate.substring(0, 10);
            arrayF = objSCPdate.split('-');
            var CheckDate = (arrayF[2] + "/" + arrayF[1] + "/" + arrayF[0]);
            var objscpdatetime =   CheckDate +' '+ objSCPhours;
         var objloginID =   document.getElementById("<%=hdnLoginID.ClientID%>").value;  
//             alert(gblBookingID)
//             alert(gblResourceID)
//             alert(objscpdatetime)
                //alert(hdnLoginID)
    if (gblBookingID != ""){
       if (confirm("Are you sure want to Updated the Booking slot?")) 
            {
              if (gblResourceID != ""){
               var bearerToken =  "bearer " + accessToken;
               var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                   vurl = vurl + 'HomeCollection/PostUpdateBookingSchedule?pBookingID=' + gblBookingID + '&pTechID=' + gblResourceID + '&pBookingDate=' + objscpdatetime + '&pLoginID=' + objloginID;
                $.ajax({
                        type: "GET",
                        url: vurl,                        
                        dataType: 'json', 
                        headers: {                                    
                                    Authorization: bearerToken
                                 },   
                        dataType: "json",                 
                        success: function(result) {
                                 ValidationWindow("Booking Scheduled Updated.", "Alert");
                                GetData() ;
                                onClickClose('id');
                        },
                        error: function (err) {
                         alert('err');
                       }
            });
                  }
            }
       }else{
        alert("BookingID is required .")
       }
   }
function GetAccessToken()
    {
    // var vurl = "http://localhost/LIMS_API/api/v1/";
     var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
     vurl = vurl + "v1/";
     vurl = vurl + "Authenticate";
     var granttype = "grant_type=" + '<%=ConfigurationManager.AppSettings["grant_type"] %>';
     var username =  "&username=" + '<%=ConfigurationManager.AppSettings["username"] %>';
     var password = "&password=" + '<%=ConfigurationManager.AppSettings["password"] %>';
     var client_id = "&client_id=" + '<%=ConfigurationManager.AppSettings["client_id"] %>';
     var client_Secret= "&client_Secret=" +'<%=ConfigurationManager.AppSettings["client_Secret"] %>';
     var rawdata = granttype + username + password + client_id + client_Secret;
   //  var rawdata = "grant_type=password&username=LIMSAPI&password=LIMSAPI&client_id=LIMSAPI&client_Secret=";
                    $.ajax({
                        type: "POST",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        data: rawdata,
                        async: false,
                        dataType: "text",
                         success: function(result) {
                        if (result.length > 0) {
                            var obj = JSON.parse(result);
                            //console.log(obj.access_token);
                            accessToken = obj.access_token;
                            }
                        }
            });    
     }
</script>