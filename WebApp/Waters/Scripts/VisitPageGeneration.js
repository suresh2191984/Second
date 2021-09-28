var ClientID, PersonID;




function GetClientID(source, eventArgs) {


    ClientID = eventArgs.get_value().split('~')[2];
    document.getElementById('hfCustomerId').value = ClientID;


}

function GetPersonID(source, eventArgs) {


    PersonID = eventArgs.get_value();
    document.getElementById('hfPersonID').value = 0;
    document.getElementById('hfPersonID').value = PersonID;




}

var vldPer = true;
var vldCld = true;
function ValidVisitSearch() {
    var VisitNo = document.getElementById('txtVisitNo').value;

    if (VisitNo == '') {
       
        if ($('#txtPerson').val() == '') {


            ValidationWindow("Provide Sample Collection person", "alert");
            vldPer = false;
            return false;

        }

        if ($('#txtClientName').val() == '') {


            ValidationWindow("Provide Client Name", "alert");
            vldCld = false;
            return false;
            //$('#txtClientName').focus();


        }

        VisitSheetDetail('');


    }
    else {
        VisitSheetDetail(VisitNo);
    }
   


    return false;


}
function ClearField() {
    document.getElementById('txtFromDate').value = "";
    document.getElementById('txtToDate').value = "";
    document.getElementById('txtClientName').value = "";
    document.getElementById('txtPerson').value = "";
    $("#WholeVisitSheet").hide();
    $("#btnPrint").hide();
    $("#lnkPrint").hide();
    $("#btnSendMail").hide();
    ClearData();
    return false;
}

var ResultLen;
function VisitSheetDetail(check) {

    var DynamicTableES;
    var Orgid = document.getElementById('hdnOrgID').value;


    var fdate = document.getElementById('txtFromDate').value;
    var tdate = document.getElementById('txtToDate').value;
    ClientID = document.getElementById('hfCustomerId').value;
    PersonID = document.getElementById('hfPersonID').value;
    var VisitNo = check;
    if (check != '') {
        PersonID = -1;
        ClientID = -1;
        ResultLen = 2;
        DynamicTableES = BindDataVisit;
    }
    else {
        DynamicTableES = BindData;
        ResultLen = 3;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetVisitPageGeneration",
        data: JSON.stringify({ OrgID: Orgid, ClientID: ClientID, CollectedBy: PersonID, fdate: fdate, tdate: tdate, VisitNo: VisitNo }),
        dataType: "json",
        async: false,
        success: DynamicTableES
    });


    return false;


}

function SelectALL() {

    $("#VisitSheetOneTbl tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        debugger;
        if ($('#selectall').is(':checked')) {
            $row.find("input[class$='ALL']").prop('checked', true);
        }
        else {
            $row.find("input[class$='ALL']").prop('checked', false);
        }
    });

}

function MultiSelect(Val) {
    $("#VisitSheetOneTbl tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        debugger;
        if ($('#' + Val + '').is(':checked')) {
            debugger;
            $row.find("input[Id$=" + Val + "]").prop('checked', true);
        }
        else {
            $row.find("input[Id$=" + Val + "]").prop('checked', false);
        }
    });
}


