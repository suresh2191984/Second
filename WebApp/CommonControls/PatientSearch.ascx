<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientSearch.ascx.cs"
    Inherits="CommonControls_PatientSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/Audit_History.ascx" TagName="Audit_History" TagPrefix="adh1" %>

<script language="javascript" type="text/javascript">

    function ShowAlertMsg(key) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_01") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_01") : "Please select visit detail";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_02") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_02") : "Please Proceed via Todays Patient Link";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_03") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_03") : "This action cannot be performed for New born baby";
        var variable1 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_002") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_002") : "Please select visit detail";
        var variable2 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_004") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_004") : "Please Proceed via Todays Patient Link";
        var variable3 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_005") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_005") : "This action cannot be performed for New born baby";
        var userMsg = SListForApplicationMessages.Get(key);
        if (userMsg != null) {
            alert(userMsg);
        }
        //else if (key =="CommonControls\\PatientSearch.ascx.cs_1")
        else if (key == variable1) {
            // alert('Please select visit detail');
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        }
        //else if (key == "CommonControls\\PatientSearch.ascx.cs_2")
        else if (key == variable2) {
            // alert('Please Proceed via Todays Patient Link');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
        }
        //else if (key == "CommonControls\\PatientSearch.ascx.cs_4") {
        else if (key == variable3) {
            //  alert('This action cannot be performed for New born baby');
            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
        }

        return false;

    }
    function ButtonEvent(e, buttonid) {
        var evt = e ? e : window.event;
        var bt = document.getElementById(buttonid);
        if (bt) {
            if (evt.keyCode == 13) {
                bt.click();

            }
        }
    }

</script>

