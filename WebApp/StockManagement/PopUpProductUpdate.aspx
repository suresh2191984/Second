<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="true" CodeFile="PopUpProductUpdate.aspx.cs"
    Inherits="StockManagement_PopUpProductUpdate" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Products List</title>
</head>
<body>
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:Panel ID="panelContainer" runat="server" CssClass="hide">
    </asp:Panel>
    <div class="contentdata">
        <table class="searchPanel w-100p">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                                AutoGenerateColumns="False" OnRowCommand="grdResult_RowCommand" CssClass="gridView w-100p"
                                HeaderStyle-CssClass="gridHeader" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                <Columns>
                                    <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource1" />
                                    <asp:TemplateField HeaderText="BatchNo" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("BatchNo") %>' ID="txtBatchNo" onkeypress="return ValidateMultiLangChar(this);"
                                                runat="server" CssClass="xsmaller"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EXP Date" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <%--  <asp:DropDownList ID="ddlExpMonth" runat="server" CssClass="mini ddlTheme" meta:resourcekey="ddlExpMonthResource1">
                                            </asp:DropDownList>--%>
                                            <asp:DropDownList ID="ddlExpMonth" CssClass="ddlTheme w-50" runat="server"
                                                meta:resourcekey="ddlExpMonthResource1">
                                                <asp:ListItem Text="MMM" Value="-1" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                                <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlExpYear" runat="server" CssClass="xsmaller ddlTheme" meta:resourcekey="ddlExpYearResource1">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rcvd Qty" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("InHandQuantity") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                ID="txtQuantity" runat="server" CssClass="tiny"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Units" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlUnit" Enabled="False" runat="server" CssClass="mini ddlTheme"
                                                meta:resourcekey="ddlUnitResource1">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Unit Price" meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("UnitPrice") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                ID="txtUnitPrice" onblur="calculateselling(this);" runat="server" CssClass="smaller"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Selling Price" meta:resourcekey="TemplateFieldResource6">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("Rate") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                ID="txtSellingPrice" runat="server" CssClass="smaller"></asp:TextBox>
                                            <asp:HiddenField ID="hdnRid" Value='<%# Eval("ID") %>' runat="server" />
                                            <asp:HiddenField ID="hdnCategoryId" Value='<%# Eval("CategoryId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnProductId" Value='<%# Eval("ProductId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnProductName" Value='<%# Eval("ProductName") %>' runat="server" />
                                            <asp:HiddenField ID="hdnCategoryName" Value='<%# Eval("CategoryName") %>' runat="server" />
                                            <asp:HiddenField ID="hdnProductCode" Value='<%# Eval("ProductCode") %>' runat="server" />
                                            <asp:HiddenField ID="hdnDescription" Value='<%# Eval("Description") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tax%" meta:resourcekey="TemplateFieldResource7">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("Tax") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                onblur="calculateselling(this);" ID="txtTax" runat="server" CssClass="tiny"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rack No" meta:resourcekey="TemplateFieldResource8">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("RakNo") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                ID="txtRakNo" runat="server" CssClass="tiny"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks" meta:resourcekey="TemplateFieldResource9">
                                        <ItemTemplate>
                                            <asp:TextBox Text='<%# Eval("Remarks") %>' ID="txtPrdtRemarks" onkeypress="return ValidateMultiLangChar(this);"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="15%" Wrap="True" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource10">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnAdd" CommandArgument="INVAdd" runat="server" class="ui-icon ui-icon-plus b-none pointer pull-left marginL5"
                                                meta:resourcekey="lbtnAddResource1"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDelete" CommandArgument="INVDetete" runat="server" class="ui-icon ui-icon-trash b-none pointer pull-left marginL5"
                                                meta:resourcekey="lbtnDeleteResource1"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridPager" />
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <a class="cancel-btn" href="javascript:window.close();">
                        <%=Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_01%>
                    </a>&nbsp;&nbsp;
                    <asp:Button ID="btnSearch" runat="server" Text="OK" CssClass="btn1" OnClick="btnSearch_Click"
                        meta:resourcekey="btnSearchResource1" />
                    &nbsp;&nbsp;
                    <input type="hidden" id="hdnorgid" runat="server" />
                    <input type="hidden" id="hdnValues" value="N" runat="server" />
                    <input type="hidden" id="hdnorgAddressid" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnSellingPrieRuleList" runat="server" />
    <asp:HiddenField ID="hdnIsSellingPriceRuleApply" runat="server" Value="N" />
    </form>

