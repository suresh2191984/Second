
var invoice = ""
$(function() {
    var wholeStruct = "";
    invoice = $('#hdnResultInvoice').val();
    FirstLoad(invoice);
    // rio();
    var balanceAmount = 0;
    $('#btnSaveIn').hide();
    $('.txtDisabled').attr('disabled', true);

});
function FirstLoad(invoice) {
    //alert(invoice);
    var InvoiceID = 0;
    var InvoiceInputData = [];
    var ClientID = 0;
    for (var i = 0; i < invoice.split('^').length - 1; i++) {

        InvoiceID = invoice.split('^')[i].split('~')[0];
        InvoiceNumber = invoice.split('^')[i].split('~')[1];
        ClientID = invoice.split('^')[i].split('~')[2];
        $('#hdnClientID').val(ClientID);
        InvoiceInputData.push({
            InvoiceID: InvoiceID,
            InvoiceNumber: InvoiceNumber,
            ClientID: ClientID

        });
    }
    InVoiceDataLOad(InvoiceInputData, 'INVOICE');
    SubGrid();
}


function InVoiceDataLOad(InvoiceInputData, INtype) {
    var tblStruct = "";
    tblStruct = "";

    $.ajax({

        type: "POST",

        async: false,
        contentType: "application/json; charset=utf-8",

        url: "../OPIPBilling.asmx/GetInvoicePayments",

        data: JSON.stringify({ lstInvID: InvoiceInputData, Type: INtype }),

        dataType: "json",

        success: function(msg) {
            data = JSON.parse(msg.d);
            if (data.length > 0) {

                //alert(Result);
                if (INtype == "INVOICE") {
                    if (data[0].DueAmount < 0) {
                        $('#txtpendOut').val("0");
                    }
                    else {
                        $('#txtpendOut').val(data[0].DueAmount);
                    }

                    $('#txttlInv').val(data[0].ReceivedAmt);
                    
                    tblStruct = "<div class='w-100p h-210 o-auto'><table border=1  class='table table-bordered responstable w-100p' id='tblEnterTissue'> <tr><th></th><th>Invoice Date</th><th>Invoice Period</th><th>Invoice Number</th><th>Client Name</th><th> Invoice Gross Amount</th><th> Discount Amount</th><th> Credit Amount</th><th> Invoice Amount</th><th> Due Amount</th><th>Discount</th><th>TDS</th><th> Knock Off selection</th><th>Write Off</th></tr>";
                    $.each(data, function(i, item) {

                        var iddd = "  id= datergr" + i++ + ""

                        tblStruct += "<tr class='trrow'><td><a href='#'  id=" + item.InvoiceID + " class='toodle'>+</a></td><td><span class='Invoicedate'>" + item.IsNotifyComplete + "</span></td><td>" + item.ApproverRemarks + "</td><td>" + item.InvoiceNumber + "</td><td>" + item.Comments + "</td><td>" + item.GrossValue + "</td><td>" + item.DiscountAmt + "</td><td>" + item.CreditAmount + "</td><td>" + item.NetValue + "</td><td class='tdDue' dueAmt='"+ item.TaxAmount +"'>" + item.TaxAmount + "</td><td><input type='textbox' id='" + 'txtDiscount' + item.InvoiceID + "' style='width: 60px' class='txtDiscountID'  onblur='checkValidateDiscount(this.id)' ></td><td><input type='textbox' id='" + 'txtTDS' + item.InvoiceID + "' style='width: 60px' onblur='checkValidateTDS(this.id)' class='txTDSID' ></td><td><input type='checkbox' id='" + 'Inknock' + item.InvoiceID + "' class='ckh'  ></td><td><input type='checkbox' id='" + 'Inwrite' + item.InvoiceID + "'  class='ckhwrite'  ></td></tr>";

                    });
                    
                    tblStruct += "</table></div>";

                    document.getElementById('tableArea').innerHTML = "";
                    document.getElementById('tableArea').innerHTML = tblStruct;
                }
                else {
                    var idU = "";
                    var finalnetvalue1 = 0;
                    $.each(data, function(i, item) {

                        idU = 'tst' + item.InvoiceID;
                        var discountamt = (item.NetValue * data["0"].Discount / 100);
                        var NetValues = (item.NetValue - (item.NetValue * data["0"].Discount / 100)); //Bill wise dicount cal

                        finalnetvalue1 = (NetValues - (NetValues * data["0"].TTOD / 100)); // Turn around discount cal against Bill
                        var Creditvalue = ((100 * data["0"].CreditAmount / data["0"].ReceivedAmt));
                        var test = (NetValues - (NetValues * Creditvalue.toFixed(2) / 100));
                      //  alert(Math.round(test));
                      var  finalnetvalue = Math.round(test);
                        tblStruct += "<tr ><td >" + item.Comments + "</td><td>" + item.ApproverRemarks + "</td><td>" + item.Old_InvoiceNumber + "</td><td>" + item.NetValue + "</td><td>" + discountamt + "</td><td class='tdPayable'>" + finalnetvalue + "</td><td><input type='checkbox' NetValue=" + finalnetvalue + " id='" + 'subInknock' + i++ + item.InvoiceID + "'  class= '" + 'subckhK' + item.InvoiceID + " NetValueK subckh' ></td><td><input type='checkbox' id='" + 'subInwrite' + i++ + item.InvoiceID + "' NetValue=" + finalnetvalue + "  class='" + 'subckhW' + item.InvoiceID + " NetValueW subckhwrite' ></td><td class='billid hide'>" + item.FinalBillID + "</td><td class='invoiceid hide'>" + item.InvoiceID + "</td></tr>";
                       // alert(Creditvalue);
                    });
                    var tblStructA = "<tr id='" + idU + "' class='sup'><td></td><td colspan='10'><table id='supbill' border=1  class='w-80p getdetails' style='margin-left: 5%;'><tr><th>Bill Date</th><th>Bill Number</th><th>Patient Name</th><th>Net Amount</th><th>Discount</th><th>Payable Amount</th><th>Knock Off selection</th><th>Write Off</th>";
                    wholeStruct = tblStructA + tblStruct + "</table></tr>"

                    document.getElementById('hdnSubtable').value = wholeStruct;
                    wholeStruct = "";
                }



                $(".toodle").show();
            }
        },


        error: function(Result) {

            alert("Error");

        }

    });
}