<script language="javascript" type="text/javascript">
    function ShowRegDate() {
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";

        document.getElementById('<%=hdnTempFrom.ClientID %>').value = "";
        document.getElementById('<%=hdnTempTo.ClientID %>').value = "";

        document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "0";
        document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "0";
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "0") {

            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "2") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "3") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "1";
            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "-1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "4") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }

        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "5") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "6") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "7") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
    }
    function ShowChildGrid(Val) {
        var UTCName = 'uctlPatientSearch_';
        //document.getElementById(UTCName+'HdnID').value = Val;
        var ParantGrd = document.getElementById('uctlPatientSearch_' + 'grdResult');
        for (var i = 0; ParantGrd.rows.length; i++) {
            document.getElementById(UTCName + 'HdnID').value = ParantGrd.rows[i].rowIndex;
            //   document.getElementById('uctlPatientSearch_' + 'DivChild').visible = false;
        }
    }

    function SetRID(ID) {
        document.getElementById('<%= HdnID.ClientID  %>').value = ID;


    }
    function SelectVisit(id, vid, pid, PName, Edibill,IsHealthCheckup) {
       
        chosen = "";
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(id).checked = true;
        document.getElementById('uctlPatientSearch_' + 'hdnVID').value = vid;
        document.getElementById('pid').value = pid;
        document.getElementById('uctlPatientSearch_' + 'hdnPNAME').value = PName;
        document.getElementById('<%= hdnEditBill.ClientID  %>').value = Edibill;
        document.getElementById('uctlPatientSearch_' + 'hdnIsHealthCheckUp').value = IsHealthCheckup;
        //        alert(document.getElementById('PID').value);
    }


    function checkForValues() {


        // PatientSearch.ascx_1

        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_04") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_04") : "Please Enter Page No";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_05") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_05") : "Please Enter Correct Page No";

        // var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_1');

        if (document.getElementById('uctlPatientSearch_' + 'txtpageNo').value == "") {
            if (userMsg != null) {

                // alert(userMsg)

                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            }
            else {
                //alert("Please Enter Page No");

                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            }
            return false;
        }

        //userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_2');
        if (Number(document.getElementById('uctlPatientSearch_' + 'txtpageNo').value) < Number(1)) {

            if (UsrAlrtMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }
            else {
                //alert("Please Enter Correct Page No");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }
            return false;
        }
        //userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_2');
        if (Number(document.getElementById('uctlPatientSearch_' + 'txtpageNo').value) > Number(document.getElementById('uctlPatientSearch_' + 'lblTotal').innerText)) {
            if (UsrAlrtMsg1 != null) {
                //alert(userMsg);
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }
            else {
                //alert("Please Enter Correct Page No");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }

            return false;
        }




    }
    function SelectRowCommon(rid, patid) {
        chosen = "";

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('<%= hdnPatientID.ClientID %>').value = patid;
        document.getElementById('pid').value = patid;
        document.getElementById('<%= hdnTempPatientid.ClientID %>').value = patid;


    }
    function SelectRowCommon(rid, patid, POrgID, Pvid, pname) {
        chosen = "";

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('<%= hdnPatientID.ClientID %>').value = patid;
        document.getElementById('pid').value = patid;
        document.getElementById('<%= hdnTempPatientid.ClientID %>').value = patid;
        document.getElementById('<%= patOrgID.ClientID %>').value = POrgID;
        document.getElementById('<%= hdnVID.ClientID %>').value = Pvid;
        document.getElementById('<%= hdnPNAME.ClientID %>').value = pname;
    }

    function ShowDDl() {

        var obj = document.getElementById('<%= ddlType.ClientID %>');

        if (obj.options[obj.selectedIndex].value == 1) {
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "block";
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
        }
        else if (obj.options[obj.selectedIndex].value == 2) {
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "block";
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
        }
        else {
            document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
            document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
        }
        return false;
    }
    function PrintCaseSheet(vid, pid, vType) {
        window.open("../Physician/ViewIPCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y&Prt=Y" + "", '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
        return false;
    }

    function ShowPicture(id, PictureName) {
        var position = $("#" + id).position();
        $("[id$='imgPopupPatient']").attr('src', '<%=ResolveUrl("~/Reception/PatientImageHandler.ashx?FileName=' + PictureName + '")%>');
        $('#divFullImage').show().css({ left: position.left - 150, top: position.top + 20 });
    }

    function HidePicture() {
        $('#divFullImage').hide();
    }

</script>

<style type="text/css">
    .divPopup
    {
        display: none;
        z-index: 1000;
        position: absolute;
        background-color: White;
        padding: 2px;
        border: solid 1px black;
    }
    .style1
    {
        width: 40%;
    }
</style>
<%--<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">--%>
<table class="defaultfontcolor w-100p">
    <tr>
        <td>
            <table class="dataheader3 w-100p">
                <tr>
                    <td class="w-15p">
                        <asp:Label ID="Rs_PatientNo" runat="server" Text="Patient No" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnPID" runat="server" />
                        <asp:HiddenField ID="hdnVisitDetail" runat="server" />
                        <asp:HiddenField ID="hdnVID" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:HiddenField ID="hdnPNAME" runat="server" />
                        <asp:HiddenField ID="hdnIsHealthCheckUp" runat="server" />
                    </td>
                    <td class="w-39p">
                        <asp:TextBox ID="txtPatientNo" runat="server"  CssClass ="Txtboxsmall" MaxLength="60" onkeypress="return ButtonEvent(event,'btnSearch');"
                            meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtPatientNo"
                            ValidChars="1234567890qwertyuiopasdfghjklzxcvbnm/." Enabled="True">
                        </cc1:FilteredTextBoxExtender>
                    </td>
                    <td class="w-20p">
                        <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox ID="txtPatientName" OnChange="javascript:GetText(document.getElementById('uctlPatientSearch_txtPatientName').value);"
                            MaxLength="255" CssClass ="Txtboxsmall" runat="server" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                            EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                            CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo" OnClientItemSelected="SelectPatientStatus"
                            ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                            DelimiterCharacters="" Enabled="True">
                        </cc1:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_PatientAge" runat="server" Text="Patient Age" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDOB" runat="server"  MaxLength="3" CssClass ="Txtboxsmall" Width="50px" meta:resourcekey="txtDOBResource1"></asp:TextBox>
                        <!--  <asp:ImageButton ID="ImgBntCalc"  runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                    CausesValidation="False" /> -->
                    </td>
                    <td>
                        <asp:Label ID="Rs_SpouseFatherName" runat="server" Text="Spouse/Father Name" meta:resourcekey="Rs_SpouseFatherNameResource1"></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox ID="txtRelation" runat="server" MaxLength="50"  CssClass ="Txtboxsmall" meta:resourcekey="txtRelationResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass ="Txtboxsmall"  meta:resourcekey="txtLocationResource1"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="Rs_Others" runat="server" Text="Others" meta:resourcekey="Rs_OthersResource1"></asp:Label>&nbsp;
                        <asp:DropDownList runat="server" ID="ddOthers"  CssClass ="ddlsmall" onchange="document.getElementById('uctlPatientSearch_txtOthers').focus();"
                            meta:resourcekey="ddOthersResource1">
                        </asp:DropDownList>
                    </td>
                    <td class="style1">
                        <asp:TextBox ID="txtOthers" runat="server"    CssClass ="Txtboxsmall" meta:resourcekey="txtOthersResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality" meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlNationality" runat="server"  CssClass ="ddlsmall" TabIndex="14" meta:resourcekey="ddlNationalityResource1">
                      
                              </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="Rs_CorporateInsurance" runat="server" Text="Corporate/Insurance" meta:resourcekey="Rs_CorporateInsuranceResource1"></asp:Label>
                    </td>
                    <td class="style1">
                        <table>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlType" CssClass ="ddlsmall" onChange="javascript:return ShowDDl();"
                                        runat="server" meta:resourcekey="ddlTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <%-- <td>
                            TPA Name :
                        </td>--%>
                                <td>
                                    <asp:DropDownList ID="ddlTpaName" CssClass="ddlsmall" Style="display: none" runat="server"
                                        meta:resourcekey="ddlTpaNameResource1">
                                      
                                         </asp:DropDownList>
                                    <asp:DropDownList ID="ddlCorporate" CssClass="ddlsmall" Style="display: none" runat="server"
                                        meta:resourcekey="ddlCorporateResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server" id="trRegisterPanel">
                    <td>
                        <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
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
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                       CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                        </asp:DropDownList>
                        <div id="divRegDate" style="display: none" runat="server">
                            <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                            <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                            <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                            <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                        </div>
                        <div id="divRegCustomDate" runat="server" style="display: none;">
                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                            <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                            <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                CultureTimePlaceholder="" Enabled="True" />
                            <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                            <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                CultureTimePlaceholder="" Enabled="True" />
                            <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                        </div>
                    </td>
                    <td>
                        <asp:Label ID="Rs_URNo" runat="server" Text="URNo" meta:resourcekey="Rs_URNoResource1"></asp:Label>
                    </td>
                    <td colspan="2" class="style1">
                        <asp:TextBox ID="txtURNo" runat="server" MaxLength="50"  CssClass ="Txtboxsmall" meta:resourcekey="txtURNoResource1"></asp:TextBox>
                        &nbsp;<asp:DropDownList CssClass ="ddlsmall" ID="ddlUrnType" runat="server" meta:resourcekey="ddlUrnTypeResource1">
                        </asp:DropDownList>
                    &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSmartCardNo" Text="Smart Card No" runat="server" meta:resourcekey="lblSmartCardNoResource1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtSmartCardNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtSmartCardNoResource1" />
                    </td>
                    <td>
                        <asp:Label ID="lblUrnType" runat="server" Text="UrnType" meta:resourcekey="lblUrnTypeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="ddlsmall" ID="DropDownList1" runat="server" meta:resourcekey="ddlUrnTypeResource1">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                    <td>
                        <asp:CheckBox ID="chkInactive" runat="server" Text="Include Inactive Patients" />
                    </td>
                   
                    
                </tr>
                <%--<td>
                       <asp:Label ID="lblWardNo" runat="server" Visible="false" Text="WardNo" ></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox ID ="txtWardNo" runat="server"  Visible="false"></asp:TextBox>
                    </td>--%>
                <tr>
                    <td colspan="4" align="center" nowrap="nowrap">
                        <asp:Button ID="btnSearch" runat="server" Text="Search"  CssClass ="btn" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="return CheckPatientSearch();"
                            meta:resourcekey="btnSearchResource1" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%--<tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>--%>
    <tr>
        <td colspan="4">
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
        </td>
    </tr>
     <tr class="a-right">
        <td>
            <table id="PatientDetails" runat="server">
                <tr>
                    <td class="a-left">
                        <asp:Label ID="lblTotalPatient" Text="Total Patient Count:" runat="server" Style="font-weight: 700"
                            meta:resourcekey="lblTotalPatientResource1"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:Label ID="lblpatientCount" runat="server" meta:resourcekey="lblpatientCountResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left">
                        <asp:Label ID="lblPatientVisitCount" Text="PatientVisitCount:" runat="server" Style="font-weight: 700"
                            meta:resourcekey="lblPatientVisitCountResource1"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:Label ID="lblPatientTotalVisitCount" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="a-right">
            &nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/starbutton.png" visible="false" id="imgstar"
                runat="server" alt="" align="middle" />
            <asp:Label ID="Label4" Visible="False" Text="Click On PatientName To Show VisitDetails. "
                runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="a-center">
            <table id="tblHeader" runat="server" class="w-100p">
                <tr>
                    <td colspan="4">
                        <table border="0" id="GrdHeader" runat="server" style="display: none" class="w-100p">
                            <tr class="dataheader1">
                                <td class="a-left w-3p">
                                    <asp:Label ID="Rs_Select" runat="server" Text="Select" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                </td>
                                <td class="a-left w-10p">
                                    <asp:Label ID="Rs_PatientNo1" runat="server" Text="Patient No." meta:resourcekey="Rs_PatientNo1Resource1"></asp:Label>
                                </td>
                                <td class="a-left w-21p">
                                    <asp:Label ID="Rs_Name" runat="server" Text="Name" meta:resourcekey="Rs_NameResource1"></asp:Label>
                                </td>
                                <%--<td style="display: none; width: 80px"></td>--%>
                                <td class="w-10p">
                                    <asp:Label ID="Rs_Age" runat="server" Text="Age" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                </td>
                                <td class="w-13p">
                                    <asp:Label ID="Rs_URNNo" runat="server" Text="URN No" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                                </td>
                                <td class="w-12p a-center">
                                    <asp:Label ID="Rs_MobileNumber" runat="server" Text="Mobile Number" meta:resourcekey="Rs_MobileNumberResource1"></asp:Label>
                                </td>
                                <td class="w-19p">
                                    <asp:Label ID="Rs_Address" runat="server" Text="Address" meta:resourcekey="Rs_AddressResource1"></asp:Label>
                                </td>
                                <td runat="server" id="tdorg" visible="false" style="width: 7%">
                                    <asp:Label ID="Rs_Organization" runat="server" Text="Organization" meta:resourcekey="Rs_OrganizationResource1"></asp:Label>
                                </td>
                                <td class="w-10p">
                                    <asp:Label ID="lblDueAmount" runat="server" Text="DueAmount" 
                                        meta:resourcekey="lblDueAmountResource1"></asp:Label>
                                </td>
                                <td class="w-2p">
                                    <asp:Label ID="lblHistory" runat="server" Text="History" 
                                        meta:resourcekey="lblHistoryResource1"></asp:Label>
                                </td>
                                <%--<td style="width: 100px; display: none">Address</td>--%>
                                <%--<td style="display: none"></td>--%>
                            </tr>
                        </table>
                        <table class="w-100p">
                            <tr>
                                <td colspan="10">
                                    <asp:GridView ID="grdResult" CssClass="w-100p" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        DataKeyNames="PatientID,Name,Age,URNO,MobileNumber,Address,OrgID,PictureName,PatientNumber"
                                        PagerSettings-Mode="NextPrevious" OnRowDataBound="grdResult_RowDataBound" OnRowCommand="grdResult_RowCommand"
                                        OnPageIndexChanging="grdResult_PageIndexChanging" PageSize="15" meta:resourcekey="grdResultResource1">
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <%--<HeaderStyle CssClass="dataheader1" />--%>
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField Visible="false" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource1" />
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <table id="TabChild" runat="server" class="a-left w-100p">
                                                        <tr id="Tr1" runat="server">
                                                            <td id="Td1" class="w-3p" nowrap="nowrap" runat="server">
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                                            </td>
                                                            <td id="PatientNumber" class="a-left w-10p" nowrap="nowrap" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                            </td>
                                                            <td id="Name" class="a-left w-21p" runat="server">
                                                                <asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                    ImageUrl="~/Images/collapse.jpg" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                <asp:LinkButton ID="lblNaME" ToolTip="Click here To View Visit details" ForeColor="Black"
                                                                    runat="server" CommandName="ShowVisit" Text='<%# Bind("Name") %>' CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                            </td>
                                                            <td id="PatientID" class="a-left" style="display: none" runat="server">
                                                                <asp:TextBox ID="txtPatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                            </td>
                                                            <td id="Age" class="a-left w-10p" runat="server">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                            </td>
                                                            <td id="URNNo" class="a-left w-13p" nowrap="nowrap" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "URNO")%>
                                                            </td>
                                                            <td id="MobileNumber" class="a-left w-12p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "MobileNumber")%>
                                                            </td>
                                                            <td id="Address" class="a-left w-19p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "Address")%>
                                                            </td>
                                                            <td id="tdOrganizationID" runat="server" visible="False" class="a-left w-7p">
                                                                <%# DataBinder.Eval(Container.DataItem, "PatorgName")%>
                                                            </td>
                                                            <td id="DueAmt" class="a-left w-10p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "TotalDueAmt")%>
                                                            </td>
                                                            <td id="PicPatient" class="a-left w-2p" runat="server">
                                                                <asp:ImageButton ID="imgPatient" runat="server" ImageUrl="~/Images/PhotoViewer.png"
                                                                    Width="13px" Height="13px" />
                                                            </td>
                                                     <td class="a-center" runat="server">
                                                                <asp:ImageButton ID="btnHistory" ImageUrl="~/Images/Hist2.png" runat="server" 
                                                                    Text="H" Height="25px" 
                                                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "PatientID") %>' 
                                                                    CommandName="History" />
                                                            </td>
                                                        </tr>
                                                        <tr  runat="server">
                                                            <td  colspan="10" runat="server">
                                                                <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center">
                                                                    <itemtemplate>
                                                                                   
                                                                                    <div class="w-100p">
                                                                                            <div runat="server"  id="DivChild" style="display:none;" class="evenforsurg"  >
                                                                                             
                                                                                                  
                                                                                                    <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" 
                                                                                                        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                                                                                        DataKeyNames="PatientVisitID,Name" OnRowDataBound="ChildGrid_RowDataBound"
                                                                                                        ForeColor="White" OnPageIndexChanging="ChildGrd_PageIndexChanging" PageSize="5"
                                                                                                        CssClass="mytable1 w-100p gridView">
                                                                                                        <PagerSettings Mode="NextPrevious" />
                                                                                                        <PagerTemplate>
                                                                                                            <tr>
                                                                                                                <td colspan="5" align="center">
                                                                                                                    <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                                                                                        CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                                                                                                    <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                                                                                        CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </PagerTemplate>
                                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                                        <Columns>
                                                                                                            <asp:BoundField Visible="False" DataField="PatientVisitID" 
                                                                                                                HeaderText="PatientVisitID" />
                                                                                                            <asp:TemplateField HeaderText="Select">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                                                                                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date" />
                                                                                                            
                                                                                                            <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Ref Physician" />
                                                                                                        
                                                                                                        <asp:BoundField DataField="Investigation" HeaderText="Investigation List" />
                                                                                                        <asp:BoundField DataField="PerformingPhysicain" HeaderText="Reporting Radiologist" />
                                                                                                      <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" />
                                                                                                                        <asp:BoundField DataField="OrganizationName" HeaderText="Organization Name" />
                                                                                                        <asp:BoundField DataField="WardNo" HeaderText="WardNo" />  
                                                                                                                                                
                                                                                                                        
                                                                                                            <asp:BoundField Visible="False" DataField="Status" HeaderText="Report Status" />
                                                                                                   <asp:BoundField Visible="False" DataField="Status" HeaderText="Report Status" />
                                                                                                            
                                                                                                           
                                                                                                        </Columns>
                                                                                                    </asp:GridView>&nbsp;
                                                                                                   
                                                                                                        <asp:DropDownList ID="ddlVisitActionName" CssClass="ddlTheme" runat="server">
                                                                                                        </asp:DropDownList>
                                                                                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                             onmouseout="this.className='btn'" OnClick="btnGo_Click"  />
                                                                                                    
                                                                                               
                                                                                            </div>
                                                                                       
                                                                                    </div>
                                                                                </itemtemplate>
                                                                </asp:TemplateField>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                <td colspan="10" class="defaultfontcolor a-center">
                                    <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                                        meta:resourcekey="Btn_PreviousResource1" />
                                    <asp:Button ID="Btn_Next" runat="server" Text="Next"  CssClass ="btn" OnClick="Btn_Next_Click"
                                        meta:resourcekey="Btn_NextResource1" />
                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                    <asp:TextBox ID="txtpageNo" runat="server" CssClass ="Txtboxsmall" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  
                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                    <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1"
                                        meta:resourcekey="btnGo1Resource1" />
                                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="a-center">
            <asp:Panel ID="pnlPatientSearch" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup w-80p"
                Style="display: none; top: 400px; height: 400px" meta:resourcekey="pnlPatientSearchResource1">
                <adh1:Audit_History ID="audit_History" runat="server" />
                <asp:Button ID="btnClose" Text="Close" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                    onmouseout="this.className='btn1'" meta:resourcekey="btnCloseResource1" />
            </asp:Panel>
        </td>
        <td>
            <cc1:ModalPopupExtender id="ModelPopPatientSearch" runat="server" targetcontrolid="btnR"
                popupcontrolid="pnlPatientSearch" backgroundcssclass="modalBackground" okcontrolid="btnClose"
                dynamicservicepath="" enabled="True" />
               <input type="button" id="btnR" runat="server" style="display: none;" />
        </td>
    </tr>
