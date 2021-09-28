var oTable;
var hoverEvent = true;

var data;
var locCount = 0;
var DepCount = 0;


           $(document).ready(function() {

               $('#tatDiv').hide();
               $(document).on('click', '.panel-heading span.clickable', function(e) {
                   var $this = $(this);
                   if (!$this.hasClass('panel-collapsed')) {
                       $this.parents('.panel').find('.panel-body').slideUp();
                       $this.addClass('panel-collapsed');
                       $this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
                   } else {
                       $this.parents('.panel').find('.panel-body').slideDown();
                       $this.removeClass('panel-collapsed');
                       $this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
                   }
               });
               for (i = new Date().getFullYear(); i > 1900; i--) {
                   $('#monthyearpicker').append($('<option />').val(i).html(i));
               }
               ddlDevice();
               // ddlLocation();
               ddlDepartment();

              
               
            


               var fill = [];
               var arr = {};
               arr.Text = 'Jan';
               arr.ID = 1;
               fill.push(arr);

               $('#ddlFiltertype').change(function() {

                   if ($(this).val() != 0) {
                       $('#ddlMonth').removeAttr('disabled');
                   }
                   else { $('#ddlMonth').attr('disabled', 'disabled'); }

               });             

              

               $('#btnFilter').click(function() {
                   Filterclick();

               });

               $("#ddlOrganization").change(function() {

                   var Orgid = $('#ddlOrganization').val();
                   if (Orgid != 0) {
                       ddlLocation(Orgid);
                   }

                   else {
                       $("#ddlLocation").empty();
                       $("#ddlLocation").append($('<option></option>').val(0).html('---No Records---'));
                   }
               });

               var now = new Date();

               var day = ("0" + now.getDate()).slice(-2);
               var month = ("0" + (now.getMonth() + 1)).slice(-2);

               var today = now.getFullYear() + "-" + (month) + "-" + (day);
               $('input[type="time"][value="now"]').each(function() {
                   var d = new Date(),
        h = d.getHours(),
        m = d.getMinutes();
                   if (h < 10) h = '0' + h;
                   if (m < 10) m = '0' + m;
                   $(this).attr({
                       'value': h + ':' + m
                   });
               });
               $('#txtDate').val(today);
               $('#ddlDate').change(function() {
                   var datePeriod = $(this).val();
                   $fromDate = $('#txtFromDate');
                   $toDate = $('#txtToDate');
                   var DateFormat = 'DD/MM/YYYY';
                   $dateFilter = $('.dateFilter');
                   if (datePeriod == '0') {
                       $dateFilter.hide();
                   }
                   else {
                       $dateFilter.show();
                   }
                   if (datePeriod != '5') {
                       $fromDate.attr('disabled', 'disabled');
                       $toDate.attr('disabled', 'disabled');
                   }
                   if (datePeriod == '1') {
                       $fromDate.val(moment().startOf('Week').format(DateFormat));
                       $toDate.val(moment().endOf('Week').format(DateFormat));
                   }
                   if (datePeriod == '2') {
                       $fromDate.val(moment().subtract(1, 'weeks').startOf('Week').format(DateFormat));
                       $toDate.val(moment().subtract(1, 'weeks').endOf('Week').format(DateFormat));
                   }
                   if (datePeriod == '3') {

                       $fromDate.val(moment().startOf('month').format(DateFormat));
                       $toDate.val(moment().endOf('month').format(DateFormat));
                   }
                   if (datePeriod == '4') {
                       $fromDate.val(moment().subtract(1, 'months').startOf('month').format(DateFormat));
                       $toDate.val(moment().subtract(1, 'months').endOf('month').format(DateFormat));
                   }
                   if (datePeriod == '5') {
                       $fromDate.val('');
                       $toDate.val('');
                       $fromDate.removeAttr('disabled');
                       $toDate.removeAttr('disabled');
                   }
                   if (datePeriod == '6') {
                       $fromDate.val(moment().startOf('year').format(DateFormat));
                       $toDate.val(moment().endOf('year').format(DateFormat));
                   }
                   if (datePeriod == '7') {
                       $fromDate.val(moment().subtract(1, 'years').startOf('year').format(DateFormat));
                       $toDate.val(moment().subtract(1, 'years').endOf('year').format(DateFormat));
                   }
               });





               $('#ddlType').on('change', function() {
                   var WGCode = $(this).val();
                   var WCode = $(this).attr('WCode');
                   var txt = $('#ddlType option:selected').text();
                   $('#innerheader').html('');
                   $('#innerheader').html(txt);
                   var lst = GetMISReport(WCode, WGCode);
                   bindMIStable(lst);
               });

               $('#btntatsearch').on('click', function() {
                   var WGCode = $('#ddlTatType').val();
                   var WCode = $('#ddlTatType').attr('WCode');
                   var txt = $('#ddlTatType option:selected').text();
                   $('#innerheader').html('');
                   $('#innerheader').html(txt);
                   filterData.checkDiff = $('#ddltathours').val();
                   var lst = GetMISReport(WCode, WGCode);
                   bindMIStable(lst);
               });
    LoadDefaultDrpvalues();
               LoadWidgetDetails();
            //   LoadData();
               $('#ddlwlt').change(function() {
                   var WLT = $('#ddlwlt').val();
                   GetWorLoadMISReport(WLT);
               });
               $('#ddldwb').change(function() {
                   var DWWLB = $('#ddldwb').val();
                   GetWorLoadMISReport(DWWLB);
               });
               $('#ddldtt').change(function() {
                   var DTT = $('#ddldtt').val();
                   GetWorLoadMISReport(DTT);
               });
                   $('.tool').hover(function() {

                       var cnt = $(this)[0].innerText;
                       if (cnt != 0) {
                           var spn = $(this).next('span')[0];
                          var txt = $(spn).attr('value')
                           var tbl = $(this).next('span')[0].innerHTML;
                           tooltip.pop(this, '<h4>' + txt + '</h4>' + tbl);
                      }
                   });

});

