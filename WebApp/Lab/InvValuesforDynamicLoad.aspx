<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvValuesforDynamicLoad.aspx.cs" Inherits="Lab_InvValuesforDynamicLoad" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Covid Report</title>
<link href="../PMS/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../PMS/css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="../PMS/css/dashboard.css" rel="stylesheet" />
    <link href="../PMS/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="../PMS/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.tableTools.min.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.responsive.css" rel="stylesheet" />
    <link href="../PMS/css/jquery-ui.min.css" rel="stylesheet" />
 <style type="text/css">
  
        
       .ui-datepicker
        {
            font-size: 10pt !important;
            background: #333;
           border: 1px solid #555;
     color: #EEE;
        }
    .ui-datepicker .ui-datepicker-title select {
    font-size: 1em;
    margin: 1px 0;
    color: black;
}

th.hide_me, td.hide_me {display: none;}

.tblwidth

{
   
   width:100% !important;
}
      .tbltdwidth  td:nth-child(2) { 
                width: 10%; 
            } 
            .tbltdwidth  td:nth-child(3) { 
                width: 15%; 
            } 
             .tbltdwidth  td:nth-child(4) { 
                width: 10%; 
            } 
   
    </style>
    <script type="text/javascript">

        
       
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
    <div id="statusProgess" style="display: none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="w-15p a-center" style="display: block;">
                <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                    Font-Size="Larger" />
                <br />
                <br />
                <asp:Image ID="imgProgressbar1" Width="16px" Height="16px" runat="server" ImageUrl="../Images/working.gif" />
            </div>
        </div>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <table id="tblCollectionOPIP" class="a-center w-100p">
                    <tr class="a-center">
                        <td class="a-left">
                            <div class="dataheaderWider">
                                <table id="tbl">
                                    <tr class="w-100p">
                                     
                                        <td class="w-10p">
                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" ></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="165px" Height="20px">
                                            </asp:TextBox>
                                             <img src="../Images/starbutton.png" alt="" align="middle" />
                                            <%--<td id="datecheck" runat="server" class="a-right">
                                            
                                                <%--<a href="javascript:NewCssCal('<% =txtFDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                               
                                            </td>--%>
                                        </td>
                                        <td class="w-10p">
                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" ></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="165px" Height="20px" 
                                                OnTextChanged="txtTDate_TextChanged"></asp:TextBox>
                                                 <img src="../Images/starbutton.png" alt="" align="middle" />
                                           
                                            <td> <asp:Label ID="lblVisitNo" Text="Visit No :" runat="server" ></asp:Label></td>
                                       <td> <asp:TextBox ID="txtVisitNo" runat="server" 
                                                    meta:resourcekey="txtVisitNoResource1" Width="165px" Height="20px"
                                                ></asp:TextBox>
                                               
                                                

                                        </td>
                                        
                                        
                                        </tr>
                                        <tr class="w-100p">
                                        <td class="w-10p">  <asp:Label ID="lblCode" Text="Group name / code " runat="server"></asp:Label></td>
                                       <td class="w-20p"> <asp:TextBox ID="txtTestCodeScheme" runat="server" Width="165px" Height="20px"
                                            TabIndex="1" meta:resourcekey="txtTestCodeSchemeResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="ACETestCodeScheme" runat="server" TargetControlID="txtTestCodeScheme"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box mediumList"
                                            CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                            ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                            DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedTestCodeScheme"
                                            OnClientPopulated="TestCodeSchemePopulated" CompletionSetCount="20">
                                        </ajc:AutoCompleteExtender></td>
                                        <td class="w-10p"></td>
                                        <td class="w-20p"> </td>
                                        <td></td>
                                        <td class="a-left   ">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return GetResult();" meta:resourcekey="btnSubmitResource1" />
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td></tr>
                                      
                                    <tr class="w-100p"><table id="DynamicTable" class="table table-bordered tblwidth tbltdwidth" >
        </table></tr>
         <tr><td class="a-center">
                                              <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return SaveInvValues();" meta:resourcekey="btnSubmitResource1"  />
                                           
                                        </td></tr>
        <tr><table id="DynamicTableCount" class="table tableHover table-bordered table-condensed table-responsive tableHeaderBG">
        </table></tr>
       
                                </table>
                            </div>
                           
                            
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCoAuth" runat="server" Value="Y" />
    <asp:HiddenField ID="hdnValidateTime" runat="server" Value="Y" />
    <asp:HiddenField ID="hdnGRPID" runat="server" Value=""/>
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

   <%-- <script src="../Scripts/datatablescroll.min.js" type="text/javascript"></script>--%>
