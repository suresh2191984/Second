<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExternalAudit.aspx.cs" EnableEventValidation="false" Inherits="QMS_ExternalAudit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>External Audit</title>
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
                     <h2 class="strong">External Audits</h2>
               
                </div>
                <div class="body">
                    <div class="row">
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                            <asp:Label ID="lblOrganization" runat="server" Text="Organization" localize="ExternalAudit_lblOrganization"></asp:Label>
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
                               <asp:Label ID="Label1" runat="server" Text="Location" localize="ExternalAudit_Label1"></asp:Label>
                               </div>
                     </div>
                       
                              
                    <div class="col-xs-8 col-sm-6 col-md-2">
                      <div class="form-group">
                             <select id="txtLocation" Entity="AddressID" data="Location" change="ddlOrganization"  class="form-control">
                   <option value="0">---Select---</option>
                 </select>
                 </div>
                       
                   </div>
                
                <%-- <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                            <label for="txtDate">From Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtFromDate" Entity="FromDate" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                       </div>
                </div>--%>
               
                     
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblDeviceCode" runat="server" Text="Audit No" localize="ExternalAudit_lblDeviceCode"></asp:Label>
                          <%--       <span class="required">*</span>--%>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <input type="text" readonly="readonly" class="form-control" Entity="EnternalAuditID" id="txtAuditNumber" />
                            </div>
                            
                    </div>
                    </div>
                    <div class="row">
                    <div class="col-lg-2 col-xs-4 col-sm-4 col-md-4">
                     <div class="form-group">
                            <label for="txtDate">Date & Time</label>
                            </div>
                    </div>
                    <div class="col-lg-10 col-xs-8 col-sm-8 col-md-8">
                        <div id="timePair" IEntity="EventType" class="timepair">
            <input type="text" valType="date" readonly="readonly" Entity="FromDate" id="itxtFromDate" aEntity="EventType" class="" />
            <input type="text" id="fromTime"  Entity="StartTime" class="time start" /> to
            <input type="text" id="toTime"     Entity="EndTime" class="time end" />
            <input type="text" valType="date" readonly="readonly"  Entity="Todate" id="itxtToDate" aEntity="EventType" class="" />
           </div>
           </div>
                    </div>
                    <div class="row">
                <%--     <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                            <label for="txtDate">To Date</label>
                            </div>
                      
                </div>
                 <div class="col-xs-8 col-sm-6 col-md-2">
                       <div class="form-group">
                         <div class="input-group">
                         <input id="txtToDate" Entity="Todate" valType="date" class="form-control" />
                                       <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                        </div>
                        </div>
                       </div>
                </div>--%>
  
                     
                      <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Audit Agency" localize="ExternalAudit_Label4"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <input type="text" Entity="AuditAgency" Val-Key="AuditAgency" class="form-control" id="txtAuditAgency" />
                            </div>
                    </div>
                          <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" Text="Major NC" localize="ExternalAudit_Label5"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <input type="text" Entity="MajorNC" Val-Key="MajorNC"  class="form-control" id="txtMajorNC" />
                            </div>
                    </div>
                  
       
                      <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="Label6" runat="server" Text="Minor NC" localize="ExternalAudit_Label6"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <input type="text" Entity="MinorNC" Val-Key="MinorNC" class="form-control" id="txtMinorNC" />
                            </div>
                    </div>
                  
                    </div>
                    <div class="row">
                    
                 
                      <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblMethod" runat="server" Text="List of Auditors" localize="ExternalAudit_lblMethod"></asp:Label>
                            </div>
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                   <input type="text" Entity="AuditorsList" Val-Key="AuditorsList" class="form-control" id="txtAuditors" />
                            </div>
                    </div>
                    
                    <div class="col-xs-8 col-sm-6 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblPrinciple" runat="server" Text="Department" localize="ExternalAudit_lblPrinciple"></asp:Label>
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
                                <asp:Label ID="Label2" runat="server" Text="Status" localize="ExternalAudit_Label2"></asp:Label>
                            </div>
                    </div>
                     <div class="col-xs-8 col-sm-6 col-md-2">
                           <div class="form-group">
                                 <asp:DropDownList ID="ddlStatus" Entity="Status"  runat="server" CssClass="form-control">
                                  
                                 </asp:DropDownList>
                            </div>
                    </div>
                 
                         
                    
                    
                   </div>
                   <div class="row">
                   <div class="col-xs-8 col-sm-6 col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="lblFileUpload" runat="server" Text="File Upload" localize="ExternalAudit_lblFileUpload"></asp:Label>
                                </div>
                        </div>
                        <div class="col-xs-8 col-sm-6 col-md-2">
                               <div class="form-group" style="overflow:hidden;">
                                     <asp:FileUpload ID="txtfileupload" runat="server" accept=".pdf,image/*"    meta:resourcekey="FileUpload1Resource1" />
                                     <div class="MultiFile-list" id="txtfileupload_wrap_list">
                                     </div> 
                                     
                                </div>
                        </div>
                   
                   </div>
                    
       

                    <div class="row" style="padding-left:20px; padding-right:20px;">
                    </div>
                    <div class="form-group text-center">
                    
                         <input id="btnClear" type="button" class="btn btn-success" value="Clear" localize="ExternalAudit_btnClear"/>
                         <input id="btnSave" type="button" class="btn btn-success" value="Save" localize="ExternalAudit_btnSave"/>
                       

        
                       
                            <asp:HiddenField ID="hdnMessages" Value="" />
                            <asp:HiddenField ID="hdnSListClientDisplay" Value="" />
                            <asp:HiddenField ID="hdnSListUserMsg" Value="" />
                            <asp:HiddenField ID="hdnFilepath" Value="" />
                </div>

                     <div class="gridTable bounceinup" id="externalAuditList" runat="server">
                     
                            <div class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblexternalAuditDetails" style="display:none" >
                                  <thead>
                                        <tr>
                                            <th localize="SNo">SNo</th>
                                            <th localize="ExternalAudit_lblDeviceCode">AuditNo</th>
                                            <th localize="ExternalAudit_txtDate">Date & Time</th>
                                            <th localize="ExternalAudit_Label4">Audit Agency</th>
                                            <th localize="ExternalAudit_Label5">Major NC</th>
                                            <th localize="ExternalAudit_Label6">Minor NC</th>
                                            <th localize="ExternalAudit_Auditors">Auditors</th>
                                            <th localize="ExternalAudit_lblPrinciple">Department</th>
                                            <th localize="ExternalAudit_Label2">Status</th>
                                            <th localize="Action">Action</th>
                                        
                                        </tr>
                                  </thead>
                              </table>
                           </div>
                    </div>
                     
                     <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="" />
                     <asp:HiddenField ID="hdnInsID" runat="server" Value="" />
                     
                   <asp:HiddenField ID=RoleID runat="server" Value="" />
            </div>
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
    

    <script src="Script/ExternalAudit.js" type="text/javascript"></script>
    <script type="text/javascript">
        var DelFiles = [];
        $(function() {


            var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
            var path = GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');
           
        });


        function populateOnEdit(aData) {
            $("#txtfileupload_wrap_list").html('');
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
