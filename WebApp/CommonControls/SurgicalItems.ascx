<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgicalItems.ascx.cs"
    Inherits="CommonControls_SurgicalItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<asp:Panel ID="pnlSurgicalItems" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlSurgicalItemsResource1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                <div id="ACX2plusSur" style="display: none;">
                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusSur','ACX2minusSur','ACX2responsesSur',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusSur','ACX2minusSur','ACX2responsesSur',1);">
                        &nbsp;<asp:Label ID="Rs_SurgicalItems1" runat="server" Text="Surgical Items" meta:resourcekey="Rs_SurgicalItems1Resource1"></asp:Label></span>
                </div>
                <div id="ACX2minusSur" style="display: block;">
                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusSur','ACX2minusSur','ACX2responsesSur',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusSur','ACX2minusSur','ACX2responsesSur',0);">
                        &nbsp;<asp:Label ID="Rs_SurgicalItems2" runat="server" Text="Surgical Items" meta:resourcekey="Rs_SurgicalItems2Resource1"></asp:Label>
                </div>
            </td>
            <td style="width: 75%" height="23" align="left">
                &nbsp;
            </td>
        </tr>
        <tr class="tablerow" id="ACX2responsesSur" style="display: block;">
            <td colspan="2">
                <div class="filterdatahe">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="tabletxt">
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Item" runat="server" Text="Item" meta:resourcekey="Rs_ItemResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Nos" runat="server" Text="Nos." meta:resourcekey="Rs_NosResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Comments" runat="server" Text="Comments" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:TextBox ID="txtOthersItems" Style="width: 110px;" runat="server" CssClass="Txtboxsmall"  meta:resourcekey="txtOthersItemsResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox ID="txtQuantity" runat="server"  CssClass="Txtboxsmall" autocomplete="off" Style="width: 80px"
                                    Text="1" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tComments" CssClass="Txtboxsmall" Style="width: 120px" autocomplete="off"
                                    meta:resourcekey="tCommentsResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <input id="txtFromDate" runat="server" readonly="readonly" CssClass="Txtboxsmall"  width="137px" type="text" />
                                &nbsp;&nbsp; <a href="javascript:NewCal('','ddmmyyyy',true,12)">
                                    <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                        width="16"></img></a>
                            </td>
                            <td nowrap="nowrap">
                                <input id="txtToDate" runat="server" readonly="readonly" CssClass="Txtboxsmall"  width="137px" type="text" />
                                <a href="javascript:NewCal('','ddmmyyyy',true,12)">
                                    <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                        width="16"></img></a>
                                <input id="aMedNew" class="btn" onclick="MedControlValidation();return false;" onmouseout="this.className='btn'"
                                    onmouseover="this.className='btn btnhov'" tooltip="Add New Drug" type="button"
                                    value="Add" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 15px" align="center" nowrap="nowrap">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <div id="dvTableIndent" runat="server">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Panel>
<input type="hidden" id="did" runat="server" />
<asp:HiddenField ID="hdfMedItems" runat="server" />
<asp:HiddenField ID="hdfMedExists" runat="server" />
<asp:HiddenField ID="hdfMedDelete" runat="server" />