<%--    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>--%>
    <%--
    <script src="../js/jquery-1.11.3.min.js" language="javascript" type="text/javascript"></script>--%>
    <script src="../js/bootstrap.min.js" language="javascript" type="text/javascript"></script>

    <%--<script src="../js/moment.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/bootstrap-datetimepicker.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../js/jquery.dataTables.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/dataTables.tableTools.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <%--<script src="../js/dataTables.responsive.min.js" language="javascript" type="text/javascript"></script>
<%--
    <script src="../js/dataTables.bootstrap.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../js/jquery-ui.min.js" language="javascript" type="text/javascript"></script>




    <script type="text/javascript">


        $(document).ready(function() {
        $('#btnSave').hide();
        });
        function Valiadte() {
            var iatrue = true;
            if ($("#txtFDate").val() == "" && $("#txtTDate").val() == "" && $("#txtVisitNo").val() == "") {
                alert('Please Choose any one of the filter.');
                iatrue = false;
            }
            if ($("#txtFDate").val() != "" && $("#txtTDate").val() == "") {
                alert('Please Choose To Date.');
                
            }
            if ($('#hdnGRPID').val() == '') {
                ValidationWindow('Please choose Group Name', AlertType);
                iatrue = false;
            }
            
            return iatrue;
        }
        $(function() {
            $("#txtFDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTDate").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFDate").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFDate").datepicker("option", "maxDate", selectedDate);
                }
            })
        });
        


        function GetResult() {
            //debugger;
            try {
                if (Valiadte()) {
                    var MISName = $('#ddlMIS').val();
                    var Fdate = $('#txtFDate').val();
                    var Tdate = $('#txtTDate').val();
                    var FdateChange = Fdate.split("/");
                    var TdateChange = Tdate.split("/");

                    Fdate = FdateChange[1] + '/' + FdateChange[0] + '/' + FdateChange[2];
                    Tdate = TdateChange[1] + '/' + TdateChange[0] + '/' + TdateChange[2];
                    
                    
                    Fdate = Fdate + ' 00:00:00';
                    Tdate = Tdate + ' 23:59:59';

                    if ($("#txtFDate").val() == "") {
                        Fdate = '01/01/2018 00:00:00';

                    }
                    if ($("#txtTDate").val() == "") {
                        Tdate = '12/31/2050 23:59:59';
                        
                    }

                    var VisitNo = $('#txtVisitNo').val();
                    var GroupID = parseInt($('#hdnGRPID').val());
                   var Param1 = '';
                   var Param2 = '';
                   var Param3 = '';
                   var Param4 = '';
                   var Param5 = 0;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../WebService.asmx/DynamicInvValues",
                        data: JSON.stringify({ Fdate: Fdate, Tdate: Tdate, VisitNo: VisitNo,GroupID:GroupID, Param1: Param1 , Param2:Param2, Param3:Param3, Param4:Param4, Param5:Param5 }),
                        dataType: "json",
                        async: true,
                        success: AjaxGetFieldDataSucceeded,
                        error: function(result) {
                            alert("Error in Json Method");
                        }
                    });
                
                }
            }
            catch (e) { }
            return false;
        }

        function AjaxGetFieldDataSucceeded(result) {
            debugger;
            try {
                $('#btnSave').show();
                CreateDynamicGrid(result)
            }
            catch (e) {
                alert("Error in AjaxGetFieldDataSucceeded Method");
            }
        }

        var rowDataSet = [];
        var resultColumns = [];
     
        function CreateDynamicGrid(result) {
            
            $('#DynamicTable tbody > tr').remove();
            $('#DynamicTable thead > tr').remove();
            if (result.d.length > 0) {
                var list = result.d;
                if (list[0].length > 0) {
                    var tabledata = list[0];
                    if (list[1].length > 0) {
                        var tabledatacount = list[1];
                        var parseJSONResultDetail = JSON.parse(tabledata)
                        var parseJSONResultCount = JSON.parse(tabledatacount)
                        var parseJSONResult = $.merge(parseJSONResultDetail, parseJSONResultCount);
                    }
                    else {
                        var parseJSONResult = JSON.parse(tabledata)
                    }
                    if (parseJSONResult.length > 0) {
                        var i = 0;
                        $.each(parseJSONResult[0], function(key, value) {
                            var obj = { sTitle: key };
                           
                               
                                resultColumns[i] = obj;
                            
                            i++;
                        });
                        var i = 0;
                        $.each(parseJSONResult, function(key, value) {
                            var rowData = [];
                            var j = 0;
                            $.each(parseJSONResult[i], function(key, value) {

                                if (key == 'VisitID' || key == 'Visit Number' || key == 'Patient Name' || key == 'Age/Sex' || key == 'AccessionNumber' || key == 'OrgID') {

                                    rowData[j] = '<label >' + value + '</label>'

                                }

                                else {

                                    var InvValue = GetInvValue(value);
                                    var k = i + 1;
                                    rowData[j] = '<input type="text" id="' + k + '^' + value + '"  KEY="' + key + '" value="' + InvValue + '" >'



                                }
                                j++;
                            });

                            rowDataSet[i] = rowData;
                            i++;
                        });



                        BindValues(true);


//                        $('#DynamicTable td').each(function() {
//                            var min = 10;                                  // Define a minimum
//                            var step = 5 * $(this).index();                // Define Step(your step is 5 here)
//                            $(this).css('width', (min + step) + "px");     // css attribute of your <td> width:15px; i.e.
//                        });
                        
                    }
                    else {
                        $('#DynamicTable').hide();
                        $('#btnSave').hide();
                        $('#DynamicTable_wrapper').hide();
                        alert('No records found !!!');
                    }
                }
                
                }
            }
           