<script type="text/javascript" language="javascript">
    var errorMsg = SListForAppMsg.Get("StockManagement_Error") != null ? SListForAppMsg.Get("StockManagement_Error") : "Alert";
    var InformationMsg = SListForAppMsg.Get("StockManagement_Information") != null ? SListForAppMsg.Get("StockManagement_Information") : "Information";
    var okMsg = SListForAppMsg.Get("StockManagement_Ok") != null ? SListForAppMsg.Get("StockManagement_Ok") : "Ok";
    var CancelMsg = SListForAppMsg.Get("StockManagement_Cancel") != null ? SListForAppMsg.Get("StockManagement_Cancel") : "Cancel";
        </script>
<script language="javascript" type="text/javascript">


    function ShowAlertMsg3() {
        var userMsg = SListForAppMsg.Get("StockManagement_PopUpProductUpdate_aspx_01") == null ? "Product combination already exist" : SListForAppMsg.Get("StockManagement_PopUpProductUpdate_aspx_01");
        ValidationWindow(userMsg, errorMsg);
        return true;
    }
    function refreshparent() {
        if (document.getElementById('hdnValues').value == 'Y') {

            if (!window.opener.location)
                window.opener.location = self;

            window.close();
        }
    }
    function nameValidate() {

        window.opener.document.getElementById('hdnUpdate').value = "Update";
        // window.parent.document.getElementById('hdnUpdate').value
        if (document.getElementById('hdnValues').value == 'Y') {
            //window.opener.location.reload();
            window.opener.document.forms[0].submit();
            window.close();
            return false;
        }
    }

    function calculateselling(ele) {
        var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
        if (IsRule == "Y") {
            var idFrame = $(ele).attr('id').split('_');
            var unitPrice = idFrame[0] + '_' + idFrame[1] + '_' + 'txtUnitPrice';
            var sPrice = idFrame[0] + '_' + idFrame[1] + '_' + 'txtSellingPrice';
            var Tax = idFrame[0] + '_' + idFrame[1] + '_' + 'txtTax';
            AutoSellingprice(unitPrice, sPrice, Tax);
        }

    }

    function AutoSellingprice(unitPrice, sPrice, Tax) {
        var Istrue = false;

        var pNominalDiscount = 0;
        var pselval = document.getElementById('hdnSellingPrieRuleList').value.split("^");
        var tax = ToInternalFormat($('#' + Tax)) == 0.00 ? 0 : ToInternalFormat($('#' + Tax));
        var Costprice = ToInternalFormat($('#' + unitPrice)) == 0.00 ? 0 : ToInternalFormat($('#' + unitPrice));
        var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($('#' + unitPrice)) == 0.00 ? 0 : ToInternalFormat($('#' + unitPrice));
        var tempTaxAmt = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
        var sellingPrice = 0.00;
        var Price = 0.00;
        Price = parseFloat(parseFloat(UnitPrice) + parseFloat(tempTaxAmt)).toFixed(6);

        var i;
        if (Price > 0) {

            for (i = 0; i < pselval.length; i++) {
                if (pselval[i] != "" && Istrue == false) {
                    p_sel = pselval[i].split('~');

                    if (parseFloat(Price) >= parseFloat(p_sel[1]) && parseFloat(Price) <= parseFloat(p_sel[2])) {

                        sellingPrice = parseFloat(parseFloat(Price) + parseFloat(parseFloat(Price) * parseFloat(parseFloat(p_sel[3]) / 100))).toFixed(6)
                        $('#' + sPrice).val(parseFloat(sellingPrice).toFixed(6));
                        ToTargetFormat($('#' + sPrice));
                        Istrue = true;
                    }

                }
            }
        }
    }
    
    </script>
<script language="javascript" type="text/javascript">
    nameValidate()
</script>

</body>
</html>
