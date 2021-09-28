<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrder.aspx.cs" Inherits="PurchaseOrder_PurchaseOrder" EnableEventValidation="true"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Purchase Order</title>
</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" defaultbutton="btnGeneratePO">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

    <script language="javascript" type="text/javascript">
        var lstPurcharseOrder = [];
        var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error') == null ? "Alert" : SListForAppMsg.Get('PurchaseOrder_Error');
        var informMsg = SListForAppMsg.Get('PurchaseOrder_Information') == null ? "Information" : SListForAppMsg.Get('PurchaseOrder_Information');
        var okMsg = SListForAppMsg.Get('PurchaseOrder_Ok') == null ? "Ok" : SListForAppMsg.Get('PurchaseOrder_Ok')
        var cancelMsg = SListForAppMsg.Get('PurchaseOrder_Cancel') == null ? "Cancel" : SListForAppMsg.Get('PurchaseOrder_Cancel');
        function pSetfocus() {

            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return;
        }
        function IsSelected(source, eventArgs) {
            // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var categoryID;
            var AddStatus = 0;
            var quantity = parseFloat(0).toFixed(2);
                    var PurchaseTax = "0.00";
            //var val = eventArgs.get_value().split('~');
            var val = JSON.parse(eventArgs.get_value());
            //            var desc = val[4];
            //            var unit = val[13];

            var desc = val.StockInHand;
            var unit = val.Units;
            var lsunit = "";
            var amount = parseFloat(0).toFixed(2);
            var rate = parseFloat(0).toFixed(2);
            // var CategoryName = val[2];
            var CategoryName = val.CatName;
            var Product = '';


            var result = eventArgs.get_text().match(/[^[\]]+(?=])/g)
            if (result != null) {
                Product = eventArgs.get_text().replace(/\s*\[.*?\]\s*/g, '');


            } else {
                Product = eventArgs.get_text();
            }
            var ProductName = Product; //.split('--');
            var InHandQty = 0;
            var ID = 0;
            var BatchNo = val.IsStockReceived;  //val[3];
            //var InHandQty = val[4];
            //categoryID = val[1];
            categoryID = val.CategoryID;

            // var HidValue = document.getElementById('iconHid').value;
			 var Tax = 0;
        var Discount = 0;
        var CompQty = 0;
            // var list = HidValue.split('^');
            var ObjProduct = new Object();
            ObjProduct.ProductID = val.ProductID;
            ObjProduct.ProductName = ProductName;
            ObjProduct.CategoryID = val.CategoryID;
            ObjProduct.Unit = val.Units;
            ObjProduct.CategoryName = val.CatName;            
            ObjProduct.Quantity = 0;
            ObjProduct.Description = val.StockInHand;
            ObjProduct.ID = 0;
            ObjProduct.BatchNo = "";
            ObjProduct.IsStockReceived = val.IsStockReceived;
            ObjProduct.Amount=0;
            ObjProduct.Tax = val.TaxPercent;
            ObjProduct.ComplimentQTY=0;
            ObjProduct.PurchaseTax=0;
           
            // if (document.getElementById('iconHid').value != "") {
            if (lstPurcharseOrder.length > 0) {
                /* for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                if (InvesList[0] == val[0]) {
                AddStatus = 1;
                }
                }
                }*/

                $.each(lstPurcharseOrder, function(obj, value) {
                    if (val.ProductID == value.ProductID) {
                        AddStatus = 1;
                        return;
                    }
                });
            }
            else {

                // if (val[5] == 'Y') {
                if (val.IsPurchaseOrder == 'Y') {

                    var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                    if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                    }
                    else {
                        return;
                    }
                }


                //document.getElementById('lblHeader').style.display = "block";
                $('#lblHeader').removeClass().addClass('show bold');
                //document.getElementById('tblOrederedInves').style.display = "table";
                $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p');
                var rowCount = $('#tblOrederedInves tr').length;
                var row = document.getElementById('tblOrederedInves').insertRow(rowCount);
                // row.id = val[0];
                row.id = ObjProduct.ProductID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + val[0] + ");' src='../PlatForm/Images/Delete.jpg' />";
                //cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + val[0] + ");' class='ui-icon ui-icon-trash pointer' />";
                cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + JSON.stringify(ObjProduct) + ");' class='ui-icon ui-icon-trash pointer' />";
                cell1.width = "5%";
                cell2.innerHTML = ProductName + " (" + CategoryName + ")";
                cell2.align = 'left';
                cell3.innerHTML = categoryID;
                cell3.style.display = "none";
                cell4.style.display = "none";
                if (ObjProduct.IsStockReceived == 'Y') {
                    //  cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + val[0] + ") type='button' class='btn pointer' />"
                    cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + ObjProduct.ProductID + ") type='button' class='btn pointer' />"
                }
                else {
                    //cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                }
                lstPurcharseOrder.push(ObjProduct);
                $('#iconHid').val(JSON.stringify(lstPurcharseOrder));
                //document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {

                // if (val[5] == 'Y') {
                if (val.IsPurchaseOrder == 'Y') {

                    var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                    if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                    }
                    else {
                        return;
                    }
                }
                //document.getElementById('lblHeader').style.display = 'block';
                $('#lblHeader').removeClass().addClass('show bold');
                var rowCount1 = $('#tblOrederedInves tr').length;
                var row = document.getElementById('tblOrederedInves').insertRow(rowCount1);
                // row.id = val[0];
                row.id = ObjProduct.ProductID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                //cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + val[0] + ");' class='ui-icon ui-icon-trash pointer' />";
                cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + JSON.stringify(ObjProduct) + ");' class='ui-icon ui-icon-trash pointer' />";
                cell1.width = "5%";
                cell2.innerHTML = ProductName + " (" + CategoryName + ")";
                cell2.align = 'left';
                cell3.innerHTML = categoryID;
                cell3.style.display = "none";
                cell4.style.display = "none";
                if (ObjProduct.IsStockReceived == 'Y') {
                    //cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + val[0] + ") type='button' class='btn pointer' />"
                    cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + ObjProduct.ProductID + ") type='button' class='btn pointer' />"
                }
                else {
                    // cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                }
                lstPurcharseOrder.push(ObjProduct);
                $('#iconHid').val(JSON.stringify(lstPurcharseOrder));
                //document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "^";
            }
            else if (AddStatus == 1) {

                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08") == null ? "Product already added" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

                ValidationWindow(userMsg, errorMsg);
                return false;

                document.getElementById('txtProduct').value = '';
                document.getElementById('txtProduct').focus();
            }


            //if (list.length == 0) {
            if (lstPurcharseOrder.length == 0) {
                //document.getElementById('lblHeader').style.display = "hide";
                $('#lblHeader').removeClass().addClass('hide');
                //document.getElementById('tblOrederedInves').style.display = "hide";
                $('#tblOrederedInves').removeClass().addClass('hide')
            }
            else {
                //document.getElementById('lblHeader').style.display = "show";
                $('#lblHeader').removeClass().addClass('show bold');
                //document.getElementById('tblOrederedInves').style.display = "table";
                $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p')

            }
            //To Order More No of items in Purchase Order
            pSetfocus();

        }
        function ShowAlertMsg(key) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_01") == null ? "Product Added sucessfully" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_01");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_01');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;
