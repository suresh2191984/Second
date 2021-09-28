
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Attune_OrgHeader.ascx.cs"
    Inherits="CommonControls_Attune_OrgHeader" %>
<%@ Register Src="LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="PatientHeader.ascx" TagName="ucPatientHeader" TagPrefix="Top" %>
<%@ Reference Control="../CommonControls/ErrorDisplay.ascx" %>
<link href="../Images/favicon.ico" rel="shortcut icon" />
<%--<link id="CurrentTheme" class="theme" rel="stylesheet" type="text/css" href="../Themes/IB/style.css" />--%>
<link id="iconslink" rel="stylesheet" type="text/css" href="../Themes/LisIB/start/jquery-ui-1.10.4.custom.min.css" />
<link href="../StyleSheets/font/font-awesome.min.css" rel="stylesheet" />
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../StyleSheets/changeRole.css" />
<link rel="stylesheet" type="text/css" href="../StyleSheets/SmartPatientSearch.css" />
<link rel="stylesheet" type="text/css" href="../StyleSheets/UserAlert.css" />
<link href="../StyleSheets/font/stylesheet.css" rel="stylesheet" type="text/css" />
<link href="../StyleSheets/font/pyments.css" rel="stylesheet" />
<link href="../Themes/LisIB/start/jquery-ui-timepicker-addon.css" rel="stylesheet"
    type="text/css" />
<link rel="stylesheet" type="text/css" href="../StyleSheets/TabMenu.css" />

<!--[if (gte IE 6)&(lte IE 8)]>
  <script type="text/javascript" src="../Scripts_New/selectivizr.js"></script>
  <noscript><link rel="stylesheet" id="CurrentTheme" class="theme" href="../Themes/IB/style.css" /></noscript>
<![endif]--> 
<style type="text/css">
/* Preloader */
body {
	overflow: hidden;
}
#preloader {
    position:fixed;
    top:0;
    left:0;
    right:0;
    bottom:0;
    background-color:#f5f5f5; /* change if the mask should have another color then white */
    z-index:99999; /* makes sure it stays on top */
    background-image:url(../Images/loaderNew.GIF); /* path to your loading animation */
    background-repeat:no-repeat;
    background-position:center center;
    margin:0 auto;
}
/* preloader End*/

    .newMenu
    {
        width: 100% !important;
    }
    .newMenu .arrowlistmenu
    {
        padding: 0 10px 0 0;
        float: left;
        border-right: 1px solid #CCCCCC;
    }
    .newMenu .bottom
    {
        width: auto !important;
    }
    .newMenu .categoryitems
    {
        min-width: 11%;
        background-color: #FFFFFF;
        border: 1px solid #D2D2D2;
        box-shadow:0 1px 5px #b1b1b1;-moz-box-shadow:0 1px 5px #b1b1b1;-webkit-box-shadow:0 1px 5px #b1b1b1;-khtml-box-shadow:0 1px 5px #b1b1b1;
        -o-box-shadow:0 1px 5px #b1b1b1;-ms-box-shadow:0 1px 5px #b1b1b1;
        display: block;
        position: absolute;
        margin-left: -1px;
        z-index: 999;
    }
    #Attuneheader_LeftMenu1_LeftMenuHelp1_leftDiv
    {
    display:none;	
    }
  
    #Attuneheader_LeftMenu1_LeftMenuHelp1_leftDiv .categoryitems, #Attuneheader_LeftMenu1_Daycare_leftDiv .categoryitems, #Attuneheader_LeftMenu1_Theme1_leftDiv .categoryitems
    {
        min-width: 8% !important;
    }
    .newMenu .boxmenu_2
    {
        list-style-image: none !important;
    }
    
    .imageNone
    {
        border-right: none;
        background: none;
        display: none;
    }
    .icon-user
    {
        height: 21px;
        margin-left: 5px;
        margin-top: -3px;
        width: 21px;
    }
    .icon-logout
    {
        margin-left: 0;
        margin-top: -2px;
        padding: 5px 0 0 0;
    }
    .icon-location
    {
        margin-left: 0;
        width: auto;
        padding: 4px 0px 6px 20px;
    }
    .changeRole
    {
        margin-left: 0;
        margin-top: 0;
        margin-right: 2px;
        width: auto;
        padding: 8px 24px 6px 0;
    }
    .icon-help
    {
        margin-left: 2px;
        margin-top: -2px;
    }
    .icon-role
    {
        margin-left: 0;
        margin-top: 0px;
        padding: 4px 0px 6px 24px;
        width: auto !important; /*width: 21px;height: 21px;*/
    }
    .alert
    {
        font-size: 1.3em;
        padding: 1em;
        text-align: center;
        white-space: nowrap;
        width: auto;
        word-wrap: normal;
        min-width: 250px;
        min-height: 100px;
        padding-left: 32px !important; /*background:url("../Images/info.gif" ) no-repeat scroll 0 0 rgba(0, 0, 0, 0 ) !important;*/
    }
    .confirm
    {
        font-size: 1.3em;
        padding: 1em;
        text-align: center;
        white-space: nowrap;
        width: auto;
        word-wrap: normal;
        min-width: 250px;
        min-height: 100px;
        padding-left: 32px !important; /*background:url("../Images/help.gif" ) no-repeat scroll 0 0 rgba(0, 0, 0, 0 ) !important;	*/
    }
    .headerError ul li
    {
        display: none;
    }
    .loading
    {
        height: auto !important;
    }
    .w-auto
    {
        width: auto !important;
    }
    .ps-container
    {
        overflow-x: hidden !important;
        overflow-y: hidden !important;
        position: relative;
    }
    .vertical-track
    {
        width: 10px;
        background: rgba(0, 0, 0, 0);
        margin-right: 2px;
        border-radius: 10px;
        -webkit-transition: background 250ms linear;
        transition: background 250ms linear;
    }
    .vertical-track:hover, .horizontal-track:hover, .vertical-track.dragging, .horizontal-track.dragging
    {
        background: #d9d9d9; /* Browsers without rgba support */
        background: rgba(0, 0, 0, 0.15);
    }
    .vertical-handle
    {
        width: 7px;
        right: 0;
        background: #999;
        background: rgba(0, 0, 0, 0.4);
        border-radius: 7px;
        -webkit-transition: width 250ms;
        transition: width 250ms;
    }
    .vertical-track:hover .vertical-handle, .vertical-track.dragging .vertical-handle
    {
        width: 10px;
    }
    .horizontal-track:hover .horizontal-handle, .horizontal-track.dragging .horizontal-handle
    {
        height: 10px;
    }
    .scroll-up-btn, .scroll-down-btn, .scroll-left-btn, .scroll-right-btn
    {
        background-image: url( "../Images/mCSB_buttons.png" ) !important;
        background-repeat: no-repeat !important;
        opacity: 0.8 !important;
        filter: "alpha(opacity=80)";
        -ms-filter: "alpha(opacity=80)" !important; /* old ie */
    }
    .scroll-up-btn
    {
        background-position: -96px 0px;
    }
    .scroll-down-btn
    {
        background-position: -96px -20px !important;
    }
    .scroll-right-btn
    {
        background-position: 0 -40px;
    }
    .scroll-left-btn
    {
        background-position: 0 -56px;
    }
    .horizontal-track
    {
        width: 100%;
        height: 10px;
        background: rgba(0, 0, 0, 0);
        margin-bottom: 2px;
        border-radius: 10px;
        -webkit-transition: background 250ms linear;
        transition: background 250ms linear;
    }
    .horizontal-handle
    {
        height: 7px;
        background: #999;
        background: rgba(0, 0, 0, 0.4);
        border-radius: 7px;
        -webkit-transition: width 250ms;
        transition: width 250ms;
    }
    #navigation_new>#v-image
    {
        display: none !important;
    }
    .menuNew>.newMenu 
    {
        border-top: transparent;
    }
    .menuNew>.newMenu .arrowlistmenu {
        padding: 0 2px !important;
        border-right: transparent;
    }
    .menuNew>.newMenu .dropmenutxt {
        display: inline-block;
        padding-right: 10px;
    }
    
    .menuNew>.newMenu .arrowlistmenu .menuheader:after {
        margin: 7px 5px 0 0;
    }
    .newMenu .menuheader[headerindex="0h"] .dropmenutxt,.newMenu .menuheader[headerindex="1h"] .dropmenutxt,.newMenu .menuheader[headerindex="2h"] .dropmenutxt,.newMenu .menuheader[headerindex="3h"] .dropmenutxt,.newMenu .menuheader[headerindex="4h"] .dropmenutxt
    {
        background: none !important;
        display: inline-block;
        font: normal normal normal 14px/1 FontAwesome;
        font-size: inherit;
        text-rendering: auto;
        -webkit-font-smoothing: antialiased;
        position: relative;
        padding-top: 8px!important;
    }
    .newMenu .menuheader[headerindex="0h"] .dropmenutxt:before {
        content: "\f0e4";
        font-size: 18px;
        top: 4px;
        position: absolute;
        left: 0;
    }
    .newMenu .menuheader[headerindex="1h"] .dropmenutxt:before{
        content: "\f2be";
        font-size: 18px;
        top: 4px;
        position: absolute;
        left: 0;
    }
    .newMenu .menuheader[headerindex="2h"] .dropmenutxt:before
    {
        font-size: 18px;
        top: 4px;
        position: absolute;
        left: 0;
        content: "\f1c0";
    }
    .newMenu .menuheader[headerindex="3h"] .dropmenutxt:before
    {
        content: "\f017";
        font-size: 18px;
        top: 4px;
        position: absolute;
        left: 0;
    }
    .divLogoCell
    {
        min-width: 40px;
        max-width: 150px;
    }
    .divMainCell
    {
        min-width: 100px;
        max-width: 300px;
    }
    .dropmenutxt span.commonFontSt
    {
        font-family: OpenSansRegular,calibri !important;
        font-size: 12px;
    }
    
