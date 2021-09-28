<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomAttributesMaster.aspx.cs"
    Inherits="Inventory_CustomAttributesMaster" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Attributes Master</title>
    
    <script src="../PlatForm/Scripts/dateTimePicker-UI.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/ProgressBar.js" type="text/javascript"></script>
<style>
    .h-150 {
        height: 150px;
        }
</style>
     <script language="javascript" type="text/javascript">


         function ShowType() {
             //if (document.getElementById('DivType').style.display == 'table-cell')
             if ($('#DivType').hasClass('displaytd'))
                 //document.getElementById('DivType').style.display = 'none';
                 $('#DivType').removeClass().addClass('hide');
             else
                 //document.getElementById('DivType').style.display = 'table-cell';
                 $('#DivType').removeClass().addClass('displaytd');

             return false;
         }
         function ShowhideType() {
             if (document.getElementById('ShowTypeid').src.split('Images')[1] == '/show.png')
                 document.getElementById('ShowTypeid').src = '~/PlatForm/Images/hide.png';
             else if (document.getElementById('ShowTypeid').src.split('Images')[1] == '/hide.png')
                 document.getElementById('ShowTypeid').src = '~/PlatForm/Images/show.png'; 
                  
         }

         function isNumeric(e, Id) {
             var key; var isCtrl; var flag = 0;
             var txtVal = document.getElementById(Id).value.trim();
             var len = txtVal.split('.');
             if (len.length > 0) {
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



         var JsonAttributeList = {};
         var EditAttributeList = [];
         var DynamicAttributeList = [];
         function DynamicTable() {
             //  debugger;

             var ProductList;
             var loginID = $("#hdnUserLoginId").val();
             if ($("#hdnAttributeList").val() != '') {
                 AttributeList = $("#hdnAttributeList").val();
             }
             var Result = JSON.parse(AttributeList);
             $.each(Result, function(i, Obj) {
                 DynamicAttributeList.push({
                     MappingID: Obj.MappingID,
                     AttributeName: Obj.AttributeName,
                     AttributeID: Obj.AttributeID,
                     AttributeStatus: Obj.AttributeStatus,
                     IsPreDefined: Obj.IsPreDefined,
                     DataType: Obj.DataType,
                     ControlLength: Obj.ControlLength,
                     IsMandatory: Obj.IsMandatory,
                     DisplayText: Obj.DisplayText,
                     Status: Obj.Status,
                     Description: Obj.MappingID + "_" + Obj.AttributeID,
                     ControlTypeID: Obj.ControlTypeID,
                     ControlName: Obj.ControlName,
                     CreatedBy: loginID,
                     ControlCode: Obj.ControlCode,
                     Type: Obj.Type,
                     ID: i,
                     ControlValue: Obj.ControlValue,
                     IsTableReference: Obj.IsTableReference

                 });
             });


             ItemTableCreation(DynamicAttributeList);

         }




         function ItemTableCreation(DataTable) {

             document.getElementById('hdnAttributeList').value = '';
             while (count = document.getElementById('tblAttributeValues').rows.length) {

                 for (var j = 0; j < document.getElementById('tblAttributeValues').rows.length; j++) {
                     document.getElementById('tblAttributeValues').deleteRow(j);
                 }
             }
             var Edit = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Edit') == null ? "Edit" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Edit');
             var Delete = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Delete') == null ? "Delete" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Delete');
             var tbleDynamic = $("#tblAttributeValues");

             var Headrow = document.getElementById('tblAttributeValues').insertRow(0);
             Headrow.id = "HeadID1";
             //Headrow.style.fontWeight = "bold";
             Headrow.addClass("bold");
             Headrow.className = "dataheader1"
             var cell1 = Headrow.insertCell(0);
             var cell2 = Headrow.insertCell(1);
             var cell3 = Headrow.insertCell(2);
             var cell4 = Headrow.insertCell(3);
             var cell5 = Headrow.insertCell(4);
             var cell6 = Headrow.insertCell(5);
             var cell7 = Headrow.insertCell(6);
             var cell8 = Headrow.insertCell(7);
             var cell9 = Headrow.insertCell(8);
             var cell10 = Headrow.insertCell(9);



             cell1.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_AttributeName') == null ? "AttributeName" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_AttributeName');
             cell2.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_ControlType') == null ? "Control Type" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_ControlType');
             cell3.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_DataType') == null ? "Data Type" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_DataType');
             cell4.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Length') == null ? "Length" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Length');
             cell5.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_AttributeStatus') == null ? "AttributeStatus" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_AttributeStatus');
             cell6.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_IsPredefined') == null ? "IsPredefined" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_IsPredefined');
             cell7.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_IsMandatory') == null ? "IsMandatory" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_IsMandatory');
             cell8.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Status') == null ? "Status" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Status');
             cell10.innerHTML = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Action') == null ? "Action" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Action');

             $.each(DataTable, function(k, Res) {

                 var row = document.getElementById('tblAttributeValues').insertRow(1);
                 //row.style.height = "13px";
                 row.addClass("h-13");
                 row.id = Res.Description;
                 var cell1 = row.insertCell(0);
                 var cell2 = row.insertCell(1);
                 var cell3 = row.insertCell(2);
                 var cell4 = row.insertCell(3);
                 var cell5 = row.insertCell(4);
                 var cell6 = row.insertCell(5);
                 var cell7 = row.insertCell(6);
                 var cell8 = row.insertCell(7);
                 var cell9 = row.insertCell(8);



                 cell1.innerHTML = Res.AttributeName;
                 cell2.innerHTML = Res.ControlName;
                 cell3.innerHTML = Res.DataType;
                 cell4.innerHTML = Res.ControlLength;
                 cell5.innerHTML = Res.AttributeStatus;
                 cell6.innerHTML = Res.IsPreDefined;
                 cell7.innerHTML = Res.IsMandatory;
                 cell8.innerHTML = Res.Status;
                 cell9.innerHTML = "<input name='" + Res.Description + "' onclick='Dyn_btnEdit_OnClick(this,name);' value = '" + Edit + "' type='button'"
                     + " class='view underline pointer'  /><br>"
                     + "<input name='" + Res.Description + "' onclick='Dyn_btnDelete(this,name);' value = '" + Delete + "' type='button' "
                     + "class='view underline pointer'  />";

             });


             if (DynamicAttributeList.length == 0) {
                 //document.getElementById('tblAttributeValues').style.display = "none";
                 $('#tblAttributeValues').removeClass().addClass('hide');
             }
             else {
                 //document.getElementById('tblAttributeValues').style.display = "block";
                 $('#tblAttributeValues').removeClass().addClass('show');
             }

             $('[id$="hdnAttributeList"]').val(JSON.stringify(DynamicAttributeList));

         }




         function Dyn_btnEdit_OnClick(ele, sEditedData) {
             $(ele).parent('td').parent('tr').remove();
             var temp_DynamicAttributeList = [];

             for (var i = 0; i < DynamicAttributeList.length; i++) {

                 if (DynamicAttributeList[i].Description == sEditedData) {
                     EditAttributeList.push(DynamicAttributeList[i]);
                     var y = DynamicAttributeList[i];
                     document.getElementById('hdnMappingID').value = y.MappingID;
                     document.getElementById('hdnAttributeID').value = y.AttributeID;
                     document.getElementById('txtAttributeName').value = y.AttributeName;
                     document.getElementById('txtLength').value = y.ControlLength;
                     document.getElementById('ddlControlType').value = y.ControlTypeID;
                     document.getElementById('hdnControlTypeID').value = y.ControlTypeID;
                     document.getElementById('ddlDataType').value = y.DataType;
                     document.getElementById('txtDisplayText').value = y.DisplayText;
                     var msg = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Update')
                     document.getElementById('add').value = (msg == null ? 'Update' : msg); 
                     document.getElementById('chkAttributeStatus').checked = y.AttributeStatus == 1 ? true : false;
                     document.getElementById('chkIsPredefinedAttributes').checked = y.IsPreDefined == 1 ? true : false;
                     //document.getElementById('hdnAdd').value = 'Update';

                 }
                 else {
                     temp_DynamicAttributeList.push(DynamicAttributeList[i]);
                 }

             }
             temp_DynamicAttributeList = temp_DynamicAttributeList;
         }


         function CheckControlType() {

             // var pcontrolType = document.getElementById('ddlControlType').value; // document.getElementById('ddlSelling').value
             var pcontrolType = $("#ddlControlType option:selected").text();
             var pDataType = document.getElementById('ddlDataType').value;
             if (pDataType == "String" && pcontrolType != 'TextBox') {
                 document.getElementById('txtLength').value = '0';
             }
             if (pcontrolType == "CheckBox") {
                 document.getElementById('ddlDataType').value = "Boolean";
                 document.getElementById('ddlDataType').disabled = true;
                 //document.getElementById('trLength').style.display = 'none';
                 $('#trLength').removeClass().addClass('hide');
                 document.getElementById('txtLength').value = '0';
             }
             else if (pcontrolType == "dropdownlist") {
                 document.getElementById('ddlDataType').value = "String";
                 // document.getElementById('ddlDataType').options[document.getElementById('ddlDataType').selectedIndex].text = "String";
                 //document.getElementById('trLength').style.display = 'none';
                 $('#trLength').removeClass().addClass('hide');
                 document.getElementById('txtLength').value = '0';
             }
             else {
                 document.getElementById('ddlDataType').disabled = false;
                 document.getElementById('ddlDataType').value = "String";

                 if (document.getElementById('ddlDataType').value == "String" && pcontrolType == "TextBox") {
                     //document.getElementById('trLength').style.display = 'table-row';
                     $('#trLength').removeClass().addClass('displaytr');
                     document.getElementById('txtLength').value = '0';

                 }
                 else {

                     //document.getElementById('trLength').style.display = 'none';
                     $('#trLength').removeClass().addClass('hide');
                     document.getElementById('txtLength').value = '0';
                 }
             }

             if (pcontrolType != 'CheckBox') {
                 document.getElementById('ddlDataType').disabled = true;
             }
             else {
                 document.getElementById('ddlDataType').disabled = false;
             }

             //document.getElementById('ddlControlType').style.display = 'none';
             $('#ddlControlType').removeClass().addClass('hide');

         }

         function DataTypeChange() {
             // debugger;
             var pDataType = document.getElementById('ddlDataType').value;
             var pcontrolType = document.getElementById('ddlControlType').value;
             if (pDataType == "Boolean" && pcontrolType == 'TextBox') {
                 // $('#divPanel').css('height', '170px');
                 var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_SelectOtherData');
                 var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
                 if (userMsg != null && errorMsg != null) {
                     ValidationWindow(userMsg, errorMsg);
                 }
                 else {
                     ValidationWindow("select other data type", "Error");
                 }
              
                 document.getElementById('ddlDataType').focus();
             }
             if (pDataType == "String") {
                 //$('#divPanel').css('height', '150px');
                 //document.getElementById('trLength').style.display = 'table-row';
                 $('#trLength').removeClass().addClass('displaytr');
                 document.getElementById('txtLength').value = '0';

             }
             else {

                 //document.getElementById('trLength').style.display = 'none';
                 $('#trLength').removeClass().addClass('hide');
                 document.getElementById('txtLength').value = '0';
             }

         }







         function Dynamic_BindProductList() {



             var pAttributeName = document.getElementById('txtAttributeName').value;
             var pMappingID = document.getElementById('hdnMappingID').value;
             var pAttributeID = document.getElementById('hdnAttributeID').value;
             var pControlType = document.getElementById('ddlControlType').options[document.getElementById('ddlControlType').selectedIndex].text;
             var pDataType = document.getElementById('ddlDataType').options[document.getElementById('ddlDataType').selectedIndex].text;
             var pControlTypeId = document.getElementById('ddlControlType').value;
             var pContentLength = document.getElementById('txtLength').value;
             var loginID = $("#hdnUserLoginId").val();
             var pAttributeStatus = document.getElementById('chkAttributeStatus').checked == true ? 1 : 0;
             var pIsPredefinedAttributes = document.getElementById('chkIsPredefinedAttributes').checked = true ? 1 : 0;
             var pDisplaytext = document.getElementById('txtDisplayText').value;

             DynamicAttributeList.push({
                 MappingID: pMappingID,
                 AttributeName: pAttributeName,
                 AttributeID: pAttributeID,
                 AttributeStatus: pAttributeStatus,
                 IsPreDefined: pIsPredefinedAttributes,
                 DataType: pDataType,
                 ControlLength: pContentLength,
                 IsMandatory: 1,
                 DisplayText: pDisplaytext,
                 Status: 1,
                 Description: pMappingID + "_" + pAttributeID,
                 ControlTypeID: pControlTypeId,
                 ControlName: pControlType,
                 CreatedBy: loginID,
                 ControlCode: "",
                 Type: "",
                 ID: i,
                 ControlValue: "",
                 IsTableReference: 0
             });


             ItemTableCreation(DynamicAttributeList);
             var msg = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Add'); 
             document.getElementById('add').value = msg==null?'Add':msg;
             //  document.getElementById('hdnAdd').value = 'Add';
             cleardata();

         }

         function cleardata() {
             var Save = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Save') == null ? "Save" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Save');
             document.getElementById('hdnControlTypeID').value = '0';
             document.getElementById('txtAttributeName').value = '';
             document.getElementById('hdnMappingID').value = '0';
             document.getElementById('hdnAttributeID').value = '0';
             document.getElementById('ddlControlType').value = '0';
             document.getElementById('ddlDataType').value = '0';
             document.getElementById('txtLength').value = '';
             $("#hdnUserLoginId").val(0);
             document.getElementById('chkAttributeStatus').checked = false;
             document.getElementById('txtDisplayText').value = '';
             document.getElementById('btnSave').value = Save;
             document.getElementById('hdnStatus').value = Save;
             document.getElementById('hdnControlTypeID').value = '0';
             document.getElementById('lblControlType').innerHTML = '';
             //document.getElementById('trLength').style.display = 'none';
             $('#trLength').removeClass().addClass('hide');
             document.getElementById('ddlDataType').disabled = false;
             document.getElementById('ddlDataType').value = '0';
             //document.getElementById('lblControlType').style.display = 'block';
             //document.getElementById('ddlControlType').style.display = 'none';
             $('#lblControlType').removeClass().addClass('show');
             $('#ddlControlType').removeClass().addClass('hide');
             return false;
         }
         function SetAttributeValues(obj) {
             var x = obj.value.split('~');

             if (x[5] == "String") {
                 //$('#divPanel').css('height', '170px');
                 //document.getElementById('trLength').style.display = 'table-row';
                 $('#trLength').removeClass().addClass('displaytr');
             }
             else {
                // $('#divPanel').css('height', '150px');
                 //document.getElementById('trLength').style.display = 'none';
                 $('#trLength').removeClass().addClass('hide');
             }
             document.getElementById('hdnMappingID').value = x[0];
             document.getElementById('hdnAttributeID').value = x[1];
             document.getElementById('txtAttributeName').value = x[2];
             document.getElementById('hdnControlTypeID').value = x[3];
             document.getElementById('ddlControlType').value = x[3];
             document.getElementById('lblControlType').innerHTML = x[4];
             document.getElementById('ddlDataType').value = x[5];
             document.getElementById('txtLength').value = x[6];
             document.getElementById('txtDisplayText').value = x[7];
             document.getElementById('chkAttributeStatus').checked = x[8] == 1 ? true : false;
             var msg = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_Update')

             document.getElementById('btnSave').value = msg == null ? 'Update' : msg;
             document.getElementById('hdnStatus').value = msg == null ? 'Update' : msg;
             //document.getElementById('lblControlType').style.display = 'block';
             $('#lblControlType').removeClass().addClass('show');
             //document.getElementById('ddlControlType').style.display = 'block';

             if (x[4] == 'CheckBox') {
                 document.getElementById('ddlDataType').disabled = true;
             }

         }



         function checkIsEmpty() {

             if (document.getElementById('txtAttributeName').value.trim() == "") {

                 var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_EnterAttribute');
                 var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                 if (userMsg != null && errorMsg != null) {
                     ValidationWindow(userMsg, errorMsg);
                 }
                 else {
                     ValidationWindow("Enter AttributeName", "Error");
                 }
                 
                 document.getElementById('txtAttributeName').focus();
                 return false;

             }

             //            if (document.getElementById('ddlControlType').value == 0) {
             //                alert('Select ControlType');
             //                document.getElementById('ddlControlType').focus();
             //                return false;
             //            }
             //

             var pDataType = document.getElementById('ddlDataType').value;
             var pcontrolType = document.getElementById('ddlControlType').value;
             var ControlName = document.getElementById('ddlControlType').options[document.getElementById('ddlControlType').selectedIndex].text;

             //var ControlName = document.getElementById('ddlDataType').options[document.getElementById('ddlDataType').selectedIndex].text;
             if (pDataType == 'Boolean' && ControlName == 'TextBox') {
                 var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_SelectDataNotSuitable');
                 var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                 if (userMsg != null && errorMsg != null) {
                     ValidationWindow(userMsg, errorMsg);
                 }
                 else {
                     ValidationWindow("select other data type.this Datatype is not suitable  for this control", "Error");
                 }
              
                 document.getElementById('ddlDataType').focus();
                 return false;
             }

             if (document.getElementById('hdnControlTypeID').value == '0') {
                 var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_SelectControlType');
                 var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                 if (userMsg != null && errorMsg != null) {
                     ValidationWindow(userMsg, errorMsg);
                 }
                 else {
                     ValidationWindow("Select the ControlType", "Error");
                 }
                 // document.getElementById('ddlControlType').focus();
                 return false;
             }


             if (document.getElementById('ddlDataType').value == 0) {
                 var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_SelectDataType');
                 var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                 if (userMsg != null && errorMsg != null) {
                     ValidationWindow(userMsg, errorMsg);
                 }
                 else {
                     ValidationWindow("Select DataType", "Error");
                 }

                 document.getElementById('ddlDataType').focus();
                 return false;
             }

             var pDataType = document.getElementById('ddlDataType').value;
             var pcontrolType = document.getElementById('ddlControlType').value;

             $('#hdnDataType').val(pDataType);
             if (pDataType == "String" && pDataType > 0) {
                 // document.getElementById('trLength').style.display = 'block';
                 $('#trLength').removeClass().addClass('show');
                 var stringlength = Number(document.getElementById('txtLength').value.trim() == "" ? 0 : document.getElementById('txtLength').value);
                 if (Number(stringlength) == 0) {
                     var userMsg = SListForAppMsg.Get('InventoryMaster_CustomAttributesMaster_aspx_EnterContent');
                     var errorMsg = SListForAppMsg.Get('InventoryKit_Error');
                     if (userMsg != null && errorMsg != null) {
                         ValidationWindow(userMsg, errorMsg);
                     }
                     else {
                         ValidationWindow("Enter Content Length", "Error");
                     }
                    // alert('Enter Content Length');
                     document.getElementById('txtLength').focus();
                     return false;
                 }


             }

             fnShowProgress();
             return true;
         }



    </script>
