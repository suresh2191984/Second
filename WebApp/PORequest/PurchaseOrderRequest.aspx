<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrderRequest.aspx.cs" Inherits="PORequest_PurchaseOrderRequest" EnableEventValidation="false" meta:resourcekey="PageResource1"  %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> Purchase Order Request</title>
    
    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get("PORequest_Error") == null ? "Alert" : SListForAppMsg.Get("PORequest_Error");
        function locationdetails() {
            
            var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
            if (Trustedorgid > 0) {

                document.getElementById('hdnSelectOrgid').value = Trustedorgid;
            }

            var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

            if (Fromlocationid > 0) {

                document.getElementById('hdnFromLocationID').value = Fromlocationid;
            }

        }
    
    
    
       function checkDetails() {
            if (document.getElementById('txtPurchaseOrderDate').value == '') {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_01") == null ? "Select purchase order date" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtPurchaseOrderDate').focus();
                return false;
            }

            if (document.getElementById('ddlTrustedOrg').value == 0) {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_02") == null ? "Select Organization" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }


            if (document.getElementById('ddlLocation').value == 0) {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_03") == null ? "Select location" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }

          
            document.getElementById('btnGeneratePO').style.display = "hide";
            return true;
        }


        function GetLocationlist() {


            var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

            document.getElementById('hdnSelectOrgid').value = drpOrgid;
            var options = document.getElementById('hdnlocation').value;
            var ddlLocation = document.getElementById('ddlLocation');
            ddlLocation.options.length = 0;
            var optn1 = document.createElement("option");
            ddlLocation.options.add(optn1);
            var cell1html = SListForAppDisplay.Get("PORequest_PurchaseOrderRequest_aspx_07") == null ? "-----Select----" : SListForAppDisplay.Get("PORequest_PurchaseOrderRequest_aspx_07");
            optn1.text = cell1html;
            optn1.value = "0";

            var list = options.split('^');
            if (list.length > 0) {
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


        }




        function checkname() {
        
            var SelectOrgID1= document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
            var SelectOrgID = document.getElementById('ddlTrustedOrg').value;
            var SelectLocationID = document.getElementById('ddlLocation').value;
            if (SelectOrgID == 0 && SelectLocationID == 0) {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_04") == null ? "Select organisation and location" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_04");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
        }
        function checkKitExists() {
            locationdetails();
            var SelectOrgID = document.getElementById('ddlTrustedOrg').value;
            var SelectLocationID = document.getElementById('ddlLocation').value;
            if (SelectOrgID == 0 && SelectLocationID == 0) {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_04") == null ? "Select organisation and location" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_04");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
            $('#divSearch').show();
            return true;
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
            var tUnit = eventArgs.get_value().split('~')[2].trim();
            var tParentProductID = eventArgs.get_value().split('~')[3].trim();
           
            document.getElementById('txtProductName').value = tName;
            document.getElementById('hdnProductID').value = tProductID;
            if (tParentProductID > 0) {
                document.getElementById('hdnParentProductID').value = tParentProductID;
            }
           if (tUnit != 'NAN' && tUnit != '') {

                document.getElementById('drpUnit').value = tUnit;
            }
            else {
                document.getElementById('drpUnit').value = "0";
            }
            ProductItemSelected(source, eventArgs);
        }

        function BindProductList() {
                       
            var ProductID = document.getElementById('hdnProductID').value;
            var ProductName = document.getElementById('txtProductName').value;
            var UnitText = document.getElementById('drpUnit').value;
            var Qty = document.getElementById('txtQuantity').value;
            var ParentProductID = document.getElementById('hdnParentProductID').value;
            document.getElementById('hdnSelectProductslist').value += ProductName + "~" + UnitText + "~" + Qty + "~" + ProductID + "~" + ParentProductID + "^";

            TbList();
        
            document.getElementById('txtProductName').value = "";
            document.getElementById('drpUnit').value = "0";
            document.getElementById('txtQuantity').value = "";
            document.getElementById('hdnProductID').value = "";
            document.getElementById('hdnParentProductID').value = "0";
            var save = document.getElementById('hdnSelectProductslist').value.split("^");
            if (save.length > 0) {
                $('#btnSaveID').show();
            }
        }

        function TbList() {
          
            clearTable();
            var x = document.getElementById('hdnSelectProductslist').value.split("^");
            if ((x.length > 0) && (x[0] != "")) {
                var Headrow = document.getElementById('tblproductsDetails').insertRow(0);
                Headrow.id = "HeadID";
                Headrow.style.fontWeight = "bold";
                Headrow.className = "gridHeader";
                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);

                var Productname = SListForAppDisplay.Get('PORequest_PurchaseOrderRequest_aspx_01');
                if (Productname == null) {
                    Productname = "Product name";
                }

                var Units = SListForAppDisplay.Get('PORequest_PurchaseOrderRequest_aspx_02');
                if (Units == null) {
                    Units = "Units";
                }

                var Quantity = SListForAppDisplay.Get('PORequest_PurchaseOrderRequest_aspx_03');
                if (Quantity == null) {
                    Quantity = "Quantity";
                }

                var Select = SListForAppDisplay.Get('PORequest_PurchaseOrderRequest_aspx_04');
                if (Select == null) {
                    Select = "Select";
                }



                cell1.innerHTML = Productname;
                cell2.innerHTML = Units;
                cell3.innerHTML = Quantity;
                cell4.innerHTML = Select;

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        var row = document.getElementById('tblproductsDetails').insertRow(i + 1);
                        row.style.height = "13px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);

                        cell1.innerHTML = y[0];
                        cell2.innerHTML = y[1];
                        cell3.innerHTML = y[2];
                        cell4.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' class='ui-icon with-out-bkg ui-icon-pencil b-none pointer pull-left' title='Click to edit'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='ui-icon ui-icon-trash b-none pointerm pull-left marginL5 pointer pull-left' title='Click to delete'  />"
                    }
                }
                if (x.length > 0) {
                    document.getElementById('btnSaveID').style.display = "show";
                }
            }
            document.getElementById('add').value = "Add";
        }
        function btnDelete(sEditedData) {
            var i;
            var x = document.getElementById('hdnSelectProductslist').value.split("^");
            document.getElementById('hdnSelectProductslist').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnSelectProductslist').value += x[i] + "^";
                    }
                }
            }
            TbList();
        }
        function btnEdit_OnClick(sEditedData) {
            
            var y = sEditedData.split('~');

            document.getElementById('txtProductName').value = y[0];
            document.getElementById('drpUnit').value = y[1];
            document.getElementById('txtQuantity').value = y[2];
            document.getElementById('hdnProductID').value = y[3];
            document.getElementById('hdnParentProductID').value = y[4];

            var x = document.getElementById('hdnSelectProductslist').value.split("^");

            document.getElementById('hdnSelectProductslist').value = '';
            for (var i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnSelectProductslist').value += x[i] + "^";
                    }
                }
            }
            TbList();
            document.getElementById('add').value = "Update";
        }

        function clearTable() {
            for (var i = document.getElementById("tblproductsDetails").rows.length; i > 0; i--) {
                document.getElementById("tblproductsDetails").deleteRow(i - 1);
            }
        }
        function HideTable() {
            if (document.getElementById('btnAddNewKit').value == "Add New") {
                document.getElementById('ddlSelectKit').selectedIndex = 0;
                document.getElementById('tblAddKit').style.display = "show";
                document.getElementById('btnAddNewKit').value = "Cancel";
                document.getElementById('txtNewKitName').value = "";

            }
            else {
                document.getElementById('tblAddKit').style.display = "hide";
                document.getElementById('btnAddNewKit').value = "Add New";
            }
            document.getElementById('hdnSelectProductslist').value = "";
            clearTable();
        }
        function ckeckIsExists() {
        
            var IsTrue = true;
         
            if (document.getElementById('hdnProductID').value == "" || document.getElementById('hdnProductID').value == 0) {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05") == null ? "Provide Product Name" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtProductName').value = "";
                document.getElementById('drpUnit').value = "0";
                document.getElementById('txtQuantity').value = "";
                document.getElementById('hdnParentProductID').value = "0";
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtProductName').value.trim() == "") {
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05") == null ? "Provide Product Name" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            var UnitText = document.getElementById('drpUnit');
            if (UnitText.value == "0") {
                document.getElementById('drpUnit').focus();
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_06") == null ? "Provide Unit" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_06");
                ValidationWindow(userMsg, errorMsg);
            }

            if (document.getElementById('txtQuantity').value == "0" || document.getElementById('txtQuantity').value == "") {
                document.getElementById('txtQuantity').focus();
                var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_07") == null ? "Entered quantity must be greater than zero" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_07");
                ValidationWindow(userMsg, errorMsg);
            }
            if (document.getElementById('add').value != 'Update') {
                var x = document.getElementById('hdnSelectProductslist').value.split("^");
                var pProductId = document.getElementById('hdnProductID').value;
                var y; var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[3] == pProductId) {
                            var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_08") == null ? "Product combination already exist" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_08");
                            ValidationWindow(userMsg, errorMsg);
                            document.getElementById('txtProductName').value = '';
                            document.getElementById('hdnProductID').value = '';
                            document.getElementById('hdnParentProductID').value = "0";
                            document.getElementById('drpUnit').value = "0";
                            document.getElementById('txtQuantity').value = '';
                            document.getElementById('txtProductName').focus();
                            IsTrue = false;
                            return false;
                        }
                    }
                }
            }
            if (IsTrue == true) {
                BindProductList();
                document.getElementById('txtProductName').focus();
            }
            return true;
       
        }

        function CheckProductList() {
            document.getElementById('hdnProductDetails').value = document.getElementById('hdnSelectProductslist').value;
        }
        
   
        
    </script>
    
    
   
    
