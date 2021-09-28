<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Attune_OrgHeader.ascx.cs"
    Inherits="PlatFormControls_Attune_OrgHeader" %>

<link href="../PlatForm/StyleSheets/Common.css?v=<%=VersionNo%>" runat="server" id="lnkCommon_css"
    rel="stylesheet" type="text/css" media="all" />


<link media="all" href="../PlatForm/Themes/BB/style.css?v=<%=VersionNo%>" runat="server" id="lnkStyle"
    rel="stylesheet" type="text/css" />

<link id="iconslink" rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/start/jquery-ui-1.10.4.custom.min.css?v=<%=VersionNo%>" />



<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/TabMenu.css?v=<%=VersionNo%>" />
<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/dist/font-awesome-4.5.0/css/font-awesome.css" />
<link href="../PlatForm/StyleSheets/dist/css/ionicons.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/animate.css" />

<!-- Preloader -->
<div id="preloader">
    <div id="Loadimg">
    </div>
</div>
<!-- Preloader End -->
 
<script type="text/javascript">
    var Redirect = '<%= AppointmentRedirect %>';
    function redirect() {
        if (Redirect != "" && Redirect != null) {
            window.location.href = Redirect;
        }
    }                               
</script>
<div id="header"  style="display:none;" >
    <div class="logoleft zidx2">
        <div class="logowrapper">
            <img alt="logo" src="<%=LogoPath%>" class="logostyle" />
            <h3 id="orgName" class="hosp_name logoText font14"><%=OrgDisplayName%></h3>
            <div id="divBanner" runat="server" class="small pull-right">
                <marquee scrolldelay="250" scrollamount="5" direction="left">
                    <%=BannerText %> 
                    </marquee>
            </div>
        </div>

        <div class="pull-left new-hdrBar">
            <ul>
                <li data-toggle="offcanvas" role="button">
                    <a class="font14">
                        <span class=""><i class="ionicons ion-android-menu font25 pointer  logoText"></i></span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="middleheader">
            <div>
                <table class="title w-100p">
                    <tr>
                        <td class="main_Location a-left w-100p">
                            <div class="logoText">
                            </div>
                            <div class="topNav">
                                <ul>
                                    <!-- Arun -->
                                    <li id="imgshowDemographic" runat="server" class="pointer hide-imp" onclick='patientPanel()' data-toggle="control-sidebar">
                                         <div class="quick-menu-ico">
                                            <i class="ionicons ion-person font20"></i>
                                        </div>
                                    </li>
                                    <!-- Arun End -->
                                    <%--<li id="imgshowDemographic" class="pointer hide-imp" onclick='showDemoGraphic()'><i
                                        class="fa fa-id-card-o font14 marginT5"></i></li>--%>
                                    <li id="ImgAppointment" runat="server" class='hide-imp'
                                        onclick='redirect()' title="Appointment">
                                        <div class="quick-menu-ico">
                                            <i class="ionicons ion-android-calendar font20"></i>
                                        </div>
                                    </li>
                                    <%--<li class="pointer" onclick="requestFullScreen()" title="Fullscreen">
                                        <div class="quick-menu-ico">
                                        <span><i class="ionicons ion-android-expand font20 " ></i></span>
                                        </div>
                                    </li>--%>
                                    <li class="pointer" id="ImgBtnHome" title="Home" onclick='<%=string.Format("navigateURL(\"{0}\",\"..{1}\",\"{2}\");","",LandingPage,"") %>'>
                                        <div class="quick-menu-ico">
                                        <span>
                                        <i class="ionicons ion-android-home font20 "></i></span>
                                        </div>
                                    </li>
                                    <li class="activeDB pointer rolePopupDD">
                                        <div class="quick-menu-ico">
                                        <a style="cursor: pointer;" class="" title='<%=UserName %>'>
                                            <div class="w-100p displaytb a-center">
                                                <div class="displaytd">
                                                    <img id="imguserprofile1" src="../PlatForm/Images/User26w.png" runat="server" class="icon-role-26 marginR10 pull-left">
                                                    </img></div>
                                                <div class="displaytd v-top">
                                                    <span class="logoText"><%=UserName %></span><br />
                                                    <span class="logoText marginT6 font11-imp"><%=RoleDescription%></span>
                                                </div>
                                            </div>
                                         </a>
                                        <div class="roleSettings_Arrow " style="display: none;">
                                        </div>
                                        <div class="rolePopupDD_settings" style="display: none">
                                            <div class="popup-profile pos-relative margin10">
                                                <div class="bg-cover-user pos-absolute">
                                                    <img src="../PlatForm/Images/bgCover/background_cover_0-1.png" class="opacity0-3" height="104" width="330" />
                                                </div>
                                                <div class="padding19 marginB10">
                                                    <div class="displaytd pos-relative">
                                                        <img id="imguserprofile" runat="server" class="icon-role-new" />
                                                        
                                                    </div>
                                                    <div class="displaytd pos-relative v-middle w-100p">
                                                    <p class="text-shadow">
                                                        <span id="roleId" class="OT_app  marginB7 font13">
                                                            <%=UserName %> - <%=RoleDescription%></span>
                                                        <br />
                                                        <span id="locationId" class="OT_app ">
                                                            <small><span><%=LocationName %></span><span id="dvInvlocationName"></span></small>
                                                        </span>
                                                    </p>
                                                    
                                                </div>
                                                </div>
                                            </div>
                                                <div class="marginL10 marginR10 ">
                                                    <table class="c-black w-100p lh25">
                                                        <tr>
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_SelectOrganisationResource1%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <select id="ddlOrg" class="small" onchange="LoadRole(null)">
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_SelectRoleResource1%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <select id="ddlRole" onchange="LoadLoc(null);" class="small">
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_LocationResource1%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <select id="ddlOrgHeaderLocation" class="small" onchange="LoadInvLoc(null)">
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr id="trLanguage" runat="server" class="hide">
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_Language%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:DropDownList ID="ddlLanguage" CssClass="small" runat="server" meta:resourcekey="ddlLanguageResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr class="hide" id="trDepartment" runat="server">
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_Department%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <%-- <asp:DropDownList ID="ddlDepartment" CssClass="small" runat="server" onchange="SetDepartment(this)"
                                                                    meta:resourcekey="ddlDepartmentResource1">
                                                                </asp:DropDownList>--%>
                                                                <select id="ddlDepartment" class="small">
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr id="trInvLocation">
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_InventoryLocation%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <select id="ddlOrgHeaderInvLocation" class="small">
                                                                </select>
                                                                <%-- <asp:DropDownList ID="ddlOrgHeaderInvLocation" CssClass="small" runat="server" onchange="SetDepartment(this)"
                                                                    meta:resourcekey="ddlDepartmentResource1">
                                                                </asp:DropDownList>--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_Theme%></span>
                                                            </td>
                                                            <td class="a-right">
                                                                <select id="ddlTheme" class="small">
                                                                </select>
                                                                <%--  <asp:DropDownList ID="ddlTheme" DataTextField="ThemeName" DataValueField="ThemeID"
                                                                    CssClass="small" runat="server" onchange="SetDepartment(this)">
                                                                </asp:DropDownList>--%>
                                                            </td>
                                                        </tr>
                                                        <tr class="Show">
                                                            <td>
                                                                <span>
                                                                    <%=Resources.PlatFormControls_ClientDisplay.Rs_TaskNotification %></span>
                                                            </td>
                                                            <td >
                                                                <input type="checkbox" id="chkTaskNotification" class="marginL20" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" style="text-align: center" class="hide">
                                                                <%--  <asp:Button ID="btnRoleOK" runat="server" Text="OK" OnClientClick="GetValuesHeader();"
                                                                    CssClass="btn btn-medium" meta:resourcekey="btnRoleOKResource1" />--%>
                                                                
                                                                &nbsp;&nbsp;
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            <div class="profile-Footer">
                                                <div class="paddingL10">
                                                    <%--<input type="button" title="Cancel" value="Profile" class="hide roleLogout btn btn-default  pop_btn_foo btn-flat " />--%>
                                                    <input id="btnRoleCancel" type="button" class="cancel-btn btn-flat " onclick="return CloseChangeRole();"
                                                                    value='<%=Resources.PlatFormControls_ClientDisplay.RS_Reset %>' />
                                                </div>
                                                <div class="paddingR10">
                                                    <%--<input type="button" title="Logout" value="Sign out" class="roleLogout btn btn-primary noStyleBtn pop_btn_foo w-65" />--%>
                                                    <%--<asp:LinkButton  runat="server" Text="Sign Out"
                                                        OnClientClick="javascript:return DisabledEffect();" meta:resourcekey="lnkLogOut"
                                                        CssClass="roleLogout btn btn-primary  pop_btn_foo w-65 btn-flat" OnClick="lnkLogOut_Click" TabIndex="-1" />--%>
                                                    <input type="button" id="btnRoleOK" class="btn btn-medium btn-flat" onclick="updateSettings()"
                                                                    value='<%=Resources.PlatFormControls_ClientDisplay.Rs_OK %>' />
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </li>
                                    <li style="display: none;"><a id="helper" href="#"><i class="icon  icon-help"></i></a>
                                        <div class="help_arrow hide ">
                                        </div>
                                        <div class="popup_help header-color" style="display: none">
                                            <%--    <a style="text-decoration: none;" href="/WebApp/HelpFiles/Helpvideo.aspx">
                                                <asp:Label ID="lblHelpVideo" runat="server" Text="Help Video"></asp:Label>
                                            </a>--%>
                                        </div>
                                    </li>
                                    <li id="lnkSettings" class="pointer hide-imp"><a class="pointer "><i class="fa fa-cogs font14 logoText marginT5"></i></a>
                                        <div class="settings_arrow" style="display: none;">
                                        </div>
                                        <div class="popup_settings OT_cur" style="display: none">
                                            <fieldset>
                                                <legend class="header-color bold"><span>
                                                    <%=Resources.PlatFormControls_ClientDisplay.RsSetting%></span></legend>
                                                <div class="location_arrow hide">
                                                </div>
                                                <div class="popup_location hide">
                                                    <span>
                                                        <%=LocationName %></span> <span>
                                                            <%=UserName %></span> <span>
                                                                <%=RoleDescription %></span>
                                                </div>
                                                <input type="hidden" id="hdnTheme" />
                                                <span id="lblOrgHeader_DispText" cssclass="displaytext" ></span>
                                                <%--Your session will expire in--%>
                                                <span id="lblOrgHeader_SessionTime" cssclass="displaytext bold" ></span><span id="lblOrgHeader_denom"
                                                    cssclass="displaytext" ></span><a id="aPatientSearch" href="#" class="pull-left paddingR10 cursor"
                                                        runat="server" onclick="SmartPatientSearch(this);">Patient Search</a>
                                                
                                            </fieldset>
                                        </div>
                                    </li>
                                    <li  title="Logout" runat="server" >
                                        <div class="quick-menu-ico">
                                        <asp:LinkButton  ID="lnkLogOut" runat="server" CssClass="pointer" OnClientClick="javascript:return DisabledEffect();" OnClick="lnkLogOut_Click" ><i class="ionicons ion-power font18 marginT2 OT_app"></i></asp:LinkButton> 
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="CRloader">
                </div>
                <div id="ChangeRolebackgroundPopup">
                </div>
                <div class="ssloader">
                </div>
                <div id="divSPSbackgroundPopup">
                </div>
                <asp:HiddenField ID="hdnTestURLFlag" runat="server" />
                <asp:HiddenField ID="hdnLogout" runat="server" meta:resourcekey="hdnLogout" />
                <div id="divUserAlert" class="hide">
                    <div class="UA_close" onclick="UAdisablePopup();" onmouseout="UAOut();" onmouseover="UAOver();">
                    </div>
                    <span class="UAecs_tooltip"><span id="lblPresstoclose">Press to close</span> <span
                        class="UAarrow"></span></span>
                    <div id="UApopup_content">
                        <center>
                            <span id="spanAlert" class="Alerttxt"><span id="lblTestURL">You Are Using Test URL !!</span>
                            </span>
                        </center>
                    </div>
                </div>
                <div class="UAloader">
                </div>
                <div id="UAbackgroundPopup">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="divAttMenuheader"  style="display:none;" class="  divSideBody hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-collapse-hide">
    <aside class="main-sidebar">
        <section class="sidebar">
            <ul class="sidebar-menu">
                <asp:Repeater runat="server" ID="rptMainMenu" OnItemDataBound="rptMainMenu_ItemDataBound">
                    <ItemTemplate>
                        <li class="treeview">
                            <%--<a href="#"><i class="fa fa-dashboard"></i><span id="Div1" class='<%#Eval("CssClass")%>' runat="server">--%>
                            <a><i class='font14 <%#Eval("CssClass")%>'></i><span id="Div1" class="" runat="server">
                                <%#Eval("HeaderText")%></span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left  pull-right"></i>
                                </span></a>
                            <%-- <div class="categoryitems">
                                <div id="hideOPdiv" class="show">--%>
                            <ul class="treeview-menu scroll-picker">
                                <asp:Repeater ID="rptMenu" runat="server">
                                    <ItemTemplate>
                                        <li class="">
                                            <a href="javascript:void(0);" data-toggle="offcanvas" role="button" onclick='<%#string.Format("navigateURL(\"{0}\",\"..{1}\",\"{2}\",\"{3}\",\"{4}\");",Eval("PageID"),Eval("MenuURL"),Eval("MenuName"),Eval("TemplateUrl"),Eval("Controller"),Eval("SequenceId")) %>'>
                                                <i class="fa fa-circle-o font10"></i><%#Eval("MenuName")%>
                                            </a></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                            <ul class="bottom">
                                <li></li>
                            </ul>
                            <%--</div>
                            </div>--%>
                        </li>
                        <%--</div>--%>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </section>
    </aside>