//            }
//             else {
            ValidationWindow(userMsg, errorMsg);
                return false;
                //  }
          //end
        }
        var userMsg;
        function checkDetails() {

            var getValue = '';
            document.getElementById('hdnvalue').value = '';

            $("#LocationPanel input.Txtboxverysmall").each(function() {
                getValue += $(this).val() + '|';

            });

            document.getElementById('hdnvalue').value = getValue;
            if (document.getElementById('txtPurchaseOrderDate').value == '') {

                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_02") == null ? "Select purchase order date" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtPurchaseOrderDate').focus();
                return false;
            }

            if (document.getElementById('ddlSupplierList').value == 0) {

                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_03") == null ? "Select supplier" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlSupplierList').focus();
                return false;
            }

            //document.getElementById('btnGeneratePO').style.display = "none";
            var rowCount = $('#tblOrederedInves tr').length;
            if (rowCount <= 1) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_16") == null ? "There is no product selected in the list" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_16");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            return true;
        }

        function checkLSU() {


            var obj = document.getElementById('hdnInHandQty').value;

            //            if (obj > 0) {
            //                alert('If U Change LSU');
            //                return false;

            //            }

        }

        function SelectGeneric(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnGenericID').value = PColval[0];

            //            document.getElementById('txtGenericName').value = PColval[1];

        }

        function SelectLocation(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnLocationID').value = PColval[0];
            document.getElementById('hdnLocationName').value = PColval[1];
            //            document.getElementById('txtLocationName').value = PColval[1];

        }
        function SelectOrganization(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnOrgId').value = PColval[0];

        }

        function Checkorgtext() {
            if ($("#<%=txtOrgName.ClientID%>").val().length > 12) {
                $("#<%=txtOrgName.ClientID%>").val("")
                $("#<%=hdnOrgId.ClientID%>").val("0");
            }
            $("#<%=txtLocationName.ClientID%>").val("")
            $("#<%=hdnLocationID.ClientID%>").val("0");
            var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
            var ContextInfodetails = 'Org' + '~' + OrgId
            $find('AutoOrgName').set_contextKey(ContextInfodetails);

        }
        function CheckorgLocationtext() {
            var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
            var ContextInfodetails = 'Location' + '~' + OrgId
            if (OrgId != "" && OrgId != "0")
                $find('AutoCompleteExtenderLocation').set_contextKey(ContextInfodetails);
            else
                $find('AutoCompleteExtenderLocation').set_contextKey("");
        }

        function checkLocation() {
            if (document.getElementById('hdnOrgId').value == "0" || document.getElementById('txtOrgName').value.trim() == "") {
                
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_04") == null ? "Provide the Organization" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_04");
//                var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_04');
//                var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);

//                }
//                else {
//                    ValidationWindow('Provide the Organization','Error');
                    //                }
//end
                document.getElementById('txtOrgName').focus();
                return false;
            }
            if (document.getElementById('txtLocationName').value.trim() == "") {
                
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_05") == null ? "Provide the LocationName" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_05");
//                var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_05');
//                var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);

//                }
//                else {
//                    ValidationWindow('Provide the LocationName','Error');
                //                }
                ValidationWindow(userMsg, errorMsg);
                //end
                document.getElementById('txtLocationName').focus();
                return false;
            }

            if (document.getElementById('txtReOrderLevel').value == "") {
                
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_06") == null ? "Provide ReOrder Level quantity" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_06");
//                var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_06');
//                var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);

//                }
//                else {
//                    ValidationWindow('Provide ReOrder Level quantity','Error');
                //                }
                ValidationWindow(userMsg, errorMsg);
                //end
                document.getElementById('txtReOrderLevel').focus();
                return false;
            }

            if (document.getElementById('btnAddLocation').value != 'Update') {
                var x = document.getElementById('hdnLocationList').value.split("^");
                var pLocID = document.getElementById('hdnLocationID').value;
                var pLocationName = document.getElementById('txtLocationName').value;
                var y; var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[0] == pLocID) {
                            
                            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_09") == null ? "This Location already exist" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_09");
//                            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_09');
//                            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                            if (userMsg != null && errorMsg != null) {
//                                ValidationWindow(userMsg, errorMsg);

