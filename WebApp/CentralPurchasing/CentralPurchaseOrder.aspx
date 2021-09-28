<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="CentralPurchaseOrder.aspx.cs"
    Inherits="CentralPurchasing_CentralPurchaseOrder" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Purchase Order</title>
</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
         <script src="Scripts/PurchaseOrder.js" language="javascript" type="text/javascript"></script>
    <div class="contentdata">
<%--        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div class="a-center" class="hide" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" 
                                meta:resourcekey="imgProgressbarResource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>
                <div id="sample" runat="server">
                    <table class="w-100p searchPanel">
                        <tr class="panelHeader">
                            <td colspan="2">
                                <%-- ================================ PurchaseorderHeader==============================================================================================================================--%>
                                <div id="ACX2OPPmt1" class="hide" runat="server">
                                    &nbsp;<img src="../PlatForm/Images/showBids.gif" alt="Show" class="v-top pointer w-15 h-18"
                                        onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',1);" />
                                    <span class="pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',1);">
                                        &nbsp;<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_01%></span></div>
                                <div id="ACX2minusOPPmt1" runat="server">
                                    &nbsp;<img src="../PlatForm/Images/HideBids.gif" class="v-top pointer w-15 h-18"
                                         onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',0);" />
                                    <span class="pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responses4',0);">
                                        &nbsp;<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_01%></div>
                            </td>
                        </tr>
                        <tr id="ACX2responses4">
                            <td colspan="2">
                                <table runat="server" class="w-100p">
                                    <tr runat="server">
                                        <td width="10%" runat="server">
                                            <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_02%>
                                            :
                                        </td>
                                        <td class="w-20p" runat="server">
                                            <asp:TextBox ID="txtPurchaseOrderDate" runat="server" MaxLength="1" Style="text-align: justify"
                                                CssClass="small datePicker" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                TabIndex="2" ValidationGroup="MKE" Width="130px" meta:resourcekey="txtPurchaseOrderDateResource1" />
                                        </td>
                                        <td class="w-70p">
                                            <asp:RadioButton ID="chkBasedonQuantity" Text="Based on quantity " onclick="javascript:ShowBaseOnQuantity(this);"
                                                runat="server" meta:resourcekey="chkBasedonQuantityResource1" />
                                            <asp:RadioButton ID="chkPO_Rate" Text="Based on rate" onclick="javascript:ShowBasedOnRate(this);"
                                                runat="server" meta:resourcekey="chkPO_RateResource1" />
                                            <span id="spanBySupplier" style="visibility: hidden;" runat="server">
                                                <asp:CheckBox ID="chkSupplier" Text="Search by Supplier" onclick="javascript:ShowSupplierlist();"
                                                    runat="server" meta:resourcekey="chkSupplierResource1" />
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <div id="divBasedOnRate" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td runat="server" id="tdlblsuppliername" clss="hide">
                                                            <asp:Label ID="lblSuppliername" runat="server" Text="Supplier Name" Font-Bold="True"
                                                                meta:resourcekey="lblSuppliernameResource1" />
                                                        </td>
                                                        <td colspan="4">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td runat="server" id="tdtxtsuppliername" class="hide v-top">
                                                            <asp:DropDownList ID="DropSupplierName" ToolTip="Select Supplier" runat="server"
                                                                onchange="javascript:GetSupplierdetails();" CssClass="small" Width="200px" meta:resourcekey="DropSupplierNameResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td colspan="4">
                                                            <div id="divSupplierProductList" class="w-100p" style="overflow-x: hidden; overflow-y: auto;">
                                                                <asp:Table CssClass="gridView w-100p"  runat="server" 
                                                                    ID="tblSupplierProductList" meta:resourcekey="tblSupplierProductListResource1">
                                                                </asp:Table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w-10p">
                                                            <input id="hdnProductId" runat="server" type="hidden">
                                                                <asp:Label ID="lblprd" runat="server" Font-Bold="True" Text="Product Name" meta:resourcekey="lblprdResource1"></asp:Label>
                                                            </input>
                                                        </td>
                                                        <td colspan="4">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="v-top">
                                                            <asp:TextBox ID="txtProductName" runat="server" CssClass="small" onKeyPress="return ValidateMultiLangChar(this);"
                                                                meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProductName"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" OnClientItemOver="ProductSupplierlist"
                                                                CompletionListItemCssClass="wordWheel itemsMain" OnClientItemSelected="IAmSelected" CompletionSetCount="10"
                                                                EnableCaching="false" MinimumPrefixLength="2" CompletionInterval="1" FirstRowSelected="true"
                                                                ServiceMethod="GetProductandSupplierList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td colspan="4">
                                                            <asp:Table CellPadding="1" CssClass="gridView" CellSpacing="1" BorderWidth="0px"
                                                                runat="server" ID="tbllist" Width="100%" 
                                                                meta:resourcekey="tbllistResource1">
                                                            </asp:Table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" runat="server" id="supnames" class="hide">
                                                            <asp:Label ID="Label5" runat="server" Text="Supplier Name " Font-Bold="True" 
                                                                meta:resourcekey="Label5Resource1"></asp:Label>
                                                            <input id="hdnsupplierID" runat="server" type="hidden" />
                                                        </td>
                                                        <td runat="server" id="hdunits" class="hide">
                                                            <asp:Label ID="Label13" runat="server" Text="Units" Font-Bold="True" 
                                                                meta:resourcekey="Label13Resource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" id="hdquantity" class="hide">
                                                            <asp:Label ID="Label6" runat="server" Text="Quantity" Font-Bold="True" 
                                                                meta:resourcekey="Label6Resource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" id="hdInverseQty" class="hide">
                                                            <asp:Label ID="lblInvQty" runat="server" Text="InverseQty" Font-Bold="True" 
                                                                meta:resourcekey="lblInvQtyResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" id="hdtotalQty" class="hide">
                                                            <asp:Label ID="Label29" runat="server" Text="Total Qty/LSU" Font-Bold="True" 
                                                                meta:resourcekey="Label29Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="secrow">
                                                        <td align="left" runat="server" id="drpssupnames" class="hide">
                                                            <asp:DropDownList ID="ddlSupplierList" runat="server" Width="200px" Style="margin-left: 0px"
                                                                onchange="supbasedunits();" meta:resourcekey="ddlSupplierListResource1">
                                                            </asp:DropDownList>
                                                            <%-- &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                                                        </td>
                                                        <td class="hide" runat="server" id="TotalQty">
                                                            <asp:DropDownList ID="drpunits" runat="server" OnChange="ConvertData();" 
                                                                meta:resourcekey="drpunitsResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="hide" runat="server" id="txquan">
                                                            <asp:TextBox ID="txtquantity" runat="server" Width="50px" onblur="checkQty();" 
                                                                onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                meta:resourcekey="txtquantityResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="hide" runat="server" id="tdtxtInvQty">
                                                        <asp:HiddenField runat="server" Value="0" ID="hdnBSRateMaximumQuantity" />
                                                            <asp:TextBox ID="txtInverQty" runat="server" Width="50px" ReadOnly="True" 
                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtInverQtyResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="hide" runat="server" id="drpulist">
                                                            <asp:TextBox ID="txtTotalQty" runat="server" Width="70px" ReadOnly="True" 
                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtTotalQtyResource1" />
                                                            <%--<asp:TextBox ID="drpunits" runat="server" Width="70px" ReadOnly="True" />--%>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <%--Arun--%>
                                                            <a id="btnClientAttributes" runat="server" class="btn"  onclick="javascript:createClienttab();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%></a>
                                                            <%--end--%>
                                                            <%--<input id="btnClientAttributes" class="btn" onclick="javascript:createClienttab();"
                                                                type="button" value="<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%>" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="hide" runat="server" id="trsupplieradd" colspan="5" align="center">
                                                        <%--Arun--%>
                                                        <a id="btnSuplierAdd" runat="server" class="btn"  onclick="javascript:createsupplierproductlist();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%></a>
                                                        <%--end--%>
                                                            <%--<input id="btnSuplierAdd" class="btn" type="button" onclick="javascript:createsupplierproductlist();"
                                                                value="<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%>" />--%>
                                                            <asp:CheckBox ID="chkCForm" Style="margin-left: 20px;" Text="C Form Tax Applicable For This Order" CssClass ="hide"
                                                                runat="server" meta:resourcekey="chkCFormResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divPOQuantity" runat="server" class="hide">
                                                <table border="0" class="w-100p gridView">
                                                    <tr>
                                                        <td>
                                                            <table width="25%">
                                                                <tr>
                                                                    <td align="left" runat="server" id="td_QuantitySupplier">
                                                                        <asp:Label ID="lbl_POQuantity_Supplier" runat="server" Text="Supplier Name" 
                                                                            Font-Bold="True" meta:resourcekey="lbl_POQuantity_SupplierResource1" />
                                                                    </td>
                                                                    <td runat="server" id="td_PO_Quantity_Supplier" align="left">
                                                                        <asp:DropDownList ID="ddl_PO_QuantitySupplier" ToolTip="Select Supplier" runat="server"
                                                                            onchange="javascript:GetSupplierdetailsPOQuantity();fnGetDrafts();" CssClass="ddl"
                                                                            Width="200px" meta:resourcekey="ddl_PO_QuantitySupplierResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" runat="server" id="td_PO_Quantity_Comments">
																	<%--Arun--%>
                                                                        <asp:Label ID="lbl_PO_Quantity_Comment" runat="server" Text="Comment" 
                                                                            Font-Bold="True" OnKeyPress="ValidateMultiLangCharacter();" meta:resourcekey="lbl_PO_Quantity_CommentResource1" />
																	<%--end--%>		
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txt_PO_Quantity_Comment" runat="server" BorderColor="DarkGray" ForeColor="Black"
                                                                            Width="195px" TextMode="MultiLine" onKeyPress="return ValidateMultiLangChar(this);"
                                                                            meta:resourcekey="txt_PO_Quantity_CommentResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="divPO_Details" class="hide" runat="server">
                                                                <table id="table_PO_QuantityDetails" class="grdiView w-100p marginT5" runat="server">
                                                                    <tr class="gridHeader" runat="server">
                                                                        <td align="left" runat="server">
                                                                            <input id="hdnPO_Quantity_ProductID" runat="server" type="hidden" >
                                                                                <asp:Label ID="lbl_PO_Qty_ProductName" runat="server" Font-Bold="True" 
                                                                                    Text="Product Name" meta:resourcekey="lbl_PO_Qty_ProductNameResource1"></asp:Label>
                                                                            </input>
                                                                        </td>
                                                                        <td runat="server" id="Td1">
                                                                            <asp:Label ID="lbl_PO_Qty_POUnit" runat="server" Text="PO Unit" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_POUnitResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server" id="Td14">
                                                                            <asp:Label ID="lbl_PO_Qty_Quantity" runat="server" Text="Quantity" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_QuantityResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lbl_PO_Qty_StockinQty" runat="server" Text="StockinHand Quantity"
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_StockinQtyResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:Label ID="lbl_PO_Qty_LastDayQty" runat="server" Text="SoldYesterDay" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_LastDayQtyResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:Label ID="lbl_PO_Qty_LastMonth" runat="server" Text="SoldLastMonth" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_LastMonthResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:Label ID="lbl_PO_Qty_LastQuater" runat="server" Text="SoldLastQuater" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_LastQuaterResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:Label ID="lbl_PO_Qty_New" runat="server" Text="Product is" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_NewResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txt_PO_Quantity_ProductName" runat="server" class="small" onKeyPress="return ValidateMultiLangChar(this);"
                                                                                meta:resourcekey="txt_PO_Quantity_ProductNameResource1"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                                                MinimumPrefixLength="1" OnClientItemSelected="IsSelected" ServiceMethod="GetSearchProductList"
                                                                                ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txt_PO_Quantity_ProductName"
                                                                                DelimiterCharacters="" Enabled="True">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td align="left" runat="server" id="Td2">
                                                                            <asp:DropDownList ID="ddlPOUnits" runat="server" Width="80px" 
                                                                                Style="margin-left: 0px" meta:resourcekey="ddlPOUnitsResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txtPOQuantity" runat="server" Width="50px" 
                                                                                onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                                                                meta:resourcekey="txtPOQuantityResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txt_PO_Quantity_Stockinhand" runat="server" Width="50px" ReadOnly="True"
                                                                                Enabled="False" onKeyPress="return ValidateSpecialAndNumeric(this);" 
                                                                                meta:resourcekey="txt_PO_Quantity_StockinhandResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txt_PO_Qty_LastDayQtyValue" runat="server" Width="50px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                Enabled="False" meta:resourcekey="txt_PO_Qty_LastDayQtyValueResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txt_PO_Qty_LastMonthValue" runat="server" Width="50px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                Enabled="False" meta:resourcekey="txt_PO_Qty_LastMonthValueResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:TextBox ID="txt_PO_Qty_LastQuaterValue" runat="server" Width="50px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                Enabled="False" Font-Bold="True" 
                                                                                meta:resourcekey="txt_PO_Qty_LastQuaterValueResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td runat="server">
                                                                            <asp:Label ID="lbl_PO_Qty_NewValue" runat="server" Width="50px" 
                                                                                Font-Bold="True" meta:resourcekey="lbl_PO_Qty_NewValueResource1"></asp:Label>
                                                                        </td>
                                                                        <td runat="server" id="Td3">
                                                                        <%--Arun--%>
                                                                        <a id="btnPO_Quantity_Add" runat="server" class="btn"  onclick="javascript:return btnOnFocus();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%></a>
                                                                           <%-- <input id="btnPO_Quantity_Add" class="btn" onclick="javascript:return btnOnFocus();"
                                                                                style="width: 50px;" type="button" value=" <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%> " />--%>
                                                                            <%--end--%>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="ProductData" runat="server" class="hide">
                                        <td colspan="3">
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="3" CssClass="gridView" 
                                                DataKeyNames="OrderId,SupplierId,IsRate" OnRowCommand="grdResult_RowCommand" 
                                                OnRowDataBound="grdResult_RowDataCommand" Width="100%" 
                                                OnPageIndexChanging="grdResult_PageIndexChanging" 
                                                meta:resourcekey="grdResultResource1">
                                                <HeaderStyle CssClass="gridHeader" />
                                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="OrderNo" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblorderno" runat="server" Text='<%# Eval("OrderNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <%--Arun--%>
                                                    <asp:TemplateField HeaderText="SupplierName" meta:resourcekey="TemplateFieldResource3">
                                                    <%--end--%>
                                                        <ItemTemplate>
                                                            <asp:Label ID="sname" runat="server" Text='<%# Eval("SupplierName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle Width="30%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Status" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="OrderDate" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="OrderDate" runat="server" Text='<%# Eval("DCN0") %>'></asp:Label>
                                                            <asp:HiddenField ID="hdnsupplierinfo" runat="server" Value='<%# Eval("ReferenceNo") %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle Width="25%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <input id="hdnProductsupplier" runat="server" type="hidden" />
                                            <input id="hdnLoadProductsupplier" runat="server" type="hidden" />
                                            <input id="hdntvtvalue" runat="server" type="hidden" />
                                            <input id="hdnInverseQty" runat="server" type="hidden" />
                                            <table id="tblProductsupplier" runat="server" class="w-100p gridView hide">
                                                <tr runat="server"  class="gridHeder">
                                                    <th >
                                                        <asp:Label ID="INvnam" runat="server" Text="Product Name" meta:resourcekey="INvnamResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="Product" runat="server" Text="Supplier Name" meta:resourcekey="ProductResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="quantity" runat="server" Text="Quantity" meta:resourcekey="quantityResource2"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="units" runat="server" Text="Units" meta:resourcekey="unitsResource2"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblInverseQty" runat="server" Text="Inverse Qty" meta:resourcekey="lblInverseQtyResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="Label30" runat="server" Text="Total Qty" meta:resourcekey="Label30Resource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblStockinQty" runat="server" Text="Stockinhand Qty" meta:resourcekey="lblStockinQtyResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblsoldlastDay" runat="server" Text="SoldYesterday" meta:resourcekey="lblsoldlastDayResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblsoldlastMonth" runat="server" Text="SoldLastMonth" meta:resourcekey="lblsoldlastMonthResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblsoldlastYear" runat="server" Text="SoldLastQuater" meta:resourcekey="lblsoldlastYearResource1"></asp:Label>
                                                    </th>
                                                    <th >
                                                        <asp:Label ID="lblProductIs" runat="server" Text="Product is" meta:resourcekey="lblProductIsResource1"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblActions" runat="server" Text="Action" meta:resourcekey="lblActionsResource1"></asp:Label>
                                                    </th>
                                                </tr>
                                            </table>
                                            <table id="tblPO_Quantity_Productlist" runat="server" class="gridView w-100p marginT10 hide" >
                                                <tr runat="server"  class="gridHeader">
                                                    <th runat="server" >
                                                        <asp:Label ID="Label25" runat="server" Text="S No" meta:resourcekey="Label25Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label11" runat="server" Text="Product Name" meta:resourcekey="Label11Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label24" runat="server" Text="PO Unit" meta:resourcekey="Label24Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label18" runat="server" Text="Quantity" meta:resourcekey="Label18Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label12" runat="server" Text="Stockinhand Qty" meta:resourcekey="Label12Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label26" runat="server" Text="SoldYesterDay" meta:resourcekey="Label26Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label27" runat="server" Text="SoldLastMonth" meta:resourcekey="Label27Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label33" runat="server" Text="SoldLastQuater" meta:resourcekey="Label33Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" >
                                                        <asp:Label ID="Label34" runat="server" Text="Product is" meta:resourcekey="Label34Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server">
                                                        <asp:Label ID="Label32" runat="server" Text="Action" meta:resourcekey="Label32Resource1"></asp:Label>
                                                    </th>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" id="tdApprove" class="hide a-center" runat="server">
                                            <asp:Button ID="btnpoApprove" runat="server" class="btn" OnClick="btnpoApprove_Click"
                                                OnClientClick="Checkvalue();" Text="Approved" meta:resourcekey="btnpoApproveResource1" />
                                            <asp:Button ID="btnPOCancel" runat="server" class="cancel-btn" OnClick="btnPOCancel_Click"
                                                OnClientClick="Checkvalue();" Text="PO Cancel" meta:resourcekey="btnPOCancelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="hide a-center" id="btsave" runat="server">
                                            <%--Arun--%>
                                            <a id="save" runat="server" class="btn hide" onclick="fnSaveAsDrafts('ManualSave')">
                                                <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_04%></a>
                                            <%--<input type="button" value="<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_04%>"
                                                class="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                onclick="fnSaveAsDrafts('ManualSave')" />--%>
                                                <%--end--%>
                                            <asp:Button ID="btnSave" runat="server" class="btn" OnClick="btnSave_Click" OnClientClick="Checkvalue();"
                                                Text="Save" meta:resourcekey="btnSaveResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <%--==================================================================================================================================================================================================================================================================================================
                                                          <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                                                            <ajc:ModalPopupExtender ID="Purchasesup" runat="server" BackgroundCssClass="modalBackground"
                                                                CancelControlID="btnCnl" PopupControlID="pnlAttrib" TargetControlID="hiddenTargetControlForModalPopup">
                                                            </ajc:ModalPopupExtender>--%>
                                <%-- ================================ PurchaseorderHeader==============================================================================================================================--%>
                                <%-- <tr>
                                                    <td colspan="2" class="colorforcontent">
                                                        <div id="Div1" style="display: block;" runat="server">
                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div1','Div2','ACX2responses5',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','ACX2responses5',1);">
                                                                &nbsp;Purchase Order Mapping Location </span>
                                                        </div>
                                                        <div id="Div2" style="display: none;" runat="server">
                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div1','Div2','ACX2responses5',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','ACX2responses5',0);">
                                                            &nbsp;Purchase Order Mapping Location
                                                        </div>
                                                    </td>
                                                </tr>--%>
                                <tr align="center" id="ACX2responses5" class="hide">
                                    <td class="w-100p">
                                        <asp:Panel ID="pnlAttrib" runat="server" CssClass="w-100p" meta:resourcekey="pnlAttribResource1">
                                            <div id="divPORateDetails" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="v-top">
                                                            <table id="stockIssuedTab" runat="server" class="gridView w-100p">
                                                                <tr class="v-top">
                                                                    <td >
                                                                        <asp:HiddenField ID="hdnSupliersID" runat="server" />
                                                                         <%--Arun--%>
                                                                        <asp:Label ID="lblsup1" runat="server" Text="Supplier " Width="100px" meta:resourcekey="lblsup1Resource1"></asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td>
                                                                        <%--Arun--%>
                                                                        <asp:Label ID="lblll17" runat="server" meta:resourcekey="lblll17Resource1">:</asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td >
                                                                        <asp:Label ID="SupName" runat="server" ForeColor="Black" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td >
                                                                        <%--Arun--%>
                                                                        <asp:Label ID="lblAdd1" runat="server" Text="Address " Width="100px" meta:resourcekey="lblAdd1Resource1"></asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td>
                                                                    <%--Arun--%>
                                                                        <asp:Label ID="lblll16" runat="server"  meta:resourcekey="lblll16Resource1">:</asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td >
                                                                        <asp:Label ID="Supplierinfos" runat="server" ForeColor="Black" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td >
                                                                        <%--Arun--%>
                                                                        <asp:Label ID="lblCon1" runat="server" Text="Contact No  " Width="100px" meta:resourcekey="lblCon1Resource1"></asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td>
                                                                        :
                                                                    </td>
                                                                    <td >
                                                                        <asp:Label ID="lblContact" runat="server" ForeColor="Black" />
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td >
                                                                        <%--Arun--%>
                                                                        <asp:Label ID="lblcomm1" runat="server" Text="Comments " Width="100px" meta:resourcekey="lblcomm1Resource1"> </asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td>
                                                                        :
                                                                    </td>
                                                                    <td >
                                                                        <asp:TextBox ID="txtComment" runat="server" BorderColor="DarkGray" ForeColor="Black"
                                                                            onKeyPress="return ValidateMultiLangChar(this);" TextMode="MultiLine" />
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td >
                                                                        <%--Arun--%>
                                                                        <asp:Label ID="lblordn1" runat="server" Text="Order Date" Width="100px" meta:resourcekey="lblordn1Resource1"></asp:Label>
                                                                        <%--end--%>
                                                                    </td>
                                                                    <td>
                                                                        :
                                                                    </td>
                                                                    <td >
                                                                        <asp:Label ID="txtorderdate" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="v-top w-55p a-left">
                                                            <div class="auto" id="gvPurchaseorder">
                                                                <asp:GridView ID="gvPurOrderDetails" runat="server" AutoGenerateColumns="False" CssClass="w-100p gridView"
                                                                    OnRowDataBound="gvPurOrderDetails_RowDataBound" meta:resourcekey="gvPurOrderDetailsResource1">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourceKey="BoundFieldResource1">
                                                                            <ItemStyle  />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" meta:resourceKey="BoundFieldResource2">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Unit" HeaderText="Units" meta:resourceKey="BoundFieldResource3">
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="TotalQty/LSU" meta:resourceKey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <%# Eval("OrderedQty")%>
                                                                                <%# Eval("LSUnit")%>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                            <%--Edit purhcase ordr--%>
                                                            <div>
                                                                <table id="divEditPurchaseorder" class="hide w-100p borderGrey" runat="server">
                                                                    <tr  class="panelHeader">
                                                                        <td colspan="4">
                                                                            <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_05%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblproductname" runat="server" Text="ProductName : "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="txtprodname" runat="server" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblquant" runat="server" Text="Quantity : "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtqty" runat="server" CssClass="small" onKeyPress="return ValidateSpecialAndNumeric(this);" onblur="CalculateQty();updatechangesqty();"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblunit" runat="server" Text="Units : " />
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="dpUnits" runat="server" CssClass="small" onchange="CalculateQty();">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lbltotal" runat="server" Text="Quantity : "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txttotalquantity" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="small"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" class="a-center">
                                                                            <asp:Button ID="btnprupdate" runat="server" class="btn" Text="Update" OnClick="btnprupdate_Click"
                                                                                OnClientClick="return NewUpdateData();" meta:resourceKey="btnprupdateResource1" />
                                                                                <%--Arun--%>
                                                                                <a id="Button1" runat="server" class="cancel-btn"  onclick="javascript:hide();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_28%></a>
                                                                            <%--<input id="Button1" class="cancel-btn" type="button" value="Cancel" onclick="javascript:hide();" />--%>
                                                                            <%--end--%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none;">
                                                                        <td colspan="4">
                                                                            <asp:Label ID="lblpurchaseorderid" runat="server" Text="" />
                                                                            <asp:Label ID="lblpodetailsid" runat="server" Text="" />
                                                                            <asp:Label ID="lblsuppliersid" runat="server" Text="" />
                                                                            <asp:Label ID="lblproductid" runat="server" Text="" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="v-top" >
                                                        <td colspan="2" class="v-top">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <table class="w-50p gridView marginB5 marginT5">
                                                                            <tr class="gridTDheader  a-center">
                                                                                <td>
                                                                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Products" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                </td>
                                                                                                                                                                <td>
                                                                                    <asp:Label ID="Label37" runat="server" Font-Bold="True" Text="ProductDescription" ></asp:Label>
                                                                                </td>
                                                                                <td class="w-10p">
                                                                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="Unit" meta:resourcekey="Label4Resource1"></asp:Label>
                                                                                </td>
                                                                                <td class="w-10p">
                                                                                    <asp:Label ID="Label14" runat="server" Font-Bold="True" Text="Ordered Qty" meta:resourcekey="Label14Resource1"></asp:Label>
                                                                                </td>
                                                                                <td class="w-10p">
                                                                                    <asp:Label ID="Label31" runat="server" Font-Bold="True" Text="Qty/SKU" meta:resourcekey="Label31Resource1"></asp:Label>
                                                                                </td>
                                                                                <td class="w-10p">
                                                                                    <asp:Label ID="Label36" runat="server" Font-Bold="True" Text="Action" meta:resourcekey="Label36Resource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="a-center">
                                                                                <td id="tdSearch" runat="server" style="width: 3%;">
                                                                                    <input id="hdnprodsID" runat="server" type="hidden" />
                                                                                    <asp:TextBox ID="txtProduct" runat="server" onKeyPress="return ValidateMultiLangChar(this);" Width="225px"> </asp:TextBox>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtProduct"
                                                                                        BehaviorID="AutoCompleteProduct1" CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                        CompletionListItemCssClass="listitemtwo" OnClientItemSelected="IAmSelectedItems"
                                                                                        CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                        FirstRowSelected="true" ServiceMethod="GetProductSupplierOrder" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                    <%--
                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                            CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                                            MinimumPrefixLength="2" OnClientItemSelected="IAmSelectedItems" ServiceMethod="GetProductSupplierOrder"
                                                                                            ServicePath="~/InventoryWebService.asmx" TargetControlID="txtProduct">
                                                                                        </ajc:AutoCompleteExtender>--%>
                                                                                </td>
                                                                                
                                                                                                                                                                                                                                                <td class="w-5p">
                                                                                      <asp:TextBox ID="txtPD" runat="server" BorderColor="DarkGray" Font-Bold="True"
                                                                                        ForeColor="Black"  Width="255px"  />
                                                                                </td>
                                                                                <td class="w-5p">
                                                                                    <asp:DropDownList ID="txtUnits" runat="server" Width="70px" Style="margin-left: 0px"
                                                                                        Onchange="AvailableQty();" meta:resourcekey="txtUnitsResource1">
                                                                                       <%-- Arun--%>
                                                                                        <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>--%>
                                                                                        <%--end--%>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td class="w-5p">
                                                                                    <asp:TextBox ID="txtavailableqty" runat="server" BorderColor="DarkGray" Font-Bold="True" onKeyPress="return ValidateMultiLangChar(this);"
                                                                                        ForeColor="Black" ReadOnly="True" Width="60px" meta:resourcekey="txtavailableqtyResource1" />
                                                                                </td>
                                                                                <td class="style5">
                                                                                    <asp:TextBox ID="txtqtyml" runat="server" BorderColor="DarkGray" Font-Bold="True" onKeyPress="return ValidateMultiLangChar(this);"
                                                                                        ForeColor="Black" ReadOnly="True" Width="60px" meta:resourcekey="txtqtymlResource1" />
                                                                                </td>
                                                                                <td>
                                                                                <%--Arun--%>
                                                                                <a id="clear1" runat="server" class="cancel-btn"  onclick="fnclear();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_06%></a>
                                                                                    <%--<input name="lnkclear" value="<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_06%>"
                                                                                        type='button' class="cancel-btn" onclick="fnclear();" />--%>
                                                                                        <%--end--%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr class="v-top">
                                                                    <td class="v-top">
                                                                        <div>
                                                                            <table class="gridView w-100p marginB5">
                                                                                <tr class="gridTDheader ">
                                                                                    <td>
                                                                                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Text="Ordered Qty" meta:resourcekey="Label15Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="Label28" runat="server" Font-Bold="True" Text="Amount" meta:resourcekey="Label28Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="Label19" runat="server" Font-Bold="True" Text="Comp.Qty(lsu)" meta:resourcekey="Label19Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="Label20" runat="server" Font-Bold="True" Text="Discount(%)" meta:resourcekey="Label20Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="Label22" runat="server" Font-Bold="True" Text="Vat(%)" meta:resourcekey="Label22Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="Label23" runat="server" Font-Bold="True" Text="Total Amount" meta:resourcekey="Label23Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="lbltrusted">
                                                                                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Text="Trusted Org " meta:resourcekey="Label8Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="lblloc">
                                                                                        <asp:Label ID="Label16" runat="server" Font-Bold="True" Text="Location " meta:resourcekey="Label16Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="lblDelivery">
                                                                                        <asp:Label ID="Label17" runat="server" Font-Bold="True" Text="Delivery Date " Width="100px"
                                                                                            meta:resourcekey="Label17Resource1" />
                                                                                    </td>
                                                                                    <td id="Td4" class="w-100">
                                                                                        <asp:Label ID="Label35" runat="server" Font-Bold="True" Text="Action " meta:resourcekey="Label35Resource1" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtsQuantity" runat="server" BorderColor="DarkGray" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                            Font-Bold="True" ForeColor="Black" Width="60px" onblur="Amountbind();ConversionUnits();"
                                                                                            meta:resourcekey="txtsQuantityResource1" />
                                                                                    </td>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtunitcost" runat="server" BorderColor="DarkGray" Font-Bold="True" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                            ForeColor="Black" ReadOnly="True" Width="60px" meta:resourcekey="txtunitcostResource1" />
                                                                                    </td>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtcompqty" runat="server" BorderColor="DarkGray" Font-Bold="True"
                                                                                            onKeyPress="return ValidateSpecialAndNumeric(this);" ForeColor="Black" Width="60px"
                                                                                            Text="0" meta:resourcekey="txtcompqtyResource1" />
                                                                                    </td>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtDiscount" runat="server" BorderColor="DarkGray" Font-Bold="True"
                                                                                            ForeColor="Black" Width="60px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                            Text="0" meta:resourcekey="txtDiscountResource1" />
                                                                                    </td>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtvat" runat="server" BorderColor="DarkGray" Font-Bold="True" ForeColor="Black"
                                                                                            Text="0" Width="60px" onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtvatResource1" />
                                                                                    </td>
                                                                                    <td class="style5">
                                                                                        <asp:TextBox ID="txtAmount" runat="server" BorderColor="DarkGray" Font-Bold="True"
                                                                                           onKeyPress="return ValidateSpecialAndNumeric(this);" ForeColor="Black" ReadOnly="True" Width="60px" meta:resourcekey="txtAmountResource1" />
                                                                                    </td>
                                                                                    <td id="txtrustedorg" style="display: none;">
                                                                                        <asp:DropDownList ID="ddlTrustedOrg" runat="server" Onblur="GetLocationlist();" class="fix-me"
                                                                                            meta:resourcekey="ddlTrustedOrgResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtTrustedOrg" onKeyPress="return ValidateMultiLangChar(this);" onkeydown="javascript:return Checkorgtext();" runat="server"
                                                                                            Width="300px" meta:resourcekey="txtTrustedOrgResource1"></asp:TextBox>
                                                                                        <ajc:AutoCompleteExtender ID="AutoTrustOrg" runat="server" TargetControlID="txtTrustedOrg"
                                                                                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                            CompletionListItemCssClass="listitemtwo" CompletionSetCount="10" EnableCaching="false"
                                                                                            OnClientItemSelected="SetOrganizationDetails" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                            FirstRowSelected="true" ServiceMethod="GetProductorganizationDetails" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx">
                                                                                        </ajc:AutoCompleteExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtLocationorg" onKeyPress="return ValidateMultiLangChar(this);" onkeydown="javascript:return CheckorgLocationtext();"
                                                                                            runat="server" Width="200px" meta:resourcekey="txtLocationorgResource1"></asp:TextBox>
                                                                                        <ajc:AutoCompleteExtender ID="AutoLocationOrg" runat="server" TargetControlID="txtLocationorg"
                                                                                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                            CompletionListItemCssClass="listitemtwo" CompletionSetCount="10" EnableCaching="false"
                                                                                            OnClientItemSelected="SetLocationDetails" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                            FirstRowSelected="true" ServiceMethod="GetProductorganizationDetails" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx">
                                                                                        </ajc:AutoCompleteExtender>
                                                                                    </td>
                                                                                    <td id="txlocation" class="hide">
                                                                                        <asp:DropDownList ID="drpLocation" runat="server" Width="120px" onclick="return validateorg();"
                                                                                            class="fix-me" meta:resourcekey="drpLocationResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td id="txDeliverydat">
																					<%--Arun--%>
                                                                                        <asp:TextBox ID="txtFDate" runat="server" class="small datePicker"  onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                                                        
                                                                                    </td>
                                                                                    <td>
                                                                                    <%--Arun--%>
                                                                                    <a id="btnaddo" runat="server" class="btn"  onclick="javascript:purchaseordertab();"><%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03  %></a>
                                                                                        <%--<input id="btnaddo" class="btn" onclick="javascript:purchaseordertab(); " type="button"
                                                                                            value="<%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_03%>" />--%>
                                                                                            <%--end--%>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <%--dynamic Table using javascript in modal popup--%>
                                                    <tr class="v-top">
                                                        <td colspan="2" class="v-top">
                                                            <input id="hdnproductlocmap" runat="server" type="hidden" value="" />
                                                            <input id="hdnPONo" runat="server" type="hidden" value="" />
                                                            <input id="hdnPOID" runat="server" type="hidden" value="0" />
                                                            <input id="hdnSupplierName" runat="server" type="hidden" value="" />
                                                            <input id="hdnPOStatus" runat="server" type="hidden" value="" />
                                                            <asp:Label ID="lblTable" runat="server" CssClass="w-100p"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="tbTotalCost" class="pull-right hide" runat="server">
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td >
                                                                            <%= Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_07%>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtGrandTotal" Width="70px" Style="text-align: right;" Enabled="False"
                                                                                runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" Text="0.00" meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td >
                                                                            <asp:Label ID="lbldiscount" Text="Total Discount" runat="server" meta:resourcekey="lbldiscountResource1" />
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtProductdiscount" Width="70px" Style="text-align: right;" Enabled="False" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                runat="server" Text="0.00" meta:resourcekey="txtProductdiscountResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td >
                                                                            <asp:Label ID="lblVat" Text="Total GST" runat="server" meta:resourcekey="lblVatResource1" />
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtProductVat" Width="70px" Style="text-align: right;" Enabled="False"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtProductVatResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td >
                                                                            <%= Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_08%>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtTotalDiscount" Width="70px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                Style="text-align: right;" runat="server" Text="0.00" onblur="checkAddToTotal();"
                                                                                meta:resourcekey="txtTotalDiscountResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td >
                                                                            <%= Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_09%>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtCharges" Width="70px" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                                                                Style="text-align: right;" runat="server" Text="0.00" onblur="checkAddToTotal();"
                                                                                meta:resourcekey="txtChargesResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td >
                                                                            <%= Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_10%>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtNetTotal" Width="70px" Enabled="False" Style="text-align: right;"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtNetTotalResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPackingSale" runat="server" class="hide">
                                                                        <td >
                                                                            <input type="checkbox" id="chkPackingSale" onclick="CalculatePackingSale(this);" />
                                                                            <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale" meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtPackingSale" Enabled="false" Width="70px" runat="server" CssClass="Align"
                                                                              onKeyPress="return ValidateSpecialAndNumeric(this);"  Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trExciseDuty" runat="server" class="hide">
                                                                        <td >
                                                                            <input type="checkbox" id="chkExciseDuty" onclick="CalculateExciseDuty(this);" />
                                                                            <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty :" meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtExciseDuty" Enabled="false" Width="70px" runat="server" CssClass="Align"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trEduCess" runat="server" class="hide">
                                                                        <td >
                                                                            <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess :"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtEduCess" Enabled="false" Width="70px" runat="server" CssClass="Align"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trSecCess" runat="server" class="hide">
                                                                        <td >
                                                                            <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess :" meta:resourcekey="lblSecCessResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtSecCess" Enabled="False" Width="70px" runat="server" CssClass="Align"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trTotal" runat="server" class="hide">
                                                                        <td  runat="server">
                                                                            <asp:Label ID="Label10" runat="server" Text="Total" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtTotal" Enabled="False" Width="70px" runat="server" CssClass="Align"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trCST" runat="server" class="hide">
                                                                        <td >
                                                                            <asp:Label ID="lblCST" runat="server" Text="CST :" meta:resourcekey="lblCSTResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtCST" Enabled="false" Width="70px" runat="server" CssClass="Align"
                                                                               onKeyPress="return ValidateSpecialAndNumeric(this);" Style="text-align: right;" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <asp:HiddenField ID="hdnGetTaxList" runat="server" />
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center" colspan="2">
                                                            <asp:Button ID="btninsert" runat="server" CssClass="btn" OnClick="btninsert_Click"
                                                                Text="Save" OnClientClick="return purchasevalid();" meta:resourcekey="btninsertResource1" />
                                                            <asp:Button ID="btnApprove" runat="server" CssClass="btn" Text="Approve" OnClick="btnApprove_Click"
                                                                OnClientClick="return approvestep();" Visible="False" meta:resourcekey="btnApproveResource1" />
                                                            <asp:Button ID="btnback" runat="server" CssClass="cancel-btn" Text="Back" OnClick="btnback_Click"
                                                                meta:resourcekey="btnbackResource1" />
                                                            <asp:Button ID="btnCancelPO" Text="Cancel PO" runat="server" CssClass="cancel-btn"
                                                                OnClick="btnCancelPO_Click" Visible="False" meta:resourcekey="btnCancelPOResource1" />
                                                            <asp:Button ID="btnCnl" runat="server" CssClass="cancel-btn" Text="Close" OnClientClick="clearfun();"
                                                                meta:resourcekey="btnCnlResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style18">
                                    </td>
                                    <td align="center" class="style19">
                                    </td>
                                </tr>
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:HiddenField ID="hdnallproducts" runat="server" />
                <asp:HiddenField ID="hdnFlag" Value="0" runat="server" />
            <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <asp:HiddenField ID="hdnorderid" runat="server" />
    <asp:HiddenField ID="hdnsuppid" runat="server" />
    <asp:HiddenField ID="hdnIsRate" runat="server" />
    <input type="hidden" id="hdnvalues" runat="server" />
    <input type="hidden" id="hdnRowEdit" runat="server" />
    <input type="hidden" id="hdnConversionamt" runat="server" />
    <input type="hidden" id="hidSupplierID" runat="server" />
    <input type="hidden" id="pnoquantity" runat="server" />
    <input type="hidden" id="pototalqty" runat="server" />
    <input type="hidden" id="hdnPurchaseOrderID" runat="server" />
    <input type="hidden" id="hdnlocation" runat="server" />
    <input type="hidden" id="hdnDeliverydate" runat="server" />
    <input type="hidden" id="hdnPurOrderDetailsID" runat="server" />
    <input type="hidden" id="hdnconvesrsiondata" runat="server" />
    <input type="hidden" id="hdnparentprodutid" runat="server" />
    <asp:HiddenField ID="hdnavailqty" runat="server" Visible="false" />
    <asp:HiddenField ID="hdnrate" runat="server" />
    <asp:HiddenField ID="hdnTotaldiscount" runat="server" />
    <asp:HiddenField ID="hdnunitss" runat="server" />
    <input type="hidden" id="hdnRowId" value="0" runat="server" />
    <asp:HiddenField ID="hdnPorderQty" runat="server" />
    <asp:HiddenField ID="hdnpodetails" runat="server" />
    <asp:HiddenField ID="hdnoriginalqty" runat="server" />
    <asp:HiddenField ID="hdneditunit" runat="server" />
    <asp:HiddenField ID="hdnID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnrates" Value="0" runat="server" />
    <asp:HiddenField ID="hdnSelectedOrg" Value="0" runat="server" />
    <asp:HiddenField ID="hdnSelectedLocation" Value="0" runat="server" />
    <asp:HiddenField ID="hdnLSU" runat="server" />
    <asp:HiddenField ID="hdnLstDayQty" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnLstMonthQty" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnLstQtrQty" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnProductIs" runat="server" />
    <asp:HiddenField ID="hdnSellingPrice" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnQuotationId" runat="server" Value="0" />
    <input type="hidden" id="hdnStockinhandQty" runat="server" value="0" />
    <input type="hidden" id="hdnPO_Quantity_Day" runat="server" value="0" />
    <input type="hidden" id="hdnPO_Quantity_Month" runat="server" value="0" />
    <input type="hidden" id="hdnPO_Quantity_Quater" runat="server" value="0" />
    <input type="hidden" id="hdnPO_Quantity_New" runat="server" value="0" />
    <input type="hidden" id="hdnPO_Quantity_Approval" runat="server" value="N" />
    <input type="hidden" id="hdnEditTaxApproval" runat="server" value="N" />
    <asp:HiddenField ID="hdnInventoryLocationID" runat="server" Value="0" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <input type="hidden" runat="server" id="hdnLoginLocationID" />
    <input type="hidden" runat="server" id="hdnPageID" />
    <input type="hidden" runat="server" id="hdnLoginID" />
    <input type="hidden" runat="server" id="hdnOrgId" />
    <input type="hidden" id="hdnDaftMethod" />
     <input type="hidden" id="hdn_ValidateQutationDiscountInPOconfig" runat="server" value="N" />
       <input type="hidden" id="hdn_QMdiscount"  value="0" />     
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
      <script src="Scripts/PurchaseOrder.js" language="javascript" type="text/javascript"></script>
  <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" language="javascript"
        type="text/javascript"></script>
    </form>