</head>
<body>
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                     <div class="contentdata">
                     
                     <ul>
                            <li>
                            </li>
                        </ul>
                        
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div>
                                    <table class="w-100p searchPanel">
                                        <tr>
                                            <td class="h-10">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-20p">
                                                <%=Resources.PORequest_ClientDisplay.PORequest_PurchaseOrderRequest_aspx_05%>
                                            </td>
                                            <td colspan="3" class="w-50p">
                                            <asp:TextBox ID="txtPurchaseOrderDate" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="small datePicker" 
                                            meta:resourcekey="txtPurchaseOrderDateResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-20p">
                                               
                                                 <asp:Label ID="lblOrgName" Text="Organization Name" runat="server" 
                                                     meta:resourcekey="lblOrgNameResource1" ></asp:Label>
                                            </td>
                                            <td colspan="3" class="w-10p">
                                                <asp:DropDownList   ID="ddlTrustedOrg" CssClass="ddl" TabIndex="1" 
                                                    runat="server" OnChange="GetLocationlist();" 
                                                    meta:resourcekey="ddlTrustedOrgResource1" > 
                                                </asp:DropDownList>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td class="w-20p">
                                                 <asp:Label ID="lblLocation" Text="Location Name" runat="server" 
                                                     meta:resourcekey="lblLocationResource1" ></asp:Label>
                                            </td>
                                            <td colspan="3" class="w-10p">
                                                <asp:DropDownList CssClass="ddl" ID="ddlLocation" TabIndex="2" runat="server"  
                                                    onchange="return checkKitExists();" meta:resourcekey="ddlLocationResource1"  > 
                                                         </asp:DropDownList>
                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                     
                                        <tr>
                                            <td>
                                            <asp:Label ID="lblcomments" Text="Comments" runat="server" 
                                                    meta:resourcekey="lblcommentsResource1" ></asp:Label>
                                            </td>
                                            <td colspan="3" class="w-10p">
                                                <asp:TextBox ID="txtComments" runat="server" CssClass="large" TabIndex="3" onKeyPress="return ValidateMultiLangChar(this);" 
                                                    meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="h-5 a-center" colspan="4">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        
                         <div id="divProduct" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="hide" id="divSearch" runat="server">
                                                                   
                                     <table id="tblAddProduct" class="w-100p" runat="server">
                                                <tr>
                                                        <td>
                                                            <asp:Label ID="lblProduct" Text="Product Name" runat="server" 
                                                                meta:resourcekey="lblProductResource1" />
                                                            <asp:TextBox ID="txtProductName" CssClass="small" onKeyPress="return ValidateMultiLangChar(this);"
                                                                onkeydown="return checkname();" runat="server" TabIndex="4" 
                                                                meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProductName"
                                                                BehaviorID="AutoCompleteExLstGrp11" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                                                                OnClientItemSelected="OnSelectProducts" FirstRowSelected="true" ServiceMethod="GetAllProducts"
                                                                ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx">
                                                            </ajc:AutoCompleteExtender>
                                                            <asp:HiddenField ID="hdnProductID" runat="server" />
                                                        </td>
                                                        <td>
                                                        <asp:Label ID="lblUnits" Text="Units" runat="server" 
                                                                meta:resourcekey="lblUnitsResource1" />
                                                         <asp:DropDownList ID="drpUnit" CssClass="ddl" runat="server" TabIndex="5" 
                                                                Width="89px" meta:resourcekey="drpUnitResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        
                                                        <td>
                                                            <asp:Label ID="lblQuantity" Text="Quantity" runat="server" 
                                                                meta:resourcekey="lblQuantityResource1" />
                                                            <asp:TextBox ID="txtQuantity" runat="server" TabIndex="6" CssClass="small" 
                                                                onKeyPress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;<input type="button" id="add" name="add" tabindex="7" onmouseout="this.className='btn'"
                                                                onclick="return ckeckIsExists();" onmouseover="this.className='btn btnhov'" class="btn"
                                                                style="width: 60px;" value="Add" />
                                                            <asp:HiddenField ID="hdnParentProductID" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnSelectProductslist" runat="server" />
                                                            <asp:HiddenField ID="hdnProductDetails" Value="" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                            <table id="tblproductsDetails" class="gridView w-100p">
                                            </table>
                                            
                                             <table class="w-100p">
                                                <tr>
                                                    <td class="a-center hide" id="btnSaveID">
                                                        <asp:Button ID="btnSave" runat="server" OnClientClick="return CheckProductList();"
                                                            Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                            onmouseout="this.className='btn'" OnClick="btnSave_Click" 
                                                            meta:resourcekey="btnSaveResource1" />
                                                         
                                                    </td>
                                                </tr>
                                            </table>
                                    
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                     
                       <input type="hidden" id="hdnlocation" runat="server" />
                       <input type="hidden" id="hdnSelectOrgid" runat="server" />
                       <input type="hidden" id="hdnFromLocationID" runat="server" />
                     </div>                
    <input type="hidden" id="hdnvalues" runat="server" />
    <asp:HiddenField ID ="hdnMessages" runat ="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
