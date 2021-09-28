<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnterTissueType.aspx.cs"
    Inherits="Histopathology_EnterTissueType" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enter Tissue Type</title>
        <script src="../Scripts/datatablescroll.3.3.1.js" type="text/javascript"></script>

    <link href="../StyleSheets/datatable.scroll.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="ctrlDIV" class="contentdata">

        <script type="text/javascript">
            $(function() {
                $("#txtFDate").datepicker({
                    dateFormat: 'dd/mm/yy',
                   
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    showOn: "both",
                    buttonImage: "../StyleSheets/start/images/calendar.gif",
                    buttonImageOnly: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    showOn: "both",
                    buttonImage: "../StyleSheets/start/images/calendar.gif",
                    onClose: function(selectedDate) {
                        $("#txtTDate").datetimepicker("option", "minDate", selectedDate);

                        var date = $("#txtFDate").datetimepicker('getDate');
                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                        // $("#txtTo").datepicker("option", "maxDate", d);

                    }
                });
                $("#txtTDate").datepicker({
                    dateFormat: 'dd/mm/yy',
                   
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    showOn: "both",
                    buttonImage: "../StyleSheets/start/images/calendar.gif",
                    buttonImageOnly: true,
                    maxDate: 0,

                    yearRange: '1900:2100',
                    showOn: "both",
                    buttonImage: "../StyleSheets/start/images/calendar.gif",
                    onClose: function(selectedDate) {
                        $("#txtFDate").datetimepicker("option", "maxDate", selectedDate);
                    }
                })
            });
        </script>

<style>
       .autocmp .ui-corner-all
        {
            -moz-border-radius: 4px 4px 4px 4px;
        }
    .ui-widget-content
        {
            border: 1px solid black;
            color: #222222;
            background-color: White;
        }
      
      .ui-menu
        {
            display: block;
            float: left;
            list-style: none outside none;
            margin: 0;
            padding: 2px;
        }
      .ui-autocomplete
        {
            cursor: default;
            position: absolute;
        }
        .ui-menu .ui-menu-item
        {
            clear: left;
            float: left;
            margin: 0;
            padding: 0;
            width: 100%;
        }
        .ui-menu .ui-menu-item a
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            cursor: pointer;
            background-color: White;
        }
        .ui-menu .ui-menu-item a:hover
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            color: White;
            cursor: pointer;
            background-color: ButtonText;
        }
        .ui-widget-content a
        {
            color: #222222;
        }
    </style>

        <table style="padding-right: 15px; width: 1300px; height: 150px; /* right: 134px;
            */">
            <tr>
                <td>
                    <asp:Label ID="lblOUTLOC" runat="server" Text="Visit Number "></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtVisitNos" />
                </td>
                <td>
                    <asp:Label ID="lblPatient" runat="server" Text="Patient Number "></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtPatientNos" />
                </td>
                <td>
                    <asp:Label ID="lblHisto" runat="server" Text="Histopath Number "></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtHistopath" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPatientNos" runat="server" Text="Patient Name "></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtPatientName" />
                </td>
                <td>
                    <asp:Label ID="lblInv" runat="server" Text="Investigation "></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtINV" class="autocmp" onkeyup="ContainerAutoCom(this.id)"/>
                </td>
                <td>
                    <asp:Label ID="lblSpec" runat="server" Text="Specimen "></asp:Label>
                </td>
                <td>
                    <input id="txtSpeciman" type="text" onkeyup="ContainerAutoCom(this.id)" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCOntainerName" Text="Container Name" runat="server"></asp:Label>
                </td>
                <td>
                    <input id="txtContainer" type="text" onkeyup="ContainerAutoCom(this.id)" />
                </td>
                <td>
                    <asp:Label ID="lblBarcodeNos" Text="BarCode Number" runat="server"></asp:Label>
                </td>
                <td>
                    <input type="text" id="txtBarcodeNos" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblFromDate" Text="From Date" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png" alt="" class="a-center">
                </td>
                <td>
                    <asp:Label ID="lblToDate" Text="To Date" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox><img src="../Images/starbutton.png" alt="" class="a-center">
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                    <input type="button" value="Search" class="btn" onclick="searchData();" />
                </td>
                <td>
                </td>
            </tr>
        </table>
        <div id="Searchtbl" >
        </div>
        <br />
        <div id="downbtnDiv">
            <input type="button" value="Save" style="margin-left: 50%; display: none" class="btn"
                id="btnSaveclick" onclick="SaveEnterTissue();" /></div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnSampleID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnContainer" runat="server" Value="0" />
    <asp:HiddenField ID="hdnInvID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
    <asp:HiddenField ID="hdnOrgDate" runat="server" Value="" />
    </form>
