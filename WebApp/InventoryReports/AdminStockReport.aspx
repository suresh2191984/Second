<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminStockReport.aspx.cs"
    Inherits="InventoryReports_AdminStockReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Report</title>


    <style type="text/css">
        .s1
        {
            height: 200px;
            overflow: auto;
            width: 168px;
            border: solid 1px black;
            position: absolute;
            background-color: White;
            display: inline;
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
        var InfoMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information");
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok");
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel");
    </script>
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="searchPanel a-center w-100p">
            <tr class="panelContent a-center">
                <td class="a-center">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <div>
                                            <table class="w-100p">
                                                <tr class="lh30">
                                                    <td nowrap="Nowrap">
                                                        <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" onchange="javascript:clearContextText();"
                                                            runat="server" CssClass="small" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged"
                                                            meta:resourcekey="ddlTrustedOrgResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <td class="a-left" nowrap="Nowrap">
                                                                <asp:Label runat="server" ID="lblDepartment" Text="Department" meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="ddlLocation" CssClass="small w-130p" runat="server" meta:resourcekey="ddlLocationResource1">
                                                                   
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left" nowrap="Nowrap">
                                                                <asp:Label runat="server" ID="lblCat" Text="Category" meta:resourcekey="lblCatResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="small w-133p" meta:resourcekey="ddlCategoryResource1">
                                                                  
                                                                </asp:DropDownList>
                                                            </td>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </tr>
                                                <tr id="divAll" class="lh30">
                                                    <td class="a-left w-10p" nowrap="Nowrap">
                                                        <asp:Label runat="server" ID="fromDate" Text="From" meta:resourcekey="fromDateResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left" nowrap="Nowrap">
                                                        <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePickerPres" meta:resourcekey="txtFromResource1" />
                                                    </td>
                                                    <td class="a-left" nowrap="Nowrap">
                                                        <asp:Label runat="server" ID="toDate" Text="To" meta:resourcekey="toDateResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left" nowrap="Nowrap">
                                                        <asp:TextBox ID="txtTo" runat="server" CssClass="small datePickerPres" meta:resourcekey="txtToResource1" />
                                                    </td>
                                                    <td class="a-left" nowrap="Nowrap">
                                                        <asp:Label runat="server" ID="lblProduct" Text="Product Name" meta:resourcekey="lblProductResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtProduct" CssClass="small w-130p" runat="server" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                                            OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                                            ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                                            MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                                            DelimiterCharacters=";,:" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr class="a-left lh30">
                                                    <td nowrap="Nowrap">
                                                        <asp:CheckBox ID="chkNilStock" runat="server" Text="Show Nil Stocks" meta:resourcekey="chkNilStockResource1" />
                                                    </td>
                                                    <td nowrap="Nowrap" class="a-left">
                                                        <asp:RadioButton GroupName="all" ID="rdosummary" Checked="True" Text="Summary" runat="server"
                                                            meta:resourcekey="rdosummaryResource1" />
                                                        <asp:RadioButton GroupName="all" ID="rdodetails" Text="Details" runat="server" meta:resourcekey="rdodetailsResource1" />
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                            OnClick="btnSearch_Click" OnClientClick="javascript:return CheckDates('');"
                                                            meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
                                                            meta:resourcekey="Label2Resource1"><asp:Label ID="Label2" runat="server" Text="Back" meta:resourcekey="Label2Resource1"></asp:Label></asp:LinkButton>
                                                    </td>
                                                    <td class="a-left" colspan="2">
                                                        <asp:HyperLink ID="hypLnkExportXL" Target="XLWindow" runat="server" ToolTip="Save As Excel"
                                                            meta:resourcekey="hypLnkExportXLResource1"><img id="imgXL" alt="To XL" runat="server" src="~/PlatForm/Images/ExcelImage.GIF" />
                                                        </asp:HyperLink>
                                                        <asp:HyperLink ID="hypLnkPrint" Target="BillWindow" runat="server" ToolTip="Click Here To Print Stock Details"
                                                            meta:resourcekey="hypLnkPrintResource1"><img id="imgPrint" alt="To Print" runat="server" src="~/PlatForm/Images/printer.gif" />
                                                        </asp:HyperLink>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                    <asp:Label ID="Label4" runat="server" Text="Pleasewait" meta:resourcekey="Label4Resource1"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div class="fixedReport w-100p">
                                <asp:Repeater ID="rptHeader" OnItemDataBound="rptHeader_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-right">
                                                    <asp:Label ID="Label5" runat="server" Text="Department" meta:resourcekey="Label5Resource1"></asp:Label>
                                                    :
                                                    <asp:Label ID="lblDepartmentValue" runat="server" Text='<%# Eval("LocationName") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-100p">
                                                        <asp:Repeater ID="rptMiddle" OnItemDataBound="rptMiddle_ItemDataBound" runat="server">
                                                            <ItemTemplate>
                                                                <tr class="a-left">
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="server" Text="Category" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                        :
                                                                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryName") %>' />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="grdResult" AllowPaging="True" runat="server" AutoGenerateColumns="False"
                                                                            ShowFooter="True" DataKeyNames="LocationID,CategoryID" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                            OnRowDataBound="grdResult_RowDataBound" CssClass="gridView w-100p" meta:resourcekey="grdResultResource1">
                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                            <HeaderStyle CssClass="gridHeader" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Product" meta:resourcekey="TemplateFieldResource2">
                                                                                    <ItemTemplate>
                                                                                        <asp:HyperLink ID="hypProduct" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("ProductName") %>'
                                                                                            Target="_blank" runat="server" ></asp:HyperLink>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle CssClass="w-30p" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="OpeningBalance" DataFormatString="{0:N}" HeaderText="Opening Balance"
                                                                                    meta:resourcekey="BoundFieldResource1">
                                                                                    <ItemStyle CssClass="a-right" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="OpeningStockValue" DataFormatString="{0:N}" HeaderText="Opening Stock Value"
                                                                                    meta:resourcekey="BoundFieldResource2">
                                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="StockReceived" DataFormatString="{0:0}" HeaderText="Stock Received"
                                                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockIssued" DataFormatString="{0:0}" HeaderText="Stock Issued"
                                                                                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockDamage" DataFormatString="{0:0}" HeaderText="Stock Damage"
                                                                                    meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockReturn" DataFormatString="{0:0}" HeaderText="Stock Return"
                                                                                    meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                                                                                <asp:BoundField DataField="ClosingBalance" DataFormatString="{0:N}" HeaderText="Closing Balance"
                                                                                    meta:resourcekey="BoundFieldResource7">
                                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ClosingStockValue" DataFormatString="{0:N}" HeaderText="Closing Stock Value"
                                                                                    meta:resourcekey="BoundFieldResource8">
                                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Units" HeaderText="Units" meta:resourcekey="BoundFieldResource9">
                                                                                </asp:BoundField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="w-100p">
                                    <div class="a-right">
                                        <strong></strong>
                                        <asp:Label ID="lblTotalStockValue" runat="server" meta:resourcekey="lblTotalStockValueResource1"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:GridView ID="grdXLResult" runat="server" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                        CssClass="gridView w-100p" HeaderStyle-CssClass="gridHeader" meta:resourcekey="grdXLResultResource1">
                        <PagerStyle CssClass="gridPager" />
                        <HeaderStyle CssClass="gridHeader" />
                        <Columns>
                            <asp:TemplateField HeaderText="Product" ItemStyle-HorizontalAlign="center" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hypProduct" Text='<%# Eval("ProductName") %>' Target="_blank"
                                        runat="server" ></asp:HyperLink>
                                </ItemTemplate>
                                <ItemStyle CssClass="a-left"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OpeningBalance" DataFormatString="{0:N}" HeaderText="Opening Balance"
                                meta:resourcekey="BoundFieldResource10"></asp:BoundField>
                            <asp:BoundField DataField="OpeningStockValue" DataFormatString="{0:N}" HeaderText="Opening Stock Value"
                                meta:resourcekey="BoundFieldResource11"></asp:BoundField>
                            <asp:BoundField DataField="StockReceived" DataFormatString="{0:0}" HeaderText="Stock Received"
                                meta:resourcekey="BoundFieldResource12"></asp:BoundField>
                            <asp:BoundField DataField="StockIssued" DataFormatString="{0:0}" HeaderText="Stock Issued"
                                meta:resourcekey="BoundFieldResource13"></asp:BoundField>
                            <asp:BoundField DataField="StockDamage" DataFormatString="{0:0}" HeaderText="Stock Damage"
                                meta:resourcekey="BoundFieldResource14"></asp:BoundField>
                            <asp:BoundField DataField="StockReturn" DataFormatString="{0:0}" HeaderText="Stock Return"
                                meta:resourcekey="BoundFieldResource15"></asp:BoundField>
                            <asp:BoundField DataField="ClosingBalance" DataFormatString="{0:N}" HeaderText="Closing Balance"
                                meta:resourcekey="BoundFieldResource16"></asp:BoundField>
                            <asp:BoundField DataField="ClosingStockValue" DataFormatString="{0:N}" HeaderText="Closing Stock Value"
                                meta:resourcekey="BoundFieldResource17"></asp:BoundField>
                            <asp:BoundField DataField="Units" HeaderText="Units" meta:resourcekey="BoundFieldResource18">
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnProductCategories" runat="server" />
    <input type="hidden" id="hdnProductCategorieschk" runat="server" />
    <input type="hidden" id="hdnIsflag" runat="server" />

    <script language="javascript" type="text/javascript">
        var common;
        $(window).on('load', function() {

            common = $('#hdnIsflag').val();
            LoadCategoryValue();
            $(document.body).click(function(e) {

                if (e.target.id != 'imgDDL' && e.target.parentElement.id != 'imgChklistdrp' && e.target.id != 'lblChk') {
                    if ($('#CheckBoxListDropDown').css('display') == 'block') {
                        $('#CheckBoxListDropDown').slideToggle('slow');
                    }
                    else if ($('#CheckBoxListDropDown').css('display') == 'inline') {
                        $('#CheckBoxListDropDown').slideToggle('slow');
                    }
                    else if ($('#CheckBoxListDropDown').css('display') == 'inline-block') {
                        $('#CheckBoxListDropDown').slideToggle('slow');
                    }
                }
            });
        });
        function LoadCategoryValue() {
            var AllMsg = SListForAppDisplay.Get("InventoryReports_AdminStockReport_aspx_01") == null ? "--ALL-- " : SListForAppDisplay.Get("InventoryReports_AdminStockReport_aspx_01");
            $('#CheckBoxListDropDown').html('');
            //$('[id$="hdnProductCategorieschk"]').val('');
            var tmpTable;
            var lstProductCategories = [];
            lstProductCategories = JSON.parse($('[id$="hdnProductCategories"]').val());
            tmpTable = "<table id ='tblPC' CELLSPACING=3px width=100%  CELLSPACING=0 style = 'border: thin solid #817679;'><tbody>";

            tmpTable += "<tr id ='imgtrchk'>";
            tmpTable += "<td id ='imgChklistdrp' align='left'><input id ='chkAll0' name='0' value ='0' type='checkbox' style='border-style:none;text-decoration:underline;cursor:pointer' onclick='ChkALL(this)' /></td>";
            tmpTable += "<td id ='lblChk' align='left'> " + AllMsg + "</td>";
            tmpTable += "</tr>";

            $.each(lstProductCategories, function(i, obj) {
                tmpTable += "<tr id ='imgtrchk'>";
                tmpTable += "<td id ='imgChklistdrp' align='left'><input id ='imgChklist" + obj.CategoryID + "' name='" + obj.CategoryName + obj.CategoryID + "' value ='" + obj.CategoryID + "' type='checkbox' style='border-style:none;text-decoration:underline;cursor:hand'  /></td>";
                tmpTable += "<td id ='lblChk' align='left'>" + obj.CategoryName + " </td>";
                tmpTable += "</tr>";

            });
            tmpTable += "</tbody>";
            tmpTable += "</table>";
            $('#CheckBoxListDropDown').html(tmpTable);
            if ($('[id$="hdnProductCategorieschk"]').val() != '') {
                var lstProductCategories_chk = [];
                lstProductCategories_chk = JSON.parse($('[id$="hdnProductCategorieschk"]').val());
                $.each(lstProductCategories_chk, function(i, obj) {
                    $('#imgChklist' + obj.CategoryID).attr('checked', 'checked');
                    $('#chkAll' + obj.CategoryID).attr('checked', 'checked');

                });
            }

        }

        function GetCategories() {
            //            debugger;
            var lstPC = [];
            var _flag = $('#hdnIsflag').val();

            if (_flag == 'true') {
                $('#hdnIsflag').val(_flag);
            }

            $("[id$='tblPC'] tbody  tr td input").each(function() {
                if ($(this).attr('checked')) {
                    if ($(this).attr('value') != '') {
                        lstPC.push({
                            CategoryID: $(this).attr('value')
                        });
                    }
                }
            });
            if (lstPC.length > 0) {
                $('[id$="hdnProductCategorieschk"]').val(JSON.stringify(lstPC));
                return true;
            }
            else {
                $('[id$="hdnProductCategorieschk"]').val('');
                var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_10") == null ? "please select the category name" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_10");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }

        function ToggleDDL(obj) {
            $('#CheckBoxListDropDown').slideToggle('slow');
        }

        function ChkALL(obj) {
            if ($(obj).attr('checked')) {
                $("[id$='tblPC'] tbody  tr td input").each(function() {
                    $(this).attr('checked', 'checked');
                });
            }
            else {
                $("[id$='tblPC'] tbody  tr td input").each(function() {
                    $(this).attr('checked', false);
                });
            }
        }

    
    </script>
    
    <script language="javascript" type="text/javascript">
        
        var userMsg;
        //Added by petchi for central hospital
        function ProductItemsSelected(source, eventArgs) {
            var Product = eventArgs.get_text().split('^^');
            document.getElementById('txtProduct').value = Product[0];

        }
 
        function onDivHide() {
            if (document.getElementById('ddlLocation').value == 0) {
                document.getElementById('divAll').style.display = 'block';
            }

            else {
                document.getElementById('divAll').style.display = 'none';
            }
        }
        function CheckDates(splitChar) {
            if (document.getElementById('txtFrom').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_02") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_03") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                //DateNow = now.split(splitChar);
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                //if (CheckFromToDate(DateTo, DateNow)) {
                if (CheckFromToDate(DateFrom, DateTo)) {
                        //alert("Validation Succeeded");

                        return true;
                    }
                    else {
                        return false;
                    }
               // }
               // else {
               //     return false;
               // }
            }
        }
        function ToDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_04") == null ? "Mismatch Day Between Current & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_04");
                                ValidationWindow(userMsg, errorMsg);
                                return false;
                            }
                            else {
                                var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_05") == null ? "Mismatch Day Between From & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_05");
                                ValidationWindow(userMsg, errorMsg);
                                return false;

                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_06") == null ? "Mismatch Month Between Current & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_06");
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                    else {
                        var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_07") == null ? "Mismatch Month Between From & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_07");
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_08") == null ? "Mismatch Year Between Current & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_08");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_09") == null ? "Mismatch Year Between From & To Date" : SListForAppMsg.Get("InventoryReports_AdminStockReport_aspx_09");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return false;
            }
        }
        function clearContextText() {

        }
$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