<script language="javascript" type="text/javascript">
    var errorMsg = null;
    var informMsg = null;
    var okMsg = null;
    var cancelMsg = null;
    $(document).ready(function() {
        errorMsg = SListForAppMsg.Get('CentralPurchasing_Error') == null ? "Alert" : SListForAppMsg.Get('CentralPurchasing_Error');
        informMsg = SListForAppMsg.Get('CentralPurchasing_Information') == null ? "Information" : SListForAppMsg.Get('CentralPurchasing_Information');
        okMsg = SListForAppMsg.Get('CentralPurchasing_OK') == null ? "Ok" : SListForAppMsg.Get('CentralPurchasing_OK');
        cancelMsg = SListForAppMsg.Get('CentralPurchasing_Cancel') == null ? "Cancel" : SListForAppMsg.Get('CentralPurchasing_Cancel');
        var AppInterval = $("input[id$=hdnshowintervel]").val();
        if (GetParameterValues("PONo") == undefined) {
            setTimeout(fnSaveAsDrafts, AppInterval);
        }
        if ($("#hdnProductsupplier").val() != "") {
           // PO_QuantityTblist();
        }
    });
    function fnSaveAsDrafts(SaveMetod) {
        var productList = $("#hdnProductsupplier").val();
        $('#hdnDaftMethod').val(SaveMetod);
        if (SaveMetod == 'ManualSave') {
            if (productList == "") {
                var userMsg = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_22') == null ? "please add products to save draft" : SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_22');
                ValidationWindow(userMsg,errorMsg);
                return false;
            }
            else {
                fnShowProgress();
            }
        }
        var draftValue = 0;
        if ($("#chkBasedonQuantity").prop("checked")) {
            draftValue = $('#ddl_PO_QuantitySupplier').val();
        }
        var draftData="";
    if (productList != "") {
         draftData = funFormatDrafts(productList, "", "*NA*");
    }
        var hdnLoginLocationID = $("#hdnLoginLocationID").val();
        var hdnPageID = $("#hdnPageID").val();
        var hdnLoginID = $("#hdnLoginID").val();
        var hdnOrgID = $("#hdnOrgId").val();
        var BasedOnQuantity = $('#chkBasedonQuantity').attr('checked');
        if (draftValue > 0 && BasedOnQuantity && draftData!="") {
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveASDraft",
                data: '{OrgID:"' + hdnOrgID + '",LocationID:"' + $("#hdnInventoryLocationID").val() + '",PageID:"' + hdnPageID + '",LoginID:"' + hdnLoginID + '",DraftType:"CentralPurchaseOrder",DraftValue:"' + draftValue + '",DraftData:"' + draftData + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function(response) {
                
                ValidationWindow(response.d, errorMsg);
                //end
                    fnHideProgress();
                }
            });
        }
        if (SaveMetod != 'ManualSave') {
            var AppInterval = $("input[id$=hdnshowintervel]").val();
            setTimeout(fnSaveAsDrafts, AppInterval);
        }
    }
    function OnSuccess(response) {
        // alert(response.d);
        fnHideProgress();
        if ($('#hdnDaftMethod').val() == 'ManualSave') {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_01") == null ? "Saved Successfully!!!" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_01")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_01');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//            }
//            else {
//                ValidationWindow('Saved Successfully!!!', 'Error')
            //            }
//end
        }

        $('#hdnDaftMethod').val('');
    }



    function fnGetDrafts() {
        $("#hdnProductsupplier").val('');
        var DraftValue = $('#ddl_PO_QuantitySupplier').val();
        var hdnLoginLocationID = $("#hdnLoginLocationID").val();
        var hdnPageID = $("#hdnPageID").val();
        var hdnLoginID = $("#hdnLoginID").val();
        var hdnOrgID = $("#hdnOrgId").val();
        var BasedOnQuantity = $('#chkBasedonQuantity').attr('checked');
        if (DraftValue > 0 && BasedOnQuantity) {
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetDraftDtls",
                data: '{OrgID:"' + hdnOrgID + '",LocationID:"' + $("#hdnInventoryLocationID").val() + '",PageID:"' + hdnPageID + '",LoginID:"' + hdnLoginID + '",DraftType:"CentralPurchaseOrder",DraftValue:"' + DraftValue + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetDraftSuccess,
                failure: function(response) {
                
                ValidationWindow(response.d, errorMsg);
                //end
                    fnHideProgress();
                }
            });
        }
    }
    function OnGetDraftSuccess(response) {

        if (response != null && response.d != null && response.d.length > 0) {
            if (response.d[0].Data != null && response.d[0].Data != undefined) {
                var productlist = funFormatDrafts(response.d[0].Data, "", "*NA*");
                $("#hdnProductsupplier").val(productlist);
                $('#btsave').removeClass().addClass("displaytd");
                $("#btnDraft").removeClass().addClass("btn show");
                $("#tblPO_Quantity_Productlist").removeClass().addClass("displaytb w-100p gridView");
            }
        }
        else {
            $("#hdnProductsupplier").val('');
        }
        PO_QuantityTblist();
    }
    function funFormatDrafts(str, findStr, replaceStr) {
        var stringArray = str.split("~");
        var arrayCount = stringArray.length;
        var returnString = "";
        for (var i = 0; i < arrayCount; i++) {
            if (i < arrayCount - 1) {
                returnString = stringArray[i] == findStr ? returnString + replaceStr + "~" : returnString + stringArray[i] + "~";
            } else {
                returnString = stringArray[i] == findStr ? returnString + replaceStr : returnString + stringArray[i];
            }
        }
        return returnString;
    }     
