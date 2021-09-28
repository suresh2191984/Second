<%@ Page Language="C#" AutoEventWireup="true" CodeFile="INVKitMaster.aspx.cs" Inherits="Inventory_INVKitMaster" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title> 
    
    </head>
<body id="Body1" runat="server" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryKit/WebService/InventoryKit.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
  
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                <table class="w-100p">
                                    <tr>
                                        <td>
                            <table id="tblKitName" class="w-100p searchPanel">
                                <tr class="panelContent lh30">
                                    <td class="w-12p" >
                                        <asp:Label ID="lblSelectKit" Text="Select Kit" runat="server" 
                                            meta:resourcekey="lblSelectKitResource1" />
                                    </td>
                                    <td class="a-left w-18p" >
                                        <asp:DropDownList ID="ddlSelectKit" TabIndex="1" runat="server" CssClass="small"
                                            OnSelectedIndexChanged="ddlSelectKit_SelectedIndexChanged" 
                                            AutoPostBack="True" meta:resourcekey="ddlSelectKitResource1">
                                                            
                                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-9p a-center">
                                      <asp:CheckBox ID="chkCommon" runat="server" 
                                            meta:resourcekey="chkCommonResource1"/> 
                                        <asp:Label ID="lblCommonKit" runat="server" Text="CommonKit" meta:resourcekey="lblCommonKit"></asp:Label>
                                                                                                                         
                                    </td>                                     
                                    <td class="a-left w-10p">
                                        <input id="btnAddNewKit" class="btn" name="add1" tabindex="2"
                                            onclick="HideTable();"
                                            type="button" value="Add New" meta:resourcekey="btnAddNewKitResource1"/>
                                    </td>
                                    <td class="a-center">
                                        <table id="tblAddKit" class="hide w-100p">
                                                            <tr>
                                                                <asp:HiddenField ID="hdnNewKitValue" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnSetListTable" runat="server" />
                                                            </tr>
                                                        </table>
                                                    </td>
                                </tr>
                                <tr class="panelContent lh30">
                                    <td colspan="5">
                                        <table id="productDetailtable" class="hide w-100p">
                                            <tr>
                                                <td class="a-left w-12p">
                                                                    <asp:Label ID="lblNewKit" runat="server" Text="New Kit Name" 
                                                                        meta:resourcekey="lblNewKitResource1"></asp:Label>
                                                </td>
                                                <td class="w-18p">
                                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtNewKitName" runat="server" TabIndex="3" onblur="return checkKitExists();"
                                                                        CssClass="small" meta:resourcekey="txtNewKitNameResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td class="a-left w-12p">
                                                                    <asp:Label ID="lblProductCode" Text="Kit Code" runat="server" 
                                                                        meta:resourcekey="lblProductCodeResource1"></asp:Label>
                                                </td>
                                                <td  class="w-18p">
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductCode" runat="server" CssClass="small"
                                                                        TabIndex="4" meta:resourcekey="txtProductCodeResource1"></asp:TextBox>
                                                                </td>
                                            
                                                <td class="a-left w-12p">
                                                    <asp:Label ID="Rs_CategoryName" Text="Product / Kit Category" runat="server" 
                                                        meta:resourcekey="Rs_CategoryNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="small" TabIndex="5" 
                                                        meta:resourcekey="ddlCategoryResource1">
                                                    </asp:DropDownList>
                                                    <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" visible="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_Type" Text="Product Type" runat="server" 
                                                        meta:resourcekey="Rs_TypeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlType" runat="server" CssClass="small" TabIndex="6" 
                                                        meta:resourcekey="ddlTypeResource1">
                                                    </asp:DropDownList>
                                                    <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblMake" Text="Make / Brand" runat="server" 
                                                        meta:resourcekey="lblMakeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMake" runat="server" CssClass="small" TabIndex="7" 
                                                        meta:resourcekey="txtMakeResource1"></asp:TextBox>
                                                </td>
                                            
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_ManufactureName" Text="Manufacturer Name" runat="server" 
                                                        meta:resourcekey="Rs_ManufactureNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMfgName" runat="server" CssClass="small" TabIndex="9" 
                                                        meta:resourcekey="txtMfgNameResource1"></asp:TextBox>
                                                    <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_ManufactureCode" Text="Manufacturer Code" runat="server" 
                                                        meta:resourcekey="Rs_ManufactureCodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMfgCode" runat="server" CssClass="small" TabIndex="10" 
                                                        meta:resourcekey="txtMfgCodeResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Description" Text="Description" runat="server" 
                                                        meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDescription" runat="server" TabIndex="11" CssClass="small" 
                                                        TextMode="MultiLine" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblUnit" runat="server" Text="Least Sellable Unit" 
                                                        Visible="False" meta:resourcekey="lblUnitResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="bUnits" runat="server" onchange="checkLSU()" 
                                                        CssClass="small" Visible="False" meta:resourcekey="bUnitsResource1" />
                                                </td>
                                            </tr>
                                            <tr class="hide">
                                                <td class="a-left hide">
                                                    <asp:Label ID="lblProductModel" Text="Product Model" runat="server" 
                                                        meta:resourcekey="lblProductModelResource1"></asp:Label>
                                                </td>
                                                <td class="hide">
                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductModel" runat="server" CssClass="small"
                                                        TabIndex="8" meta:resourcekey="txtProductModelResource1"></asp:TextBox>
                                                </td>
                                                <td colspan="4"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                <table id="tblAddProduct" class="w-100p" runat="server">
                                            <tr id="Tr1" runat="server">
                                                <td id="Td1" runat="server" class="w-30p">
                                                    <asp:Label ID="lblProduct" meta:resourcekey="lblProductResource1" Width="164px"  Text="Product Name" runat="server" />
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductName" onkeydown="return checkname();" runat="server" TabIndex="12"
                                                                CssClass="small"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProductName"
                                                                BehaviorID="AutoCompleteExLstGrp11" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" 
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1"
                                                                OnClientItemSelected="OnSelectProducts" FirstRowSelected="True" ServiceMethod="GetAllProducts"
                                                                ServicePath="~/InventoryKit/WebService/InventoryKit.asmx" 
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                            <asp:HiddenField ID="hdnProductID" runat="server" />
                                                             <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                        </td>
                                                <td id="Td2" class="a-left w-30p" runat="server"  >
                                                    <asp:Label ID="lblQuantity" Text="Quantity" Width="160px" CssClass="paddingL10" runat="server" meta:resourcekey="lblQuantityResource1" />
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtQuantity" runat="server" TabIndex="13" MaxLength="10" CssClass="small" onKeyDown="return validateNaN(event);">
                                            </asp:TextBox>
                                                </td>
                                                <td id="Td3" runat="server" >
                                            <input type="button" id="add" name="add" tabindex="14" meta:resourcekey="addResource1"
                                                onclick="return ckeckIsExists();" class="btn" value="Add" />
                                            <asp:HiddenField ID="hdnSelectKit" runat="server" />
                                            <asp:HiddenField ID="hdnMasterID" Value="0" runat="server" />
                                            <asp:HiddenField ID="hdnKitDetails" runat="server" />
                                            <asp:HiddenField ID="hdnCanedit" runat="server" />
                                            <asp:HiddenField ID="hdnIsDelete"  runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="tblKitDefinition" border="1" class="w-100p gridView">
                            </table>
                            <table class="w-100p">
                                <tr class="lh35">
                                    <td class="a-right w-45p" id="tdIsActive" runat="server">
                                        <asp:CheckBox ID="chkIsActive" runat="server" Text="IsActive" Checked="True" 
                                            Font-Bold="True" meta:resourcekey="chkIsActiveResource1" />
                                    </td>
                                    <td class="a-left" id="btnSaveID">
                                        <asp:Button ID="btnSave" runat="server" OnClientClick="return CheckProductList();"
                                            Text="Save" CssClass="btn" OnClick="btnSave_Click" 
                                            meta:resourcekey="btnSaveResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
            

   
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
  
    <script type="text/javascript">
        var userMsg;
        function checkname() {
            var KName = document.getElementById('ddlSelectKit').value;
            var KitName = document.getElementById('txtNewKitName').value;
            if (KitName.trim() == "" && KName == 0) {
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideKitName');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide any KitName", "Alert");
                }
                document.getElementById('ddlSelectKit').focus();
                return false;
            }
            return true;
        }
        function checkKitExists() {
            var newKit = document.getElementById('txtNewKitName').value.trim();
            var checkKit = document.getElementById('hdnSetListTable').value.split('^');
            for (i = 0; i < checkKit.length; i++) {
                if (checkKit[i] != "") {
                    if (checkKit[i].split('~')[0].trim() == newKit) {
                        var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_KitNameExists');
                        var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                        if (userMsg != null && errorMsg != null) {
                            ValidationWindow(userMsg, errorMsg);
                        }
                        else {
                            ValidationWindow("Kit Name already exists", "Alert");
                        }

                        return false;
                    }

                }
            }
        }

        function ProductItemSelected(sender, args) {


            var ProductCategory = document.forms[0][sender.get_element().name].value; //$("#" + sender.get_element().name).val(); //document.getElementById(sender.get_element().name).value;  //
            var Product = '';
            var result = '';

            if (ProductCategory == '' || ProductCategory == undefined) {

                Product = ProductCategory;
                document.forms[0][sender.get_element().name].value = Product;

            }
            else {

                result = ProductCategory.match(/[^[\]]+(?=])/g)
                if (result != null) {
                    Product = ProductCategory.replace(/\s*\[.*?\]\s*/g, '');
                    document.forms[0][sender.get_element().name].value = Product;
                    // $('#' + sender.get_element().name).val(Product);
                }
                else {

                    Product = ProductCategory;
                    document.forms[0][sender.get_element().name].value = Product;

                }
            }
        }


        function OnSelectProducts(source, eventArgs) {
            var tName = eventArgs.get_text().trim();
            var tProductID = eventArgs.get_value().split('~')[1].trim();
            document.getElementById('txtProductName').value = tName;
            document.getElementById('hdnProductID').value = tProductID;
            ProductItemSelected(source, eventArgs);
        }

        function BindProductList() {


            var ProductID = document.getElementById('hdnProductID').value;
            var ProductName = document.getElementById('txtProductName').value;
            var Qty = Number(document.getElementById('txtQuantity').value).toFixed(2);
            var MasterID = document.getElementById('hdnMasterID').value;

            document.getElementById('hdnSelectKit').value += ProductName + "~" + Qty + "~" + ProductID + "~" + MasterID + "^";
            TbList();

            document.getElementById('txtProductName').value = "";
            document.getElementById('txtQuantity').value = "";
            document.getElementById('hdnProductID').value = "";
            document.getElementById('hdnNewKitValue').value = "0";
            document.getElementById('hdnMasterID').value = "0";
            var save = document.getElementById('hdnSelectKit').value.split("^");
            if (save.length > 0) {
                document.getElementById('btnSaveID').style.display = "table-cell";
                // document.getElementById('tdIsActive').style.display = "block";
            }
        }

        function TbList() {
            clearTable();
            var x = document.getElementById('hdnSelectKit').value.split("^");
            if ((x.length > 0) && (x[0] != "")) {
                var Headrow = document.getElementById('tblKitDefinition').insertRow(0);
                var CanEdit = document.getElementById('hdnCanedit').value;
                Headrow.id = "HeadID";
                Headrow.style.fontWeight = "bold";
                //Headrow.addClass("bold");
                Headrow.className = "gridHeader";
                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);

                cell1.innerHTML = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_productname') == null ? "product name" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_productname');
                cell2.innerHTML = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_quantity') == null ? "quantity" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_quantity'); //"quantity";
                cell3.innerHTML = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_smallselect') == null ? "select" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_smallselect'); //"select";
                //                if (CanEdit == "N") 
                //                {
                //                    document.getElementById('tblAddProduct').style.display = 'none';
                //                    cell3.style.display = "none";
                //                }
                for (i = 0; i < x.length; i++) 
                {
                    if (x[i] != "") 
                    {
                        y = x[i].split('~');
                        var row = document.getElementById('tblKitDefinition').insertRow(i + 1);
                        row.style.height = "13px";
                        //row.addClass("h-13");
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);

                        cell1.innerHTML = y[0];
                        cell2.innerHTML = y[1];

                        cell3.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "' onclick='btnEdit_OnClick(name);' value = '' title='Click to Edit' type='button' class='ui-icon ui-icon-pencil marginR8 pull-left marginL10 pointer'  /> " +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "' onclick='btnDelete(name);' value = '' type='button' class='ui-icon ui-icon-trash marginL5 pull-left pointer' title='Click to Delete' />"
                        //if (CanEdit == "N") 
                        //{
                        // cell3.style.display = "none";

                        //}
                    }
                }

                if (x.length > 0) {
                    document.getElementById('btnSaveID').style.display = "table-cell";
                    //$('#btnSaveID').removeClass().addClass('displaytd');
                    if (CanEdit == "N") {
                      document.getElementById('tdIsActive').style.display = "none";
                      //  $('#tdIsActive').removeClass().addClass('hide');
                        //document.getElementById('btnSaveID').align = "center";
                    }
                    else {
                        document.getElementById('tdIsActive').style.display = "table-cell";
                        //$('#tdIsActive').removeClass().addClass('displaytd');
                    }
                }
            }
            document.getElementById('add').value = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_Add') == null ? "Add" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_Add');
        }
        function btnDelete(sEditedData) {
            var i;
            var y = sEditedData.split('~');
//            document.getElementById('productDetailtable').style.display = "table";
//            document.getElementById('txtProductName').value = y[0];
//            document.getElementById('hdnProductID').value = y[2];
//            document.getElementById('txtQuantity').value = y[1];
//            document.getElementById('hdnMasterID').value = y[3];
            var x = document.getElementById('hdnSelectKit').value.split("^");
            document.getElementById('hdnSelectKit').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnSelectKit').value += x[i] + "^";
                    }
                }
            }
            TbList();