function GetInvValue(value)
{

var splitvalue=value.split("~");
InvValues = splitvalue[0];
return InvValues;
}

        function BindValues(PageIng) {

           
            if (rowDataSet != null && resultColumns.length >= 0) {
                var tables = $.fn.dataTable.fnTables(true);

              
                $(tables).each(function() {
                    $(this).dataTable().fnClearTable();
                  $(this).dataTable().fnDestroy();

                });

               
                
                $('#DynamicTable').dataTable({
                "paging": false,
                "bDestroy": true,  
                "bRetrieve":false,
                    "searching": false,
                    "responsive": true,
                    "bProcessing": true,
                    "bserverside": true,
                    "bPaginate": false,
                    "bSortable": false,
                    "aaData": rowDataSet,
                    'bSort': false,
                    "bFilter": true,
                    "sZeroRecords": "No records found",
                    "iDisplayLength": 100,
                    "aoColumns": resultColumns,
                    "aaSorting": [[1, "asc"]],
                    "aoColumnDefs": [{ "sDefaultContent": null,
                    "sClass": "hide_me",
                    "aTargets": [0,4,5]

                }
                
              ]
                    });
                    $('#DynamicTable').show();
                   
                    $('#DynamicTable_wrapper').show();

                    $('#DynamicTable_info').hide();
                    $('#DynamicTable_filter').hide();
                    
                    rowDataSet = [];
                    resultColumns = [];
                    return false;
                }
            }
