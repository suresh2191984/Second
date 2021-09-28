<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LJChartView.aspx.cs" EnableEventValidation="false"
    Inherits="QMS_AnalyteMaster" %>

<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script src="../QMS/Script/dist/JsonScript.js" type="text/javascript"></script>

<script src="../QMS/Script/dist/jspdf.min.js" type="text/javascript"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script src="../QMS/Script/dist/canvasjs.min.js" type="text/javascript"></script>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>--%>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Level's Comparison - LJ Chart</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    
      <link rel="stylesheet" href="plugins/iCheck/all.css" type="text/css">
     <link rel="stylesheet" href="plugins/multiSelect/css/bootstrap-multiselect.css" type="text/css" />
     
<%--    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />--%>
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" /> 
    <%--<link href="Script/tooltip.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>
    <link href="Script/jquery-ui-git.css" rel="Stylesheet" type="text/css" />
   

<%--    <script type="text/javascript">
        //Sys.Application.add_load(jScript);
     
    </script>--%>

    <style type="text/css">
        
        
        .round{
    border-radius: 100%;
    padding: 6px;
    width: 2px;
    height: 2px;
transform: rotate(0 deg);
}
#span1 {    
    width: 10px;
    display: block;   
}
.padleft 
{
    padding-left: 5px;
}

.inline
{
display: inline;
    padding: 10px;
    font-size: 12px;
    font-weight:bold;
}

        .hide_Column
        {
            display: none;
        }
        .Okay
        {
            color: Green;
        }
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
            width: 160px ! important;
        }
        .required
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
         .flow
        {
            float:left;
        }
        .Wrong
        {
            color: Red;
        }
        
     
        
        #graph
        {
            position: inherit;
            left: 10px;
            right: 10px;
            top: 40px;
            padding-top: 40px;
            bottom: 100px;
            text-align: left;
           padding-left:10px;
            width: 97%; 
            font-size:14px;
            height: 285px;
        }
       
        
        #OuterGraph
        {
             width: 97%; 
            height:  440px;
            background-color:White;
            font-size:14px; 
             font-family: "verdana", Times, serif;

                   }
        
        
      #AnalyzerFilter,#SDDetails {
    font-family: "verdana", Times, serif;
font-size:14px; 
   font-weight:bold;
    color:Black; 
}

#AnalyzerFilter,#SDDetails
{
        
    letter-spacing: 1.6px;
    
}
.dygraph-axis-label.dygraph-axis-label-y
{
    
    

   /* line-height: 6;*/
   
    width: 90px;
    font-size: 9px;
    padding-right: 100px;
        color: black;
      font-weight: bold;
 
}
.dygraph-axis-label.dygraph-axis-label-x 
{
    
        color: black;
font-weight: bold;
    line-height: 4;
    font-weight:bold;
       /*padding-top: 30px !important;*/
           font-size: 14px;
   /* width: 90px; */
    
    /* Safari */
    -webkit-transform: rotate(80deg);
    /* Firefox */
    -moz-transform: rotate(80deg);
    /* IE */
    -ms-transform: rotate(80deg);
    /* Opera */
    -o-transform: rotate(80deg);
    /* Internet Explorer */
    filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
}

.legend {
    -webkit-box-shadow: 0px 0px 5px #808080;
    -moz-box-shadow: 0px 0px 5px #808080;
    border: 0px solid #000000;
    background-color: #CACFD9;
    padding: 5px;
    
    font-size: 10pt;
    color: #000080;
    text-align: left;
    outline: 1px solid #483D8B;
}
.GraphTitle {
    color: #696969;
    text-align:center;
    font-size: 22px;
    font-weight: bold;
        padding-top: 5px;
    
}


