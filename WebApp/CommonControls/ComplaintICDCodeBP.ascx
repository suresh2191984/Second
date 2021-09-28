<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ComplaintICDCodeBP.ascx.cs"
    Inherits="CommonControls_ComplaintICDCodeBP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%--<table width="80%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
    <tr>
        <td >
            <asp:Label ID="lblComplaint" runat="server"></asp:Label>
        </td>
        <td >
            <asp:Label ID="lblICDCode" runat="server" Text="ICD Code"></asp:Label>
        </td>
        <td >
            <asp:Label ID="lblICDName" runat="server" Text="ICD Name"></asp:Label>
        </td>
    </tr>
    <tr>
        <td >
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
            <asp:HiddenField ID="hdnFlag" runat="server" />
            <asp:TextBox runat="server" ID="txtCpmlaint" autocomplete="off" OnChange="javascript:GetText(this.value);" TextMode="MultiLine"> </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtCpmlaint"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td >
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.value);" TextMode="MultiLine" > </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODE"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td >
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off" OnChange="javascript:GetICDName(this.value);" TextMode="MultiLine" > </asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDName"
                ServicePath="~/WebService.asmx">
            </AutoCom:AutoCompleteExtender>
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaint();"
                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            &nbsp;
        </td>
    </tr>
   