</script>

<script language="javascript" type="text/javascript">
    var userMsg;
    $(function() {

        var el;

        $("select.fix-me")
				.each(function() {
				    el = $(this);
				    el.data("origWidth", el.outerWidth()) // IE 8 will take padding on selects
				})
			  .mouseenter(function() {
			      $(this).css("width", "auto");
			  })
			  .bind("blur change", function() {
			      el = $(this);
			      el.css("width", el.data("origWidth"));
			  });
        //            $('#chkPO_Rate').attr('checked', true);
        //            ShowControls();
        if ($.trim($('#hdnLoadProductsupplier').val()) != '') {
            //POTableList();
            POTableList_Quantity();
        }

        if ($.trim($('#hdnFlag').val()) == '1') {
            ShowBaseOnQuantity();
        }



    });
    function popupprint() {
        var prtContent = document.getElementById('sample');
        //prnReport
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }

    function IsNumeric(val) {
        if (isNaN(parseFloat(val))) {
            return false;
        }
        return true
    }



    function onlyNumbers(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
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


    function isNumerics(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;

        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0) || (key == 45)) {
                    isCtrl = true;
                }
                else {
                    if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                        isCtrl = false;
                }
            }
        } return isCtrl;
    }

    function setup() {
    
        ValidationWindow(document.getElementById('hdntest').value, errorMsg);
        //end
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
        

       

</script>

<script type="text/javascript" language="javascript">

    ///*************AutoComplit List*******************/////////

    function Checkorgtext() {
        if ($("#<%=txtTrustedOrg.ClientID%>").val().length > 12) {
            $("#<%=txtTrustedOrg.ClientID%>").val("")
            $("#<%=hdnSelectedOrg.ClientID%>").val("0");
        }
        $("#<%=txtLocationorg.ClientID%>").val("")
        $("#<%=hdnSelectedLocation.ClientID%>").val("0");
        var OrgId = 0;
        var ProductId = $("#<%=hdnprodsID.ClientID%>").val();
        var SupplierId = $("#<%=hdnSupliersID.ClientID%>").val();
        var ContextInfodetails = 'Org' + '~' + OrgId + '~' + ProductId + '~' + SupplierId;
        if (ProductId != "" && ProductId != "0")
            $find('AutoTrustOrg').set_contextKey(ContextInfodetails);
        else
            $find('AutoTrustOrg').set_contextKey("");
    }

    function CheckorgLocationtext() {
        var OrgId = $("#<%=hdnSelectedOrg.ClientID%>").val();
        var ProductId = $("#<%=hdnprodsID.ClientID%>").val();
        var SupplierId = $("#<%=hdnSupliersID.ClientID%>").val();
        var ContextInfodetails = 'Location' + '~' + OrgId + '~' + ProductId + '~' + SupplierId;
        if (OrgId != "" && OrgId != "0")
            $find('AutoLocationOrg').set_contextKey(ContextInfodetails);
        else
            $find('AutoLocationOrg').set_contextKey("");
    }




    /////**********End*****************///


    //**********SupplierList *************//
    function ShowBasedOnRate(ele) {
        
        $('#chkPO_Rate').attr('checked', true);
        if ($('#chkPO_Rate').attr('checked')) {
            $('#chkBasedonQuantity').attr('checked', false);
            ShowControls();
        }
        else {
            HideControls();
        }
        $("#tblPO_Quantity_Productlist").removeClass("displaytb");
        $("#save").removeClass("hide").addClass("hide")

    }

    function ShowControls() {
        $('#spanBySupplier').css('visibility', 'visible');
        $('#DropSupplierName').show();
        //$('#chkBasedonQuantity').attr('checked', false);
        $('#divPOQuantity').hide();
        $('#divBasedOnRate').show();

        $('#tblPO_Quantity_Productlist tr td').empty();
        $('#tblProductsupplier tr td').empty();
        //$('#tblPO_Quantity_Productlist').hide();
        $('#tblPO_Quantity_Productlist').addClass("hide");
        $('#tblProductsupplier').hide();
        $('#hdnProductsupplier').val('');
        $('#btsave').attr("class", "hide");
        //document.getElementById('btsave').style.display = 'none';
        $('#tdApprove').hide();
        $('#chkSupplier').attr('checked', true);
    }

    function HideControls() {
        $('#spanBySupplier').css('visibility', 'hidden');
        $('#DropSupplierName').hide();
        //$('#chkBasedonQuantity').attr('checked', true);
        $('#divPOQuantity').show();
        $('#divBasedOnRate').hide();
        $('#tblPO_Quantity_Productlist tr td').empty();
        $('#tblProductsupplier tr td').empty();       
        //$('#tblPO_Quantity_Productlist').hide();
        $('#tblProductsupplier').hide();
        $('#hdnProductsupplier').val('');
        $('#btsave').attr("class", "hide");
        //document.getElementById('btsave').style.display = 'none';
        
        
    }

    function ShowSupplierlist() {

        $('#tblPO_Quantity_Productlist tr td').empty();
        $('#tblProductsupplier tr td').empty();
        $('#tblPO_Quantity_Productlist').addClass("hide");
        $('#tblProductsupplier').hide();
        $('#hdnProductsupplier').val('');
        $('#btsave').attr("class", "hide");
        //document.getElementById('btsave').style.display = 'none';

        if (document.getElementById('chkSupplier').checked == true) {
            document.getElementById('DropSupplierName').selectedIndex = 0;
            document.getElementById('lblprd').style.display = 'none';
            document.getElementById('txtProductName').style.display = 'none';
            document.getElementById('tbllist').style.display = 'none';
            document.getElementById('supnames').style.display = 'none';
            document.getElementById('hdunits').style.display = 'none';
            document.getElementById('hdquantity').style.display = 'none';
            document.getElementById('hdtotalQty').style.display = 'none';
            document.getElementById('hdInverseQty').style.display = 'none';
            document.getElementById('secrow').style.display = 'none';
            $('#tdlblsuppliername').attr("class", "displaytd");
            $('#tdtxtsuppliername').attr("class", "displaytd v-top");

        }
        else {

            document.getElementById('DropSupplierName').selectedIndex = 0;
            document.getElementById('lblprd').style.display = 'block';
            document.getElementById('txtProductName').style.display = 'block';
            document.getElementById('tblSupplierProductList').style.display = 'none';
            document.getElementById('trsupplieradd').style.display = 'none';
            $('#tdlblsuppliername').attr("class", "hide");
            $('#tdtxtsuppliername').attr("class", "hide v-top");

        }
    }

    function GetSupplierdetails() {
        var OrgID = '<%= OrgID %>';
        var QuotationID = 0;
        var QuotationNo = 0;
        var ddlSupplier = document.getElementById("DropSupplierName");
        var SupID = ddlSupplier.options[ddlSupplier.selectedIndex].value;
        var LocationID = document.getElementById('<%=hdnInventoryLocationID.ClientID %>').value;
        Attune.Kernel.InventoryCommon.InventoryWebService.GetSupplierMappedProducts(OrgID, SupID, QuotationID, QuotationNo, LocationID, GetListItems);
    }

    function GetListItems(lstInventoryItemslist) {
            //            document.getElementById('ProductData').style.display = 'none';
            $("#ProductData").removeClass().addClass("hide");
        document.getElementById('divSupplierProductList').style.height = "auto";
        DeletesuppliertableEntry();
        if (lstInventoryItemslist.length > 0) {
            BindSuplierProductList(lstInventoryItemslist);
        }
    }

    function DeletesuppliertableEntry() {
        document.getElementById('trsupplieradd').style.display = 'none';
        document.getElementById('tblSupplierProductList').style.display = 'table';
        while (count = document.getElementById('tblSupplierProductList').rows.length) {
            for (var j = 0; j < document.getElementById('tblSupplierProductList').rows.length; j++) {
                document.getElementById('tblSupplierProductList').deleteRow(j);
            }
        }
    }

    function checkedItems(GetcheckboxId) {
        var ComboId = GetcheckboxId.replace("ChkBtn", "comboUnit");
        var txtQuant = GetcheckboxId.replace("ChkBtn", "txtQuantity");
        var txttotalQuant = GetcheckboxId.replace("ChkBtn", "txtTotalQuantity");
        if (document.getElementById(GetcheckboxId).checked == true) {
            //document.getElementById(ComboId).disabled = false;
            document.getElementById(txtQuant).disabled = false;
        }
        else {
            document.getElementById(ComboId).disabled = true;
            document.getElementById(txtQuant).disabled = true;
            document.getElementById(txttotalQuant).disabled = true;
            document.getElementById(txtQuant).value = "";
            document.getElementById(txttotalQuant).value = ""
        }
    }

    function Cleartextboxvlaue(GetcomboId) {
        var txtQuant = GetcomboId.replace("comboUnit", "txtQuantity");
        var txttotalQuant = GetcomboId.replace("comboUnit", "txtTotalQuantity");
        var ComboInverqty = document.getElementById(GetcomboId).value;
        var txtInverQty = GetcomboId.replace("comboUnit", "lblInverseQty");
        document.getElementById(txtInverQty).innerHTML = ComboInverqty;
        document.getElementById(txtQuant).value = "";
        document.getElementById(txttotalQuant).value = ""
    }

    function BindSuplierProductList(lstInventoryItemslist) {
        document.getElementById('trsupplieradd').style.display = 'table-cell';
        var Headrow = document.getElementById('tblSupplierProductList').insertRow(0);
        var ParentProductId = "";
        var lsu = "";
        Headrow.id = "HeadID1";
        Headrow.className = "gridTDheader "
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);

        //Inserting Salescount in between InverseQty and Costprice";


        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);
        var cell8 = Headrow.insertCell(7);
        var cell9 = Headrow.insertCell(8);
        var cell10 = Headrow.insertCell(9);
        var cell11 = Headrow.insertCell(10);
        var cell12 = Headrow.insertCell(11);
        var cell13 = Headrow.insertCell(12);
        var LstDayQty = Headrow.insertCell(13);
        var LstMonthQty = Headrow.insertCell(14);
        var LstQtrQty = Headrow.insertCell(15);
        var ProductIs = Headrow.insertCell(16);

        var ProductID = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_12');
        if (ProductID == null) {
            ProductID = "Product ID";
        }

        var ProductName = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_13');
        if (ProductName == null) {
            ProductName = "Product Name";
        }

        var Unit = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_14');
        if (Unit == null) {
            Unit = "Unit";
        }

        var UnitPrice = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_15');
        if (UnitPrice == null) {
            UnitPrice = "UnitPrice";
        }

        var SellingPrice = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_16');
        if (SellingPrice == null) {
            SellingPrice = "SellingPrice";
        }

        var Tax = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_17');
        if (Tax == null) {
            Tax = "Tax";
        }

        var Discount = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_18');
        if (Discount == null) {
            Discount = "Discount";
        }

        var Quantity = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_19');
        if (Quantity == null) {
            Quantity = "Quantity";
        }

        var InverseQty = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_20');
        if (InverseQty == null) {
            InverseQty = "Inverse Qty";
        }

        var Total = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_21');
        if (Total == null) {
            Total = "Total Qty/LSU";
        }

        var QutationID = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_22');
        if (QutationID == null) {
            QutationID = "QutationID";
        }

        var StockinhandQty = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_23');
        if (StockinhandQty == null) {
            StockinhandQty = "Stockinhand Qty";
        }

        var SoldYesterDay = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_24');
        if (SoldYesterDay == null) {
            SoldYesterDay = "SoldYesterDay";
        }

        var SoldLastMonth = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_25');
        if (SoldLastMonth == null) {
            SoldLastMonth = "SoldLastMonth";
        }

        var SoldLastQuater = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_26');
        if (SoldLastQuater == null) {
            SoldLastQuater = "SoldLastQuater";
        }

        var ProductIsText = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_27');
        if (ProductIsText == null) {
            ProductIsText = "ProductIs";
        }

        cell1.innerHTML = "";
        cell2.innerHTML = ProductID;
        cell3.innerHTML = ProductName;
        cell4.innerHTML = Unit;
        cell5.innerHTML = UnitPrice;
        cell6.innerHTML = SellingPrice;
        cell7.innerHTML = Tax;
        cell8.innerHTML = Discount;
        cell9.innerHTML = Quantity;
        cell10.innerHTML = InverseQty;
        cell11.innerHTML = Total;
        cell12.innerHTML = QutationID;
        cell13.innerHTML = StockinhandQty;

        LstDayQty.innerHTML = SoldYesterDay;
        LstMonthQty.innerHTML = SoldLastMonth;
        LstQtrQty.innerHTML = SoldLastQuater;
        ProductIs.innerHTML = ProductIsText;

        cell2.style.display = 'none';
        // cell5.style.display = 'none';
        cell6.style.display = 'none';
        cell7.style.display = 'none';
        cell8.style.display = 'none';
        cell12.style.display = 'none';
        cell1.style.width = "13px";
        if (lstInventoryItemslist.length > 6) {
            document.getElementById('divSupplierProductList').style.height = "200px";
        }

        for (var i = 0; i < lstInventoryItemslist.length; i++) {
            var tblData = lstInventoryItemslist[i].Description;
            if (tblData != "") {
                var SplittblData = tblData.split('^');
                var UnitDatas = SplittblData[1];
                var Unitsplitdata = UnitDatas.split('#');
                lsu = SplittblData[0].split('~')[2];
                ParentProductId = SplittblData[0].split('~')[3];
                var row = document.getElementById('tblSupplierProductList').insertRow(1);
                row.style.height = "10px";
                row.id = "tr_par" + SplittblData[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);
                var cell13 = row.insertCell(12);

                var LstDayQty = row.insertCell(13);
                var LstMonthQty = row.insertCell(14);
                var LstQtrQty = row.insertCell(15);
                var ProductIs = row.insertCell(16);

                cell2.style.display = 'none';
                // cell5.style.display = 'none';
                cell6.style.display = 'none';
                cell7.style.display = 'none';
                cell8.style.display = 'none';
                cell12.style.display = 'none';
                cell1.align = "center";
                cell1.innerHTML = " <input id='ChkBtn_" + i + "' name='ChkBtn'  value ='" + ParentProductId + '~' + lsu + "' onclick='checkedItems(this.id);' type='checkbox'/> ";
                cell2.innerHTML = " <label id='lblProductId_" + i + "'> " + SplittblData[0].split('~')[0] + "</label>";
                cell3.innerHTML = " <label id='lblProductName_" + i + "'> " + SplittblData[0].split('~')[1] + "</label>";
                cell4.innerHTML = " <select name='combo' id='comboUnit_" + i + "' onchange='Cleartextboxvlaue(this.id);'   style='width: 100px'  disabled='true' ></select> ";
                SupplitUnitforsupplier(UnitDatas, i)
                cell5.innerHTML = Unitsplitdata[0].split('~')[1];
                cell6.innerHTML = Unitsplitdata[0].split('~')[5];
                cell7.innerHTML = Unitsplitdata[0].split('~')[7];
                cell8.innerHTML = Unitsplitdata[0].split('~')[8];
                var txtQuantity = "<input type='text'  id='txtQuantity_" + i + "' disabled='true' onblur='checkQtysupplier(this.id);' size='10' onkeydown='return isNumericss(event,this.id)' >";
                txtQuantity = txtQuantity + "<input type='hidden' value='" + SplittblData[1].split('#')[0].split("~")[10] + "' id='hdnMaximumQuantity'/>";
                cell9.innerHTML = txtQuantity;
                cell10.innerHTML = " <label id='lblInverseQty_" + i + "'> " + Unitsplitdata[0].split('~')[3] + "</label>";
                cell11.innerHTML = "<input type='text' id='txtTotalQuantity_" + i + "' disabled='true' size='10' readonly='true'  >";
                cell12.innerHTML = " <label id='lblQuotationID_" + i + "'> " + SplittblData[0].split('~')[5] + "</label>";
                cell13.innerHTML = " <label id='lblStockinhand_" + i + "'> " + SplittblData[0].split('~')[6] + "</label>";

                //                LstDayQty.innerHTML = "<span id='D" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].LastDaySaleQty + "</span>";
                //                LstMonthQty.innerHTML = "<span id='M" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].LastMonthSaleQty + "</span>";
                //                LstQtrQty.innerHTML = "<span id='Q" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].LastQtrSaleQty + "</span>";
                // ProductIs.innerHTML = "<span id='ProductIs" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].ProductIs + "</span>";

                LstDayQty.innerHTML = "<span id='D" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].StockIssued + "</span>";
                LstMonthQty.innerHTML = "<span id='M" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].StockReturn + "</span>";
                LstQtrQty.innerHTML = "<span id='Q" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].StockReceived + "</span>";
                ProductIs.innerHTML = "<span id='ProductIs" + SplittblData[0].split('~')[0] + "'>" + lstInventoryItemslist[i].ReceiptNo + "</span>";
            }

        }
    }

    function SupplitUnitforsupplier(UnitDatas, rowcount) {
        var UnitList = UnitDatas.split('#');
        var drpunits = document.getElementById('comboUnit_' + rowcount);
        drpunits.options.length = 0;
        var optn2 = document.createElement("option");
        drpunits.options.add(optn2);
        
        var Select = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11") == null ? "-----Select-----" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11")
        optn2.text = Select;
        //end
        optn2.value = "0";
        for (i = 0; i < UnitList.length; i++) {
            var res = UnitList[i].split('~')
            var optns = document.createElement("option");
            drpunits.options.add(optns);
            optns.text = res[0];
            optns.value = res[3];

            if (res[0].trim() == res[9].trim()) {
                optns.selected = true;
                drpunits.readOnly = true;
            }
        }
        if (UnitList.length == 1) {
            document.getElementById('comboUnit_' + rowcount).selectedIndex = 1;
        }
    }

    function checkQtysupplier(GettxtqtyId) {
        var ComboId = GettxtqtyId.replace("txtQuantity", "comboUnit");
        var txttotalQuant = GettxtqtyId.replace("txtQuantity", "txtTotalQuantity");
        var ComboInverqty = document.getElementById(ComboId).value;
        var Quantity = document.getElementById(GettxtqtyId).value;
        var TotalQuantity = Number(ComboInverqty) * Number(Quantity);
        var hdnmax = $("#" + GettxtqtyId).parent().parent().find("#hdnMaximumQuantity");
        var maxQty = $(hdnmax).val() != "" ? $(hdnmax).val() : "0";
        var MaxOrderedQty = Number(maxQty) / Number(ComboInverqty);
        if (maxQty < TotalQuantity && maxQty != "0") {
            var userMsg = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_23') == null ? "Maximum Purchase Ordere Quantity is" : SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_23');
            ValidationWindow(userMsg + MaxOrderedQty,errorMsg);
            $("#" + GettxtqtyId).val("");
            $("#" + GettxtqtyId).focus();
        }
        else {
        document.getElementById(txttotalQuant).value = TotalQuantity;
        }
    }
    function createsupplierproductlist() {
        document.getElementById('divSupplierProductList').style.height = "auto"; ///div collapse
        document.getElementById('tblProductsupplier').style.display = 'table'
//            document.getElementById('ProductData').style.display = 'none';
         $("#ProductData").removeClass().addClass("hide");
        var tbsubprolist = document.getElementById('tblSupplierProductList');
        var tbcount = tbsubprolist.rows.length;
        var parentproductid = "";
        var checkcount = 0;
        for (var i = 1; i < tbcount; i++) {
            var j = i - 1;
            var objchk = document.getElementById('ChkBtn_' + j);
            if (objchk.checked == true) {
                checkcount = 1;
                var drpunits = document.getElementById('comboUnit_' + j).options[document.getElementById('comboUnit_' + j).selectedIndex].text;
                var drpunitsval = 0;
                var suppliername = document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].text;
                var supid = document.getElementById('DropSupplierName').options[document.getElementById('DropSupplierName').selectedIndex].value;
                var ProductName = document.getElementById('lblProductName_' + j).innerHTML;
                var comments = "";
                var pdate = document.getElementById('txtPurchaseOrderDate').value;
                var quantity = document.getElementById('txtQuantity_' + j).value.trim();
                var Productid = $.trim(document.getElementById('lblProductId_' + j).innerHTML);
                var tolQty = document.getElementById('txtTotalQuantity_' + j).value;
                var InvQty = document.getElementById('lblInverseQty_' + j).innerHTML;
                var QuotationID = document.getElementById('lblQuotationID_' + j).innerHTML;
                var StockinhandQty = document.getElementById('lblStockinhand_' + j).innerHTML;
                var LstDayQty = $('#D' + Productid).html();
                var LstMonthQty = $('#M' + Productid).html();
                var LstQtrQty = $('#Q' + Productid).html();
                var ProductIs = $('#ProductIs' + Productid).html();

                if (quantity == "" || Number(quantity) == 0) {
                    
                    var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03") == null ? "Provide the Quantity" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03")
                    ValidationWindow(userMsg, errorMsg);
//                    var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_03');
//                    var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                    if (userMsg != null && errorMsg != null) {
//                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtQuantity_' + j).focus();
//                    }
//                    else {
//                        document.getElementById('txtQuantity_' + j).focus();
//                        ValidationWindow('Provide the Quantity', 'Error');
//                    }
                    return false;
                    document.getElementById('txtQuantity_' + j).focus();
                }
                if (document.getElementById('comboUnit_' + j).value == '0') {
                    
                    var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_02") == null ? "Select the  Units" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_02")
                    ValidationWindow(userMsg, errorMsg);
//                    var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_02');
//                    var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                    if (userMsg != null && errorMsg != null) {
//                        ValidationWindow(userMsg, errorMsg);
//                    }
//                    else {
//                        ValidationWindow('Select the  Units ', 'Error');
                    //                    }
//end
                    document.getElementById('comboUnit_' + j).focus();
                    return false;
                }
                var lsu = objchk.value.split('~')[1];
                var supplierid = supid
                parentproductid = objchk.value.split('~')[0];
                var rwNumber = j;
                var AddStatus = "0";
                $('#btsave').attr("class", "displaytd");
                // document.getElementById('btsave').style.display = 'table-cell';
                var HidValue = document.getElementById('hdnProductsupplier').value;
                var list = HidValue.split('^');
                if (document.getElementById('hdnProductsupplier').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var ProductSupplierList = list[count].split('~');
                        if (ProductSupplierList[1] != '') {
                            if (ProductSupplierList[0] != '') {
                                rwNumber = parseInt(parseInt(ProductSupplierList[0]) + parseInt(1));
                            }
                            if (ProductName != '') {
                                if (ProductSupplierList[1] == ProductName) {
                                    if (ProductSupplierList[2] == suppliername) {
                                        AddStatus = 1;
                                    }
                                }
                            }
                        }
                    }
                }
                if (AddStatus == "0") {
                    objchk.checked = false;
                    checkedItems(objchk.id)
                    var row = document.getElementById('tblProductsupplier').insertRow(1);
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);

                    var lstDayQty = row.insertCell(7);
                    var lstMonthQty = row.insertCell(8);
                    var lstQtrQty = row.insertCell(9);
                    var productis = row.insertCell(10);
                    var cell8 = row.insertCell(11);

                    cell1.innerHTML = "<b>" + ProductName + "</b> ";
                    cell1.width = "25%";
                    cell2.innerHTML = "<b>" + suppliername + "</b> ";
                    cell2.width = "23%";
                    cell3.innerHTML = "<b>" + quantity + "</b> ";
                    cell3.width = "7%";

                    cell4.innerHTML = "<b>" + drpunits + "</b> ";
                    cell4.width = "7%";

                    cell5.innerHTML = "<b>" + InvQty + "</b> ";
                    cell5.width = "7%";

                    cell6.innerHTML = "<b>" + tolQty + "(" + lsu + ")" + "</b> ";
                    cell6.width = "7%";

                    cell7.innerHTML = "<b>" + StockinhandQty + "</b> ";
                    cell7.width = "11%";

                    lstDayQty.innerHTML = "<b>" + LstDayQty + "</b>";
                    lstMonthQty.innerHTML = "<b>" + LstMonthQty + "</b>";
                    lstQtrQty.innerHTML = "<b>" + LstQtrQty + "</b>";
                    productis.innerHTML = "<b>" + ProductIs + "</b>";
                    productis.width = "8%";
                    cell8.innerHTML = "<input id='imgbtn' name='delete' OnClick='ImgOnclickClient1(" + rwNumber + ");' type='button' class='ui-icon ui-icon-trash b-none pointer pull-left marginL5'  />"

                    cell8.width = "1%";


                    document.getElementById('hdnProductsupplier').value += rwNumber + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationID + "~" + StockinhandQty +"~"+drpunitsval + "^";

                }
                else {
                    
                    var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_04") == null ? "Attribute already added" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_04")
                    ValidationWindow(userMsg, errorMsg);
