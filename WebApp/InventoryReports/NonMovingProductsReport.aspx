<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NonMovingProductsReport.aspx.cs"
    Inherits="InventoryReports_NonMovingProductsReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Non-Moving Products Report</title>

    <script language="javascript" type="text/javascript">
       
       
        function onDivHide() {
            if (document.getElementById('ddlLocation').value == 0) {
                document.getElementById('divAll').style.display = 'block';
            }

            else {
                document.getElementById('divAll').style.display = 'none';
            }
        }

    </script>

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
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error")
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information")
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel")
</script>
    <div class="contentdata">
        <table id="tblCollectionOPIP" align="center">
            <tr align="center">
                <td align="center">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <div class="dataheaderWider">
                                            <table border="0" width="100%" cellpadding="2" cellspacing="2">
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtFrom" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            CssClass="datePicker" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtTo" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            CssClass="datePicker" ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="lblDepartment" Text="Department" CssClass="label_title"
                                                            meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:DropDownList ID="ddlLocation" onchange="onDivHide();" Width="130px" runat="server"
                                                            meta:resourcekey="ddlLocationResource1">
                                                        </asp:DropDownList>
                                                        <div id="divAll" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:RadioButton GroupName="all" ID="rdosummary" Checked="True" Text="Summary" runat="server"
                                                                            meta:resourcekey="rdosummaryResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:RadioButton GroupName="all" ID="rdodetails" Text="Details" runat="server" meta:resourcekey="rdodetailsResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="lblCat" Text="Category" CssClass="label_title" meta:resourcekey="lblCatResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <img id="imgDDL" alt="DDL" src="../PlatForm/Images/DDL.png" onclick="ToggleDDL(this);" />
                                                        <div id="CheckBoxListDropDown" class="s1" style="display: none" runat="server">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="lblProduct" Text="Product Name" CssClass="label_title"
                                                            meta:resourcekey="lblProductResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtProduct" OnkeyPress="return ValidateMultiLangCharacter(this)"
                                                            runat="server" Width="130px" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td align="left">
                                                        <asp:CheckBox ID="chkNilStock" runat="server" meta:resourcekey="chkNilStockResource1" />
                                                        <asp:Label ID="lblShowNill" Text="Show Nil Stocks" runat="server" meta:resourcekey="lblShowNillResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 25px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" align="right">
                                                        <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                            OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:HyperLink ID="hypLnkExportXL" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                            Target="XLWindow" runat="server" ToolTip="Save As Excel" meta:resourcekey="hypLnkExportXLResource1">
                                                            <img id="imgXL" alt="To XL" runat="server" style="border-width: 0px;" src="~/Images/ExcelImage.GIF" />
                                                            <asp:Label ID="lblExport" Text="Export To XL" runat="server" meta:resourcekey="lblExportResource1"></asp:Label></asp:HyperLink>
                                                        &nbsp;&nbsp;&nbsp;
                                                        <asp:HyperLink ID="hypLnkPrint" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                            Target="BillWindow" runat="server" ToolTip="Click Here To Print Stock Details"
                                                            meta:resourcekey="hypLnkPrintResource1">
                                                            <img id="imgPrint" alt="To Print" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                                                            <asp:Label ID="lblPrint" Text="Print Stock Report" runat="server" meta:resourcekey="lblPrintResource1"></asp:Label></asp:HyperLink>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td valign="top">
                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                            meta:resourcekey="lnkBackResource1">
                                            <asp:Label ID="lblBack" Text="Back" runat="server" meta:resourcekey="lblBackResource1"></asp:Label></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                    <asp:Label ID="lblPlease" Text="Please wait...." runat="server" meta:resourcekey="lblPleaseResource1"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div>
                                <asp:Repeater ID="rptHeader" OnItemDataBound="rptHeader_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <table border="1">
                                            <tr style="font-weight: bold;">
                                                <td align="center">
                                                    <asp:Label ID="lblDepartment" Text="Department" runat="server" meta:resourcekey="lblDepartmentResource2"></asp:Label>
                                                    :
                                                    <%# DataBinder.Eval(Container.DataItem, "LocationName")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <asp:Repeater ID="rptMiddle" OnItemDataBound="rptMiddle_ItemDataBound" runat="server">
                                                            <ItemTemplate>
                                                                <tr style="font-weight: bold; text-align: left;">
                                                                    <td>
                                                                        <asp:Label ID="lblCategory" Text="Category" runat="server" meta:resourcekey="lblCategoryResource1"></asp:Label>
                                                                        :
                                                                        <%# DataBinder.Eval(Container.DataItem, "CategoryName")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="grdResult" AllowPaging="True" runat="server" AutoGenerateColumns="False"
                                                                            CellPadding="2" DataKeyNames="LocationID,CategoryID" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                            CellSpacing="1" OnRowDataBound="grdResult_RowDataBound" ForeColor="Black" Width="100%"
                                                                            meta:resourcekey="grdResultResource1">
                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="Product" meta:resourcekey="TemplateFieldResource1">
                                                                                    <ItemTemplate>
                                                                                        <asp:HyperLink ID="hypProduct" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("ProductName") %>'
                                                                                            Target="_blank" runat="server" meta:resourcekey="hypProductResource1"></asp:HyperLink>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="OpeningBalance" DataFormatString="{0:0}" HeaderText="Opening Balance"
                                                                                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                                                                <asp:BoundField DataField="OpeningStockValue" DataFormatString="{0:0.00}" HeaderText="Opening Stock Value"
                                                                                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockReceived" DataFormatString="{0:0}" HeaderText="Stock Received"
                                                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockDamage" DataFormatString="{0:0}" HeaderText="Stock Damage"
                                                                                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                                                                <asp:BoundField DataField="StockReturn" DataFormatString="{0:0}" HeaderText="Stock Return"
                                                                                    meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                                                                                <asp:BoundField DataField="ClosingBalance" DataFormatString="{0:0}" HeaderText="Closing Balance"
                                                                                    meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                                                                                <asp:BoundField DataField="ClosingStockValue" DataFormatString="{0:0.00}" HeaderText="Closing Stock Value"
                                                                                    meta:resourcekey="BoundFieldResource7"></asp:BoundField>
                                                                                <asp:BoundField DataField="Units" HeaderText="Units" meta:resourcekey="BoundFieldResource8">
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
                                <div style="width: 100%; display: none; float: left;">
                                    <div style="text-align: right; padding-right: 8%;">
                                        <strong>
                                            <asp:Label ID="lblTotal" Text="Total Stock Value" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label></strong>
                                        &nbsp; &nbsp; &nbsp;
                                        <asp:Label ID="lblTotalStockValue" Text="0" runat="server" meta:resourcekey="lblTotalStockValueResource1"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:GridView ID="grdXLResult" runat="server" AutoGenerateColumns="False" CellPadding="2"
                        CellSpacing="1" OnRowDataBound="grdResult_RowDataBound" ForeColor="Black" Width="100%"
                        meta:resourcekey="grdXLResultResource1">
                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="Product" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hypProduct" ForeColor="Blue" h Font-Size="12px" Text='<%# Eval("ProductName") %>'
                                        Target="_blank" runat="server"></asp:HyperLink>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OpeningBalance" DataFormatString="{0:0}" HeaderText="Opening Balance"
                                meta:resourcekey="BoundFieldResource9"></asp:BoundField>
                            <asp:BoundField DataField="OpeningStockValue" DataFormatString="{0:0.00}" HeaderText="Opening Stock Value"
                                meta:resourcekey="BoundFieldResource10"></asp:BoundField>
                            <asp:BoundField DataField="StockReceived" DataFormatString="{0:0}" HeaderText="Stock Received"
                                meta:resourcekey="BoundFieldResource11"></asp:BoundField>
                            <asp:BoundField DataField="StockIssued" DataFormatString="{0:0}" HeaderText="Stock Issued"
                                meta:resourcekey="BoundFieldResource12"></asp:BoundField>
                            <asp:BoundField DataField="StockDamage" DataFormatString="{0:0}" HeaderText="Stock Damage"
                                meta:resourcekey="BoundFieldResource13"></asp:BoundField>
                            <asp:BoundField DataField="StockReturn" DataFormatString="{0:0}" HeaderText="Stock Return"
                                meta:resourcekey="BoundFieldResource14"></asp:BoundField>
                            <asp:BoundField DataField="ClosingBalance" DataFormatString="{0:0}" HeaderText="Closing Balance"
                                meta:resourcekey="BoundFieldResource15"></asp:BoundField>
                            <%--  <asp:BoundField DataField="CurrentSellingPrice" DataFormatString="{0:0}" HeaderText="CSPrice">
                                                </asp:BoundField>--%>
                            <asp:BoundField DataField="ClosingStockValue" DataFormatString="{0:0.00}" HeaderText="Closing Stock Value"
                                meta:resourcekey="BoundFieldResource16"></asp:BoundField>
                            <asp:BoundField DataField="Units" HeaderText="Units" meta:resourcekey="BoundFieldResource17">
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
            $('#CheckBoxListDropDown').html('');
            //$('[id$="hdnProductCategorieschk"]').val('');
            var tmpTable;
            var strAll = SListForAppDisplay.Get("InventoryReports_NonMovingProductsReport_aspx_02") == null ? " --ALL--" : SListForAppDisplay.Get("InventoryReports_NonMovingProductsReport_aspx_02");
            var lstProductCategories = [];
            lstProductCategories = JSON.parse($('[id$="hdnProductCategories"]').val());
            tmpTable = "<table id ='tblPC' CELLSPACING=3px width=100%  CELLSPACING=0 style = 'border: thin solid #817679;'><tbody>";

            tmpTable += "<tr id ='imgtrchk'>";
            tmpTable += "<td id ='imgChklistdrp' align='left'><input id ='chkAll0' name='0' value ='0' type='checkbox' style='border-style:none;text-decoration:underline;cursor:pointer' onclick='ChkALL(this)' /></td>";
            tmpTable += "<td id ='lblChk' align='left'> " + strAll + "</td>";
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
                var userMsg = SListForAppMsg.Get("InventoryReports_NonMovingProductsReport_aspx_02") == null ? "please select the category name" : SListForAppMsg.Get("InventoryReports_NonMovingProductsReport_aspx_02");
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

    $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
