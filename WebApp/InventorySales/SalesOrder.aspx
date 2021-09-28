<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesOrder.aspx.cs" Inherits="InventorySales_SalesOrder" EnableEventValidation="false" meta:resourcekey="PageResource1"  %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SalesOrder</title>

    <link href="../PlatForm/StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../PlatForm/Scripts/bid.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/Common.js" type="text/javascript"></script>

    

    <script language="javascript" type="text/javascript">

        function GetCustomerLocatiion() {
            if (document.getElementById('ddlCustomerLocation').value > 0) {
                LocationList = document.getElementById('hdnLocation').value = document.getElementById('ddlCustomerLocation').value;
            }
            
        }

        function GetCustomerLocationlist() {
           var selectOption = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_07") == null ? "Select" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_07");
            var CustomerID = document.getElementById('drpCustomerName').value;
            var ddllocation = document.getElementById('ddlCustomerLocation');
            var LocationList = document.getElementById('hdnCustomerLocation').value;

            var locationlist = "";

            if (CustomerID > 0) {
                locationlist = LocationList.split('^');

            }
            else {
                locationlist = "";

            }

            ddllocation.options.length = 0;
            var optn1 = document.createElement("option");
            ddllocation.options.add(optn1);
            optn1.text = selectOption;
            optn1.value = "0";


            if (CustomerID > 0) {
                for (i = 0; i < locationlist.length; i++) {
                    if ((locationlist[i] != "")) {
                        if (locationlist[i].split('~')[0] == Number(CustomerID)) {
                            res1 = locationlist[i].split('~');
                            if (res1 != "") {
                                var optnuserlist = document.createElement("option");
                                ddllocation.options.add(optnuserlist);
                                optnuserlist.text = res1[2];
                                optnuserlist.value = res1[1];
                            }
                        }
                        else { }

                    }


                }
            }
            else {

                ddllocation.options.length = 0;
                optn1 = document.createElement("option");
                ddllocation.options.add(optn1);
                optn1.text = selectOption;
                optn1.value = "0";
            }




        }

        function setCustomerLocation(val) {

          
            if (val > 0) {
                document.getElementById('ddlCustomerLocation').value = val;
            }
        }
    
    
        //Only numbers and only one dot value allowed for diecimal
        function updatechangesqty() {
            var qty = document.getElementById('txtqty').value.trim();
            var rate = document.getElementById('txtCostPrice').value.trim();
            document.getElementById('txtAmount').value = parseFloat(qty * rate).toFixed(2)
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
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }

        function checkIsEmpty() {
            var userMsg;
            if (document.getElementById('drpCustomerName').value == '0') {
                document.getElementById('drpCustomerName').focus();
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_01") == null ? "Select The Customer" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (document.getElementById('ddlCustomerLocation').value == '0') {
                document.getElementById('ddlCustomerLocation').focus();
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_02") == null ? "Select the Customer Ship to Location" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if (document.getElementById('txtDeliveryDate').value == "") {
                document.getElementById('txtDeliveryDate').focus();
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_03") == null ? "Select The Delivery Date" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if (document.getElementById('txtProductname').value == "") {
                document.getElementById('txtProductname').focus();
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_04") == null ? "Give the Product Name" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_04");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if (document.getElementById('txtqty').value == "") {
                document.getElementById('txtqty').focus();
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_05") == null ? "Type the Quantity" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_05");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
           
            BindProductList();
        }
        function Deleterows() {
            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnsalesorder').value.split("^");
            if (RowEdit != "") {
                var product = document.getElementById('txtProductname').value;
                var cnameid = document.getElementById('drpCustomerName').value;
                var units = document.getElementById('txtUnits').value;
                var qty = document.getElementById('txtqty').value;
                var price = document.getElementById('txtCostPrice').value;
                var Amount = document.getElementById('txtAmount').value;
                var parentproductid = document.getElementById('hdnParentProductID').value;
                var productid = document.getElementById('hdnProductID').value;
                var salesorderid = document.getElementById('hdnsalesorderid').value;
                var salesdetid = document.getElementById('hdnsalesdetid').value;
                document.getElementById('hdnsalesorder').value = product + "~" + units + "~" + qty + "~" + price + "~" +
                                                                   Amount + "~" + // Deliverydate + "~" + Comments + "~" + terms + "~" + cname + "~" + cnameid +  "^";
                                                                   parentproductid + "~" + productid + "~" + salesorderid + "~" + salesdetid + "^";
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById('hdnsalesorder').value += x[i] + "^";
                        }
                    }
                }
                Tblist();
            }

        }
        function OnSelectProducts(source, eventArgs) {
//            document.getElementById('add').value = 'Add'; 
            document.getElementById('txtUnits').value = "";
            document.getElementById('txtqty').value = "";
            document.getElementById('txtCostPrice').value = "";
            document.getElementById('txtAmount').value = ""; 
            if (document.getElementById('hdnsalesdetid').value == "0") {
                //document.getElementById('btnSave').style.display = "block";
                $('#btnSave').removeClass().addClass('show');
            }
            document.getElementById('hdnParentProductID').value = "";
            document.getElementById('hdnProductID').value = "";
            document.getElementById('hdnsalesorderid').value = 0;
            document.getElementById('hdnsalesdetid').value = 0;

           
            var lis = eventArgs.get_value().split('~');
            if (lis != "") {
                for (i = 0; i < lis.length; i++) {
                    if (lis[i] != "") {
                        document.getElementById('txtProductname').value = lis[1];
                        document.getElementById('txtUnits').value = lis[2];
                        document.getElementById('txtCostPrice').value = lis[3];
                        document.getElementById('hdnParentProductID').value = lis[4];
                        document.getElementById('hdnProductID').value = lis[0];
                    }
                }
            }
        }
        function clear() {
            document.getElementById('add').value = 'Add';
            document.getElementById('txtProductname').value = "";
            document.getElementById('txtUnits').value = "";
            document.getElementById('txtqty').value = "";
            document.getElementById('txtCostPrice').value = "";
            document.getElementById('txtAmount').value = "";
            //            document.getElementById('txtDeliveryDate').value = "";
            //            document.getElementById('txtComments').value = "";
            //            document.getElementById('txtTermscond').value = "";
            if (document.getElementById('hdnsalesdetid').value == "0") {
                //document.getElementById('btnSave').style.display = "block";
                $('#btnSave').removeClass().addClass('show');
            }
            document.getElementById('hdnParentProductID').value = "";
            document.getElementById('hdnProductID').value = "";
            document.getElementById('hdnsalesorderid').value = 0;
            document.getElementById('hdnsalesdetid').value = 0;

            document.getElementById('txtProductname').focus();
        }
        function valid() {
            var productid = document.getElementById('hdnProductID').value;
            var HidValue = document.getElementById('hdnsalesorder').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnsalesorder').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProductList = list[count].split('~');
                    if (ProductList != "") {
                        if (productid != "") {
                            if (ProductList[6] == productid) {
                                var userMsg = SListForAppMsg.Get("InventorySales_SalesOrder_aspx_06") == null ? "Products already Mapped Check The List" : SListForAppMsg.Get("InventorySales_SalesOrder_aspx_06");
                                ValidationWindow(userMsg, errorMsg);
                                document.getElementById('txtProductname').focus();
                                clear();
                                return false;

                            }
                        }
                    }

                }
            }
            
        }
        function BindProductList() {
           
                if (document.getElementById('add').value == 'Update') {
                    Deleterows();
                }
                else {

                    var cname = document.getElementById('drpCustomerName');
                    var product = document.getElementById('txtProductname').value;
                    var cnameid = document.getElementById('drpCustomerName').value;
                    var units = document.getElementById('txtUnits').value;
                    var qty = document.getElementById('txtqty').value;
                    var price = document.getElementById('txtCostPrice').value;
                    var Amount = document.getElementById('txtAmount').value;
                    var Deliverydate = document.getElementById('txtDeliveryDate').value;
                    var Comments = document.getElementById('txtComments').value;
                    var terms = document.getElementById('txtTermscond').value;
                    var parentproductid = document.getElementById('hdnParentProductID').value;
                    var productid = document.getElementById('hdnProductID').value;
                    var salesorderid = document.getElementById('hdnsalesorderid').value;
                    var salesdetid = document.getElementById('hdnsalesdetid').value;

                    document.getElementById('hdnsalesorder').value += product + "~" + units + "~" + qty + "~" + price + "~" +
                                                                  Amount + "~" + // Deliverydate + "~" + Comments + "~" + terms + "~" + cname + "~" + cnameid +  "^";
                                                                  parentproductid + "~" + productid + "~" + salesorderid + "~" + salesdetid + "^";

                    Tblist();
                }


                clear();
            


        }
        function btnDelete(sEditedData) {
            var i;
            var IsDelete = confirm("Confirm to delete!!");
            if (IsDelete == true) {
                var x = document.getElementById('hdnsalesorder').value.split("^");
                document.getElementById('hdnsalesorder').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnsalesorder').value += x[i] + "^";
                        }
                    }
                }
                Tblist();
            }
            else {
                return false;
            }
        }
        function btnEdit_OnClick(sEditedData) {
            document.getElementById('hdnRowEdit').value = sEditedData;
            var lis = sEditedData.split('~');
            document.getElementById('add').value = 'Update';

            document.getElementById('txtProductname').value = lis[0];
            document.getElementById('txtUnits').value = lis[1];
            document.getElementById('txtqty').value = lis[2];
            document.getElementById('txtCostPrice').value = lis[3];
            document.getElementById('txtAmount').value = lis[4];
            document.getElementById('hdnParentProductID').value = lis[5];
            document.getElementById('hdnProductID').value = lis[6];
            document.getElementById('hdnsalesorderid').value = lis[7];
            document.getElementById('hdnsalesdetid').value = lis[8];


        }
        function Tblist() {
            while (count = document.getElementById('tblsalesorder').rows.length) {
                for (var j = 0; j < document.getElementById('tblsalesorder').rows.length; j++) {
                    document.getElementById('tblsalesorder').deleteRow(j);
                }
            }
            var pList = document.getElementById('hdnsalesorder').value.split("^");
            var Headrow = document.getElementById('tblsalesorder').insertRow(0);
            Headrow.removeClass().addClass('bold');
            Headrow.className = "dataheader1";
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);

            cell1.innerHTML = "Product Name";
            cell2.innerHTML = "Unit";
            cell3.innerHTML = "Qty";
            cell4.innerHTML = "Rate";
            cell5.innerHTML = "Amount";
            cell6.innerHTML = "Select";

            document.getElementById('txtgrdtotal').value = "0.00";

            for (s = 0; s < pList.length; s++) {
                if (pList[s] != "") {
                    y = pList[s].split('~');

                    var row = document.getElementById('tblsalesorder').insertRow(1);
                    row.addClass('h-9');

                    cell1 = row.insertCell(0);
                    cell2 = row.insertCell(1);
                    cell3 = row.insertCell(2);
                    cell4 = row.insertCell(3);
                    cell5 = row.insertCell(4);
                    cell6 = row.insertCell(5);

                    cell1.innerHTML = y[0];
                    cell2.innerHTML = y[1];
                    cell3.innerHTML = y[2];
                    cell4.innerHTML = y[3];
                    cell5.innerHTML = y[4];
                    cell6.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' class='pointer txtdecoration1 borderstyle1 cust1blue cust1backcolor2'  /> &nbsp;&nbsp;" +
                                      "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='pointer txtdecoration1 borderstyle1 cust1blue cust1backcolor2'  />"
                    document.getElementById('txtgrdtotal').value =parseFloat( parseFloat(document.getElementById('txtgrdtotal').value) + parseFloat(y[4])).toFixed(2);

                }
            }


        }
          
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                 <table  class="dataheader2 defaultfontcolor w-100p custcellpadding2 border1 custcellspacing1">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="Label1" Text="Customer Name" 
                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpCustomerName" runat="server" CssClass="ddlsmall w-150" 
                                                onchange="GetCustomerLocationlist();"
                                                meta:resourcekey="drpCustomerNameResource1">
                                            </asp:DropDownList>
                                             <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="Label5" Text="Deliver Location" meta:resourcekey="Label5Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCustomerLocation" onchange="GetCustomerLocatiion();" 
                                                runat="server" CssClass="ddlsmall w-150" 
                                                meta:resourcekey="ddlCustomerLocationResource1">
                                            </asp:DropDownList>
                                             <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                       
                                    </tr>
                                  <tr>
                                         <td>
                                            <asp:Label ID="lblFrom" Text="Delivery Date" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtDeliveryDate" runat="server" TabIndex="3" 
                                                CssClass="datePicker" meta:resourcekey="txtDeliveryDateResource1"></asp:TextBox>
                                            
                                                 <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="Label2" Text="Terms & Conditions" meta:resourcekey="Label2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtTermscond" runat="server" TextMode="MultiLine" 
                                                meta:resourcekey="txtTermscondResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        
                                        <td>
                                            <asp:Label runat="server" ID="Label3" Text="Comments" meta:resourcekey="Label3Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtComments" runat="server" TextMode="MultiLine" 
                                                meta:resourcekey="txtCommentsResource1" />
                                        </td>
                                        <td>
                                       </td>
                                       <td></td>
                                    </tr>
                                </table>
                                <table class="dataheader2 defaultfontcolor w-100p custcellspacing1 custcellpadding2">
                                    <tr>
                                        <td>
                                            <table class="w-100p custcellpadding2 custcellspacing2">
                                                <tr>
                                                    <td class="w-208p" >
                                                        <asp:Label ID="pname" runat="server" Text="ProductName" meta:resourcekey="pnameResource1"/>
                                                    </td>
                                                    <td class="w-106p" >
                                                        <asp:Label ID="lblunits" runat="server" Text="Units" meta:resourcekey="lblunitsResource1"/>
                                                    </td>
                                                    <td class="w-103p" >
                                                        <asp:Label ID="lblQty" runat="server" Text="Qty" meta:resourcekey="lblQtyResource1"/>
                                                    </td>
                                                    <td class="w-96p" >
                                                        <asp:Label ID="Label6" runat="server" Text="Cost Price" meta:resourcekey="Label6Resource1"/>
                                                    </td>
                                                    <td class="w-106p" >
                                                        <asp:Label ID="Label4" runat="server" Text="Amount" meta:resourcekey="Label4Resource1"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="w-208p" >
                                                        <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtProductname" runat="server" onblur="return valid(); " 
                                                            CssClass="Txtboxsmall" meta:resourcekey="txtProductnameResource1" />
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProductname"
                                                            BehaviorID="AutoCompleteExLstGrp11" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                                                            OnClientItemSelected="OnSelectProducts" FirstRowSelected="true" ServiceMethod="GetProductsList"
                                                            ServicePath="~/InventorySales/WebService/InventorySalesService.asmx">
                                                        </ajc:AutoCompleteExtender>
                                                        <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                        <asp:HiddenField ID="hdnProductID" runat="server" />
                                                        <asp:HiddenField ID="hdnParentProductID" runat="server" />
                                                    </td>
                                                    <td class="w-106p">
                                                        <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtUnits" runat="server"  ReadOnly="True" 
                                                            CssClass="Txtboxverysmall w-60" meta:resourcekey="txtUnitsResource1"/>
                                                    </td>
                                                    <td class="w-103p">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtqty" runat="server" onKeyDown="return  isNumericss(event,this.id)"
                                                            onblur=" updatechangesqty(); "  CssClass="Txtboxverysmall w-60" 
                                                            meta:resourcekey="txtqtyResource1" />
                                                    </td>
                                                    <td class="w-96p">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtCostPrice" CssClass="Txtboxverysmall w-60" runat="server" 
                                                            onKeyDown="return  isNumericss(event,this.id)"
                                                            ReadOnly="True" meta:resourcekey="txtCostPriceResource1" />
                                                    </td>
                                                    <td class="w-106p">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtAmount" runat="server" CssClass="Txtboxverysmall w-60" 
                                                            onKeyDown="return  isNumericss(event,this.id)"
                                                            ReadOnly="True" meta:resourcekey="txtAmountResource1" />
                                                    </td>
                                                    <td>
                                                        <input id="add" class="btn w-60" name="add" onclick="javascript:return checkIsEmpty();" 
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            type="button" value="Add" />
                                                    </td>
                                                </tr>
                                                <%--  <tr>
                                                    <td>
                                                        <table id="tblsalesorder" cellpadding="1" width="100%">
                                                        </table>
                                                    </td>
                                                </tr>--%>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblsalesorder" class="w-100p custcellpadding2 border2 dataheaderInvCtrl">
                                </table>
                                <table class="w-100p">
                                    <tr class="a-right">
                                        <td class="a-right" colspan="3">
                        <asp:Label ID="lblGrandTotal" runat="server" Text="GrandTotal" meta:resourcekey="lblGrandTotalResource1" />
                             &nbsp; &nbsp; &nbsp; &nbsp;
                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtgrdtotal" runat="server" Text="0.00" ReadOnly="True" CssClass="Txtboxsmall"
                                meta:resourcekey="txtgrdtotalResource1" />
                                        </td>
                                         
                                    </tr>
                                    <tr class="a-center" >
                                        <td colspan="3">
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn hide h-26 w-59"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save"
                                                OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"/>
                                            &nbsp;
                                            <asp:Button ID="btnApprove" Text="Approve" Visible="False" runat="server"
                                                CssClass="btn w-60" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource1"/>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:HiddenField ID="hdnsalesorder" runat="server" />
                        <asp:HiddenField ID="hdnRowEdit" runat="server" />
                        <asp:HiddenField ID="hdnsalesorderid" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnsalesdetid" runat="server" Value="0" />
                         <asp:HiddenField ID="hdnCustomerLocation" runat="server" />
                           <input type="hidden" id="hdnLocation" runat="server" Value="0" />
                         <
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
              
    </form>
</body>
</html>