function BindData(data) {

    
    
    //    document.getElementById('btnVisitSave').style.display = 'block';
    //    document.getElementById('btnVisitCancel').style.display = 'block';    // var GetData = JSON.parse(data.d[0]);
    



    if (data.d[1] != '' && data.d[2] != '') {
        document.getElementById('lblVisitClientVal').innerHTML = data.d[0][0].ClientName;
        document.getElementById('lblVisitContactVal').innerHTML = data.d[0][0].CollectionPerson;
        document.getElementById('lblVisitDesignationVal').innerHTML = data.d[0][0].RoleName;
        document.getElementById('lblVisitAddressVal').innerHTML = data.d[0][0].Address;
        document.getElementById('lblVisitContactNumberVal').innerHTML = data.d[0][0].ContactPerson;
        document.getElementById('lblVisitSheduleTimeVal').innerHTML = data.d[0][0].ScheduledTime;
        document.getElementById('lblVisitNosShow').innerHTML = "";
        document.getElementById('hfCustomerId').value = 0;
        document.getElementById('hfPersonID').value = 0;
        document.getElementById('txtPerson').value = "";
        document.getElementById('txtClientName').value = "";


        $("#WholeVisitSheet").show();
        $("#btnPrint").hide();
        $("#lnkPrint").hide();
        $("#btnSendMail").hide();

        $('#VisitSheetOneTbl').dataTable({
            "bDestroy": true,
            "bProcessing": true,
            "aaData": data.d[1],

            "aoColumns": [

                   { "sTitle": "<Input type='checkbox' Id='selectall' onclick='SelectALL()'></Input>", "mData": "InvestiagtionID",
                       "mRender": function(data, type, full) {
                           return '<Input type="checkbox" Class="ALL" onclick="MultiSelect(this.id)"  Id="' + full.InvestiagtionID + '"></Input>';
                       }
                   },
                          { "sTitle": "Test Name", "mData": "InvestiagtionName", "sClass": "center", "sWidth": "20%",
                              "mRender": function(data, type, full) {
                                  return '<label ID="InvestiagtionName">' + full.InvestiagtionName + '</label>';
                              }
                          },
                          { "sTitle": "Sample Type", "mData": "SampleType",
                              "mRender": function(data, type, full) {
                                  return '<label ID="SampleType">' + full.SampleType + '</label>';

                              }
                          },
                          { "sTitle": "Sample ID", "mData": "SampleID", "sClass": "center", "sWidth": "10%",
                              "mRender": function(data, type, full) {
                                  return '<label ID="SampleID">' + full.SampleID + '</label>';
                              }
                          },
                           { "sTitle": "Sample Description", "mData": "SampleDescrip", "sClass": "center", "sWidth": "30%",
                               "mRender": function(data, type, full) {
                                   return '<Input Type="Text" ID="SampleDescrip"></Input>';
                               }
                           },
                            { "sTitle": "Container Count", "mData": "SampleCount", "sClass": "center", "sWidth": "5%",
                                "mRender": function(data, type, full) {
                                    return '<label ID="SampleCount">' + full.SampleCount + '</label>';
                                }
                            },
                            { "sTitle": "Field Test", "mData": "FieldTest",
                                "mRender": function(data, type, full) {
                                    return '<label ID="FieldTest">' + full.FieldTest + '</label>';
                                }
                            },
                            { "sTitle": "Temperature", "mData": "Temperature", "sClass": "center", "sWidth": "10%",
                                "mRender": function(data, type, full) {
                                    return '<Input Type="Text" ID="Temperature"> </Input>';
                                }
                            },
                             { "sTitle": "Location", "mData": "Location", "sClass": "center", "sWidth": "10%",
                                 "mRender": function(data, type, full) {
                                     return '<Input Type="Text" ID="Location"> </Input>';
                                 }
                             }




                          ],

            "sZeroRecords": "No records found",
            "bSort": false,

            "bPaginate": false,
            "bLengthChange": false,
            "bInfo": false,
            "bFilter": false

        });
        var i = 0;
        $('#tblListTestParameters').dataTable({

            "bDestroy": true,
            "bProcessing": true,
            "aaData": data.d[2],
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {

                i = i + 1;

                $(nRow).find('#SNO').text(i);



                return nRow;
            },
            "aoColumns": [
                             { "sTitle": "S.No", "mData": "ContainerCount", "sClass": "center", "sWidth": "5%",
                                 "mRender": function(result, type, full) {
                                     return '<label ID="SNO">' + full.TestNames + '</label>';
                                 }
                             },
                          { "sTitle": "Test Name", "mData": "TestNames", "sClass": "center", "sWidth": "20%",
                              "mRender": function(data, type, full) {
                                  return '<label ID="TestNames">' + full.TestNames + '</label>';
                              }
                          },
                          { "sTitle": "Count", "mData": "ContainerCount", "sClass": "center", "sWidth": "5%",
                              "mRender": function(data, type, full) {
                                  return '<label ID="ContainerCount">' + full.ContainerCount + '</label>';

                              }
                          },
                          { "sTitle": "Test Parameters", "mData": "InvestigationNameList", "sClass": "center", "sWidth": "70%",
                              "mRender": function(data, type, full) {
                                  return '<label ID="InvestigationNameList">' + full.InvestigationNameList + '</label>';
                              }
                          }



                          ],

            "sZeroRecords": "No records found",
            "bSort": false,

            "bPaginate": false,
            "bLengthChange": false,
            "bInfo": false,
            "bFilter": false

        });
         
        $("#btnVisitSave").show();
        $("#btnVisitCancel").show();
        $("#imgBarcode").hide();
    }
    else
     {
         $("#WholeVisitSheet").hide();
         $("#btnPrint").hide();
         $("#lnkPrint").hide();
         $("#btnSendMail").hide();
        ValidationWindow("Sample Schedule list is empty", "alert");
        document.getElementById('lblVisitClientVal').innerHTML = "";
        document.getElementById('lblVisitContactVal').innerHTML = "";
        document.getElementById('lblVisitDesignationVal').innerHTML = "";
        document.getElementById('lblVisitAddressVal').innerHTML = "";
        document.getElementById('lblVisitContactNumberVal').innerHTML = "";
        document.getElementById('lblVisitSheduleTimeVal').innerHTML = "";
        document.getElementById('lblVisitNosShow').innerHTML = "";
        document.getElementById('txtPerson').value = "";
        document.getElementById('txtClientName').value = "";

    }
    document.getElementById('lblVisitClientVal').style.fontWeight = "900";
    document.getElementById('lblVisitContactVal').style.fontWeight = "900";
    document.getElementById('lblVisitDesignationVal').style.fontWeight = "900";
    document.getElementById('lblVisitAddressVal').style.fontWeight = "900";
    document.getElementById('lblVisitContactNumberVal').style.fontWeight = "900";

    document.getElementById('lblVisitSheduleTimeVal').style.fontWeight = "900";
}


