<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationProductMapping.aspx.cs"
    Inherits="Admin_InvestigationProductMapping" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">

        function ChangesDevices() {
            document.getElementById('txtInvName').value = ''
            var sval = document.getElementById('drpDevices').value;
            $find('AutoInvName').set_contextKey(sval);
        }
        function validatedevice() {
            if (document.getElementById('drpDevices').value == '0') {

                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectDevice') == null ? "Select Device Name" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectDevice');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');

                ValidationWindow(userMsg, errorMsg);
                document.getElementById('drpDevices').focus();
                return false;
            }

            return true;
        }


        function validateinvest() {
            if (document.getElementById('drpDevices').value == '0') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectDevice') == null ? "Select Device Name" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectDevice');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                
                    ValidationWindow(userMsg, errorMsg);
                
                document.getElementById('drpDevices').focus();
                return false;
            }

            if (document.getElementById('txtInvName').value == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterInvestigation') == null ? "Enter Investigation Name" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterInvestigation');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                    ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtInvName').focus();
                return false;
            }

            return true;
        }
        //Auto compplete
        function fnSelectedProducts(source, eventArgs) {

            var lis = eventArgs.get_value();
            AddProductDetails(lis);
        }
        function AddProductDetails(obj) {
            var p = obj.split('~');
            if (p.lenght != 0) {

                document.getElementById('<%= txtProductName.ClientID %>').value = p[0];
                document.getElementById('<%=hdnProductId.ClientID %>').value = p[1];
                document.getElementById('<%=hdnParentProductID.ClientID %>').value = p[3];
                document.getElementById('eunits').value = p[4];
                document.getElementById('bUnits').value = p[4];

            }
            else {
                document.getElementById('<%=hdnProductId.ClientID %>').value = '';
                document.getElementById('<%=hdnParentProductID.ClientID %>').value = '0';
                document.getElementById('eunits').value = '0';
                document.getElementById('bUnits').value = '0';
            }

        }
        function fnSelectedInventory(source, eventArgs) {
            var lis = eventArgs.get_value();
            AddInventoryDetails(lis);
        }
        function AddInventoryDetails(obj) {

            var p = obj.split('~');
            if (p.lenght != 0) {
                document.getElementById('<%= txtInvName.ClientID %>').value = p[0];
                document.getElementById('<%=hdnInvID.ClientID %>').value = p[1];
                document.getElementById('<%=hdnDeviceID.ClientID %>').value = p[3];
                document.getElementById('<%=hdnDeviceMappingID.ClientID %>').value = p[4];
                //document.getElementById('tableContent').style.display = 'block';
                $('#tableContent').removeClass().addClass('show');


            }
            else {
                // document.getElementById('<%=hdnInvID.ClientID %>').value = '';
                document.getElementById('<%=hdnDeviceID.ClientID %>').value = '0';
                document.getElementById('<%=hdnDeviceMappingID.ClientID %>').value = '0';
                //document.getElementById('tableContent').style.display = 'none';
                $('#tableContent').removeClass().addClass('hide');

            }

        }
        //Table and validation
        function getdeviceid() {
            var deviceid = document.getElementById('drpDevices').value;
            $find('AutoInvName').set_contextKey(deviceid);
        }
        function validationes() {
            if (document.getElementById('txtInvName').value == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterInvestigation') == null ? "Enter Investigation Name" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterInvestigation');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                    ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtInvName').focus();
                return false;
            }
            if (document.getElementById('txtProductName').value == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterProduct') == null ? "Enter Product Name" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterProduct');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtEquantity').value == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterEstQuantity') == null ? "Enter estimated quantity" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterEstQuantity');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtEquantity').focus();
                return false;
            }
            if (document.getElementById('eunits').value == "0") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectEstQuantity') == null ? "Select the Estimated quantity" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectEstQuantity');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('eunits').focus();
                return false;
            }
            if (document.getElementById('txtBquantity').value == '') {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterBufferQuantity') == null ? "Enter Buffer quantity" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_EnterBufferQuantity');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txteBquantity').focus();
                return false;
            }

            if (document.getElementById('bUnits').value == "0") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectBufferQuantity') == null ? "Select the Buufer quantity" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_SelectBufferQuantity');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('bUnits').focus();
                return false;
            }

        }
        function CheckDuplicate() {
            if (document.getElementById('hdnProductMapping').value != "") {
                var list = document.getElementById('hdnProductMapping').value.split('^');
                for (var count = 0; count < list.length; count++) {
                    var ProductList = list[count].split('~');
                    if (ProductList[1] != '') {

                        if (ProductList[0] != '') {
                            rwNumber = parseInt(parseInt(ProductList[0]) + parseInt(1));
                        }
                        if (ProductName != '') {
                            if (ProductList[1] == ProductName) {
                                if (ProductList[2] == suppliername) {
                                    AddStatus = 1;
                                }
                            }
                        }
                    }
                }
            }
        }
        function createClienttab() {

            validationes();
            var eunits = document.getElementById('eunits').value;
            var bunits = document.getElementById('bUnits').value;

            var device = document.getElementById('drpDevices').value;
            var InvName = document.getElementById('txtInvName').value;
            var ProductName = document.getElementById('txtProductName').value;
            var Equantity = document.getElementById('txtEquantity').value;
            var Bquantity = document.getElementById('txtBquantity').value;
            var Productid = document.getElementById('hdnProductId').value;
            var Invid = document.getElementById('hdnInvID').value;
            var ParentProductid = document.getElementById('hdnParentProductID').value;
            var DeviceID = document.getElementById('hdnDeviceID').value;
            var DeviceMappingID = document.getElementById('hdnDeviceMappingID').value;

            //To check Duplicate validation & Add op
            var HidValue = document.getElementById('hdnProductMapping').value;
            var AddStatus = 0;
            var list = HidValue.split('^');
            if (document.getElementById('hdnProductMapping').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProductList = list[count].split('~');
                    if (ProductList != '') {
                        if (ProductName != '') {
                            //                            device + "~" + InvName + "~" + ProductName + "~" + Equantity + "~" + eunits + "~" + Bquantity + "~" + bunits + "~" + Productid + "~" + Invid + "~" + ParentProductid + "~" + DeviceID + "~" + DeviceMappingID
                            //  if (ProductList[0] == device && ProductList[1] == InvName && ProductList[2] == ProductName && ProductList[3] == Equantity && ProductList[4] == eunits && ProductList[5] == Bquantity && ProductList[6] == bunits && ProductList[7] == bunits && ProductList[8] == Invid && ProductList[9] == ParentProductid && ProductList[10] == DeviceID && ProductList[11] == DeviceMappingID) {//Product name , Investigationid,Device
                            if (ProductList[0] == device && ProductList[1] == InvName && ProductList[2] == ProductName && ProductList[7] == Productid && ProductList[8] == Invid) {//Product name , Investigationid,Device 

                                AddStatus = 1;
                            }
                        }

                    }
                }
            }
            if (AddStatus == 1) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_ProductExist') == null ? "Product already exist" : SListForAppMsg.Get('InventoryMaster_InvestigationProductMapping_aspx_ProductExist');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                fnclear();
                document.getElementById('txtProductName').focus();
                return false;
            }
            //End For Duplicate Validation



            var userMsg = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Update');
            userMsg = userMsg == null ? 'Update' : userMsg;
            if (document.getElementById('btnAdd').value == userMsg) {
                Deleterows();
            }
            else {


                document.getElementById('hdnProductMapping').value += device + "~" + InvName + "~" + ProductName + "~" + Equantity + "~" + eunits + "~" + Bquantity + "~" + bunits + "~" + Productid + "~" + Invid + "~" + ParentProductid + "~" + DeviceID + "~" + DeviceMappingID + "^"
                Tblist();
            }
            fnclear();
        }
        function Tblist() {
            while (count = document.getElementById('tblProductMap').rows.length) {
                for (var j = 0; j < document.getElementById('tblProductMap').rows.length; j++) {
                    document.getElementById('tblProductMap').deleteRow(j);
                }
            }


            var x = document.getElementById('hdnProductMapping').value.split("^");
            //            document.getElementById('hdnSaveTable').value = document.getElementById('hdnSetListTable').value;

            for (i = 0; i < x.length; i++) {
                m = document.getElementById('hdnUnProducts').value.split("^");
                if (x[i] != "") {
                    y = x[i].split('~');
                    // document.getElementById('txtProductName').focus();
                    BindUniqueProducts(y[0]);

                }
            }
            ChildGridList();
            if (document.getElementById('hdnProductMapping').value != "") {
                //document.getElementById('btnSaveID').style.display = 'block';
                $('#btnSaveID').removeClass().addClass('show');
            }
        }
        function BindUniqueProducts(objVal) {
            document.getElementById('hdnUnProducts').value = objVal + "^";
            for (k = 0; k < m.length; k++) {
                if (m[k].trim() != "" && m[k].trim() != objVal) {
                    document.getElementById('hdnUnProducts').value += m[k] + "^";
                }
            }
        }
        function Deleterows() {

            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnProductMapping').value.split("^");
            if (RowEdit != "") {

                var eunits = document.getElementById('eunits').value;
                var bunits = document.getElementById('bUnits').value;

                var device = document.getElementById('drpDevices').value;
                var InvName = document.getElementById('txtInvName').value;
                var ProductName = document.getElementById('txtProductName').value;

                var Equantity = document.getElementById('txtEquantity').value;
                var Bquantity = document.getElementById('txtBquantity').value;
                var Productid = document.getElementById('hdnProductId').value;
                var Invid = document.getElementById('hdnInvID').value;
                var ParentProductid = document.getElementById('hdnParentProductID').value;
                var DeviceID = document.getElementById('hdnDeviceID').value;
                var DeviceMappingID = document.getElementById('hdnDeviceMappingID').value;
                document.getElementById('hdnProductMapping').value = device + "~" + InvName + "~" + ProductName + "~" + Equantity + "~" + eunits + "~" + Bquantity + "~" + bunits + "~" + Productid + "~" + Invid + "~" + ParentProductid + "~" + DeviceID + "~" + DeviceMappingID + "^"
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById('hdnProductMapping').value += x[i] + "^";
                        }
                    }
                }
                Tblist();


            }
        }
        function btnDelete(sEditedData) {
            var i;
            var x = document.getElementById('hdnProductMapping').value.split("^");
            document.getElementById('hdnProductMapping').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnProductMapping').value += x[i] + "^";
                    }
                }
            }
            Tblist();
        }

        function fnclear() {
            document.getElementById('eunits').value = "0";
            document.getElementById('bUnits').value = "0";

            //  document.getElementById('drpDevices').value ="0";
            // document.getElementById('txtInvName').value ="";
            document.getElementById('txtProductName').value = "";

            document.getElementById('txtEquantity').value = "";
            document.getElementById('txtBquantity').value = "";
            document.getElementById('hdnProductId').value = "";
            // document.getElementById('hdnInvID').value = "";
            document.getElementById('hdnParentProductID').value = "";
           // document.getElementById('hdnDeviceID').value = "";
            //document.getElementById('hdnDeviceMappingID').value = "";
        }
        function btnEdit_OnClick(sEditedData) {
            //document.getElementById('tableContent').style.display = 'block';
            $('#tableContent').removeClass().addClass('show');
            var y = sEditedData.split('~');
            document.getElementById('hdnRowEdit').value = sEditedData;

            document.getElementById('eunits').value = y[4];
            document.getElementById('bUnits').value = y[6];

            document.getElementById('drpDevices').value = y[0];
            document.getElementById('txtInvName').value = y[1];
            document.getElementById('txtProductName').value = y[2];

            document.getElementById('txtEquantity').value = y[3];
            document.getElementById('txtBquantity').value = y[5];
            document.getElementById('hdnProductId').value = y[7];
            document.getElementById('hdnInvID').value = y[8];
            document.getElementById('hdnParentProductID').value = y[9];
            document.getElementById('hdnDeviceID').value = y[10];
            document.getElementById('hdnDeviceMappingID').value = y[11];


            var userMsg = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Update');
            userMsg = userMsg == null ? 'Update' : userMsg;
            document.getElementById('btnAdd').value = userMsg;

            var list = document.getElementById('hdnProductMapping').value.split("^");
            document.getElementById('hdnProductMapping').value = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    if (list[i] != sEditedData) {
                        document.getElementById('hdnProductMapping').value += list[i] + "^";
                    }
                }
            }
            Tblist();
        }
        function ChildGridList() {
            var Edit = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Edit') == null ? "Edit" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Edit');
            var Delete = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Delete') == null ? "Delete" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Delete')
            var pParentProIDs = document.getElementById('hdnUnProducts').value.split("^");
            var pList = document.getElementById('hdnProductMapping').value.split("^");
            var Headrow = document.getElementById('tblProductMap').insertRow(0);

            Headrow.id = "HeadID";
            //Headrow.style.fontWeight = "bold";
            Headrow.addClass("bold");
            Headrow.className = "dataheader1"

            var cell11 = Headrow.insertCell(0);
            var cell1 = Headrow.insertCell(1);
            var cell2 = Headrow.insertCell(2);
            var cell3 = Headrow.insertCell(3);
            var cell4 = Headrow.insertCell(4);
            var cell5 = Headrow.insertCell(5);
            var cell6 = Headrow.insertCell(6);
            var cell7 = Headrow.insertCell(7);
            var cell8 = Headrow.insertCell(8);
            cell11.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Sno') == null ? "S.No." : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Sno')
            cell1.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Device') == null ? "Device" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Device');
            cell2.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Investigation') == null ? "Investigation Name" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Investigation');
            cell3.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_ProductName') == null ? "Product Name" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_ProductName');
            cell4.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_EstQuantity') == null ? "Estimated Qty" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_EstQuantity');
            cell5.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Eunits') == null ? "E-Units" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Eunits');
            cell6.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_BufferedQty') == null ? "Buffer Qty" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_BufferedQty');
            cell7.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_BUnits') == null ? "B-Units" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_BUnits');
            cell8.innerHTML = SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Select') == null ? "Select" : SListForAppDisplay.Get('InventoryMaster_InvestigationProductMapping_aspx_Select'); 
            var isChild = false;
            var pCount = pParentProIDs.length - 1;
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var row = document.getElementById('tblProductMap').insertRow(1);
                    //row.style.height = "11px";
                    row.addClass("h-11");
                    var cell11 = row.insertCell(0);
                    var cell1 = row.insertCell(1);
                    var cell2 = row.insertCell(2);
                    var cell3 = row.insertCell(3);
                    var cell4 = row.insertCell(4);
                    var cell5 = row.insertCell(5);
                    var cell6 = row.insertCell(6);
                    var cell7 = row.insertCell(7);
                    var cell8 = row.insertCell(8);
                    //                    var cell9 = row.insertCell(9);

                    isChild = false;

                    for (s = 0; s < pList.length; s++) {
                        if (pList[s] != "") {
                            y = pList[s].split('~');
                            if (pParentProIDs[j] == y[0]) {
                                cell11.innerHTML = pCount;
                                if (isChild == false) {
                                    cell1.innerHTML = y[0];
                                    cell2.innerHTML = y[1];
                                    cell3.innerHTML = y[2];
                                    cell4.innerHTML = y[3];
                                    cell5.innerHTML = y[4];
                                    cell6.innerHTML = y[5];
                                    cell7.innerHTML = y[6];

                                    cell8.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnEdit_OnClick(name);' value = '" + Edit + "' type='button' class='view underline pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnDelete(name);' value = '" + Delete + "' type='button' class='view underline pointer'   />"
                                    isChild = true;
                                }
                                else {
                                    var Chrow = document.getElementById('tblProductMap').insertRow(2);
                                    //Chrow.style.height = "9px";
                                    Chrow.addClass("h-9");
                                    //Chrow.style.fontSize = "10px";
                                    Chrow.addClass("font10");
                                    var chcell12 = Chrow.insertCell(0);
                                    var chcell11 = Chrow.insertCell(1);
                                    var chcell1 = Chrow.insertCell(2);
                                    var chcell2 = Chrow.insertCell(3);
                                    var chcell3 = Chrow.insertCell(4);
                                    var chcell4 = Chrow.insertCell(5);
                                    var chcell5 = Chrow.insertCell(6);
                                    var chcell6 = Chrow.insertCell(7);
                                    var chcell7 = Chrow.insertCell(8);


                                    chcell1.innerHTML = y[1];
                                    chcell2.innerHTML = y[2];
                                    chcell3.innerHTML = y[3];
                                    chcell4.innerHTML = y[4];
                                    chcell5.innerHTML = y[5];
                                    chcell6.innerHTML = y[6];
                                    chcell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnEdit_OnClick(name);' value = '"+Edit+"' type='button' class='view underline pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnDelete(name);' value = '" + Delete + "' type='button' class='view underline pointer' />"

                                }

                            }
                        }
                    }
                    pCount--;
                }
            }
        }

        
        
      
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryMaster/Webservice/InventoryMaster.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="w-100p defaultfontcolor" cellpadding="2" cellspacing="2">
                    <tr>
                        <td>
                            <div id="DivSupplier" runat="server">
                                <table cellpadding="2" class="dataheader2 defaultfontcolor w-100p" cellspacing="1">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label5" Text="Device" runat="server" Font-Bold="True" 
                                                meta:resourcekey="Label5Resource1" />
                                            <asp:DropDownList ID="drpDevices" runat="server" CssClass="ddlsmall" OnSelectedIndexChanged="drpDevices_SelectedIndexChanged"
                                                AutoPostBack="True" onchange="ChangesDevices();" 
                                                meta:resourcekey="drpDevicesResource1">
                                            </asp:DropDownList>
                                            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" Text="Investigation Name" runat="server" TabIndex="1" 
                                                Font-Bold="True" meta:resourcekey="Label6Resource1" />
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtInvName" runat="server" CssClass="small" TabIndex="2" 
                                                onblur=" return validatedevice();" meta:resourcekey="txtInvNameResource1" />
                                            <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtInvName"
                                                ServiceMethod="GetInventoryList" ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx"
                                                EnableCaching="false" MinimumPrefixLength="2" OnClientItemSelected="fnSelectedInventory"
                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                            </ajc:AutoCompleteExtender>
                                            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                                            <input id="hdnInvID" runat="server" type="hidden" />
                                            <input id="hdnDeviceID" runat="server" type="hidden" value="0" />
                                            <input id="hdnDeviceMappingID" runat="server" type="hidden" value="0" />
                                            <input id="hdnInvestigationMappingID" runat="server" type="hidden" value="0" />
                                        </td>
                                    </tr>
                                </table>
                                <table id="tableContent" cellpadding="2" class="dataheader2 defaultfontcolor w-100p hide" cellspacing="1">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" Text="Product Name" runat="server" Font-Bold="True" 
                                                meta:resourcekey="Label2Resource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" Text="Estimated Quantity" runat="server" 
                                                Font-Bold="True" meta:resourcekey="Label3Resource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lbldevice" Text="Units" runat="server" Font-Bold="True" 
                                                meta:resourcekey="lbldeviceResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Bufferquantity" Text="Buffer Quantity" runat="server" 
                                                Font-Bold="True" meta:resourcekey="BufferquantityResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" Text="Units" runat="server" Font-Bold="True" 
                                                meta:resourcekey="Label4Resource1" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input id="hdnProductId" runat="server" type="hidden" />
                                            <input id="hdnParentProductID" runat="server" type="hidden" />
                                            <input id="hdnUnit" runat="server" type="hidden" />
											<asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductName" runat="server" TabIndex="3" onkeydown=" return validateinvest();" />
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProductName"
                                                ServiceMethod="getProductInvList" ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx"
                                                EnableCaching="false" MinimumPrefixLength="2" OnClientItemSelected="fnSelectedProducts"
                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtEquantity" runat="server" Width="70px" TabIndex="4" onkeydown="return validatenumber(event)"
                                                CssClass="marginL0" meta:resourcekey="txtEquantityResource1" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="eunits" runat="server" Width="71px" TabIndex="5" 
                                                meta:resourcekey="eunitsResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBquantity" runat="server" Width="70px" TabIndex="6" 
                                                onkeydown="return validatenumber(event)" 
                                                meta:resourcekey="txtBquantityResource1" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="bUnits" runat="server" Width="71px" TabIndex="7"
											meta:resourcekey="bUnitsResource1">
                                                <%-- <asp:ListItem Value="0">--Select-- </asp:ListItem>
                                                             <asp:ListItem Value="Value">Value </asp:ListItem>
                                                             <asp:ListItem Value="Percentage">Percentage</asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <input type="button" id="btnAdd" value="Add" class="btn" meta:resourcekey="btnAdd" onclick="javascript:createClienttab();"
                                                tabindex="8" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table id="tblProductMap" border="1" class="dataheaderInvCtrl w-100p a-left font10">
                                </table>
                                <table class="defaultfontcolor w-100p" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td id="btnSaveID" class="style4 a-center hide">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" 
                                                OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                            <asp:HiddenField ID="hdnSaveTable" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" id="hdnProductMapping" runat="server" />
                                <input type="hidden" id="hdnUnProducts" runat="server" value="" />
                                <asp:HiddenField ID="hdnRowEdit" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
