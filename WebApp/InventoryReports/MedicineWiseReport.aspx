<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MedicineWiseReport.aspx.cs"
    Inherits="InventoryReports_MedicineWiseReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Medicine Wise Report</title>
</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="10" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error")
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information")
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel")
    </script>
    <div class="contentdata">
        <table border="0" cellpadding="2" width="100%" cellspacing="1">
            <tr>
                <td>
                    <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="2"
                        cellspacing="1">
                        <tr>
                            <td>
                                <asp:Label ID="fdate" runat="server" Text="From Date" meta:resourcekey="fdateResource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker" Width="95px"
                                     onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="1"
                                    meta:resourcekey="txtFromResource1" />
                            </td>
                            <td>
                                <asp:Label ID="tdate" runat="server" Text="To Date" meta:resourcekey="tdateResource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker" Width="95px" TabIndex="2"
                                     onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1" />
                            </td>
                            <td style="width: 95px;">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblpname" runat="server" Text="Product Name" meta:resourcekey="lblpnameResource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductName" runat="server" CssClass="Txtboxsmall" Width="95px"
                                    OnkeyPress="return ValidateMultiLangChar(this)" TabIndex="5" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProductName"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain box"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                    DelimiterCharacters=";,:" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:Label ID="lblptname" runat="server" Text="Patient Name" meta:resourcekey="lblptnameResource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" Width="95px"
                                    OnkeyPress="return ValidateMultiLangCharacter(this)" TabIndex="4" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClientClick="javascript:return CheckDates();" OnClick="btnSearch_Click"
                                    TabIndex="7" meta:resourcekey="btnSearchResource1" />
                            </td>
                            <td>
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="btn" OnClick="lnkBack_Click"
                                    meta:resourcekey="lnkBackResource1" Text="Back"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right">
                                <table id="tblTool" runat="server">
                                    <tr align="right">
                                        <td align="right">
                                            <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                                Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"
                                                Text="Export To XL"></asp:LinkButton>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td align="right" style="display: none">
                                            <asp:HyperLink ID="HyperLink1" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                Target="BillWindow" runat="server" ToolTip="Click Here To Print Stock Details"
                                                meta:resourcekey="HyperLink1Resource1">
                                                <img alt="" id="img1" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                                                &nbsp;<u><asp:Label ID="lblPrint" Text="Print" runat="server" meta:resourcekey="lblPrintResource1"></asp:Label>
                                                    <asp:Label ID="Rs_MedicinewiseReport" Text="Medicine wise  Report" runat="server"
                                                        meta:resourcekey="Rs_MedicinewiseReportResource1" />
                                                </u>
                                            </asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="dataheaderWider" visible="false" style="font-weight: bold;" runat="server"
                        id="divPharmacytotRefund">
                        <asp:Label runat="server" ID="lblPharmacytotRefund" meta:resourcekey="lblPharmacytotRefundResource1"></asp:Label><br />
                        <asp:Label runat="server" ID="lblPharmacyDateRangeRefund" meta:resourcekey="lblPharmacyDateRangeRefundResource1"></asp:Label><br />
                        <asp:Label runat="server" ID="lblPharmacyItemRefund" meta:resourcekey="lblPharmacyItemRefundResource1"></asp:Label>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                                Width="100%" meta:resourcekey="gvResultResource1" OnRowDataBound="gvResult_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" DataField="CreatedAt"
                                        meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField HeaderText="Bill No" DataField="BillNumber" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField HeaderText="ReceiptNo/InterimNo" DataField="ReceiptNo" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField HeaderText="Name" DataField="Name" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField HeaderText="Description" DataField="FeeDescription" meta:resourcekey="BoundFieldResource5" />
                                    <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <%# Eval("Quantity") %>&nbsp;<%# Eval("SellingUnit") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <%# Eval("Rate") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <%# Eval("Amount")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="dataheader1" />
                                <RowStyle VerticalAlign="Top" HorizontalAlign="Left" />
                            </asp:GridView>
                            <div style="text-align: right; font-size: 15px; font-weight: bold; padding-right: 30px;">
                                <asp:Label ID="lblTotalAmt" Text="Total Amount:" runat="server" meta:resourcekey="lblTotalAmtResource1"></asp:Label>
                                <asp:Label ID="lblTotalAmount" Text="0.00" runat="server" meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl a-center">
                <td align="center" colspan="10" class="defaultfontcolor">
                    <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click"
                        meta:resourcekey="btnPreviousResource1" />
                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"
                        meta:resourcekey="btnNextResource1" />
                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px" onkeydown="javascript:return validatenumber(event);"
                        OnkeyPress="return ValidateOnlyNumeric(this)" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                        meta:resourcekey="btnGoResource1" />
                    <asp:HiddenField ID="hdnResult" runat="server" Value="0" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script type="text/javascript" language="javascript">
        
        var userMsg;
        //petchi
        function ProductItemsSelected(source, eventArgs) {
            //debugger;
            var Product = eventArgs.get_text().split('^^');
            document.getElementById('txtProductName').value = Product[0];

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


        if (document.getElementById('hdnResult').value == "1")
            document.getElementById('GrdFooter').style.display = 'block';

        function checkForValues() {
            if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
                var userMsg = SListForAppMsg.Get("InventoryReports_MedicineWiseReport_aspx_09") == null ? "Please Enter Page No" : SListForAppMsg.Get("InventoryReports_MedicineWiseReport_aspx_09");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
                    var userMsg = SListForAppMsg.Get("InventoryReports_MedicineWiseReport_aspx_10") == null ? "Please Enter Correct Page No" : SListForAppMsg.Get("InventoryReports_MedicineWiseReport_aspx_10");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
        }
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
