<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CovidBulkRegistration.aspx.cs" Inherits="Inventory_CovidBulkRegistration" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>--%>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%--<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>--%>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>--%>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Patient Bulk Registration</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
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
            debugger;
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
                url: "../WebService.asmx/CovidBulkRegistration",
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
                if ($.fn.dataTable.fnIsDataTable(this)) {
                    var dataTable = $('#example').dataTable();
                    dataTable.fnClearTable();
                    $('#lblSample').hide();
                    //$("#lblStatus").show();
                    $("#pnlFooter").hide();
                    $('#example1').hide();
                }
            });
            // $('#example').find('tr:gt(0)').remove();
            //$('#example').dataTable().fnClearTable();
            // $('#example').dataTable().fnDraw();
            //$('#example').dataTable().fnDestroy();
            /*     $('#example').each(function() {
            if ($.fn.dataTable.fnIsDataTable(this)) {
            $('#example').dataTable().fnClearTable();
            //dataTable.fnClearTable();
            $('#lblSample').hide();
            //  $("#lblStatus").show();
            $("#pnlFooter").hide();
            $('#example').hide();

                }
            });*/
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
                            //                            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                            //                                debugger; 
                            //                                var a = Date.parse(tabledata[iDisplayIndex].PDate);
                            //                            },
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
                                    { "mDataProp": "Location",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jLocation" >' + oObj.aData.Location + '</label>';
                                        }
                                    },
                                    { "mDataProp": "PDate",
                                        "fnRender": function(oObj) {
                                            //                                            var DateFormat = new Date(parseInt(oObj.aData.PDate.slice(6, -2)));
                                            //                                            var hours = DateFormat.getHours();
                                            //                                            var minutes = DateFormat.getMinutes().toString().slice(-2);
                                            //                                            var ampm = hours >= 12 ? 'pm' : 'am';
                                            //                                            hours = hours % 12;
                                            //                                            hours = hours ? hours : 12; // the hour '0' should be '12'
                                            //                                            minutes = minutes < 10 ? '0' + minutes : minutes;
                                            //                                            var strTime = hours + ':' + minutes + ' ' + ampm;
                                            //                                            var PDate = (DateFormat.getDate() + '/' + (1 + DateFormat.getMonth()) + '/' + DateFormat.getFullYear() + ' ' + strTime);
                                            //var PDate = (DateFormat.getDate() + '/' + (1 + DateFormat.getMonth()) + '/' + DateFormat.getFullYear() + ' ' + DateFormat.getHours() + ":" + DateFormat.getMinutes().toString().slice(-2));
                                            return '	<label id="jRegistrationDate">' + oObj.aData.PDate + '</label>';
                                        }
                                    },
                                    { "mDataProp": "SDate",
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
                                            return '	<label id="jSampleCollectionDate">' + oObj.aData.SDate + '</label>';
                                        }
                                    },
                                     { "mDataProp": "PatientNumber",
                                         "fnRender": function(oObj) {
                                             return '<label id="jPatientNumber">' + oObj.aData.PatientNumber + '</label>';
                                         }
                                     },
                                     { "mDataProp": "HealthHubID",
                                         "fnRender": function(oObj) {
                                         return '<label id="jHealthHubID">' + oObj.aData.HealthHubID + '</label>';
                                         }

                                     },
                                     { "mDataProp": "EmployeeID",
                                         "fnRender": function(oObj) {
                                         return '<label id="jEmployeeID">' + oObj.aData.EmployeeID + '</label>';
                                         }

                                     },
                                     { "mDataProp": "SourceType",
                                         "fnRender": function(oObj) {
                                         return '<label id="jSourceType">' + oObj.aData.SourceType + '</label>';
                                         }

                                     },
                                          { "mDataProp": "Title",
                                              "fnRender": function(oObj) {
                                                  return '<label id="jTitle">' + oObj.aData.Title + '</label>';
                                              }

                                          },
                                          { "mDataProp": "Name",
                                              "fnRender": function(oObj) {
                                                  return '<label id="jName">' + oObj.aData.Name + '</label>';
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
                                    { "mDataProp": "TestRequested",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jTestRequested" >' + oObj.aData.TestRequested + '</label>';
                                        }
                                    },
                                    { "mDataProp": "AmountPaid",
                                        "fnRender": function(oObj) {
                                            return '<input id="jAmountPaid" type="text" Value=' + oObj.aData.AmountPaid + ' onkeydown="return isNumericss(event,this.id)"></input>';
                                        }
                                    },
                                          { "mDataProp": "AmountDiscount",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jDiscountAmount" >' + oObj.aData.AmountDiscount + '</label>';
                                              }
                                          },
                                            { "mDataProp": "ClientCode",
                                                "fnRender": function(oObj) {
                                                    return '	<label id="jClientCode" >' + oObj.aData.ClientCode + '</label>';
                                                }
                                            },

                                    { "mDataProp": "SCollectedBy",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSampleCollectedby" >' + oObj.aData.SCollectedBy + '</label>'
                                            + '<input type="hidden" id="hdnUniqueID" value="' + oObj.aData.PatId + '" />';
                                        }
                                    },
                                    { "mDataProp": "MobileNo",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jMobileNo" >' + oObj.aData.MobileNo + '</label>';
                                        }
                                    },
                        //                                          { "mDataProp": "CreatedBy",
                        //                                              "fnRender": function(oObj) {
                        //                                              return '	<label id="jCreatedBy" style="display:none" >' + oObj.aData.CreatedBy + '</label>';
                        //                                              }
                        //                                          },

                                          {"mDataProp": "EmailId",
                                          "fnRender": function(oObj) {
                                              return '	<label id="jEmailId" >' + oObj.aData.EmailId + '</label>';
                                          }
                                      },
                                          { "mDataProp": "DispatchMode",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jDispatchMode" >' + oObj.aData.DispatchMode + '</label>';
                                              }
                                          },





                                     { "mDataProp": "Doctor",
                                         "fnRender": function(oObj) {
                                             return '	<label id="jDoctor" >' + oObj.aData.Doctor + '</label>';
                                         }
                                     },
                                    { "mDataProp": "RefHospital",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jRefHospital" >' + oObj.aData.RefHospital + '</label>'
                                        + '<input type="hidden" id="jPriority" value="' + oObj.aData.Priority + '" />'
                                        + '<input type="hidden" id="jCharged" value="' + oObj.aData.Charged + '" />'
                                        + '<input type="hidden" id="jDiscountReason" value="' + oObj.aData.DiscountReason + '" />'
                                        + '<input type="hidden" id="jDiscountAuthBy" value="' + oObj.aData.DiscountAuthorisedBy + '" />'
                                        + '<input type="hidden" id="jCreatedBy" value="' + oObj.aData.CreatedBy + '" />';
                                        }
                                    },

                        //                                    { "mDataProp": "Priority",
                        //                                        "fnRender": function(oObj) {
                        //                                            return '	<label id="jPriority" style="display:none">' + oObj.aData.Priority + '</label>';
                        //                                        }
                        //                                    },


                        //                                          { "mDataProp": "Charged",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jCharged" style="display:none">' + oObj.aData.Charged + '</label>';
                        //                                              }
                        //                                          },

                        //                                          { "mDataProp": "DiscountReason",
                        //                                              "fnRender": function(oObj) {
                        //                                              return '	<label id="jDiscountReason" style="display:none" >' + oObj.aData.DiscountReason + '</label>';
                        //                                              }
                        //                                          },
                        //                                          { "mDataProp": "DiscountAuthorisedBy",
                        //                                              "fnRender": function(oObj) {
                        //                                              return '	<label id="jDiscountAuthBy" style="display:none" >' + oObj.aData.DiscountAuthorisedBy + '</label>';
                        //                                              }
                        //                                          },
                                          {"mDataProp": "History",
                                          "fnRender": function(oObj) {
                                              return '	<label id="jHistory" >' + oObj.aData.History + '</label>';
                                          }
                                      },
                                          { "mDataProp": "Remarks",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jRemarks" >' + oObj.aData.Remarks + '</label>';
                                              }
                                          },
                                          { "mDataProp": "BookingID",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jBookingID" >' + oObj.aData.BookingID + '</label>';
                                              }
                                          },
                                          { "mDataProp": "ExternalRefNo",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jExternalRefNo" >' + oObj.aData.ExternalRefNo + '</label>';
                                              }
                                          },
                                          { "mDataProp": "SampleNumber",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jSampleNumber" >' + oObj.aData.SampleNumber + '</label>';
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
         debugger;
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
                                    { "mDataProp": "Location",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jLocation1" >' + oObj.aData.Location + '</label>';

                                        }
                                    },

                                    { "mDataProp": "PDate",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jRegistrationDate1">' + oObj.aData.PDate + '</label>';


                                        }
                                    },
                                    { "mDataProp": "SDate",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSampleCollectionDate1">' + oObj.aData.SDate + '</label>';

                                        }
                                    },
                                    { "mDataProp": "PatientNumber",
                                        "fnRender": function(oObj) {
                                            return '<label id="jPatientNumber1">' + oObj.aData.PatientNumber + '</label>';
                                        }
                                    },
                                    { "mDataProp": "HealthHubID",
                                        "fnRender": function(oObj) {
                                        return '<label id="jHealthHubID1">' + oObj.aData.HealthHubID + '</label>';
                                        }
                                    },
                                    { "mDataProp": "EmployeeID",
                                        "fnRender": function(oObj) {
                                        return '<label id="jEmployeeID1">' + oObj.aData.EmployeeID + '</label>';
                                        }
                                    },
                                    { "mDataProp": "SourceType",
                                        "fnRender": function(oObj) {
                                        return '<label id="jSourceType1">' + oObj.aData.SourceType + '</label>';
                                        }
                                    },
                                    { "mDataProp": "Title",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jTitle1">' + oObj.aData.Title + '</label>';

                                        }
                                    },
                                    { "mDataProp": "Name",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jName1">' + oObj.aData.Name + '</label>';

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
                                                return '	<label id="jClientCode1" >' + '' + '</label>';

                                        }
                                    },

                                     { "mData": "TestInformation",
                                         "mRender": function(data, type, full) {
                                             var value = '';
                                             var subId = '', TestRequested = '', Charged = '', ErrorDesc = '', TestCode = '', RateId = '', TestType = '', FeeId = '', CampId = '', isDiscountable = '';
                                             if (full.TestInformation != null) {
                                                 if (full.TestInformation.length > 0) {
                                                     value = '<table border="1"><thead><th style="display:none">Id</th><th>Test Requested</th><th>Charged</th><th>ErrorDesc</th><th>TestCode</th><th style="display:none">RateId</th><th>TestType</th><th style="display:none">FeeId</th><th style="display:none">CampId</th></thead>';
                                                     for (var i = 0; i < full.TestInformation.length; i++) {
                                                         //debugger;
                                                         value += '<tr><td style="display:none">' + full.TestInformation[i].Id + '</td><td>' + full.TestInformation[i].TestRequested + '</td><td>' + full.TestInformation[i].Charged + '</td><td>' + full.TestInformation[i].ErrorDesc + '</td><td>' + full.TestInformation[i].TestCode + '</td><td style="display:none">' + full.TestInformation[i].RateId + '</td><td>' + full.TestInformation[i].TestType + '</td><td style="display:none">' + full.TestInformation[i].FeeId + '</td><td style="display:none">' + full.TestInformation[i].CampId + '</td></tr>'
                                                         subId += full.TestInformation[i].Id + '~';
                                                         TestRequested += full.TestInformation[i].TestRequested + '~';
                                                         Charged += full.TestInformation[i].Charged + '~';
                                                         ErrorDesc += full.TestInformation[i].ErrorDesc + '~';
                                                         TestCode += full.TestInformation[i].TestCode + '~';
                                                         RateId += full.TestInformation[i].RateId + '~';
                                                         TestType += full.TestInformation[i].TestType + '~';
                                                         FeeId += full.TestInformation[i].FeeId + '~';
                                                         CampId += full.TestInformation[i].CampId + '~';
                                                         isDiscountable += full.TestInformation[i].IsDiscountable + '~';
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
                                                               + '<input type="hidden" id="hdnCharged" value="' + Charged + '"/>'
                                                               + '<input type="hidden" id="hdnErrorDesc" value="' + ErrorDesc + '"/>'
                                                               + '<input type="hidden" id="hdnTestCode" value="' + TestCode + '"/>'
                                                               + '<input type="hidden" id="hdnRateId" value="' + RateId + '"/>'
                                                               + '<input type="hidden" id="hdnTestType" value="' + TestType + '"/>'
                                                               + '<input type="hidden" id="hdnFeeId" value="' + FeeId + '"/>'
                                                               + '<input type="hidden" id="hdnCampId" value="' + CampId + '"/>'
                                                               + '<input type="hidden" id="jIsDiscountable1" value="' + isDiscountable + '"/>';
                                         }
                                     },
                                                                { "mDataProp": "GrossAmount",
                                                                    "fnRender": function(oObj) {
                                                                        return '	<label id="jGrossAmount1" >' + oObj.aData.GrossAmount + '</label>';

                                                                    }
                                                                },

                                            { "mDataProp": "AmountDiscount",
                                                "fnRender": function(oObj) {
                                                    return '	<label id="jDiscountAmount1" >' + oObj.aData.AmountDiscount + '</label>';

                                                }
                                            },
                                                                { "mDataProp": "NetAmount",
                                                                    "fnRender": function(oObj) {
                                                                        return '	<label id="jNetAmount1" text =' + oObj.aData.NetAmount + ' >' + oObj.aData.NetAmount + '</label>';

                                                                    }
                                                                },
                                    { "mDataProp": "AmountPaid", "sWidth": "5px",
                                        "fnRender": function(oObj) {
                                            return '<input id="jAmountPaid1" width=500px type="text" Value=' + oObj.aData.AmountPaid + ' onkeydown="return isNumericss(event,this.id)" onblur="return UpdateAmount(this)"></input>';

                                        }
                                    },
                                     { "mDataProp": "DueAmount",
                                         "fnRender": function(oObj) {
                                             if (oObj.aData.IsCreditBill == 'Y' && parseFloat(oObj.aData.AmountPaid) == 0) {
                                                 return '<label id="jDueAmount1">0</label>';
                                             }
                                             else {
                                                 return '	<label id="jDueAmount1" >' + oObj.aData.DueAmount + '</label>';
                                             }

                                         }
                                     },

                                    { "mDataProp": "SCollectedBy",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSampleCollectedby1" >' + oObj.aData.SCollectedBy + '</label>'
                                            + '<input type="hidden" id="hdnUniqueID1" value="' + oObj.aData.PatId + '" />';

                                        }
                                    },
                                    { "mDataProp": "MobileNo",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jMobileNo1" >' + oObj.aData.MobileNo + '</label>';

                                        }
                                    },
                                    { "mDataProp": "EmailId",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jEmailId1" >' + oObj.aData.EmailId + '</label>';

                                        }
                                    },
                                    { "mDataProp": "DispatchMode",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jDispatchMode1" >' + oObj.aData.DispatchMode + '</label>';

                                        }
                                    },




                                     { "mDataProp": "Doctor",
                                         "fnRender": function(oObj) {
                                             return '	<label id="jDoctor1" >' + oObj.aData.Doctor + '</label>';

                                         }
                                     },
                                    { "mDataProp": "RefHospital",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jRefHospital1" >' + oObj.aData.RefHospital + '</label>'
                                            + '<input type="hidden" id="jPriority1" value="' + oObj.aData.Priority + '"/>'
                                            + '<input type="hidden" id="jDiscountReason1" value="' + oObj.aData.DiscountReason + '"/>'
                                            + '<input type="hidden" id="jDiscountAuthBy1" value="' + oObj.aData.DiscountAuthorisedBy + '"/>'
                                            + '<input type="hidden" id="jCreatedBy1" value="' + oObj.aData.CreatedBy + '"/>'
                                            + '<input type="hidden" id="jErrorStatus1" value="' + oObj.aData.ErrorStatus + '"/>'
                                            + '<input type="hidden" id="hdnClientID" value="' + oObj.aData.ClientID + '" />'
                                                  + '<input type="hidden" id="hdnLocationID" value="' + oObj.aData.LocationID + '" />'
                                                  + '<input type="hidden" id="hdnTitleID" value="' + oObj.aData.TitleID + '" />'
                                                  + '<input type="hidden" id="hdnDoctorID" value="' + oObj.aData.DoctorID + '" />'
                                                  + '<input type="hidden" id="hdnRefHospitalID" value="' + oObj.aData.RefHospitalID + '" />'
                                                  + '<input type="hidden" id="hdnSCollectedByID" value="' + oObj.aData.SCollectedByID + '" />'
                                                  + '<input type="hidden" id="hdnPriorityID" value="' + oObj.aData.PriorityID + '" />'
                                                  + '<input type="hidden" id="hdnCreatedbyId" value="' + oObj.aData.CreatedbyId + '" />'
                                                  + '<input type="hidden" id="hdnOrgId" value="' + oObj.aData.OrgId + '" />'
                                                  + '<input type="hidden" id="hdnDiscountAuthorisedByID" value="' + oObj.aData.DiscountAuthorisedByID + '" />'
                                                  + '<input type="hidden" id="jIsClientPatient1" value="' + oObj.aData.IsClientPatient + '"/>'
                                            //  + '<input type="hidden" id="jIsDiscountable1" value="' + oObj.aData.IsDiscountable + '"/>'
                                                  + '<input type="hidden" id="jHasHealthCoupon1" value="' + oObj.aData.HasHealthCoupon + '"/>'
                                                   + '<input type="hidden" id="jMyCardActiveDays1" value="' + oObj.aData.MyCardActiveDays + '"/>'
                                                    + '<input type="hidden" id="jIsCreditBill1" value="' + oObj.aData.IsCreditBill + '"/>';


                                        }
                                    },
                        //                                    { "mDataProp": "Priority",
                        //                                        "fnRender": function(oObj) {
                        //                                            return '	<label id="jPriority1" >' + oObj.aData.Priority + '</label>';

                        //                                        }
                        //                                    },



                        //                                          { "mDataProp": "DiscountReason",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jDiscountReason1" >' + oObj.aData.DiscountReason + '</label>';

                        //                                              }
                        //                                          },
                        //                                          { "mDataProp": "DiscountAuthorisedBy",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jDiscountAuthBy1" >' + oObj.aData.DiscountAuthorisedBy + '</label>';

                        //                                              }
                        //                                          },
                                          {"mDataProp": "History",
                                          "fnRender": function(oObj) {
                                              return '	<label id="jHistory1" >' + oObj.aData.History + '</label>';

                                          }
                                      },
                                          { "mDataProp": "Remarks",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jRemarks1" >' + oObj.aData.Remarks + '</label>';

                                              }
                                          },
                                          { "mDataProp": "BookingID",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jBookingID" >' + oObj.aData.BookingID + '</label>';

                                              }
                                          },
                                          { "mDataProp": "ExternalRefNo",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jExternalRefNo" >' + oObj.aData.ExternalRefNo + '</label>';

                                              }
                                          },
                                          { "mDataProp": "SampleNumber",
                                              "fnRender": function(oObj) {
                                                  return '	<label id="jSampleNumber" >' + oObj.aData.SampleNumber + '</label>';

                                              }
                                          }

                        //                                          { "mDataProp": "CreatedBy",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jCreatedBy1" >' + oObj.aData.CreatedBy + '</label>';

                        //                                              }
                        //                                          },



                        //                                          { "mDataProp": "ErrorStatus",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jErrorStatus1" >' + oObj.aData.ErrorStatus + '</label>'
                        //                                                  + '<input type="hidden" id="hdnClientID" value="' + oObj.aData.ClientID + '" />'
                        //                                                  + '<input type="hidden" id="hdnLocationID" value="' + oObj.aData.LocationID + '" />'
                        //                                                  + '<input type="hidden" id="hdnTitleID" value="' + oObj.aData.TitleID + '" />'
                        //                                                  + '<input type="hidden" id="hdnDoctorID" value="' + oObj.aData.DoctorID + '" />'
                        //                                                  + '<input type="hidden" id="hdnRefHospitalID" value="' + oObj.aData.RefHospitalID + '" />'
                        //                                                  + '<input type="hidden" id="hdnSCollectedByID" value="' + oObj.aData.SCollectedByID + '" />'
                        //                                                  + '<input type="hidden" id="hdnPriorityID" value="' + oObj.aData.PriorityID + '" />'
                        //                                                  + '<input type="hidden" id="hdnCreatedbyId" value="' + oObj.aData.CreatedbyId + '" />'
                        //                                                  + '<input type="hidden" id="hdnOrgId" value="' + oObj.aData.OrgId + '" />'
                        //                                                  + '<input type="hidden" id="hdnDiscountAuthorisedByID" value="' + oObj.aData.DiscountAuthorisedByID + '" />';

                        //                                                  // + '<input type ="hidden" id="hdnErrorStatus" value=' + oObj.aData.ErrorStatus + '>';

                        //                                              }
                        //                                          },

                        //                                          { "mDataProp": "IsClientPatient",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jIsClientPatient1" >' + oObj.aData.IsClientPatient + '</label>';

                        //                                              }
                        //                                          },

                        //                                          { "mDataProp": "IsDiscountable",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jIsDiscountable1" >' + oObj.aData.IsDiscountable + '</label>';

                        //                                              }
                        //                                          },


                        //                                          { "mDataProp": "HasHealthCoupon",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jHasHealthCoupon1" >' + oObj.aData.HasHealthCoupon + '</label>';

                        //                                              }
                        //                                          },
                        //                                          { "mDataProp": "MyCardActiveDays",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jMyCardActiveDays1" >' + oObj.aData.MyCardActiveDays + '</label>';

                        //                                              }
                        //                                          },
                        //                                          { "mDataProp": "IsCreditBill",
                        //                                              "fnRender": function(oObj) {
                        //                                                  return '	<label id="jIsCreditBill1" >' + oObj.aData.IsCreditBill + '</label>';

                        //                                              }
                        //                                          },








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
        debugger;
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
                var OrgName = $row.find("#jOrgName").text();
                var SlNo = $row.find("#jSlNo").text();
                var RegistrationDate = $row.find("#jRegistrationDate").text();
