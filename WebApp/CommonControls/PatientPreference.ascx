<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientPreference.ascx.cs"
    Inherits="CommonControls_PatientPreference" %>

<script language="javascript" type="text/javascript">

    function LoadPreference() {

        var HidValue = document.getElementById('hdnPreference').value;

        var list = HidValue.split('~');
        while (count = document.getElementById('PatientPreference1_PatientPreference').rows.length) {
            for (var j = 0; j < document.getElementById('PatientPreference1_PatientPreference').rows.length; j++) {
                document.getElementById('PatientPreference1_PatientPreference').deleteRow(j);

            }
        }
        if (document.getElementById('hdnPreference').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var CList = list[count].split('^');
                var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                row.id = CList[0];
                var rwNumber = CList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                cell2.innerHTML = CList[1];
                cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + CList[1] + "' value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                document.getElementById('PatientPreference1_PatientPreference').style.display = "block";

            }
        }
    }

    function btnEditPreference_OnClick(sEditedData) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('hdnPreference').value;
        arrayAlreadyPresentDatas = tempDatas.split('~');
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
                tempDatas += arrayAlreadyPresentDatas[iCount] + "~";

            }
        }

        var arrayGotValue = new Array();

        arrayGotValue = sEditedData.split('^');


        if (arrayGotValue.length > 0) {

            document.getElementById('PatientPreference1_txtEnterPreference').value = arrayGotValue[1];
        }
        document.getElementById('hdnPreference').value = tempDatas;
        LoadPreference();
    }

    function ImgOnclickPreference(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        if (document.getElementById('hdnPreference') != null) {
            var HidValue = document.getElementById('hdnPreference').value;
            var list = HidValue.split('~');
            var newCList = '';
            if (document.getElementById('hdnPreference').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('^');
                    if (CList[0] != '') {
                        if (CList[0] != ImgID) {
                            newCList += list[count] + '~';
                        }
                    }
                }
                document.getElementById('hdnPreference').value = newCList;
            }

        }
        if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
            var HidValue = document.getElementById('billPart_UcHistory_hdnPreference').value;
            var list = HidValue.split('~');
            var newCList = '';
            if (document.getElementById('billPart_UcHistory_hdnPreference').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CList = list[count].split('^');
                    if (CList[0] != '') {
                        if (CList[0] != ImgID) {
                            newCList += list[count] + '~';
                        }
                    }
                }
                document.getElementById('billPart_UcHistory_hdnPreference').value = newCList;
            }

        }
    }

    function AddPreference() {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vPreference = SListForAppMsg.Get('CommonControls_PatientPreference_ascx_01') == null ? "Please Enter Preference To Add" : SListForAppMsg.Get('CommonControls_PatientPreference_ascx_01');
        var vPreference = SListForAppMsg.Get('CommonControls_PatientPreference_ascx_01') == null ? "Please Enter Preference To Add" : SListForAppMsg.Get('CommonControls_PatientPreference_ascx_01');

        var rwNumber = parseInt(209);
        var txtValue;
        var PreviousValue = "";
        if (document.getElementById('PatientPreference1_txtEnterPreference') != null) {
            if (document.getElementById('PatientPreference1_txtEnterPreference').value != "") {
                if (document.getElementById('hdnPreference') != null) {
                    PreviousValue = document.getElementById('hdnPreference').value;
                    txtValue = document.getElementById('PatientPreference1_txtEnterPreference').value;
                    if (txtValue != '') {
                        if (PreviousValue == "") {
                            document.getElementById('hdnPreference').value = rwNumber + '^' + txtValue;
                        }
                        else {
                            if ((PreviousValue != "") || (txtValue != "")) {
                                var rowCount = PreviousValue.split('~');
                                for (var row = 0; row <= rowCount.length - 1; row++) {
                                    if (row == rowCount.length - 1) {
                                        if (rowCount[row] != "") {
                                            var rwNumberList = rowCount[row].split('^');
                                            rwNumber = parseInt(parseInt(rwNumberList[0]) + parseInt(1));
                                        }
                                    }
                                }
                                document.getElementById('hdnPreference').value = PreviousValue + '~' + rwNumber + '^' + txtValue;
                            }
                        }
                    }
                    var count = document.getElementById('hdnPreference').value.split('~');
                    var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    row.id = parseInt(rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                    cell2.innerHTML = txtValue;
                    cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + txtValue + "' value = '<%= Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('PatientPreference1_PatientPreference').style.display = "block";
                    document.getElementById('PatientPreference1_txtEnterPreference').value = "";
                }

            }
            else {
                //alert("Please Enter Preference To Add");
                ValidationWindow(vPreference, AlertType);
            }
        }
        if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference') != null) {
            var rwNumber = parseInt(309);
            if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value != "") {
                if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
                    PreviousValue = document.getElementById('billPart_UcHistory_hdnPreference').value;
                    txtValue = document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value;
                    if (txtValue != '') {
                        if (PreviousValue == "") {
                            document.getElementById('billPart_UcHistory_hdnPreference').value = rwNumber + '^' + txtValue;
                        }
                        else {
                            if ((PreviousValue != "") || (txtValue != "")) {
                                if ((PreviousValue != "") || (txtValue != "")) {
                                    var rowCount = PreviousValue.split('~');
                                    for (var row = 0; row <= rowCount.length - 1; row++) {
                                        if (row == rowCount.length - 1) {
                                            if (rowCount[row] != "") {
                                                var rwNumberList = rowCount[row].split('^');
                                                rwNumber = parseInt(parseInt(rwNumberList[0]) + parseInt(1));
                                            }
                                        }
                                    }
                                    document.getElementById('billPart_UcHistory_hdnPreference').value = PreviousValue + '~' + rwNumber + '^' + txtValue;
                                }
                            }
                        }
                    }

                    var count = document.getElementById('billPart_UcHistory_hdnPreference').value.split('~');
                    var row = document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').insertRow(0);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    row.id = parseInt(rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                    cell2.innerHTML = txtValue;
                    cell2.align = 'left';
                    document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = "block";
                    document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = "";
                }
            }
            else {
                //alert("Please Enter Preference To Add");
                ValidationWindow(vPreference, AlertType);
            }
        }
    }
    
    
</script>

<table>
    <tr>
        <td>
            <table>
                <tr>
                    <td class="paddingT5">
                        <asp:TextBox ID="txtEnterPreference" runat="server" TextMode="MultiLine" Width="300px"
                            Height="105px" Wrap="true" meta:resourcekey="txtEnterPreferenceResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="paddingT15 a-center">
                        <%--<input id="btnSavePreference" runat="server" class="btn" type="button" value='<%=Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_01 %>'
                            onclick="AddPreference();" />
                            --%>
                           <%-- <asp:Button ID="btnSavePreference" runat="server" CssClass="btn" 
                            OnClientClick="AddPreference();" Text="Add" 
                            meta:resourcekey="btnSavePreferenceResource1" />--%>
                            <button id="btnSavePreference" class="btn" onclick="AddPreference();return false;"><%=Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_02 %></button>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="marginT10">
        <td>
            <table id="PatientPreference" runat="server" class="v-top a-left w-310 marginT5"
                style="display: none;" cellpadding="2" border='1'>
            </table>
        </td>
    </tr>
</table>