//function Onlynumeric(id) {

//    var $this = $(id);
//    $this.val($this.val().replace(/[^\d.]/g, ''));   
//}

function SetOutstating(ctrl)
{
var val=$(ctrl).val();
var total=$(ctrl).attr('outval');
if(val !='')
{
 val=  parseFloat(val);
 if(total !='')
 {
    $('#txtTotal').val(parseFloat(total)-val);
 }

}
else{
	
	$(txtTotal).val(total);
}

}
function SetDiscount(ctr, discountAmt) {
    var trows = $(ctr).closest('tr').next('tr').find('table tbody tr').not(':first');
    if (discountAmt != '') {
        
        var invAmt = parseFloat(discountAmt / trows.length);
        $.each($(trows), function(id, val) {
            var col = $(val).find('td.tdPayable')[0];
            var pval = parseFloat($(col).attr('pval'));

            $(col).html(pval - parseFloat(invAmt));
        });
    }
    else {
        $.each($(trows), function(id, val) {
            var col = $(val).find('td.tdPayable')[0];
            var pval = parseFloat($(col).attr('pval'));

            $(col).html(pval);
        });

    }

}
function checkValidateDiscount(id) {
    $('#txtDiscountAmount').val('0');
    var txtDisount = id.split("txtDiscount");
    var ID = txtDisount[1];
    var chkKnockOff = 'Inknock' + ID;
    var chkWriteOff = 'Inwrite' + ID;
    if ($('#' + id + '').val() != '' && ($('#' + chkKnockOff + '').prop('checked') ==  true
       || $('#' + chkWriteOff + '').prop('checked') == true)) {
        var result = confirm('Are you sure to enter discount, Already Knock and Write Off is clicked ?');
        if (result == true) {
            $('#' + id + '').val();
            $('#' + chkWriteOff + '').prop('checked', false);
            $('#' + chkKnockOff + '').prop('checked', false);


            var boolchkKN = $('#' + chkKnockOff + '').prop("checked");
            if (boolchkKN == false) {
                
                $('.subckhK' + ID).prop("checked", false);
            }

            var boolchkW = $('#' + chkWriteOff + '').prop("checked");
            if (boolchkW == false) {

                $('.subckhW' + ID).prop("checked", false);
            }
 $('#txtDiscountAmount').removeAttr('disabled');
             $('#txtTDSAmount').removeAattr('disabled'); 
           // SetDiscount(this);
            
        }
        else {
            $('#' + id + '').val('');
            
        }


    }

    else {
        $('#txtReceivedAmt').removeAttr('disabled');  
        var discountamount = $('#' + id + '').val();
        //SetDiscount('#' + id, discountamount);
       // $('#' + id + '').closest('tr').find('.toodle').click();

    }

    
}



