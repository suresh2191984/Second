<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockIssued.aspx.cs" Inherits="Inventory_StockIssued"
    EnableEventValidation="false" meta:resourcekey="PageResource3" %>

<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Issued</title>
    <style type="text/css">
      #tat_table{width:156px !important;border:1px solid #d0d0d0;}
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
        <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
        <script src="Scripts/IssueStock.js" type="text/javascript"></script>
        <script src="../InventoryCommon/Scripts/InvStockUsage.js" type="text/javascript"></script>
        <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" type="text/javascript"></script>
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
            <ProgressTemplate>
                <div id="progressBackgroundFilter">
                </div>
                <div class="a-center w-60p" id="processMessage">
                    <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server"  meta:resourcekey="Rs_PleasewaitResource1"/>
                    <br />
                    <br />
                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
                <div class="marginT10 marginB10">
                    <div class="w-97p marginauto card-md card-md-default padding10 ">
                        <table class="w-100p" >
                            <tr id="trTrusted" runat="server" class="hide">
                                <td id="Td1" class="w-10p" runat="server">
                                    <asp:Label ID="lblSelcetOrg2" runat="server" Text="Select Org" CssClass="bold" meta:resourcekey="lblSelcetOrg2Resource3"></asp:Label>
                                </td>
                                <td id="Td2" colspan="2" runat="server">
                                    <asp:DropDownList ID="ddlTrustedOrg" TabIndex="1" runat="server" CssClass="small"
                                        OnChange="GetLocationlist_new();">
                                    </asp:DropDownList>
                                    <%--    <asp:DropDownList  ID="ddlTrustedOrg" AutoPostBack ="true"  TabIndex="1" runat="server" 
                                                        > 
                                                
                                                    </asp:DropDownList>--%><img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                                <td>
                                    <asp:Label ID="lblIssuedTo" runat="server" Text="Issued To" CssClass="bold" meta:resourcekey="lblIssuedToResource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlLocation" TabIndex="1" CssClass="small" runat="server"
                                        onchange="fnChangeToLocation()" meta:resourcekey="ddlLocationResource3">
                                    </asp:DropDownList>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                                <td>
                                    <asp:Label ID="lblComments" runat="server" Text="Comments" CssClass="bold" meta:resourcekey="lblCommentsResource3"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtComments" TabIndex="3" TextMode="MultiLine" runat="server"
                                        Rows="2" onkeypress="return ValidateMultiLangChar(this);" CssClass="w-100p" meta:resourcekey="txtCommentsResource3"></asp:TextBox>
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblDate1" runat="server" Text="Date:" CssClass="bold" meta:resourcekey="lblDate1Resource3"></asp:Label>
                                    &nbsp;&nbsp;
                                    <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource3"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="hide" id="tdReceivedBy" runat="server">
                                    <asp:Label ID="lblReceivedBy" runat="server" Text="Received By" meta:resourcekey="lblReceivedByResource3"></asp:Label>
                                </td>
                                <td class="hide" id="tdddlUser" runat="server">
                                    <asp:DropDownList ID="ddlUser" TabIndex="2" CssClass="small" runat="server" meta:resourcekey="ddlUserResource3">
                                    </asp:DropDownList>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <table class="w-100p">
                    <tr>
                        <td>
                            <div class="marginB10">
                                <div class="w-97p marginauto card-md card-md-default padding10 ">
                                    <table class="w-100p lh30">
                                        <tr>
                                            <td  class="w-10p">
                                                <asp:Label ID="lblmsg" Text="Search Product" CssClass="bold" runat="server" meta:resourcekey="lblmsgResource3"></asp:Label>
                                            </td>
                                            <td id="tdSearch" runat="server" class="v-top">
                                                <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource3">
                                                    <asp:TextBox ID="txtProduct" TabIndex="4" onkeypress="return ValidateMultiLangChar(this);" onkeyup="doClearTable();"
                                                        CssClass="medium w-250 bg-searchimage" runat="server" onblur="pSetFocus('pro');" meta:resourcekey="txtProductResource3"></asp:TextBox>
                                                        <asp:CheckBox ID="cheBarcodeSearch" runat="server" Text="Barcode" onClick="fnChangeToLocation()" meta:resourcekey="cheBarcodeSearchResource2"/>
                                                     <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                        MinimumPrefixLength="1" OnClientItemSelected="IAmSelectedJSON" ServiceMethod="getSearchProductBatchListJSON"
                                                        OnClientItemOver="doGetProductTotalQuantityCommonJSON" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                        UseContextKey="true" TargetControlID="txtProduct" DelimiterCharacters="" Enabled="True"
                                                        OnClientPopulated="SetColor" BehaviorID="AutoCompleteProduct">
                                                    </ajc:AutoCompleteExtender>
                                                </asp:Panel>
                                            </td>
                                            <td class="v-top">
                                                <asp:TextBox ID="txtExpiredColor" ReadOnly="True" runat="server" CssClass="small w-10 h-10" onkeypress="return ValidateMultiLangChar(this);"
                                                    meta:resourcekey="txtExpiredColorResource3"></asp:TextBox>
                                                <asp:Label ID="lblExpLevel" Text="Products Expires Within " runat="server" meta:resourcekey="lblExpLevelResource3"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="v-top" colspan="2">
                                                <div id="divProductDetails" runat="server" class="hide">
                                                    <table id="TableProductDetails" runat="server" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" CssClass="bold " meta:resourcekey="lblBatchNoResource2"></asp:Label>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtBatchNo" runat="server" TabIndex="5" CssClass="smaller bg-searchimage" onkeypress="return ValidateMultiLangChar(this);" onblur="return BindQuantity();"
                                                                    meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                            </td>

                                                            <td>
                                                                <asp:Label ID="lblAvailableQty" runat="server" Text="Available Qty" CssClass="bold" meta:resourcekey="lblAvailableQtyResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtBatchQuantity" onkeypress="return ValidateOnlyNumeric(this)"  
                                                                    ReadOnly="True" TabIndex="6" CssClass="smaller a-right" runat="server" 
                                                                    meta:resourcekey="txtBatchQuantityResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblType" Text="Issued Qty" runat="server" CssClass="bold" meta:resourcekey="lblTypeResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtQuantity" onblur="pSetAddFocus();" TabIndex="7" CssClass="smaller a-right w-60"
                                                                 onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                            </td>

                                                            <td>
                                                                <asp:Label ID="lblUnit" runat="server" Text="Unit" CssClass="bold" meta:resourcekey="lblUnitResource2"></asp:Label>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUnit" runat="server" ReadOnly="True" TabIndex="8" CssClass="smaller" onkeypress="return ValidateMultiLangChar(this);"
                                                                    meta:resourcekey="txtUnitResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>   
                                                            <td id="Td46" runat="server" class="hide">
                                                                <asp:Label ID="lblExpDate" Text="Exp Date" runat="server" meta:resourcekey="lblExpDateResource2"></asp:Label>
                                                            </td>
                                                            <td id="Td47" runat="server" class="w-60 hide">
                                                                <asp:TextBox ID="txtExpDate" onblur="return checkExpDate(this.id);" CssClass="datepicker small" ReadOnly="true"
                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" meta:resourcekey="txtExpDateResource1"></asp:TextBox>
                                                            </td>

                                                            <td >
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="add" runat="server" Text="Add" CssClass="btn" OnClientClick="javascript: return checkIsEmpty();"
                                                                    meta:resourcekey="addResource1"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <%--Arun--%>
                                                            <td id="tdlblreturnstock" runat="server" class="w-60">
                                                                <asp:Label ID="lblreturnstockk1" Text="ReturnStock" runat="server" meta:resourcekey="lblreturnstockk1Resource1"></asp:Label>
                                                            </td>
                                                            <%--end--%>
                                                            <%--Arun--%>
                                                            <td id="tdreturnstock" class="w-60" runat="server">
                                                                <asp:TextBox ID="txtreturnstock" runat="server" onkeypress="return ValidateMultiLangChar(this);" CssClass="small  a-right" TabIndex="10" Width="60px"></asp:TextBox>
                                                            </td>
                                                            <%--end--%>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td class="w-55p">
                                                <asp:Table CssClass="w-100p marginT10" runat="server" ID="tbllist" meta:resourcekey="tbllistResource3">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                        <tr>
                                    
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <table id="tblOrederedItems" class="w-99p responstable marginauto">
                            </table>
                            <table id="tableTask" runat="server" class="w-100p">
                                <tr runat="server">
                                    <td runat="server">
                                        <asp:Table CssClass="w-100p" runat="server" 
                                            ID="ConsumableItemsTab" meta:resourcekey="ConsumableItemsTabResource1">
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                            <table id="Table2" runat="server" class="w-100p marginT10 ">
                                <tr runat="server">
                                    <td class="a-center" runat="server">
                                        <input type="button" value="<%=Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_05 %>" class="btn" 
                                        id="btnSaveasDraft" onclick="fnSaveAsDrafts('ManualSave')"/>
                                        <asp:Button ID="btnSubmit" TabIndex="10" AccessKey="S" OnClick="btnStockIssued_Click"
                                            Text="Submit" runat="server" CssClass="btn" meta:resourcekey="btnSubmitResource1"
                                            OnClientClick=" return checkDetails('StockIssued');" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnCancel" TabIndex="11" AccessKey="C" OnClick="btnCancel_Click"
                                            Text="Cancel" runat="server" CssClass="cancel-btn" meta:resourcekey="btnCancelResource1"/>
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
                                <input id="hdnlocation" runat="server" type="hidden" />
                                <input id="hdnUserlist" runat="server" type="hidden" />
                                <input id="hdnFromLocationID" runat="server" type="hidden" />
                                <input id="hdnUserID" runat="server" type="hidden" value="0" />
                                <input id="hdnShowCostPrice" runat="server" type="hidden" value="Y" />
                                <input id="hdnIntendID" runat="server" type="hidden" />
                                <input id="hdnDisplaydata" type="hidden" />
                                <input type="hidden" id="hdnDaftMethod" />
                                <input type="hidden" id="hdnEnableDraft" value="Y" />
                                <input type="hidden" id="hdnIsCorpOrg" runat="server"/>
                                <input type="hidden" id="hdnPdtRcvdDtlsID" runat="server"/>
                                <input type="hidden" id="hdnReceivedUniqueNumber" runat="server"/>
                                <input type="hidden" id="hdnStockReceivedBarcodeDetailsID" runat="server"/>
                                <input type="hidden" id="hdnStockReceivedBarcodeID" runat="server"/>
                                 <input id="hdnIsUniqueBarcode" runat="server"  type="hidden" value="N" />
                                <input type="hidden" id="Hidden1" runat="server"/>
                                <input type="hidden" id="hdnBarcodeNo" runat="server" />
                                <input id="hdnLoginid" runat="server" type="hidden" />
                                <input type="hidden" id="hdnOrgId" runat="server" />
                                <input type="hidden" id="hdnLocationId" runat="server" />
                                <input id="hndPageId" runat="server" type="hidden" />
                                <input type="hidden" id="hdnAddFlag" runat="server" value="N" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter runat="server" ID="Attunefooter" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