</body>
<style type="text/css">
    .ui-autocomplete { height: 200px; overflow-y: scroll; overflow-x: hidden;}
    .ScrollStyle
    {
        max-height: 300px;
        overflow-y: scroll;
    }
     .w-100p
        {
            width: 100%;
        }
    #tblEnterTissue td
    {
        border: 1px solid black;
    }
    #tblEnterTissue tr:nth-child(odd)
    {
        background: #e7e7e7;
    }
    #tblEnterTissue tr:nth-child(even)
    {
        background: white;
    }
     .ui-datepicker
        {
            font-size: 10pt !important;
            
        }
    ui_tpicker_time_label
    .ui_tpicker_time_label
        {
            font-size:x-small;
        }
       
       .ui_tpicker_minute_label
        {
            font-size:x-small;
        }
         .ui_tpicker_time
        {
            font-size:x-small;
        }
        .ui_tpicker_second_label
        {
            font-size:x-small;
        }
        .ui_tpicker_time_label
        {
             font-size:x-small;
        }
        .ui_tpicker_hour_label
        {
            font-size:x-small;
        }
        
</style>
<script type="text/javascript">
function bindscroll(){
    $('#tblEnterTissue').DataTable( {
        "scrollY":        "200px",
        "scrollCollapse": true,
        "paging":         false
    } );
    }
</script>
<script src="../Scripts/datatablescroll.min.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
    $('#txtFDate').val(document.getElementById('hdnOrgDate').value);
    $('#txtTDate').val(document.getElementById('hdnOrgDate').value);
    });
    function clearAllCtrl() {

        $('#txtHistopath').val('');
        $('#txtVisitNos').val('');
        $('#txtPatientNos').val('');
        $('#txtBarcodeNos').val('');
        $('#txtPatientName').val('');
//        $('#txtFDate').val('');
//        $('#txtTDate').val('');
        document.getElementById("hdnSampleID").value = '0';
        document.getElementById("hdnContainer").value = '0';
        $('#txtContainer').val('');
        $('#txtSpeciman').val('');
        $('#hdnInvID').val(0);
        $('#hdnSampleID').val(0);
        $('#hdnContainer').val(0);
        document.getElementById("txtINV").value = "";
    }


    function searchData() {
        var data = [];
        var tblStruct = "";
        var VisitNos = $('#txtVisitNos').val();
        var PatientNos = $('#txtPatientNos').val();
        var Barcode = $('#txtBarcodeNos').val();
        var PatientName = $('#txtPatientName').val();
        var frmDate = $('#txtFDate').val();
        var toDate = $('#txtTDate').val();
        var SampleID = document.getElementById("hdnSampleID").value;
        var ContainerID = document.getElementById("hdnContainer").value;
        var InvID = document.getElementById("hdnInvID").value;
        var Histo = $('#txtHistopath').val();

        if (frmDate != "" && toDate != "") {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetHistoSampleSearch",
                data: "{ 'VisitNumber': '" + VisitNos + "','PatientNumber': '" + PatientNos + "','HistoNumber': '" + Histo + "','PatientName': '" + PatientName + "','InvID': " + InvID + ",'SampleContainerID': '" + ContainerID + "' ,'SampleCode': " + parseInt(SampleID) + ",'BarcodeNumber': '" + Barcode + "','frmDate':'" + frmDate + "','toDate': '" + toDate + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    //alert(msg.d);
                    data = JSON.parse(msg.d);
                    if (data.length == 0) {
                        ValidationWindow("No Matching Records Found!!!", "Alert");
                        $('#tblEnterTissue').hide();
                        $('#downbtnDiv').hide();
                        return false;
                    }
                    else {
                        tblStruct = "<div class='w-100p'><table border='1' class='display' style='width: 100%;padding: 10px;margin:auto;' id='tblEnterTissue'><thead><tr><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th>Visit No</th><th>Patient No</th><th> Histopathlogy No</th><th> Patient Name</th><th> Investigations</th><th> Speciman</th><th> Container</th><th> BarCode No</th><th> Tissue Type</th><th> Received Date</th></tr></thead><tbody>";
                        $.each(data, function(i, item) {
                            //   alert(data[i].PatientName);

                            //var checkbox = "<input type='checkbox' name='vehicle' value='Bike'>";
                            tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td>" + item.VisitNumber + "</td><td>" + item.PatientNumber + "</td><td>" + item.HistoNumber + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='lblBarcode'>" + item.BarcodeNumber + "</span></td><td><input ID='txtTissueType' type='text' class='TissueType' value='" + item.TissueType + "'></input></td><td>" + GetCorrectdate(item.ReceivedDate) + "</td></tr>";
                            //                    var det = new Date(item.ReceivedDate.replace(/\//g, ''));
                            //                    strdate(det);
                        });
                        tblStruct += "</tbody></table></div>";
                        document.getElementById('Searchtbl').innerHTML = tblStruct;
                        tblStruct = "";
                        $('.TissueType').attr('readOnly', true);
                        $('.TissueType').css('background-color', '#ebf6f8');
                        $('#btnSaveclick').css('display', 'block');
                         bindscroll(); 
                        ChkClick();
                        $('#downbtnDiv').show();
                    }
                },
                error: function(msg) {
                    alert(msg.d);
                }

            });
        }
        else {
            ValidationWindow("Please Select FromDate & ToDate !!!!", "Alert");
        }

        

       // clearAllCtrl();
    }
    function GetCorrectdate(value) {

        if (value != null && value != '') {
            var date = new Date(parseInt(value.substr(6)));
            var month = date.getMonth() + 1;
            value = date.getDate() + "/" + month + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() ;
        }
        else
        { value = ""; }
        return value;
    }
    function ChkClick() {
        $('input[type="checkbox"]').click(function() {
            if (this.checked) {
                $(this).closest("tr").find('.TissueType').attr('readOnly', false);
                $(this).closest("tr").find('.TissueType').css('background-color', 'white');
            }
            else {
                $(this).closest("tr").find('.TissueType').attr('readOnly', true);
                $(this).closest("tr").find('.TissueType').css('background-color', '#ebf6f8');
            }
        });
    }
    function SelectALL() {

        $("#tblEnterTissue tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            debugger;
            if ($('#selectall').is(':checked')) {
                $row.find("input[class$='ckh']").prop('checked', true);
                $(this).closest("tr").find('.TissueType').attr('readOnly', false);
                $(this).closest("tr").find('.TissueType').css('background-color', 'white');
            }
            else {
                $row.find("input[class$='ckh']").prop('checked', false);
                $(this).closest("tr").find('.TissueType').attr('readOnly', true);
                $(this).closest("tr").find('.TissueType').css('background-color', '#ebf6f8');
            }
        });

    }
    function SaveEnterTissue() {
        var TissueType = '';

        var BarCodeNumber = '';
        var lstTissueType = [];
        $(".ckh:checked").each(function(i, n) {
            TissueType = $(this).closest("tr").find('.TissueType').val();
            BarCodeNumber = $(this).closest("tr").find('.lblBarcode')[0].innerHTML;
            if (TissueType != "") {
                lstTissueType.push({
                    SampleDesc: TissueType,
                    BarCodeNumber: BarCodeNumber

                });
            }
            // alert(res + '  ' + resBarCode);
        });
        if (lstTissueType.length != 0) {


        $.ajax({
            type: "POST",
            url: "../WebService.asmx/pSaveEnterTissueType",
            data: JSON.stringify({ lstPatSamp: lstTissueType }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
            //alert(msg.d);
                if(msg.d>=0)
                {
                    ValidationWindow("Tissue Type Saved successfully!!", "Alert");
					searchData();
            }

            },
            error: function(msg) {
                alert(msg.d);
            }

            });
        }
        else {
            alert("Please Select Atleast One");
        }
    }
        
       
        
        
    
