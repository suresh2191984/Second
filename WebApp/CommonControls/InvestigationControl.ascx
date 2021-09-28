<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvestigationControl.ascx.cs"
    Inherits="CommonControls_InvestigationControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="AddNewInvestigation.ascx" TagName="AddInvestigation" TagPrefix="AddnewInv" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>
<script type="text/javascript">

    function ShowAlertMsg(key) {

        var Error = SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01") != null ? "Information" : SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01");
        var InformMsg = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01") != null ? "Investigation already added!" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01");

        //var userMsg = SListForApplicationMessages.Get(key);
        if (InformMsg != null) {
            // alert(userMsg);
            ValidationWindow(InformMsg + '  ' + length, Error);

            return false;
        }
        else {
            // alert('Investigation already added!');
            ValidationWindow(InformMsg + '  ' + length, Error);
            return false;
        }
        return true;
    }


    function GetValueFromChild(InvID) {
        // //debugger;
        if (document.getElementById('tblOrederedInves') != null) {
            var otable = document.getElementById('tblOrederedInves');
            var i = 0;
            if (otable.rows.length > 1) {
                while (otable.rows.length > i) {
                    if (otable.rows[i].id == InvID) {
                        otable.rows[i].cells[0].childNodes[0].style.display = "none";
                        otable.rows[i].cells[5].childNodes[0].style.display = "none";
                    }
                    i++;
                }
            }
        }
    }

    function lblbtn_Onclick(id) {
        ////debugger;
        var PageUrl = '';
        PageUrl = document.getElementById('<%= hdnsPage.ClientID %>').value + id + "&IsPopup=Y";
        window.open(PageUrl, "skey", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");

    }
    function onClick1(id, hdnID) {




        var Error = SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01") != null ? "Information" : SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01");
        var InformMsg = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01") != null ? "Investigation already added!" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01");
        var InformMsg1 = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_02") != null ? "Please Select Investigation" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_02");

        var type;
        var AddStatus = 0;
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');

        if (id == document.getElementById("<%= listGRP.ClientID %>").getAttribute('id')) {
            type = 'GRP';
        }
        else if (id == document.getElementById("<%= listPKG.ClientID %>").getAttribute('id')) {
            type = 'PKG';
        }
        else if (id == document.getElementById("<%= listINV.ClientID %>").getAttribute('id')) {
            type = 'INV';
        }
        else if (id == document.getElementById("<%= listBLB.ClientID %>").getAttribute('id')) {
            type = 'BLB';
        }

        total = parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);

        if (document.getElementById(hdnID).value == "") {
            var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;

            var list = HidValue.split('^');

            if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '' && InvesList[2] == type) {
                        if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                UrlValue = "&PInvId=" + obj.options[obj.selectedIndex].value + "&InvName=" + obj.options[obj.selectedIndex].text + "&FType=" + type;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var rate1;
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell4.innerHTML = "<input type='text' id='InvCmd' Maxlength=100 size=10 />"
                cell5.innerHTML = obj.options[obj.selectedIndex].value;

                //cell4.innerHTML = "<input type='text' value='0' id='Contxt' size='4'  />";
                var Xray = document.getElementById('InvCmd').value;
                cell3.style.display = "none";
                cell5.style.display = "none";
                cell4.style.display = "none";
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";
                document.getElementById('<%= hdnOrderdINV.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";

                cell6.innerHTML = "<img id='imgbtnSch' style='cursor:pointer;' title='Click to Schedule' OnClick=\"lblbtn_Onclick('" + UrlValue + "');\"' src='../Images/schedule.png' />";
                if (document.getElementById('<%= hdnsPage.ClientID %>').value == '') {
                    cell6.style.display = "none";
                }

                rate = obj.options[obj.selectedIndex].text.split(':');
                var count = rate.length;
                if (count > 2) {
                    rate1 = rate[1].split('-');
                    total = Number(chkIsnumber(rate1));
                }
                else {
                    total = Number(chkIsnumber(rate[1]));
                }
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(chkIsnumber(document.getElementById('<%= lblTotal.ClientID %>').innerHTML)) + parseFloat(total);
                AddStatus = 2;

                var ISCOR = document.getElementById('<%= hdnIsCorpOrg.ClientID %>').value
//                if (ISCOR == 'N')
//                    document.getElementById('tblTot').style.display = "table";

            }
            if (AddStatus == 0) {
                document.getElementById('<%= lblHeader.ClientID %>').style.display = 'block';
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                UrlValue = "&PInvId=" + obj.options[obj.selectedIndex].value + "&InvName=" + obj.options[obj.selectedIndex].text + "&FType=" + type;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var rate1;
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                cell5.style.display = "none";
                cell4.style.display = "none";
                cell4.innerHTML = "<input type='text' id='InvCmd' Maxlength=100 size=10 />"
                cell5.innerHTML = obj.options[obj.selectedIndex].value;
                //cell4.innerHTML = "<input type='text' value='0' id='Contxt' size='4'  />";
                var Xray = document.getElementById('InvCmd').value;
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~" + Xray + "^";
                document.getElementById('<%= hdnOrderdINV.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~" + Xray + "^";

                cell6.innerHTML = "<img id='imgbtnSch' style='cursor:pointer;' title='Click to Schedule' OnClick=\"lblbtn_Onclick('" + UrlValue + "');\"' src='../Images/schedule.png' />";
                if (document.getElementById('<%= hdnsPage.ClientID %>').value == '') {
                    cell6.style.display = "none";
                }
                rate = obj.options[obj.selectedIndex].text.split(':');
                var count = rate.length;
                if (count > 2) {
                    rate1 = rate[1].split('-');
                    total = Number(chkIsnumber(rate1));
                }
                else {
                    total = Number(chkIsnumber(rate[1]));
                }
                //                rate1 = rate[1].split('-');
                total = format_number(chkIsnumber(total), 2);
                total = Number(total) + Number(chkIsnumber(rate1));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(chkIsnumber(document.getElementById('<%= lblTotal.ClientID %>').innerHTML)) + parseFloat(total);
            }
            else if (AddStatus == 1) {
                //var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl.ascx_1');
                if (InformMsg1 != null) {
                    // alert(userMsg);
                    ValidationWindow(InformMsg1 + '  ' + length, Error);
                }
                //alert("Investigation Already Added!");
                ValidationWindow(InformMsg + '  ' + length, Error);
            }

            if (id == document.getElementById('<%= listGRP.ClientID %>')) {
                document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1;
            }
            else if (id == document.getElementById('<%= listINV.ClientID %>')) {
                document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1;
            }
        }
        else {
            var AmountVal = 0;
            var amtsplit = new Array();
            amtsplit = obj.options[obj.selectedIndex].text.split('<%= CurrencyName %>');


            if (amtsplit.length > 1) {
                AmountVal = amtsplit[1].split(':')[1];
            }


            if (id == document.getElementById(id.split('_')[0] + '_' + 'listGRP').getAttribute('id')) {
                type = 'GRP';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listPKG').getAttribute('id')) {
                type = 'PKG';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listINV').getAttribute('id')) {
                type = 'INV';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listBLB').getAttribute('id')) {
                type = 'BLB';
            }

            CmdAddBillItemsType_onclick(type, obj.options[obj.selectedIndex].value, 0, obj.options[obj.selectedIndex].text.split('<%=CurrencyName %>')[0], 1, AmountVal, AmountVal, Xray);
        }
        document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1;
        document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1;
    }

    function ImgOnclick(ImgID) {



        var Error = SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01") != null ? "Information" : SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01");
        var InformMsg = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01") != null ? "Investigation already added!" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01");
        var InformMsg2 = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_03") != null ? "You Cannot delfete the item which is already billed" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_03");
        var InformMsg3 = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04") != null ? "Enter Investigation Name" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04");


        // alert(document.getElementById(ImgID).innerHTML);
        // document.getElementById(ImgID).style.display = "none";
        //        //debugger;
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');
        //  "29~ABG (Arterial Blood Gas analysis)~GRP"

        var newInvList = '';
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                var invlist1 = InvesList[1].split('-');
                //"13Q Deletion By Fish-Rs:4000.00-Ordered"
                if (InvesList[0] != '' && InvesList[0] == ImgID) {
                    if (invlist1[2] == 'paid' || InvesList[3] == 'SampleReceived') {
                      //  var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl.ascx_2');
                        if (InformMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(InformMsg2 + '  ' + length, Error);
                        } else {
                        //alert('You Cannot delfete the item which is already billed');
                        ValidationWindow(InformMsg2 + '  ' + length, Error);
                        }

                        return false;
                    }

                    else {
                        document.getElementById(ImgID).style.display = "none";
                    }



                }
                else {
                    document.getElementById(ImgID).style.display = "none";
                }

                if (InvesList[0] != ImgID) {
                    newInvList += list[count] + '^';
                }
                // This total amount calculation only for non corporate org.
                else {
                    var IsMappingtems = document.getElementById('<%= hdnIsMappingtems.ClientID %>').value;
                    var IscorpOrg = '<%= IsCorporateOrg %>';
                    if (IscorpOrg != 'Y') {
                        if (IsMappingtems != 'Y') {
                            var Minusamount = InvesList[1].split(':');
                            //"Coagulation Profile"


                            var editamt = Minusamount[1].split('-');
                            var count1 = Minusamount.length;
                            if (count1 > 2) {
                                var amt = Minusamount[1].split('-');
                                var totalAmt = parseFloat(chkIsnumber(document.getElementById('<%= lblTotal.ClientID %>').innerHTML)) - parseFloat(chkIsnumber(amt[0]));
                            }
                            else {
                                var totalAmt = parseFloat(chkIsnumber(document.getElementById('<%= lblTotal.ClientID %>').innerHTML)) - parseFloat(chkIsnumber(editamt[0]));
                            }
                            totalAmt = format_number(chkIsnumber(totalAmt), 2);
                            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(totalAmt).toFixed(2);
                        }
                    }
                }



            }


            document.getElementById('<%= iconHid.ClientID %>').value = newInvList;
            document.getElementById('<%= hdnOrderdINV.ClientID %>').value = newInvList;
        }
    }


    function LoadOrdItemsForHindu() {



        var Error = SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01") != null ? "Information" : SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01");
        var InformMsg = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01") != null ? "Investigation already added!" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_01");
        var InformMsg3 = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04") != null ? "Enter Investigation Name" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04");

        ////debugger;
        var HidValue = document.getElementById('<%= hdnOrderdINV.ClientID %>').value;
        var list = HidValue.split('^');
        var total = 0;  //parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);
        total = format_number(chkIsnumber(total), 2);
        document.getElementById('InvestigationControl1_lblTotal').innerHTML = '0';
        //alert(document.getElementById('<%= iconHid.ClientID %>').value);
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {
                //            document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);
                }
            }
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = InvesList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = InvesList[1];
                cell3.innerHTML = InvesList[2];
                cell4.innerHTML = "<input type='text' id='InvCmd' value = '" + InvesList[3] + "'/>";
                cell5.innerHTML = InvesList[0];
                cell3.style.display = "none";
                cell5.style.display = "none";
                rate = InvesList[1].split(':');
                total = format_number(chkIsnumber(total), 2);
                //rate = format_number(chkIsnumber(rate), 2);
                total = Number(total) + Number(chkIsnumber(rate[1]));
                var ISCOR = document.getElementById('<%= hdnIsCorpOrg.ClientID %>').value