function LoadDefaultDrpvalues() {
    var diff = 1;
    var lid = $("#ddlLocation").val();
    var didd = $("#ddlDepartment").val();
    var orgid = $("#ddlOrganization").val();
    var frmDate = dateformat($("#txtFromDate").val(), 'YYYY-MM-DD');
    var toDate = dateformat($("#txtToDate").val(), 'YYYY-MM-DD');
    if ($('#ddlDate').val() == 0) {
        diff = 0;
        frmDate = moment().format('YYYY-MM-DD');
        toDate = moment().format('YYYY-MM-DD');
    }
    filterData.OrgID = orgid;
    filterData.LocationID = lid;
    filterData.DepartmentID = didd;
    filterData.fromDate = frmDate;
    filterData.toDate = toDate;
    filterData.checkDiff = diff;

}


           function loadGeneralStaticsControl() {


               var data1 = [{ 'ID': 0, 'Text': 'All' }, { 'ID': 1, 'Text': 'Jan' }, { 'ID': 2, 'Text': 'Feb' }, { 'ID': 3, 'Text': 'Mar' }, { 'ID': 4, 'Text': 'Apr' }
    , { 'ID': 5, 'Text': 'May' }, { 'ID': 6, 'Text': 'Jun' }, { 'ID': 7, 'Text': 'Jul' }, { 'ID': 8, 'Text': 'Aug' }
    , { 'ID': 9, 'Text': 'Sep' }, { 'ID': 10, 'Text': 'Oct' }, { 'ID': 11, 'Text': 'Nov' }, { 'ID': 12, 'Text': 'Dec'}];
               //var dater = JSON.stringify(data1);


               $('#ddlMonth').empty();
               $.each(data1, function(key, val) {

                   $('#ddlMonth').append($('<option />').val(val.ID).html(val.Text));
               });
               $('#monthyearpicker').empty();
               for (i = new Date().getFullYear(); i > 2000; i--) {
                   $('#monthyearpicker').append($('<option />').val(i).html(i));
               }

               $('#monthyearpicker').change(function() {
                   showLoader(true);
                   loadGeneralStatistics();
                   showLoader(false);
               });
               $('#ddlMonth').change(function() {
                   showLoader(true);
                   loadGeneralStatistics();
                   showLoader(false);
               });
               loadGeneralStatistics();
           
           }
function ShowMis() {

    $('.dashLink').on('click', function(e) {
        var arr = [];
        var head = $(this).parents('.panel-body');
        var row = $(head[0]).find('.dash');
        var ctrl = '#ddlType';
        var title = $(this).attr('header');
        var innertitle = $(this).attr('WDetail');
        var WGCode = $(this).attr('WGCode');
        var WCode = $(this).attr('WCode');
        $('#ddlType').attr('WCode', WCode);
        $('#header').html('');
        $('#innerheader').html('');
        $('#header').html(title);
        $('#innerheader').html(innertitle);

        var val = $('#ddlTatType option:first').val();
        $('#ddlTatType').val(val);

        var val1 = $('#ddltathours option:first').val();
        $('#ddltathours').val(val1);
        $(ctrl).empty();
        $.each(row, function(id, val) {
            var item = $(val).attr('WGCode');
            var text = $(val).attr('WDetail');

            var option = $('<option/>');
            option.attr('value', item).text(text);
            $(ctrl).append(option);
            if (item != null && item == 'WG-TAT-NT') {
                $("#tatDiv").show();
            }
            else {
                $("#tatDiv").hide();
            }

        });
        $(ctrl).val(WGCode);
        $('[data-popup="popup-1"]').fadeIn(350);
        e.preventDefault();
        var lst = GetMISReport(WCode, WGCode);
        bindMIStable(lst);
    });

}