function checkValidateTDS(id) {
    var txtDisount = id.split("txtTDS");
    $('#txtTDSAmount').val('0');
    var ID = txtDisount[1];
    var chkKnockOff = 'Inknock' + ID;
    var chkWriteOff = 'Inwrite' + ID;
    if ($('#' + id + '').val() != '' && ($('#' + chkKnockOff + '').prop('checked') == true
       || $('#' + chkWriteOff + '').prop('checked') == true)) {
        var result = confirm('Are you sure to enter TDS, Already Knock and Write Off is clicked ?');
        if (result == true) {
            $('#' + id + '').val();
            $('#' + chkWriteOff + '').prop('checked', false);
            $('#' + chkKnockOff + '').prop('checked', false);

            var boolchkKN = $('#' + chkKnockOff + '').prop("checked");
            if (boolchkKN == false) {

                $('.subckhK' + ID).prop("checked", false);
            }

            var boolchkW = $('#' + chkWriteOff + '').prop("checked");
            if (boolchkW == false) {

                $('.subckhW' + ID).prop("checked", false);
            }

        }
        else {
            $('#' + id + '').val('');
            
        }
    }
    else {
        var TDSamount = $('#' + id + '').val();
       // $('#' + id + '').closest('tr').find('.toodle').click();
       
    }

   

   
}


