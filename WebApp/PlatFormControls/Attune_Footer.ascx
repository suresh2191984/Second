<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Attune_Footer.ascx.cs"
    Inherits="PlatFormControls_Attune_Footer" %>
</td> </tr> </table>
</div>
<%@ Register Src="FeedbackControl.ascx" TagName="Feedback" TagPrefix="FB" %>
<script type="text/javascript" language="javascript">
    function Count(text, long) {
        var maxlength = new Number(long); // Change number to your max length.
        if (text.value.length > maxlength) {
            text.value = text.value.substring(0, maxlength);
            var userMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_05');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            userMsg = userMsg.replace('{0}', long);
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Only "' + long + '" characters allowed.', 'Error');
            }
        }
    }

    function ShowDivsFeedBack() {
        document.getElementById('<%= divFeedBack1.ClientID %>').style.display = "block";
        // document.getElementById('Attunefooter_fade').style.display = "block";
        $("#divFeedBack1").show("slow");
        $("#divFeedBack2").show("slow");
        $("#divFeedBack3").show("slow");
        //$('[id$="divFeedBack1"]').css({ "position": "fixed", "top": "10px", "right": "10px" });
        $('[id$="divFeedBack1"]').css({ "position": "absolute", "bottom": "20px", "right": "10px" });
        //$('[id$="divFeedBack1"]').draggable();
    }
    function HideDivsFeedBack() {
        $("#divFeedBack2").hide("slow");
        $("#divFeedBack3").hide("slow");
        $("#divFeedBack1").hide("slow");
        document.getElementById('<%= divFeedBack1.ClientID %>').style.display = "none";
        //document.getElementById('Attunefooter_fade').style.display = "none";
        //$('[id$="divFeedBack1"]').css({ "position": "absolute", "top": "500px", "right": "1000px" });
    }
</script>
<div id="footer">
    <table class="w-100p">
        <tr>
            <td class="footerright">
                <%--<img src="../PlatForm/Images/footer_left.png" alt="footer" width="13" height="27" />--%>
            </td>
            <td class="footer_value">
                    <span><%=Resources.PlatFormControls_ClientDisplay.Rs_CopyRights%></span>
            </td>
            <td class="footer_value a-middle">
               
				<div runat="server" id="appexpDate" style="display: none;">

            </div>
            </td>
            
			 <td>
                <%--FeedBack starts--%>
                <table border="0" id="divFeedBack1" runat="server" style="display: none; z-index: 2000;">
                    <tr>
                        <td>
                        
                           <FB:Feedback ID="FeedbackCtrl" runat="server" />
                        </td>
                    </tr>
                </table>
                <table id="divFBFloat" class="pull-right w-100p" runat ="server" style="display:none; ">
                    <tr>
                        <td class="a-center" style="border-width: 0px; border-style: none; border-color: white;
                            cursor: pointer;">
                            <table width="100%">
                                <tr class="a-left">
                                    <td class="a-right" nowrap="nowrap" onclick="ShowDivsFeedBack();">
                                       <asp:LinkButton id="img1" runat="server" href="#" title="Enter Feedback" OnClientClick="ShowDivsFeedBack();" 
                                       Text="Feedback" ForeColor="#ffffff" CssClass="white-color bg-primary font16 paddingT2 paddingB2 paddingR10 paddingL10"
                                       meta:resourcekey="FeedbackResources1"></asp:LinkButton>
                                    </td>
                                    <td class="a-right" nowrap="nowrap" id="div1ss" style="display: none">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
               <%--<div id="fade" style="position: absolute; display: none; background-color: #000000;
                    top: 0px; left: 0px; width: 100%; height: 100%; z-index: 1000; opacity: 0.7;filter: alpha(opacity=70); -khtml-opacity: 0.7; -moz-opacity: 0.7;" runat="server">
                </div>--%>
                <%--FeedBack ends--%>
            </td>
            <td class="footer_value a-right">
                <asp:Literal ID="LtBuildNo" runat="server" 
                    meta:resourcekey="LtBuildNoResource1"></asp:Literal>
            </td>
        </tr>
    </table>
</div>
<div class="nav_up nav_upPopup hide" id="nav_up" onclick="Hide_Notification();">
    <table class="w-100p">
        <tr>
            <td colspan="2" class="a-center">
                <asp:Label ID="lblTaskNotification" runat="server" Text="Task Notification" meta:resourcekey="lblTaskNotification"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblPendingTask" runat="server" Text="Pending Task : " 
                    meta:resourcekey="lblPendingTaskResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblPendingTasktext" runat="server" Text="0" 
                    meta:resourcekey="lblPendingTasktextResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblProgress" runat="server" Text="Progress Task : " 
                    meta:resourcekey="lblProgressResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblProgressText" runat="server" Text="0" 
                    meta:resourcekey="lblProgressTextResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <input type="hidden" runat="server" id="hdnTaskCount" value="0" />
    <input type="hidden" runat="server" id="hdnTaskNotification" value="N" />
    <input type="hidden" runat="server" id="hdnshowintervel" value="0" />
    <input type="hidden" runat="server" id="hdnhideintervel" value="0" />
    <input type="hidden" runat="server" id="hdnFeedback" value="N" />
    <input type="hidden" runat="server" id="hdnIsCorpOrg" value="N" />
</div>

