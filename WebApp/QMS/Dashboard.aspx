<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" EnableEventValidation="false"
    Inherits="Dashboard" %>

<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Dashboard</title>
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
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- Include the plugin's CSS and JS: -->
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="Script/tooltip.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/popup.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="plugins/morris/morris.css" rel="stylesheet" type="text/css" />
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
        .panel-heading span
        {
            margin-top: -20px;
        }
        .cen
        {
            text-align: center;
        }
        .ullabel
        {
            text-decoration: underline;
            padding-right: 47px;
            margin-bottom: 0px;
        }
        .ullabel1
        {
            text-decoration: none;
            padding-right: 25px;
            margin-bottom: 0px;
        }
        .tool:hover
        {
            font-size: 14px;
            color: #bf9758;
        }
        .vertical-text
        {
            float: left;
            transform: rotate(990deg);
            margin-left: 25px;
            margin-top: 120px;
        }
        .quick-btn .label
        {
            position: absolute;
            right: -5px;
            top: 35px;
        }
        .quick-btn span
        {
            display: block;
        }
        .ultype li
        {
            padding-bottom: 9.5px;
        }
        .ultype
        {
            list-style-type: none;
        }
        /*   .ultype li{    background: #f3f3f3;
    border-radius: 3px;
    position: relative;
    padding: 7px;
    margin-bottom: 5px;
    list-style: none;}
    #overlay {
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    right: 0;
    background: #000;
    opacity: 0.5;
    filter: alpha(opacity=80);
} */
        #loading
        {
            width: 50px;
            height: 57px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin: -28px 0 0 -25px;
        }
        .load
        {
            height: 100%;
            width: 100%;
            z-index: 1600 !important;
            background: #ffffff url('../QMS/Images/qms_in1.gif') 50% 50% no-repeat;
            background-size: 30px 30px;
        }
        .btn-metis-3
        {
            color: #fff;
            background-color: #fbb450;
            border-color: #f89406;
        }
        .quick-btn
        {
            /* background: #D6EAF8; */
            -webkit-box-shadow: 0 0 0 1px #F8F8F8 inset, 0 0 0 1px #CCCCCC;
            box-shadow: 0 0 0 1px #F8F8F8 inset, 0 0 0 1px #CCCCCC;
            color: #444;
            display: inline-block;
            height: 50px;
            margin: 5px;
            padding-top: 2px;
            text-align: center;
            text-decoration: none;
            width: 90px;
            position: relative;
        }
        /* .quick-btn:hover {
  
    height: 90px;
   
    width: 210px;
    
}*/.panel-orange > .panel-heading
        {
            background-image: none;
            background-color: #F5B7B1;
            color: #333;
        }
        .panel-litegreen > .panel-heading
        {
            background-image: none;
            background-color: #1ABC9C;
            color: #333;
        }
        .panel-liteblue > .panel-heading
        {
            background-image: none;
            background-color: #AED6F1;
            color: #333;
        }
        .panel-darkyellow > .panel-heading
        {
            background-image: none;
            background-color: #F39C12;
            color: #333;
        }
        .panel-litegreen1 > .panel-heading
        {
            background-image: none;
            background-color: #ABEBC6;
            color: #333;
        }
        .panel-heading
        {
            color: #333;
            font-weight: 600;
            padding: 7px 10px;
            font-size: 14px;
        }
        .clickable
        {
            cursor: pointer;
        }
        .panel-litegreen li i:before
        {
            /* font-family: 'FontAwesome';
content: '\f111';
margin:0 25px 0 -15px;*/
            color: #1abc9c;
        }
        .panel-darkyellow li i:before
        {
            /* font-family: 'FontAwesome';
content: '\f111';
margin:0 25px 0 -15px;*/
            color: #f39c12;
        }
        .spnTable
        {
            text-align: left;
            border-collapse: collapse;
        }
        .spnTable th
        {
            font-size: 13px;
            font-weight: normal;
            background: #b9c9fe url("/images/express-css-table-design/table-images/gradhead.png") repeat-x;
            border-top: 2px solid #d3ddff;
            border-bottom: 1px solid #fff;
            color: #039;
            padding: 8px;
            vertical-align: baseline;
            margin: 0;
            text-align: -internal-center;
            display: table-cell;
        }
        .spnTable tr
        {
            font-size: 100%;
            vertical-align: baseline;
            margin: 0;
            padding: 0;
            outline: 0;
            border: 0;
            background: 0 0;
            display: table-row;
        }
        .spnTable td
        {
            border-bottom: 1px solid #fff;
            color: #669;
            border-top: 1px solid #fff;
            background: #e8edff url("/images/express-css-table-design/table-images/gradback.png") repeat-x;
            padding: 8px;
            vertical-align: top;
            font-size: 100%;
            outline: 0;
            border: 0;
        }
        .popupHeader
        {
            border-bottom: 2px solid black;
            background-color: rgb(255, 224, 7);
            margin-left: 0px;
            margin-right: 0px;
        }
        .popupBody
        {
            padding: 10px 40px 40px 40px;
        }
        .pnlDiv
        {padding-right:0px;
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
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content">
       <%--   <div class="fadeindown header-top">
          <div class="row">
                <div class="col-md-12">
                     <h4 class="strong">Capture Values</h4>
                </div>
            </div>--%>
            <div class="row">
		<div class="col-md-12">
			<div class="animated fadeInDown panel panel-thm card marginB15 bg-lightGrey">
				<div class="panel-heading">
					<h3 class="panel-title">FILTER</h3>
					<span class="pull-right clickable"><i class="glyphicon glyphicon-chevron-up"></i></span>
				</div>
				<div class="panel-body">
				<div class="row">
			
				 <div class="col-lg-1 col-xs-6 col-sm-2 col-md-3">
				   <div class="form-group">
                            <asp:Label ID="lblOrganization" runat="server" Text="Organization" localize="Dashboard_lblOrganization"></asp:Label>
                        </div>
                        </div>
				 <div class="col-lg-3 col-xs-6 col-sm-2 col-md-3">
				
                        <div class="form-group">
                         <asp:DropDownList ID="ddlOrganization" runat="server" CssClass="form-control">
                        
                           </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                </div>
                	 <div class="col-lg-1 col-xs-6 col-sm-2 col-md-3">
				   <div class="form-group">
                            <asp:Label ID="lblLocation" runat="server" Text="Location" localize="Dashboard_lblLocation"></asp:Label>
                        </div>
                        </div>
                 <div class="col-lg-3 col-xs-6 col-sm-2 col-md-3">
                 
                        <div class="form-group">
                         <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control">
                       
                           </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                </div>
                 	 <div class="col-lg-1 col-xs-6 col-sm-2 col-md-3">
				   <div class="form-group">
                            <asp:Label ID="lblDepartment" runat="server" Text="Department" localize="Dashboard_lblDepartment" ></asp:Label>
                        </div>
                        </div>
                 <div class="col-lg-3 col-xs-6 col-sm-2 col-md-3">
                       
                        <div class="form-group">
                         <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
           
                           </asp:DropDownList>
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                </div>
    

                
                   
                </div>
                <div class="row">
                                 	 <div class="col-lg-1 col-xs-6 col-sm-2 col-md-3">
				    <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="Date" localize="Dashboard_Label1"></asp:Label>
                        </div>
                        </div>
                 <div class="col-lg-3 col-xs-6 col-sm-2 col-md-3">
                
                        <div class="form-group">
                            <select id="ddlDate" class="form-control">
                            <option value ="0" selected="selected" >Today</option>
                            <option value ="1" >This Week</option>
                            <option value ="2" >Last Week</option>
                            <option value ="3" >This Month</option>
                            <option value ="4" >Last Month</option>
                              <option value ="5" >Custom</option>
                               <option value ="6" >This Year</option>
                              <option value ="7" >Last Year</option>
                           
                            
                            </select>
                        </div>
                        
                </div>
                
                 <div style ="display:none;"  class="col-lg-1 col-xs-6 col-sm-2 col-md-3 dateFilter">
                 <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="From"></asp:Label>
                        </div>
                 </div>
                  <div style ="display:none;"  class="col-lg-3 col-xs-6 col-sm-2 col-md-3 dateFilter">
                
                      

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
                 <div style ="display:none;" class="col-lg-3 col-xs-6 col-sm-2 col-md-3 dateFilter">
                
                        
                     
                        <div class="input-group date">
                              <input type ="text" id="txtToDate" disabled="disabled" class="form-control" />
                              <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                              </div>
                            </div>
                        
                  
                </div>
                
                
                
                
				</div>
				<div class="row" >
				 <div class="col-lg-12 col-xs-6 col-sm-2 col-md-3 cen">
                
                       
                        <div class="form-group">
                         <input type="button" id="btnFilter" class="btn btn-primary" value="Apply Filter"  localize="Dashboard_btnFilter"/>
                             <%--<asp:TextBox ID="ddlLevel" runat="server" CssClass="form-control" ></asp:TextBox>--%>
                        </div>
                  </div>
				</div>
			</div>
		</div>
		</div>
		</div>

               
			<asp:HiddenField ID="hdnorgid" runat="server" />
			<asp:HiddenField ID="hdnroleid" runat="server" />
			<asp:HiddenField ID="hdnuserid" runat="server" />
				
			<div class="popup" data-popup="popup-1">

    <div class="popup-inner">
    <div class="row popupHeader">
    <div class="col-lg-10" style="padding-top:3px;"><h4 id="header">Sample Details</h4></div>
    <div class="col-lg-2" style="padding-top:10px;"><select id="ddlType" class="form-control" class="pull-right"></select></div>
    
    </div>
    <div class="popupBody">
        <h4 id="innerheader" style="text-align:center;">Sample Details</h4>
        <div id="tatDiv" class="col-lg-12">
      
      <div class="col-lg-2 col-xs-6 col-sm-2 col-md-3">
      </div>
     <div class="col-lg-2 col-xs-6 col-sm-2 col-md-3">
      </div>
          <div class="col-lg-2 col-xs-6 col-sm-2 col-md-3">
				
                        <div class="form-group">
                     <select id="ddlTatType" class="form-control"></select>
                            
                        </div>
                </div>
         <div class="col-md-2 col-xs-4 col-sm-2 col-md-3">

                        <div class="form-group">
                        <select id="ddltathours" class="form-control">
                        <option value="1">1</option>
                         <option value="2">2</option>
                          <option value="3">3</option>
                           <option value="4">4</option>
                            <option value="5">5</option>
                             <option value="6">6</option>
                              <option value="24">1Day</option>
                               <option value="48">>1Day</option>
                        </select>                       
                        
                       
                        </div>
                </div>
           <div class="col-lg-2 col-xs-6 col-sm-2 col-md-3">
				
                        <div class="form-group">
                         <input type="button" ID="btntatsearch" class="btn btn-primary" value="submit" runat="server" CssClass="form-control" />                                 
                        </div>
                </div>
        </div>
                 <div class="gridTable" id="tblMishead" runat="server">
                     
                            <div class="table table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblMis" style="display:none" >
                                  <thead>
                                        <tr>
                                            <th class="hide_column">Instrument</th>
                                            <th localize="DepartmentName">Department Name</th>
                                    
                                        </tr>
                                  </thead>
                              </table>
                           </div>
                    </div>
        
        <a class="popup-close" data-popup-close="popup-1" href="#">x</a>
        </div>
    
    </div>
</div>
<div id="widgets" class="clearfix">	
		
		</div>
		</div>
		
                </div>
                <div style="display: none;" id="overlay">
                    <img src="../Images/ajax-loader.gif" />
                </div>
                </div>
              <%-- <asp:HiddenField ID="hdnChildTestName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ChildTestName %>" />
                <asp:HiddenField ID="hdnContainerName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ContainerName %>" />
                <asp:HiddenField ID="hdnDepartment" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Department %>" />
                <asp:HiddenField ID="hdnDeviceName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_DeviceName %>" />
                <asp:HiddenField ID="hdnNewSample" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_NewSample %>" />
                <asp:HiddenField ID="hdnOldSample" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_OldSample %>" />
                <asp:HiddenField ID="hdnOutsourcedLocation" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_OutsourcedLocation %>" />
                <asp:HiddenField ID="hdnParentTestName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ParentTestName %>" />
                <asp:HiddenField ID="hdnPatientNumber" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_PatientNumber %>" />
                <asp:HiddenField ID="hdnPatientName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_PatientName %>" />
                <asp:HiddenField ID="hdnVisitNumber" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_VisitNumber %>" />
                <asp:HiddenField ID="hdnReasonForReject" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ReasonForReject %>" />
                <asp:HiddenField ID="hdnSample" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Sample %>" />
                <asp:HiddenField ID="hdnSampleName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_SampleName %>" />
                <asp:HiddenField ID="hdnStatus" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Status %>" />
                <asp:HiddenField ID="hdnTATDateandTime" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_TATDateTime %>" />
                <asp:HiddenField ID="hdnTestName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_TestName %>" />
                <asp:HiddenField ID="hdnTestValue" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_TestValue %>" />
            
                <asp:HiddenField ID="hdnAuditNo" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_AuditNo %>" />
                <asp:HiddenField ID="hdnAuditDateAndtime" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_AuditDateAndtime %>" />
                <asp:HiddenField ID="hdnVenue" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Venue %>" />
                <asp:HiddenField ID="hdnAuditor" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Auditor %>" />
                <asp:HiddenField ID="hdnAuditors" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Auditors %>" />
                
                <asp:HiddenField ID="hdnAuditAgency" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_AuditAgency %>" />
                <asp:HiddenField ID="hdnNCNO" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_NCNO %>" />
                <asp:HiddenField ID="hdnClassification" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Classification %>" />
                <asp:HiddenField ID="hdnProposedCompletionDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ProposedCompletionDate %>" />
                <asp:HiddenField ID="hdnPNCNO" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_PNCNO %>" />
                
                <asp:HiddenField ID="hdnProposedDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ProposedDate %>" />
                <asp:HiddenField ID="hdnCreatedBy" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_CreatedBy %>" />
                <asp:HiddenField ID="hdnProductCode" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ProductCode %>" />
                <asp:HiddenField ID="hdnInstrumentName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_InstrumentName %>" />
                <asp:HiddenField ID="hdnManufacturer" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Manufacturer %>" />
                
                     
                <asp:HiddenField ID="hdnCallibrationDoneDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_CallibrationDoneDate %>" />
                <asp:HiddenField ID="hdnCallibrationDueDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_CallibrationDueDate %>" />
                <asp:HiddenField ID="hdnLotNo" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_LotNo %>" />
                <asp:HiddenField ID="hdnLotName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_LotName %>" />
                <asp:HiddenField ID="hdnTestCode" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_TestCode %>" />
       
                <asp:HiddenField ID="hdnInvestigationName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_InvestigationName %>" />
                <asp:HiddenField ID="hdnFrequencyDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_FrequencyDate %>" />
                <asp:HiddenField ID="hdnFrequencyTime" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_FrequencyTime %>" />
                <asp:HiddenField ID="hdnVendorName" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_VendorName %>" />
                <asp:HiddenField ID="hdnResponsiblePerson" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ResponsiblePerson %>" />
                <asp:HiddenField ID="hdnLevel" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_Level %>" />
       
                <asp:HiddenField ID="hdnMaintenanceDoneDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_MaintenanceDoneDate %>" />
                <asp:HiddenField ID="hdnMaintenanceDueDate" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_MaintenanceDueDate %>" />
                <asp:HiddenField ID="hdnReasonForRerun" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ReasonForRerun %>" />
                <asp:HiddenField ID="hdnReasonForRecollect" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_ReasonForRecollect %>" />
                 <asp:HiddenField ID="hdnDelayedHours" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_DelayedHours %>" />
                 <asp:HiddenField ID="hdnDeviceValue" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_DeviceValue %>" />
                <asp:HiddenField ID="hdnCoAuthorizedBy" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_CoAuthorizedBy %>" />
                <asp:HiddenField ID="hdnCoAuthorizedTo" runat="server" Value="<%$ Resources:QMS_ClientDisplay,QMS_Dashboard_aspx_CoAuthorizedTo %>" />
              --%>
             
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
    <%--  
    <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>
    <!-- iCheck 1.0.1 -->

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <!-- Include the plugin's CSS and JS: -->

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>

    <%-- <script type="text/javascript" src="plugins/multiSelect/js/bootstrap-multiselect.js"></script>--%>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

  <script src="plugins/morris/morris.min.js" type="text/javascript"></script> 

    <script src="plugins/morris/raphael-min.js" type="text/javascript"></script>
    
<script src="Resource/local_resorce.js" type="text/javascript"></script>
    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>

    <script src="Script/tooltip.js" type="text/javascript"></script>

    <script src="Script/moment.js" type="text/javascript"></script>

    <script src="Script/Dashboard.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.0.3/js/buttons.html5.min.js"></script>
    <script type="text/javascript">
        var ILocationID = '<%=ILocationID%>';
        var OorgID = '<%=OrgID%>';
        var dat = [];
        var filterData = {};
        $(function() {
            $('[data-popup-close]').on('click', function(e) {
                var targeted_popup_class = jQuery(this).attr('data-popup-close');
                $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);

                e.preventDefault();
            });

        $("#txtFromDate").datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
           $("#txtToDate").datepicker("option", "minDate", selectedDate);

////            var date = $("#txtToDate").datepicker('getDate');
//            $("#txtToDate").datepicker('option', 'minDate', new Date(theDate));
            }

        });
        $("#txtToDate").datepicker({
            dateFormat: 'dd/mm/yy',
           maxDate: 0,
            yearRange: '1900:2100',
            defaultdate:'minDate',
            onClose: function(selectedDate) {
                // $("#txtDueDate").datepicker("option", "minDate", selectedDate);
            
           //     var date = $("#txtToDate").datepicker('getDate');

            }

        });


        });
       
    </script>

</body>
</html>
