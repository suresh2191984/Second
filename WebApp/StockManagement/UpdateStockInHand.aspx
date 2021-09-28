<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateStockInHand.aspx.cs"
    Inherits="StockManagement_UpdateStockInHand" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
       <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>poo--%>
                <table runat="server" class="w-100p">
                    <tr runat="server">
                        <td class="a-right" runat="server">
                            <asp:Label ID="lblSelectCategory" runat="server" Text="Select Category" 
                                meta:resourcekey="lblSelectCategoryResource1"></asp:Label>
                        </td>
                        <td class="w-140 a-left" runat="server">
                            <asp:DropDownList ID="ddlCategory" runat="server"  CssClass="small" 
                                meta:resourcekey="ddlCategoryResource1">
                            </asp:DropDownList>
                        </td>
                        <td class="a-right" runat="server">
                            <asp:Label ID="lblProduct" runat="server" Text="Product" 
                                meta:resourcekey="lblProductResource1"></asp:Label>
                        </td>
                        <td class="a-left" runat="server">
                            <asp:TextBox ID="txtProduct"  CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);" 
                                meta:resourcekey="txtProductResource1"></asp:TextBox>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnSearch" OnClientClick="javascript:if(!checkValidation()) return false;"
                                runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" 
                                meta:resourcekey="btnSearchResource1" />
                        </td>
                        <td runat="server">
                            <asp:Button ID="btnAddProduct" runat="server" CssClass="btn" Text="Add Products"
                                OnClick="btnAddProduct_Click" 
                                meta:resourcekey="btnAddProductResource1" />
                        </td>
                    </tr>
                    <tr runat="server">
                        <td colspan="5" class="a-center" runat="server">
                            <asp:ListBox ID="listSearch" Visible="False" runat="server" CssClass="h-100 w-400"
                                onClick="javascript:setItem(this.id);" 
                                meta:resourcekey="listSearchResource1"></asp:ListBox>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="a-center h-15" colspan="6" runat="server">
                            <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                            <hr />
                                    <asp:Image ID="Image1" ImageUrl="~/PlatForm/Images/ajax-loader.gif" Visible="false"
                                runat="server" meta:resourcekey="Image1Resource1" />
                                    <asp:Label ID="lblWait" Text="Please Wait....." runat="server" 
                                meta:resourcekey="lblWaitResource1" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td colspan="6" runat="server">
                              <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                                                AutoGenerateColumns="False" CssClass="gridView w-100p"
                                                OnRowDataBound="grdResult_RowDataBound" 
                                                OnRowCommand="grdResult_RowCommand" 
                                                OnPageIndexChanging="grdResult_PageIndexChanging" 
                                  AllowPaging="True" meta:resourcekey="grdResultResource1">
                                 <PagerStyle HorizontalAlign="Center"
                                                    CssClass="gridPager" />
                                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                    NextPageText="" PreviousPageText="" />
                                <Columns>
                                    <asp:BoundField HeaderText="Product" DataField="ProductName" 
                                        meta:resourcekey="BoundFieldResource1">
                                        <HeaderStyle CssClass="a-left w-100" />
                                        <ItemStyle CssClass="a-left w-160" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Batch No" 
                                        meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="txtBatchNo" Text='<%# Eval("BatchNo") %>' CssClass="w-60" 
                                                runat="server" ></asp:Label>
                                        </ItemTemplate>
                                       <HeaderStyle HorizontalAlign="Left" Width="100px" />
                                                        <ItemStyle HorizontalAlign="Left" Width="160px" />
                                        
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stock In Hand" 
                                        meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:TextBox onkeypress="return ValidateSpecialAndNumeric(this);" Text='<%# Eval("InHandQuantity") %>' 
                                                CssClass="w-60" ID="txtQuantity" runat="server" 
                                                meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnRid" Value='<%# Eval("ID") %>' runat="server" />
                                            <asp:HiddenField ID="hdnCategoryId" Value='<%# Eval("CategoryId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnProductId" Value='<%# Eval("ProductId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnprovidedby" Value='<%# Eval("providedby") %>' runat="server" />
                                            <asp:HiddenField ID="hdnProductName" Value='<%# Eval("ProductName") %>' runat="server" />
                                            <asp:HiddenField ID="hdnDescription" Value='<%# Eval("Description") %>' runat="server" />
                                            <asp:HiddenField ID="hdnInHandQuantity" Value='<%# Eval("InHandQuantity") %>' runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="a-left w-90" Wrap="False" />
                                        <ItemStyle CssClass="a-left w-90" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Available Stock" 
                                        meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInHandQuantity" Text='<%# Eval("InHandQuantity") %>' 
                                                runat="server" meta:resourcekey="lblInHandQuantityResource1"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="w-20" Wrap="False" />
                                        <ItemStyle CssClass="a-left w-20" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" 
                                        meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Button ID="btnSave" CommandName="INVSave" runat="server" Text="Update" CssClass="btn1"
                                                meta:resourcekey="btnSaveResource1" />
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="a-left" />
                                        <ItemStyle CssClass="w-60" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="a-center"  colspan="6" runat="server">
                           <asp:Label runat="server" ID="lblMessage" meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="a-center" colspan="6" runat="server">
                            <asp:Button ID="btnUpdate" Text="Update" runat="server"
                                CssClass="btn" OnClick="btnUpdate_Click" 
                                meta:resourcekey="btnUpdateResource1" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" 
                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
           <%-- </ContentTemplate>
        </asp:UpdatePanel>poo--%>
        <asp:HiddenField ID="hdnUpdate" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </div>
    </form>
    
<script type="text/javascript" language="javascript">
        var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_02');
</script>
<script type="text/javascript" language="javascript">

    var ErrMsg = SListForAppMsg.Get("StockManagement_Error") == null ? "Alert" : SListForAppMsg.Get("StockManagement_Error");
    var infromMsg = SListForAppMsg.Get("StockManagement_Information") == null ? "Information" : SListForAppMsg.Get("StockManagement_Information");
    var OkMsg = SListForAppMsg.Get("StockManagement_Ok") == null ? "Ok" : SListForAppMsg.Get("StockManagement_Ok");
    var CancelMsg = SListForAppMsg.Get("StockManagement_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockManagement_Cancel");
    function ShowAlertMsg(key) {
        var userMsg = SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_01') == null ? "Please enter stock" : SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_01');
        ValidationWindow(userMsg, ErrMsg);
        return true;
    }
    function checkValidation() {
        if (document.getElementById('txtProduct').value.trim() == '') {
            var userMsg = SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_02') == null ? "Provide the product name" : SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_02');
            ValidationWindow(userMsg, ErrMsg);
            document.getElementById('txtProduct').focus();
            return false;
        }
        if (document.getElementById('txtProduct').value.trim().length < 2) {
            var userMsg = SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_03') == null ? "Provide minimum two characters" : SListForAppMsg.Get('StockManagement_UpdateStockInHand_aspx_03');
            ValidationWindow(userMsg, ErrMsg);
            document.getElementById('txtProduct').focus();
            return false;
        }
        return true;
    }
    function ProductsListPopup(obj) {
        window.open("PopUpProductUpdate.aspx?val=" + obj + "", null, "height=450,width=850,scrollbars=yes");
        return false;

    }

    function setItem(id) {
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');
        document.getElementById("txtProduct").value = obj.options[obj.selectedIndex].text;
        //            document.getElementById("btnSearch").click();
    }

    function ValidateInHandQuantity(uQty, sQty) {
        alert(uQty);
        alert(sQty);
    }
    </script>
    
</body>
</html>