//                    var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_04');
//                    var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                    if (userMsg != null && errorMsg != null) {
//                        ValidationWindow(userMsg, errorMsg);
//                        return false;
//                    }
//                    else {
//                        ValidationWindow('Attribute already added', 'Error');
//                        return false;
                    //                    }
//end
                }
            }
        }
        if (checkcount == 1) {
            DeletesuppliertableEntry();
            document.getElementById('DropSupplierName').selectedIndex = 0;
        }
        else {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_05") == null ? "Please select the atleast one product" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_05")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_05');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Please select the atleast one product', 'Error');
//                return false;
            //            }
//end
        }
    }
    function isNumericss(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }

    //**********End*****************//


    function validateorg() {
        if (document.getElementById('ddlTrustedOrg').value == 0) {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_06") == null ? "select the organisation" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_06")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_06');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {

//                ValidationWindow('select the organisation', 'Error');
//                return false;
            //            }
//end
            document.getElementById('ddlTrustedOrg').focus();
            return false;
        }
    }
    function pSetfocus() {
        document.getElementById('txtProduct').value = '';
        document.getElementById('txtProduct').focus();
        return;
    }
    function supbasedunits() {

        var ddlSupplierList = document.getElementById('ddlSupplierList').value;
        var splt = document.getElementById('hdnconvesrsiondata').value;
        var drpunits = document.getElementById('drpunits');
        drpunits.options.length = 0;
        var optn2 = document.createElement("option");
        drpunits.options.add(optn2);
        optn2.text = "-Select-";
        optn2.value = "0";
        var t = splt.split('^');
        for (i = 0; i < t.length; i++) {
            var list1 = t[i].split('#');
            if (t[i] != "") {
                var supplier = list1[0].split('~');
                for (j = 1; j < list1.length; j++) {

                    var res = list1[j].split('~')
                    if (list1[j] != "" && res[0] != "SQ") {
                        if (supplier[2] == ddlSupplierList) {
                            var optns = document.createElement("option");
                            drpunits.options.add(optns);
                            optns.text = res[0];
                            optns.value = res[0];
                            if (res[0].trim() == res[8].trim()) {
//                                optns.selected = true;
//                                drpunits.disabled = true;
                                ConvertData();
                            }
                        }
                    }
                }
            }
        }
    }
    function ConvertData() {
        var drpunits = document.getElementById('drpunits').value.split("~")[0];
        var drpunitsval = 0;
        var pid = document.getElementById('hdnProductId').value
        var splt = document.getElementById('hdnconvesrsiondata').value;
        var ddlSupplier = document.getElementById('ddlSupplierList').value;
        var t = splt.split('^');
        for (i = 0; i < t.length; i++) {
            var list1 = t[i].split('#');
            if (t[i] != "") {
                var product = list1[0].split('~');
                for (j = 1; j < list1.length; j++) {

                    var res = list1[j].split('~')


                    if (product[0] == pid && res[0] == drpunits && product[2] == ddlSupplier) {
                        document.getElementById('hdnInverseQty').value = res[3];

                    }
                }
            }
        }
        checkQty();
    }
  

    function checkQty() {
        var pqty = document.getElementById('txtquantity').value;
        var pinvqty = document.getElementById('hdnInverseQty').value;
        document.getElementById('txtInverQty').value = pinvqty;
        document.getElementById('txtTotalQty').value = Number(pqty) * Number(pinvqty);
    }

    function Checkvalue() {
        if (document.getElementById('hdnProductsupplier').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_07") == null ? "Please Fill the Purchase order details" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_07")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_07');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Please Fill the Purchase order details', 'Error');