</table>--%>
<table class="w-100p paddingL5" id="tbl1" runat="server">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="a-left w-50p">
            <asp:Label ID="lblICDName" runat="server" Text="ICD 10 Description" meta:resourcekey="lblICDNameResource1"></asp:Label>
        </td>
        <td class="w-50p a-left">
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="on" OnChange="javascript:GetTextBP(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtICDNameResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                EnableCaching="true" MinimumPrefixLength="1" CompletionInterval="100" FirstRowSelected="True" 
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:Label ID="lblComplaint" runat="server" meta:resourcekey="lblComplaintResource1"></asp:Label>
        </td>
        <td>
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
            <asp:HiddenField ID="hdnFlag" runat="server" />
            <asp:TextBox runat="server" ID="txtCpmlaint" autocomplete="off" OnChange="javascript:GetTextBP(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtCpmlaintResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtCpmlaint"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblICDCode" runat="server" Text="ICD 10 Code" meta:resourcekey="lblICDCodeResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetTextBP(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtICDCodeResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="2" class="a-center">
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaintBP();"
                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" meta:resourcekey="btnHistoryAddResource1" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td colspan="2">
            <table id="tblDiagnosisItems" runat="server" cellpadding="3" border="1" class="gridView" >
            </table>
        </td>
    </tr>
</table>

<script language="vbscript" type="text/vbscript">

	Function vbMsg(isTxt,caption)	
	testVal = MsgBox(isTxt,3,caption)
	ischoice=testval	
	End Function

</script>

<script language="javascript" type="text/javascript">
    var ischoice = 0;

    function GetTextBP(pCName) {        
        var vICDCode = SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01') == null ? "Invalid ICD Code. Do you wish to continue?" : SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01');
        
        if (pCName != "") {
            document.getElementById('<%=hdnCID.ClientID %>').value = "";
            var Temp = pCName.split('~');
            document.getElementById('<%=hdnCID.ClientID %>').value = Temp[3];

            if (Temp[1] == undefined) {
                var userMsg = '';
                if (SListForApplicationMessages != undefined) {
                    userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCodeBP.ascx_1');
                }
                return false;
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    vbMsg(''+vICDCode+'', 'Alert Message');
                }
                //6(yes) 7(No) 2(Cancel)
                if (ischoice == 6) {

                }
                else if (ischoice == 7) {
                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
                }
                else {

                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
                }

            }
            else {

                document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];
                //document.getElementById('<%=hdnCID.ClientID %>').value = 0;
                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[2];

                if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint') != null) {
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnCID').value = "";
                    var Temp = pCName.split('~');
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnCID').value = Temp[3];

                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint').value = Temp[0];
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDCode').value = Temp[1];
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDName').value = Temp[2];
                }

            }


        }
    }




    function GetICDCodeBP(pICDName) {
        var vICDCode = SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01') == null ? "Invalid ICD Code. Do you wish to continue?" : SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01');
        if (pICDName != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";

            var Temp = pICDName.split('~');
            document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCodeBP.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    vbMsg(''+vICDCode+'', 'Alert Message');
                }

                //6(yes) 7(No) 2(Cancel)
                if (ischoice == 6) {
                    document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
                }
                else if (ischoice == 7) {

                    document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
                    if (Temp[2] != "") {
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                    }
                    else {
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];

                    }
                }
                else {
                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
                }


            }

            else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") {
                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
                if (Temp[2] != "") {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                }
                else {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[1];

                }
            }

            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {

                document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                document.getElementById('<%=txtICDName.ClientID %>').value = "";
                //document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
            }

        }
    }

    function GetICDNameBP(pICDCode) {
        var vICDCode = SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01') == null ? "Invalid ICD Code. Do you wish to continue?" : SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_01');
        
        if (pICDCode != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";
            var Temp = pICDCode.split('~');
            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCodeBP.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    vbMsg(''+vICDCode+'', 'Alert Message');
                }
                //6(yes) 7(No) 2(Cancel)
                if (ischoice == 6) {
                    document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                }
                else if (ischoice == 7) {

                    document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];

                    if (Temp[2] != "") {
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                    }
                    else {
                        document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];

                    }
                }
                else {
                    document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                    document.getElementById('<%=txtICDName.ClientID %>').value = "";
                }


            }

            else if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value == "") {
                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                if (Temp[2] != "") {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[2];
                }
                else {
                    document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];

                }
            }

            else if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {

                document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                document.getElementById('<%=txtICDName.ClientID %>').value = "";
                document.getElementById('<%=txtCpmlaint.ClientID %>').value = Temp[0];
            }

        }
    }




    function onClickAddComplaintBP() {

        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vMedicalProblem = SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_02') == null ? "Enter medical problem" : SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_02');
        var vComplaintAlready = SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_03') == null ? "Complaint Already Added!" : SListForAppMsg.Get('CommonControls_ComplaintICDCodeBP_ascx_03');
        
    
        if (document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim() == "") {
            var userMsg = '';
            if (SListForApplicationMessages != undefined) {
                userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_3');

            }
            if ((userMsg != null) && (userMsg != "")) {
                alert(userMsg);
            }
            else {
                //alert("Enter medical problem");
                ValidationWindow(vMedicalProblem, AlertType);
            }
            return false;
        }

        //var rowNumber = parseInt(108);
        var rwNumber = parseInt(109);
        var AddStatus = 0;
        var ComplaintName = document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim();
        var ComplaintID = document.getElementById('<%=hdnCID.ClientID %>').value.trim();
        var ICDCODE = document.getElementById('<%=txtICDCode.ClientID %>').value.trim();
        var ICDName = document.getElementById('<%=txtICDName.ClientID %>').value.trim();
        document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'block';
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        if (HidValue == '') {
            if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
                HidValue = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
            }
        }
        var list = HidValue.split('^');
        if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
            if ((document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") ||
        (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value != "")) {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('~');
                    if (CList[1] != '') {
                        if (CList[0] != '') {
                            rwNumber = parseInt(parseInt(CList[0]) + parseInt(1));
                        }
                        if (ComplaintName != '') {
                            if (CList[1] == ComplaintName) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                if (ComplaintName != '') {
                    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                        var row = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
                    }
                    else {
                        var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                    }
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaintBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "1px";
                    cell2.width = "1px";
                    cell3.width = "1px";
                    cell4.width = "1px";
                    cell2.innerHTML = ComplaintName;
                    cell3.innerHTML = ICDCODE;
                    cell4.innerHTML = ICDName;

                    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                    }
                    else {
                        var cell5 = row.insertCell(4);
                        cell5.width = "1px";
                        cell5.innerHTML = "<input onclick='btnEditBP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                    }
                    AddStatus = 2;
                }
            }
        }
        else {
            if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('~');
                    if (CList[1] != '') {
                        if (CList[0] != '') {
                            rwNumber = parseInt(parseInt(CList[0]) + parseInt(1));
                        }
                        if (ComplaintName != '') {
                            if (CList[1] == ComplaintName) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else if (document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('~');
                    if (CList[1] != '') {
                        if (CList[0] != '') {
                            rwNumber = parseInt(parseInt(CList[0]) + parseInt(1));
                        }
                        if (ComplaintName != '') {
                            if (CList[1] == ComplaintName) {

                                AddStatus = 1;
                            }
                        }
                    }
                }

            }

            else {
                if (ComplaintName != '') {
                    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                        var row = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
                    }
                    else {
                        var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                    }
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaintBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "1px";
                    cell2.width = "1px";
                    cell3.width = "1px";
                    cell4.width = "1px";
                    cell2.innerHTML = ComplaintName;
                    cell3.innerHTML = ICDCODE;
                    cell4.innerHTML = ICDName;

                    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                    }
                    else {
                        var cell5 = row.insertCell(4);
                        cell5.width = "1px";
                        cell5.innerHTML = "<input onclick='btnEditBP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                    }
                    AddStatus = 2;
                }
            }
        }
        if (AddStatus == 0) {
            if (ComplaintName != '') {
                if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                    var row = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
                }
                else {

                    var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                }
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaintBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "1%";
                cell2.innerHTML = ComplaintName;
                cell3.innerHTML = ICDCODE;
                cell4.innerHTML = ICDName;
                if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') != null) {
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                }
                else {
                    var cell5 = row.insertCell(4);
                    cell5.innerHTML = "<input onclick='btnEditBP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "^";
                }

            }
        }
        else if (AddStatus == 1) {
            if (SListForApplicationMessages != undefined) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ComplaintICDCode.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    //alert("Complaint Already Added!");
                    ValidationWindow(vComplaintAlready, AlertType);
                }
            }

        }
        document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
        document.getElementById('<%=txtICDCode.ClientID %>').value = "";
        document.getElementById('<%=txtICDName.ClientID %>').value = "";
        document.getElementById('<%=hdnFlag.ClientID %>').value = "";


        if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint') != null) {
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint').value = "";
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDCode').value = "";
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDName').value = "";
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnFlag').value = "";
        }
        return false;

    }

    function ImgOnclickComplaintBP(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>') != null) {
            var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
            var list = HidValue.split('^');
            var newCList = '';
            if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('~');
                    if (CList[0] != '') {
                        if (CList[0] != ImgID) {
                            newCList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = newCList;
            }
            if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value == '') {
                document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'none';
            }
        }
        if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
            var HidValue = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            var newCList = '';
            if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('~');
                    if (CList[0] != '') {
                        if (CList[0] != ImgID) {
                            newCList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = newCList;
            }
            if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value == '') {
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').style.display = 'none';
            }
        }
    }




    function LoadComplaintItemsBP() {
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;

        var list = HidValue.split('^');
        if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
            while (count = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length) {

                for (var j = 0; j < document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length; j++) {
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').deleteRow(j);

                }
            }
        }
        else {
            while (count = document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length) {
                for (var j = 0; j < document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length; j++) {
                    document.getElementById('<%=tblDiagnosisItems.ClientID %>').deleteRow(j);

                }
            }
        }
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var CList = list[count].split('~');
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = CList[0];
                var rwNumber = CList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaintBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = CList[1];
                cell3.innerHTML = CList[3];
                cell4.innerHTML = CList[4];
                if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems') == null) {
                    var cell5 = row.insertCell(4);
                    cell5.innerHTML = "<input onclick='btnEditBP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "'  value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                }

            }
        }
    }


    function btnEditBP_OnClick(sEditedData) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        if (tempDatas == '') {
            tempDatas = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
        }
        arrayAlreadyPresentDatas = tempDatas.split('^');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                    arrayAlreadyPresentDatas[iCount] = "";

                }
            }
        }


        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "^";

            }
        }

        var arrayGotValue = new Array();

        arrayGotValue = sEditedData.split('~');


        if (arrayGotValue.length > 0) {

            document.getElementById('<%=hdnCID.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtCpmlaint.ClientID %>').value = arrayGotValue[1];
            document.getElementById('<%=txtICDCode.ClientID %>').value = arrayGotValue[3];
            document.getElementById('<%=txtICDName.ClientID %>').value = arrayGotValue[4];
            if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint') != null) {
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnCID').value = arrayGotValue[2];
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint').value = arrayGotValue[1];
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDCode').value = arrayGotValue[3];
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDName').value = arrayGotValue[4];
            }
        }
        if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = tempDatas;
        }
        else {
            document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = tempDatas;
        }
        LoadComplaintItemsBP();
    }
</script>

