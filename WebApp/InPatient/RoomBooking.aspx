<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoomBooking.aspx.cs" Inherits="RoomBooking"
    meta:resourcekey="PageResource1" Culture="auto" UICulture="auto" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/RoomsDispaly.ascx" TagName="RoomDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PrintIPAdmissionDetails.ascx" TagName="IPAdmDetails"
    TagPrefix="uc9" %>
<%@ Register Assembly="System.Web.DynamicData, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.DynamicData" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ESLabelPrint.ascx" TagName="ESLabelPrint" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Room Booking</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

</head>
<body>
    <form id="roombook" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:HiddenField ID="hdnTreatmentPlanID" runat="server" Value="0" />

    <script type="text/javascript" language="javascript">
        var userMsg;
        function INVRowCommon(rid, TreatmentPlanID) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('<%=hdnTreatmentPlanID.ClientID %>').value = TreatmentPlanID;


        }

        var previousID = "";

        function getValues(iBedID, iBookingID, sType, iPaientID, fromPatientName, fromVisiID, AllowSlotBooking) {
            document.getElementById('<%= hdnBookingID.ClientID %>').value = iBookingID;
            document.getElementById('<%= hdnFromBedID.ClientID %>').value = iBedID;
            document.getElementById('<%= hdnToBedID.ClientID %>').value = iBedID;
            document.getElementById('<%= hdnFromPatientID.ClientID %>').value = iPaientID;
            document.getElementById('<%= hdnIsSlotBooking.ClientID %>').value = AllowSlotBooking;

            document.getElementById('<%= hdnFromPatientName.ClientID %>').value = fromPatientName;
            document.getElementById('<%= hdnFromVisitID.ClientID %>').value = fromVisiID;
            document.getElementById('RoomsView_divbook').style.display = 'none';

            var btnBook = document.getElementById('<%= btnBook.ClientID %>');
            var btnOccupy = document.getElementById('<%= btnOccupy.ClientID %>');
            var btnTransfer = document.getElementById('<%= btnTransfer.ClientID %>');
            var btnDischarge = document.getElementById('<%= btnDischarge.ClientID %>');
            var btnCancel = document.getElementById('<%= btnCancel.ClientID %>');
            var btnSchedules = document.getElementById('<%= btnSchedules.ClientID %>');

            var selDate = document.getElementById('<%= txtDate.ClientID %>');

            if ((document.getElementById('RoomsView_hdnCurrentPatientBookedStatus1').value == "Y") && (sType == "Occupy") && (document.getElementById('<%= hdnIsCreditBill.ClientID %>').value == "Y")) {

                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_9');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('More then one Room is not Allowed for Corporate-Patient!');
                    return false;
                }
            }

            if (sType == "Book") {
                var con;
                if (AllowSlotBooking == "Y") {
                    con = confirm("Are you sure you wish to book") //on: " + selDate.value);
                }
                else {
                    con = confirm("Are you sure you wish to book on: " + selDate.value);
                }
                if (con == true) {
                    document.getElementById('<%= hdnTransfer.ClientID %>').value = "0";
                    document.getElementById('<%= hdnIsOkClicked.ClientID %>').value = "N";
                    btnBook.click();
                }
            }
            else if (sType == "Occupy") {
                if (AdmissionTimeCheck()) {
                    var con = confirm("Are you sure you wish to occupy on: " + selDate.value);
                    if (con == true) {
                        document.getElementById('<%= hdnTransfer.ClientID %>').value = "0";
                        btnOccupy.click();
                        //document.getElementById('<%= hdnCurrentPatientBookedStatus.ClientID %>').value = "Y";
                    }
                }

            }
            else if (sType == "Transfer") {
                var con = confirm("Are you sure you wish to transfer the patient on: " + selDate.value);
                if (con == true) {
                    document.getElementById('<%= hdnTransfer.ClientID %>').value = "1";
                    document.getElementById('<%= showModalPopupClientButton1.ClientID %>').click();
                }
            }
            else if (sType == "Vacate") {
                var con = confirm("Are you sure you wish to vacate the bed on: " + selDate.value);
                if (con == true) {
                    document.getElementById('<%= hdnTransfer.ClientID %>').value = "0";
                    btnDischarge.click();
                }
            }
            else if (sType == "Cancel") {
                var con = confirm("Are you sure you wish to cancel booked bed");
                if (con == true) {
                    document.getElementById('<%= hdnTransfer.ClientID %>').value = "0";
                    btnCancel.click();
                }
            }
            else if (sType == "Schedules") {
                document.getElementById('<%= hdnTransfer.ClientID %>').value = "0";
                /* WebService.getRoomSchedules(1, sStartDateTime, sEndDateTime, iBedID, OnWSRequestComplete, OnWSRequestFailed); */
            }
            //        }
        }
        function OnWSRequestComplete(results) {
            document.getElementById('<%= dvTable.ClientID %>').innerHTML = "";
            var myArray = new Array();
            myArray = results;
            var html = "";
            for (var k = 0; k < results.length; k++) {
                // html += results[k].FromDate + " TO" + results[k].ToDate;
                CmdAdd_onclick(results[k].FromDate, results[k].ToDate, results[k].PatientName);
            }
            document.getElementById('<%= showModalPopupClientButton.ClientID %>').click();

        }

        function CmdAdd_onclick(FromDate, ToDate, PatientName) {

            var newTable, startTag, endTag;


            //Creating a new table
            startTag = "<TABLE Cellpadding='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY>"
            endTag = "</TBODY></TABLE>"

            newTable = startTag;
            var trContents;
            newTable += "<TR><TD style=\"WIDTH: 120px\" >" + FromDate + "</TD>";
            newTable += "<TD style=\"WIDTH: 120px\" >" + ToDate + "</TD>";
            newTable += "<TD style=\"WIDTH: 120px\" >" + PatientName + "</TD><TR>";
            newTable += endTag;

            //Update the Previous Table With New Table.
            document.getElementById('<%= dvTable.ClientID %>').innerHTML += newTable;
        }


        function OnWSRequestFailed(error) {
            userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_1');
            if (userMsg != null) {
                alert(userMsg);
                return false;

            }
            else {
                alert("Cannot Retrive Data Please try after some Time");
                return false;
            }
        }

        function getValuesTo(iBedID, idValue) {
            var currentID = document.getElementById(idValue);
            if (previousID != "") {
                previousID.checked = false;
            }
            document.getElementById('<%= hdnToBedID.ClientID %>').value = iBedID;
            previousID = currentID;
        }

        function onOk(ival) {

            if (ival == 1) {
                document.getElementById('<%= btnTransfer.ClientID %>').click();
            }
            else if (ival == 2) {

            }
        }
        function pageLoad() {
            $addHandler($get("showModalPopupClientButton"), 'click', showModalPopupViaClient);
            $addHandler($get("hideModalPopupViaClientButton"), 'click', hideModalPopupViaClient);
            $addHandler($get("showModalPopupClientButton1"), 'click', showModalPopupViaClient1);
            $addHandler($get("hideModalPopupViaClientButton1"), 'click', hideModalPopupViaClient1);
        }

        function showModalPopupViaClient(ev) {
            ev.preventDefault();
            var modalPopupBehavior = $find('programmaticModalPopupBehavior');
            modalPopupBehavior.show();
        }

        function hideModalPopupViaClient(ev) {
            ev.preventDefault();
            var modalPopupBehavior = $find('programmaticModalPopupBehavior');
            modalPopupBehavior.hide();
        }

        function showModalPopupViaClient1(ev) {
            ev.preventDefault();
            var modalPopupBehavior = $find('programmaticModalPopupBehavior1');
            modalPopupBehavior.show();
        }

        function hideModalPopupViaClient1(ev) {
            ev.preventDefault();
            var modalPopupBehavior = $find('programmaticModalPopupBehavior1');
            modalPopupBehavior.hide();
        }

        function ShowORHideDiv() {

            var sRequestedBy = document.getElementById('<%= ddlTransferRequestedBy.ClientID %>').value;
            var dDivDoctor = document.getElementById('<%= divDoctor.ClientID %>');
            var ddivAttendant = document.getElementById('<%= divAttendant.ClientID %>');

            if (sRequestedBy == "Doctor") {
                dDivDoctor.style.display = "Block";
                ddivAttendant.style.display = "None";
            }
            else {
                dDivDoctor.style.display = "None";
                ddivAttendant.style.display = "Block";
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('printInPatient');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function Labelprint() {
            var prtContent = document.getElementById('Labelprint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function AdmissionTimeCheck() {
            var AdmissionDate = document.getElementById('hdnAdmissionDate').value;
            var chooseDate = document.getElementById('txtDate').value;
            var tempAdmissionDate = AdmissionDate.split('/');
            var Rearranged_AdmissionDate = tempAdmissionDate[1] + '/' + tempAdmissionDate[0] + '/' + tempAdmissionDate[2];

            var tempchooseDate = chooseDate.split('/');
            var Rearranged_chooseDate = tempchooseDate[1] + '/' + tempchooseDate[0] + '/' + tempchooseDate[2];

            var D1 = new Date(Rearranged_AdmissionDate);
            var D2 = new Date(Rearranged_chooseDate);
            difference_in_milliseconds = D2 - D1;

            if (difference_in_milliseconds < 0) {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert("Occupying Room Date is before Patient's Admission Date!");
                    return false;
                }
            }
            else {
                return true;
            }
        }

        function Validation() {
            if (document.getElementById('<%= ddlFloor.ClientID %>').selectedIndex == 0) {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_10');
                if (userMsg != null) {
                    alert(userMsg);

                }
                else {
                    alert("Please Select a The Floor");
                }
                return false;
            }
            else if (document.getElementById('<%= ddlRoomType.ClientID %>').selectedIndex == 0) {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_11');
                if (userMsg != null) {
                    alert(userMsg);

                }
                else {
                    alert("Please Select a The Room Type");
                }
                return false;
            }
            else {
                return true;
            }

        }
    </script>

    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                            </asp:UpdateProgress>
                            <table class="w-100p">
                                <tr class="a-right">
                                    <td class="a-right">
                                        <div id="printInPatient" runat="server" style="display: none;">
                                            <uc9:IPAdmDetails ID="ucPrintIPAdmDet" runat="server" />
                                        </div>
                                        <div id="Labelprint" runat="server" style="display: none;">
                                            <uc10:ESLabelPrint ID="ESLabelPrint1" runat="server" />
                                        </div>
                                        <asp:LinkButton ID="btnRefresh1" CssClass="refrshbtn" ToolTip="Click here to refresh"
                                            runat="server" OnClick="btnRefresh1_Click" meta:resourcekey="btnRefresh1Resource1" />
                                        <asp:Label ID="lblPatientName" runat="server" Visible="False" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table style="border:1px solid #195E00;" class="w-100p rooms">
                                <tr style="top: auto;">
                                    <td class="floor v-top">
                                        <b>
                                            <asp:Label ID="Rs_Booking" Text="Booking" runat="server" meta:resourcekey="Rs_BookingResource1"></asp:Label></b>
                                    </td>
                                    <td colspan="2" style="color: Black; border-color: #B2E253">
                                        <asp:Label ID="Rs_From" Text="From" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDate" MaxLength="25" size="25" CssClass="Txtboxsmall"
                                            meta:resourcekey="txtDateResource1"></asp:TextBox>
                                        <a href="javascript:NewCal('<% =txtDate.ClientID %>','DDMMYYYY',true,12)">
                                            <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2" style="color: Black;">
                                        <asp:Label ID="Rs_Description" Text="Description" runat="server" meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDescription" runat="server" Height="42px" MaxLength="100" TextMode="MultiLine"
                                            Width="245px" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <div id="divFilters" runat="server">
                                <table id="tblLayout" style="border:1px solid #195E00;" class="w-100p rooms">
                                    <tr class="filterContent">
                                        <td class="floor v-top" rowspan="2">
                                            <b>
                                                <asp:Label ID="Rs_Filters" Text="Filters" runat="server" meta:resourcekey="Rs_FiltersResource1"></asp:Label></b>
                                        </td>
                                        <td style="color: Black;" class="style1">
                                            <asp:Label ID="Rs_Floor" Text="Floor" runat="server" meta:resourcekey="Rs_FloorResource1"></asp:Label>
                                        </td>
                                        <td class="style1">
                                            <asp:DropDownList ID="ddlFloor" Width="145px" runat="server" CssClass="ddlsmall"
                                                meta:resourcekey="ddlFloorResource1" AutoPostBack="true" OnSelectedIndexChanged="ddlFloor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="color: Black;" class="style1">
                                            <asp:Label ID="Rs_RoomType" Text="Room Type" runat="server" meta:resourcekey="Rs_RoomTypeResource1"></asp:Label>
                                        </td>
                                        <td class="style1">
                                            <asp:DropDownList ID="ddlRoomType" Width="145px" CssClass="ddlsmall" runat="server"
                                                meta:resourcekey="ddlRoomTypeResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="color: Black;" class="style1">
                                            <asp:Label ID="Rs_RoomStatus" Text="Room Status" runat="server" meta:resourcekey="Rs_RoomStatusResource1"></asp:Label>
                                        </td>
                                        <td class="style1">
                                            <asp:DropDownList ID="ddlStatus" Width="145px" runat="server" CssClass="ddlsmall"
                                                meta:resourcekey="ddlStatusResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="color: Black;" class="style1" nowrap="nowrap">
                                            <asp:Label ID="lblWard" Text="Ward Name" runat="server" meta:resourcekey="lblWardResource1"></asp:Label>
                                        </td>
                                        <td class="style1">
                                            <asp:DropDownList ID="ddlWard" Width="145px" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlWardResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr class="filterContent">
                                        <td style="color: Black;">
                                            <asp:Label ID="Rs_Patient" Text="Patient" runat="server" meta:resourcekey="Rs_PatientResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPatient" onclick="this.value='';this.readOnly=false;getElementById('hdnFilterPatientID').value='0'"
                                                onblur="this.readOnly=true;" Width="140px" runat="server" CssClass="Txtboxsmall"
                                                meta:resourcekey="txtPatientResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompletePatient" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                UseContextKey="True" MinimumPrefixLength="2" OnClientItemSelected="doOnSelectPatient"
                                                ServiceMethod="GetBedPatientName" ServicePath="~/WebService.asmx" TargetControlID="txtPatient"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td style="color: Black;">
                                            <asp:Label ID="Rs_Consultant" Text="Consultant" runat="server" meta:resourcekey="Rs_ConsultantResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtConsultant" Width="140px" onclick="this.value='';this.readOnly=false;getElementById('hdnFilterPhysicianID').value='0'"
                                                onblur="this.readOnly=true;" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtConsultantResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteConsultant" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                UseContextKey="True" MinimumPrefixLength="2" OnClientItemSelected="doOnSelectPhysician"
                                                ServiceMethod="GetConsultantName" ServicePath="~/WebService.asmx" TargetControlID="txtConsultant"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td colspan="2" class="a-center">
                                            <asp:Button ID="btnFilter" runat="server" CssClass="btn" Text="GO..." OnClick="btnFilter_Click"
                                                meta:resourcekey="btnFilterResource1" OnClientClick="javascript:return Validation();" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divFloorDetails">
                                <br />
                                <uc8:RoomDisplay ID="RoomsView" runat="server" />
                            </div>
                            <div id="hidediv" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <div style="display: none;">
                                                <asp:Button ID="btnBook" runat="server" CssClass="btn" OnClick="btnBook_Click" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="Book" meta:resourcekey="btnBookResource1" />
                                                <asp:Button ID="btnOccupy" runat="server" CssClass="btn" OnClick="btnOccupy_Click"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Occupy"
                                                    meta:resourcekey="btnOccupyResource1" />
                                                <asp:Button ID="btnTransfer" runat="server" CssClass="btn" OnClick="btnTransfer_Click"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Transfer"
                                                    meta:resourcekey="btnTransferResource1" />
                                                <asp:Button ID="btnDischarge" runat="server" CssClass="btn" OnClick="btnDischarge_Click"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Discharge"
                                                    meta:resourcekey="btnDischargeResource1" />
                                                <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click1"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                    meta:resourcekey="btnCancelResource1" />
                                                <asp:Button ID="btnSchedules" runat="server" CssClass="btn" OnClick="btnSchedules_Click1"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Schedule"
                                                    meta:resourcekey="btnSchedulesResource1" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <!-- Modal Popup Screens Area -->
                                <!-- Region For Transfer -->
                                <input type="button" id="showModalPopupClientButton1" runat="server" href="#" style="display: none;" />
                                <asp:Button ID="hiddenTargetControlForModalPopup1" runat="server" Style="display: none"
                                    meta:resourcekey="hiddenTargetControlForModalPopup1Resource1" />
                                <ajc:ModalPopupExtender ID="programmaticModalPopup1" runat="server" BackgroundCssClass="modalBackground"
                                    BehaviorID="programmaticModalPopupBehavior1" DropShadow="True" OkControlID="OkButton"
                                    OnOkScript="onOk('1')" PopupControlID="programmaticPopup1" PopupDragHandleControlID="programmaticPopupDragHandle1"
                                    RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup1"
                                    Y="35" DynamicServicePath="" Enabled="True">
                                </ajc:ModalPopupExtender>
                                <asp:Panel ID="programmaticPopup1" runat="server" CssClass="modalPopup padding10" Style="display: none;
                                    width: 725px; height: 540px;" meta:resourcekey="programmaticPopup1Resource1">
                                    <center class="v-middle">
                                        <asp:Panel ID="Panel1" runat="server" GroupingText="To Room" CssClass="v-middle" Style="width: 700px; height: 600px;" meta:resourcekey="Panel1Resource1">
                                            <table>
                                                <tr>
                                                    <td class="a-center">
                                                        <div style="width: 700px; height: 280px; overflow-y: auto; overflow-x: auto">
                                                            <asp:DataList ID="dlRoomsMaster" runat="server" RepeatColumns="6" RepeatDirection="Horizontal"
                                                                meta:resourcekey="dlRoomsMasterResource1">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <div id="dvFloor" runat="server">
                                                                        <td style="font-family: Arial; font-size: 11px; border-color: Silver; background-color: #dcfec6;
                                                                            border-style: solid; border-width: 1px; color: #000;">
                                                                            <div style="vertical-align: top;">
                                                                                <asp:Label ID="lblFloorName" runat="server" Text='<%# Eval("FloorName") %>' meta:resourcekey="lblFloorNameResource1"></asp:Label>
                                                                                :
                                                                                <asp:Label ID="lblRoomName" runat="server" Text='<%# Eval("RoomName") %>' meta:resourcekey="lblroomNameResource2"></asp:Label>
                                                                                <br />
                                                                                <asp:Label ID="lblToRoomType" Style="font-size: 10px;" runat="server" Text='<%# Eval("roomTypeName","({0})") %>'
                                                                                    meta:resourcekey="lblToRoomTypeResource1"></asp:Label>
                                                                                <br />
                                                                                <input id="chkBedID" runat="server" style="font-size: 10px; font-family: Verdana;"
                                                                                    type="radio" />
                                                                                <asp:Label ID="lblBedName" runat="server" Text='<%# Eval("BedName") %>' meta:resourcekey="lblBedNameResource1"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </div>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:DataList>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="a-center">
                                                    <td>
                                                        <table style="border-color: Gray;">
                                                            <tr>
                                                                <td class="a-left">
                                                                    <asp:Label ID="Rs_ConditionOnTransfer" Text="Condition On Transfer" runat="server"
                                                                        meta:resourcekey="Rs_ConditionOnTransferResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:DropDownList ID="ddlConditionOnTransfer" Width="155px" runat="server" meta:resourcekey="ddlConditionOnTransferResource1">
                                                                        <asp:ListItem Text="Stable" Value="Stable" meta:resourcekey="ListItemResource1" />
                                                                        <asp:ListItem Text="Relatively Stable" Value="Relatively Stable" meta:resourcekey="ListItemResource2" />
                                                                        <asp:ListItem Text="Un-Stable" Value="Un-Stable" meta:resourcekey="ListItemResource3" />
                                                                        <asp:ListItem Text="Critical" Value="Critival" meta:resourcekey="ListItemResource4" />
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td class="a-left">
                                                                    <asp:Label ID="Rs_AttendeesAccompanying1" Text="Attendees Accompanying 1" runat="server"
                                                                        meta:resourcekey="Rs_AttendeesAccompanying1Resource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtAttendees1" MaxLength="100" runat="server" meta:resourcekey="txtAttendees1Resource1"></asp:TextBox>
                                                                </td>
                                                                <td class="a-right">
                                                                    &nbsp;&nbsp;&nbsp;<asp:Label ID="Rs_PhoneNo1" Text="Phone No." runat="server" meta:resourcekey="Rs_PhoneNo1Resource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtAttendees1Phone" MaxLength="11" runat="server" meta:resourcekey="txtAttendees1PhoneResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td class="a-left">
                                                                    <asp:Label ID="Rs_AttendeesAccompanying2" Text="Attendees Accompanying 2" runat="server"
                                                                        meta:resourcekey="Rs_AttendeesAccompanying2Resource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtAttendees2" MaxLength="100" runat="server" meta:resourcekey="txtAttendees2Resource1"></asp:TextBox>
                                                                </td>
                                                                <td class="a-right">
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <asp:Label ID="Rs_PhoneNo" Text="Phone No." runat="server" meta:resourcekey="Rs_PhoneNoResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtAttendees2Phone" MaxLength="11" runat="server" meta:resourcekey="txtAttendees2PhoneResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td class="a-left">
                                                                    <asp:Label ID="Rs_TransferRequestedBy" Text="Transfer Requested By" runat="server"
                                                                        meta:resourcekey="Rs_TransferRequestedByResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:DropDownList ID="ddlTransferRequestedBy" Width="155px" runat="server" onchange="javascript:ShowORHideDiv();"
                                                                        meta:resourcekey="ddlTransferRequestedByResource1">
                                                                        <asp:ListItem Text="Doctor" Value="Doctor" meta:resourcekey="ListItemResource5" />
                                                                        <asp:ListItem Text="Patient/Family" Value="Patient/Family" meta:resourcekey="ListItemResource6" />
                                                                        <asp:ListItem Text="Attendant" Value="Attendant" meta:resourcekey="ListItemResource7" />
                                                                    </asp:DropDownList>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <span id="divDoctor" runat="server" style="display: Block;">
                                                                        <asp:DropDownList ID="ddlPhysician" Width="155px" runat="server" meta:resourcekey="ddlPhysicianResource1">
                                                                        </asp:DropDownList>
                                                                    </span><span id="divAttendant" runat="server" style="display: none;">
                                                                        <asp:TextBox ID="txtAttendant" MaxLength="100" runat="server" meta:resourcekey="txtAttendantResource1" />
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td class="a-left">
                                                                    <asp:Label ID="Rs_ReasonForTransfer" Text="Reason For Transfer" runat="server" meta:resourcekey="Rs_ReasonForTransferResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="3" class="a-left">
                                                                    <asp:TextBox ID="txtReasonForTransfer" TextMode="MultiLine" Height="50px" MaxLength="100"
                                                                        runat="server" meta:resourcekey="txtReasonForTransferResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-center">
                                                                <td class="a-left">
                                                                    <asp:CheckBox ID="chkRetainExistingRoom" Text="Retain Existing Room" runat="server"
                                                                        meta:resourcekey="chkRetainExistingRoomResource1" />
                                                                </td>
                                                                <td class="a-left" colspan="3">
                                                                    <input type="button" value="OK" style="width: 35px" id="OkButton" runat="server"
                                                                        class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                                                                    <!-- OK</a>  -->
                                                                    <input type="button" value="Close" id="hideModalPopupViaClientButton1" runat="server"
                                                                        class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                                                                    <!-- Close</a>-->
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </center>
                                </asp:Panel>
                                <!-- Endregion -->
                                <!-- Region For Availability Check -->
                                <a id="showModalPopupClientButton" runat="server" href="#" style="display: none;" />
                                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                    meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                <ajc:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                                    BehaviorID="programmaticModalPopupBehavior" DropShadow="True" OkControlID="A1"
                                    OnOkScript="onOk('2')" PopupControlID="programmaticPopup" PopupDragHandleControlID="programmaticPopupDragHandle"
                                    RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup"
                                    X="25" Y="200" DynamicServicePath="" Enabled="True">
                                </ajc:ModalPopupExtender>
                                <asp:Panel ID="programmaticPopup" runat="server" CssClass="modalPopup" Style="display: none;
                                    padding: 10px" meta:resourcekey="programmaticPopupResource1">
                                    <asp:Panel ID="programmaticPopupDragHandle" runat="server" meta:resourcekey="programmaticPopupDragHandleResource1">
                                        <asp:Label ID="Rs_OperationTheatreStatus" Text="Operation Theatre Status" runat="server"
                                            meta:resourcekey="Rs_OperationTheatreStatusResource1"></asp:Label></asp:Panel>
                                    <div id="dvTable" runat="server">
                                    </div>
                                    <a id="A1" runat="server" class="borderstyle" href="#" style="color: Red;">
                                        <asp:Label ID="Rs_OK" Text="OK" runat="server" meta:resourcekey="Rs_OKResource1"></asp:Label></a>
                                    <a id="hideModalPopupViaClientButton" runat="server" href="#" style="color: Red;
                                        display: none;">
                                        <asp:Label ID="Rs_Close" Text="Close" runat="server" meta:resourcekey="Rs_CloseResource1"></asp:Label></a>
                                    .
                                    <br />
                                </asp:Panel>
                                <!-- End Section -->
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td colspan="2" class="a-center">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnDummy1"
                                CancelControlID="btnClose" DynamicServicePath="" Enabled="True" PopupControlID="InvPanel"
                                BackgroundCssClass="modalBackground">
                            </ajc:ModalPopupExtender>
                            <asp:Panel ID="InvPanel" runat="server" Width="950px" Height="500px" ScrollBars="Vertical"
                                Style="display: block" CssClass="modalPopup dataheaderPopup" meta:resourcekey="InvPanelResource1">
                                <table class="dataheader2" width="100%" style="font-family: verdana; font-weight: bold"
                                    cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblName" Text="Name : " runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                            <asp:Label ID="lblNameValue" runat="server" meta:resourcekey="lblNameValueResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAgeOrSex" Text="Age/Sex : " runat="server" meta:resourcekey="lblAgeOrSexResource1"></asp:Label>
                                            <asp:Label ID="lblAgeOrSexValue" runat="server" meta:resourcekey="lblAgeOrSexValueResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPno" Text="Patient Number : " runat="server" meta:resourcekey="lblPnoResource1"></asp:Label>
                                            <asp:Label ID="lblPnovalue" runat="server" meta:resourcekey="lblPnovalueResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAddress" Text="Address : " runat="server" meta:resourcekey="lblAddressResource1"></asp:Label>
                                            <asp:Label ID="lbladdressvalue" runat="server" meta:resourcekey="lbladdressvalueResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblContactNumber" Text="Contact Number : " runat="server" meta:resourcekey="lblContactNumberResource1"></asp:Label>
                                            <asp:Label ID="lblcontactNovalue" runat="server" meta:resourcekey="lblcontactNovalueResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdTreatementPlan" runat="server" AutoGenerateColumns="False" DataKeyNames="TreatmentplanID"
                                                headerText="Plan Surgery " CssClass="filterdataheader2 gridView" OnRowDataBound="grdTreatementPlan_RowDataBound"
                                                meta:resourcekey="grdTreatementPlanResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="SelectPlan"
                                                                meta:resourcekey="rdSelResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Treatment Plan Name" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbltreatmentplanname" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'
                                                                meta:resourcekey="lbltreatmentplannameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="TreatmentPlanDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Treatment Plan Date"
                                                        meta:resourcekey="BoundFieldResource1" />
                                                    <asp:TemplateField HeaderText="Prosthesis" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProsthesis" runat="server" Text='<%# Bind("Prosthesis") %>' meta:resourcekey="lblProsthesisResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Room Name" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblroomName" runat="server" Text='<%# Bind("RoomName") %>' meta:resourcekey="lblroomNameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Provisional" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProvisonal" runat="server" Text='<%# Bind("IsProvisional") %>'
                                                                meta:resourcekey="lblProvisonalResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Surgeon Name" meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSurgeonNmae" runat="server" Text='<%# Bind("SurgeonName") %>' meta:resourcekey="lblSurgeonNmaeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Anesthesist Name" meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAnesthesiastname" runat="server" Text='<%# Bind("AnesthesiastName") %>'
                                                                meta:resourcekey="lblAnesthesiastnameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-90p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" Text="From Date :" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" CssClass="Txtboxsmall" EnableViewState="False" ID="txtFrom"
                                                            MaxLength="25" size="20" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                        <img onclick="return SetFromDate()" style="cursor: hand;" id="img1" src="../Images/Calendar_scheduleHS.png"
                                                            width="16" height="16" border="0" alt="Pick a date" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_To" Text="To Date :" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" CssClass="Txtboxsmall" EnableViewState="False" ID="txtTo"
                                                            MaxLength="25" size="20" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        <img onclick="return SetToDate()" style="cursor: hand;" id="img2" src="../Images/Calendar_scheduleHS.png"
                                                            width="16" height="16" border="0" alt="Pick a date" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="4" class="a-center">
                                            <asp:Button ID="btnOk" runat="server" Text="GO" onfocus="return ValidateBooking()"
                                                OnClientClick="SetStatus();" OnClick="btnBook_Click" CssClass="btn" Width="34px"
                                                meta:resourcekey="btnOkResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="a-center">
                                            <br />
                                            <asp:Label ID="lblBookedHistory" runat="server" Font-Bold="True" Font-Underline="True"
                                                Text="Booked History" meta:resourcekey="lblBookedHistoryResource1"></asp:Label>
                                            <br />
                                            <br />
                                            <asp:GridView ID="grdBookingDetails" runat="server" AutoGenerateColumns="False" CssClass="filterdataheader2 w-100p gridView"
                                                EmptyDataText="No Results Found." OnRowDataBound="grdBookingDetails_RowDataBound"
                                                OnRowCommand="grdBookingDetails_RowCommand" meta:resourcekey="grdBookingDetailsResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdosel" runat="server" GroupName="BedSelect" meta:resourcekey="rdoselResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientID" HeaderText="Patient ID" Visible="False" meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="FromDate" HeaderText="FromDate" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="ToDate" HeaderText="ToDate" meta:resourcekey="BoundFieldResource5" />
                                                    <asp:TemplateField HeaderText="Bed ID" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBedID" runat="server" Text='<%# Eval("BedID") %>' meta:resourcekey="lblBedIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Occupy" meta:resourcekey="TemplateFieldResource9">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnOccupy" CssClass="btn" CommandName="Occupy" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                runat="server" Text="Occupy" meta:resourcekey="btnOccupyResource2" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Book\Vacate" meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnVacate" runat="server" CommandName="Vacate" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CssClass="btn" Text="Vacate" meta:resourcekey="btnVacateResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Cancel" meta:resourcekey="TemplateFieldResource11">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CssClass="btn" Text="Cancel" meta:resourcekey="btnCancelResource2" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource12">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblStatuse" runat="server" Text='<%# Eval("RoomStatus") %>' meta:resourcekey="lblStatuseResource1"></asp:Label>
                                                            <asp:HiddenField ID="hdnBookingID" runat="server" Value='<%# Eval("BookingID") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource13">
                                                        <ItemTemplate>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5">
                                            <div id="AvilableBeds" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="a-center">
                                            <asp:Button ID="btnClose" runat="server" Text="Close" meta:resourcekey="btnCloseResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <div id="popuup_div" class="popup_msg">
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%-- </ContentTemplate>
  </asp:UpdatePanel>--%>
    <asp:HiddenField ID="hdnFromPatientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToBedID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFromBedID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnBookingID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTransfer" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFromPatientName" runat="server" />
    <asp:HiddenField ID="hdnFromVisitID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFilterPhysicianID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFilterPatientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnAdmissionDate" runat="server" Value="0" />
    <asp:HiddenField ID="hdnChoseDateTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCurrentPatientBookedStatus" runat="server" />
    <asp:HiddenField ID="hdnIsCreditBill" runat="server" Value="N" />
    <asp:HiddenField ID="hdnIsOkClicked" runat="server" Value="N" />
    <asp:HiddenField ID="hdnBedAvail" runat="server" />
    <asp:HiddenField ID="hdnCrossBook" runat="server" Value="N" />
    <asp:HiddenField ID="hdnIPTreatmentPlanID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsSlotBooking" runat="server" Value="N" />
    </form>
    <style type="text/css">
        .popup_msg
        {
            position: absolute;
            z-index: 10;
            font: 10px Verdana, Arial, Helvetica, sans-serif;
            background-color: #ffffee;
            border-style: double;
            border-color: #B2E253;
            display: none;
        }
        .style1
        {
            height: 26px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        // background:url(bg_image.gif) bottom right no-repeat;
        //width: 200px;border-color: #FF0000;
        //        tr.filterContent
        //        {
        //            display: none;
        //        }
        function showPopUp(obj, objConsultant, objPatientInfo) {

            var height = $('#popuup_div').height();
            var width = $('#popuup_div').width();

            leftVal = $('#' + obj).offset().left - (width / 2 - 50) + "px";
            topVal = $('#' + obj).offset().top - (height) + "px";

            var arrConsultant = $('#' + objConsultant).val().split('^');
            var arrPatient = $('#' + objPatientInfo).val().split('^');

            var strHtml = "<table align='left'>";

            for (var j = 0; j < arrConsultant.length; j++) {
                if (arrConsultant[j] != "") {
                    if (j == 0) {
                        strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_Physician %>" + "</td><td>:</td><td>" + arrConsultant[j].split('~')[1] + "</td></tr>";
                    } else {
                        strHtml += "<tr><td></td><td></td><td>" + arrConsultant[j].split('~')[1] + "</td></tr>";
                    }
                }
            }

            if (arrPatient[1] == "") {
                arrPatient[1] = "N/A";
            }
            if (arrPatient[2] == "") {
                arrPatient[2] = "N/A";
            }
            if (arrPatient[3] == "") {
                arrPatient[3] = "N/A";
            }
            if (arrPatient[4] == "") {
                arrPatient[4] = "N/A";
            }

            strHtml += "<tr style='bacground-color:#fcf2c3'><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_AdmissionPurpose %>" + "</td><td>:</td><td>" + arrPatient[1] + "</td></tr>";

            var flag = false;
            var arrTreatMent = arrPatient[2].split('|');

            for (var i = 0; i < arrTreatMent.length; i++) {
                if (arrTreatMent[i] != "") {
                    if (i == 0) {
                        strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_SurgeryProcedure %>" + "</td><td>:</td><td>" + arrTreatMent[i] + "</td></tr>";
                    } else {
                        if (arrTreatMent[0] == "") {
                            strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_SurgeryProcedure_1 %>" + "</td><td></td><td>" + arrTreatMent[i] + "</td></tr>";
                        } else {
                            strHtml += "<tr><td></td><td></td><td>" + arrTreatMent[i] + "</td></tr>";
                        }
                    }
                    flag = true;
                }
            }
            if (!flag) {
                strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_Complaints_1 %>" + "</td><td>:</td><td>N/A</td></tr>";
            }

            //strHtml += "<tr style='bacground-color:#fcf2c3'><td>Status</td><td>:</td><td>" + arrPatient[3] + "</td></tr>";
            //strHtml += "<tr><td>StagePlanned</td><td>:</td><td>" + arrPatient[4] + "</td></tr>";
            flag = false;
            var star = true;
            var arrComp = arrPatient[0].split('~');

            for (var i = 0; i < arrComp.length; i++) {
                if (arrComp[i] != "") {
                    if (i == 0) {
                        strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_Complaints_2 %>" + "</td><td>:</td><td>" + arrComp[i] + "</td></tr>";
                    } else {
                        if (arrComp[0] == "" && star) {
                            strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_Complaints_3 %>" + "</td><td>:</td><td>" + arrComp[i] + "</td></tr>";
                            star = false;
                        }
                        else {
                            strHtml += "<tr><td></td><td></td><td>" + arrComp[i] + "</td></tr>";
                        }
                    }
                    flag = true;
                }
            }
            if (!flag) {
                strHtml += "<tr><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_Complaints_4 %>" + "</td><td>:</td><td>N/A</td></tr>";
            }
            strHtml += "</table>";

            $('#popuup_div').html(strHtml);
            $('#popuup_div').css({ left: leftVal, top: topVal }).fadeIn(500);
        }

        function closePopUp(obj) {
            $('#popuup_div').fadeOut(500);
        }

        function doOnSelectPhysician(source, eventArgs) {
            //alert(eventArgs.get_text() + "=>" + eventArgs.get_value());
            document.getElementById('<%= hdnFilterPhysicianID.ClientID %>').value = eventArgs.get_value();
        }
        function doOnSelectPatient(source, eventArgs) {
            document.getElementById('<%= hdnFilterPatientID.ClientID %>').value = eventArgs.get_value();
        }

        $(document).ready(function() {
            $("#tdOpen").click(function() {
                $(".filterContent").slideToggle("slow");
            });
        });

        function SetStatus() {
            document.getElementById('hdnIsOkClicked').value = 'Y';
        }

        function SetFromDate() {
            NewCal('<%=txtFrom.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
        function SetToDate() {
            NewCal('<%=txtTo.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
        var alertcount = 0;
        function ValidateBooking() {
            if (document.getElementById('<%= txtFrom.ClientID %>').value == '') {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert("Kindly Choose FromDate And Time For Room Booking !");
                    return false;
                }
            }
            if (document.getElementById('<%= txtTo.ClientID %>').value == '') {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert("Kindly Choose ToDate And Time For Room Booking !");
                    return false;
                }
            }
            var BookFromDate = document.getElementById('<%= txtFrom.ClientID %>').value;
            var BookToDate = document.getElementById('<%= txtTo.ClientID %>').value;
            var D1 = new Date(BookFromDate);
            var D2 = new Date(BookToDate);
            var today = new Date();
            var tempBookFromDate = BookFromDate.split('/');
            var Rearranged_Fromdate = tempBookFromDate[1] + '/' + tempBookFromDate[0] + '/' + tempBookFromDate[2];
            var Rearranged_D1 = new Date(Rearranged_Fromdate);
            var CurMinitue = today.getMinutes();
            difference_in_minitue = today - Rearranged_D1;
            difference_in_milliseconds = D2 - D1;
            if (difference_in_minitue > 60000) {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert("Kindly Choose Future Date And Time For Room Booking !");
                    return false;
                }
            }

            if (difference_in_milliseconds < 0) {
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert("From Date And To Date Mismatch !");
                    return false;
                }
            }
            var OrgID = '<%= OrgID%>';
            var ILocationID = '<%= ILocationID%>';
            var BedID = document.getElementById('<%= hdnFromBedID.ClientID %>').value;
            var FromDate = document.getElementById('<%= txtFrom.ClientID %>').value;
            var ToDate = document.getElementById('<%= txtTo.ClientID %>').value;
            WebService.loadBedBookedDetail(OrgID, ILocationID, BedID, FromDate, ToDate, lstBedBookingDetail);
        }
        function lstBedBookingDetail(tmpVal) {
            if (tmpVal.length > 0) {
                document.getElementById('hdnCrossBook').value = 'Y';
            }
            else {
                document.getElementById('hdnCrossBook').value = 'N';
            }
            if (document.getElementById('hdnCrossBook').value == 'Y') {
                document.getElementById('<%= txtFrom.ClientID %>').focus();
                ShowAvailbeds();
                userMsg = SListForApplicationMessages.Get('InPatient\\RoomBooking.aspx_8');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('This Bed is already booked for this time. Kindly choose a different time or any other OT');
                    return false;
                }
            }
            else {
            }
        }
        function ShowAvailbeds() {
            var OrgID = '<%= OrgID%>';
            var ILocationID = '<%= ILocationID%>';

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetAvailableBedsByTime",
                data: "{ 'orgID': '" + OrgID + "','ILocationID': '" + ILocationID + "','FromDate': '" + document.getElementById('<%= txtFrom.ClientID %>').value + "','ToDate': '" + document.getElementById('<%= txtTo.ClientID %>').value + "','BedID': '" + document.getElementById('<%= hdnFromBedID.ClientID %>').value + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    $("#AvilableBeds").html('');

                    var data = msg.d;
                    //alert(data.length);
                    var t;
                    t = "<table border=1 style = 'border: solid 1px white; width: 100%; border-color: #195E00;'> <tr class='dataheader1'><th align='center' colspan='4'>Available Beds Between " + document.getElementById('<%= txtFrom.ClientID %>').value + " And " + document.getElementById('<%= txtTo.ClientID %>').value + "</th></tr>";

                    if (data.length > 0) {
                        t = t + "<tr class='dataheader1'><td> <strong>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_FloorName %>" + "</strong></td><td><strong>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_RoomName %>" + "</strong></td><td><strong>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_BedName %>" + "</strong></td><td><strong>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_RoomType %>" + "</strong></td></tr> ";
                        jQuery.each(data, function(rec) {
                            t = t + " <tr> <td> " + this.FloorName + "</td> <td> " + this.RoomName + "</td> <td>" + this.BedName + "</td><td>" + this.RoomTypeName + "</td></tr>";
                        });
                    }
                    else {
                        t += "<tr class='dataheader1'><td>" + "<%=Resources.ClientSideDisplayTexts.Reception_RoomBooking_NoBedAvailableAtThatTime %>" + "</td></tr>";
                    }
                    t = t + " </table> ";

                    document.getElementById('jsonDiv').style.display = "block";
                    $("#AvilableBeds").html(t);
                },
                error: function(msg) {

                }

            });
        };
    </script>

</body>
</html>
