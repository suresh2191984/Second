<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaiseIntend.aspx.cs" Inherits="StockIntend_RaiseIntend"
    EnableEventValidation="false" meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Indent Raise</title>
    
<script type="text/javascript" language="javascript">

    function ValidateSpecialCharacter(event) {
        var k = event.which;
        var ok = k >= 65 && k <= 90 ||  // A-Z 
                     k >= 97 && k <= 122 || // a-z
                     k >= 48 && k <= 57;    // 0-9
        if (!ok) {
            event.preventDefault();
        }
    }
    function GetLocationlist() {
        var objSelect = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_01') == null ? "--Select--" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_01');
        var drpOrgid = document.getElementById('ddlTrustedOrg').value; //.options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        document.getElementById('hdnSelectOrgid').value = drpOrgid;
        var options = document.getElementById('hdnlocation').value;
        var ddlLocation = document.getElementById('ddlLocation');
        ddlLocation.options.length = 0;
        var optn1 = document.createElement("option");
        ddlLocation.options.add(optn1);
        optn1.text = objSelect;
        optn1.value = "0";

            var IsDefaultValue = 0;

            var list = options.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (drpOrgid == res[0]) {
                        var optn = document.createElement("option");
                        ddlLocation.options.add(optn);
                        optn.text = res[2];
                        optn.value = res[1];
                        if (res[3] == "True") {
                            IsDefaultValue = res[1];
                        }
                    }

                }
            }
            ddlLocation.value = IsDefaultValue;


        }

        function GetBehalfOfLocationlist() {
        var objSelect = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_01') == null ? "--Select--" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_01');
            var drpOrgid = document.getElementById('ddlBehalfOfTrustedOrg').value; //.options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
            document.getElementById('hdnSelectBehalfOfOrgid').value = drpOrgid;
            var options = document.getElementById('hdnBehalfOflocation').value;
            var ddlLocation = document.getElementById('ddlOnBehalfOf');
            ddlLocation.options.length = 0;
            var optn1 = document.createElement("option");
            ddlLocation.options.add(optn1);
            optn1.text = objSelect;
            optn1.value = "0";

            var list = options.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (drpOrgid == res[0]) {
                        var optn = document.createElement("option");
                        ddlLocation.options.add(optn);
                        optn.text = res[2];
                        optn.value = res[1];
                    }

                }
            }
        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="divProjection">
                    <table class="w-100p displaytb" runat="server" id="tblProjection">
                        <tr id="Tr1" runat="server">
                            <td id="Td1" class="w-10p" runat="server">
                                <asp:Label ID="lablTrusted" Text="Raise Indent To Organization" CssClass="lh20" runat="server" meta:resourcekey="lablTrustedResource1"></asp:Label>
                            </td>
                            <td id="Td2" runat="server">
                                <div>
                                    <asp:DropDownList ID="ddlTrustedOrg" CssClass="medium" TabIndex="1" runat="server"
                                        OnChange="GetLocationlist();" meta:resourcekey="ddlTrustedOrgResource1">
                                    </asp:DropDownList>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                </div>
                            </td>
                            <td id="Td3" runat="server">
                                <asp:Label ID="lblIntentToLoc" Text="Raise Indent To Store" runat="server" meta:resourcekey="lblIntentToLocResource1"></asp:Label>
                            </td>
                            <td id="Td4" runat="server">
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" 
                                    OnChange="locationdetails();" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td id="Td9" runat="server">
                                <asp:Label ID="lblExpectedDeliveryDate" runat="server" Text="Expected Delivery Date"
                                    meta:resourcekey="lblExpectedDeliveryDateResource1"></asp:Label>
                            </td>
                            <td id="Td10" runat="server">
                                <asp:TextBox ID="txtDate" runat="server" CssClass="small datePicker" onkeypress="return ValidateSpecialAndNumeric(this);"  
                                    meta:resourcekey="txtDateResource1"></asp:TextBox>
                               <%-- <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate"
                                    Format="dd/MM/yyyy" PopupButtonID="txtDate" Enabled="True" />--%>
                            </td>
                        </tr>
                        <tr class="hide">
                        </tr>
                        <tr id="Tr2" class="hide" runat="server">
                        </tr>
                        <tr id="Tr3" runat="server" class="hide">
                            <td class="w-20p" id="tdRaisedOnBehalf" runat="server">
                                <asp:Label ID="lblBehalfOrg" Text="Indent Raised On Behalf Of Organization" runat="server"
                                    meta:resourcekey="lblBehalfOrgResource1"></asp:Label>
                            </td>
                            <td id="tdddlBehalfOf" runat="server">
                                <div>
                                    <asp:DropDownList ID="ddlBehalfOfTrustedOrg" CssClass="medium" TabIndex="1" runat="server"
                                        OnChange="GetBehalfOfLocationlist();" 
                                        meta:resourcekey="ddlBehalfOfTrustedOrgResource1">
                                    </asp:DropDownList>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                </div>
                            </td>
                            <td id="Td5" runat="server">
                                <asp:Label ID="lblBehalfLoc" Text="Indent Raised On Behalf Of Site" runat="server"
                                    meta:resourcekey="lblBehalfLocResource1"></asp:Label>
                            </td>
                            <td id="Td6" runat="server">
                                <asp:DropDownList ID="ddlOnBehalfOf" runat="server" CssClass="ddl" Width="380px"
                                    class="fix-me" OnChange="BehalfOflocationdetails();" 
                                    meta:resourcekey="ddlOnBehalfOfResource1">
                                </asp:DropDownList>
                                &nbsp;<img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                            </td>
                        </tr>
                        <tr id="Tr4" class="hide" runat="server">
                            
                        </tr>
                        <tr id="trShelfSize" runat="server">
                            <td id="Td11" runat="server">
                                <asp:Label ID="lblMinimumshelflife" runat="server" Text="Minimum shelf-life" meta:resourcekey="lblMinimumshelflifeResource1"></asp:Label>
                            </td>
                            <td id="Td12" runat="server" colspan="3">
                                <asp:TextBox ID="txtMinimunlife" runat="server" CssClass="medium" onkeypress="return ValidateMultiLangChar(this);" Text="1" 
                                    meta:resourcekey="txtMinimunlifeResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="Tr6" runat="server">
                            <td id="Td15" class="h-5 a-center" runat="server">
                            </td>
                        </tr>
                        <tr id="Tr7" runat="server">
                            <td id="Td16" runat="server">
                                <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource1"></asp:Label>
                            </td>
                            <td id="Td17" runat="server">
                                <asp:TextBox ID="txtComments" CssClass="medium" TextMode="MultiLine" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                    Columns="25" Rows="2" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                            </td>
                            
                             <td id="tdlblRejectComments" runat="server">
                                <asp:Label ID="lblRejectComments" runat="server" Text="Reject Comments" meta:resourcekey="lblRejectComments1"></asp:Label>
                            </td>
                            <td id="tdtxtRejectComments" runat="server">
                                <asp:TextBox ID="txtRejectComments" CssClass="medium" TextMode="MultiLine" runat="server"
                                    Columns="25" Rows="2" meta:resourcekey="txtRejectComments1"></asp:TextBox>
                            </td>
                            <td id="tdIsConsignment" class="hide">
                                <asp:CheckBox ID="ChkIsConsign" runat="server" Text="IsConsignment" onclick="return ChangeConsign();"  meta:resourcekey="ChkIsConsignResource1" />
                            </td>
                        </tr>
                        <tr id="Tr8" runat="server">
                            <td id="Td20" colspan="4" class="h-5 a-center" runat="server">
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p searchPanel">
                        <tr>
                            <td class="hide h-23" colspan="9">
                                <div id="ACX2OPPmt" class="show" runat="server">
                                    &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="w-15 h-15 v-top"
                                        onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                    <span class="dataheader1txt" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                        &nbsp;<asp:Label ID="lblProjectionList" runat="server" Text="Projection List" meta:resourcekey="lblProjectionListResource2"></asp:Label></span>
                                </div>
                                <div id="ACX2minusOPPmt" class="hide" runat="server">
                                    &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" class="w-15 h-15 v-top"
                                        onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                    <span class="dataheader1txt" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                        &nbsp;<asp:Label ID="lblProjectionList2" runat="server" Text="Projection List" meta:resourcekey="lblProjectionList2Resource2"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr class="hide displaytr" id="ACX2responsesOPPmt" runat="server">
                            <td id="Td21" colspan="9" runat="server">
                                <asp:GridView ID="gvIntendProjectionList" EmptyDataText="No matching records found "
                                    meta:resourcekey="gvIntendProjectionListResource1" runat="server" AutoGenerateColumns="False"
                                    CssClass="gridView" OnRowDataBound="gvIntendProjectionList_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource14">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkProduct" runat="server" Checked="True" 
                                                    meta:resourcekey="chkProductResource1" />
                                                <asp:HiddenField ID="hdnProductID" runat="server" 
                                                    Value='<%# Eval("ProductID") %>' />
                                                <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("ID") %>' />
                                                <asp:HiddenField ID="hdnUnit" runat="server" 
                                                    Value='<%# Eval("SellingUnit") %>' />
                                                <asp:HiddenField ID="hdnBatchNo" runat="server" 
                                                    Value='<%# Eval("BatchNo") %>' />
                                                <asp:HiddenField ID="hdnParentProductID" runat="server" 
                                                    Value='<%# Eval("ParentProductID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product" meta:resourcekey="TemplateFieldResource101">
                                            <ItemTemplate>
                                                <asp:Label Text='<%# Eval("ProductName") %>' ID="lblProductName" runat="server" 
                                                    ></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource102">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtQuantity" CssClass="small" Text='<%# Eval("Quantity") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                                    runat="server" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InHand Qty" meta:resourcekey="TemplateFieldResource103">
                                            <ItemTemplate>
                                                <asp:TextBox Enabled="False" CssClass="small" ID="txtInhandQty" Text='<%# Eval("InHandQuantity") %>'
                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" 
                                                    meta:resourcekey="txtInhandQtyResource1"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="SellingUnit" HeaderText="Unit" meta:resourcekey="BoundFieldResource103" />
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" />
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="trSelectOption" runat="server">
                            <td id="Td22" runat="server">
                                <asp:RadioButton ID="rdProduct" runat="server" GroupName="rdProducts" onclick="javascript:SelectOption()"
                                    Text="Select Product" TextAlign="Left" Checked="True" meta:resourcekey="rdProductResource1" />
                            </td>
                            <td id="Td23" runat="server">
                                <asp:RadioButton ID="rdProtocol" runat="server" GroupName="rdProducts" onclick="javascript:SelectOption()"
                                    Text="Select Study/Protocol" meta:resourcekey="rdProtocolResource1" />
                            </td>
                            <td id="tdSitename1" runat="server" class="hide">
                                <asp:Label ID="lblLocations" runat="server" Text="Select Sites" meta:resourcekey="lblLocationsResource1"></asp:Label>
                            </td>
                            <td id="tdSitename2" runat="server" colspan="6" class="hide">
                                <asp:TextBox ID="txtLocations" runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);" 
                                    meta:resourcekey="txtLocationsResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" TargetControlID="txtLocations"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                    OnClientItemSelected="GetLocationID" MinimumPrefixLength="1" CompletionInterval="1"
                                    FirstRowSelected="True" ServiceMethod="GetOrgLocations" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr class="lh30" id="trProduct" runat="server">
                            <td colspan="9" runat="server">
                                <div class="w-100p">
                                    <table class="w-100p">
                                        <tr>
                                            <td ID="Td24" runat="server" class="w-20p">
                                                <asp:Label ID="lblProductName" runat="server" 
                                                    meta:resourcekey="lblProductNameResource1" Text="Product Name"></asp:Label>
                                            </td>
                                            <td ID="Td28" runat="server" class="w-20p">
                                                <asp:Label ID="lblUnit2" runat="server" meta:resourcekey="lblUnit2Resource1" 
                                                    Text="Unit"></asp:Label>
                                            </td>
                                            <td class="w-20p">
                                                <asp:Label ID="lblCurStock" runat="server" 
                                                    meta:resourcekey="lblCurStockResource1" Text="InHand Quantity"></asp:Label>
                                            </td>
                                            <td ID="lblInhandQty" runat="server" class="w-20p">
                                                <asp:Label ID="lblInQuantity" runat="server" 
                                                    meta:resourcekey="lblInQuantityResource1" Text="Raised to Location Inhand Quantity"></asp:Label>
                                            </td>
                                            <td ID="Td26" runat="server" class="w-10p">
                                                <asp:Label ID="lblQuantity2" runat="server" 
                                                    meta:resourcekey="lblQuantity2Resource1" Text="Quantity"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td ID="Td25" runat="server" >
                                                <asp:TextBox ID="txtProductName" runat="server" CssClass="medium" 
                                                    meta:resourcekey="txtProductNameResource1" 
                                                    OnBlur="javascript:CheckProduct(this);" onkeypress="return ValidateMultiLangChar(this);" 
                                                    Onkeydown="javascript:ProductsOnBlur(event,this);"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" 
                                                    CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" 
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" 
                                                    EnableCaching="False" Enabled="True" FirstRowSelected="True" 
                                                    MinimumPrefixLength="2" OnClientItemSelected="OnSelectProducts" 
                                                    OnClientPopulated="SetColor" ServiceMethod="getProductListJSON" 
                                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" 
                                                    TargetControlID="txtProductName">
                                                </ajc:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnProductID" runat="server" />
                                            </td>
                                            
                                            <td ID="Td29" runat="server" class="">
                                                <asp:TextBox ID="txtUnit" runat="server" CssClass="small" Enabled="False" 
                                                    meta:resourcekey="txtUnitResource1" onkeypress="return ValidateSpecialAndNumeric(this);"></asp:TextBox>
                                                <asp:TextBox ID="txtOrderedUnit" runat="server" Enabled="False" 
                                                    meta:resourcekey="txtUnitResource1" onkeypress="return ValidateSpecialAndNumeric(this);" ></asp:TextBox>
                                            </td>
                                            <td >
                                                <asp:TextBox ID="txtCurStock" runat="server" CssClass="small a-right" onkeypress="return ValidateMultiLangChar(this);" Enabled="False"  
                                                    meta:resourcekey="txtCurStockResource1"></asp:TextBox>
                                            </td>
                                            <td ID="txtInhandQty" runat="server" >
                                                <asp:TextBox ID="txtInhandQuantity" runat="server" CssClass="small a-right" onkeypress="return ValidateMultiLangChar(this);" 
                                                    Enabled="False" meta:resourcekey="txtInhandQuantityResource1" Text="0"></asp:TextBox>
                                            </td>
                                            <td ID="Td27" runat="server" >
                                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="small a-right" 
                                                    meta:resourcekey="txtQuantityResource2" onblur="return setaddFocus();" 
                                                    onChange="CalTotQty();" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                                <asp:HiddenField ID="hdnSellingUnit" runat="server" />
                                                <asp:HiddenField ID="hdnBatchNo" runat="server" />
                                                <asp:HiddenField ID="hdnPProductID" runat="server" />
                                                <asp:HiddenField ID="hdnLocationID" runat="server" />
                                                <asp:HiddenField ID="hdnToOrgID" runat="server" />
                                                <asp:HiddenField ID="hdnToLocationID" runat="server" />
                                                <asp:HiddenField ID="CtConfig" runat="server" />
                                            </td>
                                            
                                            <td ID="TdlblPackSize" runat="server" class="">
                                                <asp:Label ID="lblPackSize" runat="server" 
                                                    meta:resourcekey="lblPackSizeResource1" Text="Pack Size"></asp:Label>
                                            </td>
                                            <td ID="TdTxtPackSize" runat="server" class="">
                                                <asp:TextBox ID="txtPackSize" runat="server" Enabled="False" onkeypress="return ValidateMultiLangChar(this);" 
                                                    meta:resourcekey="txtPackSizeResource1" Width="70px"></asp:TextBox>
                                            </td>
                                            <td ID="TdlblTotQty" runat="server" class="">
                                                <asp:Label ID="lblTotQty" runat="server" meta:resourcekey="lblTotQtyResource1" 
                                                    Text="Tot Qty"></asp:Label>
                                            </td>
                                            <td ID="TdtxtTotQty" runat="server">
                                                <asp:TextBox ID="txtTotQty" runat="server" Enabled="False" onkeypress="return ValidateMultiLangChar(this);"
                                                    meta:resourcekey="txtTotQtyResource1" CssClass="mini"></asp:TextBox>
                                            </td>
                                            <td ID="Td30" runat="server" class="a-center">
                                                <input ID="add" class="btn" name="add" 
                                                    onclick="javascript:return fn_checkValidation();"                                                     
                                                    type="button" value="<%=Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_17%>" />
                                            </td>
                                        </tr>
                                    
                                    </table>
                                
                                </div>
                            
                            </td>
                            
                        </tr>
                        <tr class="hide" id="trProtocol" runat="server">
                            <td id="Td31" class="w-10p" runat="server">
                                <asp:Label ID="lblProtoName" runat="server" Text="Protocol Name" meta:resourcekey="lblProtoNameResource1"></asp:Label>
                            </td>
                            <td id="Td32" class="w-24p" runat="server">
                                <asp:TextBox ID="txtProtocolName" runat="server" CssClass="large" onkeypress="return ValidateMultiLangChar(this);" Onkeydown="javascript:ClearProductsValues();"
                                    OnBlur="javascript:CheckProduct(this);" 
                                    meta:resourcekey="txtProtocolNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct1" runat="server" TargetControlID="txtProtocolName"
                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="getProtocolList"
                                    OnClientItemSelected="OnSelectProtocols" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                            </td>
                            <td id="Td33" class="w-10p" runat="server">
                                <asp:Label ID="lblNumbeofSubject" runat="server" Text="Number of Subjects" meta:resourcekey="lblNumbeofSubjectResource1"></asp:Label>
                            </td>
                            <td id="Td34" class="w-12p" runat="server">
                                <asp:TextBox ID="txtNoOfPatient" Text="0" runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);" 
                                    meta:resourcekey="txtNoOfPatientResource1"></asp:TextBox>
                            </td>
                            <td id="Td35" runat="server" colspan="2">
                                <asp:Button ID="btnViewEpiDetails" runat="server" Text="View Details" OnClick="btnViewEpiDetails_Click"
                                    OnClientClick="return fn_checkKitValidation();" CssClass="btn" meta:resourcekey="btnViewEpiDetailsResource1" />
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="UpdtPnlTOD" runat="server">
                                    <ContentTemplate>
                                        <table id="tblOrederedItems" class="w-100p responstable">
                                        </table>
                                        <input type="hidden" id="hdnProductList" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
                <table>
                    <tr>
                        <td>
                            <asp:GridView ID="GrdEpisodeDetails" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                OnRowDataBound="GrdEpisodeDetails_RowDataBound" EmptyDataText="Protocol Not found for on behalf of CT Site"
                                meta:resourcekey="GrdEpisodeDetailsResource2">
                                <HeaderStyle CssClass="gridHeader" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource14">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkVisit" runat="server" Checked="True" meta:resourcekey="chkVisitResource2" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Site Name" meta:resourcekey="TemplateFieldResource15">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("SiteName") %>' meta:resourcekey="lblProductNameResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Visit Name" meta:resourcekey="TemplateFieldResource16">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVisitName" runat="server" Text='<%# Eval("EpisodeVisitName") %>'
                                                meta:resourcekey="lblVisitNameResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Kit Name" meta:resourcekey="TemplateFieldResource17">
                                        <ItemTemplate>
                                            <asp:Label ID="lblKitName" Width="80px" runat="server" Text='<%# Eval("PackageDetails") %>'
                                                meta:resourcekey="lblKitNameResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Allowable Qty" meta:resourcekey="TemplateFieldResource18">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNoOfKits" Width="80px" runat="server" meta:resourcekey="lblNoOfKitsResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Raised Qty" meta:resourcekey="TemplateFieldResource19">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRaisedKits" runat="server" Text='<%# Eval("RaisedQty") %>' Width="80px"
                                                meta:resourcekey="lblRaisedKitsResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="To-be Raised Qty" meta:resourcekey="TemplateFieldResource20">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNoOfKits" runat="server" onkeypress="return ValidateMultiLangChar(this);" onblur="ChecRaisedkQty();" CssClass="mini"
                                                meta:resourcekey="txtNoOfKitsResource2"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stock In Hand" meta:resourcekey="TemplateFieldResource21">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStockInhand" Width="80px" runat="server" meta:resourcekey="lblStockInhandResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Units" meta:resourcekey="TemplateFieldResource22">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUnit" Width="80px" runat="server" meta:resourcekey="lblUnitResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="KidID" meta:resourcekey="TemplateFieldResource23">
                                        <ItemTemplate>
                                            <asp:Label ID="lblKitID" Width="80px" runat="server" meta:resourcekey="lblKitIDResource2"></asp:Label>
                                            <asp:HiddenField ID="hdnNoOfsites" runat="server" Value='<%# Eval("FeeID") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SiteID" meta:resourcekey="TemplateFieldResource24">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSitID" Width="80px" runat="server" Text='<%# Eval("SiteID") %>'
                                                meta:resourcekey="lblSitIDResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EpisodeVisitID" meta:resourcekey="TemplateFieldResource25">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEpisodeVisitId" Width="80px" runat="server" Text='<%# Eval("EpisodeVisitId") %>'
                                                meta:resourcekey="lblEpisodeVisitIdResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ParentProductID" meta:resourcekey="TemplateFieldResource26">
                                        <ItemTemplate>
                                            <asp:Label ID="lblParentProductID" Width="80px" runat="server" meta:resourcekey="lblParentProductIDResource2"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <table class="w-100p a-center marginT15" cellpadding="3" cellspacing="2">
                    <tr id="trSubmit" runat="server">
                        <td id="Td36" runat="server">
                            <asp:Button ID="btnRaiseIntend" runat="server" OnClientClick="return checkKitdetails();"
                                CssClass="btn" Text="Submit" OnClick="btnRaiseIntend_Click" meta:resourcekey="btnRaiseIntendResource1" />
                            &nbsp;
                            <asp:Button ID="btnBack" runat="server" Text="Indent Home" CssClass="cancel-btn" OnClick="btnBack_Click"
                                meta:resourcekey="btnBackResource1" />
                        </td>
                    </tr>
                    <tr id="trApproveBlock" class="hide searchPanel" runat="server">
                        <td id="Td37" runat="server">
                            <asp:Button ID="btnBackapp" Text="Back" runat="server" CssClass="cancel-btn"
                                OnClick="btnBack_Click" meta:resourcekey="btnBackappResource1" />
                            &nbsp;&nbsp;
                            <asp:Button ID="btnApprove" Text="Approve Indent" runat="server"
                                CssClass="btn" OnClientClick="return funexits();"
                                CommandArgument="ApproveIntend" OnClick="btnApproveIntend_Click" meta:resourcekey="btnApproveResource1" />
                            &nbsp;&nbsp;
                            <asp:Button ID="btnCancelIntend" Text="Cancel Indent" runat="server"
                                CssClass="cancel-btn" CommandArgument="CancelIntend"
                                OnClick="btnCancelIntend_Click" meta:resourcekey="btnCancelIntendResource1" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdncontrols" runat="server" />
                <asp:HiddenField ID="hdnProtocalID" runat="server" />
                <asp:HiddenField ID="hdnNoOfPatient" runat="server" />
                <asp:HiddenField ID="hdnKitID" runat="server" />
                <asp:HiddenField ID="hdnKitName" runat="server" />
                <asp:HiddenField ID="hdnUnits" runat="server" />
                <asp:HiddenField ID="hdnKitstudyDetails" runat="server" />
                <asp:HiddenField ID="hdnSiteID" runat="server" />
                <asp:HiddenField ID="hdnintID" runat="server" />
                <asp:HiddenField ID="hdnKitList" runat="server" />
                <asp:HiddenField ID="hdnIndentId" runat="server" />
                <input type="hidden" id="hdnReceivedOrgID" runat="server" />
                <input type="hidden" id="hdnlocation" runat="server" />
                <input type="hidden" id="hdnRowEdit" runat="server" />
                <input type="hidden" id="hdnSelectLocation" runat="server" />
                <input type="hidden" id="hdnSelectOrgid" runat="server" />
                <input type="hidden" id="hdnSelectBehalfOfOrgid" runat="server" />
                <input type="hidden" id="hdnBehalfOflocation" runat="server" />
                <input type="hidden" id="hdnBehalfOfSelectLocation" runat="server" />
                <input type="hidden" id="hdnIsCtParentOrg" runat="server" />
                <input type="hidden" id="hdnProductsList" runat="server" />
                <input type="hidden" id="hdnKitIDs" runat="server" />
                <input type="hidden" id="hdnParentOrgID" runat="server" />
                <input type="hidden" id="hdnAutomaticPO" value="N" runat="server" />
                <input type="hidden" id="hdnInventoryLocationID" runat="server" />
                <input type="hidden" id="hdnEnablePackSize" runat="server" />
                <input type="hidden" id="hdnRejectionStatus" value="N" runat="server" />
                <input type="hidden" id="hdnTotalqty" runat="server" />
                <input type="hidden" id="hdnPdtRcvdDtlsID" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
     <asp:HiddenField ID="hdnTempvalue" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        var lstProductLst = [];     
        //-------------Mani--------
        $(document).ready(function() {
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'RaiseIntend') {
                $("#Attuneheader_TopHeader1_lblvalue").text("Raise Indent");

                //document.getElementById('txtUnit').style.display = 'block';
                //document.getElementById('txtOrderedUnit').style.display = 'none';
                $('#txtUnit').removeClass().addClass('show');
                $('#txtOrderedUnit').removeClass().addClass('hide');

                
                if ($("#hdnEnablePackSize").val() == 'Y') {
                    //document.getElementById('txtUnit').style.display = 'none';
                    //document.getElementById('txtOrderedUnit').style.display = 'block';
                    $('#txtUnit').removeClass().addClass('hide');
                    $('#txtOrderedUnit').removeClass().addClass('show');
                
                }
                if ($('#hdnRejectionStatus').val() == 'Y') {
                    var pvalue = '<%=Request.QueryString["intID"]%>';
                    if (pvalue != '') {
                        $('#ddlLocation').val($('#hdnToLocationID').val());
                        Tblist();
                    }
                }
            }
        });
        //----------End------------

        function setaddFocus() {
            document.getElementById('add').focus();
            return false;
        }

        function BindProductList() {
            var objAdd = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03') == null ? "Add" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03');
            var objUpdate = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Update" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02');

            if (document.getElementById('add').value == objUpdate) {
                var editData = JSON.parse($('#hdnRowEdit').val());
                if (editData != "") {
                   var arrF = $.grep(lstProductLst, function(n, i) {
                      return n.ProductID != editData.ProductID;
                  });
                  lstProductLst = [];
                  lstProductLst = arrF;
                }                
               // Deleterows();
            }
           // else {
                var pName = document.getElementById('txtProductName').value.trim();
                var pProductId = document.getElementById('hdnProductID').value;
                //Convert To Internal Formate//
                //var pInhandQTY = document.getElementById('txtInhandQuantity').value;
                var pInhandQTY = ToInternalFormat($('#txtInhandQuantity')); // ToTargetFormat($('#txtInhandQuantity'));
                var pParerProductId = document.getElementById('hdnPProductID').value;
                var pUnit = document.getElementById('txtUnit').value;
                var pOrderedUnit = document.getElementById('txtOrderedUnit').value;
                var packSize = document.getElementById('txtPackSize').value;
                //var pQTY = document.getElementById('txtQuantity').value;
                var pQTY = ToInternalFormat($('#txtQuantity')); // ToTargetFormat($('#txtQuantity'));
                var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
                var pTotQTY;
                if (document.getElementById('hdnEnablePackSize').value == 'Y') {
                    pTotQTY = parseInt(pQTY) * parseInt(packSize);                   
                }
                else {
                    pTotQTY = parseInt(pQTY);
                }
                var objProd = new Object();
                objProd.ProductID = pProductId;
                objProd.ProductName = escape(pName);
                objProd.InHandQuantity = pInhandQTY;
                objProd.ParentProductID = pParerProductId;
                objProd.SellingUnit = pUnit;
                objProd.Quantity = pQTY;
                objProd.OrderedConvertUnit =Number(packSize);
                objProd.TotalQty = pTotQTY;
                objProd.OrderedUnit = pOrderedUnit;
				objProd.Status= "";
                objProd.CurStock = ToInternalFormat($('#txtCurStock'));
                lstProductLst.push(objProd);              
                $('#hdnProductList').val(JSON.stringify(lstProductLst));
           //     document.getElementById('hdnProductList').value += pName + "~" + pProductId + "~" +
                    //   pInhandQTY + "~" + pParerProductId + "~" + pUnit + "~" + pQTY + "~" + packSize + "~" + pTotQTY + "~" + pOrderedUnit + "~" + pPdtRcvdDtlsID + "^";

               
                Tblist();
                document.getElementById('txtProductName').value = "";
                document.getElementById('hdnProductID').value = 0;
                document.getElementById('txtInhandQuantity').value = 0;
                //ToTargetFormat($('#txtInhandQuantity'));
                document.getElementById('txtUnit').value = "";
                document.getElementById('txtOrderedUnit').value = "";
                document.getElementById('hdnSellingUnit').value = "";
                document.getElementById('txtQuantity').value = 0;
                document.getElementById('hdnPProductID').value = 0;
                document.getElementById('txtTotQty').value = "";
                document.getElementById('hdnPdtRcvdDtlsID').value = 0;
                $("#txtCurStock").val(0);
            //}
            document.getElementById('add').value = objAdd;
            document.getElementById('txtProductName').value = "";
            document.getElementById('txtInhandQuantity').value = 0;
            //ToTargetFormat($('#txtInhandQuantity'));
            document.getElementById('txtUnit').value = "";
            document.getElementById('txtOrderedUnit').value = "";
            document.getElementById('txtQuantity').value = 0;
            document.getElementById('txtPackSize').value = 0;
            document.getElementById('txtTotQty').value = "";


        }
        function Tblist() {
            var objSno = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_04') == null ? "S.No." : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_04');
            var objProduct = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_05') == null ? "Product Name" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_05');
            var objraise = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_06') == null ? "Raised to Location Inhand Quantity" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_06');
            var objRaiseQuan = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_07') == null ? "Raised Quantity" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_07');
            var objUnit = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_08') == null ? "Unit" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_08');
            var objTotal = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_09') == null ? "Total Qty" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_09');
            var objAction = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_18') == null ? "Action" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_18');
          
          /*  while (count = document.getElementById('tblOrederedItems').rows.length) {
                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    document.getElementById('tblOrederedItems').deleteRow(j);
                }
            } */
            $("#tblOrederedItems tr").remove();
           // var x = document.getElementById('hdnProductList').value.split("^");

            //var pCount = x.length;
            // pCount = pCount - 1;
            var pCount = lstProductLst.length;
            
            if (pCount > 0) {
                var Headrow = document.getElementById('tblOrederedItems').insertRow(0);

                Headrow.id = "HeadID";
                Headrow.className = "a-center responstableHeader animated fadeIn"
                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);
                var cell5 = Headrow.insertCell(4);


                cell1.innerHTML = objSno;
                cell2.innerHTML = objProduct;
                cell3.innerHTML = objraise;
                cell4.innerHTML = objRaiseQuan;
                cell5.innerHTML = objUnit;
                var hdnPack = document.getElementById('hdnEnablePackSize').value
                if (hdnPack == 'Y') {
                    var cell6 = Headrow.insertCell(5);
                    cell6.innerHTML = objTotal;
                    var cell7 = Headrow.insertCell(6);
                }
                else {
                    var cell7 = Headrow.insertCell(5);
                }

                cell7.innerHTML = objAction;

               
               // for (i = 0; i < x.length; i++) {
                   // if (x[i] != "") {
                       // y = x[i].split('~');
                $.each(lstProductLst, function(obj, value) {
                    var row = document.getElementById('tblOrederedItems').insertRow(1);
                    row.style.height = "13px";
                    //row.addClass("h-13");
                    row.className = "v-middle animated fadeIn";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    cell1.className = "w-10p";
                    cell2.className = "w-30p";
                    cell3.className = "w-15p a-right";
                    cell4.className = "w-15p a-right";
                    cell5.className = "w-15p";

                    cell1.innerHTML = pCount;
                    cell2.innerHTML =unescape(value.ProductName); //y[0];
                    $('#hdnTempvalue').val(value.InHandQuantity);
                    cell3.innerHTML = ToTargetFormat($('#hdnTempvalue')); //y[2];
                    $('#hdnTempvalue').val(value.Quantity);
                    cell4.innerHTML = ToTargetFormat($('#hdnTempvalue')); //y[5];
                    cell5.innerHTML = value.SellingUnit; //y[4];
                    if (hdnPack == 'Y') {
                        var cell6 = row.insertCell(5);
                        cell5.innerHTML = value.OrderedUnit; //y[8];
                        cell6.className = "w-15p";
                        $('#hdnTempvalue').val(value.Quantity * value.OrderedConvertUnit);
                        cell6.innerHTML = ToTargetFormat($('#hdnTempvalue')) + "(" + value.SellingUnit + ")"; // y[5] * y[6] + "(" + y[4] + ")";
                        var cell7 = row.insertCell(6);
                        cell7.className = "w-15p v-middle a-center";
                        cell7.innerHTML = "<input name='edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_10%>' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left'  />" +
                        "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_11%>' type='button' Class='ui-icon ui-icon-trash b-none pointer pull-left'  />"

                        //  cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnEdit_OnClick(name);' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_10%>' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left'  />" +
                        // "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnDelete(name);' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_11%>' type='button' Class='ui-icon ui-icon-trash b-none pointer pull-left'  />"

                    }
                    else {
                        var cell7 = row.insertCell(5);
                        cell7.className = "w-15p v-middle a-center";
                        // cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnEdit_OnClick(name);' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_10%>' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left'  />" +
                        // "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnDelete(name);' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_11%>' type='button' Class='ui-icon ui-icon-trash b-none pointer pull-left'  />"
                        cell7.innerHTML = "<input name='edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_10%>' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left'  />" +
                        "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '<%= Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_11%>' type='button' Class='ui-icon ui-icon-trash b-none pointer pull-left'  />"

                    }
                    //}
                    pCount = pCount - 1;
                });
               //}
