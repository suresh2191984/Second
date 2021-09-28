<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientBilling.aspx.cs" Inherits="Billing_ClientBilling" EnableEventValidation="false" 
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample" TagPrefix="CollectSample" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="DateTimePicker" %>
    <%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Client Billing</title>
<%--<script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>
<%--<script src="../QMS/Script/jquery-2.1.4.min.js" type="text/javascript"></script>--%>
<link href="../QMS/dist/css/jquery-ui.css" rel="stylesheet" type="text/css" runat="server" id="ac" />
    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>
    <script src="../Scripts/CollectSample.js" type="text/javascript"></script>

    <script src="../Scripts/ClientBilling.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

   
<%--
    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

 <style>

.ui-dialog .ui-dialog-titlebar-close {
    position: absolute;
    right: .9em;
    top: 50%;
    width: 40px;
    margin: -10px 0 0 0;
    padding: 1px;
    height: 20px;
   
}



.ui-button .ui-icon {
    background-image: url(images/ui-icons_777777_256x240.png);
}

.ui-button-icon-only .ui-icon {
    position: absolute;
    top: 10%;
    left: 10%;
    margin-top: -8px;
    margin-left: -8px;
width: 0px
}

</style>

    <script type="text/javascript" language="javascript">

        function AdditionalDetails() {


            var SampleDAte = document.getElementById('txtSampleDate').value;
            var SampleTime1 = document.getElementById('txtSampleTime11').value;
            var SampleTime2 = document.getElementById('txtSampleTime22').value;

            var SampleTimeTypeID;
            var SampleTimeType;

            var ddlAction = $('select[id$="ddlSampleTimeType1"] :selected');

            if (ddlAction != null) {

                SampleTimeTypeID = $(ddlAction).val();

                SampleTimeType = $(ddlAction).text();

            }
            var a;
            a = SampleDAte + " " + SampleTime1 + ":" + SampleTime2 + " " + SampleTimeType;

            //var CollectedDatetime = a;
            var CollectedDatetime = a;
            if (CollectedDatetime != '') {

                document.getElementById('billPart_hdnCollectedDateTime').value = CollectedDatetime;
                document.getElementById('billPart_hdnIsCollected').value = "Y";
            }
        }

        function Location() {
            var Loc = document.getElementById('txtLocClient').value;
            if (Loc != '') {
                document.getElementById('billPart_hdnLocName').value = Loc;
            }
        }
        $(document).ready(function() {
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
            $(window).keydown(function(event) {

                if (event.altKey && (event.which == 71)) {

                    if ($('#btnFinish:visible').length > 0) {
                        $('#btnFinish').trigger("click");
                    }

                }
				if (event.altKey && (event.which == 66))
                  {
                    if ($('#btnGenerate:visible').length > 0) {
                        $('#btnGenerate').trigger("click");
                    }

                }
                if (event.altKey && (event.which == 78))
                  {
                    if ($('#ddSalutation:visible').length > 0) {
                        $('#ddSalutation').focus();
                    }

                }
            });
//            if (document.getElementById('hdnlabnumber').value == "Y") {

//                document.getElementById('tdlabnumber').style.display = 'table-cell';
//                document.getElementById('tdtxtlabnumber').style.display = 'table-cell';
//                document.getElementById('tdlblvisitnno').style.display = 'none';
//                document.getElementById('tdtxtvisitno').style.display = 'none';

//            }
//            else {
//                document.getElementById('tdlabnumber').style.display = 'none';
//                document.getElementById('tdtxtlabnumber').style.display = 'none';
//                document.getElementById('tdlblvisitnno').style.display = 'table-cell';
//                document.getElementById('tdtxtvisitno').style.display = 'table-cell';
//            }

            dialogfunc();
            ClearClientAttr();

        });

        function CheckEmail() {
            var elements = document.getElementById('chkDespatchMode');
            if (document.getElementById('txtEmail').value != '') {
                document.getElementById('chkDespatchMode_0').checked = true; 
                //elements.cells[0].childNodes[0].checked = true;
            }
            else {
                document.getElementById('chkDespatchMode_0').checked = false; 
                
                //elements.cells[0].childNodes[0].checked = false;

            }
        }
    </script>

    <style type="text/css">
        .style3
        {
            width: 5%;
        }
        .Txtboxsmall11
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 205px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
        }
        .smsbox
        {
            padding: 0px !important;
        }
        .AutoCompletesearchBox { padding-left:20px!important; width:132px!important;}
        .ddlsmall {width:156px!important;}
    </style>
