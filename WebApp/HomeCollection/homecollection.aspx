<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="homecollection.aspx.cs" Inherits="HomeCollection_homecollection" meta:resourcekey="PageResource1" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/SampleCollectionPerson/Controls/SPBookingSlot.ascx" TagName="Schd"
    TagPrefix="SCPBooking" %>
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/HCBillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc1" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Home Collection</title>
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
   <%-- <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.theme.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/HCCommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>
    <style type="text/css">
        .t-small
        {
            height: 15px;
            width: 80px !important;
        }
        .s-ddl
        {
            height: 19px;
            width: 80px !important;
        }
        .tableNew
        {
            border: 1px solid;
            border-color: #ffffff #ffffff #ffffff #ffffff;
            margin-left: 0px;
            padding: 1px;
        }
        th
        {
            background: #B4F114;
        }
        .borderGreyTR:hover
        {
            border: 2px solid yellow;
        }
        .activebtn
        {
            padding: 1px;
            color: #ffffff;
            font: 12px 'Arial' ,helvetica,sans-serif;
            background: #ccc;
            border: 1px solid;
            border-color: #ffffff #ffffff #ffffff #ffffff;
            margin-left: 0px;
        }
        .active
        {
            background: green;
        }
        .activeheader
        {
            background: #446d87 !important;
            color: #fff;
        }
        .dataheader3.maintblBook td
        {
            padding: 3px;
        }
    </style>

    <script type="text/javascript">


        function ConfirmApproval(objMsg) {
            if (confirm(objMsg))
                return true;
            else
                return false;
        }

        function PhysicianSelectedInternal(source, eventArgs) {

            //debugger;
            var PhysicianID;
            var PhysicianName;
            var PhysicianCode;
            var PhysicianType;
            document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
            var PhyType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        PhysicianID = list[1];
                        PhysicianName = list[2];
                        PhysicianCode = list[3];
                        PhysicianType = list[0].trim();
                        PhyType = list[4];
                    }
                }
            }
            document.getElementById('billPart_hdnReferedPhyID').value = PhysicianID;
            document.getElementById('billPart_hdnReferedPhyName').value = PhysicianName;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Release">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
            <asp:ServiceReference Path="~/HCService.asmx" />
        </Services>
    </cc1:ToolkitScriptManager>
    <div id="wrapper">
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
            <asp:UpdatePanel ID="pp" runat="server">
                <ContentTemplate>
                    <%--  <asp:UpdateProgress ID="UpdateProgress111" AssociatedUpdatePanelID="pp" runat="server">
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
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
                        <tr>
                            <td>
                                <div id="ShowBillingItems" style="display: none; position: absolute; width: 35%;
                                    left: 62%; top: 1%">
                                    
                                    <table border="0" width="32%" cellspacing="0" class="modalPopup dataheaderPopup"
                                        cellpadding="0">
                                        <tr>
                                        <td><div onclick="Itemhidebox();return false" class="divCloseRight">
                                            </div>
                                        </td>
                                        </tr>
                                        <tr>
                                            <td id="Itemdragbar" style="cursor: move; cursor: pointer" width="100%">
                                                <asp:Label ID="lblPreviousItems" runat="server" meta:resourcekey="lblPreviousItemsResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divShowClientDetails" style="display: none; position: absolute; width: 35%;
                                    left: 62%; top: 1%">
                                    <div onclick="Itemhidebox();return false" class="divCloseRight">
                                    </div>
                                    <table border="0" width="32%" cellspacing="0" class="modalPopup dataheaderPopup"
                                        cellpadding="0">
                                        <tr>
                                            <td id="Td6" style="cursor: move; cursor: pointer" width="100%">
                                                <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table border="0" width="100%">
                                    <tr>
                                        <td style="width: 12%">
                                            <asp:RadioButton ID="rdoPatientSave" onclick="javascript:showsave();resetsave();"
                                                Text="New Home Collection" runat="server" meta:resourcekey="rdoPatientSaveResource1" />
                                        </td>
                                        <td style="width: 20%" id="tdrdoPatientSearch" runat="server" >
                                            <asp:RadioButton ID="rdoPatientSearch" runat="server" Enabled="true" onclick="javascript:showsearch();resetsearch();"
                                                Text="LookUp For Existing Home Collection" runat="server" meta:resourcekey="rdoPatientSearchResource1" />
                                        </td>
                                        <td align="right">
                                            <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                                id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" class="dataheader3 maintblBook">
                                    <tr>
                                        <td>
                                            <table id="tblBook" class="dataheader3" width="100%" style="display: none;">
                                                <tr id="trserdate" runat="server">
                                                    <td width="11%">
                                                        <asp:Label runat="server" ID="lblMob" Text="Mobile No" CssClass="label_title"></asp:Label>
                                                    </td>
                                                    <td width="18%">
                                                        <asp:TextBox ID="txtMob" runat="server" Width="130px" onkeydown="return (event.keyCode!=13);" TabIndex="19" Style="text-align: justify"
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                        </a>
                                                    </td>
                                                    <td width="9%">
                                                        <asp:Label runat="server" ID="lblBook" Text="Booking No" CssClass="label_title"></asp:Label>
                                                    </td>
                                                    <td width="18%">
                                                        <asp:TextBox ID="txtBookNos" runat="server" Width="130px" onkeydown="return (event.keyCode!=13);" TabIndex="20" Style="text-align: justify"
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        </a>
                                                    </td>
                                                 <%--  <td >
                                                        <asp:Label ID="Rs_ClientName" runat="server" Text="<u>C</u>lient Name" AssociatedControlID="txtClient"
                                                            AccessKey="C" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td style="display: none">
                                                        <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            TabIndex="23" CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                            ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>--%>
                                                      <td style="display: none">
                                                        <asp:Label ID="Rs_ClientNameone" runat="server" Text="<u>C</u>lient Name" AssociatedControlID="txtClientnone"
                                                            AccessKey="C" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td style="display: none">
                                                        <asp:TextBox ID="txtClientnone" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            TabIndex="23" CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorpnone" runat="server" TargetControlID="txtClientnone"
                                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                            ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" id="lblAdvSearch">
                                                        <input type="checkbox" id="chkAdvanceSearch" />
                                                        <asp:Label runat="server" ID="lblAdvSearch1" Font-Bold Text="Advance Search" CssClass="label_title"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                </tr>
                                            </table>
                                            <table id="AdvanceSearchDetails" class="dataheader3" width="100%" style="display: none;">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label10" runat="server" Text="Organization"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span>
                                                            <asp:DropDownList ID="drpOrgAdv" runat="server" TabIndex="6" Width="153px" CssClass="ddlsmall"
                                                                onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);"
                                                                meta:resourcekey="ddlOrgResource1">
                                                            </asp:DropDownList>
                                                            <ajc:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="drpOrgAdv"
                                                                Category="Org" PromptText="---Select ALL---" PromptValue="-1" ServicePath="~/OPIPBilling.asmx" ServiceMethod="GetOrganizations"
                                                                Enabled="True" />
                                                        </span>
                                                    </td>
                                                    <td id="td7" runat="server" align="left">
                                                        <asp:Label ID="Label11" runat="server" Text="Collection Centre" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                    </td>
                                                    <td id="td9" runat="server" align="left">
                                                        <asp:DropDownList ID="drpLocAdv" runat="server" CssClass="ddlsmall" TabIndex="7"
                                                            meta:resourcekey="ddlLocationResource1">
                                                        </asp:DropDownList>
                                                        <ajc:CascadingDropDown ID="CascadingDropDown2" runat="server" TargetControlID="drpLocAdv"
                                                            ParentControlID="drpOrgAdv" ServiceMethod="GetLocationName" ServicePath="~/OPIPBilling.asmx"
                                                            Category="Location" LoadingText="[Loading Locations...]" PromptText="---Select ALL---" PromptValue="-1" Enabled="True" />
                                                        
                                                    </td>
                                                    <td width="11%">
                                                        Technician
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpTech" runat="server" TabIndex="17" CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="11%">
                                                        <asp:Label ID="CollectionDate" runat="server" Text="Collection"></asp:Label>
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
                                                        <asp:HiddenField runat="server" ID="hdnloginRoleName" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpCollection" runat="server" TabIndex="17" onChange="javascript:return ShowRegDate();"
                                                            CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <div id="divRegDate" style="display: none" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
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
                                                                        <asp:TextBox CssClass="w-70" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td width="11%">
                                                        Booked on
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpBooked" runat="server" TabIndex="17" onChange="javascript:return ShowRegDateBook();"
                                                            CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <div id="divRegDateBook" style="display: none" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" ID="txtFromDateBook" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label13" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToDateBook" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divRegCustomDateBook" runat="server" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label14" runat="server" Text="From Date"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" ID="txtFromPeriodBook" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalcFromBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFromBook" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Text="To Date"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriodBook"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalcToBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcToBook" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td width="11%">
                                                        Status
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpStatusBo" runat="server" TabIndex="17" CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Booked" Value="B" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                            <asp:ListItem Text="Completed" Value="R" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                            <asp:ListItem Text="Cancelled" Value="C" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                            <asp:ListItem Text="Rescheduled" Value="RS" ></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="11%">
                                                        Pincode
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPinCodeBo" runat="server" TabIndex="16" CssClass="Txtboxsmall"
                                                            onkeypress="return blockNonNumbers(this, event, true, false);" ToolTip="Enter Pincode"
                                                            MaxLength="6" onblur="showlocation();ValidatePincodeAndLocation();"></asp:TextBox>
                                                    </td>
                                                    <td width="11%">
                                                        Location
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLoc" runat="server" TabIndex="16" onblur="javascript:ValidatePincodeAndLocation();"
                                                            CssClass="Txtboxsmall"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteHCGetLoc" runat="server" TargetControlID="txtLoc"
                                                            EnableCaching="False" OnClientItemSelected="SelectTab" CompletionListCssClass="listtwo"
                                                            CompletionInterval="5" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                            ServiceMethod="GetLocationforHomeCollection" ServicePath="~/HCService.asmx" Enabled="True"
                                                            DelimiterCharacters="">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="btnSearchArea" class="dataheader3" width="100%">
                                                <tr>
                                                    <td width="20%">
                                                    </td>
                                                    <td width="20%">
                                                    </td>
                                                    <td width="40%">
                                                    </td>
                                                    <td>
                                                        
                                                        <button type="button" id="btnClearBook" onclick="ClearFields();">
                                                            Clear</button>
                                                    </td>
                                                    <td>
                                                        <button type="button" id="btnSaveBook" onclick="GetData();">
                                                            Search</button>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table>
                                            </table>
                                            <table id="tbmain" runat="server" width="100%" class="dataheader3" style="border: none;">
                                                <%--Added By prbakaran--%>
                                                <tr id="trPatientNumber" style="display: none;">
                                                    <td colspan="11" align="left">
                                                        <asp:Label ID="lblPatientNumber" Font-Size="9pt" Font-Bold="True" runat="server"
                                                            Text="Patient Number :" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trPatientSearch">
                                                    <td colspan="1">
                                                        Search Type
                                                    </td>
                                                    <td colspan="10" align="left" runat="server" id="tdSearchType2">
                                                        <asp:RadioButtonList onclick="javascript:clearPageControlsValue('N');" RepeatDirection="Horizontal" 
                                                             ID="rblSearchType" runat="server" RepeatColumns="6" meta:resourcekey="rblSearchTypeResource1">
                                                            <asp:ListItem Text="None" Value="4" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Name" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="PID" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="Mobile/Phone" Value="2" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                            <asp:ListItem Text="Booking Number" Value="3" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                            <asp:ListItem Text="Booking Phone Number" Value="5" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <%--End--%>
                                                <tr>
                                                    <td>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="a-left">
                                                                    <asp:Label ID="lblPatient" runat="server" Text="Patient" meta:resourcekey="lblPatientResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server" meta:resourceKey="ddSalutationResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPatientName" runat="server" ToolTip="Enter a Patient Name" TabIndex="1"
                                                            onkeyup="javascript:GetPatientSearchList();" onchange="ClearPatientId();" onblur="javascript:ConverttoUpperCase(this.id);"
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>&nbsp;<img
                                                                id="imgMan" src="../Images/starbutton.png" alt="" />
                                                        <%--  <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                            EnableCaching="False" FirstRowSelected="False" OnClientItemSelected="IAmSelected"
                                                            MinimumPrefixLength="3" CompletionListCssClass="listtwo" CompletionInterval="5"
                                                            CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                            ServiceMethod="GetPatientListforBookings" ServicePath="~/InventoryWebService.asmx"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </cc1:AutoCompleteExtender>--%>
                                                        <%--  <asp:CheckBox ID="chkNewPatient" runat="server" TabIndex="15">
                                                                    </asp:CheckBox><asp:Label ID="lblchknew" runat="server" Text="New"></asp:Label>--%>
                                                        <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtPatientName"
                                                                        ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                        CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                        OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True"
                                                                        OnClientPopulated="onListPopulated">
                                                                    </ajc:AutoCompleteExtender>--%>
                                                    </td>
                                                    <td id="tdBookingNo1" runat="server" style="display: none;">
                                                        <asp:Label ID="Label6" runat="server" Text="Booking Number" meta:resourcekey="Label6Resource1"></asp:Label>
                                                    </td>
                                                    <td id="tdBookingNo2" runat="server" style="display: none;">
                                                        <asp:TextBox ID="txtBookingNumber" CssClass="Txtboxsmall" runat="server" MaxLength="250"
                                                            TabIndex="5" meta:resourcekey="txtBookingNumberResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="tdsex1">
                                                        <asp:Label ID="lblSex" runat="server" Text="Gender" AssociatedControlID="ddlSex" AccessKey="X"
                                                           ></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td id="tdsex2">
                                                        <asp:DropDownList Width="153px" ID="ddlSex" runat="server" CssClass="ddl" TabIndex="2"
                                                            meta:resourcekey="ddlSexResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" />
                                                    </td>
                                                    <td id="tdAge1" runat="server" align="left">
                                                        <asp:Label ID="lblAge" runat="server" Text="Age" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdAge2" runat="server" align="left" style="/* display: table-cell; */width: 190px;">
                                                        <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onkeyup="setDOBYear(this.id,'HC');"
                                                            TabIndex="3" onkeypress="return blockNonNumbers(this, event, true, false);" CssClass="Txtboxsmall"
                                                            Width="18%" runat="server" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                        <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" Width="105px"
                                                            runat="server" CssClass="ddl" meta:resourcekey="ddlDOBDWMYResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <%--<ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                            Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                        </ajc:TextBoxWatermarkExtender>--%>
                                                    </td>
                                                    <td id="tdlblDOB" runat="server" align="left">
                                                        <asp:Label ID="lblDOB" runat="server" Text="DOB" AssociatedControlID="tDOB" AccessKey="B"
                                                            meta:resourcekey="lblDOBResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdtxtDOB" align="left">
                                                        <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"
                                                            meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                        <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server"
                                                            meta:resourcekey="ddMaritalResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                        <asp:TextBox CssClass="Txtboxsmall" ID="tDOB" runat="server" ToolTip="dd/MM/yyyy"
                                                            onblur="javascript:countQuickAge(this.id);" Width="148px" Style="text-align: justify"
                                                            onkeypress="return RestrictInput(event)" ValidationGroup="MKE" meta:resourceKey="tDOBResource1" /><%--ToolTip="dd/MM/yyyy"--%>
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
                                                    <%--<td width="3%">&nbsp;</td>
                                                                 <td width="14%">&nbsp;</td>--%>
                                                </tr>
                                                <tr id="trSaveDate" style="height: 35px;" runat="server">
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblPincode" runat="server" Text="PinCode" nowrap="nowrap" meta:resourcekey="lblPincodeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtpincode" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                            TabIndex="4" ToolTip="Enter Pincode" MaxLength="6" CssClass="Txtboxsmall" onblur="showlocation();ValidatePincodeAndLocation();"
                                                            meta:resourcekey="txtpincodeResource1"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <!--  <img src="../Images/starbutton.png" alt="" align="middle" />  -->
                                                    </td>
                                                    <td id="td2" runat="server">
                                                        <asp:Label ID="Label1" runat="server" Text="Location" meta:resourcekey="Label1Resource1"></asp:Label>
                                                    </td>
                                                    <td id="td3" runat="server">
                                                        <asp:TextBox ID="txtSuburb" runat="server" TabIndex="5" MaxLength="250" CssClass="Txtboxsmall"
                                                            onblur="javascript:ValidatePincodeAndLocation();" meta:resourcekey="txtSuburbResource1"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutocompleteGetLocationforHomeCollection" runat="server"
                                                            TargetControlID="txtSuburb" EnableCaching="False" OnClientItemSelected="SelectTab"
                                                            CompletionListCssClass="listtwo" CompletionInterval="5" CompletionListItemCssClass="listitemtwo"
                                                            CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetLocationforHomeCollection"
                                                            ServicePath="~/HCService.asmx" Enabled="True" DelimiterCharacters="">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td id="td4" runat="server">
                                                        <asp:Label ID="Label2" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                            AccessKey="y" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td id="td5" runat="server" width="14%">
                                                        <asp:TextBox ID="txtCity" Style="background-color: #F2F2F2" CssClass="Txtboxsmall"
                                                            runat="server" MaxLength="250" meta:resourcekey="txtCityResource1"></asp:TextBox>
                                                        &nbsp;<img
                                                                src="../Images/starbutton.png" alt="" />
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblstate" runat="server" Text="State" nowrap="nowrap" meta:resourcekey="lblstateResource1"></asp:Label>
                                                    </td>
                                                    <td width="18%">
                                                        <asp:TextBox ID="txtstate" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtstateResource1"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="loc" runat="server">
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text="Organization" meta:resourcekey="Label5Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span>
                                                            <asp:DropDownList ID="ddlOrg1" runat="server" TabIndex="6" Width="153px" CssClass="ddlsmall"
                                                                onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);"
                                                                meta:resourcekey="ddlOrgResource1">
                                                            </asp:DropDownList>
                                                            <ajc:CascadingDropDown ID="CascadeddlOrg" runat="server" TargetControlID="ddlOrg1"
                                                                Category="Org" PromptText="------Select------" ServicePath="~/OPIPBilling.asmx"
                                                                ServiceMethod="GetOrganizations" Enabled="True" />
                                                        </span>
                                                    </td>
                                                    <td id="tdloc1" runat="server" align="left">
                                                        <asp:Label ID="lblLocation" runat="server" Text="Collection Centre" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdloc2" runat="server" align="left">
                                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" TabIndex="7"
                                                            meta:resourcekey="ddlLocationResource1">
                                                        </asp:DropDownList>
                                                        <ajc:CascadingDropDown ID="CascadeddlLoc" runat="server" TargetControlID="ddlLocation"
                                                            ParentControlID="ddlOrg1" PromptText="------Select------" ServiceMethod="GetLocationName"
                                                            ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                                            Enabled="True" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td id="tdaddtxt" runat="server" nowrap="nowrap">
                                                        <asp:Label ID="Label4" runat="server" nowrap="nowrap" Text="Collection Address" meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                    <td id="tdtxtAddress" runat="server" colspan="4">
                                                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" MaxLength="250"
                                                            Width="458" Height="30" TabIndex="8" meta:resourcekey="txtAddressResource1" placeholder="Maximum of 250 characters  "></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 35px;">
                                                    <td>
                                                        <asp:Label ID="Label16" runat="server" Text="Schedule Slot"></asp:Label>
                                                    </td>
                                                    <td id="td10">
                                                        <asp:LinkButton ID="btnShow" runat="server" OnClientClick="javascript:IsPickDt();" Font-Underline="true" Text="Schedule"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text="Technician" ></asp:Label>
                                                    </td>
                                                    <td id="td8">
                                                        <asp:DropDownList ID="ddlUser" runat="server" CssClass="ddlsmall" TabIndex="10" onchange="javascript:ChangeUsers();"
                                                            meta:resourcekey="ddlUserResource1">
                                                        </asp:DropDownList>
                                                        <img id="userImage" src="../Images/starbutton.png" alt="" align="middle" runat="server" />
                                                    </td>
                                                    <td width="6%">
                                                        <asp:Label ID="label7" runat="server" Text="mobile" meta:resourcekey="label7resource1"></asp:Label>
                                                    </td>
                                                    <td width="17%">
                                                        <asp:TextBox ID="txtMobile" runat="server" ToolTip="enter a patient mobile number"
                                                            TabIndex="11" MaxLength="13" onchange="CheckSMS();" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtmobileresource1"></asp:TextBox>
                                                        &nbsp;<img id="img1" src="../images/starbutton.png" alt="" />
                                                    </td>
                                                    <td nowrap="nowrap" width="6%">
                                                        <asp:Label ID="label8" runat="server" nowrap="nowrap" Text="land line" meta:resourcekey="label8resource1"></asp:Label>
                                                    </td>
                                                    <td width="18%">
                                                        <asp:TextBox ID="txtTelephoneNo" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                            ToolTip="enter a patient telephone number" MaxLength="15" TabIndex="12" CssClass="Txtboxsmall"
                                                            meta:resourcekey="txttelephonenoresource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%-- <td colspan="2" align="center" runat="server" id="tdChkNewPatient" style="display: none">
                                                                    <asp:CheckBox ID="chkNewPatient" Text="New patient" runat="server" TabIndex="15" />
                                                                </td>--%>
                                                    <td id="tdtime" runat="server" align="left">
                                                        <asp:Label ID="Label3" runat="server" Text="Collection Date & Time" meta:resourcekey="lblTimeResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdtimetxt" runat="server">
                                                        <asp:TextBox ID="txtTime" runat="server" Width="130px" ToolTip="Collection Date"
                                                            TabIndex="9" CssClass="Txtboxsmall" onblur="javascript:IsCollectionDt();" meta:resourcekey="txtTimeResource1"></asp:TextBox>
                                                        <%--onchange="javascript:CollectiontimeValidation(); onblur="AdditionalDetails();"--%>
                                                        <a href="javascript:NewCssCal('txtTime','ddmmyyyy','arrow',true,12);" >
                                                            <img src="../images/Calendar_scheduleHS.png" id="imgCalc" style="vertical-align: middle;"
                                                                alt="Pick a date"></a>
                                                        <img id="ImgCollDt" src="../Images/starbutton.png" alt="" runat="server" />
                                                    </td>
                                                    <td id="tdRefDrPart" runat="server">
                                                        <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                            Text="Ref Dr." meta:resourcekey="lblRefbyResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdRefDrParttxt" runat="server">
                                                        <%--onKeyDown="javascript:ClearDiscountLimitValues();"--%>
                                                        <asp:TextBox ID="txtInternalExternalPhysician" runat="server" TabIndex="14" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                            onFocus="return getrefhospid(this.id)" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                                            <img id="ImgRefDr" src="../Images/starbutton.png" alt="" runat="server" />
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" OnClientShown="DocPopulated"
                                                            FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="PhysicianSelectedInternal"
                                                            ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected"
                                                            TargetControlID="txtInternalExternalPhysician" DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" meta:resourcekey="Rs_URNTypeResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlUrnType" runat="server" TabIndex="15" onChange="javascript:return enableurntxt();"
                                                            CssClass="ddlsmall" meta:resourcekey="ddlUrnTypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_URN" Text="URN No" runat="server" meta:resourcekey="Rs_URNResource1" />
                                                    </td>
                                                    <td>
                                                        <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                        <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" MaxLength="50" CssClass="Txtboxsmall"
                                                            onblur="ConverttoUpperCase(this.id);" meta:resourcekey="txtURNoResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="tdStatus" runat="server">
                                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdddlStatus" runat="server">
                                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlStatusResource1">
                                                            <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                            <asp:ListItem Text="Booked" Value="B" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                            <asp:ListItem Text="Completed" Value="R" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                            <asp:ListItem Text="Cancelled" Value="C" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                            <asp:ListItem Text="Rescheduled" Value="RS" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                               <tr>
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblEmail" runat="server" AccessKey="E" AssociatedControlID="txtEmail"
                                                            Text="&lt;u&gt;E&lt;/u&gt;-mail" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <asp:TextBox ID="txtEmail" runat="server" autocomplete="off" TabIndex="13" onchange="CheckEmail();"
                                                            onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');" CssClass="small"
                                                            meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                        <img id="ImgEmail" src="../Images/starbutton.png" alt="" align="middle" runat="server" />
                                                    </td>
                                                   <td id="tdClientPart" runat="server">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td id="tdClientParttxt" runat="server">
                                                <%-- <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                            TabIndex="23" CssClass="Txtboxsmall" Width="25%" meta:resourcekey="txtClientResource1"></asp:TextBox>--%>
                                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                            onblur="clearBillPart();ClearRate();" onfocus="CheckOrderedItems();" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                        <div id="clientwidthauto">
                                                        </div>
                                                 <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1" 
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3css"
                                                        CompletionListItemCssClass="wordWheel itemsMaincss"   DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemOver="SelectedTempClient"
                                                        OnClientItemSelected="ClientSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="txtClient" CompletionListElementID="clientwidthauto" >
                                                    </ajc:AutoCompleteExtender>
 							<img id="imgClient" src="../Images/starbutton.png" alt="" runat="server" />
                                                </td>
                                               <%-- <td id="tdRefHosPart" runat="server">
                                                    <asp:Label ID="lblReferingHospital" runat="server" AccessKey="H" AssociatedControlID="txtReferringHospital"
                                                        Text="Ref &lt;u&gt;H&lt;/u&gt;os" meta:resourcekey="lblReferingHospitalResource1"></asp:Label>
                                                </td>
                                                <td id="tdRefHosParttxt" runat="server">
                                                    <asp:TextBox ID="txtReferringHospital" autocomplete="off" runat="server" onblur="ClearHospitalID(this.id)"
                                                        onkeyup="SetContextKey()" CssClass="AutoCompletesearchBox" meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                        CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="GetReferingHospID"
                                                        ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemOver="GetTempReferingHospID"
                                                        TargetControlID="txtReferringHospital">
                                                    </ajc:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdnReferralType" runat="server" Value="0" />
                                                </td>--%>
                                                </tr>
                                                <tr visible="true" id="tdemail">
                                                    <td colspan="1" nowrap="nowrap">
                                                        <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lblDespatchmodeResource1"></asp:Label>
                                                    </td>
                                                    <td colspan="1" nowrap="nowrap">
                                                        <asp:CheckBoxList ID="chkDespatchMode" TabIndex="16" runat="server" onclick="DispatchChecked()"
                                                            RepeatDirection="Horizontal" meta:resourcekey="chkDespatchModeResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblFeedback" runat="server" Text="Comments" meta:resourcekey="lblFeedbackResource1"></asp:Label>
                                                    </td>
                                                    <td colspan="4">
                                                        <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" TabIndex="17" Width="468"
                                                            Height="30" placeholder="Maximum of 100 characters" MaxLength="200" meta:resourcekey="txtFeedbackResource1"></asp:TextBox>
                                                    </td>
                                                    <%--Added By prbakaran--%>
                                                    <%--End--%>
                                                </tr>
                                                <tr id="trBilling" runat="server">
                                                    <td colspan="10">
                                                        <BillingPart:BPart ID="billPart" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tdbtnSave" runat="server" colspan="10" align="center" class="style1" style="display: none;">
                                                        <table class="w-10p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSend" Text="Send" runat="server" OnClick="btnSend_Click" Visible="False"
                                                                        meta:resourcekey="btnSendResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                                                        Style="margin-left: 0px" TabIndex="19" meta:resourcekey="btnClearResource1" />
                                                                    <asp:Button ID="btnSave" TabIndex="18" runat="server" Text="Save" CssClass="btn"
                                                                        OnClientClick="return validate(this);" OnClick="btnSave_Click" Style="margin-left: 0px"
                                                                        meta:resourcekey="btnSaveResource1" />
                                                                    <input id="BtnUpdateBook" type="button" value="Update" class="btn" style="display: none"
                                                                        onclick="if(validate(this)==true){UpdateFunc();showsave();clearControle();}"></input>
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td id="tdbtnSearch" runat="server" colspan="8" align="center" class="style1" style="display: none;">
                                                        <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                                            Style="margin-left: 0px;" TabIndex="18" meta:resourcekey="btnClearSearchResource1" />
                                                       <%-- <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClick="btnSearch_Click"
                                                            TabIndex="17" meta:resourcekey="btnSearchResource1" />--%>
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="enable();GetData();return false;"
                                                            TabIndex="17" Style="margin-left: 0px;" />
                                                        <%--<input type="button" ID="btnSearch" runat="server" CssClass="btn" Text="Search1" OnClientClick="GetData();" TabIndex="17" />--%>
                                                    </td>
                                                    <td id="tdbtnUpdate" runat="server" colspan="9" align="center" class="style1">
                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClientClick="return clearupdate();"
                                                            TabIndex="18" Style="margin-left: 0px;" meta:resourcekey="btnCancelResource1" />
                                                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn" Text="Update" OnClick="btnUpdate_Click"
                                                            OnClientClick="return validate(); ValidateRegister();" TabIndex="18" Style="margin-left: 0px;"
                                                            meta:resourcekey="btnUpdateResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                    </tr>
                                    <tr>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="divPrint" style="display: none;" runat="server">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="left" style="padding-right: 10px; color: #000000;">
                                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                                <asp:ImageButton ID="btnConverttoXL" runat="server" OnClick="btnConverttoXL_Click"
                                                    ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                            </td>
                                            <td align="right" style="padding-right: 10px; color: #000000;">
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
                                <table border="0" width="100%">
                                    <tr>
                                        <td colspan="10">
                                            <asp:UpdatePanel ID="updatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <table width="100%" style="">
                                                        <tr>
                                                            <td>
                                                                <div id="divPrintarea" runat="server" style="overflow: auto; height: auto;" visible="False">
                                                                    <asp:GridView ID="grdResult" EmptyDataText="No Results Found." runat="server" OnRowDataBound="grdResult_RowDataBound"
                                                                        CssClass="mytable1" AutoGenerateColumns="False" Width="100%" meta:resourcekey="grdResultResource1"
                                                                        OnRowCommand="grdResult_RowCommand" OnRowEditing="grdResult_RowEdit">
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                            PageButtonCount="5" PreviousPageText="" />
                                                                        <Columns>
                                                                            <asp:BoundField Visible="False" DataField="BookingID" HeaderText="HomeCollectionDetailsID"
                                                                                meta:resourcekey="BoundFieldResource1" />
                                                                            <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                                                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Patient" GroupName="PatientSelect"
                                                                                        meta:resourcekey="rdSelResource1" />
                                                                                    <asp:HiddenField ID="GRhdnRoleID" runat="server" Value='<%# bind("RoleID") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="BookingID" HeaderText="Booking Number" meta:resourcekey="BoundFieldResource3" />
                                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource3"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource4" />
                                                                            <asp:BoundField DataField="Age" HeaderText="Age/Gender" meta:resourcekey="BoundFieldResource5" />
                                                                            <asp:BoundField DataField="DOB" HeaderText="DOB" Visible="False" meta:resourcekey="BoundFieldResource6" />
                                                                            <asp:BoundField DataField="PhoneNumber" HeaderText="Mobile No" meta:resourcekey="BoundFieldResource7" />
                                                                            <asp:BoundField DataField="CollectionTime" HeaderText="Collection Time" DataFormatString="{0:dd/MMM/yy hh:mm tt}"
                                                                                meta:resourcekey="BoundFieldResource5" />
                                                                            <asp:BoundField DataField="CollectionAddress" HeaderText="Collection Address" meta:resourcekey="BoundFieldResource6" />
                                                                            <asp:BoundField DataField="SourceType" HeaderText="Source Type" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource7" />
                                                                            <asp:BoundField DataField="UserName" HeaderText="User" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="BookingStatus" HeaderText="Status" meta:resourcekey="BoundFieldResource9" />
                                                                            <asp:BoundField DataField="City" meta:resourcekey="BoundFieldResource10" Visible="False" />
                                                                            <asp:BoundField DataField="Comments" HeaderText="Comments" Visible="False" meta:resourcekey="BoundFieldResource11" />
                                                                            <asp:BoundField DataField="Priority" HeaderText="Priority" meta:resourcekey="BoundFieldResource12" />
                                                                            <asp:BoundField DataField="State" HeaderText="State" Visible="False" meta:resourcekey="BoundFieldResource13" />
                                                                            <asp:BoundField DataField="Pincode" HeaderText="Pincode" Visible="False" meta:resourcekey="BoundFieldResource14" />
                                                                            <asp:BoundField DataField="stateid" HeaderText="StateID" Visible="False" meta:resourcekey="BoundFieldResource15" />
                                                                            <asp:BoundField DataField="CityID" HeaderText="CityID" Visible="False" meta:resourcekey="BoundFieldResource16" />
                                                                            <asp:BoundField DataField="BillDescription" HeaderText="BillDescription" Visible="False"
                                                                                meta:resourcekey="BoundFieldResource17" />
                                                                            <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="linkEdit" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("RoleID")+","+ Eval("UserID") %>'
                                                                                        runat="server" OnClick="grdResult_OnClick" meta:resourcekey="linkEditResource1" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <table class="w-100p">
                                                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                                        <td class="divFooterNav a-center" runat="server">
                                                                            <asp:Label ID="Label19" runat="server" Text="Page"></asp:Label>
                                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                            <asp:Label ID="Label20" runat="server" Text="Of"></asp:Label>
                                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                            <asp:Label ID="Label21" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" AutoComplete="off" onkeydown="javascript:return validatenumber(event);"></asp:TextBox>
                                                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                                                OnClientClick="javascript:return validatePageNumber();" />
                                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                                        PopupControlID="pnlPopup" DynamicServicePath="" Enabled="True" />
                                                    <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Style="display: none"
                                                        BackImageUrl="~/Images/Loader.gif" meta:resourcekey="pnlPopupResource1">
                                                    </asp:Panel>
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
                    <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnShow"
                        BehaviorID="mpe" CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                        <div class="header">
                            Booking Slot Selection
                        </div>
                        <div class="body">
                            <SCPBooking:Schd ID="spBooking" runat="server" />
                        </div>
                        <br />
                        <div class="footer" align="center">
                            <input type="button" id="btnCreate" value="Slot Selection" onclick="javascript:onConfirmBookingSlot();" />
                            <asp:Button ID="btnClose" runat="server" Text="Close" />
                        </div>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnConverttoXL" />
                    <%--<asp:PostBackTrigger ControlID="ddlHCRole" />--%>
                    <asp:PostBackTrigger ControlID="btnSave" />
                </Triggers>
            </asp:UpdatePanel>
            <div id="printDiv" style="display: none;" runat="server">
                <div>
                    <%-- <asp:Label ID="Label10" runat="server" Text="Search" meta:resourcekey="lblPatientResource1"></asp:Label>--%>
                    <%--<input type="text" id="txtbox1" class="AutoCompletesearchBox" onkeyup="return checkCodes();" />
                    <asp:Label ID="lblLabel" runat="server" meta:resourcekey="lblLabelResource1"></asp:Label>
                   
                    <input type='button' name='BtnPdf' value='PDF' id='genPdf' style="float: right;"
                        class="hide" />
                    <input type='button' name='btnExcel' value='Excel' id='genExcel' style="float: right;"
                        class="hide" />
                    <input type='button' name='BtnCSV' value='CSV' id='genCSV' style="float: right;"
                        class="hide" />--%>
                    <asp:Button ID="btnpop" Text="Export" runat="server" Style="float: right;display: none;" meta:resourcekey="btnpopResource1" />
                    <asp:UpdatePanel ID="NewUP" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="bExportPdf" Text="NewPdf" runat="server" Style="float: right;" OnClick="bExportPdf_Click"
                                class="hide" meta:resourcekey="bExportPdfResource1" />
                            <ajc:ModalPopupExtender ID="HCmodalPopUp" runat="server" PopupControlID="HCReportpanel"
                                BackgroundCssClass="modalBackground" DynamicServicePath="" Enabled="True" TargetControlID="bExportPdf"
                                CancelControlID="btnPopClose">
                            </ajc:ModalPopupExtender>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnpop" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <%--<asp:Panel ID="MyTable" runat="server" meta:resourcekey="MyTableResource1">--%>
                    <div id="ScrollArea">
                        <table id="example" class="w-100p gridView">
                            <%--<thead>
                                <tr style="border: 1px solid black;">
                                <th>S.No</th>
                                    <th align="left" onclick="sort_table(people, 0, asc1); asc1 *= -1; asc2 = 1; asc3 = 1;">
                                        Booking ID
                                    </th>
                                    <th align="left" onclick="sort_table(people, 1, asc1); asc1 *= -1; asc2 = 1; asc3 = 1;">
                                        Patient Name
                                    </th>
                                    
                                    <th align="left">
                                        Mobile No
                                    </th>
                                    <th align="left">
                                        Location
                                    </th>
                                    <th align="left">
                                        Pincode
                                    </th>
                                    <th>
                                    Organization
                                    </th>
                                    <th>Collection Center</th>
                                    
                                    <th align="left" onclick="sort_table(people, 3, asc1); asc1 *= -1; asc2 = 1; asc3 = 1;">
                                        Booked Date & Time
                                    </th>
                                    <th align="left" onclick="sort_table(people, 3, asc1); asc1 *= -1; asc2 = 1; asc3 = 1;">
                                        Collection Date & Time
                                    </th>
                                    
                                    
                                    <th align="left">
                                        Technician
                                    </th>
                                    <th align="left">
                                         Status
                                    </th>
                                    
                                </tr>
                            </thead>
                            <tbody id="people">
                            </tbody>
                            <tfoot>
                                <tr id="tfooterexample" runat="server" style="display: table-row">
                                    <td colspan="14" class="a-center" style="background: #e0e0e0;" runat="server">
                                        <div id="nav" class="w-100p" style="float: right;">
                                        </div>
                                    </td>
                                </tr>
                            </tfoot>--%>
                        </table>
                    </div>
                    <br />
                    <br />
                    <br />
                    <%--</asp:Panel>--%>
                </div>
                <div>
                    <asp:Label ID="lblAction" Style="margin-left:450px;" runat="server" Text="Select any action from the following  "></asp:Label><asp:DropDownList
                        ID="drpAction" runat="server" meta:resourcekey="dListResource1" CssClass="ddlsmall" onchange="drpCancelTaskDisplay(this.id)" >
                        <asp:ListItem Text="Edit patient details" Value="1"></asp:ListItem>
                        <asp:ListItem Text="cancel booking" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList
                        ID="drpCancelStatus" Visible ="false" runat="server"  CssClass="ddlsmall"  style="Display:none;" >
                       <%-- <asp:ListItem Text="Wrong sample" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Patient Not Available" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Patient Delay" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Inappropriate Container" Value="4"></asp:ListItem>--%>
                    </asp:DropDownList>
                    <input type='button' name='BtnGo' value='GO' id='btnGo' onclick="EditDemoGraphic()" />
                    <input type='button' name='Uptech' value='SAVE' id='uptech1' onclick="uptechclick()" />
                    </div>
                <br />
                <br />
            </div>
            <div>
                <asp:Panel ID="HCReportpanel" runat="server" Style="background-color: White; height: 600px;
                    width: 1050px; vertical-align: bottom; top: 10px;" meta:resourcekey="HCReportpanelResource1">
                    <img id="btnPopClose" runat="server" alt="Close" src="../Images/Close_Red_Online_small.png"
                        style="cursor: pointer; height: 18Px;"></img>
                   <%-- <rsweb:ReportViewer ID="ReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                        Font-Size="8pt" meta:resourcekey="ReportViewerResource1" WaitMessageFont-Names="Verdana"
                        WaitMessageFont-Size="14pt">
                        <ServerReport ReportServerUrl="" />
                    </rsweb:ReportViewer>--%>
                </asp:Panel>
            </div>
        </div>
        <asp:HiddenField ID="hdnSCPPinCode" runat="server" />
        <asp:HiddenField ID="hdnSCPTechnicianID" runat="server" />
        <asp:HiddenField ID="hdnSCPdate" runat="server" />
        <asp:HiddenField ID="hdnSCPhours" runat="server" />
        <asp:HiddenField ID="hdnSCPTechnician" runat="server" />
        <asp:HiddenField ID="hdnHomeCollDtdID" runat="server" />
        <asp:HiddenField ID="hdnPatientID" runat="server" />
        <asp:HiddenField ID="hdnDOB" runat="server" />
        <asp:HiddenField ID="hdnNewDOB" runat="server" />
        <input id="hdnOrgID" type="hidden" value="0" runat="server" />
        <asp:HiddenField ID="hdnPatientName" runat="server" />
        <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
        <asp:HiddenField ID="hdnstatus" runat="server" />
        <asp:HiddenField ID="hdnrdosave" runat="server" />
        <input id="hdnGender" runat="server" value="" type="hidden" />
        <asp:HiddenField ID="hdnrdosearch" runat="server" />
        <asp:HiddenField ID="hdnRoleUser" runat="server" />
        <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
        <%--  <asp:HiddenField ID="hdnorgids1" runat="server" Value="0" />--%>
        <asp:HiddenField ID="hdnlocid" runat="server" Value="0" />
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
         <asp:HiddenField ID="hdnMessages" runat="server" />
        
        <input id="hdnIsCashClient" type="hidden" runat="server" value="N" />
        <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientName" type="hidden" value="" runat="server" />
        <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientRateID" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientMappingID" type="hidden" value="0" runat="server" />
          <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
        <%-- <uc5:footer id="Footer1" runat="server" />--%>
        <asp:HiddenField ID="hdnuserselectedval" Value="0" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
        <asp:HiddenField ID="hdnDoFrmVisit" runat="server" />
        <asp:HiddenField ID="hdnDecimalAgeHC" runat="server" />
        <asp:HiddenField ID="hdnSelectTypeID" runat="server" />
        <asp:HiddenField ID="hdnHCTechScheduler" runat="server" />
        <asp:HiddenField ID="hdnIsMandatoryEmailandRefDr" runat="server" />
        <asp:HiddenField ID="hdnIsNonMandatoryCollectionDt" runat="server" />
         <asp:HiddenField ID="hdnIsNonMandatoryClientName" runat="server" />
          <asp:HiddenField ID="hdnIsNonMandatoryEmail" runat="server" />
        <%--Added for Mobile APP--%>
        <input id="hdnStateID" runat="server" type="hidden" />
        <input id="hdnCityID" runat="server" type="hidden" />
        <input id="hdnDispatch" runat="server" type="hidden" />
        <input id="hdnstate" runat="server" type="hidden" />
        <input id="hdnWholeXls" runat="server" type="hidden" value="" />
        <input id="hdnBookedID" runat="server" type="hidden" value="0" />
        <input id="hdnCountryID" runat="server" type="hidden" />
        <input id="hdnSelectedClient" type="hidden" value="0" runat="server" />
        <input id="hdnClientRateID" type="hidden" value="0" runat="server" />
          <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
     <%-- <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />--%>
         <asp:HiddenField ID="hdnLocationClient" runat="server" />
        <script language="javascript" type="text/javascript">

            function enableurntxt() {
                var comp = document.getElementById('ddlUrnType');
                if (comp.value != 0) {
                    document.getElementById('txtURNo').disabled = false;
                    document.getElementById('txtURNo').style.backgroundColor = "white";
                    return false;
                }
                else
                    document.getElementById('txtURNo').disabled = true;
                document.getElementById('txtURNo').style.backgroundColor = "#F2F2F2";
            }
        </script>

        <script type="text/javascript">
            var people, asc1 = 1,
            asc2 = 1,
            asc3 = 1;
            window.onload = function() {
                people = document.getElementById("people");
            }
            function sort_table(tbody, col, asc) {
                var rows = tbody.rows,
                rlen = rows.length,
                arr = new Array(),
                i, j, cells, clen;
                for (i = 0; i < rlen; i++) {
                    cells = rows[i].cells;
                    clen = cells.length;
                    arr[i] = new Array();
                    for (j = 0; j < clen; j++) {
                        arr[i][j] = cells[j].innerHTML;
                    }
                }
                arr.sort(function(a, b) {
                    return (a[col] == b[col]) ? 0 : ((a[col] > b[col]) ? asc : -1 * asc);
                });
                for (i = 0; i < rlen; i++) {
                    rows[i].innerHTML = "<td>" + arr[i].join("</td><td>") + "</td>";
                }
            }
        </script>

        <script language="javascript" type="text/javascript">
         function onConfirmBookingSlot(){   
        var gblBookingDate ="";
        var gblResourceID="";
        var gblSlot ="";
        var gblpincode="";
        var gblResourceName ="";
       gblBookingDate = $("input[id*=hdngblBookingDate]").val();
       gblResourceID = $("input[id*=hdngblResourceID]").val();
       gblSlot = $("input[id*=hdngblSlot]").val();
       gblpincode = $("input[id*=hdngblpincode]").val(); 
       gblResourceName = $("input[id*=hdnTechName]").val(); 
   if (confirm("Are you sure you Booking the selected slot?")) 
        {
          if (gblResourceID != ""){
         document.getElementById('hdnSCPPinCode').value= gblpincode;
         document.getElementById('hdnSCPdate').value=gblBookingDate;
         document.getElementById('hdnSCPhours').value=gblSlot;
         document.getElementById('hdnSCPTechnicianID').value=gblResourceID;
         document.getElementById('hdnSCPTechnician').value=gblResourceName;
          loadquerystringObjects();
          showlocation();
     //     loadUsers();
          $('#ddlUser').val(gblResourceID);
          $find("mpe").hide();
          }
        }
   }
  function loadquerystringObjects(){
         var objscppincode =  document.getElementById('hdnSCPPinCode').value;
         var objSCPdate =  document.getElementById('hdnSCPdate').value;
         var objSCPhours =  document.getElementById('hdnSCPhours').value;
         var objSCPTechID =  document.getElementById('hdnSCPTechnicianID').value;
         var objSCPTechName =  document.getElementById('hdnSCPTechnician').value;
        if(objscppincode != ""){
            var arrayF = new Array();
            objSCPdate = objSCPdate.substring(0, 10);
            arrayF = objSCPdate.split('-');
            var CheckDate = (arrayF[2] + "/" + arrayF[1] + "/" + arrayF[0]);
            var objscpdatetime =   CheckDate +' '+ objSCPhours;
            document.getElementById('hdnuserselectedval').value =objSCPTechID;
            document.getElementById('txtpincode').value = objscppincode;
            document.getElementById('txtTime').value = objscpdatetime;
            document.getElementById('txtpincode').disabled = true;
//            $('#ddlUser').append('<option value="' + objSCPTechID + '">' + objSCPTechName + '</option>');                       
//            document.getElementById('<%= ddlUser.ClientID %>').disabled = false;
                    //document.getElementById('<%= ddlUser.ClientID %>').value = '0';
       }else{
       document.getElementById('txtpincode').disabled = false;
       document.getElementById('txtTime').value ="";
       }
}

            function loadUsers() {
                $('[id$=trFoc]').css('display', 'none');
                $('[id$=dvHealhcard]').css('display', 'none');
                var OrgId = document.getElementById('hdnOrgID').value; //.split('~')[0];
               // var RoleID = document.getElementById('ddlHCRole').value;
                var LocID = document.getElementById('hdnlocid').value;
                //document.getElementById('hdnRoleId').value = RoleID;
                document.getElementById('hdnlocid').value = LocID;
                var knownCategoryValues = "Org:" + parseInt(OrgId) + ";Location:" + LocID + ";Role:2340";
                $.ajax({
                    type: "POST",
                    url: "../HCService.asmx/GetUserName",
                    data: "{'knownCategoryValues': '" + knownCategoryValues + "','category': 'User'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function(data) {
                        var Items = data.d;
                        if(document.getElementById('hdnSCPTechnicianID').value != ""){
                        $('#ddlUser').find("option").remove();
                        $('#ddlUser').append('<option value="0">'+ document.getElementById('hdnSCPTechnician').value +'</option>');
                        $('#ddlUser').val(document.getElementById('hdnuserselectedval').value);
                        }
                        else{
//                        $('#ddlUser').attr("disabled", false);
//                        $('#ddlUser').append('<option value="0">--Select--</option>');
//                        $.each(Items, function(index, Item) {
//                            $('#ddlUser').append('<option value="' + Item.value + '">' + Item.name + '</option>');
//                        });
                        $('#ddlUser').val(document.getElementById('hdnuserselectedval').value);
                        }
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }

            function loadRole() {
                var OrgId = document.getElementById('hdnOrgID').value;
                var LocID = document.getElementById('hdnlocid').value;

                document.getElementById('hdnRoleId').value = '0';
                var knownCategoryValues = "Org:" + parseInt(OrgId) + ";Location:" + LocID + "";
                $.ajax({
                    type: "POST",
                    url: "../HCService.asmx/GetRoleName",
                    data: "{'knownCategoryValues': '" + knownCategoryValues + "','category': 'Role'}",   //.split('~')[0]) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var Items = data.d;

                        $('#ddlHCRole').attr("disabled", false);
                        $('#ddlHCRole').append('<option value="0">--Select--</option>');
                        $.each(Items, function(index, Item) {
                            if (Item.name == 'Phlebotomist' || Item.name == "Sr Phlebotomist") {
                                $('#ddlHCRole').append('<option value="' + Item.value + '">' + Item.name + '</option>');
                            }
                        });
                        $('#ddlHCRole').val(document.getElementById('hdnRoleId').value);
                        $("#ddlHCRole option:contains('Phlebotomist')").attr('selected', 'selected');
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }

        </script>

        <script language="javascript" type="text/javascript">

            function DispatchChecked() {

                var checked_checkboxes = $("[id*=chkDespatchMode] input:checked");
                var message = "";
                checked_checkboxes.each(function() {
                    var value = $(this).val();
                    var text = $(this).closest("td").find("label").html();
                    message += text;
                    message += ",";
                });
                document.getElementById('hdnDispatch').value = '';
                document.getElementById('hdnDispatch').value = message;

                return false;
            }

            function Popupclose() {
                $('[id$=HCReportpanel]').css('display', 'none');

            }

            function toggleCheckbox(element) {
                if ($('#chkreference').is(':checked')) {
                    $('[id$=trSTATOutSource]').css('display', 'table-row');
                }
                else {
                    $('[id$=trSTATOutSource]').css('display', 'none');
                }
            }

            function GetData() {

                try {

                    var today = new Date();
                    var dd = today.getDate();
                    var mm = today.getMonth() + 1; //January is 0!
                    var yyyy = today.getFullYear();

                    if (dd < 10) {
                        dd = '0' + dd
                    }

                    if (mm < 10) {
                        mm = '0' + mm
                    }

                    today = yyyy + '/' + mm +'/' + dd;
                    
                    

                    var PatientID = 0;
                    var BFromDate = ""; //'01/06/2015';
                    var BToDate = ""; //'21/06/2015';
                    var OrgID;
                   
                   
                    //                    var RoleID = document.getElementById('ddlHCRole').value;
                    var UserID = document.getElementById('drpTech').value;
                    var CollecOrgID = OrgID;
                    var CollecOrgAddrID;
                    var Location ;
                    var Pincode;
                    var BookingStatus;
                    var pFromDate ;
                    var pToDate ;
                    var pCollectionFromDate;
                    var pCollectionToDate;
                    
                    if (document.getElementById("chkAdvanceSearch").checked == false) 
                    {
                        CollecOrgAddrID = -1;
                        OrgID = -1;
                        Location = "";
                        Pincode = "";
                        BookingStatus = 0;
                         pFromDate = "";
                         pToDate = "";
                         pCollectionFromDate = "";
                         pCollectionToDate ="";
                         UserID = 0;
                        
                    }
                    else 
                    {
                        CollecOrgAddrID = document.getElementById('drpLocAdv').value;
                        OrgID = document.getElementById('drpOrgAdv').value;
                         Location = document.getElementById("txtLoc").value;
                         Pincode = document.getElementById('txtPinCodeBo').value;
                         BookingStatus = document.getElementById("drpStatusBo").value; 
                          pFromDate = document.getElementById('txtFromDateBook').value;
                          pToDate = document.getElementById('txtToDateBook').value;
                          pCollectionFromDate = document.getElementById('txtFromDate').value;
                          pCollectionToDate = document.getElementById('txtToDate').value;

                          if ($('#drpCollection').val() == 3) {
                              pCollectionFromDate = document.getElementById('txtFromPeriod').value;
                              pCollectionToDate = document.getElementById('txtToPeriod').value;

                          }
                          else if ($('#drpCollection').val() == 4) {

                              pCollectionFromDate = today + ' 00:00 AM';
                              pCollectionToDate = today + ' 23:59 PM';

                          }

                          if ($('#drpBooked').val() == 3) {
                              pFromDate = document.getElementById('txtFromPeriodBook').value;
                              pToDate = document.getElementById('txtToPeriodBook').value;
                          }

                          else if ($('#drpBooked').val() == 4) {
                              pFromDate = today + ' 00:00 AM';
                              pToDate = today + ' 23:59 PM';
                          }

                    }
                     
                    var LoginOrgID = CollecOrgAddrID;


                   
                    var BookingNumber = document.getElementById("txtBookNos").value;
                    var MobileNumber = document.getElementById("txtMob").value;

                    var Task = "Search";
                    var TelePhone = document.getElementById("txtTelephoneNo").value;
                    var pName = document.getElementById("txtPatientName").value;
                    var PageSize = 10;
                    var currentPageNo = 1;
                   
                    if (BookingNumber == "" || BookingNumber == null) {
                        BookingNumber = 0;
                    }
                    $.ajax({
                        type: "POST",
                        url: "../HCService.asmx/NewGetHomeCollectionDetails",
                        contentType: "application/json; charset=utf-8",
                        data: "{CollecttionFromdate:'" + pCollectionFromDate + "',CollecttionTodate:'" + pCollectionToDate + "',Fromdate:'" + pFromDate + "',Todate:'" + pToDate + "',CollecOrgID:'" + CollecOrgID + "',LoginOrgID:'" + LoginOrgID + "',Status:'" + BookingStatus + "',Task:'" + Task + "',Location:'" + Location + "',Pincode:'" + Pincode + "',UserID:'" + UserID + "',MobileNumber:'" + MobileNumber + "',TelePhone:'" + TelePhone + "',pName:'" + pName + "',PageSize:'" + PageSize + "',currentPageNo:'" + currentPageNo + "',BookingNumber:" + BookingNumber + "}",
                        dataType: "json",
                        success: AjaxGetFieldDataSucceeded,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            $('#example').hide();
                            $('#printDiv').hide();
                            return false;
                        }
                    });
                }
                catch (e) {
                    alert("Error");
                }
                return false;
            }
            function enable() {
                $('#example > tr').remove();
                $("#nav").empty();
            }
  
        </script>

        <script type="text/javascript" language="javascript">

            function SelectTab(source, eventArgs) {

                var location = eventArgs.get_value().split('|')[0];
                var locationdetails = location.split('~');
                document.getElementById('txtpincode').value = locationdetails[0];
                document.getElementById('txtPinCodeBo').value = locationdetails[0];

                document.getElementById('txtCity').value = locationdetails[1];
                document.getElementById('txtstate').value = locationdetails[2];
                //Regarding MobileAPP
                document.getElementById('hdnCityID').value = locationdetails[3];
                document.getElementById('hdnStateID').value = locationdetails[4];
                document.getElementById('hdnstate').value = locationdetails[2]

            }
            function Repagination() {
                //        $("#nav").empty();
                var rowsShown = 10;
                var rowsTotal = $('#example tbody tr').length;
                var numPages = rowsTotal / rowsShown;
                var a = document.getElementsByClassName("activebtn");

                $(this).addClass('activebtn');
                var rowsShown = 10;
                if ($(a).attr('rel') != null) {
                    var currPage = $(a).attr('rel');
                    //var currPage = 5;
                    var startItem = currPage * rowsShown;
                    var endItem = startItem + rowsShown;
                    $('#example tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
                }
                else { $("#nav").empty(); }
            }

            function Pageination() {
                $("#nav").empty();
                var rowsShown = 10;
                var rowsTotal = $('#example tbody tr').length;
                var numPages = rowsTotal / rowsShown;
                for (i = 0; i < numPages; i++) {
                    var pageNum = i + 1;
                    $('#nav').append('<a href="#" rel="' + i + '">' + pageNum + '</a> ');
                }
                $('#example tbody tr').hide();
                $('#example tbody tr').slice(0, rowsShown).show();
                $('#nav a:first').addClass('activebtn');
                $('#nav a').bind('click', function() {

                    $('#nav a').removeClass('activebtn');
                    $(this).addClass('activebtn');
                    var currPage = $(this).attr('rel');
                    var startItem = currPage * rowsShown;
                    var endItem = startItem + rowsShown;
                    $('#example tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
                });

            }

            function checkCodes() {
                var searchText = document.getElementById('txtbox1').value.toUpperCase().trim();
                searchTable(searchText);
            }

            function searchTable(inputVal) {
                var table = $('#example');
                if (inputVal.length > 0) {
                    table.find('tr').each(function(index, row) {
                        var allCells = $(row).find('td');
                        if (allCells.length > 0) {
                            var found = false;
                            allCells.each(function(index, td) {
                                var regExp = new RegExp(inputVal, 'i');
                                if (regExp.test($(td).text())) {
                                    found = true;
                                    return false;
                                }
                            });
                            if (found == true) $(row).show(); else $(row).hide();
                        }
                        //$(row).css('display', 'table-row');
                        //Pageination();
                    });
                }
                else {
                    $('#tfooterexample').css('display', 'table-row');
                    Pageination();
                }
            }

            function ForFutureDate(CDate) {
                //debugger;
                var MyDate = CDate;
                var sysDate = document.getElementById('hdncurdatetime').value;
                var curDay = parseInt(sysDate.split(' ')[0].split('/')[0]);
                var curMon = parseInt(sysDate.split(' ')[0].split('/')[1]);
                var curYear = parseInt(sysDate.split(' ')[0].split('/')[2]);
                var curhour = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[0]);
                var curminute = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[1]);
                var hour = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[0];
                var minute = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[1];
                var AMPM = MyDate.split(' ')[1].substring(5, 7);
                var campm = sysDate.split(' ')[2];
                minute = parseInt(minute);
                if (AMPM == 'PM') {
                    hour = parseInt(hour) + 12;
                }
                if (campm == 'PM' && curhour != 12) {
                    curhour = parseInt(curhour) + 12;
                }
                DateOnly = MyDate.split('-');
                var Day = parseInt(DateOnly[0]);
                var Mon = parseInt(DateOnly[1]);
                var Year = parseInt(DateOnly[2]);

                if ((Day < curDay && Mon == curMon && Year == curYear) || (Mon < curMon && Year == curYear) || (Year < curYear)
             || (hour < curhour && Day == curDay && Mon == curMon) || (minute < curminute && hour == curhour && Day == curDay && Mon == curMon)) {
                    ValidationWindow("Dont select Collection date and Time as past Date.", "Alert");                    
                    return false;
                }

            }

        </script>

        <script language="javascript" type="text/javascript">
            function GetSample() {

            }
            function GetPatientSearchList() {
                //debugger;
                var PatientNamesearch = $('#txtPatientName').val();
                var rdoSearchType = $("#rblSearchType").find(":checked").val();

                if (rdoSearchType != "4") {// If value is 4 then Search Type is none.
                    monkeyPatchAutocompleteTableApp();
                    $('#txtPatientName').autocomplete({
                        source: function(request, response) {
                            $.ajax({
                                type: "POST",
                                url: "../HCService.asmx/GetPatientListforBookings",
                                data: "{'prefixText':'" + PatientNamesearch + "','contextKey':'Y','flag':" + rdoSearchType + "}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
crossDomain: true,
                                success: function(result) {
                                    //debugger;
                                    index = 0;
                                    var autoCompleteArray = new Array();
                                    autoCompleteArray = $.map(result.d, function(item) {
                                        var sData = item.replace(/,/g, " ")
                                        var Name = sData.split('~');
                                        //var Name = item.split('~');
                                        //var Name = item.split(',')[1].split(':')[1].split('~');
                                        return {
                                            label: Name[0],
                                            PatientName: Name[1],
                                            PatientNumber: Name[3],
                                            MobileNumber: Name[5],
                                            DOB: Name[7],
                                            Age: Name[9],
                                            Address: Name[23],
                                            City: Name[13],
                                            TelephoneNo: Name[31],
                                            Sex: Name[11],
                                            EMail: Name[35],
                                            pincode: Name[21],
                                            location: Name[25],
                                            state: Name[17],
                                            CityID: Name[15],
                                            StateID: Name[19],
                                            BookingID: Name[33],
                                            Salutation: Name[36], //New Included
                                            CountryID: Name[37],
                                            DispatchType: Name[38],
                                            URNTypeID: Name[39],
                                            URNNo: Name[40],
                                            UserID: Name[41],
                                            CollectionTime: Name[42],
                                            ClientName:Name[43],
                                            ClientID: Name[44],
                                            ClientCode:Name[45]
                                        };
                                    });
                                    response(autoCompleteArray);
                                }
                            });
                        },
                        minlength: 0,
                        select: function(event, ui) {
                            $('#txtPatientName').val(ui.item.PatientName);
                            IAmSelected(ui, event);
                            return false;
                        }
                    });
                }
            }
            function monkeyPatchAutocompleteTableApp() {

                var oldFn = $.ui.autocomplete.prototype._renderItem;
                $.ui.autocomplete.prototype._renderItem = function(ul, item) {
                    //debugger;

                    var re = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + this.term + ")(?![^<>]*>)(?![^&;]+;)", "gi");
                    var t = item.label.replace(re, "<span style='font-weight:bold;'>$1</span>");
                    if (index == 0) {
                        //ul.prepend("<table><tr><td><li style='padding:0;margin:0;'><div class='borderGrey lh25 bold' style='min-width:640px;padding:0;margin:0;background:#f5f5f5;'><div class='borderGreyR w-30p inline-block'>Patient Name</div><div class='borderGreyR w-20p inline-block'>Patient Number</div><div class='borderGreyR w-28p inline-block'>Mobile Number</div><div class='w-20p inline-block'> Age </div></div></li></td></tr></table>")---<td class='w-25p activeheader'>Patient Number</td>
                        //ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")
                       // ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide w-30p'> Address </td></li></td></tr></table>")
                          ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")

                        index = 1;
                    }
                    //return $("<li></li>")
                    return $("<tr></tr>")
                  .data("item.autocomplete", item)
                                       //   .append("<td class='borderGreyR w-30p  table-cell'>" + item.BookingID + "</td><td  class='borderGreyR w-30p table-cell'>" + item.PatientName + "</td><td  class='borderGreyR w-30p table-cell'>" + item.MobileNumber + "</td><td class='w-30p table-cell'>" + item.Age + "</td><td class=' w-30p hide'>" + item.Address + "</td></td></a></td>")
									     .append("<td class='w-10p borderGreyR table-cell'>" + item.BookingID + "</td><td  class='w-25p borderGreyR table-cell'>" + item.PatientName + "</td><td class='w-25p borderGreyR table-cell'>" + item.PatientNumber + "</td><td  class='w-30p borderGreyR table-cell'>" + item.MobileNumber + "</td><td class='w-30p borderGreyR table-cell'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")
                    //.append("<td class='borderGreyR w-12p  table-cell'>" + item.BookingID + "</td><td class='borderGreyR w-25p table-cell'>" + item.PatientName + "</td><td class='borderGreyR w-25p inline-block'>" + item.PatientNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.MobileNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")----<td  class='borderGreyR w-25p table-cell'>" + item.PatientNumber + "</td>

                  .appendTo(ul);

                    //}
                };
            }

            function IAmSelected(source, eventArgs) {

              //   debugger;
                document.getElementById('txtPatientName').value = source.item.PatientName;
                document.getElementById('txtAddress').value = source.item.Address;

                document.getElementById('txtCity').value = source.item.City;
                var PatientDOB = source.item.DOB;
                document.getElementById('txtDOBNos').value = PatientDOB;
                document.getElementById('hdnNewDOB').value = PatientDOB;
                document.getElementById('txtMobile').value = source.item.MobileNumber;
                document.getElementById('txtTelephoneNo').value = source.item.TelephoneNo;
                var ageVal = source.item.Age.substr(0, 2);
                if (ageVal != '') {
                    if (ageVal.length < 3) {
                        var days = new Date();
                        var gyear = days.getFullYear();
                        dobYear = gyear - ageVal;
                        //document.getElementById('tDOB').value = '01/01/' + dobYear;
                        document.getElementById('tDOB').value = PatientDOB;
                    }
                }

                document.getElementById('ddlSex').value = source.item.Sex;

                document.getElementById('txtDOBNos').value = source.item.Age.split(' ')[0];
                document.getElementById('ddlDOBDWMY').value = source.item.Age.split(' ')[1];
                document.getElementById('txtEmail').value = source.item.EMail;
                var location = source.item.location;
                //document.getElementById('txtSuburb').value = location;
                document.getElementById('txtSuburb').value = source.item.location;

                document.getElementById('txtpincode').value = source.item.pincode;
                document.getElementById('txtstate').value = source.item.state;
                document.getElementById('hdnCityID').value = source.item.CityID;
                document.getElementById('hdnStateID').value = source.item.StateID;
                document.getElementById('hdnstate').value = source.item.state;
                document.getElementById('ddSalutation').value = source.item.Salutation;
                document.getElementById('hdnCountryID').value = source.item.CountryID;
                

                /*Added By Prabakar*/
                var PatientNumber = "";
                PatientNumber = 'Patient Number: ';
                PatientNumber += source.item.PatientNumber;
                document.getElementById('lblPatientNumber').innerHTML = PatientNumber;
                document.getElementById('trPatientNumber').style.display = "block";
                document.getElementById('hdnBookingID').value = source.item.BookingID;
                var DispatchValue = source.item.DispatchType;
                

                if (DispatchValue != undefined && DispatchValue != '' && DispatchValue != null) {
                    document.getElementById('hdnDispatch').value = DispatchValue;
                    var LstDispatchedtype = DispatchValue.split(' ');
                    for (var j = 0; j < LstDispatchedtype.length; j++) {
                        $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                            if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedtype[j]) {
                                this.checked = true;
                            }
                        });
                    }
                }

                document.getElementById('ddlUrnType').value = source.item.URNTypeID;
                document.getElementById('txtURNo').value = source.item.URNNo;
                document.getElementById('ddlUser').value = source.item.UserID;
                if (source.item.CollectionTime != '') {
                    document.getElementById('txtTime').value = source.item.CollectionTime;
                    document.getElementById('hdncurdatetime').value = source.item.CollectionTime;
                }
                document.getElementById('txtClient').value = source.item.ClientName;
                LoadPreviousBillingItems_HC();
            }

        </script>

        <script language="javascript" type="text/javascript">
            function StatusAlert() {
                alert('Home collection for this Patient has been already completed');
                return false;
            }
            function ValidateDate() {

            }
            function validatePageNumber() {
                if (document.getElementById('txtpageNo').value == "") {
                    return false;
                }
            }
        </script>

        <script language="javascript" type="text/javascript">


            function CheckDischarge() {

            }
            function CheckFromDate() {

            }
            function CheckToDate() {

            }
            function CheckCollDate() {

            }
            function CheckCollto() {

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
            function SelectedPatient(BookingID, BookingStatus, PatientName, Age, DOB, SEX, PhoneNumber, CollectionAddress, CollectionAddress2, City, CollectionTime, LandLineNumber, RoleID, UserID, BookingOrgID, OrgAddressID, Priority, CityID, StateID, State, Pincode, BillDescription) {
                //debugger;
                if (BookingStatus == 'Registered') {
                    alert('The patient has been already registered you cannot Edit');
                    return false;
                }
                if (BookingStatus == 'Cancelled') {
                    alert('The patient has been already cancelled you cannot Edit');
                    return false;
                }
                $("#ddlStatus option[value='R']").attr("disabled", "disabled");

                showEdit();

                document.getElementById('<%= hdnSelectedBookingID.ClientID %>').value = BookingID;
                document.getElementById('<%= txtPatientName.ClientID %>').value = PatientName;
                document.getElementById('<%= txtDOBNos.ClientID %>').value = Age.split(' ')[0];
                document.getElementById('<%= ddlSex.ClientID %>').value = Age.split('/')[1];
                document.getElementById('<%= tDOB.ClientID %>').value = DOB.toString();

                document.getElementById('<%= txtMobile.ClientID %>').value = PhoneNumber;
                document.getElementById('<%= txtTelephoneNo.ClientID %>').value = LandLineNumber;
                document.getElementById('<%= txtAddress.ClientID %>').value = CollectionAddress.split('~')[0];

                document.getElementById('<%= txtSuburb.ClientID %>').value = CollectionAddress.split('~')[1];
                document.getElementById('<%= txtCity.ClientID %>').value = CollectionAddress.split('~')[2];
                document.getElementById('<%= txtTime.ClientID %>').value = CollectionTime;


                // loadUsers();

                if (RoleID > 0) {
                    document.getElementById('<%= ddlUser.ClientID %>').disabled = false;
                    document.getElementById('<%= ddlUser.ClientID %>').value = UserID;
                }

                document.getElementById('hdnuserselectedval').value = UserID;
                document.getElementById('<%= hdnCityID.ClientID %>').value = CityID;
                document.getElementById('<%= txtstate.ClientID %>').value = State;
                document.getElementById('<%= hdnStateID.ClientID %>').value = StateID;
                document.getElementById('<%= txtpincode.ClientID %>').value = Pincode;
                document.getElementById('<%= txtFeedback.ClientID %>').value = BillDescription;

                if (BookingStatus == 'Booked') {
                    document.getElementById('<%= ddlStatus.ClientID %>').value = "B";
                }
                else if (BookingStatus == 'Completed') {
                    document.getElementById('<%= ddlStatus.ClientID %>').value = "R";
                }
                else {
                    document.getElementById('<%= ddlStatus.ClientID %>').value = "C";
                }

            }
            function ValidatePatientName() {

                if (document.getElementById('hdnPatientID').value == '') {
                    ValidationWindow('Select patient name', 'Alert');
                    return false;
                }

                return CheckVisitID();
            }
            function CheckVisitID() {

                var ddlaction = document.getElementById('dList')

                if (ddlaction.options[ddlaction.selectedIndex].text == 'Make Visit Entry') {
                    if (document.getElementById('hdnstatus').value == 'Registered') {

                        alert('Selected Patient has been already Investigated');
                        return false;
                    }
                    if (document.getElementById('hdnstatus').value == 'Cancelled') {

                        alert('Selected Patient Booking already Cancelled');
                        return false;
                    }
                }
                else if (ddlaction.options[ddlaction.selectedIndex].text == 'Register Home Collection') {
                    if (document.getElementById('hdnstatus').value == 'Cancelled') {
                        alert('Selected Patient has been already Cancelled');
                        return false;
                    }
                }

            }

            function ValidateIsNewPatient() {
                if (document.getElementById('rdoPatientSave').checked == true) {
                    if (document.getElementById('hdnSelectedPatientID').value == '' || document.getElementById('hdnSelectedPatientID').value == null) {
                        document.getElementById('tdChkNewPatient').style.display = 'table-cell';
                    }
                }
            }
            function ValidatePincodeAndLocation() {
                //if (document.getElementById('rdoPatientSave').checked == true) {
                if (document.getElementById('txtSuburb').value == '') {
                    document.getElementById('txtpincode').value = '';
                    document.getElementById('txtCity').value = ''
                    document.getElementById('txtstate').value = '';
                    document.getElementById('hdnCityID').value = '';
                    document.getElementById('hdnStateID').value = '';
                    document.getElementById('hdnstate').value = '';
                    document.getElementById('hdnCountryID').value = '';
                }
                else if (document.getElementById('txtpincode').value == '') {
                    document.getElementById('txtSuburb').value = '';
                    document.getElementById('txtCity').value = ''
                    document.getElementById('txtstate').value = '';
                    document.getElementById('hdnCityID').value = '';
                    document.getElementById('hdnStateID').value = '';
                    document.getElementById('hdnstate').value = '';
                    document.getElementById('hdnCountryID').value = '';
                }
                // }

            }
            function ClearPatientId() {
                document.getElementById('hdnSelectedPatientID').value = '';
            }
            function showEdit() {
                // document.getElementById('<%= ddlUser.ClientID %>').disabled = false;
                document.getElementById('tbmain').style.display = 'table';
                document.getElementById('tdStatus').style.display = 'table-cell';
                document.getElementById('tdddlStatus').style.display = 'table-cell';
                document.getElementById('tdaddtxt').style.display = 'table-cell';
                document.getElementById('tdtxtAddress').style.display = 'table-cell';
                document.getElementById('tdbtnSearch').style.display = 'none';
                document.getElementById('tdbtnUpdate').style.display = 'table-cell';
                document.getElementById('tdbtnSave').style.display = 'none';
                // document.getElementById('trserdate').style.display = 'none';
                //document.getElementById('trcollect').style.display = 'none';
                document.getElementById('tdtime').style.display = 'table-cell';
                document.getElementById('tdtimetxt').style.display = 'table-cell';
                document.getElementById('trSaveDate').style.display = 'table-row';
                document.getElementById('tdsex1').style.display = 'table-cell';
                document.getElementById('tdsex2').style.display = 'table-cell';
                document.getElementById('tdAge1').style.display = 'table-cell';
                document.getElementById('tdAge2').style.display = 'table-cell';
                //document.getElementById('tdChkNewPatient').style.display = 'none';
                document.getElementById('tdBookingNo1').style.display = 'none';
                document.getElementById('tdBookingNo2').style.display = 'none';
                document.getElementById('txtCollFrom').style.display = 'none';
                document.getElementById('txtCollto').style.display = 'none';
                document.getElementById('lblcollfrom').style.display = 'none';
                document.getElementById('lblcollto').style.display = 'none';
                document.getElementById('GrdFooter').style.display = 'block';
                document.getElementById('trBilling').style.display = 'none';
                //  document.getElementById('loc').style.display = 'none'; 
                document.getElementById('tdCollect1').style.display = 'none';
                document.getElementById('tdCollect2').style.display = 'none';
                document.getElementById('tduserid').style.display = 'table-cell';
                document.getElementById('trBilling').style.display = 'none';
            }

            function showsave() {

                if (document.getElementById('rdoPatientSave').checked = true) {
                    document.getElementById('rdoPatientSearch').checked = false;
                    document.getElementById('<%= ddlUser.ClientID %>').disabled = false;
                    document.getElementById('trBilling').style.display = 'table-row';
                    document.getElementById('tblBook').style.display = 'none';
                    document.getElementById('tbmain').style.display = 'table';
                    document.getElementById('AdvanceSearchDetails').style.display = 'none';
                    document.getElementById('btnSearchArea').style.display = 'none';

                    //document.getElementById('chkNewPatient').style.display = 'inline';
                    //document.getElementById('lblchknew').style.display = 'inline';
                    document.getElementById('tdStatus').style.display = 'none';
                    document.getElementById('tdddlStatus').style.display = 'none';
                    document.getElementById('tdaddtxt').style.display = 'table-cell';
                    document.getElementById('tdtxtAddress').style.display = 'table-cell';
                    document.getElementById('tdbtnSearch').style.display = 'none';
                    document.getElementById('tdbtnSave').style.display = 'table-cell';
                    //  document.getElementById('trserdate').style.display = 'none';
                    // document.getElementById('trcollect').style.display = 'none';
                    document.getElementById('tdtime').style.display = 'table-cell';
                    document.getElementById('tdtimetxt').style.display = 'table-cell';
                    document.getElementById('tdbtnUpdate').style.display = 'none';
                    document.getElementById('tdBookingNo1').style.display = 'none';
                    document.getElementById('tdBookingNo2').style.display = 'none';
                    document.getElementById('trSaveDate').style.display = 'table-row';
                    document.getElementById('tdsex1').style.display = 'table-cell';
                    document.getElementById('tdsex2').style.display = 'table-cell';
                    document.getElementById('tdAge1').style.display = 'table-cell';
                    document.getElementById('tdAge2').style.display = 'table-cell';
                    document.getElementById('tdlblDOB').style.display = 'table-cell';
                    document.getElementById('tdtxtDOB').style.display = 'table-cell';


                    document.getElementById('GrdFooter').style.display = 'none';

                    document.getElementById('loc').style.display = 'table-row';
                    //document.getElementById('imgMan').style.display = 'block';
                    //  document.getElementById('tduserid').style.display = 'table-cell';
                    //document.getElementById('imgMan1').style.display = 'block';
                    //                    document.getElementById('tdspce1').style.display = 'table-cell';
                    //                    document.getElementById('tdspce2').style.display = 'table-cell';
                    //                    document.getElementById('tdspce3').style.display = 'table-cell';
                    //                    document.getElementById('tdspce4').style.display = 'table-cell';
                    //                    document.getElementById('tdspce5').style.display = 'table-cell';
                    document.getElementById('td5').width = "14%";
                    $('#printDiv').hide();
                    //$('#example').empty();


                    document.getElementById('txtURNo').style.display = 'table-cell';
                    document.getElementById('Rs_URN').style.display = 'table-cell';
                    document.getElementById('ddlUrnType').style.display = 'table-cell';
                    document.getElementById('Rs_URNType').style.display = 'table-cell';
                    document.getElementById('txtEmail').style.display = 'table-cell';
                    document.getElementById('lblEmail').style.display = 'table-cell';
                    document.getElementById('tdemail').style.display = 'table-row';
                    $('[id$=tdAttributes]').css('display', 'none');
                    $('[id$=tdPreviousDue]').css('display', 'none');
                    /*Added By Prabakar*/
                    document.getElementById('trPatientSearch').style.display = '';
                    document.getElementById('trPatientNumber').style.display = '';
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
                document.getElementById('<%= txtFeedback.ClientID %>').value = '';
                document.getElementById('<%= txtCity.ClientID %>').value = '';
                document.getElementById('<%= txtpincode.ClientID %>').value = '';
                document.getElementById('<%= txtTime.ClientID %>').value = document.getElementById('<%= hdncurdatetime.ClientID %>').value;
                document.getElementById('<%= ddlStatus.ClientID %>').value = '0';

                document.getElementById('<%= tdStatus.ClientID %>').value = '';
                document.getElementById('<%= txtBookingNumber.ClientID %>').value = '';


                //           document.getElementById('<%= ddlUser.ClientID %>').value = '0';

                return false;
            }
            function showsearch() {


                if (document.getElementById('rdoPatientSearch').checked = true) {
                    document.getElementById('rdoPatientSave').checked = false;
                    // document.getElementById('chkNewPatient').style.display = 'none';
                    // document.getElementById('lblchknew').style.display = 'none';

                    document.getElementById('trBilling').style.display = 'none';
                    //document.getElementById('<%= ddlUser.ClientID %>').disabled = false;
                    document.getElementById('tblBook').style.display = 'block';
                    document.getElementById('tbmain').style.display = 'none';
                    document.getElementById('AdvanceSearchDetails').style.display = 'block';
                    $('#AdvanceSearchDetails').slideUp();
                    document.getElementById('btnSearchArea').style.display = 'block';
                    document.getElementById('HCReportpanel').style.display = 'none';
                    $('#txtLoc').val('');
                    $('#txtPinCodeBo').val('');
                    document.getElementById("btnSave").style.display = 'table-row';
                    document.getElementById("BtnUpdateBook").style.display = 'none';
                    document.getElementById('chkAdvanceSearch').checked = false;
                    //                    document.getElementById('tdStatus').style.display = 'table-cell';
                    //                    document.getElementById('tdddlStatus').style.display = 'table-cell';
                    //                    document.getElementById('tdBookingNo1').style.display = 'table-cell';
                    //                    document.getElementById('tdBookingNo2').style.display = 'table-cell';
                    //                    document.getElementById('txtCollFrom').style.display = 'inline';
                    //                    document.getElementById('txtCollto').style.display = 'inline';
                    //                    document.getElementById('lblcollfrom').style.display = 'table-row';
                    //                    document.getElementById('lblcollto').style.display = 'block';
                    //                    document.getElementById('tdbtnSearch').style.display = 'table-cell';
                    //                    document.getElementById('trserdate').style.display = 'table-row';
                    //                    //document.getElementById('trcollect').style.display = 'table-row';
                    //                    //document.getElementById('chkNewPatient').style.display = 'none';
                    //                    document.getElementById('loc').style.display = 'table-row';
                    //                    document.getElementById('tduserid').style.display = 'table-cell';
                    //                    document.getElementById('tdCollect1').style.display = 'table-cell';
                    //                    document.getElementById('tdCollect2').style.display = 'table-cell';
                    //                    document.getElementById('tdloc1').style.display = 'table-cell';
                    //                    document.getElementById('tdloc2').style.display = 'table-cell';
                    //                    // document.getElementById('loc').style.display = 'block';
                    //                    //document.getElementById('imgMan1').style.display = 'none';


                    //                    //document.getElementById('imgMan1').style.display = 'none';
                    //                    document.getElementById('tdtime').style.display = 'none';
                    //                    document.getElementById('tdtimetxt').style.display = 'none';
                    document.getElementById('tdbtnUpdate').style.display = 'none';
                    //                    //  document.getElementById('imgMan').style.display = 'none';
                    //                    document.getElementById('tdaddtxt').style.display = 'none';
                    //                    document.getElementById('tdtxtAddress').style.display = 'none';
                    document.getElementById('tdbtnSave').style.display = 'none';
                    //document.getElementById('trSaveDate').style.display = 'none';
                    //                    document.getElementById('tdlblDOB').style.display = 'none';
                    //                    document.getElementById('tdtxtDOB').style.display = 'none';
                    //                    document.getElementById('tdsex1').style.display = 'none';
                    //                    document.getElementById('tdsex2').style.display = 'none';
                    //                    document.getElementById('tdAge1').style.display = 'none';
                    //                    document.getElementById('tdAge2').style.display = 'none';

                    //                    //document.getElementById('tdChkNewPatient').style.display = 'none';
                    //                    document.getElementById('tdspce1').style.display = 'none';
                    //                    document.getElementById('tdspce2').style.display = 'none';
                    //                    document.getElementById('tdspce3').style.display = 'none';
                    //                    document.getElementById('tdspce4').style.display = 'none';
                    //                    document.getElementById('tdspce5').style.display = 'none';
                    //                    document.getElementById('td5').width = "18%";
                    //                    document.getElementById('txtURNo').style.display = 'none';
                    //                    document.getElementById('Rs_URN').style.display = 'none';
                    //                    document.getElementById('ddlUrnType').style.display = 'none';
                    //                    document.getElementById('Rs_URNType').style.display = 'none';
                    //                    document.getElementById('txtEmail').style.display = 'none';
                    //                    document.getElementById('lblEmail').style.display = 'none';
                    //                    document.getElementById('tdemail').style.display = 'none';
                    $('[id$=tdAttributes]').css('display', 'none');
                    $('[id$=tdPreviousDue]').css('display', 'none');
                    /*Added By Prabakar*/
                    document.getElementById('trPatientSearch').style.display = 'none';
                    document.getElementById('trPatientNumber').style.display = 'none';
                }

            }
            function validate(Event) {

                var btnID = Event.id;
                if (document.getElementById('txtPatientName').value == '') {
                    ValidationWindow('Please enter the Patient Name', 'Alert');
                    document.getElementById('txtPatientName').focus();
                    return false;
                }
                if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                    ValidationWindow('Select Gender', 'Alert');
                    document.getElementById('ddlSex').focus();
                    return false;

                }
                if (document.getElementById('txtDOBNos').value == '') {
                    ValidationWindow('Please enter the Age', 'Alert');
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
                if (document.getElementById('txtDOBNos').value != '') {
                    //                    document.getElementById('hdnNewDOB').value = document.getElementById('tDOB').value();
                    $('#<%=hdnNewDOB.ClientID %>').val($('#tDOB').val());
                }
                if (document.getElementById('txtpincode').value == '') {
                    ValidationWindow('Please Enter a Pincode or Location', 'Alert');
                    document.getElementById('txtpincode').focus();
                    return false;
                }
                if (document.getElementById('txtAddress').value == '') {
                    ValidationWindow('Please Enter Patient\'s Collection Address', 'Alert');
                    document.getElementById('txtAddress').focus();
                    return false;
                }
                if (document.getElementById('ddlOrg1').options[document.getElementById('ddlOrg1').selectedIndex].text == '------Select------') {
//                var ddlaction = document.getElementById('ddlOrg1');
//                if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
                    ValidationWindow('Please Select a Organization', 'Alert');
                    return false;
                }
                if (document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].text == '------Select------') {
//                var ddlLocation = document.getElementById('ddlLocation');
//                if (ddlLocation.options[ddlLocation.selectedIndex].text == '--Select--' && $('#ddlLocation').val()==null) {
                    ValidationWindow('Please Select a Location', 'Alert');
                    document.getElementById('ddlLocation').focus();
                    return false;
                }

                if (document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].text == '------Select------') {
                    
                    if (document.getElementById('<%=hdnHCTechScheduler.ClientID %>').value == "N") {
                        ValidationWindow('Please select the Technician', 'Alert');
                        document.getElementById('ddlUser').focus();
                        return false;
                     }   
                }
                if (document.getElementById('txtMobile').value == '') {

                    ValidationWindow('Enter the Mobile Number', 'Alert');
                    document.getElementById('txtMobile').focus();
                    return false;
                }
                if (document.getElementById('txtEmail').value == '') {

                    if (document.getElementById('hdnIsNonMandatoryEmail').value == 'Y') {
                        ValidationWindow('Please enter a valid Email address', 'Alert');
                       document.getElementById('txtEmail').focus();
                       return false;
                    }
                }
                if (document.getElementById('txtInternalExternalPhysician').value == '') {

                    if (document.getElementById('hdnIsMandatoryEmailandRefDr').value == 'Y') {
                        ValidationWindow('Please select Refering Physician', 'Alert');
                        document.getElementById('txtInternalExternalPhysician').focus();
                        return false;
                    }
                }
                if (document.getElementById('txtClient').value == '') {
                    if (document.getElementById('hdnIsNonMandatoryClientName').value == 'Y') {
                        ValidationWindow('Please select Client Name', 'Alert');
                        document.getElementById('txtClient').focus();
                        return false;
                    }
                }
                if (document.getElementById('rdoPatientSave').checked == true) {

                    if (document.getElementById('txtTime').value == '') {
                        if (document.getElementById('hdnIsNonMandatoryCollectionDt').value != 'Y') {
                            ValidationWindow('Please Enter the Sample Collection Time', 'Alert');
                            return false;
                        }
                    }
                    else {
                        var CDate = document.getElementById('txtTime').value;
                         ForFutureDate(CDate);
                    }

                }
                if (btnID == 'btnSave') {
                    if ($('#billPart_divItemTable tr').length <= 1) {
                        ValidationWindow("Include Billing details", "Alert");
                        $('#billPart_txtTestName').focus();
                        return false;
                    }
                }
                DispatchChecked();
                return true;
            }





            function resetsave() {
                clearControle();

                if (document.getElementById('grdResult') != null && document.getElementById('grdResult') != "") {
                    document.getElementById('grdResult').style.display = 'none';
                    document.getElementById('divPrint').style.display = 'none';
                    document.getElementById('divPrintarea').style.display = 'none';
                    document.getElementById('aRow').style.display = 'none';
                    document.getElementById('tdBookingNo1').style.display = 'none';
                    document.getElementById('tdBookingNo2').style.display = 'none';
                }

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

                document.getElementById('txtPatientName').value = "";
                document.getElementById('txtAddress').value = "";
                document.getElementById('txtSuburb').value = "";
                document.getElementById('txtpincode').value = "";
                document.getElementById('txtCity').value = "";
                document.getElementById('txtstate').value = "";

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
				   document.getElementById('txtBookNos').value = "";
                document.getElementById('txtMob').value = "";
                clearControle();
            }

            function clearControle() {
                document.getElementById('txtPatientName').value = "";
                document.getElementById('txtAddress').value = "";
                document.getElementById('txtSuburb').value = "";
                document.getElementById('txtpincode').value = "";
                document.getElementById('txtCity').value = "";
                document.getElementById('txtstate').value = "";
                document.getElementById('tDOB').value = "";
                document.getElementById('txtDOBNos').value = "";
                document.getElementById('txtMobile').value = "";
                document.getElementById('txtTelephoneNo').value = "";
                document.getElementById('ddlSex').value = "0";
                document.getElementById('ddSalutation').value = "0";
                //document.getElementById('ddlLocation').value = "0";
                document.getElementById('hdnSelectedPatientID').value = "";
                document.getElementById('hdnPatientID').value = "";
                document.getElementById('hdnPatientName').value = "";
                document.getElementById('hdnBookingNumber').value = "";
                document.getElementById('txtEmail').value = "";
                document.getElementById('<%= ddlUser.ClientID %>').value = '0';
                $('#ddlUrnType').val('0');
                document.getElementById('txtURNo').value = "";
                document.getElementById('txtFeedback').value = "";

                document.getElementById('chkDespatchMode_0').checked = false;
                document.getElementById('chkDespatchMode_1').checked = false;
                document.getElementById('chkDespatchMode_2').checked = false;
                document.getElementById('txtInternalExternalPhysician').value = "";
                document.getElementById('<%= txtBookingNumber.ClientID %>').value = '';
                //            addDate();
                document.getElementById('txtTime').value = getDateTimeNow();
                document.getElementById('txtPatientName').focus();
                clearBillPart();

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

            //            function CheckDates(splitChar) {
            //                //
            //                var today = new Date();
            //                var now = today.getDate() + splitChar + (today.getMonth() + 1) + splitChar + today.getFullYear();
            //                if (document.getElementById('txtFrom').value == '') {
            //                    alert('Select From Date!');
            //                    return false;
            //                }
            //                else if (document.getElementById('txtTo').value == '') {
            //                    alert('Select To Date!');
            //                    return false;
            //                }
            //                else {
            //                    //Assign From And To Date from Controls 
            //                    DateFrom = document.getElementById('txtFrom').value.split(splitChar);
            //                    DateTo = document.getElementById('txtTo').value.split(splitChar);
            //                    DateNow = now.split(splitChar);
            //                    
            //                }
            //            }


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


            //            function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            //                var key;
            //                var isCtrl = false;
            //                var keychar;
            //                var reg;

            //                if (window.event) {
            //                    key = e.keyCode;
            //                    isCtrl = window.event.ctrlKey
            //                }
            //                else if (e.which) {
            //                    key = e.which;
            //                    isCtrl = e.ctrlKey;
            //                }

            //                if (isNaN(key)) return true;

            //                keychar = String.fromCharCode(key);

            //                // check for backspace or delete, or if Ctrl was pressed
            //                if (key == 8 || isCtrl) {
            //                    return true;
            //                }

            //                reg = /\d/;
            //                var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            //                var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            //                return isFirstN || isFirstD || reg.test(keychar);
            //            }

        </script>

        <script type="text/javascript">
            function expandDropDownListPage(elementRef) {
                elementRef.style.width = '210px';
            }

            function collapseDropDownList(elementRef) {
                elementRef.style.width = elementRef.normalWidth;

            }

            function clearClick() {
                if (window.confirm("Are you sure you want to clear?")) {
                    $("input").attr('disabled', false);
                    document.getElementById('<%= hdnSelectedBookingID.ClientID %>').value = 0;
                    document.getElementById('<%= txtPatientName.ClientID %>').value = '';
                    document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
                    document.getElementById('<%= txtEmail.ClientID %>').value = '';
                    document.getElementById('<%= ddlSex.ClientID %>').value = 'M';
                    document.getElementById('<%= txtMobile.ClientID %>').value = '';
                    document.getElementById('<%= txtAddress.ClientID %>').value = '';
                    document.getElementById('<%= txtTelephoneNo.ClientID %>').value = '';
                    document.getElementById('<%= txtSuburb.ClientID %>').value = '';
                    document.getElementById('<%= txtCity.ClientID %>').value = '';
                    document.getElementById('<%= txtpincode.ClientID %>').value = '';
                    document.getElementById('<%= txtstate.ClientID %>').value = '';
                    document.getElementById('<%= txtFeedback.ClientID %>').value = '';
                    document.getElementById('<%= txtTime.ClientID %>').value = document.getElementById('<%= hdncurdatetime.ClientID %>').value;
                    document.getElementById('<%= ddlStatus.ClientID %>').value = '0';
                    document.getElementById('chkDespatchMode_0').checked = false;
                    document.getElementById('chkDespatchMode_1').checked = false;
                    document.getElementById('chkDespatchMode_2').checked = false;
                    document.getElementById('<%= ddlUser.ClientID %>').value = '0';
                    document.getElementById('<%= tDOB.ClientID %>').value = 'dd/MM/yyyy';
                    //document.getElementById('grdResult').style.display = 'none';
                    document.getElementById('divPrint').style.display = 'none';
                    //   document.getElementById('divPrintarea').style.display = 'none';
                    document.getElementById('GrdFooter').style.display = 'none';
                    document.getElementById('aRow').style.display = 'none';
                    document.getElementById('printDiv').style.display = 'none';
                    //$('#example').empty();
                    document.getElementById('txtInternalExternalPhysician').value = "";


                    document.getElementById('<%= ddlUrnType.ClientID %>').value = '0';
                    document.getElementById('txtURNo').disabled = true;
                    $("#ddlSex").val(0);
                    $("#ddSalutation").val(0);
                    //  $("#ddlUser").val(0);
                    $('#ddlUser').append('<option value="0">----Select-----</option>');
                    document.getElementById('<%= ddlUser.ClientID %>').value = '0';
                    document.getElementById('<%= hdnNewDOB.ClientID %>').value = '0';
                    // $("#ddlUser").val('');
                    //$('#searchField').val('');
                    //  $("#nav").empty();
                    clearBillPart();
                    return false;
                }
                else {
                    return false;
                }
            }
            function clearBillPart() {
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
                    ValidationWindow("Booked Patient Cannot Changed to Registered Here!!", "Alert");
                    return false;
                }

                //             ------Select------
                if (document.getElementById('ddlHCRole').options[document.getElementById('ddlHCRole').selectedIndex].text == '------Select------') {
                    ValidationWindow('Please Select a Role', 'Alert');
                    document.getElementById('ddlHCRole').focus();
                    return false;
                }
                if (document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].text == '------Select------') {
                    ValidationWindow('Please Select a User', 'Alert');
                    document.getElementById('ddlUser').focus();
                    return false;
                }
            }

            function CollectiontimeValidation() {

                var userid = document.getElementById('ddlUser').value;
                var collectiontime = document.getElementById('txtTime').value;

                $.ajax({

                    type: "POST",
                    url: "../HCService.asmx/GetHomeCollectionTime",

                    data: "{'userid': '" + userid + "','collectiontime':'" + collectiontime + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function(data) {
                        $.each(data.d, function(key, jsonvalue) {

                            //$("#txtTest").val(jsonvalue.PatientID);
                        ValidationWindow(jsonvalue.PatientID, 'Information');
                        });

                    }


                });

            }
            function showlocation() {

                var value = document.getElementById('txtpincode').value;
                 $("input[id*=txtPincode]").val(value); 
                if (value == '' || value == null) {
                    var value = document.getElementById('txtPinCodeBo').value;

                }

                $.ajax({
                    type: "POST",
                    url: "../HCService.asmx/GetLocationforHomeCollectionpincode",
                    data: '{"pincode": "' + value + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(data) {
                        $.each(data.d, function(key, jsonvalue) {
                            //debugger;
                            $("#txtpincode").val(jsonvalue.Pincode);
                            $("#txtSuburb").val(jsonvalue.LocationName);
                            $("#txtCity").val(jsonvalue.CityName);
                            $("#txtstate").val(jsonvalue.StateName);
                            $("#hdnStateID").val(jsonvalue.StateID);
                            $("#hdnCityID").val(jsonvalue.CityID);
                            $("#hdnCountryID").val(jsonvalue.ModifiedBy); // Get CountryID
                            $("#txtLoc").val(jsonvalue.LocationName);

                        });

                    }


                });

            }

            function IsCollectionDt() {
                if (document.getElementById('hdnIsNonMandatoryCollectionDt').value != 'Y') {
                    timevalidate()
                }
            }
            
            function IsPickDt() {
                var collectiontime = document.getElementById('txtTime').value;
            var collectiontime1 = collectiontime.replaceAll('-','/');
           // collectiontime1 = collectiontime.replace('-','/');
            console.log(collectiontime1)
             collectiontime1 = collectiontime1.substring(0, 10);
                $("input[id*=txtDate]").val(collectiontime1); 
            }
            
            function timevalidate() {
                var userid = document.getElementById('ddlUser').value;
                var collectiontime = document.getElementById('txtTime').value;


                $.ajax({

                    type: "POST",
                    url: "../HCService.asmx/GetHomeCollectionTime",

                    // data:{userid:userid,collectiontime:collectiontime},
                    // data: "{'userid': '" + userid + "','collectiontime':'"+ collectiontime +"'}",

                    data: JSON.stringify({ "userid": userid, "collectiontime": collectiontime }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function(data) {
                        $.each(data.d, function(key, jsonvalue) {

                            if (jsonvalue.PatientID > 0) {

                                var colltime = confirm('Already ' + jsonvalue.PatientID + ' patient(s) booked for the same time slot. Are you sure you want to continue?.');
                                if (colltime) {
                                    document.getElementById('ddlPriority').focus();
                                    return false;
                                }
                                else {

                                    document.getElementById('txtTime').focus();
                                    return false;
                                }
                            }

                        });

                    }


                });
            }
            function ddlHCRoleValidate() {
                var Role = document.getElementById('ddlHCRole').value;

                if (Role = "------Select------") {
                    ValidationWindow('Please select a Role', 'Alert');
                    document.getElementById('ddlHCRole').focus();
                    $('[id$=linkEdit]').removeAttr('disabled');
                    $('[id$=linkEdit]').attr('disabled', false);
                    return false;
                }

                alert('1');
            }
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Do you want to save data?")) {
                    confirm_value.value = "Yes";
                    confirm_value.nodeName = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
            $(document).ready(function() {
                $("[id=rblSearchType]").click(function() {
                    var x = $("[id*=rblSearchType] input:checked").val();
                    $('#hdnSelectTypeID').val(x);
                });
                 loadquerystringObjects();
                 showlocation();
            });
        </script>

        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>
</body>
</html>

<%--<script src="../Scripts/HCCommonBilling.js" type="text/javascript"></script>--%>

<script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.table2excel.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

<%--<script src="../Scripts/jquery.loader.js" type="text/javascript"></script>

    <script src="../Scripts/ZeroClipboard.js" type="text/javascript"></script>
    <script src="../Scripts/TableTools.js" type="text/javascript"></script>--%>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>

<%--<script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>--%>
<%--<script src="../Scripts/Autocomplete.js" type="text/javascript"></script>--%>

<%--<script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>--%>

<%--<script src="../Scripts/HCJquery-ui.js" type="text/javascript"></script>--%>
<%--<script src="../scripts/common.js" type="text/javascript"></script>--%>

<script src="../Scripts/Export_Excel_Pdf_Copy/dataTables.buttons.min.js" type="text/javascript"></script>

    <script src="../Scripts/Export_Excel_Pdf_Copy/buttons.colVis.min.js" type="text/javascript"></script>
    
    
    <script src="../Scripts/Export_Excel_Pdf_Copy/jszip.min.js" type="text/javascript"></script>
    <script src="../Scripts/Export_Excel_Pdf_Copy/pdfmake.min.js" type="text/javascript"></script>
    <script src="../Scripts/Export_Excel_Pdf_Copy/vfs_fonts.js" type="text/javascript"></script>
    <script src="../Scripts/Export_Excel_Pdf_Copy/buttons.html5.min.js" type="text/javascript"></script>
    <link href="../Scripts/Export_Excel_Pdf_Copy/buttons.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Scripts/HCTable.js" type="text/javascript"></script>


<%--
<script src="../Scripts/table2CSV.js" type="text/javascript"></script>
--%>

<script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

<style type="text/css">
    .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        width: 1100px;
        height: 600px;
    }
     .modalPopup .header
    {
        background-color: #2FBDF1;
        height: 30px;
        color: White;
        line-height: 30px;       
        border-top-left-radius: 6px;
        border-top-right-radius: 6px;
    }
    .modalPopup .body
    {       
        height:500px;       
        overflow-y:scroll;       
    }
    .modalPopup .footer
    {
        padding: 6px;
    }