<script type="text/javascript" language="javascript">

    function PMedValidation() {

        if (document.getElementById('<%= txtOthersItems.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgicalItems.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Please enter Items');
            }
            document.getElementById('<%= txtOthersItems.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%= txtQuantity.ClientID %>').value == '') {
            document.getElementById('<%= txtQuantity.ClientID %>').value = 1;
            return true;
        }

        var MedCode = "";
        var MedItem = "";

        MedCode = "-1";
        MedItem = document.getElementById('<%= txtOthersItems.ClientID %>').value;

        var MedQuantity = document.getElementById('<%= txtQuantity.ClientID %>').value;
        var MedComments = document.getElementById('<%= tComments.ClientID %>').value;
        var MedFromDate = document.getElementById('<%= txtFromDate.ClientID  %>').value;
        var MedToDate = document.getElementById('<%= txtToDate.ClientID  %>').value;
        var MedRetval = MedItem + "~" + MedQuantity + "~" + MedComments + "~" + MedFromDate + "~" + MedToDate + "~" + MedCode;
        return MedRetval;
    }


    function MedControlValidation() {
        var MedRetval = PMedValidation();
        if (MedRetval != false) {
            CmdAddMed_OnClick(MedRetval);
        }
    }

    function CmdAddMed_OnClick(gotValue) {
        var ViewStateMedValue = document.getElementById('<%= hdfMedItems.ClientID %>').value;


        var arrayMedValue = new Array();
        arrayMedValue = gotValue.split('~');
        var MedItemName, MedItemUnit, MedDescription, MedFromDate, MedToDate, MedItemCode;

        if (arrayMedValue.length > 0) {
            MedItemName = arrayMedValue[0];
            MedItemUnit = arrayMedValue[1];
            MedDescription = arrayMedValue[2];
            MedFromDate = arrayMedValue[3];
            MedToDate = arrayMedValue[4];
            MedItemCode = arrayMedValue[5];
        }
        var MedAlreadyPresentDatas = new Array();
        var iMedAlrPresent = 0;
        var iMedCnt = 0;

        var tempMedDatas = document.getElementById('<%= hdfMedExists.ClientID %>').value;

        MedAlreadyPresentDatas = tempMedDatas.split('|');
        if (MedAlreadyPresentDatas.length > 0) {
            for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
                if (MedAlreadyPresentDatas[iMedCnt].toLowerCase() == (MedItemName.toLowerCase() + "-" + MedItemUnit.toLowerCase())) {
                    iMedAlrPresent++;
                }
            }
        }
        if (iMedAlrPresent == 0) {
            tempMedDatas += MedItemName + "-" + MedItemUnit + "|";
            document.getElementById('<%= hdfMedExists.ClientID %>').value = tempMedDatas;
            ViewStateMedValue += "RID^" + 0 + "~MEDName^" + MedItemName + "~MEDUnit^" + MedItemUnit + "~MEDDesc^" + MedDescription + "~MEDFrom^" + MedFromDate + "~MEDTo^" + MedToDate + "~MEDCode^" + MedItemCode + "|";
            // newMedTable += CreateMedTables(MedItemName, MedItemUnit, MedDescription, MedFromDate, MedToDate, Duration);
            document.getElementById('<%= hdfMedItems.ClientID %>').value = ViewStateMedValue;
            CreateMedTables();
            MedControlclear();

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgicalItems.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Item Name already exists");
            }
        }

    }

    function CreateMedTables() {
        document.getElementById('<%= dvTableIndent.ClientID %>').innerHTML = "";
        var newMedTable, startMedTag, endMedTag, MedItemCode;
        var ViewStateMedValue = document.getElementById('<%= hdfMedItems.ClientID %>').value;

        startMedTag = "<TABLE ID='tabMed1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td >"+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_Select %>"+" </td><td style='width:120px;'  > "+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_ItemName %>"+" </td><td style='width:80px;' >"+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_Units %>"+" </td> <td style='width:120px;'  > "+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_Comments %>"+"</td> <td style='width:80px;'  > "+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_FromDate %>"+" </td><td > "+"<%=Resources .ClientSideDisplayTexts.CommonControls_SurgicalItems_ToDate %>"+"</td><td></td> </tr>";
        endMedTag = "</TBODY></TABLE>";
        newMedTable = startMedTag;

        var arraymMainData = new Array();
        var arraymSubData = new Array();
        var arraymChildData = new Array();
        var iarrayMDataCount = 0;
        var iarraySDataCount = 0;

        arraymMainData = ViewStateMedValue.split('|');
        if (arraymMainData.length > 0) {
            for (iarrayMDataCount = 0; iarrayMDataCount < arraymMainData.length - 1; iarrayMDataCount++) {

                arraymSubData = arraymMainData[iarrayMDataCount].split('~');
                for (iarraySDataCount = 0; iarraySDataCount < arraymSubData.length; iarraySDataCount++) {
                    arraymChildData = arraymSubData[iarraySDataCount].split('^');
                    if (arraymChildData.length > 0) {
                        if (arraymChildData[0] == "MEDName") {
                            MedItemName = arraymChildData[1];
                        }
                        if (arraymChildData[0] == "MEDUnit") {
                            MedItemUnit = arraymChildData[1];
                        }
                        if (arraymChildData[0] == "MEDDesc") {
                            MedDescription = arraymChildData[1];
                        }
                        if (arraymChildData[0] == "MEDFrom") {
                            MedFromDate = arraymChildData[1];
                        }
                        if (arraymChildData[0] == "MEDTo") {
                            MedToDate = arraymChildData[1];
                        }
                        if (arraymChildData[0] == "MEDCode") {
                            MedItemCode = arraymChildData[1];
                        }
                    }
                }
                var chkBoxName = "RID^" + 0 + "~MEDName^" + MedItemName + "~MEDUnit^" + MedItemUnit + "~MEDDesc^" + MedDescription + "~MEDFrom^" + MedFromDate + "~MEDTo^" + MedToDate + "~MEDCode^" + MedItemCode + "";
                var ReturnYesOrNo = DeletedValueCheckIND(chkBoxName);
                if (ReturnYesOrNo == "Yes") {
                    newMedTable += "<TR><TD><input name='RID^" + 0 + "~MEDName^" + MedItemName + "~MEDUnit^" + MedItemUnit + "~MEDDesc^" + MedDescription + "~MEDFrom^" + MedFromDate + "~MEDTo^" + MedToDate + "~MEDCode^" + MedItemCode + "' onclick='chkUnCheckMED(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" >" + MedItemName + "</TD>";
                }
                else {
                    newMedTable += "<TR><TD><input name='RID^" + 0 + "~MEDName^" + MedItemName + "~MEDUnit^" + MedItemUnit + "~MEDDesc^" + MedDescription + "~MEDFrom^" + MedFromDate + "~MEDTo^" + MedToDate + "~MEDCode^" + MedItemCode + "' onclick='chkUnCheckMED(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px\" >" + MedItemName + "</TD>";
                }
                newMedTable += "<TD style=\"WIDTH: 80px\" >" + MedItemUnit + "</TD>";
                newMedTable += "<TD style=\"WIDTH: 120px\" >" + MedDescription + "</TD>";
                newMedTable += "<TD style=\"WIDTH: 150px\" >" + MedFromDate + "</TD>";
                newMedTable += "<TD style=\"WIDTH: 150px\" nowrap='nowrap'>" + MedToDate + "</TD>";

                newMedTable += "<TD><input name='RID^" + 0 + "~MEDName^" + MedItemName + "~MEDUnit^" + MedItemUnit + "~MEDDesc^" + MedDescription + "~MEDFrom^" + MedFromDate + "~MEDTo^" + MedToDate + "~MEDCode^" + MedItemCode + "' onclick='MED_btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
            }
        }

        newMedTable += endMedTag;
        //Update the Previous Table With New Table.
        document.getElementById('<%= dvTableIndent.ClientID %>').innerHTML += newMedTable;

    }
    function chkUnCheckMED(DataValue) {
        //        document.getElementById('<%= hdfMedDelete.ClientID %>').value = DataValue;

        var MedAlreadyPresentDatas = new Array();
        var iMedAlrPresent = 0;
        var iMedCnt = 0;

        var tempMedDatas = document.getElementById('<%= hdfMedDelete.ClientID %>').value;
        var boolAlreadyPresent = false;
        MedAlreadyPresentDatas = tempMedDatas.split('|');
        if (MedAlreadyPresentDatas.length > 0) {
            for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
                if (MedAlreadyPresentDatas[iMedCnt].toLowerCase() == DataValue.toLowerCase()) {
                    MedAlreadyPresentDatas[iMedCnt] = "";
                    boolAlreadyPresent = true;
                }
            }
        }

        tempMedDatas = "";
        for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
            if (MedAlreadyPresentDatas[iMedCnt] != "") {
                tempMedDatas += MedAlreadyPresentDatas[iMedCnt] + "|";
            }
        }
        if (boolAlreadyPresent == false) {
            tempMedDatas += DataValue + "|";
        }
        document.getElementById('<%= hdfMedDelete.ClientID %>').value = tempMedDatas;

    }

    function DeletedValueCheckIND(DataValue) {
        var MedAlreadyPresentDatas = new Array();
        var iMedAlrPresent = 0;
        var iMedCnt = 0;
        var tempMedDatas = document.getElementById('<%= hdfMedDelete.ClientID %>').value;
        var retValueAlreadyPresent = "No";

        MedAlreadyPresentDatas = tempMedDatas.split('|');
        if (MedAlreadyPresentDatas.length > 0) {
            for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
                if (MedAlreadyPresentDatas[iMedCnt].toLowerCase() == DataValue.toLowerCase()) {
                    retValueAlreadyPresent = "Yes";
                }
            }
        }
        return retValueAlreadyPresent;
    }

    function MED_btnEdit_OnClick(sEditedData) {

        var MedAlreadyPresentDatas = new Array();
        var iMedAlrPresent = 0;
        var iMedCnt = 0;
        alert(sEditedData);

        var tempMedDatas = document.getElementById('<%= hdfMedItems.ClientID %>').value;
        MedAlreadyPresentDatas = tempMedDatas.split('|');
        if (MedAlreadyPresentDatas.length > 0) {
            for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
                if (MedAlreadyPresentDatas[iMedCnt].toLowerCase() == sEditedData.toLowerCase()) {
                    MedAlreadyPresentDatas[iMedCnt] = "";
                }
            }
        }

        tempMedDatas = "";
        for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
            if (MedAlreadyPresentDatas[iMedCnt] != "") {
                tempMedDatas += MedAlreadyPresentDatas[iMedCnt] + "|";
            }
        }

        var arrayMedValue = new Array();
        var arrayItemName = new Array();
        var arrayUnit = new Array();
        var arrayComments = new Array();
        var arrayFromDate = new Array();
        var arrayToDate = new Array();
        var arrayItemCode = new Array();

        arrayMedValue = sEditedData.split('~');
        var MedItemName, MedItemUnit, MedDescription, MedFromDate, MedToDate, MedItemCode;

        if (arrayMedValue.length > 0) {
            MedItemName = arrayMedValue[1];
            MedItemUnit = arrayMedValue[2];
            MedDescription = arrayMedValue[3];
            MedFromDate = arrayMedValue[4];
            MedToDate = arrayMedValue[5];
            MedItemCode = arrayMedValue[6];

            arrayItemName = MedItemName.split('^');
            arrayUnit = MedItemUnit.split('^');
            arrayComments = MedDescription.split('^');
            arrayFromDate = MedFromDate.split('^');
            arrayToDate = MedToDate.split('^');
            arrayItemCode = MedItemCode.split('^');

        }

        if (arrayItemName.length > 0) {
            document.getElementById('<%= txtOthersItems.ClientID %>').value = arrayItemName[1];
        }
        if (arrayUnit.length > 0) {
            document.getElementById('<%= txtQuantity.ClientID %>').value = arrayUnit[1];
        }
        if (arrayComments.length > 0) {
            document.getElementById('<%= tComments.ClientID %>').value = arrayComments[1];
        }
        if (arrayToDate.length > 0) {
            document.getElementById('<%= txtFromDate.ClientID %>').value = arrayFromDate[1];
        }
        if (arrayFromDate.length > 0) {
            document.getElementById('<%= txtToDate.ClientID %>').value = arrayToDate[1];
        }


        document.getElementById('<%= hdfMedItems.ClientID %>').value = tempMedDatas;
        // Delete datas from MedItemName Exists Field
        var tempMedDatas = document.getElementById('<%= hdfMedExists.ClientID %>').value;
        MedAlreadyPresentDatas = null;
        MedAlreadyPresentDatas = tempMedDatas.split('|');
        if (MedAlreadyPresentDatas.length > 0) {
            for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
                if (MedAlreadyPresentDatas[iMedCnt].toLowerCase() == (arrayItemName[1].toLowerCase() + "-" + arrayUnit[1].toLowerCase())) {
                    MedAlreadyPresentDatas[iMedCnt] = "";
                }
            }
        }
        tempMedDatas = "";
        for (iMedCnt = 0; iMedCnt < MedAlreadyPresentDatas.length; iMedCnt++) {
            if (MedAlreadyPresentDatas[iMedCnt] != "") {
                tempMedDatas += MedAlreadyPresentDatas[iMedCnt] + "|";
            }
        }
        document.getElementById('<%= hdfMedExists.ClientID %>').value = tempMedDatas;

        CreateMedTables();
    }

    function MedControlclear() {
        document.getElementById('<%= txtOthersItems.ClientID %>').value = '';
        document.getElementById('<%= txtQuantity.ClientID %>').value = '1';
        document.getElementById('<%= tComments.ClientID %>').value = '';
        document.getElementById('<%= txtFromDate.ClientID %>').value = '';
        document.getElementById('<%= txtToDate.ClientID %>').value = '';
        return false;
    }
</script>

