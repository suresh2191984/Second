
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModalitySchedule.aspx.cs"
    Inherits="Modality_Schedule" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="PhysicainSchedule" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Schedule</title>

    <script language="javascript" type="text/javascript">
        function ValidateSchedule() {
            var objPlzSelect = SListForAppMsg.Get("Admin_ModalitySchedule_aspx_01") == null ? "Please Select modality name" : SListForAppMsg.Get("Admin_ModalitySchedule_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_ModalitySchedule_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ModalitySchedule_aspx_Alert");
            var objValid = SListForAppMsg.Get("Admin_ModalitySchedule_aspx_02") == null ? "Choose a valid date" : SListForAppMsg.Get("Admin_ModalitySchedule_aspx_02");

            if (document.getElementById('ddlModalityName').value == "Select") {
                var userMsg = SListForApplicationMessages.Get('Admin\\ModalitySchedule.aspx_1');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('ddlModalityName').focus();
                    return false;
                } else {
                // alert('Please Select modality name');
                ValidationWindow(objPlzSelect, objAlert);

                    document.getElementById('ddlModalityName').focus();
                    return false;
                }
            }

            if (document.getElementById('tDOB').value == "") {
                var userMsg = SListForApplicationMessages.Get('Admin\\ModalitySchedule.aspx_2');
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('tDOB').focus();
                    return false;
                } else {
                //alert('Choose a valid date');
                ValidationWindow(objValid, objAlert);
                    document.getElementById('tDOB').focus();
                    return false;
                }
            }

            //            if (document.getElementById('ddlFrom').value != "") {

            //                var d1 = document.getElementById('ddlFrom').value;
            //                var d2 = document.getElementById('ddlTo').value;
            //                var d11 = new Date(Date.parse(d1));
            //                var d21 = new Date(Date.parse(d2));
            //                if (d11.getTime()>= d21.getTime()) {

            //                    var userMsg = SListForApplicationMessages.Get('Admin\\ModalitySchedule.aspx_3');
            //                    if (userMsg != null) {
            //                        alert(userMsg);
            //                        document.getElementById('ddlTo').focus();
            //                        return false;
            //                    } else {
            //                        alert('Please select the EndTime greater than StartTime:');
            //                        document.getElementById('ddlTo').focus();
            //                        return false;
            //                    }
            //                }
            //            }
            return true;


            //            if (document.form1.ddlModalityName.value == "Select") {
            //                alert('Select modality name');
            //                document.form1.ddlModalityName.focus();
            //                return false;
            //            }
            //            else if (document.form1.tDOB.value == "") {
            //                alert('Choose a valid date');
            //                document.form1.tDOB.focus();
            //                return false;
            //            }

        }
    </script>

    <style type="text/css">
        .style2
        {
            width: 5%;
            height: 20px;
        }
        .style3
        {
            width: 15%;
            height: 20px;
        }
        .style4
        {
            height: 20px;
        }
    </style>

