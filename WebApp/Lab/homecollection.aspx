<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="homecollection.aspx.cs"
    Inherits="Lab_homecollection" %>

<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%--Home Collection--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_001%>
    </title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            hideColumn();
            var prtContent = document.getElementById('divPrintarea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            ShowColumn();

            return false;
        }




        function ForFutureDate() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_01") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_01") : "Dont select Collection date as past Date.";
            var date = new Date,
    day = date.getDate(),
    month = date.getMonth() + 1,
    year = date.getFullYear(),
    hour = date.getHours(),
    minute = date.getMinutes(),
    seconds = date.getSeconds(),
    ampm = hour > 12 ? "PM" : "AM";
            hour = hour % 12;
            hour = hour ? hour : 12; // zero = 12
            minute = minute > 9 ? minute : "0" + minute;
            seconds = seconds > 9 ? seconds : "0" + seconds;
            hour = hour > 9 ? hour : "0" + hour;

            date = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + seconds + " " + ampm;
            if (document.getElementById('txtTime').value != '') {
                var currentdate = document.getElementById('hdncurdatetime').value;
                var Sampledt = document.getElementById('txtTime').value;
                var dt1 = currentdate.split(' ');
                var dt2 = Sampledt.split(' ');
                if (Date.parse(Sampledt) < Date.parse(date)) {
                    //alert("Dont select Collection date as past Date.");
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //                    document.getElementById('txtTime').value = '';
                    //                    document.getElementById('txtTime').value = date;
                    return false;
                }
            }
        }

        //        function loadlocations() {
        //            // $("select[id$=ddlRole] > option").remove();
        //            //$("select[id$=ddlUser] > option").remove();
        //            document.getElementById('hdnlocid').value = '0';
        //            $.ajax({
        //                type: "POST",
        //                url: "../OPIPBilling.asmx/GetLocationName",
        //                data: "{ 'OrgId': '" + parseInt(document.getElementById('ddlOrg').value) + "'}",   //.split('~')[0]) + "'}",
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                async: false,
        //                success: function(data) {
        //                    var Items = data.d;

        //                    $('#ddlLocation').attr("disabled", false);
        //                    $("select[id$=ddlLocation] > option").remove();
        //                    //(document.getElementById('hdnlocid').value);
        //                    $('#ddlLocation').append('<option value="0">--Select--</option>');
        //                    $.each(Items, function(index, Item) {
        //                        // if (Item.RoleName == 'Phlebotomist' || Item.RoleName == "Sr Phlebotomist") {
        //                        $('#ddlLocation').append('<option value="' + Item.AddressID + '">' + Item.Location + '</option>');
        //                        // }
        //                    });
        //                    //if (document.getElementById('hdnlocid').value > 0) {
        //                    $('#ddlLocation').val(document.getElementById('hdnlocid').value);
        //                    // }
        //                },
        //                failure: function(msg) {
        //                    ShowErrorMessage(msg);
        //                }
        //            });
        //        }
        //        function loadRole() {

        //            $("select[id$=ddlRole] > option").remove();
        //            $("select[id$=ddlUser] > option").remove();
        //            document.getElementById('hdnRoleId').value = '0';
        //            $.ajax({
        //                type: "POST",
        //                url: "../OPIPBilling.asmx/GetRoleName",
        //                data: "{ 'OrgId': '" + parseInt(document.getElementById('ddlOrg').value) + "'}",   //.split('~')[0]) + "'}",
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                async: false,
        //                success: function(data) {
        //                    var Items = data.d;

        //                    $('#ddlRole').attr("disabled", false);
        //                    $('#ddlRole').append('<option value="0">--Select--</option>');
        //                    $.each(Items, function(index, Item) {
        //                        if (Item.RoleName == 'Phlebotomist' || Item.RoleName == "Sr Phlebotomist") {
        //                            $('#ddlRole').append('<option value="' + Item.RoleID + '">' + Item.RoleName + '</option>');
        //                        }
        //                    });
        //                    // if (document.getElementById('hdnRoleId').value > 0) {
        //                    $('#ddlRole').val(document.getElementById('hdnRoleId').value);
        //                    //  }
        //                },
        //                failure: function(msg) {
        //                    ShowErrorMessage(msg);
        //                }
        //            });
        //        }

        //        function loadUsers() {
        //            $("select[id$=ddlUser] > option").remove();
        //            var OrgId = document.getElementById('ddlOrg').value; //.split('~')[0];
        //            var RoleID = document.getElementById('ddlRole').value;
        //            var LocID = document.getElementById('ddlLocation').value;
        //            document.getElementById('hdnRoleId').value = RoleID;
        //            document.getElementById('hdnlocid').value = LocID;
        //            //            var s = document.getElementById('hdnRoleId').value;
        //            //            alert(s);
        //            //document.getElementById('hdnUserID').value = RoleID;
        //            $.ajax({
        //                type: "POST",
        //                url: "../OPIPBilling.asmx/GetUserName",
        //                data: "{ OrgId: " + parseInt(OrgId) + ",RoleID: " + RoleID + "}",
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                async: true,
        //                success: function(data) {
        //                    var Items = data.d;

        //                    $('#ddlUser').attr("disabled", false);
        //                    $('#ddlUser').append('<option value="0">--Select--</option>');
        //                    $.each(Items, function(index, Item) {
        //                        $('#ddlUser').append('<option value="' + Item.UserID + '">' + Item.Name + '</option>');
        //                    });
        //                    //                    if (document.getElementById('ddlUser').value > 0) {
        //                    //                        $('#ddlUser').val(document.getElementById('hdnUserId').value);
        //                    //                    }
        //                    $('#ddlUser').val(document.getElementById('hdnuserselectedval').value);

        //                },
        //                failure: function(msg) {
        //                    ShowErrorMessage(msg);
        //                }
        //            });
        //            //            var UserID = document.getElementById('ddlUser').value;
        //            //            document.getElementById('hdnUserId').value = UserID

        //        }
        function ChangeUsers() {
            var UserID = document.getElementById('ddlUser').value;
            document.getElementById('hdnUserID').value = UserID;
        }
             

    </script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            //
            var prtContent = document.getElementById('divBillDes');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function AdditionalDetails() {


            var CollectedDatetime = document.getElementById('txtTime').value;
            if (CollectedDatetime != '') {

                document.getElementById('billPart_hdnCollectedDateTime').value = CollectedDatetime;
                document.getElementById('billPart_hdnIsCollected').value = "H";
            }
        }
    </script>

    <style>
        #lblStatus
        {
            padding-left: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="pp" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress111" AssociatedUpdatePanelID="pp" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="defaultfontcolor w-100p">
                    <tr>
                        <td>
                            <div id="ShowBillingItems" style="display: none; position: absolute; width: 35%;
                                left: 62%; top: 1%">
                                <div onclick="Itemhidebox();return false" class="divCloseRight">
                                </div>
                                <table class="modalPopup dataheaderPopup w-32p">
                                    <tr>
                                        <td id="Itemdragbar" style="cursor: move; cursor: pointer" class="w-100p">
                                                            <asp:Label ID="lblPreviousItems" runat="server" meta:resourcekey="lblPreviousItemsResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divShowClientDetails" style="display: none; position: absolute; width: 35%;
                                left: 62%; top: 1%">
                                <div onclick="Itemhidebox();return false" class="divCloseRight">
                                </div>
                                <table class="modalPopup dataheaderPopup w-32p">
                                    <tr>
                                        <td id="Td6" style="cursor: move; cursor: pointer" class="w-100p">
                                                            <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td class="w-12p">
                                        <asp:RadioButton ID="rdoPatientSave" onclick="javascript:showsave();resetsave();"
                                                            Text="New Home Collection" runat="server" meta:resourcekey="rdoPatientSaveResource1" />
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoPatientSearch" onclick="javascript:showsearch();resetsearch();"
                                            Text="LookUp For Existing Home Collection" runat="server" meta:resourcekey="rdoPatientSearchResource1" />
                                    </td>
                                    <td class="a-right">
                                        <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                            id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="tbmain" runat="server" class="dataheader3 w-100p">
                                <tr>
                                    <td class="w-10p">
                                        <asp:Label ID="lblPatient" runat="server" Text="Patient Name" meta:resourcekey="lblPatientResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPatientName" runat="server" ToolTip="Enter a Patient Name" TabIndex="1"
                                            onchange="Clear();" onblur="javascript:ConverttoUpperCase(this.id);ValidateIsNewPatient();"
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                            EnableCaching="False" FirstRowSelected="False" OnClientItemSelected="IAmSelected"
                                            MinimumPrefixLength="3" CompletionListCssClass="listtwo" CompletionInterval="5"
                                            CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                            ServiceMethod="GetPatientListforBookings" ServicePath="~/InventoryWebService.asmx"
                                            DelimiterCharacters="" Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                        <img id="imgMan" src="../Images/starbutton.png" style="display: inline" alt="" align="middle" />
                                    </td>
                                    <td id="tdBookingNo1" runat="server" class="w-10p" style="display: none;">
                                                        <asp:Label ID="Label6" runat="server" Text="Booking Number" meta:resourcekey="Label6Resource1"></asp:Label>
                                    </td>
                                    <td id="tdBookingNo2" runat="server" class="w-25p" style="display: none;">
                                        <asp:TextBox ID="txtBookingNumber" CssClass="Txtboxsmall" runat="server" MaxLength="250"
                                                            TabIndex="5" meta:resourcekey="txtBookingNumberResource1"></asp:TextBox>
                                    </td>
                                    <td id="tdsex1" class="w-5p a-left">
                                        <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                            AccessKey="X" meta:resourcekey="lblSexResource1"></asp:Label>
                                    </td>
                                    <td id="tdsex2" class="w-19p a-left">
                                                        <asp:DropDownList Width="70px" ID="ddlSex" runat="server" CssClass="ddl" TabIndex="2"
                                                            meta:resourcekey="ddlSexResource1">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                            AccessKey="B" meta:resourcekey="lblDOBResource1"></asp:Label>
                                                        <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"
                                                            meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                        <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server"
                                                            meta:resourcekey="ddMaritalResource1">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                        <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                            TabIndex="3" onblur="javascript:CalculateAge(this);" Width="87px" Style="text-align: justify"
                                            ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                            PopupButtonID="ImgBntCalc" Enabled="True" />
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td class="w-6p a-left" id="tdAge1" runat="server">
                                                        <asp:Label ID="lblAge" runat="server" Text="Age" meta:resourcekey="lblAgeResource1"></asp:Label>
                                    </td>
                                    <td class="w-14p a-left" id="tdAge2" runat="server">
                                        <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYear(this.id,'HC');"
                                            TabIndex="4"      onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxsmall"
                                            Width="18%" runat="server" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                        <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" Width="75px"
                                                            runat="server" CssClass="ddl" meta:resourcekey="ddlDOBDWMYResource1">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                            Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                        </ajc:TextBoxWatermarkExtender>
                                    </td>
                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="Mobile" meta:resourcekey="Label7Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMobile" runat="server" ToolTip="Enter a Patient Mobile Number"
                                            TabIndex="5" MaxLength="13"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                        &nbsp;<img id="img1" style="display: inline" src="../Images/starbutton.png" alt=""
                                            align="middle" />
                                    </td>
                                </tr>
                                <tr id="trSaveDate" runat="server">
                                    <td nowrap="nowrap">
                                                        <asp:Label ID="Label8" runat="server" nowrap="nowrap" Text="Telephone No" meta:resourcekey="Label8Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTelephoneNo" runat="server"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            ToolTip="Enter a Patient Telephone Number" MaxLength="15" TabIndex="5" CssClass="Txtboxsmall"
                                                            meta:resourcekey="txtTelephoneNoResource1"></asp:TextBox>
                                    </td>
                                    <td id="tdaddtxt" runat="server" nowrap="nowrap">
                                                        <asp:Label ID="Label4" runat="server" nowrap="nowrap" Text="Collection Address" meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                    <td id="tdtxtAddress" runat="server">
                                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" MaxLength="250"
                                            TabIndex="6" meta:resourcekey="txtAddressResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td id="td2" runat="server">
                                                        <asp:Label ID="Label1" runat="server" Text="Location" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td id="td3" runat="server">
                                        <asp:TextBox ID="txtSuburb" CssClass="small" runat="server" MaxLength="250" TabIndex="7" meta:resourcekey="txtSuburbResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td id="td4" runat="server">
                                                        <asp:Label ID="Label2" runat="server" Text="City" meta:resourcekey="Label2Resource1"></asp:Label>
                                    </td>
                                    <td id="td5" runat="server">
                                        <asp:TextBox ID="txtCity" CssClass="small" runat="server" MaxLength="250" TabIndex="8" meta:resourcekey="txtCityResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td7" runat="server" style="display: none;">
                                    </td>
                                    <td id="td8" runat="server" style="display: none;">
                                    </td>
                                    <td id="td9" runat="server">
                                    </td>
                                    <td id="td10" runat="server">
                                    </td>
                                    <td id="td11" runat="server">
                                    </td>
                                    <td id="td12" runat="server">
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr id="loc" runat="server" class="w-50p">
                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text="Processing Centre" meta:resourcekey="Label5Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <span>
                                            <asp:DropDownList ID="ddlOrg" runat="server" TabIndex="11" Width="150px" normalWidth="150px"
                                                                CssClass="ddlsmall" onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);"
                                                                meta:resourcekey="ddlOrgResource1">
                                            </asp:DropDownList>
                                            <ajc:CascadingDropDown ID="CascadeddlOrg" runat="server" TargetControlID="ddlOrg"
                                                Category="Org" PromptText="------Select------" ServicePath="~/OPIPBilling.asmx"
                                                ServiceMethod="GetOrganizations" meta:resourcekey="cascadeddlOrg2Resource1" />
                                        </span>
                                    </td>
                                    <td id="tdloc1" runat="server" class="a-left">
                                                        <asp:Label ID="lblLocation" runat="server" Text="Collection Centre" meta:resourcekey="lblLocationResource1"></asp:Label>
                                    </td>
                                    <td id="tdloc2" runat="server" class="a-left">
                                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" TabIndex="12"
                                                            meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                        <ajc:CascadingDropDown ID="CascadeddlLoc" runat="server" TargetControlID="ddlLocation"
                                            ParentControlID="ddlOrg" PromptText="------Select------" ServiceMethod="GetLocationName"
                                            ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                            meta:resourcekey="cascadeddlLoc2Resource1" />
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td class="a-left">
                                                        <asp:Label ID="lblRole" runat="server" Text="Role" meta:resourcekey="lblRoleResource1"></asp:Label>
                                    </td>
                                    <td>
                                                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddlsmall" TabIndex="13" meta:resourcekey="ddlRoleResource1">
                                        </asp:DropDownList>
                                        <ajc:CascadingDropDown ID="CascadeddlRole" runat="server" TargetControlID="ddlRole"
                                            ParentControlID="ddlLocation" PromptText="------Select------" ServiceMethod="GetRoleName"
                                            ServicePath="~/OPIPBilling.asmx" Category="Role" LoadingText="[Loading Roles...]"
                                            meta:resourcekey="cascadeddlRole2Resource1" />
                                    </td>
                                    <td>
                                                        <asp:Label ID="lblUser" runat="server" Text="User" meta:resourcekey="lblUserResource1"></asp:Label>
                                    </td>
                                    <td>
                                                        <asp:DropDownList ID="ddlUser" runat="server" CssClass="ddlsmall" TabIndex="14" onchange="javascript:ChangeUsers();"
                                                            meta:resourcekey="ddlUserResource1">
                                        </asp:DropDownList>
                                        <ajc:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="ddlUser"
                                            ParentControlID="ddlRole" PromptText="------Select------" ServiceMethod="GetUserName"
                                            ServicePath="~/OPIPBilling.asmx" Category="User" LoadingText="[Loading Users...]"
                                            meta:resourcekey="cascadeddlUser2Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tdtime" runat="server" class="a-left">
                                        <asp:Label ID="Label3" runat="server" Text="Collection Time" meta:resourcekey="lblTimeResource1"></asp:Label>
                                    </td>
                                    <td id="tdtimetxt" runat="server">
                                        <asp:TextBox ID="txtTime" runat="server" Width="120px" ToolTip="Collection Date"
                                                            TabIndex="9" CssClass="Txtboxsmall" onblur="AdditionalDetails();" meta:resourcekey="txtTimeResource1"></asp:TextBox>
                                        <a href="javascript:NewCssCal('txtTime','ddmmyyyy','arrow',true,12)">
                                            <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                    </td>
                                    <td colspan="2" runat="server" id="tdChkNewPatient" style="display: none">
                                                        <asp:CheckBox ID="chkNewPatient" Text="New patient" runat="server" TabIndex="15"
                                                            meta:resourcekey="chkNewPatientResource1" />
                                    </td>
                                    <td id="tdStatus" runat="server">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatusResource1"></asp:Label>
                                    </td>
                                    <td id="tdddlStatus" runat="server">
                                        <asp:DropDownList ID="ddlStatus" runat="server" TabIndex="16" CssClass="ddlsmall">
                                                          <%--  <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Booked" Value="B" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="Registered" Value="R" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="Cancelled" Value="C" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr id="trserdate" runat="server" style="display: none;">
                                    <td colspan="4">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-6p">
                                                                    <asp:Label runat="server" ID="fromDate" Text="Booked From" CssClass="label_title"
                                                                        meta:resourcekey="fromDateResource1"></asp:Label>
                                                </td>
                                                <td class="w-9p">
                                                    <asp:TextBox ID="txtFrom" runat="server" Width="130px" TabIndex="14" MaxLength="1"
                                                                        Style="text-align: justify" ValidationGroup="MKE" CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                                </td>
                                                <td class="w-5p">
                                                                    <asp:Label runat="server" ID="toDate" Text="Booked To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                </td>
                                                <td class="w-12p">
                                                    <asp:TextBox ID="txtTo" runat="server" Width="130px" TabIndex="15" MaxLength="1"
                                                                        Style="text-align: justify" ValidationGroup="MKE" CssClass="Txtboxsmall" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date"></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="4">
                                    </td>
                                </tr>
                                <tr id="trcollect" style="display: none;">
                                    <td colspan="4">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-6p">
                                                                    <asp:Label runat="server" ID="lblcollfrom" Text="Coll From Dt" CssClass="label_title"
                                                                        meta:resourcekey="lblcollfromResource1"></asp:Label>
                                                </td>
                                                <td class="w-9p" id="tdCollect1" runat="server" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCollFrom" runat="server" Width="130px" TabIndex="17" MaxLength="1"
                                                                        Style="text-align: justify" CssClass="Txtboxsmall" meta:resourcekey="txtCollFromResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtCollFrom','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img4" alt="Pick a date"></a>
                                                </td>
                                                <td class="w-5p">
                                                                    <asp:Label runat="server" ID="lblcollto" Text="Coll To Dt" CssClass="label_title"
                                                                        meta:resourcekey="lblcolltoResource1"></asp:Label>
                                                </td>
                                                <td class="w-12p" id="tdCollect2" runat="server" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCollto" runat="server" Width="130px" TabIndex="18" MaxLength="1"
                                                                        Style="text-align: justify" CssClass="Txtboxsmall" meta:resourcekey="txtColltoResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtCollto','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img5" alt="Pick a date"></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="display: none">
                                        <asp:Label ID="Rs_ClientName" runat="server" Text="<u>C</u>lient Name" AssociatedControlID="txtClient"
                                                            AccessKey="C" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                    </td>
                                    <td style="display: none">
                                        <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                            ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                            Enabled="True" OnClientItemOver="SelectedTempClient">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr id="trBilling" runat="server" style="display: none">
                                    <td colspan="8">
                                        <BillingPart:BPart ID="billPart" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tdbtnSave" runat="server" colspan="9" class="a-center" style="display: none;">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClientClick="return validate();"
                                                        OnClick="btnSave_Click" Style="margin-left: 0px" TabIndex="17" meta:resourcekey="btnSaveResource1" />
                                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                                        Style="margin-left: 0px" TabIndex="17" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td id="tdbtnSearch" runat="server" colspan="2" align="center" class="style1" style="display: none;">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClick="btnSearch_Click"
                                                            TabIndex="18" meta:resourcekey="btnSearchResource1" />
                                    </td>
                                    <td id="tdbtnUpdate" runat="server" colspan="2" class="a-center">
                                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn" Text="Update" OnClick="btnUpdate_Click"
                                                            OnClientClick="return ValidateRegister();" TabIndex="18" meta:resourcekey="btnUpdateResource1" />
                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClientClick="return clearupdate();"
                                                            TabIndex="18" meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divPrint" style="display: none;" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-left paddingL10">
                                            <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                                runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                            <asp:ImageButton ID="btnConverttoXL" runat="server" OnClick="btnConverttoXL_Click"
                                                ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                        </td>
                                        <td class="a-right paddingL10">
                                            <b id="printText" runat="server">
                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                            &nbsp;&nbsp;
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return CallPrint();"
                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td colspan="10">
                                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                                            <ContentTemplate>
                                                <%--<asp:UpdateProgress ID="UpdateProgress12" AssociatedUpdatePanelID="updatePanel2" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage" width="60%">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>--%>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <div id="divPrintarea" runat="server" style="overflow: auto; height: 350px;">
                                                                <asp:GridView ID="grdResult" EmptyDataText="No Results Found." runat="server" OnRowDataBound="grdResult_RowDataBound"
                                                                    CssClass="mytable1 gridView" AutoGenerateColumns="False" meta:resourcekey="grdResultResource1"
                                                                    OnRowCommand="grdResult_RowCommand">
                                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                        PageButtonCount="5" PreviousPageText="" />
                                                                    <Columns>
                                                                        <asp:BoundField Visible="false" DataField="BookingID" HeaderText="HomeCollectionDetailsID"
                                                                            meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:BoundField Visible="false" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                                                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Patient" GroupName="PatientSelect"
                                                                                    meta:resourcekey="rdSelResource1" />
                                                                                <asp:HiddenField ID="GRhdnRoleID" runat="server" Value='<%# bind("RoleID") %>' />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="BookingID" HeaderText="Booking Number" meta:resourcekey="BoundFieldResource3" />
                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource3" />
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource4" />
                                                                                        <asp:BoundField DataField="Age" HeaderText="Age/Gender" meta:resourcekey="BoundFieldResource5" />
                                                                                        <asp:BoundField DataField="DOB" Visible="false" meta:resourcekey="BoundFieldResource6" />
                                                                                        <asp:BoundField DataField="PhoneNumber" HeaderText="Mobile No" meta:resourcekey="BoundFieldResource7" />
                                                                        <asp:BoundField DataField="CollectionTime" HeaderText="Collection Time" DataFormatString="{0:dd/MMM/yy hh:mm tt}"
                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                        <asp:BoundField DataField="CollectionAddress" HeaderText="Collection Address" meta:resourcekey="BoundFieldResource6" />
                                                                                        <asp:BoundField DataField="SourceType" HeaderText="Source Type" meta:resourcekey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource7" />
                                                                        <asp:BoundField DataField="UserName" HeaderText="User" meta:resourcekey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="BookingStatus" HeaderText="Status" meta:resourcekey="BoundFieldResource9" />
                                                                        <asp:BoundField DataField="City" meta:resourcekey="BoundFieldResource10" Visible="false" />
                                                                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="linkEdit" Text="Edit" CommandName="Edit" CommandArgument='<%#Eval("RoleID")+","+ Eval("UserID")%>'
                                                                                                    runat="server" meta:resourcekey="linkEditResource1" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                        <td class="defaultfontcolor a-center w-100p">
                                                                            <asp:Label ID="Label19" runat="server" Text="Page" meta:resourcekey="Label19Resource1"></asp:Label>
                                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                                            <asp:Label ID="Label20" runat="server" Text="Of" meta:resourcekey="Label20Resource1"></asp:Label>
                                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click"
                                                                                meta:resourcekey="btnPreviousResource1" />
                                                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"
                                                                                meta:resourcekey="btnNextResource1" />
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                            <asp:Label ID="Label21" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label21Resource1"></asp:Label>
                                                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" AutoComplete="off"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                                                OnClientClick="javascript:return validatePageNumber();" meta:resourcekey="btnGoResource1" />
                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr id="aRow" style="display: none;" runat="server">
                                    <td id="Td1" class="defaultfontcolor" runat="server" align="center">
                                        <asp:Label ID="Rs_Selectapatient" Text="Select a patient and one of the following"
                                            runat="server" meta:resourcekey="Rs_SelectapatientResource1" />
                                        <asp:DropDownList ID="dList" runat="server" meta:resourcekey="dListResource1" CssClass="ddlsmall">
                                        </asp:DropDownList>
                                        <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" OnClientClick="return ValidatePatientName()"
                                            onmouseover="this.className='btn btnhov'" TabIndex="19" onmouseout="this.className='btn'"
                                            OnClick="bGo_Click" meta:resourcekey="bGoResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
            </Triggers>
        </asp:UpdatePanel>
        <div id="divBillDes" runat="server" class="w-50p a-center" style="display: none;">
            <table class='dataheaderInvCtrl w-100p'>
                <tr>
                    <td colspan='3'>
                        <h3 align='center'>
                            <u>
                                <%--Service Quotation--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_002%>
                            </u>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%--Patient Name:--%>
                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_003%>
                        <asp:Label ID="lblPatientName" runat="server" Text="" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td>
                        <%--Sex:--%>
                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_004%>
                        <asp:Label ID="lblPatSex" runat="server" Text="" meta:resourcekey="lblPatSexResource1"></asp:Label>
                    </td>
                    <td>
                        <%-- Age:--%>
                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_005%>
                        <asp:Label ID="lblPatAge" runat="server" Text="" meta:resourcekey="lblPatAgeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%--Mobile Number:--%>
                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_006%>
                        <asp:Label ID="lblMobNo" runat="server" Text="" meta:resourcekey="lblMobNoResource1"></asp:Label>
                    </td>
                    <td>
                        <%--  Telephone:--%>
                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_007%>
                        <asp:Label ID="lblTpno" runat="server" Text="" meta:resourcekey="lblTpnoResource1"></asp:Label>
                    </td>
                    <td>
                        <%--  Email:--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_008%>
                        <asp:Label ID="lblEmail" runat="server" Text="" meta:resourcekey="lblEmailResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td class='a-left' colspan='3'>
                        <b>
                            <%--Client Name:--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_009%></b>
                        <asp:Label ID="lblFeeType" runat="server" Text="" meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
                <tr>
                    <td colspan='3'>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="grdBillDes" Width="87%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                ForeColor="#333333" CssClass="mytable1 gridView" meta:resourcekey="grdBillDesResource1">
                <HeaderStyle CssClass="dataheader1" />
                <Columns>
                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lbldes" runat="server" Text='<%# Eval("Description") %>' Font-Size="Small"
                                meta:resourcekey="lbldesResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rate" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblRate" runat="server" Text='<%# Eval("Rate") %>' Font-Size="Small"
                                meta:resourcekey="lblRateResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <table class="w-100p">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="a-right" colspan="2">
                        <table class="w-30p">
                            <tr>
                                <td>
                                    <b>
                                        <%--Gross: --%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_010%></b>
                                </td>
                                <td>
                                    <asp:Label ID="lblGrossValue" runat="server" Text="" meta:resourcekey="lblGrossValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--Discount:--%>
                                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_011%>
                                    </b>
                                </td>
                                <td>
                                    <asp:Label ID="lblDiscount" runat="server" Text="" meta:resourcekey="lblDiscountResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--Tax:--%>
                                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_012%>
                                    </b>
                                </td>
                                <td>
                                    <asp:Label ID="lblTax" runat="server" Text="" meta:resourcekey="lblTaxResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--ED Cess(2%): --%>
                                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_013%></b>
                                </td>
                                <td>
                                    <asp:Label ID="lblEDCess" runat="server" Text="" meta:resourcekey="lblEDCessResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--SHED Cess(1%):--%>
                                        <%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_014%>
                                    </b>
                                </td>
                                <td>
                                    <asp:Label ID="lblSHEDCess" runat="server" Text="" meta:resourcekey="lblSHEDCessResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--Service Charge: --%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_015%></b>
                                </td>
                                <td>
                                    <asp:Label ID="lblSerChrg" runat="server" Text="" meta:resourcekey="lblSerChrgResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--Round Off: --%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_016%>
                                    </b>
                                </td>
                                <td>
                                    <asp:Label ID="lblRounOff" runat="server" Text="" meta:resourcekey="lblRounOffResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    ---------
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <%--Net Amount: --%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_017%></b>
                                </td>
                                <td>
                                    <asp:Label ID="lblNetAmt" runat="server" Text="" meta:resourcekey="lblNetAmtResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    ---------
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='a-left'>
                                    <%--Quote Given By:--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_018%>
                                    <asp:Label ID="lblQuoteGivenby" runat="server" Text="" meta:resourcekey="lblQuoteGivenbyResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='a-left'>
                                    <%-- Quote Date:--%><%=Resources.Lab_ClientDisplay.Lab_homecollection_aspx_019%>
                                    <asp:Label ID="lblQuoteDate" runat="server" Text="" meta:resourcekey="lblQuoteDateResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField ID="hdnHomeCollDtdID" runat="server" />
    <asp:HiddenField ID="hdnPatientID" runat="server" />
    <asp:HiddenField ID="hdnDOB" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnPatientName" runat="server" />
    <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
    <asp:HiddenField ID="hdnstatus" runat="server" />
    <asp:HiddenField ID="hdnrdosave" runat="server" />
    <input id="hdnGender" runat="server" value="" type="hidden" />
    <asp:HiddenField ID="hdnrdosearch" runat="server" />
    <asp:HiddenField ID="hdnRoleUser" runat="server" />
    <%--  <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" />--%>
    <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
    <%--  <asp:HiddenField ID="hdnorgids1" runat="server" Value="0" />--%>
    <%--  <asp:HiddenField ID="hdnlocid" runat="server" Value="0" />--%>
    <asp:HiddenField ID="hdnBookingNumber" runat="server" />
    <asp:HiddenField ID="hdnSelectedBookingID" runat="server" />
    <asp:HiddenField ID="hdncurdatetime" runat="server" />
    <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
    <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
    <input type="hidden" runat="server" id="hdnRoundOffType" />
    <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
    <input id="hdnBookingID" runat="server" type="hidden" />
    <asp:HiddenField ID="hdnuserselectedval" Value="0" runat="server" />
    <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
    <asp:HiddenField ID="hdnDoFrmVisit" runat="server" />
    <asp:HiddenField ID="hdnDecimalAgeHC" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
