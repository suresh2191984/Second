<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddDiagonosis.ascx.cs"
    Inherits="CommonControls_AddDiagonosis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
    <tr align="center">
        <td>
            <asp:Label ID="lblICDName" runat="server" Text="ICD 10 Description" meta:resourcekey="lblICDNameResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblComplaint" runat="server" Text="Complaint Name" meta:resourcekey="lblComplaintResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblICDCode" runat="server" Text="ICD 10 Code" meta:resourcekey="lblICDCodeResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblBackGroundProb" runat="server" Text="Is Background Problem" meta:resourcekey="lblBackGroundProbResource1"></asp:Label>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off" OnChange="javascript:GetICDName(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtICDNameResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDName"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td>
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnDiagnosisItemsTemp" runat="server" />
            <asp:HiddenField ID="hdnvalues" runat="server" />
            <asp:HiddenField ID="hdnCPTempValues" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
            <asp:HiddenField ID="hdnFlag" runat="server" />
            <asp:TextBox runat="server" ID="txtCpmlaint" autocomplete="off" OnChange="javascript:GetTextC(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtCpmlaintResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtCpmlaint"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosisID"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtICDCodeResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODE"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
        </td>
        <td align="center">
            <asp:CheckBox ID="ChkBP" runat="server" meta:resourcekey="ChkBPResource1" />
        </td>
        <td>
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaint();"
                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" meta:resourcekey="btnHistoryAddResource1" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td colspan="5">
            <table id="tblDiagnosisItems" runat="server" cellpadding="4" cellspacing="0" border="1">
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


    function GetTextC(pCName) {
        if (pCName != "") {

            document.getElementById('<%=hdnCID.ClientID %>').value = "";
            var Temp = pCName.split('~');
            document.getElementById('<%=hdnCID.ClientID %>').value = 0;

            if (Temp[1] == undefined) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\AddDiagonosis.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    vbMsg('Invalid ICD Code. Do you wish to continue?', 'Alert Message');
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

            }


        }
    }

    function GetICDCode(pICDName) {
        if (pICDName != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";

            var Temp = pICDName.split('~');
            document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\AddDiagonosis.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    vbMsg('Invalid Diagnosis. Do you wish to continue?', 'Alert Message');
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

    function GetICDName(pICDCode) {
        if (pICDCode != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";
            var Temp = pICDCode.split('~');
            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

            if (document.getElementById('<%=hdICD.ClientID %>').value != "undefined" && document.getElementById('<%=txtCpmlaint.ClientID %>').value != "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\AddDiagonosis.ascx_2');
                if (userMsg != null) {
                
                    alert(userMsg);
                }
                else {
                    vbMsg(' Invalid Diagnosis. Do you wish to continue?', 'Alert Message');
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




    function onClickAddComplaint() {
        if (document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim() == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\AddDiagonosis.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("Enter diagnosis");
            }
            return false;
        }

        var rwNumber = parseInt(110);
        var AddStatus = 0;
        var ComplaintName = document.getElementById('<%=txtCpmlaint.ClientID %>').value.trim();
        var ComplaintID = document.getElementById('<%=hdnCID.ClientID %>').value.trim();
        var ICDCODE = document.getElementById('<%=txtICDCode.ClientID %>').value.trim();
        var ICDName = document.getElementById('<%=txtICDName.ClientID %>').value.trim();
        if (document.getElementById('<%=ChkBP.ClientID %>').checked == true) {
            var IsBP = "Y";
        }
        else {
            var IsBP = "N";

        }
        document.getElementById('<%=tblDiagnosisItems.ClientID %>').style.display = 'block';

        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;
        var list = HidValue.split('^');
        if (document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value != "") {
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
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ComplaintName;
                cell3.innerHTML = ICDCODE;
                cell4.innerHTML = ICDName;
                cell5.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + IsBP + "'  value ='<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + IsBP + "^";
                AddStatus = 2;
            }
        }

        if (AddStatus == 0) {
            if (ComplaintName != '') {
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ComplaintName;
                cell3.innerHTML = ICDCODE;
                cell4.innerHTML = ICDName;
                cell5.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + IsBP + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ComplaintName + "~" + ComplaintID + "~" + ICDCODE + "~" + ICDName + "~" + IsBP + "^";
            }
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\AddDiagonosis.ascx_5');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert("Complaint Already Added!");
        }
        }
        document.getElementById('<%=txtCpmlaint.ClientID %>').value = "";
        document.getElementById('<%=txtICDCode.ClientID %>').value = "";
        document.getElementById('<%=txtICDName.ClientID %>').value = "";
        document.getElementById('<%=ChkBP.ClientID %>').checked = false;


        return false;

    }

    function ImgOnclickComplaint(ImgID) {
        document.getElementById(ImgID).style.display = "none";
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




    function LoadComplaintItems() {
        var HidValue = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblDiagnosisItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblDiagnosisItems.ClientID %>').deleteRow(j);

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
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = CList[1];
                cell3.innerHTML = CList[3];
                cell4.innerHTML = CList[4];
                cell5.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "~" + CList[5] + "'  value ='<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }


    function btnEditC_OnClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value;

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

            if (arrayGotValue[5] == "Y") {
                document.getElementById('<%=ChkBP.ClientID %>').checked = true;
            }
            else {
                document.getElementById('<%=ChkBP.ClientID %>').checked = false;
            }

        }

        document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = tempDatas;
        LoadComplaintItems();
    }


   
        
</script>

