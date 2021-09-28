<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DoctorWiseReport.aspx.cs"
    Inherits="Reports_DoctorWiseReport" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Wise Report</title>
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <%--<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
    <%-- <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
   
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">

      

        <table id="tbldrWise" style="/* padding: 10px; */
    padding-left: 5%; width: 100%; margin-top: 10px;">
            <tr>
                <td>
                    From
                </td>
                <td>
                    <input id="txtFDate" type="text" /><img src="../Images/starbutton.png" alt="" class="a-center">
                </td>
                <td>
                    To
                </td>
                <td>
                    <input id="txtTDate" type="text" />&nbsp;<img src="../Images/starbutton.png" alt="" class="a-center">
                </td>
                <td>
                    Histopathology No
                </td>
                <td>
                    <input id="HistoNos" type="text" />
                </td>
                <td>
                    Approved By
                </td>
                <td>
                    <input id="txtHApproved" type="text" onkeyup="ContainerAutoCom()" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                    <input type="button" value="Clear" id="btnClear" class="btn" onclick="ClearAll();"/>
                    <input type="button" value="Search" id="btnSearch" class="btn" onclick="searchData();" />                   
                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>                                       
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <div id="divtdtable" style="display:none">
        <table id="example" border="2" class="w-100p gridView">
        </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnApprveID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnMessages" Value="" runat="server" />

  <%--  <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>--%>

    <script src="../Scripts/jquery.dataTables.min1.10.10.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.table2excel.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.print.min.js"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>

    <link href="../Scripts/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    </form>
     <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
  

  <script type="text/javascript">
      $(function() {
          $("#txtFDate").datetimepicker({
              dateFormat: 'dd/mm/yy',
              timeFormat: "hh:mm:ss tt",
              defaultDate: "+1w",
              changeMonth: true,
              changeYear: true,
              showOn: "both",
              buttonImage: "../StyleSheets/start/images/calendar.gif",
              buttonImageOnly: true,
              maxDate: 0,


              yearRange: '1900:2100',
              onClose: function(selectedDate) {
                  $("#txtTDate").datetimepicker("option", "minDate", selectedDate);

                  var date = $("#txtFDate").datetimepicker('getDate');
                  //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                  // $("#txtTo").datepicker("option", "maxDate", d);

              }
          });
          $("#txtTDate").datetimepicker({
              dateFormat: 'dd/mm/yy',
              timeFormat: "hh:mm:ss tt",
              defaultDate: "+1w",
              changeMonth: true,
              changeYear: true,
              showOn: "both",
              buttonImage: "../StyleSheets/start/images/calendar.gif",
              buttonImageOnly: true,
              maxDate: 0,

              yearRange: '1900:2100',
              onClose: function(selectedDate) {
                  $("#txtFDate").datetimepicker("option", "maxDate", selectedDate);
              }
          })
      });
        </script>
    <script type="text/javascript">
        function ClearAll() {
            $('#txtFDate').val('');
            $('#txtTDate').val('');
            $('#txtHApproved').val('');
            $('#hdnApprveID').val('0');
            document.getElementById("HistoNos").value = '';
        }
    
        $(document).ready(function() {

        });
        function ContainerAutoCom() {
            $(function() {
                $('#hdnApprveID').val('0');
                var DoctorName = $('#txtHApproved').val();
                GetCtrlID = '';
                $("#txtHApproved").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: '../WebService.asmx/GetINVandSampleandContainerDetails',
                            data: "{'Name': '" + '' + "','SampleName': '" + '' + "','ContainerName':'" + '' + "','DoctorName':'" + DoctorName + "'}",
                            dataType: "json",
                            success: function(data) {
                                if (data.d.length > 0) {
                                    response($.map(data.d, function(item) {

                                        try {

                                            return {
                                                label: item.Name,
                                                val: item.ID

                                            }
                                        }
                                        catch (er) {
                                        }
                                    }


                    ))
                                } else {
                                    response([{ label: 'No results found.', val: -1}]);
                                    //Clear();

                                }
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
                        $('#hdnApprveID').val(i.item.val);


                    },
                    minLength: 2
                });
            });
        }


        function searchData() {
            var data = [];
            var i = 0;
            var frmDate = $('#txtFDate').val();
            var toDate = $('#txtTDate').val();
            var HistoNos = document.getElementById("HistoNos").value;

            var txtHApproved = $('#hdnApprveID').val();


            if (frmDate != "" && toDate != "") {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetMISDoctorWiseReportHisto",
                    data: "{ 'FromDate': '" + yyyymmdd(frmDate) + "','ToDate': '" + yyyymmdd(toDate) + "','HistoNo': '" + HistoNos + "','ApprovedBy': " + parseInt(txtHApproved) + " }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        //alert(msg.d);
                        data = JSON.parse(msg.d);
                        if (data.length > 0) {
                            $('#example').show();
                            $('#divtdtable').show();
                            
                            $('#example').DataTable({
                                "bDestroy": true,
                                "bProcessing": true,

                            "sZeroRecords": "No records found",
                            "sPaginationType": "full_numbers",
                            "bSort": false,
                            "paging": true,
                            //            "bPaginate": true,
                            "bLengthChange": false,
                            "bInfo": false,
                            "aaData": data,
                            "aoColumns": [
                         { "sTitle": "S.No", "mData": "SNO", "sClass": "center", "sWidth": "10%"

                         },
                          { "sTitle": "Patient No", "mData": "PatientNumber", "sClass": "center", "sWidth": "10%"

                          },
                          { "sTitle": "Patient Name", "mData": "PatientName", "sClass": "center", "sWidth": "10%"

                          },
                          { "sTitle": "Visit No", "mData": "VisitNumber", "sClass": "center", "sWidth": "10%"

                          },
                          { "sTitle": "Histopathology No", "mData": "HistoNumber", "sClass": "center", "sWidth": "10%"

                          },
                           { "sTitle": "Test Name", "mData": "Name", "sClass": "center", "sWidth": "20%"

                           },
                            { "sTitle": "Specimen", "mData": "Speciman", "sClass": "center", "sWidth": "10%"

                            },
                            { "sTitle": "Date & Time", "mData": "DateTime", "sClass": "center", "sWidth": "10%",
                                "mRender": function(data, type, full) {
                                    return '<label ID="dtme">' + GetCorrectdate(data) + '</label>';
                                }
                            },
                             { "sTitle": "ApprovedBy", "mData": "ApprovedBy", "sClass": "center", "sWidth": "10%"

                             },
                             { "sTitle": "Status", "mData": "Status", "sClass": "center", "sWidth": "10%"

                             },
                        ],
                            dom: 'Bfrtip',
                            buttons: [
              'excel', {
                 extend: 'print',
                 customize: function(win) {
                     $(win.document.body.getElementsByTagName('table')[0]).attr("border", "2");

                     $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                 }
             }
        ]

                            });
                            if (data.length == 0) {
                                ValidationWindow("No Matching Records Found!!!", "Alert");
                                $('#example').hide();
                                $('#divtdtable').hide();
                                $('#example').clear();
                                $('#example').empty();

                                return false;
                            }

                        }
                        else {
                            ValidationWindow("No Matching Records Found!!!", "Alert");
                            $('#divtdtable').hide();
                            $('#example').hide();
                            $('#example').clear();
                            $('#example').empty();
                            return false;
                        }
                    },
                    error: function(msg) {
                        // alert(msg.d);
                    }

                });
            }
            else {
                ValidationWindow("Please Select FromDate & ToDate !!!!", "Alert");
            }




        }
        function yyyymmdd(date) {

            var d = new Date(date.split("/").reverse().join("-"));
            var dd = d.getDate();
            if (dd.toString().length <= 1) {
                dd = '0' + dd;
            }
            var mm = d.getMonth() + 1;
            var mlen = mm.toString().length;
            if (mlen <= 1) {
                mm = '0' + mm;
            }
            var yy = d.getFullYear();
            var newdate = yy + "/" + mm + "/" + dd;
            return newdate;
        }
        function GetCorrectdate(value) {

            if (value != null && value != '') {
                var date = new Date(parseInt(value.substr(6)));
                var month = date.getMonth() + 1;
                value = date.getDate() + "/" + month + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            }
            else
            { value = ""; }
            return value;
        }
    </script>

</body>
</html>