//                return false;
            //            }
//end
            document.getElementById('txtProductName').focus();
            return false;
        }
    }
    function createClienttab() {

        if (document.getElementById('txtPurchaseOrderDate').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_08") == null ? "Provide the Purchase Order Date" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_08")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_08');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Provide the Purchase Order Date', 'Error');
//                return false;
            //            }
//end
            document.getElementById('txtProductName').focus();
            return false;
        }
        if (document.getElementById('txtProductName').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09") == null ? "Provide the Product Name" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_09');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Provide the Product Name', 'Error');
//                return false;
            //            }
//end
            document.getElementById('txtProductName').focus();
            return false;
        }
        var ddlaction = document.getElementById('ddlSupplierList');
        var Select = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
        if (Select == null) {
            Select = '-----Select-----';
        }
        if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_10") == null ? "Select The Supplier Name" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_10")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_10');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Select The Supplier Name ', 'Error');
//                return false;
            //            }
//end
        }
        if (document.getElementById('txtquantity').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11") == null ? "Provide the Quantity" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {

//                ValidationWindow('Provide the Quantity', 'Error');
//                return false;
            //            }
//end
            document.getElementById('txtProductName').focus();
            return false;
        }
        if (document.getElementById('drpunits').value == '0') {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_12") == null ? "Select the Units" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_12")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_12');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Select the Units ', 'Error');
