<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestInvestigation.aspx.cs"
    EnableEventValidation="false" Inherits="Admin_TestInvestigation" meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/PackageProfileControl1.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/ManageInvestigation.ascx" TagName="ManageInvestigation"
    TagPrefix="ucM" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link rel="Stylesheet" type="text/css">
        <style>
            .odd
            {
                background-color: white;
            }
            .even
            {
                background-color: #2c88b1;
            }
            #txtmas
            {
                width: 95px;
            }
            #txtmap
            {
                width: 90px;
            }
        </style>
    </link>     --%>
    <%-- <script src="../Scripts/Common.js" type="text/javascript"></script>
        <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/JsonScript.js"> </script>

    <%-- <script type="text/javascript" src="../Scripts/jquery-1.2.2.pack.js"> </script>--%>

    <script type="text/javascript" language="">

        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Select the department');
                return false;
            }

            return true;
        }




        //  $("#__tab_TabContainer1_Sequencetab").click(function() {alert('Handler for .click() called.');} );
        function SelectInvSeqRowCommon(rid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
        }

        function count(i, com) {
            if (document.getElementById('HdnRadio').value == -1) {
                var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_14");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert("select the row you want to move");
                    return false;
                }
            }

            else {

                var temp1, temp2, temp3;
                if (com == 1) {
                    if (i == document.getElementById('HdnRadio').value) {
                        var table = document.getElementById('TableData');
                        if (i != 0) {
                            temp2 = table.rows[i].cells[1].innerHTML; temp1 = table.rows[i].cells[6].innerHTML;
                            table.rows[i].cells[1].innerHTML = table.rows[i + 1].cells[1].innerHTML;
                            table.rows[i].cells[6].innerHTML = table.rows[i + 1].cells[6].innerHTML;
                            table.rows[i + 1].cells[1].innerHTML = temp2; table.rows[i + 1].cells[6].innerHTML = temp1;
                        }
                    }

                }
                else if (com == 2) {

                    if (i == document.getElementById('HdnRadio').value) {
                        var table = document.getElementById('TableData');
                        var l = table.rows.length;
                        var j = i + 1;
                        var l1 = l - 1;
                        if (j != l1) {
                            temp2 = table.rows[i + 1].cells[1].innerHTML; temp1 = table.rows[i + 1].cells[6].innerHTML;
                            table.rows[i + 1].cells[1].innerHTML = table.rows[i + 2].cells[1].innerHTML;
                            table.rows[i + 1].cells[6].innerHTML = table.rows[i + 2].cells[6].innerHTML;
                            table.rows[i + 2].cells[1].innerHTML = temp2; table.rows[i + 2].cells[6].innerHTML = temp1;
                        }
                    }
                }
                else if (com == 3) {
                    if (i != document.getElementById('HdnRadio').value) {
                        var table = document.getElementById('TableData');
                        var j = parseInt(document.getElementById('HdnRadio').value);
                        if (i < j) {
                            for (i1 = (j - 1); i1 >= i; i1--) {
                                temp2 = table.rows[i1 + 1].cells[1].innerHTML; temp1 = table.rows[i1 + 1].cells[6].innerHTML;
                                table.rows[i1 + 1].cells[1].innerHTML = table.rows[i1 + 2].cells[1].innerHTML;
                                table.rows[i1 + 1].cells[6].innerHTML = table.rows[i1 + 2].cells[6].innerHTML;
                                table.rows[i1 + 2].cells[1].innerHTML = temp2; table.rows[i1 + 2].cells[6].innerHTML = temp1;
                            }
                        }
                        else if (j < i) {
                            for (i1 = j; i1 < i; i1++) {
                                temp2 = table.rows[i1 + 1].cells[1].innerHTML; temp1 = table.rows[i1 + 1].cells[6].innerHTML;
                                table.rows[i1 + 1].cells[1].innerHTML = table.rows[i1 + 2].cells[1].innerHTML;
                                table.rows[i1 + 1].cells[6].innerHTML = table.rows[i1 + 2].cells[6].innerHTML;
                                table.rows[i1 + 2].cells[1].innerHTML = temp2; table.rows[i1 + 2].cells[6].innerHTML = temp1;
                            }
                        }
                    }
                }
                var cnt = 0;
                cnt = cnt + 1;
                document.getElementById('HdnCount').value = cnt;
                var e = document.getElementById('TabContainer1_Sequencetab_ddldptname');
                document.getElementById('HdnSelected').value = e.options[e.selectedIndex].text;
                var table = document.getElementById('TableData');
                document.getElementById('HdnPreviousData').value = document.getElementById('TableData');
                //            var i;
                //            for(i=1;i<table.rows.length;i++)
                //            {
                //              data=data+table.rows[i].cells[1].innerHTML+"^"+table.rows[i].cells[5].innerHTML+"^"+table.rows[i].cells[6].innerHTML+"~";
                //            }
            }
        }
        function radioindex(i) {
            document.getElementById('HdnRadio').value = i;
        }
        function bindlist(id) {
            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('TabContainer1_tab1_HdnDept').value;
                var hdnload = document.getElementById('TabContainer1_tab1_HdnLoaddata').value;
                var list = hdn.split('^');
                var count = 0;
                var hdndept = document.getElementById('TabContainer1_tab1_HdnCntDept').value;
                if (hdn != "") {
                    var hdndept = hdndept + hdn + "$";
                    document.getElementById('TabContainer1_tab1_HdnCntDept').value = hdndept;
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                }
            }
        }
        function bind(id) {
            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('TabContainer1_tab1_Hdnheader').value;
                var hdnhead = document.getElementById('TabContainer1_tab1_HdnCntHeader').value;
                if (hdn != "") {
                    var hdnhead = hdnhead + hdn + "$";
                    document.getElementById('TabContainer1_tab1_HdnCntHeader').value = hdnhead;
                    var list = hdn.split('^');
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                }
            }
        }
        function validateinves() {
            var hdn = document.getElementById('TabContainer1_mappingtab_HdnDeptvalid').value;
            var basegrid = document.getElementById('TabContainer1_mappingtab_grdResult');
            if (basegrid != null) {
                var grid = document.getElementById('TabContainer1_mappingtab_grdResult').rows.length;
                var btn = document.getElementById('TabContainer1_mappingtab_btnSave').value;
                var hdnupdate = document.getElementById('TabContainer1_mappingtab_HdnUpdateDept').value;
                var list = hdn.split('^');

                for (var j = 0; j < list.length - 1; j++) {
                    var value = list[j].split('~');
                    if ((j < grid - 1) && (document.getElementById(value[3]).checked == true)) {
                        if ((document.getElementById(value[0]).selectedIndex >= 0) && (document.getElementById(value[1]).selectedIndex >= 0)) {
                            //var ddlde = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex];
                            var ddldept = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex].text;
                            //var ddldeptdup=document.getElementById(value[0]);
                            var ddldeptvalue = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex].value;
                            var ddlhead = document.getElementById(value[1]).options[document.getElementById(value[1]).selectedIndex].text;
                            //var ddlheaddup = document.getElementById(value[1]);
                            var ddlheadvalue = document.getElementById(value[1]).options[document.getElementById(value[1]).selectedIndex].value;
                            var lblinv = document.getElementById(value[2]).value;
                            //                            if (ddldept == "--Select--") {
                            //                                alert('Select the Department Name');
                            //                                return false;
                            //                            }
                            //                            if (ddlhead == "--Select--") {
                            //                                alert('Select the Header Name');
                            //                                return false;
                            //                            }
                            if (((ddldeptvalue != 0) && (ddlheadvalue == 0)) || ((ddldeptvalue == 0) && (ddlheadvalue != 0))) {
                                var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_15");
                                if (userMsg != null) {
                                    alert(userMsg);
                                    return false;
                                }
                                else {
                                    alert("Select both Department and Header");
                                    return false;
                                }
                                //return false;
                            }
                            else if ((ddldept != "Select") && (ddlhead != "Select")) {
                                hdnupdate += lblinv + "~" + ddldeptvalue + "~" + ddlheadvalue + "^";
                                document.getElementById('TabContainer1_mappingtab_HdnUpdateDept').value = hdnupdate;

                            }
                        }
                    }
                    //                    else {
                    //                        alert('No Records to save');
                    //                    }
                }
            }
            return true;
        }
        function call() {
            var StrDispSel = SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") : "--Select--";
            if (document.getElementById('HdnCount').value == "0") {
                GetNames();

            }
            else {
                var i;
                var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_19");
                if (userMsg != null) {
                    i = confirm(userMsg);
                    // return false;
                }
                else {
                    i = confirm('Changes not saved.Do you want to continue without saving?');
                }
                // i = confirm('Changes not saved.Do you want to continue without saving?');
                if (i == true) {
                    document.getElementById('HdnCount').value = "0";
                    GetNames();
                }
                else {
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
                    //$("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Select Department", "-1");
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option(StrDispSel, "-1");
                    if ($("#HdnDepts").val() != "") {
                        var dept1 = $("#HdnDepts").val().split("~");
                        for (var count = 0; count < dept1.length; count++) {
                            var dept2 = dept1[count].split('?');
                            $("#TabContainer1_Sequencetab_ddldptname").get(0).options[$("#TabContainer1_Sequencetab_ddldptname").get(0).options.length] = new Option(dept2[0], dept2[1]);
                        }
                        $("#TabContainer1_Sequencetab_ddldptname").val(document.getElementById('HdnSelected').value).attr("selected", "selected");

                    }
                    document.getElementById('TableData') = document.getElementById('HdnPreviousData').value;
                }
            }
        }
        function select(chkid) {
            document.getElementById(chkid).checked = true;
        }


        //        $(document).ready(function() {
        //            $.ajax({
        //                type: "POST",
        //                url: "../WebService.asmx/loaddropdown",
        //                data: "{}",
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                success: function(msg) {
        //                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
        //                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Select Department", "-1");

        //                    $.each(msg.d, function(index, item) {
        //                        $("#TabContainer1_Sequencetab_ddldptname").get(0).options[$("#TabContainer1_Sequencetab_ddldptname").get(0).options.length] = new Option(item.DeptName, item.DeptID);
        //                    });

        //                                        $("#ddldptname").bind("change", function() {
        //                                            GetNames($(this).val());
        //                                        });
        //                },
        //                error: function() {
        //                    alert("Failed to load Departments");
        //                }
        //            });
        //        });
        function saveTable() {
            var StrDispSel = SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") : "--Select--";
var alertmessage = SListForAppMsg.Get('Admin_TestInvestigation_aspx_0019') == null ? "Changes saved successfully" : SListForAppMsg.Get('Admin_TestInvestigation_aspx_0019');
            var alert = SListForAppMsg.Get('Admin_TestInvestigation_aspx_0078') == null ? "Alert" : SListForAppMsg.Get('Admin_TestInvestigation_aspx_0078');
            var data = '';
            var deptID = document.getElementById('TabContainer1_Sequencetab_ddldptname').options[document.getElementById('TabContainer1_Sequencetab_ddldptname').selectedIndex].value;
            var table = document.getElementById('TableData');
            var i;
            for (i = 1; i < table.rows.length; i++) {
                data = data + table.rows[i].cells[1].innerHTML + "^" + table.rows[i].cells[5].innerHTML + "^" + table.rows[i].cells[6].innerHTML + "~";
            }
            data = JSON.stringify(data);
            var OrgID = document.getElementById('HdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveSequence",
                data: "{data:" + data + ",deptID:" + deptID + ",OrgID:" + OrgID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_7");
                    if (userMsg != null) {
                        alert(userMsg);
                        // return false;
                    }
                    else {
                        ValidationWindow(alertmessage, alert);
                       // alert("Changes saved successfully");
                        //return false;
                    }

                    $("#HdnCount").val(0);
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
                    //$("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Select Department", "-1");
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option(StrDispSel, "-1");
                    
                    if ($("#HdnDepts").val() != "") {
                        var dept1 = $("#HdnDepts").val().split("~");
                        for (var count = 0; count < dept1.length; count++) {
                            var dept2 = dept1[count].split('?');
                            $("#TabContainer1_Sequencetab_ddldptname").get(0).options[$("#TabContainer1_Sequencetab_ddldptname").get(0).options.length] = new Option(dept2[0], dept2[1]);
                        }
                        //$("#TabContainer1_Sequencetab_ddldptname").val(deptID).prop("selected", true);
                        $("#TabContainer1_Sequencetab_ddldptname").val(deptID).prop("selected", true);
                        //GetNames($(this).val());
                        GetNames();

                    }

                },
                error: function() {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_16");
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert("Failed to save details");
                        return false;
                    }

                }
            });
        }

        function Loadddl() {
            var StrDispSel = SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") : "--Select--";
            var OrgID = document.getElementById('HdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/loaddropdown",
                data: "{OrgID:" + OrgID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
                    //$("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Select Department", "-1");
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option(StrDispSel, "-1");

                    $.each(msg.d, function(index, item) {
                        $("#TabContainer1_Sequencetab_ddldptname").get(0).options[$("#TabContainer1_Sequencetab_ddldptname").get(0).options.length] = new Option(item.DeptName, item.DeptID);
                        $("#HdnDepts").val($("#HdnDepts").val() + item.DeptName + "?" + item.DeptID + "~");
                    });

                    $("#ddldptname").bind("change", function() {
                        GetNames($(this).val());
                    });
                },
                error: function() {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_17");
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert("Failed to load Departments");
                        return false;
                    }

                }
            });


        }

        function GetNames() {
            var StrDispSel = SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_20") : "--Select--";
            //          if (deptID > 0) {
            ////                $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
            ////                $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Loading names", "-1"); 
            var deptID = document.getElementById('TabContainer1_Sequencetab_ddldptname').options[document.getElementById('TabContainer1_Sequencetab_ddldptname').selectedIndex].value;
            var deptName = document.getElementById('TabContainer1_Sequencetab_ddldptname').options[document.getElementById('TabContainer1_Sequencetab_ddldptname').selectedIndex].text;
            var OrgID = document.getElementById('HdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/getDeptData",
                data: "{deptID:" + deptID + ",OrgID:" + OrgID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    var _datainfo = $(data.d);
                    var up = 1;
                    var down = 2;
                    var move = 3;

                    $('#TabContainer1_Sequencetab_divtest').html("<table id='TableData'  cellpadding='1' cellspacing='1'  Border='1' Width='100%' height: 12%; margin-left: 0px; style='BackgroundColor:#ff6600;'><tr class='dataheader1'; width='10px' ><th>" + '' + "</th><th align='center'>" + s.thINVESTIGATIONNAME + "</th><th colspan='3' align='center'>" + s.thMOVE + "</th><th style='visibility: hidden;'>" + s.thSequenceNumber + "</th><th style='visibility: hidden;'>" + s.thInvestigationID + "</th></tr></table>");
                    $('#savetable').css('display', 'table');
                    //$('#TableData').css('border','1px solid black');

                    for (var i = 0; i < _datainfo.length; i++) {
                        //                                   var row = document.createElement("tr");
                        //                                   var SequenceNo = document.createElement();
                        //                                   var InvestigationID = document.createElement();
                        //                                   var InvestigationName = document.createElement();
                        //                                   SequenceNo.innerHTML = _datainfo[i].SequenceNo;
                        //                                   InvestigationID.innerHTML = _datainfo[i].InvestigationID;
                        //                                   InvestigationName.innerHTML = _datainfo[i].InvestigationName;
                        //                                   row.appendChild(SequenceNo);
                        //                                   row.appendChild(InvestigationID);
                        //                                   row.appendChild(InvestigationName);
                        $('#TableData').append("<tr><td>" + '<input type="Radio" name="radio1" id="rdsequence"  onclick="javascript:radioindex(' + i + ',this);" runat="server"/>' + "</td><td>" + _datainfo[i].InvestigationName + "</td><td>" + '<input type="Button" ID="btnUp" Value="<%#Resources.ClientSideDisplayTexts.Admin_TestInvestigation_UP%>" runat="server" OnClick="javascript:count(' + i + ',' + up + ');" CommandName="UP" style="BACKGROUND-IMAGE: url(../Images/UpArrow.png); HEIGHT: 17px; WIDTH: 17px;border-width:0px;" />' + "</td><td>" + '<input type="Button" ID="btnDown" Value="<%#Resources.ClientSideDisplayTexts.Admin_TestInvestigation_Down%>" runat="server" OnClick="javascript:count(' + i + ',' + down + ');" CommandName="DOWN" style="BACKGROUND-IMAGE: url(../Images/DownArrow.png); HEIGHT: 17px; WIDTH: 17px;border-width:0px;"  />' + "</td><td>" + '<input type="Button" Value="' + s.move + '" id="btnMove" runat="server"  OnClick="javascript:count(' + i + ',' + move + ');"  CommandName="MOVE" class="btn" />' + "</td><td style='visibility: hidden;'>" + _datainfo[i].SequenceNo +

                                            "</td ><td style='visibility: hidden;'>" + _datainfo[i].InvestigationID + "</td></tr>");
                        //                                   $("#TabContainer1_Sequencetab_gvReckon").append("<tr><td>" + _datainfo[i].SequenceNo +
                        //                                            "</td><td>" + _datainfo[i].InvestigationID + "</td></tr>");

                        //$("#TabContainer1_Sequencetab_gvReckon").append(row);
                        //$("#TabContainer1_Sequencetab_gvReckon").style.display = 'block';

                        //                                   $("#TabContainer1_Sequencetab_gvReckon").append("<tr><td>" + data.d[i].SequenceNo +
                        //                                            "</td><td>" + data.d[i].InvestigationID + 
                        //                                            "</td><td>" + data.d[i].InvestigationName + "</td></tr>");
                    }
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options.length = 0;
                    //$("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option("Select Department", "-1");
                    $("#TabContainer1_Sequencetab_ddldptname").get(0).options[0] = new Option(StrDispSel, "-1");
                    if ($("#HdnDepts").val() != "") {
                        var dept1 = $("#HdnDepts").val().split("~");
                        for (var count = 0; count < dept1.length; count++) {
                            var dept2 = dept1[count].split('?');
                            $("#TabContainer1_Sequencetab_ddldptname").get(0).options[$("#TabContainer1_Sequencetab_ddldptname").get(0).options.length] = new Option(dept2[0], dept2[1]);
                        }
                        
                        //changed by arivalagan.kk//
                        $("#TabContainer1_Sequencetab_ddldptname").val(deptID).prop("selected", true);

                    }
                },
                error: function() {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TestInvestigation.aspx.cs_18");
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert("Failed to load names");
                        return false;
                    }

                }
            });
            // Loadddl()
            //}
            //                    else {
            //                        $("#TabContainer1_Sequencetab_gvReckon").get(0).options.length = 0;
            //                    }
        } 
              
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script type="text/javascript" language="javascript">

        var s = { move: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_MoveHere%>', thINVESTIGATIONNAME: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_INVESTIGATIONNAME%>',
            thMOVE: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_MOVE%>',
            thSequenceNumber: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_SequenceNumber%>',
            hInvestigationID: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_InvestigationID%>',
            btnup: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_UP%>',
            btndown: '<%=Resources.ClientSideDisplayTexts.Admin_TestInvestigation_Down%>'
        };
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" id="tab">
        <table class="w-100p">
            <tr>
                <td>
                    <%--<asp:HiddenField ID="hdnid" runat="server" />--%>
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <ajc:TabContainer ID="TabContainer1" runat="server" OnActiveTabChanged="TabContainer1_ActiveTabChanged"
                                AutoPostBack="True" ActiveTabIndex="0" meta:resourcekey="TabContainer1Resource1">
                                <ajc:TabPanel ID="tab1" runat="server" HeaderText="Create New Package" meta:resourcekey="tab1Resource1">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAddInvestigation" runat="server" Text="Add Investigation" meta:resourcekey="lblAddInvestigationResource1"></asp:Label>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <asp:UpdatePanel ID="updpnl" runat="server">
                                            <ContentTemplate>
                                                <ucM:ManageInvestigation ID="ManageInvestigation" runat="server" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="mappingtab" runat="server" CssClass="dataheadergroup" HeaderText="Mapping Header and Department"
                                    Visible="false" meta:resourcekey="mappingtabResource1">
                                    <ContentTemplate>
                                        <table>
                                            <tr class="a-center w-12">
                                                <asp:Panel ID="pnl_search" runat="server" meta:resourcekey="pnl_searchResource1">
                                                    <td class="a-center h-20 w-50p" style="font-weight: normal; color: #000;">
                                                        <asp:Label ID="lblSearch" runat="server" Text="Enter Investigation to Search" meta:resourcekey="lblSearchResource1"></asp:Label>
                                                        <asp:TextBox ID="txtinvestigation" CssClass="small" runat="server" ToolTip="Investigation Name"
                                                            meta:resourcekey="txtinvestigationResource1"></asp:TextBox>
                                                        <asp:Button ID="btninves" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Style="cursor: pointer;" Text="Search"
                                                            ToolTip="Click here to Search the Investigation" OnClick="btninves_Click" meta:resourcekey="btninvesResource1" />
                                                        <asp:CheckBox ID="show" runat="server" Font-Bold="True" Text="Show All" AutoPostBack="True"
                                                            OnCheckedChanged="show_CheckedChanged" meta:resourcekey="showResource1" />
                                                    </td>
                                                </asp:Panel>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p m-auto"
                                                        EmptyDataText="No Investigation to Map Departement and Header" PageSize="15"
                                                        OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                        ForeColor="Black" AllowPaging="True" meta:resourcekey="grdResultResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.NO" Visible="False" meta:resourcekey="TemplateFieldResource1">
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Investigation Name" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblInvestigation" runat="server" Text='<%# bind("Investigationname") %>'
                                                                        meta:resourcekey="lblInvestigationResource1"></asp:Label>
                                                                    <asp:HiddenField ID="lblInvestigationId" runat="server" Value='<%# bind("Investigationid") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Department Name" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlDept" runat="server" CssClass="dropdownbutton ddlsmall"
                                                                        meta:resourcekey="ddlDeptResource1">
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Header Name" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlHeader" runat="server" CssClass="dropdownbutton ddlsmall"
                                                                        meta:resourcekey="ddlHeaderResource1">
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblnote" runat="server" Font-Size="X-Small" ForeColor="Red" Text="*"
                                                                        meta:resourcekey="lblnoteResource1"></asp:Label>
                                                                    <asp:CheckBox ID="chkselect" runat="server" meta:resourcekey="chkselectResource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerStyle Font-Bold="True" CssClass="dataheader1 a-center v-middle w-14" />
                                                        <HeaderStyle CssClass="dataheader1 w-14" />
                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=">>"
                                                            PageButtonCount="5" PreviousPageText="<<" />
                                                    </asp:GridView>
                                                    <asp:HiddenField ID="HdnDeptvalid" runat="server" />
                                                    <asp:HiddenField ID="HdnHeadvalid" runat="server" />
                                                    <asp:HiddenField ID="HdnLoad" runat="server" />
                                                    <asp:HiddenField ID="HdnUpdateDept" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center h-15">
                                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                        <ProgressTemplate>
                                                            <div id="progressBackgroundFilter" class="a-center">
                                                            </div>
                                                            <div id="processMessage" class="a-center w-20p">
                                                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                                    meta:resourcekey="img1Resource1" />
                                                            </div>
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </td>
                                            </tr>
                                            <tr class="a-center">
                                                <td>
                                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClientClick="javascript:return validateinves()"
                                                        Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                    <br />
                                                    <asp:Label ID="lblnote" runat="server" Font-Size="X-Small" ForeColor="Red" Text="*Select the checkbox to save the item"
                                                        meta:resourcekey="lblnoteResource2"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="Sequencetab" runat="server" CssClass="dataheadergroup" HeaderText="Sequence Number"
                                    meta:resourcekey="SequencetabResource1">
                                    <ContentTemplate>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lbldptname" Text="Select the Department Name" runat="server" Font-Bold="True"
                                                                Font-Size="Small" meta:resourcekey="lbldptnameResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-60p">
                                                            <asp:DropDownList ID="ddldptname" runat="server" CssClass="ddlsmall" onchange="javascript:call();"
                                                                meta:resourcekey="ddldptnameResource1">
                                                            </asp:DropDownList>
                                                            <%--<Height="24px" Width="151px">--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="divtest" class="a-left w-100p" style="overflow: scroll; height: 400px;"
                                                    runat="server">
                                                </div>
                                                <table id="savetable" style="display: none">
                                                    <tr id="Tr1" class="a-center w-100p">
                                                        <td>
                                                        </td>
                                                        <td id="Td1" class="a-center w-100p">
                                                            <asp:Button ID="Button1" runat="server" CssClass="w-100 btn" Font-Bold="True" Font-Size="Medium"
                                                                Text="Save" OnClientClick="javascript:saveTable()" meta:resourcekey="Button1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="gv" runat="server" style="overflow: scroll; display: none">
                                                    <asp:GridView ID="gvReckon" EmptyDataText="No matching records found " runat="server"
                                                        AutoGenerateColumns="False" CssClass="gridView w-100p m-auto" ForeColor="#333333"
                                                        CellPadding="3" OnRowDataBound="Gvbound" OnRowCommand="gvReckon_RowCommand" meta:resourcekey="gvReckonResource1">
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                                                                <ItemTemplate>
                                                                    <asp:RadioButton ID="rdbcheck" runat="server" meta:resourcekey="rdbcheckResource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="SequenceNo" Visible="False" DataField="SequenceNo" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField HeaderText="InvestigationID" Visible="False" DataField="InvestigationID"
                                                                meta:resourcekey="BoundFieldResource2" />
                                                            <asp:BoundField HeaderText="InvestigationName" DataField="InvestigationName" meta:resourcekey="BoundFieldResource3" />
                                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource7">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" OnClientClick="javascript:count();"
                                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="UP"
                                                                        meta:resourcekey="btnUpResource1" />
                                                                    <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" OnClientClick="javascript:count();"
                                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="DOWN"
                                                                        meta:resourcekey="btnDownResource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource8">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnmove" runat="server" CssClass="btn" Text="Move Here" CommandName="Move"
                                                                        OnClientClick="javascript:count();" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                        meta:resourcekey="btnmoveResource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="dataheader1" />
                                                    </asp:GridView>
                                                    <table class="w-100p" id="tprint" runat="server">
                                                        <tr id="Tr2" runat="server">
                                                            <td id="Td2" class="a-center" runat="server">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                            </ajc:TabContainer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="HdnCount" Value="0" runat="server" />
    <asp:HiddenField ID="HdnSelected" runat="server" />
    <asp:HiddenField ID="HdnRadio" Value="-1" runat="server" />
    <asp:HiddenField ID="HdnDepts" runat="server" />
    <asp:HiddenField ID="HdnOrgID" runat="server" />
    <asp:HiddenField ID="HdnPreviousData" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    //    document.getElementById('TabContainer1_tab1_hidID').value = 'TabContainer1_tab1_chklstGrp';
    //    document.getElementById('TabContainer1_tab1_hidMapID').value = 'TabContainer1_tab1_chkGrpMap';
    //    SetId(document.getElementById('TabContainer1_tab1_hidID').value);
    //    Set(document.getElementById('TabContainer1_tab1_hidMapID').value);
    $(document).ready(function() {
        //   $("#__tab_TabContainer1_Sequencetab").bind('click', function() {
        $("#__tab_TabContainer1_Sequencetab").click(function() {
            Loadddl();
            return false;
        });
    });
</script>