</script>

<script type="text/javascript">
    function ContainerAutoCom(eve) {
        var Cont = '';
        var SampleName = '';
        var Name = '';
        // var GetCtrlID = eve.target.id;
        if (eve == 'txtContainer') {
            Cont = $('#txtContainer').val();
            SampleName = '';
            Name = '';
            GetCtrlID = '';
            $('#hdnContainer').val('0');
          

        }
        else if (eve == 'txtSpeciman') {
            Cont = '';
            SampleName = $('#txtSpeciman').val();
            Name = '';
            GetCtrlID = '';
            $('#hdnSampleID').val('0');
        }
        else if (eve == 'txtINV') {
            Cont = '';
            SampleName = '';
            Name = $('#txtINV').val();
            GetCtrlID = '';
            $('#hdnInvID').val('0');
        }

        $(function() {
            var DoctorName = '';
            GetCtrlID = '';
            $("#" + eve).autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '../WebService.asmx/GetINVandSampleandContainerDetails',
                        data: "{'Name': '" + Name + "','SampleName': '" + SampleName + "','ContainerName':'" + Cont + "','DoctorName':'" + DoctorName + "'}",
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

                    if (eve == 'txtContainer') {
                      //  alert(i.item.val);
                        // hdnContainer
                        $('#hdnContainer').val(i.item.val);
                    } else if (eve == 'txtSpeciman') {
                      //  alert(i.item.val);
                        $('#hdnSampleID').val(i.item.val);
                    }
                    else if (eve == 'txtINV') {
                    $('#hdnInvID').val(i.item.val);
                    }

                },
                minLength: 2
            });
        });
    }

    $('input:text').not('.Txtboxsmall').keypress(function(e) {
    var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;
    });

    
</script>

</html>
