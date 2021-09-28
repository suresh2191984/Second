<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServiceResourceUtilizationMaster.aspx.cs"
    Inherits="Admin_ServiceResourceUtilizationMaster" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Service Resource Utilization Master </title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script type="text/javascript">
        function setResourceType() {
            var ResourceType = document.getElementById('ddlResourceType').value;
            var OrgID = '<%= OrgID %>';
            var sval = OrgID + '~' + ResourceType;
            $find('AutoResourceName').set_contextKey(sval);
        }
        function setServiceName() {
            var ResourceType = document.getElementById('ddlServiceType').value;
            var OrgID = '<%= OrgID %>';
            var sval = OrgID + '~' + ResourceType;
            $find('AutoServiceName').set_contextKey(sval);
        }
        function IAmResourceName(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            var list = eventArgs.get_value().split('/');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('<%=hdnResourceID.ClientID %>').value = ID;
                        document.getElementById('<%=hdnResourceName.ClientID %>').value = list[1];
                        document.getElementById('<%=txtResourceName.ClientID %>').value = list[1];



                    }
                }
            }

        }
        function IAmSelected(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var list = eventArgs.get_value().split('/');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('<%=hdnID.ClientID %>').value = ID;
                        document.getElementById('<%=hdnName.ClientID %>').value = list[1];
                        document.getElementById('<%=txtServiceName.ClientID %>').value = list[1];

                        document.getElementById('tableContent').style.display = 'block';

                    }
                }
            }
        }

        function boxExpand(me) {
            // alert(me);
            boxValue = me.value.length;
            // alert(boxValue);
            boxSize = me.size;
            minNum = 20;
            maxNum = 500;


            if (boxValue > minNum) {
                me.size = boxValue
            }
            else
                if (boxValue < minNum || boxValue != minNnum) {
                me.size = minNum
            }
        }



        function extractRow(src, cID) {
            var eRow = src.parentElement.parentElement;
            var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("GVService");
            document.getElementById('hdnID').value = cID;
            document.getElementById('txtServiceName').value = CasTbl.rows[RI].cells[2].innerHTML;
            // document.getElementById('ddlServiceType').selectedItem.text = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].innerText = CasTbl.rows[RI].cells[1].innerHTML;
            // document.getElementById('ddlServiceType.selectedItem.Text').value = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].innerText = CasTbl.rows[RI].cells[3].innerHTML;
            document.getElementById('txtResourceName').value = CasTbl.rows[RI].cells[4].innerHTML;
            document.getElementById('txtQty').value = CasTbl.rows[RI].cells[5].innerHTML;
            document.getElementById('ddlUOM').value = CasTbl.rows[RI].cells[6].innerHTML;
            var Duration = CasTbl.rows[RI].cells[7].innerHTML.split('~');
            document.getElementById('txtestimatedDuration').value = Duration[0];
            document.getElementById('ddlduration').options[document.getElementById('ddlduration').selectedIndex].innerText = Duration[1];
            document.getElementById('chkRecurrentUsage').value = CasTbl.rows[RI].cells[8].innerHTML;
            document.getElementById('<%=btnSave.ClientID %>').value = "Update";


        }


        function fnclear() {

            document.getElementById('hdnID').value = "";
            //            document.getElementById('txtServiceName').value = "";
            //            document.getElementById('ddlServiceType').selectedIndex = 0;
            // document.getElementById('ddlServiceType.selectedItem.Text').value = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('ddlResourceType').selectedIndex = 0;
            document.getElementById('txtResourceName').value = "";
            document.getElementById('txtQty').value = "";
            document.getElementById('ddlUOM').selectedIndex = 0;
            document.getElementById('txtestimatedDuration').value = "";
            document.getElementById('ddlduration').selectedIndex = 0;
            document.getElementById('chkRecurrentUsage').value = "";
        }

        function validationes() {

            var ResourceType = document.getElementById('ddlResourceType').value;


            if (document.getElementById('txtServiceName').value == '') {
                alert('Enter Service Name');
                document.getElementById('txtServiceName').focus();
                return false;
            }
            if (document.getElementById('txtResourceName').value == '') {
                alert('Enter resource Name');
                document.getElementById('txtResourceName').focus();
                return false;
            }

            if (ResourceType != 'ROM') {


                if (document.getElementById('txtQty').value == '') {
                    alert('enter  quantity');
                    document.getElementById('txtQty').focus();
                    return false;
                }
            }
            if (document.getElementById('txtestimatedDuration').value == "0") {
                alert('Select the Estimated Duration');
                document.getElementById('txtestimatedDuration').focus();
                return false;
            }
            //            if (document.getElementById('txtBquantity').value == '') {
            //                alert('enter Buffer quantity');
            //                document.getElementById('txteBquantity').focus();
            //                return false;
            //            }

            //            if (document.getElementById('bUnits').value == "0") {
            //                alert('Select the Buufer quantity');
            //                document.getElementById('bUnits').focus();
            //                return false;
            //            }

        }

        function createClienttab() {
        
            validationes();

            var ServiceNameID;
            var ServiceType = document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].innerText;
            var servicename = document.getElementById('txtServiceName').value;
            var ResourceType = document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].innerText

            var ResourceName = document.getElementById('txtResourceName').value;

            var quantity = document.getElementById('txtQty').value == "" ? "0" : document.getElementById('<%= txtQty.ClientID %>').value;
            var units = document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].innerText == "--Select--" ? "-" : document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].innerText;
            var duration = document.getElementById('txtestimatedDuration').value;
            var duration1 = document.getElementById('ddlduration').options[document.getElementById('ddlduration').selectedIndex].innerText;
            ServiceNameID = document.getElementById('<%=hdnID.ClientID %>').value == "" ? 0 : document.getElementById('<%=hdnID.ClientID %>').value;
            var ServiceFeeType = document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].value;
            var ResourceFeeType = document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].value;
            var ResourceID = document.getElementById('<%=hdnResourceID.ClientID %>').value;
            var RecurrentUsage;
            if (document.getElementById('<%=chkRecurrentUsage.ClientID %>').checked = true) {
                RecurrentUsage = 'Y';
            }
            else {
                RecurrentUsage = 'N';

            }

            //To check Duplicate validation & Add op
            var HidValue = document.getElementById('hdnServiceMapping').value;
            var AddStatus = 0;
            var list = HidValue.split('^');
            if (document.getElementById('hdnServiceMapping').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ServiceList = list[count].split('~');
                    if (ServiceList != '') {
                        if (servicename != '') {
                            //                            device + "~" + InvName + "~" + ProductName + "~" + Equantity + "~" + eunits + "~" + Bquantity + "~" + bunits + "~" + Productid + "~" + Invid + "~" + ParentProductid + "~" + DeviceID + "~" + DeviceMappingID
                            //  if (ProductList[0] == device && ProductList[1] == InvName && ProductList[2] == ProductName && ProductList[3] == Equantity && ProductList[4] == eunits && ProductList[5] == Bquantity && ProductList[6] == bunits && ProductList[7] == bunits && ProductList[8] == Invid && ProductList[9] == ParentProductid && ProductList[10] == DeviceID && ProductList[11] == DeviceMappingID) {//Product name , Investigationid,Device
                            if (ServiceList[1] == servicename) {

                                ServiceNameID = ServiceList[8];
                          
//                                AddStatus = 1;
                            }
                        }

                    }
                }
            }
            if (AddStatus == 1) {
                alert('Service already exist');
                //                alert("Repeated Values Check the Table List");
                fnclear();
                document.getElementById('txtServiceName').focus();
                return false;
            }
            //End For Duplicate Validation




            if (document.getElementById('add').value == 'Update') {
                Deleterows();

               // document.getElementById('hdnServiceMapping').value += ServiceType + "~" + servicename + "~" + ResourceType + "~" + ResourceName + "~" + quantity + "~" + units + "~" + duration + "~" + duration1 + "~" + ServiceNameID + "~" + ServiceFeeType + "~" + ResourceFeeType + "~" + RecurrentUsage + "~" + ResourceID + "^";
                
                
            }
            else {


                document.getElementById('hdnServiceMapping').value += ServiceType + "~" + servicename + "~" + ResourceType + "~" + ResourceName + "~" + quantity + "~" + units + "~" + duration + "~" + duration1 + "~" + ServiceNameID + "~" + ServiceFeeType + "~" + ResourceFeeType + "~"+ RecurrentUsage+ "~" + ResourceID + "^";
                Tblist();
            }
            fnclear();
        }
        function Tblist() {
            while (count = document.getElementById('tblServiceMap').rows.length) {
                for (var j = 0; j < document.getElementById('tblServiceMap').rows.length; j++) {
                    document.getElementById('tblServiceMap').deleteRow(j);
                }
            }


            var x = document.getElementById('hdnServiceMapping').value.split("^");
            //            document.getElementById('hdnSaveTable').value = document.getElementById('hdnSetListTable').value;

            for (i = 0; i < x.length; i++) {
                m = document.getElementById('hdnUnServices').value.split("^");
                if (x[i] != "") {
                    y = x[i].split('~');
                    // document.getElementById('txtProductName').focus();
                    BindUniqueServices(y[0]);

                }
            }
            ChildGridList();
            if (document.getElementById('hdnServiceMapping').value != "") {
                document.getElementById('btnSaveID').style.display = 'block';
            }
        }


        function BindUniqueServices(objVal) {
            document.getElementById('hdnUnServices').value = objVal + "^";
            for (k = 0; k < m.length; k++) {
                if (m[k].trim() != "" && m[k].trim() != objVal) {
                    document.getElementById('hdnUnServices').value += m[k] + "^";
                }
            }
        }


        function ChildGridList() {

            var pParentServiceIDs = document.getElementById('hdnUnServices').value.split("^");
            var pServiceID = document.getElementById('<%=hdnID.ClientID %>').value == "" ? 0 : document.getElementById('<%=hdnID.ClientID %>').value;
            var pList = document.getElementById('hdnServiceMapping').value.split("^");



            var Headrow = document.getElementById('tblServiceMap').insertRow(0);

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
            var cell9 = Headrow.insertCell(9);
            cell11.innerHTML = "S.No.";
            cell1.innerHTML = "Service Type";
            cell2.innerHTML = "Service Name";
            cell3.innerHTML = "Resource Type";
            cell4.innerHTML = "Resource Name";
            cell5.innerHTML = "Qty";
            cell6.innerHTML = "Unit";
            cell7.innerHTML = "Estimated Duration";
            cell8.innerHTML = "Recurrent Usage";
            cell9.innerHTML = "Select";
            var isChild = false;
            var pCount = pParentServiceIDs.length - 1;
            for (j = 0; j < pParentServiceIDs.length; j++) {
                if (pParentServiceIDs[j] != "") {
                    var row = document.getElementById('tblServiceMap').insertRow(1);
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
                    var cell9 = row.insertCell(9);

                    isChild = false;

                    for (s = 0; s < pList.length; s++) {
                        if (pList[s] != "") {
                            y = pList[s].split('~');
                            if (pParentServiceIDs[j] == y[0]) {
                                cell11.innerHTML = pCount;
                                if (isChild == false) {
                                    cell1.innerHTML = y[0];
                                    cell2.innerHTML = y[1];
                                    cell3.innerHTML = y[2];
                                    cell4.innerHTML = y[3];
                                    cell5.innerHTML = y[4];
                                    cell6.innerHTML = y[5];
                                    cell7.innerHTML = y[6]+" "+y[7];
                                    cell8.innerHTML =  y[11];

                                    cell9.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
                                    isChild = true;
                                }
                                else {
                                    var Chrow = document.getElementById('tblServiceMap').insertRow(2);
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
                                    var chcell8 = Chrow.insertCell(9);


                                    chcell1.innerHTML = y[1];
                                    chcell2.innerHTML = y[2];
                                    chcell3.innerHTML = y[3];
                                    chcell4.innerHTML = y[4];
                                    chcell5.innerHTML = y[5];
                                    chcell6.innerHTML = y[6] + " " + y[7];
                                    chcell7.innerHTML = y[11];

                                    chcell8.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";

                                }

                            }
                        }
                    }
                    pCount--;
                }
            }
        }
        function btnEdit_OnClick(sEditedData) {
            document.getElementById('tableContent').style.display = 'block';
            var y = sEditedData.split('~');
            document.getElementById('hdnRowEdit').value = sEditedData;

            //Interventional~Artificial Urinary Sphincter Removal~Asset~assset~2~Nos~2~Day(S)~379~undefined~undefined~undefined
            document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].innerText = y[0];
            document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].innerText = y[2];
            document.getElementById('txtServiceName').value = y[1];
            document.getElementById('txtResourceName').value = y[3];

            document.getElementById('txtQty').value = y[4];
            document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].innerText = y[5];

            document.getElementById('txtestimatedDuration').value = y[6];
            document.getElementById('ddlduration').options[document.getElementById('ddlduration').selectedIndex].innerText = y[7];
            var chkvalue = y[11];
            if (chkvalue == 'Y') {
                document.getElementById('<%=chkRecurrentUsage.ClientID %>').checked = true;
            }
            else {
                document.getElementById('<%=chkRecurrentUsage.ClientID %>').checked = false;
            }
            document.getElementById('add').value = 'Update';

            var list = document.getElementById('hdnServiceMapping').value.split("^");
            document.getElementById('hdnServiceMapping').value = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    if (list[i] != sEditedData) {
                        document.getElementById('hdnServiceMapping').value += list[i] + "^";
                    }
                }
            }
            Tblist();
        }

        function Deleterows() {

            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnServiceMapping').value.split("^");
            if (RowEdit != "") {

                var ServiceType = document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].innerText
                var servicename = document.getElementById('txtServiceName').value;
                var ResourceType = document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].innerText
                var ResourceName = document.getElementById('txtResourceName').value;
                var quantity = document.getElementById('txtQty').value;
                var units = document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].innerText;
                var duration = document.getElementById('txtestimatedDuration').value;
                var duration1 = document.getElementById('ddlduration').options[document.getElementById('ddlduration').selectedIndex].innerText;
                var ServiceNameID = document.getElementById('<%=hdnID.ClientID %>').value == "" ? 0 : document.getElementById('<%=hdnID.ClientID %>').value;
                var RecurrentUsage;
                if (document.getElementById('<%=chkRecurrentUsage.ClientID %>').checked = true) {
                    RecurrentUsage = 'Y';
                }
                else {
                    RecurrentUsage = 'N';

                }

                var ServiceFeeType = document.getElementById('ddlServiceType').options[document.getElementById('ddlServiceType').selectedIndex].value;
                var ResourceFeeType = document.getElementById('ddlResourceType').options[document.getElementById('ddlResourceType').selectedIndex].value;
                var ResourceID = document.getElementById('<%=hdnResourceID.ClientID %>').value;

                document.getElementById('hdnServiceMapping').value += ServiceType + "~" + servicename + "~" + ResourceType + "~" + ResourceName + "~" + quantity + "~" + units + "~" + duration + "~" + duration1 + "~" + ServiceNameID + "~" + ServiceFeeType + "~" + ResourceFeeType + "~" + RecurrentUsage + "~" + ResourceID + "^";
               // document.getElementById('hdnServiceMapping').value = ServiceType + "~" + servicename + "~" + ResourceType + "~" + ResourceName + "~" + quantity + "~" + units + "~" + duration + "~" + duration1 + "~" + ServiceNameID +'~'+ RecurrentUsage+ "^";
