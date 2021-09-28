
$(window).load(function() { // makes sure the whole site is loaded
    $('#preloader').fadeOut(); // will fade out the white DIV that covers the website.
    //$('body').css({ 'overflow': 'visible' });
});


function moveupdown() {
    if ($(".vertical-handle").parent().parent().css('display').toLowerCase() == 'block') {
        var e = event;
        if (e.keyCode == 33 || e.keyCode == 38) {
            $(".vertical-handle").parent().parent().prev();
        }
        else if (e.keyCode == 34 || e.keyCode == 40) {
            $(".vertical-handle").parent().parent().prev();
        }
    }
    else { return; }
}
function oddEvenColor() {
    $(".ui-icon-trash,.ui-icon-pencil").attr("src", "../PlatForm/Images/Logo/Transparent.gif");
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

$(function() {

    $('form').attr('autocomplete', 'off');
    $("body").on("click", ".btn,.btn1,a", function() {
        oddEvenColor();

    });

    $('div').click(function(e) {



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
var locationArray=window.location.href.split('/');
var LocalStorageName = locationArray[2] + "_" + locationArray[3];

$(document).ready(function() {
    $("#toogleimage").click(function() {
        $(".menuheader").removeClass("openheader");
    });

    if (window.sessionStorage[LocalStorageName + "_LoginDtls"] != undefined && window.sessionStorage[LocalStorageName + "_LoginDtls"] != "null" && $('#hdnIsAccessChanged').val() == 'N') {
        var LoginDtls = null;
        LoginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
        LoadSettings(LoginDtls);
    }
    else {
        LoginDtlstoLocal();
    }
    $('#chkTaskNotification').click(function() {
        if ($('#chkTaskNotification').attr('checked') == undefined) {
            $('#chkTaskNotification').attr('checked', 'checked');
        }
        else {
            $('#chkTaskNotification').removeAttr('checked');
        }

    });
});
function LoadSettings(LoginDtls) {
    setDefaultSettings();
}
function LoadTheme(loginDtls) {
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    if (loginDtls.lstTheme != null && loginDtls.lstTheme.length > 0) {
        for (var i = 0; i < loginDtls.lstTheme.length; i++) {
            $('select[id$=ddlTheme]').append($('<Option>').attr("themeURL", loginDtls.lstTheme[i].ThemeURL).attr('value', loginDtls.lstTheme[i].ThemeID).html(loginDtls.lstTheme[i].ThemeName));
        }
    }
    $('select[id$=ddlTheme]').val($('input[id=hdnTheme]').val());
    $('[id$=lnkStyle]').attr('href', '../PlatForm' + $('select[id$=ddlTheme] option:selected').attr("themeURL"));
}

function setDefaultSettings() {

    try {
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/GetContextInfo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: onDefaultSettingSuccess,
            error: function(xhr, ajaxOptions, thrownError) {
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                ValidationWindow(xhr.status, ErrorMsg);
            }
        });
    }
    catch (e) {
        return false;
    }

}
var LangCode = "en-GB";
function onDefaultSettingSuccess(data) {
    $('input[id=hdnOrg]').val(data.d.OrgID);
    $('input[id=hdnRole]').val(data.d.RoleID);
    $('input[id=hdnOrgHeaderInvLocation]').val(data.d.InventoryLocationID);
    $('input[id=hdnOrgHeaderLocation]').val(data.d.LocationID);
    $('input[id=hdnTheme]').val(data.d.ThemeID);
    $('input[id=hdnDepartment]').val(data.d.DepartmentCode);
    LangCode = data.d.LanguageCode;
   
    //    if ('<%=TaskNotification %>' == 'Y') {
    //        $('[id=chkTaskNotification]').attr('checked', 'checked');
    //    }
    var LoginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    LoadOrg(LoginDtls);
    LoadTheme(LoginDtls);
}
function LoadOrg(loginDtls) {
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    $('select[id$=ddlOrg]').find('option').remove();
    if (loginDtls.lstOrganization != null && loginDtls.lstOrganization.length > 0) {
        for (var i = 0; i < loginDtls.lstOrganization.length; i++) {
            $('select[id$=ddlOrg]').append($('<Option>').attr('value', loginDtls.lstOrganization[i].OrgID).html(loginDtls.lstOrganization[i].OrgDisplayName));
        }
    }
    if($('input[id=hdnOrg]').val()!=undefined){$('select[id$=ddlOrg] option[value="' + $('input[id=hdnOrg]').val() + '"]').attr('selected', 'selected');}
    LoadRole(loginDtls);
    LoadDepartment(loginDtls);
}

function LoadRole(loginDtls) {
    var OrgID = $('select[id$=ddlOrg]').val();
//    $('#trInvLocation').hide();
//    $('#dvInvlocationName').hide();
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    $('select[id$=ddlRole]').find('option').remove();

    if (loginDtls.lstRole != null && loginDtls.lstRole.length > 0) {
        for (var i = 0; i < loginDtls.lstRole.length; i++) {
            if (loginDtls.lstRole[i].OrgID == OrgID) {

                $('select[id$=ddlRole]').append($('<Option>').attr('value', loginDtls.lstRole[i].RoleID).html(loginDtls.lstRole[i].Description));

//                if ((loginDtls.lstRole[i].RoleName == "Inventory")) {
//                    $('#trInvLocation').show();
//                    $('#dvInvlocationName').show();
//                }
            }
        }
    }
    $('select[id$=ddlRole] option[value="' + $('input[id=hdnRole]').val() + '"]').attr('selected', 'selected');
    LoadLoc(loginDtls);
}
function LoadLoc(loginDtls) {
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    var OrgID = $('select[id$=ddlOrg]').val();
    var RoleID = $('select[id$=ddlRole]').val();

    $('select[id$=ddlOrgHeaderLocation]').find('option').remove();

    if (loginDtls.lstLocations != null && loginDtls.lstLocations.length > 0) {
        for (var i = 0; i < loginDtls.lstLocations.length; i++) {
            if (loginDtls.lstLocations[i].OrgID == OrgID && loginDtls.lstLocations[i].ReferTypeID == RoleID) {
                $('select[id$=ddlOrgHeaderLocation]').append($('<Option>').attr('value', loginDtls.lstLocations[i].AddressID).html(loginDtls.lstLocations[i].Location));
            }
        }
    }
    $('select[id$=ddlOrgHeaderLocation] option[value="' + $('input[id=hdnOrgHeaderLocation]').val() + '"]').attr('selected', 'selected');
    LoadInvLoc(loginDtls);
}
function LoadInvLoc(loginDtls) {
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    var AddessID = $('select[id$=ddlOrgHeaderLocation]').val();

    $('select[id$=ddlOrgHeaderInvLocation]').find('option').remove();

    if (loginDtls.lstInvLocations != null && loginDtls.lstInvLocations.length > 0) {
        for (var i = 0; i < loginDtls.lstInvLocations.length; i++) {
            if (loginDtls.lstInvLocations[i].OrgAddressID == AddessID) {
                $('select[id$=ddlOrgHeaderInvLocation]').append($('<Option>').attr('value', loginDtls.lstInvLocations[i].LocationID).html(loginDtls.lstInvLocations[i].LocationName));
            }
        }
        for (var i = 0; i < loginDtls.lstInvLocations.length; i++) {
            if (loginDtls.lstInvLocations[i].LocationInfo == 'Y' && loginDtls.lstInvLocations[i].OrgAddressID == AddessID) {
                $('select[id$=ddlOrgHeaderInvLocation]').val(loginDtls.lstInvLocations[i].LocationID);
                break;
            }
        }
    }
    $('select[id$=ddlOrgHeaderInvLocation] option[value="' + $('input[id=hdnOrgHeaderInvLocation]').val() + '"]').prop('selected', 'selected');

    $('#dvInvlocationName').text('[' + $('select[id$=ddlOrgHeaderInvLocation] option:Selected').text() + ']')
    if ($('select[id$=ddlOrgHeaderInvLocation]').val() > 0) {
        $('#trInvLocation').show();
        $('#dvInvlocationName').show();
    }
    else {
        $('#trInvLocation').hide();
        $('#dvInvlocationName').hide();
    }
}
function LoadDepartment(loginDtls) {
    
    if (loginDtls == null) {
        loginDtls = JSON.parse(window.sessionStorage[LocalStorageName + "_LoginDtls"]);
    }
    var OrgID = $('select[id$=ddlOrg]').val();

    $('select[id$=ddlDepartment]').find('option').remove();

    if (loginDtls.lstDepartment != null && loginDtls.lstDepartment.length > 0) {
        for (var i = 0; i < loginDtls.lstDepartment.length; i++) {
            if (loginDtls.lstDepartment[i].OrgID == OrgID) {
                $('select[id$=ddlDepartment]').append($('<Option>').attr('value', loginDtls.lstDepartment[i].Code).html(loginDtls.lstDepartment[i].EmpDeptName));
            }
        }
    }
    if ($('select[id$=ddlDepartment]').find('option').length == 0) {
        $('#QPR_ddlDepartment').removeClass().addClass('hide');
        $('#QPR_lblDepartment').removeClass().addClass('hide');
    }

    $('select[id=ddlDepartment] option[value="' + $('input[id=hdnDepartment]').val() + '"]').attr('selected', 'selected');
}

function LoginDtlstoLocal() {

    try {
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/GetLoginDtls",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnloginDtlsSuccess,
            error: function(xhr, ajaxOptions, thrownError) {
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                ValidationWindow(xhr.status, ErrorMsg);
            }
        });
    }
    catch (e) {
        return false;
    }
}

function OnloginDtlsSuccess(data) {
    window.sessionStorage[LocalStorageName + "_LoginDtls"] = JSON.stringify(data.d);
   // localStorage["LoggedInTime"] = ClientLoggedinTime($('#hdnLoginTime').val());
    LoadSettings(data.d);
}


function updateSettings() {

    var orgID = $('select[id=ddlOrg]').val();
    var roleID = $('select[id=ddlRole]').val();
    var invLocationID = $('select[id$=ddlOrgHeaderInvLocation]').val();
    var locationID = $('select[id=ddlOrgHeaderLocation]').val();
    var themeID = $('select[id=ddlTheme]').val();
    var orgName = $('select[id=ddlOrg] option:selected').text();
    var roleName = $('select[id=ddlRole] option:selected').text();
    var locationName = $('select[id=ddlOrgHeaderLocation] option:selected').text();
    var departmentID = $('select[id=ddlDepartment] option:selected').val();
    var LangCode = $("[id$=_ddlLanguage]").val();
    if (invLocationID == undefined || invLocationID == "") {
        invLocationID = 0;
    }
    if (departmentID == undefined || departmentID=="") {
        departmentID = 0;
    }
    if (LangCode == undefined) {
        LangCode = 'en-GB';
    }
    var departmentName = $('select[id=ddlDepartment] option:selected').text();
    if (departmentName == undefined) {
        departmentName = '';
    }
    var taskNotification = $('input[id=chkTaskNotification]').attr('checked') == 'checked' ? "Y" : "N";
    try {
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/UpdateLoginDtls",
            data: "{'roleID':" + roleID + ",'themeID':" + themeID +
                ",'orgID':" + orgID + ",'locationID':" + locationID + ",'invLocationID':" + invLocationID + ",'departmentID':'" + departmentID
                + "','OrgName':'" + orgName + "','RoleName':'" + roleName + "','LocationName':'" + locationName + "','departmentName':'" + departmentName + "',taskNotification:'" + taskNotification + "',LangCode:'" + LangCode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnUpdateLoginDtls,
            error: function(xhr, ajaxOptions, thrownError) {
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                ValidationWindow(xhr.status, ErrorMsg);
            }
        });
    }
    catch (e) {
        return false;
    }
}
function OnUpdateLoginDtls(data) {
    if (data != null && data.d != null) {
        window.sessionStorage.removeItem(LocalStorageName + "_LoginDtls");
        navigateURL("", '..' + data.d, "");
    } else {
        $('[id$=lnkLogOut]').click();
    }
}

