<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalyzerMapping.aspx.cs" EnableEventValidation ="false" 
    Inherits="QMS_AnalyzerMapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>
    <title>Analyzer Mapping</title>
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
 <uc1:MainHeader ID="MainHeader" runat="server" />
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content">
          <div class="fadeindown header-top">
          <div class="row">
                <div class="col-md-12">
                     <h4 class="strong">Analyzer Mapping</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                             <asp:Label ID="lblDeviceName" runat="server" Text="Instrument Name" localize="AnalyzerMapping_lblDeviceName"></asp:Label>
							 <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:DropDownList ID="ddlDeviceName" runat="server" CssClass="form-control">
                                    <%-- <asp:ListItem Text="Cobas"></asp:ListItem>
                                     <asp:ListItem Text="Cobas"></asp:ListItem>--%>
                                 </asp:DropDownList>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblDeviceCode" runat="server" Text="Device Code" localize="AnalyzerMapping_lblDeviceCode"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                       <div class="form-group">
                             <asp:TextBox ID="txtDeviceCode"  runat="server" CssClass="form-control readonly" disabled="disabled"></asp:TextBox>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblModel" runat="server" Text="Model" localize="AnalyzerMapping_lblModel"></asp:Label>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                       <asp:TextBox ID="txtModel" runat="server" CssClass="form-control" disabled="disabled"></asp:TextBox>
                </div>
                </div>
                <div class="row">
                <!--Row-->
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" localize="AnalyzerMapping_lblManufacturer"></asp:Label>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                             <asp:TextBox ID="txtManufacturer" runat="server" CssClass="form-control" disabled="disabled" ></asp:TextBox>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblAnalyte" runat="server" Text="Analyte" Localize="AnalyzerMapping_lblAnalyte"></asp:Label>
                            <span class="required">*</span>
                        </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                     <div class="form-group">
                     <div class="icon-addon addon-md ">
                          
                        <asp:TextBox ID="AnalyteName" Val-Key="AnalyteName" runat="server" CssClass="form-control"></asp:TextBox>
                      <asp:Label CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                 <asp:HiddenField ID="hdnInvestigationID" runat="server" />
                                 </div>
                     </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblTestCode" runat="server" Text="AssayCode" Localize="AnalyzerMapping_lblTestCode"></asp:Label>
                            <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                     <div class="input-group">
                        <asp:TextBox ID="TxtTestcode" Val-Key="AssayCode" runat="server" CssClass="form-control" ></asp:TextBox>
            <span class="input-group-btn">
        <button class=" form-control btn-primary" type="button" id="Check_Testcode"><i class="fa fa-question"></i></button>
      </span> 
                        
                     </div>
                </div>
                </div>
                <div class="row">
                <!--Row-->
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblQCRequired" runat="server" Text="QC Required" Localize="AnalyzerMapping_lblQCRequired"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group">
                         <asp:DropDownList ID="QCRequired" runat="server" CssClass="form-control">
					
                                      <asp:ListItem Text="YES"></asp:ListItem>
                                      <asp:ListItem Text="NO" Selected="True"></asp:ListItem>
                                     <%--<asp:ListItem Text="SOP"></asp:ListItem>--%>
                                 </asp:DropDownList>
                     </div>
                </div>
                 <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblFrequencyDay" runat="server" Text="Frequency Day" Localize="AnalyzerMapping_lblFrequencyDay"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group">
                       <select class="form-control" id="FrequencyDay"  multiple="multiple" >
                       
                       <option value="SU">Sunday</option>
                            <option value="M">Monday</option>
                            <option value="T">Tuesday</option>
                            <option value="W">Wednesday</option>
                            <option value="TH">Thursday</option>
                            <option value="F">Friday</option>
                            <option value="S">Saturday</option>
                        </select>
                     </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:Label ID="lblFrequencyTime" runat="server" Text="Frequency Time" Localize="AnalyzerMapping_lblFrequencyTime"></asp:Label>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group">
                        <select class="multiselect form-control" id="ddlFrequencyTime" multiple="multiple">
                        
                        <option value="12">12 AM </option>
                            <option value="1">1 AM </option>
                            <option value="2">2 AM </option>
                           <option value="3">3 AM </option>
                             <option value="4">4 AM </option>
                           <option value="5">5 AM </option>
                        <option value="6">6 AM </option>
                        <option value="7">7 AM</option>
                        <option value="8">8 AM </option>
                        <option value="9">9 AM</option>
                        <option value="10">10 AM </option>
                        <option value="11">11 AM </option>
                        <option value="13">12 PM</option>
                        <option value="14">1 PM</option>
                        <option value="15">2 PM</option>
                        <option value="16">3 PM</option>
                        <option value="17">4 PM</option>
                        <option value="18">5 PM</option>
                        <option value="19">6 PM</option>
                        <option value="20">7 PM</option>
                        <option value="21">8 PM</option>
                        <option value="22">9 PM</option>
                        <option value="23">10 PM</option>
                        <option value="24">11 PM</option>
                        </select>
                     </div>
                </div>
                <!--Row-->
               </div>
             
            <!-- Row -->
            <div class="row">
                <div class="form-group text-center">
                     <%--<asp:Button ID="btnClear" runat="server" CssClass="btn btn-default" Text="Clear" />
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" />
                        <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" Text="Add" />
                        <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary" Text="Update" style="display:none" />--%>
                        <input type ="button"   id="btnClear" class="btn btn-default" value="Clear" onclick="clear()" Localize="AnalyzerMapping_btnClear"/> 
                        <input type ="button"   id="btnSave" class="btn btn-success" value="Save" style="display:none;" Localize="AnalyzerMapping_btnSave"/>
                         <input type ="button"   id="btnAdd" class="btn btn-primary" value="Add" Localize="AnalyzerMapping_btnAdd"/>
                        <input type ="button"   id="btnEdit" class="btn btn-primary" value="Update" style="display:none" Localize="AnalyzerMapping_btnUpdate"/>
                   
                </div>
            </div>
            
            
           </div>
        
                     <div class="gridTable bounceinup">
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="TblDeviceMapping" style="display:none;">
                                  <thead>
                                        <tr>
                                            <th class="hide_Column" data="InstrumentID">InstrumentID</th>
                                            <th localize="AnalyzerMaster_lblDeviceName" data="DeviceName">Device Name</th>
                                            <th localize="AnalyzerMapping_lblTestCode" data="AssayCode">Assay Code</th>
                                            <th localize="AnalyzerMapping_lblAnalyte" data="Analyte">Analyte</th>
                                            <th localize="AnalyzerMapping_lblQCRequired" data="QCRequired">QC Required</th>
                                            <th localize="AnalyzerMapping_lblFrequencyDay" data="FrequencyDay">Frequency Day</th>
                                            <th localize="AnalyzerMapping_lblFrequencyTime" data="FrequencyTime">Frequency Time</th>
                                            <th class="hide_Column" data="InvestigationID">InvestigationID</th>
                                            <th class="hide_Column" data="DeviceCode">DeviceCode</th>
                                            <th localize="Delete" data="Delete">Delete</th>
                                            <th class="hide_Column" data="QCRequired">QC Required</th>
                                            <th class="hide_Column" data="FrequencyDay">Frequency Day</th>
                                            <th class="hide_Column" data="FrequencyTime">Frequency Time</th>
                                        </tr>
                                  </thead>
                                  <tbody>
                  
                                    </tbody>
                              </table>
                           </div>
                    </div>
                     <div class="gridTable bounceinup" id="DeviceList" runat="server">
                     
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblAnalyzermappingDetails" style="display:none" >
                                  <thead>
                                        <tr>
                                            <%--<th>S.No</th>--%>
                                            <th class="hide_Column">InstrumentID</th>
                                            <th localize="AnalyzerMapping_lblDeviceName">Instrument Name</th>
                                            <th localize="AnalyzerMapping_lblTestCode">Assay Code</th>
                                            <th class="hide_Column">DeviceID</th>
                                            <th class="hide_Column">Model</th>
                                            <th class="hide_Column">Manufacturer</th>
                                            <th class="hide_Column">InvestigationID</th>
                                            <th localize="AnalyzerMapping_lblAnalyte">Analyte</th>
                                            <th localize="AnalyzerMapping_lblQCRequired">QC Required</th>
                                            <th localize="AnalyzerMapping_lblFrequencyDay">Frequency Day</th>
                                            <th localize="AnalyzerMapping_lblFrequencyTime">Frequency Time</th>
                                            <th localize="AnalyzerMapping_btnEdit">Edit</th>
                                            <th class="hide_Column">Delete</th>
                                            <th localize="Status">Status</th>
                                            <th class="hide_Column">QC Required</th>
                                            
                                        </tr>
                                  </thead>
                              </table>
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

    <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>

    <!-- iCheck 1.0.1 -->

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

    <script src="dist/js/demo.js" type="text/javascript"></script>
     <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
<link href="Script/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet" type="text/css">
    <script src="Script/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>
    <script src="Script/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>
    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            //Date picker
            $('.datepicker').datepicker({
                autoclose: true
            });
         
        });
    </script>

    <script src="Script/AnalyzerMapping.js" type="text/javascript"></script>

</body>
</html>