<script type="text/javascript" language="javascript">

    var myshow;
    var myHide;
    var ShowIntervel = 0;
    var HideIntervel = 0;
    var Notification = "";
    Notification = document.getElementById('<%=hdnTaskNotification.ClientID %>').value;
    ShowIntervel = document.getElementById('<%=hdnshowintervel.ClientID %>').value;
    HideIntervel = document.getElementById('<%=hdnhideintervel.ClientID %>').value;
    if (ShowIntervel == "0" && HideIntervel == "0") {
        Notification == "N";
    }
    if (Notification == "Y") {
        myshow = setTimeout(function() { show_Notification() }, ShowIntervel);
    }
    function show_Notification() {
        GetNotificationTaskDetails();
        clearTimeout(myshow);
        myHide = setTimeout(function() { Hide_Notification() }, HideIntervel);
        if (document.getElementById('<%=hdnTaskCount.ClientID %>').value == "1") {
            $('#nav_up').slideDown('slow');
        }

    }

    function Hide_Notification() {
        clearTimeout(myHide);
        $('#nav_up').slideUp('hide');
        myshow = setTimeout(function() { show_Notification() }, ShowIntervel);
    }

    function GetNotificationTaskDetails() {
        var RoleId = "";
        var UserId = "";
        var OrgId = "0";
        var LocationId = "";
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/GetNotificationTaskDetails",
            data: "{OrgID:'" + OrgId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {
                document.getElementById('<%=hdnTaskCount.ClientID %>').value = "0";
                if (data.d != "") {
                    document.getElementById('<%=hdnTaskCount.ClientID %>').value = "1";
                    document.getElementById('<%=lblPendingTasktext.ClientID %>').innerHTML = data.d.split('~')[0];
                    document.getElementById('<%=lblProgressText.ClientID %>').innerHTML = data.d.split('~')[1];
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                //  alert(xhr.status);
                return false;
            }
        });
        return false;
    }

    function getLoad() {


        document.getElementsByTagName("form")[0].style.display = "block";

        if ($('html').hasClass('ie7')) {


        }

        var patientheaderheight = 0;
        if (window.menuExists) {
            
            if ($('#toppanel3').length == '0') {
                patientheaderheight = 0; 
            }
            else {
               patientheaderheight = $("#toppanel3").height();
            }
            window.contentHieght = $(window).height() - ($('#header').height() + $('.tdspace').children().first().height() + $('#footer').height() + $(".newMenu").height() + patientheaderheight + 15);

            $('.contentdata').height(window.contentHieght);
            //$("#v-image").addClass('pull-left');
           // $("#v-image").show();
        } else {

        window.contentHieght = $(window).height() - ($('#header').height() + $('.tdspace').children().first().height() + $('#footer').height() + patientheaderheight + 15); //10 for contentdata padding top

            $('.contentdata').height(window.contentHieght);
        }
    }
    function loadscroll() {
        if ($('.contentdata').next().css("position") == "absolute") {
            $('.contentdata').next().remove();
//            $('.contentdata').enscroll({
//                verticalTrackClass: 'vertical-track',
//               verticalHandleClass: 'vertical-handle',
//                drawScrollButtons: false,
//                scrollUpButtonClass: 'scroll-up-btn',
//                scrollDownButtonClass: 'scroll-down-btn'
//            });
        }
//        else {
//            $('.contentdata').enscroll({
//                verticalTrackClass: 'vertical-track',
//                verticalHandleClass: 'vertical-handle',
//                drawScrollButtons: false,
//                scrollUpButtonClass: 'scroll-up-btn',
//                scrollDownButtonClass: 'scroll-down-btn'
//            });
//        }
        
        if ($("body").hasClass("rtl")) {
            $('body.rtl .enscroll-track.vertical-track').parent().css('left', '0');
        }
        
    }

    $(window).resize(function() {
        $(".vertical-track").each(function() {
            $(this).parent().css("display", "none");
        });
        getLoad();

        loadscroll();

    });
    //method for recalling enscroll
    function recallscroll() {
       getLoad();
       loadscroll();
    }

    //method for hindu org css
    function addbodyclass() {
        $('body').addClass("hinducss");
    }
    $(document).ready(function() {
        loadleftsidescroll();
        function loadleftsidescroll() {
            var LangCode = "<%=LanguageCode%>";
            if (LangCode == "ar-SA") {
                $('body').addClass('rtl');
            }
        }
        var isCorpOrg = "N";
        isCorpOrg = document.getElementById('<%=hdnIsCorpOrg.ClientID %>').value;
        if (isCorpOrg == "Y")
            addbodyclass();
    });

    window.onload = function() {

        $(".vertical-track").parent().css("display", "none");

//        if ($('.datePicker').attr('disabled')) {
//            if ($('.ui-datepicker-trigger').length > 0) {
//                $('.ui-datepicker-trigger').remove();
//            }
//        }

        getLoad();

        loadscroll();

      


        $(".menuheader").click(function() {
            $(".vertical-track").each(function() {
                $(this).parent().css("display", "none");
            });

        });




        var iframe = document.getElementsByTagName("iframe")[0];
        if (iframe === undefined) { } else {
            if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {

                iframe.onreadystatechange = function() {
                var userMsg = SListForAppDisplay.Get('PlatFormControls_Attune_Footer_ascx_01');
                    if (userMsg == null) {
                        userMsg = "complete";
                    }
                    if (iframe.readyState == userMsg) {
                        getLoad();

                    }
                };
            }

        }
    }
  
</script>