function yyyymmdd(date) {
    var getdatetime = [];
    getdatetime = date.split(' ');
    var d = new Date(getdatetime[0].split("/").reverse().join("-"));
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
    var newdate = yy + "/" + mm + "/" + dd + ' ' + getdatetime[1] + ' ' + getdatetime[2];
    return newdate;
}
function SubGrid() {

    $(".toodle").click(function(event) {

        if ($("#" + this.id).text() == "-") {

            // $("#tst" + this.id).toggle();
            //  $("#" + this.id).empty();
            $("#" + this.id).text("+");
            $("#tst" + this.id).hide();
            //  $("#tst" + this.id).hide();


        } else if ($("#" + this.id).text() == "+") {
            //$("#tst" + this.id).remove();

            $("#" + this.id).text("-");
            var InvoiceInputData = [];
            InvoiceInputData.push({

                InvoiceID: this.id
            });



            if ($("#tst" + this.id).text() == '') {
                InVoiceDataLOad(InvoiceInputData, '');
                var txtSubtable = document.getElementById('hdnSubtable').value;
                $(txtSubtable).insertAfter($(this).closest('tr'));
            }
            subfuncCheck();


            $("#tst" + this.id).show();
            event.preventDefault();
        }

        txtSubtable = "";
        document.getElementById('hdnSubtable').value = "";

    });



    $(".ckh").click(function() {

        var currentID = $("#" + this.id).closest('tr').find('.toodle').attr('id');

        var ID = currentID;
        var TxtTDSID = 'txtTDS' + ID;
        var TxtDiscountID = 'txtDiscount' + ID;
        if ($('#' + this.id + '').prop('checked') == true && ($('#' + TxtDiscountID + '').val() != '' || $('#' + TxtTDSID + '').val() != '')) {
            var result = confirm('Are you sure to click KnockOff, Already discount or TDS amount is entered ?');
            if (result == true) {
            $('#txtDiscountAmount').attr('disabled');
             $('#txtTDSAmount').attr('disabled');  
            $('#txtReceivedAmt').attr('disabled','disabled');   
                $('#' + this.id + '').prop('checked', true);
                var boolchk = $("#" + this.id).closest('td').next('td').find('input').prop("checked");
                if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
                    $("#" + this.id).prop("checked", false);
                }
                if ((boolchk != true) && ($("#" + this.id).closest('tr').find('.toodle').text() != '-')) {
                    $("#" + this.id).closest('tr').find('.toodle').click();
                    $('.subckhK' + currentID).prop("checked", true);
                }
                if ($("#" + this.id).closest('tr').find('.toodle').text() == '-') {
                    $('.subckhK' + currentID).prop("checked", $("#" + this.id).prop("checked"));
                }
                if ($("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueW:checked').length > 0 && (boolchk != true)) {
                    $("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueW:checked').prop("checked", false);
                }
                
                $('#' + TxtDiscountID + '').val('');
                $('#' + TxtTDSID + '').val('');
                
            }
            else {
                $('#' + this.id + '').prop('checked', false);
            }
        }
        else {
            var boolchk = $("#" + this.id).closest('td').next('td').find('input').prop("checked");
            if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
                $("#" + this.id).prop("checked", false);
            }
            if ((boolchk != true) && ($("#" + this.id).closest('tr').find('.toodle').text() != '-')) {
                $("#" + this.id).closest('tr').find('.toodle').click();
                $('.subckhK' + currentID).prop("checked", true);
            }
            if ($("#" + this.id).closest('tr').find('.toodle').text() == '-') {
                $('.subckhK' + currentID).prop("checked", $("#" + this.id).prop("checked"));
            }
            if ($("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueW:checked').length > 0 && (boolchk != true)) {
                $("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueW:checked').prop("checked", false);
            }
            $('#txtDiscountAmount').attr('disabled');
             $('#txtTDSAmount').attr('disabled');  
        }

    });

    $(".ckhwrite").click(function() {
        var currentID = $("#" + this.id).closest('tr').find('.toodle').attr('id');

        var ID = currentID;
        var TxtTDSID = 'txtTDS' + ID;
        var TxtDiscountID = 'txtDiscount' + ID;
        if ($('#' + this.id + '').prop('checked') == true && ($('#' + TxtDiscountID + '').val() != '' || $('#' + TxtTDSID + '').val() != '')) {
            var result = confirm('Are you sure to click WriteOff, Already discount amount is entered ?');
            if (result == true) {
                $('#' + this.id + '').prop('checked', true);

                var boolchk = $("#" + this.id).closest('td').prev('td').find('input').prop("checked");
                if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
                    //  alert('hi');
                    $("#" + this.id).prop("checked", false);
                }
                if ((boolchk != true) && ($("#" + this.id).closest('tr').find('.toodle').text() != '-')) {
                    $("#" + this.id).closest('tr').find('.toodle').click();
                    $('.subckhW' + currentID).prop("checked", true);
                }
                if ($("#" + this.id).closest('tr').find('.toodle').text() == '-') {
                    $('.subckhW' + currentID).prop("checked", $("#" + this.id).prop("checked"));
                }
                if ($("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueK:checked').length > 0 && (boolchk != true)) {
                    $("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueK:checked').prop("checked", false);

                }

                if ($('#txtDiscountAmount').val() != '' && $('#txtDiscountAmount').val() != 0) {
                    $('#txtDiscountAmount').val('0');
                }
                if ($('#txtTDSAmount').val() != '' && $('#txtTDSAmount').val() != 0) {
                    $('#txtTDSAmount').val('0');
                }

                $('#' + TxtDiscountID + '').val('');
                $('#' + TxtTDSID + '').val('');

            }
            else {
                $('#' + this.id + '').prop('checked', false);
            }
        }
        else {
            var boolchk = $("#" + this.id).closest('td').prev('td').find('input').prop("checked");
            if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
                //  alert('hi');
                $("#" + this.id).prop("checked", false);
            }
            if ((boolchk != true) && ($("#" + this.id).closest('tr').find('.toodle').text() != '-')) {
                $("#" + this.id).closest('tr').find('.toodle').click();
                $('.subckhW' + currentID).prop("checked", true);
            }
            if ($("#" + this.id).closest('tr').find('.toodle').text() == '-') {
                $('.subckhW' + currentID).prop("checked", $("#" + this.id).prop("checked"));
            }
            if ($("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueK:checked').length > 0 && (boolchk != true)) {
                $("#" + this.id).closest('tr').next('tr').find('#supbill .NetValueK:checked').prop("checked", false);

            }
        }



    });
}

function subfuncCheck() {
    $(".NetValueK").click(function() {
        var woff = $(this).closest('.sup').prev('tr').find('td input.ckh').prop('checked')
        var boolchk = $("#" + this.id).closest('td').next('td').find('input').prop("checked");
        if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
            $("#" + this.id).prop("checked", false);
        }
    });
    $(".NetValueW").click(function() {
       var woff=$(this).closest('.sup').prev('tr').find('td input.ckhwrite').prop('checked')
        var boolchk = $("#" + this.id).closest('td').prev('td').find('input').prop("checked");
        if ((boolchk == true) && ($("#" + this.id).prop("checked") == true)) {
            $("#" + this.id).prop("checked", false);


        }
    });
}


function CalculationArea() {

    if ('' == '') {
        var TotalKnockoff = 0;
        var TotalWriteoff = 0;

        var UnTotalKnockoff = 0;
        var UnTotalWriteoff = 0;

        var entry1 = $('#tblEnterTissue .NetValueK:checked');

        var entry2 = $('#tblEnterTissue .NetValueW:checked');
        // iterate through each td based on class and add the values
        $.each($(entry1), function(id, val) {

            var value = $(this).attr('NetValue');
            // add only if the value is number
            if (!isNaN(value) && value.length != 0) {
                TotalKnockoff += parseFloat(value);
            }

        });

        $.each($(entry2), function(id, val) {

            var value = $(this).attr('NetValue');
            // add only if the value is number
            if (!isNaN(value) && value.length != 0) {
                TotalWriteoff += parseFloat(value);
            }

        });

        var entry3 = $('#tblEnterTissue .NetValueK:not(checked)');

       // var entry4 = $('#tblEnterTissue .NetValueW:not(checked)');
        $.each($(entry3), function(id, val) {
        var fnKnokoffam = $('#tblEnterTissue').find('#' + $(this).attr('id')).closest('td').next('td').find('input').prop('checked');
        if ($(this).prop("checked") == false && fnKnokoffam==false) {
                var value = $(this).attr('NetValue');
                // add only if the value is number
                if (!isNaN(value) && value.length != 0) {
                    UnTotalKnockoff += parseFloat(value);
                }
            }
        });


           
        var TotalDiscount = 0;
        $.each($('#tblEnterTissue tbody tr .txtDiscountID'), function(id, val) {
            var value = $(this).val();
            if ($.isNumeric(value)) {
                TotalDiscount = parseFloat(TotalDiscount) + parseFloat($(val).val());
            }

        });
        
                var TotalDUe = 0;
        $.each($('#tblEnterTissue tbody tr .tdDue'), function(id, val) {
            var value = $(this).attr('dueAmt');
            if ($.isNumeric(value)) {
                TotalDUe = parseFloat(TotalDUe) + parseFloat(value);
            }

        });

        

        var TotalTDS = 0;
        $.each($('#tblEnterTissue tbody tr .txTDSID'), function(id, val) {
        var value = $(this).val();
        if ($.isNumeric(value)) {
                TotalTDS = parseFloat(TotalTDS) + parseFloat($(val).val());
            }

        });

      

  
        
       
        $('#txtAmuRec').val((TotalKnockoff + TotalWriteoff));

      //  balanceAmount = (receiveAmo) - (TotalKnockoff + TotalWriteoff);

       

            if ($('#tblEnterTissue .trrow').length > 0) {
                var PendingOutstanding = 0;
                var TotalPending = 0;
                var TotalInvAmount = 0;
                var receivedAmount = 0;
                var InvBalAmount = 0;
                $('#txtknoff').val(TotalKnockoff);
                $('#txtwrite').val(TotalWriteoff);
               
                $('#txtCredit').val('');
                PendingOutstanding = parseFloat($('#txtpendOut').val());

                TotalInvAmount = parseFloat($('#txttlInv').val());
                receivedAmount = parseFloat($('#txtAmuRec').val());
                $('#txtTotalInAmt').val(TotalInvAmount);
                $('#txtReceivedAmt').val(receivedAmount);



                $('#txtDiscountAmount').val(TotalDiscount);
                $('#txtTDSAmount').val(TotalTDS);
                
//                $('#txtDiscountAmount').attr('disabled', true);
//                $('#txtTDSAmount').attr('disabled', true);
                
                
                
                InvBalAmount = TotalInvAmount - receivedAmount;
                if (InvBalAmount > 0) {
                    $('#txtInBal').val(InvBalAmount);

                }
                else {
                    InvBalAmount = 0;
                    $('#txtInBal').val(InvBalAmount);
                }
                TotalPending = (UnTotalKnockoff) + (PendingOutstanding);
                $('#txtTotal').val(TotalPending);
                $('#txtReceivedAmt').attr('outval',TotalPending-(TotalTDS+TotalDiscount));
				if(TotalDUe >0)
				{
					
			    $('#txtTotal').val(TotalDUe-(TotalTDS+TotalDiscount));
                $('#txtReceivedAmt').attr('outval',TotalDUe-(TotalTDS+TotalDiscount));
				}
                $('#btnSaveIn').show();
                
            }
    }
    else {
        alert("Please Fill Recevied Amount");
        $('#txtAmuRec').focus();
    }
}

function DataValidation(){
 var PaymentType = $('select[id$="ddlPaymentType"] :selected');
   var ChequeDate =$("#txtChequeValid").val();
    var PaymentTypeID = 1;
    if (PaymentType != null) {
        PaymentTypeID = $(PaymentType).val();
    }
    if(PaymentTypeID==3)
    {
         if($("#txtCardType").val()=="" || $("#txtCheque").val()=="")
         {
          alert("Please provide card details");
          return false;
         }
         else
         {
             SaveDetails();
         }
    }
    else if(PaymentTypeID==2 || PaymentTypeID==4)
    {
         if(ChequeDate=="" || $("#txtCheque").val()=="")
         {
             alert("Please provide cheque details");
             return false;
         }
         else
         {
             SaveDetails();
         }
    }
    else
    {
         SaveDetails();
    }
}

function SaveDetails() {
   var PaymentType = $('select[id$="ddlPaymentType"] :selected');
   var ChequeDate =$("#txtChequeValid").val();
    var PaymentTypeID = 1;
    if (PaymentType != null) {
        PaymentTypeID = $(PaymentType).val();
    }
    if(PaymentTypeID==2 && ChequeDate!=""){
         
    }
    var prows = $('#tblEnterTissue >tbody > tr.trrow');
    var entry1 = $('#tblEnterTissue .getdetails .subckhwrite');
    var kickoffAmount = 0;
    var writeoffAmount = 0;
    var lstinvoiceReceDetails = [];
    var CardType = $("#txtCardType").val();
    var CheckNo = $("#txtCheque").val();
    var CreditAmount = $("#txtCredit").val();
    if (CreditAmount=="") {
         CreditAmount=0;
    }
  
    if (ChequeDate == "")
         ChequeDate = "01-01-1900";
     var ChequeImage = $("#xlsUpload").val();

     $.each($(prows), function(id, val) {
         var DiscountAmt = $(val).find('.txtDiscountID').val();
         var tdsidamount = $(val).find('.txTDSID').val();
         if (DiscountAmt == "") {
             DiscountAmt = 0;
         }
         if (tdsidamount == "") {
             tdsidamount = 0;
         }
         
         DiscountAmt = parseFloat(DiscountAmt);
         tdsidamount = parseFloat(tdsidamount);

        
         if ((DiscountAmt != '' || DiscountAmt > 0) || (tdsidamount != '' || tdsidamount > 0)) {

             var invoiceid = $($(val).find('td > a')[0]).attr('id');
             lstinvoiceReceDetails.push({
                 InvoiceID: invoiceid,
                 PaymentTypeID: PaymentTypeID,
                 ReceivedAmount: 0,
                 WriteOffAmt: 0,
                 BankNameorCardType: CardType,
                 ChequeorCardNumber: CheckNo,
                 CreditAmount: CreditAmount,
                 chequeDate: ChequeDate,
                 chequeImage: ChequeImage,
                 DiscountAmount: DiscountAmt,
                 TDSAmount: tdsidamount
             });
         }


     });
    $.each($(entry1), function(id, val) {

        var chkKickoff = $(this).closest('tr').find('.NetValueK').prop("checked");
        var chkWriteoff = $(this).closest('tr').find('.NetValueW').prop("checked");
        if (chkKickoff == true) {
            var FinalbillId = $(this).closest('tr').find('td.billid').text();
            var invoiceid = $(this).closest('tr').find('td.invoiceid').text();
            kickoffAmount = $(this).closest('tr').find('.NetValueW').attr('NetValue')

        }
        if (chkWriteoff == true) {
            var FinalbillId = $(this).closest('tr').find('td.billid').text();
            var invoiceid = $(this).closest('tr').find('td.invoiceid').text();
            writeoffAmount = $(this).closest('tr').find('.NetValueK').attr('NetValue')
        }
        // alert(bill + ' ' + invoice + ' ' + kickoffAmount + ' ' + writeoffAmount);

        if ((chkWriteoff == true) || (chkKickoff == true)) {
            lstinvoiceReceDetails.push({
                InvoiceID: invoiceid,
                PaymentTypeID: PaymentTypeID,
                ReceivedAmount: kickoffAmount,
                WriteOffAmt: writeoffAmount,
                BankNameorCardType: CardType,
                ChequeorCardNumber: CheckNo,
                CreditAmount:CreditAmount,
                chequeDate: ChequeDate,
                chequeImage: ChequeImage,
                DiscountAmount: 0,
                TDSAmount: 0,
		OrgID:FinalbillId
            });
        }
        kickoffAmount = 0;
        writeoffAmount = 0;
    });


    $.ajax({

        type: "POST",

        async: false,
        contentType: "application/json; charset=utf-8",

        url: "../WebService.asmx/pUpdateInvoicePayment",

        data: JSON.stringify({ lstInvoices: lstinvoiceReceDetails }),

        dataType: "json",

        success: function(msg) {

            if (msg.d > 0) {
                alert('Saved Successfully');
                FirstLoad(invoice);
                $('#btnSaveIn').hide();
                var credit = $('#txtCredit').val();
                if (credit > 0) {
                    InsertCreditSummary();
                }
            }
        },


        error: function(Result) {

            alert("Error");

        }

    });
}


function InsertCreditSummary() {
    var lstCreditSummary = [];
    var ClientId = $('#hdnClientID').val();
    var CreditAmount = $('#txtCredit').val();
    lstCreditSummary.push({
        ItemType: 'Credit',
        ClientType: 'Client',
        ClientId: ClientId,
        Authorizedby: 0,
        Amount: CreditAmount,
        ReferenceType: 'INVOICE NO'
    });
    $.ajax({

        type: "POST",

        async: false,
        contentType: "application/json; charset=utf-8",

        url: "../WebService.asmx/InsertCreditDebitSummary",

        data: JSON.stringify({ lstCreditSummary: lstCreditSummary }),

        dataType: "json",

        success: function(msg) {

            if (msg.d > 0) {
//                alert('Nice');

            }
        },


        error: function(Result) {

            alert("Error");

        }

    });
}



$(function() {
$("input[id*='txtAmuRec']").keydown(function(event) {


        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

        } else {
            event.preventDefault();
        }

        if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
            event.preventDefault();

    });
});


function SplitAmounttoDiscount() {

           if ($('#txtDiscountAmount').val() != '' && $('#txtDiscountAmount').val() != 0) {
              var discountamount = $('#txtDiscountAmount').val();
               var discountvalue = 0;
                var tbllength = $('#tblEnterTissue .trrow').length;
               discountvalue = discountamount / tbllength;
              $('#tblEnterTissue tbody tr .txtDiscountID').val(discountvalue);


         }
     }

     function SplitAmounttoTDS() {

                if ($('#txtTDSAmount').val() != '' && $('#txtTDSAmount').val() != 0) {
                    var TDSAmount = $('#txtTDSAmount').val();
                 var TDSValue = 0;
                  var tbllength = $('#tblEnterTissue .trrow').length;
                  TDSValue = TDSAmount / tbllength;
                    $('#tblEnterTissue tbody tr .txTDSID').val(TDSValue);

                }
     }
     