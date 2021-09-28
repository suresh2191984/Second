    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExternalQualityAssurance.aspx.cs" Inherits="ExternalQualityAssurance" EnableEventValidation="false" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
    <%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
    <!DOCTYPE html>
    <html>
    <head id="Head1" runat="server">
        <meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
        <title>External Quality Assurance Scheme </title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
            name='viewport'>    
        <!-- Bootstrap 3.3.4 -->
  

        
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- FontAwesome 4.3.0 -->
        <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons 2.0.0 -->
       
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

              <style type ="text/css">
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
            <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>--%>
         <ajc:ToolkitScriptManager ID="ScriptManager1" runat="server"></ajc:ToolkitScriptManager>
            <asp:UpdatePanel ID="test" runat="server" UpdateMode="Always" >
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
                         <h4 class="strong">External Quality Assurance Scheme</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDepartment" runat="server" Text="Department" localize="EQA_lblDepartment"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" onChange="javascript:ClearResultGrid();">
                                     
                                     </asp:DropDownList>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-1">
                            <div class="form-group">
                                <asp:Label ID="lblVendor" runat="server" Text="Vendor" localize="EQA_lblVendor"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                  <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control">
                                     
                                     </asp:DropDownList>
                            </div>
                    </div>
                    
                   
                   
                   
                    <div class="col-xs-6 col-sm-2 col-md-1">
                            <div class="form-group">
                                <asp:Label ID="lblDate" runat="server" Text="Date" localize="EQA_lblDate"></asp:Label>
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
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <input type="button" id="btnLoad" value="Load" class="btn btn-success"  onclick="LoadDeptInvestigations();" localize="EQA_btnLoad"/>
                            </div>
                    </div>
                    </div>
                    <div class="row">
                    <!--Row-->
                    
                     
                    <div class="col-xs-6 col-sm-2 col-md-2">
                          <div class="form-group">
                                <asp:Label ID="LblCycle" runat="server" Text="Cycle Identification" localize="EQA_LblCycle"></asp:Label>
                            </div>  
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                         <div class="form-group">
                              <asp:TextBox ID="TxtCycle" Class="form-control" runat="server" ></asp:TextBox>
                         </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-1">
                            <div class="form-group">
                                <asp:Label ID="lblInterpretaion" runat="server" Text="Interpretation" localize="EQA_lblInterpretaion"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                              <asp:TextBox ID="TxtInterpretation" Class="form-control" runat="server" ></asp:TextBox>
                         </div>
                    </div>
                    
                     
                    </div>
                    <div class="row">
                    <!--Row-->
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblFileupload" runat="server" Text="Fileupload" localize="EQA_lblFileupload"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group" style="overflow:hidden;">
                                <asp:FileUpload ID="txtfileupload" runat="server" accept=".pdf,image/*" meta:resourcekey="FileUpload1Resource1" />
                                     <div class="MultiFile-list" id="txtfileupload_wrap_list">
                                     </div> 
                         </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-1">
                            <div class="form-group">
                                <asp:Label ID="lblFileType" runat="server" Text="FileType" localize="EQA_lblFileType"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                  <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control">
                                <%--  <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>--%>
                                 <%-- <asp:ListItem Text="Internal" Value="IN"></asp:ListItem>--%>
                                    <asp:ListItem Text="External" Value="EX"></asp:ListItem>
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
                                  <asp:DropDownList ID="ddlResultType" runat="server" CssClass="form-control" disabled="disabled">
                                  <asp:ListItem Text="External" Value="EX"></asp:ListItem>
                                     </asp:DropDownList>
                            </div>
                    </div>
                     
                   
                    <!--Row-->
                   </div>
                 
                <!-- Row -->
                <div class="row">
                    <div class="form-group text-center">
                         <input type="button" id="btnClear"  class="btn btn-primary" value="Clear" onclick="Clear()" localize="EQA_btnClear"/>
                          <input type="button" id="btnAdd" class="btn btn-primary" value="Save" localize="EQA_btnAdd"/>
                       <%-- <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="AddFileMaster_click"    />--%>
                    </div>
                </div>
                
                
               </div>
          
                         <div class="gridTable bounceinup">
                                <div class="table-responsive" style="display:none;">
                                  <table class="table tbl-grid table-bordered form-inline table-striped" id="TblTaskDetails" >
                                      <thead>
                                            <tr>
                                                <th class="hide_Column">InvestigationID</th>
                                                <th localize="SNo">SNO</th>
                                                <th localize="EQA_AnalyteName">Analyte Name</th>
                                                <th localize="EQA_ResultValue">Result Value</th>
                                                <th localize="EQA_Score">Score/Z-Score</th>
                                                <th localize="Status"">Status</th>
                                                <th localize="EQA_RootCause">Root Cause</th>
                                                <th localize="EQA_CorrectiveActions">Corrective Actions</th>
                                                <th localize="EQA_PreventiveActions">Preventive Actions</th>
                                               <th localize="EQA_btnEdit">Edit</th>
                                               <th localize="Delete">Delete</th>
                                            </tr>
                                      </thead>
                                      <tbody>
                      
                                        </tbody>
                                  </table>
                               </div>
                            
                              
                              <asp:HiddenField ID="hdnFilepath" runat="server" />
                              <asp:HiddenField ID="hdnRootPath" runat="server" />
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
      <%--<asp:PostBackTrigger ControlID="BtnAdd" />   --%> 
    <%--   <asp:PostBackTrigger ControlID="BtnLoad" />--%>
       
      <%--<asp:AsyncPostBackTrigger ControlID="BtnAdd" />--%>
             <%-- <asp:PostBackTrigger ControlID="btnUpload" />--%>
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
                                                <%--    <tr>
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
            </form>
            
        </div>
        <!-- ./wrapper -->
        <!-- jQuery 2.1.4 -->
        <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
        <!-- jQuery UI 1.11.2 -->
        <script src="Script/jquery-ui.min.js" type="text/javascript"></script>
        <!-- Bootstrap 3.3.2 JS -->
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

        <script src="Script/ControlLength.js" type="text/javascript"></script>
        <!-- bootstrap datepicker --><%--
        <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>
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
        <!-- AdminLTE for demo purposes -->
            <%--<script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>
        <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
        <script src="dist/js/demo.js" type="text/javascript"></script>
        <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>
        
        <script src="Resource/local_resorce.js" type="text/javascript"></script>

        <script src="Script/QC_Common.js" type="text/javascript"></script>
        <script src="Script/moment.js" type="text/javascript"></script>
        <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>
        <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
        <script type="text/javascript">
        var DelFiles = [];
   
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

             function Onlyfloatandnumers(e) {
                 var regex = new RegExp("^[0-9.-]+$");
                 var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
                 if (regex.test(str)) {
                     return true;
                 }

                 e.preventDefault();
                 return false;
             }

             function SpecialCharRestriction(e) {
                 var regex = new RegExp("^[a-zA-Z0-9. -]+$");
                 var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
                 if (regex.test(str)) {
                     return true;
                 }

                 e.preventDefault();
                 return false;
             }

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
                            $('#ddlDepartment').append($('<option></option>').val(0).html('-- Select --'));
                            $.each(dd[2], function(index, Item) {
                                $('#ddlDepartment').append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');
                            });
                        }
                            if (dd[5].length > 0) {
                                $('#ddlVendor').append($('<option></option>').val(0).html('-- Select --'));
                                $.each(dd[5], function(index, Item) {
                                $('#ddlVendor').append('<option value="' + Item.VendorID + '">' + Item.VendorName + '</option>');
                                });
                          
                  
                        }
                    },
                    error: function(result) {
                        alert("Error");
                    }
                });
                return dd;
            }

              
         
    function DepartmentValidation()
    {
    if(  $('#ddlDepartment option:selected').val()==0)
    {
    alert("Select Department")
    return false;
    }
    else if($('#ddlVendor option:selected').val()==0)
    {
     alert("Select Vendor")
    return false;
    }
     else if($('#txtDate').val()== "")
    {
    alert("Provide Date of Processing");
    return false;
    }
        else if(($('#<%=txtfileupload.ClientID%>').val().length > 0) && ($('#ddlFileType option:selected').val()==0))   
        {
            alert("Since you have selected some file(s), You have to select the file type too..");
            return false;
        }          
    else
    {
    return true;
    }
    }

