<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttuneHeaderV1.ascx.cs"
    Inherits="CommonControls_AttuneHeaderV1" %>
<style type ="text/css" >
.clickable{
    cursor: pointer;   
} 
 .modl
 {

    bottom:0; 
    right:0;
    position:   fixed;
    top:        0; 
    left:       0;
    height:     100%;
    width:      100%;
    z-index:1500 !important;

    background: rgba(60, 87, 104, 0.98)
                url('../QMS/Images/Full.gif') 
                50% 50% 
                no-repeat;
                 background-size: 100px 100px;
}

     .innermodl
    {
     bottom:0;
    right:0;
    position:   fixed;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    z-index:3 !important;

    background: #b3c5d0 
                url('../QMS/Images/Full.gif') 
                50% 50% 
                no-repeat;
     background-size: 30px 30px;
    }

/* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
body.loading {
    overflow: hidden;   
}

/* Anytime the body has the loading class, our
   modal element will be visible */
body.loading .modal {
    display: block;
}

</style>

<%--<link href="../QMS/dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
<link href="../QMS/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link href="../QMS/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="../QMS/dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />--%>



<!-- FontAwesome 4.3.0 -->

<!-- Ionicons 2.0.0 -->
<!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
<!-- bootstrap datepicker -->
<!-- iCheck for checkboxes and radio inputs -->
<!-- Theme style -->


<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->

<%--<link href="../QMS/dist/css/animated.css" rel="stylesheet" type="text/css" />
<link href="../QMS/dist/css/custom.css" rel="stylesheet" type="text/css" />--%>
 <div id="loader" class="modl">
<%-- <div class="limg">
     <img src="../Images/Full.gif" />
 </div>--%>
 </div>
 <div id="innerLoad" ></div>
 <header class="main-header">
<nav class="navbar navbar-static-top" role="navigation">
            <!-- Logo -->
            <%--<uc1:MainHeader ID="MainHeader" runat="server" />--%>
                    <div  class="logo fadeindown">
                      <!-- mini logo for sidebar mini 50x50 pixels -->
                      <img id="att-logo" src="../Images/Logo/attune_logo.png" alt="" height="44px" />
                      <!-- logo for regular state and mobile devices -->
                      <span class="title-logo"> <asp:Label runat="server" ID = "lblOrgName" > </asp:Label> </span>
                    </div>
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle fadeinup" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <asp:Label ID="Label1" localize="location_header" runat="server"> Loc</asp:Label>
            <asp:Label ID="lblLocationName" runat="server"></asp:Label>
            
            </a>
            <div id="divBanner" runat="server">
            <marquee scrolldelay="250" scrollamount="5" direction="left">
            <asp:Label ID="lblBannerText" CssClass="bannerText" runat="server"></asp:Label></marquee>
            </div>

          <div id="divToggle" class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Role Menu: style-->
              <li class="dropdown  messages-menu" >
                <a href="#" id="lnkI" class="" onclick="javascript:onRoleChanges(0,0,0); return false;">
                  <i class="fa fa-2x fa-user"></i>
                  <p class="dr-roles">
                      <span class="dr-role"><asp:Label runat="server" ID="lblLoginName" ></asp:Label></span>
                      <span class="dr-role-name"><asp:Label runat="server" ID="lblRoleName"></asp:Label>  </span>
                   </p>
                    <span class="caret">
                    </span>
                </a>
                <ul class="dropdown-menu" id="ddlOpen">
                  <li class="header strong" localize="select_role">Select Role</li>
                 <li>
                 <!-- Row -->
                    <div class="role-box">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                              <div class="form-group">
                                    <label localize="select_organization">Select Organization</label>
                              </div>
                         </div>
                         <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                         <%--<select class="form-control" id="Select8">
                                          <option>Anderson</option>
                                          <option>Bose</option>
                                        </select>--%>
                                        
         <asp:DropDownList ID="ddlOrg" class="dropdown-toggle form-control" runat="server" onchange="javascript:return onRoleChanges(1,1,0);"
                            AutoPostBack="true">
                        </asp:DropDownList>
                                    </div>
                            </div>         
                       </div>
                 </li>
                 <li>
                 <!-- Row -->
                         <div class="col-xs-6 col-sm-6 col-md-6">
                              <div class="form-group">
                                    <label localize="select_role">Select Role</label>
                              </div>
                         </div>
                         <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">  
                        <asp:DropDownList ID="ddlRole" class="dropdown-toggle form-control"  runat="server" 
                        onchange="javascript:return onRoleChanges(1,1,1);"
                            AutoPostBack="true">
                        </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">  
                        <asp:Button ID="Save" localize="ok" Text="OK"  OnClientClick="if (!GetValuesHeader()){return false;}else{return true;};" runat="server" OnClick="btnRoleOK_Click" >
                        </asp:Button>
                        <input type="button" localize="cancel" id="Cancel" value="Cancel" />
                        
                                    </div>
                            </div>
                            
                 </li>
                </ul>
              </li>
            </ul>
          </div>
          <div class="navbar-collapse collapse">
     
          <ul class="nav navbar-nav navbar-right"> 

