<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DaycarePatientSearch.ascx.cs"
    Inherits="CommonControls_DaycarePatientSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
    function SelectRowCommon(rid, patid, episodeid, visitid, pname,iscredit,rateid) {
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
        document.getElementById('<%= hdnVID.ClientID %>').value = visitid;
        document.getElementById('<%= hdniscredit.ClientID %>').value = iscredit;
        document.getElementById('<%= hdnRateID.ClientID %>').value = rateid;
        
        
    }
    function CheckVisitID(DDlID) {

        if (document.getElementById('<%=hdnVID.ClientID %>').value == '') {
            document.getElementById(DDlID).focus();
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DaycarePatientSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert('Please Select Visit Detail'); }
            return false;
        }
        else if (document.getElementById(DDlID) != undefined) {
            document.getElementById('<%=hdnVisitDetail.ClientID %>').value = document.getElementById(DDlID)[document.getElementById(DDlID).selectedIndex].innerHTML
            document.getElementById('<%=hdnRowInx.ClientID %>').value = document.getElementById(DDlID).selectedIndex;
            return true;
        }
    }
  
</script>
<style type="text/css">
.divPicturePopup
    {
        display: none;
        z-index: 1000;
        position: absolute;
        background-color: White;
        padding: 2px;
        border: solid 1px black;
    }
