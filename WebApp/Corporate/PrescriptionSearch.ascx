<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrescriptionSearch.ascx.cs"
    Inherits="Corporate_PrescriptionSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
    function SelectRow(rid, vid, pid, tid, PhyID, Status, PrescriptionNo,RefundStatus,IssueQty) {
       
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('<%=hdnPatientVisitID.ClientID %>').value=vid;
        document.getElementById('<%=hdnPatientID.ClientID %>').value=pid;
        document.getElementById('<%=hdnTaskID.ClientID %>').value = tid;
        document.getElementById('<%=hdnPhysicianID.ClientID %>').value = PhyID;
        document.getElementById('<%=hdnStatus.ClientID %>').value = Status;
        document.getElementById('<%=hdnPrescriptionNo.ClientID %>').value = PrescriptionNo;
        document.getElementById('<%=hdnRefundStatus.ClientID %>').value = RefundStatus;
        document.getElementById('<%=hdnIssueQty.ClientID %>').value = IssueQty;
        
    }
</script>
<script type="text/javascript">
    function ValidatePatientName() {

        if (document.getElementById('<%=hdnPatientID.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get("Corporate\\PrescriptionSearch_ascx_1");
        if (userMsg != null) {
            alert(userMsg);
            return false;
        }
        else {
            alert('Select patient name');
            return false;
        }
          return false;
        }

        if ((document.getElementById('<%=hdnIssueQty.ClientID %>').value == '0') && (document.getElementById('ddlAction').value == 'Refund_Prescription_Corporate_prescriptionStockReturn')) {
 var userMsg = SListForApplicationMessages.Get("Corporate\\PrescriptionSearch_ascx_2");
 if (userMsg != null) {
     alert(userMsg);
     return false;
 }
 else {
     alert('There is no Bill for this Patient.  Select another patient name');
     return false;
 }
            return false;
        }
        if ((document.getElementById('<%=hdnStatus.ClientID %>').value == 'Open') && (document.getElementById('uctlPatientSearch_hdnIssueQty').value == '0') && (document.getElementById('ddlAction').value == 'Refund_Prescription_Corporate_prescriptionStockReturn')) {
var userMsg = SListForApplicationMessages.Get("Corporate\\PrescriptionSearch_ascx_2");
if (userMsg != null) {
    alert(userMsg);
    return false;
}
else {
    alert('There is no Bill for this Patient.  Select another patient name');
    return false;
}
            return false;
        }

//        if ((document.getElementById('<%=hdnStatus.ClientID %>').value == 'Closed') && (document.getElementById('ddlAction').value == 'Issue_Prescription_Corporate_CorpInvBilling')) {

//            alert('Selected patient task closed');
//            return false;
//        }

        return true;

    }
   
    function ShowRegDate() {
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";
        document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
        document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
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

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block'; 2210, 1
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
    }
    </script>
<style type="text/css">
    </style>
<%--<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">--%>
<table id="tblHeader" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="4">
            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                <tr>
                    <td style="width: 15%">
                        <asp:Label ID="lblNumber" runat="server" meta:resourcekey="lblNumberResource1"></asp:Label>
                    </td>
                    <td style="width: 39%">
                        <asp:TextBox ID="txtNumber" runat="server" MaxLength="16" 
                            onkeypress="return onEnterKeyPress(event);" 
                            meta:resourcekey="txtNumberResource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                    <td style="width: 20%">
                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                    </td>
                    <td style="width: 28%">
                        <asp:TextBox ID="txtName" MaxLength="255" runat="server" 
                            meta:resourcekey="txtNameResource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPrescriptionNo" runat="server" Text="Prescription No" 
                            meta:resourcekey="lblPrescriptionNoResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPrescriptionNo" runat="server" Width="50px" 
                            meta:resourcekey="txtPrescriptionNoResource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblDependent" runat="server" Text="Dependent Type" 
                            meta:resourcekey="lblDependentResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPatientType" runat="server" 
                            meta:resourcekey="ddlPatientTypeResource1" CssClass="ddlsmall">
                            <asp:ListItem Text="---Select---" Value="0" 
                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                            <asp:ListItem Text="Employee" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                            <asp:ListItem Text="Dependent" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            <asp:ListItem Text="Extended" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>
                            <%--<asp:ListItem Text="Non Employee" Value="4"></asp:ListItem>--%>
                            <%--<asp:ListItem Text="Casuals" Value="5"></asp:ListItem>--%>
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="txtDependent" runat="server" MaxLength="50"></asp:TextBox>--%>
                    </td>
                </tr>
                <tr>
                    <%--<td style="width: 15%">
                        <asp:Label ID="lblFromDate" Text="From Date" runat="server"></asp:Label>
                    </td>
                    <td style="width: 39%">
                        <asp:TextBox ID="txtFromDate" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png" CausesValidation="False" />
                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromDate"
                          Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                          OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True" />
                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                          ControlToValidate="txtFromDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                          Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"  ValidationGroup="MKE" />
                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate" PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                    </td>
                    <td style="width: 20%">
                        <asp:Label ID="lblToDate" Text="To Date" runat="server"></asp:Label>
                    </td>
                    <td style="width: 28%">
                        <asp:TextBox ID="txtToDate" MaxLength="255" runat="server"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png" CausesValidation="False" />
                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToDate"
                          Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                          OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True" />
                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                          ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                          Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*" ValidationGroup="MKE" />
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate" PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                    </td>--%>
                    <td align="left" class="style1">
                <asp:Label ID="Rs_BillDate" runat="server" Text="Bill Date" meta:resourceKey="Rs_BillDateResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                   runat="server" CssClass="ddlsmall"
                    meta:resourcekey="ddlRegisterDateResource1">
                   <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource5">--Select--</asp:ListItem>
                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource6" >This Week</asp:ListItem>
                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource7" >This Month</asp:ListItem>
                    <%--<asp:ListItem Value="2" >This Year</asp:ListItem>--%>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource8" >Custom Period</asp:ListItem>
                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource9" >Today</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource10" >Last Week</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource11" >Last Month</asp:ListItem>
                    <%--<asp:ListItem Value="7" >Last Year</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
            <td colspan="2">
                <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourceKey="txtFromDateResource1"></asp:TextBox>
                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourceKey="txtToDateResource1"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                    <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate2Resource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourceKey="txtFromPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourceKey="ImgBntCalcFromResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourceKey="MaskedEditValidator1Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    <asp:Label ID="Rs_ToDate2" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate2Resource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourceKey="txtToPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourceKey="ImgBntCalcToResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourceKey="MaskedEditValidator2Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                </div>
            </td>
                </tr>
                
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Status" 
                            meta:resourcekey="Label1Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" runat="server" 
                            meta:resourcekey="ddlStatusResource1" CssClass="ddlsmall">
                            <asp:ListItem Text="All" Value="0" meta:resourcekey="ListItemResource12"></asp:ListItem>
                            <asp:ListItem Text="Pending" Value="1" meta:resourcekey="ListItemResource13"></asp:ListItem>
                            <asp:ListItem Text="Closed" Value="2" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                      
                        </asp:DropDownList>
                    </td>
                    <td>
                        
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" nowrap="nowrap">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn'" OnClick="btnSearch_Click" 
                            meta:resourcekey="btnSearchResource1" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                            meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
            </table>
            <table width="100%">
            <tr>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" 
                    meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
            </tr>
                <tr>
                    <td>
                        <asp:GridView Width="100%"  BorderWidth="2px" AllowPaging="True" 
                            CellPadding="3" Font-Bold="False"
                            Font-Names="Verdana" Font-Overline="False" OnPageIndexChanging="grdResult_PageIndexChanging"
                            Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" 
                            ID="grdResult" PageSize="15"
                            AutoGenerateColumns="False" runat="server" 
                            OnRowDataBound="grdResult_RowDataBound" DataKeyNames="PatientVisitID" 
                            meta:resourcekey="grdResultResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" 
                                    meta:resourcekey="TemplateFieldResource1">
                                   <ItemTemplate>
                                     <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" 
                                           GroupName="PatientSelect" meta:resourcekey="rdSelResource1" />
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PrescriptionID" Visible="false" 
                                    meta:resourcekey="BoundFieldResource1" />
                                <asp:BoundField ItemStyle-Width="25%"  DataField="BrandName" 
                                    HeaderText="Employee/Dependent No" meta:resourcekey="BoundFieldResource2" >
<ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="45%"  DataField="Status" 
                                    HeaderText="Employee Name" meta:resourcekey="BoundFieldResource3" >
<ItemStyle Width="45%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="25%"  DataField="brandName" 
                                    HeaderText="Patient No" meta:resourcekey="BoundFieldResource4" >
<ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="45%"  DataField="status" 
                                    HeaderText="Patient Name" meta:resourcekey="BoundFieldResource5" >
<ItemStyle Width="45%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="PrescriptionNumber" HeaderText="Prescription Number" 
                                    meta:resourcekey="BoundFieldResource6" />
                                <asp:BoundField DataField="PatientVisitID" Visible="false" 
                                    meta:resourcekey="BoundFieldResource7" />
                                <asp:BoundField DataField="TaskID" Visible="false" 
                                    meta:resourcekey="BoundFieldResource8" />
                                <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" 
                                    HeaderText="Visit Date" meta:resourcekey="BoundFieldResource9" />
                            </Columns>
                          <%--  <Columns>
                              <asp:BoundField DataField="PatientID" Visible="false" />
                              <asp:BoundField DataField ="PatientVisitID" Visible="false" />
                              <asp:TemplateField>
                               <ItemTemplate>
                               <table id="TabChild" runat="server" border="0" width="100%" align="left">
                                  <tr id="Tr1" runat="server">
                                     <td id="Td1" style="width: 3%;" nowrap="nowrap" runat="server">
                                        <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PrescSelect" />
                                     </td>
                                     <td id="EmployeeNumber" align="left" style="width: 10%" nowrap="nowrap" runat="server">
                                        <%# DataBinder.Eval(Container.DataItem, "EmpNo")%>
                                     </td>
                                     <td id="EmployeeName" align="left" width="10%" runat="server">
                                         <%# DataBinder.Eval(Container.DataItem, "EmpName")%>
                                     </td>
                                     <td id="PatientNumber" align="left" style="width: 13%" nowrap="nowrap" runat="server">
                                         <%# DataBinder.Eval(Container.DataItem, "EmpNo")%>
                                     </td>
                                     <td id="PatientName" align="left" style="width: 13%" nowrap="nowrap" runat="server">
                                         <%# DataBinder.Eval(Container.DataItem, "EmpName")%>
                                     </td>
                                     <td id="PrescriptionNo" align="left" width="19%" runat="server">
                                         <%# DataBinder.Eval(Container.DataItem, "PrescriptionNumber")%>
                                     </td>
                                     <td id="VisitDate" runat="server" visible="False" align="left" width="7%">
                                         <%# DataBinder.Eval(Container.DataItem, "CreatedAt")%>
                                     </td>
                                   </tr>
                                </table>
                                </ItemTemplate>
                              </asp:TemplateField>
                            </Columns>--%>
                        </asp:GridView>
                    </td>
                </tr>
               <%-- <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                    <td align="center" class="defaultfontcolor">
                                        <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
                                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click" />
                                        <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click" />
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1" />
                                    </td>
              </tr>--%>
            </table>
        </td>
    </tr>
    
</table>
<asp:HiddenField ID="hdnIssueQty" runat="server" Value ="0" />
<asp:HiddenField ID="hdnRefundStatus" runat="server" />
<asp:HiddenField ID="hdnPrescriptionNo" runat="server" />
<asp:HiddenField ID="hdnPatientVisitID" runat="server" />
<asp:HiddenField ID="hdnStatus" runat="server" />
<asp:HiddenField ID="hdnPatientID" runat="server" />
<asp:HiddenField ID="hdnTaskID" runat="server" />
<asp:HiddenField ID="hdnPhysicianID" runat="server" />
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
