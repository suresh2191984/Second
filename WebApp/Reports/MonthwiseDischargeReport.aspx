<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthwiseDischargeReport.aspx.cs"
    Inherits="Reports_MonthwiseDischargeReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <asp:Label ID="Rs_MonthWiseDisRpt" Text="MonthWise Discharge Report" runat="server"></asp:Label>
    </title>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        <asp:ScriptManager ID="scriptManager2" runat="server">
        </asp:ScriptManager>
        <div id="wrapper">
            <div id="header">
                <div class="logoleft" style="z-index: 2;">
                    <div class="logowrapper">
                        <%--     <img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                    </div>
                </div>
                <div class="middleheader">
                    <uc4:MainHeader ID="MHead" runat="server" />
                    <uc3:Header ID="RHead" runat="server" />
                </div>
                <div style="float: right;" class="Rightheader">
                </div>
            </div>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
                <tr>
                    <td valign="top" id="menu" style="display: none;" class="style2">
                        <div id="navigation">
                            <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                        </div>
                    </td>
                    <td width="85%" valign="top" class="tdspace">
                        <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                            style="cursor: pointer;" />
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <Top:TopHeader ID="TopHeader1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div class="contentdata1">
                            <ul>
                                <li>
                                    <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </li>
                            </ul>
                            <table id="tblCollectionOPIP" align="center" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td align="center">
                                        <div class="dataheaderWider">
                                            <table id="tbl" border="0" cellpadding="0" cellspacing="0" width="58%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        <asp:TextBox ID="txtDisFMon" CssClass="Txtboxverysmall" runat="server" Style="margin-right: 47px"
                                                            meta:resourcekey="txtDisFMonResource1"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="txtDisFMon_CalendarExtender" Format="MMM/yyyy" runat="server"
                                                            OnClientHidden="onCalendarHidden" OnClientShown="onCalendarShown" BehaviorID="calendar1"
                                                            Enabled="True" TargetControlID="txtDisFMon" PopupButtonID="ImageButton1" PopupPosition="TopRight">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtDisFMon"
                                                            Mask="LLL/9999" ClearMaskOnLostFocus="False" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        <asp:TextBox ID="txtDisTMon" CssClass ="Txtboxverysmall" runat="server" meta:resourcekey="txtDisTMonResource1"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="txtEXPDate_CalendarExtender" Format="MMM/yyyy" runat="server"
                                                            OnClientHidden="onCalendarHidden2" OnClientShown="onCalendarShown2" BehaviorID="calendar2"
                                                            Enabled="True" TargetControlID="txtDisTMon" PopupPosition="TopRight">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtDisTMon"
                                                            Mask="LLL/9999" ClearMaskOnLostFocus="False" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                            OnClick="btnSubmit_Click" Width="114px" meta:resourcekey="btnSubmitResource1" />
                                                    </td>
                                                    <td>
                                                        <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                            meta:resourcekey="lnkBackResource1">
                                                            <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                            &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                        <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                            CssClass="details_label_age" OnClick="lnkBack_Click" 
                                                            meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" Height="16px"
                                                        meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </div>
                                        <div id="divPrint" style="display: none;" runat="server">
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <asp:LinkButton ID="lnkExportXL" runat="server" Font-Bold="true"
                                                        Visible="true" Font-Size="12px" ForeColor="#000000" ToolTip="Save As Excel" 
                                                        OnClick="imgBtnXL_Click"><u>Export To XL</u></asp:LinkButton>
                                                         <asp:ImageButton ID="imgBtnXL"  runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                        <b id="printText" runat="server">
                                                            <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                        </b>&nbsp;&nbsp;
                                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div  id="divPrintarea">
                                            <asp:GridView ID="gvMonthwiseDischargeRpt" runat="server" AutoGenerateColumns="False"
                                                ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvMonthwiseDischargeRptResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Period" ItemStyle-Width="25px" HeaderText="Month" meta:resourcekey="BoundFieldResource1">
                                                        <ItemStyle Width="60px"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OpeningBalance" ItemStyle-HorizontalAlign="Right" HeaderText="Opening Balance"
                                                        meta:resourcekey="BoundFieldResource2">
                                                        <%-- <ItemStyle Width="25px"></ItemStyle>--%><ItemStyle HorizontalAlign="Right">
                                                        </ItemStyle>
                                                    </asp:BoundField>
                                                    <%--<asp:BoundField ItemStyle-Width="25px" DataField="DoAdmission" DataFormatString="{0:dd/MM/yyyy}"
                                                                    HeaderText="DOA" />
                                                                <asp:BoundField ItemStyle-Width="25px" DataField="DoDischarge" DataFormatString="{0:dd/MM/yyyy}"
                                                                    HeaderText="DOD" />--%>
                                                    <asp:BoundField DataField="AdmitedPatient" ItemStyle-HorizontalAlign="Right" HeaderText="No of patients Admitted"
                                                        meta:resourcekey="BoundFieldResource3">
                                                        <%-- <ItemStyle Width="25px"></ItemStyle>--%><ItemStyle HorizontalAlign="Right">
                                                        </ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DischargedPatient" ItemStyle-HorizontalAlign="Right" HeaderText="No of Patients Discharged"
                                                        meta:resourcekey="BoundFieldResource4">
                                                        <%--  <ItemStyle Width="25px"></ItemStyle>--%><ItemStyle HorizontalAlign="Right">
                                                        </ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ClosingBalance" ItemStyle-HorizontalAlign="Right" HeaderText="Closing Balance"
                                                        meta:resourcekey="BoundFieldResource5">
                                                        <%--  <ItemStyle Width="25px"></ItemStyle>--%><ItemStyle HorizontalAlign="Right">
                                                        </ItemStyle>
                                                    </asp:BoundField>
                                                    <%-- <asp:BoundField DataField="Due" ItemStyle-Width="25px" HeaderText="Due" />
                                                                <asp:BoundField DataField="ReceivedAmount" ItemStyle-Width="25px" HeaderText="AdvanceAmount" />--%>
                                                    <%--<asp:BoundField DataField ="AdmissionDate"  ItemStyle-Width="25px" HeaderText ="DOA" />
                                        <asp:BoundField DataField ="DateOfDischarge"  ItemStyle-Width="25px" HeaderText ="DOD" />--%>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:UpdatePanel ID="Dayupdatepanel" runat="server">
                                                <ContentTemplate>
                                                    <div id="divOPDWCR" runat="server" style="display: none;">
                                                        <div id="prnReport">
                                                        </div>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                        </div>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">

    function validateToDate() {

        if (document.getElementById('txtDisFMon').value == '') {
            alert('Provide / select value for From date');
            document.getElementById('txtDisFMon').focus();
            return false;
        }
        if (document.getElementById('txtDisTMon').value == '') {
            alert('Provide / select value for To date');
            document.getElementById('txtDisTMon').focus();
            return false;
        }
    }




    function onCalendarShown() {

        var cal = $find("calendar1");
        //Setting the default mode to month
        cal._switchMode("months", true);

        //Iterate every month Item and attach click event to it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }
    }

    function onCalendarHidden() {
        var cal = $find("calendar1");
        //Iterate every month Item and remove click event from it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }

    }

    function call(eventElement) {
        var target = eventElement.target;
        switch (target.mode) {
            case "month":
                var cal = $find("calendar1");
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
        }
    }

    function onCalendarShown2() {

        var cal = $find("calendar2");
        //Setting the default mode to month
        cal._switchMode("months", true);

        //Iterate every month Item and attach click event to it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                }
            }
        }
    }

    function onCalendarHidden2() {
        var cal = $find("calendar2");
        //Iterate every month Item and remove click event from it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                }
            }
        }

    }

    function call2(eventElement) {
        var target = eventElement.target;
        switch (target.mode) {
            case "month":
                var cal = $find("calendar2");
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
        }
    }

        
