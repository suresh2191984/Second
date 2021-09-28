<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaptureValues.aspx.cs" EnableEventValidation ="false" 
    Inherits="CaptureValues" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>
    <title>Capture Values</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />
   <%-- <link href="dist/css/jquery-ui.css" rel="stylesheet" type="text/css" />--%>
<%--    <link href="http://code.jquery.com/ui/jquery-ui-git.css" rel="Stylesheet" type="text/css" />--%>
    <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
    <!-- bootstrap datepicker -->
    
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="plugins/iCheck/all.css" type="text/css"/>
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
  <%--  <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />--%>
    <link href="dist/css/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type ="text/css" >
        .hide_Column
        {
            display: none;
        }
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
        }
    </style>

   <%-- <link href="http://code.jquery.com/ui/jquery-ui-git.css" rel="Stylesheet" type="text/css" />--%>
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
                     <h4 class="strong">Capture Values</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6 col-sm-1 col-md-1">
                        <div class="form-group">
                             <asp:Label ID="lblDate" runat="server" Text="Date" localize="CaptureValues_lblDate"></asp:Label>
                             <span style="color:Red;">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                        <div class="input-group date">
                          <%--  <asp:DropDownList ID="ddlDeviceName" runat="server" CssClass="form-control">--%>
                            <input type="text" id="txtDate" readonly="readonly" class ="form-control">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div></div>
                                    <%-- <asp:ListItem Text="Cobas"></asp:ListItem>
                                     <asp:ListItem Text="Cobas"></asp:ListItem>--%>
                                <%-- </asp:DropDownList>--%>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-1 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lbltime" runat="server" Text="Time" localize="CaptureValues_lbltime"></asp:Label>
                            <span style="color:Red;">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                             <%--<asp:TextBox ID="txtDeviceCode" runat="server" CssClass="form-control" placeholder="880"></asp:TextBox>--%>
                              <input type="text" id="txtTime" class ="form-control"  >
                        </div>
                </div>
                <div class="col-xs-6 col-sm-1 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lblLotName" runat="server" Text="LotName" localize="CaptureValues_lblLotName"></asp:Label>
                            <span style="color:Red;">*</span>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                         <asp:DropDownList ID="ddlLotName" runat="server" CssClass="form-control">
                         <%--<asp:ListItem Value ="0">Select Level</asp:ListItem>
                         <asp:ListItem Value ="1">C1</asp:ListItem>
                         <asp:ListItem Value ="2">C2</asp:ListItem>
                         <asp:ListItem Value ="3">C3</asp:ListItem>--%>
                           </asp:DropDownList>
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-1 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lblLevel" runat="server" Text="Level" localize="CaptureValues_lblLevel"></asp:Label>
                            <span style="color:Red;">*</span>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                         <asp:DropDownList ID="ddlLevel" change="ddlLotName" runat="server" CssClass="form-control">
                         <%--<asp:ListItem Value ="0">Select Level</asp:ListItem>
                         <asp:ListItem Value ="1">C1</asp:ListItem>
                         <asp:ListItem Value ="2">C2</asp:ListItem>
                         <asp:ListItem Value ="3">C3</asp:ListItem>--%>
                           </asp:DropDownList>
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-1 col-md-1">
                        <div class="form-group">
                            <asp:Label ID="lblAnalyzer" runat="server" Text="Analyzer" localize="CaptureValues_lblAnalyzer"></asp:Label>
                        <span style="color:Red;">*</span>
                        
                        </div>
                </div>
                 <%--<div class="col-xs-6 col-sm-2 col-md-2">
                  <div class="form-group">
            
                   <div class="icon-addon addon-md">
                   <span id="lblsearch" class="glyphicon glyphicon-search"></span>
                   <asp:TextBox ID="txtAnalyzers" runat="server" class="autosuggest"></asp:TextBox>
                 <input name="txtAnalyzers" type="text" id="txtAnalyzers" class="form-control ui-autocomplete-input" placeholder="Search" >
                    <asp:TextBox ID="txtAnalyzers" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                   <span id="lblAnalyteNamegly" class="glyphicon glyphicon-search" rel="tooltip">
                   </span>
                    <asp:HiddenField ID="hdnInstrumentID" runat="server" />
                  </div> 
                    
                  </div>
                </div>--%>
                <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <div class="icon-addon addon-md">
                                    <asp:TextBox ID="txtAnalyzers" LengthCheck-Key="AnalyzerName" runat="server" CssClass="form-control" disabled="disabled" ></asp:TextBox>
                                    
                                    <asp:Label ID="Label1" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                    <input type="hidden" id="hdnInstrumentID" value="" />
                                    <input type="hidden" id="hdnInstrumentName" value="" />
                                </div>
                              
                            </div>
                    </div>
                     
                  
               
                </div>
                <!--Row-->
             
             
            <!-- Row -->
            <div class="row">
                <div class="form-group text-center" style="padding-top: 20px;">
                   <%--  <asp:Button ID="btnClear" runat="server" CssClass="btn btn-default" Text="Clear" />
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" />--%>
                        <input type=button id="btnAdd" runat="server" class="btn btn-primary" value  ="Add" localize="CaptureValues_btnAdd"/>
                   <%--     <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary" Text="Update" style="display:none" />--%>
                </div>
            </div>
            
            
           </div>
           <%--<!-- Row -->
            <div class="row slideinleft">
                <div class="form-group text-center">
                <div class="col-xs-6 col-sm-3 col-md-2">
                   <div class="form-group">
                     <div class="icon-addon addon-md">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                         <asp:Label ID="lblSearch2" runat="server" CssClass="glyphicon glyphicon-search"></asp:Label>
                    </div>
                   </div>
                   </div>
                </div>
            </div>
            <!-- Row -->--%>
                     <div class="gridTable bounceinup">
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="TblDeviceMapping" style ="display :none ">
                                  <thead>
                                        <tr>
                                            <th class="hide_Column">ID</th>
                                             <th localize="CaptureValues_lblDate">Date</th>                                   
                                            <th localize="CaptureValues_lbltime">Time</th>
                                            <th localize="CaptureValues_lblAnalyzer">Analyzer</th>
                                            <th localize="CaptureValues_lblLevel">Level</th>
                                            <th localize="CaptureValues_Analyte">Analyte</th>
                                            <th localize="Value">Value</th>
                                           
                                        </tr>
                                  </thead>
                                  <tbody>
                  
                                    </tbody>
                              </table>
                           </div>
                    </div>
                    <%-- <div class="gridTable bounceinup" id="DeviceList" runat="server">
                     
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblAnalyzermappingDetails" style="display:none" >
                                  <thead>
                                        <tr>
                                            <%--<th>S.No</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Analyzer</th>
                                            <th class="hide_Column">DeviceID</th>
                                            <th class="hide_Column">Model</th>
                                            <th class="hide_Column">Manufacturer</th>
                                            <th class="hide_Column">InvestigationID</th>
                                            <th>Level</th>
                                            <th>Analyte</th>
                                            <th>Value1</th>
                                            <th>Edit</th>
                                            <th class="hide_Column">Value3</th>
                                            <th class="hide_Column">Value4</th>
                                            
                                        </tr>
                                  </thead>
                              </table>
                           </div>
                    </div>--%>
               <div  class="row"> 
               <div  id="SaveBtnDiv" class="form-group text-center" style ="display :none ;">    
                    
                         <input type =button  id="btnClear"  class="btn btn-success" value ="Clear" />
                        <input type =button  id="btnSave"  class="btn btn-success" value ="Save" />
                        <input type=button id="btnEdit"  class="btn btn-primary" value  ="Edit" />
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
        </asp:UpdatePanel>
        </form>
    </div>
    <!-- ./wrapper -->
    <!-- jQuery 2.1.4 -->

    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <!-- jQuery UI 1.11.2 -->

    <%--<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>--%>

    <script src="dist/js/jquery-1.11.2-ui.min.js" type="text/javascript"></script>
    <!-- Bootstrap 3.3.2 JS -->

    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
    <!-- bootstrap datepicker -->

    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <%--<script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>
     <script src="Script/jquery.timepicker.min.js" type="text/javascript"></script>
    <!-- iCheck 1.0.1 -->

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <!-- Include the plugin's CSS and JS: -->
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>

      <script src="Script/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>

 <script src="Script/CaptureValues.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <script src="Script/moment.js" type="text/javascript"></script>
    <script type="text/javascript">
        $("#txtDate").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtDueDate").datepicker("option", "minDate", selectedDate);

                var date = $("#txtDoneDate").datepicker('getDate');

            }

        });
        $(function() {
            //Date picker
            $('.datepicker').datepicker({
                autoclose: true
            });

        });
    </script>

   

</body>
</html>