</head>
<body>
    <form id="prFrm" runat="server">
      <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
                        <table class="w-100p marginT2">
                            <tr>
                                <td class="w-40p v-top" id="DivType">
                                    <div id="divType">
                                        <asp:Panel ID="pnlType" CssClass="w-100p bold" runat="server" 
                                            GroupingText="ControlType" meta:resourcekey="pnlTypeResource1">
                                            <div class="w-100p" id="divPanel" runat="server">
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </td>
                                <td class="v-top">
                            
                                    <img alt="" onclick="ShowType();ShowhideType();" src="../Images/hide_old.png" id="ShowTypeid"
                                        class="pointer" />
                                    <div id="divAttribute">
                                        <asp:Panel ID="pnlAttribute" runat="server" CssClass=" bold" 
                                            GroupingText="Custom Attributes" meta:resourcekey="pnlAttributeResource1">
                                            <table class="w-90p marginT5">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblType" runat="server" Text="Control Type" 
                                                            meta:resourcekey="lblTypeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblControlType" runat="server" 
                                                            meta:resourcekey="lblControlTypeResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlControlType" CssClass="ddl hide w-155"
                                                            runat="server" onchange="CheckControlType();" 
                                                            meta:resourcekey="ddlControlTypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblName" runat="server" Text="Name" 
                                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" runat="server" CssClass="small" ID="txtAttributeName" 
                                                            meta:resourcekey="txtAttributeNameResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDataType" runat="server" Text="Data Type" 
                                                            meta:resourcekey="lblDataTypeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlDataType" CssClass="small" runat="server" 
                                                            onchange="DataTypeChange();" meta:resourcekey="ddlDataTypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trLength" class="hide" runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblLength" runat="server" Text="Length" meta:resourcekey="lblLengthResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" runat="server" ID="txtLength" CssClass="small" onKeyDown="return  isNumeric(event,this.id)"></asp:TextBox>
                                                    </td>
                                                    <td colspan="3">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDisplayText" runat="server" Text="DisplayText" 
                                                            meta:resourcekey="lblDisplayTextResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" runat="server" CssClass="small" ID="txtDisplayText" 
                                                            meta:resourcekey="txtDisplayTextResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblchkAttribute" runat="server" Text="Is Active" 
                                                            meta:resourcekey="lblchkAttributeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkAttributeStatus" runat="server" 
                                                            meta:resourcekey="chkAttributeStatusResource1" />
                                                        &nbsp;&nbsp;
                                                        <asp:CheckBox ID="chkIsPredefinedAttributes" runat="server" 
                                                            Text="IsPredefinedAttribute" CssClass="hide" 
                                                            meta:resourcekey="chkIsPredefinedAttributesResource1"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" class="a-center">
                                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save"
                                                            CssClass="btn" OnClientClick="javascript:return checkIsEmpty();" 
                                                            meta:resourcekey="btnSaveResource1" />
                                                        <asp:Button ID="btnCancel" OnClientClick="javascript:return cleardata();" runat="server"
                                                            Text="Clear" CssClass="cancel-btn" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Table ID="tblAttributeValues" CssClass="w-100p border1 hide" 
                                        runat="server" meta:resourcekey="tblAttributeValuesResource1">
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-100p marginT5" colspan="2">
                                    <asp:UpdatePanel ID="UpdatePane" runat="server">
                                        <contenttemplate>
                                            <table id="tblCategoryGrid" runat="server" class="w-100p">
                                                <tr id="Tr1" runat="server">
                                                    <td id="Td1" runat="server">
                                                        <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                                             AllowPaging="True" OnPageIndexChanging="gvCategory_PageIndexChanging"
                                                             PageSize="10" 
                                                            onrowdatabound="gvCategory_RowDataBound">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Select">
                                                                    <ItemTemplate>
                                                                    
                                                                        <input id="rdSel" name="radio" value='<%#Eval("Description") %>' onclick="SetAttributeValues(this)"
                                                                            type="radio" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="AttributeName">
                                                                    <%--   <HeaderTemplate>
                                                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCategoryNameWiseSearch" runat="server" Width="200px"></asp:TextBox>
                                                                    <asp:Button ID="btn1" runat="server" Text="GO" CommandName="Search1" />
                                                                </HeaderTemplate>--%>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblname" Text='<%#Eval("AttributeName") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="ControlName" HeaderText="ControlType">
                                                                    <ItemStyle Width="15%" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DataType" HeaderText="DataType">
                                                                    <ItemStyle Width="15%" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ControlLength" HeaderText="Length">
                                                                    <ItemStyle HorizontalAlign="Right" Width="10%" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DisplayText" HeaderText="Displaytext">
                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:BoundField>
                                                                <%--<asp:BoundField DataField="AttributeStatus" HeaderText="IsActive" >
                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:BoundField>--%>
                                                                <asp:TemplateField HeaderText="IsActive">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblActive" Text='<%#Eval("AttributeStatus") %>' runat="server" CssClass="hide"></asp:Label>
                                                                    <asp:Image ImageUrl="../PlatForm/Images/Checkin.png" ToolTip="Active" ID="ImgActive" runat="server"
                                                                        CssClass="hide" />
                                                                    <asp:Image ImageUrl="../PlatForm/Images/Delete7.jpg" ToolTip="De-Active" ID="ImgDeActive"
                                                                        runat="server" CssClass="hide" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" Width="1%" />
                                                            </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                            <HeaderStyle CssClass="gridHeader" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </contenttemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="hdnAttributeList" runat="server" />
                        <input type="hidden" id="hdnUserLoginId" runat="server" value="0" />
                        <input type="hidden" id="hdnAttributeID" runat="server" value="0" />
                        <asp:HiddenField ID="hdnControlTypeID" runat="server" Value="0" />
                        <input type="hidden" id="hdnControlName" runat="server" value="0" />
                        <input type="hidden" id="hdnMappingID" runat="server" value="0" />
                        <input type="hidden" id="hdnStatus" runat="server" />
                        <input type="hidden" id="Hidden4" runat="server" value="0" />
                        <input type="hidden" id="Hidden5" runat="server" value="0" />
                        <input type="hidden" id="Hidden6" runat="server" value="0" />
                        <input type="hidden" id="Hidden7" runat="server" value="0" />
                        <input type="hidden" id="hdnDataType" runat="server" value="" />
                    </div>
                
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnvalue" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>