</style>
<script src='<%= "../Scripts/resource/ResourceJson_"+ LanguageCode +".js"%>'    type="text/javascript"></script>

<script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript" language="javascript"></script>

<script src="../Scripts/jquery-ui-1.10.4.custom.min.js" type="text/javascript" language="javascript"></script>

<script type="text/javascript" src="../Scripts/css_browser_selector.js"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/KeySuppress.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/ddaccordion.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/menu.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-timepicker-addon.js"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-sliderAccess.js"></script>

<%--<script type="text/javascript" src="../Scripts_New/dateTimePicker-UI.js"></script>--%>

<script type="text/javascript" src="../Scripts/jquery.watermark.min.js"></script>
<script src="../PlatForm/Scripts/KeyCodeValidation.js" type="text/javascript"></script>
 <script src="../PlatForm/Scripts/xregexp-all.js" type="text/javascript"></script>
 <script src="../PlatForm/Scripts/unicode-base.js" type="text/javascript"></script>
<script src="../PlatForm/Scripts/unicode-categories.js" type="text/javascript"></script>
<script src="../PlatForm/Scripts/unicode-scripts.js" type="text/javascript"></script>

<%--<script src="../Scripts/datatablescroll.min.js" type="text/javascript"></script--%>

<script type="text/javascript">