</head>
<body onload="onComboFocus('ddlModalityName');">
    <form id="form1" runat="server" defaultbutton="btnSave">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="dataheader2">
                                    <table class="w-100p searchPanel">
                                        <tr>
                                            <td class="a-left style2">
                                                &nbsp;
                                            </td>
                                            <td class="a-left style3">
                                                <asp:Label runat="server" ID="lblDoctor" Text="Modality Name" meta:resourcekey="lblDoctorResource1"></asp:Label>
                                            </td>
                                            <td colspan="4" class="style4 a-left">
                                                <asp:DropDownList runat="server" ID="ddlModalityName" TabIndex="1"   CssClass ="ddlsmall"
                                                    OnSelectedIndexChanged="ddlModalityName_SelectedIndexChanged" AutoPostBack="True"
                                                    meta:resourcekey="ddlModalityNameResource1">
                                                    <asp:ListItem Text="Select" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                &nbsp;
                                            </td>
                                            <td class="a-left h-35">
                                                <asp:Label runat="server" ID="Label1" Text="Start Date" meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td colspan="4">
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                    Enabled="True" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                    PopupButtonID="ImgBntCalc" Enabled="True" />
                                                <asp:TextBox ID="tDOB" runat="server" Width="130px" TabIndex="2" MaxLength="1" Style="text-align: justify"
                                                 CssClass ="Txtboxsmall"    ValidationGroup="MKE" meta:resourcekey="tDOBResource1" />
                                                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left w-5p h-30">
                                                &nbsp;
                                            </td>
                                            <td class="a-left w-15p">
                                                <asp:Label runat="server" ID="lblTiming" Text="Timing" meta:resourcekey="lblTimingResource1"></asp:Label>
                                            </td>
                                            <td class="a-left w-4p">
                                                <asp:Label runat="server" ID="lblFrm" Text="From" meta:resourcekey="lblFrmResource1"></asp:Label>
                                            </td>
                                            <td class="a-left w-12p">
                                                <asp:DropDownList runat="server" ID="ddlFrom" TabIndex="3" CssClass ="ddlsmall"
                                                    OnSelectedIndexChanged="ddlFrom_SelectedIndexChanged" meta:resourcekey="ddlFromResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-left w-3p">
                                                <asp:Label runat="server" ID="lblTo" Text="To" meta:resourcekey="lblToResource1"></asp:Label>
                                            </td>
                                            <td class="a-left w-61p">
                                                <asp:DropDownList runat="server" ID="ddlTo" TabIndex="4"  CssClass ="ddlsmall"
                                                    meta:resourcekey="ddlToResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td class="h-35">
                                                <label>
                                                    <asp:Label ID="Rs_Duration" Text="Duration" runat="server" meta:resourcekey="Rs_DurationResource1"></asp:Label></label>
                                            </td>
                                            <td colspan="4">
                                                <asp:DropDownList runat="server" ID="ddlDuration" TabIndex="5"  CssClass ="ddl"
                                                    meta:resourcekey="ddlDurationResource1">
                                                    <asp:ListItem meta:resourcekey="ListItemResource2">5</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource3">10</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource4">15</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource5">20</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource6">25</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource7">30</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource8">45</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource9">60</asp:ListItem>
                                                </asp:DropDownList>
                                                <label class="defaultfontcolor">
                                                    <asp:Label ID="Rs_mins" Text="mins" runat="server" meta:resourcekey="Rs_minsResource1"></asp:Label></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                &nbsp;
                                            </td>
                                            <td class="a-left h-35">
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblRepeat" Text="Repeats" meta:resourcekey="lblRepeatResource1"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                               <asp:DropDownList runat="server" ID="ddlRepeat" TabIndex="6" CssClass ="ddlsmall" 
                                                     meta:resourcekey="ddlRepeatResource1" >
                                                </asp:DropDownList>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_BranchLocation" Text="Branch/Location" runat="server" meta:resourcekey="Rs_BranchLocationResource1"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlOrgLocation" CssClass ="ddlmedium" runat="server" meta:resourcekey="ddlOrgLocationResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td><asp:Label runat="server" ID="lblmindate" 
                                                    meta:resourcekey="lblmindateResource1"   ></asp:Label>
                                                <asp:Label runat="server" ID="lblmaxdate" 
                                                    meta:resourcekey="lblmaxdateResource1"   ></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td colspan="4">
                                                <div id="dRepeat" style="display: none" class="scheduledataheader2">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td colspan="2">
                                                                <div id="dWords" style="display: none">
                                                                    <table>
                                                                        <tr>
                                                                            <td class="blackfontcolormedium h-25">
                                                                                <asp:Label runat="server" ID="lblRepeatWords" meta:resourcekey="lblRepeatWordsResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-8p">
                                                                <asp:Label runat="server" ID="lblMonths" Text="Repeat every:" meta:resourcekey="lblMonthsResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:DropDownList runat="server" ID="ddlMonths" CssClass="dropdownbutton" onchange="loadText();"
                                                                    meta:resourcekey="ddlMonthsResource1">
                                                                </asp:DropDownList>
                                                                <label id="lblMW">
                                                                    <asp:Label ID="Rs_months" Text="months" runat="server" meta:resourcekey="Rs_monthsResource1"></asp:Label></label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div id="dMonthly" style="display: none">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="Label5" Text="Repeat By:" meta:resourcekey="Label5Resource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:RadioButtonList runat="server" CssClass="radiobutton" ID="rdrptBy" RepeatDirection="Horizontal"
                                                                                    onclick="loadText();" meta:resourcekey="rdrptByResource1">
                                                                                    <asp:ListItem meta:resourcekey="ListItemResource14">day of the month</asp:ListItem>
                                                                                    <asp:ListItem meta:resourcekey="ListItemResource15">day of the week</asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div id="dWeekly" style="display: none">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="Label6" Text="Repeat On:" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:CheckBoxList runat="server" ID="chkDays" RepeatDirection="Horizontal" CssClass="radiobutton"
                                                                                    onclick="loadText();" meta:resourcekey="chkDaysResource1">
                                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource16">Sun</asp:ListItem>
                                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource17">Mon</asp:ListItem>
                                                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource18">Tue</asp:ListItem>
                                                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource19">Wed</asp:ListItem>
                                                                                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource20">Thu</asp:ListItem>
                                                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource21">Fri</asp:ListItem>
                                                                                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource22">Sat</asp:ListItem>
                                                                                </asp:CheckBoxList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
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
                                            <td>
                                                <asp:HiddenField runat="server" ID="weekNo" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" Text="Save" TabIndex="7" CssClass="btn1"
                                                    OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                            </td>
                                            <td colspan="3">
                                                <asp:Button ID="btnChange" runat="server" CssClass="btn1" OnClick="lnkChange_Click"
                                                    TabIndex="8" Text="Reset" meta:resourcekey="btnChangeResource1" />
                                                <%--<asp:LinkButton ID="lnkChange" runat="server" onclick="lnkChange_Click">Change</asp:LinkButton>--%>&nbsp;<asp:Button
                                                    ID="btnCancel" runat="server" Text="Cancel" TabIndex="8" CssClass="btn1" OnClick="btnCancel_Click"
                                                    meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="dataheader2" align="center">
                                    <uc8:PhysicainSchedule ID="phyBooked" runat="server" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    <asp:HiddenField ID="hdnSTID" runat="server" />
    <asp:HiddenField ID="hdnRTID" runat="server" />
    <asp:HiddenField ID="hdnResourceID" runat="server" />
    <asp:HiddenField ID="hdnRecurrenceID" runat="server" />
    <asp:HiddenField ID="hdnPRCylID" runat="server" />
    <asp:HiddenField ID="hdnRCylID" runat="server" />

    <script language="javascript" type="text/javascript">
        function SelectedDatas(stid, rtid, hrecid, hprcid, hrcid, ifrom, ito,
                                iduration, yearly, monthly, weekly, monthyear, dfmonth,
                                dfweek, sun, mon, tue, wed, thur, fri, sat) {

            document.getElementById('<%= ddlFrom.ClientID %>').value = ifrom;
            document.getElementById('<%= ddlTo.ClientID %>').value = ito;
            document.getElementById('<%= ddlDuration.ClientID %>').value = iduration;


            document.getElementById('<%= hdnSTID.ClientID %>').value = stid;
            document.getElementById('<%= hdnRTID.ClientID %>').value = rtid;
            document.getElementById('<%= hdnRecurrenceID.ClientID %>').value = hrecid;
            document.getElementById('<%= hdnPRCylID.ClientID %>').value = hprcid;
            document.getElementById('<%= hdnRCylID.ClientID %>').value = hrcid;

            var d = new Date();
            var curr_year = d.getFullYear();
            var curr_Month = d.getMonth();
            var curr_date = d.getDate();

            if (yearly != "0") {
                document.getElementById('<%= ddlRepeat.ClientID %>').value = "Yearly";
                document.getElementById('<%= tDOB.ClientID %>').value = monthyear + "/" + curr_year;
                document.getElementById('<%= ddlMonths.ClientID %>').value = yearly;
            }
            else if (monthly != "0") {
                document.getElementById('<%= ddlRepeat.ClientID %>').value = "Monthly";
                document.getElementById('<%= ddlMonths.ClientID %>').value = monthly;
                if (dfmonth != "0") {
                    document.getElementById('rdrptBy_0').checked = true;
                }
                else {
                    document.getElementById('rdrptBy_0').checked = false;
                }
                if (dfweek != "0") {
                    document.getElementById('rdrptBy_1').checked = true;
                }
                else {
                    document.getElementById('rdrptBy_1').checked = false;
                }
            }
            else if (weekly != "0") {
                document.getElementById('<%= ddlRepeat.ClientID %>').value = "Weekly";
                document.getElementById('<%= ddlMonths.ClientID %>').value = weekly;
                if (sun == "Y") {
                    document.getElementById('chkDays_0').checked = true;
                }
                else {
                    document.getElementById('chkDays_0').checked = false;
                }

                if (mon == "Y") {
                    document.getElementById('chkDays_1').checked = true;
                }
                else {
                    document.getElementById('chkDays_1').checked = false;
                }

                if (tue == "Y") {
                    document.getElementById('chkDays_2').checked = true;
                }
                else {
                    document.getElementById('chkDays_2').checked = false;
                }

                if (wed == "Y") {
                    document.getElementById('chkDays_3').checked = true;
                }
                else {
                    document.getElementById('chkDays_3').checked = false;
                }

                if (thur == "Y") {
                    document.getElementById('chkDays_4').checked = true;
                }
                else {
                    document.getElementById('chkDays_4').checked = false;
                }

                if (fri == "Y") {
                    document.getElementById('chkDays_5').checked = true;
                }
                else {
                    document.getElementById('chkDays_5').checked = false;
                }

                if (sat == "Y") {
                    document.getElementById('chkDays_6').checked = true;
                }
                else {
                    document.getElementById('chkDays_6').checked = false;
                }
            }
            else {
                document.getElementById('<%= ddlRepeat.ClientID %>').value = "Does not repeat";
            }
            loadMonths();
            loadText();
        }


        function WPM(y, m) {
            var DoM, DoW, Thu;
            with (new Date(y, m, 13)) {
                DoM = getDate();
                DoW = getDay();
            }
            Thu = DoM - (DoW + 3) % 7;
            return ((Thu + 6) / 7) | 0;
        }
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