<asp:HiddenField ID="hdnMessages" runat="server" />
<input id="hdnMRPBillDisplay" type="hidden" value="N" runat="server" /> 
<asp:HiddenField ID="hdnTestHistoryPatient" Value="" runat="server" />
    <asp:HiddenField ID="hdnPageType" runat="server" Value="DEOH" />
    <asp:HiddenField ID="hdnExternalBarcode" runat="server" Value="N" />
    <script language="javascript" type="text/javascript">
        function StatusAlert() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_03") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_03") : "Home collection for this Patient has been already completed";

            //alert('Home collection for this Patient has been already completed');
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            return false;
        }
        function ValidateDate() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_04") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_04") : "Enter Booked FromDate";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_homecollection_aspx_05") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_05") : "Enter Booked ToDate";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Lab_homecollection_aspx_06") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_06") : "Enter Collect FromDate";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Lab_homecollection_aspx_07") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_07") : "Enter Collect ToDate";


            if (document.getElementById("<%=txtFrom.ClientID%>").value == "") {
                //alert("Enter Booked FromDate");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            if (document.getElementById("<%=txtTo.ClientID%>").value == "") {
                //alert("Enter Booked ToDate");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;
            }
            if (document.getElementById("<%=txtCollFrom.ClientID%>").value == "") {
                //alert("Enter Collect FromDate");
                ValidationWindow(UsrAlrtMsg2,AlrtWinHdr);
                return false;
            }
            if (document.getElementById("<%=txtCollto.ClientID%>").value == "") {
                //alert("Enter Collect ToDate");
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                return false;
            }
        }
        function validatePageNumber() {
            if (document.getElementById('txtpageNo').value == "") {
                return false;
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
        dialogfunc();
});
        function IAmSelected(source, eventArgs) {

            var patient = eventArgs.get_value().split('~')
            var patientdetail = eventArgs.get_text().split('~');
            document.getElementById('hdnSelectedPatientID').value = patient[5];
            if (document.getElementById('hdnSelectedPatientID').value != '' && document.getElementById('hdnSelectedPatientID').value != null) {
                document.getElementById('tdChkNewPatient').style.display = 'none';
                document.getElementById('chkNewPatient').disabled = true;
            }
            else {
                document.getElementById('tdChkNewPatient').style.display = 'block';
                document.getElementById('chkNewPatient').checked = true;
                document.getElementById('chkNewPatient').disabled = false;
            }

            //document.getElementById('txtAddress').innerHTML = patient[0] + ',' + patient[1] + ',' + patient[2] + ',' + patient[3] + ',' + patient[4] + ',' + patient[5];
            document.getElementById('txtPatientName').value = patient[9];
            document.getElementById('txtAddress').innerHTML = patient[0];
            document.getElementById('txtSuburb').value = patient[1];
            document.getElementById('txtCity').value = patient[3];
            document.getElementById('txtDOBNos').value = patient[6];
            document.getElementById('txtMobile').value = patient[8];
            document.getElementById('txtTelephoneNo').value = patient[11];
            document.getElementById('txtCity').value = patient[2];
            var ageVal = patient[6].substr(0, 2);
            if (ageVal != '') {
                if (ageVal.length < 3) {
                    var days = new Date();
                    var gyear = days.getFullYear();
                    dobYear = gyear - ageVal;
                    document.getElementById('tDOB').value = '01/01/' + dobYear;
                }
            }
            document.getElementById('ddlSex').value = patient[7];

            document.getElementById('txtDOBNos').value = patient[6].split(' ')[0];
            document.getElementById('ddlDOBDWMY').value = patient[6].split(' ')[1];
            document.getElementById('ddlOrg').value = patient[14];
            document.getElementById('ddlLocation').value = patient[15];
            document.getElementById('ddlRole').value = patient[12];
            document.getElementById('ddlUser').value = patient[13];
            document.getElementById('hdnuserselectedval').value = patient[13];
            //            if (patient[12] != "0") {
            //                //loadUsers();
            //            }
            //            else {
            //                $('#ddlUser').append('<option value="0">--Select--</option>');
            //            }

        }
        function CheckDischarge() {
            NewCal('<%=txtTime.ClientID %>', 'ddmmyyyy', true, 12, 'N', 'N')
            // NewCssCal('<% = txtTime.ClientID %>', 'ddmmyyyy', 'arrow', true, 12, 'Y', 'Y')
        }
        function CheckFromDate() {
            NewCal('<%=txtFrom.ClientID %>', 'ddmmyyyy', true, 12, 'N', 'N')
            // NewCssCal('<% = txtTime.ClientID %>', 'ddmmyyyy', 'arrow', true, 12, 'Y', 'Y')
        }
        function CheckToDate() {
            NewCal('<%=txtTo.ClientID %>', 'ddmmyyyy', true, 12, 'N', 'N')
            // NewCssCal('<% = txtTime.ClientID %>', 'ddmmyyyy', 'arrow', true, 12, 'Y', 'Y')
        }
        function CheckCollDate() {
            NewCal('<%=txtCollFrom.ClientID %>', 'ddmmyyyy', true, 12, 'N', 'N')
            // NewCssCal('<% = txtTime.ClientID %>', 'ddmmyyyy', 'arrow', true, 12, 'Y', 'Y')
        }
        function CheckCollto() {
            NewCal('<%=txtCollto.ClientID %>', 'ddmmyyyy', true, 12, 'N', 'N')
            // NewCssCal('<% = txtTime.ClientID %>', 'ddmmyyyy', 'arrow', true, 12, 'Y', 'Y')
        }

        function SelectRow(rid, HomeCollDtdID, PID, status, PName, BookingNumber) {

            chosen = "";

            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('<%= hdnHomeCollDtdID.ClientID %>').value = HomeCollDtdID;
            document.getElementById('<%= hdnPatientID.ClientID %>').value = PID;
            document.getElementById('<%= hdnstatus.ClientID %>').value = status;
            document.getElementById('<%= hdnPatientName.ClientID %>').value = PName;
            document.getElementById('<%= hdnBookingNumber.ClientID %>').value = BookingNumber;

        }
        function SelectedPatient(BookingID, BookingStatus, PatientName, Age, DOB, SEX, PhoneNumber, CollectionAddress, CollectionAddress2, City, CollectionTime, LandLineNumber, RoleID, UserID, BookingOrgID, OrgAddressID) {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_08") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_08") : "The patient has been already registered you cannot Edit";
	
            if (BookingStatus == 'Registered') {
                //alert('The patient has been already registered you cannot Edit');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            if (BookingStatus == 'Cancelled') {
                //alert('The patient has been already cancelled you cannot Edit');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            $("#ddlStatus option[value='R']").attr("disabled", "disabled");

            showEdit();
            document.getElementById('<%= hdnSelectedBookingID.ClientID %>').value = BookingID;
            document.getElementById('<%= txtPatientName.ClientID %>').value = PatientName;
            document.getElementById('<%= txtDOBNos.ClientID %>').value = Age.split(' ')[0];
            document.getElementById('<%= ddlSex.ClientID %>').value = Age.split('/')[1];
            document.getElementById('<%= tDOB.ClientID %>').value = DOB;
            document.getElementById('<%= txtMobile.ClientID %>').value = PhoneNumber;
            document.getElementById('<%= txtTelephoneNo.ClientID %>').value = LandLineNumber;
            document.getElementById('<%= txtAddress.ClientID %>').value = CollectionAddress.split('~')[0];

            document.getElementById('<%= txtSuburb.ClientID %>').value = CollectionAddress.split('~')[1];
            document.getElementById('<%= txtCity.ClientID %>').value = CollectionAddress.split('~')[2];
            document.getElementById('<%= txtTime.ClientID %>').value = CollectionTime;

            document.getElementById('<%= ddlOrg.ClientID %>').value = BookingOrgID;
            // loadlocations();
            document.getElementById('<%= ddlLocation.ClientID %>').value = OrgAddressID;
            // loadRole();
            document.getElementById('<%= ddlRole.ClientID %>').value = RoleID;
            // loadUsers();
            document.getElementById('<%= ddlUser.ClientID %>').value = UserID;
            document.getElementById('hdnuserselectedval').value = UserID;

            //            if (UserID != "0") {

            //            }
            //            else {
            //                $('#ddlUser').append('<option value="0">--Select--</option>');
            //            }

            //            document.getElementById('<%= ddlRole.ClientID %>').value = RoleID;
            //            document.getElementById('<%= ddlUser.ClientID %>').value = UserID;

            if (BookingStatus == 'Booked') {
                document.getElementById('<%= ddlStatus.ClientID %>').value = "B";
            }
            else if (BookingStatus == 'Registered') {
                document.getElementById('<%= ddlStatus.ClientID %>').value = "R";
            }
            else {
                document.getElementById('<%= ddlStatus.ClientID %>').value = "C";
            }

        }
        function ValidatePatientName() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_09") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_09") : "Select patient name";
            if (document.getElementById('hdnPatientID').value == '') {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                //alert('Select patient name');
                return false;
            }

            return CheckVisitID();
        }
        function CheckVisitID() {

            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_10") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_10") : "Selected Patient has been already Investigated";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_homecollection_aspx_11") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_11") : "Selected Patient Booking already Cancelled";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Lab_homecollection_aspx_12") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_12") : "Selected Patient has been already Cancelled";
	
            var ddlaction = document.getElementById('dList')

            if (ddlaction.options[ddlaction.selectedIndex].text == 'Make Visit Entry') {
                if (document.getElementById('hdnstatus').value == 'Registered') {
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //alert('Selected Patient has been already Investigated');
                    return false;
                }
                if (document.getElementById('hdnstatus').value == 'Cancelled') {
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    //alert('Selected Patient Booking already Cancelled');
                    return false;
                }
            }
            else if (ddlaction.options[ddlaction.selectedIndex].text == 'Register Home Collection') {
                if (document.getElementById('hdnstatus').value == 'Cancelled') {
                    //alert('Selected Patient has been already Cancelled');
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    return false;
                }
            }

        }

        function ValidateIsNewPatient() {
            if (document.getElementById('rdoPatientSave').checked == true) {
                if (document.getElementById('hdnSelectedPatientID').value == '' || document.getElementById('hdnSelectedPatientID').value == null) {
                    document.getElementById('tdChkNewPatient').style.display = 'block';
                }
            }
        }
        function Clear() {
            document.getElementById('hdnSelectedPatientID').value = '';
        }
        function showEdit() {

            document.getElementById('tbmain').style.display = 'table';
            document.getElementById('tdStatus').style.display = 'table-cell';
            document.getElementById('tdddlStatus').style.display = 'table-cell';
            document.getElementById('tdaddtxt').style.display = 'table-cell';
            document.getElementById('tdtxtAddress').style.display = 'table-cell';
            document.getElementById('tdbtnSearch').style.display = 'none';
            document.getElementById('tdbtnUpdate').style.display = 'table-cell';
            document.getElementById('tdbtnSave').style.display = 'none';
            document.getElementById('trserdate').style.display = 'none';
            document.getElementById('trcollect').style.display = 'none';
            document.getElementById('tdtime').style.display = 'table-cell';
            document.getElementById('tdtimetxt').style.display = 'table-cell';

            document.getElementById('trSaveDate').style.display = 'table-row';
            document.getElementById('tdsex1').style.display = 'table-cell';
            document.getElementById('tdsex2').style.display = 'table-cell';
            document.getElementById('tdAge1').style.display = 'table-cell';
            document.getElementById('tdAge2').style.display = 'table-cell';
            document.getElementById('tdChkNewPatient').style.display = 'none';
            document.getElementById('tdBookingNo1').style.display = 'none';
            document.getElementById('tdBookingNo2').style.display = 'none';
            document.getElementById('txtCollFrom').style.display = 'none';
            document.getElementById('txtCollto').style.display = 'none';
            document.getElementById('lblcollfrom').style.display = 'none';
            document.getElementById('lblcollto').style.display = 'none';
            document.getElementById('GrdFooter').style.display = 'none';
            document.getElementById('trBilling').style.display = 'none';
            //  document.getElementById('loc').style.display = 'none'; 
            document.getElementById('tdCollect1').style.display = 'none';
            document.getElementById('tdCollect2').style.display = 'none';

        }

        function showsave() {

            if (document.getElementById('rdoPatientSave').checked = true) {
                document.getElementById('rdoPatientSearch').checked = false;
                document.getElementById('tbmain').style.display = 'table';
                document.getElementById('tdStatus').style.display = 'none';
                document.getElementById('tdddlStatus').style.display = 'none';
                document.getElementById('tdaddtxt').style.display = 'table-cell';
                document.getElementById('tdtxtAddress').style.display = 'table-cell';
                document.getElementById('tdbtnSearch').style.display = 'none';
                document.getElementById('tdbtnSave').style.display = 'table-cell';
                document.getElementById('trserdate').style.display = 'none';
                document.getElementById('trcollect').style.display = 'none';
                document.getElementById('tdtime').style.display = 'table-cell';
                document.getElementById('tdtimetxt').style.display = 'table-cell';
                document.getElementById('tdCollect1').style.display = 'none';
                document.getElementById('tdCollect2').style.display = 'none';
                document.getElementById('tdbtnUpdate').style.display = 'none';

                document.getElementById('trSaveDate').style.display = 'table-row';
                document.getElementById('tdsex1').style.display = 'table-cell';
                document.getElementById('tdsex2').style.display = 'table-cell';
                document.getElementById('tdAge1').style.display = 'table-cell';
                document.getElementById('tdAge2').style.display = 'table-cell';
                document.getElementById('tdloc1').style.display = 'table-cell';
                document.getElementById('tdloc2').style.display = 'table-cell';
                document.getElementById('tdChkNewPatient').style.display = 'table-cell';
                document.getElementById('tdBookingNo1').style.display = 'none';
                document.getElementById('tdBookingNo2').style.display = 'none';
                document.getElementById('txtCollFrom').style.display = 'none';
                document.getElementById('txtCollto').style.display = 'none';
                document.getElementById('lblcollfrom').style.display = 'none';
                document.getElementById('lblcollto').style.display = 'none';
                document.getElementById('GrdFooter').style.display = 'none';
                document.getElementById('trBilling').style.display = 'table-row';
                document.getElementById('loc').style.display = 'table-row';
                document.getElementById('imgMan').style.display = 'inline';
                //document.getElementById('imgMan1').style.display = 'block';

            }

        }
        function clearupdate() {
            showsearch();
            document.getElementById('<%= hdnSelectedBookingID.ClientID %>').value = 0;
            document.getElementById('<%= txtPatientName.ClientID %>').value = '';
            document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
            document.getElementById('<%= ddlSex.ClientID %>').value = 'M';
            document.getElementById('<%= txtMobile.ClientID %>').value = '';
            document.getElementById('<%= txtTelephoneNo.ClientID %>').value = '';
            document.getElementById('<%= txtAddress.ClientID %>').value = '';

            document.getElementById('<%= txtSuburb.ClientID %>').value = '';
            document.getElementById('<%= txtCity.ClientID %>').value = '';
            document.getElementById('<%= txtTime.ClientID %>').value = document.getElementById('<%= hdncurdatetime.ClientID %>').value;
            document.getElementById('<%= ddlStatus.ClientID %>').value = '0';
            //            document.getElementById('<%= ddlRole.ClientID %>').value = '0';
            //            document.getElementById('<%= ddlUser.ClientID %>').value = '0';
            //            document.getElementById('<%= ddlLocation.ClientID %>').value = '0';
            return false;
        }
        function showsearch() {


            if (document.getElementById('rdoPatientSearch').checked = true) {
                document.getElementById('rdoPatientSave').checked = false;
                document.getElementById('tbmain').style.display = 'table';
                document.getElementById('tdStatus').style.display = 'table-cell';
                document.getElementById('tdddlStatus').style.display = 'table-cell';
                document.getElementById('tdBookingNo1').style.display = 'table-cell';
                document.getElementById('tdBookingNo2').style.display = 'table-cell';
                document.getElementById('txtCollFrom').style.display = 'inline';
                document.getElementById('txtCollto').style.display = 'inline';
                document.getElementById('lblcollfrom').style.display = 'block';
                document.getElementById('lblcollto').style.display = 'block';
                document.getElementById('tdbtnSearch').style.display = 'table-cell';
                document.getElementById('trserdate').style.display = 'table-row';
                document.getElementById('trcollect').style.display = 'table-row';
                document.getElementById('loc').style.display = 'table-row';
                document.getElementById('tdCollect1').style.display = 'table-cell';
                document.getElementById('tdCollect2').style.display = 'table-cell';
                document.getElementById('tdloc1').style.display = 'table-cell';
                document.getElementById('tdloc2').style.display = 'table-cell';
                //document.getElementById('imgMan1').style.display = 'none';


                //document.getElementById('imgMan1').style.display = 'none';
                document.getElementById('tdtime').style.display = 'none';
                document.getElementById('tdtimetxt').style.display = 'none';
                document.getElementById('tdbtnUpdate').style.display = 'none';
                document.getElementById('imgMan').style.display = 'none';
                document.getElementById('tdaddtxt').style.display = 'none';
                document.getElementById('tdtxtAddress').style.display = 'none';
                document.getElementById('tdbtnSave').style.display = 'none';
                document.getElementById('trSaveDate').style.display = 'none';
                document.getElementById('tdsex1').style.display = 'none';
                document.getElementById('tdsex2').style.display = 'none';
                document.getElementById('tdAge1').style.display = 'none';
                document.getElementById('tdAge2').style.display = 'none';

                document.getElementById('tdChkNewPatient').style.display = 'none';

                document.getElementById('trBilling').style.display = 'none';

            }

        }
        function validate() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_13") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_13") : "Please Enter a Patient Name";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_homecollection_aspx_14") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_14") : "Select patient sex";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Lab_homecollection_aspx_15") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_15") : "Please Enter a Patient Age";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Lab_homecollection_aspx_16") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_16") : "Please Enter a City";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Lab_homecollection_aspx_17") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_17") : "Please Enter Patient\'s Collection Address";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Lab_homecollection_aspx_18") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_18") : "Enter the Mobile Number";
            var UsrAlrtMsg6 = SListForAppMsg.Get("Lab_homecollection_aspx_19") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_19") : "Please Select a Organization";
            var UsrAlrtMsg7 = SListForAppMsg.Get("Lab_homecollection_aspx_20") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_20") : "Please Select a Location";
            var UsrAlrtMsg8 = SListForAppMsg.Get("Lab_homecollection_aspx_21") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_21") : "Please Select a Role";
            var UsrAlrtMsg9 = SListForAppMsg.Get("Lab_homecollection_aspx_22") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_22") : "Please Select a User";
            var UsrAlrtMsg10 = SListForAppMsg.Get("Lab_homecollection_aspx_23") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_23") : "Add Test to Book";
            var UsrAlrtMsg11 = SListForAppMsg.Get("Lab_homecollection_aspx_24") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_24") : "Please Enter The Sample Collection Time";
            
            
            
            
	
            if (document.getElementById('hdnSelectedPatientID').value != '' && document.getElementById('hdnSelectedPatientID').value != null) {
                document.getElementById('tdChkNewPatient').style.display = 'none';
                document.getElementById('chkNewPatient').disabled = true;
            }
            else {
                document.getElementById('tdChkNewPatient').style.display = 'table-cell';
                document.getElementById('chkNewPatient').checked = true;
                document.getElementById('chkNewPatient').disabled = false;
            }
            if (document.getElementById('txtPatientName').value == '') {
                //alert('Please Enter a Patient Name');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtPatientName').focus();
                return false;
            }
            if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                //alert('Select patient sex');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                document.getElementById('ddlSex').focus();
                return false;

            }
            if (document.getElementById('txtDOBNos').value == '') {
                //alert('Please Enter a Patient Age');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if (document.getElementById('txtCity').value == '') {
                // alert('Please Enter a City');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                document.getElementById('txtCity').focus();
                return false;
            }
            if (document.getElementById('txtAddress').value == '') {
                //alert('Please Enter Patient\'s Collection Address');
                ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                document.getElementById('txtAddress').focus();
                return false;
            }

            if (document.getElementById('txtMobile').value == '') {
                //alert('Enter the Mobile Number');
                ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                document.getElementById('txtMobile').focus();
                return false;
            }
            var ddlaction = document.getElementById('ddlOrg');
            if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
                //alert('Please Select a Organization');
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                return false;
            }

            var ddlLocation = document.getElementById('ddlLocation');
            if (ddlLocation.options[ddlLocation.selectedIndex].text == '--Select--') {
                //alert('Please Select a Location');
                ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
                document.getElementById('ddlLocation').focus();
                return false;
            }

            if (document.getElementById('ddlRole').options[document.getElementById('ddlRole').selectedIndex].text == '--Select--') {
                //alert('Please Select a Role');
                ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
                return false;
            }
            if (document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].text == '--Select--') {
                // alert('Please Select a User');

                ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
                return false;
            }

            if ($.trim($('[id$="hdfBillType1"]').val()) == '') {
                //alert('Add Test to Book');
                ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
                return false;
            }

            if (document.getElementById('txtTime').value == '') {
                //alert('Please Enter The Sample Collection Time');
                ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                return false;
            }
            else {
                return ForFutureDate();
            }

        }


        ///////////
        function ShowUserForRole(ID) {
            /*****************Modified by Arivalagan.KK*****************/
            //            var ddl = document.getElementById('ddlRole');
            //            if (ddl.count > 0) {
            //                var seletedRole = ddl.options[ddl.selectedIndex].value;
            //            }

            var ddl = $('#ddlRole').val();
            if (ddl != 0) {
                var seletedRole = $('#ddlRole').val();
            }
            var rawdata = new Array();
            var ddldata = new Array();
            rawdata = document.getElementById('hdnRoleUser').value.split('^');
            var ddlUser = document.getElementById('ddlUser');
            for (i = ddlUser.length - 1; i >= 0; i--) {
                ddlUser.options[i] = null;
            }

            var opt = document.createElement("option");
            opt.text = '--Select--';
            opt.value = 0;
            document.getElementById('ddlUser').options.add(opt);
            for (var i = 0; i < rawdata.length; i++) {
                ddldata = rawdata[i].split('~');
                if (ddldata[0] == seletedRole) {
                    AddItem(ddldata[2], ddldata[1])
                }
            }
            /*****************End Modified by Arivalagan.KK*****************/
        }
        function AddItem(Text, Value) {
            var opt = document.createElement("option");
            opt.text = Text;
            opt.value = Value;
            document.getElementById('ddlUser').options.add(opt);
        }
        function getUservalue() {
            var ddlUser = document.getElementById('ddlUser');
            var seletedUser = ddlUser.options[ddlUser.selectedIndex].value;
            document.getElementById('hdnUserID').value = seletedUser;
        }
        function resetsave() {

            if (document.getElementById('grdResult') != null && document.getElementById('grdResult') != "") {
                document.getElementById('grdResult').style.display = 'none';
                document.getElementById('divPrint').style.display = 'none';
                document.getElementById('divPrintarea').style.display = 'none';
                document.getElementById('aRow').style.display = 'none';
                document.getElementById('tdBookingNo1').style.display = 'none';
                document.getElementById('tdBookingNo2').style.display = 'none';
            }
            //            document.form1.ddlOrg.selectedindex = 0;
            //            //document.form1.ddlOrg.options[0].selected = true;
            //            document.form1.ddlLocation.selectedindex = 0;
            //            document.form1.ddlRole.selectedindex = 0;
            //            // document.form1.ddlRole.options[0].selected = true;
            //            document.form1.ddlUser.selectedindex = 0;

            // document.form1.ddlUser.options[0].selected = true;
            //            document.form1.ddlLocation.selectedindex = 0;
            //            document.form1.ddlLocation.options[0].selected = true;
            //            document.getElementById('txtPatientName').value = "";
            //            document.getElementById('txtAddress').value = "";
            //            document.getElementById('txtSuburb').value = "";
            //            document.getElementById('txtCity').value = "";
            //            document.getElementById('txtDOBNos').value = "";
            //            document.getElementById('txtMobile').value = "";
            //            document.getElementById('ddlSex').value = "0";
            //            //document.getElementById('ddlLocation').value = "0";
            //            document.getElementById('hdnSelectedPatientID').value = "";
            //            document.getElementById('hdnPatientID').value = "";
            //            document.getElementById('hdnPatientName').value = "";
            //            document.getElementById('hdnBookingNumber').value = "";
            //CheckDischarge();
            getdatetime();
            document.getElementById('txtPatientName').focus();
        }
        function resetsearch() {

            if (document.getElementById('grdResult') != null && document.getElementById('grdResult') != "") {
                document.getElementById('grdResult').style.display = 'none';
                document.getElementById('divPrint').style.display = 'none';
                document.getElementById('divPrintarea').style.display = 'none';
                document.getElementById('aRow').style.display = 'none';
                //                document.form1.ddlOrg.selectedindex = 0;
                //                document.form1.ddlOrg.options[0].selected = true;

            }
            document.getElementById('tdBookingNo1').style.display = 'table-cell';
            document.getElementById('tdBookingNo2').style.display = 'table-cell';
            //            document.form1.ddlLocation.selectedindex = 0;
            //            document.form1.ddlRole.selectedindex = 0;
            //            // document.form1.ddlRole.options[0].selected = true;
            //            document.form1.ddlUser.selectedindex = 0;
            // document.form1.ddlUser.options[0].selected = true;
            //            document.form1.ddlLocation.selectedindex = 0;
            //            document.form1.ddlLocation.options[0].selected = true;
            document.getElementById('txtPatientName').value = "";
            document.getElementById('txtAddress').value = "";
            document.getElementById('txtSuburb').value = "";
            document.getElementById('txtCity').value = "";
            document.getElementById('txtDOBNos').value = "";
            document.getElementById('txtMobile').value = "";
            document.getElementById('txtTelephoneNo').value = "";
            document.getElementById('ddlSex').value = "0";
            //document.getElementById('ddlLocation').value = "0";
            document.getElementById('hdnSelectedPatientID').value = "";
            document.getElementById('hdnPatientID').value = "";
            document.getElementById('hdnPatientName').value = "";
            document.getElementById('hdnBookingNumber').value = "";
            //            addDate();
            document.getElementById('txtPatientName').focus();
        }
        function addDate() {
            date = new Date();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var year = date.getFullYear();
            document.getElementById('txtFrom').value = day + '/' + month + '/' + year;
            document.getElementById('txtTo').value = day + '/' + month + '/' + year;
        }
        function getdatetime() {
            datetime = new Date();
            var month = datetime.getMonth() + 1;
            var day = datetime.getDate();
            var year = datetime.getFullYear();
            var time = datetime.getTime();
            var hour = datetime.getHours();
            var min = datetime.getMinutes();
            var sec = datetime.getSeconds();

            var ap = "AM";
            if (hour > 11) { ap = "PM"; }
            if (hour > 12) { hour = hour - 12; }
            if (hour == 0) { hour = 12; }

            //  document.getElementById('txtTime').value = day + '/' + month + '/' + year + ' ' + hour + ':' + min + ':' + sec + ' ' + ap;
        }

        function CheckDates(splitChar) {
            //
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_25") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_25") : "Select From Date!";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_homecollection_aspx_26") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_26") : "Select To Date!!";
	
	
            var today = new Date();
            var now = today.getDate() + splitChar + (today.getMonth() + 1) + splitChar + today.getFullYear();
            if (document.getElementById('txtFrom').value == '') {
                //alert('Select From Date!');

                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
            //alert('Select To Date!');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                DateNow = now.split(splitChar);
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                //                if (doDateValidation(DateTo, DateNow, 0)) {
                //                    if (doDateValidation(DateFrom, DateTo, 1)) {
                //                        //alert("Validation Succeeded");

                //                        return true;
                //                    }
                //                    else {
                //                        return false;
                //                    }
                //                }
                //                else {
                //                    return false;
                //}
            }
        }
        function doDateValidation(from, to, bit) {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_27") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_27") : "Mismatch Day Between Current & To Date";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_homecollection_aspx_28") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_28") : "Mismatch Day Between From & To Date";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Lab_homecollection_aspx_29") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_29") : "Mismatch Month Between Current & To Date";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Lab_homecollection_aspx_30") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_30") : "Mismatch Month Between From & To Date";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Lab_homecollection_aspx_31") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_31") : "Mismatch Year Between Current & To Date";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Lab_homecollection_aspx_32") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_32") : "Mismatch Year Between From & To Date";
            
            
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                //alert('Mismatch Day Between Current & To Date');
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                            }
                            else {
                                //alert('Mismatch Day Between From & To Date');
                                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        // alert('Mismatch Month Between Current & To Date');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    }
                    else {
                        //alert('Mismatch Month Between From & To Date');
                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    //alert('Mismatch Year Between Current & To Date');
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                }
                else {
                    // alert('Mismatch Year Between From & To Date');
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                }
                return false;
            }
        }

        function hideColumn() {
            var col_num = 0;
            rows = document.getElementById("grdResult").rows;
            for (i = 0; i < rows.length; i++) {
                rows[i].cells[col_num].style.display = "none";
            }
            for (i = 0; i < rows.length; i++) {
                rows[i].cells[11].style.display = "none";
            }
        }
        function ShowColumn() {
            var col_num = 0;
            rows = document.getElementById("grdResult").rows;
            for (i = 0; i < rows.length; i++) {
                rows[i].cells[col_num].style.display = "block";
            }
            for (i = 0; i < rows.length; i++) {
                rows[i].cells[11].style.display = "block";
            }
        }


        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }

    </script>

    <script type="text/javascript">
        function expandDropDownListPage(elementRef) {
            elementRef.style.width = '400px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;

        }
        function clearClick() {
            var tt = SListForAppMsg.Get("Lab_homecollection_aspx_Confirm") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_Confirm") : "Are you sure you want to clear?";
//            var ok = SListForAppMsg.Get("Lab_homecollection_aspx_ok") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_ok") : "ok";
//            var cancel = SListForAppMsg.Get("Lab_homecollection_aspx_Cancel") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_Cancel") : "cancel";
            if (ConfirmWindow( tt))
            //if (ConfirmWindow(message, tt, btnoktext, btnclosetext))
             {
                document.getElementById('<%= hdnSelectedBookingID.ClientID %>').value = 0;
                document.getElementById('<%= txtPatientName.ClientID %>').value = '';
                document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
                document.getElementById('<%= ddlSex.ClientID %>').value = 'M';
                document.getElementById('<%= txtMobile.ClientID %>').value = '';
                document.getElementById('<%= txtAddress.ClientID %>').value = '';
                document.getElementById('<%= txtTelephoneNo.ClientID %>').value = '';
                document.getElementById('<%= txtSuburb.ClientID %>').value = '';
                document.getElementById('<%= txtCity.ClientID %>').value = '';
                document.getElementById('<%= txtTime.ClientID %>').value = document.getElementById('<%= hdncurdatetime.ClientID %>').value;
                document.getElementById('<%= ddlStatus.ClientID %>').value = '0';
                //                document.getElementById('<%= ddlOrg.ClientID %>').value = '0';
                //                document.getElementById('<%= ddlRole.ClientID %>').value = '0';
                //                document.getElementById('<%= ddlUser.ClientID %>').value = '0';
                //                document.getElementById('<%= ddlLocation.ClientID %>').value = '0';

                clearBillPart();
                return false;
            }
            else {
                return false;
            }
        }
        function clearBillPart() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_homecollection_aspx_33") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_33") : "Booked Patient Cannot Changed to Registered Here!!";
	
            document.getElementById('billPart_txtTestName').value = '';
            document.getElementById('billPart_divItemTable').value = '';
            document.getElementById('billPart_txtAuthorised').value = '';
            document.getElementById('billPart_txtPatientHistory').value = '';
            document.getElementById('billPart_txtGross').value = '0.00';
            ToTargetFormat($("#billPart_txtGross"));
            document.getElementById('billPart_hdnGrossValue').value = '0.00';
            ToTargetFormat($("#billPart_hdnGrossValue"));
            document.getElementById('billPart_txtDiscount').value = '0.00';
            ToTargetFormat($("#billPart_txtDiscount"));
            document.getElementById('billPart_txtDiscountReason').value = '0.00';
            ToTargetFormat($("#billPart_txtDiscountReason"));
            document.getElementById('billPart_hdnDiscountAmt').value = '0.00';
            ToTargetFormat($("#billPart_hdnDiscountAmt"));
            document.getElementById('billPart_txtTax').value = '0.00';
            ToTargetFormat($("#billPart_txtTax"));
            document.getElementById('billPart_hdnTaxAmount').value = '0.00';
            ToTargetFormat($("#billPart_hdnTaxAmount"));
            document.getElementById('billPart_hdfTax').value = '0.00';
            ToTargetFormat($("#billPart_hdfTax"));
            document.getElementById('billPart_txtServiceCharge').value = '0.00';
            ToTargetFormat($("#billPart_txtServiceCharge"));
            document.getElementById('billPart_hdnServiceCharge').value = '0.00';
            ToTargetFormat($("#billPart_hdnServiceCharge"));
            document.getElementById('billPart_txtRoundoffAmt').value = '0.00';
            ToTargetFormat($("#billPart_txtRoundoffAmt"));
            document.getElementById('billPart_hdnRoundOff').value = '0.00';
            ToTargetFormat($("#billPart_hdnRoundOff"));
            document.getElementById('billPart_txtNetAmount').value = '0.00';
            ToTargetFormat($("#billPart_txtNetAmount"));
            document.getElementById('billPart_hdnNetAmount').value = '0.00';
            ToTargetFormat($("#billPart_hdnNetAmount"));
            document.getElementById('billPart_txtAmtReceived').value = '0.00';
            ToTargetFormat($("#billPart_txtAmtReceived"));
            document.getElementById('billPart_hdnDiscountableTestTotal').value = '0.00';
            ToTargetFormat($("#billPart_hdnDiscountableTestTotal"));
            document.getElementById('billPart_hdnAmountReceived').value = '0.00';
            ToTargetFormat($("#billPart_hdnAmountReceived"));
            document.getElementById('billPart_txtDue').value = '0.00';
            ToTargetFormat($("#billPart_txtDue"));
            document.getElementById('billPart_hdnDue').value = '0.00';
            ToTargetFormat($("#billPart_hdnDue"));
            document.getElementById('billPart_hdfBillType1').value = '';
            ToTargetFormat($("#billPart_hdfBillType1"));
            document.getElementById('billPart_hdnName').value = '';
            document.getElementById('billPart_hdnID').value = '';
            document.getElementById('billPart_hdnReportDate').value = '';
            ToTargetFormat($("#billPart_hdnReportDate"));
            document.getElementById('billPart_hdnRemarks').value = '';
            document.getElementById('billPart_hdnIsRemimbursable').value = '';
            ToTargetFormat($("#billPart_hdnIsRemimbursable"));
            document.getElementById('billPart_hdnPaymentControlReceivedtemp').value = '';
            ToTargetFormat($("#billPart_hdnPaymentControlReceivedtemp"));
            document.getElementById('billPart_hdnAmt').value = '0.00';
            ToTargetFormat($("#billPart_hdnAmt"));
            document.getElementById('billPart_ddDiscountPercent').value = '0';
            ToTargetFormat($("#billPart_ddDiscountPercent"));
            document.getElementById('billPart_hdnActualAmount').value = '0.00';
            ToTargetFormat($("#billPart_hdnActualAmount"));
            document.getElementById('billPart_ddlDiscountReason').value = '0';
            ToTargetFormat($("#billPart_ddlDiscountReason"));
            document.getElementById('billPart_hdnIsDiscount').value = 'N';
            ToTargetFormat($("#billPart_hdnIsDiscount"));
            document.getElementById('billPart_hdnFeeTypeSelected').value = 'COM';
            ToTargetFormat($("#billPart_hdnFeeTypeSelected"));
            document.getElementById('billPart_hdnIsRepeatable').value = 'Y';
            ToTargetFormat($("#billPart_hdnIsRepeatable"));
            document.getElementById('billPart_hdnIsRepeatable').value = 'N';
            ToTargetFormat($("#billPart_hdnIsRepeatable"));
            document.getElementById('billPart_lblPreviousDueText').value = '0.00';
            ToTargetFormat($("#billPart_lblPreviousDueText"));
            document.getElementById('billPart_ddlTaxPercent').value = '0';
            ToTargetFormat($("#billPart_ddlTaxPercent"));
            document.getElementById('billPart_txtEDCess').value = '0.00';
            ToTargetFormat($("#billPart_txtEDCess"));
            document.getElementById('billPart_hdnEDCess').value = '0.00';
            ToTargetFormat($("#billPart_hdnEDCess"));
            document.getElementById('billPart_txtSHEDCess').value = '0.00';
            ToTargetFormat($("#billPart_txtSHEDCess"));
            document.getElementById('billPart_hdnSHEDCess').value = '0.00';
            ToTargetFormat($("#billPart_hdnSHEDCess"));
            document.getElementById('billPart_hdnfinduplicate').value = '';
            ToTargetFormat($("#billPart_hdnfinduplicate"));
            document.getElementById('billPart_ddlDiscountReason').disabled = true;
            document.getElementById('billPart_ddlTaxPercent').disabled = true
            document.getElementById('billPart_ddDiscountPercent').disabled = true
            document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
            document.getElementById('billPart_chkEDCess').checked = false;
            document.getElementById('billPart_chkSHEDCess').checked = false;
            document.getElementById('billPart_txtRemarks').value = '';
            document.getElementById('billPart_hdnIsInvestigationAdded').value = '0';
            document.getElementById('billPart_divItemTable').innerHTML = "";
            defaultbillflag = 0
        }
        function ValidateRegister() {

            if (document.getElementById('<%= ddlStatus.ClientID %>').value == "R") {
                //alert("Booked Patient Cannot Changed to Registered Here!!")
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }

        }
    </script>

    </form>
</body>
</html>
