<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationProductMapping.aspx.cs"
    Inherits="Admin_InvestigationProductMapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="uc31" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ChangesDevices() {
            document.getElementById('txtInvName').value = ''
            var sval = document.getElementById('drpDevices').value;
            $find('AutoInvName').set_contextKey(sval);
        }
        function validatedevice() {
            if (document.getElementById('drpDevices').value == '0') {
                alert('Select Device Name');
                document.getElementById('drpDevices').focus();
                return false;
            }

            return true;
        }


        function validateinvest() {
            if (document.getElementById('drpDevices').value == '0') {
                alert('Select Device Name');
                document.getElementById('drpDevices').focus();
                return false;
            }

            if (document.getElementById('txtInvName').value == '') {
                alert('Enter Investigation Name');
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
                document.getElementById('tableContent').style.display = 'block';

            }
            else {
                // document.getElementById('<%=hdnInvID.ClientID %>').value = '';
                document.getElementById('<%=hdnDeviceID.ClientID %>').value = '0';
                document.getElementById('<%=hdnDeviceMappingID.ClientID %>').value = '0';
                document.getElementById('tableContent').style.display = 'none';
            }

        }
        //Table and validation
        function getdeviceid() {
            var deviceid = document.getElementById('drpDevices').value;
            $find('AutoInvName').set_contextKey(deviceid);
        }
        function validationes() {
            if (document.getElementById('txtInvName').value == '') {
                alert('Enter Investigation Name');
                document.getElementById('txtInvName').focus();
                return false;
            }
            if (document.getElementById('txtProductName').value == '') {
                alert('Enter Product Name');
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtEquantity').value == '') {
                alert('enter estimated quantity');
                document.getElementById('txtEquantity').focus();
                return false;
            }
            if (document.getElementById('eunits').value == "0") {
                alert('Select the Estimated quantity');
                document.getElementById('eunits').focus();
                return false;
            }
            if (document.getElementById('txtBquantity').value == '') {
                alert('enter Buffer quantity');
                document.getElementById('txteBquantity').focus();
                return false;
            }

            if (document.getElementById('bUnits').value == "0") {
                alert('Select the Buufer quantity');
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
                alert('Product already exist');
                //                alert("Repeated Values Check the Table List");
                fnclear();
                document.getElementById('txtProductName').focus();
                return false;
            }
            //End For Duplicate Validation




            if (document.getElementById('add').value == 'Update') {
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
                document.getElementById('btnSaveID').style.display = 'block';
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
            document.getElementById('hdnDeviceID').value = "";
            document.getElementById('hdnDeviceMappingID').value = "";
        }
        function btnEdit_OnClick(sEditedData) {
            document.getElementById('tableContent').style.display = 'block';
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
            document.getElementById('add').value = 'Update';

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

            var pParentProIDs = document.getElementById('hdnUnProducts').value.split("^");
            var pList = document.getElementById('hdnProductMapping').value.split("^");
            var Headrow = document.getElementById('tblProductMap').insertRow(0);

            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
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
            cell11.innerHTML = "S.No.";
            cell1.innerHTML = "Device";
            cell2.innerHTML = "Investigation Name";
            cell3.innerHTML = "Product Name";
            cell4.innerHTML = "Estimated Qty";
            cell5.innerHTML = "E-Units";
            cell6.innerHTML = "Buffer Qty";
            cell7.innerHTML = "B-Units";
            cell8.innerHTML = "Select";
            var isChild = false;
            var pCount = pParentProIDs.length - 1;
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var row = document.getElementById('tblProductMap').insertRow(1);
                    row.style.height = "11px";
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

                                    cell8.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                                    isChild = true;
                                }
                                else {
                                    var Chrow = document.getElementById('tblProductMap').insertRow(2);
                                    Chrow.style.height = "9px";
                                    Chrow.style.fontSize = "10px";
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
                                    chcell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"

                                }

                            }
                        }
                    }
                    pCount--;
                }
            }
        }

        
        
      
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                            <div style="display: none;">
                                <uc31:Theme ID="Theme1" runat="server" />
                            </div>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <%--<uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                                <table class="defaultfontcolor w-100p searchPanel">
                                    <tr>
                                        <td>
                                            <div id="DivSupplier" runat="server">
                                           
                                             <table  class="dataheader2 defaultfontcolor w-100p">
                                                       
                                                    <tr>
                                                     
                                                      <td>
                                                   
                                                         <asp:Label ID="Label5" Text="Device" runat="server" Font-Bold="true" />
                                                          <asp:DropDownList ID="drpDevices" runat="server" CssClass = "ddlsmall"
                                                            OnSelectedIndexChanged ="drpDevices_SelectedIndexChanged"
                                                               AutoPostBack ="true"  onchange="ChangesDevices();" >
                                                            </asp:DropDownList>
                                                             &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                     </td>
                                                  
                                                     
                                                         <td>
                                                          <asp:Label ID="Label6" Text="Investigation Name" runat="server" TabIndex="1"
                                                                Font-Bold="true" />
                                                             <asp:TextBox ID="txtInvName" runat="server"  CssClass ="Txtboxsmall" TabIndex="2" onblur=" return validatedevice();" />
                                                            <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtInvName"
                                                                ServiceMethod="GetInventoryList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                                                MinimumPrefixLength="2" OnClientItemSelected="fnSelectedInventory" CompletionInterval="10"
                                                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                            </ajc:AutoCompleteExtender>
                                                             &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                         <input id="hdnInvID" runat="server" type="hidden" />
                                                        <input id="hdnDeviceID" runat="server" type="hidden" value="0" />
                                                        <input id="hdnDeviceMappingID" runat="server" type="hidden" value="0" />
                                                        <input id="hdnInvestigationMappingID" runat="server" type="hidden" value="0" />
                                                        </td>
                                                        
                                                       
                                                    
                                                    
                                                    </tr>
                                                   
                                                </table>
                                              
                                                <table id="tableContent" class="dataheader2 defaultfontcolor w-100p" style="display : none">
                                                        <td>
                                                          <asp:Label ID="Label2" Text="Product Name" runat="server" Font-Bold="true" />
                                                           
                                                        </td>
                                                        <td>
                                                         <asp:Label ID="Label3" Text="Estimated Quantity" runat="server" Font-Bold="true" />
                                                          
                                                        </td>
                                                        <td>
                                                  
                                                           <asp:Label ID="lbldevice" Text="Units" runat="server" Font-Bold="true" />
                                                        </td>
                                                        <td> <asp:Label ID="Bufferquantity" Text="Buffer Quantity" runat="server" Font-Bold="true" />
                                                        </td>
                                                        <td>
                                                             <asp:Label ID="Label4" Text="Units" runat="server" Font-Bold="true" />
                                                        </td>
                                                        <td>
                                                        
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        <input id="hdnProductId" runat="server" type="hidden" />
                                                        <input id="hdnParentProductID" runat="server" type="hidden" />
                                                         <input id="hdnUnit" runat="server" type="hidden" />
                                                          <asp:TextBox ID="txtProductName" runat="server" TabIndex="3" onkeydown=" return validateinvest();" />
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProductName"
                                                                ServiceMethod="getProductInvList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                                                MinimumPrefixLength="2" OnClientItemSelected="fnSelectedProducts" CompletionInterval="10"
                                                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                       
                                                        <td>    <asp:TextBox ID="txtEquantity" runat="server" Width="70px" TabIndex="4"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                Style="margin-left: 0px" />
                                                        </td>
                                                      
                                                        <td>
                                                           <asp:DropDownList ID="eunits" runat="server" Width="71px" TabIndex="5" />
                                                        </td>
                                                        <td>
                                                         <asp:TextBox ID="txtBquantity" runat="server" Width="70px" TabIndex="6"  onkeypress="return ValidateOnlyNumeric(this);"  />
                                                            
                                                        </td>
                                                        <td>
                                                           
                                                            <asp:DropDownList ID="bUnits" runat="server" Width="71px" TabIndex="7"  >
                                                           <%-- <asp:ListItem Value="0">--Select-- </asp:ListItem>
                                                             <asp:ListItem Value="Value">Value </asp:ListItem>
                                                             <asp:ListItem Value="Percentage">Percentage</asp:ListItem>--%>
                                                             </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <input type="button" id="add" value="Add" class="btn" onclick="javascript:createClienttab();"
                                                                tabindex="8" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table id="tblProductMap" class="dataheaderInvCtrl w-100p font10 a-left">
                                                </table>
                                                <table class="defaultfontcolor w-100p">
                                                    <tr>
                                                        <td class="a-center style4" id="btnSaveID" style="display: none">
                                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" Height="26px" Width="59px"  
                                                                OnClick="btnSave_Click" />
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
