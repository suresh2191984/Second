<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleTransferScreen.aspx.cs"
    Inherits="Lab_SampleTransferScreen" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%--<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
    
    <%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>--%>
<%--<%@ register src="~/commoncontrols/topheader.ascx" tagname="topheader" tagprefix="top" %>--%>
<%@ register src="../commoncontrols/userheader.ascx" tagname="userheader" tagprefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Transfer Sample</title>

    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
        .style18
        {
            width: 89px;
        }
        .dataTables_wrapper
        {
            position: inherit !important;
        }
        .style2
        {
            width: 114px;
        }
        .style1
        {
            width: 250px;
        }
        #pnlSerch .wordWheel.listMain { z-index:99999!important;}
       
    </style>

    <script type="text/javascript" language="javascript">

        $(function() {
            ChangeDDLItemListWidth();
            $("#ddlAction").change(function() {
                if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                    $('#TxtAliquot').show();
                }
                else
                    $('#TxtAliquot').hide();
                if ($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') {
                    $('#ddlReason').show();
                }
                else
                    $('#ddlReason').hide();

            });
        });
    </script>

    <script type="text/javascript" language="javascript">

        function expandDropDownList1(elementRef) {
            elementRef.style.width = '420px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
    </script>

    <script language="javascript" type="text/javascript">

        function CheckOnOff(chkselectID, gridName) {
            var rdo = document.getElementById(chkselectID);
            var all = document.getElementsByTagName("input");
            for (i = 0; i < all.length; i++) {
                if (all[i].type == "radio" && all[i].id != rdo.id) {
                    var count = all[i].id.indexOf(gridName);
                    if (count != -1) {
                        all[i].checked = false;
                    }
                }
            }
            chkselectID.checked = true;
        }

        function ValidateSearch(pageno) {
            /* BEGIN | NA | Vijay | 20180108 | Created | Visit Search Using Last 5 Digits  */
            var _VisitNumber = $("[id*=txtVisitID]").val();
            if (_VisitNumber != '' && _VisitNumber.length < 5) {
                alert('Please Enter the VisitNumber Atleast 5 Digits');
                document.getElementById('<%=txtVisitID.ClientID %>').value = "";
                document.getElementById('<%=txtVisitID.ClientID %>').focus();
                return false;
            }
            /* END | NA | Vijay | 20180108 | Created | Visit Search Using Last 5 Digits  */
        
            var bolSelected = 'false';
	
			
   if (document.getElementById('txtFrom').value == '') {
                alert('Select From date');
                document.getElementById('txtFrom').focus();
                return false;

            }
		

            if (document.getElementById('txtFrom').value == '') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select From date');
                    return false;

                }
                document.getElementById('txtFrom').focus();
                return false;
            }


   if (document.getElementById('txtTo').value == '') {
                alert('Select To date');
                document.getElementById('txtTo').focus();
                return false;

            }
			
            if (document.getElementById('txtTo').value == '') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select To date');
                    return false;

                }
                document.getElementById('txtTo').focus();
                return false;
            }
          
            //------------------------andrews-----------------
                var fdate = (document.getElementById('txtFrom').value.trim().split(' '));
            var tdate = (document.getElementById('txtTo').value.trim().split(' '));
            var f1 = fdate[0];
            var f2 = tdate[0];


            if (fdate.length  <   1) {
               alert("Select To date");
                document.getElementById('txtFrom').focus();

               
                return false;
            }

            if (tdate.length < 1) {
                alert("Select To date");
                document.getElementById('txtTo').focus();
                return false;
            }
            
            if (f1.split('/')[2] > f2.split('/')[2]) {
                alert('Enter To Date as Greater than From Date');
                return false;
            }
            else {
                if (f1.split('/')[1] > f2.split('/')[1]) {
                    alert('Enter To Date as Greater than From Date');
                    return false;
                }
                else {

                    if ((f1.split('/')[0] > f2.split('/')[0]) && (f1.split('/')[1] == f2.split('/')[1]))
                     {
                        alert('Enter To Date as Greater than From Date');
                        return false;
                    }
                }

            }
