<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="InternalAudit.aspx.cs" 
Inherits="QMS_InternalAudit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Internal Audit</title>
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
        table
        {    width: 100%;}
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
                    <section class="content" >
          <div class="fadeindown" id="maincontent">
             <div id="filterCard" class="card">
          
              <div class="header">
                     <h2 class="strong">Internal Audit --> Pending Task List</h2>
               
                </div>
                <div class="body">
                 <div class="row">
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label6" runat="server" Text="Organization" localize="InternalAudit_Label6"></asp:Label>
                            <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                    <select id="ddlOrganization" Entity="OrgID" data="Organization" class="form-control">
                <option value="0">---Select---</option>
                </select>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                       
                          <div class="form-group">
                               <asp:Label ID="Label8" runat="server" Text="Location" localize="InternalAudit_Label8"></asp:Label>
                               </div>
                     </div>
                       
                              
                    <div class="col-xs-8 col-sm-6 col-md-2">
                      <div class="form-group">
                             <select id="txtLocation" Entity="Location" data="Location" change="ddlOrganization"  class="form-control">
                   <option value="0">---Select---</option>
                 </select>
                 </div>
                       
                   </div>
                
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                            <label for="txtDate" localize="InternalAudit_txtDate">From Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtFromDate" readonly="readonly" Entity="FromDate" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                        </div>
                        </div>
             
                   
             
                    
                    </div>

                    <div class="row">
                     <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                            <label for="txtDate" localize="InternalAudit_txtDate2">To Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtToDate" readonly="readonly" Entity="Todate" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                       </div>
                </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblPrinciple" runat="server" Text="Department" localize="InternalAudit_lblPrinciple"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                           <div class="form-group">
                                 <asp:DropDownList ID="ddlDepartment" Entity="DeptID" change="ddlOrganization" data="Department" runat="server" CssClass="form-control">
                                  
                                 </asp:DropDownList>
                            </div>
                    </div>
                            <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label12" runat="server" Text="Audit No" localize="InternalAudit_Label12"></asp:Label>
                          <%--       <span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <input type="text" class="form-control" Val-Key="PlanScheduleID" Entity="PlanScheduleID" id="txtAuditNumber" />
                            </div>
                            
                    </div>

                   </div>
                   <div class="row">
                   
                   <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
                            <label for="ddlStatus" localize="InternalAudit_ddlStatus">Status</label>
                        </div>
                </div>
              <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
                     
                        <asp:DropDownList Entity="Status" ID="ddlStatusFilter" CssClass="form-control" runat="server">
                             <asp:ListItem Value="0" Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                        
                              
                        </div>
                </div>
                 
                   </div>
                   <div class="row">
                    <div class="form-group text-center">
                    

                         <input id="btnShowTask" type="button" class="btn btn-success" value="Show Task" localize="InternalAudit_btnShowTask"/>

        
                       
                </div>
          </div>
                   <div class="row">
                    <div class="gridTable bounceinup" id ="tblSheduleDetails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblScheduledList">
                                  <thead><tr>
                   
    <th localize="SNo">S.No</th>
    <th localize="InternalAudit_EventName">Event Name</th>
    <th localize="InternalAudit_Task">Task Date</th>
    
    <th localize="InternalAudit_Label8">Location</th>
    <th localize="Auditor">Auditor</th>
    <th localize="Status">Status</th>
    <th localize="Action">Action</th>                                          
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>  
          </div>   
        
                
                </div>
                </div>
               <div id="cardList" class="card" style="display:none;">
          
          <div class="header">
                     <h2 class="strong">Internal Audits</h2>
                     <div class="right">
                     <h4 id="linkBack">Go Back</h4>
                     </div>
                </div>
          <div class="body">
           
                    <div class="row">
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="lblOrganization" class="control-label" runat="server" Text="Organization" ></asp:Label>
                           
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="input-group">
                                    <label for="ddlOrganization" Entity="OrgID" Text="" >

                
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                       
                          <div class="form-group">
                               <asp:Label ID="Label1" runat="server" class="control-label" Text="Location"></asp:Label>
                               </div>
                     </div>
                       
                              
                    <div class="col-xs-8 col-sm-6 col-md-2">
                      <div class="form-group">
                             <label for="txtLocation" Entity="Location"  Text="" >
                 
                 </div>
                       
                   </div>
                
                 <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <asp:Label ID="Label2" class="control-label" runat="server" Text="From"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
                         
                              <label for="txtDate" Entity="StartTime1" Text="" >
                              
                              </div>
                            </div>
                         </div>
                   
                    <div class="row">
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <asp:Label ID="Label3" class="control-label" runat="server" Text="To"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
                          
                              <label for="txtToDate" Entity="EndTime1" Text="" >
                            
                            
                         </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <asp:Label ID="Label7" class="control-label" runat="server" Text="Venue"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
                           <label for="txtVenue" Entity="Venue" Text="" >
                         </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDeviceCode" class="control-label" runat="server" Text="Department"></asp:Label>
                          <%--       <span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <label for="txtDepartment" Entity="DeptID" Text="" >
                            </div>
                            
                    </div>
                     
                    
                    </div>
                    <div class="row">
                      <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label4" class="control-label" runat="server" Text="Auditor"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <label for="txtAuditor" Entity="Auditor"  Text="" >
                            </div>
                    </div>
                  
                         <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label5" class="control-label" runat="server" Text="Audit No"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <label for="txtDepartment" Entity="PlanScheduleID" Text="" >
                            </div>
                    </div>
                  
       
                     
                    </div>
                    <div class="row">
                     <div class="nav-tabs-custom">
							<ul class="nav nav-tabs">
							  <li class="active"><a data-toggle="tab" href="#tab_1" class="uniquetestcode">Opening Meeting</a></li>
							  <li><a data-toggle="tab" href="#tab_2" class="uniquetestcode">Observation</a></li>
							  <li><a data-toggle="tab" href="#tab_3" class="uniquetestcode">Non Conformity</a></li>
							</ul>
							<div class="tab-content tab-scroll">
							  <div id="tab_1" class="tab-pane active">
							  <div class="row">
							   <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                <asp:Label ID="Label9" class="control-label" runat="server" Text="Audit Team Members"></asp:Label>
                            </div>
                            </div>
                            <div class="col-lg-10 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                 <div class="MultiFile-list" id="divGuestMail">
                                                   
                                 </div>
                            </div>
                             </div>
							  </div>
							  <div class="row">
							  
							  
							     <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                <asp:Label ID="Label10" class="control-label" runat="server" Text="Audit Scope"></asp:Label>
                            </div>
                            </div>
                               <div class="col-lg-10 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                             <label style="margin-left: 10px;" for="Label11" Entity="AuditScope" Text="" >
                                
                            </div>
                            </div>
							  </div>
							  
							  <div class="row">
							       <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                <asp:Label ID="Label13" class="control-label" runat="server" Text="Audit Criteria"></asp:Label>
                            </div>
                            </div>
                               <div class="col-lg-10 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                             <label for="Label11" style="margin-left: 10px;" Entity="AuditCriteria" Text="" >
                                
                            </div>
                            </div>
							  </div>
							  
							  <div class="row">
							       <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                <asp:Label ID="Label15" class="control-label" runat="server" Text="Reference Documents"></asp:Label>
                            </div>
                            </div>
                               <div class="col-lg-10 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                 <div class="MultiFile-list" id="txtfileupload_wrap_list">
                  
                                </div> 
                            </div>
                            </div>
							  </div>
							  
							  
							  
							  </div>
                              <div id="tab_2" class="tab-pane">
                              <div class="row">
                              <div class="col-lg-1  col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label11" class="control-label" runat="server" Text="Audit Type" ></asp:Label>
                                 <span class="required">*</span>
                            </div>
                            </div>
                    <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
               <%--                     <select id="ddlAuditType"   class="form-control">
                <option value="0">---Select---</option>
                </select>--%>
                <asp:DropDownList  ID="ddlAuditType" Entity="AuditType" CssClass="form-control" runat="server">
                             <asp:ListItem Value="0" Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                            </div>
                            </div>
                            <div class="col-lg-3 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtObservation"  Val-Key="Observation" Entity="Observation" class="form-control" />
                                 <span class="required">*</span>
                            </div>
                    </div>
                              <div class="col-lg-2  col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                 <%--   <select id="ddlCatagory"   class="form-control">
                <option value="0">---Select---</option>
                </select>--%>
                <asp:DropDownList ID="ddlCategory" Entity="Category"  runat="server" CssClass="form-control">
                                  
                                 </asp:DropDownList>
                                      <span class="required">*</span>
                            </div>
                              </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="input-group">
                                   <input type="button" id="btnAdd" value="Add" class="btn btn-primary" />
                                   <input type="hidden" id="hdnInternamAuditID" Entity="InternalAuditID" value="0" />
                            </div>
                            </div>
                              </div>
                              <div class="row" style="margin-top:20px">
                    <div class="gridTable bounceinup" id ="tblObservationDeatails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblObservationList">
                               <thead>
                               <tr>
                               <th localize="SNO">S.No</th>
                               <th localize="AuditType">Audit Type</th>
                               <th localize="Observation">Observation</th>
                               <th localize="Category">Category</th>
                               <th localize="Action">Action</th>
                               </tr>
                               </thead>
                              </table>
                           </div>
                    </div>  
          </div> 
                              </div>
                              <div id="tab_3" class="tab-pane">
                              <div class="row">
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label14" class="control-label" runat="server" Text="NABL Clause" ></asp:Label>
                             <span class="required">*</span>
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" Val-Key="NABLClause" id="txtNABLClause" Entity="NABLClause" class="form-control" />
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label16" class="control-label" runat="server" Text="ISO Clause" ></asp:Label>
                             <span class="required">*</span>
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" Val-Key="ISOClause" id="txtISOClause" Entity="ISOClause" class="form-control" />
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label17" class="control-label" runat="server" Text="NC No" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtNCNO" readonly="readonly" Entity="InternalAuditNCID" value="" class="form-control" />
                            </div>
                    </div>
                              </div>
                                 <div class="row">
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label18" class="control-label" runat="server" Text="Description of Non Conformity" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtDescription" Val-Key="Description" Entity="Description" class="form-control" />
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label19" class="control-label" runat="server" Text="Classification" ></asp:Label>
                             <span class="required">*</span>
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                  <%-- <select id="ddlClassification" class="form-control" />
                                   </select>--%><asp:DropDownList ID="ddlClassification"  CssClass="form-control" Entity="Classification" runat="server"></asp:DropDownList>
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label20" class="control-label" runat="server" Text="Activity Assessed" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtActivity" Val-Key="ActivityAssesed" Entity="ActivityAssesed" class="form-control" />
                            </div>
                    </div>
                              </div>
                                 <div class="row">
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label21" class="control-label" runat="server" Text="Corrective Action Proposed" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtCorrectiveAction" Val-Key="ProposedAction" Entity="ProposedAction" class="form-control" />
                                    
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label22" class="control-label" runat="server" Text="Proposed Completion Date" ></asp:Label>
 <span class="required">*</span>
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                               <div class="form-group">
                            <div class="input-group">
                                   <input type="text" id="txtCompletionDate" readonly="readonly" valType="date" Entity="CompletionDate" class="form-control" />
                               <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                   
                            </div>
                            </div>
                              </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label23" class="control-label" runat="server" Text="Corrective Action Taken" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtCorrectiveTaken" Val-Key="ActionTaken" Entity="ActionTaken" class="form-control" />
                            </div>
                    </div>
                              </div>
                                 <div class="row">
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label24" class="control-label" runat="server" Text="Corrective Action Verified" ></asp:Label>
                             <span class="required">*</span>
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                              <%--     <select type="text" id="txtCorrectiveVerified" class="form-control" />
                                   </select>--%>
                                   <asp:DropDownList ID="ddlCorrectiveVerified" CssClass="form-control" Entity="ActionVerified" runat="server"></asp:DropDownList>
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label25" class="control-label" runat="server" Text="Comments" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" id="txtComments" Val-Key="Comments" Entity="Comments" class="form-control" />
                            </div>
                    </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="Label26" class="control-label" runat="server" Text="Status" ></asp:Label>
                            
                            </div>
                            </div>
                               <div class="col-lg-2 col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                  <%-- <input type="text" id="ddlStatus" Entity="Status" class="form-control" />--%>
                                   <asp:DropDownList ID="ddlStatus" CssClass="form-control" Entity="Status" runat="server"></asp:DropDownList>
                            </div>
                    </div>
                              </div>
                              <div class="row">
                              <div class="text-center">
                                
                                  <input type="button" id="btnClearNC" value="Clear" class="btn btn-primary" />
                                   <input type="button" id="btnSaveNC" value="Save" class="btn btn-primary" />
                                   <input type="hidden" id="hdnInternalAuditNCID" Entity="InternalAuditNCID" value="0" />
                                  
                                   </div>
                              </div>
                               <div class="row" style="margin-top:20px">
                    <div class="gridTable bounceinup" id ="tblNCdetails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblNCList">
                               <thead>
                               <tr>
                               <th localize="SNO">S.No</th>
                               <th localize="NABLClause">NABL Clause</th>
                               <th localize="ISOClause">ISO Clause</th>
                               <th localize="QMS_Dashboard_aspx_NCNO">NC No</th>
                               <th localize="DescriptionofNC">Description of NC</th>
                               <th localize="QMS_Dashboard_aspx_Classification">Classification</th>
                               <th localize="ProposedCorrectiveAction">Proposed Corrective Action</th>
                               <th localize="Verified">Verified</th>
                                <th localize="Status">Status</th>
                                 <th localize="Action">Action</th>
                                
                               </tr>
                               </thead>
                              </table>
                           </div>
                    </div>  
          </div> 
                              </div>
                       </div>
                       </div>
                       </div>
                    
                   <div class="row" style="padding-left:20px; padding-right:20px;">

                  <input type="hidden" id="PSID" value="0" Entity="PlanScheduleID" />
                       
         
                
            </div>
               </div>
               </div>
                </div>
          
                <div class="form-group text-center">
                    

                      
                            <asp:HiddenField ID="hdnMessages" Value="" />
                            <asp:HiddenField ID="hdnSListClientDisplay" Value="" />
                            <asp:HiddenField ID="hdnSListUserMsg" Value="" />
                            <asp:HiddenField ID="hdnFilepath" Value="" />

                  
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