//                if (ISCOR == 'N')
//                    document.getElementById('tblTot').style.display = "table"

                //                total = format_number(chkIsnumber(total), 2);
                //                total = Number(total) + Number(chkIsnumber(rate[1]));
                //                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
            }
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
        }
    }


    function addPhyFeeList(invID) {
        var HdnLPF = document.getElementById('InvestigationControl1_HdnLPF').value;
        var LPFlist = HdnLPF.split('^');

        if (document.getElementById('InvestigationControl1_HdnLPF').value != "") {

            for (var count = 0; count < LPFlist.length; count++) {
                var FeeList = LPFlist[count].split('~');
                if (FeeList[0] == invID) {
                    return FeeList[2];
                }
            }
            return "---";
        }
        else {
            return "---";
        }
    }
    function LoadOrdItems() {

        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');
        var total = 0;  //parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);
        total = format_number(chkIsnumber(total), 2);
        document.getElementById('InvestigationControl1_lblTotal').innerHTML = '0';
        //alert(document.getElementById('<%= iconHid.ClientID %>').value);
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {
                //            document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);
                }
            }
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = InvesList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var rate1;
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;'  OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = InvesList[1];
                cell3.innerHTML = InvesList[2];
                cell4.innerHTML = InvesList[3];
                cell4.style.display = "none";
                cell3.style.display = "none";
                rate = InvesList[1].split(':');
                rate1 = rate[1].split('-')[0];
                total = format_number(chkIsnumber(total), 2);
                //rate = format_number(chkIsnumber(rate), 2);
                total = Number(total) + Number(chkIsnumber(rate1));
                var ISCOR = document.getElementById('<%= hdnIsCorpOrg.ClientID %>').value
