<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="QMS_UserManagement"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>User Management</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <%--     <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />--%>
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <%--    <link href="bootstrap/css/bootstrap-select.css" rel="stylesheet" type="text/css" />--%>
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../qms/plugins/multiselect/css/bootstrap-multiselect.css"
        type="text/css" />
    <%--  <link href="Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />--%>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
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
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
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
                                <h4 class="strong">User Selection</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblRole" runat="server" Text="Role" localize="UserManagement_lblRole"></asp:Label>
                                 <span class="required">*</span>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                             
                                 </asp:DropDownList>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                <asp:Label ID="lblUs4er" runat="server" Text="Username" localize="UserManagement_lblUs4er"></asp:Label>                                
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <asp:DropDownList ID="ddlUsers" runat="server" CssClass="chosen-select form-control" multiple="multiple">                             
                                 </asp:DropDownList>
                                 
                                 <label id="lblUser" class="form-control" style="display:none;">  </label>
                            </div>
                    </div>
                    <div class="col-xs-6 col-sm-2 col-md-2">
                            <div class="form-group">
                                 <asp:Label ID="lblwidget" runat="server" Text="Widgets" localize="UserManagement_lblwidget"></asp:Label>
								 
                            </div>
                    </div>
                     <div class="col-xs-6 col-sm-2 col-md-2">
                           <div class="form-group">
                                <asp:DropDownList ID="ddlWidget" runat="server" CssClass="chosen-select form-control" multiple="multiple">                                                                                      
                                 </asp:DropDownList>
                            </div>
                    </div>
                    </div> 
          
                <!-- Row -->
                <div class="row">
                    <div class="form-group text-center">
                    <input type ="button" id="btnCancel"  class="btn btn-success"  value="Cancel" localize="UserManagement_btnCancel"/>
                        <input type ="button" id="btnSave" onclick="if(!Saveusermappedwidgets()){ return false;}" class="btn btn-success" value="Submit" localize="UserManagement_btnSave" />
                     
                    </div>
                </div>                             
            </div>
             <!-- Row -->
                <asp:HiddenField ID="hdnloginid" runat="server" Value="0" />
            <!-- Row -->
                     <div class="gridTable bounceinup" id ="Bindtable" runat="server" style="overflow:auto !important">
                          <div  class="table-responsive">
                              <table class="table tbl-grid table-bordered form-inline table-striped" id ="tblBindtable">
                                  <thead>
                                        <tr>
                                        <th class="hide_column">LoginID</th>
                                            <th localize="QMS_Dashboard_aspx_LotName">Name</th>
                                            <th class="hide_column">RoleID</th>
                                            <th localize="UserManagement_lblRole">Role</th>
                                            <th localize="UserManagement_MobileNumber">Mobile Number</th>
                                            <th localize="UserManagement_lblEmailId">Email ID</th>
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

    <script src="../QMS/Script/bootstrap-multiselect.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <script src="dist/js/demo.js" type="text/javascript"></script>
    
    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="Script/QC_Common.js" type="text/javascript"></script>

    <%--<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.js"></script>--%>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function() {
         var   resdata = [];
            BindRoles();
            $('#ddlRole').change(function() {
                $("#ddlUsers").prop("disabled", false);
                loadusers();
                loadwidgets();
                loaduserDeatils();

            });


            $("#btnCancel").click(function() {
                $("#ddlUsers").prop("disabled", false);
               // loadusers();
               // loadwidgets();
                // loaduserDeatils();
                //$("#ddlUsers").show();
                $("#ddlUsers option").removeAttr('selected');
                $("#ddlUsers").multiselect('refresh');
                $("#ddlWidget option").removeAttr('selected');
                $("#ddlWidget").multiselect('refresh');
               // $('#ddlWidget option').prop('selected', false);
                $('.multiselect').show(); 
               // $("#lblUser").html(name);
                $("#lblUser").hide();

            });
            $('#ddlUsers').multiselect('dataprovider', resdata);
            $('#ddlWidget').multiselect('dataprovider', resdata);


        });


        function Save(result) {
            var OrgID = '<%= Session["OrgID"] %>';
            
            var RoleID = $('#ddlRole').val();
            if (result == 'Submit') {
                var LoginID = $('#ddlUsers').val();
            }
            else {
                var LoginID = JSON.parse("[" + document.getElementById('hdnloginid').value + "]"); 
            }
            var WID = $('#ddlWidget').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/pSaveWidgetsbyroleanduser",
                data: JSON.stringify({ RoleID: RoleID, OrgID: OrgID, LoginID: LoginID, WID: WID
                }),
                dataType: "json",
                async: false,
                success: function(data) {
                    var returncode;
                    returncode = data.d;
                    if (returncode > 0) {
                        loaduserDeatils();
                        alert('Widget(s) Mapped sucessfully');
                        $('#ddlRole').change();
                        document.getElementById('btnSave').value = 'Submit';
                        $("#ddlUsers").prop("disabled", false);

                    }
                    else {

                        alert('Mapping not saved!');
                       
                    }
                    return false;
                },
                error: function(xhr, status, error) {
                    alert(error);
                    return false;
                }

            });

        }

        function Saveusermappedwidgets() {
            var flag = 0;
            var result = document.getElementById('btnSave').value;

            if (result != 'Update') {
                if (ValidateSave() == true) {

                    Save(result);
                }
                else {
                    return false;
                }

            }
            else {
                var valWidget = $('#ddlWidget').val();
                if (valWidget == null || valWidget.length <= 0) {
                    alert('Please Choose atleast one widget');
                    flag = 1;
                    return false;
                }
                if (flag == 0) {
                    Save(result);
                }
            }

        }

        function ValidateSave() {

         var valWidget = $('#ddlWidget').val();
         var valUsers = $('#ddlUsers').val();

         if ($('#ddlRole option:selected').val() == "0") {
             alert('Please Choose Role');

         }

         else if (valUsers == null ||  valUsers.length <= 0) {
             alert('Please Choose User');

         }

         else if (valWidget == null || valWidget.length <= 0) {
             alert('Please Choose atleast one widget');

         }
         else {
             return true;
         }
        return false;
        }



        function loaduserDeatils() {

            var OrgID = '<%= Session["OrgID"] %>';
            var RoleID = $('#ddlRole').val();
            var LoginID = 0;
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../WebService.asmx/pGetWidgetsuserdetails",
                data: JSON.stringify({ RoleID: RoleID, LoginID: LoginID, orgID: OrgID }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var UserList = data.d;
                    if (UserList.length > 0) {
                        var parseJSONResult = UserList;
                        $('#Bindtable').show();
                        $('#Bindtable  tbody > tr').remove();
                        $('#Bindtable').show();
                        $('#tblBindtable').dataTable({
                            paging: true,
                            "iDisplayLength": 5,
                            "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                            data: parseJSONResult,
                            "bDestroy": true,
                            "searchable": true,
                            "sort": true,
                            columns: [
                                            { 'data': 'LoginID',
                                                "sClass": "hide_column"
                                            }
                                               ,
                                            { 'data': 'LoginName'
                                            }
                                            ,
                                             { 'data': 'RoleID',
                                                 "sClass": "hide_column"
                                             }
                                            ,
                                             { 'data': 'RoleName'
                                             }
                                            ,

                                                { 'data': 'MobileNumber'
                                                },

                                             { 'data': 'Email'
                                             },


                                            {

                                                "mRender": function(data, type, full) {
                                                return '<input type=button class="btn btn-info btn-sm"  onclick=Edit_OnClick('+ full.LoginID +',"'+full.LoginName+'") id=Edit' + full.LoginID + ' Lname="' + full.LoginName + '" value= Edit ID1=' + full.LoginID + ' >';
                                                }
                                            }

                                            

                                         ]
                        });

                    }
                    else {
                        $('#Bindtable').hide();
                        //alert('No matching record found!');

                    }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }
            });
        }


        function Edit_OnClick(ID,name) {
          
            var LoginID = ID;
            var OrgID = '<%= Session["OrgID"] %>';
            var RoleID = $('#ddlRole').val();
            var dd;
            var resdata = [];
            var obj = {};

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/pGetWidgetsuserdetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                data: JSON.stringify({ RoleID: RoleID, LoginID: LoginID, orgID: OrgID }),
                async: false,
                success: function(data) {
                    dd = data.d;
                    $("#ddlUsers").hide();
                    $("#ddlUsers option").removeAttr('selected');
                    $('.multiselect').hide();
                    $("#lblUser").html(name);
                    $("#lblUser").show();
                    if (dd.length > 0) {

                        $("#ddlWidget option").removeAttr('selected');

                        //$("#ddlUsers").multiselect('destroy');
                        $("#ddlWidget").multiselect('destroy');
                        //$("#ddlUsers option").removeAttr('selected');
                        $.each(dd, function(index, Item) {

                            if (Item.LoginID > 0 && Item.Str1 != null && Item.Str2 != null) {
                                //    $("#ddlUsers").val(Item.LoginID);
                                document.getElementById('btnSave').value = 'Update';
                                document.getElementById('hdnloginid').value = Item.LoginID;

                                //                                for (var i = 0; i < $("#ddlUsers option").length ; i++) {
                                //                                    if ($("#ddlUsers option")[i].value == Item.LoginID) {
                                //                                          $("#ddlUsers option")[i].selected = true;
                                //                                      break;
                                //                                  }
                                //                                  
                                //                              }

                                // $("#ddlUsers").multiselect();
                                $("#ddlUsers").prop("disabled", true);
                                var selectedWidget = [];
                                selectedWidget = Item.Str1.split(",");

                                $.each(selectedWidget, function(key, value) {
                                    //   $("#ddlWidget").multiselect('destroy');

                                    for (var i = 0; i < $("#ddlWidget option").length; i++) {
                                        if ($("#ddlWidget option")[i].value == value) {
                                            $("#ddlWidget option")[i].selected = true;
                                            break;
                                        }
                                    }


                                });
                                $("#ddlWidget").multiselect();

                                var selectedWidgetgroupingdetails = [];
                                selectedWidgetgroupingdetails = Item.Str2.split(",");
                            }
                            else {
                                $('#ddlRole').change();
                                alert('No widgets are mapped');
                                return false;
                            }


                        });

                    }



                },
                error: function(result) {
                    alert("Error");
                }

            });

            
        }



        function loadwidgets() {

            var dd;
            var resdata = [];
            var obj = {};
            var RoleID = $('#ddlRole').val();
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/pGetWidgetNames",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                data: JSON.stringify({ RoleID: RoleID }),
                async: false,
                success: function(data) {
                dd = data.d;
                    
                    if (dd.length > 0) {
                        //                    $('#ddlUsers').append($('<option></option>').val(0).html('-- Select --'));
                        //                    $.each(dd, function(index, Item) {
                        //                    $('#ddlUsers').append('<option value="' + Item.LoginID + '">' + Item.LoginName + '</option>');
                        //                    });

                        $.each(dd, function(index, Item) {
                            var obj = new Object();
                            var label = Item.WName;
                            var value = Item.WID;
                            obj = { label: label, value: value };
                            resdata.push(obj);
                        });
                        $('#ddlWidget').multiselect('dataprovider', resdata);
                        //                    $('#ddlUsers').multiselect('refresh');
                        //                        $(ctrl).multiselect('dataprovider', arr);

                    }
                    else {
                        $('#ddlWidget').multiselect('dataprovider', resdata); 
                      }


                },
                error: function(result) {
                    alert("Error");
                }

            });

        }

        function loadusers() {
            var OrgID = '<%= Session["OrgID"] %>';
            var RoleID = $('#ddlRole').val();
            var dd;
            var resdata = [];
            var obj = {};
            var flag = 0;
            obj.status = 'principle'
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/pGetLoginNamesbyRole",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                data: JSON.stringify({ RoleID: RoleID, orgID: OrgID }),
                async: false,
                success: function(data) {
                    dd = data.d;
                    if (dd.length > 0) {
                        //                    $('#ddlUsers').append($('<option></option>').val(0).html('-- Select --'));
                        //                    $.each(dd, function(index, Item) {
                        //                    $('#ddlUsers').append('<option value="' + Item.LoginID + '">' + Item.LoginName + '</option>');
                        //                    });
                        $('#ddlUsers').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd, function(index, Item) {
                            var obj = new Object();
                            var label = Item.LoginName;
                            var value = Item.LoginID;
                            obj = { label: label, value: value };
                            resdata.push(obj);
                        });
                        $('#ddlUsers').multiselect('dataprovider', resdata);

                    }
                    else {
                        for (var i = 0; i < $("#ddlUsers option").length; i++) {
                            if ($("#ddlUsers option")[i].value == 0) {
                                flag = 1;
                            }
                        }
                        if (flag == 0) {
                            $('#ddlUsers').append($('<option></option>').val(0).html('-- Select --'));
                        }
                    }


                },
                error: function(result) {
                    alert("Error");
                }

            });

        }

        function BindRoles() {
            var OrgID = '<%= Session["OrgID"] %>';
            var Roles = 'QC Manager,Pathologist,Doctor';
            var dd;
            var resdata = [];
            var obj = {};
            obj.status = 'principle'
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetQCRolesbyNames",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //data: JSON.stringify(),
                data: JSON.stringify({ Roles: Roles, orgID: OrgID }),
                async: false,
                success: function(data) {
                    dd = data.d;
                    if (dd.length > 0) {
                        $('#ddlRole').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd, function(index, Item) {
                            $('#ddlRole').append('<option value="' + Item.RoleID + '">' + Item.RoleName + '</option>');
                        });
                        //DdlAddUsingList(ddlPrinciple, dd, 'PrincipleID', 'PrincipleName');
                    }
                    else { $('#ddlRole').append($('<option></option>').val(0).html('-- Select --')); }


                },
                error: function(result) {
                    alert("Error");
                }

            });
            return dd;
        }

    
    
    </script>

    <%--<script type="text/javascript">
           $(document).ready(function() {
               $(".selectpicker").selectpicker();
           });
    </script>--%>
</body>
</html>