//for datatable localisation --Dhanaselvam
function getLanguage() {
    return '../Scripts/DataTable/DataTable_Lang/<%=Session["LanguageCode"]%>.txt';
	
	
}
    function logout() {
    var AalrtLogout = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_02") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_02") : "Are you sure you want to Logout?";
        if (confirm(AalrtLogout)) {

            document.getElementById('<%= btnOk.ClientID %>').click();
        }
        else {
            return false;
        }
    }

    function oddEvenColor() {
        $(".ui-icon-trash,.ui-icon-pencil").attr("src", "../Images/Logo/Transparent.gif");
        $('.gridView').each(function() {
            var j = 0;
            $("tbody tr", this).each(function() {

                if (j % 2 == 0) {
                    $(this).addClass("trEven");
                } else {
                    $(this).addClass("trOdd");
                }
                j++;
            });

        });

    }
    var baseHelpURL = '<%= ResolveUrl("~/") %>';
        $(document).ready(function() {

            $('#hVideo').click(function() {
                $('#hVideo').attr('href', '../HelpFiles/Helpvideo.aspx');

            });
            $('#hText').click(function() {
                $('#hText').attr('href', '../HelpFiles/Helptext.aspx');

            });
         
         

        });
          /* Horizontal Menu*/
       $(window).load(function() {
       //alert('hai');
                $("#navigation").attr("style", "display:inline-block");
                $("#Attuneheader_menu").hide();
                $("#v-image").show();
                $("#imagetd").addClass("hide");
                $("#navigation.navigation_left").hide();
                $(".newMenu .categoryitems").css('display', 'none');
                 $("#navigation.newMenu .menuheader").removeClass('openheader');
       });
         /* Horizontal Menu End*/
    $(function() {

        //GetRoleList('');
        $('form').attr('autocomplete', 'off');
        $("body").on("click", ".btn,.btn1,a", function() {
            oddEvenColor();

        });

        $('div').click(function(e) {

            //updateScrollbarCss();
            //        


            //            setTimeout(function() {
            //            $(".ps-container").each(function() {

            // $(this).perfectScrollbar("update");
            //});
            //}, 450);
            //                          




            //            

        });
        oddEvenColor();

        var selectDate = '';
        $(".datePicker,.dateTimePicker,.monthYearPicker,.timePicker").click(function() {

            selectDate = this.id;

        });

        $(".ui-datepicker-trigger").click(function() {

            selectDate = $(this).prev().attr("id");


        });

        $(".contentdata").scroll(function() {

            if ($('#ui-datepicker-div').css("display") == "block") {

                var inp = $("#" + selectDate);
                var val = inp.offset().top + inp.outerHeight();
                if ($('.contentdata').height() < (val)) {

                    $('#ui-datepicker-div').css('top', inp.offset().top - $('#ui-datepicker-div').height());
                } else {
                    $('#ui-datepicker-div').css('top', val);
                }

            }


        });
    });


    $(function() {
        $(".column").sortable({
            connectWith: ".column",
            handle: ".portlet-header",
            cancel: ".portlet-toggle",
            placeholder: "portlet-placeholder ui-corner-all"
        });
        $(".portlet")
.addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
.find(".portlet-header")
.addClass("ui-widget-header ui-corner-all moveCursor")
.prepend(" <span class='ui-icon  ui-icon-circle-triangle-s portlet-toggle cur' style='margin-right:25px'></span><span style='margin-top:-2px;' class='ui-icon ui-icon-circle-close closePanel cur'></span>");
        $(".portlet-toggle").click(function() {
            var icon = $(this);
            //icon.toggleClass("ui-icon-minusthick ui-icon-plusthick");
            icon.closest(".portlet").find(".portlet-content").toggle();
        });
        $(".closePanel").click(function() {
            var icon = $(this);

            icon.parents('.portlet').remove();
        });

    });





</script>

<script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

<script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

<script type="text/javascript">
    // Preloader 

    //<![CDATA[
    $(window).load(function() { // makes sure the whole site is loaded
        $('#preloader').fadeOut(); // will fade out the white DIV that covers the website.
        $('body').css({ 'overflow': 'visible' });
    });
    //]]>
    
    $(document).ready(function() {
        $("#toogleimage").click(function() {
            $(".menuheader").removeClass("openheader");
        });
        $(".contentdata").scroll(function() {

            $(".wordWheel").css("display", "none");
        });

    });

    var menuExists = false;

    $(function() {


        window.currentMenuPosition = localStorage.getItem("currentMenuPosition");
        if (window.currentMenuPosition == "horPosition") {

            menuExists = true;
            $("#header").after($("div#navigation").clone().removeClass("navigation_left").addClass("newMenu").css("display", "inline-block"));

            // $("#v-image").addClass('show');

            //$(".categoryitems").removeClass("menuitem");
            $("#showmenu").removeClass("show").addClass("hide");
            $("#toogleimage").removeClass("show").addClass("hide");
            $("#imagetd").addClass('imageNone');
            $(this).attr("menudir", "h");
            document.getElementById('v-image').className = 'show';
            $("td#Attuneheader_menu > div#navigation").hide();

        } else {
            $("#header").after($("div#navigation").clone().removeClass("navigation_left").addClass("newMenu").css("display", "inline-block"));
            $("#showmenu").removeClass("hide").addClass("show");
            $("#toogleimage").removeClass("hide").addClass("show");
            $("#imagetd").addClass('imageNone');
            $(this).attr("menudir", "h");
            $("td#Attuneheader_menu > div#navigation").show("slow");
            $("#imagetd").removeClass('imageNone');
            //$(".newMenu").hide();
            //$("#v-image").hide();

            //          //  $("#v-image").addClass('hide');
            //            //document.getElementById('v-image').className = 'hide';
            //            var d = document.getElementById("v-image");
            //            d.className = d.className + " hide";

        }

        $(".loading").dialog(
        {
            modal: true,
            height: 90,
            autoOpen: false,
            width: 70,
            dialogClass: 'closeTitleBar',
            open: function(event, ui) {
                $(this).siblings('.ui-dialog-titlebar').remove();
                $(this).parent().addClass("w-auto");
                $(this).parent().addClass("fixPosition");

            }
        });
        $(".loading").dialog("open");

        // setTimeout(function() { $(".loading").dialog("close"); }, 500); 

        setTimeout(function() { $(".loading").dialog("close"); }, 700);


        //$(".categoryitems").addClass("menuitem");
        $("body").on({
            mouseenter: function() {
                $(this).addClass("ui-dark-icon");
            },
            mouseleave: function() {
                $(this).removeClass("ui-dark-icon");
            }

        }, ".with-out-bkg");
        

        $("body").on("click", ".menuToogle", function() {
            // $(".menuToogle").on("click", function() {

            var mm = $(this).attr("menudir");
            if (mm == "d") {


                if (menuExists) {
                    $("td#Attuneheader_menu > div#navigation").hide("slow");
                    $(".newMenu").show("slow");
                    $("#v-image").show();
                    // $(".categoryitems").removeClass("menuitem");
                    $("#showmenu").removeClass("show").addClass("hide");
                    $("#toogleimage").removeClass("show").addClass("hide");
                    $(".newMenu").css("display", "inline-block").fadeIn("slow");
                    //$(this).attr("menudir","v");
                    $("#imagetd").addClass('imageNone');
                    document.getElementById('showmenu').src = '../Images/hide.png';
                    $('.contentdata').height(window.contentHieght);


                } else {


                    $(".newMenu").show();
                    $("#v-image").show();
                    $("#showmenu").removeClass("show").addClass("hide");
                    $("#toogleimage").removeClass("show").addClass("hide");
                    $("#imagetd").addClass('imageNone');
                    $(this).attr("menudir", "h");
                    $("td#Attuneheader_menu > div#navigation").hide("slow");
                    window.contentNewHieght = window.contentHieght - $(".newMenu").height();
                    $('.contentdata').height(window.contentNewHieght);

                }

            } else if (mm == "h") {



                $("#v-image").show();
                $("td#Attuneheader_menu > div#navigation").hide("slow");
                $(".newMenu").show("slow");
                // $(".categoryitems").removeClass("menuitem");
                $("#showmenu").removeClass("show").addClass("hide");
                $("#toogleimage").removeClass("show").addClass("hide");
                $(".newMenu").css("display", "inline-block").fadeIn("slow");
                //$(this).attr("menudir","v");
                $("#imagetd").addClass('imageNone');
                document.getElementById('showmenu').src = '../Images/hide.png';


                if (menuExists) {

                    $('.contentdata').height(window.contentHieght);


                } else {


                    $('.contentdata').height(window.contentNewHieght);
                }



            } else if (mm == "v") {


                if (menuExists) {
                    contentHeightValue = window.contentHieght + $(".newMenu").height();

                    $('.contentdata').height(contentHeightValue);
                } else {
                    $('.contentdata').height(window.contentHieght);
                }

                $("#v-image").hide();
                $(".newMenu").hide("slow");
                $("td#Attuneheader_menu > div#navigation").show("slow");
                //$(".categoryitems").addClass("menuitem");
                $("#showmenu").removeClass("hide").addClass("show");
                $("#imagetd").removeClass('imageNone');
                $("#imagetd").addClass('displaytd');
                $("#toogleimage").addClass("show").removeClass("hide");
                //$(this).attr("menudir","h");
            }


        });



        $(".topNav .icon").tooltip({
            show: {
                effect: "slideDown",
                delay: 250
            },
            position: { my: 'center top', at: 'center bottom+10' }
        });



        $("#lnkSettings,#openSettings").click(function(e) {
            //e.preventDefault();
            $(".settings_arrow").slideToggle("slow");
            $(".popup_settings").slideToggle("slow");
	    e.stopPropagation();
        });
        $(".popup_settings").click(function(e) {
            e.stopPropagation();


        });
        $("#helper").click(function(e) {
            $(".help_arrow").slideToggle("slow");
            $(".popup_help").slideToggle("slow");
        });
        $(".popupClose").click(function(e) {
            //e.preventDefault();
            $(".settings_arrow").slideUp("slow");
            $(".popup_settings").slideUp("slow");

        });

        var setting_click = true;

        $("#lnkSettings,.settings_arrow,.popup_settings").on("click", function() {
            // alert('1111',true);
            setting_click = false;
        });
        $("body").on("click", function() {
            // alert('222',true);



            if (setting_click && $(".popup_settings").css("display") != "none") {
                //alert('1111'+$(".popup_settings").css("display"),true)
                $(".settings_arrow").slideUp("slow");
                $(".popup_settings").slideUp("slow");
            }
            setting_click = true;
        });


        var helper_click = true;
        $("#helper,.help_arrow,.popup_help").on("click", function() {

            helper_click = false;
        });
        $("body").on("click", function() {

            if (helper_click && $(".popup_help").css("display") != "none") {

                $(".help_arrow").slideUp("slow");
                $(".popup_help").slideUp("slow");
            }
            helper_click = true;
        });


        $("body").on({
            mouseenter: function() {

                $(this).find(".categoryitems").fadeIn("fast");

            },
            mouseleave: function() {

                $(this).find(".categoryitems").fadeOut("fast");
            }

        }, ".newMenu .arrowlistmenu");


        $(".navigation_left").on("click", function() {
            window.currentMenuPosition = "";

            localStorage.setItem("currentMenuPosition", window.currentMenuPosition);
        });

        var clicked = true;


        $("body").on("click", function() {
            $(".newMenu").on("click", function() {
                clicked = false;
            });

            if ($(".newMenu").css("display") === undefined) {


            }

            else {
                if (clicked && $(".newMenu").css("display") != "none") {

                    $(".categoryitems").hide("slow");
                } else if (!clicked) {
                    window.currentMenuPosition = "horPosition";

                    localStorage.setItem("currentMenuPosition", window.currentMenuPosition);
                }

            }

            clicked = true;
        });

    });

  

