<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HEMATOLOGY.ascx.cs" Inherits="Investigation_HEMATOLOGY" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .dataheaderInvCtrl td, .dataheaderInvCtrl th
    {
        border: 1px solid #000;
    }
    .divTable
    {
        width: 100%;
        display: block;
        padding-top: 10px;
        padding-bottom: 10px;
        padding-right: 10px;
        padding-left: 10px;
    }
    .divRow
    {
        width: 99%;
    }
    .divColumn
    {
        float: left;
        width: 33%;
        padding-bottom: 15px;
    }
    .divColumn td, .divColumn th
    {
        border: 1px solid #000;
    }
</style>

<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    var hdnLstStainResult = '<%=hdnLstStainResult.ClientID %>';
    var btnAddStain = '<%=btnAddStain.ClientID %>';
    var btnCancelStain = '<%=btnCancelStain.ClientID %>';
    function AddStainResult(ddlStainType, txtStainResult, txtRemarks, tblStainResult, divTblStainResult, ACEStainResult, txtOtherstaintype, divstaintype, GroupName, hdnSelectedRowIndex, ddlStatus) {
        var vMarkers = SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_01') == null ? "Select Markers Used\n" : SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_01');
        var vType = SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_02') == null ? "Enter stain type\n" : SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_02');
        
        try {
           
            var ddlStainTypeID = document.getElementById(ddlStainType);
            var selectedStainType = ddlStainTypeID.options[ddlStainTypeID.selectedIndex].text;
            var selectedStainTypeValue = ddlStainTypeID.options[ddlStainTypeID.selectedIndex].value;
            var selectedStainResult = $.trim(document.getElementById(txtStainResult).value);
            var selectedRemarks = $.trim(document.getElementById(txtRemarks).value);
            var message = '';
            var isRequiredMissing = false;
            var value = 0;

            if (ddlStainTypeID.selectedIndex == 0) {
                message += vMarkers;
                isRequiredMissing = true;
            }
            else if (selectedStainTypeValue == "Other" && $.trim(document.getElementById(txtOtherstaintype).value) == "") {
                message += vType;
                isRequiredMissing = true;
            }
//            if (selectedStainResult == '') {
//                message += "Enter stain result\n";
//               isRequiredMissing = true;
//            }
            if (!isRequiredMissing) {
                var table = document.getElementById(tblStainResult);
                var rowCount = 0;
                if (document.getElementById(btnAddStain).value == 'Update' && document.getElementById(hdnSelectedRowIndex).value >= 0) {
                    rowCount = document.getElementById(hdnSelectedRowIndex).value;
                    var row = document.getElementById(tblStainResult).rows[rowCount];
                    var tdStainType = row.cells[0];
                    if (selectedStainTypeValue == "Other") {
                        tdStainType.innerHTML = document.getElementById(txtOtherstaintype).value;
                    }
                    else {
                        tdStainType.innerHTML = selectedStainType;
                    }
                    var tdStainResult = row.cells[1];
                    var tdRemarks = row.cells[2];
                    tdStainResult.innerHTML = selectedStainResult;
                    tdRemarks.innerHTML = selectedRemarks;
                }
                else {
                    if (document.getElementById(tblStainResult).getElementsByTagName("tr") != null) {
                        rowCount = document.getElementById(tblStainResult).getElementsByTagName("tr").length;
                    }
                    var row = table.insertRow(rowCount);
                    var tdStainType = row.insertCell(0);
                    if (selectedStainTypeValue == "Other") {
                        tdStainType.innerHTML = document.getElementById(txtOtherstaintype).value;
                    }
                    else {
                        tdStainType.innerHTML = selectedStainType;
                    }

                    var tdStainResult = row.insertCell(1);
                    var tdRemarks = row.insertCell(2);
                    tdStainResult.innerHTML = selectedStainResult;
                    tdRemarks.innerHTML = selectedRemarks;
                    var tdEdit = row.insertCell(3);
                    tdEdit.innerHTML = '<input id="btnEditStainResult" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditStainResult(this,\'' + hdnSelectedRowIndex + '\',\'' + ddlStainType + '\',\'' + txtStainResult + '\',\'' + txtRemarks + '\',\'' + txtOtherstaintype + '\',\'' + divstaintype + '\');" />';
                    var tdDelete = row.insertCell(4);
                    tdDelete.innerHTML = '<input id="btnDeleteStainResult" value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteStainResult(this,\'' + hdnSelectedRowIndex + '\',\'' + ddlStainType + '\',\'' + txtStainResult + '\',\'' + txtRemarks + '\',\'' + txtOtherstaintype + '\',\'' + divstaintype + '\',\'' + ACEStainResult + '\');" />';
                }
                document.getElementById(divTblStainResult).style.display = 'block';
                document.getElementById(ddlStainType).selectedIndex = 0;
                document.getElementById(txtStainResult).value = '';
                document.getElementById(txtRemarks).value = '';
                $find(ACEStainResult).set_contextKey('');
                document.getElementById(txtOtherstaintype).value = '';
                document.getElementById(divstaintype).style.display = 'none';
                setCompletedStatus(GroupName, ddlStatus);
                document.getElementById(btnAddStain).value = 'Add';
                document.getElementById(btnCancelStain).style.display = 'none';
                document.getElementById(hdnSelectedRowIndex).value = '-1';
            }
            else {
                alert(message);
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function LoadAllStainResult(hdnLstStainResultXML, tblStainResult, divTblStainResult, hdnSelectedRowIndex, ddlStainType, txtStainResult, txtRemarks , txtOtherstaintype, divstaintype, ACEStainResult) {
        try {
            var StainXMLData = $.parseXML(document.getElementById(hdnLstStainResultXML).value);
            var table = document.getElementById(tblStainResult);
            $(StainXMLData).find('Stain').each(function() {
                var stainType = '';
                if (typeof ($(this).attr('Type')) != 'undefined') {
                    stainType = $(this).attr('Type');
                }
                var stainResult = '';
                if (typeof ($(this).attr('Result')) != 'undefined') {
                    stainResult = $(this).attr('Result');
                }
                var Remarks = '';
                if (typeof ($(this).attr('Remarks')) != 'undefined') {
                    Remarks = $(this).attr('Remarks');
                }
                var rowCount = 0;
                if (document.getElementById(tblStainResult).getElementsByTagName("tr") != null) {
                    rowCount = document.getElementById(tblStainResult).getElementsByTagName("tr").length;
                }
                var row = table.insertRow(rowCount);
                var tdStainType = row.insertCell(0);
                tdStainType.innerHTML = stainType;
                var tdStainResult = row.insertCell(1);
                tdStainResult.innerHTML = stainResult;
                var tdRemarks = row.insertCell(2);
                tdRemarks.innerHTML = Remarks;
                var tdEdit = row.insertCell(3);
                tdEdit.innerHTML = '<input id="btnEditStainResult" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditStainResult(this,\'' + hdnSelectedRowIndex + '\',\'' + ddlStainType + '\',\'' + txtStainResult + '\',\'' + txtRemarks + '\',\'' + txtOtherstaintype + '\',\'' + divstaintype + '\');" />';
                var tdDelete = row.insertCell(4);
                tdDelete.innerHTML = '<input id="btnDeleteStainResult" value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteStainResult(this,\'' + hdnSelectedRowIndex + '\',\'' + ddlStainType + '\',\'' + txtStainResult + '\',\'' + txtOtherstaintype + '\',\'' + divstaintype + '\',\'' + ACEStainResult + '\');" />';
                document.getElementById(divTblStainResult).style.display = 'block';
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onEditStainResult(obj, hdnSelectedRowIndex, ddlStainType, txtStainResult,txtRemarks , txtOtherstaintype, divstaintype) {
        try {
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            document.getElementById(btnAddStain).value = 'Update';
            document.getElementById(btnCancelStain).style.display = 'block';
            document.getElementById(hdnSelectedRowIndex).value = rowIndex;
            var stainType = $.trim($row.find("td").eq(0).html());
            var stainResult = $.trim($row.find("td").eq(1).html());
            var Remarks = $.trim($row.find("td").eq(2).html());
            var isValueExists = false;
            for (var i = 0; i < document.getElementById(ddlStainType).options.length; i++) {
                if (document.getElementById(ddlStainType).options[i].text == stainType) {
                    isValueExists = true;
                    break;
                }
            }
            if (isValueExists) {
                document.getElementById(ddlStainType).value = stainType;
                document.getElementById(txtOtherstaintype).value = '';
                document.getElementById(divstaintype).style.display = 'none';
            }
            else {
                document.getElementById(divstaintype).style.display = 'block';
                document.getElementById(ddlStainType).value = 'Other';
                document.getElementById(txtOtherstaintype).value = stainType;
            }
            document.getElementById(txtStainResult).value = stainResult;
            document.getElementById(txtRemarks).value = Remarks;
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteStainResult(obj, hdnSelectedRowIndex, ddlStainType, txtStainResult, txtRemarks , txtOtherstaintype, divstaintype, ACEStainResult) {
        try {
            $(obj).closest('tr').remove();
            if ($('tr', $(obj).closest('table').find('tbody')).length <= 1) {
                $(obj).closest('table').closest('div').hide();
            }
            if (document.getElementById(btnAddStain).value == 'Update' && document.getElementById(hdnSelectedRowIndex).value >= 0) {
                document.getElementById(ddlStainType).selectedIndex = 0;
                document.getElementById(txtStainResult).value = '';
                document.getElementById(txtRemarks).value = '';
                $find(ACEStainResult).set_contextKey('');
                document.getElementById(txtOtherstaintype).value = '';
                document.getElementById(divstaintype).style.display = 'none';
                document.getElementById(btnAddStain).value = 'Add';
                document.getElementById(btnCancelStain).style.display = 'none';
                document.getElementById(hdnSelectedRowIndex).value = '-1';
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onFocusStainResult(txtStainResult) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vAddStain = SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_03') == null ? "Add stain result" : SListForAppMsg.Get('Investigation_HEMATOLOGY_ascx_03');
        try {
            var txtStain = document.getElementById(txtStainResult).value;
            if (txtStain = !'') {
                //alert("Add stain result");
                ValidationWindow(vAddStain, AlertType);
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onChangeStainType(ddlStainType, hdnInvestigationID, ACEStainResult, divstaintype) {

        try {
            var ddlStainTypeID = document.getElementById(ddlStainType);
            var invID = document.getElementById(hdnInvestigationID).value;
            $find(ACEStainResult).set_contextKey(invID + '~' + ddlStainTypeID.options[ddlStainTypeID.selectedIndex].text);
            var ddlStainname = ddlStainTypeID.options[ddlStainTypeID.selectedIndex].value;
            if (ddlStainname == "Other") {
                document.getElementById(divstaintype).style.display = 'block';

            }
            else {
                document.getElementById(divstaintype).style.display = 'none';
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function SaveHEMATOLOGYPatternDetails(hdnInvID, ctrlClientID) {
        try {
            var lstStainResult = [];
            var table = document.getElementById(ctrlClientID + "_tblStainResult");
            var type, result;
            for (var i = 0, row; row = table.rows[i]; i++) {
                if (i > 0) {
                    type = "";
                    result = "";
                    for (var j = 0, col; col = row.cells[j]; j++) {
                        if (j == 0) {
                            type = col.innerText;
                        }
                        if (j == 1) {
                            result = col.innerText;
                        }
                        if (j == 2) {
                            Remarks = col.innerText;
                        }
                    }
                    lstStainResult.push({
                        StainType: type,
                        StainResult: result,
                        Remarks: Remarks
                    });
                }
            }
            if (lstStainResult.length > 0) {
                document.getElementById(ctrlClientID + "_hdnLstStainResult").value = JSON.stringify(lstStainResult);
            }
            else {
                document.getElementById(ctrlClientID + "_hdnLstStainResult").value = "";
            }
        }
        catch (e) {
            return false;
        }
        return true;
    }
</script>

<div>
    <table class="w-95p">
        <tr>
            <td>
                <table class="w-100p">
                    <tr>
                        <td id="tdInvName" class="font11 h-20 w-19p" runat="server" style="font-weight: normal;
                            color: #000; display: table-cell;">
                            <asp:Label ID="lblName" runat="server" Font-Bold="True" 
                                meta:resourcekey="lblNameResource1"></asp:Label>
                            <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="Red" OnClick="lnkEdit_Click"
                                Text="Edit" Visible="False" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                                visible="false"><u>
                                    <%=Resources.Investigation_ClientDisplay.Investigation_HEMATOLOGY_ascx_01 %></u></a>
                        </td>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <span class="richcombobox" style="width: 200px;">
                                            <asp:DropDownList ForeColor="Black" ID="ddlStainType" runat="server" 
                                            CssClass="ddlsmall" meta:resourcekey="ddlStainTypeResource1">
                                            </asp:DropDownList>
                                        </span>
                                        <div id="divstaintype" runat="server" class="paddingT10" style="display: none;">
                                            <asp:TextBox ID="txtOtherstaintype" runat="server" CssClass="small" 
                                                meta:resourcekey="txtOtherstaintypeResource1" />
                                        </div>
                                    </td>
                                    <td>
                                        <asp:TextBox ForeColor="Black" runat="server" ID="txtStainResult" Width="250px" 
                                            CssClass="small" meta:resourcekey="txtStainResultResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="ACEStainResult" MinimumPrefixLength="2" runat="server"
                                            TargetControlID="txtStainResult" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                            EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            DelimiterCharacters=";,:" Enabled="True" UseContextKey="true">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:TextBox ForeColor="Black" runat="server" ID="txtRemarks" CssClass="small" 
                                            meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                        <%--<ajc:AutoCompleteExtender ID="ACERemarks" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtRemarks" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" UseContextKey="true">
                                            </ajc:AutoCompleteExtender>--%>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnAddStain" Text="Add" CssClass="btn w-50 h-25" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" 
                                            meta:resourcekey="btnAddStainResource1" />
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnCancelStain" Text="Cancel" CssClass="btn w-50 h-25"
                                            onmouseover="this.className='btn btnhov'" 
                                            onmouseout="this.className='btn'" Style="display: none;" 
                                            meta:resourcekey="btnCancelStainResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td class="font10 h-50 w-20p" style="font-weight: normal; color: #000;">
                                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                            meta:resourcekey="ddlstatusResource1">
                                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                                        meta:resourcekey="lblReasonResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" 
                                                        meta:resourcekey="lblOpinionUserResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" 
                                                        onblur="collapseDropDownList(this);" 
                                                        meta:resourcekey="ddlStatusReasonResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <span class="richcombobox w-100">
                                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                            CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlenabled" runat="server" CssClass="w-100p" 
                    meta:resourcekey="pnlenabledResource1">
                    <table class="w-100p">
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <div id="divTblStainResult" runat="server" style="display: none;">
                                    <table id='tblStainResult' runat="server" class="w-100p dataheaderInvCtrl">
                                        <thead>
                                            <tr class="colorforcontent h-20">
                                                <th class="bold font11 h-8" style="color: White;">
                                                    <asp:Label ID="thStainType" Text="Markers used" runat="server" />
                                                </th>
                                                <th class="bold font11 h-8" style="color: White;">
                                                    <asp:Label ID="thStainResult" Text="Percentage Positivity" runat="server" />
                                                </th>
                                                <th class="bold font11 h-8" style="color: White;">
                                                    <asp:Label ID="thRemarks" Text="Remarks" runat="server" />
                                                </th>
                                                <th class="bold font11 h-8 w-20p" style="color: White;" colspan="2">
                                                    <asp:Label ID="thStainAction" Text="Action" runat="server" />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hidVal" />
    <asp:HiddenField runat="server" ID="hdnLstStainResult" Value="" />
    <asp:HiddenField runat="server" ID="hdnInvestigationID" Value="0" />
    <asp:HiddenField runat="server" ID="hdnInvestigationList" Value="0" />
    <asp:HiddenField runat="server" ID="hdnSelectedRowIndex" Value="-1" />
    <asp:HiddenField runat="server" ID="hdnLstStainResultXML" Value="" />
    <input id="hdnstatusreason" runat="server" type="hidden" value="" />
    <input id="hdnOpinionUser" runat="server" type="hidden" value="" />
</div>
<style type="text/css">
    .listMain
        {
            width: 400px !important;
        }
</style>