.annotation-info.editable {
        min-width: 180px;  /* prevents squishing at the right edge of the chart */
      }
      .dygraph-annotation-line {
        box-shadow: 0 0 4px gray;
      }
      .annotation
      {
           border:0px;
            font-size:12px;
            width:30px;
            padding:3px;
              font-weight:bold;
            background-color:transparent;
             text-shadow: 2px 0 0 #fff, -2px 0 0 #fff, 0 2px 0 #fff, 0 -2px 0 #fff, 1px 1px #fff, -1px -1px 0 #fff, 1px -1px 0 #fff, -1px 1px 0 #fff;
       }
      .bold{font-weight: bold; font-family:Verdana;}
     .small{
            width: 150px !important;
        }
      
    </style>

      <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
        <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="test" runat="server" UpdateMode="Always">
            <ContentTemplate>
             <uc1:MainHeader ID="MainHeader" runat="server" />
                <!-- /.sidebar -->
                </aside>
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper" id="contentid">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content" style="overflow-y: auto;">
          <div class="fadeindown" id="maincontent" style="padding:10px;">
          <div id="divDDL">
              <div class="row">
                    <div class="col-md-12">
                                <h4 class="strong">Level's Comparison - LJ Chart</h4>
                    </div>
                </div>
                <div class="row">
                
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="lblLocation" runat="server" Text="Location" localize="LJChartView_lblLocation"></asp:Label>
                            <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <div class="form-group"> <select id="ddlLocation"  class="form-control ">
                                    <option value="-1">--Select---</option>
                                 </select>
                            </div>
                            </div>
                    </div>
                                         
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblAnalyzer" runat="server" Text="Analyzer" localize="LJChartView_lblAnalyzer"></asp:Label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                    
                    
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                
                               <select id="ddlAnalyzer"  class="form-control">
                                    <option value="-1">--Select---</option>
                                  </select>
                            
                            </div>
                    </div>
                    
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                              <asp:Label ID="lblLot" runat="server" Text="Lot Name" localize="LJChartView_lblLot"></asp:Label>
                              <span style="color:Red">*</span>
                            </div>
                    </div>
                  <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            
                                  <select id="ddlLotNo"  class="form-control">
                                   
                                      <option value="-1">--Select---</option>
                                 </select>
                            </div>
                    </div>
                    </div>
                       <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblAnalyte" runat="server" Text="Analyte" localize="LJChartView_lblAnalyte"></asp:Label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                      
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                               <select id="ddlAnalyte"  class="form-control">
                               <option value="-1">--Select---</option>
                                   
                                  </select>
                            </div>
                    </div>
               
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                              <asp:Label ID="lblLevel" runat="server" Text="Level" localize="LJChartView_lblLevel"></asp:Label>
                              <span style="color:Red">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                  <select class="multiselect form-control" id="ddlLevel" multiple="multiple">
                                   <%--<option value="-1">--Select---</option>--%>
                                     <option value="COne">C1</option>
                                    <option value="CTwo">C2</option>
                                    <option value="CThree">C3</option>
                                      
                                 </select>
                            </div>
                    </div>
                  
               
                                        </div>
                    

                       
                
                    <!--Row-->
                 
           
                    <div class="row" >
                        
                      <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <div class="form-group">
                                <asp:Label ID="lblFromDate" runat="server" Text="From Date" localize="LJChartView_lblFromDate"></asp:Label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                        <div class="form-group">
                           <div class="input-group date">
                           <input type="text" id="txtFromDate" readonly="readonly" class="form-control" />
                     <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                              </div>
                            </div>
                         </div>
                    </div>                    
                      <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <div class="form-group">
                                <asp:Label ID="lblToDate" runat="server" Text="To Date" localize="LJChartView_lblToDate"></asp:Label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                        <div class="form-group">
                           <div class="input-group date">
                           <input type="text" id="txtToDate" readonly="readonly" class="form-control" />
                           <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                              </div>
                            </div>
                         </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                    <input type="button"  value ="Search" id="btnFilter" class="btn btn-success" localize="LJChartView_btnFilter" />
                    <input type="button" id="Clear" class="btn btn-success" onclick="ClearLJFilter();" value="Clear" localize="Clear" >
                    </div>
                     </div>
                        </div>
                   
       
              </br>
                <div id="chartContainer" style="height: 300px; width: 100%;"></div>
               <div id="NoRec"  >
                  
                  <label class="text-red" localize="NoMatchingRecordFound">No Matching Record Found..</label>
                  
                  </div>
              <div id="FilterResult">
            
            <div id="ShowDate" class="pull-right  text-bold" style="padding-right:20px">
                
                </div>
              <div id="AnalyzerFilter" style="padding-left: 15px;">
                <div class="row" style="display:none" >
                    <table id="tblAnalyzerDtls" class="table table-bordered table-responsive">
                        <tbody>
                        </tbody>
                    </table>
                </div>
                   </div>
                   
                   <div id="SDDetails" style="padding-left: 15px;" >
                <div class="row"  style="display:none">
                    <div class="table-responsive col-lg-4">
                        <table id="tblSDValues" class="table table-bordered col-lg-6">
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="table-responsive col-lg-8">
                        <table id="tblValues" class="table table-bordered">
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
             
                 </div>
              
                <div id="OuterGraph">
                <div class="GraphTitle"> Levey-Jennings Comparison chart</div>
                    <div id="graph" >
                    
                    </div>
                    <%--<div id="chartContainer" style="height: 300px; width: 100%;"></div>--%>

                     <div style="padding-top: 85px;padding-left: 70px; display:none;"><b style="color:Black">Legends:</b>
                    <div  style="display:none">
                    <li class="fa fa-circle inline" style="color:green" > <b style="color:Black">:Passed</b>  </li>
                    <li class="fa fa-circle inline" style="color:#ffdb99">  <b style="color:Black">:Warning</b> </li>
                    <li class="fa fa-circle inline" style="color:red">  <b style="color:Black">:Rejected</b> </li>
                    <li class="inline">  <b style="color:Black">TM : Target Mean</b> </li>                  
                    </div>
                    </div>
                    </div>
                </div>
                </br>
               </br>
                  <div  style="display:none">
                   <input type="button" id="GeneratePDF" class="btn-info pull-right " value="Download PDF" visible="false"  />
                  </div>
                   </br>
                   </br>
                
                     <div class="gridTable bounceinup" id="DeviceList" runat="server"  style="display:none">
                     
                            <div class="table-responsive"  style="display:none">
                              <table class="table tbl-grid table-bordered form-inline table-striped bold" id="tblQCValues" style="display:none" >
                                  <thead>
                                        <tr>
                                            <%--<th>S.No</th>--%>
                                            <th localize="DateTime">Date Time</th>
                                            <th localize="Value">Value</th>
                                            <th localize="TargetMean">Target Mean</th>
                                            <th localize="Deviation">Deviation</th>
                                            <th localize="QCStatus">QC Status</th>
                                            <th localize="FailedRule">Failed Rule</th>
                                            <th localize="Reason">Reason</th>
                                            <th localize="CorrectionAction">Correction Action</th>
                                            <th localize="Preventive Action">Preventive Action</th>
                                             <th class="hide_Column">QCValueID</th>
                                            <th localize="Action">Action</th>                                            
                                        </tr>
                                  </thead>
                              </table>
                           </div>
                    </div>
                    
                    </br>
                     <div  style="display:none">
                   <input type="button" id="btnUpdate" class="btn-info pull-right " value="Update QC Status"  visible="false" />
                   </div>
                   </br>
               <div  class="row"> 
               <div  id="SaveBtnDiv" class="form-group text-center" style ="display :none ;">    
                    
                         <input type =button  id="btnClear"  class="btn btn-success" value ="Clear" />
                        <input type =button  id="btnSave"  class="btn btn-success" value ="Save" />
                        <input type=button id="btnEdit"  class="btn btn-primary" value  ="Edit" />
               </div>
                   </div> 
                </div>
                </div>
                
                <input type="hidden" id="PrintPage" name="Language" value="0">
                <input type="hidden" id="hdnSDDetails" name="Language" value="0">
                <input type="hidden" id="hdnGrpImg" name="Language" value="0">
                <input type="hidden" id="hdnTable" name="Language" value="0">
                
               </div>
                 <input id="hdnOrgID" type="hidden" runat="server" />
                </section>
                <!-- /.content -->
                </div>
                
                
                  </div>
                  <canvas id="myCanvas" style="display: none;"></canvas>
                   <canvas id="myCanvas2" style="display: none;"></canvas>
                  
                <!-- /.content-wrapper -->
                <footer class="main-footer">
        <div class="pull-right hidden-xs gl">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2016-2017 <a href="http://attunelive.com">Attune</a>.</strong> All rights reserved.
      </footer>
            </ContentTemplate>
        </asp:UpdatePanel>
        </form>
    </div>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js" type="text/javascript"></script>
    
    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="plugins/dygraph/dygraph-combined-dev.js" type="text/javascript"></script>
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>
    
    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>
      <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
      
    <script src="Script/LJComparisonChart.js" type="text/javascript"></script>

   <%-- <script src="Script/jspdf.min.js" type="text/javascript"></script>--%>

    <script src="dist/js/jquery-1.11.2-ui.min.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
    <script>
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>
    <%--<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>--%>


    <script src="Script/html2canvas.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>





    <script type="text/javascript">