</script>

<script type="text/javascript">
    var sessionTime = <%= Session.Timeout %>;
    var timeLeft=sessionTime;
    var denom="M";
    var t;
   //alert(document.getElementById('lblLocationName').innerHTML);
    function resetSession()
    {
        timeLeft=<%= Session.Timeout %>;
        displaySessionTimeLeft();
    }
    
    function displaySessionTimeLeft() 
    {
      //alert("test");
        if(denom=="M")
        {
            document.getElementById('lblOrgHeader_DispText').innerHTML = "Your session will expire in";
            document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
            document.getElementById('lblOrgHeader_denom').innerHTML = " minutes";
            timeLeft=timeLeft-1;
            if(timeLeft==0)
            {
                denom="S";
                timeLeft=59;
                t=setTimeout("displaySessionTimeLeft()",1000);
            }   
            else
            {
                t=setTimeout("displaySessionTimeLeft()",60000);
            }
            
        }
        else
        {
            document.getElementById('lblOrgHeader_DispText').innerHTML = "Your session will expire in";
            document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
            document.getElementById('lblOrgHeader_denom').innerHTML = " seconds";
            timeLeft=timeLeft-1;
            if(timeLeft>=0)
            {
                t=setTimeout("displaySessionTimeLeft()",1000);
            }
            else
            {
                document.getElementById('lblOrgHeader_DispText').innerHTML = "";
                document.getElementById('lblOrgHeader_SessionTime').innerHTML = "Your Session Has EXPIRED";
                document.getElementById('lblOrgHeader_denom').innerHTML = "";
                document.getElementById('divEXPIRED').style.display = "block";
                document.getElementById('divLogout').style.display = "none";
                document.getElementById('<%= btnCancel.ClientID %>').style.display = "none";

                document.getElementById('<%= lnkLogOut.ClientID %>').click();
                clearTimeout(t);
            }
        }
    }
   
    var UApopupStatus = 0; // set value

        $(document).ready(function() {
            if ($("[id$='hdnTestURLFlag']").val() == 'ShowAlert') {
                UAloading(); // loading
                setTimeout(function() { // then show popup, deley in .5 second
                    UAloadPopup(); // function show popup
                }, 500); // .5 second
                return false;
                // Handler for .ready() called.
            }
        });

        function UAloading() {
            $("div.loader").show();
        }
        function UAcloseloading() {
            $("div.loader").fadeOut('normal');
        }

        function UAloadPopup() {
            if (UApopupStatus == 0) { // if value is 0, show popup
                UAcloseloading(); // fadeout loading
                $("#divUserAlert").fadeIn(0500); // fadein popup div
                $("#UAbackgroundPopup").css("opacity", "0.7"); // css opacity, supports IE7, IE8
                $("#UAbackgroundPopup").fadeIn(0001);
                UApopupStatus = 1; // and set value to 1
            }
        }

        function UAdisablePopup() {
            if (UApopupStatus == 1) { // if value is 1, close popup
                $("#divUserAlert").fadeOut("normal");
                $("#UAbackgroundPopup").fadeOut("normal");
                UApopupStatus = 0;  // and set value to 0
            }
        }


        function UAOver() {
            $('span.UAecs_tooltip').show();
        }
        function UAOut() {
            $('span.UAecs_tooltip').hide();
        }


        function blinking(elm) {
            timer = setInterval(blink, 10000);
            blink();

            function blink() {
                elm.fadeOut(5000, function() {
                    elm.fadeIn(5000);
                });
            }
        }

