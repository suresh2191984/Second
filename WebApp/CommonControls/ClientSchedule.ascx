<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClientSchedule.ascx.cs"
    Inherits="CommonControls_ClientSchedule" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 283px;
    }
    
   
    
    .RowStyle {
  height: 30px;
}
.AlternateRowStyle {
  height: 30px;
}
    
</style>

<script language="javascript" type="text/javascript">

    var AlertType;

    function IAmSelected(source, eventArgs) {

        var varGetVal = eventArgs.get_value();
        //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
        var ID;


        //            eventArgs.get_value()[0].PatientID;
        var list = eventArgs.get_value().split('^');
        if (list.length > 0) {
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    ID = list[0];
                    document.getElementById('CSchedule_hdnClientID').value = ID;



                }
            }


        }
    }
    //////////////////////////
    function ChkAllBox(sender) {

        var chkArrayMain = new Array();
        chkArrayMain = document.getElementById('CSchedule_hdnchkAll').value.split('~');
        if (document.getElementById(sender).checked) {
            for (var i = 0; i < chkArrayMain.length; i++) {
                document.getElementById(chkArrayMain[i]).checked = true;
            }
        }
        else {
            for (var i = 0; i < chkArrayMain.length; i++) {
                document.getElementById(chkArrayMain[i]).checked = false;
            }
        }
    }
    //////////Added by prabakar for multiple select  option using grid checkbox  row 21-09-2013/
    function SelectBatch(chkbxID, ExternalVisitID) {
        try {
            UnSelectedPatientList = document.getElementById('CSchedule_hdnUnSelectedClients').value;
            if (!($('#' + chkbxID).attr('checked'))) {
                if (UnSelectedPatientList == '')
                    document.getElementById('CSchedule_hdnUnSelectedClients').value = ExternalVisitID + '~';
                else
                    document.getElementById('CSchedule_hdnUnSelectedClients').value += ExternalVisitID + '~';
            }
            else {
                Collections = UnSelectedPatientList.split('~');
                document.getElementById('CSchedule_hdnUnSelectedClients').value = '';
                if (Collections.length > 0) {
                    for (var i = 0; i < Collections.length; i++) {
                        if (Collections[i] != '') {
                            if (Collections[i] != ExternalVisitID) {
                                document.getElementById('CSchedule_hdnUnSelectedClients').value += Collections[i] + '~';
                            }
                        }
                    }
                }
            }
        }
        catch (e) {
            return false;
        }
    }

    //////////////End/////////////////
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
        //*************To block slash(/) into text box change the key value to 48***************************//
        if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }
        return isCtrl;
    }



    function CheckToSaveData() {
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        
        var vFromDate = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_01') == null ? "Please Select FromDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_01');
        var vToDate = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_02') == null ? "Please Select ToDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_02');

        var customerType = document.getElementById('CSchedule_drpCustomerType').value;
        var fromDate = document.getElementById('CSchedule_txtFrom').value;
        var toDate = document.getElementById('CSchedule_txtTo').value;

        //        if (customerType == '0') {
        //            alert('Please Select Business Type');
        //            document.getElementById('CSchedule_drpCustomerType').focus();
        //            //return false;
        //        }
        //else
        if (fromDate == '') {
            //alert('Please Select FromDate');
            ValidationWindow(vFromDate, AlertType);
            document.getElementById('CSchedule_txtFrom').focus();
            return false;
        }
        else if (toDate == '') {
            //alert('Please Select ToDate');
            ValidationWindow(vToDate, AlertType);
            document.getElementById('CSchedule_txtTo').focus();
            return false;
        }

    }

    function ValidFromDate(obj, StartDt, wedFlag, BAflage) {
        /* Added By Venkatesh S */
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        
        var vGreaterDateValidation = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_03') == null ? "Selected Date Must Be Greater than CurrentDate or CurrentDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_03');
        var vLessDateValidation = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_04') == null ? "Selected Date Must Be Less than CurrentDate or CurrentDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_04');

        var obj = document.getElementById(obj);
        var currentTime;
        if (obj.value != '' && obj.value != '01/01/1901' && obj.value != '__/__/____') {
            dobDt = obj.value.split('/');
            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            var mMonth = dobDtTime.getMonth() + 1;
            var mDay = dobDtTime.getDate();
            var mYear = dobDtTime.getFullYear();
            if (wedFlag == 0) {
                currentTime = new Date();
            }
            else {
                wedDt = document.getElementById(StartDt).value.split('/');
                var currentTime = new Date(wedDt[2] + '/' + wedDt[1] + '/' + wedDt[0]);
            }
            var month = currentTime.getMonth() + 1;
            var day = currentTime.getDate();
            var year = currentTime.getFullYear();
            if (BAflage == 0) {
                if (mYear > year) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\ClientSchedule.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        //alert('Selected Date Must Be Greater than CurrentDate or CurrentDate');
                        ValidationWindow(vGreaterDateValidation, AlertType);
                    }
                    obj.value = '__/__/____';
                    obj.focus();
                    return false;
                }
                else if (mYear == year && mMonth > month) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\ClientSchedule.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(vGreaterDateValidation, AlertType);
                    }
                    obj.value = '__/__/____';
                    obj.focus();
                    return false;
                }
                else if (mYear == year && mMonth == month && mDay > day) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\ClientSchedule.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        ValidationWindow(vLessDateValidation, AlertType);
                    }
                    obj.value = '__/__/____';
                    obj.focus();
                    return false;
                }
            }
        }

        var FromDate = document.getElementById('CSchedule_txtFrom').value;
        document.getElementById('CSchedule_hdnFromDate').value = FromDate;

    }


    function ValidToDate(obj1, StartDt, wedFlag, BAflage) {
        /* Added By Venkatesh S */
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        
        var vGreaterDateValidation = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_03') == null ? "Selected Date Must Be Greater than CurrentDate or CurrentDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_03');
        var vLessDateValidation = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_04') == null ? "Selected Date Must Be Less than CurrentDate or CurrentDate" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_04');

        var obj1 = document.getElementById(obj1);
        var currentTime;
        if (obj1.value != '' && obj1.value != '01/01/1901' && obj1.value != '__/__/____') {
            dobDt = obj1.value.split('/');
            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            var mMonth = dobDtTime.getMonth() + 1;
            var mDay = dobDtTime.getDate();
            var mYear = dobDtTime.getFullYear();
            if (wedFlag == 0) {
                currentTime = new Date();
            }
            else {
                wedDt = document.getElementById(StartDt).value.split('/');
                var currentTime = new Date(wedDt[2] + '/' + wedDt[1] + '/' + wedDt[0]);
            }
            var month = currentTime.getMonth() + 1;
            var day = currentTime.getDate();
            var year = currentTime.getFullYear();
            if (BAflage == 0) {
                if (mYear > year) {
                    var userMsg = SListForAppMsg.Get('CommonControls\\ClientSchedule.ascx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        ValidationWindow(vGreaterDateValidation, AlertType);
                    }
                    obj1.value = '__/__/____';
                    obj1.focus();
                    return false;
                }
                else if (mYear == year && mMonth > month) {
                var userMsg = SListForAppMsg.Get('CommonControls\\ClientSchedule.ascx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        ValidationWindow(vGreaterDateValidation, AlertType);
                    }
                    obj1.value = '__/__/____';
                    obj1.focus();
                    return false;
                }
                else if (mYear == year && mMonth == month && mDay > day) {
                var userMsg = SListForAppMsg.Get('CommonControls\\ClientSchedule.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        ValidationWindow(vLessDateValidation, AlertType);
                    }
                    obj1.value = '__/__/____';
                    obj1.focus();
                    return false;
                }
            }
        }

        var FromDate = document.getElementById('CSchedule_txtTo').value;
        document.getElementById('CSchedule_hdnToDate').value = FromDate;

    }

    function checkForValues() {
        /* Added By Venkatesh S */
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        
        var vPageNo = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_05') == null ? "Please Enter Page No" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_05');
        var vCorrectPageNo = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_06') == null ? "Please Enter Correct Page No" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_06');
        var vScheduleSuccess = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_07') == null ? "Invoice Scheduled Successfully" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_07');
        
        if (document.getElementById('CSchedule_txtpageNo').value == '') {
            //alert('Please Enter Page No');
            ValidationWindow(vPageNo, AlertType);
            return false;
        }

        if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
            //alert('Please Enter Correct Page No');
            ValidationWindow(vCorrectPageNo, AlertType);
            return false;
        }

        if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
            //alert('Please Enter Correct Page No');
            ValidationWindow(vCorrectPageNo, AlertType);
            return false;
        }
    }

    function AutoInvoice() {
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        var vScheduleSuccess = SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_07') == null ? "Invoice Scheduled Successfully" : SListForAppMsg.Get('CommonControls_ClientSchedule_ascx_07');
    
        //alert('Invoice Scheduled Successfully');
        ValidationWindow(vScheduleSuccess, AlertType);
        return false;
    }

    function ValidatebillSupplyNumber() {
        AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        var vScheduleSuccess = document.getElementById('CSchedule_hdnbillSupplyNumber').value + "<br/> <br/> We Cannot Generate Invoice for above mentioned Clients, because of Bill Supply Number is missing";

        //alert('Invoice Scheduled Successfully');
        ValidationWindow(vScheduleSuccess, AlertType);
        return false;
    }
