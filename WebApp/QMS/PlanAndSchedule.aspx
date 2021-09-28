<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanAndSchedule.aspx.cs" EnableEventValidation="false"
    Inherits="QMS_PlanAndSchedule" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Plan & Schedule</title>
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
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    
 
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
        .required
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
        .flow
        {
            float: left;
        }
    </style>
    <%--<link href="http://code.jquery.com/ui/jquery-ui-git.css" rel="Stylesheet" type="text/css" />--%>
    <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
        <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="test" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content">
          <div class="fadeindown header-top">
          <div class="row">
                <div class="col-md-12">
                     <h4 class="strong">Plan & Schedule</h4>
                </div>
            </div>
            
            <div class="row" style="     padding-right: 20px;  padding-bottom: 20px; ">
            <input type="button" class="btn-primary pull-right"   value="Create New" id="btnCreateEvent" />
            </div>
           
            <div class="row">
                <div class="col-xs-6 col-sm-2 col-md-2">
                       
                               <label for="Org" localize="PlanAndSchedule_Org">Organization</label>
                        
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                         <select id="Org" class="form-control">
                   <option value="0">---Select---</option>
               </select>
                 </div>
                
                <div class="col-xs-6 col-sm-2 col-md-2">
                       
                              <label for="txtLocation" localize="PlanAndSchedule_txtLocation">Location</label>
                       
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                      
                             <select id="txtLocation" class="form-control">
                   <option value="0">---Select---</option>
                 </select>
                       
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                       
                            <label for="txtDate" localize="PlanAndSchedule_txtDate">Date</label>
                      
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtDate" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                       </div>
                </div>
                </div>
             <div class="row">
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="txtTime" localize="PlanAndSchedule_txtTime">Time</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                        <input type="text" id="txtTime" class="form-control" />
                                                   </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                              <label for="EventType" localize="PlanAndSchedule_EventType">Event Type</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                             <select id="EventType" class="form-control">
                   <option value="0">---Select---</option>
                 </select>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <label for="txtDate" localize="PlanAndSchedule_EventName">Event Name</label>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input type="text" id="txtEventName" class="form-control" />
                        </div>
                       </div>
                </div>
                </div>
              <div class="row">
               <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <label for="ddlStatus" localize="PlanAndSchedule_ddlStatus">Status</label>
                        </div>
                </div>
              <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                        <select for="ddlStatus" class="form-control">
                        <option value="0">---Select---</option>
                        </select>
                              
                        </div>
                </div>
              </div>
            
            
           </div>
           
           <div class="text-center">
           <input type="button" class="btn btn-primary " id="btnFilter" value="Filter" localize="PlanAndSchedule_btnFilter"/>
           </div>
           <br />
           <br />
           <div class="gridTable bounceinup" id ="tblEventDetails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblPNCDetails">
                                  <thead><tr>
                                       
  <th localize="SNO">S.No</th>
  <th localize="PlanAndSchedule_EventName">Event Type</th>
  <th localize="PlanAndSchedule_EventName">Event Name</th>
  <th localize="DateTime">Date Time</th>
    <th localize="PlanAndSchedule_txtLocation">Location</th>
    <th localize="Status">Status</th>
    <th localize="Action">Action</th>                                          
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>
        
        <div>
        <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlEventType" localize="PlanAndSchedule_ddlEventType">Event Type</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">
                        <div class="form-group">
                        <select id="ddlEventType" class="form-control">
                        <option>---SELECT---</option>
                        </select>
                                                   </div>
                </div>
                </div>
            </div>
          <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="txtEventName" localize="PlanAndSchedule_EventName">Event Name</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                        <input type="text" id="txtEventName" class="form-control" />
                                                   </div>
                </div>
                </div>
            </div>
            
            <div class="row">
            <p id="basicExample">
    <input type="text" class="date start" />
    <input type="text" class="time start" /> to
    <input type="text" class="time end" />
    <input type="text" class="date end" />
