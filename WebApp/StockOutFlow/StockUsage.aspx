<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockUsage.aspx.cs" Inherits="StockOutFlow_StockUsage"
    meta:resourcekey="PageResource1"%>

<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Usage</title>
    <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
    <script src="Scripts/StockUsage.js" language="javascript" type="text/javascript"></script>
    <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" type="text/javascript"></script>
    <link href="../PlatForm/StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script src="../PlatForm/Scripts/jquery-1.11.1.min.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

    <style type="text/css">
        .is-flex
        {
            display: flex;
            flex-wrap: wrap;
        }
        .is-flex > [
        class*='col-']
        {
            display: flex;
            flex-direction: column;
        }
        input[type="radio"]
        {
            position: relative; /*top: -0.375rem;*/
            margin: 0 1rem 0 0;
            cursor: pointer;
        }
        input[type="radio"]:before
        {
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
            content: "";
            position: absolute;
            left: 0;
            z-index: 1;
            width: 1rem;
            height: 1rem;
            border: 2px solid #dedede;
        }
        input[type="radio"]:checked:before
        {
            -webkit-transform: rotate(-45deg);
            -moz-transform: rotate(-45deg);
            -ms-transform: rotate(-45deg);
            -o-transform: rotate(-45deg);
            transform: rotate(-45deg);
            height: .5rem;
            border-color: #009688;
            border-top-style: none;
            border-right-style: none;
        }
        input[type="radio"]:after
        {
            content: "";
            position: absolute;
            top: -0.025rem;
            left: 0;
            width: 1.1rem;
            height: 1.1rem;
            background: #fff;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                <div class="contentdata">
                    <div class="ionTabs w-98p marginauto" id="tabs_1" data-name="Tabs_Group_name">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div id="divSubLoc" runat="server" class="w-98p marginauto card-md card-md-default padding10 ">
                                    <table class="w-100p">
                                        <tr id="rdbtns" runat="server" class="hide">
                                            <td runat="server">
                                                <asp:RadioButton runat="server" ID="rdbtnNormal" Text="Normal" GroupName="A" meta:resourcekey="rdbtnNormalResource1" />
                                                <asp:RadioButton runat="server" ID="rdbtnisDevice" Text="IsDevice" GroupName="A" meta:resourcekey="rdbtnisDeviceResource1"/>
                                            </td>
                                        </tr>
                                        <tr id="trsublocation" runat="server" class="hide">
                                            <td runat="server">
                                                <asp:Label ID="lblSublocation" runat="server" Text="" meta:resourcekey="lblSublocationResource1"></asp:Label>
                                            </td>
                                            <td runat="server">
                                                <asp:DropDownList ID="ddlSublocation" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr class="hide">
                                            <td class="a-left">
                                                <asp:Label ID="Rs_Date" Text="Date" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtStockDamageDate" runat="server" CssClass="datePicker" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtStockDamageDateResource1"></asp:TextBox>
                                                <%--<asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/PlatForm/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtStockDamageDate"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtStockDamageDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtStockDamageDate"
                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" Enabled="True" />--%>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="h-5 a-center">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table class="w-100p">
                                    <tr>
                                        <td class="w-100p a-left v-top">
                                            <div class="w-98p marginauto card-md card-md-default padding10">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td id="tdSearch" runat="server" class="a-left">
                                                            <asp:Label ID="lblmsg" Text="Search Product" CssClass="bold" runat="server" meta:resourcekey="lblmsgResource2"></asp:Label>
                                                            <%--      <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource2">--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtProduct" TabIndex="4" onkeyup="doClearTable(); SetFrequency();"
                                                                CssClass="medium" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                                                onblur="pSetFocus('pro');" meta:resourcekey="txtProductResource2"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                UseContextKey="true" CompletionListItemCssClass="listitemtwo" EnableCaching="False"
                                                                FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="IAmSelected"
                                                                ServiceMethod="getSearchProductwithFrequencyBatchList" OnClientItemOver="doGetProductTotalQuantityCommonJSON"
                                                                ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProduct"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td class="a-left" id="tdSTF">
                                                            <asp:Label runat="server" ID="lblSTF" CssClass="bold" Text="Stock Taking Frequency" meta:resourcekey="lblSTFResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rblStockTakingFrequency" runat="server" RepeatDirection="Horizontal"
                                                                meta:resourcekey="rblStockTakingFrequencyResource1" CssClass="bold">
                                                                <asp:ListItem Text="None" Value="None" Selected="True|False" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:Label ID="Rs_Comments" Text="Comments" CssClass="bold" runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" Columns="25" Rows="2"
                                                                onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="v-middle">
                                                            <asp:TextBox ID="txtExpiredColor" ReadOnly="True" onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="w-10 h-10"
                                                                meta:resourcekey="txtExpiredColorResource2"></asp:TextBox>
                                                            <asp:Label ID="lblExpLevel" Text="Products Expires Within " CssClass="bold" runat="server" meta:resourcekey="lblExpLevelResource2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="marginT10 marginB10">
                                                <div class="w-98p marginauto card-md card-md-default padding10">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left w-40p v-top">
                                                                <div id="divProductDetails" runat="server" class="hide">
                                                                    <table id="TableProductDetails" runat="server" class="w-100p lh30">
                                                                        <tr class="bold a-left" runat="server">
                                                                            <td class="" runat="server">
                                                                                <asp:Label ID="lblBatchNo" runat="server" Text="BatchNo" CssClass="bold" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                                                &nbsp;
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:TextBox ID="txtBatchNo" CssClass="smaller" runat="server" TabIndex="5" onkeypress="return ValidateMultiLangChar(this);" onblur="return BindQuantity();"></asp:TextBox>
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:Label ID="lblAvailableQty" CssClass="bold" runat="server" Text="AvailableQty" meta:resourcekey="lblAvailableQtyResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:TextBox ID="txtBatchQuantity" TabIndex="6" runat="server" onkeypress="return ValidateMultiLangChar(this);" ReadOnly="True" CssClass="smaller"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="" runat="server">
                                                                                <asp:Label ID="lblType" Text="Used Qty" CssClass="bold" runat="server" meta:resourcekey="lblTypeResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:TextBox ID="txtQuantity" onblur="pSetAddFocus();" TabIndex="7" runat="server" CssClass="smaller"
                                                                                    onkeypress="return NumericOnly(event);"></asp:TextBox>
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:Label ID="lblUnit" runat="server" CssClass="bold" Text="Unit" meta:resourcekey="lblUnitResource1"></asp:Label>
                                                                                &nbsp;
                                                                            </td>
                                                                            <td class="" runat="server">
                                                                                <asp:TextBox ID="txtUnit" runat="server" ReadOnly="True" TabIndex="8" onkeypress="return ValidateMultiLangChar(this);" CssClass="smaller"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="tdRemarks" runat="server" class="">
                                                                                <asp:Label ID="lblRemarks" Text="Remarks" CssClass="bold" runat="server" meta:resourcekey="lblRemarksResource1"></asp:Label>
                                                                            </td>
                                                                            <td runat="server" colspan="2">
                                                                                <asp:TextBox ID="txtRemarks" TextMode="MultiLine" runat="server"  CssClass="w-90p" TabIndex="10" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                                                            </td>
                                                                            <%--<td class="" runat="server">
                                                                                Action
                                                                            </td>--%>
                                                                            <td class="" runat="server">
                                                                                    <%-- <asp:Button ID="add" runat="server" Text="Button" class="btn" TabIndex="9" OnClientClick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="width: 60px;" meta:resourcekey="btnaddResource2" />
                                                                                    --%>
                                                                                        <asp:Button ID="add" runat="server" Text="Button" class="btn w-60" TabIndex="9" OnClientClick="javascript:return checkIsEmpty();"
                                                                                    meta:resourcekey="btnaddResource2" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <%--Arun--%>
                                                                            <td id="tdlblreturnstock" runat="server" class="">
                                                                                <asp:Label ID="lblreturnstockk1" Text="ReturnStock" runat="server" meta:resourcekey="lblreturnstockk1Resource1"></asp:Label>
                                                                            </td>
                                                                            <%--end--%>
                                                                            <%--Arun--%>
                                                                            <td id="tdreturnstock" runat="server" class="">
                                                                                <asp:TextBox ID="txtreturnstock" runat="server"  TabIndex="10" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                                                            </td>
                                                                            <%--end--%>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Table CssClass="responstable w-100p" runat="server" ID="tbllist" meta:resourcekey="tbllistResource2">
                                                                </asp:Table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <table id="tblOrederedItems" class="responstable w-100p font11 a-left">
                                            </table>
                                            <table class="w-100p hide" id="tableTask" runat="server">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Table CssClass="w-100p" 
                                                            runat="server" ID="ConsumableItemsTab">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="Table2" runat="server" class="w-100p marginT10">
                                                <tr runat="server">
                                                    <td class="a-center" runat="server">
                                                        <asp:Button ID="btnReturnStock" Text="Submit" runat="server"
                                                            CssClass="btn" OnClientClick="javascript:if(!checkDetails('StockUsage')) return false;"
                                                            OnClick="btnReturnStock_Click" meta:resourcekey="btnReturnStockResource1" />
                                                        &nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnCancel" TabIndex="11" AccessKey="C" OnClick="btnCancel_Click"
                                                            Text="Cancel" runat="server"  CssClass="cancel-btn"
                                                             meta:resourcekey="btnCancelResource1"/>
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
                                                <input id="hdnDisplaydata" runat="server" type="hidden" />
                                                <input id="hdnlocationID" runat="server" type="hidden" />
                                                <input id="hdnShowCostPrice" runat="server" type="hidden" value="Y"/>
                                                <input id="hdnPdtRcvdDtlsID" runat="server" type="hidden" />
                                                 <input id="hdnReceivedUniqueNumber" runat="server" type="hidden" />
                                                <input type="hidden" id="hdnStockReceivedBarcodeDetailsID" runat="server"/>
                                                <input type="hidden" id="hdnBarcodeNo" runat="server" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="Blockslot" class="hide " style="width: 100%; max-height: 500px; height: 300px;
            overflow: auto;">
            <div class="w-100p h-30 bg-theme">
                <table class="w-100p paddingT2">
                    <tr>
                        <td class="a-left font18 paddingL10 w-60p">
                            <asp:Label ID="lblMDBS" runat="server" Text="Stock Usage and Update Audit" Style="color: #fff;"
                                meta:resourcekey="lblMDBSResource1"></asp:Label>
                            <%--    <span style="color: #fff;">Multiple Doctor Blocking Screen</span>--%>
                        </td>
                        <td class="a-right" style="margin-right: 10px;">
                            <%-- <asp:Button ID="btnClose" runat="server" Text="X" />--%>
                            <input type="button" id="Button1" onclick="Closeclick()" value="X" class="btn" style="font-weight: bold;
                                border: 1px solid #fff;" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="w-95p" style="background-color: #f5f5f5; padding: 10px 10px;text-align: center;margin: 0 auto;">
                <table id="auditlog" class="responstable w-100p font11 a-left" style="text-align: center !important;">
                </table>
            </div>
            <div class="w-99p " style="background-color: #f5f5f5; margin: 0 0 10px 8px;">
            </div>
        </div>
                    <div id="Bck-black" class="hide" style="background: #c1c1c1; top: 0; position: fixed;
                        height: 1000px; width: 100%; z-index: 99; opacity: 0.8; filter: alpha (opacity=80);
                        padding: 0; margin: 0; left: 0;">
                    </div>
                </div>
          <Attune:Attunefooter ID="Attunefooter" runat="server" />   
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
    <script src="../PlatForm/Scripts/ion.tabs.min.js" type="text/javascript"></script>
</body>
</html>