//                return false;
            //            }
//end
            document.getElementById('drpunits').focus();
            return false;
        }
        var j = 1;
            //            document.getElementById('ProductData').style.display = 'none';
           $("#ProductData").removeClass().addClass("hide");
           var drpunits = document.getElementById('drpunits').value.split("~")[0];
           var drpunitsval = document.getElementById('ddlPOUnits').value.split("~")[1];
        var suppliername = document.getElementById('ddlSupplierList').options[document.getElementById('ddlSupplierList').selectedIndex].text;

        var supid = document.getElementById('ddlSupplierList').options[document.getElementById('ddlSupplierList').selectedIndex].value;
        var AddStatus = 0;
        var ProductName = document.getElementById('txtProductName').value;

        var comments = "";
        var pdate = document.getElementById('txtPurchaseOrderDate').value;
        var quantity = document.getElementById('txtquantity').value;
        var Productid = document.getElementById('hdnProductId').value;
        var tolQty = document.getElementById('txtTotalQty').value;
        var lsu = document.getElementById('hdnLSU').value;
        var InvQty = document.getElementById('txtInverQty').value;
        var QuotationId = document.getElementById('hdnQuotationId').value;
        var StockinhandQty = document.getElementById('hdnStockinhandQty').value;

        var LstDayQty = $('#hdnLstDayQty').val();
        var LstMonthQty = $('#hdnLstMonthQty').val();
        var LstQtrQty = $('#hdnLstQtrQty').val();
        var ProductIs = $('#hdnProductIs').val();


        var supplierid = supid
        var parentproductid = document.getElementById('hdnparentprodutid').value;
        var rwNumber = j;
        $('#btsave').attr("class", "displaytd");
        //document.getElementById('btsave').style.display = 'table-cell';
        var HidValue = document.getElementById('hdnProductsupplier').value;

        var list = HidValue.split('^');

        if (document.getElementById('hdnProductsupplier').value != "") {
            for (var count = 0; count < list.length; count++) {
                var ProductSupplierList = list[count].split('~');
                if (ProductSupplierList[1] != '') {

                    if (ProductSupplierList[0] != '') {
                        rwNumber = parseInt(parseInt(ProductSupplierList[0]) + parseInt(1));
                    }
                    if (ProductName != '') {
                        if (ProductSupplierList[1] == ProductName) {
                            if (ProductSupplierList[2] == suppliername) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
        }
        else {

            if (ProductName != '') {
                var row = document.getElementById('tblProductsupplier').insertRow(1);
                row.id = rwNumber;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var lstdayQty = row.insertCell(7);
                var lstMonthQty = row.insertCell(8);
                var lstQtrQty = row.insertCell(9);
                var productIs = row.insertCell(10);
                var cell8 = row.insertCell(11);

                cell1.innerHTML = "<b>" + ProductName + "</b> ";
                cell1.width = "25%";
                cell2.innerHTML = "<b>" + suppliername + "</b> ";
                cell2.width = "23%";
                cell3.innerHTML = "<b>" + quantity + "</b> ";
                cell3.width = "15%";

                cell4.innerHTML = "<b>" + drpunits + "</b> ";
                cell4.width = "15%";
                cell5.innerHTML = "<b>" + InvQty + "</b> ";
                cell5.width = "15%";


                cell6.innerHTML = "<b>" + tolQty + "(" + lsu + ")" + "</b> ";
                cell6.width = "15%";
                cell7.innerHTML = "<b>" + StockinhandQty + "</b> ";
                cell7.width = "15%";



                cell8.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + rwNumber + ");' type='button' class='ui-icon ui-icon-trash b-none pointer pull-left marginL5' />";
                cell8.width = "1%";

                lstdayQty.innerHTML = "<b>" + LstDayQty + "</b>";
                lstMonthQty.innerHTML = "<b>" + LstMonthQty + "</b>";
                lstQtrQty.innerHTML = "<b>" + LstQtrQty + "</b>";
                productIs.innerHTML = "<b>" + ProductIs + "</b>";


                document.getElementById('hdnProductsupplier').value += rwNumber + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty+"~"+drpunitsval + "^";
                AddStatus = 2;

                clears();

                j++;
            }
            else {
                
                var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13") == null ? "Provide attribute to add" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13")
                ValidationWindow(userMsg, errorMsg);
//                var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_13');
//                var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;
//                }
//                else {
//                    ValidationWindow('Provide attribute to add', 'Error');
//                    return false;
                //                }
//end
            }
        }
        if (AddStatus == 0) {
            if (ProductName != '') {
                var row = document.getElementById('tblProductsupplier').insertRow(1);

                row.id = rwNumber;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var lstdayQty = row.insertCell(7);
                var lstMonthQty = row.insertCell(8);
                var lstQtrQty = row.insertCell(9);
                var productIs = row.insertCell(10);
                var cell8 = row.insertCell(11);


                cell1.innerHTML = "<b>" + ProductName + "</b> ";
                cell1.width = "25%";
                cell2.innerHTML = "<b>" + suppliername + "</b> ";
                cell2.width = "23%";
                cell3.innerHTML = "<b>" + quantity + "</b> ";
                cell3.width = "15%";

                cell4.innerHTML = "<b>" + drpunits + "</b> ";
                cell4.width = "15%";

                cell5.innerHTML = "<b>" + InvQty + "</b> ";
                cell5.width = "15%";

                cell6.innerHTML = "<b>" + tolQty + "(" + lsu + ")" + "</b> ";
                cell6.width = "15%";

                cell7.innerHTML = "<b>" + StockinhandQty + "</b> ";
                cell7.width = "15%";

                lstdayQty.innerHTML = "<b>" + LstDayQty + "</b>";
                lstMonthQty.innerHTML = "<b>" + LstMonthQty + "</b>";
                lstQtrQty.innerHTML = "<b>" + LstQtrQty + "</b>";
                productIs.innerHTML = "<b>" + ProductIs + "</b>";

                cell8.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                cell8.width = "1%";

                j++;
                document.getElementById('hdnProductsupplier').value += rwNumber + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty +"~"+drpunitsval+ "^";

                clears();



            }
            else {
                
                var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13") == null ? "Provide attribute to add" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13")
                ValidationWindow(userMsg, errorMsg);
//                var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_13');
//                var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;
//                }
//                else {
//                    ValidationWindow('Provide attribute to add', 'Error');
//                    return false;
                //                }
//end

            }
        }
        else if (AddStatus == 1) {
        
        var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_14") == null ? "Attribute already added" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_14")
        ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_14');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Attribute already added');
//                return false;
        //            }
//end
        }

        return;
    }
    function clears() {
        document.getElementById('tblProductsupplier').style.display = 'table'
        document.getElementById('hdnProductId').value = '';
        document.getElementById('hdnsupplierID').value = '';
        document.getElementById('txtquantity').value = '';
        document.getElementById('hdnInverseQty').value = 0;
        document.getElementById('txtTotalQty').value = '';
        document.getElementById('txtProductName').focus();
        document.getElementById('hdnLSU').value = "";
        document.getElementById('txtInverQty').value = '';
        document.getElementById('hdnStockinhandQty').value = '0';

        document.getElementById('txtProductName').value = '';

        document.getElementById('ddlPOUnits').selectedIndex = 0;
        document.getElementById('ddlSupplierList').selectedIndex = 0;
        if (document.getElementById('txtProductName').value == "") {
            document.getElementById('tbllist').style.display = "none";

            while (count = document.getElementById('tbllist').rows.length) {

                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
        }
    }
    function ImgOnclickClient1(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('hdnProductsupplier').value;
        var list = HidValue.split('^');
        var NewHealthCheckupList = '';
        if (document.getElementById('hdnProductsupplier').value != "") {
            for (var count = 0; count < list.length; count++) {
                var HealthCheckupList = list[count].split('~');
                if (HealthCheckupList[0] != '') {
                    if (HealthCheckupList[0] != ImgID) {
                        NewHealthCheckupList += list[count] + '^';
                    }
                }
            }
            document.getElementById('hdnProductsupplier').value = NewHealthCheckupList;
        }
        if (document.getElementById('hdnProductsupplier').value == '') {
            document.getElementById('hdnProductsupplier').style.display = 'none';
        }

    }



    function ShowBaseOnQuantity() {

        $("#save").removeClass("hide");
        $('#chkBasedonQuantity').attr('checked', true);
        if ($('#chkBasedonQuantity').attr('checked')) {
            $('#chkPO_Rate').attr('checked', false);
            HideControls();

        }
        else {
            $('#chkPO_Rate').attr('checked', true);
            ShowControls();

        }
        if (document.getElementById('chkSupplier').checked == true) {
            document.getElementById('DropSupplierName').selectedIndex = 0;
            document.getElementById('lblprd').style.display = 'none';
            document.getElementById('txtProductName').style.display = 'none';
            document.getElementById('tbllist').style.display = 'none';
            document.getElementById('supnames').style.display = 'none';
            document.getElementById('hdunits').style.display = 'none';
            document.getElementById('hdquantity').style.display = 'none';
            document.getElementById('hdtotalQty').style.display = 'none';
            document.getElementById('hdInverseQty').style.display = 'none';
            document.getElementById('secrow').style.display = 'none';
            $('#tdlblsuppliername').attr("class", "displaytd");
            $('#tdtxtsuppliername').attr("class", "displaytd v-top");
        }
        else {

            document.getElementById('DropSupplierName').selectedIndex = 0;
            document.getElementById('lblprd').style.display = 'block';
            document.getElementById('txtProductName').style.display = 'block';
            document.getElementById('tblSupplierProductList').style.display = 'none';
            document.getElementById('trsupplieradd').style.display = 'none';
            $('#tdlblsuppliername').attr("class", "hide");
            $('#tdtxtsuppliername').attr("class", "hide v-top");
        }
    }


    function GetSupplierdetailsPOQuantity() {
        var OrgID = '<%= OrgID %>';
        var QuotationID = 0;
        var QuotationNo = 0;
        var ddlSupplier = document.getElementById("ddl_PO_QuantitySupplier");
        var SupID = ddlSupplier.options[ddlSupplier.selectedIndex].value;

        if (SupID > 0) {
            $("#divPO_Details").show();
            document.getElementById('txt_PO_Quantity_ProductName').value = '';
            document.getElementById('txt_PO_Quantity_Comment').value = '';
            document.getElementById('txt_PO_Quantity_ProductName').focus();
        }
        else {
            $("#divPO_Details").hide();
        }
        var LocationID = document.getElementById('<%=hdnInventoryLocationID.ClientID %>').value;
    }

    function checkPO_Quantity() {
        var pqty = document.getElementById('txtPOQuantity').value == "" ? 0 : document.getElementById('txtPOQuantity').value;
        if (pqty == 0) {
            document.getElementById('txtPOQuantity').focus();
            return false;
        }
        return true;
    }

    /// ------------------------------PO Edit ophtion
    function CheckItem_PO_Quantity_Table() {

        if (document.getElementById('txt_PO_Quantity_ProductName').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09") == null ? "Provide the Product Name" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_09');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                document.getElementById('txt_PO_Quantity_ProductName').focus();
//                return false;
//            }
//            else {
               // ValidationWindow('Provide the Product Name', 'Error');
                document.getElementById('txt_PO_Quantity_ProductName').focus();
//                return false;
                //            }
//end
        }
        var ddlaction = document.getElementById('ddlPOUnits');
        var Select = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
        if (Select = null) {
            Select = '--Select--';
        }
        if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16") == null ? "Select PO Unit" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_16');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                document.getElementById('ddlPOUnits').focus();
//                return false;
//            }
//            else {
//                ValidationWindow('Select PO Unit ', 'Error');
                document.getElementById('ddlPOUnits').focus();
//                return false;
                //            }
//end
        }
        if (document.getElementById('txtPOQuantity').value.trim() == "" || document.getElementById('txtPOQuantity').value.trim() == "0") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03") == null ? "Provide the Quantity" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03")
            ValidationWindow(userMsg, errorMsg);
            return false;
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_03');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//            else {
//                ValidationWindow('Provide the Quantity', 'Error');
//                // document.getElementById('txtPOQuantity').focus();
//                return false;
            //            }