<li>       
 <asp:LinkButton ID="lnkLogOut" CssClass="nav navbar-nav navbar-right" OnClientClick="javascript:if(!DisabledEffect()) return false;" runat="server" localize="logout" Text="Logout" 
                   OnClick="lnkLogOut_Click" TabIndex="-1"/>
</li>
 </ul>    
   </div>
        <input type="button" id="btnRoleDummy" runat="server" style="display: none;" />
        <input type="hidden" runat="server" id="hdnOrg" value="" />
        <input type="hidden" runat="server" id="hdnRole" value="" />
        <input type="hidden" runat="server" id="hdnDisplayName" value="" />
        <input type="hidden" runat="server" id="hdnLocationID" value="" />
        <input type="hidden" runat="server" id="hdnLocationName" value="" />
        <input type="hidden" runat="server" id="hdnRoleName" value="" />
        <input type="hidden" runat="server" id="hdnLocation" value="" />
</nav>
</header>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
 
            <ul id="sidebar-menu" class="sidebar-menu">
                <li id="QMS" class="treeview"><a href="#" class="txt-ell"> 
                <i class="fa fa-check-square-o"></i><span localize="qms">Quality Management System</span></a></li>
            </ul>
        


    </section>
    <!-- /.sidebar -->
  
</aside>

 
<script src="../QMS/Script/jquery-2.1.4.min.js" type="text/javascript"></script>

<script src="../QMS/Script/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
    
<script src="../QMS/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/MessageHandler.js" type="text/javascript"></script>
<%--
 <script src="../Scripts/jquery-ui-1.10.4.custom.min.js" type="text/javascript" language="javascript"></script>--%>


<%--<script src="../QMS/dist/js/app.min.js" type="text/javascript"></script>--%>

<%--<script src="../QMS/dist/js/demo.js" type="text/javascript"></script>--%>
<%--<script src="../QMS/dist/js/animated.js" type="text/javascript"></script>

<script src="../QMS/dist/js/animatedfn.js" type="text/javascript"></script>--%>

<script language="javascript">
    var Icons={'Dashboard':'fa fa-tachometer',
              'MasterData': 'fa fa-database',
              'CommonTasks':'fa fa-tasks',
              'ChangeLocation':'fa fa-map-marker',
              'UserManagement':'fa fa-users'
}
    $("#lnkI,#Cancel").click(function() {
    $("#ddlOpen").toggle();
});
var SLanguageCode = '<%=LanguageCode%>';
	var ILocationID = '<%=ILocationID%>';
var CurrentOrgID = '<%=OrgID%>';
var CurrentRoleID = '<%=RoleID%>';

