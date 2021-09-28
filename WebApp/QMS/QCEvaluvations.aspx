<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QCEvaluvations.aspx.cs" Inherits="QMS_QCEvaluvations" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>QC Evaluvations</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->

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
    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>
     <!-- Bootstrap 3.3.2 JS -->

    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap-select.js" type="text/javascript"></script>
       <script src="Script/QCEvaluvations.js" type="text/javascript"></script>
       <script src="Script/moment.js" type="text/javascript"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .hide_column
        {
            display: none;
        }
    </style>
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
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
        <uc1:MainHeader ID="MainHeader" runat="server" />
        <!-- Content Wrapper. Contains page content -->
        <asp:UpdatePanel ID="ctlTaskUpdPnl1" runat="server">
                                <ContentTemplate> 
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
          <section class="content">
          <div class="fadeindown">
              <div class="row">
                    <div class="col-md-12">
                                <h4 class="strong">Evaluvations of Mean & SD</h4>
                    </div>
                </div>
                    <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblDevicename" runat="server" Text="DeviceName" ></asp:Label>
                                 <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                             <div class="icon-addon addon-md ">
                            <asp:TextBox ID="txtDeviceName" runat="server" CssClass="form-control autosuggest" ></asp:TextBox>
                             <asp:Label ID="Label1" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                           </div>
                            </div>
                    </div>

                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblbarcode" runat="server" Text="LotNumber" ></asp:Label>
                                 <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                             <div class="icon-addon addon-md ">
                            <asp:TextBox ID="txtLotNumber" Val-Key="LotNumber" runat="server" CssClass="form-control autosuggest" ></asp:TextBox>
                              <asp:Label ID="Label3" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                  </div>
                            </div>
                    </div>
                   
                    </div>
                    <div class="row">
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lbltestName" runat="server" Text="TestName" ></asp:Label>
                               <span class="required">*</span>
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                             <div class="icon-addon addon-md ">
                           <asp:TextBox ID="txtTestName" Val-Key="TestName" runat="server" CssClass="form-control autosuggest" ></asp:TextBox>
                             <asp:Label ID="Label2" CssClass="glyphicon glyphicon-search" rel="tooltip" runat="server"></asp:Label>
                                  </div>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                    <div class="form-group text-center">
                        <input type ="button" id="btnSearch"  class="btn btn-success" value="Search" onclick="GetQCLabMeanDetails()"/>
                    </div>
                     </div>
                      
                    </div>
                <!-- Row -->
                 <div class="row">
                    <!--Row-->
                      <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group">
                                <label>
                                  <input id="chkAction" type="checkbox" class="icheckbox_minimal-blue"/>
                                </label>
                                <label>
                                Copy Action
                                </label>
                          </div>
                          </div>
                    </div>
                <!-- Row -->
                
                 <div class="row" id="dvsearch" >
                    <!--Row-->
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                             <asp:Label ID="lblmean" runat="server" Text="Floating Mean Selection" ></asp:Label>
							 <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                            <asp:DropDownList ID="ddlmean" runat="server" CssClass="form-control">
                                     <asp:ListItem Value="0" Text="--select--" Selected="True"></asp:ListItem>
                                     <asp:ListItem Value="1" Text="Last Month"></asp:ListItem>
                                     <asp:ListItem Value="2" Text="Cummulative"></asp:ListItem>
                                     <asp:ListItem Value="3" Text="Date Interval"></asp:ListItem>
                                 </asp:DropDownList>
                        </div>
                </div>
                <div style ="display:none;"  class="col-lg-1 col-xs-6 col-sm-2 col-md-3 dateFilter">
                 <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="From"></asp:Label>
                        </div>
                 </div>
                  <div style ="display:none;"  class="col-lg-2 col-xs-3 col-sm-2 col-md-3 dateFilter">
                        <div class="input-group date">
                              <input type ="text" id="txtFromDate" disabled="disabled" class="form-control">
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        
          
                </div>
                 <div style ="display:none;"  class="col-lg-1 col-xs-6 col-sm-2 col-md-3 dateFilter">
                 <div class="form-group">
                            <asp:Label ID="Label5" runat="server" Text="To"></asp:Label>
                        </div>
                 </div>
                 <div style ="display:none;" class="col-lg-2 col-xs-3 col-sm-2 col-md-3 dateFilter">
                
                        
                     
                        <div class="input-group date">
                              <input type ="text" id="txtToDate" disabled="disabled" class="form-control" />
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        
                  
                </div>
                
                 <div class="form-group text-center">
                        <input type ="button" id="btnApply"  class="btn btn-success" value="Apply" onclick="GetFloatingMeanDetails()"/>
                    </div>
                    <!-- Row -->
               </div>
            </div>
             <!-- Row -->
                <div class="gridTable bounceinup" id ="Bindtable" runat="server">
                <div  class="table-responsive" id="dvBindDatatable" visible="false">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblBindDatatable" >
                                  <thead>
                                  <tr>
                                       <th colspan="2">
                                        </th>
                                        <th colspan="3">Level 1
                                        </th>
                                        <th colspan="3">Level 2
                                        </th>
                                        <th colspan="3">Level 3
                                        </th>
                                        </tr>
                                        <tr>
                                         <th class="hide_column">InvestigationID</th>
                                          <th class="hide_column">InstrumentID</th>
                                          <th class="hide_column">LotID</th>
                                          <th>SNo</th>
                                            <th>TestName</th>
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <%--<th> <input type="checkbox" id="Checkbox1" class="level" onclick="LevelOne()" /></th>--%>                                            
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <%--<th><input type="checkbox" id="Checkbox2" class="L2"/></th>--%> 
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <%--<th><input type="checkbox" id="Checkbox3" class="L3"/></th>--%> 
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                          <div  class="table-responsive"  id="dvBindtable" visible="false">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblBindtable">
                                  <thead>
                                  <tr>
                                       <th colspan="2">
                                        </th>
                                        <th colspan="4">Level 1
                                        </th>
                                        <th colspan="4">Level 2
                                        </th>
                                        <th colspan="4">Level 3
                                        </th>
                                        </tr>
                                        <tr>
                                         <th class="hide_column">InvestigationID</th>
                                          <th class="hide_column">InstrumentID</th>
                                          <th class="hide_column">LotID</th>
                                          <th>SNo</th>
                                            <th>TestName</th>
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <th> <input type="checkbox" id="chkLOneAll" class="level" onclick="LevelOne()" /></th>                                            
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <th><input type="checkbox" id="chkLTAll" class="L2"/></th> 
                                            <th>Mean</th>
                                            <th>SD</th>
                                            <th>CV</th>    
                                            <th><input type="checkbox" id="chkLEAll" class="L3"/></th> 
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>
            <!-- Row -->
                  <!-- Row -->
                 <div class="row" id="dvsave" >
                    <!--Row-->
                                        <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                            </div>
                            </div>
                          <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                           
                            </div>
                            </div>
                      <div class="col-xs-6 col-sm-2 col-md-2">
                   <div class="form-group">
                    <div class="form-group text-center">
                        <input type ="button" id="btnCancel"  class="btn btn-success" value="Cancel"/>
                    </div>
                                
                          </div>
                          </div>
                          <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                         
                        <input type ="button" id="btnSave"  class="btn btn-success" value="Save" onclick="SaveQCMeanDetails()"/>
                   
                            </div>
                            </div>
                    </div>
                <!-- Row -->
           </section>
            <!-- /.content -->
        </div>
       </ContentTemplate>
        </asp:UpdatePanel>
        <!-- /.content-wrapper -->
        <footer class="main-footer">
        
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

   
    <!-- Angular Js -->

    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <script src="dist/js/angular.min.js" type="text/javascript"></script>
    
    <!-- bootstrap datepicker -->
    <%--<script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>
    
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
    <!-- End-->
    <%--Hiden Controls--%>
    
    <input id="hdnSelectedLotID" type="hidden" runat="server" />
    <input id="hdnSelectedLotValue" type="hidden" runat="server" />
    <input id="hdnOrgID" type="hidden" runat="server" />
    <input id="hdnInvestigationID" type="hidden" runat="server"  />
    <input id="hdnInvestigationValue" type="hidden" runat="server"  />
    <input id="hdnDeviceID" type="hidden" runat="server"  />
    <input id="hdnDeviceValue" type="hidden" runat="server"  />
    
    <%--End Of Hidden Control List--%>

    <script src="dist/js/demo.js" type="text/javascript"></script>

 
    
    <%--<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.js"></script>--%>
    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $("#txtFromDate").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtToDate").datepicker("option", "minDate", selectedDate);
            }

        });
        $("#txtToDate").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100',
            defaultdate: 'minDate',
            onClose: function(selectedDate) {

            }

        });
       
    </script>
       <%--<script type="text/javascript">
           $(document).ready(function() {
               $(".selectpicker").selectpicker();
           });
    </script>--%>
</body>
</html>