//                            }
//                            else {
//                                ValidationWindow('This Location already exist','Error');
                            //                            }
                            ValidationWindow(userMsg, errorMsg);
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


        function BindLocationList() {
            if (document.getElementById('btnAddLocation').value == 'Update') {
                DeleterowsLoc();
            }
            else {

                var POrgId = document.getElementById('hdnOrgId').value;
                var pOrgName = document.getElementById('txtOrgName').value;
                var pLocationID = document.getElementById('hdnLocationID').value;
                var pLocationName = document.getElementById('txtLocationName').value;
                var pReOrderLevelQuantity = document.getElementById('txtReOrderLevel').value;
                var pMaxQuantity = document.getElementById('txtMaxQuantity').value;
                document.getElementById('hdnLocationList').value += pLocationID + "~" + pLocationName + "~" + pReOrderLevelQuantity + "~" + POrgId + "~" + pOrgName + "~" + pMaxQuantity + "^";
                tableLocationList();

            }

            document.getElementById('btnAddLocation').value = 'Add';
            document.getElementById('txtLocationName').value = '';
            document.getElementById('txtReOrderLevel').value = '0';
            document.getElementById('txtMaxQuantity').value = '0';
            document.getElementById('txtLocationName').focus();

        }

        function tableLocationList() {


            while (count = document.getElementById('tblLocationlist').rows.length) {

                for (var j = 0; j < document.getElementById('tblLocationlist').rows.length; j++) {
                    document.getElementById('tblLocationlist').deleteRow(j);
                }
            }

            var Headrow = document.getElementById('tblLocationlist').insertRow(0);
            Headrow.id = "HeadID";
            //    Headrow.style.backgroundColor = "#2c88b1";
            Headrow.style.fontWeight = "bold";
            //    Headrow.style.color = "#FFFFFF";
            Headrow.className = "gridHeader"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);

            var SNo = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_01');
            if (SNo == null) {
                SNo = "S.No.";
            }

             var OrganizationName = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_02');
             if (OrganizationName == null) {
                 OrganizationName = "Organization Name";
             }

             var LocationName = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_03');
             if (LocationName == null) {
                 LocationName = "Location Name";
             }
             var ReOrderLevelQuantity = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_04');
             if (ReOrderLevelQuantity == null) {
                 ReOrderLevelQuantity = "Re-Order Level Quantity";
             }

             var Action = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_05');
             if (Action == null) {
                 Action = "Action";
             }
             var MaxQTY = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_05') == null ? "Maximum Quantity" : SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_05');

             cell1.innerHTML = SNo;
             cell2.innerHTML = OrganizationName;
             cell3.innerHTML = LocationName;
             cell4.innerHTML = ReOrderLevelQuantity;
             cell5.innerHTML = MaxQTY;
             cell6.innerHTML = Action;
            var x = document.getElementById('hdnLocationList').value.split("^");
            var pCount = x.length;
            pCount = pCount - 1;

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');

                    var row = document.getElementById('tblLocationlist').insertRow(1);
                    row.style.height = "13px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);


                    cell1.innerHTML = pCount;
                    cell2.innerHTML = y[4];
                    cell3.innerHTML = y[1];
                    cell4.innerHTML = y[2];
                    cell5.innerHTML = y[5];

                    var pAction = "";

                    pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnLocEdit_OnClick(name);'  value = 'Edit' type='button' class='ui-icon ui-icon-pencil b-none pointer pull-left'  /> " +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnLocDelete(name);' value = 'Delete' type='button' class='ui-icon ui-icon-trash b-none pointer pull-left marginL5'   />"
                cell6.innerHTML = pAction;

                }
                pCount = pCount - 1;
            }


        }

        function btnLocEdit_OnClick(sEditedData) {
            var y = sEditedData.split('~');

            document.getElementById('hdnOrgId').value = y[3];
            document.getElementById('txtOrgName').value = y[4];
            document.getElementById('hdnLocationID').value = y[0];
            document.getElementById('txtLocationName').value = y[1];
            document.getElementById('hdnLocationName').value = y[1];
            document.getElementById('txtReOrderLevel').value = y[2];
            document.getElementById('txtMaxQuantity').value = y[5];
            document.getElementById('hdnLocRowEdit').value = sEditedData;
            document.getElementById('btnAddLocation').value = 'Update';
        }

        function btnLocDelete(sEditedData) {
            var i;
            var x = document.getElementById('hdnLocationList').value.split("^");
            document.getElementById('hdnLocationList').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnLocationList').value += x[i] + "^";
                    }
                }
            }
            tableLocationList();
        }


        function DeleterowsLoc() {
            var RowEdit = document.getElementById('hdnLocRowEdit').value;
            var x = document.getElementById('hdnLocationList').value.split("^");
            if (RowEdit != "") {

                var POrgId = document.getElementById('hdnOrgId').value;
                var pOrgName = document.getElementById('txtOrgName').value;
                var pLocationId = document.getElementById('hdnLocationID').value;
                var pLocationName = document.getElementById('hdnLocationName').value;
                var pReOrderLevelQTY = document.getElementById('txtReOrderLevel').value;
                var MaxQuantity = document.getElementById('txtMaxQuantity').value;

                document.getElementById('hdnLocationList').value = pLocationId + "~" + pLocationName + "~" + pReOrderLevelQTY + "~" + POrgId + "~" + pOrgName + "~" + MaxQuantity + "^";

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById('hdnLocationList').value += x[i] + "^";
                        }
                    }
                }
                document.getElementById('hdnLocRowEdit').value = "";
                tableLocationList();

                document.getElementById('txtLocationName').readOnly = false;

            }
        }

        function ChangeTxtBoxWidthDynamic() {
            var completionList = $find("AutoOrgName").get_completionList().childNodes;
            for (var i = 0; i < completionList.length; i++) {
                var temp = completionList[i].innerHTML;
                if ($('#AutoOrgName_completionListElem').length > 0 && temp.length != '') {
                    if (temp.length > 0 && temp.length < 10) {
                        $('#AutoOrgName_completionListElem').css('width', '150px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 10 && temp.length < 25) {
                        $('#AutoOrgName_completionListElem').css('width', '200px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 25 && temp.length < 30) {
                        $('#AutoOrgName_completionListElem').css('width', '250px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '250px');
                        });
                    }
                    else if (temp.length > 30 && temp.length < 35) {
                        $('#AutoOrgName_completionListElem').css('width', '300px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '300px');
                        });
                    }
                    else if (temp.length > 35 && temp.length < 40) {
                        $('#AutoOrgName_completionListElem').css('width', '320px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '320px');
                        });
                    }
                    else if (temp.length > 40 && temp.length < 45) {
                        $('#AutoOrgName_completionListElem').css('width', '340px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '340px');
                        });
                    }
                    else if (temp.length > 45 && temp.length < 50) {
                        $('#AutoOrgName_completionListElem').css('width', '370px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '370px');
                        });
                    }
                    else if (temp.length > 50 && temp.length < 55) {
                        $('#AutoOrgName_completionListElem').css('width', '400px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '400px');
                        });
                    }
                    else if (temp.length > 55 && temp.length < 60) {
                        $('#AutoOrgName_completionListElem').css('width', '450px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '450px');
                        });
                    }
                    else if (temp.length > 60 && temp.length < 65) {
                        $('#AutoOrgName_completionListElem').css('width', '500px');
                        $("#AutoOrgName_completionListElem li").each(function(n) {
                            $(this).css('width', '500px');
                        });
                    }
                }
            }
        }
        function ChangeTxtBoxWidthDynamiclocat() {
            var completionList = $find("AutoCompleteExtenderLocation").get_completionList().childNodes;
            for (var i = 0; i < completionList.length; i++) {
                var temp = completionList[i].innerHTML;
                if ($('#AutoCompleteExtenderLocation_completionListElem').length > 0 && temp.length != '') {
                    if (temp.length > 0 && temp.length < 10) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '150px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 10 && temp.length < 25) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '200px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 25 && temp.length < 30) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '250px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '250px');
                        });
                    }
                    else if (temp.length > 30 && temp.length < 35) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '300px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '300px');
                        });
                    }
                    else if (temp.length > 35 && temp.length < 40) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '320px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '320px');
                        });
                    }
                    else if (temp.length > 40 && temp.length < 45) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '340px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '340px');
                        });
                    }
                    else if (temp.length > 45 && temp.length < 50) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '370px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '370px');
                        });
                    }
                    else if (temp.length > 50 && temp.length < 55) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '400px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '400px');
                        });
                    }
                    else if (temp.length > 55 && temp.length < 60) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '450px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '450px');
                        });
                    }
                    else if (temp.length > 60 && temp.length < 65) {
                        $('#AutoCompleteExtenderLocation_completionListElem').css('width', '500px');
                        $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                            $(this).css('width', '500px');
                        });
                    }
                }
            }
        }
         
    </script>

    <script type="text/javascript">

        function onClick1(id) {

            var categoryID;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            var quantity = parseFloat(0).toFixed(2);
            var val = obj.value.split('~');
            var desc = val[4];
            var unit = "";
            var lsunit = "";
            var PurchaseTax="0.00";
            var amount = parseFloat(0).toFixed(2);
            var rate = parseFloat(0).toFixed(2);
            var CategoryName = val[2]
            var ProductName = (obj.options[obj.selectedIndex].text).split('--');
            var InHandQty = 0;
            var ID = 0;
            var BatchNo = val[3];
            //var InHandQty = val[4];
            categoryID = val[1];

            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');

            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] == val[0]) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {

                if (val[5] == 'Y') {
                    
                    var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                    if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                    }
                    else {
                        return;
                    }
                    //                    var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_07');
                    //                    var OkMsg = SListForAppMsg.Get('PurchaseOrder_Ok');
                    //                    var Information = SListForAppMsg.Get('PurchaseOrder_Information');
                    //                    var Cancel = SListForAppMsg.Get('PurchaseOrder_Cancel');
                    //                    if (userMsg != null && OkMsg != null && Information != null && Cancel != null) {
                    //                        if (ConfirmWindow(userMsg, Information, OkMsg, Cancel)) {
                    //                        }
                    //                        else {
                    //                            return;
                    //                        }
                    //                    }
                    //                    else {
                    //                        if (ConfirmWindow("An order for this product has already been placed in PO. \n Do you still wish to continue?", "Information", "Ok", "Cancel")) {
                    //                        }
                    //                        else {
                    //                            return;
                    //                        }

                    //                    }   
                    //end                 

                }


                //document.getElementById('lblHeader').style.display = "show";
                $('#lblHeader').removeClass().addClass('show bold');
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = val[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' class='pointer;' OnClick='ImgOnclick(" + val[0] + ");' src='../PlatForm/Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ProductName[0] + " (" + CategoryName + ")";
                cell2.align = 'left';
                cell3.innerHTML = categoryID;
                cell3.style.display = "none";
                if (val[3] == 'Y') {
                    cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + val[0] + ") type='button' class='btn pointer'  />"
                }
                else {
                    //cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                }
                document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "~"+PurchaseTax+"^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {

                if (val[5] == 'Y') {
                    
                    var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                    if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                    }
                    else {
                        return;
                    }
                    //                    var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_07');
                    //                    var OkMsg = SListForAppMsg.Get('PurchaseOrder_Ok');
                    //                    var Information = SListForAppMsg.Get('PurchaseOrder_Information');
                    //                    var Cancel = SListForAppMsg.Get('PurchaseOrder_Cancel');
                    //                    if (userMsg != null && OkMsg != null && Information != null && Cancel != null) {
                    //                        if (ConfirmWindow(userMsg, Information, OkMsg, Cancel))
                    //                            return;
                    //                    }
                    //                    else {
                    //                        if (ConfirmWindow("An order for this product has already been placed in PO. \n Do you still wish to continue?", "Information", "Ok", "Cancel"))
                    //                            return;

                    //                    }  
                    //end             
                }
                //document.getElementById('lblHeader').style.display = 'block';
                $('#lblHeader').removeClass().addClass('show bold');
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = val[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' class='pointer;' OnClick='ImgOnclick(" + val[0] + ");' src='../PlatForm/Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ProductName[0] + " (" + CategoryName + ")";
                cell2.align = 'left';
                cell3.innerHTML = categoryID;
                cell3.style.display = "none";
                if (val[3] == 'Y') {
                    cell4.innerHTML = "<input name='but' value = 'SupplierList' OnClick=SupplierListPopup(" + val[0] + ") type='button' class='btn pointer'  />"
                }
                else {
                    // cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                }
                document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID +"~"+PurchaseTax+ "^";
            }
            else if (AddStatus == 1) {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08") == null ? "Product already added" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_08');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//                else {
            ValidationWindow(userMsg, errorMsg);
                    return false;
                //}
            }

            if (id == document.getElementById('listProducts')) {
                document.getElementById('listProducts').selectedIndex = -1;
            }
            if (list.length == 0) {
                //document.getElementById('lblHeader').style.display = "hide";
                $('#lblHeader').removeClass().addClass('hide');
                //document.getElementById('tblOrederedInves').style.display = "hide";
                $('#tblOrederedInves').removeClass().addClass('hide');
            }
            else {
                //document.getElementById('lblHeader').style.display = "show";
                $('#lblHeader').removeClass().addClass('show bold');
                //document.getElementById('tblOrederedInves').style.display = "table";
                $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p');

            }

            //alert(document.getElementById('iconHid').value);
            document.getElementById('listProducts').selectedIndex = -1;
        }
        function ImgOnclick(ImgID) {
            //$('#' + ImgID).removeClass().addClass('hide');
            if ($("#tblOrederedInves")[0].rows.length > 0) {
                $('[id$="tblOrederedInves"] tr').each(function(i, n) {
                    var currentRow = $(n);
                    //var gItemName = currentRow.find("'" + ImgID + "'").html();
                    var gItemName = this.id;
                    if (gItemName == ImgID.ProductID) {
                        currentRow.remove();
                    }
                });
            }

            if ($("#tblOrederedInves")[0].rows.length == 1) {
                // document.getElementById('lblHeader').style.display = "none";
                $('#lblHeader').hide();
            }
            var index = lstPurcharseOrder.indexOf(ImgID);
            lstPurcharseOrder.splice(index, 1);
            $('#iconHid').val(JSON.stringify(lstPurcharseOrder));

            //document.getElementById(ImgID).style.display = "hide";
            /* var HidValue = document.getElementById('iconHid').value;

            var list = HidValue.split('^');
            var newInvList = '';
            if (document.getElementById('iconHid').value != "") {
            for (var count = 0; count < list.length; count++) {
            var InvesList = list[count].split('~');
            if (InvesList[0] != '') {
            if (InvesList[0] != ImgID) {
            newInvList += list[count] + '^';
            }
            }
            }
                
            document.getElementById('iconHid').value = newInvList;
            if (newInvList.split('^').length == 1) {
            $('#lblHeader').hide();
            $('#tblOrederedInves').hide();
            }
            else {
            //document.getElementById('lblHeader').style.display = "show";
            $('#lblHeader').removeClass().addClass('show bold');
            //document.getElementById('tblOrederedInves').style.display = "table";
            $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p');

                }

            }*/
        }
        function LoadOrdItems() {

            if (document.getElementById('iconHid') != null) {
                lstPurcharseOrder = JSON.parse($('#iconHid').val());
                $.each(lstPurcharseOrder, function(obj, value) {
                $('#lblHeader').removeClass().addClass('show bold');
                $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p');      
                    var rowCount = $('#tblOrederedInves tr').length;
                    var row = document.getElementById('tblOrederedInves').insertRow(rowCount);
                    row.id = value.ProductID;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);

                    cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + JSON.stringify(value) + ");' class='ui-icon ui-icon-trash pointer' />";
                    cell1.width = "5%";
                    cell2.innerHTML = value.ProductName + " (" + value.CategoryName + ")";
                    cell2.align = 'left';
                    cell3.innerHTML = value.CategoryID;
                    cell3.style.display = "none";
                    cell4.style.display = "none";
                    if (value.IsStockReceived == 'Y') {
                        cell4.innerHTML = "<input name='but'  value = 'SupplierList' OnClick=SupplierListPopup(" + value.ProductID + ") type='button' class='btn pointer'  />"
                    }
                    else {
                        //cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                    }
                });

                // var HidValue = document.getElementById('iconHid').value;
               /* var list = HidValue.split('^');
                if (document.getElementById('iconHid').value != "") {
                    //document.getElementById('lblHeader').style.display = "show";
                    $('#lblHeader').removeClass().addClass('show bold');
                    //document.getElementById('tblOrederedInves').style.display = "table";
                    $('#tblOrederedInves').removeClass().addClass('displaytb gridView w-50p');
                    for (var count = 0; count < list.length - 1; count++) {
                        var InvesList = list[count].split('~');
                        var rowCount = $('#tblOrederedInves tr').length;
                        var row = document.getElementById('tblOrederedInves').insertRow(rowCount);
                        row.id = InvesList[0];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);

                        cell1.innerHTML = "<input  type='button' OnClick='ImgOnclick(" + InvesList[0] + ");' class='ui-icon ui-icon-trash pointer' />";
                        cell1.width = "5%";
                        cell2.innerHTML = InvesList[1] + " (" + InvesList[7] + ")";
                        cell2.align = 'left';
                        cell3.innerHTML = InvesList[2];
                        cell3.style.display = "none";
                        cell4.style.display = "none";
                        if (InvesList[6] == 'Y') {
                            cell4.innerHTML = "<input name='but'  value = 'SupplierList' OnClick=SupplierListPopup(" + InvesList[0] + ") type='button' class='btn pointer'  />"
                        }
                        else {
                            //cell4.innerHTML = "<input name='but' value = 'SupplierList' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:none;cursor:default;'  />"

                        }

                    }
                }*/

            }

        }

        function setItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClick1(ctl.id);
            }

        }

        function SupplierListPopup(obj) {

            var suplstpopup = "SupplierList.aspx?pID=" + obj + "&sID=" + document.getElementById('ddlSupplierList').value + "&IsPopup=Y";
            newwindow = window.open(suplstpopup, 'Supplier_List', 'height=450,width=790,scrollbars=yes');

            newwindow.focus();

            // window.open("SupplierList.aspx?pID=" + obj + "&sID=" + document.getElementById('ddlSupplierList').value + "", 'Supplier List', 'height=450,width=790,scrollbars=yes');
        }

        function checkSupplier() {
            var Select = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrder_aspx_06');
            if (Select == null) {
                Select = '--Select--';
            }
            if (document.getElementById('ddlSupplierList').options[document.getElementById('ddlSupplierList').selectedIndex].text == Select) {
                
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_03") == null ? "Select supplier" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_03");
//                var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_03');
//                var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;

//                }
//                else {

                ValidationWindow(userMsg, errorMsg);
                    return false;
                    // }
               //end
                document.getElementById('ddlSupplierList').focus();
                return false;
            }
            return true;
        }
        /*  
        function toggleSearchDisp() {
        if (document.getElementById('ddlSupplierList').options[document.getElementById('ddlSupplierList').selectedIndex].text == '--Select--') {
        document.getElementById('divSearch').style.display = 'none';
        alert('If block');

            }
        else {
        document.getElementById('divSearch').style.display = 'block';
        alert('elseblock');

            }
        }
        */          

    
    </script>

    <div class="contentdata">

        <script type="text/javascript">

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_initializeRequest(InitRequest);
        prm.add_endRequest(EndRequest);
        function InitRequest(sender, args) {
            //$get("progressDivWithGif").style.display = "show";
            $('#progressDivWithGif').removeClass().addClass('show')
        }
        function EndRequest(sender, args) {
            //$get("progressDivWithGif").style.display = "hide";
            $('#progressDivWithGif').removeClass().addClass('hide')
        }
    </script>
 <div class="contentdata">
        <%--
                                <div id="progressDivWithGif" style="display: none">
                                   <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" />
                                     Please wait....
                                </div>--%>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div>
                                    <table class="w-100p searchPanel">
                                        <tr class="panelContent lh30">
                                            <td class="a-left w-15p">
                                                <asp:Label ID="lbltagtxt1" runat="server" Text="Purchase Order Date :" meta:resourcekey="lbltagtxt1Resource1"></asp:Label>
                                            </td>
                                            <td class="w-40p">
                                            <%--Arun--%>
                                <asp:TextBox ID="txtPurchaseOrderDate" runat="server" CssClass="small datePickerPres" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                    meta:resourcekey="txtPurchaseOrderDateResource1"></asp:TextBox>
                                <%--<asp:ImageButton ID="ImgBntCalc" CssClass="ui-datepicker-trigger" runat="server" CausesValidation="False" ImageUrl="../PlatForm/images/Calendar_scheduleHS.png"
                                                    meta:resourcekey="ImgBntCalcResource1" />--%>
                                <%--end--%>
                                <%--<ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                    DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                    TargetControlID="txtPurchaseOrderDate" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                    CultureTimePlaceholder="" Enabled="True" />--%>
                                <%-- <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtPurchaseOrderDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                    EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                    TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5"
                                                    meta:resourcekey="MaskedEditValidator5Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                    TargetControlID="txtPurchaseOrderDate" Enabled="True" />--%>
                                &nbsp;<img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                            </td>
                                            <td class="a-left w-13p">
                                                <asp:Label ID="lbltxtSupplier" runat="server" Text="Supplier Name :" meta:resourcekey="lbltxtSupplierResource1"></asp:Label>
                                            </td>
                                            <td >
                                <asp:DropDownList ID="ddlSupplierList" runat="server" AutoPostBack="True" CssClass="small"
                                                    OnSelectedIndexChanged="ddlSupplierList_SelectedIndexChanged" meta:resourcekey="ddlSupplierListResource1">
                                                </asp:DropDownList>
                                                &nbsp;<img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                            </td>
                                        </tr>
                                        <tr class="panelContent ">
                                            <td colspan="4">
                                                <asp:UpdateProgress ID="progressDivWithGif" AssociatedUpdatePanelID="UpdatePanel1"
                                                    runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/PlatForm/Images/working.gif" meta:resourcekey="imgProgressbar1Resource1" />
                                                        <asp:Label ID="lblPleasewait" runat="server" Text="Please wait...." meta:resourcekey="lblPleasewaitResource1"></asp:Label>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblComments1" runat="server" Text="Comments :" meta:resourcekey="lblComments1Resource1"></asp:Label>
                                            </td>
                                            <td >
                                                <asp:TextBox ID="txtComments" CssClass="w-60p" runat="server" Columns="25"
                                                    Rows="2" TextMode="MultiLine" onKeyPress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                            </td>
                                            <td colspan="2">
                                                <div id="divSupplier" runat="server" class="hide a-center">
                                                    <table cellspacing="4">
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblAddress1" runat="server" Text="Address" meta:resourcekey="lblAddress1Resource1"></asp:Label>&nbsp;
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblVendorAddress" Text="--" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblCity1" runat="server" Text="City" meta:resourcekey="lblCity1Resource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblPhone1" runat="server" Text="Phone" meta:resourcekey="lblPhone1Resource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                :
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblEmai1" runat="server" Text="Email ID :" meta:resourcekey="lblEmai1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblEmailID" runat="server" meta:resourcekey="lblEmailIDResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div id="divProduct" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter">
                                            </div>
                                            <div class="a-center" id="processMessage">
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" 
                                                    meta:resourcekey="Rs_PleasewaitResource1" />
                                                <br />
                                                <br />
                                                <asp:Image ID="imgProgressbar" runat="server" 
                                                    ImageUrl="~/PlatForm/Images/working.gif" 
                                                    meta:resourcekey="imgProgressbarResource1" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divSearch" runat="server">
                                        <table class="w-100p searchPanel">
                                            <tr class="panelContent">
                                                <td>
                                                    <table class="w-100p">
                                                        <asp:HiddenField ID="iconHid" runat="server" />
                                                        <asp:HiddenField ID="hiddenProductList" runat="server" />
                                                        <tr>
                                                            <td class="a-left w-15p" id="tdSearch" runat="server">
                                                                <asp:Label ID="lblProduct1" runat="server" Text="Product" meta:resourcekey="lblProduct1Resource1"></asp:Label>
                                                                </td><td>&nbsp;<asp:TextBox ID="txtProduct" runat="server" CssClass="medium" maxlength="100" 
                                                                    meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                    completionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            CompletionListItemCssClass="wordWheel itemsMain"  EnableCaching="False" FirstRowSelected="True"
                                                                    MinimumPrefixLength="1" OnClientItemSelected="IsSelected" ServiceMethod="GetSearchProductListJSON"
                                                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProduct" DelimiterCharacters=""
                                                                    Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            
                                                                &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="javascript:if(!checkSupplier()) return false;"
                                                                    CssClass="btn hide" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                                
                                                                <asp:Button ID="btnAddNew" runat="server" Text="Add New Product" OnClientClick="javascript:if(!AddNewProduct()) return false;"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    meta:resourcekey="btnAddNewResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left" colspan="2">
                                                                <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trProductHeader" runat="server" class="hide">
                                                            <td id="Td1" colspan="2" class="h-25" runat="server">
                                                                <asp:Label ID="lblProducts2" runat="server" 
                                                                    Text="Products (Double click the Products to Add Quantity)" 
                                                                    meta:resourcekey="lblProducts2Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="v-top a-left hide" id="tdProduct" runat="server">
                                                                <asp:ListBox ID="listProducts" runat="server" CssClass="w-278 h-200" onkeypress="javascript:setItem(event,this);"
                                                                    ondblClick="javascript:onClick1(this.id);" meta:resourcekey="listProductsResource1">
                                                                </asp:ListBox>
                                                            </td>
                                                            <td class="v-top a-left" colspan="2">
                                                                <asp:Label ID="lblHeader" runat="server" Text="Selected Products" CssClass="hide bold"  
                                                                     meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                                <table id="tblOrederedInves"  class="w-50p gridView hide a-center">
                                                                    <thead>
                                                                        <tr>
                                                                            <th><%=Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_07%></th>
                                                                            <th><%=Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_08%></th>
                                                                            <th class="hide"></th>
                                                                            <th class="hide"></th>
                                                                        </tr>
                                                                    </thead>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:HiddenField ID="hdnCatID" runat="server" />
                                                    <asp:HiddenField ID="hdnCatType" runat="server" />
                                                    <asp:HiddenField ID="hdnInHandQty" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnGeneratePO" runat="server" CssClass="btn" OnClientClick="javascript:if(!checkDetails(this.id)) return false;"
                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Submit"
                                                        meta:resourcekey="btnGeneratePOResource1" />
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" CssClass="cancel-btn" OnClick="btnCancel_Click"
                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                        meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                     
                        <div id="divNewProduct" class="a-left hide" runat="server">
                            <table class="searchPanel w-100p" id="tblEditcolumn" runat="server">
                                <tr>
                                    <td colspan="4" class="a-center">
                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                        <input type="hidden" id="hdnStatus" runat="server" />
                                        <input id="Hidden1" runat="server" type="hidden" />
                                        <input id="hdnpName" runat="server" type="hidden" />
                                        <input id="hndCatName" runat="server" type="hidden" />
                                        <input id="hdnPrname" runat="server" type="hidden" />
                                        <input id="hdnattrip" runat="server" type="hidden" value="N" />
                                        <input id="hdnGenericID" runat="server" type="hidden" value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left w-15p">
                                        <asp:Label ID="lblGenericName" Text="Generic Name" runat="server" meta:resourcekey="lblGenericNameResource1"></asp:Label>
                                    </td>
                                    <td class="w-40p">
                                        <asp:DropDownList ID="ddlGeneric" runat="server" CssClass="ddl w-133 hide" 
                                            meta:resourcekey="ddlGenericResource1">
                                        </asp:DropDownList>
                                        <%--&nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />   OnClientItemSelected="SelectGeneric"--%>
                                        <asp:TextBox ID="txtGenericName" runat="server" MaxLength="50" onkeypress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)"
                                            CssClass="small w-133" meta:resourcekey="txtGenericNameResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderGeneric" runat="server" TargetControlID="txtGenericName"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            OnClientItemSelected="SelectGeneric" MinimumPrefixLength="1" CompletionInterval="1"
                                            FirstRowSelected="True" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                            DelimiterCharacters="" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td class="w-13p">&nbsp;</td>
                                    <td >&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_ProductName" Text="Product Name" runat="server" meta:resourcekey="Rs_ProductNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtProductName" runat="server" MaxLength="255" onkeypress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)"
                                           onBlur="return ConverttoUpperCase(this.id);" CssClass="small bg-searchimage" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                       <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct1" runat="server" CompletionInterval="1"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                            MinimumPrefixLength="2" ServiceMethod="GetSearchProductList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                            TargetControlID="txtProductName" DelimiterCharacters="" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="lblProductCode" Text="Product Code" runat="server" 
                                            meta:resourcekey="lblProductCodeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtProductCode" runat="server" CssClass="small w-133" onkeypress="return ValidateMultiLangChar(this);" 
                                            meta:resourcekey="txtProductCodeResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="lblMake" Text="Make / Brand" runat="server" 
                                            meta:resourcekey="lblMakeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMake" runat="server" CssClass="small w-133" onkeypress="return ValidateMultiLangChar(this);"
                                            meta:resourcekey="txtMakeResource1"></asp:TextBox>
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_ManufactureName" Text="Manufacturer Name" runat="server" 
                                            meta:resourcekey="Rs_ManufactureNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMfgName" runat="server" CssClass="small w-133" onkeypress="return ValidateMultiLangChar(this);" 
                                            meta:resourcekey="txtMfgNameResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_ManufactureCode" Text="Manufacturer Code" runat="server" 
                                            meta:resourcekey="Rs_ManufactureCodeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMfgCode" runat="server" CssClass="small w-133" onkeypress="return ValidateMultiLangChar(this);"
                                            meta:resourcekey="txtMfgCodeResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Rs_Description" Text="Description" runat="server" meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDescription" runat="server" meta:resourcekey="txtDescriptionResource1" onkeypress="return ValidateMultiLangChar(this);"
                                         TextMode="MultiLine" CssClass="medium w-133"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_Type" Text="Type" runat="server" meta:resourcekey="Rs_TypeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" CssClass="ddl w-133" meta:resourcekey="ddlTypeResource1">
                                        </asp:DropDownList>
                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_CategoryName" Text="Category Name" runat="server" meta:resourcekey="Rs_CategoryNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="small w-133" meta:resourcekey="ddlCategoryResource1" onblur="javascript:return SetTax();">
                                        </asp:DropDownList>
                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-middle">
                                        <asp:Label ID="lblUnit" runat="server" Text="Least Sellable Unit" 
                                            meta:resourcekey="lblUnitResource1"></asp:Label>
                                    </td>
                                    <td class="v-middle">
                                        <asp:DropDownList ID="bUnits" runat="server" CssClass="small w-133" 
                                            meta:resourcekey="bUnitsResource1" />
                                        <img class="center" alt="" src="../PlatForm/Images/starbutton.png" />
                                    </td>
                                    <td class="a-left v-top">
                                        <asp:Label ID="lblTax" runat="server" Text="GST Percentage" 
                                            meta:resourcekey="lblTaxResource1"></asp:Label>
                                    </td>
                                    <td valign="top">
                                        <asp:TextBox ID="TxtTax" runat="server" CssClass="small w-133" 
                                            onkeypress="return ValidateSpecialAndNumeric(this);" 
                                            OnBlur="return doValidatePercent(this);" meta:resourcekey="TxtTaxResource1">0</asp:TextBox>
                                        %
                                    </td>
                                </tr>
                                <tr id="trAsset1" class="hide">
                                    <td class="a-left">
                                        <asp:Label ID="lblProductModel" Text="Product Model" runat="server" 
                                            meta:resourcekey="lblProductModelResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtProductModel" runat="server" CssClass="small w-133" onkeypress="return ValidateMultiLangChar(this);"
                                            meta:resourcekey="txtProductModelResource1"></asp:TextBox>
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="lblLTofProduct" Text="Life Time of Product" runat="server" 
                                            meta:resourcekey="lblLTofProductResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLTofProduct" MaxLength="3" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            CssClass="smaller w-30" meta:resourcekey="txtLTofProductResource1"></asp:TextBox>
                                        &nbsp;<asp:Label ID="lblLFYears" Text="Years" runat="server" 
                                            meta:resourcekey="lblLFYearsResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="hide">
                                    <td class="v-top">
                                        <asp:Label ID="Rs_AssignAttributes" runat="server" Text="Attributes" 
                                            meta:resourcekey="Rs_AssignAttributesResource1"></asp:Label>
                                    </td>
                                    <td class="v-top">
                                        <table>
                                            <tr>
                                                <td id="tdAttributes1" runat="server">
                                                    <asp:CheckBox ID="chkIsScheduleHDrug" runat="server" meta:resourcekey="chkIsScheduleHDrugResource1" />
                                                    <asp:Label ID="Rs_IsScheduleHDrug" runat="server" meta:resourcekey="Rs_IsScheduleHDrugResource1"
                                                        Text="Is ScheduleH Drug"></asp:Label>
                                                </td>
                                                <td id="tdExpDate" runat="server">
                                                    <asp:CheckBox ID="chkExpDate" runat="server" meta:resourcekey="chkExpDateResource1"
                                                        Text="Has Expiry Date" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkBatchNo" runat="server" meta:resourcekey="chkBatchNoResource1"
                                                        Text="Has Batch No" />
                                                </td>
                                                <td id="tdAttributes2" runat="server">
                                                    <div id="divUsageCount" runat="server" class="hide">
                                                        <asp:Label ID="Rs_Count" runat="server" meta:resourcekey="Rs_CountResource1" Text="Count"></asp:Label>
                                                        <asp:TextBox ID="txtUsageCount" runat="server" meta:resourcekey="txtUsageCountResource1"
                                                            onblur="checkCount();" onkeypress="return ValidateSpecialAndNumeric(this);" Text="0" CssClass="w-40"></asp:TextBox>
                                                    </div>
                                                    <div id="divNorcotic" runat="server" class="hide">
                                                        <asp:CheckBox ID="ChkNorcotic" runat="server" Text="Is Narcotic" 
                                                            meta:resourcekey="ChkNorcoticResource1" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="tdAttributes3" runat="server">
                                                <td class="hide">
                                                    <asp:CheckBox ID="chkHasUsage" runat="server" meta:resourcekey="chkHasUsageResource1"
                                                        onclick="OnUsageCount(this)" Text="Has Usage" />
                                                </td>
                                                <td id="tdTransblock" runat="server" class="hide">
                                                    <asp:CheckBox ID="ChkTransblock" runat="server" Text="Is Banned Item " 
                                                        meta:resourcekey="ChkTransblockResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="hide" id="tddelete" runat="server">
                                                    <asp:CheckBox ID="chkisdelete" runat="server" Text="IsDelete" 
                                                        meta:resourcekey="chkisdeleteResource1" />
                                                </td>
                                            </tr>
                                            <tr id="tdAttributesforAsset" runat="server" class="hide">
                                                <td>
                                                    <asp:CheckBox ID="chkHasSerialNo" runat="server" Text="Has Serial No" 
                                                        meta:resourcekey="chkHasSerialNoResource1" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkIsLabAnalyzer" runat="server" Text="Is Lab Analyzer" 
                                                        meta:resourcekey="chkIsLabAnalyzerResource1" />
                                                </td>
                                            </tr>
                                            <tr class="hide">
                                                <td colspan="2">
                                                    <div class="hide">
                                                        <asp:LinkButton ID="lnkAddAttribute" runat="server" CssClass="att" Font-Underline="True"
                                                            meta:resourcekey="lnkAddAttributeResource1" Text="Add Attribute"></asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                  <tr>
                                        <td class="v-top">
                                            <asp:Label ID="Label2" runat="server" Text="Attributes" 
                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                        </td>
                                        <td colspan="5">
                                            <div id="divProductAttributes" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" 
                                            meta:resourcekey="lblLocationResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <div id="divLocation" class="show" runat="server">
                                            <table id="tblLocation" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <div id="divLocationItem" class="w-100p" runat="server">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblOrgName" runat="server" Text="Organization Name" 
                                                                            meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtOrgName" CssClass="w-250" onkeypress="return ValidateMultiLangChar(this);" onkeydown="javascript:return Checkorgtext();"
                                                                            runat="server" meta:resourcekey="txtOrgNameResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoOrgName" runat="server" TargetControlID="txtOrgName"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                            OnClientItemSelected="SelectOrganization" MinimumPrefixLength="1" CompletionInterval="1"
                                                                            FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                            DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamic">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblLocationName" runat="server" Text="Location Name" 
                                                                            meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtLocationName" runat="server" 
                                                                            onkeypress="return ValidateMultiLangChar(this);" onkeydown="javascript:return CheckorgLocationtext();" 
                                                                            meta:resourcekey="txtLocationNameResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLocation" runat="server" TargetControlID="txtLocationName"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                            OnClientItemSelected="SelectLocation" MinimumPrefixLength="1" CompletionInterval="1"
                                                                            FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                            DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamiclocat">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblMaxQuantity" runat="server" Text="Maximum Quantity" 
                                                                            meta:resourcekey="lblMaxQuantityResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtMaxQuantity" runat="server" CssClass="w-40" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                            Text="0" meta:resourcekey="txtMaxQuantityResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblReOrderLevel" runat="server" Text="Re-Order Level" 
                                                                            meta:resourcekey="lblReOrderLevelResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtReOrderLevel" runat="server" CssClass="w-40" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                            Text="0" meta:resourcekey="txtReOrderLevelResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                     <%--<input type="button" runat="server" class="btn" id="btnAddLocation" value="<%=Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_09%>" onclick="javascript:if(checkLocation()) return BindLocationList();"
                                                                            tabindex="50" />--%>
                                                                            <%--Arun--%>
                                                                      <%-- <button id="btnAddLocation" runat="server" type="button" class="btn" tabindex="50" onclick="javascript:if(checkLocation()) return BindLocationList();"><%=Resources.InventoryMaster_ClientSideDisplayText.InventoryMaster_Products_aspx_02%> </button>--%>
                                                                   <a id="btnAddLocation" runat="server" class="btn"  onclick="javascript:if(checkLocation()) return BindLocationList();"><%=Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_12%> </a>
                                                                   <%--end--%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Table CssClass="gridView w-100p" runat="server" ID="tblLocationlist" meta:resourcekey="tblLocationlistResource1">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <input type="hidden" id="hdnLocationID" value="0" runat="server" />
                                            <input type="hidden" id="hdnLocationName" runat="server" />
                                            <input id="hdnLocationList" runat="server" type="hidden" />
                                            <input id="hdnLocRowEdit" runat="server" type="hidden" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" class="a-center">
                                        <asp:Button ID="btnFinish" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                                            CssClass="btn w-70" OnClientClick="javascript:return NewProductcheckDetails();"
                                            onmouseout="this.className='btn'" OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                        &nbsp;
                                        <asp:Button ID="Button1" OnClientClick="javascript:return FnClear();" runat="server"
                                            Text="Cancel" CssClass="cancel-btn"
                                            OnClick="btnClear_Click" meta:resourcekey="btnCancelResource1" />
                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%--<uc6:ErrorDisplay ID="ErrorDisplay2" runat="server" />--%>
                                    </td>
                                </tr>
                            </table>
                            <%-- CONTROLAU--%>
                        </div>
                    </div>
                
        <input type="hidden" id="hdnvalues" runat="server" />
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnvalue" runat="server" />
    <%--<asp:HiddenField ID="hdnLocationID" runat="server" />--%>
    <asp:HiddenField ID="hdnLocationValue" runat="server" />
    <asp:HiddenField ID="hdnUpdateID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnUpdateValue" runat="server" Value="0" />
    <asp:HiddenField ID="HiddenUpdateValue" runat="server" Value="0" />
    <asp:HiddenField ID="hdnOrgId" runat="server" Value="0" />
     <asp:HiddenField ID="hdnProductList" runat="server" Value="" />
                                <asp:HiddenField ID="hdnCatTax" runat="server" Value="" />
                                 <asp:HiddenField ID="hdnGetTax" runat="server" Value="0" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">


    function AddNewProduct() {
        document.getElementById('divNewProduct').className = 'show';
        document.getElementById('divProduct').className = 'hide';
        document.getElementById('txtProductName').value = '';
        document.getElementById('ddlCategory').value = 0;
        document.getElementById('ddlType').value = 0;
        document.getElementById('bUnits').value = 0;
        document.getElementById('TxtTax').value = 0;
        document.getElementById('txtDescription').value = '';
        // document.getElementById('txtReOrderLevel').value = '';
        document.getElementById('chkIsScheduleHDrug').checked = false;
        document.getElementById('chkBatchNo').checked = false;
        document.getElementById('chkExpDate').checked = false;
        document.getElementById('ChkNorcotic').checked = false;
        document.getElementById('txtGenericName').focus()
        // document.getElementById('hdnLocationList').value = '';
        document.getElementById('txtGenericName').value = '';
        document.getElementById('txtProductCode').value = '';
        document.getElementById('txtMake').value = '';
        tableLocationList();
        return false;
    }

    function NewProductcheckDetails() {


        if (document.getElementById('txtProductName').value == '') {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_10") == null ? "Provide the product name" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_10");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_10');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
            ValidationWindow(userMsg, errorMsg);
                return false;
                //}
            //end
            document.getElementById('txtProductName').focus();
            return false;
        }


        if (document.getElementById('ddlType').value == "0") {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_11") == null ? "Select the type" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_11");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_11');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
            ValidationWindow(userMsg, errorMsg);
                return false;
                //}
            //
            document.getElementById('ddlType').focus();
            return false;
        }



        if (document.getElementById('ddlCategory').value == "0") {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_12") == null ? "Select the category name" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_12");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_12');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
            ValidationWindow(userMsg, errorMsg);
                return false;
            //}
            document.getElementById('ddlCategory').focus();
            return false;
        }
        //        if (document.getElementById('txtReOrderLevel').value == '') {
        //           userMsg = SListForApplicationMessages.Get('Inventory\\PurchaseOrder.aspx_10');
        //                 if(userMsg !=null)
        //                   {
        //                      alert (userMsg );
        //                        return false;
        //                   }  
        //            else{
        //            alert('Provide the reorder level');
        //              return false;
        //            }
        //            document.getElementById('txtReOrderLevel').focus();
        //            return false;
        //        }
        if (document.getElementById('chkHasUsage').checked) {
            if (document.getElementById('txtUsageCount').value == '0') {
                
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_13") == null ? "Provide the usage count" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_13");
//                var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_13');
//                var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//                if (userMsg != null && errorMsg != null) {
//                    ValidationWindow(userMsg, errorMsg);
//                    return false;

//                }
//                else {
                ValidationWindow(userMsg, errorMsg);
                    return false;
                //}
                document.getElementById('txtUsageCount').focus();
                return false;
            }
        }
        if (document.getElementById('bUnits').value == "0") {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_14") == null ? "Select the LSUnit" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_14");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_14');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//                return false;