//                if (ISCOR == 'N')
//                    document.getElementById('tblTot').style.display = "table"

                //                total = format_number(chkIsnumber(total), 2);
                //                total = Number(total) + Number(chkIsnumber(rate[1]));
                //                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
            }
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
        }
    }
    //    function setItem(e, ctl) {

    //        var key = window.event ? e.keyCode : e.which;
    //        if (key == 13) {
    //            onClick1(ctl.id);
    //        }

    //    }
    //    function deselectLists(id) {

    //        //        if (id == "InvestigationControl1_listGRP") {
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;
    //        //        }
    //        //        else if (id == "InvestigationControl1_listPKG") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;

    //        //        }
    //        //        else if (id == "InvestigationControl1_listINV") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;

    //        //        }
    //        //        else if (id == "InvestigationControl1_listBLB") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;

    //        //        }
    //    }
    function Validation1() {

        var Error = SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01") != null ? "Information" : SListForAppMsg.Get("CommonControl_ManageInvestigation_ascx_01");
        var InformMsg3 = SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04") != null ? "Enter Investigation Name" : SListForAppMsg.Get("CommonControl_InvestigationControl_ascx_04");

    
        if (document.getElementById('<%= txtINV.ClientID %>').value == "") {
           // var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl.ascx_3');
            if (InformMsg3 != null) {
                // alert(userMsg);
                ValidationWindow(InformMsg3 + '  ' + length, Error);
            } else {
            //alert("Enter Investigation Name");
            ValidationWindow(InformMsg3 + '  ' + length, Error);
            }
            document.getElementById('<%= txtINV.ClientID %>').focus();
            return false;
        }
        return true;
    }
    function setItem(e, ctl, SecID) {

        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClick1(ctl.id, SecID);
        }
    }
    function deselectLists(id) {
        var obj1 = document.getElementById('InvestigationControl1_listINV');
        var obj2 = document.getElementById('InvestigationControl1_listGRP');
        var obj3 = document.getElementById('InvestigationControl1_listPKG');
        var obj4 = document.getElementById('InvestigationControl1_listLCON');


        if (id == "InvestigationControl1_listGRP") {
            //if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = 0; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listPKG") {
            //if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listINV") {
            //if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listLCON") {
            // if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
        }
    }

    MyUtil = new Object();
    MyUtil.selectFilterData = new Object();
    MyUtil.selectFilter = function(selectId, filter) {
        selectId = document.getElementById('<%= hidID.ClientID %>').value;
        var list = document.getElementById(selectId);
        if (!MyUtil.selectFilterData[selectId]) { //if we don't have a list of all the options, cache them now'
            MyUtil.selectFilterData[selectId] = new Array();
            for (var i = 0; i < list.options.length; i++) MyUtil.selectFilterData[selectId][i] = list.options[i];
        }
        list.options.length = 0;   //remove all elements from the list
        for (var i = 0; i < MyUtil.selectFilterData[selectId].length; i++) { //add elements from cache if they match filter
            var o = MyUtil.selectFilterData[selectId][i];
            if (o.text.toLowerCase().indexOf(filter.toLowerCase()) >= 0) {

                if (navigator.appName == "Microsoft Internet Explorer") {
                    //alert("hai")
                    list.add(o);
                }
                else {
                    //alert("httt")
                    list.add(o, null);
                }
            }
        }
    }
    function SetId(ID) {

        //document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
        if (ID != document.getElementById('<%= hidID.ClientID %>').value) {
            //alert(document.getElementById('<%= hidID.ClientID %>').value);
            MyUtil.selectFilter(document.getElementById('<%= hidID.ClientID %>').value, '');

            document.getElementById('<%= hidID.ClientID %>').value = ID;

            document.getElementById('txtBX').value = '';
            //document.getElementById('txtBX').focus();
        }
        else {
            document.getElementById('txtBX').value = '';
            //document.getElementById('txtBX').focus();
        }

        return false;
    }
    