function LoadWidgetDetails() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    var today = dd + '/' + mm + '/' + yyyy;


    var LocationID = $('#ddlLocation').val();
    var DeptID = $('#ddlDepartment').val();
    var date = $('#ddlDate').val();
    var FromDate = '';
    var ToDate = '';
    var mis = '';
    if (date == 0) {
        FromDate = today;
        ToDate = today;
    }
    else {

        FromDate = document.getElementById('txtFromDate').value;
        ToDate = document.getElementById('txtToDate').value;
    }
    var OrgID = document.getElementById('hdnorgid').value;
    var RoleID = document.getElementById('hdnroleid').value;
    var LoginID = document.getElementById('hdnuserid').value;


    var lst = LoadWidgetbyroleanduser(OrgID, RoleID, LoginID);
    mis = LoadWidgetcountmis(OrgID, LocationID, DeptID, FromDate, ToDate, RoleID);
    BindWidgets(lst, mis);
    ShowMis();
   // loadGeneralStatistics();

}
function BindWidgets(lst, mis) {
    var lst1 = lst[0];
    var lst2 = lst[1];
    var items = {}, base, key;
    $.each(lst1, function(index, val) {
        key = val.WCode.substring(1, 3);
        if (!items[key]) {
            items[key] = 0;
        }
        items[key]++;
    });
    var panels1 = [];
    var panels2 = [];
    var panels3 = [];
    var panels4 = [];
    var panels5 = [];
    $('#widgets').html('');
    $.each(lst1, function(id, val) {

        var code = val.WCode.substring(1, 3);
        if (code == "01" || code == "06") {
            var WID = val.WID;

            var txt = WidgetsType1(val.WID, val.WName, lst2, mis);
            panels1.push(txt);
        }
        else if (code == "02") {

            var txt = WidgetsType2(val.WID, val.WName, lst2, mis);
            panels2.push(txt);
            // $('#widgets').append(txt);
        }
        else if (code == "03") {

            var txt = WidgetsType3(val.WID, val.WName, lst2, mis);
            panels3.push(txt);
            // $('#widgets').append(txt);
        }
        else if (code == "04") {

            var txt = WidgetsType4(val.WID, val.WName, lst2, mis);
            panels4.push(txt);
            // $('#widgets').append(txt);
        }
        
        else if (code == "05") {

            var txt = WidgetsType5(val.WID, val.WName, lst2, mis);
            panels5.push(txt);
            // $('#widgets').append(txt);
        }
//        else if (code == "06") {

//            var txt = WidgetsType6(val.WID, val.WName, lst2, mis);
//            panels1.push(txt);
//            // $('#widgets').append(txt);
//        }
        
    });
    var p1 = 0;
    var p2 = 0;
    var p3 = 0;
    var divrow = '';
    var Cssclass1 = '<div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 pnlDiv">';
    var Cssclass2 = '<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 pnlDiv">';
    var Cssclass4 = '<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 pnlDiv">';
    var Cssclass3 = '<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 pnlDiv">';
    var rtext = "";
    var isGS = false;
    var isQCGS = false;
   // rtext = Cssclass1
    $.each(panels1, function(id, val)
    { rtext =rtext+ Cssclass1 + panels1[id] + '</div>'; });
   // rtext = Cssclass1 + panels1[0] + '</div>' + Cssclass1 + panels1[1] + '</div>' + Cssclass1 + panels1[2] + '</div>' + Cssclass1 + panels1[3] + '</div>' + Cssclass1 + panels1[4] + '</div></div>';
   
   
    rtext = rtext + divrow;
    $.each(panels2, function(id, val)
    { rtext = rtext + Cssclass2 + panels2[id] + '</div>'; });
    rtext = rtext + '</div>';

    rtext = rtext + divrow;
    $.each(panels4, function(id, val) {
        rtext = rtext + Cssclass3 + panels4[id] + '</div>';
        isGS = true;
    });
    rtext = rtext + '</div>';
    
    rtext = rtext + divrow;
    $.each(panels3, function(id, val) {
        rtext = rtext + Cssclass3 + panels3[id] + '</div>';
        isGS = true;
    });
    rtext = rtext + '</div>';

   
   
    rtext = rtext + divrow;
    $.each(panels5, function(id, val)
    { rtext = rtext + Cssclass3 + panels5[id] + '</div>'; isQCGS = true; });
      rtext = rtext + '</div>';

    //rtext = rtext + divrow + Cssclass2 + panels2[0] + '</div>' + Cssclass2 + panels4[0] + '</div>' + Cssclass2 + panels2[1] + '</div></div>';
   // rtext = rtext + divrow + Cssclass3 + panels3[0] + '</div></div>';
    //rtext = rtext + divrow + Cssclass3 + panels5[0] + '</div></div>';
    

    $('#widgets').append(rtext);

    if (isQCGS) {
        loadGeneralStaticsControl();
    }

    //    var DefaultWLT =  $('#ddlwlt').val();
    //    var DefaultDWWLB = $('#ddldwb').val();
    //    var DefaultDTT = $('#ddldtt').val();

    if (isGS) {
        GetWorLoadMISReport('WLT');
        GetWorLoadMISReport('DWB');
        GetWorLoadMISReport('DTT');
    }


}
function WidgetsType1(wid, wname, lst1, mis) {

    var ResultValue = JSON.parse(mis);
    // alert(ResultValue);
    var txt = '<div id=' + wid + ' class="animated fadeInDown delay3 panel panel-danger card marginB15 bg-lightGrey" style="height:235px;">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-8 col-sm-8 col-xs-8 lh36">' + wname + '</h3>\
					<div class="col-md-4 col-sm-4 col-xs-4 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body box-body lh28 noBulletList">';
    var MD = "";
    $.each(lst1, function(id, val) {
        var WID = val.WID;
        var WDetail = val.DetailedName;
        var WGCode = val.WGCode;
        var Tcount = 0;
        var isLink = val.ShowReport;
        var cclass = "ullabel clickable dashLink dash";
        if (isLink == 0)
        { cclass = "ullabel1"; }
        if (wid == WID) {
            MD = MD + '<li>' + WDetail + '<label ';

            $.each(ResultValue, function() {
                $.each(this, function(name, value) {

                    if (name == WGCode) {
                        Tcount = value;
                    }
                });
            });
            // MD = MD + 'class ="pull-right ullabel ' + cclass + '">' + Tcount + '</label></li>';
            MD = MD + 'class ="pull-right ' + cclass + '" header="' + WDetail + '" WDetail="' + WDetail + '" WID=' + val.WID + ' WCode="' + val.WCode + '" WGCode="' + val.WGCode + '">' + Tcount + '</label></li>';
        }
    });


    return txt + MD + '</div></div>';

}

function WidgetsType6(wid, wname, lst1, mis) {

    var ResultValue = JSON.parse(mis);
    // alert(ResultValue);
    var txt = '<div id=' + wid + ' class="animated fadeInDown delay3 panel panel-danger card marginB15 bg-lightGrey" style="height:235px;">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-8 col-sm-8 col-xs-8 lh36">' + wname + '</h3>\
					<div class="col-md-4 col-sm-4 col-xs-4 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body box-body lh28 noBulletList">';
    var MD = "";
    $.each(lst1, function(id, val) {
        var WID = val.WID;
        var WDetail = val.DetailedName;
        var WGCode = val.WGCode;
        var Tcount = 0;
        var isLink = val.ShowReport;
        var cclass = "ullabel clickable tool";
        if (isLink == 0)
        { cclass = "ullabel1"; }
        if (wid == WID) {
            MD = MD + '<li>' + WDetail + '<label ';

//            $.each(ResultValue, function() {
//                $.each(this, function(name, value) {

//                    if (name == WGCode) {
//                        Tcount = value;
//                    }
//                });
//            });
            // MD = MD + 'class ="pull-right ullabel ' + cclass + '">' + Tcount + '</label></li>';
            MD = MD + 'class ="pull-right ' + cclass + '" header="' + WDetail + '" WDetail="' + WDetail + '" WID=' + val.WID + ' WCode="' + val.WCode + '" WGCode="' + val.WGCode + '">0</label></li>';
        }
    });


    return txt + MD + '</div></div>';

}

