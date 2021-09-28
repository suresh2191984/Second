<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InterLabComparison.aspx.cs" Inherits="QMS_InterLabComparison" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Inter Lab Comparison </title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
     

   
    
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="plugins/iCheck/all.css" type="text/css">
    <!-- Include the plugin's CSS and JS: -->
    <link rel="stylesheet" href="plugins/multiSelect/css/bootstrap-multiselect.css" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
 
    
          <style type="text/css">
         .hide_Column
         {
            display: none;
         }
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
        }
        .textsize
         {
            max-width:70px;
            max-height:20px;
        }
         .required
         {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
    </style>
    <link href="Script/jquery-ui-git.css" rel="Stylesheet" type="text/css" />
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
        <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="test" runat="server" UpdateMode="Always">
            <ContentTemplate>
                  <uc1:MainHeader ID="MainHeader" runat="server" />

                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content">
          <div class="fadeindown header-top">
          <div class="row">
                <div class="col-md-12">
                     <h4 class="strong">Inter Lab Comparison</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblDepartment" runat="server" Text="Department" localize="ILC_lblDepartment"></asp:Label>
                            <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                                 
                                 </asp:DropDownList>
                        </div>
                </div>
                
                <div class="col-xs-6 col-sm-2 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lblVendor" runat="server" Text="Vendor" localize="ILC_lblVendor"></asp:Label>
                            <span class="required">*</span>
                         </div>
                         
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                              <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control">
                                 
                                 </asp:DropDownList>
                        </div>
                </div>
                
               
                
               
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblDate" runat="server" Text="Evaluation Date" localize="ILC_lblDate"></asp:Label>
                            <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                     <div class="form-group">
                        
                        <div class="input-group date">
                              <asp:TextBox ID="txtDate" runat="server" ReadOnly="true" CssClass="form-control pull-right"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        
                     </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-1">
                        <div class="form-group">
                            <input type="button" id="btnLoad" value="Load" class="btn btn-success"  onclick="LoadDeptInvestigations();" localize="ILC_btnLoad"/>
                        </div>
                </div>
                </div>
                <div class="row">
                <!--Row-->
               <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblFileupload" runat="server" Text="File Upload" localize="ILC_lblFileupload"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group" style="overflow:hidden;">
                      <asp:FileUpload ID="txtfileupload" runat="server" accept=".pdf,image/*"   meta:resourcekey="FileUpload1Resource1" />
                                     <div class="MultiFile-list" id="txtfileupload_wrap_list">
                                     </div> 
                     </div>
                </div>
               <div class="col-xs-6 col-sm-2 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lblFileType" runat="server" Text="FileType" localize="ILC_lblFileType"></asp:Label>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                              <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control" >
                                <%-- <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>--%>
                                  <asp:ListItem Text="Internal" Value="IN"></asp:ListItem>
                               <%--     <asp:ListItem Text="External" Value="EX"></asp:ListItem>--%>
                                 </asp:DropDownList>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-1" style="display:none;">
                        <div class="form-group">
                            <asp:Label ID="lblResultType" runat="server" Text="Result Type"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2" style="display:none;">
                   <div class="form-group">
                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" disabled="disabled">
                                  <asp:ListItem Text="Internal" Value="IN"></asp:ListItem>
                                 </asp:DropDownList>
                     </div>
                </div>
                 
                <!--Row-->
               </div>
             
            <!-- Row -->
            <div class="row">
                <div class="form-group text-center">
                          <input type="button" id="btnClear"  class="btn btn-primary" value="Clear" onclick="Clear()" localize="ILC_btnClear" />
                          <input type="button" id="btnAdd" class="btn btn-primary" value="Save" localize="ILC_btnAdd" />
                    <%--<asp:Button ID="btnUpload" runat="server" CssClass="btn btn-primary" Text="Upload"     />--%>
                </div>
            </div>
            
            
           </div>
      
                     <div class="gridTable bounceinup">
                            <div class="table-responsive" style="display:none;">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="TblTaskDetails" >
                                  <thead>
                                        <tr>
                                            <th class="hide_Column">InvestigationID</th>
                                            <th localize="SNO">SNO</th>
                                            <th localize="ILC_AnalyteName">Analyte Name</th>
                                            <th localize="ILC_InternalValue">Internal Value</th>
                                            <th localize="ILC_ExternalValue">External Value</th>
                                            <th localize="ILC_Variation">Variation %  </th>
                                            <th localize="Status">Status</th>
                                            <th localize="ILC_RootCause">Root Cause</th>
                                            <th localize="ILC_lblCorrection">Correction</th>
                                            <th localize="EQA_CorrectiveActions">Corrective Actions</th>
                                            <th localize="EQA_PreventiveActions">Preventive Actions</th>
                                           <th localize="ILC_btnEdit">Edit</th>
                                           <th localize="Delete">Delete</th>
                                        </tr>
                                  </thead>
                                  <tbody>
                  
                                    </tbody>
                              </table>
                           </div>
                    </div>
                    
           </section>
                    <!-- /.content -->
                </div>
                <!-- /.content-wrapper -->
                <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2016-2017 <a href="http://attunelive.com">Attune</a>.</strong> All rights reserved.
      </footer>
            </ContentTemplate>
            <Triggers>
       <%-- <asp:PostBackTrigger ControlID="BtnAdd" />--%>
          
            </Triggers>
        </asp:UpdatePanel>
        <asp:Button ID="btnTarget" runat="server" Style="display: none;" />
                                        <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1100px;"
                                            CssClass="modalPopup dataheaderPopup">
                                            <div id="divFullImage">
                                             <button id="btnClose" type="button" class="fa fa-times fa-2x pull-right circle" style="border-radius:50px;" data-dismiss="modal"></button>
                                                <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                    <tr id="trPDF" runat="server">
                                                        <td>
                                                            <iframe id="ifPDF" runat="server" style="display: none; border: 1; overflow: auto;"
                                                                width="1100px" height="600px"></iframe>
                                                        </td>
                                                    </tr>
                                            <%--        <tr>
                                                        <td align="center">
                                                            <input id="btnClose" runat="server" class="btn" type="button" value="Close" />
                                                        </td>
                                                    </tr>--%>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                        <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                            BackgroundCssClass="modalBackground" DropShadow="false" PopupControlID="pnlOthers"
                                            CancelControlID="btnClose" TargetControlID="btnTarget" Enabled="True">
                                        </ajc:ModalPopupExtender>
        <asp:HiddenField  runat="server" id="hdnFilepath" />
        </form>
    </div>
    <!-- ./wrapper -->
    <!-- jQuery 2.1.4 -->

    <script src="plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>

    <!-- jQuery UI 1.11.2 -->

    <script src="Script/jquery-ui.min.js" type="text/javascript"></script>

    <!-- Bootstrap 3.3.2 JS -->

    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <!-- bootstrap datepicker -->

    <script src="Script/ControlLength.js" type="text/javascript"></script>

    <%--<script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>

    <!-- iCheck 1.0.1 -->

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <!-- Include the plugin's CSS and JS: -->

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>

    <%-- <script type="text/javascript" src="plugins/multiSelect/js/bootstrap-multiselect.js"></script>--%>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->
    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>
    
    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
<%--
    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>--%>

    <script src="Script/QC_Common.js" type="text/javascript"></script>
     
        <script src="Script/moment.js" type="text/javascript"></script>
    <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>
    <script type="text/javascript">
        var DelFiles = [];
//        $(function() {

//            //Date picker
//            $('.datepicker').datepicker({
//                autoclose: true,
//                format: 'dd/mm/yyyy',
//                startDate: '-3d'
//            });
//        });

        $(document).ready(function() {
            LoadEQASDropDownValues();
            $('#btnAdd').hide();
            var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
            var path = GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');
            $("#txtDate").datepicker({
                dateFormat: 'dd/mm/yy',
                //defaultDate: "d",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {


                    var date = $("#txtDate").datepicker('getDate');

                }

            });
        });

        function LoadEQASDropDownValues() {
            var dd;
            var resdata = [];

            $.ajax({
                type: "POST",
                url: "../QMS.asmx/QMS_LoadInvPrincipleMaster",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                async: false,
                success: function(data) {
                    dd = data.d;

                    if (dd[2].length > 0) {
                        $('#ddlDepartment').append($('<option></option>').val(0).html(langData.ddl_select));
                        $.each(dd[2], function(index, Item) {
                            $('#ddlDepartment').append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');
                        });

                    }
                        if (dd[5].length > 0) {
                            $('#ddlVendor').append($('<option></option>').val(0).html(langData.ddl_select));
                            $.each(dd[5], function(index, Item) {
                            $('#ddlVendor').append('<option value="' + Item.VendorID + '">' + Item.VendorName + '</option>');
                            });

                      
              
                    }


                },
                error: function(result) {
                    alert(langData.alaer_wentwrong);
                }

            });
            return dd;
        }

        function SaveEQAMaster()
        {
     
       
        var Vendorid;
        var cycleidentification;
        var dateofprocessing;
        var interpretation;
        var hasfile;
        var filetype;
        var filepath;
  var depId=0;
        var EQAMaster = [];
        
        Vendorid= $('#ddlVendor option:selected').val();
         depId= $('#ddlDepartment option:selected').val();
        cycleidentification=$('#TxtCycle').val();
        dateofprocessing=$('#txtDate').val();
        interpretation=$('#TxtInterpretation').val();
        filetype=$('#ddlFileType option:selected').val();
        hasfile='a';
       filepath="B";
      


        EQAMaster.push({
                 
                  VendorID:Vendorid,
                  CycleIdentification:cycleidentification,
                  DateOfProcessing:dateofprocessing,
                  Interpretation:interpretation,
                  FileType:filetype,
                   HasFile:hasfile,
                 FilePath:filepath,
                 DeptID:depId
                });
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/SaveEQAMaster",
                    data: JSON.stringify({SaveEQAMaster: EQAMaster}),
                    dataType: "json",
                    async: false,
                    success: function(data) {   
                        var returncode;
                        returncode = data.d;
                        if (returncode > 0) {
//////                           alert('Saved sucessfully');
                           //Clear();
                        }
                        else {

                            alert(langData.alert_wentwrong);
                            Clear();
                        }
                        
                    },
                    error: function(xhr, status, error) {
                        alert(error);
                        
                    }

                });
                  
                
            }
            var Gtable;