</script>

<%--<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>--%>
<asp:HiddenField ID="iconHid" runat="server" />
<input type="hidden" id="HdnLPF" value="" runat="server" />
<input type="hidden" id="hidID" value="" runat="server" />
<table class="w-100p">
    <tr>
        <td class="v-top">
            <table class="w-100p">
                <tr>
                    <td>
                        <AddnewInv:AddInvestigation ID="AddNewInvestigation1" Visible="False" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblGroup" runat="server" Visible="False" Font-Bold="True" Text="Group"
                            meta:resourcekey="lblGroupResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--  <td style="display:none" nowrap="nowrap">
                                
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtGroup" Visible="false" Width="150px" runat="server" autocomplete="off"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname" runat="server" TargetControlID="txtGroup"
                                            ServiceMethod="getgrpInvList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                            MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp1" CompletionInterval="10"
                                            DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:Button ID="btnAdd" Visible="false" runat="server" Text="Add" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnAdd_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>--%>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Filter" runat="server" Text="Filter:" Font-Bold="True" meta:resourcekey="Rs_FilterResource1"></asp:Label>
                        <input type="text" onkeyup="MyUtil.selectFilter('InvestigationControl1_listINV', this.value)"
                            id="txtBX" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listGRP" Visible="False" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="60%" Height="150px" onblur="javascript:return SetId(this.id);" onclick="javascript:return SetId(this.id);"
                            meta:resourcekey="listGRPResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPackage" runat="server" Visible="False" Text="Package" meta:resourcekey="lblPackageResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listPKG" Style="display: none;" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="60%" onclick="javascript:return SetId(this.id);" Height="100px" meta:resourcekey="listPKGResource1">
                        </asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLCON" runat="server" Visible="False" Text="Consumables" meta:resourcekey="lblLCONResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listLCON" Visible="False" runat="server" ToolTip="Double Click the List or Press Enter to Select Consumables"
                            onfocus="javascript:deselectLists(this.id);" Width="350px" CssClass="h-100" onclick="javascript:return SetId(this.id);"
                            meta:resourcekey="listLCONResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblBloodBank" runat="server" Visible="False" Text="Blood Bank" meta:resourcekey="lblBloodBankResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listBLB" Style="display: none;" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="350px" CssClass="h-100" onclick="javascript:return SetId(this.id);" meta:resourcekey="listBLBResource1">
                        </asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-left">
                        <asp:Label ID="lblInvestigation" runat="server" Visible="False" Text="Investigation"
                            Font-Bold="True" meta:resourcekey="lblInvestigationResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="display: none" class="a-left">
                        <asp:UpdatePanel ID="up2" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtINV" Visible="False" CssClass="small" runat="server" autocomplete="off"
                                    meta:resourcekey="txtINVResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtINV"
                                    ServiceMethod="getIndInvList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;
                                <asp:Button ID="btnInvAdd" Visible="False" runat="server" Text="Add" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnInvAdd_Click"
                                    meta:resourcekey="btnInvAddResource1" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr style="display: none;">
                                <td>
                                    <asp:Label ID="lblSearchInves" runat="server" Text="Investigation search" meta:resourcekey="lblSearchInvesResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtsearch" CssClass="small" runat="server" OnTextChanged="txtsearch_TextChanged"
                                        meta:resourcekey="txtsearchResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnsearch" Text="search" runat="server" OnClick="btnsearch_Click"
                                        meta:resourcekey="btnsearchResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ListBox ID="listINV" runat="server" Width="350px" onfocus="javascript:deselectLists(this.id);"
                                        Height="200px" onclick="javascript:return SetId(this.id);" onkeypress="javascript:setItem(event,this);"
                                        meta:resourcekey="listINVResource1"></asp:ListBox>
                                    <%--<ajc:ListSearchExtender ID="ListSearchExtender1" PromptPosition="Bottom" QueryPattern="StartsWith"
                                                runat="server" TargetControlID="listINV" PromptCssClass="ListSearchExtenderPrompt"
                                                IsSorted="false">
                                            </ajc:ListSearchExtender>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td class="v-top">
            <br />
            <br />
            <table id="Table1" class="w-96p">
                <tr>
                    <td>
                        <asp:Label ID="lblHeader" runat="server" Text="Ordered Investigations" Style="display: none;"
                          CssClass="Duecolor font12 v-middle padding5" meta:resourcekey="lblHeaderResource1"></asp:Label>
                    </td>
                </tr>
            </table>
            <table id="tblOrederedInves" class="dataheaderInvCtrl w-96p">
            </table>
            <asp:HiddenField ID="hdnOrderdINV" runat="server" />
            <asp:HiddenField ID="hdnOrderdINVNew" runat="server" />
            <table id="tblTot" style="display: none" class="dataheaderInvCtrl w-96p">
                <tr>
                    <td class="a-right w-60p">
                        <asp:Label ID="lblTotaltxt" runat="server" Text="Total Amount :" meta:resourcekey="lblTotaltxtResource1"></asp:Label>
                    </td>
                    <td class="a-right w-36p">
                        <asp:Label ID="lblTotal" Text="0" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="ISAddItems" runat="server" />