//            }
//            else {
            ValidationWindow(userMsg, errorMsg);
                return false;
                //}
            //end
            document.getElementById('bUnits').focus();
            return false;
        }
        GetProductsAttributes();
    }

    function NewProductCancel() {
        document.getElementById('divNewProduct').className = 'hide';
        document.getElementById('divProduct').className = 'show';
        return false;
    }

    function FnClear() {


        document.getElementById('txtMake').value = '';
        document.getElementById('txtProductCode').value = '';
        document.getElementById('TxtTax').value = 0;
        document.getElementById('hdnId').value = 0;
        document.getElementById('txtProductName').value = '';
        document.getElementById('ddlCategory').value = 0;
        document.getElementById('bUnits').value = 0;
        document.getElementById('txtDescription').value = '';

        document.getElementById('txtMfgName').value = '';
        document.getElementById('txtMfgCode').value = '';
        document.getElementById('chkIsScheduleHDrug').checked = false;
        document.getElementById('chkExpDate').checked = false;
        document.getElementById('chkBatchNo').checked = false;
        //document.getElementById('chkIsDeleted').checked = false;
        document.getElementById('btnFinish').value = 'Save';
        document.getElementById('lblmsg').innerText = '';
        document.getElementById('hdnStatus').value = 'Save';
        document.getElementById('ddlType').value = 0;

        document.getElementById('chkHasSerialNo').checked = false;
        document.getElementById('chkIsLabAnalyzer').checked = false;
        document.getElementById('txtProductModel').value = '';
        document.getElementById('txtLTofProduct').value = '';
        document.getElementById('txtGenericName').value = '';
        document.getElementById('hdnGenericID').value = '0';

        document.getElementById('tdTransblock').style.display = 'hide';
        document.getElementById('tddelete').style.display = 'hide';

        document.getElementById('hdnLocationList').value = '';

        //var chkAttrib = document.getElementById('GvSelectAttribute').childNodes[0];

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "checkbox") {
                document.forms[0].elements[i].checked = false;
            }
        }
        //        $("#LocationPanel input.Txtboxverysmall").each(function() {
        //            $(this).val(0);

        //        });

        //        var alldynamic = document.getElementById("LocationPanel").getElementsByTagName("input");
        //        for (var i = 0; i < alldynamic.length; i++) {

        //            alldynamic[i].style.display = "none";


        //        }
        document.getElementById('divNewProduct').className = 'hide';
        document.getElementById('divProduct').className = 'show';
        $('#hdnGetTax').val('0');
        return false;
    }

    function isSpclChar(e) {
        var key;
        var isCtrl = false;

        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 46) || (key == 44) || (key == 45)) {
            isCtrl = true;
        }

        return isCtrl;
    }

    function GetProductsAttributes() {
        var GetValue = '';
        $("#divProductAttributes table tr").each(function() {
            var tr = $(this).closest("tr");
            $(tr).children('td').each(function(i) {
                var td = $(this).closest("td");
                if ($(this).children().attr('type') == 'checkbox') {
                    var id = $(this).children().attr('id');
                    var chk = document.getElementById(id).checked == true ? "Y" : "N";
                    GetValue += id + '~' + chk + '#';
                }
                else if ($(this).children().attr('type') == 'text') {
                    var id = $(this).children().attr('id');
                    var value = document.getElementById(id).value;
                    GetValue += id + '~' + value + '#';
                }
                else if ($(this).children().attr('type') == 'dropdownlist') {
                    var id = $(this).children().attr('id');
                    var value = document.getElementById(id).value;
                    GetValue += id + '~' + value + '#';
                }
            });

        });

        $('#hdnProductList').val(GetValue);
    }

    function SetProductsAttributes() {
        var GetValue = $('#hdnProductList').val().split('#');

        for (var i = 0; i < GetValue.length; i++) {
            if (GetValue[i] != "") {
                var ArrayValue = GetValue[i].split('~');
                var id = ArrayValue[0] + '~' + ArrayValue[1];

                if (document.getElementById(id).type == 'checkbox') {
                    document.getElementById(id).checked = ArrayValue[2] == "Y" ? true : false;
                }
                else if (document.getElementById(id).type == 'text') {
                    document.getElementById(id).value = ArrayValue[2];
                }
                else if (document.getElementById(id).type == 'dropdownlist') {
                    document.getElementById(id).value = ArrayValue[2];
                }
            }
        }
    }

    function SetTax() {
        var GetValue = $('#hdnCatTax').val().split('#');
        for (var i = 0; i < GetValue.length; i++) {
            if (GetValue[i] != "") {
                var ArrayValue = GetValue[i].split('~');
                if ($('#<%= ddlCategory.ClientID %>').val() == ArrayValue[0]) {
                    $('#<%= TxtTax.ClientID %>').val(parseFloat(ArrayValue[1]).toFixed(2));
                    $('#hdnGetTax').val(parseFloat(ArrayValue[1]).toFixed(2));

                    break;
                }
            }
        }

    }
    SetProductsAttributes();

    function doValidatePercent(obj) {
        if (Number(obj.value) > 100) {
            
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_15") == null ? "percentage must between 0 to 100" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_15");
//            var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrder_aspx_15');
//            var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//            if (userMsg != null && errorMsg != null) {
//                ValidationWindow(userMsg, errorMsg);
//            }
//            else {
            ValidationWindow(userMsg, errorMsg);
            //  }
          //end
            obj.value = "0.00";
            obj.select();
        }
        $('#hdnGetTax').val(Number(obj.value));
        return false;
    }
  function AutoCompleteProduct_callback(result, context) {
            if (result == "") {
               // ValidationWindow("Free text not allowed", informMsg);
                pSetfocus();
            }
        }

        function pageLoad() {
            if ($find('AutoCompleteProduct') != null) {
                $find('AutoCompleteProduct')._onMethodComplete = function(result, context) {
                    $find('AutoCompleteProduct')._update(context, result, /* cacheResults */false);
                    AutoCompleteProduct_callback(result, context);
                };
            }
        }

        $(document).ready(function() {
            LoadOrdItems();

        });
</script>

</body>
</html>



