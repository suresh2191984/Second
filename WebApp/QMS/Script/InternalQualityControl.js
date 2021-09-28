var oTable=0;
var RecursiveFlag = false;
var PrevFailedRule = "";
var PrevFailedPart = "";
 var F1s =0;
            var TenX = 0;

function BindDDL(ControlName, list, Id, text, firstElement) {

    var returnCode = -1;
    if ($(ControlName).length > 0) {
        $(ControlName).empty();
        if (arguments.length == 5) {
            $(ControlName).append(firstElement)
        }
        $.each(list, function(key, value) {
            var option = $('<option/>');
            option.attr('value', value[Id]).text(value[text]);

            $(ControlName).append(option);
        });
        if (list.length == 1) {
            $(ControlName).prop("selectedIndex", 1);
        }
        returnCode = 1;
    }
    returnCode = 1;
}



 function ClearLJFilter() {
            
            $('#ddlLocation').val("-1");
            $('#ddlAnalyzer').val("-1");
            $('#ddlLotNo').val("-1");
            $('#ddlAnalyte').val("-1");
            $('#ddlLevel').val("0");
            $('#txtFromDate').val("");
            $('#txtToDate').val("");
                $('#FilterResult').hide();
        }






function LoadLotDDL() {
    OrgId = document.getElementById("hdnOrgID").value;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/GetLotDetails",
        data: "{'orgId': '" + OrgId + "'}",
        dataType: "json",
        async: false,
        success: function(data) {
            loaDropDownOnSuccess(data);
        },
        failure: function(msg) {
            alert(msg);
        }
    });
}
function loaDropDownOnSuccess(data) {

    if (data.d.length >= 0) {
        var ArryLst = data.d;
        //ddlDepartment
        var ddlLotItemsArrLst = ArryLst[0];

        var ddlLotNo = $('#ddlLotNo');
        ddlLotNo.empty();

        $('#ddlLotNo').append('<option value="0~0~0~0~0~0">'+langData.ddl_select+'</option>');
        $.each(ddlLotItemsArrLst, function(index, Item) {
            $('#ddlLotNo').append('<option value="' + Item.LotID + '~' + Item.LotCode + '~' + Item.LotName + '~' + Item.MetaValueID + '~' + Item.Code + '">' + Item.LotCode + '</option>');
        });

    }
}

function DDLAjaxCall(value, CtrlName, URL) {
    var obj = {};
    obj.Value = value;
    obj.CtrlName = CtrlName;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify(obj),
        dataType: "json",
        success: function(data) {//On Successfull service call
            var data_test = data.d;
            if ($('#' + CtrlName).length > 0) {

                $("#" + CtrlName).empty();
                $('#' + CtrlName).append('<option value="-1">'+langData.ddl_select+'</option>');
                $.each(data_test, function(key, value) {

                    //this refers to the current item being iterated over 

                    var option = $('<option/>');
                    option.attr('value', value.ID).text(value.Name);

                    $('#' + CtrlName).append(option);
                });
            }
            else {
                // BindMachines(data_test);
            }



            //  alert(data.GetDDlDataResult[0].StateName);
        },
        error: function(result) {
            alert(langData.alert_loadunable);
        } // When Service call fails
    });
}


function getddlName(controlname) {
    var ctrlName = null;
    if (controlname == "ddlLocation") {
        ctrlName = "ddlAnalyzer";
        return ctrlName;
    }
    else if (controlname == "ddlAnalyzer") {
        ctrlName = "ddlLotNo";
        return ctrlName;
    }

    else if (controlname == "ddlLotNo") {
        ctrlName = "ddlAnalyte";
        return ctrlName;
    }
    else if (controlname == "VendorList1") {
        ctrlName = "MachineList";
        return ctrlName;
    }


    else
        return 'NO';
}