<asp:HiddenField ID="hdnFromDate" Value='<%= DateTime.Now %>' runat="server" />
<asp:HiddenField ID="hdnIsCorpOrg" Value="N" runat="server" />
<asp:HiddenField ID="hdnsPage" runat="server" />
<asp:HiddenField ID="hdnIsMappingtems" runat="server" Value="N" />
<asp:HiddenField ID="hdnMessages" runat="server" />
<%-- </ContentTemplate>
</asp:UpdatePanel>--%>

<script language="javascript" type="text/javascript">
    //LoadOrdItems();
    if (document.getElementById('<%= hidID.ClientID %>') != null && document.getElementById('<%=listINV.ClientID %>') != null) {
        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
        document.getElementById('<%=listINV.ClientID %>').selectedIndex = 0;
        SetId(document.getElementById('<%= hidID.ClientID %>').value);
    }

    function SetValues() {
        ////debugger;
        document.getElementById('<%= hdnOrderdINVNew.ClientID %>').value = '';
        var table = document.getElementById('tblOrederedInves');
        var ordInvList = '';
        var newordInvList = '';
        ordInvList = document.getElementById('<%= hdnOrderdINV.ClientID %>').value;
        if (ordInvList != "") {

            var ListInvValue = ordInvList.split('^');
            for (var a = 0; a < ListInvValue.length; a++) {
                if (ListInvValue[a] != "") {
                    var InvValue = '';
                    InvValue = ListInvValue[a].split('~');

                    for (var k = 0; k < table.rows.length; k++) {
                        if (table.rows[k] != "") {
                            if (InvValue[0] == table.rows[k].childNodes[4].innerHTML && InvValue[2] == table.rows[k].childNodes[2].innerHTML) {
                                InvValue[3] = table.rows[k].cells[3].childNodes[0].value;
                            }

                        }
                    }
                    document.getElementById('<%= hdnOrderdINVNew.ClientID %>').value += InvValue[0] + '~' + InvValue[1] + '~' + InvValue[2] + '~' + InvValue[3] + '^';
                }
            }
        }
    }
</script>

