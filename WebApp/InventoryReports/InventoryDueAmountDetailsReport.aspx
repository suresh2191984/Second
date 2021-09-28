<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InventoryDueAmountDetailsReport.aspx.cs"
    Inherits="InventoryReports_InventoryDueAmountDetailsReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryReports/Controls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

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
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error")
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information")
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel")
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
                                    <asp:TextBox CssClass="small datePicker" Width="70px" ID="txtFDate" runat="server"
                                         onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small datePicker" Width="70px" ID="txtTDate" runat="server"
                                         onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;<asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Report Type"
                                        meta:resourcekey="pnReportTypeResource1">
                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                            meta:resourcekey="rblReportTypeResource1">
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Panel ID="pnBillType" runat="server" Width="100%" GroupingText="Bill Type" meta:resourcekey="pnBillTypeResource1">
                                        <asp:RadioButtonList ID="rblBillType" RepeatDirection="Horizontal" runat="server"
                                            meta:resourcekey="rblBillTypeResource1">
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    &nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return CheckDates();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                    <asp:LinkButton ID="lnkBack" Font-Underline="True" runat="server" CssClass="details_label_age"
                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">
                                        <asp:Label Text="Back" ID="lblBack" runat="server" meta:resourcekey="lblBackResource1"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        OnClick="imgBtnXL_Click" ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkExportXL" runat="server" Font-Bold="True" Font-Size="12px"
                                        ForeColor="Black" OnClick="imgBtnXL_Click" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="DivReport" runat="server">
                        <%--Summary Report--%>
                        <asp:GridView ID="grdDueDetails" Width="100%" runat="server" AllowPaging="True" CellSpacing="1"
                            CellPadding="1" DataKeyNames="FinalBillID" AutoGenerateColumns="False" ForeColor="#333333"
                            CssClass="dataheader2" OnPageIndexChanging="grdDueDetails_PageIndexChanging"
                            OnRowDataBound="grdDueDetails_RowDataBound" meta:resourcekey="grdDueDetailsResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Left" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPatientName" runat="server" Text='<%# Eval("PatientName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UHID" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPatientNumber" runat="server" Text='<%# Eval("PatientNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillNumber" runat="server" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recipt Number" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceiptNo" runat="server" Text='<%# Eval("ReceiptNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Visit Type" meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVisitType" runat="server" Text='<%# Eval("VisitType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Type" meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillType" runat="server" Text='<%# Eval("BillType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Date" meta:resourcekey="TemplateFieldResource8">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChequeValidDate" runat="server" Text='<%# Eval("ChequeValidDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billed Amount" meta:resourcekey="TemplateFieldResource9">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblBilledAmount" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("BilledAmount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Amount" meta:resourcekey="TemplateFieldResource10">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceivedAmtUsed" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("ReceivedAmtUsed") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Deposit Usage" meta:resourcekey="TemplateFieldResource11">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepositamtUsed" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("DepositamtUsed") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Amount" meta:resourcekey="TemplateFieldResource12">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDue" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("Due") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="dataheader1" />
                        </asp:GridView>
                        <%--Detail Report--%>
                        <asp:GridView ID="grdDueSummary" Width="100%" runat="server" AllowPaging="True" CellSpacing="1"
                            CellPadding="1" AutoGenerateColumns="False" DataKeyNames="FinalBillID" ForeColor="#333333"
                            CssClass="dataheader2" OnPageIndexChanging="grdDueSummary_PageIndexChanging"
                            OnRowDataBound="grdDueSummary_RowDataBound" meta:resourcekey="grdDueSummaryResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Left" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource13">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource14">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPatientName" runat="server" Text='<%# Eval("PatientName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UHID" meta:resourcekey="TemplateFieldResource15">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPatientNumber" runat="server" Text='<%# Eval("PatientNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateFieldResource16">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillNumber" runat="server" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recipt Number" meta:resourcekey="TemplateFieldResource17">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceiptNo" runat="server" Text='<%# Eval("ReceiptNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Visit Type" meta:resourcekey="TemplateFieldResource18">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVisitType" runat="server" Text='<%# Eval("VisitType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Type" meta:resourcekey="TemplateFieldResource19">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillType" runat="server" Text='<%# Eval("BillType") %>' m></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fee Description" meta:resourcekey="TemplateFieldResource20">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFeeDescription" runat="server" Text='<%# Eval("FeeDescription") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Date" meta:resourcekey="TemplateFieldResource21">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChequeValidDate" runat="server" Text='<%# Eval("ChequeValidDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billed Amount" meta:resourcekey="TemplateFieldResource22">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblBilledAmount" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("BilledAmount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Amount" meta:resourcekey="TemplateFieldResource23">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceivedAmtUsed" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("ReceivedAmtUsed") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Deposit Usage" meta:resourcekey="TemplateFieldResource24">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepositamtUsed" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("DepositamtUsed") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Amount" meta:resourcekey="TemplateFieldResource25">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDue" DataFormatString="{0:0.00}" runat="server" Text='<%# Eval("Due") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    
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
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
