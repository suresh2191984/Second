<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MedicalIndents.ascx.cs"
    Inherits="CommonControls_MedicalIndents" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="MasterControl.ascx" TagName="MasterControl" TagPrefix="uc1" %>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<asp:Panel ID="pnlIndentItems" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlIndentItemsResource1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="colorforcontent" width="10" height="23" align="left">
                <div id="ACX2plusMedical" style="display: none;">
                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusMedical','ACX2minusMedical','ACX2responsesMedical',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMedical','ACX2minusMedical','ACX2responsesMedical',1);">
                        &nbsp;<asp:Label ID="Rs_MedicalIndents1" runat="server" Text="Medical Indents" meta:resourcekey="Rs_MedicalIndents1Resource1"></asp:Label></span>
                </div>
                <div id="ACX2minusMedical" style="display: block;">
                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusMedical','ACX2minusMedical','ACX2responsesMedical',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMedical','ACX2minusMedical','ACX2responsesMedical',0);">
                        &nbsp;<asp:Label ID="Rs_MedicalIndents2" runat="server" Text="Medical Indents" meta:resourcekey="Rs_MedicalIndents2Resource1"></asp:Label></span>
                </div>
            </td>
            <td style="width: 75%" height="23" align="left">
                <uc1:MasterControl ID="MasterControl1" Text="Add MedicalIndents" runat="server" />
            </td>
        </tr>
        <tr class="tablerow" id="ACX2responsesMedical" style="display: block;">
            <td colspan="2">
                <div class="filterdatahe">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="tabletxt">
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Item" runat="server" Text="Item" meta:resourcekey="Rs_ItemResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Nos" runat="server" Text=" Nos." meta:resourcekey="Rs_NosResource1"></asp:Label>
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
                                <asp:DropDownList runat="server" ID="ddlMedItem" onChange="funcItemsChange();" Style="width: 120px;"
                                    meta:resourcekey="ddlMedItemResource1">
                                    <asp:ListItem Text="--Select--" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Oxygen" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    <asp:ListItem Text="Others" Value="0" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="txtOthersItems" Style="display: none; width: 110px;" runat="server"
                                    meta:resourcekey="txtOthersItemsResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox ID="txtQuantity" runat="server" autocomplete="off" Style="width: 80px"
                                    Text="1" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="tComments" Style="width: 120px" autocomplete="off"
                                    meta:resourcekey="tCommentsResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <input id="txtFromDate" readonly="readonly" width="137px" type="text" />&nbsp; <a
                                    href="javascript:NewCal('txtFromDate','ddmmyyyy',true,12)">
                                    <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                        width="16"></img></a>
                            </td>
                            <td nowrap="nowrap">
                                <input id="txtToDate" readonly="readonly" width="137px" type="text" />
                                <a href="javascript:NewCal('txtToDate','ddmmyyyy',true,12)">
                                    <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                        width="16"></img></a>
                                <asp:Button ID="aNew" runat="server" Text="ADD"  class="btn"  
                                    OnClientClick ="IndentControlValidation();return false;" onmouseout="this.className='btn'"
                                    onmouseover="this.className='btn btnhov'" tooltip="Add New Drug" 
                                    value="Add" meta:resourcekey="aNewResource1"  />
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
                    <input type="hidden" id="did" runat="server"> 
                        </input>

                </div>
            </td>
        </tr>
    </table>
</asp:Panel>