function Pagevalidation()
{

//if($('#txtResultValue').val()=="" && $('#txtScore').val()=="" && $('#txtStatus').val()=="" 
//&& $('#txtRootCause').val()=="" && $('#txtCorrectiveActions').val()=="" && $('#txtPreventiveActions').val()=="")
// alert('None of the Values are capture for External Quality Value');
// return false;
}
            function Clear() {
                $('#TxtCycle').val("");
                $('#txtDate').val("");
                $('#TxtInterpretation').val("");
                $('#ddlVendor').val($("#ddlVendor option:first").val());
                $('#ddlFileType').val($("#ddlFileType option:first").val());
                $('#ddlDepartment').val($("#ddlDepartment option:first").val());
                $('.table-responsive').hide();
                $('#txtfileupload_wrap_list').html('');
                DelFiles = [];
                $("#txtfileupload").Attune_RemoveFiles();
            }

            function LoadDeptInvestigations() {
                if ($('#ddlDepartment option:selected').val() == "0") {
                    alert(langData.alert_departmentselect);
                    return false;
                }
                if ($('#ddlVendor option:selected').val() == "0") {
                    alert(langData.alert_vendorselect);
                    return false;
                }
                if ($('#txtDate').val() == "") {
                    alert(langData.alert_processingdate);
                    return false;
                }
                $('#txtfileupload_wrap_list').html('');
                DelFiles = [];
                $("#txtfileupload").Attune_RemoveFiles();
                    var dd;
                    var obj = $('#ddlDepartment option:selected').val();
                    var venID = $('#ddlVendor option:selected').val();
                    var PDate = dateformat($('#txtDate').val(),'YYYY/MM/DD');
                    var Type = "IN";
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "../QMS.asmx/LoadDepartmentInvestigation",
                        data: JSON.stringify({ DeptID: obj, Type: Type, VendorID: venID, PDate: PDate }),
                        async: false,
                        dataType: "json",
                        success: function(data) {
                            var Items = data.d[0];
                            $('#btnAdd').show();
                            var dtDayWCR = Items;
                            if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                                var parseJSONResult = JSON.parse(dtDayWCR);

                                Gtable = $('#TblTaskDetails').dataTable({
                                    paging: true,
                                     "language": {
                                 "url": dataTablePath
                                  },
                                    data: parseJSONResult,
                                    "bDestroy": true,
                                    "searchable": true,
                                    "sort": true,
                                    "fnDrawCallback": function() {
                                        $(".EditCss").click(function() {

                                            var row = $(this).closest('tr');
                                            row.find('input[type="text"]').removeAttr("disabled");
                                            row.find('select').removeAttr("disabled");
                                            $('#btnAdd').val(langData.Update);
                                        });

                                        debugger;
                                        $(".textsize").keyup(function() {
                                            var tdata = '';
                                            var row = $(this).closest('tr');
                                            var InputControls = row.find('input[type="text"]');
                                            var SelectControls = row.find('select');
                                            $.each(InputControls, function(key, value) {
                                                tdata = tdata + $(value).val() + '~';
                                            });
                                            $.each(SelectControls, function(key, value) {
                                                tdata = tdata + $(value).val() + '~';
                                                //                                                alert($(value).val());
                                            });
                                            $(InputControls[0]).attr("data", tdata);
                                            $(InputControls[0]).attr("isupdated", 'Y');
                                        });

                                        $('input[Calc="InternalValue"]').on('keyup', function() {
                                            var calVal;
                                            var row = $(this).parent('tr');
                                            var internalvalue = $(this).val();

                                            var exval = $(this).parents('tr').find('input[Calc="ExternalResult"]').val();

                                            if (parseFloat(internalvalue) <= 0 || internalvalue.length <= 0) {
                                                internalvalue = 0;
                                            }
                                            if (parseFloat(exval) <= 0 || exval.length <= 0) {
                                                exval = 0;
                                            }

                                            if (internalvalue > 0 && exval > 0) {
                                                calVal = (parseFloat(internalvalue) - parseFloat(exval));
                                                calVal = parseFloat(calVal) / parseFloat(exval);
                                                calVal = parseFloat(parseFloat(calVal) * 100);
                                                $(this).parents('tr').find('input[Calc="Variation"]').val(calVal.toFixed(2));
                                            } else {
                                            $(this).parents('tr').find('input[Calc="Variation"]').val(0);
                                            }

                                        });
                                        $('input[Calc="ExternalResult"]').on('keyup', function() {


                                        var calVal1;
                                        var row1 = $(this).parent('tr');
                                        var exval1 = $(this).val();

                                        var internalvalue1 = $(this).parents('tr').find('input[Calc="InternalValue"]').val();

                                        if (parseFloat(internalvalue1) <= 0 || internalvalue1.length <= 0) {
                                            internalvalue = 0;
                                        }
                                        if (parseFloat(exval1) <= 0 || exval1.length <= 0) {
                                            exval1 = 0;
                                        }

                                        if (internalvalue1 > 0 && exval1 > 0) {
                                            calVal1 = (parseFloat(internalvalue1) - parseFloat(exval1));
                                            calVal1 = parseFloat(calVal1) / parseFloat(exval1);
                                            calVal1 = parseFloat(calVal1) * 100;
                                            $(this).parents('tr').find('input[Calc="Variation"]').val(calVal1.toFixed(2));
                                        } else {
                                            $(this).parents('tr').find('input[Calc="Variation"]').val(0);
                                        }


                                        });
                                        $(".SelectSize").change(function() {
                                            var tdata = '';
                                            var row = $(this).closest('tr');
                                            var InputControls = row.find('input[type="text"]');
                                            var SelectControls = row.find('select');
                                            $.each(InputControls, function(key, value) {
                                                tdata = tdata + $(value).val() + '~';
                                            });
                                            $.each(SelectControls, function(key, value) {
                                                tdata = tdata + $(value).val() + '~';
                                                //                                                alert($(value).val());
                                            });
                                            $(InputControls[0]).attr("data", tdata);
                                            $(InputControls[0]).attr("isupdated", 'Y');
                                        });

                                        $(".Deci").keypress(function(event) {
                                            if ((event.which != 46) && (event.which < 48 || event.which > 57)) {
                                                event.preventDefault();
                                            }
                                            else if (($(this).val() == "" && event.which == 46) || ($(this).val().indexOf('.') != -1 && event.which == 46)) {
                                                event.preventDefault();
                                            }
                                        });

                                    },

                                    columns: [

                                               { "defaultContent": obj, "sClass": "hide_Column",
                                                   "mRender": function(data, type, full, meta) {
                                                       return '<input id= "txtInvestigationID" type="text" box="value" class="textsize" data="" IsUpdated="' + full.IsUpdated + '" value="' + full.InvestigationID + '" disabled="disabled">';
                                                   }
                                               },

                                               { 'data': 'SNo' }, { 'data': 'AnalyteName' },

                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {

                                                       if (full.InternalResultValue != "") {
                                                           return '<input id= "txtInternalResultValue"  Calc="InternalValue" type="text" Val-Key="EQAResultValue"  box="value" class="textsize" value="' + full.InternalResultValue + '" disabled="disabled">';
                                                       }
                                                       else {
                                                           return '<input id= "txtInternalResultValue" Calc="InternalValue" type="text" Val-Key="EQAResultValue" box="value" class="textsize" value="' + full.InternalResultValue + '" >';
                                                       }
                                                   }
                                               },
                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {
                                                       if (full.ExternalResultValue != "") {
                                                           return '<input id= "txtExternalResultValue" Calc="ExternalResult" type="text" box="value" Val-Key="EQAResultValue" class="textsize" value="' + full.ExternalResultValue + '" disabled="disabled">';
                                                       }
                                                       else {
                                                           return '<input id= "txtExternalResultValue" Calc="ExternalResult" type="text" box="value" Val-Key="EQAResultValue" class="textsize" value="' + full.ExternalResultValue + '">';
                                                       }
                                                  }
                                               },
                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {
                                                       if (full.Deviation == 0) {

                                                           return '<input id= "txtDeviation" Calc="Variation" type="text" box="value" Val-Key="Deviation" class="textsize Deci" value="' + "" + '">';
                                                       }
                                                       else {
                                                           return '<input id= "txtDeviation" Calc="Variation" type="text" box="value" Val-Key="Deviation" class="textsize Deci" value="' + full.Deviation + '" disabled="disabled">';
                                                       }

                                                   }
                                               },
                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {
                                                   if (full.Status == "Pass" || full.Status == "") {

                                                           if (full.Status == "") {
                                                               return '<select class="SelectSize " >  <option value="Pass" selected>' + langData.Pass + '</option>  <option value="Fail">' + langData.Fail + '</option> </select>';
                                                           }
                                                           else {
                                                               return '<select class="SelectSize " disabled="disabled">  <option value="Pass" selected>' + langData.Pass + '</option>  <option value="Fail">' + langData.Fail + '</option> </select>';
                                                           }
                                                       }
                                                       else {
                                                           return '<select class="SelectSize " disabled="disabled">  <option value="Pass">' + langData.Pass + '</option>  <option value="Fail" selected>' + langData.Fail + '</option> </select>';
                                                       }
                                                   }
                                               },
                                                { "defaultContent": obj,
                                                    "mRender": function(data, type, full, meta) {
                                                        if (full.RootCause != "") {
                                                            return '<input id= "txtRootCause" type="text" box="value" Val-Key="Description-NoSC" class="textsize" value="' + full.RootCause + '" disabled="disabled">';

                                                        }
                                                        else {
                                                            return '<input id= "txtRootCause" type="text" box="value" Val-Key="Description-NoSC" class="textsize" value="' + full.RootCause + '">';
                                                        }
                                                    }
                                                },
                                                { "defaultContent": obj,
                                                    "mRender": function(data, type, full, meta) {
                                                        if (full.Correction == 0) {
                                                            return '<input id= "txtCorrection" type="text" box="value" Val-Key="Correction" class="textsize" value="' + "" + '" >';
                                                        }
                                                        else {
                                                            return '<input id= "txtCorrection" type="text" box="value" Val-Key="Correction" class="textsize" value="' + full.Correction + '" disabled="disabled">';
                                                        }
                                                    }
                                                },
                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {
                                                       if (full.CorrectiveActions != "") {
                                                           return '<input id= "txtCorrectiveActions" type="text" box="value" Val-Key="Description-NoSC" class="textsize" value="' + full.CorrectiveActions + '" disabled="disabled">';
                                                       }
                                                       else {
                                                           return '<input id= "txtCorrectiveActions" type="text" box="value" Val-Key="Description-NoSC"  class="textsize" value="' + full.CorrectiveActions + '">';
                                                       }
                                                   }
                                               },
                                               { "defaultContent": obj,
                                                   "mRender": function(data, type, full, meta) {
                                                       if (full.PreventiveActions != "") {
                                                           return '<input id= "txtPreventiveActions" type="text" box="value" Val-Key="Description-NoSC" class="textsize" value="' + full.PreventiveActions + '" disabled="disabled">';
                                                       }
                                                       else {
                                                           return '<input id= "txtPreventiveActions" type="text" box="value" Val-Key="Description-NoSC" class="textsize" value="' + full.PreventiveActions + '">';
                                                       }
                                                   }
                                               },

                                               // { 'data': 'Edit' }, { 'data': 'Delete'}
                                                           {
                                                       'data': 'Edit',
                                                       "mRender": function(data, type, full, meta) {
                                                       return '<input value = "'+langData.Edit+'" class="deleteIcons EditCss" type="button"  style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                       }
                                                   },
                                                    {
                                                        'data': 'Delete',
                                                        "mRender": function(data, type, full, meta) {
                                                        
                                                        return '<input value = "'+langData.Delete+'" class="deleteIcons" type="button" '+ full.Delete+' />';
                                                        }
                                                    }
                                               
                                               ]
                                            });
                                $('.table-responsive').find('input[Val-Key]').maxLength();
                                $('.table-responsive').show();


                            }
                            else {
                                
                                $('.table-responsive').hide();
                                alert(langData.record_notfound);

                            }
                            if (data.d[1] != '' && data.d[1] != null) {
                                populateOnEdit(data.d[1]);
                            }

                        },
                        error: function(jqXHR, textStatus, errorThrown) {

                        }
                    });

                }
                function Delete_OnClick(ValId) {
                    var ret = confirm("Are you sure to delete the values ?");
                if (ret == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../QMS.asmx/DeleteInternalExternalQualityValue",
                        data: JSON.stringify({ ValId: ValId }),
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            LoadDeptInvestigations();
                            alert(langData.alert_delete);
                        },
                        error: function(xhr, status, error) {
                            alert(error);
                        }
                    });
                }
                else {
                    return false;
                }
                }
                $("#txtDate").datepicker({
                    dateFormat: 'dd/mm/yy',
                    //defaultDate: "d",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {


                    var date = $("#txtDate").datepicker('getDate');

                    }

                });
                $("#btnAdd").click(function() {
                    if (($('#<%=txtfileupload.ClientID%>').val().length > 0) && ($('#ddlFileType option:selected').val() == 0)) {
                        alert("Since you have selected some file(s), You have to select the file type too..");
                        return false;
                    }
                    var headers = [];
                    var array = [];
                    headers[0] = 'InvestigationID'
                    headers[1] = 'AnalyteName'
                    headers[2] = 'ResultValue'
                    headers[3] = 'InternalResultValue';
                    headers[4] = 'ExternalResultValue';
                    headers[5] = 'Score';
                    headers[6] = 'Status';
                    headers[7] = 'RootCause';
                    headers[8] = 'Correction';
                    headers[9] = 'CorrectiveActions';
                    headers[10] = 'PreventiveActions';
                    headers[11] = 'Deviation';
                    headers[12] = 'EQMID';
                    headers[12] = 'ID';

                    $(Gtable.fnGetNodes()).has('td').each(function() {
                        $('td', $(this)).each(function(index, item) {
                            if (index == 0) {
                                var arrayItem = {};
                                var IsUpdated = $(item).find('input').attr('IsUpdated');
                                if (IsUpdated == 'Y') {
                                    var items = ($(item).find('input').attr('data')).split('~');
                                    arrayItem[headers[0]] = items[0];
                                    arrayItem[headers[1]] = '';
                                    arrayItem[headers[2]] = '';
                                    arrayItem[headers[3]] = items[1];
                                    arrayItem[headers[4]] = items[2];
                                    arrayItem[headers[5]] = '';
                                    arrayItem[headers[6]] = items[8];
                                    arrayItem[headers[7]] = items[4];
                                    arrayItem[headers[8]] = parseFloat(items[5]) || 0;
                                    arrayItem[headers[9]] = items[6];
                                    arrayItem[headers[10]] = items[7];
                                    arrayItem[headers[11]] = parseFloat(items[3]) || 0;
                                    arrayItem[headers[12]] = 0;
                                    arrayItem[headers[13]] = 0;
                                    array.push(arrayItem);
                                }
                            }
                        });
                    });
                    //                    if (array.length <= 0) {
                    //                        alert("No changes has done in the master, Could not update.");
                    //                        false;
                    //                    }

                    var Vendorid;
                    var cycleidentification;
                    var dateofprocessing;
                    var interpretation;
                    var hasfile;
                    var filetype;
                    var FileName;
                    var FilePath;
                    var files;
                    var resultType;
                    var depId = 0;
                    Vendorid = $("#ddlVendor").find("option:selected").val();
                    cycleidentification = "";
                    depId = $('#ddlDepartment option:selected').val();
                    dateofprocessing = $('#txtDate').val();
                    interpretation = "";
                    filetype = $("#ddlFileType").find("option:selected").val();
                    resultType = $("#ddlResultType").find("option:selected").val();
                    var Frmiles = $("#txtfileupload").Attune_GetFiles();
                    if (Frmiles.length > 0) {
                        hasfile = "Y";
                    }
                    else {
                        hasfile = "N"
                        FilePath = "";
                        resultType = "N";
                    }
                    filetype = "IN";
                    var EQAMaster = [];
                    EQAMaster.push({
                        VendorID: Vendorid,
                        CycleIdentification: cycleidentification,
                        DateOfProcessing: dateofprocessing,
                        Interpretation: interpretation,
                        FileType: filetype,
                        HasFile: hasfile,
                        FilePath: FilePath,
                        ResultType: resultType,
                        DeptID: depId
                    });


                    // if (array.length > 0) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "../QMS.asmx/QMS_SaveInternalExternalQualityValues",
                        data: JSON.stringify({ InternalExternalQuality: array, SaveEQAMaster: EQAMaster }),
                        dataType: "JSON",
                        async: false,
                        success: function(data) {
                            var returncode;
                            returncode = data.d[0];
                            if (returncode != 1001) {
                                if (data.d[1] != -1) {
                                    FilesAddDelete(DelFiles, data.d[1], 'ILC');
                                }
                                alert(langData.alert_save);
                                LoadDeptInvestigations();
                                $('#btnAdd').val(langData.save);

                            }
                            else {
                                alert(langData.alert_wentwrong);
                            }
                        },
                        error: function(xhr, status, error) {
                            alert(xhr);
                        }


                    });
                    //}
                    return false;
                });

                function populateOnEdit(aData) {
                    if (aData != null && aData != '') {
                        var path = $('#hdnFilepath').val();
                        var arr = aData.split(',');
                        for (var i = 0; i < arr.length; i++) {
                            var lst = arr[i].split('~');
                            var d = '<div id="' + lst[2] + '" class="MultiFile-label">\
                     <a class="MultiFileremove"  filename="' + lst[2] + '" fileid="' + lst[1] + '" filetype="' + lst[3] + '" href="#" innerPath="' + lst[0] + '" style="color:red;font-size:large;font-weight:900">x</a>\
                     <span href="' + path + lst[0] + '" class="MultiFile-title clickable" >' + lst[2] + '  -  ' + lst[3] + '</span>\
                     </div>';


                            $("#txtfileupload_wrap_list").append(d);
                        }

                        $('.MultiFileremove').click(function() {
                            var div = $(this).parent('div');
                            var id = $(div).attr('id')
                            var ke = $("#hdnFilepath").val() + '~' + 'AnalyzerMaster~' + $(this).attr('filetype') + '~' + $('#txtDeviceCode').val() + '~Y~' + $(this).attr('innerPath') + '~' + $(this).attr('fileid') + '~' + $(this).attr('filename');
                            DelFiles.push(ke);
                            $(div).remove();

                        });
                        //                $(".MultiFile-title").click(function() {
                        //                    var url = $(this).attr('href');
                        //                    $("[id$='btnTarget']").click();
                        //                    //var orgID = '<%= OrgID %>';
                        //                    $('[id$="ifPDF"]').show();
                        //                    // $('[id$="trPDF"]').show();   
                        //                    $("[id$='ifPDF']").attr('src', '<%=ResolveUrl("~/QMS/QChandler.ashx?PictureName=' + url + '")%>');
                        //                    // window.open(url);
                        //                });
                        $(".MultiFile-title").click(function() {
                            var url = $(this).attr('href');
                            $("#ifPDF").attr('src', '<%=ResolveUrl("~/QMS/QChandler.ashx?PictureName=' + url + '")%>');
                            $("#btnTarget").click();
                            //var orgID = '<%= OrgID %>';
                            $('#ifPDF').show();
                            // $('[id$="trPDF"]').show();   

                            // window.open(url);
                        });




                    }
                }
                
    </script>

    

</body>
</html>
