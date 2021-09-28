<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" 
CodeFile="QCPlan.aspx.cs" Inherits="QMS_QCPlan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Plan & Schedule</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
    <!-- bootstrap datepicker -->
  <%--<link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />--%>
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
                    <section class="content">
          <div class="fadeindown" id="maincontent">
    
        
          <div id="cardList" class="card">
          
          <div class="header">
                     <h2 class="strong">Plan & Schedule</h2>
                     <div class="right">
                     <h4 id="linkCreate">Create New</h4>
                     </div>
                </div>
          <div class="body">
           
           
            <div class="row">
                <div class="col-xs-8 col-sm-6 col-md-1">
                       <div class="form-group">
                               <asp:Label ID="lblAnalyzer" runat="server" Text="Organization" localize="QCPlan_lblAnalyzer"></asp:Label>
                               </div>
                        
                </div>
                <div class="col-xs-8 col-sm-6 col-md-2">
                <div class="form-group">
                 <asp:DropDownList Entity="OrgID" ID="ddlOrg" data="Organization" runat="server" CssClass="form-control">
                                  <asp:ListItem Text="---Select---" Value="0"></asp:ListItem>
                                  </asp:DropDownList>
                                 
             
               </div>
                 </div>
                
                <div class="col-xs-8 col-sm-6 col-md-1">
                       <div class="form-group">
                          <div class="form-group">
                               <asp:Label ID="Label1" runat="server" Text="Location" localize="QCPlan_Label1"></asp:Label>
                               </div>
                             </div>
                       
                </div>
                <div class="col-xs-8 col-sm-6 col-md-2">
                      <div class="form-group">
                             <select id="txtLocation" Entity="Location" data="Location" change="ddlOrg"  class="form-control">
                   <option value="0">---Select---</option>
                 </select>
                 </div>
                       
                </div>
                <div class="col-xs-8 col-sm-6 col-md-1">
                       <div class="form-group">
                            <label for="txtDate" localize="QCPlan_txtDate">From Date</label>
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
                <div class="col-xs-8 col-sm-6 col-md-1">
                       <div class="form-group">
                            <label for="txtDate" localize="QCPlan_txtDate1">To Date</label>
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

                </div>
             <div class="row">
               
                <div class="col-xs-8 col-sm-6 col-md-1">
                        <div class="form-group">
                         <asp:Label ID="Label2" runat="server" Text="Event Type" localize="QCPlan_Label2"></asp:Label>
                              
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                           
                             <asp:DropDownList Entity="EventType"  ID="EventType" CssClass="form-control" runat="server">
                             <asp:ListItem Value=0 Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                  
                 </select>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-1">
                        <div class="form-group">
                            <label for="txtDate" localize="QCPlan_txtDate2">Event Name</label>
                        </div>
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input type="text" Entity="EventName" Val-Key="EventName"  id="Text1" class="form-control" />
                        </div>
                       </div>
                </div>
                      <div class="col-xs-8 col-sm-6 col-md-1">
                        <div class="form-group">
                            <label for="ddlStatus" localize="QCPlan_ddlStatus">Status</label>
                        </div>
                </div>
              <div class="col-xs-8 col-sm-6 col-md-2">
                        <div class="form-group">
              
                        <asp:DropDownList Entity="Status" ID="ddlStatusFilter" CssClass="form-control" runat="server">
                             <asp:ListItem Value=0 Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                        
                              
                        </div>
                </div>
                </div>
      
            
        
           
           <div class="text-center">
           <input type="button" class="btn btn-primary " id="btnFilter" value="Filter" localize="QCPlan_btnFilter"/>
           </div>
           <br />
           <br />
           <div class="gridTable bounceinup" id ="tblSheduleDetails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblScheduledList">
                                  <thead><tr>
    <th localize="PlanScheduleID">PlanScheduleID</th>                  
  <th localize="SNO">S.No</th>
  <th localize="EventTypeID">Event Type ID</th>
  <th localize="QCPlan_ddlEventType">Event Type</th>
  <th localize="QCPlan_txtDate2">Event Name</th>
  <th localize="DateTime">Date Time</th>
    <th localize="QCPlan_Label1">Location</th>
    <th localize="Status">Status</th>
    <th localize="Action">Action</th>                                          
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>  
          </div>
          </div>
        
            
               <div id="cardCreate" class="card" style="display:none";>
          <div class="header">
                     <h2 class="strong">Plan & Schedule</h2>
                      <div class="right">
                     <h4 id="linkBack">Go Back</h4>
                     </div>
                </div>
      <div class="body">
        <div class="row">
                
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="ddlEventType" class="control-label" localize="QCPlan_ddlEventType">Event Type</label>
                               <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">
                        <div class="form-group">
          
                        <asp:DropDownList ID="ddlEventType" Entity="EventType" CssClass="form-control" runat="server">
                             <asp:ListItem Value=0 Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                        
                                                   </div>
                </div>
            
            </div>
          <div class="row">
                
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label for="txtEventName" class="control-label" localize="QCPlan_txtEventName">Event Name</label>
                               <span class="required">*</span>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-2 col-md-6">
                        <div class="form-group">
                        <input type="text"  id="txtEventName" Val-Key="EventName" Entity="EventName" EventName placeholder="Enter Event Name" class="form-control" />
                        
                                                   </div>
                </div>
               
            </div>
            
            <div class="row">
           
            <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="ddlStatus" localize="QCPlan_ddlStatus1">Event Date & Time</label>
                               <span class="required">*</span>
                        </div>
                </div>
                 <div class="col-sm-2 col-md-2 col-lg-8">
            <div id="timePair" IEntity="EventType" class="timepair">
            <input type="text" valType="date" readonly="readonly" Entity="FromDate" id="itxtFromDate" aEntity="EventType" class="" />
            <input type="text" id="fromTime"  Entity="StartTime" class="time start" /> to
            <input type="text" id="toTime"     Entity="EndTime" class="time end" />
            <input type="text" valType="date" readonly="readonly"  Entity="Todate" id="itxtToDate" aEntity="EventType" class="" />
           </div>
           
           </div>
          
            </div>
        
         <div IA="show" MRM="hide" TP="hide" class="row" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="txtScope" localize="QCPlan_txtScope">Audit Scope</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" Entity="AuditScope" Val-Key="AuditScope" id="txtScope" class="form-control" > </textarea>
                        
                                                   </div>
                </div>
               
            </div>
            <div IA="show" MRM="show" TP="show" class="row" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="txtScope" localize="QCPlan_txtScope2">Venue</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-6">
                        <div class="form-group">
                        <%--<textarea  rows="4" cols="50" Entity="EventScope" id="Textarea1" class="form-control" > </textarea>--%>
                        <input type="text"  id="txtVenue" Entity="Venue" Val-Key="Venue"  placeholder="Enter Venue" class="form-control" />
                        
                                                   </div>
                </div>
               
            </div>
         <div IA="show" MRM="hide" TP="hide" class="row" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="txtCriteria" localize="QCPlan_txtCriteria">Audit Criteria</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" Val-Key="AuditCriteria" Entity="AuditCriteria" id="txtCriteria" class="form-control" > </textarea>
                                                   </div>
                </div>
                
            </div>
            <div  IA="hide" MRM="hide" TP="show" class="row" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="txtCriteria">Topic</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" Entity="Topic" Val-Key="Topic" id="txtTopix" class="form-control" > </textarea>
                                                   </div>
                </div>
                
            </div>
            <div IA="hide" MRM="show" TP="hide" class="row" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="txtCriteria">Agenda</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-6 col-md-6">
                        <div class="form-group">
                        <textarea  rows="4" cols="50" Entity="Agenda" Val-Key="Agenda" id="txtAgenda" class="form-control" > </textarea>
                                                   </div>
                </div>
                
            </div>
            <div class="row">
            <div class="col-lg-8">
           <div IA="show" MRM="show" TP="hide" class="row">
                    <!--Row-->
                    
                     <div class="col-xs-8 col-sm-3 col-md-2 col-lg-3">
                            <div class="form-group">
                                <asp:Label CssClass="control-label" ID="lblFileupload" runat="server" Text="Reference Documents" localize="QCPlan_lblFileupload"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-3 col-md-1 col-lg-2">
                            <div class="form-group">
                                <asp:Label  CssClass="control-label" ID="lblFileType" runat="server" Text="Select File Type" localize="QCPlan_lblFileType"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-3 col-md-2 col-lg-3">
                            <div class="form-group">
                                  <asp:DropDownList ID="ddlFileType" runat="server" CssClass="form-control">
                       
                                    <asp:ListItem Value=0 Text="--Select--"></asp:ListItem>
                                     </asp:DropDownList>
                            </div>
                    </div>
               
                    <div class="col-xs-8 col-sm-3 col-md-2 col-lg-4">
                       <div class="form-group" style="overflow:hidden;">
                                <asp:FileUpload ID="txtfileupload"  runat="server" accept=".pdf,image/*" meta:resourcekey="FileUpload1Resource1" />
                                     <%--<div class="MultiFile-list" id="txtfileupload_wrap_list">
                                     </div> --%>
                         </div>
                    </div>
                    
               
                     
                   
                    <!--Row-->
                   </div>
           <div IA="show" MRM="hide" TP="hide" class="row">
               
                    <div class="col-xs-8 col-sm-2 col-md-2 col-lg-3">
                        <div class="form-group">
                               <label class="control-label" for="ddlProgType" localize="QCPlan_ddlProgType">Audit Program Type</label>
                        </div>
            </div>
                <div class="col-xs-8 col-sm-4 col-md-4 col-lg-3">
                        <div class="form-group">
                     <%--   <select  id="ddlProgType" Entity="ProgramType" class="form-control">
                        <option value="0">---SELECT---</option>
                        </select>--%>
                        <asp:DropDownList ID="ddlProgType" Entity="ProgramType" CssClass="form-control" runat="server">
                             <asp:ListItem Value=0 Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                                                   </div>
                </div>
                
            </div>
            <div IA="show" MRM="hide" TP="hide" class="row">
                
                    <div class="col-xs-8 col-sm-2 col-md-2 col-lg-3">
                        <div class="form-group">
                               <label class="control-label" for="ddlDept" localize="QCPlan_ddlDept">Department To Audit</label>
                        </div>
                </div>
                <div class="col-xs-8 col-sm-4 col-md-4 col-lg-3">
                        <div class="form-group">
                        <select   id="ddlDepartment" Entity="DeptID" class="form-control">
                       <%-- <option value="0">---SELECT---</option>--%>
                        </select>
                                                   </div>
                </div>
               
            </div>
            <div class="row">
                
                    <div class="col-sm-2 col-md-2 col-lg-3">
                        <div class="form-group">
                               <label class="control-label" for="ddlStatus" localize="QCPlan_ddlStatus">Status</label>
                        </div>
                </div>
                <div class="col-sm-4 col-md-4 col-lg-3">
                        <div class="form-group">
                      <%--  <select id="ddlStatus" Entity="Status" class="form-control">
                        <option>---SELECT---</option>
                        </select>--%>
                        <asp:DropDownList ID="ddlStatus" Entity="Status" CssClass="form-control" runat="server">
                             <asp:ListItem Value=0 Text="---Select---"> </asp:ListItem>
                             </asp:DropDownList>
                                                   </div>
                
                </div>
            </div>
            </div>
            <div IA="show" MRM="show" TP="hide"  class="col-lg-4">
                  <div class="MultiFile-list" id="txtfileupload_wrap_list">
                  
                  </div> 
            </div>
            </div>
            <div class="row">
                
                    <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <label class="control-label" for="ddlStatus" localize="QCPlan_ddlStatus21">Audit Team Member</label>
                        </div>
                </div>
                <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                        <select id="ddlTeamMember"  class="form-control">
                        <%--<option value="0" >---SELECT---</option>--%>
                        </select>
                                                   </div>
                </div>
                
                  <div class="col-sm-2 col-md-2">
                        <div class="form-group">
                               <input type="text" class="form-control" Val-Key="GuestMail" id="txGuestEmail" placeholder="Enter Guest Name" />
                               <asp:HiddenField ID="hdnParticipants" runat="server"></asp:HiddenField>
                         <%--       <asp:HiddenField  ID="PSID" runat="server" Entity="PlanScheduleID"></asp:HiddenField>--%>
                               <asp:HiddenField ID="hdnParticipantEmail" runat="server"></asp:HiddenField>
                               <input type="hidden" id="PSID" value="0" Entity="PlanScheduleID" />
                               <input type="hidden" id="hdnRoleID" value="0"/>
                                    <asp:HiddenField ID="hdnDeviceMappingId" runat="server" />
        <asp:HiddenField ID="hdnEventType" runat="server" />
        <input type="hidden" id="hdnFilepath"  />
                        </div>
                </div>
                <div class="col-sm-1 col-md-1">
                        <div class="form-group">
                              <input type="button" value="Add" class="btn btn-success" id="btnAddMail" localize="QCPlan_btnAddMail" />
                       
                                                   </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-3" >
                        <div class="">
                             <label id="lblMailID" class="" localize="QCPlan_lblMailID">Guests</label>
                                                   </div>
                                                   <div class="MultiFile-list" id="divGuestMail">
                                                   
                                                   </div>
                </div>
                
               
            </div>
            
            <div class="row">
                <div class="text-center">
            
                        <input type="button" id="btnClear" class="btn btn-success " onclick="clearControls();" value="Clear" localize="QCPlan_btnClear"/>
                       
              
                
                        <input type="button" id="btnSave" class="btn btn-success" value="Save" localize="QCPlan_btnSave" />
                      
              
                        <input type="button" id="btnSend" class="btn btn-success" value="Send" localize="QCPlan_btnSend" />
                        
                </div>
                </div>
            </div>
              </div>
              </div>
                
               
                <div class="form-group text-center">
                    

                      
                            <asp:HiddenField ID="hdnMessages" Value="" />
                            <asp:HiddenField ID="hdnSListClientDisplay" Value="" />
                            <asp:HiddenField ID="hdnSListUserMsg" Value="" />
                            <asp:HiddenField ID="HiddenField1" Value="" />
             

                  
                     <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="" />
                     <asp:HiddenField ID="hdnInsID" runat="server" Value="" />
                     
                   <asp:HiddenField ID=RoleID runat="server" Value="" />
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
   
   <%--<script src="dist/js/jquery-1.11.2-ui.min.js" type="text/javascript"></script>--%>
    <!-- Bootstrap 3.3.2 JS -->

    <script src="Script/moment.js" type="text/javascript"></script>
    <script src="Script/jquery.timepicker.min.js" type="text/javascript"></script>

    <script src="Script/DateTimePair/datepair.js" type="text/javascript"></script>
  <%-- <script src="Script/DateTimePAir/datepair.min.js" type="text/javascript"></script>--%>
  
  <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <link href="Script/DateTimePair/jquery.timepicker.css" rel="stylesheet" type="text/css" />
     <script src="Script/DateTimePair/Jquery.datepair.js" type="text/javascript"></script>
    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<%--   <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>--%>


    <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>


    <script src="Script/ControlLength.js" type="text/javascript"></script>

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <!-- Include the plugin's CSS and JS: -->

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>


    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>


    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <script src="Script/Qcplan.js" type="text/javascript"></script>
    <script type="text/javascript">

        var lid = '<%=Session["LID"] %>';
        var UserID = '<%=Session["UID"] %>';
        var ILocationID = '<%=ILocationID%>';
        var DelFiles = [];
        var path;
        $(function() {


        var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
        GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');
        });
        function populateOnEdit(aData) {
            if (aData != null && aData != '') {
                var path = $('#hdnFilepath').val();
                var arr = aData.split(',');
                for (var i = 0; i < arr.length; i++) {
                    var lst = arr[i].split('~');
                    var d = '<div id="' + lst[2] + '" class="MultiFile-label">\
                     <a class="MultiFileremove"  filename="' + lst[2] + '" fileid="' + lst[1] + '" filetype="' + lst[3] + '" href="#" innerPath="' + lst[0] + '" style="color:red;font-size:large;font-weight:900">x</a>\
                     <span href="' + path + lst[0] + '" class="MultiFile-title clickable" >' + lst[2] + '  -  ' + lst[3] + '</span>\
                     </div>';


                    $("#txtfileupload_wrap_list").append(d);
                }
                $('.MultiFileremove').click(function() {
                    var div = $(this).parent('div');
                    var id = $(div).attr('id')
                    var ke = $("#hdnFilepath").val() + '~' + 'AnalyzerMaster~' + $(this).attr('filetype') + '~' + $('#txtDeviceCode').val() + '~Y~' + $(this).attr('innerPath') + '~' + $(this).attr('fileid') + '~' + $(this).attr('filename');
                    DelFiles.push(ke);
                    $(div).remove();

                });
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