</script>

<asp:UpdateProgress ID="prog1" runat="server">
    <ProgressTemplate>
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlPSearch" runat="server" CssClass="w-100p">
            <table class="dataheader3 w-100p defaultfontcolor" style="height: auto">
                <tr>
                    <td colspan="7">
                        <table>
                            <tr>
                                <td>
                                    <asp:RadioButton ID="RdoNonSch" runat="server" AutoPostBack="True" GroupName="RdoClient"
                                        OnCheckedChanged="RdoNonSch_CheckedChanged" TabIndex="1" meta:resourcekey="RdoNonSchResource1" />
                                    <asp:Label ID="lblchknonSch" runat="server" Text="Manual Invoice" meta:resourcekey="lblchknonSchResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButton ID="RdoClient" runat="server" AutoPostBack="True" GroupName="RdoClient"
                                        OnCheckedChanged="RdoClient_CheckedChanged" TabIndex="2" meta:resourcekey="RdoClientResource1" />
                                    <asp:Label ID="lblchk" runat="server" Text="Bulk Invoice" meta:resourcekey="lblchkResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%--  <td align="right">
                      <asp:CheckBox ID="ChkRejected" runat="server" TabIndex="3" />
                                    <asp:Label ID="lblreject" runat="server" Text="Rejected Bills"></asp:Label>
                    </td>--%>
                    <td>
                    </td>
                    <td class="a-left">
                        <asp:CheckBox ID="chkPreSch" runat="server" TabIndex="3" meta:resourcekey="chkPreSchResource1" />
                        <asp:Label ID="lblPreSch" runat="server" Text="un-invoiced bills" meta:resourcekey="lblPreSchResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCustomerType" Text="Business Type" runat="server" meta:resourcekey="lblCustomerTypeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpCustomerType" CssClass="ddlsmall" runat="server" TabIndex="4"
                            AutoPostBack="True" OnSelectedIndexChanged="drpCustomerType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblClientType" Text="Client Type" runat="server" meta:resourcekey="lblClientTypeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpClientType" CssClass="ddlsmall" runat="server" TabIndex="4">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblCName" Text="Client Name" runat="server" meta:resourcekey="lblCNameResource1" />
                    </td>
                    <td>
                        <asp:TextBox CssClass="small" TabIndex="5" ID="txtClientName" Enabled="False" runat="server"
                            OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                            BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                            ServiceMethod="GetClientNamebyClientType" OnClientItemSelected="IAmSelected"
                            ServicePath="~/WebService.asmx" DelimiterCharacters="" UseContextKey="True" Enabled="True">
                        </cc1:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFrom" TabIndex="6" CssClass="small" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True" />
                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtTo" TabIndex="7" CssClass="small" runat="server" meta:resourcekey="txtToResource1"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" class="middle" />
                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True" />
                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                    </td>
                    <td class="w-5p">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn" TabIndex="8" meta:resourcekey="btnSearchResource1"
                            OnClick="btnSearch_Click" OnClientClick="return CheckToSaveData()" Text="Search" />
                    </td>
                </tr>
            </table>
            <asp:UpdatePanel ID="updatePanel2" runat="server">
                <ContentTemplate>
                    <table class="a-center w-75p">
                        <tr>
                            <td>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="10"
                                    DataKeyNames="ClientID,ClientName,ScheduleID,NextOccurance,PreviousOccurance,ClientCode,ApprovalRequired,BusinessType,BusinessTypeID,BillofSupplyNumber"
                                    OnRowDataBound="GridView1_RowDataBound" ForeColor="Black" CellPadding="1" CssClass="mytable1 w-96p m-auto"
                                    AllowPaging="True" OnRowCommand="GridView1_RowCommand" meta:resourcekey="GridView1Resource1">
                                    <rowstyle cssclass="RowStyle" />
                                    <alternatingrowstyle cssclass="AlternateRowStyle" />
                                    <PagerStyle HorizontalAlign="Center" />
                            <Columns>
                                        <asp:TemplateField HeaderText="ClientID"   meta:resourcekey="TemplateFieldResource1" SortExpression="ClientID" Visible="false">
                                    
                                    
                                    <ItemTemplate>
                                        <%--<asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1" Text='<%# Bind("ClientID") %>'></asp:Label>
                                        <asp:Label ID="Label5" runat="server" meta:resourcekey="Label5Resource1" Text='<%# Bind("BusinessTypeID") %>'></asp:Label>--%>
                                         <asp:Label ID="Label1" runat="server"  Text='<%# Bind("ClientID") %>'></asp:Label>
                                        <asp:Label ID="Label5" runat="server"   Text='<%# Bind("BusinessTypeID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="small" 
                                            Text='<%# Bind("ClientID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                        <asp:TemplateField Visible="true">
                                            <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" Checked="True" meta:resourcekey="chkSelectAllResource1"
                                            onclick="ChkAllBox(this.id);" ToolTip="Select All" />
                                                   
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                        <asp:CheckBox ID="chkInvoiceItem" runat="server" Checked="True" meta:resourcekey="chkInvoiceItemResource1" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="center"></ItemStyle>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Business Type" meta:resourcekey="TemplateFieldResource3"
                                    SortExpression="BusinessType">
                                    <ItemTemplate>
                                        <%--<asp:LinkButton ID="btnEditBusiness" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" meta:resourcekey="btnEditBusinessResource1">
                                            <asp:Label runat="server" Text='<%# Bind("BusinessType") %>' ForeColor="Black" ID="LabelBusiness"
                                                meta:resourcekey="LabelBusinessResource1"></asp:Label>
                                                </asp:LinkButton>--%>
                                                <asp:LinkButton ID="btnEditBusiness" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" >
                                            <asp:Label runat="server" Text='<%# Bind("BusinessType") %>' ForeColor="Black" ID="LabelBusiness"
                                                ></asp:Label>
                                                </asp:LinkButton>
                                                <%-- <a href='<%# "../Invoice/GenerateInvoice.aspx?CID="+DataBinder.Eval(Container.DataItem,"ClientID") + "&CName=" + DataBinder.Eval(Container.DataItem,"ClientName") + "&SID=" + DataBinder.Eval(Container.DataItem,"ScheduleID")+ "&FDate=" + DataBinder.Eval(Container.DataItem,"NextOccurance", "{0:dd/MM/yyyy}")+ "&TDate=" + DataBinder.Eval(Container.DataItem,"PreviousOccurance","{0:dd/MM/yyyy}")+ "&Status=" + DataBinder.Eval(Container.DataItem,"ScheduleStatus")%>'
                                            runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                            <%# (string)DataBinder.Eval(Container.DataItem, "ClientName")%>
                                        </a>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Client Type" meta:resourcekey="TemplateFieldResource4"
                                    SortExpression="ClientType">
                                            <ItemTemplate>
                                       <%-- <asp:LinkButton ID="btnEdit" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" meta:resourcekey="btnEditResource1">
                                            <asp:Label runat="server" Text='<%# Bind("ClientType") %>' ForeColor="Black" ID="Label2"
                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                                </asp:LinkButton>--%>
                                                 <asp:LinkButton ID="btnEdit" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" >
                                            <asp:Label runat="server" Text='<%# Bind("ClientType") %>' ForeColor="Black" ID="Label2"
                                                ></asp:Label>
                                                </asp:LinkButton>
                                                <%-- <a href='<%# "../Invoice/GenerateInvoice.aspx?CID="+DataBinder.Eval(Container.DataItem,"ClientID") + "&CName=" + DataBinder.Eval(Container.DataItem,"ClientName") + "&SID=" + DataBinder.Eval(Container.DataItem,"ScheduleID")+ "&FDate=" + DataBinder.Eval(Container.DataItem,"NextOccurance", "{0:dd/MM/yyyy}")+ "&TDate=" + DataBinder.Eval(Container.DataItem,"PreviousOccurance","{0:dd/MM/yyyy}")+ "&Status=" + DataBinder.Eval(Container.DataItem,"ScheduleStatus")%>'
                                            runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                            <%# (string)DataBinder.Eval(Container.DataItem, "ClientType")%>
                                        </a>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Client Name" meta:resourcekey="TemplateFieldResource5"
                                    SortExpression="ClientName">
                                            <ItemTemplate>
                                       <%-- <asp:LinkButton ID="btnEdit1" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" meta:resourcekey="btnEdit1Resource1">
                                            <asp:Label runat="server" Text='<%# Bind("ClientName") %>' ForeColor="Black" ID="Label3"
                                                meta:resourcekey="Label3Resource1"></asp:Label>
                                                </asp:LinkButton>--%>
                                             <asp:LinkButton ID="btnEdit1" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" >
                                            <asp:Label runat="server" Text='<%# Bind("ClientName") %>' ForeColor="Black" ID="Label3"
                                                ></asp:Label>
                                                </asp:LinkButton>
                                                <%-- <a href='<%# "../Invoice/GenerateInvoice.aspx?CID="+DataBinder.Eval(Container.DataItem,"ClientID") + "&CName=" + DataBinder.Eval(Container.DataItem,"ClientName") + "&SID=" + DataBinder.Eval(Container.DataItem,"ScheduleID")+ "&FDate=" + DataBinder.Eval(Container.DataItem,"NextOccurance", "{0:dd/MM/yyyy}")+ "&TDate=" + DataBinder.Eval(Container.DataItem,"PreviousOccurance","{0:dd/MM/yyyy}")+ "&Status=" + DataBinder.Eval(Container.DataItem,"ScheduleStatus")%>'
                                            runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                            <%# (string)DataBinder.Eval(Container.DataItem, "ClientName")%>
                                        </a>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="ScheduleID" meta:resourcekey="TemplateFieldResource6" SortExpression="ScheduleID" Visible="False">
                                            <ItemTemplate>
                                            <%--<asp:Label ID="Label4" runat="server" meta:resourcekey="Label4Resource1" Text='<%# Bind("ScheduleID") %>'></asp:Label>
                                            </ItemTemplate>--%>
                                            <asp:Label ID="Label4" runat="server"  Text='<%# Bind("ScheduleID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                        <%--<asp:TextBox ID="TextBox3" runat="server" CssClass="small" meta:resourcekey="TextBox3Resource1"
                                            Text='<%# Bind("ScheduleID") %>'></asp:TextBox>--%>
                                            <asp:TextBox ID="TextBox3" runat="server" CssClass="small" 
                                            Text='<%# Bind("ScheduleID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Date" meta:resourcekey="TemplateFieldResource7"
                                    SortExpression="InvoiceDate" Visible="False">
                                            <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit2" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" ForeColor="Black" meta:resourcekey="btnEdit2Resource1">
                                            <%# (string)DataBinder.Eval(Container.DataItem, "NextOccurance", "{0:dd/MMM/yyyy}") %></asp:LinkButton>                                                                                           
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                <asp:TemplateField HeaderText="PreviousOccurance" meta:resourcekey="TemplateFieldResource8"
                                    SortExpression="PreviousOccurance" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("PreviousOccurance") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox5" CssClass="small" runat="server" Text='<%# Bind("PreviousOccurance") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Status" meta:resourcekey="TemplateFieldResource9"
                                    SortExpression="Invoice Status">
                                            <ItemTemplate>
                                        <%--<asp:LinkButton ID="btnEdit3" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" meta:resourcekey="btnEdit3Resource1">
                                            <asp:Label runat="server" Text='<%# Bind("ScheduleStatus") %>' ForeColor="Black"
                                                ID="Label7" meta:resourcekey="Label7Resource1"></asp:Label>
                                                </asp:LinkButton>--%>
                                                <asp:LinkButton ID="btnEdit3" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            CommandName="ValueEdit" >
                                            <asp:Label runat="server" Text='<%# Bind("ScheduleStatus") %>' ForeColor="Black"
                                                ID="Label7" ></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="ClientCode" meta:resourcekey="TemplateFieldResource10"
                                    SortExpression="ClientCode" Visible="False">
                                            <ItemTemplate>
                                       <%-- <asp:Label ID="Label8" runat="server" meta:resourcekey="Label8Resource1" Text='<%# Bind("ClientCode") %>'--%>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("ClientCode") %>'
                                            Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="ApprovalRequired" meta:resourcekey="TemplateFieldResource11"
                                    SortExpression="ApprovalRequired" Visible="False">
                                            <ItemTemplate>
                                        <%--<asp:Label ID="Label9" runat="server" meta:resourcekey="Label9Resource1" Text='<%# Bind("ApprovalRequired") %>'--%>
                                        <asp:Label ID="Label9" runat="server"  Text='<%# Bind("ApprovalRequired") %>'
                                            Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField HeaderText="Bill of Supply Number" 
                                    SortExpression="Bill of Supply Number" Visible="False">
                                            <ItemTemplate>
                                        <%--<asp:Label ID="Label9" runat="server" meta:resourcekey="Label9Resource1" Text='<%# Bind("ApprovalRequired") %>'--%>
                                        
                                            <asp:LinkButton ID="btnEditbillofsupply" runat="server"  CommandArgument="<%# ((GridViewRow)Container).RowIndex %>" CommandName="EditBillSupplyNumber"
                                            >
                                            <asp:Label ID="lblBillofSupplyNumber" runat="server"  Text='<%# Bind("BillofSupplyNumber") %>'
                                            Visible="True"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                            &nbsp;
                                             &nbsp; <asp:TextBox ID="txtbillsupplynumber" runat="server" Visible="false"></asp:TextBox>
                                            &nbsp; &nbsp; <asp:Button ID="btnSavebillSupplyNumber" runat="server" Text="Save" Visible="false" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>" CommandName="SaveUpdateBillSupplyNumber"/>


                                            </ItemTemplate>
                                        </asp:TemplateField>
                                 
                                    </Columns>
                                    <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl" visible="false">
                            <td class="defaultfontcolor a-center">
                                <asp:Label ID="Label4" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                                    meta:resourcekey="Btn_PreviousResource1" />
                                <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                                    meta:resourcekey="Btn_NextResource1" />
                                <asp:HiddenField ID="hdnCurrent" runat="server" />
                                <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="small" autocomplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                
                                <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo1_Click"
                                    onmouseover="this.className='btn btnhov'" meta:resourcekey="btnGo1Resource1"
                                    OnClientClick="return checkForValues()" />
                            </td>
                        </tr>
                        <tr class="h-12">
                        </tr>
                        <tr>
                            <td class="a-center">
                        <asp:Button ID="GnereateInvoive" runat="server" CssClass="btn" Visible="False" OnClick="GnereateInvoive_Click"
                            Text="Generate Invoice" meta:resourcekey="GnereateInvoiveResource1" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnFromDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnToDate" runat="server" Value="" />
            <asp:Label ID="lblerror" runat="server" meta:resourcekey="lblerrorResource1"></asp:Label>
            <asp:HiddenField ID="hdnchkAll" runat="server" />
            <asp:HiddenField ID="hdnUnSelectedClients" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsWaters" runat="server" Value="" />
            <asp:HiddenField ID="hdnisNeedBillSupplyNumber" runat="server" Value="" />
            <asp:HiddenField ID="hdnbillSupplyNumber" runat="server" Value="" />
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