</style>
<style type="text/css">
    .contentdata
    {
        min-height: 380px !important;
    }
    .style1
    {
        height: 32px;
    }
    #tbmain textarea
    {
        width: 148px;
        height: 19px;
    }
    #td input, #tdbtnSearch input, #tdbtnUpdate input
    {
        margin: 0 10px;
    }
    #tdChkNewPatient input
    {
        margin: 0 3px 0 0;
    }
    .button
    {
        display: block;
        width: 16px;
        height: 16px;
        background: url('../Images/calendar.gif') top left;
        border: 0;
    }
    .Editbutton
    {
        display: inline;
        width: 16px;
        height: 16px;
        background: url('../Images/edit.png') top left;
        border: 0;
        font-size: 0;
        cursor: pointer;
        margin: 0 5px 0 0;
    }
    .button:hover
    {
        background-position: bottom;
        cursor: pointer;
    }
</style>

<script language="javascript" type="text/javascript">
    $(function() {
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                //$(".datePicker").datepicker("option", "maxDate", selectedDate);

                //var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });

    });
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

        CollectiontimeValidation();
        var CollectedDatetime = document.getElementById('txtTime').value;
        if (CollectedDatetime != '') {

            document.getElementById('billPart_hdnCollectedDateTime').value = CollectedDatetime;
            document.getElementById('billPart_hdnIsCollected').value = "H";
        }
    }

    function AlertMessage(value) {
        alert(value);
    }

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

    function ChangeUsers() {
        var UserID = document.getElementById('ddlUser').value;
        //alert(UserID);
        document.getElementById('hdnUserID').value = UserID;
    }

    function getrefhospid(source, eventArgs) {


        var sval = 0;

        var OrgID = document.getElementById('hdnOrgID').value;
        var rec = "0"; //document.getElementById('hdfReferalHospitalID').value;
        var sval = "RPH" + "^" + OrgID + "^" + rec;
        $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);

    }
    $(document).ready(function() {

        $("#btnpop").click(function(e) {
            var table_div;
            //getting values of current time for generating the file name
            var table_html;
            var dt = new Date();
            var day = dt.getDate();
            var month = dt.getMonth() + 1;
            var year = dt.getFullYear();
            var hour = dt.getHours();
            var mins = dt.getMinutes();
            var postfix = day + "." + month + "." + year + "_" + hour + "." + mins;
            //creating a temporary HTML link element (they support setting file names)
            var a = document.createElement('a');
            //getting data from our div that contains the HTML table
            if (($('#txtbox1').val() != '') && $('#txtbox1').val() != null) {

                table_div = document.getElementById('example');
                table_html = table_div.outerHTML.replace(/ /g, '%20');
            }
            else {
                table_div = document.getElementById('hdnWholeXls').value;
                table_html = "<Table>" + table_div + "</Table>"
                table_html = table_html.replace(/ /g, '%20');
            }
            var data_type = 'data:application/vnd.ms-excel';


            a.href = data_type + ', ' + table_html;
            //setting the file name
            a.download = 'Booking_Details' + postfix + '.xls';
            //triggering the function
            a.click();
            //just in case, prevent default behaviour
            e.preventDefault();
        });
    });
    function CheckEmail() {
        //var elements = document.getElementById('chkDespatchMode');
        if (document.getElementById('txtEmail').value != '') {
            document.getElementById('chkDespatchMode_0').checked = true;
            //elements.cells[0].childNodes[0].checked = true;
        }
        else {
            //elements.cells[0].childNodes[0].checked = false;
            document.getElementById('chkDespatchMode_0').checked = false;

        }

    }
    $(document).on('click', '#chkAdvanceSearch', function(e) {
//        $("#drpOrgAdv").append('<option value="-1">--Select All--</option>');
//        $("#drpOrgAdv").val(-1).change();
//        $("#drpLocAdv").append('<option value="-1">--Select All--</option>');
//        $("#drpLocAdv").val(-1).change();
//        $("#drpBooked").append('<option value="-1">--Select All--</option>');
//        $("#drpBooked").val(-1).change();
//        $("#drpCollection").append('<option value="-1">--Select All--</option>');
//        $("#drpCollection").val(-1).change();
        var $this = $(this);
        if (document.getElementById("chkAdvanceSearch").checked != true) {
            $('#AdvanceSearchDetails').slideUp();
//            $("#drpOrgAdv option[value='-1']").remove();
//            $("#drpLocAdv option[value='-1']").remove();
//            $("#drpBooked option[value='-1']").remove();
//            $("#drpCollection option[value='-1']").remove();
        } else {
            $('#AdvanceSearchDetails').slideDown();

        }
    });

    //////Date Year - week - Custom



    function ShowRegDate() {
        document.getElementById('txtFromDate').value = "";
        document.getElementById('txtToDate').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpCollection').value == "0") {

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
        if (document.getElementById('drpCollection').value == "1") {
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
        if (document.getElementById('drpCollection').value == "2") {
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
        if (document.getElementById('drpCollection').value == "3") {
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpCollection').value == "-1") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }
        if (document.getElementById('drpCollection').value == "4") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }

        if (document.getElementById('drpCollection').value == "5") {
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
        if (document.getElementById('drpCollection').value == "6") {
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
        if (document.getElementById('drpCollection').value == "7") {
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




    function ShowRegDateBook() {
        document.getElementById('txtFromDateBook').value = "";
        document.getElementById('txtToDateBook').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpBooked').value == "0") {

            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "1") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayMonth').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "2") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayYear').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';

        }
        if (document.getElementById('drpBooked').value == "3") {
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpBooked').value == "-1") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }
        if (document.getElementById('drpBooked').value == "4") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }

        if (document.getElementById('drpBooked').value == "5") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastWeekLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "6") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastMonthLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "7") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastYearLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
             document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
    }
    function getDateTimeNow() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hour = now.getHours();
        var minute = now.getMinutes();
        var second = now.getSeconds();
        var AMrPM = "";
        if (month.toString().length == 1) {
            var month = '0' + month;
        }
        if (day.toString().length == 1) {
            var day = '0' + day;
        }
        if (hour.toString().length == 1) {
            var hour = '0' + hour;
        }
        if (minute.toString().length == 1) {
            var minute = '0' + minute;
        }
        if (second.toString().length == 1) {
            var second = '0' + second;
        }
        if (hour >= 12) {
            AMrPM = 'PM';
        }
        else {
            AMrPM = 'AM';
        }
        var dateTime = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ' ' + AMrPM;
        return dateTime;
    }
</script>