//end
        }
        
        var upd = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29") == null ? "Update" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29")
        if (document.getElementById('btnPO_Quantity_Add').value != upd) {
        //end
            var x = document.getElementById('hdnProductsupplier').value.split("^");
            var pid = document.getElementById('hdnProductId').value;
            var pName = document.getElementById('txt_PO_Quantity_ProductName').value;
            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[0] == pid) {
                        
                        var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_17") == null ? "Product combination already exist" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_17")
                        ValidationWindow(userMsg, errorMsg);
//                        var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_17');
//                        var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                        if (userMsg != null && errorMsg != null) {
//                            ValidationWindow(userMsg, errorMsg);

//                        }
//                        else {
//                            ValidationWindow('Product combination already exist', 'Error');
                        //                        }
//end
                        document.getElementById('txt_PO_Quantity_ProductName').value = '';
                        document.getElementById('txt_PO_Quantity_ProductName').focus();
                        ClearItem_POQuantity();
                        return false;
                    }
                }
            }
        }

        // BindProductList();
        return true;

    }

    function btnOnFocus() {

        if (CheckItem_PO_Quantity_Table()) {
            BindProductList();
                if (GetParameterValues("PONo") == undefined) {
                    $('#tblPO_Quantity_Productlist').removeClass().addClass("displaytb w-100p gridView");
            $('#btsave').removeClass().addClass("displaytd");
            $('#btnDraft').removeClass().addClass("btn show");
                }
        } 
    }


    function BindProductList() {
    
        var upd = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29") == null ? "Update" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29")
        if (document.getElementById('btnPO_Quantity_Add').value == upd) {
        //end
            DeleteQtyrows();
        }
        else {
            var drpunits = document.getElementById('ddlPOUnits').value.split("~")[0];
            var drpunitsval = document.getElementById('ddlPOUnits').value.split("~")[1];
            var suppliername = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].text;
            var supid = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].value;
            var ProductName = document.getElementById('txt_PO_Quantity_ProductName').value;
            var comments = document.getElementById('txt_PO_Quantity_Comment').value;
            var pdate = document.getElementById('txtPurchaseOrderDate').value;
            var quantity = document.getElementById('txtPOQuantity').value;
            var Productid = document.getElementById('hdnProductId').value;
            var tolQty = 0;
            var lsu = '';
            var InvQty = 0;
            var QuotationId = 0;
            var StockinhandQty = $('#hdnStockinhandQty').val();
            var supplierid = supid
            var parentproductid = document.getElementById('hdnparentprodutid').value;
            var pDay = $('#hdnPO_Quantity_Day').val();
            var pMonth = $('#hdnPO_Quantity_Month').val();
            var pQuater = $('#hdnPO_Quantity_Quater').val();
            var pNew = $('#hdnPO_Quantity_New').val();

            document.getElementById('hdnProductsupplier').value += Productid + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty + "~" + pDay + "~" + pMonth + "~" + pQuater + "~" + pNew + "~" + drpunitsval + "~" + OrderedUnitValues + "^";
            PO_QuantityTblist();

            document.getElementById('txtPOQuantity').value = '';


        }
        
        var Add = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03") == null ? "Add" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_03")
        document.getElementById('btnPO_Quantity_Add').value = Add;
        //end
        document.getElementById('txt_PO_Quantity_ProductName').value = '';


        return false;
    }


    function btnEditQty_OnClick(sEditedData) {
        //   debugger;

        var y = sEditedData.split('~');
        document.getElementById('txt_PO_Quantity_ProductName').value = y[1];
        document.getElementById('txt_PO_Quantity_ProductName').value = y[1];
        document.getElementById('txtPOQuantity').value = y[4];
        document.getElementById('ddlPOUnits').value = y[5]+"~"+y[19];
        document.getElementById('hdnProductId').value = y[0];
        document.getElementById('hdnparentprodutid').value = y[10];
        document.getElementById('hdnStockinhandQty').value = y[14];
        document.getElementById('txt_PO_Quantity_Stockinhand').value = y[14];
        //          $('#txt_PO_Quantity_Stockinhand').val(y[14]);
        //        $('#txt_PO_Qty_LastDayQtyValue').text(y[15]);
        //        $('#txt_PO_Qty_LastMonthValue').text(val[16]);
        //        $('#txt_PO_Qty_LastQuaterValue').text(val[17]);
        //        $('#lbl_PO_Qty_NewValue').text(val[18]);
        //        $('#hdnPO_Quantity_Day').val(val[15]);
        //        $('#hdnPO_Quantity_Month').val(val[16]);
        //        $('#hdnPO_Quantity_Quater').val(val[17]);
        //        $('#hdnPO_Quantity_New').val(val[18]);

        document.getElementById('txt_PO_Qty_LastDayQtyValue').value = y[15];
        document.getElementById('txt_PO_Qty_LastMonthValue').value = y[16];
        document.getElementById('txt_PO_Qty_LastQuaterValue').value = y[17];
        document.getElementById('lbl_PO_Qty_NewValue').innerHTML = y[18];
        document.getElementById('hdnPO_Quantity_Day').value = y[15];
        document.getElementById('hdnPO_Quantity_Month').value = y[16];
        document.getElementById('hdnPO_Quantity_Quater').value = y[17];
        document.getElementById('hdnPO_Quantity_New').value = y[18];
        document.getElementById('hdnRowEdit').value = sEditedData;
        OrderedUnitValues=y[20];
        ConvertOrderUnitList(OrderedUnitValues, y[5]);
        
        var upd = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29") == null ? "Update" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29")
        document.getElementById('btnPO_Quantity_Add').value = upd;
        //end

    }


    function btnDeleteQty(sEditedData) {
        //debugger;
        var i;
        var x = document.getElementById('hdnProductsupplier').value.split("^");
        document.getElementById('hdnProductsupplier').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    // if (x[i].split('~')[0] != sEditedData[1] && x[i].split('~')[2] != sEditedData[2] && x[i].split('~')[4]!= sEditedData[4] && x[i].split('~')[5] != sEditedData[5] && x[i].split('~')[7] != sEditedData[7] && x[i].split('~')[10] != sEditedData[10] ) {
                    document.getElementById('hdnProductsupplier').value += x[i] + "^";
                }
            }
        }
        // btnEditQty_OnClick(sEditedData);
        PO_QuantityTblist();
    }

    function DeleteQtyrows() {
        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductsupplier').value.split("^");
        if (RowEdit != "") {
            var drpunits = document.getElementById('ddlPOUnits').value.split("~")[0];
            var drpunitsval = document.getElementById('ddlPOUnits').value.split("~")[1];
            var suppliername = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].text;
            var supid = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].value;
            var ProductName = document.getElementById('txt_PO_Quantity_ProductName').value;
            var comments = document.getElementById('txt_PO_Quantity_Comment').value;
            var pdate = document.getElementById('txtPurchaseOrderDate').value;
            var quantity = document.getElementById('txtPOQuantity').value;
            var Productid = document.getElementById('hdnProductId').value;
            var tolQty = 0;
            var lsu = '';
            var InvQty = 0;
            var QuotationId = 0;
            var StockinhandQty = $('#hdnStockinhandQty').val();
            var supplierid = supid
            var parentproductid = document.getElementById('hdnparentprodutid').value;
            var pDay = $('#hdnPO_Quantity_Day').val();
            var pMonth = $('#hdnPO_Quantity_Month').val();
            var pQuater = $('#hdnPO_Quantity_Quater').val();
            var pNew = $('#hdnPO_Quantity_New').val();

            document.getElementById('hdnProductsupplier').value = Productid + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty + "~" + pDay + "~" + pMonth + "~" + pQuater + "~" + pNew + "~" + drpunitsval + "~" + OrderedUnitValues + "^";


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        //if (x[i].split('~')[1] != RowEdit[1] && x[i].split('~')[2] != RowEdit[2] && x[i].split('~')[4] != RowEdit[4] && x[i].split('~')[5] != RowEdit[5] && x[i].split('~')[7] != RowEdit[7] && x[i].split('~')[10] != RowEdit[10]) {
                        document.getElementById('hdnProductsupplier').value += x[i] + "^";
                    }
                }
            }
            document.getElementById('hdnRowEdit').value = '';
            PO_QuantityTblist();
            document.getElementById('txtPOQuantity').value = '';

        }
    }




    function PO_QuantityTblist() {

        var rowCount = document.getElementById('tblPO_Quantity_Productlist').rows.length;
        $('#tblPO_Quantity_Productlist tr.RowSeq').remove();


        if ($('#hdnLoadProductsupplier').val() == '') {
            $('#btsave').attr("class", "displaytd");
            //document.getElementById('btsave').style.display = 'block';
        }
        else {
            $('#btsave').attr("class", "hide");
            //document.getElementById('btsave').style.display = 'none';
        }


        var x = document.getElementById('hdnProductsupplier').value.split("^");
        var pCount = x.length;
        pCount = pCount - 1;
            //            document.getElementById('ProductData').style.display = 'none';
            $("#ProductData").removeClass().addClass("hide");
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
//                    document.getElementById('tblPO_Quantity_Productlist').style.display = 'table';
                    $("#tblPO_Quantity_Productlist").removeClass().addClass("displaytb w-100p gridView");
                var row = document.getElementById('tblPO_Quantity_Productlist').insertRow(1);
                row.style.height = "13px";
                row.className = 'RowSeq';
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);


                cell1.innerHTML = pCount;
                cell2.innerHTML = y[1];
                cell3.innerHTML = y[5];
                cell4.innerHTML = y[4];
                cell5.innerHTML = y[14];
                cell6.innerHTML = parseFloat(y[15]).toFixed(2);
                cell7.innerHTML = y[16];
                cell8.innerHTML = y[17];
                cell9.innerHTML = y[18];
                var pAction = "";

                pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "' onclick='btnEditQty_OnClick(name);' value = '' type='button' title='Click to Edit' class='ui-icon ui-icon-pencil b-none pointer pull-left marginR10' /> " +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "' onclick='btnDeleteQty(name);' value = '' type='button' title='Click to Delete' class='ui-icon ui-icon-trash b-none pointer pull-left'  />"
                 cell10.innerHTML = pAction;

            }
            pCount = pCount - 1;
        }
        document.getElementById('txt_PO_Quantity_ProductName').value = '';
        document.getElementById('hdnProductId').value = '0';
        document.getElementById('hdnProductId').value = '0';
        document.getElementById('txt_PO_Qty_LastDayQtyValue').value = '';
        document.getElementById('txt_PO_Qty_LastMonthValue').value = '';
        document.getElementById('txt_PO_Qty_LastQuaterValue').value = '';
        document.getElementById('lbl_PO_Qty_NewValue').innerHTML = '';
        document.getElementById('hdnPO_Quantity_Day').value = '0';
        document.getElementById('hdnPO_Quantity_Month').value = '0';
        document.getElementById('hdnPO_Quantity_Quater').value = '0';
        document.getElementById('hdnPO_Quantity_New').value = '';
        document.getElementById('txtPOQuantity').value = '';
        document.getElementById('txt_PO_Quantity_ProductName').focus();
        document.getElementById('hdnStockinhandQty').value = '0';
        document.getElementById('txt_PO_Quantity_ProductName').value = '';
        document.getElementById('txt_PO_Quantity_Stockinhand').value = '';
        $('#hdnStockinhandQty').val('0');
        document.getElementById('ddlPOUnits').selectedIndex = 0;


    }

    function ClearItem_POQuantity() {
        document.getElementById('txt_PO_Quantity_ProductName').value = '';
        document.getElementById('hdnProductId').value = '0';
        document.getElementById('hdnProductId').value = '0';
        document.getElementById('txt_PO_Qty_LastDayQtyValue').value = '';
        document.getElementById('txt_PO_Qty_LastMonthValue').value = '';
        document.getElementById('txt_PO_Qty_LastQuaterValue').value = '';
        document.getElementById('lbl_PO_Qty_NewValue').innerHTML = '';
        document.getElementById('hdnPO_Quantity_Day').value = '0';
        document.getElementById('hdnPO_Quantity_Month').value = '0';
        document.getElementById('hdnPO_Quantity_Quater').value = '0';
        document.getElementById('hdnPO_Quantity_New').value = '';
        document.getElementById('txtPOQuantity').value = '';
        document.getElementById('txt_PO_Quantity_ProductName').focus();
        document.getElementById('hdnStockinhandQty').value = '0';
        document.getElementById('txt_PO_Quantity_ProductName').value = '';
        document.getElementById('txt_PO_Quantity_Stockinhand').value = '';
        $('#hdnStockinhandQty').val('0');
        document.getElementById('ddlPOUnits').selectedIndex = 0;




    }










    //--------------------------------------------- 

    function create_PO_Quantity_Table() {

        if (document.getElementById('txt_PO_Quantity_ProductName').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09") == null ? "Provide the Product Name" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_09');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);

//            }
//            else {
//                ValidationWindow('Provide the Product Name', 'Error');
            //            }
//end
            document.getElementById('txt_PO_Quantity_ProductName').focus();
            return false;
        }
        var ddlaction = document.getElementById('ddlPOUnits');
        var Select = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
        if (Select == null) {
            Select = '--Select--';
        }
        if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16") == null ? "Select PO Unit" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_16');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);

//            }
//            else {
//                ValidationWindow('Select PO Unit ', 'Error');
            //            }
//end
            document.getElementById('ddlPOUnits').focus();
            return false;
        }
        if (document.getElementById('txtPOQuantity').value.trim() == "" || document.getElementById('txtPOQuantity').value.trim() == "0") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11") == null ? "Provide the Quantity" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);

