<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InsuranceSearch.ascx.cs"
    Inherits="CommonControls_InsuranceSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/jscript">
    function ValidateDate() {

        if (document.getElementById('<%= txtFrom.ClientID %>').value == '') {

            var userMsg = SListForApplicationMessages.Get('CommonControls\\InsuranceSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Select from Date and to date');
            }
            return false;
        }
        else if (document.getElementById('<%= txtTo.ClientID %>').value == '') {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\InsuranceSearch.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert('Select from Date and to date');
        }
            return false;

        }
        else {
            return checkFromDateToDate('<%= txtFrom.ClientID %>', '<%= txtTo.ClientID %>');
        }
    }

    function CompareDate(txtfrom, txtto, txtAdmissionDate) {
        var flag = 0;
        var From = document.getElementById(txtfrom);
        var To = document.getElementById(txtto);
        var hdnAdmissionDate = document.getElementById(txtAdmissionDate);

        dobDt = To.value.split('/');
        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
        var mMonth = dobDtTime.getMonth() + 1;
        var mDay = dobDtTime.getDate();
        var mYear = dobDtTime.getFullYear();
        currentTime = new Date();
        var month = currentTime.getMonth() + 1;
        var day = currentTime.getDate();
        var year = currentTime.getFullYear();
        if (mYear > year) {
            flag = 1;
        }
        else if (mYear == year && mMonth > month) {
            flag = 1;
        }
        else if (mYear == year && mMonth == month && mDay > day) {
            flag = 1;
        }
        if (flag == 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\InsuranceSearch.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("Claim forward date can not be Exceeded than Current Date.");
            }
            To.value = "__/__/____";
            return false;
        }
        else {
            flag = 0;
            if (From != null) {

                var strSplitFrom = From.value.split('/')
                var myDateFrom = new Date();
                myDateFrom.setFullYear(strSplitFrom[2], strSplitFrom[1] - 1, strSplitFrom[0]);
                var strSplitTo = To.value.split('/')
                myDateTo = new Date();
                myDateTo.setFullYear(strSplitTo[2], strSplitTo[1] - 1, strSplitTo[0]);

                if (myDateFrom > myDateTo) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\InsuranceSearch.ascx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert("Claim forward date can not lesser than Discharge date.");
                    }
                    To.value = "__/__/____";
                    return false;
                }


                if (hdnAdmissionDate != null) {
                    flag = 0;
                    var strSplitFromAdmission = hdnAdmissionDate.value.split('/')
                    var myDateFromAdmission = new Date();
                    myDateFromAdmission.setFullYear(strSplitFromAdmission[2], strSplitFromAdmission[1] - 1, strSplitFromAdmission[0]);
                    var strSplitTo = To.value.split('/')
                    myDateTo = new Date();
                    myDateTo.setFullYear(strSplitTo[2], strSplitTo[1] - 1, strSplitTo[0]);
                    if (myDateFromAdmission > myDateTo) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\InsuranceSearch.ascx_4');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert("Claim forward date can not lesser than Admission date.");
                        }
                        To.value = "__/__/____";
                        return false;
                    }

                }
                else {
                    return true;
                }
            }
            else {
                return true;
            }
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
    function onChaangeChk(obj) {

        if (document.getElementById(obj).checked) {

            document.getElementById('hdnGetValue').value = obj + '^';
        }
        else {
            var x = document.getElementById('hdnGetValue').value.split('^');
            document.getElementById('hdnGetValue').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != '') {
                    if (x[i] != obj) {
                        document.getElementById('hdnGetValue').value = x[i] + '^';
                    }
                }

            }
        }

    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <asp:UpdatePanel ID="pnl" runat="server">
        <ContentTemplate>
            <table class="defaultfontcolor w-100p">
                <tr>
                    <td>
                        <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtFrom" runat="server" Width="130px" TabIndex="4" MaxLength="1"
                            Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                            CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True" />
                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                            PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtTo" runat="server" Width="130px" TabIndex="5" MaxLength="1" Style="text-align: justify"
                            ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                            CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                        <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True" />
                        <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                            PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                </tr>
                <tr id="trPatient" runat="server">
                    <td class="w-13p" runat="server">
                        <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" />
                    </td>
                    <td class="w-39p" runat="server">
                        <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);"></asp:TextBox>
                    </td>
                    <td class="w-20p" runat="server">
                        <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" />
                    </td>
                    <td class="w-28p" runat="server">
                        <asp:TextBox ID="txtPatientName" runat="server" MaxLength="255"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_CorporateandInsurance" Text="Corporate/Insurance" runat="server"
                            meta:resourcekey="Rs_CorporateandInsuranceResource1" />
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlType" onChange="javascript:return ShowDDl();" runat="server"
                                        meta:resourcekey="ddlTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTpaName" Style="display: none" runat="server" meta:resourcekey="ddlTpaNameResource1">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlCorporate" Style="display: none" runat="server" meta:resourcekey="ddlCorporateResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="Rs_PaymentType" Text="Payment Type" runat="server" meta:resourcekey="Rs_PaymentTypeResource1" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPaymentype" runat="server" TabIndex="39" meta:resourcekey="ddlPaymentypeResource1">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="a-center">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="return ValidateDate();"
                            meta:resourcekey="btnSearchResource1" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="a-center">
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="a-center">
                        <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" Height="16px"
                                    Width="16px" meta:resourcekey="imgProgressbarResource1" />
                                <asp:Label ID="Rs_info" Text="Please wait...." runat="server" meta:resourcekey="Rs_infoResource1" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="w-100p a-center">
                        <tableclass="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblStatus" Text="No Matching Records Found!" runat="server" Visible="False"
                                        meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="w-100p gridView"
                                        DataKeyNames="PatientID,PatientVisitID,FinalBillID" OnRowDataBound="grdResult_RowDataBound"
                                        PageSize="15" OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourcekey="grdResultResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource1"
                                                Visible="False" />
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="rdSel" runat="server" meta:resourcekey="rdSelResource1" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Left" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No." meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill N0" 
                                                meta:resourcekey="BoundFieldResource4" />
                                            <asp:TemplateField HeaderText="Admission Date" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAdmissionDate" runat="server" 
                                                        meta:resourcekey="lblAdmissionDateResource1"></asp:Label>
                                                    <asp:HiddenField ID="hdnAdmissionDate" runat="server"></asp:HiddenField>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Discharge Date" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDischaredDT" runat="server" meta:resourcekey="lblDischaredDTResource1"></asp:Label>
                                                    <asp:HiddenField ID="hdnDischargedDT" runat="server"></asp:HiddenField>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TPAName" HeaderText="TPA/Corporate" meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField DataField="GrossAmount" HeaderText="Bill Amount" meta:resourcekey="BoundFieldResource5">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PreAuthAmount" HeaderText="PreAuth Amount" meta:resourcekey="BoundFieldResource6">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Claim From TPA" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblClaimFromTPA" runat="server" meta:resourcekey="lblClaimFromTPAResource1"
                                                        Text='<%# Bind("TPABillAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Claim Forward Date" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtClaimForwardDate" runat="server" MaxLength="1" meta:resourcekey="txtClaimForwardDateResource1"
                                                        Style="text-align: justify" TabIndex="4" Text='<%# Bind("CliamForwardDate") %>'
                                                        ValidationGroup="MKE" Width="80px"></asp:TextBox>
                                                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="ImageButton1Resource2" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtClaimForwardDate">
                                                    </ajc:MaskedEditExtender>
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtClaimForwardDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                        EmptyValueMessage="Date is required" ErrorMessage="MaskedEditValidator1" InvalidValueBlurredMessage="*"
                                                        InvalidValueMessage="Date is invalid" meta:resourcekey="MaskedEditValidator1Resource2"
                                                        TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE"></ajc:MaskedEditValidator>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                        PopupButtonID="ImageButton1" TargetControlID="txtClaimForwardDate">
                                                    </ajc:CalendarExtender>
                                                    &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="80px" />
                                                <ItemStyle Width="14%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Received From TPA" meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPaidByTPA" runat="server" meta:resourcekey="lblPaidByTPAResource1"
                                                        Text='<%# Bind("PaidByTPA") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="TDS" meta:resourcekey="TemplateFieldResource7">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTDS" runat="server" meta:resourcekey="lblTDSResource1" Text='<%# Bind("TDSAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DiscountAmount" HeaderText="Disc Amt" 
                                                meta:resourcekey="BoundFieldResource7" />
                                            <asp:TemplateField HeaderText="WriteOff" meta:resourcekey="TemplateFieldResource8">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblWriteOff" runat="server" meta:resourcekey="lblWriteOffResource1"
                                                        Text='<%# Bind("WriteOff") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <input type="hidden" id="pid" name="pid" />
    <input type="hidden" id="hdnChkItem" runat="server"> </input>
    </input>
    </input>
        <input id="patOrgID" name="patOrgID" type="hidden" />
        <asp:HiddenField ID="hdnTPALAB" runat="server" />
        </input>
</asp:Panel>