//                for (i = 0; i < x.length-1; i++) {
//                    if (x[i] != "") {
//                        if (x[i] != RowEdit) {
//                            document.getElementById('hdnServiceMapping').value += x[i] + "^";
//                        }
//                    }
//                }
                Tblist();


            }
        }

        function btnDelete(sEditedData) {
            var i;
            var x = document.getElementById('hdnServiceMapping').value.split("^");
            document.getElementById('hdnServiceMapping').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnServiceMapping').value += x[i] + "^";
                    }
                }
            }
            Tblist();
        }

        function ShowHide() {
            var ResourceType = document.getElementById('ddlResourceType').value;

            if (ResourceType == 'ROM') {
                // ddlUOM, txtQty, lblQty

                document.getElementById('ddlUOM').style.display = 'none';
                document.getElementById('txtQty').style.display = 'none';
                document.getElementById('lblQty').style.display = 'none';


            }
            else {
                document.getElementById('ddlUOM').style.display = 'block';
                document.getElementById('txtQty').style.display = 'block';
                document.getElementById('lblQty').style.display = 'block';
            }
        }
        
      
    </script>

    <style type="text/css">
        .style3
        {
            height: 33px;
        }
        .style5
        {
            height: 19px;
        }
        .style6
        {
            height: 29px;
        }
        .style7
        {
            width: 973px;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <%--     <img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <div class="contentdata1">
                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                        <table width="100%" class="defaultfontcolor" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                    <div id="DivSupplier" runat="server">
                                      <%--  <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblSearch" Text="Enter to Search" runat="server"></asp:Label>
                                                    <asp:TextBox ID="txtsearch" runat="server"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" Text="Search" runat="server" Width="62px" class="btn"
                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>--%>
                                        <table border="0" cellpadding="2" class="dataheader2 defaultfontcolor" cellspacing="1"
                                            width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblServiceType" Text="Service Type" runat="server" 
                                                        Font-Bold="True" meta:resourcekey="lblServiceTypeResource1" />
                                                    <asp:DropDownList ID="ddlServiceType" runat="server"  CssClass="ddlsmall"
                                                        Height="16px" meta:resourcekey="ddlServiceTypeResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblservicename" Text="Service Name" runat="server" TabIndex="1" 
                                                        Font-Bold="True" meta:resourcekey="lblservicenameResource1" />
                                                    <asp:TextBox ID="txtServiceName" onfocus="setServiceName();" runat="server"  CssClass ="Txtboxsmall"
                                                        TabIndex="2" meta:resourcekey="txtServiceNameResource1" />
                                                    <ajc:AutoCompleteExtender ID="AutoServiceName" runat="server" TargetControlID="txtServiceName"
                                                        ServiceMethod="getServiceNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                        OnClientItemSelected="IAmSelected" MinimumPrefixLength="2" CompletionInterval="30"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                                        Enabled="True" DelimiterCharacters="">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <input id="hdnserviceTypeID" runat="server" type="hidden" />
                                                    <input id="hdnServiceNameID" runat="server" type="hidden" value="0" />
                                                    <input id="hdnResourceTypeID" runat="server" type="hidden" value="0" />
                                                    <input id="hdnResourceNameID" runat="server" type="hidden" value="0" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tableContent" border="0" cellpadding="2" class="dataheader2 defaultfontcolor"
                                            cellspacing="1" width="100%" style="display: none">
                                            <tr>
                                                <td class="style5">
                                                    <asp:Label ID="lblResourceType" Text="Resource Type" runat="server" 
                                                        meta:resourcekey="lblResourceTypeResource1"></asp:Label>
                                                </td>
                                                <td class="style5">
                                                    <asp:DropDownList runat="server" Width="175px" ID="ddlResourceType" onchange="javascript:ShowHide();"
                                                        CssClass="ddl" meta:resourcekey="ddlResourceTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="style3">
                                                    <asp:Label ID="lblResourceNmae" Text="Resource Name" runat="server" 
                                                        meta:resourcekey="lblResourceNmaeResource1"></asp:Label>
                                                </td>
                                                <td class="style3">
                                                    <asp:TextBox ID="txtResourceName" onfocus="setResourceType();" runat="server" CssClass="Txtboxsmall"
                                                        Width="170px" meta:resourcekey="txtResourceNameResource1"></asp:TextBox>&nbsp;
                                                    <ajc:AutoCompleteExtender ID="AutoResourceName" runat="server" TargetControlID="txtResourceName"
                                                        ServiceMethod="getServiceNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                        OnClientItemSelected="IAmResourceName" MinimumPrefixLength="2" CompletionInterval="30"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" 
                                                        Enabled="True" DelimiterCharacters="">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style3">
                                                    <asp:Label ID="lblestimatedTime" Text="Estimated Duration" runat="server" 
                                                        meta:resourcekey="lblestimatedTimeResource1"></asp:Label>
                                                </td>
                                                <td class="style3">
                                                    <asp:TextBox ID="txtestimatedDuration" runat="server" Width="44px" 
                                                        CssClass="Txtboxsmall" meta:resourcekey="txtestimatedDurationResource1"></asp:TextBox>
                                                    <asp:DropDownList runat="server" ID="ddlduration" CssClass="ddl" 
                                                        meta:resourcekey="ddldurationResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="style3">
                                                    <asp:Label ID="lblQty" Text="Quantity" runat="server" Style="display: none" 
                                                        meta:resourcekey="lblQtyResource1"></asp:Label>
                                                </td>
                                                <td class="style3">
                                                    <asp:TextBox ID="txtQty" runat="server" CssClass="Txtboxsmall" Width="44px" 
                                                        Style="display: none" meta:resourcekey="txtQtyResource1"></asp:TextBox>
                                                    <asp:DropDownList runat="server" ID="ddlUOM" CssClass="ddl" 
                                                        Style="display: none" meta:resourcekey="ddlUOMResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkRecurrentUsage" Text="Recurrent Usage" runat="server" 
                                                        meta:resourcekey="chkRecurrentUsageResource1" />
                                                </td>
                                                <td>
                                                    <input id="hdnProductId" runat="server" type="hidden" />
                                                    <input id="hdnParentProductID" runat="server" type="hidden" />
                                                    <input id="hdnUnit" runat="server" type="hidden" />
                                                </td>
                                                <td>
                                                    <input id="add" class="btn" onclick="javascript:createClienttab();" tabindex="8"
                                                        type="button" value="Add" />
                                                </td>
                                            </tr>
                                        </table>
                                        <caption>
                                            <br />
                                            <table id="tblServiceMap" border="1" cellpadding="0" cellspacing="0" class="dataheaderInvCtrl"
                                                style="text-align: left; font-size: 10px;" width="100%">
                                            </table>
                                            <table border="0" cellpadding="2" cellspacing="2" class="defaultfontcolor" width="100%">
                                                <tr>
                                                    <td id="btnSaveID" align="center" align="right" class="style4" style="display: none">
                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" Height="26px" OnClick="btnSave_Click"
                                                            onmouseout="this.className='btn'" 
                                                            onmouseover="this.className='btn btnhov'" Text="Save"
                                                            Width="59px" meta:resourcekey="btnSaveResource1" />
                                                        <asp:HiddenField ID="hdnSaveTable" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <input id="hdnServiceMapping" runat="server" type="hidden" />
                                            <input id="hdnUnProducts" runat="server" type="hidden" value="" />
                                            <asp:HiddenField ID="hdnRowEdit" runat="server" />
                                        </caption>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <div id="divgv">
                                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                        CellPadding="0" DataKeyNames="ResourceServiceTypeName,ServiceName" ForeColor="#333333"
                                                        GridLines="None" Width="100%" OnRowDataBound="grdResult_RowDataBound"
                                                        OnPageIndexChanging="grdResult_PageIndexChanging" 
                                                        HeaderStyle-BorderWidth="0px" meta:resourcekey="grdResultResource1">
                                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                        cellspacing="0" border="1" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                                                <tr class="Duecolor">
                                                                                                    <td align="left" style="font-weight: bold;">
                                                                                                        <asp:Label ID="lblServiceType" Text='<%# DataBinder.Eval(Container.DataItem,"ResourceServiceTypeName") %>'
                                                                                                            runat="server" meta:resourcekey="lblServiceTypeResource2"></asp:Label>
                                                                                                        <br />
                                                                                                        <asp:Label ID="lblspcae" runat="server" Text="/" 
                                                                                                            meta:resourcekey="lblspcaeResource1"></asp:Label>
                                                                                                        <asp:Label ID="lblServiceName" Text='<%# DataBinder.Eval(Container.DataItem,"ServiceName") %>'
                                                                                                            runat="server" meta:resourcekey="lblServiceNameResource2"></asp:Label>
                                                                                                    </td>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                                PageSize="100" ForeColor="Black" OnRowDataBound="grdChildResult_RowDataBound"
                                                                                                Width="100%" meta:resourcekey="grdChildResultResource1">
                                                                                                <PagerTemplate>
                                                                                                    <tr>
                                                                                                        <td align="center" colspan="6">
                                                                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" 
                                                                                                                Width="18px" meta:resourcekey="lnkPrevResource1" />
                                                                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" 
                                                                                                                Width="18px" meta:resourcekey="lnkNextResource1" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </PagerTemplate>
                                                                                                <HeaderStyle Font-Underline="True" />
                                                                                                <RowStyle Font-Bold="False" />
                                                                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="ResourceType" HeaderText="Resource Type" 
                                                                                                        meta:resourcekey="BoundFieldResource1" />
                                                                                                    <asp:BoundField DataField="ResourceName" HeaderText="Resource Name" 
                                                                                                        meta:resourcekey="BoundFieldResource2" />
                                                                                                    <asp:BoundField DataField="EstimatedQty" HeaderText="Quantity" 
                                                                                                        meta:resourcekey="BoundFieldResource3" />
                                                                                                    <asp:BoundField DataField="EstimatedUnit" HeaderText="Unit" 
                                                                                                        meta:resourcekey="BoundFieldResource4" />
                                                                                                    <asp:BoundField DataField="EstimatedDuration" HeaderText="Duration" 
                                                                                                        meta:resourcekey="BoundFieldResource5" />
                                                                                                    <asp:BoundField DataField="RecurrentUsage" HeaderText="Recurrent Usage" 
                                                                                                        meta:resourcekey="BoundFieldResource6" />
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                                    </asp:GridView>
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
    </div>
    <asp:HiddenField ID="hdnID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnName" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTypeID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnUnServices" runat="server" />
    <asp:HiddenField ID="hdnResourceID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnResourceName" runat="server" />
    </form>
</body>
</html>
