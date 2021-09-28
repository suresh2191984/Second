<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoundManagement.aspx.cs"
    Inherits="Admin_RoundManagement" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Round Management</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

    <script type="text/javascript">

        function ExistRoundName() {

            var OrgID = document.getElementById('hdnOrgID').value;
            var RoundName = document.getElementById('txtRoundName').value;
            try {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/CheckRoundName",
                    data: JSON.stringify({ prefixText: RoundName, contextKey: OrgID }),
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        if (data.d[0] == '1') {
                            alert('Round name is already exists');
                            document.getElementById('txtRoundName').value = '';
                            document.getElementById('txtRoundName').focus();
                            return false;
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Unable to check round name");
                    }
                });
            }
            catch (e) {
                return false;
            }
        }

        function SetClientID(source, eventArgs) {

            var list = eventArgs.get_value().split('^');
            var slist = eventArgs.get_value().split('###');

            var ID = "0";
            if (list[5] != "") {
                ID = list[5];
            }
            document.getElementById('hdnClientId').value = ID;
            document.getElementById('txtClient').value = eventArgs.get_text();
        }

        function onRoundSelected() {
            var completionList = $find("AutoCompleteExtenderRoundName").get_completionList();
            completionList.style.width = '250';
        }
        var lstPreviousRoundDetails = [];
        function SetRoundID(source, eventArgs) {

            var list = eventArgs.get_value().split('~');
            var slist = eventArgs.get_value().split('###');

            var ID = "0";
            if (list[0] != "") {
                ID = list[0];
            }
            document.getElementById('hdnRoundId').value = ID;
            document.getElementById('txtSearchRoundName').value = eventArgs.get_text();

            if (ID > 0) {
                isRoundNameList = eventArgs.get_value().split('|')[0];

                var RoundName = eventArgs.get_text().split(':')[0];

                var StartTime = isRoundNameList.split('~')[1];
                var fhr = StartTime.split(':')[0];
                var fms = StartTime.split(':')[1].substr(0, 2);
                var fampm = StartTime.split(':')[1].substr(2, 3);

                var EndTime = isRoundNameList.split('~')[2];
                var thr = EndTime.split(':')[0];
                var tms = EndTime.split(':')[1].substr(0, 2);
                var tampm = EndTime.split(':')[1].substr(2, 3);

                var StartLocation = isRoundNameList.split('~')[3];

                var EndLocation = isRoundNameList.split('~')[4];
                var IsActive = isRoundNameList.split('~')[5];
                var RoundRepeatDays = isRoundNameList.split('~')[6];

                var Type = isRoundNameList.split('~')[7];
                var LogisticEmployee = isRoundNameList.split('~')[8];
                var RoundSheetTime = isRoundNameList.split('~')[9];
                var RoundSheetTime1 = isRoundNameList.split('~')[10];

                document.getElementById('txtRoundName').value = RoundName;
                if (document.getElementById('chkIsActive') != null) {
                    if (IsActive == 'T') {
                        document.getElementById('chkIsActive').checked = true;
                    }
                    else {
                        document.getElementById('chkIsActive').checked = false;
                    }
                }

                document.getElementById('txtFromTime1').value = fhr;
                document.getElementById('txtFromTime2').value = fms;
                document.getElementById('ddlFromTime').value = fampm;

                document.getElementById('txtToTime1').value = thr;
                document.getElementById('txtToTime2').value = tms;
                document.getElementById('ddlToTime').value = tampm;

                document.getElementById('txtStartLocation').value = StartLocation;
                document.getElementById('txtEndLocation').value = EndLocation;
                document.getElementById('txtLogistics').value = LogisticEmployee;

                document.getElementById('ddlTiming').value = RoundSheetTime;
                document.getElementById('ddlHrs').value = RoundSheetTime1;

                if (RoundRepeatDays != undefined) {
                    var LstRoundRepeatDays = RoundRepeatDays.split(",");
                    for (var i = 0; i < LstRoundRepeatDays.length; i++) {
                        var chkID = "chkDays_" + LstRoundRepeatDays[i];
                        document.getElementById(chkID).checked = true;
                    }
                }

                var OrgID = document.getElementById('hdnOrgID').value;
                var prefixText = '';
                sval = OrgID + '~' + ID;
                var lstPreviousRoundDetails = [];
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../OPIPBilling.asmx/GetRoundNameAttributes",
                    data: JSON.stringify({ prefixText: prefixText, contextKey: 'Attributes' + '~' + ID }),
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        $('#gvRound tbody tr:not(:first)').children().remove();
                        if (data.d.length > 0) {
                            var list = data.d;
                            if (list[0].length > 0) {
                                for (var i = 0; i < list[0].length; i++) {
                                    var ClientName = list[0][i].ClientName;
                                    var ClientId = list[0][i].ClinicID;
                                    var ID = list[0][i].ID;
                                    var SequenceNo = list[0][i].SequenceNo;
                                    var RoundID = list[0][i].RoundID;
                                    var EstimatedTime = list[0][i].EstimatedTime;
                                    $("#gvRound").append("<tr style='background-color:#F9B7FF;'><td><span id ='lblClientName'>" + ClientName + "</span></td><td><span id ='lblestimatedTime'>" + EstimatedTime + "</span></td><td style='display:none';><span id ='lblClientId'>" + ClientId + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td style='display:none';><span id ='lblRoundID'>" + RoundID + "</span></td><td><img alt='Up' src='../Images/UpArrow.png' id='btnUp' class='up' onclick=onMoveUp(this.id);>&nbsp;<img alt='Down' src='../Images/DownArrow.png' id='btnDown' class='down' onclick=onMoveDown(this.id);></td><td><img alt='Delete' src='../Images/Delete.jpg' id='btnDel' onclick='onDeleteRoundClient(this);'></td></tr>");
                                    $('#gvRound').css('visibility', 'visible');

                                    lstPreviousRoundDetails.push({
                                        ClinicID: ClientId,
                                        ID: ID,
                                        Type: "Client",
                                        SequenceNo: SequenceNo,
                                        RoundID: RoundID,
                                        EstimatedTime: EstimatedTime
                                    });
                                    if (lstPreviousRoundDetails.length > 0) {
                                        $('#hdnRoundValues').val(JSON.stringify(lstPreviousRoundDetails));
                                    }
                                }
                            }
                            document.getElementById('txtSearchRoundName').value = '';
                        }

                    },
                    error: function(result) {
                        alert("New Error");
                    }
                });
            }
        }


        var lstRoundNames = [];
        function CheckToAddData() {

            if (document.getElementById('txtRoundName').value == '') {
                alert('Please enter round name');
                document.getElementById('txtRoundName').focus();
                return false;
            }
            //            if (document.getElementById("chkIsActive").checked == false) {
            //                alert('Please check IsActive');
            //                document.getElementById('chkIsActive').focus();
            //                return false;
            //            }
            if (document.getElementById('txtStartLocation').value == '') {
                alert('Please enter start location');
                document.getElementById('txtStartLocation').focus();
                return false;
            }

            if (document.getElementById('txtEndLocation').value == '') {
                alert('Please enter end location');
                document.getElementById('txtEndLocation').focus();
                return false;
            }

            if (document.getElementById('txtLogistics').value == '') {
                alert('Please enter logistics Name');
                document.getElementById('txtLogistics').focus();
                return false;
            }

            if (document.getElementById('txtClient').value == '') {
                alert('Please select client name');
                document.getElementById('txtClient').focus();
                return false;
            }

            var Flag = '';
            var Confirm = '';
            var $row1 = "";
            var $rowSelected = "";
            var $firstRow = "";
            var flag1;
            var ClientId = document.getElementById('hdnClientId').value;
            var ClientName = document.getElementById('txtClient').value;
            var EstimatedTime = document.getElementById('txtEstimated').value;

            var ID = -1;

            var roundID = 0;

            if (Flag == '') {

                $('#gvRound tbody tr:not(:first)').each(function(i, n) {
                    var $row = $(n);
                    var ClientName1 = $row.find($('span[id$="lblClientName"]')).html();
                    if (ClientName1 == ClientName) {
                        alert("Already added ");
                        flag1 = "1";
                        return false;

                    }
                });
                if (ClientName != '' && flag1 != 1) {
                    // $('#gvRound tbody tr:not(:first)').children().remove();
                    var k = $("#gvRound tr").length;
                    //$("#gvRound").append("<th style='background-color:#F9B7FF;'><td><span id ='lblClientName'> ClientName </span></td><td style='display:none';><span id ='lblClientId'>ClientId</span></td><td>Seq No</td><td>Delete</td></th>");
                    $("#gvRound").append("<tr style='background-color:#F9B7FF;'><td><span id ='lblClientName'>" + ClientName + "</span></td><td><span id ='lblestimatedTime'>" + EstimatedTime + "</span></td><td style='display:none';><span id ='lblClientId'>" + ClientId + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td style='display:none';><span id ='lblRoundID'>" + roundID + "</span></td><td><img alt='Up' src='../Images/UpArrow.png' id='btnUp' class='up' onclick=onMoveUp(this.id);>&nbsp;<img alt='Down' src='../Images/DownArrow.png' id='btnDown' class='down' onclick=onMoveDown(this.id);></td><td><img alt='Delete' src='../Images/Delete.jpg' id='btnDel' onclick='onDeleteRoundClient(this);'></td></tr>");
                    $('#gvRound').css('visibility', 'visible');
                    document.getElementById('txtClient').value = '';
                    document.getElementById('txtEstimated').value = '';

                    //                    if (document.getElementById('hdnRoundValues').value == "") {
                    //                        document.getElementById('hdnRoundValues').value = ClientName;
                    //                    }
                    //                    else {
                    //                        document.getElementById('hdnRoundValues').value += "," + ClientName;
                    //                    }
                    //                    document.getElementById('txtClient').value = '';
                    //                    lstRoundNames.push({
                    //                        ClinicID: ClientId,
                    //                        ID: ID,
                    //                        Type: "Client",
                    //                        SequenceNo: "1",
                    //                        roundID:roundID
                    //                    });
                    //                    if (lstRoundNames.length > 0) {
                    //                        $('#hdnRoundValues').val(JSON.stringify(lstRoundNames));
                    //                    }
                }
                return false;
                document.getElementById('txtClient').value = '';
                document.getElementById('txtEstimated').value = '';
                document.getElementById('txtClient').focus();
                document.getElementById('txtClient').select();
            }
        }


        function chkToSaveData() {
            var lstRoundMasterAttributes = [];
            if (document.getElementById('txtRoundName').value == '') {
                alert('Please enter round name');
                document.getElementById('txtRoundName').focus();
                return false;
            }
            //            if (document.getElementById("chkIsActive").checked == false) {
            //                alert('Please check IsActive');
            //                document.getElementById('chkIsActive').focus();
            //                return false;
            //            }
            if (document.getElementById('txtStartLocation').value == '') {
                alert('Please enter start location');
                document.getElementById('txtStartLocation').focus();
                return false;
            }

            if (document.getElementById('txtEndLocation').value == '') {
                alert('Please enter end location');
                document.getElementById('txtEndLocation').focus();
                return false;
            }

            if (document.getElementById('txtLogistics').value == '') {
                alert('Please enter logistics Name');
                document.getElementById('txtLogistics').focus();
                return false;
            }
            lstRoundMasterAttributes.pop();
            $('#gvRound tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var ClientId = $row.find($('span[id$="lblClientId"]')).html();
                var ID = $row.find($('span[id$="lblID"]')).html();
                var RoundID = $row.find($('span[id$="lblRoundID"]')).html();
                if (RoundID == undefined || RoundID == '0' || RoundID == '') {
                    RoundID = 0;
                }
                var SequenceNo = i + 1;
                var EstimatedTime = $row.find($('span[id$="lblestimatedTime"]')).html();

                lstRoundMasterAttributes.push({
                    ClinicID: ClientId,
                    EstimatedTime: EstimatedTime,
                    ID: ID,
                    Type: "Client",
                    SequenceNo: SequenceNo,
                    RoundID: RoundID
                });
            });

            if (lstRoundMasterAttributes.length > 0) {
                $("#hdnRoundValues").val(JSON.stringify(lstRoundMasterAttributes));
            }
            else {
                alert('Please Select clients');
                return false;
            }
        }

        $("body").keydown(function(e) {
            if (e.keyCode == 40) //down arrow key code
                onMoveUp(id);
            if (e.keyCode == 38) // up arrow key code
                onMoveDown(id);
        });

        function onMoveUp(id) {
            $(".up").click(function() {
                var row = $(this).parents("tr:first");
                if (row.index() > 1) {
                    //var row = row.next();
                    row.insertBefore(row.prev());
                }
            });

        }

        function onMoveDown(id) {
            $(".down").click(function() {
                var row = $(this).parents("tr:first");
                var count = $("#gvRound tr").length;
                if (row.index() < count - 1) {
                    row.insertAfter(row.next());
                }
            });

        }

        //        function btnDel() {
        //        }

        function onDeleteRoundClient(obj) {

            try {
                var $row = $(obj).closest('tr');
                var ID1 = $row.find($('span[id$="lblID"]')).html();
                var roundID = document.getElementById('hdnRoundId').value;
                if (ID1 == '' || ID1 == '0' || ID1 == undefined) {
                    ID1 = -1;
                }
                if (ID1 == -1) {
                    $(obj).closest('tr').remove();
                }
                else {
                    var ans = window.confirm('Do you want to delete?');
                    if (ans == true) {
                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/DeleteRoundMasterClient",
                            data: "{ID: " + ID1 + ",roundID: " + roundID + "}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function Success(data) {
                                $(obj).closest('tr').remove();
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert("Unable to delete");
                            }
                        });
                    }
                    else {
                        return false;
                    }
                }
            }
            catch (e) {
                return false;
            }
            return false;
        }
        
    </script>
