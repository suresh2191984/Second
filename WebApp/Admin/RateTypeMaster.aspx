<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RateTypeMaster.aspx.cs" Inherits="Admin_RateTypeMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%--
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>--%>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #imgMandatory
        {
            margin-top: 15px;
            vertical-align: top !important;
        }
        .marginL22
        {
            margin-left: 22px;
        }
    </style>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>

    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>

    <%--    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

    <script language="javascript" type="text/javascript">


        function setMandatory() {
            if ($('#drpVendorType :selected').val() == 'Special') {
                $('#imgMandatory').show();
                //$('#imgMandatorySubType').show();
            }
            else {
                $('#imgMandatory').hide();
                // $('#imgMandatorySubType').hide();
            }

        }

        function ShowAlertMsg(key) {
            var objApp01 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_01") == null ? "Rate Card Already Mapped to this Organisation" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                return false;
            }
            else {
                    // alert('Rate Card Already Mapped to this Organisation');
                    ValidationWindow(objApp01, objAlert);

                return false;
            }

        }


        //Only numbers and only one dot value allowed for diecimal
        function isNumericss(e, Id) {

                var key; var isCtrl; var flag = 0;
                var txtVal = document.getElementById(Id).value.trim();
                var len = txtVal.split('.');
                if (len.length > 1) {
                    flag = 1;
                }
                if (window.event) {
                    key = window.event.keyCode;
                    if (window.event.shiftKey) {
                        isCtrl = false;
                    }
                    else {
                        if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                            isCtrl = true;
                        }
                        else {
                            isCtrl = false;
                        }
                    }
                } return isCtrl;
            }
            function checkIsValid() {
                var objApp02 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_02") == null ? "Provide a valid Ratecard" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_02");
                var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");
                var objApp03 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_03") == null ? "Select Organization" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_03");

                if (document.getElementById('txtRateCard').value == "" || document.getElementById('hdnRateID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\RateTypeMaster.aspx.cs_10");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);

                        // return false;
                    }
                    else {
                        // alert('Provide a valid Ratecard');
                        ValidationWindow(objApp02, objAlert);

                       
                        // return false;
                    }


                    document.getElementById('txtRateCard').value = "";
                    document.getElementById('txtRateCard').focus();
                    return false;
                }
                var ddlTrustedOrg = document.getElementById('drpTrustedOrg');
                if (ddlTrustedOrg.value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\RateTypeMaster.aspx.cs_11");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);

                        //return false;
                    }
                    else {
                        // alert('Select Organization');
                        ValidationWindow(objApp03, objAlert);

                        // return false;
                    }
                    document.getElementById('drpTrustedOrg').focus();
                    return false;
                }
            }
        function pcheckitem() {
                var objApp04 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_04") == null ? "Provide the name" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_04");
                var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");
                var objApp05 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_05") == null ? "Select Type" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_05");
                var objApp06 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_06") == null ? "Select the SubType" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_06");
                var objApp07 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_07") == null ? "Provide the Comments" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_07");

            if (document.getElementById('txtName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Admin\\RateTypeMaster.aspx_1');
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                }
                else {
                    //alert('Provide the name');
                    ValidationWindow(objApp04, objAlert);

                }
                document.getElementById('txtName').focus();
                return false;
            }

            var drpVendorType = document.getElementById('drpVendorType');
            if (drpVendorType.value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\RateTypeMaster.aspx.cs_12");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                    //return false;
                }
                else {
                    //alert('Select Type');
                    ValidationWindow(objApp05, objAlert);

                    // return false;
                }
                document.getElementById('drpVendorType').focus();
                return false;
            }
            // if ($('#drpVendorType :selected').val() == 'Special') {
            if ($('#drpVendorSubType :selected').val() == '0') {
                // alert('Select the SubType');
                ValidationWindow(objApp06, objAlert);

                return false;
            }

            // }

            if ($('#drpVendorType :selected').val() == 'Special') {
                if ($('#txtComments').val() == '') {
                    // alert('Provide the Comments');
                    ValidationWindow(objApp07, objAlert);

                    return false;
                }

            }
            return true;
        }
        function ButtonClickMessage(objNumber) {
            var objApp08 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_08") == null ? "Changes saved successfully." : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_08");
            var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");
            var objApp09 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_09") == null ? "Already exist." : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_09");

            var userMsg = SListForApplicationMessages.Get('Admin\\RateTypeMaster.aspx.cs_' + objNumber);
            if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

            }
            else {
                    // alert('Changes saved successfully.');
                    ValidationWindow(objApp08, objAlert);

            }
        }
        function ButtonDeleteClickMessage(objNumber) {
            var userMsg = SListForApplicationMessages.Get('Admin\\RateTypeMaster.aspx.cs_' + objNumber);
            if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
            }
            else {
                    ValidationWindow(objApp08, objAlert);

//alert('Changes saved successfully.');
            }
        }
        function ButtonAlreadyClickMessage(objNumber) {
                var objApp09 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_09") == null ? "Already exist." : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_09");
                var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");

            var userMsg = SListForApplicationMessages.Get('Admin\\RateTypeMaster.aspx.cs_' + objNumber);
            if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
            }
            else {
                    //alert('Already exist.');
                    ValidationWindow(objApp09, objAlert);
            }
        }
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
                isCtrl = true;
            }

            return isCtrl;
        }



        function pChekUserName() {
                var objApp10 = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_10") == null ? "Are you sure you wish to delete this type?" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_10");
            var i;
            
            var userMsg = SListForApplicationMessages.Get("Admin\\RateTypeMaster.aspx_3");
            if (userMsg != null) {
                i = confirm(userMsg);
                //return false;
            }
            else {
                    // i = confirm('Are you sure you wish to delete this type?');  Comment by Gowtham
                    i = confirm(objApp10);
                //return false;
            }

            // i = confirm('Are you sure you wish to delete this type?');
            if (i == true) {
                return;
            }
            else {
                return false;
            }
        }

        function pUpdateItem(obj) {
            document.getElementById('<%= txtName.ClientID %>').value = obj.CName;
            document.getElementById('<%= Hdnupdate.ClientID %>').value = obj.Cid;

            document.getElementById('<%= btnsave.ClientID %>').value = 'Update';

        }

        function fClear() {
            document.getElementById('<%= btnsave.ClientID %>').value = 'Save';
            document.getElementById('<%= txtName.ClientID %>').value = '';
            document.getElementById('<%=drpVendorType.ClientID %>').value = "0";
            document.getElementById('<%=txtRateNameSearch.ClientID %>').value = '';

            $("#drpVendorSubType").get(0).options.length = 0;
            $('#drpVendorSubType').append('<option value="0">--Select--</option>');
            document.getElementById('<%= txtComments.ClientID %>').value = '';
            $('#imgMandatory').hide();
            // $('#imgMandatorySubType').hide();
            //$('#drpVendorSubType').empty();  
            return false;

        }

        function SelectedClientValue(source, eventArgs) {
            $("#txtTrustedOrgPolicyID").val('');
            $("#hdnTrustedPolicyID").val('');
            $("#txtTrustedOrgPolicyID").attr("disabled", true);
            $('[id$="drpTrustedOrg"] option:first').attr('selected', true);
            document.getElementById('hdnRateID').value = eventArgs.get_value();
        }
        function clearRateValue() {
            if (document.getElementById('txtRateCard').value == "") {
                document.getElementById('hdnRateID').value = "0";
            }
        }

        function GetPolicyID(source, eventArgs) {
            $('[id$="txtPolicyName"]').val(eventArgs.get_text());
            $('[id$="hdnPolicyID"]').val(eventArgs.get_value());
        }
        function GetTrusredOrgPolicyID(source, eventArgs) {
            $('[id$="txtTrustedOrgPolicyID"]').val(eventArgs.get_text());
            $('[id$="hdnTrustedPolicyID"]').val(eventArgs.get_value());
            var TrustedOrgID = $("#drpTrustedOrg").val();
            var RateID = $("#hdnRateID").val();
            var LID = '<%= LID %>';
            var PolicyID = eventArgs.get_value();
            if (TrustedOrgID != 0 && RateID.length > 0)
                WebService.pSaveRateOrgMapping(RateID, TrustedOrgID, PolicyID, LID);
        }
        function DisplayTab(tabName) {
            $('#TabsMenu li').removeClass('active');
            $('.divTab').attr("style", "display:none");
            switch (tabName) {
                case 'RAC':
                    $('#li1').addClass('active');
                    $('#divManageRate').attr("style", "display:block");
                    break;
                case 'RACO':
                    $('#li2').addClass('active');
                    $('#divRateOrgMapping').attr("style", "display:block");
                    break;
            }
        }

        function SetContextKey() {
            try {
                var trustedOrgID = $("#drpTrustedOrg").val();
                if (trustedOrgID != 0 && $("#txtRateCard").val() != "") {
                    $("#txtTrustedOrgPolicyID").attr("disabled", false);
                    $find('AutoCompleteExtender1').set_contextKey("DCP" + "~" + trustedOrgID);
                    var RateID = $("#hdnRateID").val();
                    var orgType = 'TOrg';
                    $('[id$="txtTrustedOrgPolicyID"]').val('');
                    $('[id$="hdnTrustedPolicyID"]').val('');
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetRateTypeMaster",
                        data: "{OrgID: " + trustedOrgID + ", OrgType:'" + orgType + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function Success(data) {
                            var lstRateMaseter = data.d;
                            $.each(lstRateMaseter, function(i, obj) {
                                if (obj.RateId == RateID) {
                                    if (obj.DiscountPolicyID != "" && obj.DiscountPolicyID != 0) {
                                        $('[id$="txtTrustedOrgPolicyID"]').val(obj.RateTypeName);
                                        $('[id$="hdnTrustedPolicyID"]').val(obj.DiscountPolicyID);
                                    }
                                }
                            });
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(xhr.status);
                        }
                    });
                }
            }
            catch (e) {
                return false;
            }
        }

        $(function() {
            $("#txtTrustedOrgPolicyID").attr("disabled", true);
        });
        var DisplMsg;
        var userMsg2;
        var Cond;


        function checkForValues1(Cond) {

            if (Cond == 'A') {

                var userMsg1 = SListForAppMsg.Get('Admin_RateTypeMaster_aspx_11') != null ? SListForAppMsg.Get('Admin_RateTypeMaster_aspx_11') : "Provide page number";
                DisplMsg = SListForAppMsg.Get('Admin_RateTypeMaster_aspx_Alert') != null ? SListForAppMsg.Get('Admin_RateTypeMaster_aspx_Alert') : "Alert";
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

if (Cond == 'B') {

    var userMsg1 = SListForAppMsg.Get('Admin_RateTypeMaster_aspx_11') != null ? SListForAppMsg.Get('Admin_RateTypeMaster_aspx_11') : "Provide page number";
    DisplMsg = SListForAppMsg.Get('Admin_RateTypeMaster_aspx_Alert') != null ? SListForAppMsg.Get('Admin_RateTypeMaster_aspx_Alert') : "Alert";
    if (document.getElementById('txtpageNo1').value == "") {
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
    if (Number(document.getElementById('txtpageNo1').value) < Number(1)) {
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

    if (Number(document.getElementById('txtpageNo1').value) > Number(document.getElementById('lblTotal1').innerText)) {
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



        }

        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <%--<asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>--%>
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="pnlrate" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <div id='TabsMenu' class="a-left">
                                            <ul>
                                                <li id="li1" class="active" onclick="DisplayTab('RAC')"><a href='#'>
                                                    <asp:Label ID="lblManageRate" runat="server" Text="Manage Rate" meta:resourcekey="lblManageRateResource1"></asp:Label>
                                                </a></li>
                                                <li id="li2" onclick="DisplayTab('RACO')"><a href='#'>
                                                    <asp:Label ID="lblRateCardMapping" runat="server" Text="RateCard Mapping" meta:resourcekey="lblRateCardMappingResource1"></asp:Label>
                                                </a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p b-tab">
                                <tr>
                                    <td>
                                        <div id="divManageRate" runat="server" class="divTab">
                                            <asp:Panel ID="Panel1" CssClass="dataheader2 w-100p" runat="server" meta:resourcekey="Panel1Resource1">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <asp:Panel ID="Panel2" CssClass="dataheader2 w-100p" runat="server" meta:resourcekey="Panel2Resource1">
                                                                <table class="w-100p">
                                                                    <tr class="w-100p">
                                                                        <td class="w-3p a-right">
                                                                            <asp:Label ID="lblRateName" runat="server" Text="RateName" meta:resourcekey="lblRateNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-15p a-left">
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="small marginL22" MaxLength="45"
                                                                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                        <td class="w-9p a-right" style="display: none">
                                                                            <asp:Label ID="lblDiscountPolicy" Text="Search Policy Name" runat="server" meta:resourcekey="lblDiscountPolicyResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-14p a-left" style="display: none">
                                                                            <asp:TextBox ID="txtPolicyName" runat="server" CssClass="small" AutoComplete="off"
                                                                                meta:resourcekey="txtPolicyNameResource1"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender11" runat="server" TargetControlID="txtPolicyName"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTODCodeAndID"
                                                                                OnClientItemSelected="GetPolicyID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                Enabled="True">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td class="w-3p a-right">
                                                                            <%--Type--%> <%--andrews--%>
                                                                            <%=Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_01%>
                                                                        </td>
                                                                        <td class="w-15p a-left">
                                                                            <asp:DropDownList ID="drpVendorType" runat="server" CssClass="ddlsmall" 
                                                                                Style="margin-left: 22px;" 
                                                                                OnSelectedIndexChanged="drpVendorType_SelectedIndexChanged" AutoPostBack="True" 
                                                                                meta:resourcekey="drpVendorTypeResource1">
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                        </td>
                                                                        <%--ManageRate Changes start--%>
                                                                        <td class="w-3p a-right" id="lblSubType">
                                                                            <%--SubType--%> <%--andrews--%>
                                                                            <%=Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_02%>
                                                                        </td>
                                                                        <td class="w-15p a-left">
                                                                            <asp:DropDownList ID="drpVendorSubType" runat="server" CssClass="ddlsmall"
                                                                                Style="margin-left: 22px;" >
                                                                                <%--<asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource1"></asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle  marginL4" id="imgMandatorySubType" />
                                                                        </td>
                                                                        <td class="w-3p a-right">
                                                                            <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-21p a-right">
                                                                            <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" MaxLength="255"
                                                                                CssClass="Txtboxlarge marginL22" meta:resourcekey="txtCommentsResource1"></asp:TextBox><%--  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" --%>
                                                                            <img ID="imgMandatory" runat="server" class="v-middle hide marginL4" 
                                                                                src="../Images/starbutton.png"></img>
                                                                        </img>
                                                                        </td>
                                                                        <%--ManageRate Changes End--%>
                                                                        <td class="w-10p">
                                                                            <asp:Button ID="btnsave" runat="server" CssClass="btn" onmouseout="this.className='btn1'"
                                                                                onmouseover="this.className='btn1 btnhov'" Text="Save" OnClientClick="javascript:return pcheckitem();"
                                                                                OnClick="btnsave_Click1" meta:resourcekey="btnsaveResource1" />
                                                                            <asp:Button ID="btn" runat="server" Text="Clear" CssClass="btn" onmouseout="this.className='btn1'"
                                                                                onmouseover="this.className='btn1 btnhov'" OnClientClick="return fClear();" meta:resourcekey="btnResource1" />
                                                                            <%--<input type="button" id="btn" value="Clear" class="btn1" onmouseout="this.className='btn1'"
                                                                                    onmouseover="this.className='btn1 btnhov'" onclick="fClear();" />--%>
                                                                            <asp:HiddenField ID="Hdnupdate" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-right w-6p">
                                                                            <asp:Label ID="lblRateNameSearch" runat="server" Text="Rate Name" 
                                                                                meta:resourcekey="lblRateNameSearchResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left w-14p">
                                                                            <asp:TextBox ID="txtRateNameSearch" runat="server" CssClass="small marginL22" 
                                                                                AutoComplete="off" meta:resourcekey="txtRateNameSearchResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td class="a-left w-9p">
                                                                            <asp:Button ID="btnsearch" runat="server" CssClass="btn" onmouseout="this.className='btn1'"
                                                                                onmouseover="this.className='btn1 btnhov'" OnClick="btnsearch_Click" 
                                                                                Text="Search" meta:resourcekey="btnsearchResource1" />
                                                                        </td>
                                                                        <td class="a-left w-14p" style="display: none">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td class="a-right w-3p">
                                                                        </td>
                                                                        <td class="a-left w-7p">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td class="w-10p">
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Panel ID="PnlEditGp" CssClass="dataheader2 w-100p" runat="server" meta:resourcekey="PnlEditGpResource1">
                                                                <div class="tablerow" id="ACX2responsesOPPmt" style="display: block;" runat="server">
                                                                    <asp:GridView ID="gvRateTypes" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                        BorderColor="#CCCCCC" BorderStyle="None" CssClass="gridView w-100p m-auto" Font-Bold="False"
                                                                        Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False"
                                                                        Font-Underline="False" OnRowDataBound="gvRateTypes_RowDataBound" DataKeyNames="RateId,DiscountPolicyID,Status,Type"
                                                                        OnRowDeleting="gvRateTypes_RowDeleting" 
                                                                        OnRowCommand="gvRateTypes_RowCommand" meta:resourcekey="gvRateTypesResource2">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="S.No." meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <%#Container.DataItemIndex+1%>
                                                                                </ItemTemplate>
                                                                                <ItemStyle CssClass="w-8p" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Rate card" 
                                                                                meta:resourceKey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblname" runat="server" meta:resourceKey="lblnameResource1" 
                                                                                        Text='<%# bind("RateName") %>'></asp:Label>
                                                                                    <asp:Label ID="lblid" runat="server" meta:resourcekey="lblidResource2" 
                                                                                        Text='<%# bind("RateId") %>' Visible="False"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Discount Policy" 
                                                                                meta:resourcekey="TemplateFieldResource5" Visible="False">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDiscountName" runat="server" 
                                                                                        meta:resourceKey="lblDiscountNameResource1" Text='<%# bind("RateTypeName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Type" meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorType" runat="server" 
                                                                                        meta:resourcekey="lblVendorTypeResource1" Text='<%# bind("LType") %>'></asp:Label>
                                                                                    <asp:Label ID="lblVendorTypeCode" runat="server" 
                                                                                        meta:resourcekey="lblVendorTypeCodeResource1" Style="display: none;" 
                                                                                        Text='<%# bind("Type") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="SubType" 
                                                                                meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSubType" runat="server" 
                                                                                        meta:resourcekey="lblSubTypeResource1" Text='<%# bind("LSubType") %>'></asp:Label>
                                                                                        <asp:HiddenField ID="hdnsubtypeEnglish" runat="server" Value='<%# bind("SubType") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Comments" 
                                                                                meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblComments" runat="server" 
                                                                                        meta:resourcekey="lblCommentsResource2" Text='<%# bind("Comments") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action" 
                                                                                meta:resourceKey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkEdit" runat="server" 
                                                                                        CommandArgument="<%# Container.DataItemIndex %>" CommandName="RateEdit" 
                                                                                        CssClass="editIcons" ForeColor="Red" meta:resourceKey="lnkEditResource1" 
                                                                                        Text="Edit"></asp:LinkButton>
                                                                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                                                                                        CssClass="deleteIcons" ForeColor="Red" meta:resourceKey="lnkDeleteResource1" 
                                                                                        OnClientClick="javascript:return pChekUserName(); " Text="Delete" 
                                                                                        Visible="False"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <ItemStyle CssClass="w-15p" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                        <RowStyle ForeColor="#000066" />
                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr id="GrdFooter" runat="server" style="display: none; background: none" class="dataheaderInvCtrl">
                                                        <td class="defaultfontcolor a-center" runat="server">
                                                            <asp:Label ID="Label3" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                            <asp:Label ID="Label4" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click"
                                                                CssClass="btn" meta:resourcekey="btnPreviousResource1" />
                                                            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn" meta:resourcekey="btnNextResource1"/>
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                            <asp:Label ID="Label5" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                            <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" MaxLength="4" onkeypress="return ValidateOnlyNumeric(this);" 
                                                                AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                            <asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btnGo_Click" CssClass="btn" OnClientClick="javascript:return checkForValues1('A');" meta:resourcekey="btnGoResource1" />
                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>
                                        <div id="divRateOrgMapping" runat="server" style="display: none;" class="divTab">
                                            <asp:Panel ID="pnlRateOrgMap" CssClass="dataheader2 w-100p" runat="server" meta:resourcekey="pnlRateOrgMapResource1">
                                                <table class="w-100p" id="tblRateOrgMap" runat="server" style="display: table;">
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            <asp:Panel ID="Panel3" CssClass="dataheader2 w-100p" runat="server">
                                                                <table>
                                                                    <tr id="trRateCardMapping" runat="server">
                                                                        <td class="w-14p" nowrap="nowrap" runat="server">
                                                                            <asp:Label runat="server" ID="lblOrgRateCardName" Text="RateCard Name" meta:resourcekey="lblOrgRateCardNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-17p" nowrap="nowrap" runat="server">
                                                                            <asp:TextBox ID="txtRateCard" runat="server" CssClass="small" onBlur="clearRateValue();"
                                                                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" ></asp:TextBox>
                                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" BehaviorID="AutoCompleteExLstGrp1"
                                                                                CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                Enabled="True" FirstRowSelected="True" OnClientItemSelected="SelectedClientValue"
                                                                                MinimumPrefixLength="1" ServiceMethod="GetClientRateCard" ServicePath="~/WebService.asmx"
                                                                                TargetControlID="txtRateCard">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td class="w-14p" runat="server">
                                                                            <asp:Label runat="server" ID="lblTrustedOrg" Text="Organisation" meta:resourcekey="lblTrustedOrgResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-14p" runat="server">
                                                                            <asp:DropDownList ID="drpTrustedOrg" onChange="SetContextKey()" runat="server" CssClass="ddl">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td class="w-14p" style="display: none" runat="server">
                                                                            <asp:Label ID="lblOrgPolicy" Text="Search Policy Name" runat="server" meta:resourcekey="lblOrgPolicyResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-14p" style="display: none" runat="server">
                                                                            <asp:TextBox ID="txtTrustedOrgPolicyID" runat="server" CssClass="small" AutoComplete="off"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtTrustedOrgPolicyID"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTrustedOrgPolicy"
                                                                                OnClientItemSelected="GetTrusredOrgPolicyID" ServicePath="~/WebService.asmx"
                                                                                DelimiterCharacters="" Enabled="True">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td class="w-14p" runat="server">
                                                                            <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseout="this.className='btn1'"
                                                                                onmouseover="this.className='btn1 btnhov'" Text="Save" OnClientClick="javascript:return checkIsValid();"
                                                                                OnClick="btnAdd_Click" meta:resourcekey="btnAddResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trRateCardMapping1" runat="server">
                                                                        <td class="w-14p" runat="server">
                                                                            <asp:Label ID="lblRateNameSearch1" runat="server" Text="RateCard Name" meta:resourcekey="lblRateNameSearch1Resource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-19p a-left" runat="server">
                                                                            <asp:TextBox ID="txtRateCardMapping" runat="server" CssClass="small"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-14p" runat="server">
                                                                            <asp:Button ID="btnmapping" runat="server" CssClass="btn" onmouseout="this.className='btn1'"
                                                                                onmouseover="this.className='btn1 btnhov'" Text="Search" OnClick="btnmapping_Click" meta:resourcekey="btnmappingResource1" />
                                                                        </td>
                                                                        <td class="w-14p" runat="server">
                                                                        </td>
                                                                        <td style="display: none" class="w-14p" runat="server">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td style="display: none" class="w-14p" runat="server">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td runat="server">
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td colspan="5" runat="server">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td colspan="5" runat="server">
                                                            <asp:GridView ID="grdRateOrgMapping" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                BorderColor="#CCCCCC" BorderStyle="None" Font-Bold="False" CssClass="gridView w-100p m-auto"
                                                                Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False"
                                                                Font-Underline="False">
                                                                <RowStyle ForeColor="#000066" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No."  meta:resourcekey="TemplateFieldResource1" >
                                                                        <ItemTemplate>
                                                                            <%#Container.DataItemIndex+1%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle CssClass="w-8p" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Rate card" meta:resourcekey="TemplateFieldResource12" >
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRateCardName" runat="server" Text='<%#bind("RateCardName")%>'>
                                                                            </asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle CssClass="w-38p" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="RateID" Visible="False" meta:resourcekey="TemplateFieldResource13">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRateID" runat="server" Text='<%#bind("RateID")%>'>
                                                                            </asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Organization" meta:resourcekey="TemplateFieldResource14">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblOrganizationName" runat="server" Text='<%#bind("OrganizationName")%>'>
                                                                            </asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="OrgID" Visible="False" meta:resourcekey="TemplateFieldResource15">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblOrgID" runat="server" Text='<%#bind("OrgID")%>'>
                                                                            </asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr id="GrdFooter1" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                        <td align="center" class="defaultfontcolor" runat="server">
                                                            <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                            <asp:Label ID="lblCurrent1" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                            <asp:Label ID="Label6" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            <asp:Label ID="lblTotal1" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                            <asp:Button ID="btnPrevious1" runat="server" Text="Previous" OnClick="btnPrevious1_Click"
                                                                CssClass="btn" meta:resourcekey="btn_PreviousResource1"/>
                                                            <asp:Button ID="btnNext1" runat="server" Text="Next" OnClick="btnNext1_Click" CssClass="btn" meta:resourcekey="btn_NextResource1"/>
                                                            <asp:HiddenField ID="hdnCurrent1" runat="server" />
                                                            <asp:Label ID="Label8" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                            <asp:TextBox ID="txtpageNo1" runat="server" Width="30px" MaxLength="4"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                AutoComplete="off"></asp:TextBox>
                                                            <asp:Button ID="btnGo1" OnClick="btnGo1_Click" runat="server" Text="Go" CssClass="btn" OnClientClick="javascript:return checkForValues1('B');" meta:resourcekey="btnGoResource1"/>
                                                            <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnRateID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnPolicyID" runat="server" />
    <asp:HiddenField ID="hdnTrustedPolicyID" runat="server" />
    </form>
</body>
</html>
