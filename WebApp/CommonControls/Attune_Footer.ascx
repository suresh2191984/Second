<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Attune_Footer.ascx.cs"
    Inherits="CommonControls_Attune_Footer" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="FooterRole" TagPrefix="FRole" %>
            
            </td>
        </tr>
    </table>
</div>
<div id="footer">
    <table class="w-100p">
        <tr>
            <td class="copyrights">
                <table class="w-100p">
                    <tr>
                        <%--<td class="w-50p">
                            <asp:Literal ID="Literal1" Text="Copyright&#169; 2015. All Rights Reserved." runat="server"
                                meta:resourcekey="Literal1Resource1"></asp:Literal>
                        </td>--%>
                        <td class="w-100p">
                           <FRole:FooterRole ID="ftrRole" runat="server" />
                        </td>
                    </tr>
                    </table>
            </td>
            <td class="footer_value a-right" style="display: none">
                <asp:Literal ID="LtBuildNo" runat="server" meta:resourcekey="LtBuildNoResource1"></asp:Literal>
            </td>
        </tr>
    </table>
</div>
<div class="nav_up nav_upPopup hide" id="nav_up" onclick="Hide_Notification();">
    <table class="w-100p">
        <tr>
            <td colspan="2" class="a-center">
                <%--Task Notification--%>
                <%=Resources.CommonControls_ClientDisplay.CommonControls_Attune_Footer_ascx_02%>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblPendingTask" runat="server" Text="Pending Task : " meta:resourcekey="lblPendingTaskResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblPendingTasktext" runat="server" Text="0" meta:resourcekey="lblPendingTasktextResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblProgress" runat="server" Text="Progress Task : " meta:resourcekey="lblProgressResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblProgressText" runat="server" Text="0" meta:resourcekey="lblProgressTextResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <input type="hidden" runat="server" id="hdnTaskCount" value="0" />
    <input type="hidden" runat="server" id="hdnTaskNotification" value="N" />
    <input type="hidden" runat="server" id="hdnshowintervel" value="0" />
    <input type="hidden" runat="server" id="hdnhideintervel" value="0" />
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
            url: "../WebService.asmx/GetNotificationTaskDetails",
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


        if (window.menuExists) {

            window.contentHieght = $(window).height() - ($('#header').height() + $('.tdspace').children().first().height() + $('#footer').height() + $(".newMenu").height() + 15);

            $('.contentdata').height(window.contentHieght);
            $("#v-image").addClass('pull-left');
            $("#v-image").show();
        } else {

            window.contentHieght = $(window).height() - ($('#header').height() + $('.tdspace').children().first().height() + $('#footer').height() + 15); //10 for contentdata padding top

            $('.contentdata').height(window.contentHieght);
        }
    }


    window.onload = function() {

        if ($('.datePicker').attr('disabled')) {
            if ($('.ui-datepicker-trigger').length > 0) {
                $('.ui-datepicker-trigger').remove();
            }
        }

        getLoad();

//        $('.contentdata,.boxe').enscroll({
//            verticalTrackClass: 'vertical-track',
//            verticalHandleClass: 'vertical-handle',
//            drawScrollButtons: false,
//            scrollUpButtonClass: 'scroll-up-btn',
//            scrollDownButtonClass: 'scroll-down-btn'
//        });

//        $('.fixedReport').enscroll({
//            horizontalScrolling: true,

//            verticalTrackClass: 'vertical-track',
//            verticalHandleClass: 'vertical-handle',
//            horizontalTrackClass: 'horizontal-track',
//            horizontalHandleClass: 'horizontal-handle',
//            drawScrollButtons: false,
//            scrollUpButtonClass: 'scroll-up-btn',
//            scrollDownButtonClass: 'scroll-down-btn',
//            scrollLeftButtonClass: 'scroll-left-btn',
//            scrollRightButtonClass: 'scroll-right-btn'
//        });


        $(".menuheader").click(function() {
            $(".vertical-track").each(function() {
                $(this).parent().css("display", "none");
            });

        });




        var iframe = document.getElementsByTagName("iframe")[0];
        if (iframe === undefined) { } else {
            if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {

                iframe.onreadystatechange = function() {
                    if (iframe.readyState == "complete") {

                        getLoad();

                    }
                };
            }

        }
    }
  
</script>

