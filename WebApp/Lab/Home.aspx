<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Lab_Home"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>--%>
<%-- <%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %> --%>
<%--<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>--%>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc3" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/AdvancedSearch.ascx" TagName="AdvancedSearch"
    TagPrefix="uc10" %>
<%-- <%@ Register Src="~/CommonControls/AbberantQueue.ascx" TagName="AbbrentQueue" TagPrefix="uc11" %> --%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Technician Home Page</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Tasks.js" type="text/javascript"></script>
    <script src="../Scripts/moment.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        window.history.forward(1);
    </script>


    <script type="text/javascript" language="javascript">
        function WaterMarktxt(txtbox, evt, defaultText) {
            if (txtbox.value.length == 0 && evt.type == "blur") {
                txtbox.style.color = "gray";
                txtbox.value = defaultText;
            }
            if (txtbox.value == defaultText && evt.type == "focus") {
                txtbox.style.color = "black";
                txtbox.value = "";
            }
        }
        function AnimateGridview() {

            $(document).ready(function() {



                document.getElementById("divGridView").style.display = "none";

                $("#divGridView").slideDown('slow');



            });
        }
        function LoadPost() {


        }
        
        
        
        function AjaxGetInvestigationStatus(result) {
            //debugger;
            if (result != "[]") {
                var x = event.clientX;
                var y = event.clientY;
                var data = result.d;
                $("#jsonDiv").html('');
                var text = '<table border="1"><tbody>';
                text += '<tr><td style=\"font-weight: bold;text-decoration:underline\"> <strong>InvestigationList</strong></td>';
                text += '<td  style=\"font-weight: bold;text-decoration:underline\"><strong>Status</strong></td></tr>';

                jQuery.each(data, function(rec) {
                    text = text + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.Status + "</td> </tr> ";
                });
                //text +='<tr><td>' + result.d[0].InvestigationName + '</td><td>' + result.d[0].Status + '</td></tr>'
                text += '</tbody></table>';
                //return text  
                document.getElementById('jsonDiv').style.display = "block";
                // $("#jsonDiv").html(text);
                //            var winH = $(window).height();
                //            var winW = $(window).width();
                //var centerDiv = $('#jsonDiv');
                //            centerDiv.css('top', winH / 2 - centerDiv.height() / 2);
                //            centerDiv.css('left', winW / 2 - centerDiv.width() / 2);
                //                    var mouseX, mouseY // with e.pageX and e.pageY    
                //                    var $e = $("body");

                //                    var center_x = $e.width() / 2;
                //                    var center_y = $e.height() / 2;

                //                    mouseX -= $e.position().left + center_x;
                //                    mouseY -= $e.position().top + center_y;

                //                $(document).on("mousemove", function(event) {
                //                //$("#jsonDiv").text("pageX: " + event.pageX + ", pageY: " + event.pageY);
                //                centerDiv.css('top', event.pageY + event.offsetY);
                //                centerDiv.css('left', event.pageX + event.offsetX);
                //                });
                $("#tblEnterResult tbody tr").on("mouseover", function(event) {
                    showTooltipnew(event, text);
                });
                $('#tblEnterResult tbody tr').on('mouseout', function() {
                    hideTooltip();
                });
            }
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 100px;
        }
    </style>

    <script type="text/javascript">

        var DisplMsg;
        var userMsg2;


        function checkForValues1() {

            var userMsg1 = SListForAppMsg.Get('Lab_Home_aspx_01') != null ? SListForAppMsg.Get('Lab_Home_aspx_01') : "Provide page number";
            DisplMsg = SListForAppMsg.Get('Lab_Home_aspx_05') != null ? SListForAppMsg.Get('Lab_Home_aspx_05') : "Alert";
            if (document.getElementById('txtpageNo').value == "") {
                var userMsg = SListForApplicationMessages.Get("Lab\\Home.aspx_4");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, DisplMsg);
                    return false;
                }
                else {
                    // alert('Provide page number');
                    ValidationWindow(userMsg1, DisplMsg);
                    return false;
                }
                return false;
            }
            userMsg2 = SListForAppMsg.Get('Lab_Home_aspx_02') != null ? SListForAppMsg.Get('Lab_Home_aspx_02') : "Provide correct page number";
            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                var userMsg = SListForApplicationMessages.Get("Lab\\Home.aspx_5");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, DisplMsg);
                    return false;
                }
                else {
                    //alert('Provide correct page number');
                    ValidationWindow(userMsg2, DisplMsg);
                    return false;
                }
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                var userMsg = SListForApplicationMessages.Get("Lab\\Home.aspx_5");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, DisplMsg);
                    return false;
                }
                else {
                    //alert('Provide correct page number');
                    ValidationWindow(userMsg2, DisplMsg);
                    return false;
                }
                return false;
            }



        }

    </script>

  <%--  <script type="text/javascript" src="../Scripts_New/jquery.min.js"></script>--%>