var dtCampDetail = [];


function SaveData() {
   

    $("#VisitSheetOneTbl tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        var checked = $row.find("input[class$='ALL']").is(":checked");
        if (checked) {

            var SampleId = $row.find("#SampleID").text();
            var SampleDescrip = $row.find("#SampleDescrip").val();
            var Temperature = $row.find("#Temperature").val();
            var Location = $row.find("#Location").val();

            dtCampDetail.push({
                SampleId: SampleId,
                SampleDescrip: SampleDescrip,
                Temperature: Temperature,
                Location: Location

            });

        }



    });

    if (dtCampDetail.length <= 0) {

        ValidationWindow("Please select atleast one record", "Alert");
        return false;

    }
    else {

        GenerateVisitNo();
        dtCampDetail = [];
        return false;
    }

}


function GenerateVisitNo() {
 var OrgID = document.getElementById("hdnOrgID").value;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/CreateVisitNoGeneration",
        data: JSON.stringify({ LstVisitSheetDetailsQuotation: dtCampDetail, OrgID: OrgID }),
        dataType: "json",
        async: false,
        success: BindDataVisit
    });



}

function BindDataVisit(result) {
    var j = 0;
    $("#WholeVisitSheet").show();
    $("#btnPrint").show();
    $("#lnkPrint").show();
    $("#btnSendMail").show();
    $('#VisitSheetOneTbl').dataTable({
        "bDestroy": true,
        "bProcessing": true,
       
        "aaData": result.d[1],
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {

        j = j + 1;

        $(nRow).find('#SNO').text(j);



            return nRow;
        },
        "aoColumns": [

                   { "sTitle": "S.No", "mData": "ContainerCount", "sClass": "center", 
                       "mRender": function(result, type, full) {
                           return '<label ID="SNO">' + full.TestNames + '</label>';
                       }
                   },
                          { "sTitle": "Test Name", "mData": "InvestiagtionName", "sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="InvestiagtionName">' + full.InvestiagtionName + '</label>';
                              }
                          },
                          { "sTitle": "Sample Type", "mData": "SampleType", "sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="SampleType">' + full.SampleType + '</label>';

                              }
                          },
                          { "sTitle": "Sample ID", "mData": "SampleID", "sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="SampleID">' + full.SampleID + '</label>';
                              }
                          },
                           { "sTitle": "Sample Description", "mData": "SampleDescrip", "sClass": "center", 
                               "mRender": function(result, type, full) {
                                   return '<label ID="SampleDescrip">' + full.SampleDescrip + '</label>';
                               }
                           },
                            { "sTitle": "Container Count", "mData": "SampleCount", "sClass": "center", 
                                "mRender": function(result, type, full) {
                                    return '<label ID="SampleCount">' + full.SampleCount + '</label>';
                                }
                            },
                            { "sTitle": "Field Test", "mData": "FieldTest", "sClass": "center", 
                                "mRender": function(result, type, full) {
                                    return '<label ID="FieldTest">' + full.FieldTest + '</label>';
                                }
                            },
                            { "sTitle": "Temperature", "mData": "Temperature", "sClass": "center", 
                                "mRender": function(result, type, full) {
                                    return '<label ID="Temperature">' + full.Temperature + '</label>';
                                }
                            },
                             { "sTitle": "Location", "mData": "Location", "sClass": "center", 
                                 "mRender": function(result, type, full) {
                                     return '<label ID="Location">' + full.Location + '</label>';
                                 }
                             }




                          ],

        "sZeroRecords": "No records found",
        "bSort": false,
      
        "bPaginate": false,
        "bLengthChange": false,
        "bInfo": false,
        "bFilter": false

    });
    var j = 0;
    $('#tblListTestParameters').dataTable({

        "bDestroy": true,
        "bProcessing": true,

        "aaData": result.d[ResultLen],
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
           
            j = j + 1;

            $(nRow).find('#SNO').text(j);



            return nRow;
        },
        "aoColumns": [

                   { "sTitle": "S.No", "mData": "ContainerCount", "sClass": "center", 
                       "mRender": function(result, type, full) {
                           return '<label ID="SNO">' + full.TestNames + '</label>';
                       }
                   },
                          { "sTitle": "Test Name", "mData": "TestNames", "sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="TestNames">' + full.TestNames + '</label>';
                              }
                          },
                          { "sTitle": "Count", "mData": "ContainerCount","sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="ContainerCount">' + full.ContainerCount + '</label>';

                              }
                          },
                          { "sTitle": "Test Parameters", "mData": "InvestigationNameList", "sClass": "center", 
                              "mRender": function(result, type, full) {
                                  return '<label ID="InvestigationNameList">' + full.InvestigationNameList + '</label>';
                              }
                          }



                          ],

        "sZeroRecords": "No records found",
        "bSort": false,
    
        "bPaginate": false,
        "bLengthChange": false,
        "bInfo": false,
        "bFilter": false

    });

    if (result.d[1] != '' && result.d[2] != '') {
        document.getElementById('lblVisitClientVal').innerHTML = result.d[0][0].ClientName;
        document.getElementById('lblVisitContactVal').innerHTML = result.d[0][0].CollectionPerson;
        document.getElementById('lblVisitDesignationVal').innerHTML = result.d[0][0].RoleName;
        document.getElementById('lblVisitAddressVal').innerHTML = result.d[0][0].Address;
        document.getElementById('lblVisitContactNumberVal').innerHTML = result.d[0][0].ContactPerson;
        document.getElementById('lblVisitSheduleTimeVal').innerHTML = result.d[0][0].ScheduledTime;
       // document.getElementById('lblVisitNosShow').innerHTML = result.d[1][0].VisitNumber;
        document.getElementById('hfCustomerId').value = 0;
        document.getElementById('hfPersonID').value = 0;
        document.getElementById('txtPerson').value = "";
        document.getElementById('txtClientName').value = "";
        document.getElementById('txtVisitNo').value = "";
        $("#imgBarcode").show();
        CreateVisitImg(result.d[1][0].VisitNumber);

        document.getElementById('hdnVisitNo').value = result.d[1][0].VisitNumber;
        document.getElementById('hdnEmailID').value = result.d[0][0].Email;
//        document.getElementById('btnVisitSave').style.display = 'none';
        //        document.getElementById('btnVisitCancel').style.display = 'none';
        $("#btnVisitSave").hide();
        $("#btnVisitCancel").hide();
        ValidationWindow("Visit Number is Generated.Visit Number is "+result.d[1][0].VisitNumber, "Alert");
        
    }
    else {
        $("#WholeVisitSheet").hide();
        $("#btnPrint").hide();
        $("#lnkPrint").hide();
        $("#btnSendMail").hide();
        ValidationWindow("Invalid VisitNumber", "alert");
        document.getElementById('lblVisitClientVal').innerHTML = "";
        document.getElementById('lblVisitContactVal').innerHTML = "";
        document.getElementById('lblVisitDesignationVal').innerHTML = "";
        document.getElementById('lblVisitAddressVal').innerHTML = "";
        document.getElementById('lblVisitContactNumberVal').innerHTML = "";
        document.getElementById('lblVisitSheduleTimeVal').innerHTML = "";
        document.getElementById('lblVisitNosShow').innerHTML = "";
        document.getElementById('txtPerson').value = "";
        document.getElementById('txtClientName').value = "";
        document.getElementById('txtVisitNo').value = "";
        document.getElementById('txtFromDate').value = "";
        document.getElementById('txtToDate').value = ""; 

    }
    document.getElementById('lblVisitClientVal').style.fontWeight = "900";
    document.getElementById('lblVisitContactVal').style.fontWeight = "900";
    document.getElementById('lblVisitDesignationVal').style.fontWeight = "900";
    document.getElementById('lblVisitAddressVal').style.fontWeight = "900";
    document.getElementById('lblVisitContactNumberVal').style.fontWeight = "900";
    document.getElementById('lblVisitNosShow').style.fontWeight = "900";
    document.getElementById('lblVisitSheduleTimeVal').style.fontWeight = "900";
}

