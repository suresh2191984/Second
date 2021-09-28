<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalyzerMaster.aspx.cs" Inherits="QMS_MasterTemplate"
  EnableEventValidation="false"   %>

<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Analyzer Master</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>


   
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
     <link href="Script/tooltip.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
 <link href="Script/jquery-ui-git.css" rel="Stylesheet" type="text/css" />
<%-- <link href="http://code.jquery.com/ui/jquery-ui-git.css" rel="Stylesheet" type="text/css" />--%>


    <style type="text/css">
        .hide_column 
        {
            display: none;
        }
		.required 
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        } 
        .dropdown-menu
         {
            max-height: 300px;
            overflow-y:auto;
            overflow-x:hidden;
            
         }
    </style>
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
                <div class="content-wrapper" id="contentid">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content" style="overflow-y: auto;">
          <div class="fadeindown" id="maincontent">
              <div class="row">
                    <div class="col-md-12">
                                <h4 class="strong">Analyzer Master</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="lblDeviceName" runat="server" Text="Device Name" autocomplete="off" localize="AnalyzerMaster_lblDeviceName"></asp:Label>
                            <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtDeviceName" Val-Key="AnalyzerName" runat="server" CssClass="form-control" ></asp:TextBox>
                                
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDeviceCode" runat="server" Text="Device Code" localize="AnalyzerMaster_lblDeviceCode"></asp:Label>
                                 
                                 <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtDeviceCode" Val-Key="ProductCode" runat="server" CssClass="form-control"  onkeyup="LimitTextValidation(this.form.txtDeviceCode,9);" onkeypress="return SpecialCharRestriction(event);"></asp:TextBox>
                                                      <span class="input-group-btn">
              <button text="Given device code already exists" error="I"  class="tool form-control btn-success" type="button" id="Check_DeviceID"><i class="fa fa-question"></i></button>
           </span> 
                            </div>
                            
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblModel" runat="server" Text="Model" localize="AnalyzerMaster_lblModel"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:TextBox ID="txtModel" Val-Key="AnalyzerModel" runat="server" CssClass="form-control" ></asp:TextBox>
                            </div>
                    </div>
                    </div>
                    <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                              <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" localize="AnalyzerMaster_lblManufacturer"></asp:Label>
                              <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            
                                 <asp:DropDownList ID="ddlManufacturer" runat="server" CssClass="form-control">
                                  
                                 </asp:DropDownList>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblMethod" runat="server" Text="Method" localize="AnalyzerMaster_lblMethod"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control">
                                     <%--<asp:ListItem Text="---select---"></asp:ListItem> --%>
                                 </asp:DropDownList>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblPrinciple" runat="server" Text="Principle" localize="AnalyzerMaster_lblPrinciple"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <asp:DropDownList ID="ddlPrinciple" runat="server" CssClass="form-control">
                                     <%--<asp:ListItem Text="---select---"></asp:ListItem>--%>
                                 </asp:DropDownList>
                            </div>
                    </div>
                    </div>
                    <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDepartment" runat="server" Text="Department" localize="AnalyzerMaster_lblDepartment"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <asp:DropDownList ID="ddlDepartment" runat="server"  CssClass="chosen-select form-control" multiple="multiple" style="width:50%">
                             
                                 </asp:DropDownList>
                            </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                               <asp:Label ID="lblInstallDate" runat="server" Text="Installation Date" localize="AnalyzerMaster_lblInstallDate"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                           <div class="input-group date">
                              <asp:TextBox ID="TextBox1" runat="server" readonly="true" CssClass="form-control"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                         </div>
                    </div>
                    
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDoneDate" runat="server" Text="Calibration Done Date" localize="AnalyzerMaster_lblDoneDate"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                           <div class="input-group date">
                              <asp:TextBox ID="txtDoneDate" runat="server" readonly="true" CssClass="form-control"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                         </div>
                    </div>
                    
                    <!--Row-->
                   </div>
                    <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDueDate" runat="server" Text="Calibration Due Date" localize="AnalyzerMaster_lblDueDate"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                           <div class="input-group date">
                               <asp:TextBox ID="txtDueDate" runat="server" readonly="true" CssClass="form-control"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                         </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblmaintDoneDate" runat="server" Text="Maintenance Done Date" localize="AnalyzerMaster_lblmaintDoneDate"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                           <div class="input-group date">
                              <asp:TextBox ID="txtmaintDoneDate" runat="server" readonly="true" CssClass="form-control"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblmaintDueDate" runat="server" Text="Maintenance Due Date" localize="AnalyzerMaster_lblmaintDueDate"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                           <div class="input-group date">
                              <asp:TextBox ID="txtmaintDueDate" runat="server" CssClass="form-control"></asp:TextBox>
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        </div>
                    </div>
                    
                    <!--Row-->
                    </div>
                    <div class="row">
                        <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblProcessingMode" runat="server" Text="Processing Mode" localize="AnalyzerMaster_lblProcessingMode"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                               <div class="form-group">
                                    <asp:DropDownList ID="ddlProcessingMode" runat="server" CssClass="form-control">
                                     <%--<asp:ListItem Text="Random" Value=0></asp:ListItem>
                                     <asp:ListItem Text="Batch" Value=1></asp:ListItem>--%>
                                 </asp:DropDownList>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblThroughPut" runat="server" Text="Through Put" localize="AnalyzerMaster_lblThroughPut"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                               <div class="form-group">
                                    <asp:TextBox ID="txtThroughPut" Val-Key="AnalyzerThroughPut" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblInterface" runat="server" Text="Interface" localize="AnalyzerMaster_lblInterface"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                              <div class="form-group">
                                    <asp:DropDownList ID="ddlInterface" runat="server" CssClass="form-control">
                                    
                                 </asp:DropDownList>
                                </div>
                        </div>
                </div>
                <!-- Row -->
                <div class="row">
                     
                        
                         <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lbllocation" runat="server" Text="Select Location" localize="AnalyzerMaster_lbllocation"></asp:Label>
                                      <span class="required">*</span>
                                </div>
                        </div>
               <div class="col-xs-6 col-sm-3 col-md-2">
               <div class="form-group">
               <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control">
                      </asp:DropDownList>
                     
               </div>
               </div>
                         <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblFileUpload" runat="server" Text="File Upload" localize="AnalyzerMaster_lblFileUpload"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                               <div class="form-group" style="overflow:hidden;">
                                     <asp:FileUpload ID="txtfileupload" runat="server" accept=".pdf,image/*"    meta:resourcekey="FileUpload1Resource1" />
                                     <div class="MultiFile-list" id="txtfileupload_wrap_list">
                                     </div> 
                                     
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblSelectFileTpye" runat="server" Text="Select File Type" localize="AnalyzerMaster_lblSelectFileTpye"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                              <div class="form-group">
                                    <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control">
                                     <asp:ListItem value="0" Text="--Select--"></asp:ListItem>
                                     <asp:ListItem value="1" Text="SOP"></asp:ListItem>
                                 </asp:DropDownList>
                                </div>
                        </div>
                </div>
               <div class="row">
                  <%--<div class="col-xs-6 col-sm-3 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblTrainedTech" runat="server" Text="Trained Tehnicians"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                               <div class="form-group">
                                    <asp:DropDownList ID="ddlTrainedTech" runat="server" CssClass="form-control">
                                    <asp:ListItem Value ="0" Text="--Select--"></asp:ListItem>
                                     <asp:ListItem Value ="1" Text="Balu"></asp:ListItem>
                                     <asp:ListItem Value ="2" Text="Nicho"></asp:ListItem>
                                 </asp:DropDownList>
                                </div>
                        </div>--%>
               
               </div>

                    <div class="row" style="padding-left:20px; padding-right:20px;">
                    <div class="form-group text-center">
                    
                       <input type=button id="btnClear"  class="btn btn-success" onclick="Clear();" value="Clear" localize="AnalyzerMaster_btnClear"/>
                        <%--<asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="if(!SaveInvInstrumentMaster()){ return false;}" OnClick="AddFileMaster_click"   />--%>
                         <input id="btnSave" type="button" class="btn btn-success" value="Save" onclick="if(!SaveInvInstrumentMaster()){ return false;}"  localize="AnalyzerMaster_btnSave" />
                      <%--  <asp:Button ID="btnUpdate" runat="server" OnClick="AddFileMaster_click" Text="Edit" 
            ClientIDMode="Static" Style="display: none;" />--%>
                       <input type=button id="Editusersave"  class="btn btn-success" value="Update" style="display:none;" localize="AnalyzerMaster_Editusersave"/>
                       
                            <asp:HiddenField ID="hdnMessages" Value="" />
                            <asp:HiddenField ID="hdnSListClientDisplay" Value="" />
                            <asp:HiddenField ID="hdnSListUserMsg" Value="" />
                            <asp:HiddenField ID="hdnFilepath" Value="" />
                </div>

                     <div class="gridTable bounceinup" id="DeviceList" runat="server">
                     
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblDeviceDetails" style="display:none" >
                                  <thead>
                                        <tr>
                                            <%--<th>S.No</th>--%>
                                            <th class="hide_column">Instrument</th>
                                            <th localize="QMS_Dashboard_aspx_LotName">Name</th>
                                            <th localize="Code">Code</th>
                                            <th localize="AnalyzerMaster_lblModel">Model</th>
                                            <th localize="AnalyzerMaster_lblManufacturer">Manufacturer</th>
                                            <th class="hide_column">ManufacturerID</th>
                                            <th localize="AnalyzerMaster_lblmaintDueDate">Maintenance Due Date</th>
                                            <th localize="AnalyzerMaster_lblDueDate">Calibration Due Date</th>
                                            <th class="hide_column">CalibrationDoneDate</th>
                                            <th class="hide_column">MaintenanceDoneDate</th>
                                            <th class="hide_column">InstallationDate</th>
                                            <th class="hide_column">ProcessingMode</th>
                                            <th class="hide_column">Method</th>
                                            <th class="hide_column">MethodID</th>
                                            <th class="hide_column">Principle</th>
                                            <th class="hide_column">PrincipleID</th>
                                            <th class="hide_column">ThroughPut</th>
                                            <th class="hide_column">Direction</th>
                                            <th localize="AnalyzerMaster_lblDepartment">Department Name</th>
                                            <th class="hide_column">Location</th>
                                            <th class="hide_column">LocationID</th>
                                             <th localize="Action">Action</th>
                                           <%-- <th>Delete</th>--%>
                                            <th class="hide_column">Files</th>
                                        </tr>
                                  </thead>
                              </table>
                           </div>
                    </div>
                     
                     <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="" />
                     <asp:HiddenField ID="hdnInsID" runat="server" Value="" />
                     
                   <asp:HiddenField ID=RoleID runat="server" Value="" />
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
             <%--   <asp:PostBackTrigger ControlID="btnSave" />--%>
                <%-- <asp:PostBackTrigger ControlID="btnUpdate" />--%>
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

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>


    <script src="Script/ControlLength.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>


    <script src="Script/tooltip.js" type="text/javascript"></script>
    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>
    <!-- AdminLTE for demo purposes -->
    
    <script src="Script/moment.js" type="text/javascript"></script>
    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>

              

    <script type="text/javascript">
        //Sys.Application.add_load(jScript);
        $btnSave = $('#btnSave');
        var btn = 'save';
       // var frmFiles = new FormData(); 
        // var files=[];
        var DelFiles = [];
        $(document).ready(function() {
        // Stop user to press enter in textbox
        $("input:text").keypress(function(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        });
            var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
            var path = GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');

//        $('#txtDeviceName').bind('keypress', function(event) {
//        var regex = new RegExp("^[a-zA-Z0-9- !@#$%&*]+$");
//            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
//            if (!regex.test(key)) {
//                event.preventDefault();
//                return false;
//            }
//        });
//        $('#txtThroughPut').bind('keypress', function(event) {
//            var regex = new RegExp("^[0-9]+$");
//            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
//            if (!regex.test(key)) {
//                event.preventDefault();
//                return false;
//            }
//        });
            loadpricipalmaster();
            GetAnalyzerMaster();
            Clear();

            $('#Check_DeviceID').click(function() { });

            $('.tool').hover(function() {

                var err = $(this).attr('error');
                if (err == 'Y') {
                    var txt = $(this).attr('text');
                    tooltip.pop(this, '<h4>' + txt + '</h4>');
                }
            });
            $('#txtDeviceCode').keyup(function(e) {


                var DeviceID = $('#txtDeviceCode').val();
                var oVal = $('#txtDeviceCode').attr('OVal');

                if (DeviceID == "") {
                    $('#Check_DeviceID').removeClass('btn-danger');
                    $('#Check_DeviceID').addClass('btn-success');
                    $('#Check_DeviceID i').removeClass('fa fa-check');
                    $('#Check_DeviceID i').addClass('fa fa-question');
                    //$("#btnSave").addClass('disabled');
                }
                else if (e.keyCode == 32) {
                    e.preventDefault();
                }
                else {
                    if (DeviceID != "") {

                        if (btn == 'update') {

                            if (DeviceID == oVal) {
                                $('#Check_DeviceID i').removeClass('fa fa-question');
                                $('#Check_DeviceID i').removeClass('fa fa-times');
                                $('#Check_DeviceID i').removeClass('NotOk');
                                $('#Check_DeviceID i').addClass('fa fa-check');
                                $('#Check_DeviceID i').addClass('Ok');
                                $('#Check_DeviceID').removeClass('btn-danger');
                                $('#Check_DeviceID').addClass('btn-success');
                                $('#Check_DeviceID').attr('error', 'N');
                            }
                            else {
                                var ObjClientDevice = {};
                                ObjClientDevice["DeviceID"] = DeviceID;
                                var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckDeviceID");
                            }
                        }
                        else {
                            var ObjClientDevice = {};
                            ObjClientDevice["DeviceID"] = DeviceID;
                            var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckDeviceID");

                        }


                    }
                    else {
                        $('#txtDeviceCode').val('');
                    }

                }
            });

//            $('#txtDeviceCode').keypress(function(e) {
//                if (e.keyCode == 32) {
//                    event.preventDefault();
//                }
//            });
            $('#Editusersave').click(function() {

                btn == 'save';
                if (pagevalidation()) {
                    $(this).hide();
                    $btnSave.show();
                    var Model;
                    var InstrumentName;
                    var Method = "";
                    var MethodID;
                    var Principle = "";
                    var PrincipleID;
                    var ProcessingMode = "";
                    var ThroughPut;
                    var OrgID;
                    var Department;
                    var DeptID;
                    var RoleID;
                    var CreatedBy;
                    var MaintenanceDoneDate1;
                    var MaintenanceDueDate1;
                    var CalibrationDoneDate1;
                    var CalibrationDueDate1;
                    var Manufacturer;
                    var ProductCode;
                    var InvInvestigationMaster1 = [];
                    var InstrumentID;
                    var installationdate;
                    var Locationid;
                    var direction = '';
                    Model = $('#txtModel').val();
                    InstrumentName = $('#txtDeviceName').val();

                    if ($('#ddlInterface').val() != 0) {
                        //direction = $('#ddlInterface').text();
                        direction = $('#ddlInterface option:selected').text();
                    }
                    MethodID = $('#ddlMethod').val();
                    if (MethodID != 0)
                    { Method = $('#ddlMethod  option:selected').text(); }

                    PrincipleID = $('#ddlPrinciple').val();
                    if (PrincipleID != 0)
                    { Principle = $('#ddlPrinciple  option:selected').text(); }

                    ProcessingModeid = $('#ddlProcessingMode').val();
                    if (ProcessingModeid != 0) {
                        ProcessingMode = $('#ddlProcessingMode option:selected').text();
                    }
                    ThroughPut = $('#txtThroughPut').val();
                    //Department = $('#ddlDepartment option:selected').text();
                    DeptID = $('#ddlDepartment').val();
                    CreatedBy = '<%= Session["RoleID"] %>';
                    OrgID = '<%= Session["OrgID"] %>'
                    RoleID = '<%= Session["RoleID"] %>';
                    

                    MaintenanceDoneDate1 = ($('#txtmaintDoneDate').val().length > 1) ? dateformat($('#txtmaintDoneDate').val(), 'YYYY/MM/DD') : "";
                    MaintenanceDueDate1 = ($('#txtmaintDueDate').val().length > 1) ? dateformat($('#txtmaintDueDate').val(), 'YYYY/MM/DD') : "";
                    CalibrationDoneDate1 = ($('#txtDoneDate').val().length > 1) ? dateformat($('#txtDoneDate').val(), 'YYYY/MM/DD') : "";
                    CalibrationDueDate1 = ($('#txtDueDate').val().length > 1) ? dateformat($('#txtDueDate').val(), 'YYYY/MM/DD') : ""; 
                    Manufacturer = $('#ddlManufacturer option:selected').val();
                    ProductCode = $('#txtDeviceCode').val();
                    InstrumentID = document.getElementById('<%=hdnInstrumentID.ClientID%>').value;
                    installationdate = ($('#TextBox1').val().length > 1) ? dateformat($('#TextBox1').val(), 'YYYY/MM/DD') : "";
                    InstrumentID = hdnInstrumentID.Value;
                    Locationid = $('#ddlLocation option:selected').val();

                    FilesAddDelete(DelFiles, ProductCode, 'AnalyzerMaster');
                    InvInvestigationMaster1.push({
                        Model: Model,
                        InstrumentName: InstrumentName,
                        InstrumentID: InstrumentID,
                        Method: Method,
                        MethodID: MethodID,
                        Principle: Principle,
                        PrincipleID: PrincipleID,
                        ProcessingMode: ProcessingMode,
                        ThroughPut: ThroughPut,
                        OrgID: OrgID,
                        Direction: direction,
                        CreatedBy: CreatedBy,
                        Manufacturer: Manufacturer,
                        ProductCode: ProductCode,
                        LocationID: Locationid,
                        Installationdate: installationdate
                    });
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "../QMS.asmx/QMS_EditInstrumentMaster",
                        data: JSON.stringify({ roleID: RoleID, orgID: OrgID, SaveAnalyzer: InvInvestigationMaster1,
                            MaintenanceDoneDate: MaintenanceDoneDate1, MaintenanceDueDate: MaintenanceDueDate1,
                            CalibrationDoneDate: CalibrationDoneDate1, CalibrationDueDate: CalibrationDueDate1, DeptID: DeptID
                        }),
                        dataType: "json",
                        success: function(data) {
                            GetAnalyzerMaster();
                            Clear();
                            $("#Editusersave").hide();
                            alert("Device details are updated successfully");
                        },
                        error: function(xhr, status, error) {
                            alert(error);
                        }
                    });
                }

             });

         });
    </script>