<script src="Resource/local_resorce.js" type="text/javascript"></script>
    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <script src="Script/jquery.timepicker.min.js" type="text/javascript"></script>

    <script src="Script/DateTimePair/datepair.js" type="text/javascript"></script>
  <%-- <script src="Script/DateTimePAir/datepair.min.js" type="text/javascript"></script>--%>

    <link href="Script/DateTimePair/jquery.timepicker.css" rel="stylesheet" type="text/css" />
     <script src="Script/DateTimePair/Jquery.datepair.js" type="text/javascript"></script>
    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>


    <script src="Script/tooltip.js" type="text/javascript"></script>
    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    
    <!-- AdminLTE for demo purposes -->
    
    <script src="Script/moment.js" type="text/javascript"></script>
    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/demo.js" type="text/javascript"></script>
<script src="Script/QC_Common.js" type="text/javascript"></script>
    <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>

    <script src="Script/InternalAudit.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(function() {
        var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
        GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');
        });   
        function populateOnEdit(aData) {
            $("#txtfileupload_wrap_list").html('');
            if (aData != null && aData != '') {
                var path = $('#hdnFilepath').val();
                var arr = aData.split(',');
                for (var i = 0; i < arr.length; i++) {
                    var lst = arr[i].split('~');
                    var d = '<div id="' + lst[2] + '" class="MultiFile-label">\
                    <i class="fa fa-file" aria-hidden="true"></i>\
                     <span href="' + path + lst[0] + '" class="MultiFile-title clickable" >' + lst[2] + '  -  ' + lst[3] + '</span>\
                     </div>';


                    $("#txtfileupload_wrap_list").append(d);
                }

                $(".MultiFile-title").click(function() {
                    var url = $(this).attr('href');
                    $("#ifPDF").attr('src', '<%=ResolveUrl("~/QMS/QChandler.ashx?PictureName=' + url + '")%>');
                    $("#btnTarget").click();
                    $('#ifPDF').show();

                });




            }
        }
    
    </script>
</body>
</html>