var ChartObj;
        function ShowErrToolTip(ID, Content) {
            var tooltipOptions = {
                container: 'body',
                html: true,
                trigger: 'manual',
                title: function() {
                    // here will be custom template
                    var id = 'TEST';

                    return Content;
                },
           placement:"bottom",
            };

            tip = $(ID);
            tip.tooltip(tooltipOptions);
            tip.tooltip('show');

        }
        
        
        function ValidateFilter()
        {
        if($('#ddlLocation option:selected').val()=="-1")
        {
        ShowErrToolTip('#ddlLocation', 'Please Choose Location');
        }
        else  if($('#ddlAnalyzer option:selected').val()=="-1")
        {
        ShowErrToolTip('#ddlAnalyzer', 'Please Choose Analyzer');
        }
        else  if($('#ddlLotNo option:selected').val()=="-1")
        {
        ShowErrToolTip('#ddlLotNo', 'Please Choose LotNumber');
        }
        else  if($('#ddlAnalyte option:selected').val()=="-1")
        {
        ShowErrToolTip('#ddlAnalyte', 'Please Choose Analyte');
        }
        
        else  if($('#ddlLevel option:selected').val()=="0")
        {
        ShowErrToolTip('#ddlLevel', 'Please Choose Level');
        }
       
        else  if($('#txtFromDate').val()=="")
        {
        ShowErrToolTip('#txtFromDate', 'Please Choose FromDate');
        }
        else  if($('#txtToDate').val()=="")
        {
        ShowErrToolTip('#txtToDate', 'Please Choose Todate');
        }
        
        
        else
        {
        return true;
        }
        
        return false;
        
        }
        
        function isDate(dateVal) {
  var d = new Date(dateVal);
  return d.toString() === 'Invalid Date'? false: true;
}
        $(function() {
    
        
        $('#OuterGraph').hide();
       $('#NoRec').hide();
        
        $('.tooltip-inner').on('click',function(event)
        {
       
        });
             
        $('#divDDL').on('change', function (event) {
                var itemId = event.target.id;
               
               if(itemId=='ddlLocation' || itemId=='ddlAnalyzer'||itemId=='ddlAnalyte'||itemId=='ddlLotNo')
               {
                var selectedValue = $("#" + event.target.id).find("option:selected").val();
                var selectedText = $("#" + event.target.id).find("option:selected").text();
                //  var Control = $('#' + itemId).parents('.box-body').find('.MachineList');
                var ctrlName = getddlName(itemId)
                
                  
                  if( itemId=='ddlLotNo')
                  {
                  selectedValue=selectedValue+'~'+$('#ddlAnalyzer').val();
                  
                  }
                if( itemId=='ddlAnalyzer')
               {
             
                   $('#ddlLotNo').empty();
                   $('#ddlLotNo').append('<option value="-1">--Select---</option>');
                   $('#ddlAnalyte').empty();
                $('#ddlAnalyte').append('<option value="-1">--Select---</option>');
//                $('#ddlLevel').empty();
//                   $('#ddlLevel').append('<option value="0">--Select---</option>');
               
               }
                if( itemId=='ddlLocation')
               {
               
               
               $('#ddlAnalyzer').empty();
                   $('#ddlAnalyzer').append('<option value="-1">--Select---</option>');
                   $('#ddlLotNo').empty();
                   $('#ddlLotNo').append('<option value="-1">--Select---</option>');
                   $('#ddlAnalyte').empty();
                $('#ddlAnalyte').append('<option value="-1">--Select---</option>');
//                   $('#ddlLevel').empty();
//                   $('#ddlLevel').append('<option value="0">--Select---</option>');
               
               }

                if (ctrlName != "") {

                    DDLAjaxCall(selectedValue, ctrlName, '../QMS.asmx/QMS_LoadCascadingDDL');

                }
                
                
                
               }
                
              var attr=  $(itemId).attr('aria-describedby');
              
              
              
              
              if(attr!='undefined')
              {
               $('#'+ itemId).tooltip('destroy');
              }
              

            });
        $("#txtFromDate").datepicker({
            dateFormat: 'dd/mm/yy',
            //defaultDate: "+1w",
            //changeMonth: true,
            //changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtToDate").datepicker("option", "minDate", selectedDate);

                var date = $("#txtFromDate").datepicker('getDate');

            }

        });
        $("#txtToDate").datepicker({
            minDate: 1,
             maxDate: 0,
            //defaultDate: "+1w",
            onSelect: function(theDate) {
            if (theDate != $("#txtFromDate").val()) {
                    var date = $("#txtToDate").datepicker('getDate');
                    //$("#txtmaintDueDate").datepicker("option", "minDate", new Date(date));
                }
                else {
                    $("#txtToDate").datepicker('option', 'minDate', new Date(theDate));
                }
            },

            dateFormat: 'dd/mm/yy'

            
           
        });

       
            $('#tblQCValues').css("visibility", "hidden");
             $('#GeneratePDF').css("visibility", "hidden");
              $('#btnUpdate').css("visibility", "hidden");
             

            DDLAjaxCall('', 'ddlLocation', '../QMS.asmx/QMS_LoadCascadingDDL');
            //DDLAjaxCall('ddlLevel', 'ddlLevel', '../QMS.asmx/QMS_LoadCascadingDDL');

            $('#btnFilter').on('click', function(event) {
             if(ValidateFilter()==true){
                //LoadLJChart();
                LoadLJComparisonChart();
                }
            });

            $('#GeneratePDF').on('click', function(event) {

                //GeneratePDF();
               funexportButton();
            });
            $('#btnUpdate').on('click', function(event) {

                //GeneratePDF();
               funUpdateQCStatus();
            });
        });

        function GeneratePDF() {
        var data ;
var specialElementHandlers = {
    '#editor': function(element, renderer){
        return true;
    }
};


                //var som = convertImgToBase64(imageurl);
        var canvas3 = document.getElementById("EXcanvas");
       // var canvas1 = $("#chartContainerLevel1 .canvasjs-chart-canvas").get(0);
       // var canvas3 = $("#chartContainerLevel3 .canvasjs-chart-canvas").get(0);
        // var canvas4 = $("#chartContainerLevel4 .canvasjs-chart-canvas").get(0);
        // var dataURL1 = canvas1.toDataURL();
        
        
        //  var c = document.getElementsByTagName("canvas")[0];
        
        var c = $('#DameIT')[0];
  // save canvas image as data url (png format by default)
	
    //  var dataURL2 = c.toDataURL();
     //   var dataURL1 = canvas1.toDataURL();
     //   var dataURL3 = canvas3.toDataURL();
        //var dataURL4 = canvas4.toDataURL();
        var pdf = new jsPDF();
        var doc = new jsPDF('p', 'mm');
        // var img = canvas.toDataURL("../Images/Logo/Thyrocare.png/png");
        // doc.addImage(dataURL1, 'PNG', 0, 50, 200, 100); // A4 sizes
        //doc.addPage();
        //alert(Imgurl);
        //doc.addImage(som, 'PNG', 0, 50, 10, 50);
        var From = document.getElementById('txtFromDate').value;
        var To = document.getElementById('txtToDate').value;
        //doc.addImage(imageurl, 'JPEG', 15, 40, 180, 160);
     //   doc.addImage(imageurl, 'PNG', 10, 5, 28, 12);
        doc.setDrawColor(0);
        doc.setFillColor(255, 255, 255);
        doc.roundedRect(10, 20, 190, 275, 3, 3, 'FD');
      
      var PrintDate = document.getElementById('PrintPage').value ;
        doc.addImage(PrintDate, 'JPEG', 15, 35, 180, 25);
        
        
        
         var PrintSD = document.getElementById('hdnSDDetails').value ;
        doc.addImage(PrintSD, 'JPEG', 15, 60, 180, 30);
        
          var PrintGrph = document.getElementById('hdnGrpImg').value ;
        doc.addImage(PrintGrph, 'JPEG', 15, 100, 180, 80);
          doc.setFontSize(13);
        doc.text(100, 8, 'QC Report');
        doc.setFontSize(10);
        doc.text(90, 14, ' Date ' + From + '  - ' + To);
        doc.setFontSize(10);
        doc.text(60, 291, 'Verified By');
        doc.text(150, 291, 'Approved By');
        
        
var canvas = document.getElementById('myCanvas');
var context = canvas.getContext('2d');
var img = new Image();

img.onload = function() {
  context.drawImage(this, 0, 0, canvas.width, canvas.height);
}

img.src =  document.getElementById('hdnTable').value;

//if (img.height >600)
//{
doc.addPage();
           doc.setDrawColor(0);
        doc.setFillColor(255, 255, 255);
        doc.roundedRect(10, 20, 190, 275, 3, 3, 'FD');
        var PrintTbl = document.getElementById('hdnTable').value ;
        
        
                        var sourceX = 0;
                        var sourceY = 0;
                        var sourceWidth = img.width-72;
                        var sourceHeight = 1570;
                        var destWidth = sourceWidth;
                        var destHeight = sourceHeight;
                        var destX = 0;
                        var destY = 0;
                        var canvas2 =document.getElementById('myCanvas2');
                        canvas2.setAttribute('height', destHeight);
                        canvas2.setAttribute('width', destWidth);                         
                        var ctx2 = canvas2.getContext("2d");
                        ctx2.drawImage(img, sourceX, 
                                             sourceY,
                                             sourceWidth,
                                             sourceHeight, 
                                             destX, 
                                             destY, 
                                             destWidth, 
                                             destHeight);
        
        doc.addImage(canvas2, 'JPEG', 15, 22, 180, 0);
        
     //   doc.addImage(dataURL2, 'JPEG', 15, 106, 183, 76);
     //   doc.addImage(dataURL2, 'JPEG', 15, 190, 183, 76);
        doc.setFontSize(13);
        doc.text(100, 8, 'QC Report');
        doc.setFontSize(10);
        doc.text(90, 14, ' Date ' + From + '  - ' + To);
        doc.setFontSize(10);
      
      
                       
      
        // doc.text(150, 285, 'Lab QC Incharge');
        // doc.addPage();  
        
//        }  
//        else 
//        {
//        var PrintTbl = document.getElementById('hdnTable').value ;
//        doc.addImage(PrintTbl, 'JPEG', 15, 170, 180, 0);
//          doc.setFontSize(10);
//        doc.text(60, 291, 'Verified By');
//        doc.text(150, 291, 'Approved By');
//        } 



var croppingYPosition = 1570;
                count = (img.height) / 1570;

                for (var i =1; i < count; i++) {
                        doc.addPage();
                          doc.setFontSize(13);
                          
        doc.text(100, 8, 'QC Report');
        doc.setFontSize(10);
        doc.text(90, 14, ' Date ' + From + '  - ' + To);
        doc.setFontSize(10);
          doc.setDrawColor(0);
        doc.setFillColor(255, 255, 255);
        doc.roundedRect(10, 20, 190, 275, 3, 3, 'FD');
                        var sourceX = 0;
                        var sourceY = croppingYPosition;
                        var sourceWidth = img.width-72;
                        var sourceHeight = 1570;
                        var destWidth = sourceWidth;
                        var destHeight = sourceHeight;
                        var destX = 0;
                        var destY = 0;
                        var canvas1 = document.createElement('canvas');
                        canvas1.setAttribute('height', destHeight);
                        canvas1.setAttribute('width', destWidth);                         
                        var ctx = canvas1.getContext("2d");
                        ctx.drawImage(img, sourceX, 
                                             sourceY,
                                             sourceWidth,
                                             sourceHeight, 
                                             destX, 
                                             destY, 
                                             destWidth, 
                                             destHeight);
                      //  var image2 = new Image();
                      //  image2 = Canvas2Image.convertToJPEG(canvas1);
                       // image2Data = image2.src;
                         doc.addImage(canvas1, 'JPEG', 15, 22, 180, 0);
                       
                        croppingYPosition += destHeight;              
                    }



        doc.save("QC_Details.pdf");
        return false;


        }
        
        
         function funexportButton() {

        //var img = $('#imgLogo').attr('src');
        // USE this link to encrypt the image http://www.askapache.com/online-tools/base64-image-converter/
     
        //var som = convertImgToBase64(imageurl);
        var pdf = new jsPDF();
        var doc = new jsPDF('p', 'mm', [210, 297]);
        var From = document.getElementById('txtFromDate').value;
        var To = document.getElementById('txtToDate').value;
       // doc.addImage(imageurl, 'PNG', 10, 5, 28, 12);
        doc.setDrawColor(0);
        doc.setFillColor(255, 255, 255);
        
      
//            var canvas3 = $("#myCanvas .canvasjs-chart-canvas").get(0);
//            var dataURL3 = canvas3.toDataURL();
//            doc.roundedRect(10, 188, 190, 80, 3, 3, 'FD');
//            doc.addImage(dataURL3, 'JPEG', 15, 190, 183, 76);
            
       
        var PrintDate = document.getElementById('PrintPage').value ;
        doc.addImage(PrintDate, 'TIF', 15, 35, 180, 25);
        doc.setFont("courier", "bold");
        
        
        
         var PrintSD = document.getElementById('hdnSDDetails').value ;
        doc.addImage(PrintSD, 'TIF', 15, 60, 180, 30);
        doc.setFont("courier", "bold");
        
          var PrintGrph = document.getElementById('hdnGrpImg').value ;
        doc.addImage(PrintGrph, 'TIF', 15, 85, 180, 80);
       
        var PrintTbl = document.getElementById('hdnTable').value ;
        doc.addImage(PrintTbl, 'JPEG', 15, 170, 180, 0);       
        doc.setFontSize(13);
        doc.text(100, 8, 'QC Report');
        doc.setFontSize(10);
        doc.text(90, 14, ' Date ' + From + '  - ' + To);
        doc.setFontSize(10);
        doc.text(60, 291, 'Verified By');
        doc.text(150, 291, 'Approved By');
         doc.setFont("courier", "bold");
        // doc.text(150, 285, 'Lab QC Incharge');



        // doc.addPage();

        //doc.setFontSize(10);
        //doc.text(50, 285, 'Page 2');
        //doc.addPage();

        //                doc.setFontSize(10);
        //                doc.text(50, 285, 'Page 3');
        // doc.printout();
        // doc.output('datauri');
        doc.save("QC_Details.pdf");
        return false;
    }
        
        
    </script>

</body>
</html>
