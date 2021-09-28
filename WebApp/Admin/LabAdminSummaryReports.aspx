<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabAdminSummaryReports.aspx.cs"
    Inherits="Admin_LabAdminSummaryReports" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Summary Report</title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
        var x;

        function validateClient() {
            var AlertType = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01');
            var objcli = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_02') == null ? "Select a client" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_02');
            var objhos = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_03') == null ? "Select a hospital" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_03');
            var objcol = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_04') == null ? "Select a collection center" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_04');
            var objins = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_05') == null ? "Select a insurance name" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_05');
            var objbranch = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_06') == null ? "Select a branch name" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_06');
            var objdprt = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_07') == null ? "Select a department name" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_07'); 
            
            

            if (document.getElementById('flagSetter').value == "1") {
                if (document.getElementById('ddlClient').value == "0") {
                    //Admin\LabAdminSummaryReports.aspx_1
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {

                        ValidationWindow(objcli, AlertType);
                    
                       // alert('Select a client');
                    }
                    document.getElementById('ddlClient').focus();
                    return false;
                }
            }

            //            if (document.getElementById('flagSetter').value == "2") {
            //                if (document.getElementById("ddlPhysician").options[document.getElementById("ddlPhysician").selectedIndex].text == "-----Select-----") {
            //                    alert("Please Select a Doctor");
            //                    document.getElementById('ddlPhysician').focus();
            //                    return false;
            //                }
            //            }
            if (document.getElementById('flagSetter').value == "3") {
                if (document.getElementById('ddlHospital').value == "0") {
                    //Admin\LabAdminSummaryReports.aspx_3
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(objhos, AlertType);
                    
                        //alert('Select a hospital');
                    }
                    document.getElementById('ddlHospital').focus();
                    return false;
                }
            }

            if (document.getElementById('flagSetter').value == "4") {
                if (document.getElementById('ddlCollectionCentre').value == "0") {
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_4');
                    //Admin\LabAdminSummaryReports.aspx_4
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(objcol, AlertType);
                        //alert('Select a collection center');
                    }
                    document.getElementById('ddlCollectionCentre').focus();
                    return false;
                }
            }

            if (document.getElementById('flagSetter').value == "5") {
                if (document.getElementById('ddlInsurance').value == "0") {
                    //Admin\LabAdminSummaryReports.aspx_5
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_5');
                    //Admin\LabAdminSummaryReports.aspx_4
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(objins, AlertType);
                        //alert('Select a insurance name');
                    }
                    document.getElementById('ddlInsurance').focus();
                    return false;
                }
            }
            if (document.getElementById('flagSetter').value == "6") {
                if (document.getElementById('ddlBranch').value == "0") {
                    //Admin\LabAdminSummaryReports.aspx_6
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_6');
                    //Admin\LabAdminSummaryReports.aspx_4
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(objbranch, AlertType);
                       // alert('Select a branch name');
                    }
                    document.getElementById('ddlBranch').focus();
                    return false;
                }
            }
            if (document.getElementById('flagSetter').value == "7") {
                if (document.getElementById('ddlDept').value == "-1") {
                    //Admin\LabAdminSummaryReports.aspx_7
                    var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_7');
                    //Admin\LabAdminSummaryReports.aspx_4
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(objdprt, AlertType);
                    
                       // alert('Select a department name');
                    }
                    document.getElementById('ddlDept').focus();
                    return false;
                }
            }
            return ValidateDate();

        }
        function showHideClientDoctor(x) {
            document.getElementById('ddlPhysician').selectedIndex = 0;
            document.getElementById('ddlPhysician').options[0].selected = true;
            document.getElementById('ddlClient').selectedIndex = 0;
            document.getElementById('ddlClient').options[0].selected = true;

            document.getElementById('ddlHospital').selectedIndex = 0;
            document.getElementById('ddlHospital').options[0].selected = true;
            document.getElementById('ddlCollectionCentre').selectedIndex = 0;
            document.getElementById('ddlCollectionCentre').options[0].selected = true;

            document.getElementById('ddlInsurance').selectedIndex = 0;
            document.getElementById('ddlInsurance').options[0].selected = true;

            document.getElementById('ddlBranch').selectedIndex = 0;
            document.getElementById('ddlBranch').options[0].selected = true;

            document.getElementById('ddlDept').selectedIndex = 0;
            document.getElementById('ddlDept').options[0].selected = true;
            document.getElementById('trUsers').style.display = "none";
            if (x == "0") {
                document.getElementById('trClient').style.display = "block";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "1") {

                document.getElementById('trClient').style.display = "block";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "2") {
                document.getElementById('trClient').style.display = "none";
                document.getElementById('trDoctor').style.display = "block";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "3") {
                document.getElementById('trClient').style.display = "block";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "block";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "4") {
                document.getElementById('trClient').style.display = "none";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trCC').style.display = "block";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "5") {
                document.getElementById('trClient').style.display = "none";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "block";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "6") {
                document.getElementById('trClient').style.display = "none";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trBranch').style.display = "block";
                document.getElementById('trDept').style.display = "none";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }

            if (x == "7") {
                document.getElementById('trClient').style.display = "none";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trCC').style.display = "none";
                document.getElementById('trINS').style.display = "none";
                document.getElementById('trBranch').style.display = "none";
                document.getElementById('trDept').style.display = "block";
                document.getElementById('trUsers').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
        }

        function ValidateDate() {
            var AlertType = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01');
            var objdate = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_08') == null ? "Select From Date" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_08');
            var objdateto = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_09') == null ? "Select To Date" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_09');

            if (document.getElementById('txtFrom').value == '') {
                //Admin\LabAdminSummaryReports.aspx_8
                var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_8');

                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    ValidationWindow(objdate, AlertType);

                  //  alert('Select From Date');
                }
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                // Admin\LabAdminSummaryReports.aspx_9
                var userMsg = SListForApplicationMessages.Get('Admin\\LabAdminSummaryReports.aspx_9');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    ValidationWindow(objdateto, AlertType);
                   // alert('Select To Date');
                }
                return false;

            }
            else {
                return checkFromDateToDate('txtFrom', 'txtTo');
            }
        }
        //        function print() {

        //            var prtContent = document.getElementById('tdprintContent');
        //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        //            //alert(WinPrint);
        //            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        //            WinPrint.document.write(prtContent.innerHTML);
        //            WinPrint.document.close();
        //            WinPrint.focus();
        //            WinPrint.print();
        //            WinPrint.close();
        //        }


        function showCheckSplitUp(id) {

            var list = document.getElementById("rblReportType"); //Client ID of the radiolist
            var inputs = list.getElementsByTagName("input");
            var selected;
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].checked) {
                    selected = inputs[i];
                    break;
                }
            }
            if (document.getElementById(id).value == "1" && selected.value == "1") {
                document.getElementById('tdchkSplitUp').style.display = "block";
                document.getElementById('chkSplitUp').checked = true;
            }
            else {
                document.getElementById('tdchkSplitUp').style.display = "none";
                document.getElementById('chkSplitUp').checked = true;

            }

        }
        function showCheckSplitUp1() {
            var list = document.getElementById("rblReportType"); //Client ID of the radiolist
            var inputs = list.getElementsByTagName("input");
            var selected;
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].checked) {
                    selected = inputs[i];
                    break;
                }
            }
            if (selected.value == "2") {
                document.getElementById('tdchkSplitUp').style.display = "none";
                document.getElementById('chkSplitUp').checked = true;
            }
            if (document.getElementById('ddlDept').value == "1" && selected.value == "1") {
                document.getElementById('tdchkSplitUp').style.display = "block";
                document.getElementById('chkSplitUp').checked = true;
            }
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body onload="onComboFocus('ddlClient')">
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="ddlClient">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                       <%-- <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>--%>

                        <script type="text/javascript">
            $(function() {
                $("#txtFrom").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtTo").datepicker("option", "minDate", selectedDate);

                        var date = $("#txtFrom").datepicker('getDate');
                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                        // $("#txtTo").datepicker("option", "maxDate", d);

                    }
                });
                $("#txtTo").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                    }
                })
            });

                        </script>

                        <table class="w-100p searchPanel">
                            <tr>
                                <td>
                                    <div>
                                        <asp:Panel runat="server" CssClass="dataheader2 w-99p" ID="pnlDate" meta:resourcekey="pnlDateResource1">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                                                        meta:resourceKey="lblOrgsResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                                        CssClass="ddlsmall" meta:resourceKey="ddlTrustedOrgResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtFromResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtTo" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtToResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="pnlView" runat="server" Width="100%" 
                                                                        GroupingText="View Report based on" meta:resourceKey="pnlViewResource1">
                                                                        <input type="hidden" id="flagSetter" runat="server"> </input>
                                                                        <asp:DropDownList ID="ddlSummaryReportParameter" runat="server" meta:resourcekey="ddlSummaryReportParameterResource1"
                                                                            CssClass="ddlsmall" onchange="javascript:showHideClientDoctor(this.value);">
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="pnReportType" runat="server" Width="100%" 
                                                                        GroupingText="Report Type" meta:resourceKey="pnReportTypeResource1">
                                                                        <asp:RadioButtonList ID="rblReportType" onclick="javascript:showCheckSplitUp1();" RepeatDirection="Horizontal" runat="server">
                                                                           <%-- <asp:ListItem Text="Summary" Selected="True" Value="2" 
                                                                                meta:resourceKey="ListItemResource1"></asp:ListItem>
                                                                            <asp:ListItem Text="Detail" Value="1" meta:resourceKey="ListItemResource2"></asp:ListItem>--%>
                                                                        </asp:RadioButtonList>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr id="trClient" runat="server">
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblClient" Text="Select a Client" meta:resourcekey="lblClientResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlClient" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlClientResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trHospital" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="lblHospital" Text="Select a Hospital" meta:resourcekey="lblHospitalResource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlHospital" CssClass="ddl" runat="server" meta:resourcekey="ddlHospitalResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </tr>
                                                            <tr id="trDoctor" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="lblDoctor" Text="Select a Doctor" meta:resourcekey="lblDoctorResource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlPhysician" CssClass="ddl" runat="server" meta:resourcekey="ddlPhysicianResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trCC" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="Label1" Text="Select a CollectionCentre" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlCollectionCentre" CssClass="ddl" runat="server" meta:resourcekey="ddlCollectionCentreResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trINS" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="Label2" Text="Select a Insurance" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlInsurance" CssClass="ddl" runat="server" meta:resourcekey="ddlInsuranceResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trBranch" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="Label3" Text="Select a Branch" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlBranch" CssClass="ddl" runat="server" meta:resourcekey="ddlBranchResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trUsers" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="Label6" Text="Select User Name" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl" meta:resourcekey="ddlUsersResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trDept" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label runat="server" ID="Label4" Text="Select a Department" meta:resourcekey="Label4Resource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                    <asp:DropDownList ID="ddlDept" CssClass="ddlsmall" onchange="javascript:showCheckSplitUp(this.id);"
                                                                        runat="server" meta:resourcekey="ddlDeptResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td id="tdchkSplitUp" runat="server" style="display: none;">
                                                                    <asp:CheckBox ID="chkSplitUp" Checked="True" runat="server" Text="Lab Department Wise Split Up Report?"
                                                                        meta:resourcekey="chkSplitUpResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                        <center>
                                            <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateClient();"
                                                OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                            &nbsp;
                                            <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            <td>
                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                    meta:resourcekey="lnkBackResource1" Text="Back;"></asp:LinkButton>
                                            </td>
                                        </center>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="a-right paddingR10" style="color: #000000;">
                    <asp:ImageButton ID="btnConverttoXL" OnClick="btnXL_Click" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                        meta:resourcekey="btnConverttoXLResource1" Visible="false"  />
                    <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333" Visible="false"
                        runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                    &nbsp;&nbsp;
                    <%--
                                                        <asp:ImageButton ID="btnConverttoClientXL" runat="server" OnClick="btnXL_Click1"
                                                               ImageUrl="~/Images/ExcelImage.GIF" Visible="false" />
                                                                --%>
                    <asp:HyperLink ID="hypLnkPrint" ImageUrl="~/Images/printer.gif" ToolTip="Print" Target="ReportWindow" Visible="false"
                        runat="server" meta:resourcekey="hypLnkPrintResource1"></asp:HyperLink>
                    <b id="printText" runat="server">
                        <asp:Label ID="lblPrintExportExcel" runat="server" Text="Print Report" meta:resourcekey="lblPrintExportExcelResource2" Visible="false"></asp:Label>
                    </b>&nbsp;&nbsp;
                    <asp:ImageButton ID="btnPrint" runat="server" Visible="False" ImageUrl="~/Images/printer.gif"
                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                </td>
            </tr>
            <tr>
                <td runat="server" id="tdprintContent" colspan="2">
                    <table id="orgHeaderTab" runat="server" class="w-100p">
                        <tr>
                            <td id="orgHeaderTextForReport" colspan="2" class="a-center bold font12" runat="server"
                                style="color: #000000;">
                            </td>
                        </tr>
                        <tr>
                            <td id="dateTextForReport" class="a-left font12" runat="server" style="color: #000000;
                                padding-top: 20px;">
                            </td>
                            <td class="a-right font12 bold" runat="server" style="color: #000000; padding-top: 20px;">
                                <div id="divPrintExcel" runat="server" style="display: block;">
                                    <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                                                                    <div>
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvDoctorWiseReport" runat="server" AutoGenerateColumns="False"
                                                                                        meta:resourcekey="gvDoctorWiseReportResource1" CssClass="w-100p gridView">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Department Name" meta:resourcekey="TemplateFieldResource1">
                                                                                                <ItemTemplate>
                                                                                                    <div class="a-center">
                                                                                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lblDepartmentNameResource1"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle ForeColor="Black" />
                                                                                                <ItemStyle ForeColor="Black" Width="14%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Number Of Investigation" meta:resourcekey="TemplateFieldResource2">
                                                                                                <ItemTemplate>
                                                                                                    <div style="text-align: center;">
                                                                                                        <asp:Label ID="lblNumberOfItem" runat="server" HeaderStyle-ForeColor="#000000" ItemStyle-ForeColor="#000000"
                                                                                                            Text='<%# Bind("NumberOfItem") %>' meta:resourcekey="lblNumberOfItemResource1"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle ForeColor="Black" />
                                                                                                <ItemStyle Width="14%" ForeColor="Black" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Number Of Cases" meta:resourcekey="TemplateFieldResource3">
                                                                                                <ItemTemplate>
                                                                                                    <div class="a-center">
                                                                                                        <asp:Label ID="lblPatientCount" runat="server" Text='<%# Bind("PatientCount") %>'
                                                                                                            meta:resourcekey="lblPatientCountResource1"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle ForeColor="Black" />
                                                                                                <ItemStyle Width="14%" ForeColor="Black" />
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="4" DataKeyNames="BillID" ForeColor="#333333" GridLines="None" PagerSettings-Mode="NextPrevious"
                                        PageSize="5" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                        HeaderStyle-BorderWidth="0px" meta:resourcekey="grdResultResource1" CssClass="w-99p gridView">
                                        <PagerTemplate>
                                            <tr>
                                                <td align="center" colspan="6">
                                                    <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                        meta:resourcekey="lnkPrevResource2" />
                                                    <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                        meta:resourcekey="lnkNextResource2" />
                                                </td>
                                            </tr>
                                        </PagerTemplate>
                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <table class="dataheaderInvCtrl w-99p">
                                                        <tr>
                                                            <td>
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td>
                                                                            <table class="w-100p">
                                                                                <tr class="Duecolor">
                                                                                    <td class="a-left w-10p">
                                                                                        <asp:Label ID="lblBillNo" runat="server" Text="Bill No:" 
                                                                                            meta:resourcekey="lblBillNoResource2"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem, "BillNumber")%>
                                                                                        &nbsp;&nbsp;
                                                                                        <%# DataBinder.Eval(Container.DataItem,"IsCredit") %>
                                                                                    </td>
                                                                                    <td class="a-left w-5p">
                                                                                        <asp:Label ID="lblDate" runat="server" Text="Date:" 
                                                                                            meta:resourcekey="lblDateResource4"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left w-30p">
                                                                                        <%#  DataBinder.Eval(Container.DataItem,"BillDate") %>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="color: #000000;">
                                                                                    <td class="a-left w-10p">
                                                                                        <asp:Label ID="lblName" runat="server" Text="Name:" 
                                                                                            meta:resourcekey="lblNameResource3"></asp:Label> 
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"Name") %>
                                                                                    </td>
                                                                                    <td class="a-left w-5p">
                                                                                        <asp:Label ID="lblAge" runat="server" Text="Age:" 
                                                                                            meta:resourcekey="lblAgeResource2"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left w-30p">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"Age") %>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table class="w-100p">
                                                                                <tr style="color: #000000;">
                                                                                    <td class="a-left w-15p">
                                                                                        <asp:Label ID="lblDrName" runat="server" Text="Dr Name:" 
                                                                                            meta:resourcekey="lblDrNameResource2"></asp:Label> 
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"ReferingPhysicianName") %>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="color: #000000;">
                                                                                    <td class="a-left w-15p">
                                                                                        <asp:Label ID="lblHospitalBranch" runat="server" Text="Hospital/Branch:" 
                                                                                            meta:resourcekey="lblHospitalBranchResource2"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"HospitalName") %>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="color: #000000;">
                                                                                    <td class="a-left w-18p">
                                                                                        <asp:Label ID="lblCollectionCentre" runat="server" Text="Collection Centre:" 
                                                                                            meta:resourcekey="lblCollectionCentreResource2"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"CollectionCentreName") %>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                PageSize="100" ForeColor="Black" GridLines="None" CssClass="w-99p gridView" meta:resourcekey="grdChildResultResource1">
                                                                                <PagerTemplate>
                                                                                    <tr>
                                                                                        <td class="a-center" colspan="6">
                                                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                                                meta:resourcekey="lnkPrevResource1" />
                                                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                                                meta:resourcekey="lnkNextResource1" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </PagerTemplate>
                                                                                <HeaderStyle Font-Underline="True" />
                                                                                <RowStyle Font-Bold="False" />
                                                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="ItemName" HeaderText="Name" meta:resourcekey="BoundFieldResource1">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left" Width="18%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Quantity" HeaderText="Qty" meta:resourcekey="BoundFieldResource2">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Rate" HeaderText="Rate" meta:resourcekey="BoundFieldResource3">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" HeaderText="Amount"
                                                                                        meta:resourcekey="BoundFieldResource4">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table class="w-100p">
                                                                                <tr style="color: #000000;">
                                                                                    <td class="a-right w-80p">
                                                                                        <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount:" 
                                                                                            meta:resourcekey="lblTotalAmountResource4"></asp:Label> 
                                                                                    </td>
                                                                                    <td class="a-right h-25 paddingR10">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"GrossAmount","{0:0.00}") %>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                    </asp:GridView>
                                    <table class="w-100p">
                                        <%--<tr Class="Duecolor">
                                            <td align="center" style="width: 25%;">
                                                Department Name
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Date
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Number Of Items
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Amount
                                            </td>
                                        </tr>--%>
                                        <tr class="v-top">
                                            <td colspan="4" class="v-top">
                                                <table id="deptwiseCollectionTab" visible="false" runat="server"
                                                    class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView Visible="False" ID="grdCollection" runat="server" AllowPaging="True"
                                                                AutoGenerateColumns="False" CellPadding="0" DataKeyNames="BillID" ForeColor="#333333"
                                                                GridLines="None" PagerSettings-Mode="NextPrevious" CssClass="w-100p gridView" PageSize="30"
                                                                OnRowDataBound="grdCollection_RowDataBound" OnPageIndexChanging="grdCollection_PageIndexChanging"
                                                                meta:resourcekey="grdCollectionResource1">
                                                                <Columns>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                                                                        <HeaderTemplate>
                                                                            <table class="w-100p">
                                                                                <tr class="Duecolor">
                                                                                    <td class="a-center w-25p">
                                                                                        <asp:Label ID="lblDepartmentName" runat="server" Text="Department Name" 
                                                                                            meta:resourcekey="lblDepartmentNameResource3"></asp:Label> 
                                                                                    </td>
                                                                                    <td class="a-center w-25p">
                                                                                        <asp:Label ID="lblDate" runat="server" Text="Date" 
                                                                                            meta:resourcekey="lblDateResource3"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-center w-25p">                                                                                        <asp:Label ID="lblNumberItems" runat="server" Text="Number Of Items" 
                                                                                            meta:resourcekey="lblNumberItemsResource2"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-center w-25p">
                                                                                        <asp:Label ID="lblAmount" runat="server" Text="Amount" 
                                                                                            meta:resourcekey="lblAmountResource2"></asp:Label> 
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <table class="dataheaderInvCtrl w-100p">
                                                                                <tr>
                                                                                    <td class="v-top">
                                                                                        <asp:GridView ID="grdCollectionDetail" runat="server" AutoGenerateColumns="False"
                                                                                            CellPadding="0" PageSize="100" ForeColor="Black" EmptyDataText="DepartmentWise Lab Data not Available for current Date(S)"
                                                                                            GridLines="None" CssClass="w-100p gridView" meta:resourcekey="grdCollectionDetailResource1">
                                                                                            <EmptyDataRowStyle Font-Bold="True" HorizontalAlign="Center" />
                                                                                            <RowStyle Font-Bold="False" VerticalAlign="Top" />
                                                                                            <Columns>
                                                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource5">
                                                                                                    <HeaderTemplate>
                                                                                                        <asp:Label ID="LBL" runat="server" Visible="False" meta:resourcekey="LBLResource1"></asp:Label>
                                                                                                    </HeaderTemplate>
                                                                                                    <ItemTemplate>
                                                                                                        <table class="w-100p">
                                                                                                            <tr>
                                                                                                                <td class="a-center w-25p">
                                                                                                                    <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                                                                                                </td>
                                                                                                                <td class="a-center w-25p">
                                                                                                                    <%# DataBinder.Eval(Container.DataItem, "BillDate","{0:dd/MM/yyyy}")%>
                                                                                                                </td>
                                                                                                                <td class="a-center w-25p">
                                                                                                                    <%# DataBinder.Eval(Container.DataItem, "NumberOfItem")%>
                                                                                                                </td>
                                                                                                                <td class="a-right w-25p">
                                                                                                                    <%# DataBinder.Eval(Container.DataItem, "GrossAmount")%>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <table class="w-100p">
                                                                                            <tr style="color: #000000;" class="bold">
                                                                                                <td class="a-left w-75p paddingR0">
                                                                                                    &nbsp;
                                                                                                </td>
                                                                                                <td class="a-right w-25p">
                                                                                                    <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount :" 
                                                                                                        meta:resourcekey="lblTotalAmountResource3"></asp:Label>
                                                                                                    <%# DataBinder.Eval(Container.DataItem,"GrossAmount","{0:0.00}") %>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            <asp:Label runat="server" ID="lblForter" Visible="False" meta:resourcekey="lblForterResource1"></asp:Label>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerTemplate>
                                                                    <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                        CommandName="Page" ImageUrl="~/Images/previousimage.png" Width="18px" meta:resourcekey="lnkPrevResource3" />
                                                                    <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                        CommandName="Page" ImageUrl="~/Images/nextimage.png" Width="18px" meta:resourcekey="lnkNextResource3" />
                                                                </PagerTemplate>
                                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Table CssClass="dataheaderInvCtrl w-100p" CellPadding="4" Visible="False" Style="color: #000000;
                                        border-width: 1px; font-weight: normal;" CellSpacing="0" BorderWidth="0px"
                                        runat="server" ID="consumableTab" meta:resourcekey="consumableTabResource1">
                                    </asp:Table>
                                    <table border="0" id="miscellaneousTotalTab" runat="server" visible="false" class="dataheaderInvCtrl w-100p" style="color: #000000;">
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblMiscellaneousTotal1" runat="server" 
                                                    Text="Miscellaneous Total:" meta:resourcekey="lblMiscellaneousTotal1Resource1"></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <label id="lblMiscellaneousTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" id="individualDeptCollectionTab" runat="server" visible="false"
                                        class="dataheaderInvCtrl w-100p" cellpadding="5" style="color: #000000;">
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalCollectionDepartments" runat="server" 
                                                    Text="Total Collection Of Departments:" 
                                                    meta:resourcekey="lblTotalCollectionDepartmentsResource1"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblIndividualDeptCollection" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" id="combinedDeptCollectionTab" runat="server" visible="false" class="dataheaderInvCtrl w-100p" style="color: #000000;">
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalCollectionOfGroups" runat="server" 
                                                    Text="Total Collection Of Groups & Packages:" 
                                                    meta:resourcekey="lblTotalCollectionOfGroupsResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblCombinedDeptCollection" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tabGranTotal1" runat="server" visible="false" class="w-100p">
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblGrandTotal1" runat="server" Text="Grand Total:" meta:resourcekey="lblGrandTotalResource2" 
                                                    ></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblGrandTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tabGranTotal2" runat="server" visible="false" class="w-100p">
                                        <tr>
                                            <td colspan="2" class="a-right">
                                                ----------------
                                             </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalCollectionAmount" runat="server" 
                                                    Text="Total Collection Amount:" 
                                                    meta:resourcekey="lblTotalCollectionAmountResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblCollectionAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalDiscount" runat="server" Text="Total Discount Amount:" 
                                                    meta:resourcekey="lblTotalDiscountResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblDiscountAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalDueAmt" runat="server" Text="Total Due Amount:" 
                                                    meta:resourcekey="lblTotalDueAmtResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblDueAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-right">
                                                ----------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalCashAmt" runat="server" Text="Total Cash Amount:" 
                                                    meta:resourcekey="lblTotalCashAmtResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblCashAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblTotalDuePaidAmt" runat="server" Text="Total Due Paid Amount:" 
                                                    meta:resourcekey="lblTotalDuePaidAmtResource2"></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblDuePaidAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-right">
                                                ----------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-80p">
                                                <asp:Label ID="lblGrandTotalAmount1" runat="server" Text="Grand Total Amount:" meta:resourcekey="lblGrandTotalAmountResource2" 
                                                    ></asp:Label>
                                            </td>
                                            <td class="a-right" style="padding-right: 15px;">
                                                <label id="lblGrandTotalAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-right">
                                                ----------------
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="w-100p"
                                        runat="server" style="display: none;" id="tblDoctorWisereport">
                                        <tr class="Duecolor">
                                            <td class="a-left">
                                                <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                <asp:Label ID="lblDoctorName" runat="server" meta:resourcekey="lblDoctorNameResource1"></asp:Label><%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lblId" runat="server"></asp:Label>
                                                <asp:Label ID="lblHospitalId" runat="server"></asp:Label>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="w-100p" runat="server" id="tblAllDoctorsReport"
                                        style="display: table;">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdDoctorsResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    DataKeyNames="ReferingPhysicianID" GridLines="None" CssClass="w-100p gridView" OnRowDataBound="grdDoctorsResult_RowDataBound"
                                                    HeaderStyle-BorderWidth="0px" OnPageIndexChanging="grdDoctorsResult_PageIndexChanging"
                                                    meta:resourcekey="grdDoctorsResultResource1">
                                                    <PagerTemplate>
                                                        <tr>
                                                            <td class="a-center" colspan="6">
                                                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                    meta:resourcekey="lnkPrevResource4" />
                                                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                    meta:resourcekey="lnkNextResource4" />
                                                            </td>
                                                        </tr>
                                                    </PagerTemplate>
                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                    <Columns>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource10">
                                                            <ItemTemplate>
                                                                <table class="dataheaderInvCtrl w-100p">
                                                                    <tr>
                                                                        <td>
                                                                            <table class="w-100p">
                                                                                <tr class="Duecolor">
                                                                                    <td class="a-left">
                                                                                        <%# DataBinder.Eval(Container.DataItem,"HeaderName") %>
                                                                                    </td>
                                                                                    <td class="a-left" style="display: none;">
                                                                                        <%# DataBinder.Eval(Container.DataItem, "ID")%>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="gvChildDoctorsResult" CssClass="w-100p gridView" runat="server" AutoGenerateColumns="False"
                                                                                meta:resourcekey="gvChildDoctorsResultResource1">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Department Name" meta:resourcekey="TemplateFieldResource7">
                                                                                        <ItemTemplate>
                                                                                            <div class="a-center">
                                                                                                <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lblDepartmentNameResource2"></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle ForeColor="Black" />
                                                                                        <ItemStyle Width="14%" ForeColor="Black" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Number Of Investigation" meta:resourcekey="TemplateFieldResource8">
                                                                                        <ItemTemplate>
                                                                                            <div style="text-align: center;">
                                                                                                <asp:Label ID="lblNumberOfItem" runat="server" Text='<%# Bind("NumberOfItem") %>'
                                                                                                    meta:resourcekey="lblNumberOfItemResource2"></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle ForeColor="Black" />
                                                                                        <ItemStyle Width="14%" ForeColor="Black" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Number Of Cases" meta:resourcekey="TemplateFieldResource9">
                                                                                        <ItemTemplate>
                                                                                            <div style="text-align: center;">
                                                                                                <asp:Label ID="lblPatientCount" runat="server" Text='<%# Bind("PatientCount") %>'
                                                                                                    meta:resourcekey="lblPatientCountResource2"></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle ForeColor="Black" />
                                                                                        <ItemStyle Width="14%" ForeColor="Black" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />              
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
  <%--   <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>
</body>
</html>
