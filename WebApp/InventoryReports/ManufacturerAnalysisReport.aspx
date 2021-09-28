<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManufacturerAnalysisReport.aspx.cs" Trace="false" Inherits="InventoryReports_ManufacturerAnalysisReport" EnableEventValidation="false" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ManufacturerWise Sales Report</title>
    <script language="javascript" type="text/javascript">
        //petchi
        var errorMsg;
        var MFGID = 0;
        var PID = 0;
        function ProductItemsSelected(source, eventArgs) {
            //debugger;
            var Product = eventArgs.get_text().split('^^');
            document.getElementById('txtProduct').value = Product[0];

        }
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
            if (document.getElementById('hdnMfgID').value == 0 || $('#txtSearchNo').val().trim() == "") {
                var userMsg = SListForAppMsg.Get("InventoryReports_ManufacturerAnalysisReport_aspx_01") == null ? "Please Select Manufacturer!" : SListForAppMsg.Get("InventoryReports_ManufacturerAnalysisReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
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

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        function calcHeight() {

            setTimeout(function () {
                var hgt = $('.contentdata').height() - $('#tbl1Search').height() - 16;
                console.log(hgt);
                var widt = $(window).width() - 4;
                $('#divPrintarea').css("height", hgt);
                $('#divPrintarea').css('width', widt);
                $('#divPrintarea').css('overflow', 'auto');
            }, 1000);
        }
        function ManufacturerSelected(sender, eventArgs) {

            var item = eventArgs.get_value();
            document.getElementById('hdnMfgID').value = item.split("{")[1].slice(1, -1).split(",")[0].split(":")[1];

        }
        function ProductItemSelectedvalues(sender, eventArgs) {
            var item = eventArgs.get_value();
            document.getElementById('hdnPID').value = item.split("~")[0];
        }
    </script>
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <asp:UpdatePanel ID="UpdtPanel" runat="server">
        <ContentTemplate>
            <div class="contentdata">
                <table class="lh30 w-100p ">
                    <tr>
                        <td>
                            <table border="0" id="tbl1Search" class="w-100p dataheader2 defaultfontcolor" >
                                <tr>
                                    <td valign="middle">
                                        <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" 
                                            meta:resourcekey="fromDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFrom" onkeydown="return false;" runat="server" TabIndex="1" MaxLength="1"
                                            CssClass="small datePicker" ValidationGroup="MKE" 
                                            meta:resourcekey="txtFromResource1" />
                                    </td>
                                    <td valign="middle">
                                        <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" 
                                            meta:resourcekey="toDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTo" onkeydown="return false;" runat="server" CssClass="datePicker"
                                            TabIndex="2" MaxLength="1" ValidationGroup="MKE" 
                                            meta:resourcekey="txtToResource1" />
                                    </td>
                                    <td valign="middle">
                                        <asp:Label runat="server" ID="Label1" 
                                            CssClass="label_title" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTrustedOrg" runat="server" Width="150px" 
                                            OnChange="GetLocationlist();" meta:resourcekey="ddlTrustedOrgResource1">
                                        </asp:DropDownList>
                                    </td>
                               
                                    <td>
                                        <%=Resources.InventoryReports_ClientDisplay.InventoryReports_SupplierAnalysisReport_aspx_Location%>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLocation" OnChange="document.getElementById('hdnInvLocation').value=document.getElementById('ddlLocation').value;"
                                            runat="server" Width="135px" meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                    </td>
                                   
                                </tr>
                                <tr>

                                    <td valign="middle">
                                        <asp:Label runat="server" ID="SearchNo" Text="Manufacturer Name" 
                                            CssClass="label_title" meta:resourcekey="SearchNoResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSearchNo" runat="server" Width="130px" TabIndex="7"
                                            meta:resourcekey="txtSearchNoResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteSearchNo" runat="server" CompletionInterval="1"
                                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True" OnClientItemSelected="ManufacturerSelected"
                                            MinimumPrefixLength="1" ServiceMethod="GetManufacturer" ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx"
                                            TargetControlID="txtSearchNo" DelimiterCharacters=";,:" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                          &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                   
                                    <td valign="middle">
                                        <asp:Label runat="server" ID="lblProduct" Text="Product Name" 
                                            CssClass="label_title" meta:resourcekey="lblProductResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtProduct" runat="server" CssClass="small"
                                        OnkeyPress="return ValidateMultiLangChar(this) && ValidateMultiLangCharacter(this);" TabIndex="4" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                            OnClientItemSelected="ProductItemSelectedvalues" ServiceMethod="GetSearchProductList"
                                            ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                            DelimiterCharacters=";,:" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text=" Search " CssClass="btn"
                                            OnClientClick="javascript:return CheckDates('')" 
                                            OnClick="btnSearch_Click" TabIndex="5" meta:resourcekey="btnSearchResource1" />
                                        &nbsp;
                                        <asp:Button ID="btnBack" runat="server" Text=" Back " CssClass="btn" OnClick="btnBack_Click"
                                            TabIndex="5" meta:resourcekey="btnBackResource1" />
                                    </td>
                                    <td align="right">
                                        <table id="tblExport" runat="server" width="100%">
                                            <tr>
                                                <td width="65%">
                                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="~/PlatForm/Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                                    <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                                        Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" Text="&lt;u&gt;Export To XL&lt;/u&gt;" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>&nbsp;
                                                </td>
                                                <td width="35%">
                                                    <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/PlatForm/Images/printer.gif"
                                                        ToolTip="Click Here To Print Supplier Details" 
                                                        meta:resourcekey="imgBtnPrintResource1" />
                                                    <asp:LinkButton ID="lnkPrint" OnClientClick="CallPrint();" runat="server" Font-Bold="True"
                                                        Font-Size="12px" ForeColor="Black" ToolTip="Click Here To Print Supplier Details"
                                                        Text="&lt;u&gt;Print&lt;/u&gt;" meta:resourcekey="lnkPrintResource1"></asp:LinkButton>
                                                    <%-- OnClick="imgBtnPrint_Click"--%>
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
                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ProductName" HeaderText="ProductName" 
                                                meta:resourceKey="BoundFieldResource1"></asp:BoundField>

                                            <asp:BoundField DataField="LocationName" DataFormatString="{0:N0}" 
                                                HeaderText="Location" meta:resourceKey="BoundFieldResource17">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                              <asp:BoundField DataField="StockIssued" DataFormatString="{0:N0}" 
                                                HeaderText="Sales Qty" meta:resourceKey="BoundFieldResource18">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                              <asp:BoundField DataField="StockInHand" DataFormatString="{0:N0}" 
                                                HeaderText="Current Stock" meta:resourceKey="BoundFieldResource19">
                                                <ItemStyle HorizontalAlign="Center" />
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
                    <asp:HiddenField ID="hdnInvLocation" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnMfgID" runat="server" Value="0"/>
                    <asp:HiddenField ID="hdnPID" runat="server"  Value="0"/>
                </table>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="lnkExportXL" />
            <asp:PostBackTrigger ControlID="imgBtnXL" />
        </Triggers>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
    <script type="text/javascript">
        $(document).ready(function () {
            errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
        });
        $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
</script>
</html>