function WidgetsType2(wid, wname, lst1, mis) {
    var ResultValue = JSON.parse(mis);
    var Tcount = 0;
    var txt = '<div class="animated fadeInDown delay2 panel panel-success card marginB15 bg-lightGrey">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-6 col-sm-6 col-xs-6 lh36">' + wname + '</h3>\
					<div class="col-md-6 col-sm-6 col-xs-6 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body">';

    var MD = "";
    $.each(lst1, function(id, val) {
        var WID = val.WID;
        var WGCode = val.WGCode;
        var WDetail = val.DetailedName;
        var isLink = val.ShowReport;
        var cclass = "clickable dashLink dash";
        if (isLink == 0)
        { cclass = "ullabel1"; }
        if (wid == WID) {
            // MD = MD + '<li><i class="fa fa-circle-o-notch fa-spin fa-fw"></i>' + WDetail + '<label ';
            // MD = MD + 'class ="pull-right ullabel tool clickable">0</label></li>';

            //            $.each(ResultValue, function() {
            //                $.each(this, function(name, value) {

            //                    if (name == WGCode) {
            //                        Tcount = value;
            //                    }
            //                });
            //            });

            var Count = ResultValue[1][WGCode];
            if (Count == undefined || Count == null) {
                Count = 0;
            }

            MD = MD + '<div class="col-md-1 col-sm-4 col-xs-12"><div class="info-box">\
                <i class="info-box-icon bg-aqua ' + val.Icon + '"></i><div class="info-box-content ' + cclass + '" header="' + WDetail + '" WDetail="' + WDetail + '" WID=' + val.WID + ' WCode="' + val.WCode + '" WGCode="' + val.WGCode + '">\
                <span class="info-box-text a-center">' + WDetail + '</span>\
                <span class="info-box-number a-center marginT5">' + Count + '</span>\
                </div></div></div>';
        }
    });



    return txt + '<div class="seven-cols">' + MD + '</div></div></div>';
}
function WidgetsType3(wid, wname, lst1, mis) {



    var txt = '<div class="animated fadeInDown delay4 panel panel-primary card marginB15 bg-lightGrey ">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-6 col-sm-6 col-xs-6 lh36">' + wname + '</h3>\
					<div class="col-md-6 col-sm-6 col-xs-6 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body">\
				<div class="row">\
				<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12" style="border-right: 2px solid #ebebeb;">\
				<div class="row">\
				<div class="col-lg-6" style="text-align:center;"><p>Workload Trends</p></div>\
				<div class="col-lg-6">\
				 <a onclick ="getWorkLoadTWvsLW();" style="cursor:pointer;text-decoration: underline;" > This Week vs Last Week </a>\
				<select style="display:none;text-decoration: underline;"   class="form-control pull-right" id="ddlwlt"> <option value="WLT-00">This Week</option><option value="WLT-01">Last Week</option><option value="WLT-02">This Week vs Last Week</option></select></div></div>\
				<div class="row">\
				<div id="barchartWLT" style="min-height:170px;">\
				</div></div></div>\
			    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12" style="border-right: 2px solid #ebebeb;">\
				<div class="row">\
				<div class="col-lg-12" style="text-align:center;"><p>Department wise workload breakup</p></div>\
				<div class="col-lg-4" style="display:none;"  ><select class="form-control pull-right" id="ddldwb"> <option value="DWB-00">Today</option><option value="DWB-01">Last Week</option><option value="DWB-02">Last Month</option></select></div></div>\
				<div class="row">\
				<div id="pie-chart" style="min-height:170px;">\
				</div></div></div>\
				<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12" style="border-right: 2px solid #ebebeb;">\
				<div class="row">\
				<div class="col-lg-12" style="text-align:center;"><p>Delayed TAT Trends</p></div>\
				<div class="col-lg-4" style="display:none;" ><select  class="form-control pull-right" id="ddldtt"><option value="DTT-00">Today</option><option value="DTT-01">Last Week</option><option value="DTT-02">Last Month</option></select></div></div>\
				<div class="row">\
				<div id="barchartDTT"  style="min-height:170px;">\
				</div></div></div>\
				</div>';

    return txt + '</div></div>';

}
function WidgetsType4(wid, wname, lst1, mis) {

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    var currentdateandtime = dd + '/' + mm + '/' + yyyy + ' ' + today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds(); ;

    //alert(currentdateandtime);

    var ResultValue = JSON.parse(mis);
  //  alert(ResultValue.length);
   
        if (ResultValue[4] != undefined || ResultValue[4] != null) {
            var NearingTAT = ResultValue[4];

        }
        if (ResultValue[5] != undefined || ResultValue[5] != null) {
            var DelayedTAT = ResultValue[5];

        }
   
    
    $('#ddlTatType').empty();
    $.each(lst1, function(id, val) {
        var WID = val.WID;
        var WGCode = val.WGCode;
        var WDetail = val.DetailedName;

        if (wid == WID) {
            if (WGCode != null) {
                $('#ddlTatType').append('<option value="' + WGCode + '">' + WDetail + '</option>');
                $('#ddlTatType').attr('WCode', val.WCode);
            }
        }
    });

    var Tcount = 0;

    var txt = '<div class="animated fadeInDown delay4 panel panel-success card marginB15 bg-lightGrey">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-6 col-sm-6 col-xs-6 lh36">' + wname + '</h3>\
					<div class="col-md-6 col-sm-6 col-xs-6 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body">\
<table class="w-100p" style="width: 100%;"><tbody>\
<tr>	<th align="left" style="width: 13%; padding-left:0px;"><label class="pull-right ullabel clickable dashLink dash" style="color:red;font-size:14px"; header="TAT" wdetail="Turn Around Time Details" wid="' + wid + '"  wcode="W04-TAT" wgcode="WG-TAT-NT">**View Report**</label>\
	</th>	<th>1 hr</th>	<th>2 hrs</th>	<th>3 hrs</th>	<th>4 hrs</th>	<th>5 hrs</th>	<th>6 hrs</th>	<th>1 day</th>	<th>>1 day</th></tr>';



    var MD = "";
    // $.each(lst1, function(id, val) {
    //  var WID = val.WID;
    //  var WGCode = val.WGCode;
    //  var WDetail = val.DetailedName;

    var hr1 = 0;
    var hrs2 = 0;
    var hrs3 = 0;
    var hrs4 = 0;
    var hrs5 = 0;
    var hrs6 = 0;
    var day1 = 0;
    var day2 = 0;
    var WGCode = '';
    //if (wid == WID) {

    if (NearingTAT != undefined || NearingTAT != null) {
        $.each(NearingTAT, function(name, value) {
            var Code = name.split("_");
            WGCode = Code[0];
            if (Code[0] == 'WG-TAT-NT') {

                if (parseInt(value) == 1) {
                    hr1 = parseInt(hr1) + 1;
                }
                if (parseInt(value) == 2) {
                    hrs2 = parseInt(hrs2) + 1;
                }
                if (parseInt(value) == 3) {
                    hrs3 = parseInt(hrs3) + 1;
                }
                if (parseInt(value) == 4) {
                    hrs4 = parseInt(hrs4) + 1;
                }
                if (parseInt(value) == 5) {
                    hrs5 = parseInt(hrs5) + 1;
                }
                if (parseInt(value) == 6) {
                    hrs6 = parseInt(hrs6) + 1;
                }
                if (parseInt(value) > 6 && parseInt(value) <= 24) {
                    day1 = parseInt(day1) + 1;
                }
                if (parseInt(value) > 24) {
                    day2 = parseInt(day2) + 1;
                }
            }

        });
    }
    MD += '<tr><td><label WGCode="' + WGCode + '" >' + 'Nearing TAT' + '</label>	</td>	<td>' + hr1 + '</td>	<td>' + hrs2 + '</td>	<td>' + hrs3 + '</td>	<td>' + hrs4 + '</td>	<td>' + hrs5 + '</td>	<td>' + hrs6 + '</td>	<td>' + day1 + '</td>	<td>' + day2 + '</td></tr>';

    hr1 = 0;
    hrs2 = 0;
    hrs3 = 0;
    hrs4 = 0;
    hrs5 = 0;
    hrs6 = 0;
    day1 = 0;
    day2 = 0;


    if (DelayedTAT != undefined || DelayedTAT != null) {
        $.each(DelayedTAT, function(name, value) {
            var Code = name.split("_");
            WGCode = Code[0];
            var Values = value.split("-");
            if (Code[0] == 'WG-TAT-DT') {

                if (parseInt(Values[1]) == 1) {
                    hr1 = parseInt(hr1) + 1;
                }
                if (parseInt(Values[1]) == 2) {
                    hrs2 = parseInt(hrs2) + 1;
                }
                if (parseInt(Values[1]) == 3) {
                    hrs3 = parseInt(hrs3) + 1;
                }
                if (parseInt(Values[1]) == 4) {
                    hrs4 = parseInt(hrs4) + 1;
                }
                if (parseInt(Values[1]) == 5) {
                    hrs5 = parseInt(hrs5) + 1;
                }
                if (parseInt(Values[1]) == 6) {
                    hrs6 = parseInt(hrs6) + 1;
                }
                if (parseInt(Values[1]) > 6 && parseInt(Values[1]) <= 24) {
                    day1 = parseInt(day1) + 1;
                }
                if (parseInt(Values[1]) > 24) {
                    day2 = parseInt(day2) + 1;
                }
            }

        });
    }

    MD += '<tr><td><label WGCode="' + WGCode + '" >' + 'Delayed TAT' + '</label>	</td>	<td>' + hr1 + '</td>	<td>' + hrs2 + '</td>	<td>' + hrs3 + '</td>	<td>' + hrs4 + '</td>	<td>' + hrs5 + '</td>	<td>' + hrs6 + '</td>	<td>' + day1 + '</td>	<td>' + day2 + '</td></tr>';

    //}
    //});


    return txt + MD + '</tbody></table></div></div>';
}

