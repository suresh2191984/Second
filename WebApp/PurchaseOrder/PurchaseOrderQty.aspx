<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrderQty.aspx.cs" Inherits="PurchaseOrder_PurchaseOrderQty" meta:resourcekey="PageResource1" EnableEventValidation="true"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchaseorder Quantity</title>
    <style>
    #innerDiv{display:none !important;}
    .ww-300{width:300px;}
    .right0{
        right: 0;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGeneratePO">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script src="Script/PurchaseOrderQty.js" type="text/javascript"></script>
            <script type="text/javascript">
                $(document).ready(function () {
                    var StateID = '@Request.RequestContext.HttpContext.Session["StateID"]';
                    $(document).delegate("#popTaxTrigger", "click", function (event) {
                        $('#divTaxDetails').toggleClass('hide');
                        event.stopPropagation();
                    });
                    $(document).click(function () {
                        $('#divTaxDetails').addClass('hide');
                    });
                });
        </script>
        <div class="contentdata">
            <table class="w-100p">
                <tr>
                    <td colspan="3">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="marginT10 marginB10">
                                    <div class="w-97p marginauto card-md card-md-default padding10">
                                        <table class="w-100p">
                                        <tr class="panelContent lh40">
                                            <td class="a-left w-10p">
                                                <asp:Label ID="lbltagtxt1" runat="server" CssClass="bold" Text="Purchase Order Date :" 
                                                    meta:resourcekey="lbltagtxt1Resource1" ></asp:Label>
                                            </td>
                                            <td class="w-15p">

                                                <asp:TextBox ID="txtPurchaseOrderDate" runat="server" CssClass="small datePickerPres"
                                                    onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                                    meta:resourcekey="txtPurchaseOrderDateResource1" ></asp:TextBox>
                                                &nbsp;<span class="star-icon"></span>
                                            </td>
                                            <td class="a-center w-10p">
                                                <asp:Label ID="lblSupplierDetails" runat="server" CssClass="bold" Text="Supplier Details :" 
                                                    meta:resourcekey="lblSupplierDetailsResource1" ></asp:Label>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td class="w-12p">
                                                <asp:DropDownList ID="ddlSupplierList" runat="server" CssClass="small" 
                                                    onChange="GetSuppInfo(this.value);fnGetDrafts();ClearSupplier();" meta:resourcekey="ddlSupplierListResource1"
                                                    >
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdnSName" runat="server" />
                                            </td>
                                            
                                             <td rowspan="2">
                                                <div id="divSupplier" runat="server">
                                                    <table class="v-top w-100p marginL10">
                                                        <tr>
                                                             <td class="a-left v-top">
                                                                 <asp:Label ID="lbltxtSupplier" runat="server" CssClass="bold" Text="Supplier Name :" 
                                                                        meta:resourcekey="lbltxtSupplierResource1" ></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblsupplierName" CssClass="txtelipsis w-200"></asp:Label> 
                                                            </td>
                                                            <td class="a-left v-top"  >
                                                                <asp:Label ID="lblAddress" runat="server" CssClass="bold" Text="Address" 
                                                                    meta:resourcekey="lblAddressResource1" ></asp:Label>&nbsp;
                                                            :
                                                            </td>
                                                            <td class="v-top"  colspan="3">
                                                                <asp:Label ID="lblVendorAddress" Text="--" runat="server" CssClass="w-317 txtelipsis" 
                                                                    meta:resourcekey="lblVendorAddressResource1" ></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left v-top">
                                                                <asp:Label ID="lblPhone" runat="server" Text="Phone" CssClass="bold" 
                                                                    meta:resourcekey="lblPhoneResource1" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                            :
                                                            </td>
                                                            <td class="v-top" >
                                                                <asp:Label ID="lblVendorPhone" runat="server" 
                                                                    meta:resourcekey="lblVendorPhoneResource1" ></asp:Label>
                                                            </td>
                                                           <td>
                                                                   <asp:Label ID="lblCity" runat="server" Text="City" CssClass="bold" 
                                                                    meta:resourcekey="lblCityResource1" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            :
                                                            </td>
                                                            <td class="a-left v-top">
                                                                <asp:Label ID="lblVendorCity" CssClass="w-100 txtelipsis" runat="server" 
                                                                    meta:resourcekey="lblVendorCityResource1" ></asp:Label>
                                                           </td>
                                                            <td class="a-left v-top">
                                                                <asp:Label ID="lblEmailID1" runat="server" Text=" Email ID :" CssClass="bold" 
                                                                    meta:resourcekey="lblEmailID1Resource1" ></asp:Label>
                                                            </td>
                                                            <td class="v-top">
                                                                <asp:Label ID="lblEmailID" CssClass="txtelipsis w-150" runat="server" 
                                                                    meta:resourcekey="lblEmailIDResource1" ></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td class="a-left v-top">
                                                <asp:Label ID="lblComments1" runat="server" Text="Comments :"  CssClass="bold"
                                                    meta:resourcekey="lblComments1Resource1" ></asp:Label>
                                            </td>
                                            <td class="v-top" colspan="3">
                                                <asp:TextBox ID="txtComments" CssClass="w-98p" runat="server" Columns="25" Rows="2"
                                                    TextMode="MultiLine" onKeyPress="return ValidateMultiLangChar(this);" 
                                                    meta:resourcekey="txtCommentsResource1" ></asp:TextBox>
                                            </td>
                                         </tr>
                                        <tr class="lh30">
                                        </tr>
                                        <tr class="panelContent lh30">
                                            <td colspan="4">
                                                <asp:UpdateProgress ID="progressDivWithGif" AssociatedUpdatePanelID="UpdatePanel1"
                                                    runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar1" runat="server" 
                                                            ImageUrl="~/PlatForm/Images/working.gif" meta:resourcekey="imgProgressbar1Resource1"
                                                             />
                                                        <asp:Label ID="lblPleasewait" runat="server" Text="Please wait...." 
                                                            meta:resourcekey="lblPleasewaitResource1" ></asp:Label>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        
                                    </table>
                                    </div>
                                </div>
                                
                                <div id="divProductDetails" runat="server" class="w-97p marginauto card-md card-md-default padding10">
                                    <table id="TableProductDetails" runat="server" class="w-100p lh30">
                                        <tr id="Tr1" class="bold a-left" runat="server">
                                            <td id="tdProductName" class="w-75" runat="server">
                                                <asp:Label ID="lblProductName" runat="server" Text="Product Name" ></asp:Label>
                                            </td>
                                            <td id="tdQty" class="w-80" runat="server">
                                                <asp:Label ID="lblQuantity" runat="server" Text="Quantity" ></asp:Label>
                                            </td>
                                            <td id="tdUnits" class="w-60" runat="server">
                                                <asp:Label ID="lblUnits" Text="Units" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdUnitCost" class="w-60" runat="server">
                                                <asp:Label ID="lblUnitCost" Text="Unit Cost" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdTotal" class="w-60" runat="server">
                                                <asp:Label ID="lblTotal" Text="Total" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdDiscount" class="w-60" runat="server">
                                                <asp:Label ID="lblDiscount" Text="Discount(%)" runat="server" ></asp:Label>
                                            </td>

                                            <td id="tdCompQty" class="w-60" runat="server">
                                                <asp:Label ID="lblCompQty" Text="Comp.Qty" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdPurchaseTax" class="w-60 hide" runat="server">
                                                <asp:Label ID="lblPurchaseTax" Text="Purchase Tax(%)" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdSalesTax" class="w-60" runat="server">
                                                <asp:Label ID="lblSalesTax" Text="Tax(%)" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdTotalValue" class="w-60" runat="server">
                                                <asp:Label ID="lblTotalValue" Text="Total Value" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdActio" class="w-60" runat="server">
                                                <asp:Label ID="lblAction" Text="Action" runat="server" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr2" runat="server">
                                            <td id="tdProName" class="w-75" runat="server">
                                                <asp:TextBox ID="txtProduct" CssClass="small" runat="server" TabIndex="5" onkeyup = "SetContextKey()" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                    MinimumPrefixLength="1" ServiceMethod="GetSearchProductListJSON" OnClientItemSelected="IsSelected"
                                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProduct"
                                                    DelimiterCharacters="" Enabled="True" UseContextKey = "true">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td id="tdTxtQty" class="w-60" runat="server">
                                                <asp:TextBox ID="txtQuantity" TabIndex="6" onBlur="Calcul();" 
                                                   onkeypress="return ValidateOnlyNumeric(this);" Text="0" runat="server" CssClass="w-60" ></asp:TextBox>
                                            </td>
                                            <td id="tdDDLunit" class="w-60" runat="server">
                                                <asp:DropDownList TabIndex="7" ID="ddlUnits" runat="server" onChange="ddluintChange()">
                                                </asp:DropDownList>
                                            </td>
                                            <td id="tdUnitPrice" runat="server" class="w-60">
                                                <asp:TextBox ID="txtUnitCost" runat="server" Text="0.00" CssClass="a-right" 
                                                 onkeydown="return validatenumber(event);"   onBlur="Calcul();" TabIndex="8" onKeypress="return ValidateMultiLangChar(this);"
                                                    Width="60px"></asp:TextBox>
                                            </td>
                                            <td id="tdTotC" runat="server" class="w-60 a-left">
                                                <asp:Label ID="lblTotalCost" Text="0.00" runat="server" ></asp:Label>
                                            </td>
                                            <td id="tdDis" runat="server" class="w-60">
                                                <asp:TextBox ID="txtDiscount" runat="server" Text="0.00" TabIndex="9" onBlur="Calcul();"
                                                     CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                   onkeydown="return validatenumber(event);" Width="60px"></asp:TextBox>
                                            </td>

                                            <td id="tdComplQty" runat="server" class="w-60">
                                                <asp:TextBox ID="txtCompQty" runat="server" TabIndex="10" Text="0.00" 
                                             onBlur="Calcul();" onkeydown="return validatenumber(event);" CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);" Width="60px"></asp:TextBox>
                                            </td>
                                            <td id="tdPurtax" runat="server" class="w-60 hide">
                                                <asp:TextBox ID="txtPurchaseTax" runat="server" TabIndex="11" Text="0.00" onBlur="Calcul();"
                                                onkeydown="return validatenumber(event);"  CssClass="a-right"  onkeypress="return ValidateMultiLangChar(this);"
                                                    Width="60px"></asp:TextBox>

                                            </td>
                                            <td id="tdTax" runat="server" class="w-60">
                                                <asp:TextBox  Width="60px" onBlur="Calcul();" ID="txtTax" value="0.00" Enabled="false"
                                                 onkeydown="return validatenumber(event);"   CssClass="a-right" TabIndex="12" runat="server" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                                <span id="popTaxTrigger" class="ui-icon ui-icon-info inline-block"></span>
                                                <div id="divTaxDetails" runat="server" class= " right0 ww-300 p-ab card-md card-md-default padding10 hide"></div>
                                                <asp:HiddenField ID="CheckState" runat="server" />
                                            </td>
                                            <td id="tdTotalVal" runat="server" class="w-60 a-left">
                                                <asp:Label ID="lblTotVal" Text="0.00" runat="server"></asp:Label>
                                            </td>

                                            <td id="tdAdd" class="w-60" runat="server">

                                                <input type="button" id="add" value="Add" class="btn w-60" tabindex="13" onclick="javascript: return BindProductList();"
                                                     />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="marginT15">
                                <table id="tblOrederedItems" class="gridView w-99p marginauto a-left">
                                </table>
                                </div>
                                
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="v-top">
                        <table class="w-100p">
                            <tr>
                                <td class="v-top">
                                    <table class="w-100p">
                                        <tr>
                                            <td colspan="2">
                                                <asp:Table CellPadding="4" CssClass="w-100p gridView" runat="server" 
                                                    ID="purchaseOrderDetailsTab" meta:resourcekey="purchaseOrderDetailsTabResource1"
                                                    >
                                                </asp:Table>
                                                <asp:HiddenField ID="hdnPurchaseOrderItems" runat="server" />
                                                <input type="hidden" id="hdnCollectedItems" runat="server" />
                                            </td>
                                        </tr>
                                        <tr class="lh30 hide">
                                            
                                            <td colspan="2" runat="server" class="hide" id="tdPORecd">
                                                <asp:CheckBox ID="ChkIsPODisplay" runat="server" 
                                                    Text="PO Receivable From Other Location" meta:resourcekey="ChkIsPODisplayResource1"
                                                    />
                                            </td>
                                        </tr>
                                        <tr id="trApproveBlock" runat="server">
                                            <td colspan="2" class="a-center">
                                                <table class="marginT15 w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <input type="hidden" id="hdnApprovePO" runat="server" />
                                                            
                                                            <asp:Button ID="btnApprove" Text="Approve PO" runat="server" OnClientClick="javascript:if(!collectValues()) return false;"
                                                                CssClass="btn hide" onmouseout="this.className='btn'" 
                                                                OnClick="btnGeneratePO_Click" meta:resourcekey="btnApproveResource1"
                                                                />
                                                            <asp:Button ID="btnCancelPO" Text="Cancel PO" runat="server" CssClass="cancel-btn hide"
                                                                OnClick="btnCancelPO_Click" meta:resourcekey="btnCancelPOResource1" />
                                                            <asp:Button ID="btnGeneratePO" Text="Finish" runat="server" CssClass="btn" OnClick="btnGeneratePO_Click"
                                                                 OnClientClick="javascript:if(!collectValues()) return false;" 
                                                                meta:resourcekey="btnGeneratePOResource1" />

                                                            <input type="button" runat="server" value="Save as Draft"
                                                                class="cancel-btn" id="btnDraft" onclick="fnSaveAsDrafts('ManualSave')" />
                                                            <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn" OnClick="btnBack_Click"
                                                                meta:resourcekey="btnBackResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </td>
                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <%--<button type="button" class="btn btn-primary" onclick="openModalJQ('mymodaldiag1', 'myModalclass1');">Open Modal</button>--%>
            <div id="mymodaldiag1" class="modalDiag paddingT50">
                <!-- modaldiag1 content -->
                <div id="myModalclass1" class="w-40p">
                    <div class="modalDiag-header">
                        <span class="bold w-100p"><span class="marginT5">Product Quantity Details</span><span onclick="closeModdalDialog('mymodaldiag1', 'myModalclass1');" class="closeModalDiag pointer pull-right">X</span></span>
                    </div>
                    <div class="modalDiag-body">
                        <div id="dvlocationDetailsTab">
                            <table class="w-100p">
                                <tr class="lh25">
                                    <td class="a-center">
                                        <span class="bold marginB15" id="lblPNameinPopup"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Table CellPadding="3" CssClass="w-100p gridView" runat="server" 
                                            ID="locationDetailsTab" meta:resourcekey="locationDetailsTabResource1"
                                            >
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </div>
                </div>
            </div>

        </div>
        <input id="hdnProductId" runat="server" type="hidden" />
        <input id="hdnProductName" runat="server" type="hidden" />
        <input id="hdnReceivedID" runat="server" type="hidden" />
        <input id="hdnSellingPrice" runat="server" type="hidden" />
        <input id="hdnUnitPrice" runat="server" type="hidden" />
        <input id="hdnPdtRcvdDtlsID" runat="server" type="hidden" />
        <input id="hdnRowEdit" runat="server" type="hidden" />
        <input id="hdnProductList" runat="server" type="hidden" />
        <input id="hdnDaftMethod" runat="server" type="hidden" />
        <input id="hndPageId" runat="server" type="hidden" />
        <input id="hdnLoginid" runat="server" type="hidden" />
        <input id="hdnDesc" runat="server" type="hidden" />
        <input type="hidden" id="hdnPoDate" runat="server" />
        <input type="hidden" id="hdnComments" runat="server" />
        <input type="hidden" id="hdnTotal" value="0" runat="server" />
        <input type="hidden" id="hdntotalcost" value="0" runat="server" />
        <input type="hidden" id="iconHid" runat="server" />
        <input type="hidden" id="hdnMessages" runat="server" />
        <input type="hidden" id="hdnButtonText" runat="server"  />
        <input type="hidden" id="hdnOrgId" runat="server" />
        <input type="hidden" id="hdnOrgAddressID" runat="server" />
        <input type="hidden" id="hdnLocationId" runat="server" />
        <input type="hidden" id="hdnNeedReqSuppBaseCostprice" runat="server" value="N"/>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    

</body>


<script type="text/javascript" >
var lstSupplierList = ('<%=lstSupplierDetails %>');
var a = JSON.parse(lstSupplierList);
$(document).ready(function () {
    if ($('#hdnPurchaseOrderItems').val() != "") {
        // JSON.parse($('#hdnPurchaseOrderItems').val());
        lstProductList = JSON.parse($('#hdnPurchaseOrderItems').val());
        if (lstProductList != "") {
            Tblist();
        }
    }
});


</script>

</html>
<script src="../PlatForm/Scripts/DataTable/js/jquery.dataTables.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/DataTable/TableTools.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/DataTable/js/dataTables.tableTools.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/DataTable/js/ZeroClipboard.js" type="text/javascript"></script>