var dataTablePath = '';
var langData;
$(document).ready(function() {
var type="";
    var lpath = '<%=Session["LogoPath"] %>';
    $("#att-logo").attr('src', lpath);
    LeftMenu();
    ChaneLocation();
    ActiveMenu();
    $('#loader').removeClass("modl");
    $(document).on('ajaxStart', function(e) {
    type = e.currentTarget.activeElement.type;
    if (type != 'text' && type != "" && type != undefined)
            $("#innerLoad").addClass('innermodl');
    }).bind('ajaxStop', function(e) {
    if (type != 'text' && type != "" && type != undefined)
            $("#innerLoad").removeClass('innermodl');
    });
    $(this).bind("contextmenu", function(e) {
        e.preventDefault();
    });
});
    function DisabledEffect() {
        var objConfirm = langData.logout_confirm;
        if (confirm(objConfirm)) {
            return true;
        }
        return;
    }
    function onRoleChanges(defaultOrgID, defaultRoleID, defaultlocationID) {
        var OrgID = '<%=OrgID%>';
        var RoleID = '<%=RoleID%>';
        var RoleName = '<%=RoleName%>';
        //var ILocationID = '<%=ILocationID%>';
        var CurrentRoleDescription = '<%= RoleDescription%>';
        if (defaultOrgID != 0) {
            OrgID = document.getElementById("<%=ddlOrg.ClientID %>").value;
        }
        if (defaultlocationID == 0) {
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetOrgDetails",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function(data) {
                        var Items = data.d;
                        var orgList = [];
                        var roleList = [];
                        var k = 0;
                        if (defaultOrgID == 0) {
                            $.each(Items, function(index, Item) {
                                var orgExist = $.grep(orgList, function(obj) {
                                    return obj.OrgID === Item.OrgID;
                                });
                                if (orgExist.length == 0) {
                                    orgList.push({
                                        OrgID: Item.OrgID,
                                        OrgDisplayName: Item.OrgDisplayName
                                    });
                                }
                            });
                            //For Sorting based on OrgDisplayName
                            orgList.sort(function(a, b) {
                                var a1 = a.OrgDisplayName, b1 = b.OrgDisplayName;
                                if (a1 == b1) return 0;
                                return a1 > b1 ? 1 : -1;
                            });
                            document.getElementById("<%=ddlOrg.ClientID %>").innerHTML = "";
                            $.each(orgList, function(index, Item) {
                                $('#<%=ddlOrg.ClientID %>').append('<option value="' + Item.OrgID + '">' + Item.OrgDisplayName + '</option>');
                            });
                        }
                        document.getElementById("<%=ddlOrg.ClientID %>").value = OrgID.toString();
                        var roleExist = $.grep(Items, function(obj) {
                            return obj.OrgID.toString() === OrgID.toString();
                        });

                        //For Sorting based on description
                        roleExist.sort(function(a, b) {
                            var a1 = a.Description, b1 = b.Description;
                            if (a1 == b1) return 0;
                            return a1 > b1 ? 1 : -1;
                        });
                        document.getElementById("<%=ddlRole.ClientID %>").innerHTML = "";
                        $.each(roleExist, function(index, Item) {
                            $('#<%=ddlRole.ClientID %>').append('<option value="' + Item.RoleID + "~" + Item.RoleName + "~" + Item.Description + '">' + Item.Description + '</option>');
                        });
                        if (defaultOrgID == 0)
                            document.getElementById("<%=ddlRole.ClientID %>").value = RoleID.toString() + "~" + RoleName.toString() + '~' + CurrentRoleDescription;
                        else
                            document.getElementById("<%=ddlRole.ClientID %>").selectedIndex = 0;
                        if (defaultRoleID != 0) {
                            RoleID = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[0];
                            RoleName = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[1];
                            CurrentRoleDescription = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[2];
                        }
                        //onChangeLocation(RoleID, RoleName);

                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }

                });
            }
            catch (e) {
            }
        }
        else {



            RoleID = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[0];
            RoleName = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[1];
            //onChangeLocation(RoleID, RoleName)
        }

        return false;
    }

    function GetValuesHeader() {
        // debugger;
        if ($('#<%=ddlOrg.ClientID%>').val() != CurrentOrgID || document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[0] != CurrentRoleID) {
            $('#<%=hdnRole.ClientID%>').val(document.getElementById("<%=ddlRole.ClientID %>").value);
            $('#<%=hdnLocation.ClientID%>').val(ILocationID + '~' + document.getElementById("<%=hdnLocationName.ClientID %>").value);
            return true;
        }
        else

        {return false;}
      
    }
    function CloseChangeRole() {
        /* $("#ChangeRolePopup").fadeOut("normal");
        $("#ChangeRolebackgroundPopup").fadeOut("normal");
        crpopupStatus = 0;
        $("[id$='lnkSettings']").show();*/

        $(".settings_arrow").slideUp("slow");
        $(".popup_settings").slideUp("slow");

        return false;
    }

    function ActiveMenu() {

        $("#sidebar-menu").find('.treeview-menu a').click(function() {

            var id = this.id;
            var list = id.split('-');
            var pageid = list[1];
            var isLink = $(this).attr('link');
            if (isLink == 'N') {
          
                var lname = $(this).text();
                ChangeLocationMenuClick(list[0], lname);

            }

        });

    }
    function LeftMenu() {
        var sidebar = $("#sidebar-menu");
        var rid = '<%=Session["RoleID"] %>';
        var oid = '<%=Session["OrgID"] %>';
        var pid = -1;

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../QMS.asmx/GetMenuItems",
            data: JSON.stringify({ roleID: rid, orgID: oid, parentID: pid }),
            dataType: "json",
            async: false,
            success: function(data) {
                //var data_test = JSON.parse(data.d);
                var pageName = document.location.pathname.match(/[^\/]+$/)[0];
                $.each(data.d, function(key, value) {
                    var Mname = value.HeaderText.replace(/\s/g, '');
                    var header = $(sidebar).find('li#' + Mname);
                    var len = header.length;
                    var Tclass = 'treeview-menu';
                    var liclass = '';
                    var HeadClass = 'treeview';
                    var icon = Icons[Mname];
                    if (icon == null || icon == '') {
                        icon = 'fa fa-files-o';
                    }


                    var Pname = value.MenuURL.match(/[^\/]+$/)[0]
                    if (Pname == pageName) {
                        Tclass = 'treeview-menu menu-open';
                        liclass = 'active';
                        HeadClass = 'treeview active';
                        $(header).addClass('active');
                    }
                    if (value.ParentID != 5 && value.ParentID != 10) {

                        if (len > 0) {

                            var submenu = $(header).find('.treeview-menu');
                            $(submenu).append('<li class="' + liclass + '"><a href="..' + value.MenuURL + '" class="clickable txt-ell" id="Page-' + value.PageID + '"  URL="' + value.MenuURL + '" link="Y"><i class="fa fa-circle-o">\
                            </i>' + value.MenuName + '</a></li>');
                        }
                        else {
                            var menu = '<li id="' + value.HeaderText.replace(/\s/g, '') + '" class="' + HeadClass + '"><a href="#">\
                            <i class="' + icon + '">\
                            </i><span title="' + value.HeaderText + '">' + value.HeaderText + '</span>\
                            <i class="fa fa-angle-left pull-right"></i>\
                            </a><ul class="' + Tclass + '">\
                            <li class="' + liclass + '"><a href="..' + value.MenuURL + '" class="clickable txt-ell" id="Page-' + value.PageID + '" URL="' + value.MenuURL + '" link="Y"><i class="fa fa-circle-o">\
                            </i>' + value.MenuName + '</a></li></ul></li>';

                            $(sidebar).append(menu);
                        }
                    }
                    else {

                        var menu = '<li id="' + value.HeaderText.replace(/\s/g, '') + '" class="' + HeadClass + '"><a href="..'+value.MenuURL+'" id="Page-' + value.PageID + '" URL="' + value.MenuURL + '" link="Y">\
                            <i class="' + icon + '"></i><span title="' + value.HeaderText + '">' + value.HeaderText + '</span></li>';
                        $(sidebar).append(menu);
                    }

                });
                //  ActiveMenu();
                //                var values = getUrlVars();
                //                menuClass(values);

            },

            error: function(result) {
                alert("Error");
            }
        });
    }
    function ChaneLocation() {
        var sidebar = $("#sidebar-menu");
        var rid = '<%=Session["RoleID"] %>';
        var oid = '<%=Session["OrgID"] %>';
        var Locid  = '<%=Session["LocationID"] %>';
        var lid = '<%=Session["LID"] %>';
    

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetChangeLocationMenu",
            data: JSON.stringify({ LocationID: Locid, OrgID: oid, LoginID: lid, RoleID: rid  }),
            dataType: "json",
            async: false,
            success: function(data) {
                //var data_test = JSON.parse(data.d);
                $.each(data.d, function(key, value) {
                var header = $(sidebar).find('li#ChangeLocation');
                var icon = Icons["ChangeLocation"];
                if (icon == null || icon == '') {
                    icon = 'fa fa-files-o';
                }
                    var len = header.length;
                    if (len > 0) {
                        var submenu = $(header).find('.treeview-menu');
                        $(submenu).append('<li><a class="clickable txt-ell" id="' + value.AddressID + '" link="N"><i class="fa fa-circle-o">\
                            </i>' + value.Location + '</a></li>');
                    }
                    else {
                        var menu = '<li id="ChangeLocation" class="treeview"><a href="#">\
                            <i class="'+icon+'">\
                            </i><span localize="menu_location">Change Location </span>\
                            <i class="fa fa-angle-left pull-right"></i>\
                            </a><ul class="treeview-menu">\
                            <li><a class="clickable txt-ell" id="' + value.AddressID + '" link="N" ><i class="fa fa-circle-o">\
                            </i>' + value.Location + '</a></li></ul></li>';

                        $(sidebar).append(menu);
                    }


                });
               // ActiveMenu();
                //                var values = getUrlVars();
                //                menuClass(values);

            },

            error: function(result) {
                alert("Error");
            }
        });
    }

    function ChangeLocationMenuClick(Locid, lname) {
        var sidebar = $("#sidebar-menu");
        var rid = '<%=Session["RoleID"] %>';
        var oid = '<%=Session["OrgID"] %>';
        //var Locid = '<%=Session["LocationID"] %>';
        var lid = '<%=Session["LID"] %>';


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/ChangeLocationMenuClick",
            data: JSON.stringify({ LoginID: lid, OrgAddressID: Locid, OrgID: oid, RoleID: rid, LocationName: lname }),
            dataType: "json",
            async: false,
            success: function(data) {
                var arr = data.d;
                if (arr.length > 0) {
                    document.location = '..' + arr[1];
                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
</script>

