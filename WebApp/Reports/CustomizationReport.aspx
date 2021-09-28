<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomizationReport.aspx.cs" Inherits="Reports_CustomizationReport" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Customization Report</title>
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
    </style>
    <script type="text/javascript">

        function SelectedClient(source, eventArgs) {

            var Name = eventArgs.get_text();
            var list = eventArgs.get_value().split('^');
            var ID = list[5];
            document.getElementById('hdnClientID').value = ID;
        }
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
        }
    
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
                                            <asp:Label ID="lblSp" Text="MIS Name" runat="server" ></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:DropDownList ID="ddlMIS" CssClass="ddlsmall" runat="server" >
                                            </asp:DropDownList>
                                             <img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td class="w-10p">
                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" ></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="165px" Height="20px">
                                            </asp:TextBox>
                                            <a href="javascript:NewCssCall('<%=txtFDate.ClientID %>','ddMMyyyy','arrow',true,12,'','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
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
                                            <a href="javascript:NewCssCall('<%=txtTDate.ClientID %>','ddMMyyyy','arrow',true,12,'','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                            <%-- <td id="Td1" runat="server" class="a-right">
                                               <%-- <a href="javascript:NewCssCal('<% =txtTDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                               
                                            </td>--%>
                                        </td>
                                        </tr>
                                        
                                       <tr>
                                       <td> <asp:Label ID="lblClientname" Text="Client Name :" runat="server" ></asp:Label></td>
                                       <td> <asp:TextBox ID="txtClientName" runat="server" 
                                                    meta:resourcekey="txtClientNameResource1" Width="160px" Height="20px"
                                                ></asp:TextBox>
                                                <div id="aceDiv">
                                                </div>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClientName"
                                                                        BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                                        ServiceMethod="GetClientList" OnClientItemSelected="SelectedClient"  ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                         Enabled="True" CompletionListElementID="aceDiv" OnClientShown="setAceWidth" >
                                                                    </ajc:AutoCompleteExtender></td>
                                                                    <asp:HiddenField ID="hdnClientID" runat="server" Value="0"/>
                                        <td >
                                            <asp:Label runat="server" ID="lblvisitType" Text="Visit Type" CssClass="label_title"
                                                ></asp:Label>
                                        </td>
                                        <td >
                                            <asp:DropDownList ID="ddlVisitType" runat="server" CssClass="ddl" Width="200px"
                                                TabIndex="7" >
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                        </td>
                                        <td class="a-left   ">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return GetResult();" meta:resourcekey="btnSubmitResource1" />
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                    <%-- <tr>
                                        <td colspan="6">
                                            <div id="divDynamic" runat="server" style="overflow: auto; border: 2px; border-color: #fff;
                                                height: 480px;">
                                                <table id="DynamicTable" style="width:98%" class=" table tableHover table-bordered table-condensed table-responsive tableHeaderBG" cellspacing="2" cellpadding="1">
                                                </table>
                                                &nbsp;
                                           </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table id="DynamicTableCount" class="table tableHover table-bordered table-condensed table-responsive tableHeaderBG">
                                            </table>
                                        </td>
                                    </tr>--%>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divDynamic" runat="server" style="overflow: auto; border: 2px; border-color: #fff;
                                height: 480px;">
                                <table id="DynamicTable" style="width: 98%" class=" table tableHover table-bordered table-condensed table-responsive tableHeaderBG"
                                    cellspacing="2" cellpadding="1">
                                </table>
                                &nbsp;
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="DynamicTableCount" class="hide table tableHover table-bordered table-condensed table-responsive tableHeaderBG">
                            </table>
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

    <script src="../js/dataTables.responsive.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/dataTables.bootstrap.js" language="javascript" type="text/javascript"></script>

    <script src="../js/jquery-ui.min.js" language="javascript" type="text/javascript"></script>




    <script type="text/javascript">
      
        function Valiadte() {
            var iatrue = true;
            if ($("#txtClientName").val() == "") {

                $("#hdnClientID").val('0');
                iatrue = true;
            }
            if ($("#ddlMIS option:selected").val() == -1) {
                alert('Select any MIS.');
                iatrue = false;
            }
            else if ($("#txtFDate").val() == "") {
                alert('From Date is empty.');
                iatrue = false;
            }
            else if ($("#txtTDate").val() == "") {
                alert('To Date is empty.');
                iatrue = false;
            }
            return iatrue;
        }
        //        $(function() {
        //            $("#txtFDate").datepicker({
        //                dateFormat: 'dd/mm/yy',
        //                defaultDate: "+1w",
        //                changeMonth: true,
        //                changeYear: true,
        //                maxDate: 0,
        //                yearRange: '1900:2100',
        //                onClose: function(selectedDate) {
        //                    $("#txtTDate").datepicker("option", "minDate", selectedDate);

        //                    var date = $("#txtFDate").datepicker('getDate');
        //                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        //                    // $("#txtTo").datepicker("option", "maxDate", d);

        //                }
        //            });
        //            $("#txtTDate").datepicker({
        //                dateFormat: 'dd/mm/yy',
        //                defaultDate: "+1w",
        //                changeMonth: true,
        //                changeYear: true,
        //                maxDate: 0,
        //                yearRange: '1900:2100',
        //                onClose: function(selectedDate) {
        //                    $("#txtFDate").datepicker("option", "maxDate", selectedDate);
        //                }
        //            })
        //        });
        


        function GetResult() {
            //debugger;
            try {
                if (Valiadte()) {
                    var MISName = $('#ddlMIS').val();
                    var Fdate = $('#txtFDate').val();
                    var Tdate = $('#txtTDate').val();
                    FdateChange = Fdate.split("-");
                    TdateChange = Tdate.split("-");

                    //                    var FdateChange = Fdate.split("/");
                    //                    var TdateChange = Tdate.split("/");

                    Fdate = FdateChange[1] + '/' + FdateChange[0] + '/' + FdateChange[2];
                    Tdate = TdateChange[1] + '/' + TdateChange[0] + '/' + TdateChange[2];


                    //                    Fdate = Fdate + ' 00:00:00';
                    //                    Tdate = Tdate + ' 23:59:59';
                    
                    var ClientID = $('#hdnClientID').val();
                    var VisitType = $('#ddlVisitType').val();
                    var Testdetail='Test';
                    var Deptid=0;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../WebService.asmx/CustomizedReport",
                        data: JSON.stringify({ ReportID: MISName, Fdate: Fdate, Tdate: Tdate, ClientID: ClientID, VisitType: VisitType, TestDetail: Testdetail, DeptID: Deptid }),
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
                                rowData[j] = value;
                                j++;
                            });
                           
                            rowDataSet[i] = rowData;
                            i++;
                        });
                       
                       
                        
                        BindValues(true);
                    }
                    else {
                        $('#DynamicTable').hide();
                        
                        $('#DynamicTable_wrapper').hide();
                        alert('No records found !!!');
                    }
                }
                
                }
            }
           


        function BindValues(PageIng) {
            var Reportname = $('#ddlMIS :selected').text();
            if (rowDataSet != null && resultColumns.length >= 0) {
                var tables = $.fn.dataTable.fnTables(true);

                $(tables).each(function() {
                    $(this).dataTable().fnClearTable();
                    $(this).dataTable().fnDestroy();
                    
                });
                $('#DynamicTable').dataTable({
                "paging": false,
                "bDestroy": true,
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
                    "aaSorting": [[0, "asc"]],
                    "aoColumnDefs": [{ "sDefaultContent": null,
                        "aTargets": [0]}],
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            "aButtons": [
                             { "sExtends": "csv", "mColumns": "visible", "sFileName": Reportname + ".csv" },

                           { "sExtends": "xls", "mColumns": "visible", "sFileName": Reportname + ".xls"
                           },

                          ]
                        }
                    });
                    $('#DynamicTable').show();

                    $('#DynamicTable_wrapper').show();

                    $('#DynamicTable_info').hide();
                    rowDataSet = [];
                    resultColumns = [];
                    return false;
                }
            }

            
            
        
    </script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">

       
        function validateToDate() {
            var AlertType = SListForAppMsg.Get("Reports_TATReport_aspx_01") == null ? "Alert" : SListForAppMsg.Get("Reports_TATReport_aspx_01");
            var from = SListForAppMsg.Get("Reports_TATReport_aspx_02") == null ? "Select From Date!!!" : SListForAppMsg.Get("Reports_TATReport_aspx_02");
            var to = SListForAppMsg.Get("Reports_TATReport_aspx_03") == null ? "Select To Date!!!'" : SListForAppMsg.Get("Reports_TATReport_aspx_03");

            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(from, AlertType);
                //  alert('Provide / select value for From date');
                //                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                // alert('Provide / select value for To date');
                ValidationWindow(to, AlertType);
                //                document.getElementById('txtTDate').focus();
                return false;
            }
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