</style>
<input type="hidden" id="hdnRowInx" runat="server" name="hdnRowInx" />
<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" 
    meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" class="defaultfontcolor">
        <tr>
            <td width="100%">
                <table border="0" cellpadding="0" cellspacing="5" width="100%" class="dataheader3">
                    <tr>
                        <td style="width: 15%">
                          <asp:Label  ID="lbpatno" Text ="Patient No" runat="server" 
                                meta:resourcekey="lbpatnoResource1" ></asp:Label>
                        </td>
                        <td style="width: 39%">
                            <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="16" 
                                onkeypress="return onEnterKeyPress(event);" 
                                meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                        </td>
                        <td style="width: 20%">
                <asp:Label  ID="lbpatname" Text ="Patient Name" runat="server" 
                                meta:resourcekey="lbpatnameResource1" ></asp:Label>
                        </td>
                        <td style="width: 28%">
                           <asp:TextBox ID="txtPatientName" OnChange="javascript:GetText(document.getElementById('ucDaycarePatientSearch_txtPatientName').value);"
                            MaxLength="255" runat="server" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                            EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                            CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                            ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                            DelimiterCharacters="" Enabled="True">
                        </cc1:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                <asp:Label  ID="lbpatage" Text ="Patient Age" runat="server" 
                                meta:resourcekey="lbpatageResource1" ></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDOB" runat="server" MaxLength="3" Width="50px" 
                                meta:resourcekey="txtDOBResource1"></asp:TextBox>
                            <!--  <asp:ImageButton ID="ImgBntCalc"  runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                    CausesValidation="False" /> -->
                            <asp:TextBox ID="txtRoomNo" runat="server" MaxLength="3" Visible="False" 
                                meta:resourcekey="txtRoomNoResource1"></asp:TextBox>
                        </td>
                        <td>
                          <asp:Label  ID="lbpatmobno" Text ="Mobile No" runat="server" 
                                meta:resourcekey="lbpatmobnoResource1" ></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCellNo" runat="server" MaxLength="12" 
                                meta:resourcekey="txtCellNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <asp:Label ID="lbnat" runat="server" Text="Nationality" 
                                meta:resourcekey="lbnatResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlNationality" runat="server" TabIndex="14" 
                                meta:resourcekey="ddlNationalityResource1">
                            </asp:DropDownList>
                            <asp:DropDownList ID="purposeOfAdmission" runat="server" TabIndex="39" 
                                Visible="False" meta:resourcekey="purposeOfAdmissionResource1">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtPurpose" runat="server" Visible="False" Width="16px" 
                                meta:resourcekey="txtPurposeResource1"></asp:TextBox>
                        </td>
                        <td nowrap="nowrap">
                      <asp:Label ID="lbcorporate" runat="server" Text="Corporate/Insurance" 
                                meta:resourcekey="lbcorporateResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server" 
                                onChange="javascript:return ShowDDl();" 
                                meta:resourcekey="ddlTypeResource1">
                                <asp:ListItem Text="Any" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Client" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="Insurance" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSmartCardNo" Text="Smart Card No" runat="server" 
                                meta:resourcekey="lblSmartCardNoResource1" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtSmartCardNo" runat="server" 
                                meta:resourcekey="txtSmartCardNoResource1" />
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:DropDownList ID="ddlTpaName" Style="display: none" runat="server" 
                                            meta:resourcekey="ddlTpaNameResource1">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlCorporate" Style="display: none" runat="server" 
                                            meta:resourcekey="ddlCorporateResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr  runat="server" id="trRegisterPanel" >
                        <td runat="server" >
                            <asp:Label ID="lbregdate" runat="server" Text="Registered Date" 
                                meta:resourcekey="lbregdateResource1"></asp:Label>
                            <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                            <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                            <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                            <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                            <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                            <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                            <asp:HiddenField ID="hdnDateImage" runat="server" />
                            <asp:HiddenField ID="hdnTempFrom" runat="server" />
                            <asp:HiddenField ID="hdnTempTo" runat="server" />
                            <asp:HiddenField ID="hdnVID" runat="server" />
                            <asp:HiddenField ID="hdnRateID" runat="server" />
                            <asp:HiddenField ID="hdniscredit" runat="server" />
                            <asp:HiddenField ID="hdnVisitDetail" runat="server" />
                            <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                            <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                            <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                            <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                            <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                            <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                            <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                            <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                        </td>
                        <td colspan="3" runat="server">
                            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                CssClass="ddlTheme" runat="server" 
                                meta:resourcekey="ddlRegisterDateResource1">
                                <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource4">--Select--</asp:ListItem>
                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource5">This Week</asp:ListItem>
                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource6">This Month</asp:ListItem>
                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource7">This Year</asp:ListItem>
                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource8">Custom Period</asp:ListItem>
                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource9">Today</asp:ListItem>
                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource10">Last Week</asp:ListItem>
                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource11">Last Month</asp:ListItem>
                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource12">Last Year</asp:ListItem>
                            </asp:DropDownList>
                            <div  id="divRegDate" style="display: none" runat="server" >
                          <asp:Label ID="lbfrmdate" runat="server" Text="From Date" 
                                    meta:resourcekey="lbfrmdateResource1"></asp:Label>
                                <asp:TextBox Width="70px" ID="txtFromDate" runat="server" 
                                    meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                          <asp:Label ID="lbtodate" runat="server" Text="To Date" 
                                    meta:resourcekey="lbtodateResource1"></asp:Label>
                                <asp:TextBox Width="70px" runat="server" ID="txtToDate" 
                                    meta:resourcekey="txtToDateResource1"></asp:TextBox>
                            </div>
                            <div id="divRegCustomDate" runat="server" style="display: none;"   >
                       <asp:Label ID="lbfrmdt" runat="server" Text="From Date" 
                                    meta:resourcekey="lbfrmdtResource1"></asp:Label>
                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" 
                                    meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                    meta:resourcekey="MaskedEditValidator5Resource1" />
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                         <asp:Label ID="lbtodt" runat="server" Text="To Date" 
                                    meta:resourcekey="lbtodtResource1"></asp:Label>
                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" 
                                    meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                    meta:resourcekey="MaskedEditValidator1Resource1" />
                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                            </div>
                        </td>
                    </tr>
                    
                    <tr  runat="server" id="trAdmissionPanel">
                        <td runat="server">
                            
                            <!--Admission Date
                            <asp:HiddenField ID="AdhdnFirstDayWeek" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayWeek" runat="server" />
                            <asp:HiddenField ID="AdhdnFirstDayMonth" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayMonth" runat="server" />
                            <asp:HiddenField ID="AdhdnFirstDayYear" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayYear" runat="server" />
                            <asp:HiddenField ID="AdhdnDateImage" runat="server" />
                            <asp:HiddenField ID="AdhdnTempFrom" runat="server" />
                            <asp:HiddenField ID="AdhdnTempTo" runat="server" />
                            <asp:HiddenField ID="AdhdnTempFromPeriod" runat="server" />
                            <asp:HiddenField ID="AdhdnTempToPeriod" runat="server" />
                            <asp:HiddenField ID="AdhdnLastMonthFirst" runat="server" />
                            <asp:HiddenField ID="AdhdnLastMonthLast" runat="server" />
                            <asp:HiddenField ID="AdhdnLastWeekFirst" runat="server" />
                            <asp:HiddenField ID="AdhdnLastWeekLast" runat="server" />
                            <asp:HiddenField runat="server" ID="AdhdnLastYearFirst" />
                            <asp:HiddenField ID="AdhdnLastYearLast" runat="server" />-->
                        </td>
                        <td colspan="3" runat="server">
                            <asp:DropDownList ID="ddlAdmissionDate" Visible="False" onChange="javascript:return ShowAdmDate();"
                                CssClass="ddlTheme" runat="server" 
                                meta:resourcekey="ddlAdmissionDateResource1">
                                <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource4">--Select--</asp:ListItem>
                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource5">This Week</asp:ListItem>
                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource6">This Month</asp:ListItem>
                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource7">This Year</asp:ListItem>
                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource8">Custom Period</asp:ListItem>
                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource9">Today</asp:ListItem>
                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource10">Last Week</asp:ListItem>
                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource11">Last Month</asp:ListItem>
                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource12">Last Year</asp:ListItem>
                            </asp:DropDownList>
                            <div   id="divAdmDate" style="display: none" runat="server"    >
                     <asp:Label ID="lbfrmdat" runat="server" Text="From Date" 
                                    meta:resourcekey="lbfrmdatResource1"></asp:Label>
                                <asp:TextBox Width="70px" ID="AdtxtFromDate" runat="server" 
                                    meta:resourcekey="AdtxtFromDateResource1"></asp:TextBox>
                               <asp:Label ID="lbtodte" runat="server" Text="To Date" 
                                    meta:resourcekey="lbtodteResource1"></asp:Label>
                                <asp:TextBox Width="70px" runat="server" ID="AdtxtToDate" 
                                    meta:resourcekey="AdtxtToDateResource1"></asp:TextBox>
                            </div>
                            <div id="divAdmCustomDate" runat="server" style="display: none;">
               <asp:Label ID="lbfromdt" runat="server" Text="From Date" meta:resourcekey="lbfromdtResource1"></asp:Label>
                                <asp:TextBox Width="70px" ID="AdtxtFromPeriod" runat="server" 
                                    meta:resourcekey="AdtxtFromPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="AdImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="AdImgBntCalcFromResource1" />
                                <cc1:MaskedEditExtender ID="AdMaskedEditExtender5" runat="server" TargetControlID="AdtxtFromPeriod"
                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                <cc1:MaskedEditValidator ID="AdMaskedEditValidator5" runat="server" ControlExtender="AdMaskedEditExtender5"
                                    ControlToValidate="AdtxtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="AdMaskedEditValidator5" 
                                    meta:resourcekey="AdMaskedEditValidator5Resource1" />
                                <cc1:CalendarExtender ID="AdCalendarExtender1" runat="server" TargetControlID="AdtxtFromPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="AdImgBntCalcFrom" Enabled="True" />
                              <asp:Label ID="lbtdate" runat="server" Text="To Date" 
                                    meta:resourcekey="lbtdateResource1"></asp:Label>
                                <asp:TextBox Width="70px" runat="server" ID="AdtxtToPeriod" 
                                    meta:resourcekey="AdtxtToPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="AdImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="AdImgBntCalcToResource1" />
                                <cc1:MaskedEditExtender ID="AdMaskedEditExtender1" runat="server" TargetControlID="AdtxtToPeriod"
                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                <cc1:MaskedEditValidator ID="AdMaskedEditValidator1" runat="server" ControlExtender="AdMaskedEditExtender5"
                                    ControlToValidate="AdtxtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="AdMaskedEditValidator1" 
                                    meta:resourcekey="AdMaskedEditValidator1Resource1" />
                                <cc1:CalendarExtender ID="AdCalendarExtender2" runat="server" TargetControlID="AdtxtToPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="AdImgBntCalcTo" Enabled="True" />
                            </div>
                        </td>
                    </tr>
                   
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                onmouseout="this.className='btn1'" OnClick="btnSearch_Click" 
                                OnClientClick="return CheckINPatientSearch();" 
                                meta:resourcekey="btnSearchResource1" />
                            &nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                onmouseout="this.className='btn1'" OnClick="btnCancel_Click" 
                                meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="chkDischarge" Visible="False" runat="server" 
                    Text="Need Recent Discharge Patient's Only" 
                    meta:resourcekey="chkDischargeResource1" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" 
                    meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <table width="100%" border="1" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" id="GrdHeader" runat="server" style="display: block" width="100%">
                                <tr  class="dataheader1" runat="server"  >
                                    <td align="left" style="width: 2%" runat="server">
                                    </td>
                                    <td align="center" style="width: 18%" runat="server"     >
                                      <asp:Label ID="labname" runat="server" Text="Name" 
                                            meta:resourcekey="labnameResource1"></asp:Label>
                                    </td>
                                    <td  align="center" style="width: 8%" runat="server" >
                                        <asp:Label ID="lblPatientNumberHeader" runat="server" Text='Patient No.' 
                                            meta:resourcekey="lblPatientNumberHeaderResource1"></asp:Label>
                                    </td>
                                    <td align="center" style="width: 13%" runat="server"   >
                              
                                        <asp:Label ID="LabEpisode" runat="server" Text="Episode " 
                                            meta:resourcekey="LabEpisodeResource1"></asp:Label></td>
                                    <td align="center" style="width: 10%" runat="server">
                                        &nbsp;<asp:Label ID="LabAge" runat="server" Text="Age" 
                                            meta:resourcekey="LabAgeResource1"></asp:Label></td>
                                    <td align="center" style="width: 12%" runat="server">
                                      <asp:Label ID="Labphnum" runat="server" Text="Phone  Number" 
                                            meta:resourcekey="LabphnumResource1"></asp:Label></td>
                                    <td align="center" style="width: 12%" runat="server">
                       <asp:Label ID="LabAdd" runat="server" Text="Address" meta:resourcekey="LabAddResource1"></asp:Label></td>
                                    <td align="center" style="width: 9%" runat="server">
                                        &nbsp;<asp:Label ID="Labepistrtdt" runat="server" Text="Episode Start Date" 
                                            meta:resourcekey="LabepistrtdtResource1"></asp:Label></td>
                                    <td align="center" style="width: 9%" runat="server">
                                      <asp:Label ID="labepienddt" runat="server" Text="Episode End Date" 
                                            meta:resourcekey="labepienddtResource1"></asp:Label>
                                    </td>
                                    <td align="center" style="width: 5%" runat="server">
                                        &nbsp;<asp:Label ID="Labnoofsit" runat="server" Text="No. of Sitting" 
                                            meta:resourcekey="LabnoofsitResource1"></asp:Label></td>
                                        <td align="center" style="width: 2%" runat="server">
                                        &nbsp;
                                    </td>
                                    <td align="center" style="width: 2%" runat="server">
                                        &nbsp;</td>
                                </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                            DataKeyNames="PatientID" OnRowDataBound="grdResult_RowDataBound" 
                                            OnPageIndexChanging="grdResult_PageIndexChanging" 
                                            OnRowCommand="grdResult_RowCommand" meta:resourcekey="grdResultResource1">
                                            <Columns>
                                                <asp:BoundField DataField="PatientNumber" HeaderText="PatientNo" 
                                                    meta:resourcekey="BoundFieldResource1" Visible="False" />
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <table ID="TabChild" runat="server" align="left" width="100%">
                                                            <tr runat="server">
                                                                <td runat="server" nowrap="nowrap" style="width: 2%">
                                                                    <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" 
                                                                        ToolTip="Select Row" />
                                                                </td>
                                                                <td ID="tdName" runat="server" align="left" style="width: 18%">
                                                                    <%# DataBinder.Eval(Container.DataItem, "PatientName") %>
                                                                </td>
                                                                <td ID="tdPatientNo" runat="server" align="left" style="width: 8%">
                                                                    <asp:Label ID="lblPatientNumber" runat="server" 
                                                                        Text='<%# Bind("PatientNumber") %>'></asp:Label>
                                                                </td>
                                                                <td ID="tdEpisode" runat="server" align="left" style="width: 13%">
                                                                    <asp:Label ID="lblEpisode" runat="server" Text='<%# Bind("EpisodeName") %>'></asp:Label>
                                                                </td>
                                                                <td ID="tdAge" runat="server" align="left" nowrap="nowrap" style="width: 10%">
                                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                                </td>
                                                                <td ID="tdPhoneNumbers" runat="server" align="left" style="width:12%">
                                                                    <asp:Label ID="lblMobileNumber" runat="server" Text='<%# Bind("PhoneNo") %>'></asp:Label>
                                                                </td>
                                                                <td ID="tdAddress" runat="server" align="left" style="width: 12%">
                                                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                                </td>
                                                                <td ID="tdEStartDt" runat="server" align="left" style="width: 9%">
                                                                    <%# String.Format("{0:dd/MM/yyyy}",Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "EpisodeStartDt"))) %>
                                                                </td>
                                                                <td ID="tdEEndDt" runat="server" align="left" style="width: 9%">
                                                                    <%# String.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "EpisodeEndDt"))) %>
                                                                </td>
                                                                <td ID="tdENoSit" runat="server" align="left" style="width: 5%">
                                                                    <asp:Label ID="lblENoSit" runat="server" Text='<%# Bind("NoofSitting") %>'></asp:Label>
                                                                </td>
                                                                <td ID="PicPatient" runat="server" align="right" width="2%">
                                                                    <asp:ImageButton ID="imgPatient" runat="server" Height="13px" 
                                                                        ImageUrl="~/Images/PhotoViewer.png" Width="13px" />
                                                                </td>
                                                                <td runat="server" align="left" style="width: 2%">
                                                                    &nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" 
                                                NextPageText="" PageButtonCount="5" PreviousPageText="" />
                                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                    <td align="center" class="defaultfontcolor" runat="server">
                                        <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click" />
                                        <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click" />
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="divFullImage" class="divPicturePopup">
        <img alt="Patient Picture" id="imgPopupPatient" runat="server" src="~/Images/ProfileDefault.jpg" />
    </div>
    <input type="hidden" id="pid" name="pid" />
    <input type="hidden" id="PNumber" name="PNumber" />
    <input type="hidden" id="patOrgID" name="patOrgID" />
  
    <asp:HiddenField ID="ShowID" runat="server" />
    <asp:HiddenField ID="hdnTempPatientid" runat="server" />
    <asp:HiddenField ID="hdnIswardNo" runat="server" />
    <asp:HiddenField id="hdnPatientID" runat="server" />
    <script type="text/javascript" language="javascript">
        function ShowPicture(id, PictureName) {
            var position = $("#" + id).position();
            document.getElementById('<%=imgPopupPatient.ClientID %>').setAttribute('src', '<%=ResolveUrl("~/Reception/PatientImageHandler.ashx?FileName=' + PictureName + '")%>');
            document.getElementById('divFullImage').style.display = 'block';
            document.getElementById('divFullImage').style.left = position.left - 150;
            document.getElementById('divFullImage').style.top = position.top + 20;
        }

        function HidePicture() {
            document.getElementById('divFullImage').style.display = 'none';
        }
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
//        if (document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value == "1" && document.getElementById('<%=AdhdnTempToPeriod.ClientID %>').value == "1") {
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
//        }
//        if (document.getElementById('<%=AdhdnTempFrom.ClientID %>').value != "" && document.getElementById('<%=AdhdnTempTo.ClientID %>').value != "") {
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//        }
    </script>