</script>

<script type="text/javascript" language="javascript">
    function checkDate1(obj) {

        var myValStr = document.getElementById(obj).value;
        if (myValStr != "__/____" && myValStr != "") {
            var Mon = myValStr.split('/')[0];
            var isTrue = false;

            var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');

            for (i = 0; i < myMonth.length; i++) {
                if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                    isTrue = true;
                }
            }

            if (!isTrue) {
                document.getElementById(obj).focus();
                alert("Provide valid date");
            }
            return isTrue;
        }


    }
</script>

<script type="text/javascript" language="javascript">
    function getMonthValue(source) {
        //  var month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var month_names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
        for (var i = 0; i < month_names.length; i++) {
            if (month_names[i] == source) {
                return i;
            }
        }
    }

    function CheckDatesstart(splitChar, ObjDate, flag) {

        var today = new Date();


        if (ObjDate.value.trim() == '__/____') {
            document.getElementById('txtDisFMon').value == '';
            return true;

        }
        else {

            if (ObjDate.value.trim() == '') {
                alert(flag == "START" ? 'Provide Start  Date!' : 'Provide End  Date!');
                ObjDate.select();
                return false;
            }
            else {
                //Assign From And To Date from Controls
                splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
                var DateFrom = new Array(2);
                var DateNow = new Array(2);
                DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
                DateFrom[1] = ObjDate.value.split(splitChar)[1];
                // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
                DateNow[0] = today.getMonth() + 1;
                DateNow[1] = today.getFullYear();
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date
                if (doDateValidation(DateFrom, DateNow, 0)) {
                    //       alert("Validation Succeeded");
                    return true;
                }
                else {
                    ObjDate.select();
                    return false;
                }
            }
        }

    }
    function CheckDatesEnd(splitChar, ObjDate, flag) {

        var today = new Date();

        if (ObjDate.value.trim() == '') {
            alert(flag == "START" ? 'Provide Start  Date!!' : 'Provide End  Date!');
            ObjDate.select();
            return false;
        }
        else {
            //Assign From And To Date from Controls
            splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
            var DateFrom = new Array(2);
            var DateNow = new Array(2);
            DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
            DateFrom[1] = ObjDate.value.split(splitChar)[1];
            // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
            DateNow[0] = today.getMonth() + 1;
            DateNow[1] = today.getFullYear();
            //Argument Value 0 for validating Current Date And To Date 
            //Argument Value 1 for validating Current From And To Date
            if (doDateValidation(DateNow, DateFrom, 1)) {
                //       alert("Validation Succeeded");
                return true;
            }
            else {
                ObjDate.select();
                return false;
            }

        }
        return true;

    }

    function doDateValidation(from, to, bit) {
        var monthFlag = true;
        var i = from.length - 1;
        if (Number(to[i]) >= Number(from[i])) {
            if (Number(to[i]) == Number(from[i])) {
                monthFlag = false;
            }
            i--;
            if (Number(to[i]) >= Number(from[i])) {
                return true;
            }
            else if (monthFlag) {
                return true;
            }
            else {
                if (bit == 0) {
                    alert('Mismatch Month Between Current & Start Date');
                }
                else {
                    alert('Mismatch Month Between Current & end Date');
                }
                return false;
            }
        }
        else {
            if (bit == 0) {
                alert('Mismatch Year Between Current & start Date');
            }
            else {
                alert('Mismatch Year Between Current & end Date');
            }
            return false;
        }
    }
    function popupprint() {
        var prtContent = document.getElementById('divPrintarea');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
        return false;
    }

        
</script>

