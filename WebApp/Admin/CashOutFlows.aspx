<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CashOutFlows.aspx.cs" Inherits="Admin_CashOutFlows" %>

<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentTypeDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cash Out Flow </title>
      <script src="../Scripts/Export_Excel_Pdf_Copy/jquery-1.12.4.js" type="text/javascript"></script>
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <%-- <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.theme.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../Scripts/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table>
            <tr>
                <td>
                    Location Name :
                </td>
                <td>
                    <asp:DropDownList ID="ddlLocation" runat="server" disabled CssClass="ddl" Width="150px" TabIndex="1">
                    </asp:DropDownList>
                </td>
                <td>
                    Select Payable type :
                </td>
                <td>
                    <asp:DropDownList ID="ddlPay" runat="server" CssClass="ddl" Width="150px" TabIndex="2">
                    </asp:DropDownList>
                </td>
                <td>
                    Others :
                </td>
                <td>
                    <asp:TextBox ID="txtother" runat="server" Width="150px" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Expense Date :
                </td>
                <td>
                    <asp:TextBox ID="txtExpdate" runat="server" placeholder="dd/mm/yyyy" CssClass="datePicker"></asp:TextBox>
                </td>
                <td>
                    Payment Receiver :
                </td>
                <td>
                    <asp:TextBox ID="txtPayrece" runat="server" Width="150px" TabIndex="4"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPayrece"
                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetAllEmployeeName"
                        OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                        DelimiterCharacters="" Enabled="True">
                    </cc1:AutoCompleteExtender>
                </td>
                <td>
                    Remarks :
                </td>
                <td>
                    <textarea rows="4" cols="50" runat="server" id="txtRemarks">

</textarea>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <uc9:PaymentTypeDetails EnabledCurrType="false" ID="PaymentTypeDetails1" runat="server" />
        <br /><br />
        <div id="btnarea">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="bsave_Click" CssClass="btn" style="margin-left: 50%;" /></div>
   <br /><br />
   
    <table>
            <tr>
                <td>
                    Location Name :
                </td>
                <td>
                    <asp:DropDownList ID="ddlLocationSearch" runat="server" disabled CssClass="ddl" Width="150px" TabIndex="1">
                    </asp:DropDownList>
                </td>
                <td>
                    Select Payable Type :
                </td>
                <td>
                    <asp:DropDownList ID="ddlpaySearch" runat="server" CssClass="ddl" Width="150px" TabIndex="1">
                    </asp:DropDownList>
                </td>
                <td>
                    Expense Date :
                    <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                    <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                    <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                    <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                    <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                    <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                    <asp:HiddenField ID="hdnDateImage" runat="server" />
                    <asp:HiddenField ID="hdnTempFrom" runat="server" />
                    <asp:HiddenField ID="hdnTempTo" runat="server" />
                    <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                    <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                    <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                    <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                    <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                    <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                    <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                    <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                </td>
                <td>
                    <span class="richcombobox" style="width: 155px;">
                        <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                            runat="server" meta:resourcekey="ddlRegisterDateResource1">
                        </asp:DropDownList>
                    </span>
                </td>
                <td>
                    <%-- <asp:Button ID="btnSave" runat="server" Text="Search" OnClick="bsearch_Click" CssClass="btn" />--%>
                    <input type="button" id="Button1" onclick="Test();" class="btn" value="Search">
                    </input>
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
                    <div id="divRegDate" style="display: none" runat="server">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="w-70" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="w-70" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divRegCustomDate" runat="server" style="display: none;">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="w-70" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <div>
            <table id="example" class="w-100p gridView">
            </table>
        </div>
   
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnEmpID" runat="server" Value="-1" />

    <script type="text/javascript">
        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
           
        }
        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPayrece').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal;
        }
        function SetOtherCurrValues() {
            var pnetAmt = document.getElementById('PaymentTypeDetails1_txtAmount').value;
            //            var ConValue = "OtherCurrencyDisplay1";
            var ConValue = SListForAppMsg.Get("Admin_CashFlow_aspx_02") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_02") : "OtherCurrencyDisplay1";
            //  SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        function isOtherCurrDisplay1(pType) {
        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_CashFlow_aspx_10") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_10	") : "Amount cannot be zero";

            if (TotalAmount > 0) {

                return true;
            }
            else {
                // var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_9");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Amount cannot be zero');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                return false;
            }
        }
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
    </script>

    </form>
</body>
</html>
<script src="../Scripts/JsonScript.js" type="text/javascript"></script>



<script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

<script src="../Scripts/Export_Excel_Pdf_Copy/jquery.dataTables.min.js" type="text/javascript"></script>

<script src="../Scripts/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>





<script src="../Scripts/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>

<script src="../Scripts/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>

<script src="../Scripts/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>

