<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IssueStock.aspx.cs" Inherits="Inventory_IssueStock"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Issue Stock</title>
    <style type="text/css">
        #tat_table
        {
            width: 156px !important;
            border: 1px solid #d0d0d0;
        }
      .ui-dialog.ui-widget.ui-widget-content.popupBorder{ border:1px solid #ddd!important;}
      .ui-dialog.ui-widget.ui-widget-content.w-500{width: 500px !important;}
      .pos-top{top:15% !important; left:24% !important;}
    </style>
    <link href="../PlatForm/Scripts/DataTable/css/TableTools_JUI.css" rel="stylesheet"
        type="text/css" />
    <link href="../PlatForm/Scripts/DataTable/css/jquery.dataTables.css" rel="stylesheet"
        type="text/css" />
    <link href="../PlatForm/Scripts/DataTable/css/ModelPopUp.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

    <script src="../PlatForm/Scripts/DataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/DataTable/TableTools.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/DataTable/TableTools.min.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>

    <script src="Scripts/IssueStock.js" language="javascript" type="text/javascript"></script>

     <script language="javascript" src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js"
        type="text/javascript"></script>

    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div class="a-center w-60p" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="searchPanel w-100p" id="tabRecd" runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="stockIssuedTab" class="w-100p" runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_12 %>
                                        <asp:Label ID="lblDate" class='bold' runat="server" 
                                            meta:resourcekey="lblDateResource1"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_13 %>
                                        <asp:Label ID="lblIndentNo" class='bold' runat="server" 
                                            meta:resourcekey="lblIndentNoResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_14 %>
                                    </td>
                                    <td runat="server">
                                        <asp:DropDownList ID="ddlTrustedOrg" TabIndex="1" CssClass="medium" runat="server"
                                            OnChange="GetLocationlist();" meta:resourcekey="ddlTrustedOrgResource1">
                                        </asp:DropDownList>
                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_15 %>
                                    </td>
                                    <td runat="server">
                                        <asp:DropDownList ID="ddlLocation" TabIndex="1" runat="server" 
                                            CssClass="medium" meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td class="hide a-left" runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_16 %>
                                    </td>
                                    <td class="hide w-50" runat="server">
                                        <asp:DropDownList ID="ddlUser" TabIndex="2" runat="server" CssClass="medium" 
                                            meta:resourcekey="ddlUserResource1">
                                        </asp:DropDownList>
                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server">
                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_17 %>
                                    </td>
                                    <td runat="server">
                                        <div id="divsup1" runat="server" class="show">
                                            <asp:TextBox ID="txtComments" TabIndex="3" TextMode="MultiLine" runat="server" Columns="25"
                                                Rows="2" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td colspan="2" class="a-center" runat="server">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="v-top w-65p" runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <div class="w-100p">
                                            <asp:GridView ID="gvIndentDetails" EmptyDataText="No Matching Records Found!" runat="server"
                                                AllowPaging="True" AutoGenerateColumns="False"
                                                CssClass="gridView w-100p" GridLines="Both" PageSize="100" 
                                                OnRowDataBound="gvIndentDetails_RowDataBound" 
                                                meta:resourcekey="gvIndentDetailsResource1">
                                                <HeaderStyle CssClass="gridHeader" />
                                                <Columns>
                                                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                                        meta:resourcekey="BoundFieldResource1" />
                                                    <asp:TemplateField HeaderText="Ordered Qty" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity")) / Convert.ToInt32(Eval("OrderedConvertUnit")))) %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Ordered Qty" 
                                                        meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity"))))%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Issued Qty" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <%# (String.Format("{0}", Convert.ToInt32(Eval("InvoiceQty")) / Convert.ToInt32(Eval("OrderedConvertUnit"))))%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Issued Qty" 
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <%# (String.Format("{0}", Convert.ToInt32(Eval("InvoiceQty"))))%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="InHand Qty" 
                                                        meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:HiddenField runat="server" ID="hdnProductID" Value='<%# Bind("ProductID") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnInhandQuantity" Value='<%# Bind("ToInHandQuantity") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnOrderedQuantity" Value='<%# Bind("Quantity") %>' />
                                                            <%# (String.Format("{0}", Convert.ToInt32(Eval("ToInHandQuantity"))))%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnAction" runat="server" Text="Add" CssClass="btn" meta:resourcekey="btnActionResource1" />
                                                            <asp:Button ID="btnIndCancel" runat="server" Text="Cancel" CssClass="btn" meta:resourcekey="btnIndCancelResource1" />                                                         
                                                            <asp:Label ID="lblIndStatus"  runat="server" Text="" meta:resourcekey="lblIndStatusResource1"></asp:Label>
                                                            <asp:HiddenField ID="hdnProductName" Value='<%# Eval("ProductName") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div id="divParentBarCodeList">
                    <div id="divBarCodeList">
                        <table id="tblBarCodeList" class="gridView w-100p hide">
                            <thead>
                                <tr>
                                    <th>
                                       <asp:Label ID="lblProduct" Text="Product Name" runat="server" 
                                            meta:resourcekey="lblProductResource1"></asp:Label>
                                    </th>
                                    <th>
                                        <asp:Label ID="lblBarCode" Text="BarCode No" runat="server" 
                                            meta:resourcekey="lblBarCodeResource1"></asp:Label>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <table class=" w-100p">
                    <tr>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td id="tdSearch" runat="server" class="a-left v-middle">
                                        <asp:Label ID="lblmsg" Text="Search Product" CssClass="bold" runat="server" 
                                            meta:resourcekey="lblmsgResource2"></asp:Label>
                                        <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource2">
                                            <asp:TextBox ID="txtProduct" TabIndex="4" CssClass="medium" onkeypress="return ValidateMultiLangChar(this);" onkeyup="doClearTable();"
                                                runat="server" onblur="pSetFocus('pro');" 
                                                meta:resourcekey="txtProductResource2"></asp:TextBox>
                                            <asp:CheckBox ID="cheBarcodeSearch" runat="server" Text="Barcode" onClick="setProductContextKey()" meta:resourcekey="cheBarcodeSearchResource2"/>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="1" OnClientItemSelected="IAmSelectedJSON" ServiceMethod="GetIntendDetailStockIssueJSON"
                                                OnClientItemOver="doGetProductTotalQuantityJSON" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                TargetControlID="txtProduct">
                                            </ajc:AutoCompleteExtender>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-bottom paddingT10">
                                        <asp:Label ID="lblProdDesc" runat="server" class="w-100p" 
                                            meta:resourcekey="lblProdDescResource2"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top a-left">
                                        <div id="divProductDetails" runat="server" class="hide w-30p">
                                            <table id="TableProductDetails" runat="server" class="w-100p gridView marginT20">
                                                <tr class="gridHeader" runat="server">
                                                    <td runat="server">
                                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_18 %>
                                                        &nbsp;
                                                    </td>
                                                    <td runat="server">
                                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_19 %>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Label ID="lblType" Text="Issued Qty" runat="server" 
                                                            meta:resourcekey="lblTypeResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <%=Resources.StockIntend_ClientDisplay.StockIntend_Intend_aspx_20 %>
                                                        &nbsp;
                                                    </td>
                                                   <td id="Td1" runat="server">
                                                        <asp:Label ID="lblRak" Text="Rak No" runat="server" 
                                                            meta:resourcekey="lblRaknoResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                      <asp:Label ID="lblAction" Text="Action" runat="server" 
                                                            meta:resourcekey="lblActionResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtBatchNo" runat="server" TabIndex="5" onkeypress="return ValidateMultiLangChar(this);" onblur="return BindQuantity();"
                                                            CssClass="small" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtBatchQuantity" TabIndex="6" runat="server" ReadOnly="True" 
                                                            CssClass="small" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtBatchQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtQuantity" onblur="pSetAddFocus();" TabIndex="7" runat="server"
                                                           CssClass="small" 
                                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtUnit" runat="server" ReadOnly="True" TabIndex="8" 
                                                            CssClass="small" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtUnitResource1"></asp:TextBox>
                                                    </td>
                                                    <td  runat="server">
                                                        <asp:TextBox ID="txtRakNo" runat="server" ReadOnly="True" TabIndex="8" 
                                                            CssClass="small" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtRakNoResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <input id="add" class="btn" name="add" tabindex="9" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                            type="button" value="<%=Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_17%>" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblOrederedItems" class="gridView w-100p">
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Table CssClass=" w-100p" runat="server" meta:resourcekey="TableResource2">
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                            <table id="Table2" runat="server" class="paddingT10 w-100p">
                                <tr runat="server">
                                    <td class="a-center" runat="server">
                                        <input type="button" id="btnSaveAsDraft" value="<%=Resources.StockIntend_ClientDisplay.StockIntend_IssueStock_aspx_02%>" class="btn"
                                            onclick="fnSaveAsDrafts('ManualSave')" />
                                        <asp:Button ID="btnSubmit" TabIndex="10" AccessKey="S" OnClick="btnStockIssued_Click"
                                            Text="Submit" runat="server" CssClass="btn"
                                            OnClientClick="javascript:if(!checkDetails()) return false;" 
                                            meta:resourcekey="btnSubmitResource1" />
                                        <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn"
                                            Text="Back" meta:resourcekey="btnBackResource1" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnCancel" TabIndex="11" AccessKey="C" Text="Cancel" runat="server"
                                            CssClass="cancel-btn" OnClick="btnCancel_Click" 
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <input id="hdnProBatchNo" runat="server" type="hidden" >
                                    <input id="hdnBatchList" runat="server" type="hidden"></input>
                                        <input id="hdnProductId" runat="server" type="hidden"></input>
                                            <input id="hdnProductName" runat="server" type="hidden"></input>
                                                <input id="hdnReceivedID" runat="server" type="hidden"></input>
                                                    <input id="hdnSellingPrice" runat="server" type="hidden"></input>
                                                        <input id="hdnTax" runat="server" type="hidden"></input>
                                                            <input id="hdnExpiryDate" runat="server" type="hidden"></input>
                                                                <input id="hdnProductList" runat="server" type="hidden"></input>
                                                                    <input id="hdnRowEdit" runat="server" type="hidden"></input>
                                                                        <input id="hdnTasklist" runat="server" type="hidden"></input>
                                                                            <input id="hdnTaskCollectedItems" runat="server" type="hidden"></input>
                                                                                <input id="hdnAddedTaskList" runat="server" type="hidden"></input>
                                                                                    <input id="hdnIntendID" runat="server" type="hidden"></input>
                                                                                        <input id="hdnCategoryID" runat="server" type="hidden"></input>
                                                                                            <input id="hdnStockInHandID" runat="server" type="hidden"></input>
                                                                                                <input id="hdnUnitPrice" runat="server" type="hidden"></input>
                                                                                                    <input id="hdnParentProductID" runat="server" type="hidden" value="0"></input>
                                                                                                        <input id="hdnlocation" runat="server" type="hidden"></input>
                                                                                                            <input id="hdnSelectOrgid" runat="server" type="hidden"></input>
                                                                                                                <input id="hdnReceivedOrgID" runat="server" type="hidden"></input>
                                                                                                                    <input id="hdnUserlist" runat="server" type="hidden"></input>
                                                                                                                        <input id="hdnFromLocationID" runat="server" type="hidden"></input>
                                                                                                                            <input id="hdnUserID" runat="server" type="hidden"></input>
                                                                                                                                <input id="hdnOrgAddid" runat="server" type="hidden"></input>
                                                                                                                                    <input id="hdnTargetMsg" type="hidden" />
                                                                                                                                    <input id="hdnTargetMsg1" type="hidden" />
                                                                                                                                    <input id="hdnMRP" runat="server" type="hidden" value="0"></input>
                                                                                                                                        <input id="hdnQty" runat="server" type="hidden" value="0"></input>
                                                                                                                                            <input id="hdnDaftMethod" type="hidden" />
                                                                                                                                            <input id="hdnRaisedQty" type="hidden" />
																																			 <input id="hdnStockReceivedBarcodeDetailsID" runat="server" type="hidden" />
																																			 <input id="hdnStockReceivedBarcodeID" runat="server" type="hidden" />
																																			 <input id="hdnRakno" runat="server" type="hidden" />
																																			 <input id="hdnBarcode" runat="server" type="hidden" />
																																			 <input id="hdnIsUniqueBarcode" runat="server"  type="hidden" value="N" />
                                                                                                                                        </input>
                                                                                                                                    </input>
                                                                                                                                </input>
                                                                                                                            </input>
                                                                                                                        </input>
                                                                                                                    </input>
                                                                                                                </input>
                                                                                                            </input>
                                                                                                        </input>
                                                                                                    </input>
                                                                                                </input>
                                                                                            </input>
                                                                                        </input>
                                                                                    </input>
                                                                                </input>
                                                                            </input>
                                                                        </input>
                                                                    </input>
                                                                </input>
                                                            </input>
                                                        </input>
                                                    </input>
                                                </input>
                                            </input>
                                        </input>
                                    </input>
                                </input>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="divBarCodeException" class="hide">
            <table class="w-100p">
				    <tr>
					<td>batch No</td>
					<td><select id="ddlBatchNo"></select></td>
					</tr>
                <tr>
                    <td>
                       <asp:Label ID="lblEnter" Text=" Enter Quantity" runat="server" 
                            meta:resourcekey="lblEnterResource1"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="txtQuantityofExceptionItem" onkeypress="return ValidateOnlyNumeric(this);" />
                        <asp:Label ID="ExceptionItemUnit" Text="Unit" runat="server" 
                            meta:resourcekey="ExceptionItemUnitResource1"></asp:Label>
                        
                    </td>
                </tr>
                <tr>
                    <td class="w-30p">
                        <input type="hidden" id="hdnBarCodeExceptionItems" />
<%--<input type="button" id="btnAddBarCodeExceptionItem" value="Add" class="btn" onclick="AddBarCodeExceptionItem();" />--%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTaxAddFlag" runat="server" Value="0" />
    <input type="hidden" id="hdnAddFlag" runat="server" value="N" />
    <input type="hidden" id="hdnEnablePackSize" runat="server" />
    <input type="hidden" id="hdnEnableBarCode" runat="server" />
    <input type="hidden" id="hdnDisplaydata" runat="server" />
    <asp:HiddenField runat="server" ID="hdnPdtRcvdDtlsID" Value=""/>
    <asp:HiddenField runat="server" ID="hdnReceivedUniqueNumber" Value=""/>
    <input id="hdnLoginid" runat="server" type="hidden" />
    <input type="hidden" id="hdnOrgId" runat="server" />
    <input type="hidden" id="hdnLocationId" runat="server" />
    <input id="hndPageId" runat="server" type="hidden" />
</form>
 
    

    <script type="text/javascript">

        var intID = '<%= Request.QueryString["intID"]  %>';

        var PID;
        function GetProductName(ProductName, ProductID) {
            PID = ProductID;
            Attune.Kernel.InventoryCommon.InventoryWebService.GetIntendDetailStockIssueBYAdd(unescape(ProductName), 1, intID, pSetValues);
            return false;
        }
     
        
        function pSetValues(tmpVal) {
            tmpVal = $.grep(tmpVal, function (n, i) {
                return n.ProductID == PID
            });
            var lstArray = tmpVal;
            for (var i = 0; i < tmpVal.length; i++) {
                if (tmpVal[i] != '') {
                    document.getElementById('txtProduct').value = tmpVal[i].ProductName
                        var lis = tmpVal[i];
                        document.getElementById('hdnBatchList').value = '';
                        document.getElementById('hdnProductId').value = '';
                        var bannedItem = lis.IsTransactionBlock;
                        var AvilableQty = lis.InHandQuantity;
                        var ReorderQty = lis.ReorderQuantity;
                        var RakNo = lis.RakNo;
                        if (bannedItem == 'Y') {
                            var userMsg = SListForAppMsg.Get('StockIntend_IssueStock_aspx_05') == null ? "Selected product has been marked as Banned. Do you still wish to use this?" : SListForAppMsg.Get('StockIntend_IssueStock_aspx_05');
                            var rep = ConfirmWindow(userMsg, errorMsg, okMsg, cancelMsg);
                            if (rep == true) {

                            }
                            else {
                                document.getElementById("lblProdDesc").innerHTML = "";
                                document.getElementById('txtProduct').value = '';
                                document.getElementById('txtProduct').focus();
                                return false;
                            }
                        }

                        if ((ReorderQty > 0) && (ReorderQty <= AvilableQty)) {
                            var userMsg = SListForAppMsg.Get('StockIntend_IssueStock_aspx_06') == null ? "Selected product has been reached its reorder level. Do you still wish to use this?" : SListForAppMsg.Get('StockIntend_IssueStock_aspx_06');
                            if (ConfirmWindow(userMsg, errorMsg, okMsg, cancelMsg)) {

                            }
                            else {
                                document.getElementById("lblProdDesc").innerHTML = "";
                                document.getElementById('txtProduct').value = '';
                                document.getElementById('txtProduct').focus();
                                return false;
                            }
                        }

                        var arrF = new Object();
                        var arrX = [];
                        arrY = [];
                        $.each(lstArray, function (obj, value) {
                            arrF = $.grep(lstProductList, function (n, i) {
                            return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber
                            });
                            if (arrF.length > 0) {
                                $.merge(arrY, arrF)
                            }
                        });

                        if (arrY.length > 0) {
                            if (arrY.length == lstArray.length) {
                                alert("Product already Added");
                                return false;
                            }
                            var pid = Enumerable.From(lstArray).Select("$.ReceivedUniqueNumber").ToArray();
                            var npid = Enumerable.From(arrY).Select("$.ReceivedUniqueNumber").ToArray();
                            var rpid = [];
                            jQuery.grep(pid, function (el) {
                                if (jQuery.inArray(el.toString(), npid) == -1)
                                    rpid.push(el);
                            });
                            arrX = Enumerable.From(lstArray).Where(function(x) { return Enumerable.From(rpid).Contains(x.ReceivedUniqueNumber) }).ToArray();
                        }
                        else {
                            arrX = lstArray;
                        }

                        document.getElementById('hdnBatchList').value = JSON.stringify(arrX);
                        document.getElementById('hdnProductId').value = lis.ProductID;

                        var pid = document.getElementById('hdnProductId').value;
                        document.getElementById('hdnProBatchNo').value = '';
                        document.getElementById('txtQuantity').value = '';
                        document.getElementById('txtBatchQuantity').value = '';
                        document.getElementById('txtUnit').value = '';
                        document.getElementById('txtBatchNo').value = '';
                        document.getElementById('txtRakNo').value = '';
                        if ($('#hdnBatchList').val() != '') {
                            var x = JSON.parse($('#hdnBatchList').val());
                            var isAddItem = 0;
                            $.each(x, function (obj, value) {
                                if (CheckTaskItems(pid + "~" + value.StockInHandID)) {
                                    document.getElementById('hdnProBatchNo').value += value.BatchNo + "@#$" + value.StockInHandID + "|";
                                    $('#divProductDetails').removeClass().addClass('show');
                                    if (arrX.length > 0) {
                                        if (isAddItem == 0) {
                                            document.getElementById('txtBatchNo').value = value.BatchNo;
                                            document.getElementById('hdnReceivedID').value = value.StockInHandID;
                                            $('#hdnAddFlag').val('Y');
                                            BindQuantity();
                                            isAddItem = 1;
                                        }
                                    }
                                }
                            });
                        }
                        AutoCompBacthNo();
                }
            }
            return false
        }

        $(document).ready(function() {
            $('#ddlTrustedOrg').attr('disabled', 'disabled');
            $('#ddlLocation').attr('disabled', 'disabled');
        });
    function ValidateSpecialCharacter(event) {
        var k = event.which;
        var ok = k >= 65 && k <= 90 ||  // A-Z 
                     k >= 97 && k <= 122 || // a-z
                     k >= 48 && k <= 57;    // 0-9
        if (!ok) {
            event.preventDefault();
        }
    }
    </script>
<script language="javascript" type="text/javascript">
        var IndentProductDetails = [];
        $(document).ready(function() {

        var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
        var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
        var okMsg = SListForAppMsg.Get("StockIntend_Ok") == null ? "Ok" : SListForAppMsg.Get("StockIntend_Ok");
        var cancelMsg = SListForAppMsg.Get("StockIntend_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockIntend_Cancel");
            var AppInterval = $("input[id$=hdnshowintervel]").val();

            if ($("#hdnProductList").val() != "") {
			lstProductList = JSON.parse($("#hdnProductList").val());
                Tblist();
            }
            if ($("#hdnEnablePackSize").val() == "Y") {
                $("#btnSaveAsDraft").hide();
                $("#txtProduct").attr("onchange", "clearbarCodeTable()");
                AddInHandQuantity();
                setTimeout(fnSaveAsDrafts, 0);
            }
            else {
                setTimeout(fnSaveAsDrafts, AppInterval);
            }
        });
        function clearbarCodeTable() {
            $("#tblBarCodeList tbody").empty();
            $("#tblBarCodeList").addClass("hide");
            $('.ui-dialog').css("display", "none");
        }
        function fnSaveAsDrafts(SaveMetod) {

            $('#hdnDaftMethod').val(SaveMetod);
            if (SaveMetod == 'ManualSave') {
                //fnShowProgress();
            }
            var draftData = $("#hdnProductList").val();
            var OrgID = $('#hdnOrgId').val();
            var LID = $('#hdnLoginid').val();
            var ILocationID = $('#hdnLocationId').val();
            var PageID = $('#hndPageId').val();
            if (draftData != "") {
                $.ajax({
                    type: "POST",
                    url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveASDraft",
                    data: "{ 'OrgID':" + OrgID + ",'LocationID':" + ILocationID + ",'PageID':" + PageID + ",'LoginID':" + LID + ",'DraftType':'IssueIntend','DraftValue':'<%=intNo%>','DraftData':'" + draftData + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            }
            else if (SaveMetod != 'ManualSave') {
                var AppInterval = $("input[id$=hdnshowintervel]").val();
                setTimeout(fnSaveAsDrafts, AppInterval);
            }
            else {
                var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Add Product";
                var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

                ValidationWindow(userMsg, informMsg)
            }
            
        }
        function OnSuccess(response) {
            // alert(response.d);
            //fnHideProgress();
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_07") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_07") : "Saved Successfully!!!";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
            if ($('#hdnDaftMethod').val() == 'ManualSave')
            { ValidationWindow(userMsg, informMsg) }

            $('#hdnDaftMethod').val('');
        }
        function setProductContextKey() {
            var indentID = GetParameterValues("intID");

            if ($("#cheBarcodeSearch").is(':checked')) {
                $find('AutoCompleteProduct').set_contextKey(indentID + "~" + "Barcode");
            } else {
                $find('AutoCompleteProduct').set_contextKey(indentID + "~" + "Product");
            }
            document.getElementById('lblProdDesc').innerHTML = '';
            $("#txtProduct").val('');
            return false;
        }

        function GetParameterValues(param) {
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (urlparam[0] == param) {
                    return urlparam[1];
                }
            }
        } 
  

var btnCancelID;

function UpdateItemStatusConfirmDialog(obj, ProductID) {
    btnCancelID = obj.id;
     
$('<div></div>').appendTo('body')
.html('<div style="height:30px"><h6>Are you sure, want to cancel the item ?</h6></div> <div><input id="txtIntendRemarks" TextMode="MultiLine" type="text" maxlength="250" placeholder="Remarks" style="width: 200px" />  </div>')
.dialog({
    modal: true, title: 'Confirm Alert', zIndex: 10000, autoOpen: true,
    width: 'auto', resizable: false,
    buttons: {
    Yes: function() {

        var Remarks = $("#txtIntendRemarks").val();
        Attune.Kernel.InventoryCommon.InventoryWebService.UpdateIntendItemStatus(ProductID, intID, Remarks, SetCancelAction);
                    
          $(this).dialog("close");
        },
        No: function() {       
            $(this).dialog("close");
        }
    },
    close: function(event, ui) {
        $(this).remove();
    }
});

return false;

};

function SetCancelAction(okStatus) {

    var btnAction = btnCancelID.replace('_btnIndCancel', '_btnAction');
    var lblIndStatus = btnCancelID.replace('_btnIndCancel', '_lblIndStatus');
    var HdnProductID = $("#" + btnCancelID.replace('_btnIndCancel', '_hdnProductID')).val();
    

    if (okStatus == "Success") {
    
        $("#" + btnAction).addClass("hide");
        $("#" + btnCancelID).addClass("hide");
        $("#" + lblIndStatus).text("Canceled");
        
        var arrF = $.grep(lstProductList, function(n, i) {
        return n.ProductID != HdnProductID;
    });
        
        lstProductList = [];
        lstProductList = arrF;
        $('#hdnProductList').val(JSON.stringify(lstProductList));
        Tblist(); 
    }   
}


      

</script>

</body>
</html>