<!--language conversion files start-->
<script type="text/javascript" language="javascript">
    var ErrorMsg = SListForAppMsg.Get('StockIntend_Error') != null ? SListForAppMsg.Get('StockIntend_Error') : "Error";
    var InformationMsg = SListForAppMsg.Get('StockIntend_Information') != null ? SListForAppMsg.Get('StockIntend_Information') : "Information"
    var okMsg = SListForAppMsg.Get('StockIntend_Ok') != null ? SListForAppMsg.Get('StockIntend_Ok') : "Ok";
    var CancelMsg = SListForAppMsg.Get('StockIntend_Cancel') != null ? SListForAppMsg.Get('StockIntend_Cancel') : "Cancel";
</script>
<script language="javascript" type="text/javascript">
        $(document).ready(function() {

            var AppInterval = $("input[id$=hdnshowintervel]").val();
            setTimeout(fnSaveAsDrafts, AppInterval);
            if ($("#hdnProductList").val() != "") {
                Tblist();
            }
        });
        function fnSaveAsDrafts(SaveMetod) {
            $('#hdnDaftMethod').val(SaveMetod);

            if ($('#ddlTrustedOrg').val() == 0) {
                var userMsg = SListForAppMsg.Get('StockIntend_StockIssued_aspx_01') != null ? SListForAppMsg.Get('StockIntend_StockIssued_aspx_01') : "Select the Organization";
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            var draftData = $("#hdnProductList").val();
            if (draftData == '^null' || draftData == 'null^') {
                $("#hdnProductList").val('');
                userMsg = SListForAppMsg.Get('StockIntend_StockIssued_aspx_02') != null ? SListForAppMsg.Get('StockIntend_StockIssued_aspx_02') : "Format is not correct";
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            } else if (draftData == '') {
            userMsg = SListForAppMsg.Get('StockIntend_StockIssued_aspx_03') != null ? SListForAppMsg.Get('StockIntend_StockIssued_aspx_03') : "Select the product";
            ValidationWindow(userMsg, ErrorMsg); 
                return false;
            }
            if (draftData.length <= 0) {
                userMsg = SListForAppMsg.Get('StockIntend_StockIssued_aspx_03') != null ? SListForAppMsg.Get('StockIntend_StockIssued_aspx_03') : "Select the product";
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            var sManualValue = SListForAppDisplay.Get('StockIntend_StockIssued_aspx_01') != null ? SListForAppDisplay.Get('StockIntend_StockIssued_aspx_01') : "ManualSave";
            if (SaveMetod == sManualValue) {
              //  fnShowProgress();
            }



            if ($('#ddlTrustedOrg').val() != 0 && $('#ddlLocation').val() != 0 && $('#hdnEnableDraft').val() == "Y") {
                var DraftValue = $('#ddlTrustedOrg').val() + "|" + $('#ddlLocation').val();
                var OrgID = $('#hdnOrgId').val();
                var LID = $('#hdnLoginid').val();
                var ILocationID = $('#hdnLocationId').val();
                var PageID = $('#hndPageId').val();
                $.ajax({
                    type: "POST",
                    url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveASDraft",
                    data: "{ 'OrgID':" + OrgID + ",'LocationID':" + ILocationID + ",'PageID':" + PageID + ",'LoginID':" + LID + ",'DraftType':'StockIssued','DraftValue':'" + DraftValue + "','DraftData':'" + draftData + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function(response) {
                        alert(response.d);
                    }
                });

            }
            if (SaveMetod != sManualValue) {
                var AppInterval = $("input[id$=hdnshowintervel]").val();
                setTimeout(fnSaveAsDrafts, AppInterval);
            }
        }
        function OnSuccess(response) {
            var sManualValue = SListForAppDisplay.Get('StockIntend_StockIssued_aspx_01') != null ? SListForAppDisplay.Get('StockIntend_StockIssued_aspx_01') : "ManualSave";
            if ($('#hdnDaftMethod').val() == sManualValue) {
                var userMsg = SListForAppDisplay.Get('StockIntend_StockIssued_aspx_04') != null ? SListForAppDisplay.Get('StockIntend_StockIssued_aspx_04') : "Saved Successfully!!!";
                ValidationWindow(userMsg, InformationMsg);
            }

            $('#hdnDaftMethod').val('');
        }


        function fnGetDrafts() {
            $("#hdnProductList").val('');
            var DraftValue = $('#ddlTrustedOrg').val() + "|" + $('#ddlLocation').val();
            var OrgID = $('#hdnOrgId').val();
            var LID = $('#hdnLoginid').val();
            var ILocationID = $('#hdnLocationId').val();
            var PageID = $('#hndPageId').val();
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetDraftDtls",
                data: "{ 'OrgID':" + OrgID + ",'LocationID':" + ILocationID + ",'PageID':" + PageID + ",'LoginID':" + LID + ",'DraftType':'StockIssued','DraftValue':'" + DraftValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetDraftSuccess,
                failure: function(response) {
                    alert(response.d);
                }
            });

        }
        function OnGetDraftSuccess(response) {
            if (response != null && response.d != null && response.d.length > 0) {
                $("#hdnProductList").val(response.d[0].Data);
                lstProductList = JSON.parse($("#hdnProductList").val());
            }
            else {
                $("#hdnProductList").val('');
            }
            if (lstProductList.length > 0)
            {
                Tblist();
            }
        }
