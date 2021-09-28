<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="PNC.aspx.cs" Inherits="QMS_PNC" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Process Non Conformance</title>
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
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <link href="Script/tooltip.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- AdminLTE App -->

    <script type="text/javascript">
        //Sys.Application.add_load(jScript);
     
    </script>

    <style type="text/css">
        .hide_Column
        {
            display: none;
        }
        html
        {
            font-family: "Times New Roman" , Times, serif;
            font-size: 90%;
        }
        div.scroll
        {
            overflow: scroll;
        }
        label
        {
            font-weight: 100 !important;
        }
    </style>
    <link href="http://code.jquery.com/ui/jquery-ui-git.css" rel="Stylesheet" type="text/css" />
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
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content" style="overflow-y: auto;">
          <div class="fadeindown" id="divMainContent">
          <div class="row">
                    <div class="col-md-12">
                                <h4 class="strong">Process Non Conformance</h4>
                    </div>
                </div>
        <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <asp:label ID="lblNPCNO" Text="Process Non Conformity No" runat="server" localize="PNC_lblNPCNO"></asp:label>
                                 <%--<label  id="lblNPCNO" ><label>--%>
                            </div>
                    </div>
                   
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <input type="text" id="txtNPCNO" class="form-control" />
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <label  id="lblDept" localize="PNC_lblDept">Department</label>
                                 <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <select id="ddlDepartment"  class="form-control">
                            </select>
                                
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <label id="lbldate"  localize="PNC_lbldate">Date</label>
                                   <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                              <div class="form-group">
                                               <div class="input-group date">
                            <div class="form-group">
                                 <input type="text" id="txtDate" readonly="readonly" class="form-control pull-right datepicker" />
                                 
                            </div>
                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                              </div>
                                            </div>
                                         </div>
                            
                          
                                            
                                              
                    </div>
                    </div>
                    
                    
       <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <label  id="lblPNCDescrip" localize="PNC_lblPNCDescrip">PNC Description</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <input type="input" Val-Key="PNCDescription" id="txtPNCDescrip" class="form-control" />
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblPerson" localize="PNC_lblPerson">Responsible Person</label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <div class="icon-addon addon-md ">
                                 <input type="text" id="txtPerson" Val-Key="SPOCName" class="form-control" onclick="clearfields();" />
                                 <asp:Label ID="Label1" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                  </div>
                            </div>
                    </div>                  
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblClassify" localize="PNC_lblClassify">Classification</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <select id="ddlClassify" class="form-control">
                                 <option value='0' selected="selected">-- Select --</option>
                                 <option value='1'>Minor NC</option>
                                 <option value='2'>Major NC</option>
                                 </select>
                            </div>
                    </div>
                    </div>
       <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <label  id="lblRCA" localize="PNC_lblRCA">Root Cause Analysis</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <input type="input" Val-Key="PNCDescription" id="txtRCA" class="form-control" />
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblCorrection" localize="PNC_lblCorrection">Correction</label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <input type="text" Val-Key="PNCDescription" id="txtCorrection" class="form-control" />
                            </div>
                    </div>                  
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblCorrctiveAction" localize="PNC_lblCorrctiveAction" >Corrective Action Proposed</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <input type="text" Val-Key="PNCDescription" id="txtCorrectiveAction" class="form-control" />
                            </div>
                    </div>
                    </div>
       <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <label  id="lblPAProposed" localize="PNC_lblPAProposed" >Preventive Action Proposed</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <input type="input" Val-Key="PNCDescription" id="txtPAProposed" class="form-control" />
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblCompDate" localize="PNC_lblCompDate">Proposed Completion Date</label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                          <div class="form-group">
                                               <div class="input-group date">
                            <div class="form-group">
                                 <input type="text" id="txtCompDate" readonly="readonly" class="form-control pull-right datepicker" />
                         </div>
                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                              </div>
                                            </div>
                                         </div>
                    </div>    
                    
                   
                                
                                 
                            
                                         
                                                        
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblActionTaken" localize="PNC_lblActionTaken">ActionTaken</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <input type="text" Val-Key="PNCDescription" id="txtAction" class="form-control" />
                            </div>
                    </div>
                    </div>
       <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <label  id="lblComments" localize="PNC_lblComments" >Comments</label>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            <input type="input" Val-Key="PNCDescription" id="txtComments" class="form-control" />
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <label id="lblStatus" localize="PNC_lblStatus">Status</label>
                                <span style="color:Red">*</span>
                            </div>
                    </div>
                      <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <select id="ddlStatus" class="form-control">
                                <option value="0">---Select---</option>
                                <option>Open</option>
                                <option>Close</option>
                                </select>
                            </div>
                    </div>
                    
                    </div>
        </div>
         <!-- Row -->
                <div class="row">
                    <div class="form-group text-center">
                         <input type="button" id="btnClear" CssClass="btn btn-success" value="Clear" localize="PNC_btnClear" />
                        <input type="button" id="btnSave"  CssClass="btn btn-success"   value="Save" localize="PNC_btnSave"/>
                    </div>
                </div>
        
          <div class="gridTable bounceinup" id ="pnlPNCDetails" runat="server" style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblPNCDetails">
                                  <thead><tr>
                                       
  <th localize="QMS_Dashboard_aspx_PNCNO">PNC No</th>
  <th localize="PNC_lblDept">Department</th>
  <th localize="ProcessDate">Process Date</th>
  <th localize="PNC_lblPNCDescrip">Description</th>
 <th class="hide_Column">NCClassification</th>