//                if (RegistrationDate == "" || isNaN(Date.parse(RegistrationDate)))
//                    RegistrationDate = "01-01-1900";

                var SampleCollectionDate = $row.find("#jSampleCollectionDate").text();
//                if (SampleCollectionDate == "" || isNaN(Date.parse(SampleCollectionDate)))
//                    SampleCollectionDate = "01-01-1900";
                var SampleCollectedby = $row.find("#jSampleCollectedby").text();
                var UniqueID = $row.find("#hdnUniqueID").val();
                var HealthHubID = $row.find("#jHealthHubID").text();
                var EmployeeID = $row.find("#jEmployeeID").text();
                var SourceType = $row.find("#jSourceType").text();
                var Title = $row.find("#jTitle").text();
                var Name = $row.find("#jName").text();
                var DOB = $row.find("#jDOB").text();
                if (DOB == "" || isNaN(Date.parse(DOB)))
                    DOB = "01-01-1900";
                var Age = $row.find("#jAge").text();
                var AgeType = $row.find("#jAgeType").text();
                var Sex = $row.find("#jSex").text();
                var Location = $row.find("#jLocation").text();
                var Doctor = $row.find("#jDoctor").text();
                var RefHospital = $row.find("#jRefHospital").text();
                var Priority = $row.find("#jPriority").val();
                var DispatchMode = $row.find("#jDispatchMode").text();
                var TestRequested = $row.find("#jTestRequested").text();
                var Charged = $row.find("#jCharged").val();
                var AmountPaid = $row.find("#jAmountPaid").val();
                if (AmountPaid == '' || AmountPaid == '.')
                    AmountPaid = '0';
                // $('#hdnPreviousAmount').val(AmountPaid);
                var DiscountAmount = $row.find("#jDiscountAmount").text();
                var DiscountReason = $row.find("#jDiscountReason").val();
                var DiscountAuthBy = $row.find("#jDiscountAuthBy").val();
                var History = $row.find("#jHistory").text();
                var Remarks = $row.find("#jRemarks").text();
                var MobileNo = $row.find("#jMobileNo").text();
                var CreatedBy = $row.find("#jCreatedBy").val();
                var ClientCode = $row.find("#jClientCode").text();
                var EmailId = $row.find("#jEmailId").text();
                var PatientNumber = $row.find("#jPatientNumber").text();
				var BookingID = $row.find("#jBookingID").text();
                var ExternalRefNo = $row.find("#jExternalRefNo").text();
                var SampleNumber = $row.find("#jSampleNumber").text(); 
                dtBulkReg.push({
                    OrgName: OrgName,
                    SlNo: SlNo,
                    PDate: RegistrationDate,
                    SDate: SampleCollectionDate,
                    SCollectedBy: SampleCollectedby,
                    PatId: UniqueID,
                    HealthHubID: HealthHubID,
                    EmployeeID: EmployeeID,
                    SourceType: SourceType,
                    Title: Title,
                    Name: Name,
                    DOB: DOB,
                    Age: Age,
                    AgeType: AgeType,
                    Sex: Sex,
                    Location: Location,
                    Doctor: Doctor,
                    RefHospital: RefHospital,
                    Priority: Priority,
                    DispatchMode: DispatchMode,
                    TestRequested: TestRequested,
                    Charged: Charged,
                    AmountPaid: AmountPaid,
                    AmountDiscount: DiscountAmount,
                    DiscountReason: DiscountReason,
                    DiscountAuthorisedBy: DiscountAuthBy,
                    History: History,
                    Remarks: Remarks,
					BookingID:BookingID,
				    ExternalRefNo:ExternalRefNo,
				    SampleNumber: SampleNumber,
                    MobileNo: MobileNo,
                    CreatedBy: CreatedBy,
                    ClientCode: ClientCode,
                    EmailId: EmailId,
                    PatientNumber: PatientNumber
                });

            });
            var list = JSON.stringify(dtBulkReg);
            $("input:hidden[id$=hdnBulkRegTable]").val(list);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ValidateCovidBulkRegistrationDetails",
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
                var AmountPaid = 0;
                var NetAmount = 0;
                AmountPaid = $row.find('#jAmountPaid1').val();
                NetAmount = $row.find('#jNetAmount1').text();




                var ErrorStatus = $row.find("#jErrorStatus1").val();
                if (ErrorStatus == "true") {
                    ErrorCount = 1;
                    alert('Error Data is not allowed for Billing, Please uncheck the Teal color rows');
                    return false;
                }

                if (parseFloat(AmountPaid) > parseFloat(NetAmount)) {
                    ErrorCount = 1;
                    alert('AmountPaid is greater than NetAmount');
                    $row.find('#jAmountPaid1').focus();
                    return false;
                }

                var isCreditBill = $row.find('#jIsCreditBill1').val();
                if (isCreditBill == "Y" && parseFloat(AmountPaid) > 0) {
                    ErrorCount = 1;
                    alert('Amount Receive should be zero for Credit Client');
                    $row.find('#jAmountPaid1').focus();
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
        //debugger;
        //document.getElementById('fulSelect').value='';
        $('#btnSave').hide();
        $('#panelPopup').show();
        // $find("modalpopup").show();
        // debugger;
        var dtCampDetail = [];
        var dtTestCampDetails = [];
        var chkcount = 0;
        var j = 0;
        try {
            $("#example1 tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var checked = $row.find("input[id$='chkjdatatable1']").is(":checked");
                if (checked) {
                    chkcount++;
                    var Id = $row.find("#jId1").text();
                    var OrgName = $row.find("#jOrgName1").text();
                    var SlNo = $row.find("#hdnSlNo").val();
                    var RegistrationDate = $row.find("#jRegistrationDate1").text();
                    var SampleCollectionDate = $row.find("#jSampleCollectionDate1").text();
                    var SampleCollectedby = $row.find("#jSampleCollectedby1").text();
                    var UniqueID = $row.find("#hdnUniqueID1").val();
                    var HealthHubID = $row.find("#jHealthHubID1").text();
                    var EmployeeID = $row.find("#jEmployeeID1").text();
                    var SourceType = $row.find("#jSourceType1").text();
                    var Title = $row.find("#jTitle1").text();
                    var Name = $row.find("#jName1").text();
                    var DOB = $row.find('#jDOB1').text();
                    if (DOB == "")
                        DOB = "01-01-1900";
                    var Age = $row.find("#jAge1").text(); 
                    var AgeType = $row.find("#jAgeType1").text();
                    var Sex = $row.find("#jSex1").text();
                    var Location = $row.find("#jLocation1").text();
                    var Doctor = $row.find("#jDoctor1").text();
                    var RefHospital = $row.find("#jRefHospital1").text();
                    var Priority = $row.find("#jPriority1").val();
                    var DispatchMode = $row.find("#jDispatchMode1").text();
                    var AmountPaid = $row.find("#jAmountPaid1").val();
                    if (AmountPaid == '' || AmountPaid == '.')
                        AmountPaid = '0';
                    var DiscountAmount = $row.find("#jDiscountAmount1").text();
                    var DiscountReason = $row.find("#jDiscountReason1").val();
                    var DiscountAuthBy = $row.find("#jDiscountAuthBy1").val();
                    var History = $row.find("#jHistory1").text();
                    var Remarks = $row.find("#jRemarks1").text();
                    var MobileNo = $row.find("#jMobileNo1").text();
                    var CreatedBy = $row.find("#jCreatedBy1").val();
                    var ClientCode = $row.find("#hdnjClientCode1").val();
                    var EmailId = $row.find("#jEmailId1").text();
                    var ErrorStatus = $row.find("#jErrorStatus1").val();
                    var PatientNumber = $row.find('#jPatientNumber1').text();
                    var ClientID = $row.find("#hdnClientID").val();
                    var LocationID = $row.find("#hdnLocationID").val();
                    var TitleID = $row.find("#hdnTitleID").val();
                    var DoctorID = $row.find("#hdnDoctorID").val();
                    var RefHospitalID = $row.find("#hdnRefHospitalID").val();
                    var SCollectedByID = $row.find("#hdnSCollectedByID").val();
                    var PriorityID = $row.find("#hdnPriorityID").val();
                    var IsClientPatient = $row.find("#jIsClientPatient1").val();
                    var CreatedbyId = $row.find("#hdnCreatedbyId").val();
                    // var IsDiscountable = $row.find("#jIsDiscountable1").val();
                    var DueAmount = $row.find("#jDueAmount1").text();
                    var OrgId = $row.find("#hdnOrgId").val();
                    var DiscountAuthorisedByID = $row.find("#hdnDiscountAuthorisedByID").val();
                    var HasHealthCoupon = $row.find("#jHasHealthCoupon1").val();
                    var MyCardActiveDays = $row.find("#jMyCardActiveDays1").val();
                    var IsCreditBill = $row.find("#jIsCreditBill1").val();
                    var BookingID = $row.find("#jBookingID").text();
                    var ExternalRefNo = $row.find("#jExternalRefNo").text();
                    var SampleNumber = $row.find("#jSampleNumber").text();
                    //var splitCount = $('#hdnSubId').val().split("~");
                    dtCampDetail.push({
                        Id: Id,
                        OrgName: OrgName,
                        SlNo: SlNo,
                        PDate: RegistrationDate,
                        SDate: SampleCollectionDate,
                        SCollectedBy: SampleCollectedby,
                        PatId: UniqueID,
                        HealthHubID: HealthHubID,
                        EmployeeID: EmployeeID,
                        SourceType: SourceType,
                        Title: Title,
                        Name: Name,
                        DOB: DOB,
                        Age: Age,
                        AgeType: AgeType,
                        Sex: Sex,
                        Location: Location,
                        Doctor: Doctor,
                        RefHospital: RefHospital,
                        Priority: Priority,
                        DispatchMode: DispatchMode,
                        AmountPaid: AmountPaid,
                        AmountDiscount: DiscountAmount,
                        DiscountReason: DiscountReason,
                        DiscountAuthorisedBy: DiscountAuthBy,
                        History: History,
                        Remarks: Remarks,
                        MobileNo: MobileNo,
                        CreatedBy: CreatedBy,
                        ClientCode: ClientCode,
                        EmailId: EmailId,
                        PatientNumber: PatientNumber,
                        ErrorStatus: ErrorStatus,
                        ClientID: ClientID,
                        LocationID: LocationID,
                        TitleID: TitleID,
                        DoctorID: DoctorID,
                        RefHospitalID: RefHospitalID,
                        SCollectedByID: SCollectedByID,
                        PriorityID: PriorityID,
                        IsClientPatient: IsClientPatient,
                        CreatedbyId: CreatedbyId,
                        //IsDiscountable: IsDiscountable,
                        DueAmount: DueAmount,
                        OrgId: OrgId,
                        DiscountAuthorisedByID: DiscountAuthorisedByID,
                        HasHealthCoupon: HasHealthCoupon,
                        MyCardActiveDays: MyCardActiveDays,
                        IsCreditBill: IsCreditBill,
                        BookingID:BookingID,
				        ExternalRefNo:ExternalRefNo,
				        SampleNumber: SampleNumber
                    });


                    for (j = 0; j < $row.find('#hdnSubId').val().split("~").length - 1; j++) {
                        //debugger;
                        dtTestCampDetails.push({
                            Id: $row.find('#hdnSubId').val().split("~")[j],
                            TestRequested: $row.find('#hdnTestRequested').val().split("~")[j],
                            Charged: $row.find('#hdnCharged').val().split("~")[j],
                            ErrorDesc: $row.find('#hdnErrorDesc').val().split("~")[j],
                            TestCode: $row.find('#hdnTestCode').val().split("~")[j],
                            RateId: $row.find('#hdnRateId').val().split("~")[j],
                            TestType: $row.find('#hdnTestType').val().split("~")[j],
                            FeeId: $row.find('#hdnFeeId').val().split("~")[j],
                            CampId: $row.find('#hdnCampId').val().split("~")[j],
                            IsDiscountable: $row.find('#jIsDiscountable1').val().split("~")[j]

                        });

                    }

                }
            });



            var list = JSON.stringify(dtCampDetail);
            var Testlist = JSON.stringify(dtTestCampDetails);

            $("input:hidden[id$=hdnCampDetails]").val(list);
            $("input:hidden[id$=hdnTestCampDetails]").val(Testlist);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveCovidBulkRegistrationDetails",
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
            alert('Error Occured');
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
                            { "mDataProp": "VisitNumber",
                                "fnRender": function(oObj) {
                                    //   debugger;
                                    return '<label id="dtVisitNumber">' + oObj.aData.VisitNumber + '</label>';
                                }

                            },
                            { "mDataProp": "PatientNumber",
                                "fnRender": function(oObj) {
                                    return '<label id="dtPatientNumber">' + oObj.aData.PatientNumber + '</label>';
                                }
                            },

                            { "mDataProp": "Name",
                                "fnRender": function(oObj) {
                                    return '<label id="dtName">' + oObj.aData.Name + '</label>';
                                }
                            },
                            { "mDataProp": "BillNumber",
                                "fnRender": function(oObj) {
                                    return '<label id="dtName">' + oObj.aData.BillNumber + '</label>';
                                }
                            },
                            { "mDataProp": "TestDetails",
                                "fnRender": function(oObj) {
                                    return '<label id="dtName">' + oObj.aData.TestDetails + '</label>';
                                }
                            },
                            { "mDataProp": "Location",
                                "fnRender": function(oObj) {
                                    return '<label id="dtName">' + oObj.aData.Location + '</label>';
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
      <%--      <tr id="tdAberrant" runat="server" style="display: none;">
                <td class="w-100p a-right">
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <uc11:AbbrentQueue ID="AbbrentQueue" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>--%>
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
                        <table>
                            <tr id="ACX2responsesRateCard" style="display: none;" class="tablerow" runat="server">
                                <td id="Td7" runat="server">
                                    <table style="height: 80px">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkXls" Style="color: Blue; font-size: 14px" runat="server" Text="Click here for download Bulk Registration template"
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
                                    <table cellspacing="5">
                                        <tr style="display: none;">
                                            <td>
                                                Select Upload type
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlSelectedType" runat="server" Style="display: none;">
                                                    <asp:ListItem Value="1"> Patient Registration</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
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
                            <tr align="left">
                                <td>
                                    <asp:Label ID="lblSelectFile" runat="server" Text=" Select File :" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                </td>
                                <td>
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
                        <div id="dvExcel" style="max-width:1350px;overflow: auto;max-height: 450px;">
                            <asp:Panel ID="Panel1" runat="server">
                                <table width="80%" border="0">
                                    <tr>
                                        <td id="lblSample" runat="server">
                                            <table id="example" style="width:100%;overflow:scroll;min-height:200px;">
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
                                                            Registration Date
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Sample Collected Date & Time
                                                        </th>
                                                        <th align="center" width="15%">
                                                            Patient Number
                                                        </th>
                                                        <th align="center" width="15%">
                                                            HealthHub ID
                                                        </th>
                                                        <th align="center" width="15%">
                                                            Employee ID
                                                        </th>
                                                        <th align="center" width="15%">
                                                            Source Type
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Title
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Name
                                                        </th>
                                                        <th align="center" width="10%">
                                                            DOB
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Age
                                                        </th>
                                                        <th align="center" width="10%">
                                                            AgeType
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Sex
                                                        </th>
                                                        <th align="center" width="10%">
                                                            TestRequested
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Amount Paid
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Discount Amount
                                                        </th>
                                                        <th align="center" width="10%">
                                                            ClientCode
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Sample Collected By
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
                                                            Doctor
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Ref Hospital
                                                        </th>
                                                        <%--<th align="center" width="10%" style="display:none">
                                                            Priority
                                                        </th>--%>
                                                        <%-- <th align="center" width="10%" style="display:none">
                                                            Charged
                                                        </th>--%>
                                                        <%-- <th align="center" width="10%" style="display:none">
                                                            Discount Reason
                                                        </th>
                                                        <th align="center" width="10%" style="display:none">
                                                            Discount Authorised By
                                                        </th>--%>
                                                        <th align="center" width="10%">
                                                            History
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Remarks
                                                        </th>
                                                        <th align="center" width="10%">
                                                            BookingID
                                                        </th>
                                                        <th align="center" width="10%">
                                                            ExternalRefNo
                                                        </th>
                                                        <th align="center" width="10%">
                                                            SampleNumber
                                                        </th>
                                                        <%--<th align="center" width="10%" style="display:none">
                                                            CreatedBy
                                                        </th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <div id="dvValidate" style="max-width:1350px;overflow: auto;max-height: 450px;">
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
                                                        <th align="center">
                                                            SlNo
                                                        </th>
                                                        <th align="center">
                                                            OrgName
                                                        </th>
                                                        <th align="center">
                                                            Location
                                                        </th>
                                                        <th align="center">
                                                            Registration Date
                                                        </th>
                                                        <th align="center">
                                                            Sample Collected Date & Time
                                                        </th>
                                                        <th align="center">
                                                            Patient Number
                                                        </th>
                                                        <th align="center">
                                                            HealthHub ID
                                                        </th>
                                                        <th align="center">
                                                            Employee ID
                                                        </th>
                                                        <th align="center">
                                                            Source Type
                                                        </th>
                                                        <th align="center">
                                                            Title
                                                        </th>
                                                        <th align="center">
                                                            Patient Name
                                                        </th>
                                                        <th align="center">
                                                            DOB
                                                        </th>
                                                        <th align="center">
                                                            Age
                                                        </th>
                                                        <th align="center">
                                                            AgeType
                                                        </th>
                                                        <th align="center">
                                                            Sex
                                                        </th>
                                                        <th align="center">
                                                            ClientName
                                                        </th>
                                                        <th align="center">
                                                            TestInformation
                                                        </th>
                                                        <th align="center">
                                                            Gross Amount
                                                        </th>
                                                        <th align="center">
                                                            Discount Amount
                                                        </th>
                                                        <th align="center">
                                                            Net Amount
                                                        </th>
                                                        <th align="center" style="width: 15px">
                                                            Amount Paid
                                                        </th>
                                                        <th align="center">
                                                            DueAmount
                                                        </th>
                                                        <th align="center">
                                                            Sample Collected By
                                                        </th>
                                                        <th align="center">
                                                            MobileNo
                                                        </th>
                                                        <%-- <th align="center" >
                                                            CreatedBy
                                                        </th>--%>
                                                        <th align="center">
                                                            Email ID
                                                        </th>
                                                        <th align="center">
                                                            Dispatch Mode
                                                        </th>
                                                        <th align="center">
                                                            Doctor
                                                        </th>
                                                        <th align="center">
                                                            Ref Hospital
                                                        </th>
                                                        <%-- <th align="center" width="10%">
                                                            Priority
                                                        </th>--%>
                                                        <%-- %>   <th align="center" width="10%">
                                                        TestRequested
                                                    </th>
                                                    <th align="center" width="10%">
                                                        Charged
                                                    </th> --%>
                                                        <%-- <th align="center" width="10%">
                                                            Discount Reason
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Discount Authorised By
                                                        </th>--%>
                                                        <th align="center">
                                                            History
                                                        </th>
                                                        <th align="center">
                                                            Remarks
                                                        </th> 
                                                        <th align="center" width="10%">
                                                            BookingID
                                                        </th>
                                                        <th align="center" width="10%">
                                                            ExternalRefNo
                                                        </th>
                                                        <th align="center" width="10%">
                                                            SampleNumber
                                                        </th>
                                                        <%--<th align="center" width="10%">
                                                            Error Status
                                                        </th>--%>
                                                        <%--  <th align="center" width="10%">
                                                        Error Desc
                                                    </th> --%>
                                                        <%-- <th align="center" width="10%">
                                                        TestCode
                                                    </th>--%>
                                                        <%--  <th align="center" width="10%">
                                                            IsClientPatient
                                                        </th>--%>
                                                        <%--   <th align="center" width="10%">
                                                        RateId
                                                    </th>
                                                    <th align="center" width="10%">
                                                        TestType
                                                    </th>
                                                    <th align="center" width="10%">
                                                        FeeId
                                                    </th>
                                                    <th align="center" width="10%">
                                                        CampId
                                                    </th>  
                                                        <th align="center" width="10%">
                                                            IsDiscountable
                                                        </th>--%>
                                                        <%--    <th align="center" width="10%">
                                                            HasHealthCoupon
                                                        </th>
                                                        <th align="center" width="10%">
                                                            MyCardActiveDays
                                                        </th>
                                                        <th align="center" width="10%">
                                                            IsCreditBill
                                                        </th>--%>
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
                                                            Visit Number
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Patient Number
                                                        </th>
                                                        <th align="center" width="20%">
                                                            Name
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Bill Number
                                                        </th>
                                                        <th align="center" width="30%">
                                                            Test Details
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
                                    <asp:Button ID="btnValidateData" runat="server" Text="ValidateData" OnClientClick="return ValidateData();" />
                                    <%--<asp:Button ID="btnValidate" runat="server" Text="Validate" OnClientClick="return ValidateData();"/>--%>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return ValidateErrorIsFound(); return false" />
                                    <asp:Button ID="btnClearall" runat="server" Text="Clear" OnClientClick="return ClearAll();" />
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

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>
</html>