//                document.getElementById('btnRaiseIntend').style.display = "show";
//                document.getElementById('btnBack').style.display = "show";
            }
//            else {
//                document.getElementById('btnRaiseIntend').style.display = "hide";
//                document.getElementById('btnBack').style.display = "hide";
//                
//                

//            }
            document.getElementById('txtProductName').value = "";
            document.getElementById('hdnProductID').value = 0;
            document.getElementById('txtInhandQuantity').value = 0;
            //ToTargetFormat($('#txtInhandQuantity'));
            document.getElementById('txtUnit').value = "";
            document.getElementById('txtOrderedUnit').value = "";
            document.getElementById('hdnSellingUnit').value = "";
            document.getElementById('hdnBatchNo').value = "";
            document.getElementById('hdnPProductID').value = 0;
            //document.getElementById('txtProductName').focus();
            document.getElementById('txtQuantity').value = 0;
            document.getElementById('hdnPdtRcvdDtlsID').value = 0;
            
        }

     /*   function Deleterows() {
            //Internal Format//
            var objAdd = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03') == null ? "Add" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03');
            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnProductList').value.split("^");
            if (RowEdit != "") {
                var pName = document.getElementById('txtProductName').value.trim();
                var pProductId = document.getElementById('hdnProductID').value;
                var pInhandQTY = ToTargetFormat($('#txtInhandQuantity'));
                var pParerProductId = document.getElementById('hdnPProductID').value;
                var pUnit = document.getElementById('txtUnit').value;
                var pOrderedUnit = document.getElementById('txtOrderedUnit').value;
                var pQTY = ToTargetFormat($('#txtQuantity'));
                var packSize = ToTargetFormat($('#txtPackSize'));
                var TotQty = ToTargetFormat($('#txtTotQty'));

                var hdnPack = document.getElementById('hdnEnablePackSize').value
//                if (hdnPack == 'Y') {
                    document.getElementById('hdnProductList').value = pName + "~" + pProductId + "~" +
                        pInhandQTY + "~" + pParerProductId + "~" + pUnit + "~" + pQTY + "~" + packSize + "~" + TotQty + "~" + pOrderedUnit + "~" + "" + "^";
//                }
//                else {
//                    document.getElementById('hdnProductList').value = pName + "~" + pProductId + "~" +
//                        pInhandQTY + "~" + pParerProductId + "~" + pUnit + "~" + pQTY + "~" + packSize + "^";
//                }

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById('hdnProductList').value += x[i] + "^";
                        }
                    }
                }
                Tblist();
                document.getElementById('txtProductName').value = "";
                document.getElementById('hdnProductID').value = 0;
                document.getElementById('txtInhandQuantity').value = 0;
                //ToTargetFormat($('#txtInhandQuantity'));
                document.getElementById('txtUnit').value = "";
                document.getElementById('txtOrderedUnit').value = "";
                document.getElementById('hdnSellingUnit').value = "";
                document.getElementById('txtQuantity').value = 0;
                document.getElementById('hdnPProductID').value = 0;
                document.getElementById('txtQuantity').value = 0;
                document.getElementById('txtPackSize').value = 0;
                document.getElementById('txtTotQty').value = 0;
                document.getElementById('add').value = objAdd;
                document.getElementById('hdnPdtRcvdDtlsID').value = 0;
            }
        }*/

        function btnEdit_OnClick(sEditedData) {
            var objUpdate = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Update" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02');
            document.getElementById('txtProductName').value =unescape(sEditedData.ProductName);
            document.getElementById('hdnProductID').value = sEditedData.ProductID;
            document.getElementById('txtInhandQuantity').value = sEditedData.InHandQuantity;
            ToTargetFormat($('#txtInhandQuantity'));                  
            document.getElementById('txtUnit').value = sEditedData.SellingUnit;
            document.getElementById('hdnPProductID').value = sEditedData.ParentProductID;
            document.getElementById('txtQuantity').value = sEditedData.Quantity;
            ToTargetFormat($('#txtQuantity'));
            document.getElementById('txtPackSize').value = sEditedData.OrderedConvertUnit;                                   
            document.getElementById('txtOrderedUnit').value = sEditedData.pOrderedUnit;
            document.getElementById('txtTotQty').value = sEditedData.TotalQty;
            ToTargetFormat($('#txtTotQty'));
            document.getElementById('txtCurStock').value = sEditedData.CurStock;
            ToTargetFormat($('#txtCurStock'));
            document.getElementById('add').value = objUpdate;
            document.getElementById('hdnRowEdit').value =JSON.stringify(sEditedData);
                            
            
           /* var y = sEditedData.split('~');
            document.getElementById('txtProductName').value = y[0];
            document.getElementById('hdnProductID').value = y[1];
            document.getElementById('txtInhandQuantity').value = y[2];
            //ToTargetFormat($('#txtInhandQuantity'));
            document.getElementById('txtUnit').value = y[4];
            document.getElementById('hdnPProductID').value = y[3];
            document.getElementById('txtQuantity').value = y[5];
            document.getElementById('txtPackSize').value = y[6];
            document.getElementById('add').value = 'Update';
            document.getElementById('hdnRowEdit').value = sEditedData;
            var hdnPack = document.getElementById('hdnEnablePackSize').value
            document.getElementById('txtOrderedUnit').value = y[8];
            if (hdnPack == 'Y') {
                document.getElementById('txtTotQty').value = y[7];
            }
            else
                document.getElementById('txtTotQty').value = y[5]; */

        }

        function btnDelete(sEditedData) {
            // var index = lstProductLst.indexOf(sEditedData);
			var index = lstProductLst.findIndex(x => x.ProductID ==sEditedData.ProductID && x.ParentProductID==sEditedData.ParentProductID);
            lstProductLst.splice(index, 1);
            $('#hdnProductList').val(JSON.stringify(lstProductLst));

           /* var i;
            var x = document.getElementById('hdnProductList').value.split("^");
            document.getElementById('hdnProductList').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnProductList').value += x[i] + "^";
                    }
                }
            }*/
            Tblist();
            clearEditControls();
            
        }

        function clearEditControls() {
            var objAdd = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03') == null ? "Add" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_03');
            document.getElementById('txtProductName').value = "";
            document.getElementById('txtCurStock').value = "0";
            document.getElementById('txtQuantity').value = "0";
            document.getElementById('txtUnit').value = "";
            document.getElementById('txtOrderedUnit').value="";
            document.getElementById('txtPackSize').value = "";
            document.getElementById('txtTotQty').value = "";           
            document.getElementById('add').value = objAdd;
        }
        
    </script>

    <script type="text/javascript" language="javascript">
        function ShowAlertMsg(key) {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_05') == null ? "Select atleast one product" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_05');
            ValidationWindow(userMsg, ErrMsg);
            return true;
        }

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

        });



        function funexits() {
            if (document.getElementById('ddlTrustedOrg').value == "" || document.getElementById('ddlTrustedOrg').value == 0) {
                var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_06') == null ? "Select Organization name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_06');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }

            if (document.getElementById('ddlLocation').value == "" || document.getElementById('ddlLocation').value == 0) {
                var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_07') == null ? "Select location name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_07');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }

            if (document.getElementById('ddlOnBehalfOf').value == "" || document.getElementById('ddlOnBehalfOf').value == 0) {
               
            }
            if (document.getElementById('ddlLocation').value == document.getElementById('ddlOnBehalfOf').value) {
                var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_08') == null ? "Raise Indent has same Location" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_08');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlOnBehalfOf').focus();
                return false;
            }

            if (document.getElementById('hdnProductList').value == "" || document.getElementById('hdnKitList').value == "") {
                if (document.getElementById('hdnProductList').value == "" && document.getElementById('rdProduct').checked) {
                    var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_09') == null ? "Enter product name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_09');
                    ValidationWindow(userMsg, ErrMsg); 
                    document.getElementById('txtProductName').focus();
                    return false;
                }
                if (document.getElementById('hdnKitList').value == "" && document.getElementById('rdProtocol').checked) {
                    var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_10') == null ? "Enter Protocol name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_10');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProtocolName').focus();
                    return false;
                }
            }


            //document.getElementById('btnRaiseIntend').style.display = "hide";
            $('#btnRaiseIntend').removeClass().addClass('hide');


        }

        function locationdetails() {

            var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
            if (Trustedorgid > 0) {

                document.getElementById('hdnSelectOrgid').value = Trustedorgid;
            }

            var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;
            if (Fromlocationid > 0) {
                document.getElementById('hdnSelectLocation').value = Fromlocationid;
            }

            if (document.getElementById('hdnSelectOrgid').value == document.getElementById('hdnSelectBehalfOfOrgid').value) {
                if (document.getElementById('hdnSelectLocation').value = document.getElementById('hdnBehalfOfSelectLocation').value) {
                    var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11') == null ? "Select Different Location name for Raise Indent and On BehalfOf" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlLocation').focus();
                    return false;
                }
            }
            if (Trustedorgid > 0 && Fromlocationid > 0) {
                var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
                var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini;
                $find('AutoCompleteProduct1').set_contextKey(sval);
                // $find('AutoCompleteProduct1').set_contextKey(sval);
            }

        }

        function BehalfOflocationdetails() {

            var Trustedorgid = document.getElementById('ddlBehalfOfTrustedOrg').options[document.getElementById('ddlBehalfOfTrustedOrg').selectedIndex].value;
            if (Trustedorgid > 0) {

                document.getElementById('hdnSelectBehalfOfOrgid').value = Trustedorgid;

            }

            var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;
            if (Fromlocationid > 0) {
                document.getElementById('hdnBehalfOfSelectLocation').value = Fromlocationid;
            }

            if (document.getElementById('hdnSelectOrgid').value == document.getElementById('hdnSelectBehalfOfOrgid').value) {
                if (document.getElementById('ddlLocation').value == document.getElementById('ddlOnBehalfOf').value) {
                    var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11') == null ? "Select Different Location name for Raise Indent and On BehalfOf" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlOnBehalfOf').focus();
                    return false;
                }
            }
            var currentLocationid = document.getElementById('ddlOnBehalfOf').value;
            if (Trustedorgid > 0 && Fromlocationid > 0) {
                var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
                 var pIsConsign=$('#ChkIsConsign').prop('checked')==true ? "Y" : "N";
                var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini + '~' + currentLocationid + '~' + pIsConsign;
                //$find('AutoCompleteProduct').set_contextKey(sval);
                $find('AutoCompleteProduct').set_contextKey(sval);
            }

        }
        function setBehalfOflocationdetails(objval) {
            document.getElementById('ddlOnBehalfOf').value = objval;
        }
        function Setlocation() {

            if (document.getElementById('hdnSelectLocation').value > 0) {
                document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value = document.getElementById('hdnSelectLocation').value;
            }
        }

        var productName;


        function GetText(pBrandName) {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            if (pBrandName != "") {
                var Temp = pBrandName.split('^');
                if (Temp.length > 1) {
                    document.getElementById('txtProductName').value =unescape(Temp[0]);
                    document.getElementById('hdnProductID').value = Temp[1];
                    if (document.getElementById('txtProductName').value == "undefined") {
                        document.getElementById('txtProductName').focus();
                        var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_12') == null ? "Product name does not exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_12');
                        ValidationWindow(userMsg, ErrMsg);
                        return false;
                    }
                }
                else {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_13') == null ? "Product name does not exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_13');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProductName').focus();
                    document.getElementById('txtProductName').value = '';
                    return false;
                }
            }
        }

        function CheckProduct(pName) {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            var projectionGrid = document.getElementById('gvIntendProjectionList');
            if (projectionGrid != null) {
                for (var i = 1; i < projectionGrid.rows.length; i++) {
                    if ((projectionGrid.rows[i].cells[1].innerText).trim().toUpperCase() == pName.value.trim().toUpperCase()) {
                        document.getElementById('txtProductName').focus();
                        var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_14') == null ? "Product already exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_14');
                        ValidationWindow(userMsg, ErrMsg);
                        pName.value = "";
                        return false;
                    }
                }
            }
        }
        function CheckPrStatus(IntendId) {
            alert("Those Products are directly goes to auto approval");
            window.location = "../StockIntend/ViewIntendDetail.aspx?intID=" + IntendId;
        }


        /*Colour change for Trusted Drugs start*/
        function SetColor() {

            var completionList = $find("AutoCompleteProduct").get_completionList().childNodes;
            var HighlightProduct = '';
            var _Color = '';
            for (var i = 0; i < completionList.length; i++) {
                //_Color = completionList[i]._value.split('^');
                _Color = JSON.parse(completionList[i]._value);
                if (_Color != undefined && _Color != '') {
                    HighlightProduct = _Color.ProductColour;
                } else {
                    HighlightProduct = 'N';
                }
                if (HighlightProduct == 'Y') {
                    completionList[i].style.color = "orange";
                }
            }
        }
        /*Colour change for Trusted Drugs End*/

        function CheckQuantity(qty) {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            if (qty.value == "") {
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_15') == null ? "Provide the product quantity" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_15');
                ValidationWindow(userMsg, ErrMsg);
                qty.focus();
                return;
            }
            else {
                productName = document.getElementById('txtProductName').value;
            }
        }

        function fn_checkKitValidation() {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            if (document.getElementById('CtConfig').value != "Y") {
                if (document.getElementById('ddlTrustedOrg').value == "" || document.getElementById('ddlTrustedOrg').value == 0) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_16') == null ? "Select Raise Indent To Organization" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_16');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlTrustedOrg').focus();
                    return false;
                }

                if (document.getElementById('ddlLocation').value == "" || document.getElementById('ddlLocation').value == 0) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_17') == null ? "Select Raise Indent To Store" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_17');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlLocation').focus();
                    return false;
                }

                if (document.getElementById('ddlBehalfOfTrustedOrg').value == "" || document.getElementById('ddlBehalfOfTrustedOrg').value == 0) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_18') == null ? "Select Indent Raised On Behalf Of Organization" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_18');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlBehalfOfTrustedOrg').focus();
                    return false;
                }
                if (document.getElementById('ddlOnBehalfOf').value == "" || document.getElementById('ddlOnBehalfOf').value == 0) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_19') == null ? "Select Indent Raised On Behalf Of Site" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_19');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlOnBehalfOf').focus();
                    return false;
                }
                if (document.getElementById('ddlLocation').value == document.getElementById('ddlOnBehalfOf').value) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_20') == null ? "Select Different Sites for Raise and On Behalf Of" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_20');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('ddlOnBehalfOf').focus();
                    return false;
                }
                if (document.getElementById('txtProtocolName').value.trim() == "") {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21') == null ? "Provide Protocol name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProtocolName').focus();
                    return false;
                }
                if (document.getElementById('hdnProtocalID').value == "") {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21') == null ? "Provide Protocol name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProtocolName').focus();
                    return false;
                }

                return true;
            }
            else {
                if (document.getElementById('hdnInventoryLocationID').value == '') {
                    if (document.getElementById('txtLocations').value == '') {
                        var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_22') == null ? "Select the Site for Raise Indent " : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_22');
                        ValidationWindow(userMsg, ErrMsg);
                        document.getElementById('txtLocations').focus();
                        return false;
                    }
                }
                if (document.getElementById('txtProtocolName').value.trim() == "") {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21') == null ? "Provide Protocol name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProtocolName').focus();
                    return false;
                }
                if (document.getElementById('hdnProtocalID').value == "") {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21') == null ? "Provide Protocol name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_21');
                    ValidationWindow(userMsg, ErrMsg); 
                    document.getElementById('txtProtocolName').focus();
                    return false;
                }

                return true;
            }
        }
        function fn_checkValidation() {
            var objUpdate = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Update" : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_02');
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            if (document.getElementById('txtProductName').value.trim() == "") {
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_23') == null ? "Provide product name" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_23');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtProductName').focus();
                return false;
            }

            if (document.getElementById('hdnProductID').value.trim() == "" || document.getElementById('hdnProductID').value < 0) {
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_24') == null ? "Product name does not exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_24');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtProductName').focus();
                document.getElementById('txtProductName').value = "";
                return false;
            }

            if (document.getElementById('txtQuantity').value.trim() == "" || document.getElementById('txtQuantity').value == 0) {
                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_25') == null ? "Provide the product quantity" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_25');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtQuantity').focus();
                return false;
            }
            if (document.getElementById('add').value != objUpdate) {
                var pProductId = document.getElementById('hdnProductID').value;
                var arrF = $.grep(lstProductLst, function(n, i) {
                    return n.ProductID==pProductId;
                });
                if (arrF.length > 0) {
                    var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_26') == null ? "Product Name already exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_26');
                    ValidationWindow(userMsg, ErrMsg);
                    document.getElementById('txtProductName').value = '';
                    document.getElementById('txtProductName').focus();
                    return false;
                }
            }
            
           /* if (document.getElementById('add').value != objUpdate) {
                var x = document.getElementById('hdnProductList').value.split("^");
                var pProductId = document.getElementById('hdnProductID').value;
                var pName = document.getElementById('txtProductName').value.trim();
                var y; var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[1] == pProductId && y[0] == pName) {
                            var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_26') == null ? "Product Name already exist" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_26');
                            ValidationWindow(userMsg, ErrMsg);
                            document.getElementById('txtProductName').value = '';
                            document.getElementById('txtProductName').focus();
                            return false;
                        }
                    }
                }
            }*/
            BindProductList();
            return true;
        }

        function OnSelectProducts(source, eventArgs) {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            var okMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_03') == null ? "Ok" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_03');
            var cancelMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_04') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_04');
            var objSelected = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_29') == null ? "Selected " : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_29');
            /*var pval = eventArgs.get_value().split('~');
            var AvilableQty = pval[7];
            var ReorderQty = pval[10];
            var tQty = pval[5];
            var tID = pval[1];
            var tUnit = pval[2];
            var tBatchNo = '';
            var tParentProductID = pval[3];
            var tIsBannedProduct = pval[4];
            var tName = pval[0].split('^^');
            var tCurStock = pval[7];
            var tPackSoze = pval[8];
            var tPackunti = pval[9];
            var ProductReceivedDetailsID = pval[11]; */
            var pval = JSON.parse(eventArgs.get_value());
            var AvilableQty = pval.CurStock;
            var ReorderQty = pval.ReorderQuantity;
            var tQty = pval.StockInHand; 
            var tID = pval.ProductID;
            var tUnit = pval.LSU;
            var tBatchNo = '';
            var tParentProductID = pval.ParentProductID;
            var tIsBannedProduct = pval.IsTransactionBlock;
            var tName = pval.ProductName;
            var tCurStock = pval.CurStock;
            var tPackSoze = pval.OrderedConvertUnit;
            var tPackunti = pval.OrderedUnit;
          //  var ProductReceivedDetailsID = pval.ProductReceivedDetailsID;

            if (tIsBannedProduct == 'Y') {
                if (ConfirmWindow(objSelected,ErrMsg,okMsg,cancelMsg)) {

                }
                else {
                    document.getElementById('txtProductName').value = '';
                    ClearProductsValues();
                    document.getElementById('txtProductName').focus();
                    return false;
                }
            }
            //Added by petchi for central hospital
            document.getElementById('txtProductName').value =unescape(pval.ProductName);  //tName[0];
            document.getElementById('hdnProductID').value = tID;
            document.getElementById('txtInhandQuantity').value = tQty;
            ToTargetFormat($("#txtInhandQuantity"));
            document.getElementById('txtUnit').value = tUnit;
            document.getElementById('txtOrderedUnit').value = tPackunti;
            document.getElementById('hdnSellingUnit').value = tUnit;
            document.getElementById('hdnBatchNo').value = tBatchNo;
            document.getElementById('hdnPProductID').value = tParentProductID;
            document.getElementById('txtCurStock').value = tCurStock;
            document.getElementById('txtPackSize').value = tPackSoze;
            //document.getElementById('hdnPdtRcvdDtlsID').value = ProductReceivedDetailsID;
           // ToTargetFormat($("#txtPackSize"));
            ToTargetFormat($("#txtCurStock"));
            var hdnPack = document.getElementById('hdnEnablePackSize').value
            if (hdnPack == 'Y') {
                document.getElementById('txtTotQty').value = parseInt(ToInternalFormat($('#txtPackSize'))) * parseInt(ToInternalFormat($('#txtQuantity')));
                //document.getElementById('txtTotQty').value = parseInt(document.getElementById('txtPackSize').value) * parseInt(document.getElementById('txtQuantity').value);
            }
            else
                document.getElementById('txtTotQty').value = parseInt(ToInternalFormat($('#txtQuantity'))) 
               // document.getElementById('txtTotQty').value = parseInt(document.getElementById('txtQuantity').value);

            ToTargetFormat($("#txtTotQty"));

            ProductItemSelected(source, eventArgs);

            if (parseInt(ReorderQty) > parseInt(AvilableQty)) {
                var information = 'Selected product has been reached its reorder level. Do you still wish to use this?';
                var infromMsg = SListForAppMsg.Get("Scripts_Information") == null ? "Information" : SListForAppMsg.Get("Scripts_Information");
                var OkMsg = SListForAppMsg.Get("Scripts_Ok") == null ? "Ok" : SListForAppMsg.Get("Scripts_Ok");
                var CancelMsg = SListForAppMsg.Get("Scripts_Cancel") == null ? "Cancel" : SListForAppMsg.Get("Scripts_Cancel");
                if (ConfirmWindow(information, infromMsg, OkMsg, CancelMsg)) {
                    return true;
                }
                else {
                    document.getElementById('txtProductName').value = '';
                    
                    return false;
                }
            }
            
            
            
        }

        function ClearProductsValues() {

            document.getElementById('txtQuantity').value = "0";
            document.getElementById('hdnProductID').value = "";
            document.getElementById('txtInhandQuantity').value = "0";
            document.getElementById('txtUnit').value = "";
            document.getElementById('txtOrderedUnit').value = "";

            var Trustedorgid = document.getElementById('ddlBehalfOfTrustedOrg').value;
            if (Trustedorgid > 0) {

                document.getElementById('hdnSelectBehalfOfOrgid').value = Trustedorgid;

            }

            var Fromlocationid = document.getElementById('ddlLocation').value;
            if (Fromlocationid > 0) {
                document.getElementById('hdnBehalfOfSelectLocation').value = Fromlocationid;
            }
            var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
            var currentLocationid = document.getElementById('ddlOnBehalfOf').value;
            var pIsConsign=$('#ChkIsConsign').prop('checked')==true ? "Y" : "N";

            var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini + '~' + currentLocationid + '~' + pIsConsign;
            $find('AutoCompleteProduct').set_contextKey(sval);


        }

        function ProductsOnBlur(event, ele) {

            if (event.keyCode != 9) {
                document.getElementById('txtQuantity').value = "0";
                document.getElementById('hdnProductID').value = "";
                document.getElementById('txtInhandQuantity').value = "0";
                document.getElementById('txtUnit').value = "";
                document.getElementById('txtOrderedUnit').value = "";

                var Trustedorgid = document.getElementById('ddlBehalfOfTrustedOrg').value;
                if (Trustedorgid > 0) {

                    document.getElementById('hdnSelectBehalfOfOrgid').value = Trustedorgid;

                }

                var Fromlocationid = document.getElementById('ddlLocation').value;
                if (Fromlocationid > 0) {
                    document.getElementById('hdnBehalfOfSelectLocation').value = Fromlocationid;
                }
                var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
                var currentLocationid = document.getElementById('ddlOnBehalfOf').value;
                var pIsConsign=$('#ChkIsConsign').prop('checked')==true ? "Y" : "N";
                
                var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini + '~' + currentLocationid + '~' +pIsConsign;
                $find('AutoCompleteProduct').set_contextKey(sval);
            }


        }

        function OnSelectProtocols(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnProtocalID').value = PColval[0];
            document.getElementById('txtNoOfPatient').value = PColval[2];
            document.getElementById('hdnNoOfPatient').value = PColval[2];
        }

        function checkKitdetails() {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            var grid = document.getElementById('GrdEpisodeDetails');
            if (grid != null) {
                var GrdLenth = grid.rows.length;
                var flag = 0;
                var pName;
                var pProductId;
                var pInhandQTY;
                var pProductId;
                var pUnit;
                var pQTY;
                var EpisodeVisitId;
                var SiteID;
                document.getElementById('hdnKitList').value = "";
                document.getElementById('hdnKitstudyDetails').value = "";
                document.getElementById('hdnKitIDs').value = "";
                var lstKitIDs = [];

                IndentId = document.getElementById('hdnintID').value;
                for (var i = 1; i < GrdLenth; i++) {
                    if (grid.rows[i].cells[0].childNodes[0].checked == true) {
                        flag = 1;
                        pName = grid.rows[i].cells[3].innerText;
                        pProductId = grid.rows[i].cells[9].innerText;
                        pInhandQTY = grid.rows[i].cells[7].innerText;
                        pUnit = grid.rows[i].cells[8].innerText;
                        pParerProductId = grid.rows[i].cells[12].innerText; // pProductId;
                        pQTY = grid.rows[i].cells[4].innerText;
                        //grid.rows[i].cells[4].innerText;
                        RaisedQTY = grid.rows[i].cells[6].childNodes[0].value;
                        EpisodeVisitId = grid.rows[i].cells[11].innerText;
                        SiteID = grid.rows[i].cells[10].innerText;
                        document.getElementById('hdnKitList').value += pName + "~" + pProductId + "~" +
                        pInhandQTY + "~" + pParerProductId + "~" + pUnit + "~" + pQTY + "~" + RaisedQTY + "^";

                        document.getElementById('hdnKitstudyDetails').value += pProductId + "~" + SiteID + "~" + EpisodeVisitId + "~" + pQTY + "~" + RaisedQTY + "^";


                        lstKitIDs.push({
                            EpisodeVisitId: EpisodeVisitId,
                            KitID: pProductId,
                            KitName: pName
                        });

                    }
                }


                var lstRaisedProducts = [];
                if (document.getElementById('hdnProductList').value != "") {
                    var PCommonList = document.getElementById('hdnProductList').value.split('^');
                    for (var count = 0; count < PCommonList.length; count++) {
                        var PList = PCommonList[count].split('~');
                        lstRaisedProducts.push({
                            ProductID: PList[1],
                            ProductName: PList[0]
                        });
                    }
                }
                //  lstKitIDs - Raised Kit IDs
                //  lstProducts - Products in Kits which kits are in this Episode Visit
                //  lstRaisedProducts - Raised Prdoucts IDs
                var objmsg = SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_12') == null ? " is Already Present in the Kit: " : SListForAppDisplay.Get('StockIntend_RaiseIntend_aspx_12');
                var Isfalse = '0';
                if (lstKitIDs.length > 0) {
                    var lstProducts = JSON.parse($('input[id$="hdnProductsList"]').val());
                    $.each(lstKitIDs, function(i, obj1) {
                        $.each(lstProducts, function(j, obj2) {
                            if (obj1.EpisodeVisitId == obj2.EpisodeVisitId && obj1.KitID == obj2.KitID) {
                                $.each(lstRaisedProducts, function(k, obj3) {
                                    if (obj3.ProductID == obj2.ProductID) {
                                        var mesg = obj3.ProductName + objmsg + obj1.KitName;
                                        ValidationWindow(mesg,ErrMsg);
                                        Isfalse = 1;
                                        return false;
                                    }
                                });
                                if (Isfalse == '1') {
                                    return false;
                                }
                            }
                        });
                        if (Isfalse == '1') {
                            return false;
                        }

                    });
                    if (Isfalse == '1') {
                        return false;
                    }
                }

            }
            if (document.getElementById('CtConfig').value != "Y") {
                return funexits();
            }
        }
        function SelectOption() {
            if (document.getElementById('rdProtocol').checked) {
                //document.getElementById('trProtocol').style.display = 'block';
                //document.getElementById('trProduct').style.display = 'none';
                $('#trProtocol').removeClass().addClass('show');
                $('#trProduct').removeClass().addClass('hide');

            }
            else {
                //document.getElementById('trProduct').style.display = 'block';
                //document.getElementById('trProtocol').style.display = 'none';
                $('#trProduct').removeClass().addClass('show');
                $('#trProtocol').removeClass().addClass('hide');
            }
        }
        function GetLocationID(source, eventArgs) {
            
            var list = eventArgs.get_value().split('~');
            var Fromlocationid = document.getElementById('hdnLocationID').value = list[0];
            var Trustedorgid = document.getElementById('hdnToOrgID').value = list[1];
            var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
            var CurrentLocationid = document.getElementById('ddlOnBehalfOf').value == '' ? '0' : document.getElementById('ddlOnBehalfOf').value;
             var pIsConsign=$('#ChkIsConsign').prop('checked')==true ? "Y" : "N";
            var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini;
            $find('AutoCompleteProduct1').set_contextKey(sval);
        }


        function ChecRaisedkQty() {
            var ErrMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02') == null ? "Error" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_02');
            var grid = document.getElementById('GrdEpisodeDetails');
            if (grid != null) {
                var GrdLenth = grid.rows.length;
                var pQTY;
                var RaisedQTY;
                var NumofKits;
                var Total;

                for (var i = 1; i < GrdLenth; i++) {
                    if (grid.rows[i].cells[0].childNodes[0].checked == true) {
                        NumofKits = grid.rows[i].cells[4].innerText;
                        RaisedQTY = grid.rows[i].cells[5].innerText;
                        pQTY = grid.rows[i].cells[6].childNodes[0].value;
                        Total = Number(NumofKits);  //+ Number(RaisedQTY);
                        if (pQTY > Total) {
                            var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_30') == null ? "Raised More Than required Quantity" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_30');
                            ValidationWindow(userMsg, ErrMsg);
                        }
                    }
                }
            }
        }
        function CalTotQty() {
          
            var hdnPack = document.getElementById('hdnEnablePackSize').value
            if (hdnPack == 'Y') {
                document.getElementById('txtTotQty').value = parseInt(ToInternalFormat($('#txtPackSize'))) * parseInt(ToInternalFormat($('#txtQuantity')));

                //document.getElementById('txtTotQty').value = parseInt(document.getElementById('txtPackSize').value) * parseInt(document.getElementById('txtQuantity').value);
            }
            else
            //document.getElementById('txtTotQty').value =  parseInt(document.getElementById('txtQuantity').value);
                document.getElementById('txtTotQty').value = parseInt(ToInternalFormat($('#txtQuantity')));

            ToTargetFormat($('#txtTotQty'))

        }
        function ChangeConsign() {
           // var chk = document.getElementById('ChkIsConsign');
            $("#txtProductName").val("");
            $('#txtInhandQuantity').val("0");
            $('#txtQuantity').val("0");
            $('#txtUnit').val("");
            $('#hdnProductID').val("0");
            $('#txtOrderedUnit').val(""); 
            lstProductLst = [];                                 
            while (count = document.getElementById('tblOrederedItems').rows.length) {
                $('#tblOrederedItems >tbody> tr').remove();
                $('#hdnProductList').val('');
            }
        }

    </script>

</body>
</html>