</head>
<body>
    <form id="frmPatientVitals" runat="server" defaultbutton="btnSearch">

    <script type="text/javascript">
        function ShowStatus(visitid) {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/FetchInvestigationStatus",
                data: "{ 'visitid': '" + visitid + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    // $("#jsonResponse").html(msg);
                    //alert(msg);
                    $("#jsonDiv").html('');

                    var data = msg.d;

                    var t = "<table border=1> <tr>" +
                      "<td> <strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_TestName%>" + "</strong></td> <td> " +
                      "<strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_Status%>" + "</strong></td> </tr> ";
                    jQuery.each(data, function(rec) {
                        t = t + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.Status + "</td> </tr> ";
                    });

                    t = t + " </table> ";
                    document.getElementById('jsonDiv').style.display = "block";
                    $("#jsonDiv").html(t);
                },
                error: function(msg) {

                }

            });
        };
        function HideStatus() {

            document.getElementById('jsonDiv').style.display = "none";
        }

        function reloadauto() {

            function ShowStatus(visitid, name) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/FetchInvestigationStatus",
                    data: "{ 'visitid': '" + visitid + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        // $("#jsonResponse").html(msg);
                        //alert(msg);
                        $("#jsonDiv").html('');

                        var data = msg.d;

                        var t = "<table border=1><tr><td>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_PatientName%>" + "</td><td>" + name + "</td></tr> <tr>" +
                      "<td> <strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_TestName_1%>" + "</strong></td> <td> " +
                      "<strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_Status_1%>" + "</strong></td> </tr> ";
                        jQuery.each(data, function(rec) {
                            t = t + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.Status + "</td> </tr> ";
                        });

                        t = t + " </table> ";
                        document.getElementById('jsonDiv').style.display = "block";
                        $("#jsonDiv").html(t);
                    },
                    error: function(msg) {

                    }

                });
            };
        }
	    
	    
    </script>

    <script type="text/javascript">
        function ShowStatus(visitid) {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/FetchInvestigationStatus",
                data: "{ 'visitid': '" + visitid + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    // $("#jsonResponse").html(msg);
                    //alert(msg);
                    $("#jsonDiv").html('');

                    var data = msg.d;

                    var t = "<table border=1> <tr>" +
                      "<td> <strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_TestName%>" + "</strong></td> <td> " +
                      "<strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_Status%>" + "</strong></td> </tr> ";
                    jQuery.each(data, function(rec) {
                        t = t + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.Status + "</td> </tr> ";
                    });

                    t = t + " </table> ";
                    document.getElementById('jsonDiv').style.display = "block";
                    $("#jsonDiv").html(t);
                },
                error: function(msg) {

                }

            });
        };
        function HideStatus() {

            document.getElementById('jsonDiv').style.display = "none";
        }

        function reloadauto() {

            function ShowStatus(visitid, name) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/FetchInvestigationStatus",
                    data: "{ 'visitid': '" + visitid + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        // $("#jsonResponse").html(msg);
                        //alert(msg);
                        $("#jsonDiv").html('');

                        var data = msg.d;

                        var t = "<table border=1><tr><td>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_PatientName%>" + "</td><td>" + name + "</td></tr> <tr>" +
                      "<td> <strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_TestName_1%>" + "</strong></td> <td> " +
                      "<strong>" + "<%=Resources.ClientSideDisplayTexts.Lab_Home_Status_1%>" + "</strong></td> </tr> ";
                        jQuery.each(data, function(rec) {
                            t = t + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.Status + "</td> </tr> ";
                        });

                        t = t + " </table> ";
                        document.getElementById('jsonDiv').style.display = "block";
                        $("#jsonDiv").html(t);
                    },
                    error: function(msg) {

                    }

                });
            };
        }
	    
	    
    </script>

    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table cellpadding="2" cellspacing="1" class="w-100p">
                            <tr id="tdAberrant" runat="server" style="display: none;">
                                <td class="w-100p a-right">
                                    <asp:UpdatePanel ID="up1" runat="server">
                                        <ContentTemplate>
                                            <%--<uc11:AbbrentQueue ID="AbbrentQueue" runat="server" />--%>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor a-left">
                                   <%-- <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" meta:resourcekey="Rs_PendingTaskListResource1"></asp:Label>--%>
                                    <uc3:Department ID="Department1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor h-32">
                                    <uc8:Task ID="uctlTaskList" runat="server" />
                                    <asp:HiddenField ID="hdntext" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div id="dCapture" runat="server" visible="false">
                            <asp:UpdatePanel ID="ctlTaskUpdPnl1" runat="server">
                                <ContentTemplate> 
                                    <table class="w-100p">
                                        <tr>
                                            <td class="w-15p h-23 a-left">
                                                <div id="dCaption" runat="server" visible="False">
                                                    <span class="dataheader1txt">&nbsp;<asp:Label ID="Rs_InvestigatonResultCapture" Text="Investigaton Result Capture"
                                                        runat="server" meta:resourcekey="Rs_InvestigatonResultCaptureResource1"></asp:Label></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="colorforcontent w-30p h-23 a-left">
                                                <div id="ACX2plus2" style="display: none;">
                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',2);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',2);">
                                                        &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Result" meta:resourcekey="lblinvfilterResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus2" style="display: block;">
                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                        &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Investigation Result" meta:resourcekey="lblinvfiltersResource1"></asp:Label></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="tablerow" id="ACX2responses2" style="display: table-row;">
                                            <td class="w-85p h-23 a-right filterdataheader2">
                                                <table class="w-100p" id="CommonToAll" runat="server">
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtPatientSearch" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientSearchResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="a-right style1">
                                                            <asp:Label ID="lbltestname" Text="Test Name" runat="server" meta:resourcekey="lbltestnameResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtinvname" class="tb1" CssClass="Txtboxsmall" runat="server" onfocus="javascript:ClearTestDetails();"></asp:TextBox>
                                                            <div id="aceDiv">
                                                            </div>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                                TargetControlID="txtinvname" ServiceMethod="FetchInvestigationNameForResult"
                                                                ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                Enabled="True" OnClientItemSelected="SelectedTest" CompletionListElementID="aceDiv"
                                                                OnClientShown="setAceWidth">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblVisitType" Text="Visit Type" runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList ID="ddlVisitType" runat="server" meta:resourcekey="ddlVisitTypeResource1"
                                                                CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdnVisitType" runat="server" />
                                                            <asp:HiddenField ID="hdnPatientName" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblwardno" Text="WardNo/PhoneNo" runat="server" meta:resourcekey="lblwardnoResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtwardno" runat="server" meta:resourcekey="txtwardnoResource1"
                                                                CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                        <td class="a-right style1">
                                                            <asp:Label ID="lblstatus" Text="Status" runat="server" meta:resourcekey="lblstatusResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList ID="ddlStatus" runat="server" Height="25px" Width="134px" meta:resourcekey="ddlStatusResource1"
                                                                CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <%--     <td align="right">
                                                            <asp:Label ID="lblSourceName" Text="Client Name" runat="server" meta:resourcekey="lblSourceNameResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:DropDownList ID="ddlSourceName" runat="server" meta:resourcekey="ddlSourceNameResource1" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>--%>
                                                        <td class="a-right">
                                                            <asp:Label ID="lbldept" runat="server" Text="Department"  meta:resourcekey="lbldeptResource2"></asp:Label>
                                                            <asp:Label ID="Label4" Text="Priority Type" runat="server" Style="display: none"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList ID="drpPriority" runat="server" Style="display: none" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddlDept" Visible ="false"  runat="server" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <asp:TextBox ID="txtDeptName" runat="server" class="tb1" CssClass="Txtboxsmall" onfocus="javascript:ClearDeptDetails();">
                                                            </asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="txtDeptNameExtender" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                Enabled="True" MinimumPrefixLength="2" ServiceMethod="FetchDepartmentNameForResult"
                                                                OnClientItemSelected="SelectedDept" ServicePath="~/WebService.asmx" TargetControlID="txtDeptName">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right w-100">
                                                            <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox Width="142px" ID="txtFrom" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                        </td>
                                                        <td class="style1 a-right">
                                                            <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtTo" Width="125px" runat="server" meta:resourcekey="txtToResource1"
                                                                CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                        </td>
                                                        <td class="a-right">
                                                        <asp:Label ID="lblProtocal" runat="server" Text="Protocal Group" meta:resourcekey="lblProtocalResource1"></asp:Label>
                                                         <asp:Label ID="lblSourceName" Text="Client Name" runat="server" Visible ="false"  meta:resourcekey="lblSourceNameResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                         <asp:DropDownList runat="server" Width="155px" ID="ddlprotocalgroup" CssClass="ddl">
                                                                </asp:DropDownList>
                                                                 <asp:DropDownList ID="ddlSourceName" Visible ="false" runat="server" meta:resourcekey="ddlSourceNameResource1"
                                                                CssClass="ddlsmall">
                                                                </asp:DropDownList> 
                                                        </td>
                                                        <%--<td align="right">
                                                            <asp:Label ID="lbldept" runat="server" Text="Department"></asp:Label>
                                                            <asp:Label ID="Label4" Text="Priority Type" runat="server" Style="display: none"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:DropDownList ID="drpPriority" runat="server" Style="display: none" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <asp:TextBox ID="txtDeptName" runat="server" class="tb1" CssClass="Txtboxsmall" onfocus="javascript:ClearDeptDetails();">
                                                            </asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="txtDeptNameExtender" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                Enabled="True" MinimumPrefixLength="2" ServiceMethod="FetchDepartmentNameForResult"
                                                                OnClientItemSelected="SelectedDept" ServicePath="~/WebService.asmx" TargetControlID="txtDeptName">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>--%>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right w-100">
                                                            <asp:Label ID="lblvisitNo" runat="server" Text="Number" meta:resourcekey="lblvisitNoResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtvisitno" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                        <td class="style1 a-right">
                                                            <asp:Label ID="lblpatno" runat="server" Text="Patient Number" meta:resourcekey="lblpatnoResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtpatno" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                        <td class="a-right">
                                                        <asp:Label ID="lblpendingdays" runat="server" Text="PendingDays" meta:resourcekey="lblpendingdaysResource1"></asp:Label>
                                                        
                                                            <asp:CheckBox ID="chkSetDefault"  runat="server" Text="Set Default" Visible ="false"  meta:resourcekey="chkSetDefaultResource1" />                                                        
                                                                 
                                                        </td>
                                                        <td class="a-left">
                                                        <asp:TextBox ID="txtpendingdays" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <asp:Button ID="btnClear" runat="server" CssClass="btn" 
                                                                        meta:resourcekey="btnClearResource1" OnClick="btnClear_Click" 
                                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                        Text="Clear" Visible="false" />
                                                             
                                                        </td>
                                                        <td>
                                            <asp:CheckBox ID="chktasks" runat="server" Text="Allocated Tasks" />
                                        </td>
                                    </tr>
                                    <tr>
                                                        <td class="a-right w-100">
                                                            <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                           <asp:DropDownList ID="ddlLocation" runat="server" meta:resourcekey="ddlLocationResource1"
                                                                CssClass="ddlsmall" 
                                                                onselectedindexchanged="ddlLocation_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
														
														
														 <td class="a-right">
                                            <asp:Label ID="lblBarcode" runat="server" Text="BarCode Number" meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtBarcode" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>
                                                       
                                    </tr>
                                </table>
                                <table class="w-100p" id="Waters" runat="server" visible="false">
                                    <tr>
                                        <td class="a-right w-100">
                                            <asp:Label ID="Label5" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox Width="142px" ID="txtFromWaters" runat="server" CssClass="Txtboxsmall"
                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                            <asp:ImageButton ID="ImgFrmPopUp" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtFromWaters"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtFromWaters" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtFromWaters"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgFrmPopUp" Enabled="True" />
                                        </td>
                                        <td class="style1 a-right">
                                            <asp:Label ID="Label6" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtTowaters" Width="125px" runat="server" meta:resourcekey="txtToResource1"
                                                CssClass="Txtboxsmall"></asp:TextBox>
                                            <asp:ImageButton ID="imgToPopUP" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtTowaters"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtTowaters" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtTowaters"
                                                Format="dd/MM/yyyy" PopupButtonID="imgToPopUP" Enabled="True" />
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblSampleID" Text="Sample ID" runat="server"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtSampleID" runat="server" class="tb1" placeholder="Sample Number"
                                                CssClass="Txtboxsmall">
                                            </asp:TextBox>
                                        </td>
                                        <td class="w-10p">
                                            <asp:Button ID="btnWtSearch" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-right">
                                            <asp:Label ID="Label7" runat="server" Text="Department" meta:resourcekey="lbldeptResource2"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtDeptNameW" runat="server" class="tb1" CssClass="Txtboxsmall"
                                                onfocus="javascript:ClearDeptDetails();">
                                            </asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="DeptFilter" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                Enabled="True" MinimumPrefixLength="2" ServiceMethod="FetchDepartmentNameForResult"
                                                OnClientItemSelected="SelectedDept" ServicePath="~/WebService.asmx" TargetControlID="txtDeptNameW">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="a-right w-100">
                                            <asp:Label ID="Label9" runat="server" Text="Visit Number"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtVisitNumberW" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <caption>
                                                &nbsp;
                                            </caption>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="defaultfontcolor">
                                                <div id="divGridView">
                                                    <asp:GridView ID="GridView1" runat="server" ForeColor="Black" CellPadding="4"
                                                        AutoGenerateColumns="False" class="gridView" CssClass="grdResult w-100p" 
                                                          OnRowDataBound="GridView1_RowDataBound" AllowPaging="True"
                                                        meta:resourcekey="GridView1Resource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                                        <EmptyDataTemplate>
                                                            <center>
                                                                <asp:Label ID="Rs_NoMatchingPatientRecordsFound" Text="No Matching Patient Records Found"
                                                                    runat="server" meta:resourcekey="Rs_NoMatchingPatientRecordsFoundResource3"></asp:Label></center>
                                                        </EmptyDataTemplate>
                                                        <Columns>
                                                            <%--<asp:TemplateField HeaderText="Task Details" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <a href='<%# "~/Investigation/InvestigationCapture.aspx?DeptId="+DataBinder.Eval(Container.DataItem,"DeptID")+"&vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") + "&gUID=" + DataBinder.Eval(Container.DataItem,"UID") + "&RNo=" + DataBinder.Eval(Container.DataItem,"Labno") + "&InvCount=" + DataBinder.Eval(Container.DataItem,"RateID")%>'
                                                                        runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                                                        <%# "Enter Result for " + (string)DataBinder.Eval(Container.DataItem, "PatientName")+"(PatientNo:" + "" + (string)DataBinder.Eval(Container.DataItem, "PatientNumber") + ")" +"(VisitNumber:"+ "" +(string)DataBinder.Eval(Container.DataItem, "VisitNumber") + ")" + " " + (string)DataBinder.Eval(Container.DataItem, "VisitNotes")%>
                                                                    </a>
                                                                </ItemTemplate>
                                                                <ControlStyle Width="250px" />
                                                            </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="Task Details" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <a href='<%# "~/Investigation/InvestigationCapture.aspx?DeptId="+DataBinder.Eval(Container.DataItem,"DeptID")+"&vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") + "&gUID=" + DataBinder.Eval(Container.DataItem,"UID") + "&RNo=" + DataBinder.Eval(Container.DataItem,"Labno") + "&InvCount=" + DataBinder.Eval(Container.DataItem,"RateID")+ "&REType=" + DataBinder.Eval(Container.DataItem,"ResultEntryType")%>'
                                                                        runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                                                        <asp:Label ID="lblTaskDescription" runat="server" meta:resourcekey="TemplateFieldResource1"
                                                                            Text='<%# Eval("AccompaniedBy") %>'></asp:Label>
                                                                    </a>
                                                                </ItemTemplate>
                                                                <ControlStyle Width="250px" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource1"
                                                                ItemStyle-HorizontalAlign="center">
                                                                <ControlStyle Width="120px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="OutVisitID" HeaderText="LabNo" Visible="False" meta:resourcekey="BoundFieldResource2">
                                                                <ControlStyle Width="120px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VisitDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}"
                                                                ItemStyle-HorizontalAlign="center" meta:resourcekey="BoundFieldResource3">
                                                                <ControlStyle Width="120px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ComplaintName" HeaderText="Registered Location" ItemStyle-HorizontalAlign="center"
                                                                meta:resourcekey="BoundFieldResource4">
                                                                <ControlStyle Width="120px" />
                                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Report Date" ItemStyle-HorizontalAlign="center" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldate" runat="server" Text='<%#bind("ReportTat","{0:dd MMM yyyy hh:mm tt}")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                                            <asp:TemplateField Visible="False" HeaderText="Print Work List" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="hypLnkPrint" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                                        Target="WorkListWindow" runat="server" ToolTip="Click Here To Print Work List"
                                                                        NavigateUrl='<%# "~/Investigation/PrintLabWorkList.aspx?vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") + "&gUID=" + DataBinder.Eval(Container.DataItem,"UID") %>'
                                                                        meta:resourcekey="hypLnkPrintResource1">
                                                                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                                                                        &nbsp;<u> </u>
                                                                    </asp:HyperLink>
                                                                </ItemTemplate>
                                                                <ControlStyle Width="50px" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                                                    meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                                                <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                                    TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                                    CancelControlID="btnCnl" DynamicServicePath="" Enabled="True">
                                                                </cc1:ModalPopupExtender>
                                                                <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="50%" CssClass="w-50p modalPopup dataheaderPopup"
                                                                    runat="server" meta:resourcekey="pnlAttribResource1">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <uc10:AdvancedSearch ID="ucAdvanceSearch" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                    onmouseout="this.className='btn'" meta:resourcekey="btnCnlResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr class="dataheaderInvCtrl">
                                            <td colspan="2" class="a-center defaultfontcolor">
                                                <div id="divFooterNav" runat="server">
                                                    <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                    <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                        CssClass="btn" meta:resourcekey="Btn_PreviousResource1" />
                                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                                        meta:resourcekey="Btn_NextResource1" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px" CssClass="Txtboxsmall" maxlength='4' onkeyDown="javascript:return validatenumberOnly(event,this.id);"
                                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                    <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues1();"
                                                        OnClick="btnGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                                </div>
                                            </td>
                                        </tr>
                        <tr>
                            <td>
                                <table id="tblEnterResult" class="bg-row" border="1" style="display: none; border-collapse: collapse;
                                    empty-cells: show; white-space: nowrap; text-align: left;">
                                    <thead>
                                        <tr>
                                            <th>
                                               <%--Task Details--%>
                                               <%=Resources.Lab_ClientDisplay.Lab_Home_aspx_09 %>
                                            </th>
                                            <th>
                                                <%--Age--%>
                                                <%=Resources.Lab_ClientDisplay.Lab_Home_aspx_10 %>
                                            </th>
                                            <%--<th>
                                                LabNo
                                            </th>--%>
                                            <th>
                                                <%--Date--%>
                                                <%=Resources.Lab_ClientDisplay.Lab_Home_aspx_11 %>
                                            </th>
                                            <th>
                                                <%--Registered Location--%>
                                                 <%=Resources.Lab_ClientDisplay.Lab_Home_aspx_12 %>
                                            </th>
                                            <th>
                                                <%--Report Date--%>
                                                <%=Resources.Lab_ClientDisplay.Lab_Home_aspx_13 %>
                                            </th>
                                            <%--<th>
                                                Print Work Lis
                                            </th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>

                            </asp:UpdateProgress>
                        </div>
                        <br />
                        <br />
                        
                    </div>
            <Attune:Attunefooter ID="Attunefooter" runat="server" />  
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="hdnTestName" runat="server" />
    <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnTestType" runat="server" />
    <asp:HiddenField ID="hdnDeptName" runat="server" />
    <asp:HiddenField ID="hdnDeptID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnReportdateconfig" runat="server" />
    <%--Script for AutoComplete of Investigation Name--%>

    <script type="text/javascript">
        $(function() {

            $(".tb1").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "../WebService.asmx/FetchInvestigationName",
                        data: "{ 'Name': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function(data) { return data; },
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    value: item.Name
                                }
                            }))
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                minLength: 2
            });
        });


        function reloadTestautoComplete() {

            $(function() {

                $(".tb1").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchInvestigationName",
                            data: "{ 'Name': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.Name
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });

        }
        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName1 = TestDetails.split('~')[0];
            var TestName = TestName1.split(':')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = TestName;
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = TestID;
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = TestType;
            }
        }
        function ClearTestDetails() {
            if (document.getElementById('txtinvname') != null) {
                document.getElementById('txtinvname').value = '';
            }
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = '';
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = '0';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }


        function SelectedDept(source, eventArgs) {
            DeptDetails = eventArgs.get_value();

            var DeptName = DeptDetails.split('~')[0];
            var DeptID = DeptDetails.split('~')[1];
            if (document.getElementById('hdnDeptName') != null) {
                document.getElementById('hdnDeptName').value = DeptName;
            }
            if (document.getElementById('hdnDeptID') != null) {
                document.getElementById('hdnDeptID').value = DeptID;
            }
        }
        function ClearDeptDetails() {
            if (document.getElementById('txtDeptName') != null) {
                document.getElementById('txtDeptName').value = '';
            }
            if (document.getElementById('hdnDeptName') != null) {
                document.getElementById('hdnDeptName').value = '';
            }
            if (document.getElementById('hdnDeptID') != null) {
                document.getElementById('hdnDeptID').value = '0';
            }
        }
	    
    </script>

    <asp:HiddenField ID="hdnTaskCount" runat="server" />

    <script language="javascript" type="text/javascript">
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
        }
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

</body>
</html>