</table>
<div id="divFullImage" class="divPopup">
    <img alt="Patient Picture" id="imgPopupPatient" runat="server" src="~/Images/ProfileDefault.jpg" />
</div>
<asp:HiddenField ID="hdnPatientID" runat="server" />
<input type="hidden" id="pid" name="pid" />
<%--<input type="hidden" id="patOrgID" name="patOrgID" />--%>
<asp:HiddenField ID="ShowID" runat="server" />
<asp:HiddenField ID="hdnTempPatientid" runat="server" />
<asp:HiddenField ID="patOrgID" runat="server" />
<asp:HiddenField ID="hdnIswardNo" runat="server" />
<asp:HiddenField ID="hdnEditBill" runat="server" />
<script language="javascript" type="text/javascript">
    function ShowTable() {
        if (document.getElementById('<%=ShowID.ClientID %>').value == "") {
            document.getElementById('<%=ShowID.ClientID %>').value = "Show";
        }
        else
            form1.submit();

    }
    function GetText(pName) {
        if (pName != "") {
            // var Temp = pName.split('(');
            //if (Temp.length >= 2) {
            document.getElementById('<%=txtPatientName.ClientID %>').value = pName;
            // }
        }
    }
    function CheckVisitID(DDlID) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_06") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_06") : "Please Select Visit Detail";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_PatientSearch_ascx_07") != null ? SListForAppMsg.Get("CommonControls_PatientSearch_ascx_07") : "This Visit Bill is Already Merged";

        //var UserMsg = null;

        if (document.getElementById('<%=hdnVID.ClientID %>').value == '') {
            document.getElementById(DDlID).focus();
            if (UsrAlrtMsg != null) {
                // alert(UserMsg);
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            }
            else {
                //alert('Please Select Visit Detail');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            }
            return false;
        }
        else if (document.getElementById(DDlID) != undefined) {
            document.getElementById('<%=hdnVisitDetail.ClientID %>').value = document.getElementById(DDlID)[document.getElementById(DDlID).selectedIndex].innerHTML
            document.getElementById('<%=hdnRowInx.ClientID %>').value = document.getElementById(DDlID).selectedIndex;
            if (document.getElementById('<%=hdnVisitDetail.ClientID %>').value == "OPBillSettlement") {
                if (document.getElementById('<%=hdnEditBill.ClientID %>').value != "Y") {
                    return true;
                }
                else {
                    //  alert("This Visit Bill is Already Merged");
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);

                    return false;
                }

            }
            else if (document.getElementById('<%=hdnVisitDetail.ClientID %>').value == "Print Merge Bill") {
                return document.getElementById('<%=hdnEditBill.ClientID %>').value == "Y" ? true : false;
            }
            else {
                return true;
            }
        }
    }
  
</script>

<input type="hidden" id="hdnRowInx" runat="server" name="hdnRowInx" />

<script type="text/javascript" language="javascript">
    if (document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value == "1" && document.getElementById('<%=hdnTempToPeriod.ClientID %>').value == "1") {

        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
    }
    if (document.getElementById('<%=hdnTempFrom.ClientID %>').value != "" && document.getElementById('<%=hdnTempTo.ClientID %>').value != "") {

        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
        document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
    }

    function PrintOpCard() {
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        WinPrint.document.write($('#divGenerateVisit').html());
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }

</script>

<div style="display: none" id="divGenerateVisit">
        <asp:Xml ID="XmlOP" runat="server"></asp:Xml>
    </div>
<%--</asp:Panel>--%>