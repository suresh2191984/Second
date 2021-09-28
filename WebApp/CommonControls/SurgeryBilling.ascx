<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryBilling.ascx.cs"
    Inherits="CommonControls_SurgeryBilling" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />



<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

	
    
<script language="javascript" type="text/javascript">


    function AddddlChief() {

        var ddlPhy = document.getElementById('<%= ddlChief.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtddlChief.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }

    function AddddlChiefDefined() {

        var ddlPhy = document.getElementById('<%= DrpCheifSurgeon.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtCheifSurgeon.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }


    function AddddlAssistent() {

        var ddlPhy = document.getElementById('<%= ddlAssistent.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtddlAssistent.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }


    function AddddlAssistentDefined() {

        var ddlPhy = document.getElementById('<%= DrpAssistantSurgeon.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtAssistantSurgeion.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }

    function AddddlAnesthetistDefined() {

        var ddlPhy = document.getElementById('<%= ddlAnesthetist.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtAnesthesiast.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }

    function AddddlNurseDefined() {

        var ddlPhy = document.getElementById('<%= drpNurse.ClientID %>');
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtNurse.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }



    function closeData() { }

    var ddlTextC, ddlValueC, ddlC, lblMesgC;
    var ddlTextAS, ddlValueAS, ddlAS, lblMesgAS, ddlNurse;
    var ddlTextAN, ddlValueAN, ddlAN, lblMesgAN;

    function CacheItemsddlChief() {

        var IsSurgeryDefined = document.getElementById('<%=hdnIsSurgeryDefined.ClientID %>').value;
        ddlTextC = new Array();
        ddlValueC = new Array();
        if (IsSurgeryDefined != 'Y') {
            ddlC = document.getElementById('<%=ddlChief.ClientID %>');
        }
        else {
            ddlC = document.getElementById('<%=DrpCheifSurgeon.ClientID %>');
        }
        for (var i = 0; i < ddlC.options.length; i++) {
            ddlTextC[ddlTextC.length] = ddlC.options[i].text;
            ddlValueC[ddlValueC.length] = ddlC.options[i].value;
        }


    }



    function CacheItemsddlnurse() {

        var IsSurgeryDefined = document.getElementById('<%=hdnIsSurgeryDefined.ClientID %>').value;
        ddlTextC = new Array();
        ddlValueC = new Array();
        if (IsSurgeryDefined != 'Y') {
            ddlC = document.getElementById('<%=drpNurse.ClientID %>');
        }
        else {
            ddlC = document.getElementById('<%=drpNurse.ClientID %>');
        }
        for (var i = 0; i < ddlC.options.length; i++) {
            ddlTextC[ddlTextC.length] = ddlC.options[i].text;
            ddlValueC[ddlValueC.length] = ddlC.options[i].value;
        }


    }
    window.onload = CacheItemsddlnurse;


    function CacheItemsddlAssistent() {

        var IsSurgeryDefined = document.getElementById('<%=hdnIsSurgeryDefined.ClientID %>').value;
        ddlTextAS = new Array();
        ddlValueAS = new Array();
        if (IsSurgeryDefined != 'Y') {
            ddlAS = document.getElementById('<%=ddlAssistent.ClientID %>');
        }
        else {
            ddlAS = document.getElementById('<%=DrpAssistantSurgeon.ClientID %>');
        }
        for (var i = 0; i < ddlAS.options.length; i++) {
            ddlTextAS[ddlTextAS.length] = ddlAS.options[i].text;
            ddlValueAS[ddlValueAS.length] = ddlAS.options[i].value;
        }
    }

    //window.onload = CacheItemsddlAssistent;

    function CacheItemsddlAnesthetist() {
        var IsSurgeryDefined = document.getElementById('<%=hdnIsSurgeryDefined.ClientID %>').value;
        ddlTextAN = new Array();
        ddlValueAN = new Array();
        if (IsSurgeryDefined != 'Y') {
            ddlAN = document.getElementById('<%=ddlAnesthetist.ClientID %>');
        }
        else {
            ddlAN = document.getElementById('<%=DrpAnesthesiast.ClientID %>');

        }
        for (var i = 0; i < ddlAN.options.length; i++) {
            ddlTextAN[ddlTextAN.length] = ddlAN.options[i].text;
            ddlValueAN[ddlValueAN.length] = ddlAN.options[i].value;
        }

        CacheItemsddlChief();
        CacheItemsddlAssistent();
    }

    window.onload = CacheItemsddlAnesthetist;


    function FilterItemsC(value) {

        value = value.toLowerCase();
        ddlC.options.length = 0;
        for (var i = 0; i < ddlTextC.length; i++) {
            if (ddlTextC[i].toLowerCase().indexOf(value) != -1) {
                AddItemC(ddlTextC[i], ddlValueC[i]);
            }
        }

        if (ddlC.options.length == 0) {
            AddItemC("No Physician Found", "");
        }
    }
    function FilterItemsAS(value) {
        value = value.toLowerCase();
        ddlAS.options.length = 0;
        for (var i = 0; i < ddlTextAS.length; i++) {
            if (ddlTextAS[i].toLowerCase().indexOf(value) != -1) {
                AddItemAS(ddlTextAS[i], ddlValueAS[i]);
            }
        }

        if (ddlAS.options.length == 0) {
            AddItemAS("No Physician Found", "");
        }
    }
    function FilterItemsAN(value) {
        value = value.toLowerCase();
        ddlAN.options.length = 0;
        for (var i = 0; i < ddlTextAN.length; i++) {
            if (ddlTextAN[i].toLowerCase().indexOf(value) != -1) {
                AddItemAN(ddlTextAN[i], ddlValueAN[i]);
            }
        }

        if (ddlAN.options.length == 0) {
            AddItemAN("No Physician Found", "");
        }
    }

    function FilterItemsNurse(value) {

        value = value.toLowerCase();
        ddlAN.options.length = 0;
        for (var i = 0; i < ddlTextAN.length; i++) {
            if (ddlTextAN[i].toLowerCase().indexOf(value) != -1) {
                AddItemAN(ddlTextAN[i], ddlValueAN[i]);
            }
        }

        if (ddlAN.options.length == 0) {
            AddItemAN("No Physician Found", "");
        }
    }


    function AddItemC(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddlC.options.add(opt);
    }
    function AddItemAS(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddlAS.options.add(opt);
    }

    function AddItemAN(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddlAN.options.add(opt);
    }

    function AddItemNurse(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddlAN.options.add(opt);
    }




    function pValidationTreatment() {

        if (document.getElementById("pid").value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('select Treatment Plan');
            }
            return false;
        }
    }

    ///Bind DropDown

    function getIPTreatmentName() {

        document.getElementById('<%=hdntreatmentID.ClientID %>').value = "";
        document.getElementById('<%=hdntreatmentName.ClientID %>').value = "";
        document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;
        document.getElementById('<%=hdntreatmentID.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].value;


        if (document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text == "Others") {

            document.getElementById('<%=divOthers.ClientID %>').style.display = 'block';
            document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;
            document.getElementById('<%=hdntreatmentID.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').selectedIndex].value;

        }
        else {
            document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;
            document.getElementById('<%=hdntreatmentID.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].value;
            document.getElementById('<%=divOthers.ClientID %>').style.display = 'none';
        }


        var HidRate = document.getElementById('<%=hdnIPTreatmentRate.ClientID %>').value;
        var listRate = HidRate.split('^');
        var txtSurgFee = document.getElementById('<%=txtSurgigalFee.ClientID %>');
        for (var Rcount = 0; Rcount < listRate.length; Rcount++) {
            var IPTreatmentRate = listRate[Rcount].split('~');
            if (document.getElementById('<%=hdntreatmentID.ClientID %>').value == IPTreatmentRate[0]) {

                document.getElementById('<%=txtSurgigalFee.ClientID %>').value = IPTreatmentRate[3];
                document.getElementById('<%=hdnDiscEnhc.ClientID %>').value = IPTreatmentRate[4];
                document.getElementById('<%=hdnDiscEnhctype.ClientID %>').value = IPTreatmentRate[5];
                document.getElementById('<%=hdnRemark.ClientID %>').value = IPTreatmentRate[6];
                break;
            }
            else {
                document.getElementById('<%=txtSurgigalFee.ClientID %>').value = '';
            }

        }

    }

    function showIPTreatmentPlanChild(SelectedMasterID) {


        var HidValue = document.getElementById('<%=hdnIPTreatmentPlanChild.ClientID %>').value;

        var MasterID = SelectedMasterID;
        var list = HidValue.split('^');

        var ddlTreatmentPlanChild = document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID %>');

        ddlTreatmentPlanChild.options.length = 0;
        if (document.getElementById('<%=hdnIPTreatmentPlanChild.ClientID %>').value != "") {


            for (var count = 0; count < list.length; count++) {

                var IPTreatmentPlanChild = list[count].split('~');

                if (MasterID == IPTreatmentPlanChild[2]) {

                    var opt = document.createElement("option");
                    document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID %>').options.add(opt);
                    opt.text = IPTreatmentPlanChild[1];
                    opt.value = IPTreatmentPlanChild[0];



                }
            }


        }

        document.getElementById('<%=hdntreatmentID.ClientID %>').value = "";
        document.getElementById('<%=hdntreatmentName.ClientID %>').value = "";


        if (document.getElementById('<%=hdnTID.ClientID %>').value != "") {
            document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID %>').value = document.getElementById('<%=hdnTID.ClientID %>').value;
        }

        if (document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text == "Others") {

            document.getElementById('<%=hdntreatmentID.ClientID %>').value = SelectedMasterID;
            document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;

        }
        else {

            document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;
            document.getElementById('<%=hdntreatmentID.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].value;
        }

    }


    // Add AssistantOperator
    function onAssistantOperatorClick() {
       

        if (document.getElementById('<%=txtAssistent.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Fees");
            }
        }
        else {
            var rwNumber = parseInt(1);
            var AddStatus = 0;
            document.getElementById('<%=tbAssistent.ClientID %>').style.display = 'block';
            var AssistentName = document.getElementById('<%= ddlAssistent.ClientID %>').options[document.getElementById('<%= ddlAssistent.ClientID %>').selectedIndex].text;
            var AssistentID = document.getElementById('<%= ddlAssistent.ClientID %>').options[document.getElementById('<%= ddlAssistent.ClientID %>').selectedIndex].value;
            var AssistentFee = document.getElementById('<%=txtAssistent.ClientID %>').value;
            var HidValue = document.getElementById('<%=iconHidAssistant.ClientID %>').value;

            var list = HidValue.split('^');

            if (document.getElementById('<%=iconHidAssistant.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var AssistantOperator = list[count].split('~');
                    if (AssistantOperator[1] != '') {
                        if (AssistantOperator[0] != '') {
                            rwNumber = parseInt(parseInt(AssistantOperator[0]) + parseInt(1));
                        }
                        if (AssistentName != '') {
                            if (AssistantOperator[1] == AssistentName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (AssistentName != '') {
                    var row = document.getElementById('<%=tbAssistent.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = AssistentName;
                    cell3.innerHTML = AssistentID;
                    cell3.style.display = "none";
                    cell4.innerHTML = AssistentFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClick(this.id);' id='" + parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "~" + AssistentFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAssistant.ClientID %>').value += parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "~" + AssistentFee + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (AssistentName != '') {
                    var row = document.getElementById('<%=tbAssistent.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = AssistentName;
                    cell3.innerHTML = AssistentID;
                    cell3.style.display = "none";
                    cell4.innerHTML = AssistentFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClick(this.id);' id='" + parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "~" + AssistentFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAssistant.ClientID %>').value += parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "~" + AssistentFee + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Assistant Already Added!");
                }
            }
            document.getElementById('<%=txtAssistent.ClientID %>').value = '';
            return false;
        }
    }
    // Add AssistantOperator
    function ImgOnclickAssistent(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidAssistant.ClientID %>').value;
        var list = HidValue.split('^');
        var newAssistantOperatorList = '';
        if (document.getElementById('<%=iconHidAssistant.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var AssistantOperator = list[count].split('~');
                if (AssistantOperator[0] != '') {
                    if (AssistantOperator[0] != ImgID) {
                        newAssistantOperatorList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidAssistant.ClientID %>').value = newAssistantOperatorList;
        }
        if (document.getElementById('<%=iconHidAssistant.ClientID %>').value == '') {
            document.getElementById('<%=tbAssistent.ClientID %>').style.display = 'none';
        }
    }

    //Edit AssistantOperator

    function btnEditAssistentClick(sEditedData) {

        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidAssistant.ClientID %>').value;
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
            document.getElementById('<%=ddlAssistent.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtAssistent.ClientID %>').value = arrayGotValue[3];
        }

        document.getElementById('<%=iconHidAssistant.ClientID %>').value = tempDatas;
        LoadAssistantOperatorItems();

    }
    //Load AssistantOperator
    function LoadAssistantOperatorItems() {
        var HidValue = document.getElementById('<%=iconHidAssistant.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tbAssistent.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tbAssistent.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tbAssistent.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidAssistant.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var AssistantOperator = list[count].split('~');
                var row = document.getElementById('<%=tbAssistent.ClientID %>').insertRow(0);
                row.id = AssistantOperator[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistent(" + parseInt(AssistantOperator[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = AssistantOperator[1]; ;
                cell3.innerHTML = AssistantOperator[2];
                cell3.style.display = "none";
                cell4.innerHTML = AssistantOperator[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClick(this.id);' id='" + parseInt(AssistantOperator[0]) + "~" + AssistantOperator[1] + "~" + AssistantOperator[2] + "~" + AssistantOperator[3] + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }



    // Add AnesthetistOperator
    function onAnesthetistOperatorClick() {


        if (document.getElementById('<%=txtAnesthetist.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Fees");
            }
        }
        else {
            var rwNumber = parseInt(200);
            var AddStatus = 0;
            document.getElementById('<%=tbAnesthetist.ClientID %>').style.display = 'block';
            var AnesthetistName = document.getElementById('<%= ddlAnesthetist.ClientID %>').options[document.getElementById('<%= ddlAnesthetist.ClientID %>').selectedIndex].text;
            var AnesthetistID = document.getElementById('<%= ddlAnesthetist.ClientID %>').options[document.getElementById('<%= ddlAnesthetist.ClientID %>').selectedIndex].value;
            var AnesthetistFee = document.getElementById('<%=txtAnesthetist.ClientID %>').value;
            var HidValue = document.getElementById('<%=iconHidAnesthetist.ClientID %>').value;

            var list = HidValue.split('^');


            if (document.getElementById('<%=iconHidAnesthetist.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var AnesthetistOperator = list[count].split('~');
                    if (AnesthetistOperator[1] != '') {
                        if (AnesthetistOperator[0] != '') {
                            rwNumber = parseInt(parseInt(AnesthetistOperator[0]) + parseInt(1));
                        }
                        if (AnesthetistName != '') {
                            if (AnesthetistOperator[1] == AnesthetistName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (AnesthetistName != '') {
                    var row = document.getElementById('<%=tbAnesthetist.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = AnesthetistName;
                    cell3.innerHTML = AnesthetistID;
                    cell3.style.display = "none";
                    cell4.innerHTML = AnesthetistFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClick(this.id);' id='" + parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "~" + AnesthetistFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAnesthetist.ClientID %>').value += parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "~" + AnesthetistFee + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (AnesthetistName != '') {
                    var row = document.getElementById('<%=tbAnesthetist.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = AnesthetistName;
                    cell3.innerHTML = AnesthetistID;
                    cell3.style.display = "none";
                    cell4.innerHTML = AnesthetistFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClick(this.id);' id='" + parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "~" + AnesthetistFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAnesthetist.ClientID %>').value += parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "~" + AnesthetistFee + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Anesthetist Already Added!");
                }
            }
            document.getElementById('<%=txtAnesthetist.ClientID %>').value = '';

            return false;
        }
    }
    // Add AnesthetistOperator
    function ImgOnclickAnesthetist(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidAnesthetist.ClientID %>').value;
        var list = HidValue.split('^');
        var newAnesthetistOperatorList = '';
        if (document.getElementById('<%=iconHidAnesthetist.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var AnesthetistOperator = list[count].split('~');
                if (AnesthetistOperator[0] != '') {
                    if (AnesthetistOperator[0] != ImgID) {
                        newAnesthetistOperatorList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidAnesthetist.ClientID %>').value = newAnesthetistOperatorList;
        }
        if (document.getElementById('<%=iconHidAnesthetist.ClientID %>').value == '') {
            document.getElementById('<%=tbAnesthetist.ClientID %>').style.display = 'none';
        }
    }

    //Edit AnesthetistOperator

    function btnEditAnesthetistClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidAnesthetist.ClientID %>').value;
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
            document.getElementById('<%=ddlAnesthetist.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtAnesthetist.ClientID %>').value = arrayGotValue[3];
        }

        document.getElementById('<%=iconHidAnesthetist.ClientID %>').value = tempDatas;
        LoadAnesthetistOperatorItems();

    }
    //Load AnesthetistOperator
    function LoadAnesthetistOperatorItems() {
        var HidValue = document.getElementById('<%=iconHidAnesthetist.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tbAnesthetist.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tbAnesthetist.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tbAnesthetist.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidAnesthetist.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var AnesthetistOperator = list[count].split('~');
                var row = document.getElementById('<%=tbAnesthetist.ClientID %>').insertRow(0);
                row.id = AnesthetistOperator[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + parseInt(AnesthetistOperator[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = AnesthetistOperator[1]; ;
                cell3.innerHTML = AnesthetistOperator[2];
                cell3.style.display = "none";
                cell4.innerHTML = AnesthetistOperator[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClick(this.id);' id='" + parseInt(AnesthetistOperator[0]) + "~" + AnesthetistOperator[1] + "~" + AnesthetistOperator[2] + "~" + AnesthetistOperator[3] + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }




    //Add other Fees


    function onOthersClick() {


        if (document.getElementById('<%=txtOtherAmount.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Other Fees");
            }
        }
        else {
            if (document.getElementById('<%=txtOtherFeeType.ClientID %>').value == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_6');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Enter The Other Fee Type");
                }
            }
            else {
                var rwNumber = parseInt(300);
                var AddStatus = 0;
                document.getElementById('<%=tblOthers.ClientID %>').style.display = 'block';
                var OtherFeeType = document.getElementById('<%=txtOtherFeeType.ClientID %>').value;
                var OtherAmount = document.getElementById('<%=txtOtherAmount.ClientID %>').value;
                var HidValue = document.getElementById('<%=iconHidOthers.ClientID %>').value;

                var list = HidValue.split('^');


                if (document.getElementById('<%=iconHidOthers.ClientID %>').value != "") {
                    for (var count = 0; count < list.length - 1; count++) {
                        var OtherFees = list[count].split('~');
                        if (OtherFees[1] != '') {
                            if (OtherFees[0] != '') {
                                rwNumber = parseInt(parseInt(OtherFees[0]) + parseInt(1));
                            }
                            if (OtherFeeType != '') {
                                if (OtherFees[1] == OtherFeeType) {
                                    AddStatus = 1;

                                }
                            }
                        }
                    }
                }

                else {

                    if (OtherFeeType != '') {
                        var row = document.getElementById('<%=tblOthers.ClientID %>').insertRow(0);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOtherFees(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "10%%";
                        cell2.innerHTML = OtherFeeType;
                        cell3.innerHTML = OtherAmount;
                        cell4.innerHTML = "<input onclick='javascript:btnEditOtherFeeClick(this.id);' id='" + parseInt(rwNumber) + "~" + OtherFeeType + "~" + OtherAmount + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        document.getElementById('<%=iconHidOthers.ClientID %>').value += parseInt(rwNumber) + "~" + OtherFeeType + "~" + OtherAmount + "^";
                        AddStatus = 2;
                    }
                }

                if (AddStatus == 0) {
                    if (OtherFeeType != '') {
                        var row = document.getElementById('<%=tblOthers.ClientID %>').insertRow(0);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOtherFees(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "10%%";
                        cell2.innerHTML = OtherFeeType;
                        cell3.innerHTML = OtherAmount;
                        cell4.innerHTML = "<input onclick='javascript:btnEditOtherFeeClick(this.id);' id='" + parseInt(rwNumber) + "~" + OtherFeeType + "~" + OtherAmount + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        document.getElementById('<%=iconHidOthers.ClientID %>').value += parseInt(rwNumber) + "~" + OtherFeeType + "~" + OtherAmount + "^";
                    }
                }
                else if (AddStatus == 1) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_7');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert("Fee Type Already Added!");
                    }
                }
                document.getElementById('<%=txtOtherAmount.ClientID %>').value = '';
                document.getElementById('<%=txtOtherFeeType.ClientID %>').value = '';
                return false;
            }
        }
    }
    // Delete  other Fees
    function ImgOnclickOtherFees(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidOthers.ClientID %>').value;
        var list = HidValue.split('^');
        var newOtherList = '';
        if (document.getElementById('<%=iconHidOthers.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var OthersFees = list[count].split('~');
                if (OthersFees[0] != '') {
                    if (OthersFees[0] != ImgID) {
                        newOtherList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidOthers.ClientID %>').value = newOtherList;
        }
        if (document.getElementById('<%=iconHidOthers.ClientID %>').value == '') {
            document.getElementById('<%=tblOthers.ClientID %>').style.display = 'none';
        }
    }

    //Edit other Fees
    function btnEditOtherFeeClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidOthers.ClientID %>').value;
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
            document.getElementById('<%=txtOtherFeeType.ClientID %>').value = arrayGotValue[1];
            document.getElementById('<%=txtOtherAmount.ClientID %>').value = arrayGotValue[2];
        }

        document.getElementById('<%=iconHidOthers.ClientID %>').value = tempDatas;
        LoadOtherFeeItems();

    }


    //Load other Fees
    function LoadOtherFeeItems() {
        var HidValue = document.getElementById('<%=iconHidOthers.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tblOthers.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblOthers.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblOthers.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidOthers.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var OtherFees = list[count].split('~');
                var row = document.getElementById('<%=tblOthers.ClientID %>').insertRow(0);
                row.id = OtherFees[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOtherFees(" + parseInt(OtherFees[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = OtherFees[1];
                cell3.innerHTML = OtherFees[2];
                cell4.innerHTML = "<input onclick='javascript:btnEditOtherFeeClick(this.id);' id='" + parseInt(OtherFees[0]) + "~" + OtherFees[1] + "~" + OtherFees[2] + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }


    // Add Instrumentation Charges
    function onInsChgClick() {


        if (document.getElementById('<%=txtInsChg.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Fees");
            }
        }
        else {
            var rwNumber = parseInt(500);
            var AddStatus = 0;
            document.getElementById('<%=tblInsChg.ClientID %>').style.display = 'block';
            var InsName = document.getElementById('<%= ddlInsChg.ClientID %>').options[document.getElementById('<%= ddlInsChg.ClientID %>').selectedIndex].text;
            var InsID = document.getElementById('<%= ddlInsChg.ClientID %>').options[document.getElementById('<%= ddlInsChg.ClientID %>').selectedIndex].value;
            var InsFee = document.getElementById('<%=txtInsChg.ClientID %>').value;
            var HidValue = document.getElementById('<%=hdnInsChg.ClientID %>').value;

            var list = HidValue.split('^');


            if (document.getElementById('<%=hdnInsChg.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var InsChgItems = list[count].split('~');
                    if (InsChgItems[1] != '') {
                        if (InsChgItems[0] != '') {
                            rwNumber = parseInt(parseInt(InsChgItems[0]) + parseInt(1));
                        }
                        if (InsName != '') {
                            if (InsChgItems[1] == InsName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (InsName != '') {
                    var row = document.getElementById('<%=tblInsChg.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsChg(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = InsName;
                    cell3.innerHTML = InsID;
                    cell3.style.display = "none";
                    cell4.innerHTML = InsFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditInsChgClick(this.id);' id='" + parseInt(rwNumber) + "~" + InsName + "~" + InsID + "~" + InsFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=hdnInsChg.ClientID %>').value += parseInt(rwNumber) + "~" + InsName + "~" + InsID + "~" + InsFee + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (InsName != '') {
                    var row = document.getElementById('<%=tblInsChg.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsChg(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = InsName;
                    cell3.innerHTML = InsID;
                    cell3.style.display = "none";
                    cell4.innerHTML = InsFee;
                    cell5.innerHTML = "<input onclick='javascript:btnEditInsChgClick(this.id);' id='" + parseInt(rwNumber) + "~" + InsName + "~" + InsID + "~" + InsFee + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=hdnInsChg.ClientID %>').value += parseInt(rwNumber) + "~" + InsName + "~" + InsID + "~" + InsFee + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Anesthetist Already Added!");
                }
            }
            document.getElementById('<%=txtInsChg.ClientID %>').value = '';

            return false;
        }
    }

    // Delete Instrumentation Charges

    function ImgOnclickInsChg(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnInsChg.ClientID %>').value;
        var list = HidValue.split('^');
        var newInsChgItemsList = '';
        if (document.getElementById('<%=hdnInsChg.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InsChgItems = list[count].split('~');
                if (InsChgItems[0] != '') {
                    if (InsChgItems[0] != ImgID) {
                        newInsChgItemsList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnInsChg.ClientID %>').value = newInsChgItemsList;
        }
        if (document.getElementById('<%=hdnInsChg.ClientID %>').value == '') {
            document.getElementById('<%=tblInsChg.ClientID %>').style.display = 'none';
        }
    }

    //Edit Instrumentation Charges


    function btnEditInsChgClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnInsChg.ClientID %>').value;
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
            document.getElementById('<%=ddlInsChg.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtInsChg.ClientID %>').value = arrayGotValue[3];
        }

        document.getElementById('<%=hdnInsChg.ClientID %>').value = tempDatas;
        LoadInsChgItems();

    }
    //Load Instrumentation Charges

    function LoadInsChgItems() {
        var HidValue = document.getElementById('<%=hdnInsChg.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tblInsChg.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblInsChg.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblInsChg.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=hdnInsChg.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var InsChgItems = list[count].split('~');
                var row = document.getElementById('<%=tblInsChg.ClientID %>').insertRow(0);
                row.id = InsChgItems[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsChg(" + parseInt(InsChgItems[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = InsChgItems[1]; ;
                cell3.innerHTML = InsChgItems[2];
                cell3.style.display = "none";
                cell4.innerHTML = InsChgItems[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditInsChgClick(this.id);' id='" + parseInt(InsChgItems[0]) + "~" + InsChgItems[1] + "~" + InsChgItems[2] + "~" + InsChgItems[3] + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %> ' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }




         
</script>

<div id="Common">
    <table id="tblCommon" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" >
        <tr>
            <td style="width: 229px;">
                <asp:Label Text=" Select Surgery / Intervention" runat="server" ID="lblSoi"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlIPTreatmentPlanMaster" runat="server" CssClass="ddlsmall"
                    onchange="javascript:showIPTreatmentPlanChild(this.value);">
                </asp:DropDownList>
                <asp:HiddenField ID="hdnSurgeryBillingID" Value="" runat="server" />
            </td>
             <td width ="50%" rowspan ="4">
            <table id ="tblSplitUps" class ="dataheaderInvCtrl" style="display: none">
           <%-- <tr class = "dataheader1">
            <td>
            <asp:Label ID ="lblfD" runat ="server" Text ="FeeDescription"></asp:Label>
            </td>
            <td>
            <asp:Label ID ="lblAmt" runat ="server" Text ="Amount"></asp:Label>
            </td>
            </tr>--%>
          
            </table>
            </td>
        </tr>
        
        <tr>
            <td style="width: 229px;">
                <asp:Label ID="lbltretmntname" runat="server" Text="Treatment Name" meta:resourcekey="lbltretmntnameResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlIPTreatmentPlanChild" runat="server" CssClass="ddlsmall"
                    onchange="javascript:getIPTreatmentName();DDLonChange(this.value)">
                </asp:DropDownList>
                <div id="divOthers" style="display: none" runat="server">
                    <asp:TextBox ID="txtOthers" runat="server"></asp:TextBox>
                </div>
                <input type="hidden" id="hdnIPTreatmentPlanChild" runat="server" />
                <input type="hidden" id="hdnIPTreatmentRate" runat="server" />
                <asp:HiddenField ID="hdntreatmentID" Value="" runat="server" />
                <input id="hdnTID" type="hidden" runat="server" />
                <asp:HiddenField ID="hdntreatmentName" Value="" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 229px;">
                <asp:Label ID="lbldtandtime" runat="server" Text="Date And Time Of Billing" meta:resourcekey="lbldtandtimeResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtBillDate" CssClass="Txtboxsmall" MaxLength="25"
                    size="25"> </asp:TextBox>
                <a href="javascript:NewCal('<%=txtBillDate.ClientID %>','ddmmyyyy',true,12)">
                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
            </td>
        </tr>
        <tr>
            <td style="width: 229px;">
                <asp:Label ID="lblsurgfee" runat="server" Text="Surgical Fee" meta:resourcekey="lblsurgfeeResource1"></asp:Label>
            </td>
            <td nowrap="nowrap">
                <asp:TextBox ID="txtSurgigalFee" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                    autocomplete="off" MaxLength="19"></asp:TextBox>
                <asp:HiddenField ID="hdnDiscEnhc" Value="" runat="server" />
                <asp:HiddenField ID="hdnDiscEnhctype" Value="" runat="server" />
                <asp:HiddenField ID="hdnRemark" Value="" runat="server" />
                 <asp:CheckBox ID="chkShowDeatils" Text="" runat="server" onclick="ShowFeeDeatils()" />
                <asp:Label Text="ShowFeeDeatils" ID="lblShowDeatils" runat="server" ></asp:Label>
            </td>
           
        </tr>
    </table>
         <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
                    runat="server" id="tbSurgery" style="display: none">
                    <tr style="height: 10px;">
                        <td style="font-weight: normal; color: #000;" colspan="2" align="center">
                            <input type="hidden" id="pid" name="pid" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:GridView ID="gvTreatment" runat="server" AutoGenerateColumns="False" DataKeyNames="SurgeryBillingID"
                                OnRowDataBound="gvTreatment_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSurgeryBillingID" runat="server" Text='<%#Bind("SurgeryBillingID") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="14%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Treatment Name" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%#Bind("TreatmentName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Performed By" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPhysicianName" runat="server" Text='<%#Bind("ChiefSurgeonName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreatedAt" runat="server" Text='<%#Bind("CreatedAt") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblamount" runat="server" Text='<%#Bind("SurgicalFee") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnEditOperationNotes" runat="server" Text="Edit" CssClass="btn"
                                OnClientClick="return pValidationTreatment()" OnClick="btnEditOperationNotes_Click" />
                            <%--<asp:Button ID="btnEditOperationCancel" runat="server" Text="Cancel" CssClass="btn"
                                                    OnClick="btnEditOperationCancel_Click" />--%>
                        </td>
                    </tr>
                </table>
    
</div>
<div id="divSurgeryNonDefined" style="display: none" runat="server">
    <table id="tblSurgeryNonDefined" cellpadding="0" cellspacing="0" border="0" width="100%"
        align="center" class="dataheaderInvCtrl">
        <tr>
            <td>
           
            </td>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table2" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td style="width: 229px;">
                            <asp:Label ID="lblselectcheifsurg" runat="server" Text="Select Chief Surgeon" meta:resourcekey="lblselectcheifsurgResource1"></asp:Label>
                        </td>
                        <td style="width: 250px;">
                            <asp:TextBox ID="txtddlChief" runat="server" ToolTip="Enter Text Here" CssClass="Txtboxsmall"
                                onkeyup="FilterItemsC(this.value)" onblur="AddddlChief()" />
                            <asp:Label ID="lblsearchchefsurg" runat="server" Text="search Your Cheif Surgeon"
                                meta:resourcekey="lblsearchchefsurgResource1" Style="font-size: 8pt; color: red;"></asp:Label>
                            <asp:DropDownList ID="ddlChief" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtddlChief"
                                WatermarkText="Type Chief Surgeon" />
                        </td>
                        <td style="width: 145px;">
                            <asp:Label ID="lblcheifsurgeon" runat="server" Text="Chief Surgeon Fee" meta:resourcekey="lblcheifsurgResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtChiefSurgenFee" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                <%--    </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
            <%--<td>
                <table id="Table10" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td style="width: 130px;">
                            <asp:Label ID="lblselectasstsurg" runat="server" Text="Select Assistant Surgeon"
                                meta:resourcekey="lblselectasstsurgResource1"></asp:Label>
                        </td>
                        <td style="width: 250px;">
                            <asp:TextBox ID="txtddlAssistent" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here"
                                onkeyup="FilterItemsAS(this.value)" onblur="AddddlAssistent()" />
                            <label style="font-size: 8pt; color: red;">
                                *<asp:Label ID="lblsearchasstsurg" runat="server" Text="search Your Assistant Surgeon"
                                    meta:resourcekey="lblsearchasstsurgResource1"></asp:Label></label>
                            <asp:DropDownList ID="ddlAssistent" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtddlAssistent"
                                WatermarkText="Type  Assistant Surgeon" />
                        </td>
                        <td style="width:100px;">
                            <asp:Label ID="lblasstsurgfee" runat="server" Text="Assistant Surgeon Fee" meta:resourcekey="lblasstsurgfeeResource1"></asp:Label>
                        </td>
                        <td style="width: 100px;">
                            <asp:TextBox ID="txtAssistent" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                        <td style="width: 100px;">
                            <input type="button" name="btnAssistent" id="btnAssistent" onclick="onAssistantOperatorClickdefined();"
                                value="Add" class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:HiddenField ID="iconHidAssistant" Value="" runat="server" />
                            <table id="Table11" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                align="center">
                                <%--   <tr id="trAnesthetist" style="display: none">
                                <td style="width: 63px;">
                                </td>
                                <td style="width: 260px;">
                                    Dr Name
                                </td>
                                <td colspan="2">
                                    Amount
                                </td>
                            </tr>--%>
                                <tr>
                                    <td colspan="4">
                                        <table id="tbAssistent" cellpadding="4" runat="server" cellspacing="0" border="0"
                                            width="100%" align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                <%--    </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
            <%--<td>
                <table id="Table5" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td style="width: 230px;">
                            <asp:Label ID="lblslctanestht" runat="server" Text="Select Anesthetist" meta:resourcekey="lblslctanesthtResource1"></asp:Label>
                        </td>
                        <td style="width: 250px;">
                            <asp:TextBox ID="txtddlAnesthetist" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here"
                                onkeyup="FilterItemsAN(this.value)" onblur="AddddlAnesthetist()" />
                            <label style="font-size: 8pt; color: red;">
                                *
                                <asp:Label ID="lblsearchanethst" runat="server" Text="search Your Anesthetist" meta:resourcekey="lblsearchanethstResource1"></asp:Label></label>
                            <asp:DropDownList ID="ddlAnesthetist" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtddlAnesthetist"
                                WatermarkText="Type Anesthetist Name" />
                        </td>
                        <td style="width: 100px;">
                            <asp:Label ID="lblanesthstfee" runat="server" Text="Anesthetist Fee" meta:resourcekey="lblanesthstfeeResource1"></asp:Label>
                        </td>
                        <td style="width: 100px;">
                            <asp:TextBox ID="txtAnesthetist" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                        <td>
                            <input type="button" name="btnAnesthetist" id="btnAnesthetist" onclick="onAnesthetistOperatorClick();"
                                value="Add" class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:HiddenField ID="iconHidAnesthetist" Value="" runat="server" />
                            <table id="Table6" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                align="center">
                                <%--   <tr id="trAnesthetist" style="display: none">
                                <td style="width: 63px;">
                                </td>
                                <td style="width: 260px;">
                                    Dr Name
                                </td>
                                <td colspan="2">
                                    Amount
                                </td>
                            </tr>--%>
                                <tr>
                                    <td colspan="4">
                                        <table id="tbAnesthetist" cellpadding="4" runat="server" cellspacing="0" border="0"
                                            width="100%" align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                  <%--  </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
          <%--  <td>
                <table id="Table7" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td style="width: 100px;">
                            <asp:Label ID="lblinstchrge" runat="server" Text="Instrumentation Charges" meta:resourcekey="lblinstchrgeResource1"></asp:Label>
                        </td>
                        <td style="width: 80px;">
                            <asp:DropDownList ID="ddlInsChg" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 100px;">
                            <asp:Label ID="lblamnt" runat="server" Text="Amount" meta:resourcekey="lblamntResource1"></asp:Label>
                        </td>
                        <td style="width: 100px;" >
                            <asp:TextBox ID="txtInsChg" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                        <td style="width: 100px;">
                            <input type="button" name="btnInsChg" id="btnInsChg" onclick="onInsChgClick();" value="Add"
                                class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:HiddenField ID="hdnInsChg" Value="" runat="server" />
                            <table id="tblInsChgH" cellpadding="4" runat="server" cellspacing="0" border="0"
                                width="100%" align="center">
                                <%--<tr id="trInsHeader" style="display: none">
                                <td style="width: 63px;">
                                </td>
                                <td style="width: 260px;">
                                    Instrumentation Charges
                                </td>
                                <td colspan="2">
                                    Amount
                                </td>
                            </tr>--%>
                                <tr>
                                    <td colspan="4">
                                        <table id="tblInsChg" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                            align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
               <%--     </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table8" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td>
                            <asp:Label ID="lblOTchrge" runat="server" Text="OT Charges" meta:resourcekey="lblOTchrgeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOTCharges" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblreclabroomchrg" runat="server" Text="Recovery / Labour Room Charges"
                                meta:resourcekey="lblreclabroomchrgResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtlabourCharges" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblconsumables" runat="server" Text="Consumables" meta:resourcekey="lblconsumablesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConsumablesCharges" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lbldevprotimplnt" runat="server" Text="Device / Prosthesis / Implant"
                                meta:resourcekey="lbldevprotimplntResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtProsthesis" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
              <%--  </table>
                <br />
            </td>--%>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table9" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td style="width: 229px;">
                            <asp:Label ID="lblotherfeetyp" runat="server" Text="Others Fee Type" meta:resourcekey="lblotherfeetypResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherFeeType" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                        </td>
                        <td style="width: 155px;">
                            <asp:Label ID="lbamont" runat="server" Text="Amount" meta:resourcekey="lbamontResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherAmount" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"   
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                        <td>
                            <input type="button" name="btnOthers" id="btnOthers" onclick="onOthersClick();" value="Add"
                                class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:HiddenField ID="iconHidOthers" Value="" runat="server" />
                            <asp:HiddenField ID="hdnSurgeryAmount" Value="0.00" runat="server" />
                            <table id="tblOthers" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                class="dataheaderInvCtrl">
                                <tr>
                                </tr>
                            </table>
                        </td>
                <%--    </tr>
                </table>
                <br />
            </td>--%>
        </tr>
    </table>
</div>
<div id="divSurgeryFeeDefined" style="display: block" runat="server">
    <table id="Table1" cellpadding="0" cellspacing="0" border="0" width="100%" align="center"
        class="dataheaderInvCtrl">
        <tr>
            <td>
                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
                    runat="server" id="Table3" style="display: none">
                    <tr style="height: 10px;">
                        <td style="font-weight: normal; color: #000;" colspan="2" align="center">
                            <input type="hidden" id="hdndefinedpid" name="piddefined" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SurgeryBillingID"
                                OnRowDataBound="gvTreatment_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSurgeryBillingID" runat="server" Text='<%#Bind("SurgeryBillingID") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="14%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Treatment Name" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%#Bind("TreatmentName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Performed By" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPhysicianName" runat="server" Text='<%#Bind("ChiefSurgeonName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreatedAt" runat="server" Text='<%#Bind("CreatedAt") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblamount" runat="server" Text='<%#Bind("SurgicalFee") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="Button1" runat="server" Text="Edit" CssClass="btn" OnClientClick="return pValidationTreatment()"
                                OnClick="btnEditOperationNotes_Click" />
                            <%--<asp:Button ID="btnEditOperationCancel" runat="server" Text="Cancel" CssClass="btn"
                                                    OnClick="btnEditOperationCancel_Click" />--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
         <%--   <td>
                <table id="Table4" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td>
                            <asp:Label ID="lblCheifsurgeonname" runat="server" Text="Select Chief Surgeon" meta:resourcekey="lblselectcheifsurgResource1"></asp:Label>
                        </td>
                        
                        <td width ="300px">
                            <asp:TextBox ID="txtCheifSurgeon" runat="server" ToolTip="Enter Text Here" CssClass="Txtboxsmall"
                                onkeyup="FilterItemsC(this.value)" onblur="AddddlChiefDefined()" />
                            <asp:Label ID="lblsearchCheif" runat="server" Text="search Your Cheif Surgeon" Style="font-size: 8pt;
                                color: red;"></asp:Label> 
                            </td>    <td>
                            <asp:DropDownList ID="DrpCheifSurgeon" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtendercheifSurgeon" runat="server"
                                TargetControlID="txtCheifSurgeon" WatermarkText="Type Chief Surgeon" />
                        </td>
                 <%--    </tr>
               </table>
                <br />
            </td>--%>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table12" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td >
                            <asp:Label ID="lblAssistantSurgeon" runat="server" Text="Select Assistant Surgeon"></asp:Label>
                        </td>
                        <td >
                            <asp:TextBox ID="txtAssistantSurgeion" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here"
                                onkeyup="FilterItemsAS(this.value)" onblur="AddddlAssistentDefined()" />
                            <label style="font-size: 8pt; color: red;">
                                *<asp:Label ID="Label5" runat="server" Text="search Your Assistant Surgeon" meta:resourcekey="lblsearchasstsurgResource1"></asp:Label></label>
                            </td>    <td>
                            <asp:DropDownList ID="DrpAssistantSurgeon" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderAssistantSurgeon" runat="server"
                                TargetControlID="txtAssistantSurgeion" WatermarkText="Type  Assistant Surgeon" />
                 <%--    </td>
                        <td>--%>
                            <input type="button" name="btnAssistentSurgeon" id="btnAssistantSurgeonDefined" onclick="onAssistantOperatorClickDefined();"
                                value="Add" class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:HiddenField ID="iconHidAssistantdefined" Value="" runat="server" />
                            <table id="tbassistantDefined" cellpadding="4" runat="server" cellspacing="0" border="0"
                                width="100%" align="center">
                                <tr>
                                    <td colspan="3">
                                        <table id="Table14" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                            align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    <%--   </tr>
             </table>
                <br />
            </td>--%>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table15" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>--%>
                        <td >
                            <asp:Label ID="lblAnesthesiast" runat="server" Text="Select Anesthetist" meta:resourcekey="lblslctanesthtResource1"></asp:Label>
                        </td>
                        <td >
                            <asp:TextBox ID="txtAnesthesiast" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here"
                                onkeyup="FilterItemsAN(this.value)" onblur="AddddlAnesthetistDefined()" />
                            <label style="font-size: 8pt; color: red;">
                                *
                                <asp:Label ID="Label8" runat="server" Text="search Your Anesthetist" meta:resourcekey="lblsearchanethstResource1"></asp:Label></label>
                                &nbsp;   &nbsp;&nbsp;
                                </td>    <td>
                            <asp:DropDownList ID="DrpAnesthesiast" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderAnesthesiast" runat="server"
                                TargetControlID="txtAnesthesiast" WatermarkText="Type Anesthetist Name" />
                      <%--  </td>
                        <td>--%>
                            <input type="button" name="btnAnesthetistD" id="btnAnesthesiastDefined" onclick="onAnesthetistOperatorClickDefined();"
                                value="Add" class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:HiddenField ID="iconHidAnesthetistDefined" Value="" runat="server" />
                            <table id="tbAnesthesiastdefined" cellpadding="4" runat="server" cellspacing="0"
                                border="0" width="100%" align="center">
                                <tr>
                                    <td colspan="4">
                                        <table id="Table17" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                            align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                <%--    </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
           <%-- <td>
                <table id="tableNurse" cellpadding="0" runat="server" cellspacing="0" border="0"
                    width="100%">
                    <tr>--%>
                        <td >
                            <asp:Label ID="lblnurseName" runat="server" Text="Select Nurse Name" meta:resourcekey="lblslctanesthtResource1"></asp:Label>
                        </td>
                        <td >
                            <asp:TextBox ID="txtNurse" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here"
                                onkeyup="FilterItemsNurse(this.value)" onblur="AddddlNurseDefined()" />
                            <label style="font-size: 8pt; color: red;">
                                *
                                <asp:Label ID="Label2" runat="server" Text="search Your Nurse" meta:resourcekey="lblsearchanethstResource1"></asp:Label></label>
                                </td>    <td>
                            <asp:DropDownList ID="drpNurse" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" TargetControlID="txtNurse"
                                WatermarkText="Type Nusre Name" />
                      <%--  </td>
                        <td>--%>
                            <input type="button" name="btnnurse" id="btnNurse" onclick="onNurseClickDefined();"
                                value="Add" class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:HiddenField ID="iconHidNurseDefined" Value="" runat="server" />
                            <table id="tblnurseDefined" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                align="center">
                                <tr>
                                    <td colspan="4">
                                        <table id="Table24" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                            align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
               <%--     </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
            <td>
             <%--   <table id="Table18" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblInstruments" runat="server" Text="Instrumentation Charges"
                                meta:resourcekey="lblinstchrgeResource1"></asp:Label>
                        </td>
                         <td>
                            <asp:TextBox ID="txtInstrumentdefined" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19" onblur =AddddlInstrumentDefined();></asp:TextBox>
                        </td>
                        <td style="width: 160px;">
                            <asp:DropDownList ID="drpinstrumentnames" CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <input type="button" name="btnInsChg" id="Button4" onclick="onInsChgClickDefined();" value="Add"
                                class="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:HiddenField ID="hdninsdefined" Value="" runat="server" />
                            <table id="tblinsdefined" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                align="center">
                             
                                <tr>
                                    <td colspan="4">
                                        <table id="Table20" cellpadding="4" runat="server" cellspacing="0" border="0" width="100%"
                                            align="center">
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
                <br />
            </td>
        </tr>
        <tr>
           <%-- <td>
                <table id="Table21" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%"
                    title="Optional">
                    <tr>--%>
                        <td>
                            <asp:Label ID="lblOtCharges" runat="server" Text="OT Charges" meta:resourcekey="lblOTchrgeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOTChargesdefined" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblRoonCharges" runat="server" Text="Recovery / Labour Room Charges"
                                meta:resourcekey="lblreclabroomchrgResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRoomChargesdefined" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblconsumablesDefined" runat="server" Text="Consumables" meta:resourcekey="lblconsumablesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefinedConsumablesCharges" runat="server" CssClass="Txtboxsmall"
                                   onkeypress="return ValidateOnlyNumeric(this);"   autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 229px;">
                            <asp:Label ID="lblprosthesis" runat="server" Text="Device / Prosthesis / Implant"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefinedProsthesis" runat="server" CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                autocomplete="off" MaxLength="19"></asp:TextBox>
                        </td>
                 <%--   </tr>
                </table>
                <br />
            </td>--%>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="hdnIsSurgeryDefined" Value="N" runat="server" />
<asp:HiddenField ID ="hdnRateID" Value ="0" runat ="server" />
<asp:HiddenField ID ="hdnselectedTreatmentPlanID" runat ="server" />

<script language="javascript" type="text/javascript">
    showIPTreatmentPlanChild(document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID %>').value);
    //    document.getElementById('<%=hdntreatmentID.ClientID %>').value = document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID %>').value;
    //    document.getElementById('<%=hdntreatmentName.ClientID %>').value = document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').options[document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').selectedIndex].text;

    LoadAssistantOperatorItems();
    LoadAnesthetistOperatorItems();
    LoadOtherFeeItems();
    LoadInsChgItems();



    function onAssistantOperatorClickDefined() {
   
        if (document.getElementById('<%=txtAssistantSurgeion.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Fees");
            }
        }
        else {
            var rwNumber = parseInt(1);
            var AddStatus = 0;
            document.getElementById('<%=tbassistantDefined.ClientID %>').style.display = 'block';
            var AssistentName = document.getElementById('<%= DrpAssistantSurgeon.ClientID %>').options[document.getElementById('<%= DrpAssistantSurgeon.ClientID %>').selectedIndex].text;
            var AssistentID = document.getElementById('<%= DrpAssistantSurgeon.ClientID %>').options[document.getElementById('<%= DrpAssistantSurgeon.ClientID %>').selectedIndex].value;
//            var AssistentFee = document.getElementById('<%=txtAssistantSurgeion.ClientID %>').value;
            var HidValue = document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value;

            var list = HidValue.split('^');

            if (document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var AssistantOperator = list[count].split('~');
                    if (AssistantOperator[1] != '') {
                        if (AssistantOperator[0] != '') {
                            rwNumber = parseInt(parseInt(AssistantOperator[0]) + parseInt(1));
                        }
                        if (AssistentName != '') {
                            if (AssistantOperator[1] == AssistentName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (AssistentName != '') {
                    var row = document.getElementById('<%=tbassistantDefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistentdefined(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = AssistentName;
                    cell3.innerHTML = AssistentID;
                    cell3.style.display = "none";
//                    cell4.innerHTML = AssistentFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClickDefined(this.id);' id='" + parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value += parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (AssistentName != '') {
                    var row = document.getElementById('<%=tbassistantDefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistentdefined(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = AssistentName;
                    cell3.innerHTML = AssistentID;
                    cell3.style.display = "none";
//                    cell4.innerHTML = AssistentFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClickDefined(this.id);' id='" + parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value += parseInt(rwNumber) + "~" + AssistentName + "~" + AssistentID + "~" + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Assistant Already Added!");
                }
            }
            document.getElementById('<%=txtAssistantSurgeion.ClientID %>').value = '';
            return false;
        }
    }



    ////

    // Add AnesthetistOperator
    function onAnesthetistOperatorClickDefined() {
   
        if (document.getElementById('<%=txtAnesthesiast.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Fees");
            }
        }
        else {
            var rwNumber = parseInt(200);
            var AddStatus = 0;
            document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').style.display = 'block';
            var AnesthetistName = document.getElementById('<%= DrpAnesthesiast.ClientID %>').options[document.getElementById('<%= DrpAnesthesiast.ClientID %>').selectedIndex].text;
            var AnesthetistID = document.getElementById('<%= DrpAnesthesiast.ClientID %>').options[document.getElementById('<%= DrpAnesthesiast.ClientID %>').selectedIndex].value;
//            var AnesthetistFee = document.getElementById('<%=txtAnesthesiast.ClientID %>').value;
            var HidValue = document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value;

            var list = HidValue.split('^');


            if (document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var AnesthetistOperator = list[count].split('~');
                    if (AnesthetistOperator[1] != '') {
                        if (AnesthetistOperator[0] != '') {
                            rwNumber = parseInt(parseInt(AnesthetistOperator[0]) + parseInt(1));
                        }
                        if (AnesthetistName != '') {
                            if (AnesthetistOperator[1] == AnesthetistName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (AnesthetistName != '') {
                    var row = document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetistDefined(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = AnesthetistName;
                    cell3.innerHTML = AnesthetistID;
                   cell3.style.display = "none";
//                    cell4.innerHTML = AnesthetistFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClickefined(this.id);' id='" + parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value += parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (AnesthetistName != '') {
                    var row = document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetistDefined(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = AnesthetistName;
                    cell3.innerHTML = AnesthetistID;
                   cell3.style.display = "none";
//                    cell4.innerHTML = AnesthetistFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClickefined(this.id);' id='" + parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value += parseInt(rwNumber) + "~" + AnesthetistName + "~" + AnesthetistID + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Anesthetist Already Added!");
                }
            }
            document.getElementById('<%=txtAnesthesiast.ClientID %>').value = '';

            return false;
        }
    }

    function btnEditAnesthetistClickefined(sEditedData) {

   
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value;
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
            document.getElementById('<%=DrpAnesthesiast.ClientID %>')[0].value = arrayGotValue[0];
            document.getElementById('<%=txtAnesthesiast.ClientID %>').value = arrayGotValue[1];
        }

        document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value = tempDatas;
        LoadAnesthetistOperatorItemsDefined();

    }



    function LoadAnesthetistOperatorItemsDefined() {
        var HidValue = document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var AnesthetistOperator = list[count].split('~');
                var row = document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').insertRow(0);
                row.id = AnesthetistOperator[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetistDefined(" + parseInt(AnesthetistOperator[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = AnesthetistOperator[1]; ;
                cell3.innerHTML = AnesthetistOperator[2];
                cell3.style.display = "none";
                cell4.innerHTML = AnesthetistOperator[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditAnesthetistClickefined(this.id);' id='" + parseInt(AnesthetistOperator[0]) + "~" + AnesthetistOperator[1] + "~" + AnesthetistOperator[2] +  "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }

    /////////////\


    ///
    function onNurseClickDefined() {
      
        if (document.getElementById('<%=txtNurse.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter The Nurse name ");
            }
        }
        else {
            var rwNumber = parseInt(200);
            var AddStatus = 0;
            document.getElementById('<%=tblnurseDefined.ClientID %>').style.display = 'block';
            var NurseName = document.getElementById('<%= drpNurse.ClientID %>').options[document.getElementById('<%= drpNurse.ClientID %>').selectedIndex].text;
            var NurseID = document.getElementById('<%= drpNurse.ClientID %>').options[document.getElementById('<%= drpNurse.ClientID %>').selectedIndex].value;
//            var AnesthetistFee = document.getElementById('<%=txtNurse.ClientID %>').value;
            var HidValue = document.getElementById('<%=iconHidNurseDefined.ClientID %>').value;

            var list = HidValue.split('^');


            if (document.getElementById('<%=iconHidNurseDefined.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var AnesthetistOperator = list[count].split('~');
                    if (AnesthetistOperator[1] != '') {
                        if (AnesthetistOperator[0] != '') {
                            rwNumber = parseInt(parseInt(AnesthetistOperator[0]) + parseInt(1));
                        }
                        if (NurseName != '') {
                            if (AnesthetistOperator[1] == NurseName) {
                                AddStatus = 1;

                            }
                        }
                    }
                }
            }

            else {

                if (NurseName != '') {
                    var row = document.getElementById('<%=tblnurseDefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNurse(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%%";
                    cell2.innerHTML = NurseName;
                    cell3.innerHTML = NurseID;
                    cell3.style.display = "none";
//                    cell4.innerHTML = AnesthetistFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditNurseClick(this.id);' id='" + parseInt(rwNumber) + "~" + NurseName + "~" + NurseID + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidNurseDefined.ClientID %>').value += parseInt(rwNumber) + "~" + NurseName + "~" + NurseID + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (NurseName != '') {
                    var row = document.getElementById('<%=tblnurseDefined.ClientID %>').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNurse(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = NurseName;
                    cell3.innerHTML = NurseID;
                    cell3.style.display = "none";
//                    cell4.innerHTML = AnesthetistFee;
//                    cell4.style.display = "none";
                    cell5.innerHTML = "<input onclick='javascript:btnEditNurseClick(this.id);' id='" + parseInt(rwNumber) + "~" + NurseName + "~" + NurseID + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('<%=iconHidNurseDefined.ClientID %>').value += parseInt(rwNumber) + "~" + NurseName + "~" + NurseID + "^";
                }
            }
            else if (AddStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryBilling.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Nurse name Already Added!");
                }
            }
            document.getElementById('<%=txtNurse.ClientID %>').value = '';

            return false;
        }
    }



    function DDLonChange(TreatementPlanID) {
 
        //  $('#hdnselectedTreatmentPlanID').val() = TreatementPlanID;
       
     
        var Rates = $('[id$="hdnIPTreatmentRate"]').val();

        var RateID = $('[id$="hdnRateID"]').val();
        var elements = Rates.split('^');

        console.log(elements);
      
        
        
      // var nextItems = elements.split(',');
        $.each(elements, function(index, Item) {
            var Items = elements[index].split('~');
            for (var k = 0; k < Items.length; k++) {
                var SOID = Items[k];
                if (SOID == TreatementPlanID) {
                    $('[id$="txtSurgigalFee"]').val(SOID[2]);

                }
            }

        


        });
      
     SurgicalFeeGetSplitUps(TreatementPlanID);
   
    
    }



    //DELETE OPERATIONS

    function ImgOnclickAssistentdefined(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value;
        var list = HidValue.split('^');
        var newAssistantOperatorList = '';
        if (document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var AssistantOperator = list[count].split('~');
                if (AssistantOperator[0] != '') {
                    if (AssistantOperator[0] != ImgID) {
                        newAssistantOperatorList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value = newAssistantOperatorList;
        }
        if (document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value == '') {
            document.getElementById('<%=tbassistantDefined.ClientID %>').style.display = 'none';
        }
    }
    //END

    function ImgOnclickAnesthetistDefined(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value;
        var list = HidValue.split('^');
        var newAnesthetistOperatorList = '';
        if (document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var AnesthetistOperator = list[count].split('~');
                if (AnesthetistOperator[0] != '') {
                    if (AnesthetistOperator[0] != ImgID) {
                        newAnesthetistOperatorList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value = newAnesthetistOperatorList;
        }
        if (document.getElementById('<%=iconHidAnesthetistDefined.ClientID %>').value == '') {
            document.getElementById('<%=tbAnesthesiastdefined.ClientID %>').style.display = 'none';
        }
    }



    function ImgOnclickNurse(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=iconHidNurseDefined.ClientID %>').value;
        var list = HidValue.split('^');
        var newAnesthetistOperatorList = '';
        if (document.getElementById('<%=iconHidNurseDefined.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var AnesthetistOperator = list[count].split('~');
                if (AnesthetistOperator[0] != '') {
                    if (AnesthetistOperator[0] != ImgID) {
                        newAnesthetistOperatorList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=iconHidNurseDefined.ClientID %>').value = newAnesthetistOperatorList;
        }
        if (document.getElementById('<%=iconHidNurseDefined.ClientID %>').value == '') {
            document.getElementById('<%=tblnurseDefined.ClientID %>').style.display = 'none';
        }
    }

    //DELETE FUNCTIONS END

    //EDIT FUNCTIONS STARTED ------

    function btnEditAssistentClickDefined(sEditedData) {
     
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value;
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
            document.getElementById('<%=DrpAssistantSurgeon.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtAssistantSurgeion.ClientID %>').value = arrayGotValue[1];
        }

        document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value = tempDatas;
        LoadAssistantOperatorItemsdefined();

    }


    function LoadAssistantOperatorItemsdefined() {
        var HidValue = document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tbassistantDefined.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tbassistantDefined.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tbassistantDefined.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidAssistantdefined.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var AssistantOperator = list[count].split('~');
                var row = document.getElementById('<%=tbassistantDefined.ClientID %>').insertRow(0);
                row.id = AssistantOperator[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssistentdefined(" + parseInt(AssistantOperator[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = AssistantOperator[1]; ;
                cell3.innerHTML = AssistantOperator[2];
                cell3.style.display = "none";
//                cell4.innerHTML = AssistantOperator[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditAssistentClickDefined(this.id);' id='" + parseInt(AssistantOperator[0]) + "~" + AssistantOperator[1] + "~" + AssistantOperator[2] + "~" + AssistantOperator[3] + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }



    function btnEditNurseClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=iconHidNurseDefined.ClientID %>').value;
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
            document.getElementById('<%=drpNurse.ClientID %>').value = arrayGotValue[2];
            document.getElementById('<%=txtNurse.ClientID %>').value = arrayGotValue[3];
        }

        document.getElementById('<%=iconHidNurseDefined.ClientID %>').value = tempDatas;
        LoadNurseItems();

    }

    function LoadNurseItems() {
        var HidValue = document.getElementById('<%=iconHidNurseDefined.ClientID %>').value;
        var list = HidValue.split('^');


        while (count = document.getElementById('<%=tblnurseDefined.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblnurseDefined.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblnurseDefined.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=iconHidNurseDefined.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var AnesthetistOperator = list[count].split('~');
                var row = document.getElementById('<%=tblnurseDefined.ClientID %>').insertRow(0);
                row.id = AnesthetistOperator[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNurse(" + parseInt(AnesthetistOperator[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "10%%";
                cell2.innerHTML = AnesthetistOperator[1]; ;
                cell3.innerHTML = AnesthetistOperator[2];
                cell3.style.display = "none";
                cell4.innerHTML = AnesthetistOperator[3];
                cell5.innerHTML = "<input onclick='javascript:btnEditNurseClick(this.id);' id='" + parseInt(AnesthetistOperator[0]) + "~" + AnesthetistOperator[1] + "~" + AnesthetistOperator[2] + "~" + AnesthetistOperator[3] + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }



    function SurgicalFeeGetSplitUps(TreatmentPlanID) {

        $.ajax({
        type: "POST",
            url: "../OPIPBilling.asmx/GetSurgicalFeeSplitUps",
            data: "{'TreatmentPlanID':'" + TreatmentPlanID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data, value) {
                var GetData = data.d;
                Drawtable(GetData);
                if (GetData.length > 0) {
                    document.getElementById('<%=chkShowDeatils.ClientID %>').style.display = "block";
                    document.getElementById('<%=lblShowDeatils.ClientID %>').style.display = "block";
                    document.getElementById('<%=chkShowDeatils.ClientID %>').checked = true;
                    $('#tblSplitUps').show();
                }
                else {
                    document.getElementById('<%=chkShowDeatils.ClientID %>').style.display = "none";
                    document.getElementById('<%=lblShowDeatils.ClientID %>').style.display = "none";
                    document.getElementById('<%=chkShowDeatils.ClientID %>').checked = false;
                    $('#tblSplitUps').hide();
                }
             
            },
            error: function(result) {
                alert("Error");
            }
        });
        ShowFeeDeatils();
    }



    function Drawtable(GetData) {
    
     
        $('#tblSplitUps').empty();
        $('#tblSplitUps').append('<tr class = "dataheader1"><td><asp:Label ID ="lblfD" runat ="server" Text ="FeeDescription"></asp:Label></td><td><asp:Label ID ="lblAmt" runat ="server" Text ="Amount"></asp:Label></td></tr>');
        $.each(GetData, function(index, Item) {
      
            $('#tblSplitUps').append('<tr><td>' + Item.FeeDescription + '</td><td>' + Item.Amount + '</td></tr>');

        });
    }
    function ShowFeeDeatils() {

        if ($('#SurgeryBilling1_chkShowDeatils').attr('checked')) {
        
            $('#tblSplitUps').show();
        }
        else {
            $('#tblSplitUps').hide();
          
        }
    }
    

</script>

