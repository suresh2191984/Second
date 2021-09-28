<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RelatedSchedulesControl.ascx.cs"
    Inherits="CommonControls_RelatedSchedulesControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
<style type="text/css">
    .theader
    {
        font-size: 13px;
        font-style: normal;
        line-height: normal;
        font-family: Verdana, Geneva, sans-serif;
    }
</style>

<script language="javascript" type="text/javascript">

    function ProductsListPopup() {

        var PName;
        var pNo;
        pName = document.getElementById('<%= txtPatientName.ClientID %>').value.trim();
        pNo = document.getElementById('<%= txtPatientNumber.ClientID %>').value.trim();
        var pOrg = document.getElementById('<%= hdnOrgId.ClientID %>').value.trim();
        //window.showModalDialog("PatientList.aspx?pName=" + pName + "&pNo=" + pNo + "&pOrg=" + pOrg + "", "Products List", "dialogWidth:550px;dialogHeight:450px");
        window.open("PatientList.aspx?pName=" + pName + "&pNo=" + pNo + "&pOrg=" + pOrg + "", "Patient", "height=450,width=550,scrollbars=yes");
    }

    function PatientsResult(vpname, vpnumber) {
        document.getElementById('<%= txtPatientName.ClientID %>').value = vpname;
        document.getElementById('<%= txtPatientNumber.ClientID %>').value = vpnumber;
    }

    function onOk(ival) {

        if (ival == 1) {
            document.getElementById('<%= btnSave.ClientID %>').click();
        }
        else if (ival == 2) {
            document.getElementById('<%= bCancel.ClientID %>').click();
        }
    }

    function pageLoad() {

        $addHandler($get('<%= showModalPopupClientButton2.ClientID %>'), 'click', showModalPopupViaClient2);
        $addHandler($get('<%= hideModalPopupViaClientButton2.ClientID %>'), 'click', hideModalPopupViaClient2);
        $addHandler($get('<%= showModalPopupClientButton1.ClientID %>'), 'click', showModalPopupViaClient1);
        $addHandler($get('<%= hideModalPopupViaClientButton1.ClientID %>'), 'click', hideModalPopupViaClient1);
    }

    function showModalPopupViaClient2(ev) {
        ev.preventDefault();
        var modalPopupBehavior = $find('programmaticModalPopupBehavior2');
        modalPopupBehavior.show();
    }

    function hideModalPopupViaClient2(ev) {
        ev.preventDefault();
        var modalPopupBehavior = $find('programmaticModalPopupBehavior2');
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

    function Book1(idData) {
        var tempData = document.getElementById(idData);
        var temValue = tempData.id;
        var idVal = document.getElementById('<%= hdnSelectedID.ClientID %>').value;

        if (tempData.checked == true) {
            idVal = idVal + "|" + temValue;
        }
        else {
            var iSplit = new Array();
            iSplit = idVal.split('|');
            var icount = 0;
            if (iSplit.length > 0) {
                for (icount = 0; icount < iSplit.length; icount++) {
                    if (iSplit[icount] == temValue) {
                        iSplit[icount] = "";
                    }
                }
            }
            var SIDtempDatas = "";
            for (icount = 0; icount < iSplit.length; icount++) {
                if (iSplit[icount] != "") {
                    SIDtempDatas += iSplit[icount] + "|";
                }
            }
            idVal = SIDtempDatas;
        }

        document.getElementById('<%= hdnSelectedID.ClientID %>').value = idVal;
        return false;

        //

    }
    String.prototype.trim = function() {
        return this.replace(/^\s*/, "").replace(/\s*$/, "");
    }

    function bookslots() {
        var idVal = document.getElementById('<%= hdnSelectedID.ClientID %>').value;
        idVal = idVal.trim();
        if (idVal == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\RelatedSchedulesControl.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please select slots to book");
            }
        }
        else {
            if (('<%= PatientNumber %>').trim() != "0") {

                document.getElementById('<%= txtPatientName.ClientID %>').value = '<%= Patientname %>';
                document.getElementById('<%= txtPatientNumber.ClientID %>').value = '<%= PatientNumber %>';
                document.getElementById('<%= txtPhoneNumber.ClientID %>').value = '<%= PhoneNumber %>';
                document.getElementById('<%= btnSave.ClientID %>').click();
            }
            else {
                document.getElementById('<%= showModalPopupClientButton1.ClientID %>').click();
            }
        }
        return false;
    }
    function CancelBooking1(bkid, Desc) {

        document.getElementById('<%= hidBKID.ClientID %>').value = bkid;

        document.getElementById('<%= lDesc.ClientID %>').innerHTML = Desc;
        document.getElementById('<%= showModalPopupClientButton2.ClientID %>').click();
    }

