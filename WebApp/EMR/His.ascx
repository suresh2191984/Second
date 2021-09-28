<%@ Control Language="C#" AutoEventWireup="true" CodeFile="His.ascx.cs" Inherits="EMR_His" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<%@ Register Src="~/CommonControls/ComplaintICDCodeBP.ascx" TagName="ComplaintICDCodeBP"
    TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/PatientPreference.ascx" TagName="PatientPreference"
    TagPrefix="uc13" %>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

<%--<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>--%>

<script language="javascript" type="text/javascript">
    /* Common Alert Validation */
    var AlertType;
    $(document).ready(function() {
    AlertType = SListForAppMsg.Get('EMR_His_ascx_Alert') == null ? "Alert" : SListForAppMsg.Get('EMR_His_ascx_Alert');
    });

    function datePick(objDate) {

        NewCal(objDate, 'ddmmyyyy', true, 12)

    }
    function GetValuefromParentPage() {

    }
    //Only numbers will allowed
    function isNumeric(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 0) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }
    //only text allowed
    function isSpclChar(e) {
        var key;
        var isCtrl = false;

        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }

        return isCtrl;
    }

    function onEditedcheck(id) {

        alert(id);
        alert(id);


    }
    function popupprintEMRHistory() {
        var prtContent = document.getElementById('TRFUC_UcHistory_divviewHistory');
        document.getElementById("<%=PatientNameLbl.ClientID%>").style.display = 'block';
        document.getElementById("<%=PatientIdLbl.ClientID%>").style.display = 'block';
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        document.getElementById("<%=PatientNameLbl.ClientID%>").style.display = 'none';
        document.getElementById("<%=PatientIdLbl.ClientID%>").style.display = 'none';
    }

    function validateFastingduration() {
        /* Added By Venkatesh S */
        var vValidate = SListForAppMsg.Get('EMR_His_ascx_01') == null ? "Please Enter value should be less then 24 Hours" : SListForAppMsg.Get('EMR_His_ascx_01');
        AlertType = SListForAppMsg.Get('EMR_His_ascx_Alert') == null ? "Alert" : SListForAppMsg.Get('EMR_His_ascx_Alert');
        var isreturn;
        var Hour = document.getElementById('txtHours').value.trim() == "" ? 0 : parseInt(document.getElementById('txtHours').value.trim());
        if (Hour == 0) {
            isreturn = true;
        }
        else {
            if (Hour >= 23) {
                isreturn = true;
            }
            else {
                //alert('Please Enter value should be less then 24 Hours');
                ValidationWindow(vValidate, AlertType);
                isreturn = false;
            }
        }
        return isreturn;
    }
    
    function AddAttributesItemList() {
        /* Added By Venkatesh S */
        var vAttAddedSuccessfully = SListForAppMsg.Get('EMR_His_ascx_02') == null ? "Attributes Added Successfully" : SListForAppMsg.Get('EMR_His_ascx_02');
        var vAttReq = SListForAppMsg.Get('EMR_His_ascx_03') == null ? "Attributes Required" : SListForAppMsg.Get('EMR_His_ascx_03');
        AlertType = SListForAppMsg.Get('EMR_His_ascx_Alert') == null ? "Alert" : SListForAppMsg.Get('EMR_His_ascx_Alert');
        var i = 0;
        var textvalue;
        var AttributeName = new Array();
        var AttributeValueName = new Array();

        document.getElementById('billPart_hdnAttributesList').value = '';
        

        for (i = 1; i < document.getElementById('billPart_UctHistory_tblAtt').getElementsByTagName("tr").length; i++) {
            var txtValue = ('billPart_UctHistory_txtAttribute' + i)
            textvalue = document.getElementById(txtValue).value;
            if (((textvalue).Text != "") && ((textvalue).value != "undefined")) {
                AttributeName = "Attribute" + i;
                AttributeValueName = textvalue;
                if (AttributeValueName != "") {
                    document.getElementById('billPart_hdnAttributesList').value += AttributeName + '^' + AttributeValueName + '^';
                }

            }
        }
        if (document.getElementById('billPart_hdnAttributesList').value != "") {
            //alert('Attributes Added Successfully');
            ValidationWindow(vAttAddedSuccessfully, AlertType);
        }
        else {
            //alert('Attributes Required');
            ValidationWindow(vAttReq, AlertType);
        }
        return false;
    }
    function CompareDate(obj) {

        /* Added By Venkatesh S */
        var vDay = SListForAppMsg.Get('EMR_His_ascx_04') == null ? "Please select a valid day!" : SListForAppMsg.Get('EMR_His_ascx_04');
        var vMonth = SListForAppMsg.Get('EMR_His_ascx_05') == null ? "Please select a valid month!" : SListForAppMsg.Get('EMR_His_ascx_05');
        var vYear = SListForAppMsg.Get('EMR_His_ascx_06') == null ? "Please select a valid year!" : SListForAppMsg.Get('EMR_His_ascx_06');
        var vValidDate = SListForAppMsg.Get('EMR_His_ascx_07') == null ? "Date selected by you is not a valid date!" : SListForAppMsg.Get('EMR_His_ascx_07');
        var vCurrentDate = SListForAppMsg.Get('EMR_His_ascx_08') == null ? "LMP date cannot be greater than current date!" : SListForAppMsg.Get('EMR_His_ascx_08');
        var v365days = SListForAppMsg.Get('EMR_His_ascx_09') == null ? "LMP date cannot be less than 365 days!" : SListForAppMsg.Get('EMR_His_ascx_09');
        AlertType = SListForAppMsg.Get('EMR_His_ascx_Alert') == null ? "Alert" : SListForAppMsg.Get('EMR_His_ascx_Alert');
        try {
            var selectedDate = document.getElementById(obj).value;
            if (selectedDate != "" && selectedDate != "__/__/____") {
                var lstDates = selectedDate.split('/');
                day = lstDates[0];  // take day
                if (day == 0) {
                    //alert("Please select a valid day!");
                    ValidationWindow(vDay, AlertType);
                    document.getElementById(obj).focus();
                    return false;
                }

                month = lstDates[1];  // take month
                if (month == 0) {
                    //alert("Please select a valid month!");
                    ValidationWindow(vMonth, AlertType);
                    document.getElementById(obj).focus();
                    return false;
                }

                year = lstDates[2];  // take year

                if (year == 0) {
                    //alert("Please select a valid year!");
                    ValidationWindow(vYear, AlertType);
                    document.getElementById(obj).focus();
                    return false;
                }

                // validate date selected by user
                if (!isValidDate(year, month, day)) {
                    //alert("Date selected by you is not a valid date!");
                    ValidationWindow(vValidDate, AlertType);
                    document.getElementById(obj).value = '';
                    return false;
                }

                // check whether select date is <= system date

                var curdate = new Date(); // get system date
                var backDate = new Date();
                backDate.setDate(backDate.getDate() - 365);

                // convert system date to milliseconds from 1-1-1970 using  UTC function of Date object
                curdate_utc = Date.UTC(curdate.getFullYear(), curdate.getMonth(), curdate.getDate(), 0, 0, 0, 0);
                backdate_utc = Date.UTC(backDate.getFullYear(), backDate.getMonth(), backDate.getDate(), 0, 0, 0, 0);

                // convert date selected by user also to milliseconds from 1-1-1970
                dj_utc = Date.UTC(year, month - 1, day, 0, 0, 0, 0);  // month is 0 to 11 not 1 to 12

                if (dj_utc > curdate_utc) {
                    //alert("LMP date cannot be greater than current date!");
                    ValidationWindow(vCurrentDate, AlertType);
                    document.getElementById(obj).value = '';
                    document.getElementById(obj).focus();
                    return false;
                }
                if (dj_utc < backdate_utc) {
                    //alert("LMP date cannot be less than 365 days!");
                    ValidationWindow(v365days, AlertType);
                    document.getElementById(obj).value = '';
                    document.getElementById(obj).focus();
                    return false;
                }

                return true; // valid date
            }
        }
        catch (e) {
            return false;
        }
    }

    // Validates the date and returns true if date is valid otherwise false
    function isValidDate(year, month, day) {
        try {
            var d = new Date(year, month - 1, day);  // month is 0 to 11

            // compare the value back to orginal values then it is a valid date.
            if (d.getFullYear() != year || d.getMonth() != month - 1 || d.getDate() != day)
                return false;
            else
                return true;
        }
        catch (e) {
            return false;
        }
    }