var menuExists = false;

$(function() {


    menuExists = true;
    $("#header").after($("div#navigation").clone().removeClass("navigation_left").addClass("newMenu hide"));

    // $("#v-image").addClass('show');

    //$(".categoryitems").removeClass("menuitem");
    $(".categoryitems").hide("slow");
    $("#showmenu").removeClass("show").addClass("hide");
    $("#toogleimage").removeClass("show").addClass("hide");

    $("td#Attuneheader_menu > div#navigation").hide();


    $("body").on({
        mouseenter: function() {
            $(this).addClass("ui-dark-icon");
        },
        mouseleave: function() {
            $(this).removeClass("ui-dark-icon");
        }

    }, ".with-out-bkg");





    $(".topNav .icon").tooltip({
        show: {
            effect: "slideDown",
            delay: 250
        },
        position: { my: 'center top', at: 'center bottom+10' }
    });



    $("#lnkSettings").click(function(e) {
        //e.preventDefault();
        $(".settings_arrow").slideToggle("slow");
        $(".popup_settings").slideToggle("slow");


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

            //                //alert($(this).find(".boxe").height(), true);
            //                setTimeout(function() {
            //                    $(".ps-container").each(function() {

            //                        $(this).perfectScrollbar("update");
            //                    });
            //                }, 450);



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
        $(".categoryitems").hide("slow");
        $(".newMenu").on("click", function() {
            clicked = false;
            $(".categoryitems").hide("slow");
        });

        if ($(".newMenu").css("display") === undefined) {
            $(".categoryitems").hide("slow");

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
        $(".categoryitems").hide("slow");
    });

});
var sessionTime = '<%=Session.Timeout %>';
var timeLeft = sessionTime;
var denom = "M";
var t;
//alert(document.getElementById('lblLocationName').innerHTML);
function resetSession() {
    timeLeft = '<%= Session.Timeout %>';
    displaySessionTimeLeft();
}

function displaySessionTimeLeft() {
    //alert("test");
    if (denom == "M") {
        var userMsg = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_01');
        var userMsg1 = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_02');
        if (userMsg == null) {
            userMsg = "Your session will expire in";
        }
        if (userMsg1 == null) {
            userMsg1 = "minutes";
        }
        document.getElementById('lblOrgHeader_DispText').innerHTML = userMsg;
        document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
        document.getElementById('lblOrgHeader_denom').innerHTML = userMsg1;
        timeLeft = timeLeft - 1;
        if (timeLeft == 0) {
            denom = "S";
            timeLeft = 59;
            t = setTimeout("displaySessionTimeLeft()", 1000);
        }
        else {
            t = setTimeout("displaySessionTimeLeft()", 60000);
        }

    }
    else {
        var userMsg = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_01');
        var userMsg1 = SListForAppDisplay.Get('PlatFormControls_Attune_OrgHeader_ascx_03');
        if (userMsg == null) {
            userMsg = "Your session will expire in";
        }
        if (userMsg1 == null) {
            userMsg1 = "seconds";
        }
        document.getElementById('lblOrgHeader_DispText').innerHTML = userMsg;
        document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
        document.getElementById('lblOrgHeader_denom').innerHTML = userMsg1;
        timeLeft = timeLeft - 1;
        if (timeLeft >= 0) {
            t = setTimeout("displaySessionTimeLeft()", 1000);
        }
        else {
            var userMsg = SListForAppDisplay.Get('Admin_VisitType_aspx_1');
            if (userMsg == null) {
                userMsg = "Your Session Has EXPIRED";
            }
            document.getElementById('lblOrgHeader_DispText').innerHTML = "";
            document.getElementById('lblOrgHeader_SessionTime').innerHTML = userMsg;
            document.getElementById('lblOrgHeader_denom').innerHTML = "";
            document.getElementById('divEXPIRED').style.display = "block";
            document.getElementById('divLogout').style.display = "none";

            $('#[id$=lnkLogOut]').click();
            clearTimeout(t);
        }
    }
}

var UApopupStatus = 0; // set value
$(document).ready(
        function() {
            $("head").append("<link href='../PlatForm/Images/favicon.ico' rel='shortcut icon' />");
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
function navigateURL(PageID, URL, MenuName,templateUrl,Controller,SeqNo) {

    if (templateUrl == undefined || templateUrl == "" || templateUrl == null) {
        var LoginTime = $('#hdnLoginTime').val();

        //$.ajax({ url: URL, headers: { 'ParentID': ParentID} ,async:false}).done(function() { alert('success'); });
        var $form = $("<form/>").attr("id", "data_form")
                                .attr("action", URL)
                                .attr("method", "post");
        $("body").append($form);
        //Append the values to be send
        AddParameter($form, "PageID", PageID);
        AddParameter($form, "MenuName", MenuName);
        AddParameter($form, "LoginTime", LoginTime);
        //Send the Form
        $form[0].submit();
    }
    else {
        var LoginTime = $('#hdnLoginTime').val();

        var $form = $("<form/>").attr("id", "data_form")
                                .attr("action", "../KernelV2/")
                                .attr("method", "post");
        $("body").append($form);
        window.sessionStorage["stateName"] = URL.replace('..', '');
        $form[0].submit();
    }
}
function AddParameter(form, name, value) {
    var $input = $("<input />").attr("type", "hidden")
                                .attr("name", name)
                                .attr("value", value);
    form.append($input);
}

function DisabledEffect() {

    var strMsg = $("[id$='hdnLogout']").val();
    return confirm(strMsg);
}

if (document.getElementById('hdnTheme') != null) {
    document.getElementById('hdnTheme').value = '';
}






function CloseChangeRole() {

    $(".settings_arrow").slideUp("slow");
    $(".popup_settings").slideUp("slow");
    LoadSettings(null);
    return false;
}



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


function recallloading() {
    $(".loading").dialog("open");
    setTimeout(function() { $(".loading").dialog("close"); }, 1000);
}




var idleTime = 0;
$(document).ready(function () {
    //Increment the idle time counter every minute.
    var idleInterval = setInterval(timerIncrement, 300000); // 5 minute
    var refreshInterval = setTimeout(refreshSession, (($('#hdnSessionTimeOut').val() - 1) * 60000));
    //Zero the idle timer on mouse movement.
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });



    // When site loaded, load the Popupbox First


    $('#popupBoxClose').click(function () {
        unloadPopupBox();
    });

    $('#container').click(function () {
        unloadPopupBox();
    });

    function unloadPopupBox() {    // TO Unload the Popupbox
        //  $('#popup_box').fadeOut("slow");
        jQuery('#dvTimer').dialog("close");
    }

    function loadPopupBox() {    // To Load the Popupbox

        var counter = 60;
        var id;
        $('#popup_box').fadeIn("slow");
        //$("body").css({ // this is just for style
        //    "opacity": "0.3"
        //});

        id = setInterval(function () {
            counter--;
            if (counter < 0) {
                clearInterval(id);

                unloadPopupBox();
            } else {
                if (counter == 59) {
                    //  $('.dia-timer .ui-button-text:contains(OK)').text('sss');
                    jQuery('#dvTimer').dialog("open");
                }
                $("#countDown").html(" Your session will expire in  <span class='font40 fntThmClr bold'>" + counter.toString() + "</span> seconds. Press  <span class='fa fa-refresh'></span>  to continue...");
            }
        }, 1000);

    }

    function timerIncrement() {
        idleTime = 1;
    }

    function resetRefreshSession(data) {
        var refreshInterval = setTimeout(refreshSession, (($('#hdnSessionTimeOut').val() - 1) * 60000));
    }
    function refresh() {
        initLogOut = 0;
        try {
            $.ajax({
                type: "POST",
                url: "../PlatformWebServices/PlatFormServices.asmx/GetContextInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: resetRefreshSession,
                error: function (xhr, ajaxOptions, thrownError) {
                    var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                    if (ErrorMsg == null) {
                        ErrorMsg = "Error";
                    }
                    ValidationWindow(xhr.status, ErrorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }
    }
    var initLogOut = 0;
    function refreshSession() {

        if (idleTime == 0) {
            refresh();
        }
        else {
            //ValidationWindowResponse('Your session will expire in 1 minute. Press OK to continue...', 'Alert', refresh);
            loadPopupBox();
            initLogOut = 1;
            setTimeout(logOutSession, 60000);

        }
    }
    function logOutSession() {
        if (initLogOut == 1) {
            window.location = '../Home.aspx';
        }

    }




    jQuery('<div id="dvTimer">')
                 .html("<p id='countDown'> Your session will expire in 1 minute. Press  <span class='fa fa-refresh'></span>  to continue... </p>")
                 .dialog({
                     autoOpen: false,
                     modal: true,
                     title: "Application Time Out",
                     buttons: [{
                         icons: { primary: 'fa fa-refresh cust-ui-ok' },
                         click: function () {
                             refresh();
                             jQuery(this).dialog("close");
                         }
                     }],
                     dialogClass: 'my-dialog'

                 });


});