<style>
.pnlBorder { border:1px solid #81aac4;}
</style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" AsyncPostBackTimeout="600">
        <services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <contenttemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="a-center">
                                            <div id="trDetails" runat="server">
                                                <asp:Panel ID="Panel4" CssClass="dataheader2 w-90p m-auto bg-row marginT10 padding5 pnlBorder" runat="server" 
                                                    meta:resourcekey="Panel4Resource1">
                                                    
                                                    <table class="w-100p">
                                                        <tr>
                                                         
                                                            <td class="a-right" colspan="4">
                                                              <asp:Label ID="lblRoundNameSearch" runat="server" Text="Search"></asp:Label>
                                                                <asp:TextBox ID="txtSearchRoundName" 
                                                                    runat="server" autocomplete="off" CssClass="AutoCompletesearchBox small"> </asp:TextBox>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRoundName" runat="server" TargetControlID="txtSearchRoundName"
                                                                    ServiceMethod="GetRoundNameList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                    MinimumPrefixLength="2" CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    FirstRowSelected="True" DelimiterCharacters="" OnClientItemSelected="SetRoundID"
                                                                    OnClientPopulated="onRoundSelected" Enabled="True">
                                                                </cc1:AutoCompleteExtender>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblRoundName" runat="server" Text="Round Name"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtRoundName" runat="server" CssClass="small" TabIndex="1" onblur="ExistRoundName();"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblActive" runat="server" Text="Active"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:CheckBox ID="chkIsActive" runat="server" Text="IsActive" TabIndex="2" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblStartTime" Text="Start Time" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <table class="w-20p">
                                                                    <tr class="v-top">
                                                                        <td>
                                                                            <asp:TextBox ID="txtFromTime1" runat="server" TabIndex="3"
                                                                                width="25px" ToolTip="hr"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                MaxLength="2"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtFromTime2" runat="server" width="25px" TabIndex="4"
                                                                                 MaxLength="2" ToolTip="mn"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlFromTime" Width="45px" CssClass="ddl h-19" TabIndex="5" runat="server"
                                                                             >
                                                                                <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                                                                <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblEndTime" Text="End Time" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <table class="w-20p">
                                                                    <tr class="v-top">
                                                                        <td>
                                                                            <asp:TextBox ID="txtToTime1" runat="server"  TabIndex="6" 
                                                                                width="25px" ToolTip="hr"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                MaxLength="2"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtToTime2" runat="server" TabIndex="7" 
                                                                                width="25px" MaxLength="2" ToolTip="mn"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlToTime" CssClass="ddl h-19 w-45" TabIndex="8" runat="server"
                                                                              >
                                                                                <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                                                                <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="Label8" Text="Start Location" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtStartLocation" TabIndex="9" runat="server" CssClass="small"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="Label9" Text="End Location" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtEndLocation" TabIndex="10" runat="server" CssClass="small"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblMobile" Text="Logistics" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtLogistics" TabIndex="11" runat="server" CssClass="small"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <div id="ExportXL" runat="server">
                                                                    <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="9pt"> </asp:Label>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                                        meta:resourcekey="imgBtnXLResource1" CssClass="w-16" OnClick="ImageBtnExport_Click" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <div>
                                                <asp:Panel ID="pnlClinicDetails" CssClass="dataheader2 w-90p m-auto bg-row marginT10 padding5 pnlBorder" runat="server"
                                                    meta:resourcekey="Panel4Resource1">
                                                    <table id="tblClinicNames" runat="server" class="w-100p"
                                                       >
                                                        <tr>
                                                            <td class="w-20p a-left">
                                                                <asp:Label ID="Label1" runat="server" Text="Select the clinics to be covered"></asp:Label>
                                                            </td>
                                                            <td class="w-30p a-left">
                                                                <asp:TextBox ID="txtClient" runat="server" TabIndex="12" autocomplete="off" 
                                                                    CssClass="AutoCompletesearchBox small"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                    OnClientItemSelected="SetClientID" Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2"
                                                                    ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtClient">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td class="a-left w-15p">
                                                               <asp:Label ID="lblestimatedTime" runat="server" Text="Estimated Time"></asp:Label>
                                                            </td>
                                                            <td class="w-15p a-left">
                                                             <asp:TextBox ID="txtEstimated" runat="server" CssClass="small" TabIndex="13" autocomplete="off"> </asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Button ID="btnAdd" runat="server" CssClass="btn" OnClientClick="javascript:return CheckToAddData();"
                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Add" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tblGrid" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvRound" runat="server" CssClass="gridView w-100p m-auto" OnRowDataBound="gvRound_RowDataBound">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <div>
                                                <asp:Panel ID="pnlPrinting" CssClass="dataheader2 w-90p m-auto bg-row marginT10 padding5 pnlBorder" runat="server"
                                                   meta:resourcekey="Panel4Resource1">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left" style="width: 165px;">
                                                                <asp:Label ID="Label2" runat="server" Text="Print this round sheet"></asp:Label>
                                                            </td>
                                                            <td class="a-left" style="width: 25px;">
                                                                <span class="richcombobox w-50">
                                                                    <asp:DropDownList ID="ddlTiming" CssClass="ddl w-50" TabIndex="13" runat="server">
                                                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource13" Text="10"></asp:ListItem>
                                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource14" Text="20"></asp:ListItem>
                                                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource15" Text="30"></asp:ListItem>
                                                                        <asp:ListItem Value="3" meta:resourcekey="ListItemResource16" Text="40"></asp:ListItem>
                                                                        <asp:ListItem Value="4" meta:resourcekey="ListItemResource17" Text="50"></asp:ListItem>
                                                                        <asp:ListItem Value="5" meta:resourcekey="ListItemResource18" Text="60"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                            <td class="w-50 a-left">
                                                                <span class="richcombobox w-75" >
                                                                    <asp:DropDownList ID="ddlHrs" CssClass="ddl w-75" TabIndex="14" runat="server">
                                                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource13" Text="Mins"></asp:ListItem>
                                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource14" Text="Hrs"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="Label3" runat="server" Text="before round start time"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left" style="width: 165px;">
                                                                <asp:Label ID="Label4" runat="server" Text="Repeat this round"></asp:Label>
                                                            </td>
                                                            <td colspan="3" class="a-left">
                                                                <asp:CheckBoxList runat="server" ID="chkDays" TabIndex="15" RepeatDirection="Horizontal"
                                                                    CssClass="radiobutton" AutoPostBack="false">
                                                                    <asp:ListItem Value="0">Sun</asp:ListItem>
                                                                    <asp:ListItem Value="1">Mon</asp:ListItem>
                                                                    <asp:ListItem Value="2">Tue</asp:ListItem>
                                                                    <asp:ListItem Value="3">Wed</asp:ListItem>
                                                                    <asp:ListItem Value="4">Thu</asp:ListItem>
                                                                    <asp:ListItem Value="5">Fri</asp:ListItem>
                                                                    <asp:ListItem Value="6">Sat</asp:ListItem>
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:Button ID="btnSave" ToolTip="Click here to Save Clinic Mgmnt" Style="cursor: pointer;"
                                                            runat="server" Text="Save" CssClass="btn" OnClientClick="javascript:return chkToSaveData();"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" TabIndex="16"
                                                            meta:resourcekey="btnFinishResource1" OnClick="btnSave_Click" />
                                                        &nbsp;
                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource1"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="cursor: pointer;"
                                                            TabIndex="17" Text="Cancel" OnClick="btnCancel_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnRefOrgType" runat="server" />
                                
                                <asp:GridView ID="gvRoundmaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                     OnClientItemSelected="SetClientID"  CssClass="dataheader2 gridView w-100p m-auto" PageSize="5" wrap="wrap"
                                      EmptyDataText="No matching record found.!" Visible="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No.">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1%></ItemTemplate>
                                            <ItemStyle Width="8%" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="RoundName" HeaderText="Round Name">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="StartTime" HeaderText="Start Time ">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EndTime" HeaderText="End Time">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="StartLocation" HeaderText="Start Location">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EndLocation" HeaderText="End Location">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LogisticEmployee" HeaderText="LogisticEmployee">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="IsActive" HeaderText="IsActive">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="RoundRepeatDays" HeaderText="RoundRepeatDays" Visible="false">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="Type" HeaderText="Type" Visible="false">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="RoundSheetTime" HeaderText="RoundSheetTime" Visible="false">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="Sequenceno" HeaderText="Sequenceno" Visible="false">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="ClientId" HeaderText="ClientId" Visible="false">
                                            <ItemStyle Width="22%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                </asp:GridView>
                                
                                <input id="hdnOrgID" type="hidden" value="0" runat="server" />
                                <input id="hdnRoundId" type="hidden" value="0" runat="server" />
                                <asp:HiddenField ID="hdnSelectedRoundName" runat="server" Value="" />
                                <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
                                <input type="hidden" runat="server" id="hdnClientId" />
                                <input type="hidden" runat="server" id="hdnRoundValues" />
                                <input type="hidden" runat="server" value="0" id="hdnID" />
                                 <input type="hidden" runat="server" value="0" id="hdnRecurrenceID" />
                                 <input type="hidden" runat="server" value="0" id="hdnDate" />
    </div>
    </ContentTemplate> </asp:UpdatePanel> </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
<%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