</head>
<body onload="Location();">
    <form id="form1" oncontextmenu="return false;" runat="server" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
           <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
        <table class="w-100p">
                            <tr class="v-top">
                                <td>
                                    <div class="dataheader3">
                                        <%--<img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                            style="cursor: pointer;" />--%>
                                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details"
                                            meta:resourcekey="PnlPatientDetailResource1">
                                            <table class="w-99p">
                                                <tr>
                                                    <td>
                                                        <table class="w-100p" cellspacing="1" cellpadding="1">
                                                            <tr>
                                                                <td class="w-7p" runat="server" id="tdSearchType1">
                                                                    <asp:Label ID="lblSearchType" runat="server" Text="Search Type" meta:resourcekey="lblSearchTypeResource1"></asp:Label>
                                                                </td>
                                                                <td runat="server" id="tdSearchType2">
                                                                    <asp:RadioButtonList onclick="javascript:clearPageControlsValue('N');" RepeatDirection="Horizontal"
                                                                        ID="rblSearchType" runat="server" RepeatColumns="5" meta:resourcekey="rblSearchTypeResource1">
                                                                       <%-- <asp:ListItem Text="None" Value="4" Selected="True" 
                                                                        <asp:ListItem Text="Name" Value="0"></asp:ListItem>--%>
                                                                        <%--<asp:ListItem Text="Number" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Mobile/Phone" Value="2"></asp:ListItem>
                                                                        <asp:ListItem Text="Booking Number" Value="3"></asp:ListItem>--%>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                                <td class="a-center">
                                                                    <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                                                        id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                                                </td>
                                                                <td class="a-right" id="tdVisitType1" runat="server" style="display: none;">
                                                                    <asp:Label ID="Rs_SelectVisit" runat="server" Text="Visit Type:" meta:resourcekey="Rs_SelectVisitResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left" id="tdVisitType2" runat="server" style="display: none;">
                                                                    <asp:DropDownList TabIndex="-1" Width="95px" CssClass="bilddltb" onfocus="javascript:CheckPatientName();"
                                                                        ID="ddlVisitDetails" runat="server" onchange="ChangeVisit()" meta:resourcekey="ddlVisitDetailsResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                <td id="tdlblvisitnno" runat="server">
                                                    <asp:Label ID="lblVisitNUmber" runat="server" Text="Do From Visit Number" ForeColor="Blue"
                                                        meta:resourcekey="lblVisitNUmberResource1"></asp:Label>
                                                </td>
                                                <td id="tdtxtvisitno" runat="server">
                                                    <asp:TextBox ID="txtDoFrmVisitNumber" nowrap="nowrap" runat="server" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                                 <ajc:AutoCompleteExtender ID="AutoCompleteExtenderVisitNo" runat="server" TargetControlID="txtDoFrmVisitNumber"
                                                        ServiceMethod="GetLabQuickBillPatientListForClientBilling" ServicePath="~/OPIPBilling.asmx"
                                                        EnableCaching="False" CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedClientPatient" Enabled="True"
                                                        OnClientPopulated="onClientListPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td id="tdlabnumber" runat="server" >
                                                    <asp:Label ID="lbllabnumber" runat="server" Text="Lab Number" meta:resourcekey="lbllabnumberResource1"></asp:Label>
                                                </td>
                                                <td id="tdtxtlabnumber" runat="server" >
                                                    <asp:TextBox ID="txtlabnumber" onblur="AlertforExistingLabNumber();" MaxLength="9" nowrap="nowrap" runat="server" CssClass="Small"></asp:TextBox>
                                                <%-- <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLabNumber" runat="server" TargetControlID="txtlabnumber"
                                                        ServiceMethod="GetLabQuickBillPatientListForClientBilling" ServicePath="~/OPIPBilling.asmx"
                                                        EnableCaching="False" CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedClientPatient" Enabled="True"
                                                        OnClientPopulated="onClientListPopulated">
                                                    </ajc:AutoCompleteExtender>--%>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td colspan="2">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:CheckBox ID="chkIncomplete" TextAlign="Left" Style="display: block" onClick="Validategender();"
                                                                    runat="server" Text="Incomplete Registration" meta:resourcekey="chkIncompleteResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblUnknownFlag" runat="server" Text="Not Provided" meta:resourceKey="lblUnknownFlagResource2"></asp:Label>
                                                                <asp:DropDownList CssClass="ddl" ID="ddlUnknownFlag" runat="server" Enabled="false"
                                                                    meta:resourceKey="ddlUnknownFlagResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="w-30p">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-3p">
                                                                <asp:Label ID="lblName" runat="server" Text="Name" meta:resourceKey="lblNameResource2"></asp:Label>
                                                            </td>
                                                            <td class="w-16p">
                                                                <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server" meta:resourceKey="ddSalutationResource1">
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtName" MaxLength="254" 
                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" CssClass="small" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                    onfocus="javascript:setPatientSearch();" autocomplete="off" runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                    ServiceMethod="GetQuickPatientSearch" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                    OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True"
                                                                    OnClientPopulated="onListPopulated">
                                                                </ajc:AutoCompleteExtender>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-5p">
                                                    <asp:Label ID="lblAge" runat="server" Text="A<u>g</u>e :" AssociatedControlID="txtDOBNos"
                                                        AccessKey="G" meta:resourceKey="lblAgeResource2"></asp:Label>
                                                </td>
                                                <td class="w-20p v-middle padding0">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();"
                                                                         onkeypress="return ValidateOnlyNumericAndDot(this);"    CssClass="Txtboxsmall"
                                                                    onchange="setDOBYear(this.id,'CB');" runat="server" MaxLength="6" Width="17%"
                                                                    Style="text-align: justify" Height="14px" meta:resourceKey="txtDOBNosResource2" />
                                                                <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id,true);" ID="ddlDOBDWMY"
                                                                    Width="50%" runat="server" CssClass="ddl" meta:resourceKey="ddlDOBDWMYResource1"
                                                                    Height="18px">
                                                                </asp:DropDownList>
                                                                <img id="imgAge" src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td class="a-right">
                                                                <table width="w-100p">
                                                                    <tr>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-10p">
                                                    <table>
                                                        <tr>
                                                            <td nowrap="nowrap">
                                                                <asp:Label ID="lblDOB" runat="server" Text="DOB" meta:resourcekey="lblDOBResource1"></asp:Label>
                                                            </td>
                                                            <td nowrap="nowrap">
                                                                <asp:TextBox CssClass="small datePicker" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                                    onkeypress="return RestrictInput(event)" onchange="javascript:CalculateAge(this);"
                                                                    onblur="javascript:CalculateAge(this);" Width="87px" Style="text-align: justify"
                                                                    ValidationGroup="MKE" onkeydown="javascript:preventInput(event);" meta:resourcekey="tDOBResource1" placeholder="dd/mm/yyyy" />
                                                               <%-- <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                    PopupButtonID="ImgBntCalc" Enabled="True" />--%>
                                                                <img id="imgDOB" src="../Images/starbutton.png" alt="" align="middle" />
                                                                <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital"
                                                                    runat="server" Width="30%" meta:resourceKey="ddMaritalResource2">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-20p">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblSex" runat="server" Text="Gender" AssociatedControlID="ddlSex"
                                                                    AccessKey="X" meta:resourceKey="lblSexResource2"></asp:Label>
                                                            </td>
                                                            <td nowrap="nowrap">
                                                                <asp:DropDownList ID="ddlSex" Width="60%" runat="server" CssClass="ddl"
                                                                    meta:resourceKey="ddlSexResource2">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" id="imgddlSex" alt="" align="middle" />
                                                                <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-5p">
                                                    <asp:Label ID="lblzone" runat="server" Text="Zone" meta:resourcekey="lblzoneResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p" nowrap="nowrap">
                                                    <asp:TextBox ID="txtzone" runat="server" MaxLength="50" onBlur="CheckValidationForAutocomplete('Zone',this.id);"
                                                        onfocus="javascript:ClearZoneDetails();" AutoComplete="off" Width="85%" CssClass="AutoCompletesearchBox" meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchZoneForBilling"
                                                        OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap" class="w-13p">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourceKey="Rs_ClientNameResource2"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:TextBox ID="txtClient" runat="server" CssClass="AutoCompletesearchBox"
                                                        onfocus="CheckOrderedItems(),AdditionalDetails();" onBlur="CheckValidationForAutocomplete('Client',this.id);" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemOver="SelectedTempClient"
                                                        OnClientItemSelected="ClientSelected" ServiceMethod="FetchClientNameForBilling"
                                                        ServicePath="~/WebService.asmx" TargetControlID="txtClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRefby" Text="Ref Dr." runat="server" AssociatedControlID="txtInternalExternalPhysician"
                                                        AccessKey="D" meta:resourceKey="lblRefbyResource2"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                        Height="16px" meta:resourceKey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                        MinimumPrefixLength="1" OnClientItemOver="PhysicianTempSelected" OnClientItemSelected="PhysicianSelected"
                                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtInternalExternalPhysician"
                                                        DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdnReferralType" runat="server" Value="0" />
                                                </td>
                                                <td colspan="1">
                                                    <asp:Label ID="lblSampleDate" runat="server" AccessKey="K" AssociatedControlID="txtSampleDate"
                                                        meta:resourceKey="lblSampleDateResource2" Text="Sample Pic&lt;u&gt;k&lt;/u&gt;up Date"></asp:Label>
                                                </td>
                                                <td colspan="1" class="w-1p v-middle" nowrap="nowrap">
                                                    <table cellspacing="2" class="w-90p">
                                                        <tr>
                                                            <td class="w-100p v-middle">
                                                                <asp:TextBox ID="txtSampleDate" TabIndex="-1" runat="server" onblur="AdditionalDetails();"
                                                                    CssClass="small datePicker" Height="16px" meta:resourceKey="txtSampleDateResource2"
                                                                    Width="35%" ToolTip="dd/mm/yyyy" placeholder="dd/mm/yyyy"></asp:TextBox>
                                                                    
                                                               
                                                               <%-- <ajc:MaskedEditExtender ID="MaskedEditExtender14" runat="server" TargetControlID="txtSampleDate"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender12" Format="dd/MM/yyyy" runat="server"
                                                                    TargetControlID="txtSampleDate" PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                --%><asp:TextBox ID="txtSampleTime11" TabIndex="-1" runat="server" CssClass="Txtboxsmall"
                                                                    Height="16px" Width="10%" ToolTip="hr"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                    MaxLength="2" onblur="ValidateTime(this);AdditionalDetails();" meta:resourcekey="txtSampleTime11Resource1"></asp:TextBox>
                                                                <asp:TextBox ID="txtSampleTime22" TabIndex="-1" runat="server" CssClass="Txtboxsmall"
                                                                    Height="16px" MaxLength="2" Width="10%" ToolTip="mn"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                    onblur="ValidateTime(this);AdditionalDetails();" meta:resourcekey="txtSampleTime22Resource1"></asp:TextBox>
                                                                <%--               
                                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtSampleTime"
                                                                                    Mask="99:99" MaskType="Time" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                    CultureTimePlaceholder="" Enabled="True" />--%>
                                                                                <asp:DropDownList CssClass="ddl" TabIndex="-1" Width="25%" onchange="AdditionalDetails();"
                                                                                    ID="ddlSampleTimeType1" runat="server" Height="18px">
                                                                                     <%--<asp:ListItem Text="AM" Value="AM" Selected="True"></asp:ListItem>
                                                                                    <asp:ListItem Text="PM" Value="PM"></asp:ListItem>--%>
                                                                                </asp:DropDownList>
                                                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                <%--<a href="javascript:NewCssCal('txtSampleDate','ddmmyyyy','arrow',true,12);">--%>
                                                                                <%-- <img id="imgCalc" alt="Pick a date" src="../images/Calendar_scheduleHS.png" /></a>--%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="lblLogistics" runat="server" AccessKey="L" AssociatedControlID="txtLogistics" Text="Logistics Name" meta:resourcekey="lblLogisticsResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="1">
                                                                    <asp:TextBox ID="txtLogistics" TabIndex="-1" runat="server" CssClass="AutoCompletesearchBox" onFocus="javascript:ClearlogisticsID()"
                                                                        onBlur="CheckValidationForAutocomplete('Logi',this.id);" Width="85%" meta:resourcekey="txtLogisticsResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLogi" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                                        MinimumPrefixLength="1" OnClientItemSelected="SelectedLogistics" ServiceMethod="FetchLogidticsNameForBilling"
                                                                        ServicePath="~/WebService.asmx" TargetControlID="txtLogistics" DelimiterCharacters=""
                                                                        Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <asp:DropDownList ID="ddlDespatchMode" TabIndex="-1" runat="server" CssClass="ddl"
                                                                        meta:resourceKey="ddlDespatchModeResource1" Style="display: none;" Width="86%">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="lblPhlebo" runat="server" Text="Phlebo Name" meta:resourcekey="lblPhleboResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:TextBox ID="txtPhleboName" runat="server" TabIndex="-1" CssClass="AutoCompletesearchBox small" onkeydown="javascript:return javPhlebotomistDetails();" meta:resourcekey="txtPhleboNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPhlebo" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="Selectedphlebotomist"
                                                                        ServiceMethod="FetchphlebotomistName" ServicePath="~/WebService.asmx" TargetControlID="txtPhleboName">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblPatient" runat="server" Text="Vis<u>i</u>t Type" AssociatedControlID="ddlIsExternalPatient"
                                                                        AccessKey="I" meta:resourceKey="lblPatientResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList TabIndex="-1" CssClass="ddlsmall" onchange="javascript:SelectVisitType();"
                                                                        ID="ddlIsExternalPatient" runat="server" Height="18px" >
                                                                        <%--<asp:ListItem Text="OP" Value="0" Selected="True" meta:resourceKey="ListItemResource4"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1" meta:resourceKey="ListItemResource5"></asp:ListItem>--%>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="v-middle" nowrap="nowrap">
                                                                    <asp:Label ID="Label1" runat="server" Text="Ex Patient Number" meta:resourceKey="Label1Resource1"></asp:Label>
                                                                </td>
                                                                <td id="tdlblWardNo" style="display: table-cell;" class="v-middle">
                                                    <asp:TextBox ID="txtExternalPatientNumber" TabIndex="-1" autocomplete="off" Width="82%"
                                                                        CssClass="Txtboxsmall" runat="server" MaxLength="15" meta:resourcekey="txtExternalPatientNumberResource1"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblReferingHospital" Text="Ref <u>H</u>os" runat="server" AssociatedControlID="txtReferringHospital"
                                                                        AccessKey="H" meta:resourceKey="lblReferingHospitalResource2"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtReferringHospital" TabIndex="-1" runat="server" CssClass="AutoCompletesearchBox"
                                                                        Width="85%" meta:resourceKey="txtReferringHospitalResource2"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                                        TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                                        CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingHospID"
                                                                        DelimiterCharacters="" Enabled="True" OnClientItemOver="GetTempReferingHospID">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="lblMobile" runat="server" AccessKey="M" AssociatedControlID="txtMobileNumber"
                                                                        meta:resourceKey="lblMobileResource1" Text="&lt;u&gt;M&lt;/u&gt;obile"></asp:Label>
                                                                </td>
                                                                <td colspan="1">
                                                                    <asp:CheckBox ID="chkMobileNotify" CssClass="smsbox" TabIndex="-1" runat="server" meta:resourceKey="chkMobileNotifyResource1"
                                                                        Text="SMS" ToolTip="Send SMS Notification" />
                                                                    <%--<asp:Label ID="lblCountryCode" runat="server" meta:resourceKey="lblCountryCodeResource2"></asp:Label>--%>
                                                                    <asp:TextBox ID="txtMobileNumber" TabIndex="-1" runat="server" autocomplete="off"
                                                                        CssClass="Txtboxsmall" MaxLength="13" meta:resourceKey="txtMobileNumberResource1"
                                                                        nowrap="nowrap"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        Width="41%"></asp:TextBox>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblLocation" runat="server" Text="Proxy Registration By" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLocClient" runat="server" TabIndex="-1" autocomplete="off" CssClass="AutoCompletesearchBox" meta:resourcekey="txtLocClientResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender44" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="OnCollectioncenterselectedClient"
                                                                        ServiceMethod="GetCollectionCenterClientNames" ServicePath="~/WebService.asmx"
                                                                        TargetControlID="txtLocClient">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td colspan="2" nowrap="nowrap">
                                                                    <asp:CheckBox ID="chkExcludeAutoathz" TabIndex="-1" runat="server" Text="Exclude Auto Authorization" meta:resourcekey="chkExcludeAutoathzResource1" />
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="lblDespatchmode" runat="server" meta:resourceKey="lblDespatchmodeResource1"
                                                                        Text="Dispatch Mode"></asp:Label>
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:CheckBoxList ID="chkDespatchMode" TabIndex="-1" runat="server" RepeatDirection="Horizontal" meta:resourcekey="chkDespatchModeResource1">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                            <td>
                                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" meta:resourcekey="Rs_URNTypeResource1" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUrnType" runat="server" onblur="CheckExistingURN1();" onChange="javascript:return CheckMRD();"
                                                        CssClass="ddlsmall" meta:resourcekey="ddlUrnTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of" meta:resourcekey="Rs_URNOfResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUrnoOf" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlUrnoOfResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_URN" Text="URN No" runat="server" meta:resourcekey="Rs_URNResource1" />
                                                </td>
                                                <td>
                                                    <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                    <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                        onKeyDown="javascript:ClearDiscountLimitValues();" MaxLength="50" onblur="CheckExistingURN1();ConverttoUpperCase(this.id);"></asp:TextBox>
                                                </td>
                                                            </tr>
                                                            <tr>
                                                                
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblEmail" runat="server" AccessKey="E" AssociatedControlID="txtEmail"
                                                                        Text="&lt;u&gt;E&lt;/u&gt;-mail" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                                </td>
                                                <td nowrap="nowrap" class="padding0">
                                                    <table border="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtEmail" TabIndex="-1" MaxLength="100" runat="server" autocomplete="off"
                                                                    onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');" onchange="CheckEmail();"
                                                                    CssClass="small" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <%--<td colspan="1">
                                                </td>--%>
                                             
                                                <td id="tdlblsrfid" runat="server" style="display:none;">
                                                  <asp:Label ID="lblsrfid" runat="server" Text="SRF ID" ></asp:Label>
                                                  <asp:HiddenField ID="hdnissrfid" runat="server" Value="N" />
                                                </td>
                                                <td id="tdtxtsrfid" runat="server" style="display:none;">
                                                <asp:TextBox ID="txtsrfid" runat="server" CssClass="small"></asp:TextBox>
                                                </td>
                                                <td colspan="1" nowrap="nowrap">
                                                    <asp:Label ID="lblRoundNo" runat="server" Text="Round No" meta:resourcekey="lblRoundNoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRoundNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtRoundNoResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" id="imgnoroundno" runat="server" alt="" align="middle" />
                                                </td>
                                                <td id="tdlblpassportno" runat="server" style="display:none;">
                                                  <asp:Label ID="lblpassportno" runat="server" Text="Passport No" ></asp:Label> 
                                                </td>
                                                <td id="tdtxtpassportno" runat="server" style="display:none;">
                                                <asp:TextBox ID="txtpassportno" runat="server" CssClass="small"></asp:TextBox>
                                                </td>
                                                 <td id="tdreplang" runat="server">
                                                    <asp:Label ID="lblreplang" runat="server" Text="Report Language" meta:resourcekey="lblreplangResource1"></asp:Label>
                                                </td>
                                                <td id="tdddreplang" runat="server" style="width: 300px;">
                                                    <asp:DropDownList CssClass="ddlsmall" ID="ddlreplang" runat="server">
                                                    </asp:DropDownList>
                                                     <img src="../Images/Add.png" alt="Show" id="btnAddlang" onclick="return AddReportLanguage();" />
                                                </td>
                                                
                                                <td id="trApprovalNo" runat="server" colspan="3" nowrap="nowrap">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td class="w-40p a-left">
                                                                <asp:Label ID="lblApprovalNo" runat="server" Text="Approval No" meta:resourcekey="lblApprovalNoResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtApprovalNo" runat="server" AutoCompleteType="Disabled" MaxLength="13"
                                                                    CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Width="80%" meta:resourcekey="txtApprovalNoResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td colspan="1" nowrap="nowrap">
                                                    <input id="ChkTRFImage" runat="server" tabindex="-1" onclick="ShowTRFUpload(this, this.id);"
                                                        type="checkbox" value="Upload" />
                                                    <asp:Label ID="lblTRF" runat="server" AccessKey="U" AssociatedControlID="ChkTRFImage"
                                                        Style="color: #2C88B1; font-size: small;" Text="TRF Image &lt;u&gt;U&lt;/u&gt;pload"
                                                        meta:resourceKey="lblTRFResource2"></asp:Label>
                                                </td>
                                                <td colspan="1">
                                                    <div id="TRFimage" style="display:block;width: 60px !important;">
                                                        <asp:FileUpload ID="FileUpload1" TabIndex="-1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                                            class="multi" meta:resourceKey="FileUpload1Resource1" />
                                                    </div>
                                                </td></tr>
                                            <tr>
                                            <td colspan="7"></td>
                                                <td colspan="2">
                                                <table class="w-100p">
                                                  <tr class="tablerow">
                                                        <td colspan="5">
                                                            <div id="divreplang" runat="server" class="h-100p" style="display: none; overflow: auto;
                                                                overflow-x: hidden;">
                                                                <table class="w-100p gridView" id="tblreportlang" runat="server" style="background-color: White;
                                                                    border: 1,1,1,1;">
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                                <td colspan="1" nowrap="nowrap" width="8%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap" width="8%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="2" width="7%" nowrap="nowrap">
                                                                </td>
                                                                <td colspan="2" width="5%">
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="2">
                                                                    &nbsp;
                                                                </td> 
                                                            </tr>
                                                            <tr>
                                                                <td colspan="1" nowrap="nowrap" width="8%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="1" width="8%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="1" width="7%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="1" width="5%">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="2">
                                                                    &nbsp;
                                                                </td>
                                                                <td colspan="2">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>--%>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td style="display: none;">
                                    <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality" meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                                    &nbsp;
                                    <asp:DropDownList CssClass="ddl" TabIndex="-1" ID="ddlNationality" runat="server"
                                        meta:resourcekey="ddlNationalityResource1">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddCountry" TabIndex="-1" Width="87%" onchange="javascript:loadState();"
                                        runat="server" CssClass="ddl" meta:resourceKey="ddCountryResource1">
                                    </asp:DropDownList>
                                    <select id="ddState" runat="server" class="ddl" onchange="javascript:onchangeState();">
                                    </select>
                                    <asp:Label ID="lblCountryCode1" runat="server" meta:resourcekey="lblCountryCode1Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="ShowBillingItems" style="display: none; position: absolute; width: 35%;
                                        left: 61%; top: 1%">
                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                        </div>
                                        <table class="modalPopup dataheaderPopup w-32p">
                                            <tr>
                                                <td id="Itemdragbar" style="cursor: move; cursor: pointer" class="w-100p">
                                                    <asp:Label ID="lblPreviousItems" runat="server" meta:resourcekey="lblPreviousItemsResource1"  />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="div1" style="display: none; position: absolute; width: 35%; left: 61%; top: 1%">
                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                        </div>
                                        <table class="modalPopup dataheaderPopup w-32p">
                                            <tr>
                                                <td id="Td4" style="cursor: move; cursor: pointer" class="w-100p">
                                                    <asp:Label ID="Label2" runat="server"  meta:resourcekey="Label2Resource1"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td>
                                    <table>
                                        <tr id="trRate" runat="server" style="display: none;">
                                            <td>
                                                <asp:Label ID="lblRate" runat="server" Text="Rate" meta:resourcekey="Label2Resource1"></asp:Label>
                                                &nbsp;
                                                <asp:DropDownList TabIndex="-1" ID="ddlRate" runat="server" CssClass="ddlsmall" Enabled="False"
                                                    onChange="javascript:setRate(this.value);">
                                                   <%-- <asp:ListItem Selected="True" meta:resourceKey="ListItemResource3">--Select--</asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                            <td id="divShowClientDetails" style="display: none; position: absolute; width: 35%;
                                                left: 62%; top: 1%">
                                                <div onclick="Itemhidebox();return false" class="divCloseRight">
                                                </div>
                                                <table cellspacing="1" class="modalPopup dataheaderPopup w-32p"
                                                    cellpadding="1">
                                                    <tr>
                                                        <td id="Td5" style="cursor: move; cursor: pointer" class="w-100p">
                                                            <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource2" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trOrderCalcPart" runat="server" style="display: table-row;">
                                <td class="dataheader3">
                                    <div style="display: none;" class="v-top">
                                        <div id="divBill1" onclick="showResponses('divBill1','divBill2','divBill3',1);" style="cursor: pointer;
                                            display: none;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                        </div>
                                        <div id="divBill2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divBill1','divBill2','divBill3',0);"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="Show" />
                                        </div>
                                    </div>
                                    <div>
                                        <BillingPart:BPart ID="billPart" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="dataheader3 a-center">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-right w-53p">
                                                <asp:Button ID="btnGenerate" runat="server" Width="100px" Text="Generate Bill" CssClass="btn"
                                                    onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return validateEvents('After');"
                                                    OnClick="btnGenerate_Click" onmouseout="this.className='btn'" meta:resourcekey="btnGenerateResource1" />
                                            </td>
                                            <td class="a-left">
                                                <%--<input type="button" runat="server" id="btnClose" value="Clear" class="btn" onclick="javascript:clearClientbuttonClick();" />--%>