</script>

<div id="divFH3" style="display: block;" title="Patient History" class="a-center w-100p">
    <div id="divStatus" style="display: none;" title="ErrorStatus" runat="server" class="w-100p">
        <table class="dataheaderInvCtrl w-98p">
            <tr>
                <td>
                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <table id="trBackground_Problem_Patient_Preference" class="w-100p a-center" style="display: none;">
         <tr class="defaultfontcolor">
            <td style="color: #000;" class="a-center bold h-6 font12">
                <asp:Label ID="Label2" runat="server" Text="PATIENT HISTORY" meta:resourcekey="Label2Resource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td valign="top" class="style5">
                <table class="w-100p">
                    <tr>
                        <td class="style6 v-top" style="height:auto; width:400px;">
                            <table class="w-80p">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBackgroundProblems" runat="server" Text="Background Problems" meta:resourcekey="lblBackgroundProblems1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <uc12:ComplaintICDCodeBP ID="ComplaintICDCodeBP1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="style6 v-top" style="height:auto;">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPreference" runat="server" Text="Enter Patient Preference" meta:resourcekey="lblPreference1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="paddingT4">
                                        <uc13:PatientPreference ID="PatientPreference1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table id="tblMain" style="display: none;" runat="server" class="a-center w-98p h-100">
        <tr class="a-center">
            <td class="v-top">
                <asp:UpdatePanel ID="udphistory" runat="server">
                    <ContentTemplate>
                        <table border="0" class="dataheader1" id="tableHistory" runat="server" style="display: table;"
                            width="90%">
                            <tr id="tr1PatientHistory_LMP_1097" runat="server" style="display: none;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkLMP" runat="server" Text="LMP" meta:resourcekey="chkLMPResource1" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divchkLMP" runat="server" style="display: none;">
                                                    <table border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLMPDate" runat="server" CssClass="defaultfontcolor" Text="LMP Date"
                                                                    Visible="False" meta:resourcekey="lblLMPDateResource1"></asp:Label>
                                                                &nbsp;&nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLMP" runat="server" CssClass="textfield" MaxLength="1" Style="text-align: justify"
                                                                    TabIndex="4" ValidationGroup="MKE" onchange="CompareDate(this.id);" onblur="CompareDate(this.id);"
                                                                    meta:resourcekey="txtLMPResource1" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtLMP" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    Enabled="True" ClearTextOnInvalid="true" />
                                                                <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                                    TargetControlID="txtLMP" Enabled="True" />
                                                                <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    meta:resourcekey="ImgBntCalcResource1" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                    ControlToValidate="txtLMP" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trFasting_Duration_1098" runat="server" style="display: none;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkFasting_Duration" runat="server" Text="Fasting Duration (hours)"
                                                    meta:resourcekey="ChkFasting_DurationResource1" />
                                            </td>
                                            <td>
                                                <div id="divFasting_Duration" runat="server" style="display: none;">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblFasting_Duration" runat="server" Text="Fasting Duration (hours)"
                                                                    Visible="False" meta:resourcekey="lblFasting_DurationResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtHours" runat="server" CssClass="textfield" Width="30px" onKeyDown="return isNumeric(event,this.id)"
                                                                    MaxLength="2" meta:resourcekey="txtHoursResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trLastMealTime_1099" runat="server" style="display: none;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkLastMealTime" runat="server" Text="Last Meal Time" meta:resourcekey="ChkLastMealTimeResource1" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divLastMealTime" runat="server" style="display: none; z-index:99999999">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtDateTime" runat="server" CssClass="textfield" MaxLength="1" Style="text-align: justify"
                                                                    ValidationGroup="MKE" Width="145px" ToolTip="dd-MM-yyyy hh:mm:ssAM/PM" meta:resourcekey="txtDateTimeResource1" />
                                                               <%-- <img onclick="return datePick('<%= txtDateTime.ClientID %>')" style="cursor: hand;"
                                                                    id="img1" src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0"
                                                                    alt="Pick a date" />--%>
                                                                <a href="javascript:NewCssCal('<%= txtDateTime.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date and time"></a> 
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trRecent_Sonography_Report_1100" runat="server" style="display: none;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkRecent_Sonography_Report" runat="server" Text="Recent Sonography Report"
                                                    meta:resourcekey="ChkRecent_Sonography_ReportResource1" />
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <div id="divRecent_Sonography_Report" runat="server" style="display: none;">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label1" Text="Date" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtRecent_Sonography_ReportDate" runat="server" CssClass="textfield"
                                                                    MaxLength="1" Style="text-align: justify" TabIndex="4" ValidationGroup="MKE"
                                                                    meta:resourcekey="txtRecent_Sonography_ReportDateResource1" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtRecent_Sonography_ReportDate"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender33" runat="server" Format="dd/MM/yyyy"
                                                                    PopupButtonID="ImageButton3" TargetControlID="txtRecent_Sonography_ReportDate"
                                                                    Enabled="True" />
                                                                <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    meta:resourcekey="ImageButton3Resource1" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                                    ControlToValidate="txtRecent_Sonography_ReportDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                                    EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                    TooltipMessage="(dd/mm/yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator3"
                                                                    meta:resourcekey="MaskedEditValidator3Resource1" />
                                                            </td>
                                                            <td class="a-center">
                                                                <asp:Label ID="lblComments" Text="Comments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtRecent_Sonography_ReportComments" TextMode="MultiLine" Height="68px"
                                                                    Width="221px" runat="server" meta:resourcekey="txtRecent_Sonography_ReportCommentsResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trurine_volume_Collected_1101" runat="server" style="display: none;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkurine_volume_Collected" runat="server" Text="24h Urine volume Collected in Ml"
                                                    meta:resourcekey="chkurine_volume_CollectedResource1" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divurine_volume_Collected" runat="server" style="display: none;">
                                                    <table border="0">
                                                        <tr>
                                                            <td  style="display: none;">
                                                                <asp:Label ID="lblHeight" runat="server" Text="Height" meta:resourcekey="lblHeightResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtHeight" Width="40px" runat="server" CssClass="textfield" Style="text-align: justify"
                                                                    onKeyDown="return  isNumeric(event,this.id)" MaxLength="4" meta:resourcekey="txtHeightResource1" />
                                                               <%-- CM--%>
                                                            </td>
                                                            <td  style="display: none;">
                                                                <asp:Label ID="lblWeight" runat="server" Text="Weight" meta:resourcekey="lblWeightResource1"></asp:Label>
                                                            </td>
                                                            <td  style="display: none;"> 
                                                                <asp:TextBox ID="txtWeight" runat="server" Width="40px" onKeyDown="return  isNumeric(event,this.id)"
                                                                    MaxLength="3" meta:resourcekey="txtWeightResource1"></asp:TextBox>
                                                               <%-- KG--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trAbstinence_days_1102" runat="server" style="display: table-row;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkAbstinence_days" runat="server" Text="Abstinence days" meta:resourcekey="ChkAbstinence_daysResource1" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divAbstinence_days" runat="server" style="display: block;">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblAbstinence_days" runat="server" Text="Abstinence days" Visible="False"
                                                                    meta:resourcekey="lblAbstinence_daysResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtAbstinence_days" runat="server" CssClass="textfield" Width="30px"
                                                                    onKeyDown="return  isNumeric(event,this.id)" MaxLength="3" meta:resourcekey="txtAbstinence_daysResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trOn_anti_thyroid_disease_drugs_1103" runat="server" style="display: table-row;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkOn_anti_thyroid_disease_drugs" runat="server" Text="On anti-thyroid disease drugs"
                                                    meta:resourcekey="ChkOn_anti_thyroid_disease_drugsResource1" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divOn_anti_thyroid_disease_drugs" runat="server" style="display: block;">
                                                    <table border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblOn_anti_thyroid_disease_drugs" runat="server" Text="On anti-thyroid disease drugs"
                                                                    Visible="False" meta:resourcekey="lblOn_anti_thyroid_disease_drugsResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCheck" runat="server" meta:resourcekey="ddlCheckResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trReading_taken_between_48_72_hrs_1104" runat="server" style="display: table-row;">
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkReading_taken_between_48_72_hrs" runat="server" Text="Reading taken between 48hrs - 72 hrs" />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <div id="divReading_taken_between_48_72_hrs" runat="server" style="display: block;">
                                                    <table border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblFreeText" runat="server" Text="FreeText" Visible="False" meta:resourcekey="lblFreeTextResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtFreeText" TextMode="MultiLine" Height="68px" Width="221px" runat="server"
                                                                    meta:resourcekey="txtFreeTextResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trDynamicControlsTable" runat="server" style="display: table-row;">
                                <td>
                                    <table id="tblDynamicControls" class="dataheaderInvCtrl w-100p" style="display: none;" 
									runat="server">
                                        <tr class="dataheader1">
                                            <td class="w-10p">
                                                <asp:Label ID="Label10" runat="server" Text="Select" meta:resourcekey="Label10Resource1"></asp:Label>
                                            </td>
                                            <td class="w-50p">
                                                <asp:Label ID="Label11" runat="server" Text="History Name" meta:resourcekey="Label11Resource1"></asp:Label>
                                            </td>
                                            <td class="w-40p">
                                                <asp:Label ID="Rs_Date" runat="server" Text="Histrory Value" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" Visible="False"
                                        meta:resourcekey="btnSaveResource1"></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <table id="tblAtt" class="w-98p a-center bold" runat="server">
        <tr>
            <td>
               <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_01%>  
            </td>
        </tr>
        <tr>
            <td>
                <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_02%>   
                <asp:TextBox ID="txtAttribute1" Height="50px" Width="221px" TextMode="MultiLine"
                    runat="server" meta:resourcekey="txtAttribute1Resource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_03%>  
                <asp:TextBox ID="txtAttribute2" Height="50px" Width="221px" TextMode="MultiLine"
                    runat="server" meta:resourcekey="txtAttribute2Resource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
               <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_04%>  
                <asp:TextBox ID="txtAttribute3" Height="50px" Width="221px" TextMode="MultiLine"
                    runat="server" meta:resourcekey="txtAttribute3Resource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_05%>
                <asp:TextBox ID="txtAttribute4" Height="50px" Width="221px" TextMode="MultiLine"
                    runat="server" meta:resourcekey="txtAttribute4Resource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
               <%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_06%> 
                <asp:TextBox ID="txtAttribute5" Height="50px" Width="221px" TextMode="MultiLine"
                    runat="server" meta:resourcekey="txtAttribute5Resource1"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblBtnAtt" runat="server" class="w-100p">
        <tr>
            <td class="a-center">
                <table class="w-100p">
                    <tr>
                        <td class="a-right">
                           <%-- <input id="Btsave" runat="server" class="btn" type="button" value="Save" onclick="AddAttributesItemList();onDntShowAttributes();" />--%>
                            <button id="Btsave" class="btn"  onclick="AddAttributesItemList();onDntShowAttributes();return false;" meta:resourcekey="BtsaveResource1"><%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_14%> </button>
                        </td>
                        <td class="a-left">
                           <%-- <input id="Butclose" runat="server" class="btn" type="button" value="Close" onclick="onDntShowAttributes();" />--%>
                            <button id="Butclose" class="btn"  onclick="onDntShowAttributes(); return false;" meta:resourcekey="ButcloseResource2"><%=Resources.PlatForm_ClientDisplay.PlatForm_CommonControls_His_ascx_15%></button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div id="tblhistoryview" runat="server" class="a-center">
            </div>
            <div id="tblbackgroundProbview" runat="server" class="a-center paddingT10">
            </div>
            <div id="tblpatientPreferenceview" runat="server" class="a-center paddingT10">
            </div>
            <div id="divviewHistory" runat="server" style="display: none;" title="Patient History"
                class="dataheader11 w-100p">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="PatientIdLbl" runat="server" Font-Bold="True" Style="display: none;"
                                meta:resourcekey="PatientIdLblResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="PatientNameLbl" runat="server" Font-Bold="True" Style="display: none;"
                                meta:resourcekey="PatientNameLblResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div id="divViewHeader" style="display: none; width: 100%" title="View History" runat="server">
                    <table class="w-90p">
                        <tr>
                            <td class="a-center">
                                <asp:Label ID="Label3" runat="server" Text="Patient History" Font-Bold="True" meta:resourcekey="Label3Resource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <table id="tableResult" runat="server" style="display: table;" class="w-90p">
                    <tr id="tr1" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelLMP" runat="server" Text="LMP" Font-Bold="True" meta:resourcekey="LabelLMPResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td class="a-left">
                                        :
                                        <asp:Label ID="lblLMPValue" runat="server" Width="145px" meta:resourcekey="lblLMPValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr2" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelFasting_Duration" runat="server" Text="Fasting Duration (hours)"
                                            Font-Bold="True" meta:resourcekey="LabelFasting_DurationResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td class="a-left">
                                        :
                                        <asp:Label ID="lblFasting_DurationValue" runat="server" meta:resourcekey="lblFasting_DurationValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr3" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelLast_Meal_Time" runat="server" Text="Last Meal Time" Font-Bold="True"
                                            meta:resourcekey="LabelLast_Meal_TimeResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td class="a-left">
                                        :
                                        <asp:Label ID="lblLast_Meal_TimeValue" runat="server" meta:resourcekey="lblLast_Meal_TimeValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr4" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td valign="top">
                                        <asp:Label ID="LabelRecent_Sonography_Report" runat="server" Text="Recent Sonography Report"
                                            Font-Bold="True" meta:resourcekey="LabelRecent_Sonography_ReportResource1" />
                                        &nbsp; &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="1" class="w-100p">
                                            <tr>
                                                <td class="w-35p">
                                                    <b>Report Date</b>
                                                </td>
                                                <td class="w-45p">
                                                    <asp:Label ID="lblReportDateValue" runat="server" meta:resourcekey="lblReportDateValueResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="w-35p">
                                                    <b>Report Comments</b>
                                                </td>
                                                <td class="w-45p a-center">
                                                    <asp:Label ID="lblReportCommentValue" runat="server" meta:resourcekey="lblReportCommentValueResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr5" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelUrine_volume_Collected" runat="server" Text="24h Urine volume Collected in Ml"
                                            Font-Bold="True" meta:resourcekey="LabelUrine_volume_CollectedResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td>
                                        <table border="1">
                                            <tr>
                                                <td>
                                                    Height (Cm)
                                                </td>
                                                <td>
                                                    Weight (Kg)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblHeightValue" runat="server" meta:resourcekey="lblHeightValueResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblWeightValue" runat="server" meta:resourcekey="lblWeightValueResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr6" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelAbstinence_days" runat="server" Text="Abstinence days" Font-Bold="True"
                                            meta:resourcekey="LabelAbstinence_daysResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td>
                                        :
                                        <asp:Label ID="lblAbstinence_daysValue" runat="server" meta:resourcekey="lblAbstinence_daysValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr7" runat="server" style="display: none; overflow: scroll;" class="a-center w-100p">
                        <td class="a-center">
                            <table class="a-center" id="EMRHistory" runat="server">
                                <tr class="a-center">
                                    <%--<td>
                                        <asp:Label ID="LabelThyroid_Disease" runat="server" Text="On anti-thyroid disease drugs"
                                            Font-Bold="true" />
                                        &nbsp;&nbsp;
                                    </td>--%>
                                    <td>
                                        <div style="height: 480px; overflow-y: auto; padding-top: 5px;">
                                            <%-- : <asp:Label ID="lblThyroid_Disease_Value" runat="server"></asp:Label>--%>
                                            <asp:GridView ID="grdHistory" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView"
                                                Style="width: 735px;" EmptyDataText="There is no history for this User!!" meta:resourcekey="grdHistoryResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No." meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1%>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="8%" />
                                                </asp:TemplateField>
                                                    <asp:BoundField DataField="TestName" ItemStyle-Wrap="true" HeaderText="Test Name">
                                                        <ItemStyle Wrap="True"></ItemStyle>
                                                    </asp:BoundField>
                                                <asp:BoundField DataField="HistoryName" ItemStyle-Wrap="true" HeaderText="Attribute"
                                                    meta:resourcekey="BoundFieldResource1">
                                                    <ItemStyle Wrap="True"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="AttributeValueName" HeaderText="Value" meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField DataField="ModifiedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    HeaderText="Visit Date Time" ItemStyle-Width="120" meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle Width="120px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CreatedUserName" HeaderText="Recorded By" meta:resourcekey="BoundFieldResource4" />
                                                <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    HeaderText="Recorded At" meta:resourcekey="BoundFieldResource5" />
                                            </Columns>
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                            <br />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr8" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LabelReading_taken_between_48_72_hrs" runat="server" Text="Reading taken between 48hrs - 72 hrs"
                                            Font-Bold="True" meta:resourcekey="LabelReading_taken_between_48_72_hrsResource1" />
                                        &nbsp;&nbsp;
                                    </td>
                                    <td>
                                        :
                                        <asp:Label ID="lblReading_taken_between_48_72_hrs_Value" runat="server" meta:resourcekey="lblReading_taken_between_48_72_hrs_ValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:HiddenField ID="hdnAttributeList" runat="server" />
            <asp:HiddenField ID="hdnHistoryIds" runat="server" />
            <asp:HiddenField ID="hdnPatientHistoryAttribute" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<%--<asp:HiddenField ID="hdnFamilyHistory" runat="server" />
<asp:HiddenField ID="hdnTempFamilyHistory" runat="server" />
<asp:HiddenField ID="hdnFamilyHistoryExists" runat="server" />
<asp:HiddenField ID="hdnAllergy" runat="server" />
<asp:HiddenField ID="hdnAllergyValue" runat="server" />
<asp:HiddenField ID ="hdnAllergyDet" runat ="server" />
<asp:HiddenField ID ="hdnHistoryID" runat ="server" />--%>
<asp:HiddenField ID="hdnConfig" runat="server" />
<asp:HiddenField ID="hdnHistoryList" runat="server" />
<asp:HiddenField ID="hdnHistoryAttributeList" runat="server" />
<asp:HiddenField ID="hdnSaveHisStatus" runat="server" />
<asp:HiddenField ID="hdnInvestigationID" runat="server" />
<asp:HiddenField ID="hdnTypevalue" runat="server" />
<asp:HiddenField ID="hdnPreference" runat="server" />
<asp:HiddenField ID="hdnAttributeValue" runat="server" />
<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script> 