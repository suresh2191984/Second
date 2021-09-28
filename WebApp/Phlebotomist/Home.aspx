<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Phlebotomist_Home" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>--%>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%--<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>--%>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>--%>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc3" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/AdvancedSearch.ascx" TagName="AdvancedSearch"
    TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/AbberantQueue.ascx" TagName="AbbrentQueue" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Technician Home Page</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <%--   <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">
        window.history.forward(1);
        //        Function getdatafromcontrol()
        //        {

        //        var txtCatCode = document.getElementById('uctlTaskList_txttext');
        //        if (txtCatCode == null) {
        //            document.getElementById('hdntext').value = "";
        //        }
        //        else {

        //            document.getElementById('hdntext').value = txtCatCode;
        //        }
        //        }
        //     
   
       
    </script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Tasks.js" type="text/javascript"></script>

    <script src="../Scripts/moment.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var AlertType;

        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Phlebotomist_Home_aspx_03') == null ? "Alert" : SListForAppMsg.Get('Phlebotomist_Home_aspx_03');
        });

        function AnimateGridview() {

            $(document).ready(function() {



                document.getElementById("divGridView").style.display = "none";

                $("#divGridView").slideDown('slow');



            });
        }
        function LoadPost() {

            //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(AnimateGridview);

        }

        function OpenBillPrint(url) {
            window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 100px;
        }
        .listMain
        {
            width: 300px !important;
        }
    </style>

    <script type="text/javascript">

        var datadiv_tooltip = false;
        var datadiv_tooltipShadow = false;
        var datadiv_shadowSize = 4;
        var datadiv_tooltipMaxWidth = 200;
        var datadiv_tooltipMinWidth = 100;
        var datadiv_iframe = false;
        var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
        function showTooltip(e, tooltipTxt) {

            var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

            if (!datadiv_tooltip) {
                datadiv_tooltip = document.createElement('DIV');
                datadiv_tooltip.id = 'datadiv_tooltip';
                datadiv_tooltipShadow = document.createElement('DIV');
                datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                document.body.appendChild(datadiv_tooltip);
                document.body.appendChild(datadiv_tooltipShadow);

                if (tooltip_is_msie) {
                    datadiv_iframe = document.createElement('IFRAME');
                    datadiv_iframe.frameborder = '5';
                    datadiv_iframe.style.backgroundColor = '#FFFFFF';
                    datadiv_iframe.src = '#';
                    datadiv_iframe.style.zIndex = 100;
                    datadiv_iframe.style.position = 'absolute';
                    document.body.appendChild(datadiv_iframe);
                }

            }

            datadiv_tooltip.style.display = 'block';
            datadiv_tooltipShadow.style.display = 'block';
            if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

            var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
            var leftPos = e.clientX + 10;

            datadiv_tooltip.style.width = null; // Reset style width if it's set 
            datadiv_tooltip.innerHTML = tooltipTxt;
            datadiv_tooltip.style.left = leftPos + 'px';
            datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


            datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
            datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

            if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
                datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
            }

            var tooltipWidth = datadiv_tooltip.offsetWidth;
            if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


            datadiv_tooltip.style.width = tooltipWidth + 'px';
            datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
            datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

            if ((leftPos + tooltipWidth) > bodyWidth) {
                datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
                datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
            }

            if (tooltip_is_msie) {
                datadiv_iframe.style.left = datadiv_tooltip.style.left;
                datadiv_iframe.style.top = datadiv_tooltip.style.top;
                datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
                datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

            }

        }

        function hideTooltip2() {
            datadiv_tooltip.style.display = 'none';
            datadiv_tooltipShadow.style.display = 'none';
            if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
        }

        function checkForValues() {
            /* Added By Venkatesh S */
            var vPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_01') == null ? "Provide page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_01');
            var vCorrectPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_02') == null ? "Provide correct page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_02');

            if (document.getElementById('txtpageNo').value == "") {
                ValidationWindow(vPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }



        }

    </script>

    <%--  <script type="text/javascript" src="../Scripts/jquery.min.js"></script>--%>

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
                      "<td> <strong>Test Name</strong></td> <td> " +
                      "<strong>Status</strong></td> </tr> ";
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

                        var t = "<table border=1><tr><td>Patient Name</td><td>" + name + "</td></tr> <tr>" +
                      "<td> <strong>Test Name</strong></td> <td> " +
                      "<strong>Status</strong></td> </tr> ";
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

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%-- <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
        <table class="w-100p">
            <tr id="tdAberrant" runat="server" style="display: none;">
                <td class="w-100p a-right">
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <%--<uc11:AbbrentQueue ID="AbbrentQueue" runat="server" />--%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr class="gridHeader">
                <td class="defaultfontcolor a-left">
                    <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" meta:resourcekey="Rs_PendingTaskListResource1"></asp:Label>
                    <uc3:Department ID="Department1" runat="server" />
                </td>
            </tr>
            <tr>
                <td height="32" class="defaultfontcolor">
                    <uc8:Task ID="uctlTaskList" runat="server" />
                    <asp:HiddenField ID="hdntext" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div id="dCapture" runat="server" visible="false" class="w-100p">
            <asp:UpdatePanel ID="ctlTaskUpdPnl1" runat="server">
                <ContentTemplate>
                    <table class="w-100p">
                        <tr>
                            <td class="h-23 colorforcontent a-left">
                                <div id="ACX2plus2" style="display: none;">
                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15px" height="15px" class="a-center"
                                        style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                        &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Selective Authorization"
                                            meta:resourcekey="lblinvfilterResource1"></asp:Label></span>
                                </div>
                                <div id="ACX2minus2" style="display: block;">
                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" class="a-center"
                                        style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                        &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Selective Authorization"
                                            meta:resourcekey="lblinvfiltersResource1"></asp:Label></span>
                                </div>
                            </td>
                        </tr>
                        <tr class="tablerow" id="ACX2responses2" style="display: table-row;">
                            <td class="filterdataheader2 a-left h-23">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" meta:resourcekey="Panel1Resource4">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-right">
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                <asp:HiddenField ID="hdnPatientName" runat="server" />
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearPatientNameDetails();"
                                                    meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="3" ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                                    DelimiterCharacters="" Enabled="True" OnClientItemSelected="SelectedPatientName">
                                                </cc1:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnPatientID" runat="server" Value="0" />
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lbltestname" Text="Test Name" runat="server" meta:resourcekey="lbltestnameResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtinvname" class="tb1" CssClass="Txtboxsmall" runat="server" onfocus="javascript:ClearTestDetails();"
                                                    meta:resourcekey="txtinvnameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="3" runat="server"
                                                    TargetControlID="txtinvname" ServiceMethod="FetchInvestigationNameForResult"
                                                    ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                    Enabled="True" OnClientItemSelected="SelectedTest">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblclient" Text="Client Name" runat="server" meta:resourcekey="lblclientResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="ACEClientName" runat="server" TargetControlID="txtClientName"
                                                    BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    EnableCaching="False" MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True"
                                                    ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientValue" ServicePath="~/WebService.asmx"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <%--<td>
                                                        <asp:LinkButton ID="LnkTimed" Font-Size="12px" ForeColor="Red"  runat="server" Text="TimedTask" 
                                                        OnClick="btnTimed_Click" ></asp:LinkButton>
                                                        </td>--%>
                                        </tr>
                                        <tr>
                                            <td class="a-right">
                                                <asp:Label ID="lblpatno" runat="server" Text="Patient Number" meta:resourcekey="lblpatnoResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtpatno" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtpatnoResource1"></asp:TextBox>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lbldept" runat="server" Text="Department" meta:resourcekey="lbldeptResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtDeptName" runat="server" class="tb1" CssClass="Txtboxsmall" onfocus="javascript:ClearDeptDetails();"
                                                    meta:resourcekey="txtDeptNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="txtDeptNameExtender" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                    Enabled="True" MinimumPrefixLength="3" ServiceMethod="FetchDepartmentNameForResult"
                                                    OnClientItemSelected="SelectedDept" ServicePath="~/WebService.asmx" TargetControlID="txtDeptName">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblReferringPhysician" Text="Referring Physician" runat="server" meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtReferringPhysician" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtReferringPhysicianResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtReferringPhysician"
                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="3"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="FetchRefPhysicianNameForOrg"
                                                    ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                                    DelimiterCharacters=";,:" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnPhysicianID" Value="0" runat="server"></asp:HiddenField>
                                                <td class="w-10p">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1"
                                                        Style="width: 80px; height: 30px;" />
                                                </td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right">
                                                <asp:Label ID="lblvisitNo" runat="server" Text="Visit Number" meta:resourcekey="lblvisitNoResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtvisitno" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtvisitnoResource1"></asp:TextBox>
                                            </td>
                                            <td class="v-top a-right paddingT5">
                                                <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
                                                <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                <asp:HiddenField ID="hdnTmedtask" runat="server" />
                                            </td>
                                            <td class="a-left">
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                                                        runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                                        <%--<asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource12" Text="--Select--"></asp:ListItem>
                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource13" Text="This Week"></asp:ListItem>
                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource14" Text="This Month"></asp:ListItem>
                                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource15" Text="This Year"></asp:ListItem>
                                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource16" Text="Custom Period"></asp:ListItem>
                                                                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource17" Text="Today"></asp:ListItem>
                                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource18" Text="Last Week"></asp:ListItem>
                                                                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource19" Text="Last Month"></asp:ListItem>
                                                        <asp:ListItem Value="7" meta:resourcekey="ListItemResource20" Text="Last Year"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                                <div id="divRegDate" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divRegCustomDate" runat="server" style="display: none;">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblddlocation" Text="Location" runat="server" meta:resourcekey="lblddlocationResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="ddlocation" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddlocationResource2">
                                                    </asp:DropDownList>
                                                </span>
                                                <asp:LinkButton ID="LnkTimed" Font-Size="13px" ForeColor="Brown" Font-Bold="True"
                                                    Font-Underline="True" TabIndex="103" runat="server" OnClick="btnTimed_Click"
                                                    Text="Timed Approval Tasks > 24 hours" meta:resourcekey="LnkTimedResource1"></asp:LinkButton>
                                                <asp:Label ID="lblTimedcount" Font-Size="13px" Font-Bold="True" ForeColor="Brown"
                                                    runat="server" meta:resourcekey="lblTimedcountResource1"></asp:Label>
                                                <asp:ImageButton ID="ImgTick" Visible="False" Width="25px" Height="25px" align="top"
                                                    runat="server" ImageUrl="~/Images/Checkout.gif" meta:resourcekey="ImgTickResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td runat="server" id="td_lblprotocalgroup">
                                                <asp:Label ID="lblProtocal" runat="server" Text="Protocal Group" meta:resourcekey="lblProtocalResource1"></asp:Label>
                                            </td>
                                            <td class="a-left" runat="server" id="td_drpProtocal">
                                                <asp:DropDownList runat="server" Width="155px" ID="ddlprotocalgroup" CssClass="ddl">
                                                </asp:DropDownList>
                                            </td>
                                            
                                            <td class="a-right">
                                                            <asp:Label ID="lblVisitType" Text="Visit Type" runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList ID="ddlVisitType" runat="server" meta:resourcekey="ddlVisitTypeResource1"
                                                                CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <caption>
                                &nbsp;
                            </caption>
                        </tr>
                        <tr>
                            <td colspan="2" class="defaultfontcolor">
                                <div id="divGridView" style="display: none" runat="server">
                                    <asp:GridView ID="GridView1" runat="server" ForeColor="Black" Width="100%" CellPadding="4"
                                        CssClass="gridView" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound"
                                        AllowPaging="True" meta:resourcekey="GridView1Resource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                        <EmptyDataTemplate>
                                            <center>
                                                <asp:Label ID="Rs_NoMatchingPatientRecordsFound" Text="No Matching Patient Found for Selective Authorization"
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
                                                    <a href='<%# "~/Investigation/InvestigationApprovel.aspx?DeptId="+DataBinder.Eval(Container.DataItem,"DeptID")+"&tid=0&pid="+DataBinder.Eval(Container.DataItem,"PatientID")+"&vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") + "&gUID=" + DataBinder.Eval(Container.DataItem,"UID") + "&RNo=" + DataBinder.Eval(Container.DataItem,"Labno")+"&TkCnt="+hdnTaskCount.Value +"&RowIndex=" + DataBinder.Eval(Container,"RowIndex")+"&TotRows="+hdntotrows.Value+"&POrgID="+hdnOrgID.Value%>'
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
                                                <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="50%" Width="50%" CssClass="modalPopup dataheaderPopup"
                                                    runat="server" meta:resourcekey="pnlAttribResource1">
                                                    <table width="100%">
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
                        <tr class="dataheaderInvCtrl" id="trPagination" runat="server" visible="false">
                            <td colspan="2" class="defaultfontcolor a-center">
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
                                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px" CssClass="Txtboxsmall"   onkeypress="return ValidateOnlyNumeric(this);"  
                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                    <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues1();"
                                        OnClick="btnGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <img src="../Images/working.gif" />
                    <asp:Label ID="lblLoading" runat="server" Text="Loading ..." meta:resourcekey="lblLoadingResource1"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
    </div>
    <div id="iframeplaceholder">
        <iframe runat="server" id='iframeBarcode' name='iframeBarcode' style='position: absolute;
            top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overflow:auto; z-index: -1'>
        </iframe>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTestName" runat="server" />
    <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnTestType" runat="server" />
    <asp:HiddenField ID="hdnDeptName" runat="server" />
    <asp:HiddenField ID="hdnDeptID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    </div>
    <%--         <script type="text/javascript" src="../Scripts/jquery.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script> --%>
    <%--Script for AutoComplete of Investigation Name--%>

    <script type="text/javascript">
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
        $(function() {
            //  ChangeDDLItemListWidth();
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
        function SelectedPatientName(source, eventArgs) {
            var PatientID = eventArgs.get_value();

            if (document.getElementById('hdnPatientID') != null) {
                document.getElementById('hdnPatientID').value = PatientID;
            }
        }
        function ClearPatientNameDetails() {
            if (document.getElementById('hdnPatientID') != null) {
                document.getElementById('hdnPatientID').value = '0';
            }
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
        function GetReferingPhysicianID(source, eventArgs) {
            RefPhyDetails = eventArgs.get_value();

            var lstPhyDetails = RefPhyDetails.split('~');
            if (document.getElementById('hdnPhysicianID') != null && lstPhyDetails != null && lstPhyDetails[1] != null) {
                document.getElementById('hdnPhysicianID').value = lstPhyDetails[1];
            }
        }
        function SelectedClientValue(source, eventArgs) {
            var ID = eventArgs.get_value();
            document.getElementById('hdnClientID').value = ID.split('|')[0];
        }
        function ClearFields() {
            if (document.getElementById('txtClientName').value.trim() == "") {
                document.getElementById('hdnClientID').value = "0";
            }
            if (document.getElementById('uctlTaskList_txtClientName').value.trim() == "") {
                document.getElementById('uctlTaskList_hdnSelectedClientID').value = "0";
            }
            if (document.getElementById('txtReferringPhysician').value.trim() == "") {
                document.getElementById('hdnPhysicianID').value = "0";
            }
        }
        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
        }
        function checkForValues1() {
            /* Added By Venkatesh S */
            var vPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_01') == null ? "Provide page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_01');
            var vCorrectPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_02') == null ? "Provide correct page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_02');

            if (document.getElementById('txtpageNo').value == "") {
                var userMsg = SListForApplicationMessages.Get("Phlebotomist\\Home.aspx_4");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    ValidationWindow(vPageNo, AlertType);
                    return false;
                }
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                var userMsg = SListForApplicationMessages.Get("Phlebotomist\\Home.aspx_5");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    ValidationWindow(vCorrectPageNo, AlertType);
                    return false;
                }
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                var userMsg = SListForApplicationMessages.Get("Phlebotomist\\Home.aspx_5");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    ValidationWindow(vCorrectPageNo, AlertType);
                    return false;
                }
                return false;
            }



        }
    </script>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <asp:HiddenField ID="hdnTaskCount" runat="server" />
    <asp:HiddenField ID="hdntotrows" Value="0" runat="server" />
    </form>
</body>
</html>