</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="bCancel" EventName="Click"></asp:AsyncPostBackTrigger>
        <asp:AsyncPostBackTrigger ControlID="btnSlotsBack" EventName="Click"></asp:AsyncPostBackTrigger>
    </Triggers>
    <ContentTemplate>
        <div id="dvTableData" runat="server">
        </div>
        <input type="button" class="btn" title="Book Slot(s)" value="Book Slot(s)" id="btnBookSlots"
            onclick="bookslots();" />
        <asp:Button ID="btnSlotsBack" runat="server" Text="Back" OnClick="btnSlots_Back"
            CssClass="btn" meta:resourcekey="btnSlotsBackResource1" />
        <asp:Button runat="server" ID="btnSave" CssClass="btn" onmouseover="this.className='btn btnhov'"
            onmouseout="this.className='btn'" OnClick="bSave_Click" Width="0px" meta:resourcekey="btnSaveResource1" />
        <asp:Button runat="server" ID="bCancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
            onmouseout="this.className='btn'" OnClick="bCancel_Click" Width="0px" meta:resourcekey="bCancelResource1" />
        <asp:HiddenField ID="hdnPatientNo" runat="server" />
        <asp:HiddenField ID="hdnSpeciality" runat="server" />
        <asp:HiddenField ID="hdnModality" runat="server" />
        <cc1:ModalPopupExtender ID="programmaticModalPopup1" runat="server" BackgroundCssClass="modalBackground"
            BehaviorID="programmaticModalPopupBehavior1" DropShadow="True" OkControlID="OkButton"
            OnOkScript="onOk('1')" PopupControlID="programmaticPopup1" PopupDragHandleControlID="programmaticPopupDragHandle1"
            RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup1"
            X="225" Y="70" DynamicServicePath="" Enabled="True">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="programmaticPopup1" Style="display: none; width: 450px;" CssClass="modalPopup"
            runat="server" meta:resourcekey="programmaticPopup1Resource1">
            <table width="100%" class="defaultfontcolor">
                <tr>
                    <td colspan="2">
                        <div id="dvTable" runat="server">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label class="defaultfontcolor" ID="Rs_PatientName" runat="server" Text="Patient Name"
                            meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPatientName" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label class="defaultfontcolor" ID="Rs_PatientNo" runat="server" Text="Patient No."
                            meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPatientNumber" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server" TabIndex="3" Text="Search" CssClass="btn1"
                            onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                            OnClientClick="return ProductsListPopup(); return false;" meta:resourcekey="Button1Resource1" />
                        <input type="hidden" id="hdnOrgId" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label class="defaultfontcolor" ID="Rs_PhoneNo" runat="server" Text=" Phone No."
                            meta:resourcekey="Rs_PhoneNoResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPhoneNumber" MaxLength="25" meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                        <br />
                        <span style="font-size: 8pt;">
                            <asp:Label ID="Rs_noteSeleprateUltiplePhoneNumbersWithHyphen" runat="server" Text="note : Seleprate multiple phone numbers with hyphen (-)"
                                meta:resourcekey="Rs_noteSeleprateUltiplePhoneNumbersWithHyphenResource1"></asp:Label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="defaultfontcolor">
                        <asp:Label ID="Rs_Description1" runat="server" Text="Description" meta:resourcekey="Rs_Description1Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tBkDesc" TextMode="MultiLine" MaxLength="240" meta:resourcekey="tBkDescResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <input type="button" value="OK" id="OkButton" runat="server" class="btn" onmouseout="this.className='btn'"
                            onmouseover="this.className='btn btnhov'" />
                        <!-- OK</a>  -->
                        <input type="button" value="Close" id="hideModalPopupViaClientButton1" runat="server"
                            class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <input type="button" id="showModalPopupClientButton2" runat="server" href="#" style="display: none;" />
        <asp:Button ID="hiddenTargetControlForModalPopup2" runat="server" Style="display: none"
            meta:resourcekey="hiddenTargetControlForModalPopup2Resource1" />
        <cc1:ModalPopupExtender ID="programmaticModalPopup2" runat="server" BackgroundCssClass="modalBackground"
            BehaviorID="programmaticModalPopupBehavior2" DropShadow="True" OkControlID="OkBtn"
            OnOkScript="onOk('2')" PopupControlID="programmaticPopup2" PopupDragHandleControlID="programmaticPopupDragHandle2"
            RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup2"
            X="225" Y="50" DynamicServicePath="" Enabled="True">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="programmaticPopup2" Style="display: none; width: 450px;" CssClass="modalPopup"
            runat="server" meta:resourcekey="programmaticPopup2Resource1">
            <table width="100%">
                <tr>
                    <td class="defaultfontcolor">
                        <asp:Label ID="Rs_Description" runat="server" Text="Description:" meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                    </td>
                    <td valign="bottom">
                        <asp:Label ID="lDesc" runat="server" meta:resourcekey="lDescResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="defaultfontcolor">
                        <asp:Label ID="Rs_ReasonForCancellation" runat="server" Text="Reason for Cancellation:"
                            meta:resourcekey="Rs_ReasonForCancellationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tCanDesc" TextMode="MultiLine" meta:resourcekey="tCanDescResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        <input type="button" value="OK" id="OkBtn" runat="server" class="btn" onmouseout="this.className='btn'"
                            onmouseover="this.className='btn btnhov'" />
                        <input type="button" value="Close" id="hideModalPopupViaClientButton2" runat="server"
                            class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:HiddenField runat="server" ID="hidBKID" />
        <asp:HiddenField runat="server" ID="hidDate" />
        <asp:HiddenField runat="server" ID="hidToken" />
        <asp:HiddenField runat="server" ID="hidDesc" />
        <input type="hidden" id="rtid" runat="server"></input>
        <asp:HiddenField ID="hdnScheduleID" runat="server" />
        <asp:HiddenField ID="hdnSelectedID" runat="server" />
        <asp:HiddenField ID="hdnSelectedSchedules" runat="server" />
        <input id="showModalPopupClientButton1" runat="server" href="#" style="display: none;"
            type="button"></input>
        <asp:Button ID="hiddenTargetControlForModalPopup1" runat="server" meta:resourcekey="hiddenTargetControlForModalPopup1Resource1"
            Style="display: none" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
