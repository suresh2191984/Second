<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SupplierAnalysisInVoiceReport.aspx.cs"
    Inherits="InventoryReports_SupplierAnalysisInVoiceReport" Trace="false" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice Report</title>

    <script src="WebService/InventoryReportsService.asmx" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
        var userMsg;
        function GetSelectedLocation() {
            GetLocationlist();
            document.getElementById('ddlLocation').value = document.getElementById('hdnInvLocation').value;
        }
        function GetLocationlist() {
            var drpOrgid = document.getElementById('ddlTrustedOrg').value;
            var options = document.getElementById('hdnlocation').value;
            var ddlLocation = document.getElementById('ddlLocation');
            ddlLocation.options.length = 0;

            var optn1 = document.createElement("option");
            ddlLocation.options.add(optn1);
            optn1.text = "--Select--";
            optn1.value = "0";
            var list = options.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (drpOrgid == res[0]) {
                        var optn = document.createElement("option");
                        ddlLocation.options.add(optn);
                        optn.text = res[2];
                        optn.value = res[1];
                    }
                }
            }
        }

        function KeyPress2(e) {

            $find('AutoCompleteSearchNo');

        }

        function CheckDates(splitChar) {

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
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
        function onSearch() {
            var txt = document.getElementById('txtProduct').value;
            if (txt != "") {
                document.getElementById('btnSearch').click();
                document.getElementById('btnSearch').disabled = true;
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('divPrintarea');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script language="javascript" type="text/javascript">
            var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Validation" : SListForAppMsg.Get('InventoryReports_Error');
            var cancelMsg = SListForAppMsg.Get('InventoryReports_Cancel') == null ? "Cancel" : SListForAppMsg.Get('InventoryReports_Cancel');
            var okMsg = SListForAppMsg.Get('InventoryReports_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryReports_Ok');
            var InformationMsg = SListForAppMsg.Get('InventoryReports_Information') == null ? "Information" : SListForAppMsg.Get('InventoryReports_Information');
        
    </script>
    <asp:UpdatePanel ID="UpdtPanel" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="Progressbar" runat="server">
                <ProgressTemplate>
                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                        meta:resourcekey="imgProgressbarResource1" />
                    Please wait....
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="contentdata">
                <table class="dataheader2 defaultfontcolor" border="0" width="100%" cellpadding="2"
                    cellspacing="1">
                    <tr>
                        <td>
                            <table border="0" width="100%" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td width="9%">
                                        <asp:Label runat="server" ID="SearchNo" Text="Invoice No" 
                                            CssClass="label_title" meta:resourcekey="SearchNoResource1"></asp:Label>
                                    </td>
                                    <td width="16%">
                                        <asp:TextBox KeyPress="return ValidateMultiLangChar(this)" ID="txtSearchNo" runat="server" Width="130px" TabIndex="7" meta:resourcekey="txtSearchNoResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteSearchNo" runat="server" CompletionInterval="1"
                                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                            MinimumPrefixLength="1" ServiceMethod="GetDetailsSearchNo" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                            TargetControlID="txtSearchNo" DelimiterCharacters="" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td width="6%">
                                        <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" 
                                            meta:resourcekey="fromDateResource1"></asp:Label>
                                    </td>
                                    <td width="11%">
                                        <asp:TextBox ID="txtFrom" onkeydown="return false;" runat="server" Width="100px"
                                            TabIndex="1" MaxLength="1" Style="text-align: justify" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                    </td>
                                    <td width="7%">
                                        <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" 
                                            meta:resourcekey="toDateResource1"></asp:Label>
                                    </td>
                                    <td width="11%">
                                        <asp:TextBox ID="txtTo" onkeydown="return false;" runat="server" Width="100px" TabIndex="2"
                                            MaxLength="1" Style="text-align: justify" ValidationGroup="MKE" ReadOnly="true"
                                            onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1" />
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblSupplier" Text="Supplier Name" 
                                            CssClass="label_title" meta:resourcekey="lblSupplierResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSupplier" runat="server" Width="130px" TabIndex="3" onKeyPress="return ValidateMultiLangChar(this)&&ValidateMultiLangCharacter(this);"
                                            meta:resourcekey="txtSupplierResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSupplier"
                                            ServiceMethod="GetSupplierList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                            DelimiterCharacters=";,:" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td align="right">
                                        <asp:Label runat="server" ID="lblDepartment" Text="Department" CssClass="label_title"
                                            meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLocation" CssClass="ddl" Width="130px" runat="server" meta:resourcekey="ddlLocationResource1">
                                            <asp:ListItem Text="--All--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" colspan="1" width="10%">
                                        <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                            OnClick="btnSearch_Click" TabIndex="5"  OnClientClick="javascript:return CheckDates('')" 
                                            meta:resourcekey="btnSearchResource1" />
                                        &nbsp;
                                        <asp:LinkButton ID="lnkBack" Text="Back&nbsp;&nbsp;" Font-Underline="True" runat="server"
                                            CssClass="details_label_age" OnClick="lnkBack_Click" 
                                            meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                    </td>
                                    <td align="right" width="10%">
                                        <table id="tblExport" runat="server" width="100%">
                                            <tr runat="server">
                                                <td width="65%" runat="server">
                                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" />
                                                    <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../Images/printer.GIF"
                                                        ToolTip="Click Here To Print Supplier Details" OnClientClick="CallPrint();" />
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
                            <div id="divPrintarea" runat="server">
                                <input type="hidden" id="hdnRowCount" runat="server" >
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" 
                                        AutoGenerateColumns="False" EmptyDataText="No Results Found." 
                                        meta:resourceKey="grdResultResource1" 
                                        OnPageIndexChanging="grdResult_PageIndexChanging" 
                                        OnRowCreated="gridView_RowCreated" PageSize="50" Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Supplier Name" 
                                                meta:resourceKey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <%# Eval("SupplierName") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Invoice No " 
                                                meta:resourceKey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <%# Eval("Name") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Invoice Date" 
                                                meta:resourceKey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <%# Eval("InvoiceDate", "{0:dd/MM/yyyy}") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RcvdLSUQty" HeaderText="Rcvd Qty" 
                                                meta:resourceKey="BoundFieldResource1">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" 
                                                meta:resourceKey="BoundFieldResource2">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Amount" HeaderText="Net Price" 
                                                meta:resourceKey="BoundFieldResource3">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Discount" HeaderText="Discount" 
                                                meta:resourceKey="BoundFieldResource4">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LocationName" HeaderText="Location Name" 
                                                meta:resourceKey="BoundFieldResource5">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle Font-Size="10px" HorizontalAlign="Left" />
                                    </asp:GridView>
                                </input>
                            </div>
                        </td>
                    </tr>
                    <asp:HiddenField ID="hdnlocation" runat="server" />
                    <asp:HiddenField ID="hdnInvLocation" runat="server" />
                </table>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="imgBtnXL" />
        </Triggers>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>


    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>