function WidgetsType5(wid, wname, lst1, mis) {

//  $.each(lst1, function(id, val) {
//        var WID = val.WID;
//        var WGCode = val.WGCode;
//        var WDetail = val.DetailedName;

    var txt = '<div class="animated fadeInDown delay4 panel panel-primary card marginB15 bg-lightGrey ">\
				<div class="panel-heading card-custom-head clearfix bdr-Bottom">\
					<h3 class="font18 panel-title text-white a-left col-md-6 col-sm-6 col-xs-6 lh36">' + wname + '</h3>\
					<div class="col-md-6 col-sm-6 col-xs-6 a-right">\
					<span class="clickable"><i class="glyphicon glyphicon-chevron-up text-white"></i></span>\
					</div>\
				</div>\
				<div class="panel-body">\
				<div class="row text-center ">\
				<label  >Total Sample Load Trend</label></div>\<div class="row"><div class="col-lg-2 col-xs-6 col-sm-2 col-md-2 pull-right">\
				 <div class="form-group"><select id="ddlMonth"  class="form-control"></select>\
                 </div>\
                </div>\
				<div class="col-lg-1 col-xs-6 col-sm-2 col-md-2 pull-right">\
				 <div class="form-group">\
                            <label for="Month">Month</label>\
                        </div></div>\
				  <div class="col-lg-2 col-xs-6 col-sm-2 col-md-2 pull-right">\
                        <div class="form-group">\
                         <select id="monthyearpicker"  class="form-control"></select> </div>\
                </div><div class="col-lg-1 col-xs-6 col-sm-2 col-md-2 pull-right">\
				  <div class="form-group">\
                            <label ID="Label3"  for="Year">Year</label>\
                        </div>\
				</div></div></div>\
                 <div id="chart" class="panel-body" style="overflow:auto">\
                   <div class="col-md-1">\
                   <div class="vertical-text">Sample Count</div>\
                   </div>\
				   <div id="bar-example" class="col-md-10" style="min-height: 250px;"></div>\
                 </div>\
                 </div>';

  //  var MD = '<li> <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>Test1<label \
	//			 class ="pull-right ullabel tool clickable"  >0</label></li></div></div>';

    return txt;
}
function ddlDevice() {
    var obj = {};
    var Status = "Device"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetOrganizationsDashboard",
        // data: JSON.stringify({ Status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            $('#ddlOrganization').empty();
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $("#ddlOrganization").append($('<option></option>').val(0).html('---select---'));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlOrganization').append('<option value="' + val.OrgID + '">' + val.OrgName + '</option>');

                });
                if (data.d.length > 0) {
                    $('#ddlOrganization').val(data.d[0].OrgID);
                    $('#ddlOrganization').val(OorgID);
                    //ddlLocation(data.d[0].OrgID);

                    ddlLocation(OorgID);
                }

            }
            else {
                $("#ddlOrganization").append($('<option></option>').val(0).html('---No Records---'));
            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}
