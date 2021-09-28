<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangeDocSchedule.aspx.cs"
    Inherits="Admin_ChangeDocSchedule" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UCDate.ascx" TagName="UCDate" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhyAllSchedules.ascx" TagName="ucBookedScvhedule"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Schedule</title>

    <script language="javascript" type="text/javascript">
        function ValidateSchedule() {
            var objAlert = SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_Alert");
            var objChoose = SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_01") == null ? "Choose a valid date" : SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_01");

            if (document.form1.tDOB.value == "") {
             var userMsg = SListForApplicationMessages.Get("Admin\\ChangeDocSchedule.aspx_1");
             if (userMsg != null) {
                 //                 alert(userMsg);
                 ValidationWindow(userMsg, objAlert);


                 return false;
             }
             else {
                 // alert('Choose a valid date');
                 ValidationWindow(objChoose, objAlert);

                 return false;
             }
                return false;
            }
            return true;
        }
    </script>

</head>
<body onload="onComboFocus('ddlDrName');">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript">
        function ChangeFrom(RTID, SID, PhNAME, sFrmTime, sToTime, sSPTY, sSlot) {

            document.getElementById('<%=txtOriginalDate.ClientID %>').value = sSlot;
            document.getElementById('<%=txtPhyName.ClientID %>').value = PhNAME;
            document.getElementById('<%=txtSchTime.ClientID %>').value = formatTime(sFrmTime) + '-' + formatTime(sToTime);
            document.getElementById('<%=txtPhySpeciality.ClientID %>').value = sSPTY;
            document.getElementById('<%=hdnRtid.ClientID %>').value = RTID;
            document.getElementById('<%=hdnSID.ClientID %>').value = SID;

            document.getElementById('<%= showModalPopupClientButton1.ClientID %>').click();
        }

        function pageLoad() {
            $addHandler($get("showModalPopupClientButton1"), 'click', showModalPopupViaClient1);
            $addHandler($get("hideModalPopupViaClientButton1"), 'click', hideModalPopupViaClient1);
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
        function onOk(ival) {
            if (ival == 1) {
                var ret = ValidateSchedule();
                if (ret == true) {
                    document.getElementById('<%= btnModify.ClientID %>').click();
                }
                else {
                    document.getElementById('<%= showModalPopupClientButton1.ClientID %>').click();
                }
            }
        }

        function DeleteFrom(RTID, SID, PhNAME, sFrmTime, sToTime, sSPTY, sSlot) {
            document.getElementById('<%=txtOriginalDate.ClientID %>').value = sSlot;
            document.getElementById('<%=txtPhyName.ClientID %>').value = PhNAME;
            document.getElementById('<%=txtSchTime.ClientID %>').value = formatTime(sFrmTime) + '-' + formatTime(sToTime);
            document.getElementById('<%=txtPhySpeciality.ClientID %>').value = sSPTY;
            document.getElementById('<%=hdnRtid.ClientID %>').value = RTID;
            document.getElementById('<%=hdnSID.ClientID %>').value = SID;
            var i;
            var userMsg = SListForApplicationMessages.Get("Admin\\ChangeDocSchedule.aspx_2");
            if (userMsg != null) {
                i=confirm(userMsg);
            }
            else {

                var objSchedule = SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_02") == null ? "Are you sure you wish to delete the Schedule?" : SListForAppMsg.Get("Admin_ChangeDocSchedule_aspx_02");

                i = confirm(objSchedule);
            }

            //var i = confirm("Are you sure you wish to delete the Schedule?");
            if (i == true) {
                document.getElementById('<%= btnDelete.ClientID %>').click();
            }
        }
    </script>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="a-right h-35">
                                            <asp:Label ID="Rs_DoctorName" Text="Doctor Name" runat="server" meta:resourcekey="Rs_DoctorNameResource1"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:DropDownList ID="ddlDrName" runat="server" CssClass="ddlsmall" TabIndex="1"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddlDrName_SelectedIndexChanged" 
                                                Height="16px">
                                                <%--<asp:ListItem Text="Select" meta:resourcekey="ListItemResource1"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <uc8:ucBookedScvhedule ID="ucBookedSchedules" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="weekNo" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnModify" runat="server" CssClass="btn" TabIndex="7" Text="Update"
                                                OnClick="btnModify_Click" Style="display: none;" meta:resourcekey="btnModifyResource1" />
                                            <asp:Button ID="btnDelete" runat="server" CssClass="btn" TabIndex="7" Text="Delete"
                                                OnClick="btnDelete_Click" Style="display: none;" meta:resourcekey="btnDeleteResource1" />
                                        </td>
                                        <td>
                                            &nbsp;
                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                TabIndex="8" Text="Cancel" Style="display: none;" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <!-- Region For Transfer -->
                                <input id="showModalPopupClientButton1" runat="server" style="display: none;" type="text" />
                                <asp:Button ID="hiddenTargetControlForModalPopup1" runat="server" Style="display: none" CssClass="btn"
                                    meta:resourcekey="hiddenTargetControlForModalPopup1Resource1" />
                                <ajc:ModalPopupExtender ID="programmaticModalPopup1" runat="server" BackgroundCssClass="modalBackground"
                                    BehaviorID="programmaticModalPopupBehavior1" DropShadow="True" OkControlID="OkButton"
                                    OnOkScript="onOk('1')" PopupControlID="programmaticPopup1" PopupDragHandleControlID="programmaticPopupDragHandle1"
                                    RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup1"
                                    X="225" Y="60" DynamicServicePath="" Enabled="True">
                                </ajc:ModalPopupExtender>
                                <asp:Panel ID="programmaticPopup1" runat="server" CssClass="modalPopup" Style="display: none;
                                    padding: 10px" meta:resourcekey="programmaticPopup1Resource1">
                                    <asp:Panel ID="Panel1" runat="server" CssClass="v-top a-center" meta:resourcekey="Panel1Resource1">
                                        <table>
                                            <tr>
                                                <td class="a-left">
                                                    &nbsp;
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_SchedulesFrom" Text="Schedules From" runat="server" meta:resourcekey="Rs_SchedulesFromResource1"></asp:Label>
                                                </td>
                                                <td colspan="4">
                                                    <table id="ef" class="a-left h-59">
                                                        <tr>
                                                            <td id="ef0" class="tokenbooking a-left">
                                                                <asp:TextBox ID="txtOriginalDate" Style="background-color: Transparent; border: none 0px;"
                                                                    runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtOriginalDateResource1"></asp:TextBox>
                                                                <br />
                                                                <asp:TextBox ID="txtPhyName" runat="server" Style="background-color: Transparent;
                                                                    border: none 0px;" CssClass="Txtboxsmall" meta:resourcekey="txtPhyNameResource1"></asp:TextBox>
                                                                <br />
                                                                <asp:TextBox ID="txtSchTime" runat="server" Style="background-color: Transparent;
                                                                    border: none 0px;" CssClass="Txtboxsmall" meta:resourcekey="txtSchTimeResource1"></asp:TextBox>
                                                                <br />
                                                                <asp:TextBox ID="txtPhySpeciality" runat="server" Style="background-color: Transparent;
                                                                    border: none 0px;" CssClass="Txtboxsmall" meta:resourcekey="txtPhySpecialityResource1"></asp:TextBox>
                                                                <br />
                                                                <asp:HiddenField ID="hdnRtid" runat="server" />
                                                                <asp:HiddenField ID="hdnSID" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    &nbsp;
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Label1" runat="server" Text="Select Date" meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td colspan="3">
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" 
                                                        ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                        TargetControlID="tDOB" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                        CultureDateFormat="" CultureDatePlaceholder="" 
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="tDOB" Enabled="True" />
                                                    <asp:TextBox ID="tDOB" runat="server" MaxLength="1" Style="text-align: justify" TabIndex="2"
                                                        ValidationGroup="MKE" Width="130px" meta:resourcekey="tDOBResource1" />
                                                    <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="ImgBntCalcResource1" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="tDOB" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblTiming" runat="server" Text="Timing" meta:resourcekey="lblTimingResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblFrm" runat="server" Text="From" meta:resourcekey="lblFrmResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlFrom" runat="server" CssClass="ddlsmall" TabIndex="3"
                                                        meta:resourcekey="ddlFromResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblTo" runat="server" Text="To" meta:resourcekey="lblToResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlTo" runat="server" CssClass="ddlsmall" TabIndex="4"
                                                        meta:resourcekey="ddlToResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <label>
                                                        <asp:Label ID="Rs_Duration" Text="Duration" runat="server" meta:resourcekey="Rs_DurationResource1"></asp:Label></label>
                                                </td>
                                                <td colspan="4">
                                                    <asp:DropDownList ID="ddlDuration" runat="server" CssClass="ddl" TabIndex="5"
                                                        meta:resourcekey="ddlDurationResource1">
                                             <%--           <asp:ListItem meta:resourcekey="ListItemResource2" Text="5"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource3" Text="10"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource4" Text="15"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource5" Text="20"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource6" Text="25"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource7" Text="30"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_mins" Text="mins" runat="server" meta:resourcekey="Rs_minsResource1"></asp:Label></label>
                                                </td>
                                            </tr>
                                        </table>
                                        <input type="button" value="<%=Resources.ClientSideDisplayTexts.Admin_ChangeDocSchedule_OK%>" id="OkButton" runat="server" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" />
                                        <!-- OK</a>  -->
                                        <input type="button" value="<%=Resources.ClientSideDisplayTexts.Admin_ChangeDocSchedule_Close%>" id="hideModalPopupViaClientButton1" runat="server"
                                            class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                                        <!-- Close</a>-->
                                    </asp:Panel>
                                </asp:Panel>
                                <!-- Endregion -->
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