<%--                                                <button id="btnClose" runat="server" class="btn" onclick="javascript:clearClientbuttonClick();"><%=Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_01%></button>--%>
                                                                 <asp:Button ID="btnClose" runat="server" Text="Clear" CssClass="btn"
                                    OnClientClick="javascript:return  clearbuttonClick();" meta:resourcekey="btnCloseResource1" />  
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table id="tblDatepicker" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <table class="dataheader2">
                                        <tr>
                                            <td colspan="1">
                                                <asp:Label ID="lblSampleDateTime" runat="server" Text="Sample Collected Date Time"
                                                    Font-Bold="True" meta:resourcekey="lblSampleDateTimeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <DateTimePicker:DateTimePicker ID="DateTimePicker1" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p" id="trCollectSample" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <CollectSample:CollectSample ID="ctlCollectSample" runat="server" />
                                    <asp:Panel CssClass="dataheaderInvCtrl" runat="server" ID="pnlDept" meta:resourcekey="pnlDeptResource1">
                                        <table id="deptTab" runat="server" width="100%" border="0" cellpadding="4" cellspacing="0">
                                            <tr id="Tr1" style="height: 20px;" class="Duecolor" runat="server">
                                                <td id="Td3" runat="server">
                                                    <asp:Label ID="lblSelecttheDepartmentforwhichtheSampleshastobesent" runat="server"
                                                        Text="Select the Department for which the Samples has to be sent" meta:resourcekey="lblSelecttheDepartmentforwhichtheSampleshastobesentResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td id="Td58" class="w-100p a-left v-top" runat="server">
                                                    <asp:DataList CssClass="w-100p" ID="repDepts" runat="server" RepeatColumns="5">
                                                        <ItemTemplate>
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="h-20">
                                                                        <asp:CheckBox ID="chkDept" runat="server" />
                                                                        <asp:Label ID="lblDeptName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptName")%>'> </asp:Label>
                                                                    </td>
                                                                    <td class="h-20">
                                                                        <asp:Label ID="lblDeptID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptID")%>'
                                                                            Visible="False"> </asp:Label>
                                                                        <asp:Label ID="lblRoleID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RoleID")%>'
                                                                            Visible="False"> </asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnFinish" TabIndex="1" runat="server" ToolTip="Click here to Generate Work Order"
                                        Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Generate Work Order" meta:resourcekey="btnFinishResource1" />
                                    &nbsp;
                                    <asp:Button ID="Button1" TabIndex="2" runat="server" Width="70px" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Cancel" OnClick="btnHome_Click" meta:resourcekey="Button1Resource1" />
                                </td>
                            </tr>
                        </table>
                        <div id="iframeplaceholder">
                            <iframe runat="server" id='iframeBarcode' name='iframeBarcode' style='position: absolute;
                                top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overfow: none; z-index: -1'>
                            </iframe>
                        </div>
                    </div>
           <Attune:Attunefooter ID="Attunefooter" runat="server" />     
        <asp:HiddenField ID="hdnsampleforcurrent" runat="server" />
		 <%--//change by arun -- if client not having any Baserate Ratecard then the alert should be changed RLS--%>
        <asp:HiddenField ID="hdnAlrtBaseRateNotMappng" runat="server" />
        <asp:HiddenField ID="hdnConfigTRFMandatory" runat="server" Value="N" />
        <asp:HiddenField ID="hdnSampleforPrevious" runat="server" />
        <asp:HiddenField ID="hdnTodayVisitID" runat="server" />
        <asp:HiddenField ID="hdnClientUID" runat="server" />
        <asp:HiddenField ID="hdnTempTodayVisitID" runat="server" />
        <asp:HiddenField ID="hdnDOFromVisitFlag" runat="server" Value="0" />
        <asp:HiddenField ID="hdnDoFrmVisit" runat="server" Value="0" />
        <asp:HiddenField ID="hdnDifferSanpleforDFV" runat="server" /> 
        <asp:HiddenField ID="hdnBabysalutationeditgender" runat="server" />
        <input id="hdnValidation" type="hidden" runat="server" />
        <asp:HiddenField ID="hdnNewOrgID" runat="server" />
        <input id="hdnAgeUnitinDec" runat="server" type="hidden" value="Y" />
        <input id="hdnMinimumDue" type="hidden" value="" runat="server" />
        <input id="hdnMinimumDuePercent" type="hidden" value="" runat="server" />
        <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
        <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
        <input id="hdnMobileNumber" type="hidden" value="0" runat="server" />
        <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
        <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
        <input id="hdnOutSourceInvestigations" type="hidden" runat="server" />
        <input id="hdnOPIP" type="hidden" runat="server" value="OP" />
        <input id="hdnVisitPurposeID" type="hidden" value="-1" runat="server" />
        <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
        <input id="hdnReferedPhyName" type="hidden" value="" runat="server" />
        <input id="hdnReferedPhysicianCode" type="hidden" value="0" runat="server" />
        <input id="hdnReferedPhysicianRateID" type="hidden" value="-1" runat="server" />
        <input id="hdnReferingPhysicianClientID" type="hidden" value="0" runat="server" />
        <input id="hdnReferingPhysicianMappingID" type="hidden" value="0" runat="server" />
        <input id="hdnReferedPhyType" type="hidden" value="" runat="server" />
        <input id="hdnRefPhySpecialityID" type="hidden" value="-1" runat="server" />
        <input id="hdnCollectionCenterID" type="hidden" value="-1" runat="server" />
        <input id="hdnCollectionCenterName" type="hidden" value="" runat="server" />
        <input id="hdnCollectionCenterCode" type="hidden" value="-1" runat="server" />
        <input id="hdnCollectionCenterRateID" type="hidden" value="-1" runat="server" />
        <input id="hdnCollectionCenterClientID" type="hidden" value="0" runat="server" />
        <input id="hdnCollectionCenterMappingID" type="hidden" value="0" runat="server" />
        <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientName" type="hidden" value="" runat="server" />
        <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientRateID" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
        <input id="hdnSelectedClientMappingID" type="hidden" value="0" runat="server" />
        <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
        <input id="hdnReferingHospitalName" type="hidden" value="0" runat="server" />
        <input id="hdnClientID" type="hidden" value="-1" runat="server" />
        <input id="hdnTPAID" type="hidden" value="-1" runat="server" />
        <input id="hdnClientType" type="hidden" value="CRP" runat="server" />
        <input id="hdnPageUrl" type="hidden" runat="server" />
        <input id="hdnBaseRateID" type="hidden" value="0" runat="server" />
        <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
        <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
        <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
        <input id="hdnOrgID" type="hidden" value="0" runat="server" />
        <input id="hdnPatientAlreadyExists" type="hidden" value="0" runat="server" />
        <input id="hdnDefaultCountryID" type="hidden" value="0" runat="server" />
        <input id="hdnDefaultStateID" type="hidden" value="0" runat="server" />
        <input id="hdnPatientAlreadyExistsWebCall" type="hidden" value="0" runat="server" />
        <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
        <input id="hdnIsReceptionPhlebotomist" value="N" runat="server" type="hidden" />
        <input id="hdnBillGenerate" value="N" runat="server" type="hidden" />
        <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
        <asp:HiddenField ID="hdnLstSampleTracker" runat="server" />
        <asp:HiddenField ID="hdnLstPatientInvSampleMapping" runat="server" />
        <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" />
        <input id="hdnDefaultCountryStdCode" type="hidden" value="0" runat="server" />
        <asp:HiddenField ID="hdnLstCollectedSampleStatus" runat="server" />
        <input type="hidden" id="hdnVisitID" runat="server" />
        <input type="hidden" id="hdnGuID" runat="server" />
        <input type="hidden" id="hdnFinalBillID" value="-1" runat="server" />
        <input type="hidden" id="hdnClientBalanceAmount" value="-1" runat="server" />
        <input type="hidden" id="hdnCashClient" runat="server" />
        <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
        <input type="hidden" runat="server" id="hdnRoundOffType" />
        <input type="hidden" runat="server" id="hdnTpaRoundoff" />
        <input type="hidden" runat="server" id="hdnTpaRoundOffType" />
        <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
        <input type="hidden" runat="server" value="LABB" id="hdnBillingPageName" />
        <input id="hdnMappingClientID" type="hidden" value="-1" runat="server" />
        <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
        <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
        <input id="hdnRateID" runat="server" type="hidden" value="0" />
        <input id="Hidden1" type="hidden" value="0" runat="server" />
        <input id="hdnGender" type="hidden" value="" runat="server" />
        <input id="hdnClienID" type="hidden" value="0" runat="server" />
        <input id="HdnPhleboName" type="hidden" value="" runat="server" />
        <input id="HdnPhleboID" type="hidden" value="" runat="server" />
        <input id="hdnLogisticsName" type="hidden" value="" runat="server" />
        <input id="hdnLogisticsID" type="hidden" value="" runat="server" />
        <input id="hdnCpedit" type="hidden" value="N" runat="server" />
        <input id="hdnPatientName" type="hidden" value="" runat="server" />
        <%--<uc5:Footer ID="Footer1" runat="server" />--%>
        <input id="hdnPatientAge" type="hidden" value="0" runat="server" />
        <input id="hdnPatientDOB" type="hidden" value="0" runat="server" />
        <input id="hdnPatientSex" type="hidden" value="0" runat="server" />
        <input id="hdnEdtPatientAge" type="hidden" value="0" runat="server" />
        <input id="hdnEditDDlDOB" runat="server" value="0" type="hidden" />
        <input id="hdnddlsalutation" runat="server" value="0" type="hidden" />
        <input id="hdnEditSex" runat="server" value="0" type="hidden" />
        <input id="hdnEdtSelectedClientClientID" runat="server" value="0" type="hidden" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <input id="hdnZoneID" runat="server" value="0" type="hidden" />
        <input id="hdnorgIDCl" type="hidden" runat="server" />
        <input id="HidhdnZoneName" runat="server" type="hidden" />
        <input id="hdnpatName" runat="server" type="hidden" />
        <asp:HiddenField ID="hdnVisitNumber" runat="server" />
        <asp:HiddenField ID="hdnautoautz" runat="server" />
        <asp:HiddenField ID="hdnDispatch" runat="server" />
        <asp:HiddenField ID="hdnCBDecimalAge" runat="server" />
        <input id="hdnValidateclient" type="hidden" value="0" runat="server" />
        <%-- <input id="HdnIsCopay" type="hidden" value="Y" runat="server" />--%>
        <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
        <input id="hdntaskID" type="hidden" value="-1" runat="server" />
        <%--<input id="HdnCoPay" type="hidden" value="-1" runat="server" />		--%>
        <asp:HiddenField ID="hdnLstPatientInvestigation" runat="server" />
        <asp:HiddenField ID="hdnClientPortal" runat="server" />
        <asp:HiddenField ID="hdnLocationClient" runat="server" />
        <asp:HiddenField ID="hdnPageType" runat="server" Value="B2B" />
         <input id="hdnCollectionID" runat="server" value="0" type="hidden" />
        <input id="hdnTotalDepositAmount" runat="server" value="0" type="hidden" />
        <input id="hdnTotalDepositUsed" runat="server" value="0" type="hidden" />
        <input id="hdnAmtRefund" runat="server" value="0" type="hidden" />
        <input id="hdnThresholdType" runat="server" value="0" type="hidden" />
        <input id="hdnThresholdValue" runat="server" value="" type="hidden" />
         <input id="hdnThresholdValue2" runat="server" value="" type="hidden" />
          <input id="hdnThresholdValue3" runat="server" value="" type="hidden" />
        <input id="hdnVirtualCreditType" runat="server" value="0" type="hidden" />
        <input id="hdnVirtualCreditValue" runat="server" value="" type="hidden" />
        <input id="hdnMinimumAdvanceAmt" runat="server" value="0" type="hidden" />
        <input id="hdnMaximumAdvanceAmt" runat="server" value="0" type="hidden" />
        <input id="hdnAvailDepositAmt" runat="server" value="0" type="hidden" />
        <input id="hdnAdvanceClient" runat="server" value="0" type="hidden" />
         <asp:HiddenField ID="HdnPhleboNameMandatory" runat="server" Value="N" />
        <asp:HiddenField ID="hdnAllowSplChar" runat="server" Value="N" />
    <asp:HiddenField ID="hdnCheckFlag" runat="server" />
    <asp:HiddenField ID="hdnClientFlag" runat="server" />
     <asp:HiddenField ID="hdnRoundNo" runat="server" />
     <input id="hdnAmount" type="hidden" value="" runat="server" />
     <input id="hdnCLP" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnlabnumber" runat="server" Value="N" />
    <asp:HiddenField ID="hdncollectcashforcreditclient" runat="server" Value="N" />
    <asp:HiddenField ID="hdnPatientLabNumber" runat="server" />
    <asp:HiddenField ID="hdnPatientLabnumberList" Value="N" runat="server"/>
    <asp:HiddenField ID="hdnPatientSelected" Value="N" runat="server"/>
    <asp:HiddenField ID="hdnBookedID" Value="0" runat="server"/> 
   <asp:HiddenField ID="hdnClientAttrList" Value="" runat="server" />
   <input id="hdnMRPBillDisplay" type="hidden" value="N" runat="server" /> 
   <input id="hdnRemotelogin" runat="server" value="N" type="hidden" />