<script src="../Scripts/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>

  <script type="text/javascript">
     function yyyymmdd(date)
{
var DateNow =date.replace(/\-/g, '/').split("-").reverse().join("/");
var d= new Date(DateNow);
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
        function Test() {
            var locationid = $('#ddlLocationSearch').val();
            var PayableType = $('#ddlpaySearch').val();
            var ExpenseDate = $('#ddlRegisterDate').val();

            if (ExpenseDate == "-1") {
                ValidationWindow("Please Select Expense Date !! ", "Alert");
            }
            else {
            var FromDate ="";
            var ToDate="";
            FromDate= $('#txtFromDate').val();
            ToDate=$('#txtToDate').val();
           if( FromDate =="" && ToDate=="")
           {
         FromDate=  $('#txtFromPeriod').val();
         ToDate=$('#txtToPeriod').val();
         if(FromDate =="" && ToDate=="")
         {
       FromDate=   FormatDate();
       ToDate=FormatDate();
         }
           }
            
            
                
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetCashOutFlowPaymentReport",
                    contentType: "application/json; charset=utf-8",
                    data: "{LocationID:" + parseInt(locationid) + ",PayableType:'" + PayableType + "',FromDate:'" + FromDate + "',ToDate:'" + ToDate + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        $('#printDiv').hide();
                        return false;
                    }
                });
            }
        }
        
        function AjaxGetFieldDataSucceeded(lstOfData) {

   var Items = lstOfData.d;
   var i = 0;
   $('#example').dataTable({
       "bDestroy": true,
       "bProcessing": true,
       "aaData":JSON.parse(lstOfData.d),
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
  'csv', 'excel', 'pdf'
//            {
//                extend: 'excelHtml5',
//                exportOptions: {
//                columns: [1, 2,3,4,5,6,7,8,9,10,11,12]
//                }
//            },
//            {
//                extend: 'pdfHtml5',
//                exportOptions: {
//                    columns: [1, 2,3,4,5,6,7,8,9,10,11,12]
//                }
//            }
        ],
       "paging": true,
       //            "bPaginate": true,
       "bLengthChange": false,
       "bInfo": false,
      //  "stateSave": saveSate,
       "bFilter": false,
       
       "aoColumns": [

                   {"sTitle": "S.No", "mData": "VoucherNO", "sClass": "center", "sWidth": "10%"
                      
                   },
                          { "sTitle": "Location Name", "mData": "Location", "sClass": "center", "sWidth": "10%"

//                              "mRender": function(data, type, full) {
//                                  return '<label ID="BookingID">' + data + '</label>';
//                              }
                          },
                          { "sTitle": "Payable Type", "mData": "HeadName" , "sClass": "center", "sWidth": "10%"
//                          ,
//                              "mRender": function(data, type, full) {
//                                  return '<label ID="PatientName">' + data + '</label>';

                          //    }
                          },
                          { "sTitle": "Expense Date", "mData": "ExpenseDate", "sClass": "center", "sWidth": "10%"
                          ,
 "mRender": function(data, type, full) {
                                     
         return  formatJsonDate(data) ;
    
                                 }
                          },
                           { "sTitle": "Receiver Name", "mData": "ReceiverName", "sClass": "center", "sWidth": "10%"
//                           ,
//                               "mRender": function(data, type, full) {
//                                   return '<Label  ID="CollectionAddress2">' + data + '</label>';
                            //   }
                           },
                            { "sTitle": "Amount", "mData": "AmountReceived", "sClass": "center", "sWidth": "5%"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="Pincode">' + data + '</label>';
                           //     }
                            },
                            { "sTitle": "Remarks", "mData": "Remarks", "sClass": "center", "sWidth": "20%"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="BillDescription">' + data + '</label>';
                           //     }
                            },
                            { "sTitle": "User Name", "mData": "Name", "sClass": "center", "sWidth": "10%"
//                            ,
//                                "mRender": function(data, type, full) {
//                                    return '<label ID="BillDescription">' + data + '</label>';
                            //    }
                            },
                             { "sTitle": "Registered Date", "mData": "CreatedAT", "sClass": "center", "sWidth": "10%"
                                
                                   
 ,"mRender": function(data, type, full) {
                                     
         return  formatJsonDate(data) ;
    
                                 }
                             }
                              




                          ],
                         



   });
   
   
        
//        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

//        $('#ScrollArea').addClass('show');
//        selectall();
//        rsel();
      
    }

        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

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
            if (document.getElementById('ddlRegisterDate').value == "1") {
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
            if (document.getElementById('ddlRegisterDate').value == "2") {
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
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
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
            if (document.getElementById('ddlRegisterDate').value == "6") {
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
            if (document.getElementById('ddlRegisterDate').value == "7") {
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
function FormatDate()
{
var today = new Date();
var dd = today.getDate();

var mm = today.getMonth()+1; 
var yyyy = today.getFullYear();
if(dd<10) 
{
    dd='0'+dd;
} 

if(mm<10) 
{
    mm='0'+mm;
} 
today =dd+'-'+mm+'-'+yyyy;
return today;
}


    </script>