function ClearResultGrid() 
{
    $('.table-responsive').hide();


}
    
    function Clear() {
                    $('#TxtCycle').val("");
                    $('#txtDate').val("");
                    $('#TxtInterpretation').val("");
                    $('#ddlVendor').val($("#ddlVendor option:first").val());
                    $('#ddlFileType').val($("#ddlFileType option:first").val());
                    $('#ddlDepartment').val($("#ddlDepartment option:first").val());
                    $('#txtfileupload').val("");
                    $('.table-responsive').hide();
                    $('#txtfileupload_wrap_list').html('');
                     DelFiles = [];
                      $("#txtfileupload").Attune_RemoveFiles();
                      $('#btnAdd').val(langData.EQA_btnAdd);
                }

    var Gtable;
    function LoadDeptInvestigations() {
 
     $('#btnAdd').val('Save');
                   if ($('#ddlDepartment option:selected').val() == "0") {
                       alert(langData.alert_departmentselect);
                    return false;
                }
                if ($('#ddlVendor option:selected').val() == "0") {
                    alert(langData.alert_vendorselect);
                    return false;
                }
                if ($('#txtDate').val() == "") {
                    alert(langDta.alert_processingdate);
                    return false;
                }
                    $('#txtfileupload_wrap_list').html('');
                     DelFiles = [];
                      $("#txtfileupload").Attune_RemoveFiles();
                      
                        var dd;
                        var obj = $('#ddlDepartment option:selected').val();
                        var Type = $('#ddlFileType option:selected').val();
                        Type='EX';
                        var VendorId=$('#ddlVendor option:selected').val();
                        var processingdate=dateformat($('#txtDate').val(),"YYYY/MM/DD");
                        $.ajax({
                            type: "POST",
                            contentType: "application/json;charset=utf-8",
                            url: "../QMS.asmx/LoadDepartmentInvestigation",
                            data: JSON.stringify({ DeptID: obj, Type: Type, VendorID: VendorId, PDate: processingdate }),
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
                                                            if (full.InvestigationID != "") {
                                                                return '<input id= "txtInvestigationID" type="text" box="value" class="textsize" data="" IsUpdated="' + full.IsUpdated + '" value="' + full.InvestigationID + '" disabled="disabled">';
                                                            }
                                                            else {
                                                                return '<input id= "txtInvestigationID" type="text" box="value" class="textsize" data="" IsUpdated="' + full.IsUpdated + '" value="' + full.InvestigationID + '" >';
                                                            }
                                                        }
                                                    },
                                                   { 'data': 'SNo' }, { 'data': 'AnalyteName' },
											       {
											           //'data': 'ResultValue'
											           "defaultContent": obj,
											           "mRender": function(data, type, full, meta) {
											               if (full.ResultValue != "") {
											                   return '<input id= "txtResultValue" type="text" box="value" class="textsize" Val-Key="EQAResultValue"  value="' + full.ResultValue + '" disabled="disabled">';
											               }
											               else {
											                   return '<input id= "txtResultValue" type="text" box="value" class="textsize" Val-Key="EQAResultValue" value="' + full.ResultValue + '">';
											               }
											           }
											       },
                                                   {
                                                       //'data': 'Score',
                                                       "defaultContent": obj,
                                                       "mRender": function(data, type, full, meta) {
                                                           if (full.Score != "") {
                                                               return '<input id= "txtScore" type="text" box="value" Val-Key="Zscore" class="textsize" value="' + full.Score + '" disabled="disabled">';
                                                           }
                                                           else {
                                                               return '<input id= "txtScore" type="text" box="value" Val-Key="Zscore" class="textsize" value="' + full.Score + '" >';
                                                           }
                                                       }
                                                   },
                                                  { "defaultContent": obj,
                                                      "mRender": function(data, type, full, meta) {
                                                          if (full.Status == null || full.Status == '') {
                                                              return '<select class="SelectSize " >  <option value="Pass" selected>Pass</option>  <option value="Fail">Fail</option> </select>';

                                                          }
                                                          else {
                                                              if (full.Status == "Pass") {
                                                                  return '<select class="SelectSize " disabled="disabled">  <option value="Pass" selected>Pass</option>  <option value="Fail">Fail</option> </select>';
                                                              }
                                                              else if (full.Status == "Fail") {
                                                                  return '<select class="SelectSize " disabled="disabled">  <option value="Pass">Pass</option>  <option value="" selected>Fail</option> </select>';
                                                              }
                                                          }
                                                      }
                                                  },
                                                    {
                                                        // 'data': 'RootCause',
                                                        "defaultContent": obj,
                                                        "mRender": function(data, type, full, meta) {
                                                            if (full.RootCause != "") {

                                                                return '<input id= "txtRootCause" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.RootCause + '" disabled="disabled">';
                                                            }
                                                            else {
                                                                return '<input id= "txtRootCause" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.RootCause + '" >';
                                                            }
                                                        }
                                                    },
                                                   {
                                                       //'data': 'CorrectiveActions'
                                                       "defaultContent": obj,
                                                       "mRender": function(data, type, full, meta) {
                                                           if (full.CorrectiveActions != "") {
                                                               return '<input id= "txtCorrectiveActions" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.CorrectiveActions + '" disabled="disabled">';
                                                           }
                                                           else {
                                                               return '<input id= "txtCorrectiveActions" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.CorrectiveActions + '">';
                                                           }
                                                       }
                                                   },
                                                   {
                                                       // 'data': 'PreventiveActions',
                                                       "defaultContent": obj,
                                                       "mRender": function(data, type, full, meta) {
                                                           if (full.PreventiveActions != "") {
                                                               return '<input id= "txtPreventiveActions" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.PreventiveActions + '" disabled="disabled">';
                                                           }
                                                           else {
                                                               return '<input id= "txtPreventiveActions" type="text" box="value" class="textsize" Val-Key="Description-NoSC" value="' + full.PreventiveActions + '" >';
                                                           }
                                                       }
                                                   },
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
                                    $('#btnAdd').hide();
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
                         var ret = confirm(langData.delete_confirm);
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
                     
        $("#btnAdd").click(function() {
        if(DepartmentValidation()== false){
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
        headers[13] = 'ID';

                        $(Gtable.fnGetNodes()).has('td').each(function() {
                            $('td', $(this)).each(function(index, item) {
                                if (index == 0) {
                                    var arrayItem = {};
                                    var IsUpdated = $(item).find('input').attr('IsUpdated');
                                    if (IsUpdated == 'Y') {
                                        var items = ($(item).find('input').attr('data')).split('~');
                                        arrayItem[headers[0]] = items[0];
                                        arrayItem[headers[1]] = "";
                                        arrayItem[headers[2]] = items[1];
                                        arrayItem[headers[3]] = "";
                                        arrayItem[headers[4]] = "";
                                        arrayItem[headers[5]] = items[2];
                                        arrayItem[headers[6]] = items[6];
                                        arrayItem[headers[7]] = items[3];
                                        arrayItem[headers[8]] = 0;
                                        arrayItem[headers[9]] = items[4];
                                        arrayItem[headers[10]] = items[5];
                                        arrayItem[headers[11]] = 0;
                                        arrayItem[headers[12]] = 0;
                                        arrayItem[headers[13]] = 0;
                                        array.push(arrayItem);
                                    }
                                }
                            });
                        });
       // if(array.length<=0)
        //{
          //  alert("No changes has done in the master, Could not update.");
            //false;
        //}
        var Vendorid;
        var cycleidentification;
        var dateofprocessing;
        var interpretation;
        var hasfile;
        var filetype;
        var FileName="";
        var FilePath="";
        var files;
        var resultType;
        var DeptId;
        Vendorid= $("#ddlVendor").find("option:selected").val()
        cycleidentification=$('#TxtCycle').val();
        dateofprocessing=$('#txtDate').val();
        interpretation=$('#TxtInterpretation').val();
        filetype= $("#ddlFileType").find("option:selected").val();
        resultType=$("#ddlResultType").find("option:selected").val();
        DeptId = $("#ddlDepartment").find("option:selected").val();
        var Frmiles = $("#txtfileupload").Attune_GetFiles();
        if(Frmiles.length>0)
        {
            hasfile="Y";     
        }
        else
        {
            hasfile="N"
            FilePath="";
            resultType="N";
        }                        
          var EQAMaster = [];
          EQAMaster.push({
          VendorID:Vendorid,
          CycleIdentification:cycleidentification,
          DateOfProcessing:dateofprocessing,
          Interpretation:interpretation,
          FileType:filetype,
          HasFile:hasfile,
          FilePath:FilePath,
          ResultType: resultType,
          DeptID:DeptId
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
                                returncode=data.d[0];
                      if ( returncode != 1001) {
                      if(data.d[1] !=-1)
                         {
                         FilesAddDelete(DelFiles, data.d[1], 'EQA');
                         }
                               $('#btnAdd').val(langData.save);
                    LoadDeptInvestigations();
                            alert(langData.alert_save);
                      
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