function ddlLocation(orgid) {
    var obj = {};
    var Status = "Device"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetLocationsForOrgDashboard",
        data: JSON.stringify({ OrgID: orgid }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            locCount = data.d.length;
            $("#ddlLocation").empty();
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $("#ddlLocation").append($('<option></option>').val(0).html('---select---'));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlLocation').append('<option value="' + val.AddressID + '">' + val.Location + '</option>');

                });
                if (data.d.length > 0) {
                    // $('#ddlLocation').val(ILocationID);

                    $('#ddlLocation').val(data.d[0].AddressID);

                }
            }
            else {
                $("#ddlLocation").append($('<option></option>').val(0).html('---No Records---'));
            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}


function loadGeneralStatistics(Activestatus) {
    var year = $('#monthyearpicker').val();
    var Month = $('#ddlMonth').val();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/pgetGeneralStatistics",
        data: JSON.stringify({ year: year, month: Month }),
        dataType: "json",
        async: false,
        success: function(data) {
            var Items = data.d;
            if (Items.length > 0) {
                $("#bar-example").empty();
                Morris.Bar({
                    element: 'bar-example',
                    data: Items,
                    xkey: 'Name',
                    ykeys: ['ID'],
                    labels: ['Count'],
                    xLabelAngle: 80
                    //  xLabelMargin: 10


                });

            }
            // $('#chart').removeClass('load');

        },
        error: function(xhr, status, error) {
            alert(xhr);
            $('#chart').removeClass('load');
        }



    });
}


function check() {

    var array = [];
    var headers = [];
    headers[0] = 'y'
    headers[1] = 'a'

    var arrayItem = {};
    arrayItem[headers[0]] = '2007';
    arrayItem[headers[1]] = '90';
    array.push(arrayItem);

}

function LoadData() {
    var diff = 1;
    var lid = $("#ddlLocation").val();
    var didd = $("#ddlDepartment").val();
    var orgid = $("#ddlOrganization").val();
    var frmDate = dateformat($("#txtFromDate").val(), 'YYYY-MM-DD');
    var toDate = dateformat($("#txtToDate").val(), 'YYYY-MM-DD');
    if ($('#ddlDate').val() == 0) {
        diff = 0;
        frmDate = moment().format('YYYY-MM-DD');
        toDate = moment().format('YYYY-MM-DD');
    }
    filterData.OrgID = orgid;
    filterData.LocationID = lid;
    filterData.DepartmentID = didd;
    filterData.fromDate = frmDate;
    filterData.toDate = toDate;
    filterData.checkDiff = diff;

    var dtime = '2016-09-10 00:00:00.000';
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/Dashboard_AnalyzerDetails",
        data: JSON.stringify({ OrgID: orgid, LocationID: lid, DepartmentID: didd, fromDate: frmDate, toDate: toDate, checkDiff: diff }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            var items = data.d;
            var Tabs = [];

            $.each(items, function(index, value) {
                if ($.inArray(value.Tab, Tabs) == -1) {
                    Tabs.push(value.Tab);
                }
            });

            $.each(Tabs, function(id, val) {
                var count = 0;
                var mdTbl = '';

                $.each(items, function(index, value) {
                    if (value.Tab == val) {
                        var dval = '';
                        if (value.Dtime != null) {
                            var date = new Date(parseInt(value.Dtime.substr(6)));
                            var month = date.getMonth() + 1;
                            dval = date.getDate() + "/" + month + "/" + date.getFullYear();
                        }

                        mdTbl = mdTbl + '<tr><td>' + value.InstrumentName + '</td><td>' + dval + '</td></tr>';

                        count++;
                    }
                });

                var mdText = $('label[WGCode="' + val + '"]').attr('header');
                mdTbl = '<table class="spnTable"><tbody>' + mdTbl + '</tbody></table>';
                var spnTxt = '<span value="' + mdText + '" style="display:none;">' + mdTbl + '</span>';
                $('label[WGCode="' + val + '"]').html(count)
                $('label[WGCode="' + val + '"]').parent().append(spnTxt);

            });


            //            $('label[WGCode="' + val + '"]').html()
            //            
            //            });
            //            var Panel = [];

            //            $.each(items, function(index, value) {
            //            if ($.inArray(value.DisplayText, Panel) == -1) {
            //                    Panel.push(value.DisplayText);
            //                }
            //            });
            //            var MD = '';
            //            var html = '<div class="col-md-16">';
            //            html = html + '<ul class ="ultype">';
            //            // if (items.length > 0) {
            //            $("#pnlAnalyzer").html('');
            //            MD = MD + getLI('MD', items);
            //            MD = MD + getLI('CD', items);
            //            MD = MD + getLI('QCR', items);
            //            MD = MD + getLI('LE', items);
            //            $("#pnlAnalyzer").append(html + MD + '</ul></div>');
            //            MD = '';
            //            $("#pnlAudit").html('');
            //            MD = MD + getLI('NIA', items);
            //            MD = MD + getLI('NEA', items);
            //            MD = MD + getLI('IAN', items);
            //            MD = MD + getLI('PN', items);
            //            $("#pnlAudit").append(html + MD + '</ul></div>');
            //            MD = '';
            //            MD = MD + bindQI('TS', items);
            //            MD = MD + bindQI('CR', items);
            //            MD = MD + bindQI('SR', items);
            //            MD = MD + bindQI('ER', items);
            //            MD = MD + bindQI('EF', items);
            //            MD = MD + bindQI('DT', items);
            //            MD = MD + bindQI('SRR', items);
            //            $("#pnlQuality").html('');
            //            $("#pnlQuality").append(MD);


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });

}