<link href="Script/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="Script/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>
    <script type="text/javascript">

        $("#txtDoneDate").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100'
//            onClose: function(selectedDate) {
//            $("#txtDueDate").datepicker("option", "minDate", new Date());

//                var date = $("#txtDoneDate").datepicker('getDate');

//            }

        });
        $("#txtDueDate").datepicker({
            dateFormat: 'dd/mm/yy',
            minDate: 1,
            onSelect: function(theDate) {
            if (theDate != $("#txtDoneDate").val()) {
                var date = $("#txtDueDate").datepicker('getDate');
                }
                else {
                    $("#txtDueDate").datepicker('option', 'minDate', new Date(theDate));
                }
            }
        });
        $("#txtmaintDoneDate").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                //  $("#txtmaintDueDate").datepicker("option", "minDate", selectedDate);

                var date = $("#txtmaintDoneDate").datepicker('getDate');

            }

        });
        $("#txtmaintDueDate").datepicker({
            // debugger;
           dateFormat: 'dd/mm/yy',
            minDate: 1,
            onSelect: function(theDate) {
                if (theDate != $("#txtmaintDoneDate").val()) {
                    var date = $("#txtmaintDueDate").datepicker('getDate');
                }
                else {
                    $("#txtmaintDueDate").datepicker('option', 'minDate', new Date(theDate));
                }
            }

           
        });
        $("#TextBox1").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                var date = $("#TextBox1").datepicker('getDate');
                // $("#txtmaintDueDate").datepicker('option', 'minDate', selectedDate);
                $("#txtmaintDoneDate").datepicker('option', 'minDate', selectedDate);
                $("#txtDoneDate").datepicker('option', 'minDate', selectedDate);



            }
        });
        function CheckDeviceID(ObjClient, URL) {
            var returnCode = true;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: URL,
                async: false,
                data: JSON.stringify(ObjClient),
                dataType: "json",
                success: function(data) {//On Successfull service call

                    if (data.d == 'N') {

                        $('#Check_DeviceID i').removeClass('fa fa-question');
                        $('#Check_DeviceID i').removeClass('fa fa-check');
                        $('#Check_DeviceID i').removeClass('Ok');
                        $('#Check_DeviceID i').addClass('fa fa-times');
                        $('#Check_DeviceID i').addClass('NotOk');
                        $('#Check_DeviceID').removeClass('btn-success');
                        $('#Check_DeviceID').addClass('btn-danger');
                        $('#Check_DeviceID').attr('error', 'Y');
                        $('#btnSave').attr("disabled", "disabled");
                        returnCode = false;
                    }
                    else if (data.d == 'Y') {
                        $('#Check_DeviceID i').removeClass('fa fa-question');
                        $('#Check_DeviceID i').removeClass('fa fa-times');
                        $('#Check_DeviceID i').removeClass('NotOk');
                        $('#Check_DeviceID i').addClass('fa fa-check');
                        $('#Check_DeviceID i').addClass('Ok');
                        $('#Check_DeviceID').removeClass('btn-danger');
                        $('#Check_DeviceID').addClass('btn-success');
                        $('#Check_DeviceID').attr('error', 'N');
                        $('#btnSave').removeAttr("disabled");
                        returnCode = true;
                    }


                    //  alert(data.GetDDlDataResult[0].StateName);
                },
                error: function(result) {
                    alert("Error");
                } // When Service call fails
            });
            return returnCode;
        }
        function pagevalidation() {
            var DeviceName = $('#txtDeviceName').val();
            var DeviceCode = $('#txtDeviceCode').val();
            var err = $('#Check_DeviceID').attr('error');
            if (DeviceName == "" && DeviceCode == "") {
                alert("Please provide devicename & devicecode ");
                return false;
            }
            else if (DeviceName == "") {
                alert("Please provide devicename");
                $('#txtDeviceName').focus();
                return false;
            }
            else if (DeviceCode == "") {
                alert("Please provide Devicecode");
                $('#txtDeviceCode').focus();
                return false;
            }
            else if ($('#ddlManufacturer').val() == 0) {
            alert("Please provide Manufacturer");
                $('#txtDeviceCode').focus();
                return false;
            }
            else if (err == 'Y') {
                alert("Device code already exists");
                $('#Check_DeviceID').focus();
                return false;
            }
            else if ($('#ddlLocation').val() == 0) {
            alert("Please select Location");
            return false;
            }
            else {
                return true;
            }
        }
        function Clear() {
            $btnSave.show();
            btn == 'save';
            $('#Check_DeviceID').attr('error', 'I');
            $('#Editusersave').hide();
            $('#txtDeviceName').val("");
            $('#txtDeviceCode').val("");
            $('#txtModel').val("");
            $('#ddlManufacturer').val($("#ddlManufacturer option:first").val());
            $('#ddlMethod').val($("#ddlMethod option:first").val());
            $('#ddlPrinciple').val($("#ddlPrinciple option:first").val());
           // $('#ddlDepartment').val($("#ddlDepartment option:first").val());
            $('#txtDoneDate').val("");
            $('#txtDueDate').val("");
            $('#txtmaintDoneDate').val("");
            $('#txtmaintDueDate').val("");
            $('#TextBox1').val("");
            $('#ddlProcessingMode').val($("#ddlProcessingMode option:first").val());
            $('#txtThroughPut').val("");
            $('#ddlInterface').val($("#ddlInterface option:first").val());
            $('#ddlTrainedTech').val($("#ddlTrainedTech option:first").val());
            $('#ddlSelectFileTpye').val($("#ddlSelectFileTpye option:first").val());
           // $('#ddlDepartment').multiselect('destroy');
            $('#ddlLocation').val(0);
            $('#ddlFileType').val(0);
            $("#ddlDepartment option:selected").prop("selected", false);
            $("#ddlDepartment").multiselect('refresh');
            $('#txtfileupload_wrap_list').html('');
            DelFiles = [];
            $("#txtfileupload").Attune_RemoveFiles();
            $('#Check_DeviceID i').addClass('fa fa-question');
            $('#Check_DeviceID').removeClass('btn-danger').addClass('btn-success');
            //$("select.multiselect").multiselect("deselectAll", false);
        }


        function SaveInvInstrumentMaster() {
            if (pagevalidation() == true) {
                var Model;
                var InstrumentName;
                var Method;
                var MethodID;
                var Principle;
                var PrincipleID;
                var ProcessingMode;
                var ThroughPut;
                var OrgID;
                var direction = '';
                var Department;
                var DeptID;
                var RoleID;
                var CreatedBy;
                var MaintenanceDoneDate1;
                var MaintenanceDueDate1;
                var CalibrationDoneDate1;
                var CalibrationDueDate1;
                var Manufacturer;
                var ProductCode;
                var InvInvestigationMaster1 = [];
                //var InstrumentID;
                var installationdate;
                var Locationid;
                Model = $('#txtModel').val();
                InstrumentName = $('#txtDeviceName').val();
                Method = $('#ddlMethod  option:selected').text();
                MethodID = $('#ddlMethod').val();

                PrincipleID = $('#ddlPrinciple').val();

                Principle = $('#ddlPrinciple  option:selected').text();
                ProcessingModeID = $('#ddlProcessingMode').val();
                if (ProcessingModeID != 0) {
                    ProcessingMode = $('#ddlProcessingMode option:selected').text();
                }
               
                if ($('#ddlInterface').val() != 0) {
                    //direction = $('#ddlInterface').text();
                    direction = $('#ddlInterface option:selected').text();
                }

                ThroughPut = $('#txtThroughPut').val();
                //Department = $('#ddlDepartment option:selected').text();
                DeptID = $('#ddlDepartment').val();
                CreatedBy = '<%= Session["RoleID"] %>';
                OrgID = '<%= Session["OrgID"] %>'
                RoleID = '<%= Session["RoleID"] %>';
                MaintenanceDoneDate1 = ($('#txtmaintDoneDate').val().length > 1) ? dateformat($('#txtmaintDoneDate').val(), 'YYYY/MM/DD') : "";
                MaintenanceDueDate1 = ($('#txtmaintDueDate').val().length > 1) ? dateformat($('#txtmaintDueDate').val(), 'YYYY/MM/DD') : "";
                CalibrationDoneDate1 = ($('#txtDoneDate').val().length > 1) ? dateformat($('#txtDoneDate').val(), 'YYYY/MM/DD') : "";
                CalibrationDueDate1 = ($('#txtDueDate').val().length > 1) ? dateformat($('#txtDueDate').val(), 'YYYY/MM/DD') : ""; 
                Manufacturer = $('#ddlManufacturer option:selected').val();
                ProductCode = $('#txtDeviceCode').val();
                //InstrumentID = -1;
                installationdate = ($('#TextBox1').val().length > 1) ? dateformat($('#TextBox1').val(), 'YYYY/MM/DD') : "";
                Locationid = $('#ddlLocation option:selected').val();
                //ddldeptnameseparate();
                //OrgDatetime1 = JSON.stringify(OrgDatetime1).replace(/\/Date/g, "\\\/Date").replace(/\)\//g, "\)\\\/");
                if (Method == "-- Select --") {
                    Method = "";
                    //MethodID=
                }
                if (Principle == "-- Select --") {
                    Principle = "";
                }
                if (ProcessingMode == "-- Select --") {
                    ProcessingMode = "";
                }
                FilesAddDelete(DelFiles, ProductCode, 'AnalyzerMaster');
                    
                InvInvestigationMaster1.push({
                    Model: Model,
                    InstrumentName: InstrumentName,
                    Method: Method,
                    MethodID: MethodID,
                    Principle: Principle,
                    PrincipleID: PrincipleID,
                    ProcessingMode: ProcessingMode,
                    ThroughPut: ThroughPut,
                    OrgID: OrgID,
                    Direction: direction,
                    //DeptID: DeptID,
                    CreatedBy: CreatedBy,
                    Manufacturer: Manufacturer,
                    ProductCode: ProductCode,
                    Installationdate: installationdate,
                    LocationID: Locationid
                });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/InvInstrumentMaster",
                    data: JSON.stringify({ roleID: RoleID, orgID: OrgID, SaveAnalyzer: InvInvestigationMaster1,
                        MaintenanceDoneDate: MaintenanceDoneDate1, MaintenanceDueDate: MaintenanceDueDate1,
                        CalibrationDoneDate: CalibrationDoneDate1, CalibrationDueDate: CalibrationDueDate1, DeptID: DeptID
                    }),
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var returncode;
                        returncode = data.d;
                        if (returncode > 0) {
                            hdnInsID.value = returncode;
                            GetAnalyzerMaster();
                            Clear();
                            alert('Analyzer Master saved sucessfully');

                        }
                        else {

                            alert('Analyzer Master not saved sucessfully');
                            Clear();
                        }
                        return false;
                    },
                    error: function(xhr, status, error) {
                        alert(error);
                        return false;
                    }

                });
            }
            else { 
            return false
            }
        }

        function GetAnalyzerMaster() {
            var dd;
            var obj = {};
var dval=5;
$.ajax({
    type: "POST",
    contentType: "application/json;charset=utf-8",
    url: "../QMS.asmx/LoadAnalyzerMaster",
    data: JSON.stringify(obj),
    async: false,
    dataType: "json",
    success: function(data) {
        var Items = data.d;
        var dtDayWCR = Items;
        if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
            var parseJSONResult = JSON.parse(dtDayWCR);
            $('#DeviceList').show();
            $('#tblDeviceDetails  tbody > tr').remove();
            $('#tblDeviceDetails').show();
            $('#tblDeviceDetails').dataTable({
                paging: true,
                data: parseJSONResult,
                "bDestroy": true,
                "searchable": true,
                "sort": true,

dom: 'Bfrtip',
        buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                columns: [1, 2, 3, 4, 6, 7,18]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                columns: [1, 2, 3, 4, 6, 7,18]
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: [  1, 2,3,4,6 ,7,18]
                }
            }
        ],

                columns: [
                                            { 'data': 'InstrumentID',
                                                "sClass": "hide_column"

                                            },
                                            { 'data': 'NAME' },
                                            { 'data': 'Code' },
                                            { 'data': 'Model' },
                                            { 'data': 'Manufacturer' },
                                             { 'data': 'ManufacturerID', "sClass": "hide_column" },
                                            {
                                                'data': 'MaintenanceDueDate',
                                                'render': function(JsonDate) {
                                                    if (JsonDate != null) {
                                                        var date = new Date(parseInt(JsonDate.substr(6)));
                                                        var month = date.getMonth() + 1;
                                                        return date.getDate() + "/" + month + "/" + date.getFullYear();
                                                    }
                                                    else
                                                    { return ''; }
                                                }
                                            },
                                            {
                                                'data': 'CalibrationDueDate',
                                                'render': function(JsonDate) {
                                                    if (JsonDate != null) {

                                                        var date = new Date(parseInt(JsonDate.substr(6)));
                                                        var month = date.getMonth() + 1;
                                                        return date.getDate() + "/" + month + "/" + date.getFullYear();
                                                    }
                                                    else
                                                    { return ''; }
                                                }
                                            },
                                            {
                                                'data': 'CalibrationDoneDate',
                                                "sClass": "hide_column"
                                            },
                                            {
                                                'data': 'MaintenanceDoneDate',
                                                "sClass": "hide_column"
                                            },
                                            
                                           {
                                                'data': 'Installationdate',
                                                "sClass": "hide_column"
                                            },
                                            {
                                                'data': 'ProcessingMode',
                                                "sClass": "hide_column"
                                            },
                                            
                                            {
                                                'data': 'Method',
                                                "sClass": "hide_column"
                                            },
                                            {
                                                'data': 'MethodID',
                                                "sClass": "hide_column"
                                            },
                                        {
                                            'data': 'Principle',
                                            "sClass": "hide_column"
                                        },
                                         {
                                             'data': 'PrincipleID',
                                             "sClass": "hide_column"
                                         },
                                            {
                                                'data': 'ThroughPut',
                                                "sClass": "hide_column"
                                            },
                                            {
                                                'data': 'Direction',
                                                "sClass": "hide_column"
                                            },
                                            {
                                                'data': 'DepartmentName'
                                            },

                                              {
                                                  'data': 'Location',
                                                  "sClass": "hide_column"
                                              },
                                              {
                                                  'data': 'LocationID',
                                                  "sClass": "hide_column"
                                              },
                                          
                                              {
                                                  'data': 'Edit',
                                                  "defaultContent": 'Edit',
                                                  "mRender": function(data, type, full, meta) {
                                                    var txt='<input value = "'+langData.Edit+'"  '+ full.Edit+' class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                txt=txt+' / '+'<input value = "'+langData.Delete+'"  '+ full.Delete+' class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                return txt;
                                                  }
												  },
                                            {
                                                'data': 'Files',
                                                "sClass": "hide_column" 
                                            }


]

            });

            jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

            $('#DeviceList').addClass('show');
        }
        else {
            $('#tblDeviceDetails').hide();
            $('#DeviceList').hide();
            // alert('No matching record found!');

        }

    },
    error: function(jqXHR, textStatus, errorThrown) {
        alert("Something went wrong");
    }
});
            //return dd;
        }

        function loadpricipalmaster() {
            var dd;
            var resdata = [];
            //var obj = {};
            // obj.status = 'principle'
            $.ajax({
                type: "POST",
                url: "../QMS.asmx/QMS_LoadInvPrincipleMaster",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                async: false,
                success: function(data) {
                    dd = data.d;

                    if (dd[0].length > 0) {
                        $('#ddlPrinciple').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd[0], function(index, Item) {
                            $('#ddlPrinciple').append('<option value="' + Item.PrincipleID + '">' + Item.PrincipleName + '</option>');
                        });
                        //DdlAddUsingList(ddlPrinciple, dd, 'PrincipleID', 'PrincipleName');
                    }
                    else { $('#ddlPrinciple').append($('<option></option>').val(0).html('-- Select --')); }

                    if (dd[1].length > 0) {
                        $('#ddlMethod').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd[1], function(index, Item) {
                            $('#ddlMethod').append('<option value="' + Item.MethodID + '">' + Item.MethodName + '</option>');
                        });
                        //DdlAddUsingList(ddlPrinciple, dd, 'PrincipleID', 'PrincipleName');
                    }
                    else { $('#ddlMethod').append($('<option></option>').val(0).html('-- Select --')); }

                    if (dd[2].length > 0) {

                        $.each(dd[2], function(index, Item) {
                            var obj = new Object();
                            var label = Item.DeptName;
                            var value = Item.DeptID;
                            obj = { label: label, value: value };
                            resdata.push(obj);
                        });
                        $('#ddlDepartment').multiselect('dataprovider', resdata);
                        //DdlAddUsingList(ddlPrinciple, dd, 'PrincipleID', 'PrincipleName');
                    }

                    if (dd[3].length > 0) {
                        $('#ddlLocation').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd[3], function(index, Item) {
                            $('#ddlLocation').append('<option value="' + Item.AddressID + '">' + Item.Location + '</option>');
                        });
                    }


                    if (dd[4].length > 0) {
                        $('#ddlManufacturer').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd[4], function(index, Item) {
                            $('#ddlManufacturer').append('<option value="' + Item.MacID + '">' + Item.ManufacturerName + '</option>');
                        });
                    }
                    else { $('#ddlManufacturer').append($('<option></option>').val(0).html('-- Select --')); }
                },
                error: function(result) {
                    alert("Error");
                }

            });
            return dd;
        }





        function Delete_OnClick(ID) {


            if (DeleteConfirm()) {
                var dd;
                var obj = {};
                obj.ID = ID;
                $.ajax({
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    url: "../QMS.asmx/QMS_DeleteInstrumentMaster",
                    data: JSON.stringify(obj),
                    async: false,
                    dataType: "json",
                    success: function(data) {
                        dd = data.d;
                        if (dd > 0) {
                            GetAnalyzerMaster();
                            alert("Analyzer deleted successfully");
                            Clear();
                        }
                    },
                    error: function(result) {
                        alert("Error");
                    }
                });
            }
        }
        function ActualDate(JsonDate) {
            var date = new Date(parseInt(JsonDate.substr(6)));
            var month = date.getMonth() + 1;
            return date.getDate() + "/" + month + "/" + date.getFullYear();
        }
        function DeleteConfirm() {
            var objConfirm = "Are you sure you want to delete?";
            if (confirm(objConfirm)) {
                return true;
            }
            return;
        }
        function Edit_OnClick(id) {
            Clear();
            $btnSave.hide();
            $("#Editusersave").show();
            btn = 'update';
            $('#Check_DeviceID').attr('error', 'N');
            var oTable = $("#tblDeviceDetails").DataTable();
            var rowCount = $('#tblDeviceDetails tr').length;
            var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
                if (oTable.cell(rowIdx, 0).data() == id) {
                    var aData = oTable.rows(rowIdx).data();
                    hdnInstrumentID.Value = id;
                    var DeviceName = aData[0].NAME;
                    var DeviceCode = aData[0].Code
                    var Model = aData[0].Model;
                    var Manufacturer = aData[0].Manufacturer;
                    if (aData[0].CalibrationDueDate != null) {
                        var CalibrationDueDate = ActualDate(aData[0].CalibrationDueDate);
                    }
                    if (aData[0].MaintenanceDueDate != null) {
                        var MaintainenceDueDate = ActualDate(aData[0].MaintenanceDueDate);
                    }
                    if (aData[0].MaintenanceDoneDate != null) {
                        var MaintainenceDoneDate = ActualDate(aData[0].MaintenanceDoneDate);
                    }
                    if (aData[0].CalibrationDoneDate != null) {
                        var CalibrationDoneDate = ActualDate(aData[0].CalibrationDoneDate)
                    }
                    if (aData[0].Installationdate != null) {
                        $("#TextBox1").val(ActualDate(aData[0].Installationdate));
                    }
                    var principle = aData[0].Principle;
                    var throughput = aData[0].ThroughPut;
                    var method = aData[0].Method;
                    var Department = aData[0].DepartmentName;

                    var LocationID = aData[0].LocationID;
                    $('#ddlLocation').val(LocationID);
                    $("#txtDeviceName").val(DeviceName);
                    $("#txtDeviceCode").attr('OVal', DeviceCode);
                    $("#txtDeviceCode").val(DeviceCode);

                    $("#txtModel").val(Model);

                    $("#txtDueDate").val(CalibrationDueDate);
                    $("#txtmaintDueDate").val(MaintainenceDueDate);
                    $("#txtDoneDate").val(CalibrationDoneDate);
                    $("#txtmaintDoneDate").val(MaintainenceDoneDate);
                    $("#txtThroughPut").val(throughput);
                    $("#ddlProcessingMode option").each(function() {
                        if ($(this).text() == aData[0].ProcessingMode) {

                            $("#ddlProcessingMode").val($(this).val());

                        }
                    });
                    $("#ddlInterface option").each(function() {
                        if ($(this).text() == aData[0].Direction) {

                            $("#ddlInterface").val($(this).val());

                        }
                    });

                    //$("ddlInterface").val(aData[0].Direction);
                    if (aData[0].ManufacturerID !=null) {
                        $("#ddlManufacturer").val(aData[0].ManufacturerID);
                    }
                    if (aData[0].PrincipleID != null) {
                        $("#ddlPrinciple").val(aData[0].PrincipleID);
                    }

                    if (aData[0].MethodID != null)
                     {
                        $("#ddlMethod").val(aData[0].MethodID);
                    }
                    $("#Editusersave").show();

                    populateOnEdit(aData[0].Files);



                    if (Department != null && Department != '') {
                        var selectedDays = [];
                        selectedDays = Department.split(",");
                        $("#ddlDepartment option").removeAttr('selected');
                        $.each(selectedDays, function(key, value) {
                            $("#ddlDepartment").multiselect('destroy');

                            for (var i = 0; i <= $("#ddlDepartment option").length - 1; i++) {
                                if ($("#ddlDepartment option")[i].text == value) {
                                    $("#ddlDepartment option")[i].selected = true;
                                    break;
                                }
                            }

                            $("#ddlDepartment").multiselect();
                        });
                    }


                }
            });

        }
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
