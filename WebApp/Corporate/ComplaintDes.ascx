<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ComplaintDes.ascx.cs" Inherits="Corporate_ComplaintDes" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>

<table width="100%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
    <tr>
        <td style="display:none;" >
            <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
            <asp:HiddenField ID="hdnCID" runat="server" />
            <asp:HiddenField ID="hdICD" runat="server" />
        </td>
      
    </tr>
    <tr>
        <td style="display:none;">
            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.value);"
                TextMode="MultiLine" meta:resourcekey="txtICDCodeResource1"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODE"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
            </AutoCom:AutoCompleteExtender>
           
        </td>
   </tr>
   <tr>
        <td>
        <asp:Label ID="lblICDName" runat="server" Text="Complaint Name:" meta:resourcekey="lblICDNameResource1"></asp:Label>
            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off"  OnChange="javascript:GetICDName(this.value);"
                meta:resourcekey="txtICDNameResource1" CssClass="Txtboxsmall"></asp:TextBox>
            <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="1" FirstRowSelected="True"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getComplaintName"
                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" >
            </AutoCom:AutoCompleteExtender>
            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddComplaint();"
                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" meta:resourcekey="btnHistoryAddResource1"/>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td align="left">
            <table id="tblDiagnosisItems" runat="server" cellspacing="0" border="1">
            </table>
        </td>
    </tr>
</table>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">

    function GetICDCode(pICDName) {

        if (pICDName != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";

            var Temp = pICDName.split('~');
            document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];


            if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {
                document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                document.getElementById('<%=txtICDName.ClientID %>').value = "";
            }
            else {

                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[0];
                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[1];
            }
        }

    }

    function GetICDName(pICDCode) {
        if (pICDCode != "") {
            document.getElementById('<%=hdICD.ClientID %>').value = "";
            var Temp = pICDCode.split('~');
            document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
            document.getElementById('<%=hdICD.ClientID %>').value = Temp[1];

            if (document.getElementById('<%=hdICD.ClientID %>').value == "undefined") {
                document.getElementById('<%=txtICDCode.ClientID %>').value = "";
                document.getElementById('<%=txtICDName.ClientID %>').value = "";
            }
            else {

                document.getElementById('<%=txtICDCode.ClientID %>').value = Temp[1];
                document.getElementById('<%=txtICDName.ClientID %>').value = Temp[0];
            }


        }
    }




    function onClickAddComplaint() {
        if (document.getElementById('<%=txtICDName.ClientID %>').value.trim() == "") {
            alert("Enter The txtICDName");
            return false;
        }

        var rwNumber = parseInt(110);
        var AddStatus = 0;

        var ICDCODE = document.getElementById('<%=txtICDCode.ClientID %>').value.trim();
        var ICDName = document.getElementById('<%=txtICDName.ClientID %>').value.trim();
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
                    if (ICDName != '') {
                        if (CList[0] == ICDName) {

                            AddStatus = 1;
                        }
                    }
                }
            }
        }

        else {

            if (ICDName != '') {
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ICDCODE;
                cell3.innerHTML = ICDName;
                cell4.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ICDCODE + "~" + ICDName + "'  value = 'Edit' type='button' style='Display:none;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ICDCODE + "~" + ICDName + "^";
                AddStatus = 2;
            }
        }

        if (AddStatus == 0) {
            if (ICDName != '') {
                var row = document.getElementById('<%=tblDiagnosisItems.ClientID %>').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ICDCODE;
                cell3.innerHTML = ICDName;
                cell4.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + ICDCODE + "~" + ICDName + "'  value = 'Edit' type='button' style='Display:none;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value += parseInt(rwNumber) + "~" + ICDCODE + "~" + ICDName + "^";
            }
        }
        else if (AddStatus == 1) {
            alert("ICD Code Already Added!");
        }


        document.getElementById('<%=txtICDName.ClientID %>').value = "";

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

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = CList[1];
                cell3.innerHTML = CList[2];

                cell4.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "'  value = 'Edit' type='button' style='Display:none;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
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

            //            alert(arrayGotValue);
            document.getElementById('<%=txtICDCode.ClientID %>').value = arrayGotValue[1];
            document.getElementById('<%=txtICDName.ClientID %>').value = arrayGotValue[2];


        }

        document.getElementById('<%=hdnDiagnosisItems.ClientID %>').value = tempDatas;
        LoadComplaintItems();
    }


   
        
</script>

