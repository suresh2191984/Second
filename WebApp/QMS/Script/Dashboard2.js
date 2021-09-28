var oTable;
var hoverEvent = true;

var data;
var locCount = 0;
var DepCount = 0;
$(document).ready(function() {

    
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

   
        LoadData();
        $('.tool').hover(function() {

            var cnt = $(this)[0].innerText;
            if (cnt != 0) {
                var spn = $(this).next('span')[0];
                var txt = $(spn).attr('value')
                var tbl = $(this).next('span')[0].innerHTML;
                tooltip.pop(this, '<h4>' + txt + '</h4>' + tbl);
            }
        });


    var fill = [];
    var arr = {};
    arr.Text = 'Jan';
    arr.ID = 1;
    fill.push(arr);

    data = [{ ID: 1, Text: 'Jan' }, { ID: 2, Text: 'Feb' }, { ID: 3, Text: 'Mar' }, { ID: 1, Text: 'Apr' }
    , { ID: 1, Text: 'May' }, { ID: 1, Text: 'Jun' }, { ID: 1, Text: 'Jul' }, { ID: 1, Text: 'Aug' }
    , { ID: 1, Text: 'Sep' }, { ID: 1, Text: 'Oct' }, { ID: 1, Text: 'Nov' }, { ID: 1, Text: 'Dec'}];

    $('#ddlFiltertype').change(function() {

        if ($(this).val() == 0) {

            $('#monthyearpicker').empty();
            for (i = new Date().getFullYear(); i > 2000; i--) {
                $('#monthyearpicker').append($('<option />').val(i).html(i));
            }
        }
        else {
            $('#monthyearpicker').empty();
            $.each(data, function(key, val) {

                $('#monthyearpicker').append($('<option />').val(val.ID).html(val.Text));
            });

        }

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


//    Morris.Bar({
//        element: 'bar-example',
//        data: [
//    { y: 'Jan', a: 600 },
//    { y: 'Feb', a: 75 },
//    { y: 'Mar', a: 50 },
//      { y: 'Apr', a: 55 },
//        { y: 'May', a: 50 },
//          { y: 'Jun', a: 50 },
//           { y: 'Jul', a: 600 },
//    { y: 'Aug', a: 75 },
//    { y: 'Sep', a: 50 },
//      { y: 'Oct', a: 55 },
//        { y: 'Nov', a: 50 },
//          { y: 'Dec', a: 50 }
//  ],
//        xkey: 'y',
//        ykeys: ['a'],
//        labels: ['Series A']
//    });


    //GetAnalyzerMappingDetails();
    //Searchtext();
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



   // showLoader(false );



});

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
                if(data.d.length > 0)
                {
                $('#ddlOrganization').val(data.d[0].OrgID);
                  ddlLocation(data.d[0].OrgID);
                }

            }
            else
            {
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


 function Activeuser(Activestatus)
        {
            var obj = {};
            obj.Activationstatus = Activestatus.Active;
            obj.DeviceID= Activestatus.DeviceID;
            obj.TestCode = Activestatus.Testcode;

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../QMS.asmx/QMS_DeleteAnalyzermappingDetails",
                data: JSON.stringify(obj),
                dataType: "json",
                success: function (data) {
                    if (data.d > 0)
                    {
                     
                      GetAnalyzerMappingDetails();
                        
                    }
                    

                },
                error: function(xhr, status, error) {
            alert(xhr);
        }



            });
        }


function check()
{

var array = [];
    var headers = [];
    headers[0] ='y'
	headers[1]='a'

var arrayItem = {};
arrayItem[headers[0]]='2007';
arrayItem[headers[1]]='90';
array.push(arrayItem);

}

