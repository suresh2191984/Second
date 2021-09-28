<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductCategories.aspx.cs"
    Inherits="Inventory_ProductCategories" meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Product Categories</title>

</head>
<body onload="pageLoad();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryMaster/Webservice/InventoryMaster.asmx" />
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div class="a-center w-60" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                <asp:HiddenField ID="hdnIsCorpOrg" runat="server" Value="N" />
                <input type="hidden" id="hdnInventory_Attributes_Value" runat="server" />
                <div class="w-98p marginauto">
                    <div class="card-md card-md-default padding10 marginT10 marginB10">
                        <table class="w-100p">
                        <tr class="hide">
                            <td class="a-center" colspan="4">
                                &nbsp;<asp:Label ID="lblmsg" runat="server" meta:resourceKey="lblmsgResource1"></asp:Label>
                                <input id="hdnStatus" runat="server" type="hidden" /></input> </input>
                            </td>
                        </tr>
                        <tr class="">
                            <td>
                            <div class="w-98p marginauto">
                                <asp:Panel ID="Panel2" runat="server" CssClass="no-divscheduler-border no-divscheduler-border-lh30" GroupingText="Category Details"
                                    meta:resourcekey="Panel2Resource1">
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td class="a-left w-7p">
                                                <asp:Label ID="lbcatgry" runat="server" meta:resourcekey="lbcatgryResource1" Text="Name"></asp:Label>
                                            </td> 
                                            <td class="a-left w-35p">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCategoryName" runat="server" CssClass="txtboxps medium" MaxLength="100"
                                                    meta:resourceKey="txtCategoryNameResource1" onblur="ConverttoUpperCase(this.id);"
                                                    onkeydown=" return isNumerics(event,this.id)"></asp:TextBox>
                                                &nbsp;<img class="v-middle" alt="" src="../PlatForm/Images/starbutton.png" />
                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="listitemtwo" DelimiterCharacters="" EnableCaching="False"
                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetMasterCategoryName"
                                                    ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx" TargetControlID="txtCategoryName">
                                                </ajc:AutoCompleteExtender>
                                                <input id="hdnCategoryToBeDel" runat="server" type="hidden" />
                                                <asp:CheckBox ID="chkDelete" runat="server" Checked="True" meta:resourcekey="chkDeleteResource1"
                                                    onclick="javascript:showDeleteDiv(this.id);" Text="IsActive" />
                                                </input>
                                            </td>
                                            <td class="a-left w-10p">
                                                <asp:Label ID="lbdescrp" runat="server" meta:resourceKey="lbdescrpResource1" Text="Description"></asp:Label>
                                            </td>
                                            <td class="a-left bold" colspan="2">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDescription" runat="server" CssClass="large" meta:resourceKey="txtDescriptionResource1"></asp:TextBox>
                                                <input id="hdnIsDeleted" runat="server" type="hidden"></input>
                                                <input id="hdnIsDeletable" runat="server" type="hidden"></input>
                                                </input> </input>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </div>
                            </td>
                            <td class="a-center v-bottom paddingB5">
                                <asp:Button ID="btnFinish" runat="server" CssClass="btn" meta:resourceKey="btnFinishResource1"
                                    OnClick="btnFinish_Click" OnClientClick="javascript:return checkDetails();" Text="Save" />
                                &nbsp;
                                <asp:Button ID="btnCancel" runat="server" CssClass="cancel-btn" meta:resourceKey="btnCancelResource1"
                                    OnClientClick="javascript:return FnClear();" Text="Clear" />
                            </td>
                        </tr>
                        <tr id="trPSearch" runat="server">
                            <td runat="server" class="h-128">
                                <asp:Panel ID="pnlPSearch" runat="server" CssClass="w-100p bold marginT5 black" GroupingText="Tax Details"
                                    meta:resourcekey="pnlPSearchResource1">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="h-30 bold a-left">
                                                <asp:Label ID="lblTaxNo" runat="server" Text="InputTax Type" meta:resourcekey="lblTaxNoResource1"></asp:Label>
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:DropDownList ID="ddlTaxTypeId" runat="server" CssClass="ddl" onBlur="SetTax();"
                                                    meta:resourcekey="ddlTaxTypeIdResource1">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdnTaxDetails" runat="server" />
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:Label ID="lblTax" runat="server" Text="Input Tax" meta:resourcekey="lblTaxResource1"></asp:Label>
                                            </td>
                                            <td class="h-30">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TxtTax" runat="server" CssClass="txtboxps w-50p a-right" MaxLength="255"
                                                    ReadOnly="True" meta:resourcekey="TxtTaxResource1"></asp:TextBox>
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:Label ID="lblTaxName" runat="server" Text="OutputTax Type" meta:resourcekey="lblTaxNameResource1"></asp:Label>
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:DropDownList ID="ddlTaxType" runat="server" CssClass="ddl" onBlur="SetOutPutTax();"
                                                    meta:resourcekey="ddlTaxTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:Label ID="Label11" runat="server" Text="OutPut Tax" meta:resourcekey="Label11Resource1"></asp:Label>
                                            </td>
                                            <td class="h-30">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtOutPutTax" runat="server" CssClass="txtboxps a-right w-50p" MaxLength="255"
                                                    ReadOnly="True" meta:resourcekey="txtOutPutTaxResource1"></asp:TextBox>
                                            </td>
                                            <td class="h-30 bold a-left">
                                                <asp:Label ID="lblState" runat="server" Text="State" meta:resourcekey="lblStateResource1"></asp:Label>
                                            </td>
                                            <td class="h-30">
                                                <asp:DropDownList ID="ddlState" runat="server" CssClass="ddl" meta:resourcekey="ddlStateResource1">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdnTrustorg" runat="server" />
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="lblValidFrom" runat="server" meta:resourceKey="lblValidFromResource1"
                                                    Text="Valid From"></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtValidFrom" runat="server" CssClass="small w-100" TabIndex="2"
                                                    meta:resourcekey="txtValidFromResource1"></asp:TextBox>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="lblValidTo" runat="server" meta:resourceKey="lblValidToResource1"
                                                    Text="Valid To"></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtValidTo" runat="server" CssClass="small w-100" TabIndex="2"
                                                    meta:resourcekey="txtValidToResource1"></asp:TextBox>
                                            </td>
                                            <td class="h-30">
                                                <asp:Button ID="btnAddd" runat="server" CssClass="btn" meta:resourceKey="btnAddRK1"
                                                    OnClientClick="javascript:return ItemCreateTable();" Text="Add" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="15">
                                                <table id="tbItemTable" class=" gridView w-100p a-left marginB5">
                                                    <thead class="gridTDheader">
                                                        <tr>
                                                            <th class="w-15p hide" scope="col">
                                                            </th>
                                                            <th class="w-15p hide" scope="col">
                                                            </th>
                                                            <th class="w-15p" scope="col">
                                                                <asp:Label ID="Label2" runat="server" Text="InputTax Type" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </th>
                                                            <th class="w-15p" scope="col">
                                                                <asp:Label ID="Label7" runat="server" meta:resourceKey="gdlblITaxRK1" Text="Input Tax"></asp:Label>
                                                            </th>
                                                            <th class="w-15p hide" scope="col">
                                                            </th>
                                                            <th class="w-15p" scope="col">
                                                                <asp:Label ID="Label10" runat="server" meta:resourceKey="gdlblOTaxtypeRK1" Text="Output Taxtype"></asp:Label>
                                                            </th>
                                                            <th class="w-15p" scope="col">
                                                                <asp:Label ID="Label12" runat="server" meta:resourceKey="gdlblOTaxRK1" Text="Output Tax"></asp:Label>
                                                            </th>
                                                            <th class="w-15p" scope="col">
                                                                <asp:Label ID="Label8" runat="server" meta:resourceKey="gdlblStateRK1" Text="State"></asp:Label>
                                                            </th>
                                                            <th class="w-10p" scope="col">
                                                                <asp:Label ID="Label1" runat="server" meta:resourceKey="gdlblvalidfrmRK1" Text="Valid From"></asp:Label>
                                                            </th>
                                                            <th class="w-10p" scope="col">
                                                                <asp:Label ID="Label3" runat="server" meta:resourceKey="gdlblValidtoRk1" Text="Valid To"></asp:Label>
                                                            </th>
                                                            <th class="w-10p" scope="col">
                                                                <asp:Label ID="Label9" runat="server" meta:resourceKey="gdlblactionRK1" Text="Action"></asp:Label>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="TrItems">
                                                    </tbody>
                                                </table>
                                                <asp:HiddenField ID="hdnItemDetails" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel1" runat="server" GroupingText="Attributes Mapping"
                                    meta:resourcekey="Panel1Resource1" CssClass="hide">
                                    <table class="w-100p">
                                        <tr>
                                            <td id="tdAttributeslist" class="hide" runat="server">
                                                <asp:ListBox ID="lstBoxAttributes" runat="server" CssClass="w-235 font11 h-150" meta:resourcekey="lstBoxAttributesResource1"
                                                    ondblclick="javascript:onClickSpcial(this.id);" onkeypress="javascript:setSpItem(event,this);">
                                                </asp:ListBox>
                                            </td>
                                            <td class="a-left v-top">
                                                <table class="w-100p">
                                                    <tr class="bold">
                                                        <td id="tdAttributes" class="a-left w-40p hide v-top" colspan="2">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <table id="Table1" runat="server" class="gridView w-60p">
                                                                            <tr id="Tr3" runat="server" class="gridTDheader">
                                                                                <td id="Td5" runat="server" class="w-10p">
                                                                                    <asp:Label ID="Label4" runat="server" Text="Delete"></asp:Label>
                                                                                </td>
                                                                                <td id="Td6" runat="server">
                                                                                    <asp:Label ID="Label5" runat="server" Text="Attributes"></asp:Label>
                                                                                </td>
                                                                                <td id="Td7" runat="server" class="w-18p">
                                                                                    <asp:Label ID="Label6" runat="server" Text="IsMandatory"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="auto">
                                                                            <table id="tblAttributes" runat="server" class="gridView w-60p">
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    </div>
                </div>
                <div class="w-98p marginauto">
                <asp:UpdatePanel ID="UpdatePane" runat="server">
                    <ContentTemplate>
                        <table id="tblCategoryGrid" runat="server" cellpadding="4"
                            class="dataheader2 defaultfontcolor w-100p" visible="False">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" runat="server">
                                    <asp:GridView ID="gvCategory" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CssClass="responstable w-100p" OnPageIndexChanging="gvCategory_PageIndexChanging"
                                        OnRowCommand="gvCategory_RowCommand" OnRowDataBound="gvCategory_RowDataBound"
                                        meta:resourcekey="gvCategoryResource1">
                                        <HeaderStyle CssClass="responstableHeader" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <input id="rdSel" runat="server" name="radio" type="radio" value='<%#Eval("Name") %>' />
                                                    <asp:Label ID="lblCatename" runat="server" CssClass="hide" Text='<%# Eval("Name") %>'
                                                        meta:resourcekey="lblCatenameResource1"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:Label ID="lblSelect" runat="server" Text="Select" meta:resourcekey="lblSelectResource1"></asp:Label>
                                                    <input id="rdALLSel" disabled="disabled" class="hide" name="radio" type="radio" />
                                                </HeaderTemplate>
                                                <HeaderStyle CssClass="w-5p a-left" />
                                                <ItemStyle CssClass="a-left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CategoryName" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblname" runat="server" Text='<%# Eval("CategoryName") %>' meta:resourcekey="lblnameResource1"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCategoryNameWiseSearch" runat="server" CssClass="medium no-shadow"
                                                        meta:resourcekey="txtCategoryNameWiseSearchResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteSearchProduct" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="listitemtwo" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetMasterCategoryName"
                                                        ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx" TargetControlID="txtCategoryNameWiseSearch">
                                                    </ajc:AutoCompleteExtender>
                                                    <ajc:TextBoxWatermarkExtender ID="txtWater" runat="server" Enabled="True" TargetControlID="txtCategoryNameWiseSearch"
                                                        WatermarkCssClass="watermarked medium no-shadow" WatermarkText="Enter the Category Name" meta:resourcekey="txtWaterResource1" />
                                                    <asp:Button ID="btn1" runat="server" CommandName="Search1" CssClass="cancel-btn" Text="GO"
                                                        meta:resourcekey="btn1Resource1" />
                                                </HeaderTemplate>
                                                <HeaderStyle CssClass="w-30p a-left" />
                                                <ItemStyle CssClass="a-left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tax" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTax" runat="server" CssClass="hide" Text='<%# Eval("ProductName") %>'
                                                        meta:resourcekey="lblTaxResource2"></asp:Label>
                                                    <asp:Image ID="imagTaxDetils" runat="server" ImageUrl="../PlatForm/Images/vital_signs.png"
                                                        ToolTip="Click to View Tax" meta:resourcekey="imagTaxDetilsResource1" />
                                                    <asp:Label ID="lblTaxDetails" runat="server" CssClass="hide" meta:resourcekey="lblTaxDetailsResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="a-center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource1">
                                                <ItemStyle CssClass="" Wrap="True" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Attributes" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAttributes" runat="server" CssClass="hide" Text='<%# Eval("Name") %>'
                                                        meta:resourcekey="lblAttributesResource1"></asp:Label>
                                                    <asp:Image ID="ImgAttributes" runat="server" ImageUrl="../PlatForm/Images/vital_signs.png"
                                                        ToolTip="Click to View Attributes" meta:resourcekey="ImgAttributesResource1" />
                                                    <asp:Label ID="lblContent" runat="server" CssClass="hide" meta:resourcekey="lblContentResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="a-center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsActive" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActive" runat="server" CssClass="hide" Text='<%# Eval("HasExpiryDate") %>'
                                                        meta:resourcekey="lblActiveResource1"></asp:Label>
                                                    <asp:Image ID="ImgActive" runat="server" ImageUrl="../PlatForm/Images/Checkin.png"
                                                        ToolTip="Active" Visible="False" meta:resourcekey="ImgActiveResource1" />
                                                    <asp:Image ID="ImgDeActive" runat="server" ImageUrl="../PlatForm/Images/Delete7.jpg"
                                                        ToolTip="De-Active" Visible="False" meta:resourcekey="ImgDeActiveResource1" />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="w-10p a-left" />
                                                <ItemStyle CssClass="" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Seq Number" meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:Image ID="ImgSeqnumber" runat="server" ImageUrl="../PlatForm/Images/collapse.jpg"
                                                        ToolTip="Active" meta:resourcekey="ImgSeqnumberResource1" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle CssClass="pagination-ys" HorizontalAlign="Right" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnSeqValue" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                </div>
                </input>
            </ContentTemplate>
        </asp:UpdatePanel>
        <ajc:ModalPopupExtender ID="MPESeqNumber" runat="server" TargetControlID="Button2"
            PopupControlID="PSeqNumber" BackgroundCssClass="modalBackground" Enabled="True"
            DropShadow="True" DynamicServicePath="" />
        <input type="button" id="Button2" runat="server" class="hide" />
        <asp:Panel ID="PSeqNumber" runat="server" CssClass="modalPopup dataheaderPopup w-300p h-auto"
            meta:resourcekey="PSeqNumberResource1">
            <table class="w-100p">
                <tr>
                    <td class="a-center" colspan="2">
                        <asp:Label ID="lblCatName" runat="server" CssClass="bold" meta:resourcekey="lblCatNameResource1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="lstSeqNumber" runat="server" CssClass="h-150 w-235 font11" meta:resourcekey="lstSeqNumberResource1">
                        </asp:ListBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgMoveUP" runat="server" ImageUrl="~/PlatForm/Images/UpArrow.png"
                            OnClientClick="javascript:return moveUp();" meta:resourcekey="imgMoveUPResource1" />
                        <asp:ImageButton ID="imgMoveDown" runat="server" ImageUrl="~/PlatForm/Images/DownArrow.png"
                            OnClientClick="javascript:return moveDown();" meta:resourcekey="imgMoveDownResource1" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="2">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClientClick="javascript:return GetSeqNumber()"
                            Text=" Save " OnClick="btnSaveSeqNumber_Click" meta:resourcekey="btnSaveRk1" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnClose" runat="server" CssClass="btn" Text="Close " OnClientClick="javascript:return HideSeqNumber();"
                            meta:resourcekey="btnCloseRK1" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <Attune:Attunefooter runat="server" ID="Attunefooter" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnCategoryName" runat="server" />
    <asp:HiddenField ID="hdnCategorieAttributesMapping" runat="server" />
    <asp:HiddenField ID="hdnAttributesDetails" runat="server" />
    <div id="divCONTENT" />
    
    </form>

    <script type="text/javascript">
        //-------------Mani--------
        $(document).ready(function() {
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ProductCategories') {
                $("#Attuneheader_TopHeader1_lblvalue").text("Product Categories");
            }
        });
        //----------End------------
        var Delete = SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Delete');
        if (Delete == null) {
            Delete = "Delete";
        }
        function setSpItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickSpcial(ctl.id);
            }
        }

        function onClickSpcial(id) {
            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            var HidValue = document.getElementById('hdnAttributesDetails').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnAttributesDetails').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialList = list[count].split('#');
                    if (SpecialList[0] != '') {
                        if (obj.selectedIndex >= 0) {
                            if (SpecialList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                //document.getElementById('tdAttributes').style.display = 'table-cell';
                $('#tdAttributes').removeClass().addClass('displaytd');
                var row = document.getElementById('tblAttributes').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' src='../PlatForm/Images/Delete.jpg' />";
                cell1.innerHTML = "<input id='imgbtn' name='" + Delete + "'  OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' value = '' type='button' class='ui-icon ui-icon-trash pointer pull-left'  />"
                cell1.width = "10%";

                cell2.innerHTML = "<span id='AttrIbutesText' >" + obj.options[obj.selectedIndex].text + "</span><span id='AttrIbutesID' class='hide' >" + obj.options[obj.selectedIndex].value + "</span>";
                document.getElementById('hdnAttributesDetails').value += obj.options[obj.selectedIndex].value + "#" + obj.options[obj.selectedIndex].text + "#true^";
                cell3.innerHTML = "<input type='checkbox' id='isMand' checked ='checked'  />"
                cell3.width = "18%";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                //document.getElementById('tdAttributes').style.display = 'table-cell';
                $('#tdAttributes').removeClass().addClass('displaytd');
                var row = document.getElementById('tblAttributes').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' src='../PlatForm/Images/Delete.jpg' />";
                cell1.innerHTML = "<input id='imgbtn' name='" + Delete + "'  OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' value = '' type='button' class='ui-icon ui-icon-trash pointer pull-left'  />"
                cell1.width = "10%";
                document.getElementById('hdnAttributesDetails').value += obj.options[obj.selectedIndex].value + "#" + obj.options[obj.selectedIndex].text + "#true^";
                cell2.innerHTML = "<span id='AttrIbutesText' >" + obj.options[obj.selectedIndex].text + "</span><span id='AttrIbutesID' class='hide' >" + obj.options[obj.selectedIndex].value + "</span>";
                cell3.innerHTML = "<input type='checkbox' id='isMand' checked ='checked'  />";
                cell3.width = "18%";
            }
            else if (AddStatus == 1) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_AttributeAdded') == null ? "Attributes already added" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_AttributeAdded');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);

            }

        }
        function ImgOnclickSpecial(ImgID) {
            $('#' + ImgID).remove();

            var HidValue = document.getElementById('hdnAttributesDetails').value;
            var list = HidValue.split('^');
            var NewSpecialList = '';
            if (document.getElementById('hdnAttributesDetails').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialList = list[count].split('#');
                    if (SpecialList[0] != '') {
                        if (SpecialList[0] != ImgID) {

                            NewSpecialList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAttributesDetails').value = '';
                document.getElementById('hdnAttributesDetails').value = NewSpecialList;
            }


        }

        function AddedItems() {
            document.getElementById('<%=hdnAttributesDetails.ClientID %>').value = "";
            if ($("#tblAttributes")[0].rows.length > 0) {
                var lstItmes = [];
                $('[id$="tblAttributes"] tr').each(function(i, n) {
                    var currentRow = $(n);
                    var AttrIbutesText = currentRow.find("span[id$='AttrIbutesText']").html();
                    var AttrIbutesID = currentRow.find("span[id$='AttrIbutesID']").html();
                    var chk = currentRow.find("input:checkbox[id$=isMand]").prop('checked');
                    if (AttrIbutesText != null) {
                        document.getElementById('<%=hdnAttributesDetails.ClientID %>').value += AttrIbutesID + '#' + AttrIbutesText + '#' + chk + '^';
                    }
                });
            }

        }

        function SetAttributesValues() {
            myCreateFunction();
            var HidValue = document.getElementById('hdnAttributesDetails').value;
            var list = HidValue.split('^');
            var NewSpecialList = '';
            if (document.getElementById('hdnAttributesDetails').value != "") {
                $('#tdAttributes').css('display', 'table-cell');
                for (var count = 0; count < list.length; count++) {
                    var SpecialList = list[count].split('#');
                    if (SpecialList[0] != '') {
                        var row = document.getElementById('tblAttributes').insertRow(0);
                        row.id = SpecialList[0];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + SpecialList[0] + ");' src='../PlatForm/Images/Delete.jpg' />";
                        cell1.innerHTML = "<input id='imgbtn' name='" + Delete + "'  OnClick='ImgOnclickSpecial(" + SpecialList[0] + ");' value = '' type='button' class='ui-icon ui-icon-trash pointer pull-left'  />"
                        cell1.width = "10%";
                        document.getElementById('hdnAttributesDetails').value += SpecialList[0] + "#" + SpecialList[1] + "#true^";
                        cell2.innerHTML = "<span id='AttrIbutesText' >" + SpecialList[1] + "</span><span id='AttrIbutesID' class='hide' >" + SpecialList[0] + "</span>";
                        if (SpecialList[2] == 'true') {
                            cell3.innerHTML = "<input type='checkbox' id='isMand' checked ='checked'  />";
                        }
                        else {
                            cell3.innerHTML = "<input type='checkbox' id='isMand'  />";
                        }
                        cell1.width = "18%";
                    }
                }
            }
            else {
                $('#tdAttributes').css('display', 'none');
            }
        }

        function myCreateFunction() {
            $('[id$="tblAttributes"] tbody tr').remove();
        }

        function showTooltip(lblContent, tooltipTxt) {
            var Attributes = SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Attributes') == null ? "Attributes" : SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Attributes');
            var IsMandatory = SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Ismandatory') == null ? "IsMandatory" : SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Ismandatory');
            //if (document.getElementById(lblContent).style.display == "none") {
            if ($('#' + lblContent).hasClass('hide')){
                //document.getElementById(lblContent).style.display = "block";
                $('#' + lblContent).removeClass().addClass('show');
            }
            else {
                //document.getElementById(lblContent).style.display = "none";
                $('#' + lblContent).removeClass().addClass('hide');
            }
            $('#' + lblContent).html("");
            var shtm = "";
            shtm = "<table id='tblSRRow' border='1' cellpadding='4' cellspacing='0'>";
            shtm += "<TR class='colorforcontent'><TD nowrap='nowrap' class='bold font10 white w-5p'>" + Attributes + "</TD><TD nowrap='nowrap' class='bold font10 white w-5p'>" + IsMandatory + "</td></TR>";
            var Attributes = tooltipTxt.split('^');

            for (var count = 0; count < Attributes.length; count++) {
                if (Attributes[count] != "") {
                    var Value = Attributes[count].split('#');
                    shtm += "<TR><TD nowrap='nowrap' class='a-left'>" + Value[1] + "</TD><TD nowrap='nowrap' class='a-left'>" + Value[2] + "</td></TR>";
                }
            }
            shtm += "</table>";


            $('#' + lblContent).html(shtm);
            return false;

        }

        function showTooltipout(lblContent) {
            $('#' + lblContent).css("display", "none");
        }


        function ItemCreateTable() {
            var DataTable = [];
            var TaxTypeName = $("#ddlTaxTypeId :selected").text();
            var TaxTypeID = $("#ddlTaxTypeId").val();
            var StateName = $("#ddlState :selected").text();
            var StateID = $("#ddlState").val();
            var Taxvalue = $("#TxtTax").val();

            var outputTaxTypeName = $("#ddlTaxType :selected").text();
            var outputTaxTypeID = $("#ddlTaxType").val();
            var outputTaxvalue = $("#txtOutPutTax").val();

            var FromDate = ToInternalDate($("#txtValidFrom").val());
            var ToDate = ToInternalDate($("#txtValidTo").val());


            if (TaxTypeID == 0) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectTaxType') == null ? "Please select Taxtype Name" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectTaxType');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (outputTaxTypeID == 0) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectOutputTaxType') == null ? "Please select Taxtype Name" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectOutputTaxType');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (StateID == 0) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectState') == null ? "Please select State Name" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectState');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (FromDate == "") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValid') == null ? "Please select Valid From" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValid');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (ToDate == "") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValidTo') == null ? "Please select Valid To" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValidTo');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            var iPaymentAlreadyPresent = 0

            if ($("#tbItemTable")[0].rows.length > 1) {
                $('[id$="tbItemTable"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var tempStateID = currentRow.find("span[id$='StateID']").html();
                    if (tempStateID == StateID && iPaymentAlreadyPresent == 0) {
                        iPaymentAlreadyPresent = 1;
                    }
                });
            }

            if (iPaymentAlreadyPresent == 1) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_ItemAdded') == null ? "Item already added" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_ItemAdded');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);

            }
            else {
                DataTable.push({
                    TaxTypeName: TaxTypeName,
                    TaxTypeID: TaxTypeID,
                    StateName: StateName,
                    StateID: StateID,
                    Taxvalue: Taxvalue,
                    FromDate: FromDate,
                    ToDate: ToDate,
                    OutputTaxTypeID: outputTaxTypeID,
                    OutputTaxTypeName: outputTaxTypeName,
                    OutputTaxvalue: outputTaxvalue
                });
                ITEMBindTable(DataTable);
            }

            return false;

        }
        function DeleteItem(ele) {

            $(ele).closest('tr').remove();
            AddedTaxItems();
        }

        function ITEMBindTable(DataTable) {
            var rowCount = $('#tbItemTable tr').length;
            var strDelete = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Delete')
            if (userMsg == null) {
                strDelete = "Delete"
            }


            $.each(DataTable, function(i, obj) {
                var RowNO = Number(rowCount + i);
                dtTR = $('<tr/>');
                var TaxTypeID = $('<td class="a-left hide"/>').html("<span id='TaxTypeID'>" + obj.TaxTypeID + "</span>");
                var StateID = $('<td class="a-left hide"/>').html("<span id='StateID'>" + obj.StateID + "</span>");
                var TaxTypeName = $('<td class="a-left" nowrap="nowrap" />').html("<span id='TaxTypeName'>" + obj.TaxTypeName + "</span>");
                var Taxvalue = $('<td class="a-right" nowrap="nowrap" />').html("<span id='Taxvalue'>" + obj.Taxvalue + "</span>");
                var StateName = $('<td class="a-left" nowrap="nowrap" />').html("<span id='StateName'>" + obj.StateName + "</span>");
                var FromDate = $('<td class="a-left" nowrap="nowrap" />').html("<span id='FromDate'>" + ToExternalDate(obj.FromDate) + "</span>");
                var ToDate = $('<td class="a-left" nowrap="nowrap" />').html("<span id='ToDate'>" + ToExternalDate(obj.ToDate) + "</span>");

                var OutputTaxTypeID = $('<td class="a-left hide"/>').html("<span id='spanTaxType'>" + obj.OutputTaxTypeID + "</span>");
                var OutputTaxTypeName = $('<td class="a-left" nowrap="nowrap" />').html("<span id='spanOutputTaxType'>" + obj.OutputTaxTypeName + "</span>");
                var OutputTaxvalue = $('<td class="a-right" nowrap="nowrap" />').html("<span id='spanOurputTaxvalue'>" + obj.OutputTaxvalue + "</span>");

                var btnDelete = '<input id="btnDelete" value="' + strDelete + '" type="button" class="view underline pointer font12" onclick="DeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnDelete);
                dtTR.append(TaxTypeID).append(StateID).append(TaxTypeName).append(Taxvalue).append(OutputTaxTypeID).append(OutputTaxTypeName).append(OutputTaxvalue).append(StateName).append(FromDate).append(ToDate).append(tdAction);
                $('#TrItems').append(dtTR);
            });
            if ($('#tbItemTable tr').length > 0) {
                //document.getElementById('tbItemTable').style.display = "block";
                $('#tbItemTable').removeClass().addClass('show');
            }

            AddedTaxItems();
            return false;
        }

        function AddedTaxItems() {
            document.getElementById('<%=hdnItemDetails.ClientID %>').value = "";
            if ($("#tbItemTable")[0].rows.length > 1) {
                var lstItmes = [];
                $('[id$="tbItemTable"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var TaxTypeID = currentRow.find("span[id$='TaxTypeID']").html();
                    var StateID = currentRow.find("span[id$='StateID']").html();
                    var TaxTypeName = currentRow.find("span[id$='TaxTypeName']").html();
                    var Tax = currentRow.find("span[id$='Taxvalue']").html();
                    var StateName = currentRow.find("span[id$='StateName']").html();
                    var FromDate = currentRow.find("span[id$='FromDate']").html();
                    var ToDate = currentRow.find("span[id$='ToDate']").html();

                    var outputTaxTypeID = currentRow.find("span[id$='spanTaxType']").html();
                    var outputTaxTypeName = currentRow.find("span[id$='spanOutputTaxType']").html();
                    var outputTax = currentRow.find("span[id$='spanOurputTaxvalue']").html();

                    document.getElementById('<%=hdnItemDetails.ClientID %>').value += TaxTypeID + '~' + StateID + '~'
                    + TaxTypeName + '~' + Tax + '~' + StateName + '~' + ToInternalDate(FromDate) + '~' + ToInternalDate(ToDate)
                    + '~' + outputTaxTypeID + '~' + outputTaxTypeName + '~' + outputTax + '$';
                });
            }
            return false;
        }


        function SetOrderItems() {
            var rowCount = $('#tbItemTable tr').length;
            var list = $('[id$="hdnItemDetails"]').val();
            if (list.length > 0) {
                //document.getElementById('tbItemTable').style.display = "block";
                $('#tbItemTable').removeClass().addClass('show');
            }
            var list = document.getElementById('<%=hdnItemDetails.ClientID %>').value.split('$');
            for (var count = 0; count < list.length; count++) {
                if (list[count] != "") {
                    var CList = list[count].split('~');

                    var DataTable = [];
                    var TaxTypeID = CList[0];
                    var StateID = CList[1];
                    var TaxTypeName = CList[2];
                    var Taxvalue = CList[3];
                    var StateName = CList[4];
                    var FromDate = CList[5];
                    var ToDate = CList[6];

                    var OutputTaxTypeID = 0;
                    if (CList[7] != undefined && CList[7] != '') {
                        OutputTaxTypeID = CList[7];
                    }
                    var OutputTaxTypeName = '';
                    if (CList[8] != undefined && CList[8] != '') {
                        OutputTaxTypeName = CList[8];
                    }
                    var OutputTaxvalue = 0;
                    if (CList[9] != undefined && CList[9] != '') {
                        OutputTaxvalue = CList[9];
                    }

                    DataTable.push({
                        TaxTypeName: TaxTypeName,
                        TaxTypeID: TaxTypeID,
                        StateName: StateName,
                        StateID: StateID,
                        Taxvalue: Taxvalue,
                        FromDate: FromDate,
                        ToDate: ToDate,
                        OutputTaxTypeID: OutputTaxTypeID,
                        OutputTaxTypeName: OutputTaxTypeName,
                        OutputTaxvalue: OutputTaxvalue
                    });

                    ITEMBindTable(DataTable);
                }
            }
        }

        function SetTax() {
            var GetValue = $('#hdnTaxDetails').val().split('#');
            for (var i = 0; i < GetValue.length; i++) {
                if (GetValue[i] != "") {
                    var ArrayValue = GetValue[i].split('~');
                    if ($('#<%= ddlTaxTypeId.ClientID %>').val() == ArrayValue[0]) {
                        $('#<%= TxtTax.ClientID %>').val(parseFloat(ArrayValue[2]).toFixed(2));
                        break;
                    }
                    else {
                        $('#<%= TxtTax.ClientID %>').val("");
                    }
                }
            }

        }

        function SetOutPutTax() {
            var GetValue = $('#hdnTaxDetails').val().split('#');
            for (var i = 0; i < GetValue.length; i++) {
                if (GetValue[i] != "") {
                    var ArrayValue = GetValue[i].split('~');
                    if ($('#<%= ddlTaxType.ClientID %>').val() == ArrayValue[0]) {
                        $('#<%= txtOutPutTax.ClientID %>').val(parseFloat(ArrayValue[2]).toFixed(2));
                        break;
                    }
                    else {
                        $('#<%= txtOutPutTax.ClientID %>').val("");
                    }
                }
            }

        }

        function CheckOnOff(rdoId, gridName) {
            if ($("#hdnIsCorpOrg").val() == "Y") {
                //document.getElementById('Panel1').style.display = "block";
                //document.getElementById('tdAttributeslist').style.display = "block";
                $('#Panel1').removeClass().addClass('show');
                $('#tdAttributeslist').removeClass().addClass('show');
            }
            var rdo = document.getElementById(rdoId);

            var all = document.getElementsByTagName("input");
            for (i = 0; i < all.length; i++) {

                if (all[i].type == "radio" && all[i].id != rdo.id) {
                    var count = all[i].id.indexOf(gridName);
                    if (count != -1) {
                        all[i].checked = false;
                    }
                }
            }
            rdo.checked = true;
        }

        function showTaxTooltip(lblContent, tooltipTxt) {

            var strInputTaxtype = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_InputTaxtype')
            if (userMsg == null) {
                strInputTaxtype = "Input Taxtype"
            }
            var strInputTax = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_InputTax')
            if (userMsg == null) {
                strInputTax = "Input Tax"
            }
            var strOutputTaxtype = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_OutputTaxtype')
            if (userMsg == null) {
                strOutputTaxtype = "Output Taxtype"
            }

            var strOutputTax = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_OutputTax')
            if (userMsg == null) {
                strOutputTax = "Output Tax"
            }
            var strState = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_State')
            if (userMsg == null) {
                strState = "State"
            }

            //if (document.getElementById(lblContent).style.display == "none") {
            if ($('#' + lblContent).hasClass('hide')){    
                //document.getElementById(lblContent).style.display = "block";
                $(lblContent).removeClass().addClass('show');    
            }
            else {
                //document.getElementById(lblContent).style.display = "none";
                $(lblContent).removeClass().addClass('hide'); 
            }
            $('#' + lblContent).html("");
            var shtm = "";
            shtm = "<table id='tblSRRow' border='1' cellpadding='4' cellspacing='0'>";
            shtm += "<TR class='colorforcontent'>";
            shtm += "<TD nowrap='nowrap' class='bold font10 white w-5p'>" + strInputTaxtype + "</TD>";
            shtm += "<TD nowrap='nowrap' class='bold font10 white w-5p'>" + strInputTax + "</td>";
            shtm += "<TD nowrap='nowrap' class='bold font10 white w-5p'>" + strOutputTaxtype + "</TD>";
            shtm += "<TD nowrap='nowrap' class='bold font10 white w-5p'>" + strOutputTax + "</td>";
            shtm += "<TD nowrap='nowrap' class='bold font10 white w-5p'>" + strState + "</td>"
            shtm += "</TR>";
            var Attributes = tooltipTxt.split('$');

            for (var count = 0; count < Attributes.length; count++) {
                if (Attributes[count] != "") {
                    var Value = Attributes[count].split('~');
                    shtm += "<TR>";
                    shtm += "<TD nowrap='nowrap' class='a-left'>" + Value[2] + "</TD>";
                    shtm += "<TD nowrap='nowrap' class='a-right'>" + Value[3] + "</TD>";
                    if (Value[8] != undefined) {
                        shtm += "<TD nowrap='nowrap' class='a-left'>" + Value[8] + "</TD>";
                    }
                    else {
                        shtm += "<TD nowrap='nowrap' class='a-left'> - </TD>";
                    }
                    if (Value[9] != undefined) {
                        shtm += "<TD nowrap='nowrap' class='a-right'>" + Value[9] + "</TD>";
                    }
                    else {
                        shtm += "<TD nowrap='nowrap' class='a-left'> - </TD>";
                    }
                    shtm += "<TD nowrap='nowrap' class='a-left'>" + Value[4] + "</TD>";
                    shtm += "</TR>";
                }
            }
            shtm += "</table>";


            $('#' + lblContent).html(shtm);
            return false;

        }

        function showTaxTooltipout(lblContent) {
            $('#' + lblContent).css("display", "none");
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            //document.getElementById('Panel1').style.display = "none";
            //document.getElementById('tdAttributeslist').style.display = "none";
            function EndRequestHandler(sender, args) {

                $("#txtValidFrom").datepicker({
                    yearRange: '2008:2030',
                    maxDate: "+1m +1w"
                })
                $("#txtValidTo").datepicker({
                    yearRange: '2008:2030',
                    maxDate: "+1m +1w"
                })
            }

        });
        $(function() {
            $("#txtValidFrom").datepicker({
                yearRange: '2008:2030',
                minDate: new Date(2010, 1 - 1, 1),
                changeYear: true
            })

            $("#txtValidTo").datepicker({
                yearRange: '2008:2030',
                minDate: new Date(2012, 1 - 1, 1),
                changeYear: true
            })

            $('#txtValidTo').change(function() {
                var fromDate = $("#txtValidFrom").val();
                var toDate = $("#txtValidTo").val();
                if (Date.parse(fromDate) >= Date.parse(toDate)) {

                    var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValid') == null ? "Invalid Date Range" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_SelectValid');
                    var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');

                    ValidationWindow(userMsg, errorMsg);

                    $(this).val('');
                }
            });
        });

        // Moving up the selected items
        function moveUp() {
            // get all selected items and loop through each
            $("#lstSeqNumber option:selected").each(function() {
                var listItem = $(this);
                var listItemPosition = $("#lstSeqNumber option").index(listItem) + 1;
                if (listItemPosition == 1) return false;
                listItem.insertBefore(listItem.prev());
            });
            return false;
        }


        function moveDown() {

            var itemsCount = $("#lstSeqNumber option").length;
            $($("#lstSeqNumber option:selected").get().reverse()).each(function() {
                var listItem = $(this);
                var listItemPosition = $("#lstSeqNumber option").index(listItem) + 1;
                if (listItemPosition == itemsCount) return false;
                listItem.insertAfter(listItem.next());
            });
            return false;
        }

        function ShowSeqNumber(CatName) {
            var x = CatName.split('~');
            document.getElementById('hdnId').value = x[0];
            $('#lblCatName').html(x[1]);
            Attune.Kernel.InventoryCommon.InventoryWebService.GetAllCategory(x[0], pSetValues);
            return false;
        }

        function pSetValues(tmpVal) {
            document.getElementById('lstSeqNumber').options.length = 0;
            var lstSeqNumber = document.getElementById('<%= lstSeqNumber.ClientID %>');
            for (var i = 0; i < tmpVal.length; i++) {
                if (tmpVal[i] != '') {
                    var tComblist1 = document.createElement("option");
                    lstSeqNumber.options.add(tComblist1);
                    tComblist1.text = tmpVal[i].CategoryName; ;
                    tComblist1.value = tmpVal[i].CategoryID; ;
                }
            }
            $find('MPESeqNumber').show();
            return false;
        }
        function HideSeqNumber() {
            $find('MPESeqNumber').hide();
            return false;
        }

        function GetSeqNumber() {
            var sel = document.getElementById('lstSeqNumber');

            $('#hdnSeqValue').val('');
            for (var i = 0; i < sel.options.length; i++) {
                $('#hdnSeqValue').val($('#hdnSeqValue').val() + sel.options[i].value + '$');
            }
            $find('MPESeqNumber').hide();
            return true;
        }
        
        
    </script>

    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
        var strSave = SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Save') == null ? "Save" : SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Save')
        var strUpdate = SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Update') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_ProductCategories_aspx_Update')
        var informMsg = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
        var okMsg = SListForAppMsg.Get('InventoryMaster_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryMaster_Ok');
        var cancelMsg = SListForAppMsg.Get('InventoryMaster_Cancel');
          
    </script>

    <script language="javascript" type="text/javascript">

        function checkDetails() {
            if (document.getElementById('txtCategoryName').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Selectcategoryname') == null ? "Provide category name" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Selectcategoryname')
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtCategoryName').focus();
                return false;
            }
            else {
                if (document.getElementById('btnFinish').value == strSave && document.getElementById('btnFinish').value != strUpdate) {
                    var flag = '';
                    //var sCategoryName = document.getElementById('txtCategoryName').value;
                   var sCategoryName = $('#txtCategoryName').val().trim();
                    $('#gvCategory tbody tr td span').each(function() {
                        $('.btnstyle td span').addClass("btn");
                        $('.btnstyle td a').addClass("btn");
                        if (($(this).html().toUpperCase()).match(sCategoryName.toUpperCase())) {
                            flag = 'set';
                        }
                    });

                    if (flag != '') {
                        var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_alreadyexistsy') == null ? "Category name already exists" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_alreadyexistsy')

                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtCategoryName').focus();
                        return false;
                    }

                    if ($("#hdnInventory_Attributes_Value").val() != "N") {
                        AddedItems();
                    }
                    //fnShowProgress();
                    return true;

                }
                else {


                    if ($("#hdnInventory_Attributes_Value").val() != "N") {
                        AddedItems();
                    }


                    //fnShowProgress();
                    return true;
                }
            }
            if (document.getElementById('hdnIsDeletable').value == "N" && document.getElementById('btnFinish').value == strUpdate) {
                if (document.getElementById('chkDelete').checked == false) {
                    var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorytagged') == null ? "Category tagged against the product cannot be deleted" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorytagged')
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('chkDelete').checked = true;
                    document.getElementById('btnFinish').value = strSave;
                    return false;

                }


                if ($("#hdnInventory_Attributes_Value").val() != "N") {
                    AddedItems();
                }
                //fnShowProgress();
                return true;

            }

        }

        function pageLoad() {
            document.getElementById('txtCategoryName').focus();
        }

        function SetValues(obj, TaxDetails) {
            var x = obj.split('~');
            if ($("#hdnInventory_Attributes_Value").val() != "N") {
                $('[id$="tbItemTable"] tbody tr').remove();
                $('#hdnItemDetails').val(TaxDetails);
                SetOrderItems();
            }
            var isDeleted = x[3];
            var Isdeletable = x[4];
            if ($.trim(isDeleted).toLowerCase() == "y") {
                document.getElementById('chkDelete').checked = false;
                document.getElementById('hdnIsDeleted').value = 'N';
            }
            else {
                document.getElementById('chkDelete').checked = true;
                document.getElementById('hdnIsDeleted').value = 'Y';
            }
            if ($.trim(Isdeletable).toLowerCase() == "y") {
                document.getElementById('hdnIsDeletable').value = 'Y';
            }
            else {
                document.getElementById('hdnIsDeletable').value = 'N';
            }
            document.getElementById('txtCategoryName').value = x[1];
            //document.getElementById('txtCategoryName').disabled = true;

            document.getElementById('hdnCategoryToBeDel').value = x[1];
            document.getElementById('txtDescription').value = x[2];
            document.getElementById('hdnId').value = x[0];
            document.getElementById('btnFinish').value = strUpdate;
            document.getElementById('lblmsg').innerHTML = '';
            document.getElementById('hdnStatus').value = strUpdate;
            if ($("#hdnInventory_Attributes_Value").val() != "N") {
                if (x[5] != '') {
                    $('#hdnCategorieAttributesMapping').val(x[5]);
                    $('#hdnAttributesDetails').val(x[5]);
                    SetAttributesValues();

                }
                else {
                    $('#hdnCategorieAttributesMapping').val('');
                    $('#hdnAttributesDetails').val('');
                    myCreateFunction();
                }
                $('#txtTax').val(x[6]);
            }
        }

        function FnClear() {
            document.getElementById('txtCategoryName').disabled = false;
            document.getElementById('txtCategoryName').value = '';
            document.getElementById('txtDescription').value = '';
            document.getElementById('hdnIsDeleted').value = '';
            document.getElementById('hdnIsDeletable').value = '';
            document.getElementById('hdnId').value = 0;
            document.getElementById('btnFinish').value = strSave;
            document.getElementById('lblmsg').innerHTML = '';
            document.getElementById('hdnStatus').value = strSave;
            document.getElementById('tdAttributeslist').disabled = true; 
            $("#chkDelete").prop("checked", true);
            $('#hdnCategorieAttributesMapping').val('');
            $('#hdnAttributesDetails').val('');
            $('#txtTax').val('');
            $('#hdnItemDetails').val('');
            $('[id$="tbItemTable"] tbody tr').remove();
            $('#ddlTaxTypeId').val('0');
            $('#ddlState').val('0');
            $('#ddlTaxType').val('0');
            $('#txtValidFrom').val('');
            $('#txtValidTo').val('');
            $('[id$="tblAttributes"] tbody tr').remove();
            myCreateFunction();
            return false;
        }

        function showDeleteDiv(id) {

            if (document.getElementById(id).checked) {

                document.getElementById('hdnIsDeleted').value = 'N';
            }
            else {

                document.getElementById('hdnIsDeleted').value = 'Y';
            }
        }

        function FnDelete() {

            if (document.getElementById('hdnId').value.trim() == 0 || document.getElementById('txtCategoryName').value.trim() == ''
                                                                    || document.getElementById('hdnCategoryToBeDel').value != document.getElementById('txtCategoryName').value) {

                if (document.getElementById('hdnId').value.trim() == 0 && document.getElementById('txtCategoryName').value.trim() == '') {
                    var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorytodelete') == null ? "Select the category to delete" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorytodelete')
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                } else {
                    var userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorynotexist') == null ? "Category does not exist" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_Categorynotexist')
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

                return false;
            }

            userMsg = SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_CategoryWishtodelete') == null ? "Do you wish to delete this category?" : SListForAppMsg.Get('InventoryMaster_ProductCategories_aspx_CategoryWishtodelete')
            if (ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg)) {
                return false;
            }
            return true;
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
                //             if (window.event.shiftKey) {
                //                 alert(1);
                //                 isCtrl = false;
                //             }
                //             else {
                //                 if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                //                     isCtrl = true;
                //                 }
                if (key >= 65 && key <= 90 || key == 8 || key == 37 || key <= 39 || key >= 97 && key <= 122 || key == 32 || key == 46 || key == 59 || key == 44 || key == 47 || key == 40 || key == 41 || key == 38) {
                    isCtrl = true;
                }
                else {
                    //                     if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                    isCtrl = false;
                }




                //             }


            } return isCtrl;
        }
        function checkCodes() {

            var pagecounts =
            alert(pagecounts);
            var tbl = document.getElementById('gvCategory');
            var searchText = document.getElementById('txtCategoryNameWiseSearch').value.toUpperCase().trim();
            var isTrue = 1;

            for (var i = 1; i < tbl.rows.length - 1; i++) {
                var tblRow = tbl.rows[i];
                var tblCell = tblRow.cells[1];

                var tblSpan = tblCell.innerHTML;
                if (searchText != "") {
                    if (tblSpan.toLowerCase().indexOf(searchText.toLowerCase()) == 0) {
                        //tblRow.style.display = "block"
                        $('#' + tblRow).addClass('show');

                    }
                    else {
                        //tblRow.style.display = "none"
                        $('#' + tblRow).addClass('hide');
                    }
                }
                else {
                    //tblRow.style.display = "block"
                    $('#' + tblRow).addClass('show');

                }

            }

        }

        function SetMasterValues(obj) {

            var x = obj.CategoryName;
            var y = obj.MasterCategoryID;

            document.getElementById('txtCategoryName').value = x;
            document.getElementById('hdnId').value = y;
            document.getElementById('btnFinish').value = strUpdate;
            document.getElementById('lblmsg').innerHTML = '';
            document.getElementById('hdnStatus').value = strUpdate;


        }

        function pageLoad() {

            if ($find('gvCategory_ctl01_AutoCompleteSearchProduct') != null) {
                $find('gvCategory_ctl01_AutoCompleteSearchProduct')._onMethodComplete = function(result, context) {

                $find('gvCategory_ctl01_AutoCompleteSearchProduct')._update(context, result, false);
                    fnFreetext(result, context);

                };
            }
        }

        function fnFreetext(result, context) {
            if (result == "") {
                var userMsg = SListForAppMsg.Get("InventoryMaster_ProductCategories_aspx_03") == null ? "Free Text not allowed" : SListForAppMsg.Get("InventoryMaster_ProductCategories_aspx_03");
                ValidationWindow(userMsg, errorMsg);
            }
        }
    
    </script>
</body>
</html>