<th class="hide_Column">RootCause</th>
  <th class="hide_Column">Correction</th>
  <th class="hide_Column">Correctiveaction</th>
  <th class="hide_Column">PreventiveAction</th>
     <th localize="PNC_lblCompDate">Proposed Completion Date</th>
  <th localize="PNC_lblComments">Comments</th>
  <th localize="QMS_Dashboard_aspx_CreatedBy">Created By</th>
  <th localize="PNC_lblPerson">Responsible Person</th>
  <th localize="ActionTaken">Action Taken</th>
  <th localize="status">status</th>
 <th localize="Edit">Edit</th>
   <th localize="Delete">Delete</th>
                                            
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>
           </section>
                </div>
                <!-- /.content-wrapper -->
                <footer class="main-footer">
        <div class="pull-right hidden-xs">
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

    <script src="Script/jspdf.min.js" type="text/javascript"></script>
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->
    <!-- Rule Master  JS Script Referance-->

    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
    
    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <script src="Script/moment.js" type="text/javascript"></script>
<link href="Script/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="Script/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>
    <script src="Script/QMS_PNS.js" type="text/javascript"></script>

    <!-- End-->
    <%--Hiden Controls--%>
    <input id="hdnSelectedLotID" type="hidden" runat="server" />
    <input id="hdnOrgID" type="hidden" runat="server" />
    <input id="hdnRespPerson" type="hidden" runat="server" value="0" />
    <input id="hdnAnalyteId" type="hidden" runat="server" />
    <input id="hdnManufacturerRefRange" type="hidden" runat="server" />
    <input id="hdnManufacturerMean" type="hidden" runat="server" />
    <input id="hdnRun" type="hidden" runat="server" />
    <input id="hdnLabRefRange" type="hidden" runat="server" />
    <input id="hdnLabMean" type="hidden" runat="server" />
    <input id="hdnLabSD" type="hidden" runat="server" />
    <input id="hdnLJChartCalculation" type="hidden" runat="server" />
    <input id="hdnQCRID" type="hidden" runat="server" />
    <%--End Of Hidden Control List--%>


    <script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <script>
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>



    <script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>

    <script type="text/javascript">
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


        
               
               
            
   
        
    </script>

</body>
</html>