function LoadData()
{
    var lid = $("#ddlLocation").val();
    var didd = $("#ddlDepartment").val();
    var orgid = $("#ddlOrganization").val();
      

var dtime='2016-09-10 00:00:00.000';
$.ajax({
    type: "POST",
    contentType: "application/json;charset=utf-8",
    url: "../QMS.asmx/Dashboard_AnalyzerDetails",
    data: JSON.stringify({ OrgID: orgid, LocationID: lid, DepartmentID: didd, Dtime: dtime }),
    dataType: "JSON",
    async: false,
    success: function(data) {
    var items = data.d;
//    var Tabs = [];

//       $.each(items, function(index, value) {
//       if ($.inArray(value.Tab, Tabs) == -1) {
//           Tabs.push(value.Tab);
//         }
//      });
//      var Panel = [];

//      $.each(items, function(index, value) {
//      if ($.inArray(value.Header, Panel) == -1) {
//          Panel.push(value.Header);
//          }
//      });
      var MD = '';
        var html = '<div class="col-md-16">';
        html = html + '<ul class ="ultype">';
//      $.each(Panel, function(index, value) {
//             $('#'+value).html('');
//             MD='';
//            $.each(Tabs, function(ind, val) {
//                 MD = MD + getLI(val, items, value);
//          
//           });
//          $('#'+value).append(html + MD + '</ul></div>');
//      });
//      
//        
        // if (items.length > 0) {
        $("#pnlAnalyzer").html('');
        MD = MD + getLI('MD', items);
        MD = MD + getLI('CD', items);
        MD = MD + getLI('QCR', items);
        MD = MD + getLI('LE', items);
        $("#pnlAnalyzer").append(html + MD + '</ul></div>');
        MD = '';
        $("#pnlAudit").html('');
        MD = MD + getLI('NIA', items);
        MD = MD + getLI('NEA', items);
        MD = MD + getLI('IAN', items);
        MD = MD + getLI('PN', items);
        $("#pnlAudit").append(html + MD + '</ul></div>');
        MD = '';
        MD = MD + bindQI('QI', items)
        $("#pnlQuality").html('');
        $("#pnlQuality").append(MD);


    },
    error: function(xhr, status, error) {
        alert(xhr);
    }

});

}

function getLI(tab,list,header)
{
 var mdCount=0;
        var mdText='';

            var mdTbl='';
            $.each(list, function(key, val) {
                //mdTbl = '';
                if (val.Tab == tab && val.HasValue == 'Y') {
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
                else if (val.Tab == tab && val.HasValue == 'N') {

                        mdText = val.DisplayText;
                    }
                      

            });
 //if(mdCount==0)
//{
//if(tab =='MD')
//{
//mdText='Maintenance Due';
//}
//if(tab =='CD')
//{
//mdText='Calibration Due';
//}
//if(tab =='QCR')
//{
//mdText='QC Run';
//}
//if(tab =='LE')
//{
//mdText='Lot Expiry';
//}
//if(tab =='NIA')
//{
//mdText='New Internal Audit';
//}
//if(tab =='NEA')
//{
//mdText='New External Audit';
//}
//if(tab =='IAN')
//{
//mdText="Internal Audit NC"+"'s";
//}
//if(tab =='PN')
//{
//mdText="ProcessNC"+"'s";
//}
//}
           mdTbl='<table class="spnTable"><tbody>'+mdTbl+'</tbody></table>';
           var MD='<li>'+mdText+' <label  class ="pull-right ullabel tool clickable"  >'+mdCount+'</label><span value="'+mdText+'" style="display:none;">'+mdTbl+'</span> </li>';



return MD;

}

function bindQI(tab,list)
{
var html='';
$.each(list,function (key,val){

if(val.Tab ==tab )
{
                html =html+'<a class="quick-btn" href="#">\
                <i class="' + val.InvestigationName + '"></i>\
                <span>' + val.DisplayText + '</span>\
                <span class="label label-warning">2</span>\
                </a>';
                }
               
       });
       
return html;
}
function ddlDepartment() {
    var obj = {};
    var orgid = 109;
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
            if (data.d.length >=0) {
                var ArryLst = data.d;
                $("#ddlDepartment").append($('<option></option>').val(0).html('---All---'));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlDepartment').append('<option value="' + val.DeptID + '">' + val.DeptName + '</option>');
                    
                });
                if (data.d.length > 0) {
                    $('#ddlDepartment').val(0);
                    //ddlLocation(data.d[0].DeptID);
                }

            }
            else {
                $("#ddlDepartment").append($('<option></option>').val('S').html('---No Records---'));
            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}

function Filterclick() {

    var orgid = $("#ddlOrganization").val();
    var locid = $("#ddlLocation").val();
    var depid = $("#ddlDepartment").val();
    if (orgid == 0) {
        alert("Please Select Organnization");
    }
    else if (locid == 0) { alert("Please Select Location"); }
    else if (depid == 'S') { alert("Deparment Not Mapped"); }
    else {
        showLoader(true);

        LoadData();

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
    showLoader(false);

}
function showLoader(flag) {
    if (flag) {
        $('#overlay').show();

    }
    else { $('#overlay').hide(); }
}