</script>

<script type="text/javascript">

    function fnChangeToLocation() {

        if ($('#ddlTrustedOrg').val() == 0 || $('#ddlLocation').val() == 0) {
            $('#txtProduct').val('');
        }
        else {

            //$find('AutoCompleteProduct').set_contextKey($('#ddlLocation').val());

            if ($("#cheBarcodeSearch").is(':checked')) {
                $find('AutoCompleteProduct').set_contextKey($('#ddlLocation').val() + "~" + "Barcode");
            } else {
                $find('AutoCompleteProduct').set_contextKey($('#ddlLocation').val() + "~" + "Product");
            }
            
        }
        fnGetDrafts();
    }
    function fnValidateLocation() {
        if ($('#ddlTrustedOrg').val() == "" || $('#ddlTrustedOrg').val() == "0" || $('#ddlLocation').val() == "" || $('#ddlLocation').val() == "0") {
            return false;
        }

    }
    //sathish-start--should alow alphanumeric.. 
    function ValidateSplChar(txt) {
        txt.value = txt.value.replace(/[^a-zA-Z 0-9 .\n\r]+/g, '');
    }
    //sathish-end--should alow alphanumeric.. 
</script>

</body>
</html>

<!--language conversion files End-->
 <%--<script src="../PlatForm/Scripts/ProgressBar.js" type="text/javascript"></script>--%>