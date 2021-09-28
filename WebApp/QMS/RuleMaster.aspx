<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RuleMaster.aspx.cs" Inherits="QMS_RuleMaster" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Rule Master</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
   <%-- <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.css">--%>
    <!-- Ionicons 2.0.0 -->
    <!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
     <!-- bootstrap datepicker -->
     <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />
      <!-- iCheck for checkboxes and radio inputs -->
      <link rel="stylesheet" href="plugins/iCheck/all.css" type="text/css">
    <!-- Theme style -->
    <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
     .required
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
        
    </style>
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
    <form id="form1" runat="server">
        <uc1:MainHeader ID="MainHeader" runat="server" />
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
          <section class="content">
          <div class="fadeindown">
              <div class="row">
                    <div class="col-md-12">
                                <h4 class="strong">Rule Master</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblLotNo" runat="server" Text="Lot No" localize="RuleMaster_lblLotNo"></asp:Label>
                                 <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlLotNo" runat="server" CssClass="form-control">
                             
                                 </asp:DropDownList>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblLotName" runat="server" Text="Lot Name" localize="RuleMaster_lblLotName"></asp:Label>
                                
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <asp:TextBox ID="txtLotName" runat="server" CssClass="form-control"  disabled></asp:TextBox>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblLevel" runat="server" Text="Level" localize="RuleMaster_lblLevel"></asp:Label>
								 <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <asp:DropDownList ID="ddlLevel" change="ddlLotNo" disabled="disbled" runat="server" CssClass="form-control">
                                
                                <%--<asp:DropDownList ID="ddlLevel" change="ddlLotNo" runat="server" CssClass="form-control">--%>
                          
                                 </asp:DropDownList>
                            </div>
                    </div>
                    </div>
                    <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblAnalyte" runat="server" Text="Analyte" localize="RuleMaster_lblAnalyte"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                             <div class="icon-addon addon-md ">
                            <asp:TextBox ID="AnalyteName" Val-Key="AnalyteName" runat="server" CssClass="form-control autosuggest" ></asp:TextBox>
                              <asp:Label ID="Label1" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                  </div>
                                <%--<asp:DropDownList ID="ddlAnalyte" runat="server" CssClass="form-control ">
                                     <asp:ListItem Text="Uric Acid"></asp:ListItem>
                                     <asp:ListItem Text="Numeric"></asp:ListItem>
                                 </asp:DropDownList>--%>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblManufactRefRange" runat="server" Text="Manufacturer Ref Range" localize="RuleMaster_lblManufactRefRange"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:TextBox ID="txtManufactRefRange" Val-Key="ManufacturerRefRange" runat="server" CssClass="form-control OnlyAlpha" placeholder="Start Range-End Range"></asp:TextBox>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblMAnufactMean" runat="server" Text="Manufacturer Mean" localize="RuleMaster_lblMAnufactMean"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <asp:TextBox ID="txtManufactMean" Val-Key="ManufacturerMean" runat="server" CssClass="form-control Deci" ></asp:TextBox>
                            </div>
                    </div>
                    </div>
                    <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                               <asp:Label ID="lblRun" runat="server" Text="Run" localize="RuleMaster_lblRun"></asp:Label>
                               <%--<span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                 <asp:TextBox ID="txtRun" runat="server" Val-Key="Run" CssClass="form-control Integer" ></asp:TextBox>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblLabRefRange" runat="server" Text="Lab Ref Range" localize="RuleMaster_lblLabRefRange"></asp:Label>
                                <%--<span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                               <asp:TextBox ID="txtLabRefRange" Val-Key="LabRefRange" runat="server" CssClass="form-control OnlyAlpha"  placeholder="Start Range-End Range"></asp:TextBox>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblLabMean" runat="server" Text="Lab Mean" localize="RuleMaster_lblLabMean"></asp:Label>
                               <%-- <span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                                <asp:TextBox ID="txtLabMean" Val-Key="LabMean" runat="server" CssClass="form-control Deci"></asp:TextBox>
                            </div>
                    </div>
                    <!--Row-->
                   </div>
                    <div class="row">
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblLabSD" runat="server" Text="Lab SD" localize="RuleMaster_lblLabSD"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:TextBox ID="txtLabSD" Val-Key="LabSD" runat="server" CssClass="form-control Deci" ></asp:TextBox>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <asp:Label ID="lblChartCalc" runat="server" Text="LJ Chart Calculation" localize="RuleMaster_lblChartCalc"></asp:Label>
                                <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                                <asp:DropDownList ID="txtChartCalc" runat="server" CssClass="form-control ">
                                    <asp:ListItem Text="-- Select --" Value="--Select--"></asp:ListItem>
                                     <asp:ListItem Text="Manufacturer" Value="Manufacturer"></asp:ListItem>
                                     <asp:ListItem Text="Lab" Value="Lab"></asp:ListItem>
                                 </asp:DropDownList>
                          </div>
                    </div>
                   
                    <!--Row-->
                    </div>
          
                <!-- Row -->
                <div class="row">
                    <div class="form-group text-center">
                         <input type ="button" id="btnClear"  class="btn btn-success"  value="Clear" localize="RuleMaster_btnClear" />
                        <input type ="button" id="btnSave"  class="btn btn-success" data="save"  value="Submit" localize="RuleMaster_btnSave"/>
                    </div>
                </div>
                
               
            </div>
             <!-- Row -->
                
            <!-- Row -->
                     <div class="gridTable bounceinup" id ="Bindtable" runat="server" style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblBindtable">
                                  <thead>
                                        <tr>
                                            <th localize="QMS_Dashboard_aspx_LotNo">Lot No</th>
                                            <th localize="RuleMaster_lblLotName">Lot Name</th>
                                            <th localize="RuleMaster_lblLevel">Level</th>
                                            <th localize="RuleMaster_lblAnalyte">Analyte</th>
                                            <th localize="RuleMaster_lblManufactRefRange">Manufacturer Ref. Range</th>
                                            <th localize="RuleMaster_lblMAnufactMean">Manufacturer Mean</th>
                                            <th localize="RuleMaster_lblLabRefRange">Lab Ref. Range</th>
                                            <th localize="RuleMaster_lblLabMean">Lab Mean</th>
                                            <th localize="RuleMaster_lblChartCalc">LJ Chart Calculation</th>
                                            <th localize="RuleMaster_lblLabSD">Lab SD</th>
                                            <th localize="Action">Action</th>
                                            
                                            
                                        </tr>
                                  </thead>
                                  
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
      </form>
    </div>
    <!-- ./wrapper -->
    <!-- jQuery 2.1.4 -->

    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <!-- jQuery UI 1.11.2 -->

  <%--  <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>--%>

    <script src="Script/jquery-ui.min.js" type="text/javascript"></script>

    <!-- Bootstrap 3.3.2 JS -->

    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="bootstrap/js/bootstrap-select.js" type="text/javascript"></script>
    <!-- Angular Js -->

    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <script src="dist/js/angular.min.js" type="text/javascript"></script>
    
    <!-- bootstrap datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    
    <!-- iCheck 1.0.1 -->
    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="Resource/local_resorce.js" type="text/javascript"></script>
    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->
    <!-- Rule Master  JS Script Referance-->
    

