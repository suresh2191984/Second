<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDepositDetailsWithServiceReport.aspx.cs"
    Inherits="InventoryReports_PatientDepositDetailsWithServiceReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryReports/Controls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Deposit Details With Service Report</title>

    <script language="javascript" type="text/javascript">
       
        function clearContextText() {
            $('#contentArea').hide();

        }

        function CheckDates() {

            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error");
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information");
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok");
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel");
</script>
    <div class="contentdata">
        <table id="tblCollectionOPIP" align="center" width="100%">
            <tr align="center">
                <td align="left">
                    <div class="dataheaderWider">
                        <table id="tbl">
                            <tr id="trTrustedOrg" runat="server" style="display: block;">
                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                        CssClass="ddl" meta:resourcekey="ddlTrustedOrgResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small datePicker" ID="txtFDate"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small datePicker" ID="txtTDate"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;<asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Reference Type"
                                        meta:resourcekey="pnReportTypeResource1">
                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                            meta:resourcekey="rblReportTypeResource1">
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return CheckDates();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" Text="Back"
                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource2"></asp:LinkButton>
                                    <asp:ImageButton runat="server" ID="btnExportToExcel" ImageUrl="~/Images/ExcelImage.GIF"
                                        OnClick="btnExportToExcel_Click" ToolTip="Save As Excel" meta:resourcekey="btnExportToExcelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="DivReport" runat="server" width="100%" s>
                        <asp:GridView ID="grdPatientDepositDetails" Width="100%" runat="server" AllowPaging="True"
                            CellSpacing="1" CellPadding="1" DataKeyNames="PatientNumber" AutoGenerateColumns="False"
                            ForeColor="#333333" CssClass="dataheader2" OnPageIndexChanging="grdPatientDepositDetails_PageIndexChanging1"
                            OnRowDataBound="grdPatientDepositDetails_RowDataBound" meta:resourcekey="grdPatientDepositDetailsResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Left" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" meta:resourcekey="BoundFieldResource1">
                                </asp:BoundField>
                                <asp:BoundField DataField="PatientNumber" HeaderText="UHID" meta:resourcekey="BoundFieldResource2">
                                </asp:BoundField>
                                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource3">
                                </asp:BoundField>
                                <asp:BoundField DataField="Age" HeaderText="Age" Visible="false" meta:resourcekey="BoundFieldResource4">
                                </asp:BoundField>
                                <asp:BoundField DataField="ChequeValidDate" HeaderText="Deposited Date" meta:resourcekey="BoundFieldResource5">
                                </asp:BoundField>
                                <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" DataFormatString="{0:0.00}"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:GridView ID="grdPatientDepositDetailss" Width="100%" runat="server" AllowPaging="True"
                            CellSpacing="1" CellPadding="1" DataKeyNames="PatientNumber" AutoGenerateColumns="False"
                            ForeColor="#333333" CssClass="dataheader2" OnRowDataBound="grdPatientDepositDetailss_RowDataBound"
                            meta:resourcekey="grdPatientDepositDetailssResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Left" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PatientNumber" HeaderText="UHID" meta:resourcekey="BoundFieldResource7">
                                </asp:BoundField>
                                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource8">
                                </asp:BoundField>
                                <asp:BoundField DataField="DueChartNo" HeaderText="Refund Voucher No" meta:resourcekey="BoundFieldResource9">
                                </asp:BoundField>
                                <asp:BoundField DataField="ReceiptNo" HeaderText="Deposit Receipt No" meta:resourcekey="BoundFieldResource10">
                                </asp:BoundField>
                                <asp:BoundField DataField="ChequeValidDate" HeaderText="Refund Date" meta:resourcekey="BoundFieldResource11">
                                </asp:BoundField>
                                <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" DataFormatString="{0:0.00}"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource12">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="AmountRefund" HeaderText="Amount Refunded" DataFormatString="{0:0.00}"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource13">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>