function getLI(tab, list) {
    var mdCount = 0;
    var mdText = '';

    var mdTbl = '';
    $.each(list, function(key, val) {

        if (val.Tab == tab) {
            mdCount++;
            mdText = val.DisplayText;
            if (tab == 'QCR') {
                mdTbl = mdTbl + '<tr><td>' + val.InstrumentName + '</td><td></td></tr>';
            }
            else {
                var dval = '';
                if (val.Dtime != null) {
                    var date = new Date(parseInt(val.Dtime.substr(6)));
                    var month = date.getMonth() + 1;
                    dval = date.getDate() + "/" + month + "/" + date.getFullYear();
                }
                mdTbl = mdTbl + '<tr><td>' + val.InstrumentName + '</td><td>' + dval + '</td></tr>';
            }
        }

    });
    if (mdCount == 0) {
        if (tab == 'MD') {
            mdText = 'Maintenance Due';
        }
        if (tab == 'CD') {
            mdText = 'Calibration Due';
        }
        if (tab == 'QCR') {
            mdText = 'QC Run';
        }
        if (tab == 'LE') {
            mdText = 'Lot Expiry';
        }
        if (tab == 'NIA') {
            mdText = 'New Internal Audit';
        }
        if (tab == 'NEA') {
            mdText = 'New External Audit';
        }
        if (tab == 'IAN') {
            mdText = "Internal Audit NC" + "'s";
        }
        if (tab == 'PN') {
            mdText = "ProcessNC" + "'s";
        }
    }
    mdTbl = '<table class="spnTable"><tbody>' + mdTbl + '</tbody></table>';
    var MD = '<li> <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>' + mdText + ' <label  class ="pull-right ullabel tool clickable"  >' + mdCount + '</label><span value="' + mdText + '" style="display:none;">' + mdTbl + '</span> </li>';



    return MD;

}

function bindQI(tab, list) {
    var html = '';
    $.each(list, function(key, val) {

        if (val.Tab == tab) {
            html = html + '<a class="quick-btn" href="#">\
                <i class="' + val.InvestigationName + '"></i>\
                <span>' + val.DisplayText + '</span>\
                <span class="label label-warning">' + val.InstrumentName + '</span>\
                </a>';
        }

    });

    return html;
}
function ddlDepartment() {
    var obj = {};
    var orgid = $("#ddlOrganization").val();
    if (orgid != 0) {
        var Status = "Device"
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/Dashboard_DeptList",
            data: JSON.stringify({ OrgID: orgid }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                $('#ddlDepartment').empty();
                DepCount = data.d.length;
                if (data.d.length >= 0) {
                    var ArryLst = data.d;
                    $("#ddlDepartment").append($('<option></option>').val(0).html('---All---'));
                    $.each(ArryLst, function(ind, val) {
                        $('#ddlDepartment').append('<option value="' + val.DeptID + '">' + val.DeptName + '</option>');

                    });
                    if (data.d.length > 0) {
                        // $('#ddlDepartment').val(data.d[0].DeptID);
                        //ddlLocation(data.d[0].DeptID);
                    }

                }
                else {
                    $("#ddlDepartment").append($('<option></option>').val(0).html('---No Records---'));
                }
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }

        });
    }
    else {
        $('#ddlDepartment').empty();
        $("#ddlDepartment").append($('<option></option>').val(0).html('---No Records---'));
    }
}

function Filterclick() {

    var orgid = $("#ddlOrganization").val();
    var locid = $("#ddlLocation").val();
    var depid = $("#ddlDepartment").val();
    var diff = 0;
    if (orgid == 0) {
        alert("Please Select Organnization");
    }
    
    else if (locid == 0) { alert("Please Select Location"); }
    //else if (depid == 'S') { alert("Deparment Not Mapped"); }
    else {
        // showLoader(true);

        var frmDate = dateformat($("#txtFromDate").val(), 'YYYY-MM-DD');
        var toDate = dateformat($("#txtToDate").val(), 'YYYY-MM-DD');
        if ($('#ddlDate').val() == 0) {
            diff = 0;
            frmDate = moment().format('YYYY-MM-DD');
            toDate = moment().format('YYYY-MM-DD');
        }
        filterData.OrgID = orgid;
        filterData.LocationID = locid;
        filterData.DepartmentID = depid;
        filterData.fromDate = frmDate;
        filterData.toDate = toDate;
        filterData.checkDiff = diff;

        LoadWidgetDetails();
       // LoadData();
        $('#ddlwlt').change(function() {
            var WLT = $('#ddlwlt').val();
            GetWorLoadMISReport(WLT);
        });
        $('#ddldwb').change(function() {
            var DWWLB = $('#ddldwb').val();
            GetWorLoadMISReport(DWWLB);
        });
        $('#ddldtt').change(function() {
            var DTT = $('#ddldtt').val();
            GetWorLoadMISReport(DTT);
        });

        $('.tool').hover(function() {

            var cnt = $(this)[0].innerText;
            if (cnt != 0) {
                var spn = $(this).next('span')[0];
                var txt = $(spn).attr('value')
                var tbl = $(this).next('span')[0].innerHTML;
                tooltip.pop(this, '<h4>' + txt + '</h4>' + tbl);
            }
        });
        
        
        
        //            $('#overlay').remove();
    }
    // showLoader(false);

}
function showLoader(flag) {
    if (flag) {
        $('#chart').addClass('load');
        $('#bar-example').css("z-index", "-1");
        $('#barchartDTT').css("z-index", "-1");
     //   $('#barchartWLT').css("z-index", "-1");
    }
    else {
        setTimeout(
  function() {
      //do something special
      $('#bar-example').css("z-index", "1");
      $('#chart').removeClass('load');
  }, 1000);


    }
}

