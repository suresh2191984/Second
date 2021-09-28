<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockDamage.aspx.cs" Inherits="StockOutFlow_StockDamage"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Damage</title>
   
</head>
<body>
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
    <script src="Scripts/StockDamage.js" language="javascript" type="text/javascript"></script>

    <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" type="text/javascript"></script>
    
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="marginT10 marginB10">
                    <div class="w-97p marginauto card-md card-md-default padding10 ">
                        <table class="w-100p" >
                            <tr>
                                <td>
                                    <asp:Label ID="lblmsg" Text="Search Product" runat="server" CssClass="bold" meta:resourcekey="lblmsgResource4"></asp:Label>
                                </td>
                                <td id="tdSearch" runat="server" class="left w-20p">
                                    <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource4">
                                        <asp:TextBox ID="txtProduct" TabIndex="3" onkeypress="return ValidateMultiLangChar(this);" onkeyup="doClearTable();" CssClass="medium bg-searchimage"
                                            runat="server" onblur="pSetFocus('pro');" meta:resourcekey="txtProductResource4"></asp:TextBox>
                                        <ajc:autocompleteextender id="AutoCompleteProduct" runat="server" completioninterval="1"
                                            completionlistcssclass="wordWheel listMain box" completionlisthighlighteditemcssclass="wordWheel itemsSelected3"
                                            usecontextkey="true" completionlistitemcssclass="listitemtwo" enablecaching="False"
                                            firstrowselected="True" minimumprefixlength="1" onclientitemselected="IAmSelected"
                                            servicemethod="getSearchProductBatchListJSON" onclientitemover="doGetProductTotalQuantityCommonJSON"
                                            servicepath="~/InventoryCommon/WebService/InventoryWebService.asmx" targetcontrolid="txtProduct" delimitercharacters=""
                                            enabled="True">
                                        </ajc:autocompleteextender>
                                    </asp:Panel>
                                </td>
                                <td class="a-left w-6p paddingL5">
                                    <asp:Label ID="Rs_Date" Text="Date" runat="server" CssClass="bold" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStockDamageDate" runat="server" CssClass="datePicker" TabIndex="1" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        meta:resourcekey="txtStockDamageDateResource1"></asp:TextBox>
                                    <%--<asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/PlatForm/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                    <ajc:maskededitextender id="MaskedEditExtender5" runat="server" targetcontrolid="txtStockDamageDate"
                                        mask="99/99/9999" masktype="Date" displaymoney="Left" acceptnegative="Left" errortooltipenabled="True"
                                        cultureampmplaceholder="" culturecurrencysymbolplaceholder="" culturedateformat=""
                                        culturedateplaceholder="" culturedecimalplaceholder="" culturethousandsplaceholder=""
                                        culturetimeplaceholder="" enabled="True" />
                                    <ajc:maskededitvalidator id="MaskedEditValidator5" runat="server" controlextender="MaskedEditExtender5"
                                        controltovalidate="txtStockDamageDate" emptyvaluemessage="Date is required" invalidvaluemessage="Date is invalid"
                                        display="Dynamic" tooltipmessage="(dd-mm-yyyy)" emptyvalueblurredtext="*" invalidvalueblurredmessage="*"
                                        validationgroup="MKE" errormessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <ajc:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtStockDamageDate"
                                        format="dd/MM/yyyy" popupbuttonid="ImgBntCalc" enabled="True" />
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />--%>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_Comments" Text="Comments" runat="server" CssClass="bold" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" Columns="25" Rows="2" CssClass="large"
                                        TabIndex="2" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:TextBox ID="txtExpiredColor" ReadOnly="True" runat="server" Height="10px" Width="10px" onkeypress="return ValidateMultiLangChar(this);"
                                        meta:resourcekey="txtExpiredColorResource4"></asp:TextBox>
                                    <asp:Label ID="lblExpLevel" Text="Products Expires Within " CssClass="bold" runat="server" meta:resourcekey="lblExpLevelResource4"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <table class="w-100p">
                    <tr>
                        <td class="w-100p v-top">
                            <div class="marginB10">
                                <div class="w-97p marginauto card-md card-md-default padding10">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="v-top">
                                                <div id="divProductDetails" runat="server" class="hide">
                                                    <table id="TableProductDetails" runat="server" class="w-100p lh30">
                                                        <tr class="">
                                                            <td runat="server">
                                                                <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" CssClass="bold" meta:resourcekey="lblBatchNoResource1" ></asp:Label>&nbsp;
                                                            </td>
                                                            <td runat="server">
                                                                <asp:TextBox ID="txtBatchNo" runat="server" TabIndex="5" onkeypress="return ValidateMultiLangChar(this);" onblur="return BindQuantity();"
                                                                    ></asp:TextBox>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:Label ID="lblAvailableQty" runat="server" Text="Available Qty" CssClass="bold" meta:resourcekey="lblAvailableQtyResource1"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:TextBox ID="txtBatchQuantity" TabIndex="6" onkeypress="return ValidateMultiLangChar(this);" runat="server" ReadOnly="True" Width="60px" CssClass="a-right"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td runat="server">
                                                                <asp:Label ID="lblType" Text="Issued Qty" runat="server" CssClass="bold" meta:resourcekey="lblTypeResource1"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:TextBox ID="txtQuantity" onblur="pSetAddFocus();" TabIndex="7" runat="server"
                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" Width="60px" CssClass="a-right"></asp:TextBox>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:Label ID="lblUnit" runat="server" Text="Unit" CssClass="bold" meta:resourcekey="lblUnitResource1"></asp:Label>&nbsp;
                                                            </td>
                                                            <td runat="server">
                                                                <asp:TextBox ID="txtUnit" runat="server" onkeypress="return ValidateMultiLangChar(this);" ReadOnly="True" TabIndex="8" Width="60px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td runat="server">
                                                            <asp:Label ID="lblAction" runat="server" Text="Action"></asp:Label>
                                                            </td>
                                                            <%--Arun--%>
                                                            <td runat="server">
                                                               <%-- <input type="button" id="add" runat="server" class="btn1" 
                                                                    onclick="javascript:if(checkIsEmpty()) return BindProductList();" value="<%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockDamage_aspx_03%>" />--%>
                                                                    <a id="add" runat="server" class="btn"  onclick="javascript:if(checkIsEmpty()) return BindProductList();" >
                                                                    <%=Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockDamage_aspx_03%></a>
                                                            </td>
                                                        </tr>
                                                        <tr> 
                                                           <td id="tdlblreturnstock" runat="server" class="w-60">
                                                                <asp:Label ID="lblreturnstockk1" Text="ReturnStock" runat="server" meta:resourcekey="lblreturnstockk1Resource1"></asp:Label>
                                                            </td>
                                                            <%--end--%>
                                                            <%--Arun--%>
                                                            <td id="tdreturnstock" runat="server" class="w-60">
                                                                <asp:TextBox ID="txtreturnstock" runat="server"  TabIndex="10" onkeypress="return ValidateMultiLangChar(this);" Width="60px"></asp:TextBox>
                                                            </td>
                                                            <%--end--%>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td class="w-60p">
                                                <asp:Table runat="server" ID="tbllist" class="w-100p gridView" meta:resourcekey="tbllistResource4">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="w-99p marginauto">
                                <table id="tblOrederedItems" class="responstable w-100p">
                                </table>
                            </div>
                            <table class="hide" id="tableTask" runat="server" 
                                cellpadding="2" >
                                <tr runat="server">
                                    <td runat="server">
                                        <asp:Table CellPadding="1" 
                                            runat="server" ID="ConsumableItemsTab" class="w-100p">
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                            <table id="Table2" runat="server" class="w-100p">
                                <tr runat="server">
                                    <td class="a-center paddingT5" runat="server">
                                        <asp:Button ID="btnCancel" TabIndex="11" AccessKey="C" OnClick="btnCancel_Click"
                                            Text="Cancel" runat="server"  CssClass="cancel-btn" meta:resourcekey="btnCancelResource1" />
                                            
										<asp:Button ID="btnReturnStock" Text="Submit" runat="server" 
                                            CssClass="btn marginL10" OnClientClick="javascript:if(!checkDetails('StockDamage')) return false;"
                                            OnClick="btnReturnStock_Click" meta:resourcekey="btnReturnStockResource1" />
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <input id="hdnProBatchNo" runat="server" type="hidden" />
                                <input id="hdnBatchList" runat="server" type="hidden" />
                                <input id="hdnProductId" runat="server" type="hidden" />
                                <input id="hdnProductName" runat="server" type="hidden" />
                                <input id="hdnReceivedID" runat="server" type="hidden" />
                                <input id="hdnSellingPrice" runat="server" type="hidden" />
                                <input id="hdnTax" runat="server" type="hidden" />
                                <input id="hdnExpiryDate" runat="server" type="hidden" />
                                <input id="hdnProductList" runat="server" type="hidden" />
                                <input id="hdnRowEdit" runat="server" type="hidden" />
                                <input id="hdnTasklist" runat="server" type="hidden" />
                                <input id="hdnTaskCollectedItems" runat="server" type="hidden" />
                                <input id="hdnAddedTaskList" runat="server" type="hidden" />
                                <input id="hdnExpiryDateLevel" runat="server" type="hidden" />
                                <input id="hdnHasExpiryDate" runat="server" type="hidden" />
                                <input id="hdnUnitPrice" runat="server" type="hidden" />
                                <input id="hdnParentProductID" runat="server" type="hidden" />
                                <input id="hdnShowCostPrice" runat="server" type="hidden" value="Y" />
                                <input id="hdnDisplaydata" runat="server" type="hidden" value="0" />
                                <input id="hdnPdtRcvdDtlsID" runat="server" type="hidden" value="" />
                                <input type="hidden" id="hdnReceivedUniqueNumber" runat="server" />
                                <input type="hidden" id="hdnStockReceivedBarcodeDetailsID" runat="server"/>
                                <input type="hidden" id="hdnBarcodeNo" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
<asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" /> 
<Attune:Attunefooter ID="Attunefooter" runat="server" />
    
    </form>
</body>
</html>