//            }
//            else {
//                ValidationWindow('Provide the Quantity', 'Error');
            //            }
//end
            // document.getElementById('txtPOQuantity').focus();
            return false;
        }

        var j = 1;
//            document.getElementById('ProductData').style.display = 'none';
            $("#ProductData").removeClass().addClass("hide");
            var drpunits = document.getElementById('ddlPOUnits').value.split("~")[0];
            var drpunitsval = document.getElementById('ddlPOUnits').value.split("~")[1];
        var suppliername = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].text;

        var supid = document.getElementById('ddl_PO_QuantitySupplier').options[document.getElementById('ddl_PO_QuantitySupplier').selectedIndex].value;
        var AddStatus = 0;
        var ProductName = document.getElementById('txt_PO_Quantity_ProductName').value;

        var comments = document.getElementById('txt_PO_Quantity_Comment').value;
        var pdate = document.getElementById('txtPurchaseOrderDate').value;
        var quantity = document.getElementById('txtPOQuantity').value;
        var Productid = document.getElementById('hdnProductId').value;
        var tolQty = 0;
        var lsu = '';
        var InvQty = 0;
        var QuotationId = 0;
        var StockinhandQty = $('#hdnStockinhandQty').val();
        var supplierid = supid
        var parentproductid = document.getElementById('hdnparentprodutid').value;
        var rwNumber = j;
        //        if (document.getElementById('btsave') != null) {
        //            document.getElementById('btsave').style.display = 'block';
        //        }
        //hdnPOStatus
        if ($('#hdnLoadProductsupplier').val() == '') {
            $('#btsave').attr("class", "displaytd");
            //document.getElementById('btsave').style.display = 'table-cell';
        }
        else {
            $('#btsave').attr("class", "hide");
            //document.getElementById('btsave').style.display = 'none';
        }

        var HidValue = document.getElementById('hdnProductsupplier').value;

        var list = HidValue.split('^');

        if (document.getElementById('hdnProductsupplier').value != "") {
            for (var count = 0; count < list.length; count++) {
                var ProductSupplierList = list[count].split('~');
                if (ProductSupplierList[1] != '') {

                    if (ProductSupplierList[0] != '') {
                        rwNumber = parseInt(parseInt(ProductSupplierList[0]) + parseInt(1));
                    }
                    if (ProductName != '') {
                        if (ProductSupplierList[1] == ProductName) {
                            if (ProductSupplierList[2] == suppliername) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
        }
        else {

            if (ProductName != '') {
                var row = document.getElementById('tblPO_Quantity_Productlist').insertRow(1);
                row.id = rwNumber;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);

                cell1.innerHTML = "<b>" + ProductName + "</b> ";
                cell1.width = "25%";

                cell2.innerHTML = "<b>" + drpunits + "</b> ";
                cell2.width = "15%";

                cell3.innerHTML = "<b>" + quantity + "</b> ";
                cell3.width = "15%";

                cell4.innerHTML = "<b>" + StockinhandQty + "</b> ";
                cell4.width = "20%";


                cell5.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                cell5.width = "1%";

                document.getElementById('hdnProductsupplier').value += rwNumber + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty+"~"+drpunitsval + "^";
                AddStatus = 2;

                PO_Quantity_clears();

                j++;
            }
            else {
                
                var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13") == null ? "Provide attribute to add" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13")
                ValidationWindow(userMsg, errorMsg);
//                var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_13');
//                var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;

//                }
//                else {
//                    ValidationWindow('Provide attribute to add', 'Error');
//                    return false;
                //                }
//end
            }
        }
        if (AddStatus == 0) {
            if (ProductName != '') {
                var row = document.getElementById('tblPO_Quantity_Productlist').insertRow(1);

                row.id = rwNumber;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);

                cell1.innerHTML = "<b>" + ProductName + "</b> ";
                cell1.width = "25%";
                cell2.innerHTML = "<b>" + drpunits + "</b> ";
                cell2.width = "23%";
                cell3.innerHTML = "<b>" + quantity + "</b> ";
                cell3.width = "15%";

                cell4.innerHTML = "<b>" + StockinhandQty + "</b> ";
                cell4.width = "15%";

                cell5.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + rwNumber + ");' src='../PlatForm/Images/Delete.jpg' />";
                cell5.width = "1%";

                j++;
                document.getElementById('hdnProductsupplier').value += rwNumber + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty+"~" +drpunitsval + "^";

                PO_Quantity_clears();



            }
            else {
                
                var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13") == null ? "Provide attribute to add" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_13")
                ValidationWindow(userMsg, errorMsg);
//                var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_13');
//                var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;

//                }
//                else {
//                    ValidationWindow('Provide attribute to add', 'Error');
//                    return false;
                //                }
//end


            }
        }
        else if (AddStatus == 1) {
        
        var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_18") == null ? "Product already added" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_18")
        ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_18');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//                }
//                else {
//                    ValidationWindow('Product already added', 'Error');
        //                }
//end
                PO_Quantity_clears();
                return false;
            }
        

        return;
    }

    function PO_Quantity_clears() {
        document.getElementById('tblPO_Quantity_Productlist').style.display = 'table'
        document.getElementById('hdnProductId').value = '';
        document.getElementById('hdnsupplierID').value = '';
        document.getElementById('txtPOQuantity').value = '';
        document.getElementById('txt_PO_Quantity_ProductName').focus();
        document.getElementById('hdnStockinhandQty').value = '0';
        document.getElementById('txt_PO_Quantity_ProductName').value = '';
        document.getElementById('txt_PO_Quantity_Stockinhand').value = '';
        //  document.getElementById('txt_PO_Quantity_Comment').value = '';
        $('#hdnStockinhandQty').val('0');
        document.getElementById('ddlPOUnits').selectedIndex = 0;
    }


    function POTableList() {

        if (document.getElementById('hdnLoadProductsupplier').value != "") {

            var HidValue = document.getElementById('hdnProductsupplier').value;
            var list = HidValue.split('^');


            for (var count = 0; count < list.length; count++) {

                var val = list[count].split('~');
                if (val != "") {
                    $('#tdApprove').show();
                    var row = document.getElementById('tblPO_Quantity_Productlist').insertRow(1);
                    row.id = val[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    cell1.innerHTML = "<b>" + val[1] + "</b> ";
                    cell1.width = "25%";
                    cell2.innerHTML = "<b>" + val[5] + "</b> ";
                    cell2.width = "23%";
                    cell3.innerHTML = "<b>" + val[4] + "</b> ";
                    cell3.width = "15%";
                    cell4.innerHTML = "<b>" + val[14] + "</b> ";
                    cell4.width = "15%";
                    cell5.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + val[0] + ");' src='../Images/Delete.jpg' />";
                    cell5.width = "1%";
                }

            }

        }

    }
    //----------------------------------Po Edit -----------------------------


    function POTableList_Quantity() {
        //debugger;
        if (document.getElementById('hdnLoadProductsupplier').value != "") {

            var HidValue = document.getElementById('hdnProductsupplier').value;
            var list = HidValue.split('^');
            var pCount = list.length;
            pCount = pCount - 1;

            for (var count = 0; count < list.length; count++) {

                var y = list[count].split('~');
                if (y != "") {
                    $('#tdApprove').show();
                    var row = document.getElementById('tblPO_Quantity_Productlist').insertRow(1);
                    row.id = y[0];
                    row.className = 'RowSeq';
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);

                    cell1.innerHTML = "<b>" + pCount + "</b> ";
                    //  cell1.width = "2%";
                    cell2.innerHTML = "<b>" + y[1] + "</b> ";
                    //  cell2.width = "23%";
                    cell3.innerHTML = "<b>" + y[5] + "</b> ";
                    // cell3.width = "10%";
                    cell4.innerHTML = "<b>" + y[4] + "</b> ";
                    //  cell4.width = "15%";
                    //                    cell5.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient1(" + val[0] + ");' src='../Images/Delete.jpg' />";
                    //                    cell5.width = "1%";
                    cell5.innerHTML = y[14];
                    cell6.innerHTML = parseFloat(y[15]).toFixed(2);
                    cell7.innerHTML = y[16];
                    cell8.innerHTML = y[17];
                    cell9.innerHTML = y[18];
                    var pAction = "";

                    pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "' onclick='btnEditQty_OnClick(name);' value = '' type='button' title='Click to Edit' class='ui-icon ui-icon-pencil b-none pointer pull-left marginR10' />" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "' onclick='btnDeleteQty(name);' value = '' type='button' title='Click to Delete' class='ui-icon ui-icon-trash b-none pointer pull-left '  />"
                    cell10.innerHTML = pAction;


                }
                pCount = pCount - 1;

            }

        }

    }

    //------------------------------------------------------------------------------------------===

    function CheckPO_Details() {

        if (document.getElementById('txt_PO_Quantity_ProductName').value.trim() == "") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09") == null ? "Provide the Product Name" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_09")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_09');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
//                ValidationWindow('Provide the Product Name', 'Error');
            //            }
//end
            document.getElementById('txt_PO_Quantity_ProductName').focus();
            return false;
        }
        var ddlaction = document.getElementById('ddlPOUnits');
        var Select = SListForAppDisplay.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
        if (Select == null) {
            Select = '--Select--';
        }
        if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16") == null ? "Select PO Unit" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_16")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_16');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
//                ValidationWindow('Select PO Unit ', 'Error');
            //            }
//end
            document.getElementById('ddlPOUnits').focus();
            return false;
        }
        if (document.getElementById('txtPOQuantity').value.trim() == "" || document.getElementById('txtPOQuantity').value.trim() == "0") {
            
            var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11") == null ? "Provide the Quantity" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_11")
            ValidationWindow(userMsg, errorMsg);
//            var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_11');
//            var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
//                ValidationWindow('Provide the Quantity', 'Error');
            //            }
//end
            // document.getElementById('txtPOQuantity').focus();
            return false;
        }

        //            if (document.getElementById('txtReOrderLevel').value == 0) {
        //                alert('Provide ReOrder Level quantity');
        //                document.getElementById('txtReOrderLevel').value ="";
        //                document.getElementById('txtReOrderLevel').focus();
        //                return false;
        //            }
        var Updatemsg = SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29") == null ? "Update" : SListForAppDisplay.Get("CentralPurchasing_CentralPurchaseOrder_aspx_29");
        if (document.getElementById('btnAddLocation').value != Updatemsg) {
            var x = document.getElementById('hdnLocationList').value.split("^");
            var pLocID = document.getElementById('hdnLocationID').value;
            var pLocationName = document.getElementById('txtLocationName').value;
            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[0] == pLocID) {
                        
                        var userMsg = SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_19") == null ? "This Location already exist" : SListForAppMsg.Get("CentralPurchasing_CentralPurchaseOrder_aspx_19")
                        ValidationWindow(userMsg, errorMsg);
//                        var userMsg = SListForAppMsg.Get('CentralPurchasing_CentralPurchaseOrder_aspx_19');
//                        var errorMsg = SListForAppMsg.Get('CentralPurchasing_Error');
//                        if (userMsg != null && errorMsg != null) {
//                            ValidationWindow(userMsg, errorMsg);
//                            return false;

//                        }
//                        else {
//                            ValidationWindow('This Location already exist', 'Error');
                        //                        }
//end
                        document.getElementById('txtLocationName').value = '';
                        document.getElementById('txtLocationName').focus();
                        return false;
                    }
                }
            }
        }
        return true;
    }



   
</script>

<script src="../PlatForm/Scripts/ProgressBar.js" type="text/javascript"></script>

</body>
</html>