var arr = [];
function SaveInvValues() {

    var TableData = new Array();
  var searchid='';

  $('#DynamicTable tr').each(function(row, tr) {
      if (row > 0) {
          searchid = row + '^';
          var dd = ''; dd = $(tr).find("input[id^='" + searchid + "']");
    
          for (var i = 0; i < dd.length; i++) {
              var valueid = dd[i].id;
             
              var invdetailsplit = dd[i].id.split("~");
              var patinvid = invdetailsplit[2];
              var invId = invdetailsplit[1];
              var invvalueid = invdetailsplit[3];
              var invvalue = $(tr).find("input[id^='" + valueid + "']").val()

              arr.push({
              VisitID: parseInt($(tr).find('td:eq(0)').text()),
              InvValue: invvalue,
                  MedicalRemarks: '',
                  PatientInvID: parseInt(patinvid),
                  InvestigationID: parseInt(invId),
                  AccessionNumber: parseInt($(tr).find('td:eq(4)').text()),
                  InvestigationValueID: parseInt(invvalueid),
                  OrgID: parseInt($(tr).find('td:eq(5)').text())

              });


          }

      }


     
  });

   var jsonresult = JSON.stringify(arr);
   var param1 = "";
    var param2 = "";
    var param3 = "";
    var param4 = "";
    var param5 = 0;
    var GroupID = parseInt($('#hdnGRPID').val());
   
   try{

       $.ajax({
           type: "POST",
           url: "../WebService.asmx/SaveInvValuesCovidReport",
           data: "{'JsonStringData':'" + jsonresult + "','GroupID':'" + GroupID + "','Param1':'" + param1 + "', 'Param2': '" + param2 + "','Param3':'" + param3 + "','Param4': '" + param4 + "','Param5': ' " + param5 + " '}",
           contentType: "application/json; charset=utf-8",
           dataType: "json",
           async: false,
           success: function(data) {
               
               ValidationWindow('Saved Successfully', 'Alert');
              
           },
           error: function(xhr, ajaxOptions, thrownError) {
               alert("Error");
               return false;
           }
       });
            }
            catch (e) {

            }
            arr = [];

            GetResult();
            event.preventDefault();

}
    
            
        
    </script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">

        function TestCodeSchemePopulated(Source, eventArgs) {
            try {
                var autoList = Source.get_completionList();
                if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                    $('[id$="hdnGRPID"]').val('');
                }
            }
            catch (e) {
                return false;
            }
        }
        function SelectedTestCodeScheme(Source, eventArgs) {
            try {
                var lstSelectedValue = eventArgs.get_value().split(':');

                var seletedReflextest = lstSelectedValue[0];
                $('[id$="hdnGRPID"]').val(seletedReflextest);
                var lstSelectedText = eventArgs.get_text().split(':');
                if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                    $('[id$="txtTestCodeScheme"]').val(lstSelectedText[1]);
                }
            }
            catch (e) {
                return false;
            }
        }
        var AlertType = SListForAppMsg.Get("Reports_TATReport_aspx_01") == null ? "Alert" : SListForAppMsg.Get("Reports_TATReport_aspx_01");
       
        function validateToDate() {
           
            var from = SListForAppMsg.Get("Reports_TATReport_aspx_02") == null ? "Select From Date!!!" : SListForAppMsg.Get("Reports_TATReport_aspx_02");
            var to = SListForAppMsg.Get("Reports_TATReport_aspx_03") == null ? "Select To Date!!!'" : SListForAppMsg.Get("Reports_TATReport_aspx_03");

            if (document.getElementById('txtFDate').value == '' && document.getElementById('txtTDate').value == '' && document.getElementById('txtVisitNo').value == '') {
                ValidationWindow('Please Choose any one of the Filter', AlertType);
                //  alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }

            if ($('#hdnGRPID').val() == '') {
                ValidationWindow('Please choose Group Name', AlertType);
                return false;
            }
            
            
//            if (document.getElementById('txtTDate').value == '') {
//                // alert('Provide / select value for To date');
//                ValidationWindow(to, AlertType);
//                document.getElementById('txtTDate').focus();
//                return false;
//            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function GetCorrectdate(value) {

            if (value != null && value != '') {

                var str = new Date(value.substr(0, 11));
               var date= str.toLocaleDateString("en-GB");
               var time = value.substr(11, 6);
             var time=  convertTimeFrom12To24(time);
                value = date + " " + time;
            }
            else
            { value = ""; }
            return value;
        }

        function convertTimeFrom12To24(time) {
            var colon = time.indexOf(':');
            var hours = time.substr(0, colon),
      minutes = time.substr(colon + 1, 2),
      meridian = time.substr(colon + 3, 2).toUpperCase();


            var hoursInt = parseInt(hours, 10),
      offset = meridian == 'PM' ? 12 : 0;

            if (hoursInt === 12) {
                hoursInt = offset;
            } else {
                hoursInt += offset;
            }
            return hoursInt + ":" + minutes;
        }

      
    </script>
</body>
</html>
