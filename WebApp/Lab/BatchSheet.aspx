<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchSheet.aspx.cs" Inherits="Lab_BatchSheet"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Batch Sheet</title>
    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>  
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
<%--
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>  
--%>
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
<%--
    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>--%>

    

    <script language="javascript" type="text/javascript">
        /* Common Alert Validation */
        var AlertType;
//        $(document).ready(function() {            
//            AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');
//        });
        function validateVisit() {
            /* Added By Venkatesh S */
            var vFormDate = SListForAppMsg.Get('Lab_BatchSheet_aspx_01') == null ? "Select From Date" : SListForAppMsg.Get('Lab_BatchSheet_aspx_01');
            var vToDate = SListForAppMsg.Get('Lab_BatchSheet_aspx_02') == null ? "Select To Date" : SListForAppMsg.Get('Lab_BatchSheet_aspx_02');
            var vDateValidation = SListForAppMsg.Get('Lab_BatchSheet_aspx_03') == null ? "Enter To Date as Greater than From Date" : SListForAppMsg.Get('Lab_BatchSheet_aspx_03');
            var vDestination = SListForAppMsg.Get('Lab_BatchSheet_aspx_04') == null ? "Select the destination" : SListForAppMsg.Get('Lab_BatchSheet_aspx_04');
            var vBatchNo = SListForAppMsg.Get('Lab_BatchSheet_aspx_05') == null ? "Enter Batch No" : SListForAppMsg.Get('Lab_BatchSheet_aspx_05');
            var AlertType = SListForAppMsg.Get('Lab_BatchSheet_aspx_10') == null ? "Alert" : SListForAppMsg.Get('Lab_BatchSheet_aspx_10');
            var a = document.getElementById('hdnProcessingLocation').value;            
            mode = $('#rdlBatchMode input:checked').val();            
            if (mode != '5') {
                if (document.getElementById('txtFrom').value.trim() == '' || document.getElementById('txtFrom').value == null) {
                    document.getElementById('txtFrom').focus();
                    ValidationWindow(vFormDate, AlertType);
                    return false;
                }
                if (document.getElementById('txtTo').value.trim() == '' || document.getElementById('txtTo').value == null) {
                    document.getElementById('txtTo').focus();
                    ValidationWindow(vToDate, AlertType);
                    return false;
                }
                if (Date.parse(document.getElementById('txtFrom').value.trim()) > Date.parse(document.getElementById('txtTo').value.trim())) {
                    ValidationWindow(vDateValidation, AlertType);
                    return false;
                }

                var ddlLocation = document.getElementById("ddlocation");
                if (ddlLocation.options[ddlLocation.selectedIndex].value == '0' && (mode == '1' || mode == '2')) {
                    ValidationWindow(vDestination, AlertType);
                    return false;
                }
                //                if (document.getElementById('hdnCodeExists').value == 'Y' && (mode == '1')) {
                //                    alert('This Batch has already been generated. You cannot allow to generate new batch.');
                //                    return false;
                //                }
            }
            if ((mode == '5') && document.getElementById('txtBatchNo').value == '') {
                document.getElementById('txtBatchNo').focus();
                ValidationWindow(vBatchNo, AlertType);
                return false;
            }
            return true;
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            prtContent.style.display = "block";
            var divFooter = document.getElementById('divFooter');
            divFooter.style.display = "block";
            var divHeader = document.getElementById('divHeader');
            divHeader.style.display = "block";
            var grSampleDetails = document.getElementById('grSampleDetails');
            grSampleDetails.style.display = "none";
            

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            //prtContent.style.display = "none";
            divFooter.style.display = "none";
            divHeader.style.display = "none";
            grSampleDetails.style.display = "block";
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function CheckCode() {
            try {
                text = document.getElementById('txtBatchNo').value;
                OrgID = document.getElementById('hdnOrgID').value.split('~')[0];
                FromDate = document.getElementById('txtFrom').value;
                ToDate = document.getElementById('txtTo').value;
                ddlLocation = document.getElementById("ddlocation");
                SourceLocationID = document.getElementById('hdnOrgID').value.split('~')[1];
                ProcessingLocationID = ddlLocation.options[ddlLocation.selectedIndex].value;
                ContextKey = OrgID + '~' + FromDate + '~' + ToDate + '~' + SourceLocationID + '~' + ProcessingLocationID + '~' + 'CHECK';
                $find('AutoCompleteExtender3').set_contextKey(OrgID + '~' + FromDate + '~' + ToDate + '~' + SourceLocationID + '~' + ProcessingLocationID + '~' + 'GET');
                if (text == '') {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetBatchSheet",
                        data: "{prefixText:'" + text + "', contextKey:'" + ContextKey + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function Success(data) {
                            document.getElementById('hdnCodeExists').value = data.d;
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

    function onGetUsersByRole() {
        try {
         OrgID = document.getElementById('hdnOrgID').value.split('~')[0];
                ddlMultiRoleUsers = document.getElementById("ddlMultiRoleUsers");
            $('#' + ddlMultiRoleUsers).children('option:not(:first)').remove();
            var selectedAutoAuthorizeRole = $('#' + ddlMultiRoleUsers + ' option:selected');
            var selectedAutoAuthorizeUser = $('#' + ddlMultiRoleUsers + ' option:selected');
            $('#' + hdnAutoAuthorizeUser).val($(selectedAutoAuthorizeUser).val());
        }
        catch (e) {
            return false;
        }
    }
        function ResetBatch() {
            try {
                mode = $('#rdlBatchMode input:checked').val();
                $('#ddlocation').val('0');
                $('#hdnBatchID').val('0');
                $('#hdnProcessingLocation').val('0');
                document.getElementById('txtBatchNo').value = '';
                if (mode == '1' && document.getElementById('txtFrom').value != '' && document.getElementById('txtTo').value != '') {
                    var ddlLocation = document.getElementById("ddlocation");
                    if (ddlLocation.options[ddlLocation.selectedIndex].value != '0') {
                        CheckCode();
                    }
                }
                if (mode == '1') {
                    $('[id$="tabPrintButton"]').hide();
                }
            }
            catch (e) {
                return false;
            }
        }

        function SetBatchID(source, eventArgs) {
            batchID = eventArgs.get_value().split('~')[0];
            document.getElementById('hdnProcessingLocation').value = eventArgs.get_value().split('~')[1];
            document.getElementById('txtBatchNo').value = eventArgs.get_text();
            document.getElementById('hdnBatchID').value = batchID;
        }

        function SelectBatch() {
            /* Added By Venkatesh S */
            var vSelectAtleastOne = SListForAppMsg.Get('Lab_BatchSheet_aspx_06') == null ? "Select Atleast One" : SListForAppMsg.Get('Lab_BatchSheet_aspx_06');
            AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');
            
            try {
                if ($("[id$='grdResult'] input[id$='chkSelect']:checkbox:checked").size() > 0) {
                    document.getElementById('hdnUnSelectedPatients').value == '';
                    $("#divgv table tr").each(function() {
                        //debugger;
                        var tr = $(this).closest("tr");
                        var chk = $(tr).find("input:checkbox[id$=chkSelect]").prop('checked') ? true : false;
                        if (chk == true) {                           
                            var ExternalVisitID1 = $(tr).find("input:hidden[id$=hdnExvisitID]") ? $(tr).find("input:hidden[id$=hdnExvisitID]").val() : '';
                            if (document.getElementById('hdnUnSelectedPatients').value == '') {
                                document.getElementById('hdnUnSelectedPatients').value = ExternalVisitID1 + '~';
                            }
                            else {
                                document.getElementById('hdnUnSelectedPatients').value += ExternalVisitID1 + '~';
                            }
                        }
                    });
                }
                else {
                    ValidationWindow(vSelectAtleastOne, AlertType);
                    return false;
                }
                return true;
            }
            catch (e) {
                return false;
            }
        }






        function GetParameterValues(param) {
            try {
                var QueryString = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < QueryString.length; i++) {
                    var urlparam = QueryString[i].split('=');
                    if (urlparam[0] == param) {
                        return urlparam[1];
                    }
                }
            }
            catch (e) {
                return false;
            }
        }

        function SelectAll(chk) {
            try {
                $('[id$="grdResult"]').find("input:checkbox").each(function() {
                    if (this != chk) {
                        this.checked = chk.checked;
                    }
                });
            }
            catch (e) {
            }
        }
        function chkHeaderChkbox() {
            //Get number of checkboxes in list either checked or not checked
            var totalCheckboxes = $("[id$='grdResult'] input[id$='chkSelect']:checkbox").size();
            //Get number of checked checkboxes in list
            var checkedCheckboxes = $("[id$='grdResult'] input[id$='chkSelect']:checkbox:checked").size();
            //Check / Uncheck top checkbox if all the checked boxes in list are checked
            $("[id$='grdResult'] input[id$='chkSelectAll']:checkbox").attr('checked', totalCheckboxes == checkedCheckboxes);
        }
          
       
    </script>

    <style type="text/css">
        .cssTextBox
        {
            background-image: url(images/form_bg.jpg);
            background-repeat: repeat-x;
            border: 1px solid #d1c7ac;
            width: 180px;
            height: 14px;
            color: #333333;
            padding: 3px;
            margin-right: 4px;
            margin-bottom: 8px;
            font-family: tahoma, arial, sans-serif;
        }
        .AutoCompletesearchBox
        {
            background-image: url('../Images/AutoCompleteSearch.png');
            background-repeat: no-repeat;
            font-family: tahoma, arial, sans-serif;
            text-align: left;
            height: 17px;
            width: 165px;
            border: 1px solid #d1c7ac;
            font-size: 11px;
            margin-left: 0px;
            padding-left: 20px;
        }
        .gridcolumnHide
        {
        	display:none;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                    
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="updatePanel1" runat="server">
                                   <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="dataheaderInvCtrl w-100p font13 v-top searchPanel"
                                    style="font-family: Tahoma;" id="tbSearch"
                                    runat="server">
                                    <tr>
                                        <td class="w-12p">
                                            <asp:Label ID="Rs_FromVisitNo" Text="From Visit No" runat="server" meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>
                                        </td>
                                        <td class="w-25p">
                                            <asp:TextBox ID="txtFromVisit" runat="server" meta:resourcekey="txtFromVisitResource1"
                                                CssClass="cssTextBox"></asp:TextBox>
                                        </td>
                                        <td class="w-12p">
                                            <asp:Label ID="Rs_ToVisitNo" Text="To Visit No" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                                        </td>
                                        <td class="w-51p">
                                            <asp:TextBox ID="txtToVisit" runat="server" meta:resourcekey="txtToVisitResource1"
                                                CssClass="cssTextBox"></asp:TextBox>
                                        </td>
                                        <td> <td  style="width:auto">
                            <asp:Label ID="lblConsumername" runat="server" Text="Collection Person" ></asp:Label>
                                        </td></td>
                                        <td class="w-25p"> <asp:DropDownList ID="ddlMultiRoleUsers" runat="server" Width="192" onchange="onChangeAutoAuthorizeUser();"></asp:DropDownList><asp:HiddenField ID="hdnMultiRoleUser" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                            <asp:Label ID="Rs_From" Text="From Date" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p">
                                                <tr class="defaultfontcolor">
                                                    <td class="w-20p">
                                        <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" size="25" CssClass="cssTextBox"
                                            meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="datecheck" runat="server" align="left">
                                                        <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                            <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                            <asp:Label ID="Rs_To" Text="To Date" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p">
                                                <tr class="defaultfontcolor">
                                                    <td class="w-20p">
                                        <asp:TextBox runat="server" ID="txtTo" MaxLength="25" size="25" CssClass="cssTextBox"
                                            meta:resourcekey="txtToResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="Td1" runat="server" align="left" valign="top">
                                                        <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                            <img src="../Images/Calendar_scheduleHS.png" class="w-16 h-16" alt="Pick a date"></a>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                            <asp:Label ID="lblLocation" runat="server" Text="Destination" meta:resourcekey="lblLocationResource1"></asp:Label>
                                        </td>
                                        <td>
                            <asp:DropDownList ID="ddlocation" runat="server" Width="190px" meta:resourcekey="ddlocationResource1">
                                            </asp:DropDownList>
                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                        </td>
                                        <td>
                            <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                        </td>
                                        <td>
                            <asp:TextBox ID="txtBatchNo" runat="server" CssClass="AutoCompletesearchBox" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtBatchNo"
                                                EnableCaching="False" MinimumPrefixLength="3" CompletionInterval="0" FirstRowSelected="True"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="GetBatchSheet"
                                                ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                                OnClientItemSelected="SetBatchID">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="a-left">
                            <asp:Panel ID="Panel1" CssClass="dataheader2 w-69p bg-row b-grey" runat="server"
                                meta:resourcekey="Panel1Resource1">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right">
                                                        <%--    <b>Batch Mode : </b>--%><%=Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_09%>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:RadioButtonList ID="rdlBatchMode" CssClass="font12" runat="server" RepeatDirection="Horizontal">
                                               <%-- <asp:ListItem Value="1" Selected="True" meta:resourcekey="ListItemResource1">Generate New Batch </asp:ListItem>
                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Add To Exist Batch </asp:ListItem>
                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource3">View Exist Batch </asp:ListItem>--%>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-20p font10" colspan="2">
                                            <img src="../Images/starbutton.png" alt="" class="v-middle" /><img src="../Images/starbutton.png"
                                alt="" class="v-middle" /><asp:Label runat="server" Text="Mandatory for Generating New Batch And Add to Existing Batch"
                                    meta:resourcekey="LabelResource1"></asp:Label>
                                        </td>
                                        <td class="a-left paddinL30" colspan="3">
                                            <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Show Batch Sheet"
                                                CssClass="btn pointer" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                Text="Show BatchSheet" OnClick="btnFinish_Click" OnClientClick="javascript:return validateVisit();"
                                                meta:resourcekey="btnFinishResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <div id="divBatchSheet" runat="server">
                                    <table class="w-100p">
                                        <tr>
                            <td class="h-23 a-left" style="color: #000;">
                                                <div id="ACXplussmp" style="display: none;">
                                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                        onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1);" />
                                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1);">
                                        <asp:Label ID="Rs_ReceiveSampleList" Text="Batch Sheet List" runat="server" meta:resourcekey="Rs_ReceiveSampleListResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACXminussmp" style="display: block;">
                                                    <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0);" />
                                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0);">
                                                        &nbsp;
                                        <asp:Label ID="Rs_ReceiveSampleList1" Text="Batch Sheet List" runat="server" meta:resourcekey="Rs_ReceiveSampleList1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                        </tr>                                        
                                    </table>
                                    <br />
                                    <hr />
                                </div>
                                <table id="tabPrintButton" runat="server"
                                    class="w-100p font13 v-top" style="font-family: Tahoma;">
                                    <tr>
                                        <td class="a-left w-50p">
                                            <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Visible="true" ForeColor="#000333"
                                ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"><u> Export Batch Sheet</u></asp:LinkButton>
                                        </td>
                                        <td class="w-50p a-right">
                                            <asp:LinkButton ID="LinkButton1" runat="server" Visible="true" ForeColor="Blue" ToolTip="Print"
                                                Text="Print Batch Sheet" OnClick="LinkButton1_Click" Font-Bold="true" Font-Underline="true"
                                OnClientClick="return validateVisit();" meta:resourcekey="LinkButton1Resource1"></asp:LinkButton>
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" ToolTip="Print"
                                OnClick="btnPrint_Click" OnClientClick="return validateVisit();" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="divNoRecords" class="h-25" runat="server" style="border-width: 1px; border-style: ridge;
                                    border-color: Black; display: none; width: 250px; font-family: Tahoma;">
                                    <asp:Label ID="lblNoRecords" runat="server" Text="No matching records found..!" ForeColor="Red"
                        Font-Bold="True" meta:resourcekey="lblNoRecordsResource1"></asp:Label>
                                </div>
                                <asp:HiddenField ID="hdnOrgID" runat="server" />
                                <asp:HiddenField ID="hdnCodeExists" runat="server" />
                                <asp:HiddenField ID="hdnBatchID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnProcessingLocation" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnUnSelectedPatients" runat="server" Value="" />
                                <div id="prnReport" class="font12" runat="server" style="border-width: 1px; border-style: ridge;
                                    border-color: Black; display: block;">
                                    <div id="divHeader" runat="server" style="display: none;">
                                        <table class="w-100p" id="Table1">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Label ID="Label1" CssClass="font12" runat="server" Text="SPECIMEN TRANSMITTAL FORM" Font-Names="Verdana"
                                                        Font-Bold="true" meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divConteents" style="display: none;">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left">
                                    <asp:Label ID="lblLocationName" runat="server" Visible="False" Font-Names="Verdana"
                                        meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblPrintedOn" runat="server" Text="" Visible="false" meta:resourcekey="lblPrintedOnResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>                                        
                                    </div>
                                    <br />
                                    <div id="DivSamplDetails" runat="server" style="display: none">
                                        <table class="w-100p" id="tblSampleDtl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblLocationprint" runat="server" Text="Location:" Font-Names="Verdana"
                                        Font-Bold="True" CssClass="font12" meta:resourcekey="lblLocationprintResource1"></asp:Label>
                                                    <%--</td>
                                        <td>--%>
                                                    <asp:Label ID="TxtLocation" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="True" CssClass="font12" meta:resourcekey="TxtLocationResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblBnohdr" runat="server" Text="SampleBatch Worklist ID:" Font-Names="Verdana"
                                        Font-Bold="True" CssClass="font12" meta:resourcekey="lblBnohdrResource1"></asp:Label>
                                                    <%--</td>
                                        <td>--%>
                                                    <asp:Label ID="lblbnoitem" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="True" Font-Size="12px" meta:resourcekey="lblbnoitemResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="trClient" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label ID="lblClientName" runat="server" Text="Client Name:" Font-Names="Verdana"
                                        Font-Bold="True" CssClass="font12" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                                    <asp:Label ID="TxtClientName" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="True" Font-Size="12px" meta:resourcekey="TxtClientNameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="a-right">
                                                <td class="a-right">
                                                    <asp:GridView ID="grSampleDetails" runat="server" AutoGenerateColumns="False" Height="12%"
                                        PagerSettings-Mode="NextPrevious" Font-Names="Tahoma" Font-Bold="True" CssClass="mytable1 gridView w-20p font12"
                                        ForeColor="#333333" meta:resourcekey="grSampleDetailsResource1">
                                                        <PagerStyle HorizontalAlign="Center" />
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                            PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                        <Columns>
                                                            <asp:BoundField DataField="ContainerName" HeaderText="Sample Name" ItemStyle-Width="70%"
                                                                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField DataField="SampleContainerID" HeaderText="No. Of Count" ItemStyle-Width="30%"
                                                                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divGrid">
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2">
                                                    <%--BorderColor="#CCCCCC"--%>
                                                    <div id="divgv" runat="server">
                                                        <asp:GridView ID="grdResult" CssClass="gridView w-100p font9" runat="server" AllowPaging="True" AutoGenerateColumns="True"
                                                            GridLines="both" BorderColor="Black" BorderStyle="Double" Font-Names="Verdana" PagerStyle-ForeColor="black"
                                                            HeaderStyle-BorderWidth="0px" OnPageIndexChanging="grdResult_PageIndexChanging"
                                            PageSize="10000" OnRowDataBound="grdResult_RowDataBound" ShowFooter="True" meta:resourcekey="grdResultResource1">
                                                            <RowStyle VerticalAlign="Top" ForeColor="#000066" CssClass="font12" />
                                                            <PagerStyle ForeColor="Black"></PagerStyle>
                                                            <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                                            <EditRowStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" Checked="True" onClick="javascript:SelectAll(this);"
                                                            meta:resourcekey="chkSelectAllResource1" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="True" onClick="javascript:chkHeaderChkbox();"
                                                            meta:resourcekey="chkSelectResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BatchID" HeaderText="Sample Name" Visible="false" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="gridcolumnHide"
                                                    ItemStyle-CssClass="gridcolumnHide" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnExvisitID" runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divFooter" class="w-100p" style="display: none;">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-40p">
                                                    <asp:Label ID="lblissusedby" runat="server" Text="Printed by:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblissusedbyResource1"></asp:Label>
                                                    <asp:Label ID="txtissusedby" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtissusedbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-30p">
                                                    <asp:Label ID="lblpickedby" runat="server" Text="Courier by:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblpickedbyResource1"></asp:Label>
                                                    <asp:Label ID="txtpickedby" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtpickedbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-30p">
                                                    <asp:Label ID="lblReceivedbyprint" runat="server" Text="Received by:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblReceivedbyprintResource1"></asp:Label>
                                                    <asp:Label ID="txtReceivedbyprint" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtReceivedbyprintResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="w-40p">
                                                    <asp:Label ID="lblIssuedDate" runat="server" Text="Date & Time:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblIssuedDateResource1"></asp:Label>
                                                    <asp:Label ID="txtIssedDate" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtIssedDateResource1"></asp:Label>
                                                </td>
                                                <td class="w-30p">
                                                    <asp:Label ID="lblPickedDate" runat="server" Text="Date & Time:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblPickedDateResource1"></asp:Label>
                                                    <asp:Label ID="txtPickedDate" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtPickedDateResource1"></asp:Label>
                                                </td>
                                                <td class="w-30p">
                                                    <asp:Label ID="lblReceivedDate" runat="server" Text="Date & Time:" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="lblReceivedDateResource1"></asp:Label>
                                                    <asp:Label ID="txtReceivedDate" runat="server" Text="_______________" Font-Names="Verdana"
                                        Font-Bold="False" Font-Size="12px" meta:resourcekey="txtReceivedDateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="divBtn" class="a-center">
                                        <br />
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-center w-100p">
                                                    <asp:Button ID="btnGenerateBatchSheet" runat="server" Text="Generete BatchSheet"
                                                        OnClick="btnGenerateBatchSheet_Click" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" ToolTip="Click here to Generate Batch Sheet"
                                        OnClientClick="javascript:return SelectBatch()" meta:resourcekey="btnGenerateBatchSheetResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="lnkExportXL" />
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
               <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
      <Attune:Attunefooter ID="Attunefooter" runat="server" />



   <%-- <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>  
--%>
    </form>
</body>
</html>