//---------------------end--------------------------
            //debugger;
            search();
            GetData(pageno);
            return false;

        }
        function search() {

            //   $('#pnlFooter').show();
            $('#action').hide();

            $('#trtransloc').hide();
            $('#trtransdate').show();
            $('#btnOK').show();
            var querystring = '<%=Request.QueryString["Flag"]%>'

            if (querystring == "Y") {
                $('#action').show();

                $('#trtransloc').show();



            }
            else {
                $('#action').hide();

                $('#trtransloc').hide();

                $('#trtransdate').show();
                $('#btnOK').show();


                //                document.getElementById('action').style.display = 'none';
                //                document.getElementById('trtransloc').style.display = 'none';

            }
        }
        function GetData(pageno) {

            try {
                // debugger;



                var querystring = '<%=Request.QueryString["Flag"]%>'

                if (querystring == "Y") {
                    document.getElementById('ddltransferloc').value = -1;
                }


                document.getElementById('ddloutsource').style.display = 'none';

                //   var pop = $find("mdlPopup");
                // pop.show();
                var visitid = '';
                var patientname = '';
                var visittype = 0;
                var priority = -1;
                var fromdate = '';
                var todate = '';
                var sourcename = '';
                var InvestigationName = '';
                var InvestigationID = -1;
                var SampleName = '';
                var SmID = -1;
                var InvestigationType = '';
                var refPhyName = '';
                var refPhyID = -1;
                var refPhyOrg = -1;
                var CollectedLocationID = '';
                var ProcessedLocID = -1;
                var intSampleStatus = -1;
                var smpleID = -1;
                var outsourceID = -1;
                var BarcodeNo = '';
                var ContainerID = -1;
                var PlocationID = -1;
                var textfrom = $("#txtFrom").val();
                var textto = $("#txtTo").val();
                var droptype = 1;
                var Orgid = document.getElementById('hdnBaseOrgId').value;
                var locid = document.getElementById('hdnBaseILocationID').value;


                if ($("#ddlSampleStatus option:selected").val() != -1) {
                    intSampleStatus = $("#ddlSampleStatus option:selected").val();
                }
                else {
                    intSampleStatus = -1;
                }

//                if ($("#ddlType option:selected").val() == "1") {

                    if ($("#txtVisitID").val() != "") {
                        visitid = document.getElementById("txtVisitID").value.trim();
                    }
//                }
//                else if ($("#ddlType option:selected").val() == "2") {
//                    if ($("#txtVisitID").val() != "") {
//                        smpleID = document.getElementById("txtVisitID").value.trim();
//                    }
//                }
//                else {
//                }

                if ($("#txtPatientName").val() != "") {
                    patientname = document.getElementById("txtPatientName").value.trim();
                }
                if ($("#ddVisitType option:selected").val() != "-1") {
                    visittype = $("#ddVisitType option:selected").val();
                }

                if ($("#ddlPriority option:selected").val() != "-1") {
                    priority = $("#ddlPriority option:selected").val();
                }


                if ($("#txtFrom").val() != "" && $("#txtTo").val() != "") {
                    if ($("#txtFrom").val() == $("#txtTo").val()) {
                        fromdate = $("#txtFrom").val();
                        todate = $("#txtFrom").val();
                    }
                    else {
                        fromdate = $("#txtFrom").val();
                        todate = $("#txtTo").val();
                    }
                }
                else {
                    fromdate = '';
                    todate = '';
                }

                if ($("#txtClientName").val() != "" && $("#hdnClientID").val() != "0") {
                    sourcename = $("#hdnClientID").val();
                }
                if ($("#txtTestName").val() != "" && $("#hdnTestID").val() != "0") {
                    InvestigationName = $("#hdnTestName").val();
                    InvestigationID = $("#hdnTestID").val();
                    InvestigationType = $("#hdnTestType").val();
                }

                if ($("#txtRefDrName").val() != "" && $("#hdnRefPhyID").val() != "0") {
                    refPhyName = $("#hdnRefPhyName").val();
                    refPhyID = $("#hdnRefPhyID").val();
                    refPhyOrg = $("#hdnRefPhyOrg").val();
                }

                ProcessedLocID = $("#ddlstat option:selected").val();

                if ($("#ddloutsource option:selected").val() != "-1") {
                    outsourceID = $("#ddloutsource option:selected").val();
                }

                if ($("#TxtSampleName").val() != "" && $("#hdnsampleID").val() != "0") {
                    SampleName = $("#hdnSampleName").val();
                    SmID = $("#hdnSmpleID").val();
                }

                if ($("#txtbarcodeno").val() != "") {
                    BarcodeNo = $("#txtbarcodeno").val();
                }

                if ($("#txtcontname").val() != "" && $("#hdncontID").val() != "0") {
                    ContainerID = $("#hdncontID").val();
                }
                if ($("#ddlLocation option:selected").val() != "-1") {
                    PlocationID = $("#ddlLocation option:selected").val();
                }

                 //debugger;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetInvSamplesTransferStatusNew",
                    contentType: "application/json; charset=utf-8",
                    data: "{ pageno:'"+pageno+"',Orgid: '" + Orgid + "',textfrom: '" + textfrom + "',textto: '" + textto + "',intSampleStatus: '" + parseInt(intSampleStatus) + "',locid: '" + parseInt(locid) + "',visitid: '" + visitid + "',patientname: '" + patientname + "',visittype: '" + parseInt(visittype) + "',priority: '" + parseInt(priority) + "',sourcename: '" + sourcename + "',InvestigationName: '" + InvestigationName + "',InvestigationID: '" + InvestigationID + "',InvestigationType: '" + InvestigationType + "',refPhyName: '" + refPhyName + "',refPhyID: '" + refPhyID + "',refPhyOrg: '" + refPhyOrg + "',SmID: '" + SmID + "',droptype: '" + parseInt(droptype) + "',smpleID: '" + parseInt(smpleID) + "',ProcessedLocID: '" + parseInt(ProcessedLocID) + "',outsourceID: '" + parseInt(outsourceID) + "',BarcodeNo: '" + BarcodeNo + "',ContainerID: '" + parseInt(ContainerID) + "',PlocationID: " + parseInt(PlocationID) + "}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();

                        return false;
                    }
                });
                $('#lblCurrent').text(pageno);
                return false;

            }
            catch (e) {
                alert('error while loading GetData() in TransferSampleCollection.aspx');

            }

        }

        function AjaxGetFieldDataSucceeded(result) {
            // debugger;
            //var pop = $find("mdlPopup");
            var oTable;
          
                var list = result.d;
                if (list.length > 0) {
                    var tabledata = list;
                        var total = 1;
                   // var total = list.length;
                    if (result != "[]") {
                        oTable = $('#example').dataTable({
                            "bDestroy": true,
                            //"bAutoWidth": false,
                            "bProcessing": true,
                            // "bRetrieve": true,
                            "serverSide": true,
                            "aaData": tabledata,
                            //  "fnStandingRedraw": function() { pop.show(); },
                            //  "aaSorting": [[ 2, "desc" ]],
                            "aoColumns": [
                                    { "mData": "VisitNumber",
                                        "mRender": function(data, type, full) {
                                            return '<input type="checkbox" name="checkjdatatable" id="chkjdatatable"/> ';
                                        }
                                    },
                                        { "mDataProp": "VisitNumber"},
                                        { "mDataProp": "PatientNumber"},
                                        { "mDataProp": "BarcodeNumber"},
                                        { "mDataProp": "PatientName"},
                                        { "mDataProp": "InvestigationName"},
                                        { "mDataProp": "SampleDesc"},
                                        { "mDataProp": "SampleContainerName"},
                                         { "mDataProp": "InvSampleStatusDesc" },
                            //    { "mDataProp": "SamplePickupDate" },
                                          {"mDataProp": "SamplePickupDate",
                                          "fnRender": function(oObj) {
                                              var oldDate = new Date(parseInt(oObj.aData.SamplePickupDate.slice(6, -2)));
                                              var hours = oldDate.getHours();
                                              var minutes = oldDate.getMinutes().toString().slice(-2);
                                              var ampm = hours >= 12 ? 'pm' : 'am';
                                              hours = hours % 12;
                                              hours = hours ? hours : 12; // the hour '0' should be '12'
                                              minutes = minutes < 10 ? '0' + minutes : minutes;
                                              var strTime = hours + ':' + minutes + ' ' + ampm;
                                              var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + strTime);
                                              return DateTime;
                                          }
                                      },
                                           { "mDataProp": "LocationName"},
                                           { "mDataProp": "ProcessedAT"},
                                           { "mDataProp": "OutSourcedOrgName"},
                                            { "mDataProp": "PatientVisitID", "bVisible": false

                                            },

                                               { "mDataProp": "SampleID", "bVisible": false

                                               },

                                              { "mDataProp": "gUID", "bVisible": false

                                              },
                                              { "mDataProp": "SampleTrackerID", "bVisible": false

                                              },
                                              { "mDataProp": "TaskID", "bVisible": false

                                              },
                                            { "mDataProp": "CollectedLocID", "bVisible": false

                                            },
                                            { "mDataProp": "INVID", "bVisible": false

                                            },
                                            { "mDataProp": "Type", "bVisible": false

                                            },
                                             { "mDataProp": "AddressID", "bVisible": false


                                             }

                                  ],
                                                    "sPaginationType": "full_numbers",
                            "sZeroRecords": "No records found",
                            "bSort": false,
                            "bJQueryUI": true,
                            "bPaginate": false,
                            "bLengthChange":false,
                            "bInfo":false
                            // "iDisplayLength": 10
                            //                            "sDom": '<"H"Tfr>t<"F"ip>'
                            //                            "oTableTools": {
                            //                                "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            //                                "aButtons": [
                            //                            "copy", "csv", "xls", "pdf",
                            //                             {
                            //                                 "sExtends": "collection",
                            //                                 "sButtonText": "Save",
                            //                                 "aButtons": ["csv", "xls", "pdf"]
                            //                             }
                            //                          ]
                            //                            }
                        });


                        $('#tdsearch').show();
                        $('#example').show();
                        $('#lblmsg').hide();

                        if ((total % 10) == 0) {
                            var totalpages = parseInt((total / 10));
                        }
                        else {
                            var totalpages = parseInt((total / 10)) + 1;
                        }
                        
                        $('#lblTotal').text(totalpages);
                     
                        var querystring = '<%=Request.QueryString["Flag"]%>'
                        if (querystring == "Y") {
                            jloadActionDDL();
                        }
                        $("input[id$='selectall']").prop('checked', false);
                        $('#pnlFooter').show();
                        // pop.hide();
                    }
                }
                else {

                    $('#lblmsg').show();
                    $('#tdsearch').hide();

                    $('#pnlFooter').hide();
                }
            } 
        


        function jloadActionDDL() {
            //debugger;
            var OrgID = $("input:hidden[id$=hdnBaseOrgId]").val();
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SampleTransferLoadActionDDL",
                data: "{ }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {

                    // debugger;
                    var Items = data.d;
                    $('#ddlAction').attr("disabled", false);
                    //  $('#ddlAction').append('<option value="0">-Select-</option>');
                    $.each(Items, function(index, Item) {
                        $('#ddlAction').append('<option value="' + Item.ActionCode + '">' + Item.ActionName + '</option>');
                    });

                    // ddlAction.Visible = true;

                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
            // document.getElementById('ddlAction').style.display = 'none';
            // document.getElementById('lblReAssign').style.display = 'none';

            $('#ddlAction').show();
            $('#btnGo').show();
            $('#pnlFooter').show();

            if ($("#ddlSampleStatus option:selected").val() == "8") {
                $('#ddloutsource').show();
            }
            if ($("#ddlSampleStatus option:selected").val() == "6") {

                document.getElementById('ddlprocessedlocation').value = -1;
            }

            document.getElementById('trtransdate').style.display = 'block';
            document.getElementById('ddloutsource').value = -1;

        }

        function validateAliquot() {
            var bolSelected = 'false';

            var radios = document.getElementsByTagName('input');
            var value;
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].type === 'radio' && radios[i].checked) {
                    bolSelected = 'true';
                }
            }

            if (bolSelected == 'false') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select a Sample for Aliquot');
                    return false;

                }
                document.getElementById('TxtAliquot').value = 0;
                return false;
            }

        }

        function ValidateSelect() {
            var bolSelected = 'false';
            var Outsourceselected = 'true';
            $("#grdSample tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var rbSelect = $row.find("input[id$='rbSelect']").is(":checked");
                if (rbSelect) {
                    var lblSampleStatus = $row.find("span[id$='lblSampleStatus']").html();
                    if (lblSampleStatus != 'OutSource' && $('#ddlAction :selected').val() == 'Capture_OutSourcing_Details') {
                        userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_5');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;

                        }
                        else {
                            alert("This Action is only Performed for Outsourcing Sample.So Please Choose Outsourcing Sample for Capture OutSourcing Details");
                            return false;
                        }
                        Outsourceselected = 'false';
                    }
                    if (lblSampleStatus == 'OutSource' && $('#ddlAction :selected').val() != 'Capture_OutSourcing_Details') {
                        userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_6');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;

                        }
                        else {
                            alert("This Action is not Suitable For Outsourcing Sample.");
                            return false;
                        }
                        Outsourceselected = 'false';
                    }
                }
            });
            if (Outsourceselected == 'false') {
                return false;
            }
            var radios = document.getElementsByTagName('input');
            var value;
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].type === 'radio' && radios[i].checked) {
                    bolSelected = 'true';


                }
            }

            if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && ($('#ddlReason :selected').val() == '0')) {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select Reason');
                    return false;
                }
            }

            if (bolSelected == 'false') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_8');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select a Sample');
                    return false;
                }
            }

            if ($('#ddlAction :selected').val() == '0') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_9');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select Action');
                    return false;
                }
            }
            if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                if ($('#TxtAliquot').val() == '0') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_10');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        alert('Aliquot Value not Equal to Zero');
                        return false;
                    }
                }
            }
            if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                if ($('#TxtAliquot').val() == '') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_11');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        alert('Enter Aliquot Value');
                        return false;
                    }
                }
            }
        }

        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName1 = TestDetails.split('~')[0];
            var TestName = TestName1.split(':')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = TestName;
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = TestID;
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = TestType;
            }
        }

        function ClearTestDetails() {
            if (document.getElementById('txtTestName') != null) {
                document.getElementById('txtTestName').value = '';
            }
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = '';
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = '0';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }

        function SelectedRefPhy(source, eventArgs) {
            RefPhyDetails = eventArgs.get_value();

            var RefPhyName = RefPhyDetails.split('~')[0];
            var RefPhyID = RefPhyDetails.split('~')[1];
            var RefPhyOrg = RefPhyDetails.split('~')[2];
            if (document.getElementById('hdnRefPhyName') != null) {
                document.getElementById('hdnRefPhyName').value = RefPhyName;
            }
            if (document.getElementById('hdnRefPhyID') != null) {
                document.getElementById('hdnRefPhyID').value = RefPhyID;
            }
            if (document.getElementById('hdnRefPhyOrg') != null) {
                document.getElementById('hdnRefPhyOrg').value = RefPhyOrg;
            }
        }

        function ClearRefPhyDetails() {
            if (document.getElementById('txtRefDrName') != null) {
                document.getElementById('txtRefDrName').value = '';
            }
            if (document.getElementById('hdnRefPhyName') != null) {
                document.getElementById('hdnRefPhyName').value = '';
            }
            if (document.getElementById('hdnRefPhyID') != null) {
                document.getElementById('hdnRefPhyID').value = '0';
            }
            if (document.getElementById('hdnRefPhyOrg') != null) {
                document.getElementById('hdnRefPhyOrg').value = '';
            }
        }


        function Showhideloc() {
            var ActionID;
            var ActionName;

            var ddlAction = $('select[id$="ddlAction"] :selected');

            if (ddlAction != null) {

                ActionID = $(ddlAction).val();

                ActionName = $(ddlAction).text();

            }
            if (ActionName == "TransferSample") {
                document.getElementById('trtransloc').style.display = 'block';
                document.getElementById('trtransdate').style.display = 'block';
            }
            else {
                document.getElementById('trtransloc').style.display = 'none';
                document.getElementById('trtransdate').style.display = 'none';
            }
        }
        function SetSampleStatus() {
            var LocationCode;
            var ddlProcessedAt = $('select[id$="ddlLocation"] :selected');
            if (ddlProcessedAt != null) {
                LocationCode = $(ddlProcessedAt).val();
                if (LocationCode != undefined) {
                    if (LocationCode > 0) {
                        $("#ddlSampleStatus option[value='-1']").attr("selected", "selected");
                    }
                    else {
                        $("#ddlSampleStatus option[value='7']").attr("selected", "selected");
                    }
                }
            }
        }
        function ShowProcessedLoc() {
            var SampleStatusCode;
            var SampleStatusName;

            var ddlSampleStatus = $('select[id$="ddlSampleStatus"] :selected');

            if (ddlSampleStatus != null) {

                SampleStatusCode = $(ddlSampleStatus).val();

                SampleStatusName = $(ddlSampleStatus).text();

            }
            //if (SampleStatusCode == "6") {
            //   document.getElementById('ddlprocessedlocation').style.display = 'block';
            //  }
            // else {
            //  document.getElementById('ddlprocessedlocation').style.display = 'none';
            //}
            if (SampleStatusCode == "8") {
                document.getElementById('ddloutsource').style.display = 'block';
            }
            else {
                document.getElementById('ddloutsource').style.display = 'none';
            }
        }
        function validatePageNumber() {
            if (document.getElementById('txtpageNo').value == "") {
                return false;
            }
        }

        function TransferValidation() {
            //debugger;
            var isValid = false;
            var trnsferlocId;
            var trnsferlocName;
            var Todaydate = document.getElementById('hdnDate').value;
            var transferDate = document.getElementById('txttranDate').value;
            if (transferDate > Todaydate) {
                alert("Select a Correct Date And Time");
                return false;

            }
            var querystring = '<%=Request.QueryString["Flag"]%>'

            if (querystring == "Y") {

                var ddltransferloc = $('select[id$="ddltransferloc"] :selected');

                if (ddltransferloc != null) {

                    trnsferlocId = $(ddltransferloc).val();

                    trnsferlocName = $(ddltransferloc).text();

                }
                if (trnsferlocId == "-1") {
                    alert('Select the Location to Transfer');
                    return false;
                }

                $("#example tr:not(:first)").each(function(i, n) {
                    var $row = $(n);
                    var rbSelect = $row.find("input[id$='chkjdatatable']").is(":checked");
                    if (rbSelect) {
                        if (trnsferlocId == "-1") {
                            alert('Select a Location to Transfer');
                            document.getElementById('ddltransferloc').Value = -1;
                            return false;

                        }
                        isValid = true;
                        return true;
                    }
                });


            }

            TransferSample();


            return false;
        }

        function JSONDateWithTime(dateStr) {
            jsonDate = dateStr;
            var d = new Date(parseInt(jsonDate.substr(6)));
            var m, day;
            m = d.getMonth() + 1;
            if (m < 10)
                m = '0' + m
            if (d.getDate() < 10)
                day = '0' + d.getDate()
            else
                day = d.getDate();
            var formattedDate = m + "/" + day + "/" + d.getFullYear();
            var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
            var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
            var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
            formattedDate = formattedDate + " " + formattedTime;
            return formattedDate;
        }

        function TransferSample() {
            //debugger;
            var chkcount = 0;
            var Transferdate;
            var CollLocID;
            var count = 0;
            var err = 0;
            var lstsampletransfer = [];
            var orgid = document.getElementById('hdnBaseOrgId').value;
            var lid = document.getElementById('hdnlid').value;
            var a = "";
            var b = 0;
            //            var MIN_DATE = -62135578800000;
            Transferdate = $("#txttranDate").val();
            var date = JSONDateWithTime(Transferdate);
            //             var date = new Date(parseInt(Transferdate.substr(6, Transferdate.length-8)));                                                       
            //  var date1= date.toString() == new Date(MIN_DATE).toString() ? "" : (date.getMonth() + 1) + "\\" + date.getDate() + "\\" + date.getFullYear();

            //  var myJSDate = (new Date(parseInt(Transferdate.substr(6)))).toJSON();
            //var date = new Date(parseInt(Transferdate.substr(6)));

            $("#example tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var checked = $row.find("input[id$='chkjdatatable']").is(":checked");
                if (checked) {
                    chkcount++;
                    var oTable = $("#example").dataTable();
                    var rowData = oTable.fnGetData(i);
                    var StatusType = rowData["Type"];
                    var querystring = '<%=Request.QueryString["Flag"]%>'

                    if (querystring == "Y") {
                        CollLocID = $("#ddltransferloc option:selected").val()
                    }
                    else {
                        CollLocID = rowData["AddressID"];        //row.children[21].innerText;
                    }

                    var strPatientVisitId = rowData["PatientVisitID"];     //row.children[13].innerText;
                    var strSampleId = rowData["SampleID"];                 //row.children[14].innerText;
                    var strGuid = rowData["gUID"];                        //row.children[15].innerText;
                    var strINVID = rowData["INVID"];                      //row.children[19].innerText;
                    var strType = rowData["Type"];                       //row.children[20].innerText;

                    lstsampletransfer.push({ PatientVisitID: strPatientVisitId,
                        SampleID: strSampleId,
                        UID: strGuid,
                        INVID: strINVID,
                        Type: strType,
                        ModifiedBy: lid,
                        OrgID: orgid,
                        RecSampleLocID: CollLocID,
                        CreatedAt: date
                    });
                }
            });
            if (chkcount > 0) {


                document.getElementById('hdnsampletransfer').value = JSON.stringify(lstsampletransfer);
                var lstajaxsample = document.getElementById('hdnsampletransfer').value;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/CheckIsValidtoTransferNew",
                    contentType: "application/json; charset=utf-8",
                    data: "{ lstajaxsample: '" + lstajaxsample + "'}",
                    dataType: "json",
                    async: true,
                    success: function(data) {


                        a = data.d;
                        alert(a);
                        if (a == "Sample Transferred Sucesfully") {

                            GetData(1);
                        }



                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        return false;
                    }
                });

            }
            else {
                alert('Select the Sample to Transfer');
                return false;
            }
            return false;

        }

        function SelectedSample(source, eventArgs) {
            SampleDetails = eventArgs.get_value();

            var TestName = SampleDetails.split('~')[0];
            var TestID = SampleDetails.split('~')[1];
            if (document.getElementById('hdnSampleName') != null) {
                document.getElementById('hdnSampleName').value = TestName;
            }
            if (document.getElementById('hdnSmpleID') != null) {
                document.getElementById('hdnSmpleID').value = TestID;
            }
        }
        function ClearSampleDetails() {
            if (document.getElementById('txtSampleName') != null) {
                document.getElementById('txtSampleName').value = '';
            }
            if (document.getElementById('hdnSampleName') != null) {
                document.getElementById('hdnSampleName').value = '';
            }
            if (document.getElementById('hdnSmpleID') != null) {
                document.getElementById('hdnSmpleID').value = '0';
            }
        }

        function SelectAllTest(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }
        }


        function ClientNameSelected(source, eventArgs) {
            ClientDetails = eventArgs.get_value();
            var ClientName = ClientDetails.split('~')[0];
            var ClientID = ClientDetails.split('~')[1];
            if (document.getElementById('hdnClientName') != null) {
                document.getElementById('hdnClientName').value = ClientName;
            }
            if (document.getElementById('hdnClientID') != null) {
                document.getElementById('hdnClientID').value = ClientID;
            }
        }

        function ClearClientDetails() {
            if (document.getElementById('txtClientName') != null) {
                document.getElementById('txtClientName').value = '';
            }
            if (document.getElementById('hdnClientName') != null) {
                document.getElementById('hdnClientName').value = '';
            }
            if (document.getElementById('hdnClientID') != null) {
                document.getElementById('hdnClientID').value = '0';
            }
        }

        function ContainerName(source, eventArgs) {
            ContainerDetais = eventArgs.get_value();

            var ContName = ContainerDetais.split('~')[0];
            var ContID = ContainerDetais.split('~')[1];
            if (document.getElementById('hdncontname') != null) {
                document.getElementById('hdncontname').value = ContName;
            }
            if (document.getElementById('hdncontID') != null) {
                document.getElementById('hdncontID').value = ContID;
            }
        }

        function ClearContainerDetails() {
            if (document.getElementById('txtcontname') != null) {
                document.getElementById('txtcontname').value = '';
            }
            if (document.getElementById('hdncontname') != null) {
                document.getElementById('hdncontname').value = '';
            }
            if (document.getElementById('hdncontID') != null) {
                document.getElementById('hdncontID').value = '0';
            }
        }

        function ClearPatientNameDetails() {

            if (document.getElementById('hdnPatientID') != null) {
                document.getElementById('hdnPatientID').value = '0';
            }
        }
        function SelectedPatientName(source, eventArgs) {
            //debugger;
            var PatientDetails = eventArgs.get_text().split('~');
            if (PatientDetails.length > 1) {
                document.getElementById('hdnPatientID').value = '';
                var patientname = PatientDetails[0].split('-');
                document.getElementById('txtPatientName').value = patientname[0];
                document.getElementById('hdnPatientID').value = PatientDetails[1];
            }
            else {
                document.getElementById('hdnPatientID').value = '';
                document.getElementById('txtPatientName').value = '';
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
            <Attune:Attuneheader ID="MainHeader" runat="server" />
                <%--<uc1:MainHeader ID="MainHeader" runat="server" />--%>
                <%--<uc6:UserHeader ID="UserHeader1" runat="server" />--%>
            </div>
            <%--<div style="float: right;" class="Rightheader">
            </div>--%>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="100%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                               <%-- <Top:TopHeader ID="TopHeader1" runat="server" />--%>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <div class="contentdata">
                                    <asp:UpdatePanel ID="up1" runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter">
                                                    </div>
                                                    <div align="center" id="processMessage">
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                                        <br />
                                                        <br />
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <ul>
                                                            <li>
                                                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                                            </li>
                                                        </ul>

                                                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                                                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

                                                        <script type="text/javascript">

                                                            $(function() {
                                                                $("#txtFrom").datepicker({
                                                                    changeMonth: true,
                                                                    changeYear: true,
                                                                    yearRange: '1900:2100'
                                                                });
                                                                $("#txtTo").datepicker({
                                                                    changeMonth: true,
                                                                    changeYear: true,
                                                                    maxDate: 0,
                                                                    yearRange: '1900:2100'

                                                                })
                                                            });
    

                                                        </script>

                                                        <asp:Panel ID="pnlSerch" Width="100%" runat="server">
                                                            <table cellpadding="2" class="dataheaderInvCtrl" cellspacing="2" border="0" width="100%">
                                                                <tr>
                                                                    <td style="width: 10%;" align="right">
                                                                       <%-- <span class="richcombobox" style="width: 75px;">
                                                                            <asp:DropDownList CssClass="ddl" ID="ddlType" Width="75px" runat="server" BackColor="AliceBlue">
                                                                                <%--<asp:ListItem Text="Visit No." Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Sample ID" Value="2"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </span>--%>
                                                                        <%--                                    <asp:Label ID="Rs_FromVisitNo"  Text="Visit No" runat="server" 
                                                                                            meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>--%>
                                                                        <asp:Label ID="Label4" runat="server" Text="Visit Number"></asp:Label>          
                                                                    </td>
                                                                    <td style="width: 20%;">
                                                                        <asp:TextBox ID="txtVisitID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromVisitResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 8%;" align="left">
                                                                        <asp:Label ID="Rs_ToVisitNo" Text="Patient Name" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 17%;">
                                                                        <asp:TextBox ID="txtPatientName" runat="server" onfocus="javascript:ClearPatientNameDetails();"
                                                                            CssClass="Txtboxsmall" meta:resourcekey="txtToVisitResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                            MinimumPrefixLength="3" ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                                                            DelimiterCharacters="" Enabled="True" OnClientItemSelected="SelectedPatientName">
                                                                        </ajc:AutoCompleteExtender>
                                                                        <asp:HiddenField ID="hdnPatientID" runat="server" Value="0" />
                                                                    </td>
                                                                    <td align="left" style="width: 8%;">
                                                                        <asp:Label ID="Rs_VisitType" Text=" Visit Type" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%;">
                                                                        <span class="richcombobox" style="width: 75px;">
                                                                            <asp:DropDownList CssClass="ddl" ID="ddVisitType" Width="75px" runat="server">
                                                                                <%--  <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                                        <asp:ListItem Text="OP" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1"></asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="lbllocation" runat="server" Text="Processed At"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <span class="richcombobox" style="width: 130px;">
                                                                            <asp:DropDownList CssClass="ddl" ID="ddlLocation" Width="130px" normalWidth="130px"
                                                                                onmousedown="expandDropDownList1(this);" onblur="collapseDropDownList(this);"
                                                                                runat="server" onChange="javascript:return SetSampleStatus();">
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblsourcename" runat="server" Text="Client Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtClientName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearClientDetails();"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender5" MinimumPrefixLength="2" runat="server"
                                                                            TargetControlID="txtClientName" ServiceMethod="FetchClientNameForOrg" ServicePath="~/WebService.asmx"
                                                                            EnableCaching="False" BehaviorID="AutoGrp122" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="ClientNameSelected">
                                                                        </ajc:AutoCompleteExtender>
                                                                        <asp:DropDownList CssClass="ddl" ID="ddClientName" Width="130px" runat="server" Style="display: none">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblrefdocname" runat="server" Text="Ref. Doctor Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRefDrName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearRefPhyDetails();"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                                                            TargetControlID="txtRefDrName" ServiceMethod="FetchRefPhysicianNameForOrg" ServicePath="~/WebService.asmx"
                                                                            EnableCaching="False" BehaviorID="AutoCompleteExLstGrp12" CompletionInterval="2"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                            Enabled="True" OnClientItemSelected="SelectedRefPhy">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="lbltestname" runat="server" Text="Test Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearTestDetails();"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                                            TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                                                                            EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                            Enabled="True" OnClientItemSelected="SelectedTest">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="Label3" runat="server" Text="Sample"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="TxtSampleName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearSampleDetails();"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" MinimumPrefixLength="2" runat="server"
                                                                            TargetControlID="TxtSampleName" ServiceMethod="FetchSampleNameForOrg" ServicePath="~/WebService.asmx"
                                                                            EnableCaching="False" BehaviorID="AutoGrp12" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedSample">
                                                                        </ajc:AutoCompleteExtender>
                                                                        <asp:DropDownList CssClass="ddl" Width="130px" ID="ddlSample" runat="server" Style="display: none">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblpriority" runat="server" Text="Priority"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%;">
                                                                        <span class="richcombobox" style="width: 80px;">
                                                                            <asp:DropDownList CssClass="ddl" ID="ddlPriority" Width="80px" runat="server">
                                                                                <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Text="VIP" Value="0"></asp:ListItem>
                                                                                <asp:ListItem Text="Emergency" Value="1"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Rs_From" Text="From Date" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                                            <tr class="defaultfontcolor">
                                                                                <td>
                                                                                    <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"></asp:TextBox>&nbsp;
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="Rs_To" Text="To Date" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                                            <tr class="defaultfontcolor">
                                                                                <td>
                                                                                    <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"></asp:TextBox>&nbsp;
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblSampleStatus1" runat="server" Text="Investigation Status"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <span class="richcombobox" style="width: 90px;">
                                                                            <asp:DropDownList CssClass="ddl" ID="ddlSampleStatus" Width="90px" runat="server"
                                                                                onChange="javascript:return ShowProcessedLoc();">
                                                                            </asp:DropDownList>
                                                                        </span>&nbsp;
                                                                        <img align="middle" alt="" src="../Images/starbutton.png" style="display: none" /><span
                                                                            class="richcombobox" style="width: 130px;"><asp:DropDownList ID="ddlprocessedlocation"
                                                                                Style="display: none" onmousedown="expandDropDownList1(this);" onblur="collapseDropDownList(this);"
                                                                                runat="server" CssClass="ddl" Width="130px" normalWidth="130px">
                                                                            </asp:DropDownList>
                                                                            <asp:DropDownList runat="server" Width="130px" ID="ddloutsource" CssClass="ddl" Style="display: none">
                                                                            </asp:DropDownList>
                                                                        </span>&nbsp;<asp:HiddenField ID="hdnSampleStatus" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblbarcodeno" runat="server" Text="Barcode Number"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtbarcodeno" runat="server" CssClass="Txtboxsmall" MaxLength="25"
                                                                            size="20"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblContName" runat="server" Text="Container Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtcontname" runat="server" CssClass="Txtboxsmall" MaxLength="25"
                                                                            onfocus="javascript:ClearContainerDetails();"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtendercon" runat="server" BehaviorID="AutoGrp150"
                                                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                            Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="ContainerName" ServiceMethod="FetchSampleContainerForOrg"
                                                                            ServicePath="~/WebService.asmx" TargetControlID="txtcontname">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblpriority1" runat="server" Text="StatPriority"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <span class="richcombobox" style="width: 90px;">
                                                                            <asp:DropDownList ID="ddlstat" runat="server" CssClass="ddl" Width="90px">
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5" align="center">
                                                                        <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Generate Work Order"
                                                                            Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                            Text="Search"  OnClientClick="return ValidateSearch(1);" meta:resourcekey="btnFinishResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:Label ID="lblmsg" runat="server" Text="No Matching Records Found!" style="display:none"></asp:Label>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td id="tdsearch" runat="server">
                                                                        <table id="example" style="display: none" width="100%">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th align="center" id="chk" width="2%">
                                                                                        Select
                                                                                        <input type="checkbox" id="selectall" />
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Visit No
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Patient No
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Barcode No
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Patient Name
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Investigations
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Sample Name
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Container
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Sample Status
                                                                                    </th>
                                                                                    <th align="center"  width='12%'>
                                                                                        Sample Collected Date And Time
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Sample Collected At
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Sample Processed At
                                                                                    </th>
                                                                                    <th align="center"  width='10%'>
                                                                                        Out Source Centre
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnVisitId
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnSampleId
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnGuid
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnSampleTrackerID
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnTaskID
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnCollocationID
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdninvID
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdntype
                                                                                    </th>
                                                                                    <th align="center" style="visibility: collapse">
                                                                                        hdnaddressid
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
                                        
                                                        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"> </asp:Label>
                                                        <div runat="server" id="dInves" style="display: block;">
                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                               
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:Panel ID="pnlFooter" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                                          <table width="100%">
                                                                                <tr id="pagination" runat="server" class="dataheaderInvCtrl">
                                                                                    <td align="center" colspan="10" class="defaultfontcolor">
                                                                                        <asp:Label ID="lblPage" runat="server" Text="Page" ></asp:Label>
                                                                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                                                        <asp:Label ID="lblof" runat="server" Text="Of" ></asp:Label>
                                                                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" ></asp:Label>
                                                                                        <asp:Button ID="btnFirst" runat="server" Text="First" CssClass="btn" onclientclick="return pagechange('f')"/>
                                                                                        <asp:Button ID="btnPrev" runat="server" Text="Previous" CssClass="btn" onclientclick="return pagechange('p')" />                                                                           
                                                                                        <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" onclientclick="return pagechange('n')" />
                                                                                        <asp:Button ID="btnLast" runat="server" Text="Last" CssClass="btn" onclientclick="return pagechange('l')" />
                                                                                        <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" ></asp:Label>
                                                                                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px" autocomplete="off"
                                                                                            onKeyDown="return  isNumericss(event,this.id)" ></asp:TextBox>
                                                                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" 
                                                                                            onmouseover="this.className='btn btnhov'" 
                                                                                            OnClientClick="return pagechange('g')" />
                                                                                       
                                                                                    </td>
                                                                                </tr>
                                                                            </table>  
                                                                            <table>
                                                                                <%-- //added by sudhakar--%>
                                                                                <tr id="action" runat="server">
                                                                                    <td id="Td2" style="color: #000;" align="right" runat="server" class="style18">
                                                                                        <asp:Label ID="lblReAssign" runat="server" Text="Action"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" id="Td3" runat="server" style="color: #000;">
                                                                                        <span class="richcombobox">
                                                                                            <asp:DropDownList ID="ddlAction" runat="server" CssClass="ddl" onclick="return Showhideloc()"
                                                                                                Style="display: block" Width="130px">
                                                                                            </asp:DropDownList>
                                                                                        </span>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="trtransloc" runat="server" style="display: none">
                                                                                    <td id="Td1" align="right" runat="server">
                                                                                        <%--<table width="80%">--%>
                                                                                        <%--</table>--%>
                                                                                        <asp:Label ID="Label1" runat="server" Text="Transfered&nbsp;Location"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <asp:DropDownList ID="ddltransferloc" Width="130px" runat="server" normalWidth="130px"
                                                                                            onmousedown="expandDropDownList1(this);" onblur="collapseDropDownList(this);">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="trtransdate" runat="server" style="display: none">
                                                                                    <td id="Td10" runat="server" align="right">
                                                                                        <asp:Label ID="Label2" runat="server" Text="Transfer&nbsp;Date"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <asp:TextBox ID="txttranDate" runat="server" Width="100px" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                        <a href="javascript:NewCssCal('txttranDate','ddmmyyyy','arrow',true,12)">
                                                                                            <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" align="center">
                                                                                        <asp:Button ID="btnOK" runat="server" CssClass="btn" OnClientClick="return TransferValidation()"
                                                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="cursor: pointer;"
                                                                                            Text="Transfer Sample" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td id="Td4" align="right" runat="server" colspan="3">
                                                                                        <asp:HiddenField runat="server" ID="hdnVisit" />
                                                                                        <asp:HiddenField runat="server" ID="hdnPatientNumber" />
                                                                                        <asp:HiddenField runat="server" ID="hdnPatID" />
                                                                                        <asp:HiddenField ID="hdnReasonList" runat="server" />
                                                                                        <asp:HiddenField ID="hdnReasonCtls" runat="server" />
                                                                                        <asp:HiddenField ID="hdnStatusCtls" runat="server" />
                                                                                        <asp:HiddenField ID="hdnTestName" runat="server" />
                                                                                        <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
                                                                                        <asp:HiddenField ID="hdnTestType" runat="server" />
                                                                                        <asp:HiddenField ID="hdnRefPhyName" runat="server" />
                                                                                        <asp:HiddenField ID="hdnRefPhyID" Value="0" runat="server" />
                                                                                        <asp:HiddenField ID="hdnRefPhyOrg" runat="server" />
                                                                                        <asp:HiddenField ID="hdnClickEvent" Value="No" runat="server" />
                                                                                        <asp:HiddenField ID="hdnTestCheckBoxId" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            
                                                                            
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                                                        </div>
                                                        <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                                                        <asp:HiddenField ID="hdnsampleID" runat="server" />
                                                        <asp:HiddenField ID="hdnMessages" runat="server" />
                                                        <asp:HiddenField ID="hdnSampleName" runat="server" />
                                                        <asp:HiddenField ID="hdnSmpleID" runat="server" />
                                                        <asp:HiddenField ID="hdncontname" runat="server" />
                                                        <asp:HiddenField ID="hdncontID" runat="server" />
                                                        <asp:HiddenField ID="hdnClientName" runat="server" />
                                                        <asp:HiddenField ID="hdnDate" runat="server" />
                                                        <asp:HiddenField ID="hdnClientID" runat="server" />
                                                        <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
                                                        <asp:HiddenField ID="hdnBaseILocationID" runat="server" />
                                                        <asp:HiddenField ID="hdnquerystring" runat="server" />
                                                        <asp:HiddenField ID="hdnlid" runat="server" />
                                                        <asp:HiddenField ID="hdnsampletransfer" runat="server" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                  <%--  <uc2:Footer ID="Footer2" runat="server" />--%>
                </td>
            </tr>
        </table>
    </div>
    </form>
  

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>

<script type="text/javascript">

    $('#selectall').click(function() {
        $("#example tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            if ($('#selectall').is(':checked')) {
                $row.find("input[id$='chkjdatatable']").prop('checked', true);
            }
            else {
                $row.find("input[id$='chkjdatatable']").prop('checked', false);
            }
        });

    });
    function DatePickUP() {
        $(function() {
            $("#txtFrom").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1900:2100'
            });
            $("#txtTo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'

            })
        });
    }

    function pagechange(option) {
       // debugger;
        if (option == 'f') {
            ValidateSearch(1);
        }
        else if (option == 'l') {
            ValidateSearch($('#lblTotal').text());
        }
        else if (option == 'n') {

            var a = parseInt($('#lblTotal').text());
            var b = parseInt($('#lblCurrent').text()) + 1;
            if (b > a) {
                alert("There is no next page");
            }
            else {
                ValidateSearch(b);
            }
        }
        else if (option == 'p') {
            var b = parseInt($('#lblCurrent').text()) - 1;
            if (b > 0) {
                ValidateSearch(b);
            }
            else {
                alert("There is no previous page");
            }

        }
 
        else if (option == 'g') {
            var a = parseInt($('#lblTotal').text());

            var b = parseInt($('#txtpageNo').val());

            if (b > a) {
                alert("Don't give number that Exceed page");

            }
            else if (b < 1) {
            alert("Enter the valid number");
            }
            else {
                ValidateSearch(b);
            }

        }
        return false;
    }

</script>

<script type="text/javascript">
    if (typeof DatePickUP == 'function')
        Sys.Application.add_load(DatePickUP);  </script>

</html>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