<script language="javascript" type="text/javascript">
    function AddNewProduct() {
        document.getElementById('divNewProduct').style.display = 'show';
        document.getElementById('divProduct').style.display = 'hide';
        document.getElementById('txtProductName').value = '';
        document.getElementById('ddlCategory').value = 0;
        document.getElementById('ddlType').value = 0;
        document.getElementById('txtDescription').value = '';
        document.getElementById('txtReOrderLevel').value = '';
        document.getElementById('chkIsScheduleHDrug').checked = false;
        document.getElementById('chkBatchNo').checked = false;
        document.getElementById('chkExpDate').checked = false;
        return false;
    }

    function NewProductcheckDetails() {


        if (document.getElementById('txtProductName').value == '') {
            var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05") == null ? "Provide product name" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_05");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtProductName').focus();
            return false;
        }

        if (document.getElementById('ddlType').value == "0") {
            var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_09") == null ? "Select type" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_09");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlType').focus();
            return false;
        }

        if (document.getElementById('ddlCategory').value == "0") {
            var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_10") == null ? "Select category name" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_10");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlCategory').focus();
            return false;
        }
        if (document.getElementById('txtReOrderLevel').value == '') {
            var userMsg = SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_11") == null ? "Provide reorder level" : SListForAppMsg.Get("PORequest_PurchaseOrderRequest_aspx_11");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtReOrderLevel').focus();
            return false;
        }
    }

    function NewProductCancel() {
        document.getElementById('divNewProduct').style.display = 'hide';
        document.getElementById('divProduct').style.display = 'show';
        return false;
    }
</script>

</body>
</html>