<%--    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>--%>
    <script src="Script/RuleMaster.js" type="text/javascript"></script>
    <!-- End-->
    <%--Hiden Controls--%>
    
    <input id="hdnSelectedLotID" type="hidden" runat="server" />
    <input id="hdnOrgID" type="hidden" runat="server" />
    <input id="hdnInvestigationID" type="hidden" runat="server"  />
    <input id="hdnAnalyteId" type="hidden" runat="server" />
    <input id="hdnManufacturerRefRange" type="hidden" runat="server"  />
    <input id="hdnManufacturerMean" type="hidden" runat="server" />
    <input id="hdnRun" type="hidden" runat="server"   />
    <input id="hdnLabRefRange" type="hidden" runat="server"  />
    <input id="hdnLabMean" type="hidden" runat="server"  />
    <input id="hdnLabSD" type="hidden" runat="server"  />
    <input id="hdnLJChartCalculation" type="hidden" runat="server"  />
    <input id="hdnQCRID" type="hidden" runat="server" />
    
    
    <%--End Of Hidden Control List--%>

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>
    
    <%--<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.js"></script>--%>
    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function () {
        //Date picker
        $('.datepicker').datepicker({
            autoclose: true
        });
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
    });
    </script>
       <%--<script type="text/javascript">
           $(document).ready(function() {
               $(".selectpicker").selectpicker();
           });
    </script>--%>
</body>
</html>