<script type="text/javascript">
    function SetControlType(ele) {
        var Update = SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_03') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_CustomAttributesMaster_aspx_03');
        //  debugger;
        //$('#divPanel').css('height', '150px');
        var id = $(ele).attr('id');
        $('#lblControlType').html($(ele).html());
        document.getElementById('hdnControlTypeID').value = id;
        var Control = $(ele).html();
        document.getElementById('ddlControlType').value = id;
        if (Control == "CheckBox") {
            document.getElementById('ddlDataType').value = "Boolean";
            document.getElementById('ddlDataType').disabled = true;
            //document.getElementById('trLength').style.display = 'none';
            $('#trLength').removeClass().addClass('hide');
            document.getElementById('txtLength').value = '0';
        }
        else if (Control == "dropdownlist" || Control == "DropDown") {
            document.getElementById('ddlDataType').value = "String";
            // document.getElementById('ddlDataType').options[document.getElementById('ddlDataType').selectedIndex].text = "String";
            //document.getElementById('trLength').style.display = 'none';
            $('#trLength').removeClass().addClass('hide');
            document.getElementById('txtLength').value = '0';
        }
        else {
            document.getElementById('ddlDataType').disabled = false;
            document.getElementById('ddlDataType').value = "String";
            // document.getElementById('ddlDataType').options[document.getElementById('ddlDataType').selectedIndex].text = "Boolean";
            if (document.getElementById('ddlDataType').value == "String" && Control == "TextBox") {
                //$('#divPanel').css('height', '170px');
                //document.getElementById('trLength').style.display = 'table-row';
                $('#trLength').removeClass().addClass('displaytr');
                document.getElementById('txtLength').value = '0';

            }
            else {

                //document.getElementById('trLength').style.display = 'none';
                $('#trLength').removeClass().addClass('hide');
                document.getElementById('txtLength').value = '0';
            }
        }
        //document.getElementById('ddlControlType').style.display = 'none';
        $('#ddlControlType').removeClass().addClass('hide');
        if (document.getElementById('hdnStatus').value == Update) {
            //document.getElementById('lblControlType').style.display = 'block';
            $('#lblControlType').removeClass().addClass('show');

        }

        ShowType();
    }
</script>

</body>
</html>

