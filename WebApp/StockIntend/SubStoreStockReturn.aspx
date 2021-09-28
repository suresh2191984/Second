<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubStoreStockReturn.aspx.cs"
    Inherits="StockIntend_SubStoreStockReturn" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sub-Store StockReturn </title>
<script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
    <script src="../StockIntend/Scripts/SubStoreReturn.js" language="javascript" type="text/javascript"></script>

    <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" type="text/javascript"></script>

</head>
<body>
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
      <%--  <Services>
            <asp:ServiceReference Path="~/PlatForm/CommonWebServices/CommonServices.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td class="a-right" colspan="4">                           
                            <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_01%>
                            <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblStockReturnType" runat="server" Text="Select StockReturnType" 
                                meta:resourcekey="lblStockReturnTypeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockReturnType" TabIndex="1" class="ddlTheme" 
                                runat="server" meta:resourcekey="ddlStockReturnTypeResource1">
                            </asp:DropDownList>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr id="trTrusted" runat="server" class="hide">
                        <td>                            
                            <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_02%>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTrustedOrg" TabIndex="2" class="ddlTheme" runat="server"
                                OnChange="GetLocationlist();" meta:resourcekey="ddlTrustedOrgResource1">
                            </asp:DropDownList>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                        <td>
                           <%-- <%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_IssuedTo%>--%>
                           <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_03%>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlLocation" TabIndex="3" class="ddlTheme" 
                                runat="server"  OnChange="fnChangeToLocation();" 
                                meta:resourcekey="ddlLocationResource1">
                            </asp:DropDownList>
                            <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                        </td>
                    </tr>
                    <%--Arun--%>
                   <tr class="hide">
                   <%--end--%>
                        <td>
                        <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_04%>
                           <%-- <%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_ReturnedBy%>--%>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlUser" TabIndex="4" class="ddlTheme" runat="server" 
                                meta:resourcekey="ddlUserResource1">
                            </asp:DropDownList>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr id="tbSupplier" runat="server">
                        <td>
                            <asp:Label ID="lblSupplier" runat="server" Text="Supplier" 
                                meta:resourcekey="lblSupplierResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSupplierList" runat="server" 
                                meta:resourcekey="ddlSupplierListResource1">
                            </asp:DropDownList>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                        <td>
                            <asp:Label ID="lblstockreturn" runat="server" Text="StockReturn Type" 
                                meta:resourcekey="lblstockreturnResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockReturn" class="ddlTheme" Visible="False" 
                                runat="server" meta:resourcekey="ddlStockReturnResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_05%>
                            <%--<%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_Comments%>--%>
                        </td>
                        <td>
                            <asp:TextBox ID="txtComments" TabIndex="5" TextMode="MultiLine" runat="server" Columns="25"
                                Rows="2" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td class="a-center" colspan="4">
                        </td>
                    </tr>
                </table>
                <table class="searchPanel w-100p">
                    <tr>
                        <td>
                            <table class="w-100p panelContent">
                                <tr>
                                    <td id="tdSearch" runat="server" class="a-left v-top">
                                        <asp:Label ID="lblmsg" Text="Search Product" runat="server" 
                                            meta:resourcekey="lblmsgResource1"></asp:Label>
                                        <asp:Panel ID="pnSearch" runat="server">
                                            &nbsp;
                                            <asp:TextBox ID="txtProduct" TabIndex="6" class="medium" onkeypress="return ValidateMultiLangChar(this);" onkeydown="setContextKey(event);"  onkeyup="doClearTable();"
                                                runat="server" onblur="pSetFocus('pro');" 
                                            meta:resourcekey="txtProductResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true" UseContextKey="true"
                                                MinimumPrefixLength="1" OnClientItemSelected="IAmSelected" ServiceMethod="getProductBatchList"
                                                OnClientItemOver="doGetProductTotalQuantityCommonJSON" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                TargetControlID="txtProduct">
                                            </ajc:AutoCompleteExtender>
                                        </asp:Panel>
                                    </td>
                                    <td>
                                    <%--Arun--%>
                                       <asp:Table CssClass="gridView w-100p"
                                            runat="server" ID="tbllist">
                                        </asp:Table>
                                        <%--end--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top" colspan="2">
                                        <asp:TextBox ID="txtExpiredColor" ReadOnly="True" runat="server" onkeypress="return ValidateMultiLangChar(this);" class="w-1p" 
                                            meta:resourcekey="txtExpiredColorResource1"></asp:TextBox>
                                        <asp:Label ID="lblExpLevel" Text="Products Expires Within " runat="server" 
                                            meta:resourcekey="lblExpLevelResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left v-top" colspan="2">
                                    <%--Arun--%>
                                        <div id="divProductDetails" runat="server" class="hide">
                                        <%--end--%>
                                            <table id="TableProductDetails" runat="server" class="gridView w-100p">
                                                <tr class="a-left">
                                                    <td>
                                                     <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_06%>
                                                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_BatchNo%>--%>
                                                    </td>
                                                    <td>
                                                    <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_07%>
                                                       <%-- <%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_AvailableQty%>--%>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblType" Text="Issued Qty" runat="server" 
                                                            meta:resourcekey="lblTypeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                    <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_08%>
                                                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_SubStoreStockReturn_Unit%>--%>
                                                    </td>
                                                   <%-- Arun--%>
                                                    <td id="tdlblreturnstock" runat="server"  >
                                                                        <asp:Label ID="lblreturnstockk1" Text="ReturnStock" runat="server" Width="150"
                                                                            meta:resourcekey="lblreturnstockk1Resource1"></asp:Label>
                                                                    </td>
                                                                    <%--end--%>
                                                    <td id="Td1" runat="server" class="hide">
                                                   
                                                        <asp:Label ID="lblExpDate" Text="Exp Date" runat="server"  
                                                            meta:resourcekey="lblExpDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                      <asp:Label ID="lblAction" Text="Action" runat="server" 
                                                            meta:resourcekey="lblActionResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtBatchNo" runat="server" TabIndex="7" onkeypress="return ValidateMultiLangChar(this);" 
                                                            onblur="return BindQuantity();" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatchQuantity" TabIndex="8" runat="server" onkeypress="return ValidateMultiLangChar(this);" ReadOnly="True" 
                                                            meta:resourcekey="txtBatchQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <%--Arun--%>
                                                    <td>
                                                        <asp:TextBox ID="txtQuantity" onblur="pSetAddFocus();" TabIndex="9" runat="server"
                                                            onkeypress="return ValidateSpecialAndNumeric(this);" 
                                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <%--end--%>
                                                    <td>
                                                        <asp:TextBox ID="txtUnit" runat="server" ReadOnly="True" onkeypress="return ValidateMultiLangChar(this);" TabIndex="10" 
                                                            meta:resourcekey="txtUnitResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="tdreturnstock" runat="server" class="w-60">
                                                                        <asp:TextBox ID="txtreturnstock" runat="server"  TabIndex="10" Width="60px" onkeypress="return ValidateMultiLangChar(this);" 
                                                                            meta:resourcekey="txtreturnstockResource1"></asp:TextBox>
                                                                    </td>
                                                    <td id="Td47" runat="server" class="hide">
                                                        <asp:TextBox ID="txtExpDate" onkeypress="return ValidateMultiLangChar(this);" onblur="return checkExpDate(this.id);" CssClass="small" 
                                                            runat="server" meta:resourcekey="txtExpDateResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="w-60">
                                                        <input id="add" class="btn" name="add" tabindex="11" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                            type="button" value=" <%= Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_09%>" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblOrederedItems" class="gridView w-100p">
                            </table>
                            <table id="tableTask" runat="server" class="hide gridView w-100p">
                                <tr>
                                    <td>
                                        <asp:Table class="gridView w-100p" runat="server" 
                                            ID="ConsumableItemsTab" meta:resourcekey="ConsumableItemsTabResource1">
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                            <table id="Table2" runat="server" class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:Button ID="btnSubmit" TabIndex="12" AccessKey="S" OnClick="btnSubmit_Click"
                                            Text="Submit" runat="server" CssClass="btn" 
                                            OnClientClick="javascript:if(!checkDetails('StockIssued')) return false;" 
                                            meta:resourcekey="btnSubmitResource1" />
                                        <asp:Button ID="btnCancel" TabIndex="13" AccessKey="C" 
                                            OnClick="btnCancel_Click" CssClass="cancel-btn"
                                            Text="Cancel" runat="server" meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <input id="hdnProBatchNo" runat="server" type="hidden" value="" />
                                <input id="hdnBatchList" runat="server" type="hidden" value="" />
                                <input id="hdnProductId" runat="server" type="hidden" value="" />
                                <input id="hdnProductName" runat="server" type="hidden" value="" />
                                <input id="hdnReceivedID" runat="server" type="hidden" value="" />
                                <input id="hdnSellingPrice" runat="server" type="hidden" value="" />
                                <input id="hdnTax" runat="server" type="hidden" value="" />
                                <input id="hdnExpiryDate" runat="server" type="hidden" value="" />
                                <input id="hdnProductList" runat="server" type="hidden" value="" />
                                <input id="hdnRowEdit" runat="server" type="hidden" value="" />
                                <input id="hdnTasklist" runat="server" type="hidden" value="" />
                                <input id="hdnTaskCollectedItems" runat="server" type="hidden" value="" />
                                <input id="hdnAddedTaskList" runat="server" type="hidden" value="" />
                                <input id="hdnExpiryDateLevel" runat="server" type="hidden" />
                                <input id="hdnHasExpiryDate" runat="server" type="hidden" />
                                <input id="hdnUnitPrice" runat="server" type="hidden" value="" />
                                <input id="hdnTrustedOrg" runat="server" type="hidden" value="N" />
                                <input id="hdnParentProductID" runat="server" type="hidden" value="0" />
                                <input id="hdnReceivedOrgID" runat="server" type="hidden" value="0" />
                                <input type="hidden" id="hdnlocation" runat="server" />
                                <input type="hidden" id="hdnUserlist" runat="server" />
                                <input type="hidden" id="hdnFromLocationID" runat="server" />
                                <input type="hidden" id="hdnUserID" runat="server" />
                                <input type="hidden" id="hdnShowCostPrice" value="N" runat="server" />
                                <input id="hdnDisplaydata" runat="server" type="hidden" value="0" />
                                <input id="hdnPdtRcvdDtlsID" runat="server" type="hidden" value="" />
                                <input id="hdnReceivedUniqueNumber" runat="server" type="hidden" value="" />
                                <input type="hidden" id="hdnStockReceivedBarcodeDetailsID" runat="server"/>
                                <input type="hidden" id="hdnBarcodeNo" runat="server" />
                                <input type="hidden" id="hdnAddFlag" runat="server" value="N" />                            
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    
    
<script language="javascript" type="text/javascript">
    function setContextKey(ev) {

            var strUser = document.getElementById("ddlLocation").value;
            var returnType = document.getElementById("ddlStockReturnType").value;
             var ddlTrustedOrg = document.getElementById("ddlTrustedOrg").value;
            
            if(  strUser=="0")
            {
              var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_28") == null ? "Provide valid date" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_28");
                ValidationWindow(userMsg, errorMsg);
                 return false;      
            }
            else if(returnType=="0" )
            {
              var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_29") == null ? "Provide valid date" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_29");
              var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
              ValidationWindow(userMsg, errorMsg);
               return false;
             
            }
            else if(ddlTrustedOrg=="0")
            
            {
             var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_30") == null ? "Please select To location" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_30");
             var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
                ValidationWindow(userMsg, errorMsg);
                 return false;
            }
            else
            {  
            var InventoryLocationID=<%=InventoryLocationID %>;
            $find('AutoCompleteProduct').set_contextKey(strUser+"~"+InventoryLocationID);
           
            }
        }
</script>
    
</body>
</html>
