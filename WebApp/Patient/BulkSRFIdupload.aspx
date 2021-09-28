<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BulkSRFIdupload.aspx.cs" Inherits="Inventory_CovidBulkRegistration" meta:resourcekey="PageResource1" %>

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
<title>Bulk SRF ID Upload</title>
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
//            else if (extension[1] == 'xlsx' || extension[1] == 'XLSX') {
//                alert('Excel should be in xls format');
//                return false;
//            }
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
            debugger;
            $("#dvExcel").show();
            $("#dvValidate").hide();

            var value = $('#lblCurrent').text();
            if (value == '') {
                value = 1;
            }
            var a = parseInt(value - 1) * 250;
            var b = (parseInt(value)) * 250;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/CovidBulkSRFIDUpload",
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
                                return '	<label id="jSlNo" style="text-align:center">' + oObj.aData.SlNo + '</label>';
                            }

                        },
                          { "mDataProp": "Name",
                              "fnRender": function(oObj) {
                                  return '<label id="jName">' + oObj.aData.Name + '</label>';
                              }
                          },
                          { "mDataProp": "Sex",
                              "fnRender": function(oObj) {
                                  var gender = oObj.aData.Sex == "M" ? "Male" : "Female";
                                  return '	<label id="jSex" >' + gender + '</label>';
                              }
                          },
                              { "mDataProp": "Age",
                                  "fnRender": function(oObj) {
                                      return '	<label id="jAge">' + oObj.aData.Age + '</label>';
                                  }
                              },
                            { "mDataProp": "MobileNo",
                                "fnRender": function(oObj) {
                                    return '	<label id="jMobileNo" >' + oObj.aData.MobileNo + '</label>';
                                }
},
                                                     { "mDataProp": "EmployeeID",
                                                         "fnRender": function(oObj) {
                                                             return '<label id="jEmployeeID">' + oObj.aData.EmployeeID + '</label>'; //mrnnumber
                                                         }

                                                     },
                                                      { "mDataProp": "PatientNumber",
                                                          "fnRender": function(oObj) {
                                                              return '<label id="jPatientNumber">' + oObj.aData.PatientNumber + '</label>';//visitnumber
                                                          }
                                                      },
                                                        { "mDataProp": "PDate",
                                                            "fnRender": function(oObj) {                                        
                                                                return '	<label id="jRegistrationDate">' + oObj.aData.PDate + '</label>';//visitdate
                                                            }
                                                        },
                                                       { "mDataProp": "SourceType",
                                                           "fnRender": function(oObj) {
                                                               return '<label id="jSourceType">' + oObj.aData.SourceType + '</label>';///srf id (y/n)
                                                           }

                                                       },
                                                     { "mDataProp": "HealthHubID",
                                                         "fnRender": function(oObj) {
                                                             return '<label id="jHealthHubID">' + oObj.aData.HealthHubID + '</label>';//srfid
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
                var error;
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
                                    { "mDataProp": "Name",
                                        "fnRender": function(oObj) {
                                            return '<label id="jName1">' + oObj.aData.Name + '</label>'
                                            + '<input type="hidden" id="hdnSlNo" value="' + oObj.aData.SlNo + '" />';
                                        }
                                    },
                                    { "mDataProp": "Location",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jSex1" >' + oObj.aData.Sex + '</label>';
                                        }
                                    },

                                    { "mDataProp": "Age",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jAge1">' + oObj.aData.Age + " " + oObj.aData.AgeType + '</label>';
                                        }
                                    },
                                    { "mDataProp": "MobileNo",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jMobileNo1">' + oObj.aData.MobileNo + '</label>';
                                        }
                                    },
                                    { "mDataProp": "EmployeeID",
                                        "fnRender": function(oObj) {
                                            return '<label id="jEmployeeID1">' + oObj.aData.EmployeeID + '</label>';
                                        }
                                    },
                                    { "mDataProp": "PatientNumber",
                                        "fnRender": function(oObj) {
                                            return '<label id="jPatientNumber1">' + oObj.aData.PatientNumber + '</label>';
                                        }
                                    },
                                    { "mDataProp": "PDate",
                                        "fnRender": function(oObj) {
                                            return '<label id="jPDate1">' + oObj.aData.PDate + '</label>';
                                        }
                                    },
                                    { "mDataProp": "SourceType",
                                        "fnRender": function(oObj) {
                                            return '<label id="jSourceType1">' + oObj.aData.SourceType + '</label>';
                                        }
                                    },
                                    { "mDataProp": "HealthHubID",
                                        "fnRender": function(oObj) {
                                            return '	<label id="jHealthHubID1">' + oObj.aData.HealthHubID + '</label>';

                                        }
                                    },
                                    { "mDataProp": "ErrorStatus",
                                        "fnRender": function(oObj) {
                                            error = oObj.aData.ErrorStatus;
                                            return '	<label id="jErrorStatus1">' + oObj.aData.ErrorStatus + '</label>';

                                        }
                                    },
                                      { "mDataProp": "ErrorDesc",
                                          "fnRender": function(oObj) {
                                              debugger;
                                              var errorstatus = error == true ? oObj.aData.TestInformation[0].ErrorDesc : "";
                                              error = false;
                                              return '	<label id="jErrorMsg1">' + errorstatus + '</label>';

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
             //   var OrgName = $row.find("#jOrgName").text();
                var SlNo = $row.find("#jSlNo").text();
                var Name = $row.find("#jName").text();
                var Sex = $row.find("#jSex").text();
                var Age = $row.find("#jAge").text();
                var MobileNo = $row.find("#jMobileNo").text();
                var EmployeeID = $row.find("#jEmployeeID").text(); //mrn number
                var PatientNumber = $row.find("#jPatientNumber").text();//visit number
                var Visitdate = $row.find("#jRegistrationDate").text(); //visit date
                var SourceType = $row.find("#jSourceType").text();//srfid (y/n)
                var HealthHubID = $row.find("#jHealthHubID").text();//srf id
                
                dtBulkReg.push({                    
                    SlNo: SlNo,
                    Name: Name,
                    Sex: Sex,
                    Age: Age,
                    MobileNo: MobileNo,
                    EmployeeID: EmployeeID,
                    PatientNumber: PatientNumber,
                    PDate: Visitdate,
                    SourceType: SourceType,
                    HealthHubID: HealthHubID
                });

            });
            var list = JSON.stringify(dtBulkReg);
            $("input:hidden[id$=hdnBulkRegTable]").val(list);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ValidateBulkSRFIDUpload",
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
                    alert('Error Data is not allowed for Updation, Please uncheck the Teal color rows');
                    return false;
                }
            }

        });
        if (chkcount == 0) {
            alert('Please select atleast one row to update');
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
                    var PName = $row.find("#jName1").text();
                    var SlNo = $row.find("#hdnSlNo").val();
                    var Age = $row.find("#jAge1").text();
                    var ageary = Age.split(" ");
                    Age = ageary[0];
                    var AgeType = ageary[1];
                    var Sex = $row.find("#jSex1").text();
                    var MobileNo = $row.find("#jMobileNo1").text()
                    var EmployeeID = $row.find("#jEmployeeID1").text();
                    var PatientNumber = $row.find('#jPatientNumber1').text();
                    var Pdate = $row.find('#jPDate1').text();
                    var SourceType = $row.find("#jSourceType1").text();
                    var HealthHubID = $row.find("#jHealthHubID1").text();
                    var ErrorStatus = $row.find("#jErrorStatus1").val();
                    ErrorStatus = ErrorStatus == "true" ? true:false
                    dtCampDetail.push({
                        Id: Id,
                        SlNo: SlNo,
                        Name: PName,
                        Sex: Sex,
                        Age: Age,
                        AgeType: AgeType,
                        MobileNo: MobileNo,
                        EmployeeID: EmployeeID,
                        PatientNumber: PatientNumber,
                        PDate: Pdate,
                        SourceType: SourceType,
                        HealthHubID: HealthHubID,
                        ErrorStatus: ErrorStatus
                    });
                }
            });

            debugger;
            var list = JSON.stringify(dtCampDetail);
            var Testlist = JSON.stringify(dtTestCampDetails);

            $("input:hidden[id$=hdnCampDetails]").val(list);
            $("input:hidden[id$=hdnTestCampDetails]").val(Testlist);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveBulkSRFIDUpload",
                contentType: "application/json; charset=utf-8",
                data: "{ list: '" + $('#hdnCampDetails').val() + "'}",
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
                            { "mDataProp": "Name",
                                "fnRender": function(oObj) {
                                    return '<label id="dtName">' + oObj.aData.Name + '</label>';
                                }
                            },
                            { "mDataProp": "HealthHubID",
                                "fnRender": function(oObj) {
                                return '<label id="dtName">' + oObj.aData.BillNumber + '</label>';
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
                });

               // $('#dvShowResult').Show();  -- Seetha Comment
                $('#dvShowResult').hide(); // -- Seetha Added
                $('#dvValidate').hide();
                $('#btnSave').hide();
                
                // $('#btnClearall').show(); -- Seetha Comment
                $('#btnClearall').hide(); // -- Seetha Added 
                 
                //  $find("modalpopup").hide();
                $('#panelPopup').hide();
              //  $('#<%=fulSelect.ClientID%>').val('');
                //                $('#selectall').prop('checked', false);
                $('#example1').hide();
                $('#dvShowResult').hide();
                $('#lblSample').hide();
                //$("#lblStatus").show();
                $("#pnlFooter").hide();
                //$find("modalpopup").hide();
                $('#panelPopup').hide();
                //arun changes
                $('#pnlShowResult').show();
                $('#dvShowResult').show();                  
                $('#example2').show();                  
                alert('Record Updated successfully');
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
                                       
                                        <tr id="trExcelColor" runat="server" style="display: block;">
                                            <td colspan="2">                                               
                                                <asp:TextBox ID="txtOptional" Style="background-color: #669999;" ReadOnly="True"
                                                    runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                                                <asp:Label ID="lblOptional" Text="Error" runat="server"></asp:Label>&nbsp;
                                                
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
                                            <table id="example" style="overflow:scroll;">
                                                <thead>
                                                    <tr>
                                                        <%--     <th width="50%">
                                                       <input type="checkbox" id="all" />
                                                    </th>  --%>
                                                        <th align="center" width="10%">
                                                            SlNo
                                                        </th>
                                                        <th align="center" width="20%">
                                                            Patient Name
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Gender
                                                        </th>
                                                           <th align="center" width="10%">
                                                            Age
                                                        </th>
                                                       <th align="center" width="10%">
                                                            Mobile Number
                                                        </th>
                                                         <th align="center" width="10%">
                                                            MRN Number
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Visit Number
                                                        </th>                                                        
                                                        <th align="center" width="10%">
                                                            Visit Date
                                                        </th>
                                                        <th align="center" width="10%">
                                                            SRFID(Y/N)
                                                        </th>
                                                      <th align="center" width="15%">
                                                            SRFID
                                                        </th>                                             
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
                                                          <th align="center" width="10%">
                                                            Patient Name
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Gender
                                                        </th>
                                                           <th align="center" width="10%">
                                                            Age
                                                        </th>
                                                       <th align="center" width="10%">
                                                            Mobile Number
                                                        </th>
                                                         <th align="center" width="10%">
                                                            MRN Number
                                                        </th>
                                                        <th align="center" width="10%">
                                                            Visit Number
                                                        </th>                                                        
                                                        <th align="center" width="10%">
                                                            Visit Date
                                                        </th>
                                                        <th align="center" width="10%">
                                                            SRFID(Y/N)
                                                        </th>
                                                      <th align="center" width="15%">
                                                            SRFID
                                                        </th>  
                                                        <th align="center" width="15%">
                                                            Error Status
                                                        </th>   
                                                        <th align="center" width="25%">
                                                            Error Desc
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
                                                            Visit Number
                                                        </th>                                                        
                                                        <th align="center" width="20%">
                                                            Name
                                                        </th>
                                                        <th align="center" width="10%">
                                                            SRF ID
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