</script>
<!-- Preloader -->
<div id="preloader"></div>
<div id="header">
    <!-- Top panel Start -->
    <Top:ucPatientHeader ID="ucPatientHeader" Visible="False" runat="server" />
    <!-- Top panel End -->
    <div class="logoleft zidx2">
        <%--<div class="logowrapper">
            <img alt="logo" src="<%=LogoPath%>" class="logostyle" />
        </div>--%>
    </div>
    <div class="middleheader">
        <div>
            <div class="title w-100p displaytb">
                    <div class="main_title a-left divMainCell displaytd v-middle">
                        <div class="displaytb">
                            <div class="displaytd divLogoCell">
                            <img alt="logo" src="<%=LogoPath%>" class="logostyle" style="max-width:150px;"/>
                            </div>
                            <div class="displaytd v-middle">
                            <asp:Label ID="lblOrgName" CssClass="font13-imp marginL10 pull-left" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                            </div>
                        </div>
                        <div id="divBanner" runat="server">
                            <marquee scrolldelay="250" scrollamount="5" direction="left">
                                <asp:Label ID="lblBannerText" CssClass="bannerText" runat="server"></asp:Label>
                            </marquee>
                        </div>
                    </div>
                    <div class="main_Location a-left displaytd v-middle">
                        <div class="logoText">
                        </div>
                        <div class="w-45p inline-block">
                        <div class="topLeftNav pull-none">
                            <ul>
                                <li class="w-600">
                                    <div class="">
                                        <table class="w-100p h-40">
                                            <tr>
                                                <td id="menu_new" runat="server" class="displaytd v-middle menuNew">
                                                    <div id="navigation_new" class="newMenu">
                                                      <div class="pull-left hide-imp" id="v-image">
                                                            <img src="../Images/h-menu.png" id="toogleV-image" class="menuToogle pointer" menudir="v" />
                                                        </div>
                                                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div id="menu" runat="server"></div>
                        </div>
                        <div class="topNav">
                            <ul>
                                <%--<li class="hide-imp"><span id="roleId" class="white-color icon pointer icon-role"></span></li><span id="locationId" class="white-color icon pointer icon-location"></span>--%>
                                <li  class="hide-imp">
                                    <div class="location_arrow hide">
                                    </div>
                                    <div class="popup_location hide">
                                        <asp:Label ID="lblLocationName" runat="server" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                        <asp:Label ID="lblUserName" runat="server" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                        <asp:Label ID="lblRoleName" runat="server" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                    </div>
                                    <asp:Literal ID="link" runat="server" meta:resourcekey="linkResource1"></asp:Literal>
                                    <input type="hidden" id="hdnTheme" runat="server" />
                                    <asp:Label ID="lblOrgHeader_DispText" runat="server" CssClass="displaytext" meta:resourcekey="lblOrgHeader_DispTextResource1" />
                                    <%--Your session will expire in--%>
                                    <asp:Label ID="lblOrgHeader_SessionTime" runat="server" CssClass="displaytext bold"
                                        meta:resourcekey="lblOrgHeader_SessionTimeResource1" />
                                    <asp:Label ID="lblOrgHeader_denom" runat="server" CssClass="displaytext" meta:resourcekey="lblOrgHeader_denomResource1" />
                                    <a id="aPatientSearch" href="#" class="pull-left paddingR10 cursor" runat="server"
                                        onclick="SmartPatientSearch(this);"><%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_19 %></a>
                                    <%--OnClick="RoleChange_Click"--%>
                                    <%-- <asp:LinkButton ID="lnkSettings" Text="Settings" CssClass="changeRole" Style="color: Red; text-decoration: underline;padding-right:10px;" 
                                       Width="80px" runat="server" meta:resourcekey="lnkRoleChangeResource1" TabIndex="-1" />--%>
                                </li>
                                <%--<li><i id="userId" class="icon cur  icon-user"></i>
                                    <div class="user_arrow   hide">
                                    </div>
                                    <div class="popup_user hide">
                                    </div>
                                </li>--%>
                                <%--UI Content Hardcode for Design--%>
                               <li>
                                    <div class="w-100p">
                                        <div class="lh40 a-center"><small><i class="fa fa-map-marker marginR5 font13"></i> 
                                        <asp:Label ID="lblLocation" runat="server"></asp:Label></small></div>
                                    </div>
                                </li>
                                <%--UI Content Hardcode for Design--%>
                                <li id="openSettings" onclick="GetRoleList('');" class="pointer">
                                <div class="w-100p marginT5">
                                    <div class="inline-block pull-left lh30"><i class="fa fa-user-circle-o font30 marginR10"></i></div>
                                    <div class="inline-block pull-left a-center">
                                        <div><a id="lnkSettings" href="#" class="" onclick="GetRoleList('');"><i class=""></i></a></div>
                                        <div class="lh20"><small><asp:Label ID="lblRoleDes" runat="server"></asp:Label></small></div>
                                    </div>
                                    <div class="settings_arrow hide ">
                                    </div>
                                    <div class="popup_settings" style="display: none">
                                        <%--  <a href="#" class="ui-icon ui-icon-circle-close pull-right popupClose with-out-bkg"></a>--%>
                                        <div class="popup-profile pos-relative">
                                            <div class="bg-cover-user pos-absolute w-100p">
                                                    <img src="../Images/background_cover_0-1.png" class="opacity0-3 w-100p" height="78" >
                                                </div>
	                                        <div class="padding19 marginB10">
	                                            <div class="displaytd pos-relative">
                                                    <i class="fa fa-user-circle-o font40"></i>
                                                </div>
		                                        <div class="displaytd pos-relative v-middle w-100p">
			                                        <div class="text-shadow">
				                                        <div id="Span1" class="text-white  marginB7 font13">
					                                        <span id="userNameSettings"></span> - <span id="roleId" class="white-color font13"></span></div>
				                                        <div id="Span2" class="text-white ">
					                                        <small><i class="fa fa-map-marker marginR5 font13"></i> <span id="locationId" class="white-color font13"></span></small>
				                                        </div>
			                                        </div>
                                        			
		                                        </div>
	                                        </div>
                                        </div>
                                        <fieldset>
                                            <legend class="header-color bold">
                                                <asp:Label ID="Label3" runat="server" Text="Select Organization " meta:resourcekey="RsSetting"></asp:Label></legend>
                                            <table class="a-center w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_SelectOrganisation" runat="server" Text="Select Organization "
                                                            meta:resourcekey="Rs_SelectOrganisationResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlOrg" runat="server" onchange="GetRoleList(this);" CssClass="small font12"
                                                            meta:resourcekey="ddlOrgResource1">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="HdnOrgID" runat="server" />
                                                        <asp:HiddenField ID="HdnOrgName" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_SelectRole" runat="server" Text="Select Role " meta:resourcekey="Rs_SelectRoleResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <select id="ddlRole" onchange="GetLocationList(this);" class="small font12">
                                                        </select>
                                                        <asp:HiddenField ID="hdnRole" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr class="">
                                                    <td>
                                                        <asp:Label ID="Rs_Location" runat="server" Text="Select Location " meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <select id="ddlOrgHeaderLocation" class="small font12">
                                                        </select>
                                                        <asp:HiddenField ID="hdnLocation" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr class="hide">
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text="Select Language" meta:resourcekey="Label1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLanguage" CssClass="small" runat="server" meta:resourcekey="ddlLanguageResource1">
                                                            <%--<asp:ListItem Value="en-GB" Text="English" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Value="id-ID" Text="Bahasa Indonesia" meta:resourcekey="ListItemResource2"></asp:ListItem> --%> 
                                                            <asp:ListItem Value="en-GB" Text="English"></asp:ListItem>
                                                            <asp:ListItem Value="id-ID" Text="Bahasa"></asp:ListItem>
                                                            <asp:ListItem Value="ta-IN" Text="தமிழ்"></asp:ListItem>
                                                            <asp:ListItem Value="zh-CN" Text="Chinese"></asp:ListItem>
                                                            <asp:ListItem Value="es-ES" Text="Español"></asp:ListItem>
															</asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr class="hide">
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text="Select Department" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlDepartment" CssClass="small" runat="server" onchange="SetDepartment(this)"
                                                            meta:resourcekey="ddlDepartmentResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr class="hide">
                                                    <td>
                                                        <asp:Label ID="lblInventoryLocation" runat="server" Text="Select Inventory Location"
                                                            meta:resourcekey="lblInventoryLocationtResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlOrgHeaderInvLocation" CssClass="small" runat="server" onchange="SetDepartment(this)"
                                                            meta:resourcekey="ddlDepartmentResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr class="hide">
                                                    <td>
                                                        <asp:Label ID="lblTaskNotification" runat="server" Text=" Task Notification " meta:resourcekey="lblTaskNotificationResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkTaskNotification" runat="server" meta:resourcekey="chkTaskNotificationResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align: center">
                                                        <%--<asp:Button ID="btnRoleOK" runat="server" Text="OK" OnClientClick="return GetValuesHeader();"
                                                            CssClass="btn btn-medium" OnClick="btnRoleOK_Click" meta:resourcekey="btnRoleOKResource1" />--%>
                                                            <asp:LinkButton ID="btnRoleOK" runat="server" Text="OK" OnClientClick="return GetValuesHeader();"
                                                            CssClass="btn btn-medium" OnClick="btnRoleOK_Click" meta:resourcekey="btnRoleOKResource1" />
                                                        &nbsp;&nbsp;
                                                        <asp:Button ID="btnRoleCancel" runat="server" Text="Cancel" CssClass="btn btn-medium"
                                                            OnClientClick="return CloseChangeRole();" meta:resourcekey="btnRoleCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </div>
                                </div>
                                </li>
                                <li class="hide-imp"><a id="helper" href="#"><i class="icon  icon-help"></i></a>
                                    <div class="help_arrow hide ">
                                    </div>
                                    <div class="popup_help header-color" style="display: none">
                                        <a class="pointer infoList" id="hVideo"><%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_18 %></a>
                                        <%--<a class="pointer infoList" id="hText">Help Text</a>--%>
                                    </div>
                                </li>
                                <li>
                                    <div class="w-100p marginT10">
                                        <asp:LinkButton ID="lnkLogOut" runat="server" Text="<i class='fa fa-power-off font20 text-white'></i>"
                                            OnClientClick="javascript:if(!DisabledEffect()) return false;" CssClass="logout_position"
                                            OnClick="lnkLogOut_Click" TabIndex="-1" />
                                            <%-- meta:resourcekey="lnkLogOutResource1" --%>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
            </div>
            <div class="CRloader">
            </div>
            <div id="ChangeRolebackgroundPopup">
            </div>
            <div id="divSmartPatientSearch" class="hide">
                <div class="cr_close" onclick="ssdisablePopup();" onmouseout="ssOut();" onmouseover="ssOver();">
                </div>
                <span class="ssecs_tooltip"><%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_17 %>
 <span class="ssarrow"></span></span>
                <div id="sspopup_content">
                    <asp:Panel ID="pSmartSearch" runat="server" CssClass="dataheaderInvCtrl" GroupingText="Search"
                        meta:resourcekey="pSmartSearchResource1">
                        <table class="a-center w-100p">
                            <tr>
                                <td>
                                    <input type="radio" value="PatientNo" id="rbtnPatientNo" checked="checked" name="SmartSearch"
                                        onclick="SetSearch(this);" /><%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_16 %>
                                    <input type="radio" value="PatientName" id="rbtnPatientName" name="SmartSearch" onclick="SetSearch(this);" />Patient&nbsp;Name
                                </td>
                                <td>
                                    <input type="text" id="txtSSPatientNo" />
                                    <input type="text" id="txtSSPatientName" class="hide" />
                                </td>
                                <td>
                                    <input type="button" id="btnSmartSearch" value=" Search >> " class="btn" onclick="SearchPatientDetails(this)" />
                                </td>
                            </tr>
                        </table>
                        <div id="divSSContainer">
                            <table class="w-100p border1">
                                <tr>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_14 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_13 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_12 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_11 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_10 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_09 %>
                                    </th>
                                    <th>
                                        <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_08 %>
                                    </th>
                                </tr>
                                <tbody id="tbodyPatientRow">
                                </tbody>
                            </table>
                            <h3 id="h3ErrorMsg" class="hide a-center">
                                <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_07 %></h3>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div class="ssloader">
            </div>
            <div id="divSPSbackgroundPopup">
            </div>
            <div id="divLogOut" class="hide">
                <asp:Panel ID="pnlLogout" DefaultButton="btnCancel" runat="server" CssClass="modalPopup dataheaderPopup"
                    meta:resourcekey="pnlLogoutResource1">
                    <table class="w-100p">
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="txtboxps a-center">
                                <div id="divLogout">
                                    <asp:Label ID="Rs_RUlogout" runat="server" Text="Are you sure you want to logout?"
                                        meta:resourcekey="Rs_RUlogoutResource1"></asp:Label></div>
                                <div id="divEXPIRED" class="hide">
                                    <asp:Label ID="Rs_EXPIRED" runat="server" Text="Your Session Has EXPIRED" meta:resourcekey="Rs_EXPIREDResource1"></asp:Label></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" OnClick="btnLogOut_Click"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnOkResource1" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <asp:HiddenField ID="hdnTestURLFlag" runat="server" />
            <div id="divUserAlert">
                <div class="UA_close" onclick="UAdisablePopup();" onmouseout="UAOut();" onmouseover="UAOver();">
                </div>
                <span class="UAecs_tooltip">
                    <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_05%><span
                        class="UAarrow"></span></span>
                <div id="UApopup_content">
                    <center>
                        <%--<img alt="WarningImg" style="clear:left;text-align:center;" src="../Images/Warning.png" width="50px" height="50px" />--%>
                        <span id="spanAlert" class="Alerttxt">
                            <%=Resources.CommonControls_AppMsg.CommonControls_Attune_OrgHeader_ascx_06 %></span>
                    </center>
                </div>
            </div>
            <div class="UAloader">
            </div>
            <div id="UAbackgroundPopup">
            </div>
            <%-- <script type="text/javascript" src="../Scripts_New/ChangeRole.js"></script>--%>

            <script type="text/javascript" language="javascript">


                //                function DisabledEffect() {
                //                    if (confirm('Are you sure you want to logout ?')) {
                //                        return true;
                //                    }
                //                    return;
                //                }

                function DisabledEffect() {
                    var AalrtLogout = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_20") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_20") : "Are you sure you want to Logout?";
                    var objAlert = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_21") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_21") : "Alert";
                    var objOk = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_22") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_22") : "Ok";
                    var objCancel = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_23") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_23") : "Cancel";
                    //var logout = confirm("Do you really want to Logout?");
                    var logout = ConfirmWindow(AalrtLogout, objAlert, objOk, objCancel);
                    if (logout == true) {
                        localStorage.setItem("currentMenuPosition", "");
                        javascript: __doPostBack('Attuneheader$lnkLogOut', '');
                        return true;
                    } else {
                        return false;
                    } 
                }

                if (document.getElementById('hdnTheme') != null) {
                    document.getElementById('hdnTheme').value = '';
                }

                function GetRoleList(ele) {
                    var orgID = $('#<%=ddlOrg.ClientID%> option:selected').val();
					  //var orgID = '<%=Session["OrgID"] %>';
                    try {
                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/BindRole",
                            data: "{'orgID': " + orgID + "}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function Success(data) {
                                var lstRole = data.d;
                                BindRole(lstRole, ele);
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                            var InformationMsg = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_01") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_01") : "Information";
                            ValidationWindow(xhr.status  , InformationMsg);

                               // alert(xhr.status);
                            }
                        });
                    }
                    catch (e) {
                        return false;
                    }
                }

                function BindRole(lstRole, ele) {
                    $('#ddlRole').empty();
                    var ROLEID = '<%=RoleID%>' + '~' + '<%= RoleName%>' + '~' + '<%=RoleDescription%>';
                    var isRoleExists = false;
                    var arr = [];
                    if (lstRole.length > 0) {
                        $.each(lstRole, function(index, lstRole) {
                            if (ROLEID == lstRole.RoleName)
                            { isRoleExists = true; }
                            $('#ddlRole').append('<option value="' + lstRole.RoleName + '">' + lstRole.Description + '</option>');
                        });
                    }


//                    for (var i = 0; i < lstRole.length - 1; i++) {
//                        var flg = false;
//                        var lookup = {};
//                        if (arr.length > 0) {
//                            for (var j = 0; j <= arr.length - 1; j++) {
//                                if (arr[j].OrgID != lstRole[i].OrgID) {
//                                    flg = true;
//                                }
//                            }

//                        }
//                        else
//                        { flg = true; }

//                        if (flg) {
//                            lookup['OrgID'] = lstRole[i].OrgID;
//                            lookup['OrgName'] = lstRole[i].OrgName;
//                            arr.push(lookup);
//                            flg = false;
//                        }
//                    }
//                    $('[id$=ddlOrg]').empty();
//                    $.each(arr, function(index, arr) {

//                    $('[id$=ddlOrg]').append('<option value="' + arr.OrgID + '">' + arr.OrgName + '</option>');
//                    });
                    //var orgID = '<%=Session["OrgID"] %>';
                    //$('#ddlOrg').val(orgID);
                   // var orgID = $('#<%=ddlOrg.ClientID%> option:selected').val();
                  //  $('select[name^="ddlOrg"] option[value="' + orgID + '"]').attr("selected", "selected");
                   // $('select["ddlOrg"] option[value="' + orgID + '"]').attr("selected", "selected");

                    if (isRoleExists) {
                        $('#ddlRole').val(ROLEID);
                    }
                    GetLocationList('');
                }


                function GetLocationList(ele) {
                    var orgID = $('#<%=ddlOrg.ClientID%> option:selected').val();
                    var RoleID = $('#ddlRole').val().split('~')[0];
                    if (orgID != '' && RoleID != '') {
                        try {
                            $.ajax({
                                type: "POST",
                                url: "../WebService.asmx/BindLocation",
                                data: "{ 'orgID': " + orgID + ",'RoleID': " + RoleID + "}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function Success(data) {
                                    var lstLocation = data.d;
                                    BindLocation(lstLocation, ele);
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(xhr.status);
                                }
                            });
                        }
                        catch (e) {
                            return false;
                        }
                    }
                }


                function BindLocation(lstLocation, ele) {
                    $('#ddlOrgHeaderLocation').empty();
                    var added = false;
                    var LcationID = '<%=Session["LocationID"] %>';
                    if (lstLocation.length > 0) {
                        $.each(lstLocation, function(index, lstLocation) {
                            if (lstLocation.AddressID == LcationID) {
                                added = true;
                            }
                            $('#ddlOrgHeaderLocation').append('<option value="' + lstLocation.AddressID + '">' + lstLocation.Location + '</option>');
                        });
                        var LcationID = '<%=Session["LocationID"] %>';
			if(added)
                        $('#ddlOrgHeaderLocation').val(LcationID);
                    }
                }

                function GetValuesHeader() {
                   // debugger;
                    $('#<%=hdnRole.ClientID%>').val($('#ddlRole').val());
                    $('#<%=HdnOrgID.ClientID%>').val($('[id$=ddlOrg]').val());
                    $('#<%=HdnOrgName.ClientID%>').val($('[id$=ddlOrg] option:selected').text());
                    $('#<%=hdnLocation.ClientID%>').val($('#ddlOrgHeaderLocation').val() + '~' + $('#ddlOrgHeaderLocation option:selected').text());
                    return true;
                }


                function SaveRole(ele) {
                    var idFormation = $(ele.id).selector.replace('btnRoleOK', '');
                    var org = idFormation + 'ddlOrg';
                    var Role = idFormation + 'ddlRole';
                    var Location = idFormation + 'ddlLocation';

                    var orgID = $('#' + org + ' option:selected').val();
                    var orgName = $('#' + org + ' option:selected').text();
                    var roleID = $('#' + Role + ' option:selected').val().split('~')[0];
                    var roleName = $('#' + Role + ' option:selected').text();
                    var locationID = $('#' + Location + ' option:selected').val();
                    var locationName = $('#' + Location + ' option:selected').text();

                 //   debugger;
                    if (orgID != '' && orgName != '' && roleID != '' && roleName != '' && locationID != '' && locationName != '') {
                        try {
                            $.ajax({
                                type: "POST",
                                url: "../WebService.asmx/SaveChangeRole",
                                data: "{ 'orgID': '" + orgID + "','orgName': '" + orgName + "','RoleID': '" + roleID + "','RoleName': '" + roleName + "','LocationID': '" + locationID + "','LocationName': '" + locationName + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function Success(data) {
                                    console.log(data.d);
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(xhr.status);
                                }
                            });
                        }
                        catch (e) {
                            //return false;
                        }
                    }
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
        
            </script>

            <script type="text/javascript">



                function myFunction(value) {
                    if (value == 'roleId') {
                        return document.getElementById('<%= lblRoleName.ClientID %>').innerHTML;
                    } else if (value == 'lnkSettings') {
                        return document.getElementById('<%= lblUserName.ClientID %>').innerHTML;
                    } else {
                        return document.getElementById('<%= lblLocationName.ClientID %>').innerHTML;
                    }


                }

                //    document.getElementById('roleId').setAttribute('title', myFunction('roleId'));
                //document.getElementById('userId').setAttribute('title', myFunction('userId'));      
                //        document.getElementById('locationId').setAttribute('title', myFunction('locationId'));     
                //            

                document.getElementById('roleId').innerHTML = myFunction('roleId');
                document.getElementById('lnkSettings').innerHTML = myFunction('lnkSettings');
                document.getElementById('userNameSettings').innerHTML = myFunction('lnkSettings');
                //document.getElementById('userId').innerHTML = myFunction('userId'));      
                document.getElementById('locationId').innerHTML = myFunction('locationId');


                /* 
                author: istockphp.com
                */
                var crpopupStatus = 0; // set value

                function ClickSetting(ele) {
                    $(ele).show();
                    CRloading(); // loading
                    setTimeout(function() { // then show popup, deley in .5 second
                        CRloadPopup(); // function show popup
                    }, 500); // .5 second
                    return false;
                }

                function CRloading() {
                    $("div.loader").show();
                }
                function CRcloseloading() {
                    $("div.loader").fadeOut('normal');
                }

                function CRloadPopup() {
                    if (crpopupStatus == 0) { // if value is 0, show popup
                        CRcloseloading(); // fadeout loading
                        $("#ChangeRolePopup").fadeIn(0500); // fadein popup div
                        $("#ChangeRolebackgroundPopup").css("opacity", "0.7"); // css opacity, supports IE7, IE8
                        $("#ChangeRolebackgroundPopup").fadeIn(0001);
                        crpopupStatus = 1; // and set value to 1
                    }
                }

                function CRdisablePopup() {
                    if (crpopupStatus == 1) { // if value is 1, close popup
                        $("#ChangeRolePopup").fadeOut("normal");
                        $("#ChangeRolebackgroundPopup").fadeOut("normal");
                        crpopupStatus = 0;  // and set value to 0
                        $("[id$='lnkSettings']").show();
                    }
                }


                function CSOver() {
                    $('span.CRecs_tooltip').show();
                }
                function CSOut() {
                    $('span.CRecs_tooltip').hide();
                }

                function SetDepartment(ele) {
                    var DepID = $(ele).val();
                    if (DepID != '') {
                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/SetDepartment",
                            data: "{ 'DepID': '" + DepID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            success: function(data) {

                            },
                            failure: function(msg) {
                            var ErrorMsg = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_03") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_03") : "Error";
                            var InformationMsg = SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_04") != null ? SListForAppMsg.Get("CommonControls_Attune_OrgHeader_ascx_04") : "Information";
                            // alert('error');
                            ValidationWindow(ErrorMsg  , InformationMsg);
                            }
                        });
                    }
                }

                function ToInternalFormat(pControl) {
                    return pControl.asNumber({ region: "<%=LanguageCode%>" });
                }

                function ToTargetFormat(pControl) {
                    return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
                }
            </script>

            <script type="text/javascript" src="../Scripts/SmartSearch.js"></script>

       </div>
      <%--  <uc3:Header ID="RHead" runat="server" />--%>
    </div>
    <%-- <div style="float: right;" class="Rightheader">
    </div>--%>
</div>
<table class="tableborder w-100p">
    <tr>
        <%--<td id="menu" runat="server" class="displaytd v-top">
            <div id="navigation" as class="navigation_left">
              <div class="pull-left hide-imp" id="v-image">
                    <img src="../Images/h-menu.png" id="toogleV-image" class="menuToogle pointer" menudir="v" />
                </div>
                <uc1:LeftMenu ID="LeftMenu1" runat="server" />
            </div>
        </td>--%>
        <td class="tdspace v-top w-100p" id="tdspace">
            <Top:TopHeader ID="TopHeader1" runat="server" />