function dateformat(Date, format) {
    var date_string = '';
    if (Date != '') {
        date_string = moment(Date, "DD/MM/YYYY").format(format);
    }
    return date_string;
}

function LoadWidgetbyroleanduser(OrgID, RoleID, LoginID) {

    var dd;
    var obj = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/pGetWidgetsbyRoleandUser",
        data: JSON.stringify({ RoleID: RoleID, LoginID: LoginID, orgID: OrgID }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            dd = data.d;
            if (dd.length > 0) {
                //                     $.each(dd, function(id, val) {
                //                         $('div[WCODE="' + val.WCode + '"]').show();
                //                     });
            }
        },
        error: function(result) {
            alert("Error");
        }
    });
    return dd;

}
function LoadWidgetcountmis(OrgID, LocationID, DeptID, FromDate, ToDate, RoleID) {

    var dd;
    var obj = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/pGetWidgetmisreport",
        data: JSON.stringify({ OrgID: OrgID, LocationID: LocationID, DeptID: DeptID, FromDate: FromDate, ToDate: ToDate, RoleID: RoleID }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            dd = data.d;
        },
        error: function(result) {
            alert('error; ' + eval(result));
            alert('error; ' + result.responseText);
        }
    });
    return dd;

}
function GetWorLoadMISReport(WorkLoadCode) {
    var Items = [];
    var Result;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/WorkLoadMISReport",
        data: JSON.stringify({ OrgID: filterData.OrgID, LocationID: filterData.LocationID,
            DepartmentID: filterData.DepartmentID, fromDate: filterData.fromDate, toDate: filterData.toDate,
            WorkloadCode: WorkLoadCode
        }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            Items = JSON.parse(data.d);

            if (Items.length > 0) {
                if (WorkLoadCode == 'WLT') {
                    $("#barchartWLT").empty();
                    Morris.Bar({
                        barGap: 1,
                        barSizeRatio: 1,
                        element: 'barchartWLT',
                        data: Items,
                        xkey: 'X',
                        ykeys: ['Y'],
                        labels: ['TestCount'],
                        xLabelAngle: 10
                        //  xLabelMargin: 10


                    });
                }
                if (WorkLoadCode == 'DWB') {
                    $("#pie-chart").empty();
                    Morris.Donut({
                        element: 'pie-chart',
                        resize: true,
                        data: Items

                    });
                }
                if (WorkLoadCode == 'DTT') {
                    $("#barchartDTT").empty();
                    Morris.Bar({
                        element: 'barchartDTT',
                        data: Items,
                        xkey: 'X',
                        ykeys: ['Y'],
                        labels: ['Delayed TestCount'],
                        xLabelAngle: 10
                        //  xLabelMargin: 10


                    });
                }
            }
            else {
                if (WorkLoadCode == 'WLT') {
                    $("#barchartWLT").empty();
                }
                if (WorkLoadCode == 'DTT') {
                    $("#barchartDTT").empty();
                }
                if (WorkLoadCode == 'DWB') {
                    $("#pie-chart").empty();
                }
            }
        },
        error: function(result) {
            alert("Error");
            $('#barchartDTT').removeClass('load');
            $('#barchartWLT').removeClass('load');
            $("#pie-chart").removeClass('load');
        }
    });
   

}

 
function GetMISReport(WCode, WGCode) {
    var dd;
    filterData.WCode = WCode;
    filterData.WGCode = WGCode;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/pGetMISReport",
        data: JSON.stringify({ OrgID: filterData.OrgID, LocationID: filterData.LocationID,
            DepartmentID: filterData.DepartmentID, fromDate: filterData.fromDate, toDate: filterData.toDate,
            checkDiff: filterData.checkDiff, WCode: filterData.WCode, WGCode: filterData.WGCode
        }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            dd = data.d;

        },
        error: function(result) {
            alert("Error");
        }
    });
    return dd;

}
function bindMIStable(parseJSONResult) {

    if (parseJSONResult != null && parseJSONResult.length > 0) {
        var table = $('#tblMis').DataTable();
        table.destroy();
        var tbl = '#tblMis';
        $("#tblMishead").show();
        $(tbl).empty();
        $(tbl).show();
        //Get dynmmic column.
        var dynamicColumns = [];
        var i = 0;
        $.each(parseJSONResult[0], function(key, value) {
            //var keyTxt = $('#hdn' + key).val();
            var lkey = 'QMS_Dashboard_aspx_' + key;
            var keyTxt = langData[lkey];
            if (keyTxt == null) { keyTxt = "Unknown" }
            var obj = { sTitle: keyTxt };
            dynamicColumns[i] = obj;
            i++;
        });
        //fetch all records from JSON result and make row data set.
        var rowDataSet = [];
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

        table = $(tbl).dataTable({
            "bDestroy": true,
            "bScrollCollapse": true,
            "bJQueryUI": true,
            "bPaginate": true,
            "sScrollY": "310px",
            "bInfo": true,
            "bFilter": true,
            "bSort": true,            
            "aaData": rowDataSet,
            "aoColumns": dynamicColumns
           //These are dynamically created columns present in JSON object.

        });
    }

    else {
        $("#tblMishead").hide();
$("#tblMishead > tr").remove();
    }

}

function PendingApproval(ctrl) 
{
    var vid = $(ctrl).attr('VisitID');
    var lst = GetPendingApprovalURL(vid);
    if (lst != null && lst.length > 0) {

        var url = lst[0].RedirectURL;
        url = '..'+ url.substring(1, url.length);
        window.open(url, '_blank');
    }
}

function GetPendingApprovalURL(visitID) {
    var dd;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetActionUrlPendingApproval",
        data: JSON.stringify({ VisitID: visitID }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            dd = data.d;

        },
        error: function(result) {
            alert("Error");
        }
    });
    return dd;
}

function getWorkLoadTWvsLW() {
    var DateFormat = 'DD/MM/YYYY';
       filterData.fromDate= moment().subtract(1, 'weeks').startOf('Week').format(DateFormat);
       filterData.toDate= moment().endOf('Week').format(DateFormat);
       GetWorLoadMISReport('WLT');

}