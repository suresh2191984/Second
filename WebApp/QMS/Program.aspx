<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Program.aspx.cs" Inherits="QMS_Program" EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Training Program</title>
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
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="Script/tooltip.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="Script/jquery-ui-git.css" />

    <script type="text/javascript">

        
     
    </script>

    <style type="text/css">
        .hide_Column
        {
            display: none;
        }
        label
        {
            font-weight: 600;
        }
        .lblData
        {
            font-weight: normal !important;
        }
        .MultiFile-label
        {
            margin-left: 0px;
        }
    </style>
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
        <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <!-- /.sidebar -->
        </aside>
        <!-- Content Wrapper. Contains page content -->
        <uc1:MainHeader ID="MainHeader" runat="server" />
        <div class="content-wrapper" id="contentid">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <section class="content" style="overflow-y: auto;">
          <div class="fadeindown" id="maincontent">
          <div id="divProgramFilter" class="card">
          
              <div class="header">
                     <h2 class="strong">Training Program</h2>
               
                </div>
                <div class="body">
      
             <div class="row">
         
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                            <label for="dllOrg" localize="Program_dllOrg">Organization  </label>
                            
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                                <select data="Organization" Entity="OrgID"  class="form-control" id="dllOrg"  >
                                      <option value="0">---SELECT---</option>
                                </select>
                                 
                            </div>
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                               <label for="ddlLocation" localize="Program_ddlLocation">Location </label>
                            </div>
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                             <select  data="Location" Entity="Location" change="dllOrg" class="form-control" id="ddlLocation" >
                                      <option>---SELECT---</option>
                                </select>
                            
                            </div>
                    </div>                    
                     <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                              <label for="txtFromDate" localize="Program_txtFromDate">From Date: </label>
                                    <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">      
                             <div class="input-group">                      
                                  <input type="text" class="form-control" readonly="readonly" Entity="FromDate" valtype="date" id="txtFromDate" />
                                <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                              </div>  
                            </div>
                               
                    </div>
                </div>
                
                    
                
              
               <div class="row">
                
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                            <label for="txtToDate" localize="Program_txtToDate">To Date  </label>
                            <span style="color:Red">*</span>
                            
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                <div class="input-group">
                               <input type="text" id="txtToDate" Entity="Todate" readonly="readonly"  valtype="date"  class="form-control" />
                                 <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                              </div>
                            </div>
                               
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                               <label for="txtTopic" localize="Program_txtTopic">Topic  </label>
                                     <%--<span style="color:Red">*</span>--%>
                            </div>
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                                      <input type="text" id="txtTopic" Val-Key="Topic" Entity="Topic" class="form-control" />
                                
                            
                            </div>
                    </div>                    
                     <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                              <label for="txtName" localize="Program_txtName">Name </label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <input type="text" Entity="EventName" Val-Key="EventName"  class="form-control" id="txtName" />
                                  
                            </div>
                    </div>
                    </div>
                
                
                <div class="row">
                
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                            <label for="txtTriner" localize="Program_txtTriner">Trainer  </label>
                            
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                               <input type="text" id="txtTriner" Val-Key="Trainer" class="form-control" />
                                 
                            </div>
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                               <label for="txtStatus" localize="Program_txtStatus">Status</label>
                            </div>
                    </div>                    
                    <div class="col-xs-8 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                                     <select id="txtStatus" Entity="Status" runat="server" class="form-control" >
                                    
                                     </select>
                                
                            
                            </div>
                    </div>                    
                     
                    </div>
                 
                 
                 <div class="row">
                
                 <div class="col-xs-4 col-sm-4 col-md-4"> </div>
                         
                         <div class="col-xs-2 col-sm-2 col-md-2 col-lg-1">
                             <input type="button" value="Filter" class="form-control  btn-primary" id="btnFilter" onclick="LoadPrgramDetails();" localize="Program_btnFilter"/>         
                     </div>
                    </div>
                   
                 <div class="row" style="padding:20px;">
                 <div id="divFilter"  runat="server" class="gridTable bounceinup">
                  <div class="table-responsive">
                      <table id="tblProgramList" 
                          class="table tbl-grid table-bordered form-inline table-striped" >
                          <thead>
                              <tr>
                                  <th class="hide_Column">PlanID</th>
                                  <th localize="SNO">S.NO</th>
                                  <th localize="Program_txtName">Name</th>
                                  <th localize="Program_txtTopic">Topic</th>
                                  <th localize="QMS_Dashboard_aspx_ProposedDate">Date</th>
                                  <th localize="Program_ddlLocation">Location</th>
                                  <th localize="Program_txtTriner">Trainer</th>
                                  <th localize="Program_txtStatus">Status</th>
                              </tr>
                          </thead>
                      </table>
                  </div>
              </div>
                 
                 </div>
                  
             </div>
          
             </div>   
              <div id="divTriningProgram" style="display:none;" class="card">
          
              <div class="header">
                     <h2 class="strong">Training Program --></h2>
                    <div class="right">
                     <h4 id="btnBack">Go Back</h4>
                     </div>
                </div>
                <div class="body">
            
       
                <div class="row">
                
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <label for="lblTraining">Name  </label>
                            
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblTraining" class="lblData"></label>
                                 
                            </div>
                    </div>                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                               <label for="lblDateTime">Date & Time </label>
                            </div>
                    </div>                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                              <label id="lblDateTime" class="lblData"></label>
                            
                            </div>
                    </div>                    
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                              <label for="lblVenue">Venue </label>
                            </div>
                    </div>
                  <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label id="lblVenue" class="lblData"></label>
                            </div>
                    </div>
                    </div>
                       
                
                  <div class="row">
                  <div class="col-lg-2 col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="lblParticipants">Participant </label>
                            </div>
                    </div>
                    <div class="col-lg-10 col-xs-6 col-sm-10 col-md-10">
                      
                            <div id="divGuestMail"  runat="server">
                            </div>
                    </div>
                  </div>
                 
            <div class="row">
                  <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="lblTopic" >Topic </label>
                             
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label id="lblTopic" class="lblData"></label>
                            </div>
                    </div>
                  </div>
             
             
              
                    <div class="row">
                            <div class="col-xs-6 col-sm-2 col-md-2">                            
                                  <label for="ddlStatus">Status :</label>
                                 </div>
                                 
                                  <div class="col-xs-6 col-sm-2 col-md-2">
                                  
                          
                        
                            <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server"></asp:DropDownList>                       
                                 
                            </div>
                    </div>
                    
                    <div class="row">
                    
                    <div class="text-center">
                    
                    <input ID="btnTrainingSave" type="button"  class="btn btn-success" value="Save" onclick="SaveTrainingStatus();" />
                    </div>
                    
                    </div>
     
              
              
              <div class="row" style="padding-top:35px;">
                  <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="ddlExamType">Exam Type </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">    
                             <asp:DropDownList ID="ddlExamType" CssClass="form-control" runat="server"></asp:DropDownList>                       
                                
                            </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="lblParticipant">Participant </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <select class="form-control" id="ddlParticipant">
                                  
                                  </select>
                            </div>
                    </div>
                    
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtToltal">Total </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <input type="text"  Val-Key="TotalMark"  class="form-control" id="txtToltal"/> 
                            </div>
                    </div>
                  </div>   
                 
                 <div class="row">
                 
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtMarksObtained">Marks Obtained </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <input type="text" Val-Key="MarksObtained" class="form-control" id="txtMarksObtained"/> 
                            </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtRemarks">Remarks </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <input type="text" Val-Key="Remarks"  class="form-control" id="txtRemarks"/> 
                            </div>
                    </div>
                    
                    
                   
                 </div>
                    <div class="row">
                        
                   <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                   </div>
                     <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                     <div class="text-center">
                    <input type="button"  value ="Save" id="Button1" onclick="SaveLJFilter(this.value);" class="btn btn-success"  />
                    <input type="button" id="Clear" class="btn btn-success" onclick="ClearLJFilter();" value="Clear"/>
                    </div>
                    </div>
                     </div>
 
                          
                    
                    
                    
            
              <div id="NoRec">
                  <label class="text-red" style="display:none">
                  No Matching Record Found..</label>
              </div>

              <div id="Div1"  runat="server" class="gridTable bounceinup">
                  <div class="table-responsive">
                      <table id="tblTraining" 
                          class="table tbl-grid table-bordered form-inline table-striped" >
                          
                          <thead>
                              <tr>
                                  <%--<th>S.No</th>--%>
                                  <th localize="SNO">S.NO</th>
                                  <th localize="MRM_lblParticipants">
                                      Participant</th>
                                  <th localize="ExamType">
                                      Exam Type</th>
                                  <th localize="TotalMarks">
                                      Total Marks</th>
                                  <th localize="ObtainedMarks">
                                      Obtained Marks</th>
                                  <th localize="Action">
                                      Action</th>
                              </tr>
                          </thead>
                      </table>
                  </div>
              </div>
      </div>
             </div>
             </div>
                  </section>
            <!-- /.content-wrapper -->
            <footer class="">  <!-- tblTraining-->
        <div class="pull-right hidden-xs gl">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2016-2017 <a href="http://attunelive.com">Attune</a>.</strong> All rights reserved.
      </footer>
        </div>
        <asp:HiddenField ID="hdnScheduleID" runat="server" />
        <asp:HiddenField ID="hdnOrgID" runat="server" Value="" />
        <asp:HiddenField ID="hdnTrainingprogramID" runat="server" Value="" />
        <asp:HiddenField ID="hdntrainingID" runat="server" Value="" />
        </form>
    </div>
    <!-- AdminLTE for demo purposes -->

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="Script/ControlLength.js" type="text/javascript"></script>

    <%--    <script src="Script/InternalQualityControl.js" type="text/javascript"></script>--%>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script type="text/javascript">
    
    </script>

    <script src="Script/moment.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <script src="Script/SheduleProgram_QMS.js" type="text/javascript"></script>

    <script type="text/javascript">



        function ValidateFilter() {
            if ($('#ddlLocation option:selected').val() == "-1") {
                ShowErrToolTip('#ddlLocation', 'Please Choose Location');
            }
            else if ($('#ddlAnalyzer option:selected').val() == "-1") {
                ShowErrToolTip('#ddlAnalyzer', 'Please Choose Analyzer');
            }
            else if ($('#ddlLotNo option:selected').val() == "-1") {
                ShowErrToolTip('#ddlLotNo', 'Please Choose LotNumber');
            }
            else if ($('#ddlAnalyte option:selected').val() == "-1") {
                ShowErrToolTip('#ddlAnalyte', 'Please Choose Analyte');
            }

            else if ($('#ddlLevel option:selected').val() == "0") {
                ShowErrToolTip('#ddlLevel', 'Please Choose Level');
            }



            else if ($('#txtFromDate').val() == "") {
                ShowErrToolTip('#txtFromDate', 'Please Choose FromDate');
            }
            else if ($('#txtToDate').val() == "") {
                ShowErrToolTip('#txtToDate', 'Please Choose Todate');
            }


            else {
                return true;
            }

            return false;

        }

        function isDate(dateVal) {
            var d = new Date(dateVal);
            return d.toString() === 'Invalid Date' ? false : true;
        }
        $(function() {

            $("#txtFromDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    var date = $("#txtFromDate").datepicker('getDate');
                    $("#txtToDate").datepicker('option', 'minDate', selectedDate);

                }
            });
            $("#txtToDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                yearRange: '1900:2100'
            });

            $("#txtFromDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));
            $("#txtToDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));



            AutoTrainer();

            LoadPrgramDetails();

            //            $('#tblProgramList tbody tr').on('click', function(event) {
            //                LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);
            //            });


            $('#btnBack').on('click', function() {
                $('#divProgramFilter').show();
                $('#tblProgramList').show();
                $('#tblTraining_wrapper').show();

                LoadPrgramDetails();
                //                $('#tblProgramList tbody tr').on('click', function(event) {
                //                    LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);
                //                });



                $('#divTriningProgram').hide();

                $('#hdnScheduleID').val('');

            });


            //            $('#divDDL').on('change', function(event) {
            //                var itemId = event.target.id;

            //                if (itemId == 'ddlLocation' || itemId == 'ddlAnalyzer' || itemId == 'ddlAnalyte' || itemId == 'ddlLotNo') {
            //                    var selectedValue = $("#" + event.target.id).find("option:selected").val();
            //                    var selectedText = $("#" + event.target.id).find("option:selected").text();
            //                    //  var Control = $('#' + itemId).parents('.box-body').find('.MachineList');
            //                    var ctrlName = getddlName(itemId)


            //                    if (itemId == 'ddlLotNo') {
            //                        selectedValue = selectedValue + '~' + $('#ddlAnalyzer').val();

            //                    }
            //                    if (itemId == 'ddlAnalyzer') {

            //                        $('#ddlLotNo').empty();
            //                        $('#ddlLotNo').append('<option value="-1">--Select---</option>');
            //                        $('#ddlAnalyte').empty();
            //                        $('#ddlAnalyte').append('<option value="-1">--Select---</option>');
            //                        $('#ddlLevel').empty();
            //                        $('#ddlLevel').append('<option value="0">--Select---</option>');

            //                    }
            //                    if (itemId == 'ddlLocation') {


            //                        $('#ddlAnalyzer').empty();
            //                        $('#ddlAnalyzer').append('<option value="-1">--Select---</option>');
            //                        $('#ddlLotNo').empty();
            //                        $('#ddlLotNo').append('<option value="-1">--Select---</option>');
            //                        $('#ddlAnalyte').empty();
            //                        $('#ddlAnalyte').append('<option value="-1">--Select---</option>');
            //                        $('#ddlLevel').empty();
            //                        $('#ddlLevel').append('<option value="0">--Select---</option>');

            //                    }

            //                    if (ctrlName != "") {

            //                        DDLAjaxCall(selectedValue, ctrlName, '../QMS.asmx/QMS_LoadCascadingDDL');

            //                    }



            //                }

            //                var attr = $(itemId).attr('aria-describedby');




            //                if (attr != 'undefined') {
            //                    $('#' + itemId).tooltip('destroy');
            //                }


            //            });

            //            $("#txtFromDate").datepicker({
            //                dateFormat: 'dd/mm/yy',
            //                //defaultDate: "+1w",
            //                //changeMonth: true,
            //                //changeYear: true,
            //                maxDate: 0,
            //                yearRange: '1900:2100',
            //                onClose: function(selectedDate) {
            //                    $("#txtToDate").datepicker("option", "minDate", selectedDate);

            //                    var date = $("#txtFromDate").datepicker('getDate');

            //                }

            //            });
            //            $("#txtToDate").datepicker({
            //                minDate: 1,
            //                maxDate: 0,
            //                //defaultDate: "+1w",
            //                onSelect: function(theDate) {
            //                    if (theDate != $("#txtFromDate").val()) {
            //                        var date = $("#txtToDate").datepicker('getDate');
            //                        //$("#txtmaintDueDate").datepicker("option", "minDate", new Date(date));
            //                    }
            //                    else {
            //                        $("#txtToDate").datepicker('option', 'minDate', new Date(theDate));
            //                    }
            //                },

            //                dateFormat: 'dd/mm/yy'



            //            });



            //  DDLAjaxCall('', 'ddlLocation', '../QMS.asmx/QMS_LoadCascadingDDL');



        });


        //        $("#txtFromDate").datepicker({
        //            dateFormat: 'dd/mm/yy',
        //            //defaultDate: "+1w",
        //            //changeMonth: true,
        //            //changeYear: true,
        //            maxDate: 0,
        //            yearRange: '1900:2100',
        //            onClose: function(selectedDate) {
        //                $("#txtToDate").datepicker("option", "minDate", selectedDate);

        //                var date = $("#txtFromDate").datepicker('getDate');

        //            }

        //        });
        //        $("#txtToDate").datepicker({
        //            minDate: 1,
        //            maxDate: 0,
        //            //defaultDate: "+1w",
        //            onSelect: function(theDate) {
        //                if (theDate != $("#txtFromDate").val()) {
        //                    var date = $("#txtToDate").datepicker('getDate');
        //                    //$("#txtmaintDueDate").datepicker("option", "minDate", new Date(date));
        //                }
        //                else {
        //                    $("#txtToDate").datepicker('option', 'minDate', new Date(theDate));
        //                }
        //            },

        //            dateFormat: 'dd/mm/yy'



        //        });



      
       
        
        
    </script>

</body>
</html>
