<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryforProcedurePlanning.ascx.cs"
    Inherits="CommonControls_SurgeryforProcedurePlanning" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="PaymentTypeDetails.ascx" TagName="paymentType" TagPrefix="uc9" %>
<style type="text/css">
    .style3
    {
        e: wwidth:459px;
    }
    .style4
    {
        width: 252px;
    }
    .style6
    {
        width: 172px;
    }
    .style7
    {
        width: 253px;
    }
    .style8
    {
        width: 195px;
    }
</style>


 <style type="text/css">
        /*Calendar Control CSS*/.expand
        {
            background-image: url(images/plus.gif);
            width: 9px;
            height: 9px;
        }
        .collapse
        {
            background-image: url(images/minus.gif);
            width: 9px;
            height: 9px;
        }
        .cal_Theme1 .ajax__calendar_container
        {
            background-color: #DEF1F4;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_header
        {
            background-color: #ffffff;
            margin-bottom: 4px;
        }
        .cal_Theme1 .ajax__calendar_title, .cal_Theme1 .ajax__calendar_next, .cal_Theme1 .ajax__calendar_prev
        {
            color: #004080;
            padding-top: 3px;
        }
        .cal_Theme1 .ajax__calendar_body
        {
            background-color: #ffffff;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_dayname
        {
            text-align: center;
            font-weight: bold;
            margin-bottom: 4px;
            margin-top: 2px;
            color: #004080;
        }
        .cal_Theme1 .ajax__calendar_day
        {
            color: #004080;
            text-align: center;
        }
        .cal_Theme1 .ajax__calendar_hover .ajax__calendar_day, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_month, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_year, .cal_Theme1 .ajax__calendar_active
        {
            color: #004080;
            font-weight: bold;
            background-color: #DEF1F4;
        }
        .cal_Theme1 .ajax__calendar_today
        {
            font-weight: bold;
        }
        .cal_Theme1 .ajax__calendar_other, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_today, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_title
        {
            color: #bbbbbb;
        }
        bodys
        {
            margin: 0px;
        }
    </style>
<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script type="text/javascript">

    function IAmSelected(source, eventArgs) {
      
        var varGetVal = eventArgs.get_value();
        //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
        var ID;


        //            eventArgs.get_value()[0].PatientID;
        var list = eventArgs.get_value().split('/');
        if (list.length > 0) {
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    ID = list[0];
                //    var name = list[1].split('~');

                    document.getElementById('<%=hdnIPTreatmentPlanID.ClientID %>').value = list[0]; ;
                    document.getElementById('<%=txtSurgeryName.ClientID %>').value = list[1];
                    document.getElementById('<%=hdnAdvanceAmount.ClientID %>').value = list[2];
                    document.getElementById('<%=lblMinAdvnceAmt.ClientID %>').innerHTML = "Advance amount to be collect for this Procedure :" + list[2] + ".";




                }
            }


        }
    }

    function LoadIPTreatmentPlanItems() {

        var HidValue = document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID %>').value;

        // 1~185~0~185/Laparoscopic removal of subcutaneous gastric port device~185/Laparoscopic removal of subcutaneous gastric port device~nnnn~
        //Dr.KESAVAN~Dr.SAKTHIVEL ~N~31/8/2012 11:27:38 AM~Right EYE ~Dr.KESAVAN~Dr.SAKTHIVEL ^
        var count = 0;
        var list = HidValue.split('^');

        var masterID;
        var masterText;
        var childID;
        var childText;
        var rwNumber;
        var prosthesis;
        var surgeonID;
        var AnesthesiastID;
        var Provisional;
        var ParentID;
        var ParentName;
        var TreatmentDate;
        var ScrubTeam;
        var SurgeonName;
        var AnesthesistName;
        var SiteOfOperation;



        while (count = document.getElementById('<%=tblIPTreatmentPlanItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblIPTreatmentPlanItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblIPTreatmentPlanItems.ClientID %>').deleteRow(j);

            }
        }

        if (document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID %>').value != "") {

            var row = document.getElementById('<%=tblIPTreatmentPlanItems.ClientID %>').insertRow(0);
            row.id = 0;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            var cell9 = row.insertCell(8);
            var cell10 = row.insertCell(9);


            cell1.innerHTML = "Delete"
            cell1.width = "6%";
            //cell2.innerHTML = "Surgery Type";
            cell3.innerHTML = "Treatment Plan Name";
            cell4.innerHTML = "Prosthesis";
            cell5.innerHTML = "Provisional";
            cell6.innerHTML = "TreatmentPlan Date";
            cell7.innerHTML = "Surgeon Name";
            cell8.innerHTML = "Anathesist Name";
            cell9.innerHTML = "Site Of Operation";


        }
        //"1~2~376~Interventional~AICD Implantation~Prosthesis~935~1061~Y~18/8/2012 02:33:05 PM~KUMUDHA R  ~3310~Dr.ARTHANARI~Dr.OM PRAKASH^"
        if (document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {

                var IPTreatmentPlanList = list[count].split('~');

                rwNumber = IPTreatmentPlanList[0];
                masterID = document.getElementById('<%=hdnIPTreatmentPlanID.ClientID %>').value;
                childID = IPTreatmentPlanList[2];
                masterText = IPTreatmentPlanList[3];
                childText = IPTreatmentPlanList[4];
                prosthesis = IPTreatmentPlanList[5];
                surgeonID = IPTreatmentPlanList[6];
                AnesthesiastID = IPTreatmentPlanList[7];
                Provisional = IPTreatmentPlanList[8];
                TreatmentDate = IPTreatmentPlanList[9];
                // ScrubTeam = IPTreatmentPlanList[10];
                SurgeonName = IPTreatmentPlanList[11];
                SiteOfOperation = IPTreatmentPlanList[10];
                AnesthesistName = IPTreatmentPlanList[12];

                var row = document.getElementById('<%=tblIPTreatmentPlanItems.ClientID %>').insertRow(1);
                row.id = IPTreatmentPlanList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                //          // "1~2~387~Interventional~Central Venous Catheterization (Internal Jugular)~fgdfgdfg~938~1051~Y~16/8/2012 04:00:27 AM^"
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickIPTreatmentPlan(" + parseInt(IPTreatmentPlanList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                // cell2.innerHTML = masterText;
                cell3.innerHTML = childText;
                cell4.innerHTML = prosthesis;
                cell5.innerHTML = Provisional;
                cell6.innerHTML = TreatmentDate;
                cell7.innerHTML = SurgeonName;


                cell8.innerHTML = AnesthesistName;
                cell9.innerHTML = SiteOfOperation;

                cell10.innerHTML = "<input onclick='btnEdit_OnClick(name);' name='" + parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + childText + "~" + prosthesis + "~" + SiteOfOperation + "~" + SurgeonName + "~" + AnesthesistName + "~" + TreatmentDate + "~" + Provisional + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";


            }
        }

    }

    function ImgOnclickIPTreatmentPlan(ImgID) {

        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;
        var list = HidValue.split('^');
        var newIPTreatmentPlanList = '';
        if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var IPTreatmentPlanList = list[count].split('~');
                if (IPTreatmentPlanList[0] != '') {
                    if (IPTreatmentPlanList[0] != ImgID) {
                        newIPTreatmentPlanList += list[count] + '^';
                    }
                }
            }
            document.getElementById('hdnIPTreatmentPlanItems').value = newIPTreatmentPlanList;
        }
        if (document.getElementById('hdnIPTreatmentPlanItems').value == '') {
            document.getElementById('tblIPTreatmentPlanItems').style.display = 'none';
        }
    }






    function onClickAddIPTreatmentPlan() {

        var rowNumber = 1;
        var AddStatus = 0;
        // var masterID = 0;
        var masterID = document.getElementById('<%=hdnIPTreatmentPlanID.ClientID %>').value;   //document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').options[document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').selectedIndex].value;
        var masterText = document.getElementById('<%=txtSurgeryName.ClientID%>').value; //.options[document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').selectedIndex].text;
        var surgeonID = document.getElementById('<%=txtSurgeonName.ClientID %>').value;
        var anathesistID = document.getElementById('<%=txtAnesthesiastName.ClientID %>').value;
        var Provisional = document.getElementById('<%=chkprovisional.ClientID %>').checked ? "Y" : "N";
        var Treatmetntplandate = document.getElementById('<%=txtFromTime.ClientID %>').value;
        var SiteOfOperation = document.getElementById('<%=txtSiteofOperation.ClientID %>').value;

        var SurgeonName = document.getElementById('<%=txtSurgeonName.ClientID %>').value; //document.getElementById('<%=ddlChiefOperator.ClientID%>').options[document.getElementById('<%=ddlChiefOperator.ClientID%>').selectedIndex].text;
        var anathesistName = document.getElementById('<%=txtAnesthesiastName.ClientID %>').value; // document.getElementById('<%=DrpAnasthesiast.ClientID %>').options[document.getElementById('<%=DrpAnasthesiast.ClientID%>').selectedIndex].text;

        var childID = "0";
        var childText = "";

        //Newly Added
        var TreatmentDate = "Will be scheduled later";


        var rowSplitter = "";
        var colSplitter = "";
        var prosthesisSplitter = "";


        // var obj = document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').id;
        // var obj1 = document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').id;

        var prosthesis = document.getElementById('<%=txtProsthesis.ClientID%>').value;


        if (masterText == "Medical") {

            childID = "0";
            childText = document.getElementById('<%=txtIPTreatmentPlanOthers.ClientID%>').value;
        }
        else {

            childText = document.getElementById('<%=txtSurgeryName.ClientID%>').value; //document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').options[document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').selectedIndex].text;
            if (childText == "Others") {
                childID = "0";
                childText = document.getElementById('txtIPTreatmentPlanOthersChild').value;
            }
            else {
                childID = 0;
                //childID = document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').options[document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').selectedIndex].value;
                childText = document.getElementById('<%=txtSurgeryName.ClientID%>').value; //document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').options[document.getElementById('<%=ddlIPTreatmentPlanChild.ClientID%>').selectedIndex].text;
            }
        }


        document.getElementById('<%=tblIPTreatmentPlanItems.ClientID%>').style.display = 'block';
        var HidValue = document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value;

        if (HidValue == "") {
            HidValue = rowNumber + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + surgeonID + "~" + anathesistID + "~" + Provisional + "~" + Treatmetntplandate + "~" + SiteOfOperation + "~" + SurgeonName + "~" + anathesistName + "^";
            document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value = HidValue;

            //return;
        }
        else {
            var colCount = 0;
            var prosthesisCount = 0;
            var blnChildExists = false;
            var blnProsthesisExists = false;
            var tempRow = "";
            var newChild = "";

            rowSplitter = HidValue.split('^');
            //loop through every row
            for (var i = 0; i < rowSplitter.length - 1; i++) {
                colSplitter = rowSplitter[i].split('~');
                rowNumber = i + 1
                if (colSplitter[4] == childText) {
                    blnChildExists = true;

                    prosthesisSplitter = colSplitter[5].split(',');
                    for (k = 0; k <= prosthesisSplitter.length - 1; k++) {
                        if (prosthesisSplitter[k] == prosthesis)
                            blnProsthesisExists = true;

                    }
                    if (!blnProsthesisExists) {

                        for (k = 0; k <= prosthesisSplitter.length - 1; k++) {

                            if (prosthesis == "") {

                                prosthesis = prosthesisSplitter[k];
                            }
                            else {
                                prosthesis = prosthesis + "," + prosthesisSplitter[k];
                            }

                        }
                        colSplitter[5] = prosthesis;
                    }

                    //Check For prosthesis
                    if (blnProsthesisExists) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryforProcedurePlanning.ascx_1');
                        if (userMsg != null) {
                            alert(userMsg);
                        } else {
                            alert('Prosthesis already exist');
                        }
                    }

                    // loop through more than one surgeon add



                    var SurgeonCount = 0;
                    var blnsurgeonChildExists = false;
                    var blnSurgeonExists = false;
                    var surgeonsplitter = "";
                    surgeonsplitter = colSplitter[11].split(',');
                    for (var j = 0; j <= surgeonsplitter.length - 1; j++) {
                        if (surgeonsplitter[j] == SurgeonName)
                            blnSurgeonExists = true;

                    }

                    if (!blnSurgeonExists) {

                        for (j = 0; j <= surgeonsplitter.length - 1; j++) {

                            if (SurgeonName == "") {

                                SurgeonName = surgeonsplitter[j];
                            }
                            else {
                                SurgeonName = SurgeonName + "," + surgeonsplitter[j];
                            }

                        }
                        colSplitter[11] = SurgeonName;
                    }

                    //End



                    //more than one Anesthesiast

                    var blnAnesthesianChildExists = false;
                    var blnAnesthesiaExists = false;
                    var Anesthesiasplitter = "";
                    Anesthesiasplitter = colSplitter[12].split(',');
                    for (var j = 0; j <= Anesthesiasplitter.length - 1; j++) {
                        if (Anesthesiasplitter[j] == anathesistName)
                            blnSurgeonExists = true;

                    }

                    if (!blnAnesthesiaExists) {

                        for (j = 0; j <= Anesthesiasplitter.length - 1; j++) {

                            if (anathesistName == "") {

                                anathesistName = Anesthesiasplitter[j];
                            }
                            else {
                                anathesistName = anathesistName + "," + Anesthesiasplitter[j];
                            }

                        }
                        colSplitter[12] = anathesistName;
                    }

                    //End

                }
                rowSplitter[i] = rowNumber + "~" + colSplitter[1] + "~" + colSplitter[2] + "~" + colSplitter[3] + "~" + colSplitter[4] + "~" + colSplitter[5] + "~" + colSplitter[6] + "~" + colSplitter[7] + "~" + colSplitter[8] + "~" + colSplitter[9] + "~" + colSplitter[10] + "~" + colSplitter[11] + "~" + colSplitter[12] + "^";
                tempRow = tempRow + rowSplitter[i];
            }

            if (!blnChildExists) {
                if (childText != "") {

                    newChild = rowNumber + 1 + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + surgeonID + "~" + anathesistID + "~" + Provisional + "~" + Treatmetntplandate + "~" + SiteOfOperation + "~" + SurgeonName + "~" + anathesistName + "^";
                }
            }

            HidValue = tempRow + newChild;
            document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value = HidValue;


            //return;
        }

        LoadIPTreatmentPlanItems();

        document.getElementById('<%=txtIPTreatmentPlanProsthesis.ClientID%>').value = "";

        if (masterText == "Medical") {

            document.getElementById('<%=txtIPTreatmentPlanOthers.ClientID%>').value = "";
            document.getElementById('<%=IPTreatmentPlanOthersBlock.ClientID%>').style.display = "none";
            document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').value = 1;

            showIPTreatmentPlanChild(document.getElementById('<%=ddlIPTreatmentPlanMaster.ClientID%>').value);
        }
        if (childID == 0) {

            document.getElementById('<%=txtIPTreatmentPlanOthersChild.ClientID%>').value = "";
            //                document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";

        }

        itemsClear();

        return false;

    }


    function ImgOnclickIPTreatmentPlan(ImgID) {

        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value;
        var list = HidValue.split('^');
        var newIPTreatmentPlanList = '';
        if (document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var IPTreatmentPlanList = list[count].split('~');
                if (IPTreatmentPlanList[0] != '') {
                    if (IPTreatmentPlanList[0] != ImgID) {
                        newIPTreatmentPlanList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value = newIPTreatmentPlanList;
        }
        if (document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID%>').value == '') {
            document.getElementById('<%=tblIPTreatmentPlanItems.ClientID%>').style.display = 'none';
        }
    }


    //IP treatment Plan Edit
    function btnEdit_OnClick(sEditedData) {


        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%= hdnIPTreatmentPlanItems.ClientID %>').value;

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

            showIPTreatmentPlanChild_Control(arrayGotValue[1]);

            //                if (arrayGotValue[2] == 0) 
            //                {

            //                    document.getElementById("IPTreatmentPlanOthersBlock").style.display = "block";

            //                    document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').value = arrayGotValue[1];
            //                    document.getElementById('<%= txtIPTreatmentPlanOthers.ClientID %>').value = arrayGotValue[4];
            //                    document.getElementById('<%= txtIPTreatmentPlanProsthesis.ClientID %>').value = arrayGotValue[5];

            //                }
            //                else
            //                 {

            //                    document.getElementById("IPTreatmentPlanOthersBlock").style.display = "none"
            //                    document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').value = arrayGotValue[1];
            //                    document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').value = arrayGotValue[2];
            //                    document.getElementById('<%= txtIPTreatmentPlanProsthesis.ClientID %>').value = arrayGotValue[5];
            //                }
            if (arrayGotValue[1] == 0) {

                //                    document.getElementById('chkIPTreatmentPlanOthers').checked = true;
                document.getElementById('<%= txtSurgeryName.ClientID %>').value = arrayGotValue[3];
                document.getElementById('<%= txtSurgeonName.ClientID %>').value = arrayGotValue[6];
                document.getElementById('<%= txtAnesthesiastName.ClientID %>').value = arrayGotValue[7];
                document.getElementById('<%= IPTreatmentPlanOthersChild.ClientID %>').value = arrayGotValue[2];
                document.getElementById('<%= chkprovisional.ClientID %>').value = arrayGotValue[1];
                document.getElementById('<%= txtFromTime.ClientID %>').value = arrayGotValue[8];
                document.getElementById('<%= txtSiteofOperation.ClientID %>').value = arrayGotValue[5];
                document.getElementById('<%= txtProsthesis.ClientID %>').value = arrayGotValue[4];
                document.getElementById('<%=chkprovisional.ClientID %>').value = arrayGotValue[7];
            }
            else {
                if (arrayGotValue[2] == 0) {

                    document.getElementById('<%= txtSurgeryName.ClientID %>').value = arrayGotValue[3];
                    document.getElementById('<%= txtSurgeonName.ClientID %>').value = arrayGotValue[6];
                    document.getElementById('<%= txtAnesthesiastName.ClientID %>').value = arrayGotValue[7];
                    document.getElementById('<%= IPTreatmentPlanOthersChild.ClientID %>').value = arrayGotValue[2];
                    document.getElementById('<%= chkprovisional.ClientID %>').value = arrayGotValue[9];
                    document.getElementById('<%= txtFromTime.ClientID %>').value = arrayGotValue[8];
                    document.getElementById('<%= txtSiteofOperation.ClientID %>').value = arrayGotValue[5];
                    document.getElementById('<%= txtProsthesis.ClientID %>').value = arrayGotValue[4];
                    document.getElementById('<%=chkprovisional.ClientID %>').value = arrayGotValue[9];

                }
                else {

                    //1~29~0~CABG (Coronary Artery Bypass Grafting)~CABG (Coronary Artery Bypass Grafting)~gggg~Dr.ANNA~Dr.SAKTHIVEL ~Y~
                    //10/9/2012 02:23:29 PM~Right Eye ~Dr.ANNA~Dr.SAKTHIVEL ^
                    showIPTreatmentPlanChild_Control(arrayGotValue[1]);

                    document.getElementById('<%= txtSurgeryName.ClientID %>').value = arrayGotValue[3];
                    document.getElementById('<%= txtSurgeonName.ClientID %>').value = arrayGotValue[5];
                    document.getElementById('<%= txtAnesthesiastName.ClientID %>').value = arrayGotValue[6];
                    document.getElementById('<%= IPTreatmentPlanOthersChild.ClientID %>').value = arrayGotValue[2];
                    document.getElementById('<%= chkprovisional.ClientID %>').value = arrayGotValue[1];
                    document.getElementById('<%= txtFromTime.ClientID %>').value = arrayGotValue[8];
                    document.getElementById('<%= txtSiteofOperation.ClientID %>').value = arrayGotValue[9];
                    document.getElementById('<%= txtProsthesis.ClientID %>').value = arrayGotValue[4];
                    document.getElementById('<%=chkprovisional.ClientID %>').value = arrayGotValue[7];

                }
            }


        }
        document.getElementById('<%= hdnIPTreatmentPlanItems.ClientID %>').value = tempDatas;
        LoadIPTreatmentPlanItems()

    }

    //End IP treatment Plan Edit
    //Generate table

    function OnSelectProducts(source, eventArgs) {
        var tName = eventArgs.get_text().trim();
        var tProductID = eventArgs.get_value().split('~')[1].trim();
        document.getElementById('txtProsthesis').value = tName;
        document.getElementById('hdnProductID').value = tProductID;
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
    function openPOPupQuick(url) {
        window.open(url, "PrintReceipt", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
    }
    
    
 
</script>

<table width="100%" cellpadding="0">
    <tr id="trsurgery" class="defaultfontcolor">
        <td>
            <table class="dataheader2" width="100%" style="font-family: verdana; font-weight: bold"
                cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:Label ID="lblName" Text="Name : " runat="server"></asp:Label>
                        <asp:Label ID="lblNameValue" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAgeOrSex" Text="Age/Sex : " runat="server"></asp:Label>
                        <asp:Label ID="lblAgeOrSexValue" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPno" Text="Patient Number : " runat="server"></asp:Label>
                        <asp:Label ID="lblPnovalue" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAddress" Text="Address : " runat="server"></asp:Label>
                        <asp:Label ID="lbladdressvalue" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblContactNumber" Text="Contact Number : " runat="server"></asp:Label>
                        <asp:Label ID="lblcontactNovalue" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel6" runat="server" GroupingText="Surgery/Procedure Plan" Style="font-family: verdana">
                <table>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lblMinAdvnceAmt" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%" cellpadding="0">
                    <tr>
                        <td class="style8">
                            <asp:Label ID="Label2" Text="Surgery /Procedure Name" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSurgeryName" runat="server"     CssClass="Txtboxsmall" onchange="boxExpand(this);"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoSurgeryName" runat="server" TargetControlID="txtSurgeryName"
                                ServiceMethod="getProcedureNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="2" CompletionInterval="30" OnClientItemSelected="IAmSelected"
                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td class="style8">
                            <asp:Label ID="lblProsthesis" Text="Prosthesis" runat="server"></asp:Label>
                        </td>
                        <td style="width: 220px;">
                            <asp:TextBox ID="txtProsthesis" runat="server"     CssClass="Txtboxsmall" onchange="boxExpand(this);"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtProsthesis"
                                ServiceMethod="GetProsthesis" ServicePath="~/WebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="2" CompletionInterval="30" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                Enabled="True">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnProductID" runat="server" />
                        </td>
                        <td style="width: 125px;">
                            <asp:Label ID="lblSurgeonname" Text="Surgeon Name" runat="server"></asp:Label>
                        </td>
                        <td style="width: 220px;">
                            <asp:TextBox ID="txtSurgeonName" runat="server" MaxLength="50" Width="170px" CssClass="Txtboxsmall"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="Autosurgeonname" runat="server" TargetControlID="txtSurgeonName"
                                ServiceMethod="GetAllPhysicianName" ServicePath="~/WebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="2" CompletionInterval="30" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td style="width: 125px;">
                            <asp:Label ID="lblAnesthesiastName" Text="Anesthetist Name" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAnesthesiastName" runat="server" MaxLength="50" Width="170px"
                                CssClass="Txtboxsmall"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoAnesthesiastName" runat="server" TargetControlID="txtAnesthesiastName"
                                ServiceMethod="GetAnesthesiastNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="2" CompletionInterval="30" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style4">
                            <asp:Label ID="lblsiteofoperation" Text="Site Of Operation" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSiteofOperation"     CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                        </td>
                        <%-- <td class="style4">
                            <asp:Label ID="Label13" Text="Operating Team" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TxtScrubTeam" runat="server"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoSurubTeam" runat="server" TargetControlID="TxtScrubTeam"
                                ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="2" CompletionInterval="30"
                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>--%>
                        <td>
                            <asp:Label ID="lblplannedDate" Text="Planned Date and Time" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFromTime" MaxLength="25"     CssClass="Txtboxsmall" size="25" Width="167px"></asp:TextBox>
                            <a href="javascript:NewCal('<%=txtFromTime.ClientID %>','ddmmyyyy',true,12)">
                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" CssClass="cal_Theme1"></a>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkprovisional" Text="Provisional" runat="server"></asp:CheckBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkemergency" Text="Emergency1" runat="server" Visible="false">
                            </asp:CheckBox>
                        </td>
                        <td>
                            <input type="button" name="btnIPTreatmentPlanAdd" id="btnIPTreatmentPlanAdd" onclick="onClickAddIPTreatmentPlan();"
                                value="Add" class="btn" />
                        </td>
                       
                    </tr>
                </table>
            </asp:Panel>
            <table id="tblold" cellspacing="0" border="0" width="100%" style="display: none;">
                <tr>
                    <td style="font-weight: bold; height: 20px; color: #000;">
                        <asp:Label ID="Rs_SurgeryProcedure" Text="Surgery / Procedure" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table cellspacing="0" border="1" width="100%">
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <table cellspacing="0" border="0" style="height: 48px; width: 107%">
                                                    <tr visible="false">
                                                        <td class="style7">
                                                            <asp:Label ID="lblTreatmentplan" Text="Select Plan/SurgeryType" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlIPTreatmentPlanMaster" onchange="javascript:showIPTreatmentPlanChild_Control(this.value);"
                                                                runat="server" Style="margin-left: 2px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" Text="Prosthesis" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblPackage" Text="Surgery Package" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPackage1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="style7">
                                                            <asp:Label ID="lblProcedureName" runat="server" Text="Surgery/Procedure Name"></asp:Label>
                                                        </td>
                                                        <td id="tdIPTreatmentPlanChild" style="display: block" runat="server" class="style3">
                                                            <asp:DropDownList ID="ddlIPTreatmentPlanChild" runat="server" onchange="javascript:showIPTreatmentPlanOthersChildBlock_Control(this.value);"
                                                                Style="margin-left: 2px" Visible="false">
                                                            </asp:DropDownList>
                                                            <td>
                                                                <asp:TextBox ID="txtTreatmentPlanID" runat="server"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtTreatmentPlanID"
                                                                    ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                                    MinimumPrefixLength="2" CompletionInterval="30" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                    Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <input type="hidden" id="hdnIPTreatmentPlanChild" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtIPTreatmentPlanProsthesis" Style="width: 150px;
                                                                margin-left: 0px;"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table border="0" style="font-family: verdana; height: 100px; width: 100%;">
                                                    <tr>
                                                        <td class="style4">
                                                            <asp:Label ID="lblSurgeonname1" Text="Surgeon Name" runat="server"></asp:Label>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here"></asp:TextBox>
                                                            <asp:DropDownList ID="ddlChiefOperator" runat="server" Visible="false">
                                                            </asp:DropDownList>
                                                            <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                                WatermarkText="Type Physician Name" Enabled="True" />
                                                        </td>
                                                        <td class="style6">
                                                            <asp:Label ID="Rs_Anesthetist" Text="Anesthetist Name" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="iconHidAnesthetist" runat="server" />
                                                            <asp:TextBox ID="txtAnesthesiast" runat="server" ToolTip="Enter Text Here" />
                                                            <asp:DropDownList ID="DrpAnasthesiast" runat="server" Visible="false">
                                                            </asp:DropDownList>
                                                            <ajc:TextBoxWatermarkExtender ID="TBEWAnesthesia" runat="server" TargetControlID="txtAnesthesiast"
                                                                WatermarkText="Type Anesthesist Name" Enabled="True" />
                                                        </td>
                                                        <td valign="top">
                                                            <table id="Table2" cellpadding="0px" cellspacing="0" width="96%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblAnesthetist" runat="server" Text="Anesthetist" Style="display: none;
                                                                            font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblAnesthetist" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                width="96%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="style4">
                                                            <asp:Label ID="lblScrubTeam" Text="Operating Team" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TxtScrubTeam1" runat="server"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoGname" runat="server" TargetControlID="TxtScrubTeam1"
                                                                ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                                MinimumPrefixLength="2" CompletionInterval="30" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <%-- <td>
                                                            <asp:CheckBox ID="chkprovisional" Text="Provisional" runat="server"></asp:CheckBox>
                                                            <asp:CheckBox ID="chkemergency" Text="Emergency" runat="server"></asp:CheckBox>
                                                        </td>--%>
                                                        <td>
                                                            <asp:Label ID="lblPriority" Text="Priority" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPriority" ToolTip="Select Priority" runat="server">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <input type="button" name="btnIPTreatmentPlanAdd" id="btnIPTreatmentPlanAdd1" onclick="onClickAddIPTreatmentPlan();"
                                                                value="Add" class="btn" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="display: none;">
                                                    <tr>
                                                        <td>
                                                            <table id="Table5" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr id="IPTreatmentPlanOthersBlock" style="display: none;">
                                                                    <td>
                                                                        <asp:Label ID="Rs_TreatmentPlanName" Text="TreatmentPlan Name:" runat="server" Visible="false"></asp:Label>
                                                                        <input type="text" id="txtIPTreatmentPlanOthers" runat="server" style="width: 200px;" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="IPTreatmentPlanOthersChild" style="display: none;">
                                                                    <td>
                                                                        <asp:Label ID="Rs_TreatmentPlanName1" Text="TreatmentPlan Name:" runat="server" Visible="false"></asp:Label>
                                                                        <input type="text" id="txtIPTreatmentPlanOthersChild" runat="server" style="width: 200px;" />
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
                        </table>
                        <table>
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="hdnIPCaseRecordPlan" runat="server" style="width: 600px;" />
                        <input type="hidden" id="hdnPerformed" runat="server" style="width: 600px;" />
                        <input type="hidden" id="hdnIPTreatmentPlanItems" runat="server" style="width: 600px;" />
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table id="tblIPTreatmentPlanItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                cellspacing="0" border="1" visible="true">
            </table>
            <table id="tblPlansurgery" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                cellspacing="0" border="1" width="100%" style="font-family: verdana">
                <tr>
                    <td style="font-weight: bold; height: 20px; color: #000;">
                        <asp:Label ID="Rs_PlannedSurgeryProcedure" Text="Planned Surgery / Procedure" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="hdnSurgery" runat="server" />
                        <asp:GridView ID="grdCRCplan" runat="server" AutoGenerateColumns="False" OnRowDataBound="grdCRCplan_RowDataBound"
                            DataKeyNames="SurgeryPlanID" OnRowCommand="grdCRCplan_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Surgery/Package Name" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Prosthesis" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProsthesis" runat="server" Text='<%# Bind("Prosthesis") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Plan Date" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTreatmentPlanDate" runat="server" Text='<%# Bind("TreatmentPlanDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Surgeon Name" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSurgeonName" runat="server" Text='<%# Bind("SurgeonName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Anesthesiast Name" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAnesthesiastName" runat="server" Text='<%# Bind("AnesthesiastName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Provisional" ItemStyle-Width="14%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProvisonal" runat="server" Text='<%# Bind("IsProvisional") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <table>
         
                <asp:Panel ID="programmaticPopup1" runat="server" CssClass="modalPopup" Style="display: none;">
                
                    <tr id="divPaymentType" runat="server">
                        <td id="Td1" align="center" runat="server">
                            <uc9:paymentType ID="PaymentType" runat="server" />
                        </td>
                    </tr>
                </asp:Panel>
         
            </table>
          <%--  <ajc:ModalPopupExtender ID="mpe" runat="server" TargetControlID="btnCollectAdvance"
                PopupControlID="programmaticPopup1" DropShadow="True" BackgroundCssClass="modalBackground"
                OkControlID="btnCollectAdvance" DynamicServicePath="" Enabled="True" />--%>
            <table width="100%">
                <tr align="center">
                    <td align="center">
                        <asp:Button ID="btnFinish" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                            CssClass="btn" onmouseout="this.className='btn'" Width="100px" OnClick="btnFinish_Click" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" Width="100px" OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--</asp:Panel>
--%>
<asp:HiddenField ID="hdfProthesisname" runat="server" />
<asp:HiddenField ID="hdnProthesisnameExists" runat="server" />
<asp:HiddenField ID="hdnProthesisnameDeleted" runat="server" />
<asp:HiddenField ID="hdnStatus" runat="server" />
<asp:HiddenField ID="hdnbtnsave" runat="server" />
<asp:HiddenField ID="hdnIPTreatmentPlanID" runat="server" Value="0" />
<asp:HiddenField ID="hdnAdvanceAmount" runat="server" Value="0" />
<asp:HiddenField ID="hdnReceiptNo" runat="server" Value="0" />
<asp:HiddenField ID="hdnDate" runat="server" Value="0" />
<asp:HiddenField ID="hdnVisitID" runat="server" Value="0" />
<asp:HiddenField ID ="hdnOtherCurrencyID" runat ="server" Value ="0" />








<script type="text/javascript">



 function PopUpPage() {
    
        dDate = document.getElementById('<%= hdnDate.ClientID %>').value;
        //alert(dDate);
        
       
        dAmount = document.getElementById('hdnAdvanceAmount').value.value == "" ? "0" : document.getElementById('<%= hdnAdvanceAmount.ClientID %>').value;
        var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value ;
        var sptype = "Procedure";
        var pvid = document.getElementById('<%=hdnVisitID.ClientID %>').value;
      
        //alert(dAmount);
        if((dAmount !='')&&(Number(dAmount) > 0))
        {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "PrintReceiptPage.aspx?Amount=" + dAmount + "&dDate=" + dDate+ "&rcptno=" + dReceiptNo + "&PNAME=<%=Request.QueryString["PNAME"] %>&pdid=" + dBdetNo +"&pDet=" + sptype + "&VID=" + pvid + "&PNumber=" + PNo +"";
            window.open(strURL, "", strFeatures, true);
             var ConValue = "OtherCurrencyDisplay1";
            SetReceivedOtherCurr(0, 0, ConValue);
        }
        else
        {
          var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryforProcedurePlanning.ascx_2');
                        if (userMsg != null) {
                            alert(userMsg);
                        }else{
                alert('Select a payment');}
        }
    }
    function extractRow(rid) {
        var items = document.getElementById('<%=hdnPerformed.ClientID %>').Value;
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('HdnitemID').value = itemID;
        //document.getElementById('HdnrateID').value = rateID;
        document.getElementById('txtItemName').value = ItemName;
        //         document.getElementById('txtRate').value = Rate;
        //          document.getElementById('txtIPAmount').value = IPAmount
        //        document.getElementById('ddlRateName').value = rateID;
        document.getElementById('<%=btnFinish.ClientID %>').value = "Update";
        document.getElementById('hdnbtnsave').value = "Update";

    }
    function itemsClear() {

        //            document.getElementById('hdnId').value = "0";
        document.getElementById('<%=txtSurgeryName.ClientID %>').value = "";
        document.getElementById('<%=txtProsthesis.ClientID %>').value = "";
        document.getElementById('<%=txtSurgeonName.ClientID %>').value = "";
        document.getElementById('<%=txtAnesthesiastName.ClientID %>').value = "";
        document.getElementById('<%=txtSiteofOperation.ClientID %>').value = "";

        document.getElementById('<%=txtFromTime.ClientID %>').value = "";
        document.getElementById('<%=chkprovisional.ClientID %>').value = "";

        //        document.getElementById('<%=hdnIPTreatmentPlanItems.ClientID %>').value = "";

        //

    }
    function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
        return true;
    }
    function DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge) { }
    
    function Validate()
    {
    var minadvanceAmt =document.getElementById('hdnAdvanceAmount').value;
    var PaidAmt=document.getElementById('hdnAdvanceAmount').value;
    }
    
    
  
</script>

