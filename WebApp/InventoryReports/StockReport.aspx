<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReport.aspx.cs" Inherits="InventoryReports_StockReport"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Reports</title>
    <style>
        #CheckBoxListDropDown
        {
            position: absolute;
            background: #fff;
            width: 168px;
            height: 200px;
            overflow: auto;
        }
        #divPrintareaReport table tr td strong
        {
            padding-right: 40px;
        }
        .wordb
        {
            word-wrap: break-word;
            word-break: break-all;
        }
        .o-auto
        {
            overflow: auto;
        }
    </style>    
</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr class="panelContent">
                <td class="a-center">
                    <table id="tblStock"  class="w-100p searchPanel">
                        <tr class="a-left panelContent lh30">
                            <td class="a-left w-12p">
	                            <asp:Label ID="lblOrgs" runat="server" CssClass="small" Text="Select an Organization" 
		                            meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td class="w-17p">
	                            <asp:DropDownList ID="ddlTrustedOrg" OnSelectedIndexChanged="LoadsharedorgLocation" AutoPostBack="true" runat="server"
		                            CssClass="small" meta:resourcekey="ddlTrustedOrgResource1" >
	                            </asp:DropDownList>
                            </td>
                            <td class="w-7p">
                                <asp:Label ID="lblFrom" runat="server" Text="From" class="show" meta:resourcekey="lblFromResource1"></asp:Label>
                            </td>
                            <td class="w-17p">
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="datePicker small" TabIndex="1"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" MaxLength="1"
                                    meta:resourcekey="txtFromResource1" />
                            </td>
                            <td class="w-7p">
                                <asp:Label ID="lblTo" runat="server" Text="To" class="show" meta:resourcekey="lblToResource1"></asp:Label>
                            </td>
                            <td class="w-17p">
                                <asp:TextBox ID="txtTo" runat="server" CssClass="datePicker small" TabIndex="2"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" MaxLength="1" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label ID="lblProductName" class="show" runat="server" Text="Product Name" meta:resourcekey="lblProductNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" runat="server" OnkeyPress="return ValidateMultiLangChar(this)"
                                    CssClass="small bg-searchimage" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False" MinimumPrefixLength="1"
                                    CompletionInterval="10" CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" DelimiterCharacters=";,:" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr class="a-left  lh30">
                            <td>
                                    <asp:Label ID="Rs_CategoryName" Text="Category Name" class="show" onChange="chkdrpdown();" 
                                        runat="server" meta:resourcekey="Rs_CategoryNameResource1"></asp:Label>
                            </td>
                            <td>
                                    <img src="../PlatForm/Images/DDL.png" id="imgDDL" alt="DDL" class="a-center" onclick="ToggleDDL(this);" />
                                <div id="CheckBoxListDropDown" class="s1 hide borderGrey" runat="server">
                                </div>
                            </td>
                            <td>
                                <asp:Label ID="lblDepartment" runat="server" Text="Department"  class="show"  meta:resourcekey="lblDepartmentResource1"></asp:Label>
                            </td>
                                                    <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" TabIndex="4" CssClass="small"
                                    meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList> </td>
                          
                            <td>
                                <asp:Label ID="lblRak" runat="server" Text="RakNo"  class="show"  meta:resourcekey="lblRakNoResource1"></asp:Label>
                            </td>
                                                    <td>
                                <asp:TextBox ID="txtRak" runat="server" TabIndex="4" CssClass="small"
                                    meta:resourcekey="txtRakNoResource">
                                </asp:TextBox>
                              
                                                    </td>
                            <td id="savecancel" runat="server" class="a-center" colspan="2">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                                        OnClientClick="javascript:return GetCategories()" OnClick="btnSearch_Click" TabIndex="6"
                                                                        meta:resourcekey="btnSearchResource1" /> &nbsp;&nbsp;
                                                                    <asp:Button ID="lnkBack" ToolTip="Search" meta:resourcekey="lnkBacksResource1" runat="server"
                                                                        Text="Back" CssClass="cancel-btn" OnClick="lnkBack_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td id="tdExcel" runat="server" class=" w-50p a-left hide">
                                                        <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" CssClass="marginL5"
                                                            ToolTip="Save As Excel" ImageUrl="../PlatForm/images/ExcelImage.GIF" meta:resourcekey="imgBtnXLResource1" />
                                                        <%--<asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" ToolTip="Save As Excel"
                                                            CssClass="pull-left" meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>--%>
                                                        <asp:ImageButton ID="imgBtnPrint" runat="server" CssClass="marginL5" ImageUrl="~/PlatForm/images/printer.gif"
                                                            ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"
                                                            meta:resourcekey="imgBtnPrintResource1" />
                                                        <asp:LinkButton ID="lnkPrint" runat="server" OnClientClick="return CallPrint();"
                                                            ToolTip="Click Here To Print Stock Details" meta:resourcekey="lnkPrintResource1">
                                                             <u>
                                                                <asp:Label ID="lblPrint" runat="server" Text="Print" meta:resourcekey="lblPrintResource1"></asp:Label>
                                                            </u>
                                                        </asp:LinkButton>
                                                    </td>
                        </tr>
                        <tr class="lh20">
                            <td class="a-left" colspan="2">
                                <table class="">
                                    <tr>
                                        <td class="a-left">
                                            <asp:Panel ID="Panel2" CssClass="divscheduler-border" GroupingText="Expired Type" 
                                                runat="server" meta:resourcekey="Panel2Resource1">
                                                <asp:RadioButtonList ID="rdoexpirydate" runat="server" RepeatDirection="Horizontal"
                                                    meta:resourcekey="rdoexpirydateResource1" class=" w-100p">
                                                    <asp:ListItem Text="Show Expired Drugs" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    <asp:ListItem Text="Show Non-Expired Drugs" Selected="True" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    <asp:ListItem Text="Both" Value="2" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class=" a-left" colspan="2">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel3" CssClass="divscheduler-border w-85p" GroupingText="Order by :" 
                                                            runat="server" meta:resourcekey="Panel3Resource1">
                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rdofastslow" runat="server"
                                                                class=" w-100p" meta:resourcekey="rdofastslowResource1">
                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource7">Slow Moving</asp:ListItem>
                                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource8">Fast Moving</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                            <td class="" colspan="2">
                                            <asp:Panel ID="Panel4" CssClass="divscheduler-border w-85p" GroupingText="Group by :" meta:resourcekey="Paymenttyperesource1"
                                                runat="server">
                                                <asp:RadioButtonList ID="rdoGroupBy" runat="server" RepeatDirection="Horizontal"
                                                    class=" w-100p" meta:resourcekey="rdoGroupByResource1">
                                                    <asp:ListItem Text="Category" meta:resourcekey="Rs_CategoryResource1" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Product" meta:resourcekey="Rs_ProductResource1" Selected="True"
                                                        Value="1"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </asp:Panel>
                                        </td>
                            <td class="" colspan="2">
                               <table class=" w-100p">
                                    <tr>
                                        <td nowrap="nowrap" class="a-left">
                                            <asp:Panel ID="Panel1" CssClass="divscheduler-border w-85p" GroupingText="Stock Type" 
                                                runat="server" meta:resourcekey="Panel1Resource1">
                                                <asp:RadioButtonList ID="rdostock" runat="server" RepeatDirection="Horizontal" meta:resourcekey="rdostockResource1"
                                                    class=" w-100p">
                                                    <asp:ListItem Text="Nil Stocks" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="Non-Zero Stocks" Value="1" Selected="True" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    <asp:ListItem Text="All Stocks" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr> <%--kumaresan--%>
                            <td>
                                <div class="o-auto" id="divPrintareaReport">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <strong style="padding-right:40px;">
                                                    <asp:Label ID="lblTotalStockValueinCP" runat="server" Text="Total Stock Value in CP:"
                                                        meta:resourcekey="lblTotalStockValueinCPResource1"></asp:Label>
                                                    <asp:Label ID="lblTotalStockValueCP" Text="0" CssClass="bold" runat="server" meta:resourcekey="lblTotalStockValueCPResource1"></asp:Label></strong>
                                                <strong style="padding-right:40px;">
                                                    <%--<asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>--%>
                                                    <asp:Label ID="lblTotalStockValueinSP1" runat="server" Text="Total Stock Value in SP:" meta:resourcekey="lblTotalStockValueinSP1Resource1"></asp:Label>
                                                    <asp:Label ID="lblTotalStockValueSP" CssClass="bold" Text="0" runat="server" meta:resourcekey="lblTotalStockValueSPResource1"></asp:Label></strong>
                                                    <strong>
                                            </td>
                                            <td class="a-right hide">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            <div id="divpanels"   >
                                                <asp:Repeater ID="idRep"  runat="server">
                                                    <HeaderTemplate>
                                                        <table class="gridView w-100p font11">
                                                            <tr class="gridHeader">
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    BatchNo
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Item Code
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Category
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Manufacturer name
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Supplier name
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Department name
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Invoice Date
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    SRD No
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Product name
                                                                </td>
                                                                 <td rowspan="2" nowrap="nowrap">
                                                                    Expiry Date
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    RakNo
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    UOM
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Unit Price CP
                                                                </td>
                                                                <td rowspan="2" nowrap="nowrap">
                                                                    Unit Price SP
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Opening balance
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Received
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Usage
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Damaged
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Returned
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Expired
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Issued
                                                                </td>
                                                                <td colspan="3" nowrap="nowrap">
                                                                    Closing balance
                                                                </td>
                                                            </tr>
                                                            <tr class="gridHeader">
                                                                <td nowrap="nowrap">
                                                                    No
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    Total Price CP
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    Total Price SP
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        No
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price CP
                                                                    </td>
                                                                    <td nowrap="nowrap">
                                                                        Total Price SP
                                                                    </td>
                                                            </tr>
                                                    </HeaderTemplate>
                                                            <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%# Eval("BatchNo")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("ProductCode")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("CategoryName")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("MfgName")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("SupplierName")%>
                                                            </td>
                                                             <td>
                                                                <%# Eval("LocationName")%>
                                                            </td>
                                                            <td>
                                                                <%# ((Eval("TDate", "{0:yyyy}")) == "1753" || (Eval("TDate", "{0:yyyy}")) == "9999" || (Eval("TDate", "{0:yyyy}")) == "0001" || (Eval("TDate", "{0:yyyy}")) == "1900") ? "**" : Eval("TDate", "{0: dd-MMM-yyyy}")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("SRDNo")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("ProductName")%>
                                                            </td>
                                                             <%--arya--%>
                                                             <td>
                                                                <%# ((Eval("ExpiredDate", "{0:yyyy}")) == "1753" || (Eval("ExpiredDate", "{0:yyyy}")) == "9999" || (Eval("ExpiredDate", "{0:yyyy}")) == "0001" || (Eval("ExpiredDate", "{0:yyyy}")) == "1900") ? "**" : Eval("ExpiredDate", "{0: MMM-yyyy}")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("RakNo")%>
                                                                    
                                                            </td>
                                                            <td>
                                                                <%# Eval("Units")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("CostPrice")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("CurrentSellingPrice")%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("OpeningBalance")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("OpeningBalance")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("OpeningBalance")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockReceived")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockReceived")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockReceived")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockUsage")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockUsage")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockUsage")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockDamage")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockDamage") )* Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockDamage")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockReturn")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockReturn")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}",(Convert.ToDecimal( Eval("StockReturn")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockExpiryDate")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockExpiryDate")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockExpiryDate")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("StockIssued")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockIssued")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("StockIssued")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# Eval("ClosingBalance")%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("ClosingBalance")) * Convert.ToDecimal(Eval("CostPrice"))).ToString())%>
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:D}", (Convert.ToDecimal(Eval("ClosingBalance")) * Convert.ToDecimal(Eval("CurrentSellingPrice"))).ToString())%>
                                                            </td>
                                                        </tr>
                                                            </ItemTemplate>
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="a-center">
                <td>
                    <asp:Button ID="btnHome" Text="Home" runat="server" CssClass="btn" OnClick="btnHome_Click"
                        TabIndex="7" Visible="False" meta:resourcekey="btnHomeResource1" />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnIsSellingPriceTypeRuleApply" runat="server" Value="N" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnProductCategories" runat="server" />
    <input type="hidden" id="hdnProductCategorieschk" runat="server" />
    <input type="hidden" id="hdnIsflag" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');

    var userMsg;
   
    function CallPrint() {
        var prtContent = document.getElementById('divPrintareaReport');
         $('#divpanels').removeAttr("style");
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0, width=1360, height=700');
        WinPrint.document.write(prtContent.innerHTML);
        setTimeout(function(){
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
        calcWidth();
        },2000);
        return false;
    }
    var common;
    $(document).ready(function() {
        calcWidth();
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $('#tdPrintarea').removeClass().addClass('hide');
        }


        common = $('#hdnIsflag').val();
        $('#CheckBoxListDropDown').html('');
        //$('[id$="hdnProductCategorieschk"]').val('');
        var tmpTable;
        var lstProductCategories = [];
        lstProductCategories = JSON.parse($('[id$="hdnProductCategories"]').val());
        tmpTable = "<table id ='tblPC' class='w-100p'><tbody>";

        tmpTable += "<tr id ='imgtrchk'>";
        tmpTable += "<td id ='imgChklistdrp' class='a-left'><input id ='chkAll0' name='0' value ='0' type='checkbox' CssClass='b-none pointer' onclick='ChkALL(this)' /></td>";
        tmpTable += "<td id ='lblChk' class='a-left'> --ALL-- </td>";
        tmpTable += "</tr>";

        $.each(lstProductCategories, function(i, obj) {
            tmpTable += "<tr id ='imgtrchk'>";
            tmpTable += "<td id ='imgChklistdrp' class='a-left'><input id ='imgChklist" + obj.CategoryID + "' name='" + obj.CategoryName + obj.CategoryID + "' value ='" + obj.CategoryID + "' type='checkbox' CssClass='b-none pointer'  onclick='DeChkALL(this)'/></td>";
            tmpTable += "<td id ='lblChk' class='a-left'>" + obj.CategoryName + " </td>";
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


        $(document.body).click(function(e) {

            if (e.target.id != 'imgDDL' && e.target.parentElement.id != 'imgChklistdrp' && e.target.id != 'lblChk') {
                if ($('#CheckBoxListDropDown').css('display') == 'block') {
                    $('#CheckBoxListDropDown').slideToggle('slow');
                }
            }
        });
    });

    function GetCategories() {
        //            debugger;
        calcWidth();
        var lstPC = [];
        var _flag = $('#hdnIsflag').val();

        if (_flag == 'true') {
            $('#hdnIsflag').val(_flag);
        }

        $("[id$='tblPC'] tbody  tr td input").each(function() {
            if ($(this).is(":checked")) {
                if ($(this).attr('value') != '') {
                    lstPC.push({
                        CategoryID: $(this).attr('value'),
                        OrgID: '<%= OrgID %>'
                    });
                }
            }
        });
        if (lstPC.length > 0) {
            $('[id$="hdnProductCategorieschk"]').val(JSON.stringify(lstPC));
            return true;
        }
        //        else {
        //            $('[id$="hdnProductCategorieschk"]').val('');
        //            alert('please select the category name');
        //            return false;
        //        }
    }

    function ToggleDDL(obj) {
        $('#CheckBoxListDropDown').slideToggle('slow');
    }

    function ChkALL(obj) {


        if ($(obj).is(":checked") == true) {
            $("[id$='tblPC'] tbody  tr td input").each(function() {
                $(this).attr("checked", true);

            });
        }
        else {
            $("[id$='tblPC'] tbody  tr td input").each(function() {
                $(this).attr('checked', false);

            });
        }
    }

    function DeChkALL(obj) {
        if ($(obj).is(":checked") == false) {

            $('#chkAll0').attr('checked', false);
        }
    }
      function calcWidth(){
      setTimeout(function(){
            var hgt = $('.contentdata').height() - $('#tblStock').height() - 30;
            var widt = $(window).width() - 8;
            $("#divpanels").css('height', hgt);
            $("#divpanels").css('width', widt);
            $("#divpanels").css('overflow', 'auto');
        },1000);
        }
      $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
</script>


