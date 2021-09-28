<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HC-Bulk Booking.aspx.cs"
    Inherits="HomeCollection_HC_BulkBooking" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>HC Bulk Booking</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        var userMsg;
        function checkDetails() {
            alert(document.getElementById('fulSelect').value);
            return false;
        }

    </script>

    <style type="text/css">
        .myGrid
        {
            width: 100%;
            margin: 0px 0 0px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            width: 600px;
        }
        .myGrid td
        {
            padding: 2px;
            border: solid 1px #c1c1c1;
            color: Black;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 0.9em;
            width: 40px;
        }
        .myGrid th
        {
            color: #fff;
            background: url(images/grid_header.png) repeat-x top;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 0.9em;
        }
        .conditionalRowColor
        {
            font-weight: bold;
            background-color: Teal;
        }
    </style>

    <script language="javascript" type="text/javascript">



        function SelectALL() {
            //debugger;
            $("#example1 tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                if ($('#selectall').is(':checked')) {
                    $row.find("input[id$='chkjdatatable1']").prop('checked', true);
                }
                else {
                    $row.find("input[id$='chkjdatatable1']").prop('checked', false);
                }
            });

        }


        $(document).ready(function() {
           $("#example").hide();
            $("#dvValidate").hide();
            $('#btnValidateData').hide();
            $('#btnSave').hide();
            $('#btnClearall').hide();
            $("#pnlFooter").hide();
            $('#dvShowResult').hide();
            $('#ACX2responsesRateCard').show();
        });


        function ClearAll() {
            $("#dvExcel").hide();
            $("#dvValidate").hide();
            $('#dvShowResult').hide();
            $('#btnValidateData').hide();
            $('#btnSave').hide();
            $('#btnClearall').hide();
            $("#pnlFooter").hide();

        }

        function PathValidation() {
            //debugger;
            // var a = $('#<%=fulSelect.ClientID%>').val();
            if ($('#<%=fulSelect.ClientID%>').val() == '') {
                alert('Please select the Excel path');
                return false;
            }

            return true;

        }

        function SelectUploadType() {

            if (document.getElementById('rdoMinimal').checked == true) {
                document.getElementById('hdnRdoSelected').value = '1';
            }
            if (document.getElementById('rdoDetailed').checked == true) {
                document.getElementById('hdnRdoSelected').value = '2';
            }
        }
        function pagechange(option) {
            var filepath = $('#hdnFilePath').val();
            if (option == 'f') {
                $('#lblCurrent').text(1);
                LoadData(filepath);
            }
            else if (option == 'l') {
                $('#lblCurrent').text($('#lblTotal').text());
                LoadData(filepath);
            }
            else if (option == 'n') {

                var a = parseInt($('#lblTotal').text());
                var b = parseInt($('#lblCurrent').text()) + 1;
                if (b > a) {
                    alert("There is no next page");
                }
                else {
                    $('#lblCurrent').text(b);
                    LoadData(filepath);
                }
            }
            else if (option == 'p') {
                var b = parseInt($('#lblCurrent').text()) - 1;
                if (b > 0) {
                    $('#lblCurrent').text(b);
                    LoadData(filepath);
                }
                else {
                    alert("There is no previous page");
                }
            }
            else if (option == 'g') {
                var a = parseInt($('#lblTotal').text());
                var b = parseInt($('#txtpageNO').val());
                if (b > a) {
                    alert("Don't give number that Exceed page");
                    $('#txtpageNO').val("")
                }
                else {
                    $('#lblCurrent').text(b);
                    $('#txtpageNO').val("")
                    LoadData(filepath);
                }
            }
            return false;
        }
        function doValidate(val) {
            //debugger;
            var path = val; //document.getElementById('fulSelect').value;

            var extension = val.split('.');

            if (path == '') {
                alert("Select Excel Sheet");
                return false;
            }
            else if (extension[1] == 'xlsx' || extension[1] == 'XLSX') {
                alert('Excel should be in xls format');
                return false;
            }
            else {
                var filepath = path;
                var f1 = filepath.replace(/~/g, "\\\\");
                // f1 = filepath.replace("/\\/g", '~').toString();
                // $find("modalpopup").show();
                $('#panelPopup').show();
                LoadData(f1);
                $('#hdnFilePath').val(f1);

            }
            return false;
        }
        function LoadData(path) {
            $("#dvExcel").show();
            $("#dvValidate").hide();

            var value = $('#lblCurrent').text();
            if (value == '') {
                value = 1;
            }
            var a = parseInt(value - 1) * 50;
            var b = (parseInt(value)) * 50;
            $.ajax({
                type: "POST",
                url: "../HCService.asmx/HCBulkBooking",
                contentType: "application/json; charset=utf-8",
                data: "{ fulupload: '" + path + "',Fromdata: '" + a + "', ToData: '" + b + "'}",
                dataType: "json",
                success: AjaxloadtblOutSourceSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");

                    //$('#Panel1').hide();
                    $('#example').hide();
                    $('#lblSample').hide();
                    return false;
                }
            });
            return false;
        }
     function AjaxloadtblOutSourceSucceeded(result) {
             debugger;
            $('#example').each(function() {
             //   if ($.fn.dataTable.fnIsDataTable(this)) {
            if ($.fn.dataTable.fnIsDataTable('#example')) {
                    var dataTable = $('#example').dataTable();
                    dataTable.fnClearTable();
                    $('#lblSample').hide();
                    //$("#lblStatus").show();
                    $("#pnlFooter").hide();
                    $('#example1').hide();
                }
            });

            var oTable;
            //            $("#Panel1").show();
            //            $("#Panel2").hide();
            if (result.d.length > 0) {
                var list = '';
                list = result.d;
                if (list[0] == -1) {
                    alert('Please check whether the excel sheet having data or SINo is properly given');
                }
                if (list[1] > 0) {
                    var tabledata = list[0];
                    var total = result.d.length;
                    if (result != "[]") {
                        oTable = $('#example').dataTable({
                            "bDestroy": true,
                            //"bAutoWidth": false,
                            //  "sPaginationType": "full_numbers",
                            "bProcessing": true,

                            "aaData": tabledata,
                            
                            "aoColumns": [
                            //   { "mData": "ValidateData",
                            //       "mRender": function(data, type, full) {
                            //           return '<input type="checkbox" name="checkjdatatable" id="chkjdatatable"/> ';
                            //        }
                            //    },
                                    {"mDataProp": "SlNo",
                                    "fnRender": function(oObj) {
                                        return '	<label id="jSlNo">' + oObj.aData.SlNo + '</label>';
                                    }
                                   },
                                    { "mDataProp": "OrgName",
                                        "fnRender": function(oObj) {
                                            return '<label id="jOrgName">' + oObj.aData.OrgName + '</label>';
                                        }
                                    },
                                    { "mDataProp": "OrgLocation",
                                        "fnRender": function(oObj) {
                                        return '	<label id="jOrgLocation" >' + oObj.aData.OrgLocation + '</label>';
                                        }
                                    },
                                    { "mDataProp": "BookingDate",
                                        "fnRender": function(oObj) {
                                       return '	<label id="jBookingDate">' + oObj.aData.BookingDate + '</label>';
                                        }
                                    },
                                  
                                     { "mDataProp": "PatientNumber",
                                         "fnRender": function(oObj) {
                                             return '<label id="jPatientNumber">' + oObj.aData.PatientNumber + '</label>';
                                         }
                                     },
                                    

                                          { "mDataProp": "Salutation",
                                              "fnRender": function(oObj) {
                                                  return '<label id="jSalutation">' + oObj.aData.Salutation + '</label>';
                                              }

                                          },
                                          { "mDataProp": "PatientName",
                                              "fnRender": function(oObj) {
                                              return '<label id="jPatientName">' + oObj.aData.PatientName + '</label>';
                                              }
                                          },
                                          { "mDataProp": "DOB",
                                              "fnRender": function(oObj) {
                                                  return '<label id="jDOB">' + oObj.aData.DOB + '</label>';
                                              }

                                          },
                                           { "mDataProp": "Age",
                                               "fnRender": function(oObj) {
                                                   return '	<label id="jAge">' + oObj.aData.Age + '</label>';
                                               }
                                           },
                                    { "mDataProp": "AgeType",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jAgeType">' + oObj.aData.AgeType + '</label>';
                                        }
                                    },
                                    { "mDataProp": "Sex",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSex" >' + oObj.aData.Sex + '</label>';
                                        }
                                    },
//                                   
                                           { "mDataProp": "Pincode",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jPincode" >' + oObj.aData.Pincode + '</label>';
                                              }
                                          },
                                           { "mDataProp": "Location",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jLocation" >' + oObj.aData.Location + '</label>';
                                              }
                                          },
                                           { "mDataProp": "CollectionAddress",
                                                "fnRender": function(oObj) {
                                                    return '	<label id="jCollectionAddress" >' + oObj.aData.CollectionAddress + '</label>';
                                                }
                                            },
                                            { "mDataProp": "CollectionDate",
                                                "fnRender": function(oObj) {
                                                    //                                            var DateFormat = new Date(parseInt(oObj.aData.SDate.slice(6, -2)));
                                                    //                                            var hours = DateFormat.getHours();
                                                    //                                            var minutes = DateFormat.getMinutes().toString().slice(-2);
                                                    //                                            var ampm = hours >= 12 ? 'pm' : 'am';
                                                    //                                            hours = hours % 12;
                                                    //                                            hours = hours ? hours : 12; // the hour '0' should be '12'
                                                    //                                            minutes = minutes < 10 ? '0' + minutes : minutes;
                                                    //                                            var strTime = hours + ':' + minutes + ' ' + ampm;
                                                    //                                            var SDate = (DateFormat.getDate() + '/' + (1 + DateFormat.getMonth()) + '/' + DateFormat.getFullYear() + ' ' + strTime);
                                                    //                                            //var SDate = (DateFormat.getDate() + '/' + (1 + DateFormat.getMonth()) + '/' + DateFormat.getFullYear() + ' ' + DateFormat.getHours() + ":" + DateFormat.getMinutes().toString().slice(-2));
                                                    return '	<label id="jCollectionDate">' + oObj.aData.CollectionDate + '</label>';
                                                }
                                            },
//                                             { "mDataProp": "SampleCollectedDateTime",
//                                              "fnRender": function(oObj) {
//                                                  return '	<label id="SampleCollectedDateTime" >' + oObj.aData.SampleCollectedDateTime + '</label>';
//                                              }
                                            //                                          },
                                          {"mDataProp": "Technician",
                                          "fnRender": function(oObj) {
                                              return '	<label id="jTechnician" >' + oObj.aData.Technician + '</label>'
                                                                                    + '<input type="hidden" id="hdnUniqueID" value="' + oObj.aData.PatId + '" />';
                                          }
                                        },

                                         { "mDataProp": "TestCodes",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jTestCodes" >' + oObj.aData.TestCodes + '</label>';
                                        }
                                    },

                                          {"mDataProp": "Discount",
                                          "fnRender": function(oObj) {
                                          return '	<label id="jDiscount" >' + oObj.aData.Discount + '</label>';
                                          }
                                      },


                                            { "mDataProp": "ClientCode",
                                                "fnRender": function(oObj) {
                                                    return '	<label id="jClientCode" >' + oObj.aData.ClientCode + '</label>';
                                                }
                                            },

                                  
                                    { "mDataProp": "MobileNo",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jMobileNo" >' + oObj.aData.MobileNo + '</label>';
                                        }
                                    },
               

                                          {"mDataProp": "EmailID",
                                          "fnRender": function(oObj) {
                                              return '	<label id="jEmailID" >' + oObj.aData.EmailID + '</label>';
                                          }
                                      },
                                          { "mDataProp": "DispatchMode",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jDispatchMode" >' + oObj.aData.DispatchMode + '</label>';
                                              }
                                          },
                                     { "mDataProp": "RefDocName",
                                         "fnRender": function(oObj) {
                                         return '	<label id="jRefDr" >' + oObj.aData.RefDocName + '</label>';
                                         }
                                     },

                                          { "mDataProp": "Remarks",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jRemarks" >' + oObj.aData.Remarks + '</label>';
                                              }
                                          }


                                  ],
                        //  "sPaginationType": "full_numbers",
                        "bPaginate": false,
                        //  "oSearch": { "bSearchable": false},
                        "sZeroRecords": "No records found",
                        "bSort": false,
                        "bFilter": false,
                        "bInfo": false,
                        "bJQueryUI": true//,
                        // "iDisplayLength": 15 ,
                        //  "sDom": '<"H"lfr>t<"F"ip>'//'<"top"i>rt<"bottom"flp><"clear">'
                    });
                    $('#example').show();
                    $('#btnValidateData').show();
                    $('#btnClearall').show();
                    $('#btnSave').hide();
                    $('#panelPopup').hide();
                    // $find("modalpopup").hide();
                    var totalpages;
                    total = parseInt(list[1]);
                    if ((total % 50) == 0) {
                        totalpages = parseInt((total / 50));
                    }
                    else {
                        totalpages = parseInt((total / 50)) + 1;
                    }
                    $('#lblTotal').text(totalpages);
                    var a = $('#lblCurrent').text();
                    var b = $('#lblTotal').text();
                    if (a == '' && b != '') {
                        $('#lblCurrent').text("1");
                    }
                }
            }
            else {

                $('#example').hide();
                $('#lblSample').hide();
                //$("#lblStatus").show();
                $("#pnlFooter").hide();
                $('#panelPopup').hide();
                //$find("modalpopup").hide();
            }
        }

        return false;
    }
    function AjaxloadtblOutSourceSucceededforValidate(result) {
        // debugger;
        $('#example1').each(function() {
            if ($.fn.dataTable.fnIsDataTable(this)) {
                var dataTable = $('#example1').dataTable();
                dataTable.fnClearTable();
                $('#lblSample').hide();
                //$("#lblStatus").show();
                $("#pnlFooter").hide();
                $('#example1').hide();
            }
        });
        //            $('#example').hide();
        //            $("#Panel1").hide();
        //            $("#Panel2").show();
        var oTable;
        if (result.d.length > 0) {
        //debugger;
            var list = result.d;
            if (list[1] > 0) {
                var tabledata = list[0];
                var total = result.d.length;
                if (result != "[]") {
                    oTable = $('#example1').dataTable({
                        "bDestroy": true,
                        "bAutoWidth": false,
                        //  "sPaginationType": "full_numbers",
                        "bProcessing": true,
                        // "sDom": '<"H"Tfr>t<ip>',
                        "aaData": tabledata,
                        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                            // debugger;
                            if (tabledata[iDisplayIndex].ErrorStatus == true) {
                                //debugger;
                                // $('tr:eq(0)', nRow).addClass('conditionalRowColor');
//                                '<input type="hidden" id="jErrorStatus1" value="' + oObj.aData.SlNo + '" />' +
                                $('td', nRow).addClass('conditionalRowColor');
                                
                                //$('td:eq(1)', nRow).addClass('conditionalRowColor');
                            }
                            return nRow;
                        },
                        "aoColumns": [
                                    { "mData": "ValidateData",
                                        "mRender": function(data, type, full) {
                                            return '<input type="checkbox" name="checkjdatatable" id="chkjdatatable1"/> ';
                                            // + '<input type=hidden id=hdnchkid value=' + full.Id + ' />';
                                        }
                                    },
                                    { "mDataProp": "Id",
                                        "fnRender": function(oObj) {
                                            return '<label id="jId1">' + oObj.aData.Id + '</label>';

                                        }
                                    },
                                    { "mDataProp": "OrgName",
                                        "fnRender": function(oObj) {
                                            return '<label id="jOrgName1">' + oObj.aData.OrgName + '</label>'
                                            + '<input type="hidden" id="hdnSlNo" value="' + oObj.aData.SlNo + '" />';
                                           

                                        }
                                    },
                                    { "mDataProp": "OrgLocation",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jOrgLocation1" >' + oObj.aData.OrgLocation + '</label>';

                                        }
                                    },

                                    { "mDataProp": "BookingDate",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jBookingDate1">' + oObj.aData.BookingDate + '</label>';


                                        }
                                    },
                                    { "mDataProp": "PatientNumber",
                                        "fnRender": function(oObj) {
                                            return '<label id="jPatientNumber1">' + oObj.aData.PatientNumber + '</label>';
                                        }
                                    },
                                    { "mDataProp": "Title",
                                        "fnRender": function(oObj) {
                                            return '<label id="jSalutation1">' + oObj.aData.Title + '</label>';
                                        }
                                    },
                                     { "mDataProp": "PatientName",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jName1">' + oObj.aData.PatientName + '</label>';

                                        }
                                    },
                                    { "mDataProp": "DOB",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jDOB1">' + oObj.aData.DOB + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Age",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jAge1">' + oObj.aData.Age + '</label>';

                                        }
                                    },
                                    { "mDataProp": "AgeType",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jAgeType1">' + oObj.aData.AgeType + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Sex",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSex1" >' + oObj.aData.Sex + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Pincode",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jPinCode1" >' + oObj.aData.Pincode + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Location",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jLocation1" >' + oObj.aData.Location + '</label>';
                                        }
                                    },
                                    { "mDataProp": "CollectionAddress",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jCollectionAddress1" >' + oObj.aData.CollectionAddress + '</label>';

                                        }
                                    },
                                    { "mDataProp": "CollectionDate",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jCollectionDate1">' + oObj.aData.CollectionDate + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Technician",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jTechnician1">' + oObj.aData.Technician + '</label>';
                                        }
                                    },


                                     { "mData": "TestInformation",
                                         "mRender": function(data, type, full) {
                                             var value = '';
                                             var subId = '', TestRequested = '', Charged = '', ErrorDesc = '', TestCode = '', RateId = '', TestType = '', FeeId = '', CampId = '', isDiscountable = '';
                                             if (full.TestInformation != null) {
                                                 if (full.TestInformation.length > 0) {
                                                     value = '<table border="1"><thead><th style="display:none">Id</th><th>Test Requested</th><th>ErrorDesc</th><th>TestCode</th><th>TestType</th><th style="display:none">FeeId</th><th style="display:none">CampId</th></thead>';
                                                     for (var i = 0; i < full.TestInformation.length; i++) {
                                                         //debugger;
                                                         value += '<tr><td style="display:none">' + full.TestInformation[i].Id + '</td><td>' + full.TestInformation[i].TestCodes + '</td><td>' + full.TestInformation[i].ErrorDesc + '</td><td>' + full.TestInformation[i].TestCode + '</td><td>' + full.TestInformation[i].TestType + '</td><td style="display:none">' + full.TestInformation[i].FeeId + '</td></tr>'
                                                         subId += full.TestInformation[i].Id + '~';
                                                         TestRequested += full.TestInformation[i].TestCodes + '~';
                                                      
                                                         ErrorDesc += full.TestInformation[i].ErrorDesc + '~';
                                                         TestCode += full.TestInformation[i].TestCode + '~';
                                                        
                                                         TestType += full.TestInformation[i].TestType + '~';
                                                         FeeId += full.TestInformation[i].FeeId + '~';                                                        
                                                         
                                                     }
                                                     value += '</table>';
                                                 }
                                                 else {
                                                     value = '<label>--</label>';
                                                 }
                                                 /* else if (full.TestInformation != null) {
                                                 value = '<label>' + full.DiscountValue + '</label>';

                                                      }
                                                 else {
                                                 value = '<label>--</label>';
                                                 }*/
                                             }
                                             /*else if (full.DiscountValue != null) {
                                             value = '<label>' + full.DiscountValue + '</label>';

                                                  }*/
                                             else {
                                                 value = '<label>--</label>';
                                             }
                                             return value + '<input type="hidden" id="hdnSubId" value="' + subId + '"/>'
                                                               + '<input type="hidden" id="hdnTestRequested" value="' + TestRequested + '"/>'                                                              
                                                               + '<input type="hidden" id="hdnErrorDesc" value="' + ErrorDesc + '"/>'
                                                               + '<input type="hidden" id="hdnTestCode" value="' + TestCode + '"/>'                                                             
                                                               + '<input type="hidden" id="hdnTestType" value="' + TestType + '"/>'
                                                               + '<input type="hidden" id="hdnFeeId" value="' + FeeId + '"/>'
                                                               + '<input type="hidden" id="hdnCampId" value="' + CampId + '"/>';
                                         }
                                     },
                                    
                                                                
                                                                { "mDataProp": "Discount",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jDiscount1" >' + oObj.aData.Discount + '</label>';

                                        }
                                    },

                                            { "mDataProp": "ClientCode",
                                        "fnRender": function(oObj) {
                                            //  debugger;
                                            var ss = oObj.aData.ClientCode;

                                            var dd = ss.split('~');
                                            if (dd.length > 1) {
                                                var res = dd[0] + '(' + dd[1] + ')';
                                                //return '	<label id="jClientCode1" >' + oObj.aData.ClientCode + '</label>';
                                                return '	<label id="jClientCode1" >' + res + '</label>'
                                            + '<input type="hidden" id="hdnjClientCode1" value="' + dd[1] + '"/>';
                                            }
                                            else
                                                return '	<label id="jClientCode1" >' + ss + '</label>';

                                        }
                                    },                                    
                                    { "mDataProp": "MobileNo",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jMobileNo1" >' + oObj.aData.MobileNo + '</label>';

                                        }
                                    },
                                    { "mDataProp": "EmailID",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jEmailId1" >' + oObj.aData.EmailID + '</label>';

                                        }
                                    },
                                    { "mDataProp": "DispatchMode",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jDispatchMode1" >' + oObj.aData.DispatchMode + '</label>';

                                        }
                                    },

                                     { "mDataProp": "RefDocName",
                                         "fnRender": function(oObj) {
                                             return '	<label id="jDoctor1" >' + oObj.aData.RefDocName + '</label>';

                                         }
                                     },

                                          { "mDataProp": "Remarks",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jRemarks1" >' + oObj.aData.Remarks + '</label>'
                                                            + '<input type="hidden" id="jErrorStatus1" value="' + oObj.aData.ErrorStatus + '"/>'
                                                            + '<input type="hidden" id="hdnOrgID1" value="' + oObj.aData.OrgID + '" />'
                                                            + '<input type="hidden" id="hdnOrgLocID1" value="' + oObj.aData.OrgLocationID + '" />'
                                                            + '<input type="hidden" id="hdnSalutation1" value="' + oObj.aData.Salutation + '" />'
                                                            + '<input type="hidden" id="hdnLocationID1" value="' + oObj.aData.LocationID + '" />'
                                                            + '<input type="hidden" id="hdnTechnicianID1" value="' + oObj.aData.SCollectedBy + '" />'
                                                            + '<input type="hidden" id="hdnClientID1" value="' + oObj.aData.ClientID + '"/>'
                                                             + '<input type="hidden" id="hdnCreatedBy1" value="' + oObj.aData.CreatedBy + '"/>'
                                                              + '<input type="hidden" id="hdnCreatedbyId1" value="' + oObj.aData.CreatedbyId + '"/>';

                                              }
                                          }







                                  ],
                        //  "sPaginationType": "full_numbers",
                        "bPaginate": false,
                        "bFilter": false,
                        //  "oSearch": { "bSearchable": false},
                        "sZeroRecords": "No records found",
                        "bSort": false,
                        "bInfo": false,
                        "bJQueryUI": true//,
                        // "iDisplayLength": 15 ,
                        //  "sDom": '<"H"lfr>t<"F"ip>'//'<"top"i>rt<"bottom"flp><"clear">'
                    });
                    //$('#Panel1').hide();
                    $("#dvValidate").show();               
                    $('#example1').show();                  
                    $('#btnSave').show();
                    $('#btnClearall').show();
                    $('#panelPopup').hide();
                    //$find("modalpopup").hide();
                    $("input[id$='selectall']").prop('checked', false);
                    var totalpages;
                    total = parseInt(list[1]);
                    if ((total % 50) == 0) {
                        totalpages = parseInt((total / 50));
                    }
                    else {
                        totalpages = parseInt((total / 50)) + 1;
                    }
                    $('#lblTotal').text(totalpages);
                    var a = $('#lblCurrent').text();
                    var b = $('#lblTotal').text();
                    if (a == '' && b != '') {
                        $('#lblCurrent').text("1");
                    }
                }
            }
            else {

                $('#example1').hide();
                $('#lblSample').hide();
                //$("#lblStatus").show();
                $("#pnlFooter").hide();
                $('#panelPopup').hide();
                // $find("modalpopup").hide();
            }
        }
        return false;
    }

    function UpdateAmount(amount) {
        //debugger;

        var row = $(amount.parentNode.parentNode);
        // var par = $(this).parent().parent(); //tr
        //  var tdRate = par.children("td:nth-child(6)");

        var netAmount = row.find("#jNetAmount1").text();
        var isCreditBill = row.find("#jIsCreditBill1").val();
        if (isCreditBill == 'Y' && parseFloat(amount.value) == 0) {
            row.find("#jDueAmount1").text('0');
        }
        else if (parseFloat(amount.value) > parseFloat(netAmount)) {
            alert('Amount is Greater than NetAmount');
            row.find("#jAmountPaid1").val($('#hdnPreviousAmount').val());
            var due = parseFloat(netAmount) - parseFloat(amount.value);
            row.find("#jDueAmount1").text(due.toString());
        }
        else {

            var amountPaid = amount.value;
            if (amountPaid == '' || amountPaid == '.') {
                row.find("#jDueAmount1").text(netAmount);
                row.find("#jAmountPaid1").val('0');
                $('#hdnPreviousAmount').val('0');
            }
            else {
                var due = parseFloat(netAmount) - parseFloat(amount.value);
                row.find("#jDueAmount1").text(due.toString());
                $('#hdnPreviousAmount').val(amountPaid);

            }
        }
        // var k = $(this).closest('tr').find('td:eq(1)').text();


    }
    function ValidateData() {
        //debugger;
        //$find("modalpopup").show();
        $('#btnClearall').hide();
        $('#panelPopup').show();
        $("#dvExcel").hide();
        $('#example').hide();
        $('#btnValidateData').hide();
        //$("#dvValidate").show();
        var dtBulkReg = [];

        try {
            $("#example tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var SlNo = $row.find("#jSlNo").text();
                var OrgName = $row.find("#jOrgName").text();                
                var OrgLocation = $row.find("#jOrgLocation").text();
                var BookingDate = $row.find("#jBookingDate").text();
                var PatientNumber = $row.find("#jPatientNumber").text();
                var Salutation = $row.find("#jSalutation").text();
                var PatientName = $row.find("#jPatientName").text();
                var DOB = $row.find("#jDOB").text();               
//                if (DOB == "" || isNaN(Date.parse(DOB)))
//                    DOB = "01-01-1900";
                var Age = $row.find("#jAge").text();
                var AgeType = $row.find("#jAgeType").text();
                var Sex = $row.find("#jSex").text();
                var Pincode = $row.find("#jPincode").text();
                var Location = $row.find("#jLocation").text();
                var CollectionAddress = $row.find("#jCollectionAddress").text();
                var CollectionDate = $row.find("#jCollectionDate").text();
                var Technician = $row.find("#jTechnician").text();
                var TestCodes = $row.find("#jTestCodes").text();
                var Discount = $row.find("#jDiscount").text();
                var ClientCode = $row.find("#jClientCode").text();                
                var MobileNo = $row.find("#jMobileNo").text();
                var EmailID = $row.find("#jEmailID").text();
                var DispatchMode = $row.find("#jDispatchMode").text();
                var RefDr = $row.find("#jRefDr").text();
                var Remarks = $row.find("#jRemarks").text();
                
                dtBulkReg.push({                   
                    SlNo: SlNo,
                    OrgName: OrgName,
                    OrgLocation: OrgLocation,
                    BookingDate: BookingDate,
                    PatientNumber: PatientNumber,
                    Salutation: Salutation,
                    PatientName: PatientName,
                    DOB: DOB,
                    Age: Age,
                    AgeType: AgeType,
                    Sex: Sex,
                    Pincode: Pincode,
                    Location: Location, 
                    CollectionAddress: CollectionAddress,
                    CollectionDate: CollectionDate,
                    Technician: Technician,
                    TestCodes: TestCodes,
                    Discount: Discount,
                    ClientCode: ClientCode,
                    MobileNo: MobileNo,
                    EmailID: EmailID,
                    DispatchMode: DispatchMode,
                    RefDocName: RefDr,
                    Remarks: Remarks
                    
                });

            });
            var list = JSON.stringify(dtBulkReg);
            $("input:hidden[id$=hdnBulkRegTable]").val(list);
            $.ajax({
                type: "POST",
                url: "../HCService.asmx/ValidateBulkBookingDetails",
                contentType: "application/json; charset=utf-8",
                data: "{ list: '" + $('#hdnBulkRegTable').val() + "'}",
                dataType: "json",
                success: AjaxloadtblOutSourceSucceededforValidate,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example').hide();
                    $('#lblSample').hide();
                    return false;
                }
            });
                




            return false;
        }
        catch (e) {
            alert('error Occured');
            return false;
        }
        return false;
    }


    function ValidateErrorIsFound() {
        //debugger;
        var chkcount = 0;
        var ErrorCount = 0;
        $("#example1 tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            var isChecked = $row.find("input[id$='chkjdatatable1']").is(":checked");
            if (isChecked) {
                chkcount++;
                //debugger;
//                var AmountPaid = 0;
//                var NetAmount = 0;
//                AmountPaid = $row.find('#jAmountPaid1').val();
//                NetAmount = $row.find('#jNetAmount1').text();




                var ErrorStatus = $row.find("#jErrorStatus1").val();
                if (ErrorStatus == "true") {
                    ErrorCount = 1;
                    alert('Error Data is not allowed for Booking, Please uncheck the Teal color rows');
                    return false;
                }

            }

        });
        if (chkcount == 0) {
            alert('Please select atleast one row to insert');
            return false;
        }
        if (ErrorCount == 0) {
            $('#panelPopup').show();
            // $find("modalpopup").show();
            SaveData();

        }
        return false;

    }

    function SaveData() {      
        $('#btnSave').hide();
        $('#panelPopup').show();
        
        var dtCampDetail = [];
        var dtTestCampDetails = [];
      
        var j = 0;
        try {
        
        
            $("#example1 tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var checked = $row.find("input[id$='chkjdatatable1']").is(":checked");
                if (checked) {                  
                    var Id = $row.find("#jId1").text();                    
                    var OrgName = $row.find("#jOrgName1").text();
                    var SlNo = $row.find("#hdnSlNo").val();                  
                    var OrgLocation = $row.find("#jOrgLocation1").text();
                    var BookingDate = $row.find("#jBookingDate1").text();
                    if (BookingDate == "")
                        BookingDate = "01-01-1900";
                        
                    var PatientNumber = $row.find("#jPatientNumber1").text();
                    var Title = $row.find("#jSalutation1").text();                    
                    var PatientName = $row.find("#jName1").text();
                    var DOB = $row.find("#jDOB1").text();
                    if (DOB == "")
                        DOB = "01-01-1900";
                    var Age = $row.find("#jAge1").text();
                    var AgeType = $row.find("#jAgeType1").text();                   
                    var Sex = $row.find("#jSex1").text();
                    var PinCode = $row.find("#jPinCode1").text();
                    var Location = $row.find("#jLocation1").text();                   
                    var CollectionAddress = $row.find("#jCollectionAddress1").text();
                    var CollectionDate = $row.find("#jCollectionDate1").text();
                     if (CollectionDate == "")
                        CollectionDate = "01-01-1900";
                    var Technician = $row.find("#jTechnician1").val();
                    var Discount = $row.find("#jDiscount1").val();
                    if (Discount == '' || Discount == '.')
                        Discount = '0';                    
                  
                    var ClientCode = $row.find("#jClientCode1").text();
                    var MobileNo = $row.find("#jMobileNo1").text();
                    var EmailId = $row.find("#jEmailId1").text();
                    var DispatchMode = $row.find("#jDispatchMode1").text();
                    var Remarks = $row.find("#jRemarks1").text();
                    var RefDr = $row.find("#jDoctor1").text();
                                     
                    var CreatedBy = $row.find("#hdnCreatedBy1").val();                    
                    var CreatedbyId = $row.find("#hdnCreatedbyId1").val();                           
                    var ClientID = $row.find("#hdnClientID1").val();
                    var LocationID = $row.find("#hdnLocationID1").val();
                    var TitleID = $row.find("#hdnSalutation1").val();                   
                   // var DoctorID = $row.find("#hdnDoctorID").val();                    
                    var ErrorStatus = $row.find("#jErrorStatus1").val();
                    var OrgId = $row.find("#hdnOrgID1").val();
                    var OrgLocID = $row.find("#hdnOrgLocID1").val();
                
                    var SampleCollectedby = $row.find("#hdnTechnicianID1").val();
                 
                    dtCampDetail.push({
                        Id: Id,
                        OrgName: OrgName,
                        SlNo: SlNo,
                        OrgLocation: OrgLocation,
                        BookingDate: BookingDate,
                        PatientNumber: PatientNumber,
                        Title: Title,
                        PatientName:PatientName,
                        DOB: DOB,
                        Age: Age,
                        AgeType: AgeType,
                        Sex: Sex,
                        Pincode:PinCode,                       
                        Location: Location,
                        CollectionAddress: CollectionAddress,
                        CollectionDate: CollectionDate,
                        Technician: Technician,
                        Discount: Discount,
                        ClientCode: ClientCode,
                        MobileNo: MobileNo,
                        EmailID: EmailId,
                        DispatchMode:DispatchMode,
                        Remarks: Remarks,
                        RefDocName: RefDr,
                        CreatedBy: CreatedBy,  
                        CreatedbyId: CreatedbyId, 
                        ClientID: ClientID,
                        LocationID: LocationID,
                        Salutation: TitleID,
                        ErrorStatus: ErrorStatus,
                        OrgID: OrgId,                                   
                        SCollectedBy: SampleCollectedby,
                        OrgLocationID:OrgLocID
                        
                    });


                    for (j = 0; j < $row.find('#hdnSubId').val().split("~").length - 1; j++) {
                        //debugger;
                        dtTestCampDetails.push({
                            Id: $row.find('#hdnSubId').val().split("~")[j],
                            TestCodes: $row.find('#hdnTestRequested').val().split("~")[j],                          
                            ErrorDesc: $row.find('#hdnErrorDesc').val().split("~")[j],
                            TestCode: $row.find('#hdnTestCode').val().split("~")[j],                            
                            TestType: $row.find('#hdnTestType').val().split("~")[j],
                            FeeId: $row.find('#hdnFeeId').val().split("~")[j]

                        });
                   

                    }

                }
            });



            var list = JSON.stringify(dtCampDetail);
            var Testlist = JSON.stringify(dtTestCampDetails);
           // alert(Testlist);
            console.log(Testlist);
            
            $("input:hidden[id$=hdnCampDetails]").val(list);
            $("input:hidden[id$=hdnTestCampDetails]").val(Testlist);
            $.ajax({
                type: "POST",
                url: "../HCService.asmx/SaveBulkBookingDetails",
                contentType: "application/json; charset=utf-8",
                data: "{ list: '" + $('#hdnCampDetails').val() + "', Testlist : '" + $('#hdnTestCampDetails').val() + "'}",
                dataType: "json",
                success: ShowResult
                //function() {
                //   alert('Record Inserted sucessfully');
                //  $('#example1').hide();

                // }
                    ,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example1').hide();
                    $('#lblSample').hide();
                    return false;
                }
            });


            return false;
        }
        catch (e) {
            alert(e.Message);
            return false;
        }
        return false;
    }

    function ShowResult(result) {
        //debugger;
        var oTable;
        if (result.d.length > 0) {
            var list = '';
            list = result.d;
            var tabledata = list;
            if (result != "[]") {
                oTable = $('#example2').dataTable({
                    "bDestroy": true,
                    "bProcessing": true,
                    "aaData": tabledata,
                    "aoColumns": [
                            { "mDataProp": "BookingID",
                                "fnRender": function(oObj) {                               
                                    return '<label id="dtBookingID">' + oObj.aData.BookingID + '</label>';
                                }

                            },
                            { "mDataProp": "PatientNumber",
                                "fnRender": function(oObj) {
                                    return '<label id="dtPatientNumber">' + oObj.aData.PatientNumber + '</label>';
                                }
                            },

                            { "mDataProp": "PatientName",
                                "fnRender": function(oObj) {
                                    return '<label id="dtPatientName">' + oObj.aData.PatientName + '</label>';
                                }
                            },                           
                            { "mDataProp": "Location",
                                "fnRender": function(oObj) {
                                    return '<label id="dtLocation">' + oObj.aData.Location + '</label>';
                                }
                            }

                              ],
                    //  "sPaginationType": "full_numbers",
                    "bPaginate": false,
                    //  "oSearch": { "bSearchable": false},
                    "sZeroRecords": "No records found",
                    "bSort": false,
                    "bFilter": false,
                    "bInfo": false,
                    "bJQueryUI": true, //,
                    // "iDisplayLength": 15 ,
                    //  "sDom": '<"H"lfr>t<"F"ip>'//'<"top"i>rt<"bottom"flp><"clear">'
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                                    "copy", "csv", "xls", "pdf",
                                                     {
                                                         "sExtends": "collection",
                                                         "sButtonText": "Save",
                                                         "aButtons": ["csv", "xls", "pdf"]
                                                     }
                                                  ]
                    }
                });

                $('#dvShowResult').show();
                $('#dvValidate').hide();
                $('#btnSave').hide();
                $('#btnClearall').show();
                //  $find("modalpopup").hide();
                $('#panelPopup').hide();
                $('#<%=fulSelect.ClientID%>').val('');
                $('#selectall').prop('checked', false);
                alert('Record Inserted successfully');
            }


            else {

                $('#example1').hide();
                $('#dvShowResult').hide();
                $('#lblSample').hide();
                //$("#lblStatus").show();
                $("#pnlFooter").hide();
                //$find("modalpopup").hide();
                $('#panelPopup').hide();
            }

        }
        return false;

    }
        
    </script>

    <style type="text/css">
        .style2
        {
            height: 19px;
        }
    </style>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%-- <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
        <table class="w-100p">
            <tr>
                <td>
                    <cc1:ModalPopupExtender ID="modalpopup" runat="server" PopupControlID="panelPopup"
                        TargetControlID="hdnCurrentDate" BackgroundCssClass="modalBackground" DynamicServicePath=""
                        Enabled="True">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="panelPopup" runat="server">
                        <div align="center" id="processMessage" style="width: 15%">
                            <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                                Font-Size="Larger" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/ProgressBar.gif" />
                        </div>
                    </asp:Panel>
                    <table style="float:right">
                        <tr id="ACX2responsesRateCard" style="display: none;" class="tablerow" runat="server">
                            <td id="Td7" runat="server">
                                <table style="height: 80px">
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="lnkXls" Style="color: Blue; font-size: 14px" runat="server" Text="Click here for download Bulk Booking template"
                                                OnClick="lnkXls_Click" ToolTip="Download Excel"></asp:LinkButton>
                                            <asp:ImageButton ID="ImgXls" OnClick="lnkXls_Click" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                ToolTip="Download Excel" />
                                        </td>
                                    </tr>
                                    <tr id="trExcelColor" runat="server" style="display: block;">
                                        <td colspan="2">
                                            <asp:TextBox ID="txtMandatory" Style="background-color: #ffbf00;" ReadOnly="True"
                                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                            <asp:Label ID="lblMandatory" Text="Mandatory" runat="server"></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtEither_OR" Style="background-color: #e67300;" ReadOnly="True"
                                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblEither_OR" runat="server" Text="Either-OR"></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtNonMandatory" Style="background-color: #ffff99;" ReadOnly="True"
                                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblNonMandatory" Text="Non-Mandatory" runat="server"></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtOptional" Style="background-color: #669999;" ReadOnly="True"
                                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblOptional" Text="Optional" runat="server"></asp:Label>&nbsp;
                                        </td>
                                        <td colspan="3">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table style="font-weight: normal; color: #000000;" border="0" cellspacing="0" cellpadding="0">
                        <tr align="left">
                            <td colspan="2">
                                <table cellspacing="10">
                                   <%-- <tr style="display: none;">
                                        <td>
                                            Select Upload type
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlSelectedType" runat="server" Style="display: none;">
                                                <asp:ListItem Value="1"> Patient Registration</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>--%>
                                    <tr align="left" style="display: none;">
                                        <td style="height: 10px;">
                                            <asp:RadioButton ID="rdoMinimal" runat="server" Text="Upload With Minimal Details"
                                                GroupName="Uploading" meta:resourcekey="rdoMinimalResource1" />
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdoDetailed" runat="server" Text="Upload With All Details" GroupName="Uploading"
                                                meta:resourcekey="rdoDetailedResource1" />
                                            <asp:HiddenField ID="hdnRdoSelected" Value="1" runat="server" />
                                            <asp:HiddenField ID="hdnBulkRegTable" runat="server" />
                                            <asp:HiddenField ID="hdnCampDetails" runat="server" />
                                            <asp:HiddenField ID="hdnTestCampDetails" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2">
                                <br />
                            </td>
                        </tr>
                        <tr align="left" >
                            <td >
                                <asp:Label ID="lblSelectFile" runat="server" style="margin-left:50px; font-weight:bold" Text=" Select File :" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                            </td>&nbsp;&nbsp;&nbsp;
                            <td >
                                <asp:FileUpload ID="fulSelect" runat="server" meta:resourcekey="fulSelectResource1" 
                                    accept="xls|xlsx" />
                                <asp:Button ID="BtnSheet" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Text="Upload" OnClick="GetConnection" OnClientClick="return PathValidation()" />
                            </td>
                        </tr>
                        <%--<tr>
                            <td colspan="2">
                             &nbsp;&nbsp;&nbsp;&nbsp;
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  ErrorMessage="* Only Excel files are allowed!"
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.xls|.xlsx)$"
                                        ControlToValidate="fulSelect"></asp:RegularExpressionValidator>
                            </td>
                            
                            </tr>--%>
                        <tr>
                            <td style="height: 10px;">
                            </td>
                        </tr>
                        <tr align="left">
                            <td colspan="2">
                                <div id="Sheet" runat="server" visible="false">
                                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblSelectSheet" runat="server" Text="Select Sheet :"
                                        meta:resourcekey="lblSelectSheetResource1"></asp:Label>&nbsp;&nbsp;
                                    <asp:DropDownList ID="ddlSheet" CssClass="ddlsmall" runat="server" Width="130px"
                                        meta:resourcekey="ddlSheetResource1">
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="height: 10px;">
                                <asp:HiddenField ID="hdnFilePath" runat="server" />
                                <asp:HiddenField ID="hdnCurrentDate" Value="1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div id="dvExcel" style="max-width: 1350px; overflow: auto; max-height: 500px;">
                        <asp:Panel ID="Panel1" runat="server">
                            <table width="80%" border="0" >
                                <tr>
                                    <td  id="lblSample" runat="server" >
                                        <table id="example" >
                                            <thead>
                                                <tr>
                                                    <%--     <th width="50%">
                                                       <input type="checkbox" id="all" />
                                                    </th>  --%>
                                                    <th align="center" width="10%">
                                                        SlNo
                                                    </th>
                                                    <th align="center" width="10%">
                                                        OrgName
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Location
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Booking Date
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Patient Number
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Salutation
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Patient Name
                                                    </th>
                                                    <th align="center" width="15%">
                                                        DoB
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Age
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Age Type
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Sex
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Pincode
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Location
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Collection Address t
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Sample Collected Date & Time
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Technician
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Test Codes
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Discount
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Client Code
                                                    </th>
                                                    <th align="center" width="10%">
                                                        MobileNo
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Email ID
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Dispatch Mode
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Ref Dr
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Comments
                                                    </th>
                                                    <%--<th align="center" width="10%" style="display:none">
                                                            CreatedBy
                                                        </th>--%>
                                                </tr>
                                            </thead>
                                            <tbody  >
                                            </tbody>
                                        </table>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div id="dvValidate" style="max-width: 1350px; overflow: auto; max-height: 450px;">
                        <asp:Panel ID="Panel2" runat="server">
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <table id="example1">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <input type="checkbox" id="selectall" onclick="SelectALL()" />
                                                    </th>
                                                    <th align="center" width="10%">
                                                        SlNo
                                                    </th>
                                                    <th align="center" width="10%">
                                                        OrgName
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Location
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Booking Date
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Patient Number
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Salutation
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Patient Name
                                                    </th>
                                                    <th align="center" width="15%">
                                                        DoB
                                                    </th>
                                                    <th align="center" width="15%">
                                                        Age
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Age Type
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Sex
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Pincode
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Location
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Collection Address
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Sample Collected Date & Time
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Technician
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Test Codes
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Discount
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Client Code
                                                    </th>
                                                    <th align="center" width="10%">
                                                        MobileNo
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Email ID
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Dispatch Mode
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Ref Dr
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Comments
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div id="dvShowResult">
                        <asp:Panel ID="pnlShowResult" runat="server">
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <table id="example2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th align="center" width="10%">
                                                       BookingID
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Patient Number
                                                    </th>
                                                    <th align="center" width="20%">
                                                        Patient Name
                                                    </th>
                                                    <th align="center" width="30%">
                                                        Location
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <asp:Label ID="lblStatus" runat="server" ForeColor="#000333" Style="display: none;"
                        Text="No Matching Records Found!"></asp:Label>
                    <div runat="server" id="dInves" style="display: block;">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center">
                                    <asp:Panel ID="pnlFooter" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table width="100%">
                                            <tr id="row_prev_next" align="center" class="dataheaderInvCtrl">
                                                <td align="center" class="defaultfontcolor">
                                                    <asp:Label ID="lblPage" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                    <asp:Label ID="lblof" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                    <asp:Button ID="btnFirst" CssClass="btn" runat="server" Text="First" Width="70px"
                                                        OnClientClick="return pagechange('f')" />
                                                    <asp:Button ID="btnPrev" CssClass="btn" runat="server" Text="Previous" OnClientClick="return pagechange('p')"
                                                        Width="70px" />
                                                    <asp:Button ID="btnNext" runat="server" CssClass="btn" Text="Next" OnClientClick="return pagechange('n')"
                                                        Width="70px" />
                                                    <asp:Button ID="btnLast" runat="server" CssClass="btn" Text="Last" Width="70px" OnClientClick="return pagechange('l')"
                                                        Height="26px" />
                                                    PageNO<asp:TextBox ID="txtpageNO" CssClass="Txtboxsmall" runat="server" onkeydown="return isNumeric(event.keyCode);"
                                                        Width="58px"></asp:TextBox>
                                                    <asp:Button ID="butGO" runat="server" CssClass="btn" OnClientClick="return pagechange('g')"
                                                        Text="GO" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                            <td align="center" >
                                <asp:Button ID="btnValidateData" runat="server" Text="ValidateData" OnClientClick="return ValidateData();" />
                                <%--<asp:Button ID="btnValidate" runat="server" Text="Validate" OnClientClick="return ValidateData();"/>--%>
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return ValidateErrorIsFound(); return false" />
                                <asp:Button ID="btnClearall" runat="server" Text="Clear" OnClientClick="return ClearAll();" />
                           </td>
                            </tr>
                        </table>
                        <asp:Panel ID="DatePopupInvPanel1" BorderWidth="1px" runat="server" Width="550px"
                            CssClass="modalPopup dataheaderPopup" Style="display: none; z-index: 999;">
                            <asp:Panel ID="Panel3" runat="server" CssClass="dialogHeader">
                                <table width="100%">
                                    <tr>
                                        <td style="text-align: center">
                                            <asp:Label ID="lblCollectedDate" runat="server" Text="Select Collected DateTime Details"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <img id="imgPopupClose1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                class="imgPopupClose" style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <br />
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnPreviousAmount" runat="server" Value="0" />
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>