<script type="text/javascript" language="javascript">

    function PINDvalidation() {

        if (document.getElementById('<%= ddlMedItem.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\MedicalIndents.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert('Please enter Item Name'); }
            document.getElementById('<%= ddlMedItem.ClientID %>').focus();
            return false;
        }
        if ((document.getElementById('<%= ddlMedItem.ClientID %>').value == 'IND') && (document.getElementById('<%= txtOthersItems.ClientID %>').value == '')) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\MedicalIndents.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Please enter Other Items');
            }
            document.getElementById('<%= txtOthersItems.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%= txtQuantity.ClientID %>').value == '') {
            document.getElementById('<%= txtQuantity.ClientID %>').value = 1;
            return true;
        }

        var IndentName = document.getElementById('<%= ddlMedItem.ClientID %>');
        var IndentCode = "";
        var NameofItem = "";

        if (document.getElementById('<%= ddlMedItem.ClientID %>').value == "0") {
            IndentCode = "-1";
            NameofItem = document.getElementById('<%= txtOthersItems.ClientID %>').value;
        }
        else {
            IndentCode = IndentName.options[IndentName.selectedIndex].value;
            NameofItem = IndentName.options[IndentName.selectedIndex].innerHTML;
        }


        var IndentQuantity = document.getElementById('<%= txtQuantity.ClientID %>').value;
        var IndentComments = document.getElementById('<%= tComments.ClientID %>').value;
        var IndentFromDate = document.getElementById('txtFromDate').value;
        var IndentToDate = document.getElementById('txtToDate').value;
        var retval = NameofItem + "~" + IndentQuantity + "~" + IndentComments + "~" + IndentFromDate + "~" + IndentToDate + "~" + IndentCode;
        return retval;
    }


    function Ind_loadSelectedValue(lstToLoadfrom, ctlToLoadTo, ctlToFocus) {
        var ctldd = document.getElementById(lstToLoadfrom);
        var txt = document.getElementById(ctlToLoadTo);
        var ctlfocus = document.getElementById(ctlToFocus);

        txt.value = ctldd.options[ctldd.selectedIndex].value;

        if (txt.value == "")
            txt.focus();
        //        else
        //            ctlfocus.focus();
    }

    function IndentControlValidation() {
        var retval = PINDvalidation();
        if (retval != false) {
            CmdAddIndent_onclick(retval);
        }
    }

    function CmdAddIndent_onclick(gotValue) {
        var ViewStateIndentValue = document.getElementById('<%= hdfIndent.ClientID %>').value;


        var arrayIndentValue = new Array();
        arrayIndentValue = gotValue.split('~');
        var ItemName, ItemUnit, Description, FromDate, ToDate, ItemCode;

        if (arrayIndentValue.length > 0) {
            ItemName = arrayIndentValue[0];
            ItemUnit = arrayIndentValue[1];
            Description = arrayIndentValue[2];
            FromDate = arrayIndentValue[3];
            ToDate = arrayIndentValue[4];
            ItemCode = arrayIndentValue[5];
        }
        var aAlreadyPresentDatas = new Array();
        var iAlrPresent = 0;
        var iCnt = 0;

        var tempIndentDatas = document.getElementById('<%= hdnIndentNameExists.ClientID %>').value;

        aAlreadyPresentDatas = tempIndentDatas.split('|');
        if (aAlreadyPresentDatas.length > 0) {
            for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
                if (aAlreadyPresentDatas[iCnt].toLowerCase() == (ItemName.toLowerCase() + "-" + ItemUnit.toLowerCase())) {
                    iAlrPresent++;
                }
            }
        }
        if (iAlrPresent == 0) {
            tempIndentDatas += ItemName + "-" + ItemUnit + "|";
            document.getElementById('<%= hdnIndentNameExists.ClientID %>').value = tempIndentDatas;
            ViewStateIndentValue += "RID^" + 0 + "~INDName^" + ItemName + "~INDUnit^" + ItemUnit + "~INDDesc^" + Description + "~INDFrom^" + FromDate + "~INDTo^" + ToDate + "~INDCode^" + ItemCode + "|";
            // newIndTable += CreateIndentTables(ItemName, ItemUnit, Description, FromDate, ToDate, Duration);
            document.getElementById('<%= hdfIndent.ClientID %>').value = ViewStateIndentValue;
            CreateIndentTables();
            IndentControlclear();

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\MedicalIndents.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Item Name already exists");
            }
        }

    }

    function CreateIndentTables() {
        //alert('df');
        document.getElementById('<%= dvTableIndent.ClientID %>').innerHTML = "";
        var newIndTable, startIndTag, endIndTag, ItemCode;
        var ViewStateIndentValue = document.getElementById('<%= hdfIndent.ClientID %>').value;

        startIndTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_Select %>"+" </td><td style='width:120px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_ItemName %>"+" </td><td style='width:80px;' >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_ItemUnit %>"+"</td> <td style='width:120px;'  >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_Comments %>"+"</td> <td style='width:80px;'  >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_FromDate %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_ToDate %>"+"</td><td></td> </tr>";
        endIndTag = "</TBODY></TABLE>";
        newIndTable = startIndTag;

        var arrayMainData = new Array();
        var arraySubData = new Array();
        var arrayChildData = new Array();
        var iarrayMainDataCount = 0;
        var iarraySubDataCount = 0;

        arrayMainData = ViewStateIndentValue.split('|');
        if (arrayMainData.length > 0) {
            for (iarrayMainDataCount = 0; iarrayMainDataCount < arrayMainData.length - 1; iarrayMainDataCount++) {

                arraySubData = arrayMainData[iarrayMainDataCount].split('~');
                for (iarraySubDataCount = 0; iarraySubDataCount < arraySubData.length; iarraySubDataCount++) {
                    arrayChildData = arraySubData[iarraySubDataCount].split('^');
                    if (arrayChildData.length > 0) {
                        if (arrayChildData[0] == "INDName") {
                            ItemName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INDUnit") {
                            ItemUnit = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INDDesc") {
                            Description = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INDFrom") {
                            FromDate = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INDTo") {
                            ToDate = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "INDCode") {
                            ItemCode = arrayChildData[1];
                        }
                    }
                }
                var chkBoxName = "RID^" + 0 + "~INDName^" + ItemName + "~INDUnit^" + ItemUnit + "~INDDesc^" + Description + "~INDFrom^" + FromDate + "~INDTo^" + ToDate + "~INDCode^" + ItemCode + "";
                var ReturnYesOrNo = DeletedValueCheckIND(chkBoxName);
                if (ReturnYesOrNo == "Yes") {
                    newIndTable += "<TR><TD><input name='RID^" + 0 + "~INDName^" + ItemName + "~INDUnit^" + ItemUnit + "~INDDesc^" + Description + "~INDFrom^" + FromDate + "~INDTo^" + ToDate + "~INDCode^" + ItemCode + "' onclick='chkUnCheckIND(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" >" + ItemName + "</TD>";
                }
                else {
                    newIndTable += "<TR><TD><input name='RID^" + 0 + "~INDName^" + ItemName + "~INDUnit^" + ItemUnit + "~INDDesc^" + Description + "~INDFrom^" + FromDate + "~INDTo^" + ToDate + "~INDCode^" + ItemCode + "' onclick='chkUnCheckIND(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px\" >" + ItemName + "</TD>";
                }
                newIndTable += "<TD style=\"WIDTH: 80px\" >" + ItemUnit + "</TD>";
                newIndTable += "<TD style=\"WIDTH: 120px\" >" + Description + "</TD>";
                newIndTable += "<TD style=\"WIDTH: 150px\" >" + FromDate + "</TD>";
                newIndTable += "<TD style=\"WIDTH: 150px\" nowrap='nowrap'>" + ToDate + "</TD>";

                newIndTable += "<TD><input name='RID^" + 0 + "~INDName^" + ItemName + "~INDUnit^" + ItemUnit + "~INDDesc^" + Description + "~INDFrom^" + FromDate + "~INDTo^" + ToDate + "~INDCode^" + ItemCode + "' onclick='IND_btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_MedicalIndents_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
            }
        }

        newIndTable += endIndTag;
        //Update the Previous Table With New Table.
        document.getElementById('<%= dvTableIndent.ClientID %>').innerHTML += newIndTable;

    }
    function chkUnCheckIND(DataValue) {
        //        document.getElementById('<%= hdnIndentDeleted.ClientID %>').value = DataValue;

        var aAlreadyPresentDatas = new Array();
        var iAlrPresent = 0;
        var iCnt = 0;

        var tempIndentDatas = document.getElementById('<%= hdnIndentDeleted.ClientID %>').value;
        var boolAlreadyPresent = false;
        aAlreadyPresentDatas = tempIndentDatas.split('|');
        if (aAlreadyPresentDatas.length > 0) {
            for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
                if (aAlreadyPresentDatas[iCnt].toLowerCase() == DataValue.toLowerCase()) {
                    aAlreadyPresentDatas[iCnt] = "";
                    boolAlreadyPresent = true;
                }
            }
        }

        tempIndentDatas = "";
        for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
            if (aAlreadyPresentDatas[iCnt] != "") {
                tempIndentDatas += aAlreadyPresentDatas[iCnt] + "|";
            }
        }
        if (boolAlreadyPresent == false) {
            tempIndentDatas += DataValue + "|";
        }
        document.getElementById('<%= hdnIndentDeleted.ClientID %>').value = tempIndentDatas;

    }

    function DeletedValueCheckIND(DataValue) {
        var aAlreadyPresentDatas = new Array();
        var iAlrPresent = 0;
        var iCnt = 0;
        var tempIndentDatas = document.getElementById('<%= hdnIndentDeleted.ClientID %>').value;
        var retValueAlreadyPresent = "No";

        aAlreadyPresentDatas = tempIndentDatas.split('|');
        if (aAlreadyPresentDatas.length > 0) {
            for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
                if (aAlreadyPresentDatas[iCnt].toLowerCase() == DataValue.toLowerCase()) {
                    retValueAlreadyPresent = "Yes";
                }
            }
        }
        return retValueAlreadyPresent;
    }

    function IND_btnEdit_OnClick(sEditedData) {

        var aAlreadyPresentDatas = new Array();
        var iAlrPresent = 0;
        var iCnt = 0;

        var tempIndentDatas = document.getElementById('<%= hdfIndent.ClientID %>').value;
        aAlreadyPresentDatas = tempIndentDatas.split('|');
        if (aAlreadyPresentDatas.length > 0) {
            for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
                if (aAlreadyPresentDatas[iCnt].toLowerCase() == sEditedData.toLowerCase()) {
                    aAlreadyPresentDatas[iCnt] = "";
                }
            }
        }

        tempIndentDatas = "";
        for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
            if (aAlreadyPresentDatas[iCnt] != "") {
                tempIndentDatas += aAlreadyPresentDatas[iCnt] + "|";
            }
        }

        var arrayIndentValue = new Array();
        var arrayItemName = new Array();
        var arrayUnit = new Array();
        var arrayComments = new Array();
        var arrayFromDate = new Array();
        var arrayToDate = new Array();
        var arrayItemCode = new Array();

        arrayIndentValue = sEditedData.split('~');
        var ItemName, ItemUnit, Description, FromDate, ToDate, ItemCode;

        if (arrayIndentValue.length > 0) {
            ItemName = arrayIndentValue[1];
            ItemUnit = arrayIndentValue[2];
            Description = arrayIndentValue[3];
            FromDate = arrayIndentValue[4];
            ToDate = arrayIndentValue[5];
            ItemCode = arrayIndentValue[6];

            arrayItemName = ItemName.split('^');
            arrayUnit = ItemUnit.split('^');
            arrayComments = Description.split('^');
            arrayFromDate = FromDate.split('^');
            arrayToDate = ToDate.split('^');
            arrayItemCode = ItemCode.split('^');

        }

        if (arrayItemName.length > 0) {
            if (arrayItemCode[1] != -1) {
                document.getElementById('<%= ddlMedItem.ClientID %>').value = arrayItemCode[1];
                document.getElementById('<%= txtOthersItems.ClientID %>').style.display = "none";
            }
            else {
                document.getElementById('<%= ddlMedItem.ClientID %>').value = "0";
                document.getElementById('<%= txtOthersItems.ClientID %>').style.display = "block";
                document.getElementById('<%= txtOthersItems.ClientID %>').value = arrayItemName[1];
            }
        }
        if (arrayUnit.length > 0) {
            document.getElementById('<%= txtQuantity.ClientID %>').value = arrayUnit[1];
        }
        if (arrayComments.length > 0) {
            document.getElementById('<%= tComments.ClientID %>').value = arrayComments[1];
        }
        if (arrayToDate.length > 0) {
            document.getElementById('txtFromDate').value = arrayFromDate[1];
        }
        if (arrayFromDate.length > 0) {
            document.getElementById('txtToDate').value = arrayToDate[1];
        }


        document.getElementById('<%= hdfIndent.ClientID %>').value = tempIndentDatas;
        // Delete datas from ItemName Exists Field
        var tempIndentDatas = document.getElementById('<%= hdnIndentNameExists.ClientID %>').value;
        aAlreadyPresentDatas = null;
        aAlreadyPresentDatas = tempIndentDatas.split('|');
        if (aAlreadyPresentDatas.length > 0) {
            for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
                if (aAlreadyPresentDatas[iCnt].toLowerCase() == (arrayItemName[1].toLowerCase() + "-" + arrayUnit[1].toLowerCase())) {
                    aAlreadyPresentDatas[iCnt] = "";
                }
            }
        }
        tempIndentDatas = "";
        for (iCnt = 0; iCnt < aAlreadyPresentDatas.length; iCnt++) {
            if (aAlreadyPresentDatas[iCnt] != "") {
                tempIndentDatas += aAlreadyPresentDatas[iCnt] + "|";
            }
        }
        document.getElementById('<%= hdnIndentNameExists.ClientID %>').value = tempIndentDatas;

        CreateIndentTables();
    }


    function funcItemsChange() {
        if (document.getElementById('<%= ddlMedItem.ClientID %>').value == "0") {
            document.getElementById('<%= txtOthersItems.ClientID %>').style.display = "block";
        }
        else {
            document.getElementById('<%= txtOthersItems.ClientID %>').style.display = "none";
        }
    }


    function IndentControlclear() {
        document.getElementById('<%= ddlMedItem.ClientID %>').value = '';
        document.getElementById('<%= txtOthersItems.ClientID %>').style.display = "none";
        document.getElementById('<%= txtOthersItems.ClientID %>').value = '';
        document.getElementById('<%= txtQuantity.ClientID %>').value = '1';
        document.getElementById('<%= tComments.ClientID %>').value = '';
        document.getElementById('txtFromDate').value = '';
        document.getElementById('txtToDate').value = '';
        return false;
    }
</script>

<asp:HiddenField ID="hdfIndent" runat="server" />
<asp:HiddenField ID="hdnIndentNameExists" runat="server" />
<asp:HiddenField ID="hdnIndentDeleted" runat="server" />