//            var ProductID = document.getElementById('hdnProductID').value;
//            var ProductName = document.getElementById('txtProductName').value;
//            var Qty = Number(document.getElementById('txtQuantity').value).toFixed(2);
//            var MasterID = document.getElementById('hdnMasterID').value;
//            document.getElementById('hdnIsDelete').value += ProductID + ",";
//            document.getElementById('hdnSelectKit').value += ProductName + "~" + Qty + "~" + ProductID + "~" + MasterID + "^";
//            document.getElementById('txtProductName').value = '';
//            document.getElementById('txtQuantity').value = '';
        }
        function btnEdit_OnClick(sEditedData) {
            var y = sEditedData.split('~');
            document.getElementById('productDetailtable').style.display = "table";
            document.getElementById('txtProductName').value = y[0];
            document.getElementById('hdnProductID').value = y[2];
            document.getElementById('txtQuantity').value = y[1];
            document.getElementById('hdnMasterID').value = y[3];

            var x = document.getElementById('hdnSelectKit').value.split("^");

            document.getElementById('hdnSelectKit').value = '';
            for (var i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnSelectKit').value += x[i] + "^";
                    }
                }
            }
            TbList();
            document.getElementById('add').value = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_Update') == null ? "Update" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_Update');
        }

        function clearTable() {
            for (var i = document.getElementById("tblKitDefinition").rows.length; i > 0; i--) {
                document.getElementById("tblKitDefinition").deleteRow(i - 1);
            }
        }
        function HideTable() {
            var AddNew = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_AddNew') == null ? "Add New" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_AddNew');
            if (document.getElementById('btnAddNewKit').value == AddNew) {
                document.getElementById('ddlSelectKit').selectedIndex = 0;
                document.getElementById('tblAddKit').style.display = "block";
                //$('#tblAddKit').removeClass().addClass('show');
                document.getElementById('productDetailtable').style.display = "table";
                //$('#productDetailtable').removeClass().addClass('w-100p displaytb');
                document.getElementById('btnAddNewKit').value = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_11') == null ? "Cancel" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_11');
                document.getElementById('txtNewKitName').value = "";
                document.getElementById('txtNewKitName').focus();

                // document.getElementById('ddlCategory').value = '0';
                //document.getElementById('ddlType').value = '0';
                document.getElementById('ddlCategory').selectedIndex = 0;
                //document.getElementById('ddlType').selectedIndex = 0;


            }
            else {
                document.getElementById('tblAddKit').style.display = "none";
                //$('#tblAddKit').removeClass().addClass('hide');
                document.getElementById('productDetailtable').style.display = "none";
                //$('#productDetailtable').removeClass().addClass('hide');
                document.getElementById('btnAddNewKit').value = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_AddNew') == null ? "Add New" : SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_AddNew');

            }
            document.getElementById('hdnSelectKit').value = "";
            clearTable();
        }

        function ckeckIsExists() {

            if (document.getElementById('txtNewKitName').value == "" && document.getElementById('ddlSelectKit').options[document.getElementById('ddlSelectKit').selectedIndex].value == 0) {
                document.getElementById('txtNewKitName').value = "";
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideKitValidation');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide Kit Name", "Alert");
                }
                document.getElementById('txtNewKitName').focus();
                return false;
            }

            if (document.getElementById('hdnProductID').value == "" || document.getElementById('hdnProductID').value == 0) {
                userMsg = SListForApplicationMessages.Get('Inventory\\INVKitMaster.aspx_3');
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideProductNameQty');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide Product Name & Quantity", "Alert");
                }
                document.getElementById('txtProductName').value = "";
                document.getElementById('txtQuantity').value = ""
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtProductName').value.trim() == "") {
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideProductName');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide Product Name", "Alert");
                }
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtQuantity').value <= "0") {
                document.getElementById('txtQuantity').focus();
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideQuantity');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide Quantity Greater than Zero", "Alert");
                }
                document.getElementById('txtQuantity').focus();
                return false;
                
            }
            //            if (document.getElementById('hdnCanedit').value == "N") {
            //                document.getElementById('ddlSelectKit').focus();
            //                alert("This Kit is already Created, kindly Define New Kit");
            //                return false;
            //            }
            var userMsg = SListForAppDisplay.Get('InventoryKit_INVKitMaster_aspx_Update');
            userMsg = userMsg == null ? 'Update' : userMsg;
            if (document.getElementById('add').value != userMsg) {

                var x = document.getElementById('hdnSelectKit').value.split("^");
                var pProductId = document.getElementById('hdnProductID').value;
                var y; var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[2] == pProductId) {
                            var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProductCombination');
                            var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                            if (userMsg != null && errorMsg != null) {
                                ValidationWindow(userMsg, errorMsg);
                            }
                            else {
                                ValidationWindow("Product combination already exist", "Alert");
                            }
                            document.getElementById('txtProductName').value = '';
                            document.getElementById('hdnProductID').value = '';
                            document.getElementById('txtProductName').focus();
                            return false;
                        }
                    }
                }
            }
            BindProductList();
            document.getElementById('txtProductName').focus();
        }

        function CheckProductList() {
            if (document.getElementById('txtNewKitName').value == "" && document.getElementById('ddlSelectKit').options[document.getElementById('ddlSelectKit').selectedIndex].value == 0) {
                document.getElementById('txtNewKitName').value = "";
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_ProvideKitValidation');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Provide Kit Name", "Alert");
                }
                document.getElementById('txtNewKitName').focus();
                return false;
            }
            if (document.getElementById('ddlCategory').value == "0" || document.getElementById('ddlCategory').value == "") {
                document.getElementById('ddlCategory').value = "0";
                document.getElementById('ddlCategory').focus();
                userMsg = SListForApplicationMessages.Get('Inventory\\INVKitMaster.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_SelectProduct');
                    var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                    if (userMsg != null && errorMsg != null) {
                        ValidationWindow(userMsg, errorMsg);
                    }
                    else {
                        ValidationWindow("Select Product Category", "Alert");
                    }
                    return false;
                }
            }
            if (document.getElementById('ddlType').value == "0" || document.getElementById('ddlType').value == "") {
                document.getElementById('ddlType').value = "0";
                document.getElementById('ddlType').focus();
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_SelectProductType');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Select Product Type", "Alert");
                }
                return false;
            }
            if (document.getElementById('txtMfgName').value == "") {
                document.getElementById('txtMfgName').value = "";
                document.getElementById('txtMfgName').focus();
                var userMsg = SListForAppMsg.Get('InventoryKit_INVKitMaster_aspx_EnterManufacturer');
                var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Enter Manufacturer Name", "Alert");
                }
                return false;
            }

            document.getElementById('hdnKitDetails').value = document.getElementById('hdnSelectKit').value;

        }
        
       
    </script>
 <asp:HiddenField ID="hdnMessages" runat="server" />
  </form>
</body>   
</html>
