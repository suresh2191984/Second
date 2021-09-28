<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KitCreation.aspx.cs" Inherits="Inventory_KitCreation" meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Kit Creation</title>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script src="../InventoryCommon/Scripts/InvStockUsage.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript" src="../InventoryKit/Scripts/KitCreation.js"></script>
    <script language="javascript" type="text/javascript">

        //Only numbers will allowed
        function isNumeric(e, Id) {
            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 0) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        </script>
        <style>
        .tb-divcnt {
            background: #cce9ef;
            border: 2px solid #008080 !important;
            display: inline-block;
        }
        .tb-divcntwo {
            background: #cce9ef;
            border: 2px solid #008080 !important;
            
        }
        </style>
</head>
<body>
     <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
      
           <asp:ServiceReference Path="~/InventoryKit/WebService/InventoryKit.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

                    <div class="contentdata">
        <div class="w-100p dis-inline">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                          
                               <table class="searchPanel2 w-99p marginT5 marginL10">
                <tbody>
                    <tr class="panelHeader2 lh25">
                        <td class="a-left">
                            <div>
                                <span class="pointer"><span id="Label14" class="pointer">Kit Creation</span></span>
                            </div>
                        </td>
                    </tr>
                    <tr class="lh25" id="Crent">
                        <td>
                            <table class=" w-100p dis-table  marginT10 marginB10">
                                <tr class="w-100p margin10">
                                    <td class="w-40p v-top paddingL10 paddingR10">
                                        <div class="w-100p h-213 tb-divcnt">
                                    <table id="stockIssuedTab" runat="server"  class="w-100p" margin10>
                                                <tr id="Tr1" runat="server" class="lh30">
                                                    <td id="Td1" runat="server">
                                                        <asp:Label ID="lblDateLiteral" CssClass="bold" runat="server" Text="Date:" meta:resourcekey="lblDateLiteralResource1">
                                             </asp:Label>    
                                            <asp:Label ID="lblDate" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                                <tr id="Tr2" runat="server" class="lh30">
                                                    <td id="Td2" runat="server">
                                                        <asp:Label ID="lblSelectKit" CssClass="bold" runat="server" Text="Select Kit" meta:resourcekey="lblSelectKitResource1">
                                                </asp:Label>     
                                        </td>
                                                    <td id="Td3" runat="server">
                                            <asp:DropDownList ID="ddlKitNames" TabIndex="1" runat="server" 
                                                onselectedindexchanged="ddlKitNames_SelectedIndexChanged" AutoPostBack="true" CssClass="ddl">
                                            </asp:DropDownList>
                                            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                                        </td>
                                        </tr>
                                       
                                                <tr id="Tr3" runat="server" class="lh30">

                                                    <td id="Td4" class="a-left" runat="server">
                                                        <asp:Label ID="lblComments" runat="server" CssClass="bold" Text="Comments" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                
                                            </td>
                                            <td >
                                                <div id="divsup1" runat="server"  class="show">
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtComments" TabIndex="2" TextMode="MultiLine" runat="server" Columns="25" Rows="2"></asp:TextBox>
                                                </div>
                                               
                                            </td>
                                          
                                        </tr>
                                                <tr id="trMinimum" runat="server" class="lh30">
                                                    <td id="Td5" class="a-left" runat="server">
                                           <asp:Label ID="lblMinimumShelf" runat="server" Text="Minimum shelf-life" meta:resourcekey="lblMinimumShelfResource1">
                                           </asp:Label>    
                                                 
                                            </td>
                                            <td >
                                                
                                             <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMinimumlife"  runat="server"  CssClass="small" TabIndex="3" onKeyDown="return  isNumeric(event,this.id)"  ></asp:TextBox>
                                               
                                  
                                               
                                            </td>
                                             
                                     
                                           
                                        </tr>
                                                <tr id="trNoKit" runat="server" class="lh30">
                                               
                                                    <td id="Td6" class="a-left" runat="server">
                                          <asp:Label ID="lblKits" runat="server" Text="No.Of.Kits" meta:resourcekey="lblKitsResource1"></asp:Label> 
                                               
                                            </td>
                                            <td >
                                                
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtKitNos"  runat="server"  CssClass="small" TabIndex="4" onKeyDown="return  isNumeric(event,this.id)"  ></asp:TextBox>
                                                     &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                                               
                                            </td>
                                             
                                        </tr>
                                               <tr>
                                            <td  class="a-center">
                                                
                                           <asp:Button ID="btnKit" TabIndex="5" AccessKey="S"  Text="Submit" 
                                                            runat="server" 
                                                            CssClass="btn" 
                                                            OnClientClick="return KitBatchCount();" 
                                                            OnClick ="btnKit_Click" meta:resourcekey="btnKitResource1"/>
                                               
                                            </td>
                                             
                                         
                                        </tr>
                                        
                                       
                                                <tr class="lh30">
                                            <td class="a-center">
                                            </td>
                                        </tr>
                                    </table>
                                        </div>
                                </td>
                                    
                                    <td class=" w-45p paddingR15">
                                        <div class="w-100p tb-divcnt h-213">
                                   
                                                <div class="hide" id="gvtable" runat="server">
                                                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                                        runat="server" ID="IndentDetailsTab" >
                                                    </asp:Table>

                                                    <asp:GridView ID="gvKitDetails"  EmptyDataText="No Matching Records Found!"
                                                        runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                        GridLines="Both" PageSize="100" CssClass="gridView w-100p">
                                                        <%--<HeaderStyle CssClass="gridHeader" />--%>
                                                        <Columns>
                                                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="ProductNameResource1"  />
                                                            <asp:BoundField DataField="Quantity" HeaderText="Kit Qty" meta:resourcekey="KitResource1"/>
                                                      
                                                            <asp:BoundField DataField="InHandQuantity" HeaderText="InHandQuantity" meta:resourcekey="QuantityResource1" />
                                                                
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                           
                                        </div>
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="searchPanel2 w-99p marginT5 marginL10">
                <tbody>
                    <tr class="panelHeader2 lh25">
                        <td class="a-left">
                        <div>
                                <span class="pointer bold"><span id="Span1" class="pointer bold">Search Products</span></span>
                            </div>
                            <%--<div>
                                <table  class = "searchPanel w-100 hide" id="tblProducts" runat="server" >
                            </div>--%>
                        </td>
                    </tr>
                    <tr class="lh25" id="Tr4">
                        <td>
                            <table class="w-99p dis-table tb-divcntwo marginT10 marginB10 marginL7 " id="tblProducts" runat="server">
                                <tr class="panelHeader1">
                                    <td>
                                            <table class = "w-100p">
                                                <tr>
                                                    <td id="tdSearch" runat="server"  class="a-left v-middle">
                                                        &nbsp;<asp:Label ID="lblmsg" Text="Search Product" runat="server" meta:resourcekey="lblmsgResource1" ></asp:Label>
                                                        <asp:Panel ID="pnSearch" runat="server">
                                                            &nbsp;
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProduct" TabIndex="5"  CssClass="small" onkeyup="doClearTable();" runat="server"
                                                                onblur="pSetFocus('pro');"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="2" OnClientItemSelected="IAmSelected" ServiceMethod="GetKitProductDetail"
                                                                OnClientItemOver="doGetProductTotalQuantity" ServicePath="~/InventoryKit/WebService/InventoryKit.asmx"
                                                                TargetControlID="txtProduct">
                                                            </ajc:AutoCompleteExtender>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                <td class="pull-right">
                                                        <asp:Label ID="lblProdDesc" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                <td class="a-left v-top" colspan="2">
                                                        <div id="divProductDetails" runat="server"  class="hide">
                                                            <table id="TableProductDetails" runat="server" >
                                                            <tr class="gridHeader" runat="server">
                                                                    <td runat="server" >
                                                                     <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" meta:resourcekey="lblBatchNoResource1" ></asp:Label>    
                                                                    </td>
                                                                    <td runat="server" >
                                                                      <asp:Label ID="lblQty" runat="server" Text="Available Qty" meta:resourcekey="lblQtyResource1"></asp:Label>     
                                                                    </td>
                                                                    <td runat="server" >
                                                                        <asp:Label ID="lblType" Text="Issued Qty" runat="server" meta:resourcekey="lblTypeResource1"></asp:Label>
                                                                    </td>
                                                                    <td runat="server">
                                                                          <asp:Label ID="Label1" runat="server" Text="Unit" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                    </td>
                                                                    <td class="hide" runat="server">
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td runat="server" >
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBatchNo" runat="server" TabIndex="6" onblur="return BindQuantity();" CssClass="small"></asp:TextBox>
                                                                    </td>
                                                                    <td >
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBatchQuantity" TabIndex="7" runat="server" ReadOnly="true" CssClass="small"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtQuantity" onblur="pSetAddFocus();"  TabIndex="8" runat="server" onKeyDown="return validateNaN(event);"
                                                                           CssClass="small"></asp:TextBox>
                                                                    </td>
                                                                    <td >
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtUnit" runat="server" ReadOnly="true"  TabIndex="9" CssClass="small"></asp:TextBox>
                                                                    </td>
                                                                     <td runat="server" >
                                                                        <asp:CheckBox CssClass="bilddltb" ID="chkIsReimburse"  TabIndex="10"  runat="server" Text="Is&nbsp;Reimbursable"  meta:resourcekey="chkIsReimburseResource1"  />
                                                                    </td>
                                                                    <td >
                                                                        <input id="add" class="btn" name="add" TabIndex="11" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                                            meta:resourcekey="addResource1" 
                                                                            type="button" value="Add" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table >
                                            <table id="tblOrederedItems" class ="gridView marginT10 w-100p">
                                            </table>
                                            <table class ="gridView hide w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Table CellPadding="2"  CellSpacing="1" BorderWidth="1px"
                                                            runat="server" ID="ConsumableItemsTab"  CssClass="w-100" 
                                                            meta:resourcekey="ConsumableItemsTabResource2">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="Table2" runat="server" class = " w-100p" >
                                                <tr>
                                                    <td class="a-center">
                                                            &nbsp;&nbsp;&nbsp;
                                                             <asp:Button ID="btnSubmit" TabIndex="13" AccessKey="S" OnClick="btnSubmit_Click" Text="Submit" runat="server" 
                                                            CssClass="btn" OnClientClick="javascript:if(!checkDetails()) return false; if(!Checkquanity())return false;" 
                                                            meta:resourcekey="btnSubmitResource1"/>
                                                            &nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnCancel" TabIndex="14" AccessKey="C" OnClick = "btnCancel_Click" Text="Cancel" 
                                                            runat="server" 
                                                            CssClass="cancel-btn" meta:resourcekey="btnCancelResource1"/>
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
                                                 <input id="hdnIntendID" runat="server" type="hidden"  />
                                                 <input id="hdnCategoryID" runat="server" type="hidden"  />
                                                 <input id="hdnStockInHandID" runat="server" type="hidden"  />
                                                 <input id="hdncheckstock" runat="server" type="hidden" value="" />
                                                 <input id="hdngridviewdata" runat="server" type="hidden" value="" />
                                                  <input id="hdnUnitPrice" runat="server" type="hidden" value="" />
                                                  <input id="hdnIsReimbursable" runat="server" type="hidden" value="" />
                                                 <input id="hdnKitBatchQty" runat="server" type="hidden" value="" />
                                                  <input id="hdnExpMonth" runat="server" type="hidden" value="" />  
                                                   <input id="hdnprdid" runat="server" type="hidden" value="" />                                               
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                </tbody>
            </table>
                    </div>
                     </ContentTemplate>
                            
                        </asp:UpdatePanel>
    </div>
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
      <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