function BindAutocomplete(CTRL, URL, Prefix, txtSamColPersonid, CtrlTxt) {
    var SelectedID;

    var Resultdata = [];
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify({ "Suggesion": Prefix, "CtrlName": CtrlTxt }),
        dataType: "json",
        async: false,
        success: function(data) {
            $(txtSamColPersonid).val('-1');
            val = data.d;
            var len = data.d.length;
            $.each(val, function(i, Zon) {
                var obj = new Object();
                var value = Zon.Name;
                var id = Zon.UserID;
                obj = { "value": value, "id": id };
                Resultdata.push(obj);

            });
            var availableTags = [
                { "value": "Some Name", "id": 1 }, { "value": "Some Othername", "id": 2}];
            var test = [];

            $('#' + CTRL).autocomplete({
                source: Resultdata, 
                select: function(event, ui) {
                    $(txtSamColPersonid).val(ui.item.id);
           
                },
                minLength: 2,
                max: 6
            });
        }


    });


}

function Edit_OnClick(rowIdx) {

    var dateval = '';
    if ($(rowIdx).attr('data') == 'Update') {
        var array = [];
        var headers = [];
        headers[0] = 'ProcessedAt'
        headers[1] = 'Value'
        headers[2] = 'TargetMean'
        headers[3] = 'Deviation';
        headers[4] = 'QCStatus';
        headers[5] = 'FailedRule';
        headers[6] = 'Reason';
        headers[7] = 'CorrectionAction';
        headers[8] = 'PreventiveAction';
        headers[9] = 'QCValueID';
        $(rowIdx).attr('data', 'Edit');
        $(rowIdx).attr('value', langData.edit);
        var arrayItem = {};

        var td = $(rowIdx).closest('tr').find('td');
        $.each(td, function(idx, val) {
            if (idx < 10) {
                if ($(val).find('input').length > 0) {

                    arrayItem[headers[idx]] = $(val).find('input').val();
                }
                else {




                    if (headers[idx] == 'QCStatus') {

                        if ($(val).find('lable').attr('class')=='glyphicon glyphicon-remove Wrong') {
                            arrayItem[headers[idx]] = 0;
                        }
                        else  {
                            arrayItem[headers[idx]] = 1;
                        }
                    }
                    else {
                        arrayItem[headers[idx]] = $(val).html();
                    }

                }
            }


        });
        array.push(arrayItem);

        if (array.length > 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_UpdateLJchartValues",
                data: JSON.stringify({ LJChartValue: array }),
                dataType: "JSON",
                async: false,
                success: function(data) {

                    alert(langData.alert_update);
                    LoadLJChart();
                    // }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }

    }
    else {
        var td = $(rowIdx).closest('tr').find('td');
        $.each(td, function(idx, val) {
            $(val).find('input').removeAttr('disabled')

        });

        $(rowIdx).attr('data', 'Update');
        $(rowIdx).attr('value', langData.Update);

    }

}

function funUpdateQCStatus(){

var lstQcvalues = [];
$("#tblQCValues > tbody > tr").each(function() {
                var oTable = $("#tblQCValues").dataTable();
                 var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                
                var QcStatus="N";
                if($(this).find('[class*=glyphicon]').attr("class")=="glyphicon glyphicon-ok Okay")
                {
                 QcStatus="Y";
                }
                else
                {
                 QcStatus="N";
                }
                 lstQcvalues.push({
                        QCValueID: rowData["QCValueID"],
                        IsUpdate:QcStatus,
                        LotName:"QCStatusUpdate"
                         });
                    });
 
                
    if (lstQcvalues.length > 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_SaveQcValues",
                data: JSON.stringify({ QCAnalyzerMapping: lstQcvalues }), 
                dataType: "JSON",
                async: false,
                success: function(data) {

                    alert(langData.alert_update);
                   // LoadLJChart();
                    // }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }
}



function LoadLJChart() {
    $('#FilterResult').hide();
    var obj = {};




    obj.LocationID = $('#ddlLocation').val();
    obj.InstrumentID = $('#ddlAnalyzer').val(); 
    obj.AnalyteID = $('#ddlAnalyte').val(); 
    obj.Level = $('#ddlLevel').val();
    obj.LotID = $('#ddlLotNo').val(); 
    obj.FromDate = $('#txtFromDate').val(); 
    obj.ToDate = $('#txtToDate').val(); ;



    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '../QMS.asmx/QMS_LJChartFilter',
        data: JSON.stringify(obj),
        dataType: "json",
        success: function(data) {//On Successfull service call
            var AnalyzerDetails = [];
            var AnalyteMeadSD = [];
            var AnalytePlot = [];
            var lstAnalytePlot = [];
            

            AnalyzerDetails = data.d[0][0];
            AnalyteMeadSD = data.d[1][0];
            AnalytePlot = data.d[2];
            lstAnalytePlot = data.d[3];
           
            var FailedRule = "";
          
            var FailedResult = [];
             PrevFailedRule = "";
             PrevFailedPart="";
             F1s =0;
             TenX = 0;

            if (lstAnalytePlot.length != 0) {


                $('#NoRec').hide();
                $('#tblQCValues').show();

                $('#OuterGraph').show();
              

                
                $('#tblQCValues tbody').empty();
                $('#tblQCValues').css("visibility", "visible");
                $('#GeneratePDF').css("visibility", "visible");
                $('#btnUpdate').css("visibility", "visible");

if(oTable!=0)
$('#tblQCValues').DataTable().clear().destroy();
                oTable = $('#tblQCValues').dataTable({
                    paging: true,
                     "language": {
                                 "url": dataTablePath
                                  },
dom: 'Bfrtip',
        buttons: [
             'pdf'
        ],
                    data: lstAnalytePlot,
                    "bDestroy": true,
                    "destroy": true,
                    "searchable": true,
                    "sort": true,
                   "paging":   false,

                    columns: [
                                            { 'data': 'PDate' },
                                            { 'data': 'Value' },
                                            { 'data': 'TargetMean' },
                                            { 'data': 'Deviation' },
                                            { 'data': 'QcStatus',

                                                "render": function(data, type, full, row, meta) {



                                      if(row.row==0){
                                          F1s =0;
                                          TenX = 0;
                                        }
                                                    StatusICon = 'glyphicon glyphicon-remove Wrong';

                                                    FailedRule = CheckRule(AnalyteMeadSD, lstAnalytePlot, full.Value, row, FailedRule);

                                                    FailedResult = FailedRule.split('~');
                                                    if (FailedRule == '-') {
                                                        StatusICon = 'glyphicon glyphicon-ok Okay';
                                                    }
                                                    else if (FailedResult[2] == 'W') {
                                                        StatusICon = 'glyphicon glyphicon-ok warning';
                                                    }
                                                    
                                                    return '<lable class="' + StatusICon + '"/>';
                                                }



                                            },
                                            { 'data': 'FailedRule',
                                                "render": function(data, type, full, row, meta) {
                                                                                                       StatusICon = 'label label-danger';

                                                                                                     
                                                                                                       var FailedResult = FailedRule.split('~');
                                                                                                        if (FailedRule == '-') {
                                                                                                            StatusICon = 'label label-success';
                                                                                                            return '<lable class="' + StatusICon + '" style="font-size: 14px;" >'+FailedResult[0] +'</lable>';
                                                                                                        }
                                                                                                        else if (FailedResult[2] == 'W') {
                                                                                                            StatusICon = 'label label-warning';
                                                                                                        }

                                                                                                        return '<lable class="' + StatusICon + '" style="font-size: 14px;" >'+FailedResult[0] +'<sub>' + FailedResult[1] + '</sub></lable>';
                                                }
                                            },
                                            { 'data': 'Reason',
                                                "mRender": function(data, type, full) {
                                                    return '<input type=textbox disabled=disabled class="form-control"  value= "' + full.Reason + '" >';
                                                }
                                            },
                                            { 'data': 'CorrectionAction',

                                                "mRender": function(data, type, full) {
                                                    return '<input type=textbox disabled=disabled class="form-control" value= "' + full.CorrectionAction + '" >';
                                                }

                                            },
                                            { 'data': 'PreventiveAction',

                                                "mRender": function(data, type, full) {
                                                    return '<input type=textbox disabled=disabled class="form-control" value=" ' + full.PreventiveAction + '" >';
                                                }

                                            },
                                            { 'data': 'QCValueID',

                                                "sClass": 'hide_Column'
                                            }
//                                            ,


//                                            {

//                                                "mRender": function(data, type, full) {
//                                                    return '<input type=button class="btn btn-info btn-sm"  onclick=Edit_OnClick(this) id=Edit' + full.QCValueID + '  value="'+langData.AnalyzerMapping_btnEdit+'"   ID1=' + full.QCValueID + ' >';
//                                                }
//}
]

                });
                
               
                FailedRule="";

                $('#FilterResult').show();
                $('#ShowDate').empty();
                $('#ShowDate').append(langData.date+' : ' + document.getElementById('txtFromDate').value + ' '+langData.to+' ' + document.getElementById('txtToDate').value);

                $('#tblAnalyzerDtls tbody').empty();
                if (AnalyzerDetails != undefined) {

                    $('#tblAnalyzerDtls tbody').append("<tr>\
        <td class='success'>"+langData.analyzer_name+"</td><td>" + AnalyzerDetails.AnalyzerName + "</td><td class='success'>"+langData.AnalyteMaster_lblAnalyteName+"</td><td>" + AnalyzerDetails.AnalyteName + "</td><td class='success'>"+langData.QMS_Dashboard_aspx_Level+"</td><td>" + AnalyzerDetails.Level + "</td></tr>\
        <tr><td class='success'>"+langData.LJChartView_lblLot +"</td><td>" + AnalyzerDetails.LotNO + "</td><td class='success'>"+langData.QMS_Dashboard_aspx_ExpiryDate+"</td><td>" + AnalyzerDetails.ExpiaryDate + "</td><td class='success'>"+langData.manufactured_by+" </td><td>" + AnalyzerDetails.ManufacturedBy + "</td></tr>");


                    $('#tblSDValues tbody').empty();
                    if (AnalyteMeadSD != undefined) {

                        $('#tblSDValues tbody').append(" <tr>\
             <td class='col-lg-6 align center-block' style='text-align: center;' colspan='2'>"+langData.values+"</td> </tr>\
      <tr> <td class='success'>"+langData.TargetMean+"</td> <td>" + AnalyteMeadSD.TargetMean + "</td></tr>\
      <tr><td class='success'>"+langData.sd+"</td><td>" + AnalyteMeadSD.SD + "</td> </tr>\
      <tr> <td class='success'>"+langData.cv+"</td> <td>" + AnalyteMeadSD.CV + "</td> </tr>");



                        $('#tblValues tbody').empty();
                        $('#tblValues tbody').append("<tr> <td class='success'>+3SD</td> <td class='success'>+2SD</td> <td class='success'>+1SD</td> \
                        <td class='success'>-1SD</td> <td class='success'>-2SD</td>   <td class='success'>-3SD</td> </tr>\
             <tr><td>" +AnalyteMeadSD.p3s + "</td><td>"  + AnalyteMeadSD.p2s + "</td><td>"+ AnalyteMeadSD.p1s + "</td> <td>" + AnalyteMeadSD.m1s + "</td>\
                 <td>" + AnalyteMeadSD.m2s + "</td>\
               <td>" + AnalyteMeadSD.m3s + "</td>\ </tr>");


                    }



                    $('#tblQCValues').show();
                    $('#OuterGraph').show();
                    $('#FilterResult').show();
                    $('#tblQCValues').css("visibility", "visible");
                    $('#GeneratePDF').css("visibility", "visible");
                    $('#btnUpdate').css("visibility", "visible");

                    var strRowValues = "";

                   
                    var Deviation = 0;
                    var StatusICon;




                    function formatJSONDate(test) {
                        var newDate = dateFormat(value.ProcessedAt, "mm/dd/yyyy");
                        return newDate;
                    }



                    LinePoint = [];                    
                    LinePoint.push([AnalyteMeadSD.p3s,'+3SD']);
                    LinePoint.push([AnalyteMeadSD.p2s,'+2SD']);
                    LinePoint.push([AnalyteMeadSD.p1s,'+1SD']);
                    LinePoint.push([AnalyteMeadSD.TargetMean,'TM']);
                    LinePoint.push([AnalyteMeadSD.m1s,'-1SD']);
                    LinePoint.push([AnalyteMeadSD.m2s,'-2SD']);
                    LinePoint.push([AnalyteMeadSD.m3s,'-3SD']);
                    
                    
                    DrawLJChart(LinePoint, AnalytePlot,AnalyteMeadSD);


                    html2canvas([document.getElementById('AnalyzerFilter')], {
                        onrendered: function(canvas) {


                            document.getElementById('PrintPage').value = "";
                            document.getElementById('PrintPage').value = canvas.toDataURL('image/png');



                        }


                    });
                    
                    html2canvas([document.getElementById('OuterGraph')], {
                        onrendered: function(canvas) {


                            document.getElementById('hdnGrpImg').value = "";
                            document.getElementById('hdnGrpImg').value = canvas.toDataURL('image/png');



                        }


                    });
                    
                    
                    
                    html2canvas([document.getElementById('SDDetails')], {
                        onrendered: function(canvas) {


                            document.getElementById('hdnSDDetails').value = "";
                            document.getElementById('hdnSDDetails').value = canvas.toDataURL('image/png');



                        }


                    });
                    
                    html2canvas([document.getElementById('tblQCValues')], {
                        onrendered: function(canvas) {


                            document.getElementById('hdnTable').value = "";
                            document.getElementById('hdnTable').value = canvas.toDataURL('image/png');



                        }


                    });
                    

                }
                else {
                    $('#tblQCValues').hide();
                    $('#OuterGraph').hide();
                    $('#FilterResult').hide();

                    $('#NoRec').show();

                }

            }
            else {
                $('#tblQCValues').hide();
                $('#OuterGraph').hide();
                $('#NoRec').show();

            }

        },
        error: function(result) {
            alert(langData.alert_loadunable);
        }
    });




}



function CheckRule(AnalyteMeadSD, lstAnalytePlot, Value, ID, FailedRule) {
var Diff = 0;
var CurrentFail ="";
FailedRule="";

//This Chart Rule kept on changing so condition added without following algorithm from initial stage
  if (ID.row >0)
{
  Diff= (Value-lstAnalytePlot[ID.row - 1].Value)/AnalyteMeadSD.SD;
 
 if (Diff <=0)
 Diff = Diff * (-1) ;
  
}

  if (Value > AnalyteMeadSD.p2s && Value < AnalyteMeadSD.p3s) {
        FailedRule = "1~+2s~W";    
        if (ID.row > 0) {
            if (lstAnalytePlot[ID.row - 1].Value > AnalyteMeadSD.p2s && lstAnalytePlot[ID.row - 1].Value < AnalyteMeadSD.p3s) {
                FailedRule = "2~+2s~F";
            
            }
        }
             
    }
     if (Value < AnalyteMeadSD.m1s && Value < AnalyteMeadSD.m2s) {
            FailedRule = "1~-2s~W";  
             if (ID.row > 0) {
                if (lstAnalytePlot[ID.row - 1].Value < AnalyteMeadSD.m1s && lstAnalytePlot[ID.row - 1].Value < AnalyteMeadSD.m2s) {
                    FailedRule = "2~-2s~F";
                  
                }
            }             
           } 



if (Value >AnalyteMeadSD.TargetMean)
{
   CurrentFail='P';
   if(PrevFailedPart.length==0)
   PrevFailedPart='P';
   }
   else
   {
   CurrentFail='N';
   if(PrevFailedPart.length==0)
   PrevFailedPart='N';
   }
   
   if(CurrentFail!=PrevFailedPart)
   {
     TenX=0;
      F1s=0; 
      PrevFailedPart= CurrentFail;
   }
   

    if (Value <= AnalyteMeadSD.m3s) {
                FailedRule = "1~-3s~F";
                F1s=F1s + 1;
                TenX =TenX+1 ;
                 
            }
            else if (Value >= AnalyteMeadSD.p3s) {
        FailedRule = "1~+3s~F";
        F1s=F1s + 1;
        TenX =TenX+1 ;
        
    } 
  else  if (Value > AnalyteMeadSD.p2s && Value < AnalyteMeadSD.p3s && FailedRule.includes("2~+2s~F")) {
         F1s=F1s + 1;
         TenX =TenX+1 ;
         FailedRule = "2~+2s~F";
           
        
        
          
    }
    else if (Value < AnalyteMeadSD.m1s && Value < AnalyteMeadSD.m2s && FailedRule.includes("2~-2s~F")) {
            F1s=F1s + 1;
            TenX =TenX+1 ;
           FailedRule = "2~-2s~F";
              
               
           } 
        
    else  if ((Diff>= 4))
    {
    F1s=F1s + 1;
    TenX =TenX+1 ;
                FailedRule = "R~4s~F"; 
                
    }  
   else if(Value >AnalyteMeadSD.TargetMean || Value <AnalyteMeadSD.TargetMean )
   {
   
   if (Value >AnalyteMeadSD.TargetMean)
   {
 
   PrevFailedPart="P";
   TenX =TenX+1 ;   
   if(Value >AnalyteMeadSD.p1s)
      F1s =F1s+1;
      else
      F1s=0;
      
      if(F1s >=4)
      {
      FailedRule = "4~1s~F";
      }
      else if (TenX >=10)
   {
    FailedRule = "10~X~F";
   }
      else
      {
      if(!FailedRule.includes('2s~W'))
     FailedRule = "-";
     }
   
          
      }
      else      
      {
      PrevFailedPart="N";
   TenX =TenX+1 ;   
   if(Value <AnalyteMeadSD.m1s)
      F1s =F1s+1;
      else
      F1s=0;
      
      if(F1s >=4)
      {
      FailedRule = "4~1s~F";     
      }
      else  if (TenX >=10)
   {
    FailedRule = "10~X~F";
   }
      else
      {
       if(!FailedRule.includes('2s~W'))
     FailedRule = "-";
  
     }
   
     
      
      }
   }
   else
   {
   FailedRule = "-";
   PrevFailedPart="";
   TenX=0;
      F1s=0;
   }
   

         PrevFailedRule = FailedRule;
 
    return FailedRule;

}







function DrawLJChart(LinePoint, AnalytePlot,AnalyteMeadSD) {



var ListDate=AnalytePlot.split(';');

    ChartObj = new Dygraph(document.getElementById("graph"), AnalytePlot 
,

                     {
                         labels: ['RowID','ProcessedAt', 'Value','PDate'],
                      
                        
                         drawGrid: true,
                        
                         animatedZooms: true,
                         xRangePad: 35,
                         zoomCallback: function() {
    ChartObj.updateOptions({zoomRange: [ -4, 30]});
  },
                         
                         legend: "never",
                         axisLineWidth :4,
                         gridLineWidth:1.2,
                         axisLineColor: '#000000',
                         series: {
        'x' : {
            axis: 'RowID'
             },

    'y': {
                 axis: 'Value'
         }
        },                                                                    
visibility: [ false, true,false,false],  


                         axes: {
                             x: {
                              valueRange: [ -4, 30],
                                 ticker: function(min, max, pixels, opts, dygraph, vals) {

                                     var XLineValue = [];
                                     for (var i = 0; i <ListDate.length-1; i++) {
                                         var your_value = ListDate[i].split(',')[0];

                                       
                                         XLineValue.push({ v: your_value, label: ListDate[i].split(',')[1] });

                                     }
                                     //Get auto-generated tickers (numericTicks is the default ticker generator)
                                     //Insert your label

                                     return XLineValue;
                                     },
                                
                             } , 
                                 y: {
                                 valueRange: [LinePoint[6][0]-(AnalyteMeadSD.SD *2) , LinePoint[0][0]+(AnalyteMeadSD.SD*2) ],
                                 ticker: function(min, max, pixels, opts, dygraph, vals) {

                                     LineValue = [];
                                     for (var i = 0; i < LinePoint.length; i++) {
                                         var your_value = LinePoint[i][0];
                                 
                                         LineValue.push({ v: your_value, label: LinePoint[i][0] + '('+LinePoint[i][1] +')' });

                                     }
                                     

                                     return LineValue;
                                 }
                             }
                             
                             
                         },
                         //For Color
                                                  drawPointCallback: function(g, seriesName, canvasContext, cx, cy, seriesColor, pointSize, row) {
                                                     var col = g.indexFromSetName(seriesName);
                                                     var val = g.getValue(row, col);
                                                     
                                                   var  tblRow =oTable.fnGetNodes(row);
                                                   var tblTd =$(tblRow).find('td')[4];
                                                   var RuleClass = $(tblTd).find('lable').attr('class');
                                                   
                                                   
                                                     var color = '';


                                                                                                     
                                                                                                       
                                                                                                        if (RuleClass == 'glyphicon glyphicon-remove Wrong') {
                                                                                                            color = 'red'  ;
                                                                                                        }
                                                                                                        else if (RuleClass == 'glyphicon glyphicon-ok warning') {
                                                                                                            color ='#ffdb99' ;
                                                                                                        }
                                                                                                        else 
                                                                                                        {
                                                                                                        color = 'green';
                                                                                                        }
                                                                                                       
                                                     
                                                      if (color) {
                                                          canvasContext.beginPath();
                                                          canvasContext.fillStyle = color;
                                                          canvasContext.strokeStyle = seriesColor;
                                                          canvasContext.arc(cx, cy, pointSize+3, 0, 2 * Math.PI, false);
                                                          canvasContext.fill();
                                                          canvasContext.stroke();
                                                     }
                                                  },
                         axisLabelColor: '#B25CB8',
                         drawPoints: true,
                         pointSize: 2,
                      //   highlightCircleSize: 4,
                         underlayCallback: function(ctx, area, dygraph) {
                             //An object will be more readable, for simplicity used array
                             xValues = dygraph.xAxisRange();
                             yValues = dygraph.yAxisRange()
                             var lines = [
        [[xValues[0], LinePoint[0][0]], [xValues[1], LinePoint[0][0]], 'red'],
        [[xValues[0], LinePoint[1][0]], [xValues[1], LinePoint[1][0]], 'red'],
         [[xValues[0], LinePoint[2][0]], [xValues[1], LinePoint[2][0]], 'green'],
          [[xValues[0], LinePoint[3][0]], [xValues[1], LinePoint[3][0]], 'blue'],
           [[xValues[0], LinePoint[4][0]], [xValues[1], LinePoint[4][0]], 'green'],
           [[xValues[0], LinePoint[5][0]], [xValues[1], LinePoint[5][0]], 'red'],
           [[xValues[0], LinePoint[6][0]], [xValues[1], LinePoint[6][0]], 'red']
        ];

                             for (var i = 0; i < lines.length; i++) {
                                 var line = lines[i];
                                 var xl = dygraph.toDomCoords(line[0][0], line[0][1]);
                                 var xr = dygraph.toDomCoords(line[1][0], line[1][1]);

                                 if (i == 1 || i == 5) {
                                     ctx.setLineDash([10, 8]);
                                 }
                                 else if (i == 2 || i == 4) {
                                     ctx.setLineDash([5, 3]);
                                 }
                                 else {
                                     ctx.setLineDash([1, 1]);
                                 }

                                 ctx.lineWidth=2;
                                 ctx.strokeStyle = line[2];
                                 ctx.beginPath();
                                 ctx.moveTo(xl[0], xl[1]);
                                 ctx.lineTo(xr[0], xr[1]);
                                 
                                 ctx.closePath();
                                 ctx.stroke();
                             }
                         }
                     });
                     
                  
                     
                       var annotations = [];
                 var  tblRow ;
                                                   var FailedRule;       
   for (var i = 0; i <=ListDate.length-1; i++) {
   
   if(ListDate[i].split(',')[2]!='' && ListDate[i].split(',')[2]!=undefined)
   {
   
   var SDval = (ListDate[i].split(',')[2] - AnalyteMeadSD.TargetMean)/ AnalyteMeadSD.SD;
                                                     tblRow =oTable.fnGetNodes(i);
                                                    FailedRule = $(tblRow).find('td')[5].textContent;
        annotations.push( {series:"Value",
        x: ''+ListDate[i].split(',')[0] +'',
        width: 30,
        height: 23,
        tickHeight: 10,
        text: 'Date: '+ListDate[i].split(',')[3] +'\nSD : '+SDval +' SD\nRule: '+FailedRule,
        cssClass: 'annotation',
        shortText:ListDate[i].split(',')[2]})
    }
}
                 
                     ChartObj.setAnnotations(annotations);
                     
}


                