<asp:HiddenField ID="hdnTestHistoryPatient" Value="" runat="server" />
    <input type="hidden" id="hdnreplanguage" runat="server" value="" />
<asp:HiddenField ID="hdnExternalBarcode" Value="N" runat="server" />
<asp:HiddenField ID="hdnExBarcodeExpiry" Value="0" runat="server" /> 
<asp:HiddenField ID="hdnIsExbarcode" Value="N" runat="server" /> 
<asp:HiddenField ID="hdnAllowGreaterAmtfromMrp" Value="N" runat="server" /> 
<asp:HiddenField ID="hdnnotallowlogisticfreetext" runat="server" Value="N" />
  <input id="hdnTotalCreditLimit" runat="server" value="0" type="hidden" />
        <input id="hdnTotalCreditUsed" runat="server" value="0" type="hidden" />
        <input id="hdnCreditLimit" runat="server" value="0" type="hidden" />
        <input id="hdnCreditExpires" runat="server" value=0 type="hidden" />
        <input id="hdnIsBlockReg" runat="server" value=0 type="hidden" />
        <input id="hdnSerachPatientwithClientID" type="hidden" value="0" runat="server" />
    <script type="text/javascript">
        function AddReportLanguage() {

            var ReportLang = document.getElementById('ddlreplang').value;
            var Language = $("#ddlreplang option:selected").text();
            if (ReportLang == "0") {
                alert("Please select the language");
                return false;
            }
            else {
                document.getElementById('hdnreplanguage').value += Language + "|" + ReportLang + "^";
                GenerateLangTable();
                clearlanguage();
                return false;
            }

        }
        function clearlanguage() {
            document.getElementById('ddlreplang').selectedIndex = 0;
        }
        function GenerateLangTable() {

            while (count = document.getElementById('tblreportlang').rows.length) {
                for (var j = 0; j < document.getElementById('tblreportlang').rows.length; j++) {
                    document.getElementById('tblreportlang').deleteRow(j);
                }
            }
            var pList = document.getElementById('hdnreplanguage').value.split("^");
            if (pList != "") {
                document.getElementById('divreplang').style.display = "block";
                var Headrow = document.getElementById('tblreportlang').insertRow(0);
                Headrow.id = "HeadLangID";
                var id = 0;
                Headrow.style.fontWeight = "bold";
                Headrow.className = "dataheader1"

                var vNo = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033") == null ? "S.No" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033");
                var vRepLanguage = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_065") == null ? "Language" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_065");
                var vAction = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040") == null ? "Action" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040");
                var vLangcode = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_067") == null ? "Lang Code" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_067");

                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);

                cell1.innerHTML = vNo;
                cell2.innerHTML = vRepLanguage;
                cell3.innerHTML = vLangcode;
                cell4.innerHTML = vAction;
                cell3.style.display = 'none';
                for (s = 0; s < pList.length; s++) {
                    if (pList[s] != "") {
                        y = pList[s].split('|');
                        var row = document.getElementById('tblreportlang').insertRow(1);
                        row.style.height = "10px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        cell3.style.display = 'none';
                        cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                        cell2.innerHTML = y[0];
                        cell3.innerHTML = y[1];
                        cell4.innerHTML = "<input id='editlang' name='" + y[0] + "|" + y[1] +
                                                              "' onclick='btnEditLang_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> " +
                                           "<input id='deletelang' name='" + y[0] + "|" + y[1] +
                                                                "' onclick='btnDeleteLang(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

                    }
                }
            }
        }

        function btnEditLang_OnClick(sEditedData) {
            var vUpdate = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057");
            if (document.getElementById('hdnreplanguage').value != "") {
                sEditedData = sEditedData.replace("\\", "'");
                var y = sEditedData.split('|');
                $('#ddlreplang').val(y[1]);
                document.getElementById('btnAddlang').value = vUpdate;
                var list = document.getElementById('hdnreplanguage').value.split("^");
                document.getElementById('hdnreplanguage').value = "";
                for (var i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        list[i] = list[i].replace(/\&amp;/g, "&");
                        //                    sEditedData = sEditedData.replace(/\&amp;/g, "&");
                        if (list[i] != sEditedData) {
                            document.getElementById('hdnreplanguage').value += list[i] + "^";
                        }
                    }
                }
            }
            GenerateLangTable();
            var tbl = document.getElementById('tblreportlang').rows.length;
            var Tb = document.getElementById('tblreportlang');
            if (tbl > 0) {
                for (var j = 0; j < tbl; j++) {
                    Tb.rows[j].cells[3].style.display = "none";
                }
            }


            var Add = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_068") == null ? "Add" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_068");
            document.getElementById('btnAddlang').value = Add;
        }
        function btnDeleteLang(sEditedData) {
            var i;
            var confirmmsg1;
            //var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_44");
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Confirm to delete!!";
            var btnok = SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") : "Ok";
            var btncancel = SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") : "Cancel";
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            if (UsrAlrtMsg != null) {
                confirmmsg1 = UsrAlrtMsg;

            }
            else {
                confirmmsg1 = UsrAlrtMsg;
            }
            var IsDelete = ConfirmWindow(confirmmsg1, AlrtWinHdr, btnok, btncancel);
            if (IsDelete == true) {
                var x = document.getElementById('hdnreplanguage').value.split("^");
                document.getElementById('hdnreplanguage').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnreplanguage').value += x[i] + "^";
                        }
                    }
                }
                GenerateLangTable();
            }
            else {
                return false;
            }
        }
        function preventInput(evnt) {
            //Checked In IE9,Chrome,FireFox
            if (evnt.which != 9) evnt.preventDefault();
        }

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "table-row";
            showResponses('divBill1', 'divBill2', 'divBill3', 0);
            showResponses('divBill1', 'divBill2', 'divOrder', 0);
        }
        function ToInternalFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.asNumber({ region: "<%=LanguageCode%>" });
            }
        }

        function ToTargetFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
                //return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }

        function OnCollectioncenterselectedClient(source, eventArgs) {
            document.getElementById('txtLocClient').value = eventArgs.get_text();
            document.getElementById('hdnClienID').value = eventArgs.get_value();
        }
        function Selectedphlebotomist(source, eventArgs) {
            PhleboDetails = eventArgs.get_value();

            var PhleboName = PhleboDetails.split('~')[0];
            var PhleboID = PhleboDetails.split('~')[1];
            if (document.getElementById('HdnPhleboName') != null) {
                document.getElementById('HdnPhleboName').value = PhleboName;
            }
            if (document.getElementById('HdnPhleboID') != null) {
                document.getElementById('HdnPhleboID').value = PhleboID;
            }
        }
        function SelectedLogistics(source, eventArgs) {
            LogisticsDetails = eventArgs.get_value();

            var LogisticsName = LogisticsDetails.split('~')[0];
            var LogisticsID = LogisticsDetails.split('~')[1];
            if (document.getElementById('hdnLogisticsName') != null) {
                document.getElementById('hdnLogisticsName').value = LogisticsName;
            }
            if (document.getElementById('hdnLogisticsID') != null) {
                document.getElementById('hdnLogisticsID').value = LogisticsID;
            }
        }
        function EnabledFalse() {

            document.getElementById('<%=ddSalutation.ClientID%>').disabled = true;
            document.getElementById('<%=txtName.ClientID%>').disabled = true;
            document.getElementById('<%=txtDOBNos.ClientID%>').readOnly = true;
            document.getElementById('<%=ddlDOBDWMY.ClientID%>').disabled = true;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = true;


            document.getElementById('<%=ddlIsExternalPatient.ClientID%>').disabled = true;
            document.getElementById('<%=txtExternalPatientNumber.ClientID%>').readOnly = true;
            document.getElementById('<%=txtLocClient.ClientID%>').readOnly = true;

            //document.getElementById('<%=txtClient.ClientID%>').disabled = true;
            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = true;
            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = true;

            document.getElementById('<%=txtEmail.ClientID%>').readOnly = true;
            document.getElementById('<%=chkMobileNotify.ClientID%>').disabled = true;
            document.getElementById('<%=txtMobileNumber.ClientID%>').readOnly = true;

            document.getElementById('<%=txtRoundNo.ClientID%>').readOnly = true;
            document.getElementById('<%=txtPhleboName.ClientID%>').readOnly = true;
            document.getElementById('<%=txtLogistics.ClientID%>').disabled = true;
            document.getElementById('<%=txtzone.ClientID%>').disabled = true;


            $('#chkExcludeAutoathz').attr('readonly', true);
            document.getElementById('<%=chkExcludeAutoathz.ClientID%>').disabled = true;
            document.getElementById('<%=chkDespatchMode.ClientID%>').disabled = true;
            //document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=ddlNationality.ClientID%>').disabled = true;

            document.getElementById('<%=ddCountry.ClientID%>').disabled = true;
            document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=txtClient.ClientID%>').disabled = true;
            document.getElementById('<%=tDOB.ClientID%>').disabled = true;

            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = true;
            document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = true;
            document.getElementById('<%=txtURNo.ClientID%>').disabled = true;


            // document.getElementById('<%=FileUpload1.ClientID%>').disabled = false;


        }
        function EnabledTrue() {

            document.getElementById('<%=ddSalutation.ClientID%>').disabled = false;
            document.getElementById('<%=txtName.ClientID%>').disabled = false;
            document.getElementById('<%=txtDOBNos.ClientID%>').readOnly = false;
            document.getElementById('<%=ddlDOBDWMY.ClientID%>').disabled = false;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = false;


            document.getElementById('<%=ddlIsExternalPatient.ClientID%>').disabled = false;
            document.getElementById('<%=txtExternalPatientNumber.ClientID%>').readOnly = false;
            document.getElementById('<%=txtLocClient.ClientID%>').readOnly = false;

            //document.getElementById('<%=txtClient.ClientID%>').disabled = true;
            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = false;
            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = false;

            document.getElementById('<%=txtEmail.ClientID%>').readOnly = false;
            document.getElementById('<%=chkMobileNotify.ClientID%>').disabled = false;
            document.getElementById('<%=txtMobileNumber.ClientID%>').readOnly = false;

            document.getElementById('<%=txtRoundNo.ClientID%>').readOnly = false;
            document.getElementById('<%=txtPhleboName.ClientID%>').readOnly = false;
            document.getElementById('<%=txtLogistics.ClientID%>').disabled = false;
            document.getElementById('<%=txtzone.ClientID%>').disabled = false;


            $('#chkExcludeAutoathz').attr('readonly', false);
            document.getElementById('<%=chkExcludeAutoathz.ClientID%>').disabled = false;
            document.getElementById('<%=chkDespatchMode.ClientID%>').disabled = false;
            //document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=ddlNationality.ClientID%>').disabled = false;

            document.getElementById('<%=ddCountry.ClientID%>').disabled = false;
            document.getElementById('<%=ddState.ClientID%>').disabled = false;
            document.getElementById('<%=txtClient.ClientID%>').disabled = false;
            document.getElementById('<%=tDOB.ClientID%>').disabled = false;
            document.getElementById('<%=txtName.ClientID%>').value = '';


            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = false;
            document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = false;
            document.getElementById('<%=txtURNo.ClientID%>').disabled = false;
            // document.getElementById('<%=FileUpload1.ClientID%>').disabled = false;


        }
        function SelectedLogistics(source, eventArgs) {
            LogisticsDetails = eventArgs.get_value();

            var LogisticsName = LogisticsDetails.split('~')[0];
            var LogisticsID = LogisticsDetails.split('~')[1];
            if (document.getElementById('hdnLogisticsName') != null) {
                document.getElementById('hdnLogisticsName').value = LogisticsName;
            }
            if (document.getElementById('hdnLogisticsID') != null) {
                document.getElementById('hdnLogisticsID').value = LogisticsID;
            }
        }
        function Onzoneselected(source, eventArgs) {
            ZoneDetails = eventArgs.get_value();

            var ZoneName = ZoneDetails.split('~')[0];
            var ZoneID = ZoneDetails.split('~')[1];
            if (document.getElementById('HidhdnZoneName') != null) {
                document.getElementById('HidhdnZoneName').value = ZoneName;
            }
            if (document.getElementById('hdnZoneID') != null) {
                document.getElementById('hdnZoneID').value = ZoneID;
            }

            $find('AutoCompleteExtenderClientCorp').set_contextKey(document.getElementById('hdnorgIDCl').value + '~' + 'CLIENTZONE'
            + "~" + document.getElementById('hdnZoneID').value);
            $find('AutoCompleteExtenderLogi').set_contextKey(document.getElementById('hdnorgIDCl').value
            + '~' + 'LogisticsZone' + '~' + document.getElementById('hdnZoneID').value);
            LoadLogistics();
            //document.getElementById('txtClient').focus();
        }
       
        
    </script>

    <script type="text/javascript">
        function ClearZoneDetails() {
            if (document.getElementById('txtzone') != null) {
                document.getElementById('txtzone').value = '';
            }
            if (document.getElementById('hdnZoneID') != null) {
                document.getElementById('hdnZoneID').value = '0';
            }
            if (document.getElementById('HidhdnZoneName') != null) {
                document.getElementById('HidhdnZoneName').value = '';
            }
            $find('AutoCompleteExtenderClientCorp').set_contextKey(document.getElementById('hdnorgIDCl').value + '~' + 'CLIENTZONE'
            + "~" + 0);
            $find('AutoCompleteExtenderLogi').set_contextKey(document.getElementById('hdnorgIDCl').value
            + '~' + 'LogisticsZone' + '~' + 0);

        }
        function LoadLogistics() {

            if (document.getElementById('hdnZoneID').value != "0") {
                var prefixText = "";
                var count = 0;
                var contextKey = document.getElementById('hdnorgIDCl').value + '~' + 'LogisticsZone' + '~' + document.getElementById('hdnZoneID').value;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/LoadDefautlogistics",
                    data: "{'prefixText': '" + "" + "','count': " + count + ",'contextKey':'" + contextKey + "'}",
                    dataType: "json",
                    success: function(data) {
                        Items = data.d[0];
                        if (Items != undefined) {
                            // LoadComplaintItem(Items);
                            document.getElementById('txtLogistics').value = Items.Name;

                            document.getElementById('hdnLogisticsName').value = Items.Name;
                            document.getElementById('hdnLogisticsID').value = Items.EmpID;
                        }
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }
        }
        function ClearlogisticsID() {
            document.getElementById('hdnLogisticsID').value = '';
        }
        function CheckValidationForAutocomplete(codeType, TxtID) {


            if (codeType == 'Logi') {
                var logisticID = document.getElementById('hdnLogisticsID').value;
                var LogisticName = document.getElementById('txtLogistics').value;

                //            var OrgID = document.getElementById('hdnOrgID').value;
                var _NotAllowFreeText = document.getElementById('hdnnotallowlogisticfreetext').value;
                var AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');
                var vRefAlert = "Please select the Logistic Name from the completion list";
                if (_NotAllowFreeText == 'Y') {
                    if (LogisticName != '') {
                        if (logisticID == "") {
                            ValidationWindow(vRefAlert, AlertType);
                            //alert('Please select the physician from the completion list');
                            document.getElementById('txtLogistics').value = '';
                        }
                    }
                }
            }
            var txtValue = document.getElementById(TxtID).value.trim();
           // $('#dialog').html("");
          
            if (codeType == 'Zone') {

            }
            else if (codeType == 'Client') {
                if (txtValue != '') {

                }

            }
            else {

            }
        }
        // In Edit Bill cancel the backspace navigation By Nallathambi
        var KEYCODE_BACKSPACE = 8;
        $(document).keydown(SuppressKeyStrokes);
        function SuppressKeyStrokes(e) {
            if ((e.keyCode == KEYCODE_BACKSPACE && e.target.type == "text" && e.target.readOnly == true)) {

                e.preventDefault();
                e.stopImmediatePropagation();
                return false;
            }
        };
    </script>

    <script type="text/javascript">

        function Validategender() {
            if (document.getElementById('chkIncomplete').checked == true) {
                document.getElementById('ddlSex').value = "0";
                document.getElementById('ddlSex').disabled = true;
                document.getElementById('imgddlSex').style.display = 'none';
                document.getElementById('txtDOBNos').value = "";
                document.getElementById('txtDOBNos').disabled = true;
                document.getElementById('imgAge').style.display = 'none';
                document.getElementById('imgDOB').style.display = 'none';
                document.getElementById("ddlUnknownFlag").disabled = false;
                document.getElementById('tDOB').disabled = true;
                document.getElementById('ddlDOBDWMY').disabled = true;
                
                //                document.getElementById('ImageDOB').style.display = 'none';
            }
            else {
                document.getElementById('ddlSex').value = "0";
                document.getElementById('ddlSex').disabled = false;
                document.getElementById('imgddlSex').style.display = 'block';
                document.getElementById('txtDOBNos').value = "";
                document.getElementById('txtDOBNos').disabled = false;
                document.getElementById('imgAge').style.display = 'block';
                document.getElementById('imgDOB').style.display = 'block';
                document.getElementById("ddlUnknownFlag").disabled = true;
                document.getElementById('tDOB').disabled = false;
                document.getElementById('ddlDOBDWMY').disabled = false;
                document.getElementById("ddlUnknownFlag").selectedIndex = "0";
                document.getElementById('txtDOBNos').disabled = false;
                //                document.getElementById('ImageDOB').style.display = 'block';
            }
        }
    
    </script>

    <script type="text/javascript">
        function javPhlebotomistDetails() {
            document.getElementById('HdnPhleboID').value = "";

            $find('AutoCompleteExLstGrp55')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExLstGrp55')._update(context, result, false);
                var userMsg1 = SListForAppMsg.Get('Billing_ClientBilling_aspx_01') != null ? SListForAppMsg.Get('Billing_ClientBilling_aspx_01') : "Please select Phlebotomist Name from the list";
               var DisplMsg = SListForAppMsg.Get('Billing_ClientBilling_aspx_Alert') != null ? SListForAppMsg.Get('Billing_ClientBilling_aspx_Alert') : "Alert";
                if (result == "") {
                    //alert('Please select Phlebotomist Name from the list');
                    ValidationWindow(userMsg1, DisplMsg);
                    $('#txtPhleboName').val("");
                    document.getElementById('txtPhleboName').focus();
                    return false;
                }
            };
        }

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
    </script>

    </form>
     <script src="../QMS/dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
  

</body>
</html>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