</asp:Panel>

<script type="text/javascript">
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
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
            document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
            document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
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
    function CheckINPatientSearch() {


    }


    function ShowAdmDate() {
//        document.getElementById('<%=AdtxtFromDate.ClientID %>').value = "";
//        document.getElementById('<%=AdtxtToDate.ClientID %>').value = "";

//        document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = "";
//        document.getElementById('<%=AdhdnTempTo.ClientID %>').value = "";

////        document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value = "0";
////        document.getElementById('<%=AdhdnTempToPeriod.ClientID %>').value = "0";
//        if (document.getElementById('<%=ddlAdmissionDate.ClientID %>').value == "0") {

//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayWeek.ClientID %>').value;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayWeek.ClientID %>').value;

//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayWeek.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayWeek.ClientID %>').value;

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//        }
////        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "1") {
////            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
////            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
////            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayMonth.ClientID %>').value;
////            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayMonth.ClientID %>').value;
////            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayMonth.ClientID %>').value;
////            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayMonth.ClientID %>').value;

////            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
////            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
////            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
////            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
////            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
////            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
////        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "2") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayYear.ClientID %>').value;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayYear.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayYear.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayYear.ClientID %>').value

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';

//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "3") {
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
////            document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value = "1";
//            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "-1") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';


//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "4") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = "";
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = "";
//            document.getElementById('<%=AdtxtFromPeriod.ClientID %>').value = "";
//            document.getElementById('<%=AdtxtToPeriod.ClientID %>').value = "";
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';


//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "5") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekFirst.ClientID %>').value;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekLast.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekFirst.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekLast.ClientID %>').value;

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "6") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthFirst.ClientID %>').value;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthLast.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthFirst.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthLast.ClientID %>').value;

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//        }
//        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "7") {
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
//            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastYearFirst.ClientID %>').value;
//            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastYearLast.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastYearFirst.ClientID %>').value;
//            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastYearLast.ClientID %>').value;

//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
//        }
    }


</script>