</div>
<div>
    <%--<div class="ssm-overlay ssm-toggle-nav">
</div>--%>
    <div class="ssm-overlay hide" data-toggle="offcanvas" role="button">
    </div>

    <%--<span id="ImgBtnHome" class="HomeBtn pull-right" onclick='<%=string.Format("navigateURL(\"{0}\",\"..{1}\",\"{2}\");","",LandingPage,"") %>'></span>--%>
    <%--<span id="ImgAppointment" class='appointment w-24 marginR8 pull-right pointer <%=RoleName=="Receptionist"?"inline-block":"hide" %>'
            onclick='navigateURL("","../Appointment/Appointments.aspx","")'></span>--%>
    <span id="pntDetailsico" title="Patient Detail" class="PTdetails w-24 marginR8 pull-right pointer hide"></span>
     <%--<div class="pull-right hide">
        <div class="paddingL26 paddingT4 paddingB4  ">
            <span id="lblvalue" class="cust1backgrnd7"><%=Name%><i class="marginL15 marginR15 fa fa-angle-double-left"></i> </span>
        </div>
    </div>--%>
</div>
<asp:Literal ID="Literal2" runat="server" />
<asp:HiddenField ID="hdnSelectedID" runat="server" />
<asp:HiddenField ID="hdnThemesetValue" runat="server" Value="0" />
<input type="hidden" id="hdnRole" />
<input type="hidden" id="hdnOrgHeaderInvLocation" />
<input type="hidden" id="hdnOrgHeaderLocation" />
<input type="hidden" id="hdnDepartment" />
<input type="hidden" id="hdnDateTimeFormat" value="<%=DateTimeFormat%>" />
<%--<input type="hidden" id="hdnLoginTime" value="<%=LoggedInTime%>" />--%>
<input type="hidden" id="hdnTimeFormat" value="<%=TimeFormat%>" />
<input type="hidden" id="hdnDateFormat" value="<%=DateFormat%>" name="DateFormat" />
<input type="hidden" id="hdnMonthFormat" value="<%=MonthFormat%>" />
<input type="hidden" id="hdnYearFormat" value="<%=YearFormat%>" />
<div id="divAttMainHeader"  style="display:none;">
<table class="tableborder w-100p">
    <tr>
        <td id="Attuneheader_menu" class="displaytd v-top" style="display: none;">
            <div id="navigation" class="navigation_left">
                <div id="leftDiv">
                    <%-- <input type="hidden" id="hdnOrgID" />--%>
                </div>
                <div id="jsonDiv" class="show">
                </div>
            </div>
        </td>
        <td class="tdspace v-top w-100p">
            <table class="pageHeading bg-secondary header-color hide">
                <tr>
                    <td class="smallheaderleft padding0 margin0 hide" id="imagetd">
                        <div class="pull-left" style="width: 40px;">
                            <img alt="" onclick="Showmenu();Showhide();" src="../PlatForm/Images/hide.png" id="showmenu"
                                class="show pointer pull-left paddingR8" style="height: 15px; width: 15px;" />
                            <img alt="toogleimage" src="../PlatForm/Images/v-menu.png" id="toogleimage" class="show menuToogle pointer pull-left"
                                menudir="d" style="height: 15px; width: 15px;" />
                        </div>
                    </td>
                    <td class="w-30p"></td>
                    <td id="errorMessage" runat="server" class="headerError"></td>
                    <td class="w-6p a-right paddingR5"></td>
                </tr>
            </table>
            <div runat="server" id="patientBanner">
            </div>

            <script src="../PlatForm/Scripts/jquery-2.2.1.min.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/jquery-ui-1.10.4.custom.min.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatFormControls/Scripts/PlatFormScripts.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/Utility.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/Common.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script type="text/javascript" src="../PlatForm/Scripts/jquery-ui-timepicker-addon.js?v=<%=VersionNo%>"></script>

            <script type="text/javascript" src="../PlatForm/Scripts/css_browser_selector.js"></script>
            <script type="text/javascript" src="../PlatForm/Scripts/dateTimePicker-UI.js?v=<%=VersionNo%>"></script>
            <script  type="text/javascript" src="../PlatForm/Scripts/bid.js?v=<%=VersionNo%>"></script>

            <script src="../PlatForm/Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js?v=<%=VersionNo%>"
                type="text/javascript"></script>

            <script src="../PlatForm/Scripts/Format_Currency/jquery.formatCurrency.all.js?v=<%=VersionNo%>" type="text/javascript"></script>

       
            <script src="../PlatForm/Scripts/KeyCodeValidation.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/xregexp-all.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/unicode-base.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/unicode-categories.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/unicode-scripts.js?v=<%=VersionNo%>" type="text/javascript"></script>

            <script src="../PlatForm/Scripts/moment.min.js?v=<%=VersionNo%>" type="text/javascript"></script>

           
            <script type="text/javascript" src="../PlatForm/Scripts/app-attune.js"></script>

            <script type="text/javascript">
               
                var _dateFormat = "<%=DateFormat%>";
                var _timeFormat = "<%=TimeFormat%>";
                var _dateTimeFormat = "<%=DateTimeFormat%>";
                var YearofBirth;
            </script>

            <script type="text/javascript">

                function ToInternalFormat(pControl) {
                    //return pControl.asNumber({ region: "en-GB" })
					return pControl.asNumber({ region: "<%=LanguageCode %>" })
                }

                function ToTargetFormat(pControl) {
                    return pControl.formatCurrency({ region: "<%=LanguageCode %>" }).val();
                }
                function ToTargetFormatWOR(pControl) {
                    return pControl.formatCurrencyWOR({ region: "<%=LanguageCode %>" }).val();
                }
                $(document).ready(function () {

                    try {
                        $("#header").show();
                        $("#divAttMenuheader").show();
                        $("#divAttMainHeader").show();
                        
                        
                        var homeName = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_Home');
                        var bookingName = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_Booking');
                        var PTDemographic = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_PTDemographic');
                        $('#ImgAppointment').attr('title', bookingName);
                        $('#ImgBtnHome').attr('title', homeName);
                        $('#imgshowDemographic').attr('title', PTDemographic);
                    }
                    catch (ex) {
                    }
                    loadSideBarMenu();
                });
                function fn_pageUnLoad(){
                    $("#header").hide();
                    $("#divAttMenuheader").hide();
                    $("#divAttMainHeader").hide();
                }

                window.onbeforeunload = fn_pageUnLoad;

                function loadSideBarMenu() {

                    var hgt = $(window).height() - 71;
                    $('.main-sidebar').css('height', hgt);

                }
                function showDemoGraphic() {
                    //$('#toppanel3').removeClass('hide').addClass('show');
                    $('#panel3').toggleClass('hide');
                    $('#ShowPatientHeader1').removeClass('show').addClass('hide');
                    $('#ShowPatientHeader2').removeClass('hide').addClass('show');
                    $('#ShowPatientContent').removeClass('hide').addClass('displaytr');
                    if (typeof (NursePanelHeight) === 'function') {
                        NursePanelHeight();
                    }
                    getLoad(); loadscroll();
                }
                function patientPanel() {
                    getLoad(); loadscroll();
                    setTimeout(function () {
                        var ptDHgt = $('.contentdata').outerHeight() - $('.panel-heading-new').outerHeight() - 6;
                        var dashBHgt = $('.contentdata').outerHeight() - 4;

                        $('.control-sidebar-bg').css("overflow", "auto");
                        $('.control-sidebar-bg').css("height", $(window).height() - 50);
                        $('#patientHistoryDetails').css("height", $(window).height() - 218);
                    }, 100);
                }
                $(window).resize(function () {
                    loadSideBarMenu();
                    $('.divSideBody').removeClass('sidebar-collapse').addClass('sidebar-collapse');
                });
                $(".rolePopupDD").click(function (e) {
                    //e.preventDefault();
                    $(".roleSettings_Arrow").slideToggle("slow");
                    $(".rolePopupDD_settings").slideToggle("slow");
                });
                $(".roleLogout").click(function (e) {
                    //e.preventDefault();
                    $(".roleSettings_Arrow").slideUp("slow");
                    $(".rolePopupDD_settings").slideUp("slow");

                });
                var roleSettings_click1 = true;
                $(".rolePopupDD,.roleSettings_Arrow,.rolePopupDD_settings").on("click", function () {
                    // alert('1111',true);
                    roleSettings_click1 = false;
                });
                $("body").on("click", function () {
                    // alert('222',true);
                    if (roleSettings_click1 && $(".rolePopupDD_settings").css("display") != "none") {
                        //alert('1111'+$(".popup_settings").css("display"),true)
                        $(".roleSettings_Arrow").slideUp("slow");
                        $(".rolePopupDD_settings").slideUp("slow");
                    }
                    roleSettings_click1 = true;
                });
                $(".rolePopupDD_settings").click(function (e) {
                    e.stopPropagation();
                });
                $(".popup_settings").click(function (e) {
                    e.stopPropagation();
                });
                
                $(window).bind('beforeunload', function () {
                    $('#preloader').show();
                });
            </script>
            <script type="text/javascript">
                var ApiPath = '<%= ApiUrl %>';
                var orgID = '<%= OrgID %>';
                var ContextInfo = '<%= Cntx %>';                                
            </script>