</p>
            </div>
             <div class="row">
                    <!--Row-->
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblFileupload" runat="server" Text="Fileupload"></asp:Label>
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
                                <asp:Label ID="lblFileType" runat="server" Text="FileType"></asp:Label>
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
         <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="txtScope" localize="PlanAndSchedule_txtScope">Audit Scope</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" id="txtScope" class="form-control" > </textarea>
                        
                                                   </div>
                </div>
                </div>
            </div>
         <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="txtCriteria" localize="PlanAndSchedule_txtCriteria">Audit Criteria</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" id="txtCriteria" class="form-control" > </textarea>
                                                   </div>
                </div>
                </div>
            </div>
           <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlProgType" localize="PlanAndSchedule_ddlProgType">Audit Program Type</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">
                        <div class="form-group">
                        <select id="ddlProgType" class="form-control">
                        <option>---SELECT---</option>
                        </select>
                                                   </div>
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlDept" localize="PlanAndSchedule_ddlDept">Department To Audit</label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">
                        <div class="form-group">
                        <select id="ddlDept" class="form-control">
                        <option>---SELECT---</option>
                        </select>
                                                   </div>
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlStatus" localize="PlanAndSchedule_ddlStatus">Status</label>
                        </div>
                </div>
                <div class="col-sm-4 col-md-4">
                        <div class="form-group">
                        <select id="ddlStatus" class="form-control">
                        <option>---SELECT---</option>
                        </select>
                                                   </div>
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlStatus" localize="PlanAndSchedule_AuditTeam">Audit Team Membet</label>
                        </div>
                </div>
                <div class="col-sm-4 col-md-4">
                        <div class="form-group">
                        <select id="ddlTeamMember" class="form-control">
                        <option>---SELECT---</option>
                        </select>
                                                   </div>
                </div>
                
                  <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <input type="text" class="form-control" id="txtEmail" />
                        </div>
                </div>
                <div class="col-sm-1 col-md-1">
                        <div class="form-group">
                              <input type="button" value="Add" class="form-control" id="btnAddMail" localize="PlanAndSchedule_btnAddMail"/>
                       
                                                   </div>
                </div>
                <div class="col-sm-1 col-md-1">
                        <div class="form-group">
                             <label id="lblMailID" class="form-control">Guest "\n" ddfd</label>
                       
                                                   </div>
                </div>
                
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-12">
                <div class="col-sm-4 col-md-4">
                </div>
                    <div class="col-sm-1 col-md-1">
                        <input type="button" id="btnClear" class="form-control btn btn-primary " value="Clear" localize="PlanAndSchedule_btnClear"/>
                </div>
                <div class="col-sm-1 col-md-1">
                        <input type="button" id="btnSave" class="form-control  btn-primary" value="Save" localize="PlanAndSchedule_btnSave" /> 
                </div>
                 <div class="col-sm-1 col-md-1">
                        <input type="button" id="btnSend" class="form-control  btn-primary" value="Send" localize="PlanAndSchedule_btnSend"/> 
                </div>
                </div>
            </div>
        </div>
           </section>
                </div>
                <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2016-2017 <a href="http://attunelive.com">Attune</a>.</strong> All rights reserved.
      </footer>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnDeviceMappingId" runat="server" />
        </form>
    </div>
    <!-- ./wrapper -->
    <!-- jQuery 2.1.4 -->
    <!-- bootstrap datepicker -->



    <script src="Script/jquery-2.1.4.min.js" type="text/javascript"></script>
   <script src="dist/js/jquery-1.11.2-ui.min.js" type="text/javascript"></script>
    <!-- Bootstrap 3.3.2 JS -->

    <script src="Script/jquery.timepicker.min.js" type="text/javascript"></script>

    <script src="Script/datepair.min.js" type="text/javascript"></script>

    <script src="Script/jquery.datepair.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.js"></script>
    <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>

    <script src="Script/DateTimePAir/bootstrap-datepicker.js" type="text/javascript"></script>

    <link href="Script/DateTimePAir/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
    <!-- iCheck 1.0.1 -->
        <link href="Script/DateTimePAir/site.css" rel="stylesheet" type="text/css" />

    <script src="Script/DateTimePAir/site.js" type="text/javascript"></script>

    <script src="Script/ControlLength.js" type="text/javascript"></script>

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


<script src="Resource/local_resorce.js" type="text/javascript"></script>
    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <link href="Script/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />

    <script src="Script/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>

    <script src="Script/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>

    <script src="Script/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>

    <script src="Script/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>

    <script src="Script/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>

    <script src="Script/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>

    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $('#jqueryExample .time').timepicker({
            'showDuration': true,
            'timeFormat': 'g:ia'
        });

        $('#jqueryExample .date').datepicker({
            'format': 'm/d/yyyy',
            'autoclose': true
        });

        // initialize datepair
        $('#jqueryExample').datepair();


//        $("#txtDate").datepicker({
//            dateFormat: 'dd/mm/yy',
//            defaultDate: "+1w",
//            maxDate: 0,
//            yearRange: '1900:2100',
//            onClose: function(selectedDate) {
//                //   $("#txtDueDate").datepicker("option", "minDate", selectedDate);

//                //  var date = $("#txtDoneDate").datepicker('getDate');

//            }

//        });
    </script>

 

</body>
</html>