function ViewVisitSheet() {
    var VisitNo = document.getElementById('txtVisitNo').value;

    if (VisitNo == '') {
        ValidationWindow("Provide Visit No", "alert");


    }
    else {
        VisitSheetDetail(VisitNo);
    }
    document.getElementById('txtVisitNo').value = "";
    return false;

}







function CreateVisitImg(VisitNO) {


    document.getElementById("imgBarcode").src = "../admin/BarcodeHandler.ashx?barcodeno=" + VisitNO + "&footer=" + VisitNO + "&width=155&height=65"; 
}

//function OnComplete(buffer) {

//    //String file = Convert.ToBase64String(result);
//    document.getElementById("imgBarcode").setAttribute('src', buffer.d);

//    document.getElementById("imgBarcode").src = "../admin/BarcodeHandler.ashx?barcodeno=" + BatchNo + "&footer=" + BatchNo + "&width=100&height=50&html=true"; 

//}

function SendEmail() {

//    $find("mpe").show();
    //    return false;
    CheckEmpty();
    return false;
}

function CheckEmpty() {
    var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
    var objcli = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_01') == null ? "Kindly Configure MailID for Collection Person!!!" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_01');
    var Check = document.getElementById('hdnEmailID').value;
    if (Check == "") {
        ValidationWindow(objcli, AlertType);

        //alert("Enter Email Address");
        return true;
    }
    else {
        var OrgID = document.getElementById("hdnOrgID").value;
//        var RoleID = document.getElementById("hdnRoleID").value;
//        var PageID = document.getElementById("hdnPageID").value;
        var VisitNo = document.getElementById('hdnVisitNo').value;
        var Email = document.getElementById('hdnEmailID').value;
        var InHtml = document.getElementById('WholeVisitSheet').innerHTML;
        var MailDetails = "/Waters/WatersVisitPageGeneration~Waters VisitGeneration~<div style='font-family:Verdana;font-size:12;'><p>Dear  Sir/Madam <br/>~VisitGeneration '"+111+"'"; //ReportPath~Mail Subject~Mail body~FileName

        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/EmailPdfSend",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ OrgID: OrgID, VisitNo: VisitNo, Email: Email, InHtmlBody: InHtml, MailDetails: MailDetails }),

            async: false,
            //data: { 'barcodeno': VisitNO, 'footer': VisitNO, 'width': '100', 'height': '50', 'html': 'true' },
            success: function OnCompleteEm(data) {
                if (data.d == "-1") {
                    ValidationWindow("Fail to sending Mail","Alert");
                }
                else if (data.d == "0") {
                ValidationWindow("Mail Send SuccessFully", "Alert");
                }

            }

        });
        document.getElementById('hdnEmailID').value = "";
    }
    return false;

}

function ClearData() {

    debugger;
    var Defaultamount = document.getElementById('hdfDefaultPaymentMode').value;
    $("#WholeVisitSheet").hide();
    $('#cbClient').prop('checked', false);
    $('#cbRep').prop('checked', false);
    $("#ddlPaymentMode").val(Defaultamount);

    //$("#VisitSheetOneTbl").val('');

    //document.getElementById('VisitSheetOneTbl').innerHTML = "";

    //document.getElementById('tblListTestParameters').innerHTML = "";

    return false;



}

