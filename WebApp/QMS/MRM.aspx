<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MRM.aspx.cs" Inherits="QMS_MRM"  EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>MRM</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport' />
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="Script/DateTimePAir/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="Script/tooltip.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <link href="Script/jquery-ui-git.css" rel="Stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
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
        .dropdown-menu
        {
            max-height: 300px;
            overflow-y: auto;
            overflow-x: hidden;
        }
  
        label
        {
            font-weight: 600;
        }
        .lblData
        {
            font-weight: normal !important;
        }
    </style>
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
                    <section class="content">
          <div class="fadeindown" id="maincontent">
             <div id="filterCard" class="card">
          
              <div class="header">
                     <h2 class="strong">Management Review Meeting</h2>
               
                </div>
                <div class="body">
                 <div class="row">
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                           <%-- <asp:Label ID="Label6" runat="server" Text="Organization" ></asp:Label>--%>
                              <label for="Organization" localize="MRM_Organization">Organization</label>
                            <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="input-group">
                                    <select id="ddlOrganization" Entity="OrgID" data="Organization" class="form-control">
                <option value="0">---Select---</option>
                </select>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                       
                          <div class="form-group">
                               <%--<asp:Label ID="Label8" runat="server" Text="Location"></asp:Label>--%>
                               <label for="Location" localize="MRM_Location">Location</label>
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
                            <label for="txtDate" localize="MRM_txtDate">From Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtFromDate"  readonly="readonly" Entity="FromDate" runat="server" valType="date" class="form-control" />
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
                            <label for="txtDate" localize="MRM_txtDate2">To Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtToDate" readonly="readonly" Entity="Todate" runat="server" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                       </div>
                </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <%--<asp:Label ID="Name" runat="server" Text="Name"></asp:Label>--%>
                                <label for="Name" localize="MRM_Name">Name</label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                           <div class="form-group">
                                 <asp:TextBox ID='txtName' Entity="EventName" Val-Key="EventName" runat="server" CssClass="form-control">
                                  
                                 </asp:TextBox>
                            </div>
                    </div>
                            <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                              <%--  <asp:Label ID="Label12" runat="server" Text="Audit No"></asp:Label>--%>
                                 <label for="AuditNo" localize="MRM_AuditNo">Audit No</label>
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
                            <label for="ddlStatus" localize="MRM_ddlStatus">Status</label>
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
                    

                         <input id="btnShowTask" type="button" class="btn btn-success" value="Show Task" localize="MRM_btnShowTask"/>

        
                       
                </div>
          </div>
                   <div class="row">
                    <div class="gridTable bounceinup" id ="tblSheduleDetails"  style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblScheduledList">
                                  <thead><tr>
      <th class="hide_column">PlanID</th>             
    <th localize="SNO">S.No</th>
    <th localize="MRM_Name">Name</th>
    <th localize="MRM_MRMNO">MRM No.</th>
    <th localize="QMS_Dashboard_aspx_ProposedDate">Date</th>
    <th localize="MRM_Location">Location</th>
    <th localize="Status">Status</th>
 <%--   <th>Action</th>--%>
                                           
                                        </tr>
                                  </thead>
                                  
                              </table>
                           </div>
                    </div>  
          </div>   
        
                
                </div>
                </div>
               <div id="cardList" class="card">
          
          <div class="header">
         
                     <h2 class="strong">Management Review Meeting-->MOM</h2>
                     
                     <div class="right">
                     <h4 id="btnBack">Go Back</h4>
                    </div>
                </div>
          <div class="body">
           
                    <div class="row">
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                           <%-- <asp:Label ID="lblMRMNo" runat="server" Text="MRM NO:" ></asp:Label>--%>
                            <label for="MRMNO" localize="MRM_MRMNO">MRM NO: </label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="input-group">
                                   <%-- <label for="ddlOrganization" Entity="OrgID" Text="" >--%>
                                     <asp:Label ID="lblMRMNo1" runat="server"  ></asp:Label>

                
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                       
                          <div class="form-group">
                          <%--     <asp:Label ID="lblDateTime" runat="server" Text="Date & Time:"></asp:Label>--%>
                               <label for="DateTime" localize="MRM_DateTime">Date & Time: </label>
                               </div>
                     </div>
                       
                              
                    <div class="col-xs-8 col-sm-6 col-md-2">
                      <div class="form-group">
                            <%-- <label for="" Entity="Location"  Text="" >--%>
                             <asp:Label ID="lblDateTime1" runat="server" ></asp:Label>
                             
                 
                 </div>
                       
                   </div>
                
                 <div class="col-xs-8 col-sm-6 col-md-2 col-lg-2">
                            <div class="form-group">
                              <%-- <asp:Label ID="lblVenue" runat="server" Text="Venue:"></asp:Label>--%>
                               <label for="lblVenue" localize="MRM_lblVenue">Venue: </label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2 col-lg-2 ">
                        <div class="form-group">
                         
                             <%-- <label for="txtDate" Entity="Venue" Text="" >--%>
                                <asp:Label ID="lblVenue1" runat="server" ></asp:Label>
                              
                              </div>
                            </div>
                         </div>
                   
                    <div class="row">
                  <div class="col-lg-2 col-xs-10 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="lblParticipants" localize="MRM_lblParticipants">Participant </label>
                            </div>
                    </div>
                    
                    <div class="col-lg-4 col-xs-10 col-sm-2 col-md-2">
                           <%-- <div class="form-group">                            
                                  <label id="lblParticipants" class="lblData"></label>
                            </div>--%>
                            <div id="divGuestMail1" class="w-100p" runat="server">
                            </div>
                    </div>
                    <div class="col-lg-6 col-xs-8 col-sm-6 col-md-2">
                             <div class="form-group">
                                 <div class="MultiFile-list" id="txtfileupload_wrap_list">
                  
                                </div> 
                            </div>
                            </div>
                  </div>
                    <div class="row">
                      <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <%--<asp:Label ID="lblAgenda" runat="server" Text="Agenda"></asp:Label>--%>
                                 <label for="lblAgenda" localize="MRM_lblAgenda">Agenda: </label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2 ">
                            <div class="form-group">
                                <%--<label for="txtAuditor"  Text="" >--%>
                                <asp:Label ID="lblAgenda1" runat="server" ></asp:Label>
                            </div>
                    </div>
                  
                       <%--  <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" Text="MRM No"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                               <label for="txtDepartment" Entity="PlanScheduleID" Text="" >
                            </div>
                    </div>
                  --%>
       
                     
                    </div>
                   
            <div class="row" >
                  <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="ddlorg" localize="MRM_ddlorg">Department </label>
                                   <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">    
                              <select id="ddlorg1" Entity="OrgID" data="Department" class="form-control">                     
                                   </select>
                            </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <%-- <label for="lblParticipant">Participant </label>--%>
                                 <%--<asp:Label ID="lblpointsDiscussed" runat="server" Text="Points Discussed"></asp:Label>--%>
                                 <label for="lblpointsDiscussed" localize="MRM_lblpointsDiscussed">Points Discussed: </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <%--<select class="form-control" id="lblParticipant">
                                  
                                  </select>--%>
                                  <asp:TextBox ID="txtpointsDiscussed" Val-Key="PointsDiscussed"  class="form-control" runat="server"></asp:TextBox>
                                  
                            </div>
                    </div>
                    
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtToltal" localize="MRM_txtToltal">Action Proposed</label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <input type="text" class="form-control" Val-Key="ActionProposed" id="txtToltal"/> 
                            </div>
                    </div>
                  </div>  
               <div class="row">
                 
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtCompletion" localize="MRM_txtCompletion">Proposed Completion Date</label>
                                   <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <%--    <div class="form-group">     
                            <div class="input-group>                      
                                 <input type="text" readonly="readonly" class="form-control" id="txtCompletion"/>
                                 <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div> 
                               </div>        
                            </div>--%>
                            <div class="form-group">
                         <div class="input-group">
                         <input id="txtCompletion"  readonly="readonly"  runat="server" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                        </div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                               <label class="control-label" for="ddlStatus">Audit Team Member</label>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                        <div class="form-group">
                        <select id="ddlTeamMember"  class="form-control">
                        
                        </select></div>
                    </div>
                    
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                  <label for="txtResponsibility" localize="MRM_txtResponsibility">Responsibility </label>
                                   <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">                            
                                 <input type="text" class="form-control" id="txtResponsibility"/> 
                            </div>
                             <asp:HiddenField ID="hdnParticipants" runat="server"></asp:HiddenField>
                               <input type="hidden" id="hdnRoleID" value="0"/>
                    </div>
                                  
                 </div>
                <div class="row">  
                <div class="col-xs-6 col-sm-2 col-md-2">                            
                                  <label for="ddlStatus" localize="MRM_ddlStatus">Status :</label>
                                   <span class="required">*</span>
                                 </div>
                                 
                <div class="col-xs-6 col-sm-2 col-md-2">
                                  
                          
                        
                            <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server"></asp:DropDownList>                       
                                 
                            </div>
                 </div>
                
                      
                     <div class="row">
                     <div class="text-center">
                    <input type="button"  value ="Save" id="Button1" onclick="SaveLJFilter(this.value);" class="btn btn-success"  />
                    <input type="button" id="Clear" class="btn btn-success" onclick="ClearLJFilter();" value="Clear"/>
                    </div>
                    </div>
                    
                          <div id="NoRec">
                  <label class="text-red" style="display:none">
                  No Matching Record Found..</label>
              </div>
              <div class="row">
              <div id="Div1"  runat="server" class="row gridTable bounceinup">
                  <div class="table-responsive">
                      <table id="tblTraining" 
                          class="table tbl-grid table-bordered form-inline table-striped" >
                          
                          <thead>
                              <tr>
                               <th class="hide_column">scheduledMOMID</th>
                                  <th localize="SNO">S.No</th>
                                  <th localize="MRM_MRMNO">MRM NO.</th>
                                  <th localize="MRM_ddlorg">
                                      Department</th>
                                  <th localize="MRM_lblpointsDiscussed">
                                      Point Discussed</th>
                                  <th localize="MRM_txtToltal">
                                      Action Proposed</th>
                                  <th localize="MRM_txtResponsibility">
                                      Responsibility</th>
                                  <th localize="Status">
                                      Status</th>
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
              
                
               </div>
               
                    
                   <div class="row" style="padding-left:20px; padding-right:20px;">

                  <input type="hidden" id="PSID" value="0" Entity="PlanScheduleID" />
                       
         
                
            </div>
               </div>
                </div>
                <div class="form-group text-center">
                    <asp:HiddenField runat="server" ID="hdnMessages" Value="" />
                    <asp:HiddenField runat="server" ID="hdnSListClientDisplay" Value="" />
                    <asp:HiddenField runat="server" ID="hdnSListUserMsg" Value="" />
                    <asp:HiddenField runat="server" ID="hdnFilepath" Value="" />
                    <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="" />
                    <asp:HiddenField ID="hdnInsID" runat="server" Value="" />
                    <asp:HiddenField ID="RoleID" runat="server" Value="" />
                    <asp:HiddenField ID="hdnPlanID" runat="server" Value="" />
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
                <button id="btnClose" type="button" class="fa fa-times fa-2x pull-right circle" style="border-radius: 50px;"
                    data-dismiss="modal">
                </button>
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
        <asp:HiddenField ID="hdnOrgID" runat="server" Value="" />
        <asp:HiddenField ID="hdnScheduledMOMID" runat="server" Value="" />
        </form>
    </div>

    <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Script/ControlLength.js" type="text/javascript"></script>

    <script src="Script/jquery.timepicker.min.js" type="text/javascript"></script>

    <%-- <script src="Script/DateTimePair/datepair.js" type="text/javascript"></script>--%>

    <script src="Script/DateTimePAir/datepair.min.js" type="text/javascript"></script>

    <script src="Script/DateTimePair/Jquery.datepair.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="Script/tooltip.js" type="text/javascript"></script>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="Script/moment.js" type="text/javascript"></script>

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <script src="Script/QmsFileuplaod.js" type="text/javascript"></script>

    <script type="text/javascript" src="Script/MRM.js"></script>

    <%--
    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">



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
