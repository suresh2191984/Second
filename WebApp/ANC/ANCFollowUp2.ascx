<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ANCFollowUp2.ascx.cs" Inherits="ANC_ANCFollowUp2" %>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script src="../Scripts/bid.js" type="text/javascript" language="javascript"></script>

<script language="javascript" type="text/javascript">
    
    //Symptomatic

    function TableSymptomatic(id) {
        var splitID = id.split('_');
        var HidPreviousCompValue = document.getElementById('<%=hResultvalues.ClientID %>').value;
                
        var PrevList = HidPreviousCompValue.split('^');
        
        if (document.getElementById('<%=hResultvalues.ClientID %>').value != "") {
            for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {

                var PreviousCompList = PrevList[Pcount].split('~');
                var row = document.getElementById('<%=tblResult.ClientID %>').insertRow(1);
                //row.id = PreviousCompList;
                var rowID = splitID[0] + '_' + PreviousCompList[0].split(',')[0];
                row.id = rowID;
                //alert(rowID);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                document.getElementById(splitID[0] + '_tblResult').style.display = "block";
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=ImgOnclick('" + rowID + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PreviousCompList[0].split(',')[0];
                //cell2.style.display = "none";
            }
        }
        return false;
    }
    
    function AddItemsToTableSymptomatic(id) {
        //alert(id);
        var splitID = id.split('_');
        var type;
        var iName;
        var iValue;
        var AddStatus = 0;
        var rowNumber = 0;

        var HidValue = document.getElementById(splitID[0] + '_hResultvalues').value;
        //alert(HidValue);
        iName = document.getElementById(splitID[0] + '_txtSymptomatic').value;
        //alert(iName);
        //alert('splitid = ' + splitID[0]);
        //alert(iName);
        if (iName != "") {

            var row = document.getElementById(splitID[0] + '_tblResult').insertRow(1);
            rowNumber = HidValue.split('^').length;
            var temp;
            
            var rowID = splitID[0] + "_" + iName + temp + rowNumber;
            //alert('temp : ' + temp);
            row.id = rowID;
            //alert(rowID);
            row.style.fontWeight = "normal";
            row.style.fontsize = "10px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            
            document.getElementById(splitID[0] + '_tblResult').style.display = "block";
            cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";

            cell1.width = "5%";
            cell2.innerHTML = iName;
            cell2.width = "20%"

            document.getElementById(splitID[0] + '_hResultvalues').value += iName + "~" + rowNumber + "^";
            //alert(document.getElementById(splitID[0] + '_hResultvalues').value);

            document.getElementById(splitID[0] + '_txtSymptomatic').value = "";
        }
        return false;
    }

    function ImgOnclick(ImgID) {

        var ImgsplitID = ImgID.split('_');

        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hResultvalues').value;
        var list = HidValue.split('^');

        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hResultvalues').value != "") {
            for (var count = 0; count < list.length; count++) {
                if (list[count] != '') {
                    if (list[count] != ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hResultvalues').value = newInvList;
        }
    }

    //Examinations


    function TableExamination(id) {
        var splitID = id.split('_');
        var HidPreviousExamValue = document.getElementById('<%=hdnExaminations.ClientID %>').value;

        var PrevList = HidPreviousExamValue.split('^');

        if (document.getElementById('<%=hdnExaminations.ClientID %>').value != "") {
            for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {

                var PreviousExamList = PrevList[Pcount].split('~');
                var row = document.getElementById('<%=tblExaminations.ClientID %>').insertRow(1);
                //row.id = PreviousExamList;
                var rowID = splitID[0] + '_' + PreviousExamList[0].split(',')[0];
                row.id = rowID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                document.getElementById(splitID[0] + '_tblExaminations').style.display = "block";
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=ImgOnclickE('" + rowID + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PreviousExamList[0].split(',')[0];
                //cell2.style.display = "none";
            }
        }
        return false;
    }

    function AddItemsToTableExaminations(idE) {
        var splitIDE = idE.split('_');
        var typeE;
        var iNameE;
        var AddStatusE = 0;
        var rowNumberE = 0;

        var HidValueE = document.getElementById(splitIDE[0] + '_hdnExaminations').value;
        iNameE = document.getElementById(splitIDE[0] + '_txtExamination').value;

        if (iNameE != "") {

            var rowE = document.getElementById(splitIDE[0] + '_tblExaminations').insertRow(1);
            rowNumberE = HidValueE.split('^').length;
            var tempE;

            var rowIDE = splitIDE[0] + "_" + iNameE + tempE + rowNumberE;

            rowE.id = rowIDE;
            rowE.style.fontWeight = "normal";
            rowE.style.fontsize = "10px";
            var cell1E = rowE.insertCell(0);
            var cell2E = rowE.insertCell(1);

            document.getElementById(splitIDE[0] + '_tblExaminations').style.display = "block";
            cell1E.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclickE(\'" + rowIDE + "\');\" src=\"../Images/Delete.jpg\" />";

            cell1E.width = "5%";
            cell2E.innerHTML = iNameE;
            cell2E.width = "20%"

            document.getElementById(splitIDE[0] + '_hdnExaminations').value += iNameE + "~" + rowNumberE + "^";

            document.getElementById(splitIDE[0] + '_txtExamination').value = "";
        }
        return false;
    }

    function ImgOnclickE(ImgIDE) {

        var ImgsplitIDE = ImgIDE.split('_');

        document.getElementById(ImgIDE).style.display = "none";
        var HidValueE = document.getElementById(ImgsplitIDE[0] + '_hdnExaminations').value;
        var listE = HidValueE.split('^');

        var newInvListE = '';
        if (document.getElementById(ImgsplitIDE[0] + '_hdnExaminations').value != "") {
            for (var countE = 0; countE < listE.length; countE++) {
                if (listE[countE] != '') {
                    if (listE[countE] != ImgsplitIDE[1]) {
                        newInvListE += listE[countE] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitIDE[0] + '_hdnExaminations').value = newInvListE;
        }
    }


    //Maternal Complication

    function TableCompM(id) {
        var splitID = id.split('_');
        var HidPreviousMCompValue = document.getElementById('<%=hdnMComplication.ClientID %>').value;

        var PrevList = HidPreviousMCompValue.split('^');

        if (document.getElementById('<%=hdnMComplication.ClientID %>').value != "") {
            for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {

                var PreviousMCompList = PrevList[Pcount].split('~');
                var row = document.getElementById('<%=tblMComplication.ClientID %>').insertRow(1);
                //row.id = PreviousMCompList;
                var rowID = splitID[0] + '_' + PreviousMCompList[0].split(',')[0];
                row.id = rowID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                document.getElementById(splitID[0] + '_tblMComplication').style.display = "block";
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=ImgOnclickMC('" + rowID + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PreviousMCompList[0].split(',')[0];
                //cell2.style.display = "none";
            }
        }
        return false;
    }

    function AddItemsToTableMComplication(idMC) {
        var splitIDMC = idMC.split('_');
        var typeMC;
        var iNameMC;
        var AddStatusMC = 0;
        var rowNumberMC = 0;

        var HidValueMC = document.getElementById(splitIDMC[0] + '_hdnMComplication').value;
        iNameMC = document.getElementById(splitIDMC[0] + '_txtMComplication').value;

        if (iNameMC != "") {

            var rowMC = document.getElementById(splitIDMC[0] + '_tblMComplication').insertRow(1);
            rowNumberMC = HidValueMC.split('^').length;
            var tempMC;

            var rowIDMC = splitIDMC[0] + "_" + iNameMC + tempMC + rowNumberMC;

            rowMC.id = rowIDMC;
            rowMC.style.fontWeight = "normal";
            rowMC.style.fontsize = "10px";
            var cell1MC = rowMC.insertCell(0);
            var cell2MC = rowMC.insertCell(1);

            document.getElementById(splitIDMC[0] + '_tblMComplication').style.display = "block";
            cell1MC.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclickMC(\'" + rowIDMC + "\');\" src=\"../Images/Delete.jpg\" />";

            cell1MC.width = "5%";
            cell2MC.innerHTML = iNameMC;
            cell2MC.width = "20%"

            document.getElementById(splitIDMC[0] + '_hdnMComplication').value += iNameMC + "~" + rowNumberMC + "^";

            document.getElementById(splitIDMC[0] + '_txtMComplication').value = "";
        }
        return false;
    }

    function ImgOnclickMC(ImgIDMC) {

        var ImgsplitIDMC = ImgIDMC.split('_');

        document.getElementById(ImgIDMC).style.display = "none";
        var HidValueMC = document.getElementById(ImgsplitIDMC[0] + '_hdnMComplication').value;
        var listMC = HidValueMC.split('^');

        var newInvListMC = '';
        if (document.getElementById(ImgsplitIDMC[0] + '_hdnMComplication').value != "") {
            for (var countMC = 0; countMC < listMC.length; countMC++) {
                if (listMC[countMC] != '') {
                    if (listMC[countMC] != ImgsplitIDMC[1]) {
                        newInvListMC += listMC[countMC] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitIDMC[0] + '_hdnMComplication').value = newInvListMC;
        }
    }

    //Foetus Complication

    function TableCompF(id) {
        var splitID = id.split('_');
        var HidPreviousFCompValue = document.getElementById('<%=hdnFComplication.ClientID %>').value;

        var PrevList = HidPreviousFCompValue.split('^');

        if (document.getElementById('<%=hdnFComplication.ClientID %>').value != "") {
            for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {

                var PreviousFCompList = PrevList[Pcount].split('~');
                var row = document.getElementById('<%=tblFComplication.ClientID %>').insertRow(1);
                //row.id = PreviousFCompList;
                var rowID = splitID[0] + '_' + PreviousFCompList[0].split(',')[0];
                row.id = rowID;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                document.getElementById(splitID[0] + '_tblFComplication').style.display = "block";
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=ImgOnclickFC('" + rowID + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PreviousFCompList[0].split(',')[0];
                //cell2.style.display = "none";
            }
        }
        return false;
    }

    function AddItemsToTableFComplication(idFC) {
        var splitIDFC = idFC.split('_');
        var typeFC;
        var iNameFC;
        var AddStatusFC = 0;
        var rowNumberFC = 0;

        var HidValueFC = document.getElementById(splitIDFC[0] + '_hdnFComplication').value;
        iNameFC = document.getElementById(splitIDFC[0] + '_txtFComplication').value;

        if (iNameFC != "") {

            var rowFC = document.getElementById(splitIDFC[0] + '_tblFComplication').insertRow(1);
            rowNumberFC = HidValueFC.split('^').length;
            var tempFC;

            var rowIDFC = splitIDFC[0] + "_" + iNameFC + tempFC + rowNumberFC;

            rowFC.id = rowIDFC;
            rowFC.style.fontWeight = "normal";
            rowFC.style.fontsize = "10px";
            var cell1FC = rowFC.insertCell(0);
            var cell2FC = rowFC.insertCell(1);

            document.getElementById(splitIDFC[0] + '_tblFComplication').style.display = "block";
            cell1FC.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclickFC(\'" + rowIDFC + "\');\" src=\"../Images/Delete.jpg\" />";

            cell1FC.width = "5%";
            cell2FC.innerHTML = iNameFC;
            cell2FC.width = "20%"

            document.getElementById(splitIDFC[0] + '_hdnFComplication').value += iNameFC + "~" + rowNumberFC + "^";

            document.getElementById(splitIDFC[0] + '_txtFComplication').value = "";
        }
        return false;
    }

    function ImgOnclickFC(ImgIDFC) {

        var ImgsplitIDFC = ImgIDFC.split('_');

        document.getElementById(ImgIDFC).style.display = "none";
        var HidValueFC = document.getElementById(ImgsplitIDFC[0] + '_hdnFComplication').value;
        var listFC = HidValueFC.split('^');

        var newInvListFC = '';
        if (document.getElementById(ImgsplitIDFC[0] + '_hdnFComplication').value != "") {
            for (var countFC = 0; countFC < listFC.length; countFC++) {
                if (listFC[countFC] != '') {
                    if (listFC[countFC] != ImgsplitIDFC[1]) {
                        newInvListFC += listFC[countFC] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitIDFC[0] + '_hdnFComplication').value = newInvListFC;
        }
    }

    function ValidateExam(id) {
        //alert(id);
        var name;

        var arrayID = new Array();
        arrayID = id.split('_');
        if (arrayID.length > 0) {
            name = arrayID[1];
        }
        //alert(name);
        if (name == 'rbNormal') {
            //alert('Normal');
            document.getElementById('ucANCFollowup_divPregnancy1').style.display = 'none';
            document.getElementById('ucANCFollowup_divGeneral').style.display = 'none';
            document.getElementById('ucANCFollowup_divObstratic').style.display = 'none';
            document.getElementById('ucANCFollowup_divBreast').style.display = 'none';
            document.getElementById('ucANCFollowup_divNipples').style.display = 'none';
            document.getElementById('ucANCFollowup_divGenitalia').style.display = 'none';
            document.getElementById('ucANCFollowup_divExamOthers').style.display = 'none';

            document.getElementById('ucANCFollowup_hdnExaminations').value = "";
            document.getElementById('ucANCFollowup_tblExaminations').style.display = "none";

            ExaminationNormal();
            ExaminationGeneral();
            ExaminationObstratic();
            ExaminationB();
            ExaminationN();
            ExaminationGenetalia();

        }
        else if (name == 'rbAbNormal') {
            //alert('Ab Normal');
            document.getElementById('ucANCFollowup_divPregnancy1').style.display = 'block';
            document.getElementById('ucANCFollowup_divExamOthers').style.display = 'block';
        }
        else {
        }

    }
    function ValidateGenObs(id) {
        //alert(id);
        var arrayID = new Array();
        arrayID = id.split('_');
        if (arrayID.length > 0) {
            name = arrayID[1];
        }

        if (name == 'chkGenH') {
            if (document.getElementById('ucANCFollowup_divGeneral').style.display == 'block') {
                document.getElementById('ucANCFollowup_divGeneral').style.display = 'none';
                ExaminationGeneral();
            }
            else {
                document.getElementById('ucANCFollowup_divGeneral').style.display = 'block';
            }
        }
        else if (name == 'chkObsH') {
            if (document.getElementById('ucANCFollowup_divObstratic').style.display == 'block') {
                document.getElementById('ucANCFollowup_divObstratic').style.display = 'none';
                document.getElementById('ucANCFollowup_divBreast').style.display = 'none';
                document.getElementById('ucANCFollowup_divNipples').style.display = 'none';
                document.getElementById('ucANCFollowup_divGenitalia').style.display = 'none';
                ExaminationObstratic();
                ExaminationB();
                ExaminationN();
                ExaminationGenetalia();
            }
            else {
                document.getElementById('ucANCFollowup_divObstratic').style.display = 'block';
            }
        }
    }

    function validateObsChild(id) {
        var arrayID = new Array();
        arrayID = id.split('_');
        if (arrayID.length > 0) {
            name = arrayID[1];
        }
        //alert(name);
        if (name == 'chkBreastH') {
            //alert('B');
            if (document.getElementById('ucANCFollowup_divBreast').style.display == 'block') {
                document.getElementById('ucANCFollowup_divBreast').style.display = 'none';
                ExaminationB();
            }
            else {
                document.getElementById('ucANCFollowup_divBreast').style.display = 'block';
            }
        }
        else if (name == 'chkNipplesH') {
            if (document.getElementById('ucANCFollowup_divNipples').style.display == 'block') {
                document.getElementById('ucANCFollowup_divNipples').style.display = 'none';
                ExaminationN();
            }
            else {
                document.getElementById('ucANCFollowup_divNipples').style.display = 'block';
            }
        }
        else if (name == 'chkGenitaliaH') {
            if (document.getElementById('ucANCFollowup_divGenitalia').style.display == 'block') {
                document.getElementById('ucANCFollowup_divGenitalia').style.display = 'none';
                ExaminationGenetalia();
            }
            else {
                document.getElementById('ucANCFollowup_divGenitalia').style.display = 'block';
            }
        }

    }

    function ExaminationNormal() {
        document.getElementById('ucANCFollowup_chkGenH').checked = false;
        document.getElementById('ucANCFollowup_chkObsH').checked = false;
    }

    function ExaminationGeneral() {
        document.getElementById('ucANCFollowup_cblGeneral').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_0').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_1').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_2').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_3').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_4').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_5').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_6').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_7').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_8').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_9').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_10').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_11').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_12').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_13').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_14').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_15').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_16').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_17').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_18').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_19').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_20').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_21').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_22').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_23').checked = false;
        document.getElementById('ucANCFollowup_cblGeneral_24').checked = false;
        //document.getElementById('ucANCFollowup_hdnExaminations').value = "";
    }

    function ExaminationObstratic() {
        document.getElementById('ucANCFollowup_chkBreastH').checked = false;
        document.getElementById('ucANCFollowup_chkNipplesH').checked = false;
        document.getElementById('ucANCFollowup_chkGenitaliaH').checked = false;
    }

    function ExaminationB() {
        document.getElementById('ucANCFollowup_cblBreastO_0').checked = false;
        document.getElementById('ucANCFollowup_cblBreastO_1').checked = false;
        document.getElementById('ucANCFollowup_cblBreastO_2').checked = false;
        document.getElementById('ucANCFollowup_cblBreastO_3').checked = false;
    }
    function ExaminationN() {

        document.getElementById('ucANCFollowup_cblNipplesO_0').checked = false;
        document.getElementById('ucANCFollowup_cblNipplesO_1').checked = false;
        document.getElementById('ucANCFollowup_cblNipplesO_2').checked = false;
    }
    function ExaminationGenetalia() {

        document.getElementById('ucANCFollowup_cblGenetaliaO_0').checked = false;
        document.getElementById('ucANCFollowup_cblGenetaliaO_1').checked = false;
        document.getElementById('ucANCFollowup_cblGenetaliaO_2').checked = false;
        document.getElementById('ucANCFollowup_cblGenetaliaO_3').checked = false;
    }
    function showExam() {
       

        document.getElementById('ucANCFollowup_divGeneral').style.display = 'none';
        document.getElementById('ucANCFollowup_divObstratic').style.display = 'block';
        document.getElementById('ucANCFollowup_divBreast').style.display = 'block';
        document.getElementById('ucANCFollowup_divNipples').style.display = 'block';
        document.getElementById('ucANCFollowup_divGenitalia').style.display = 'block';
        document.getElementById('ucANCFollowup_divExamOthers').style.display = 'block';
    }

    
</script>

<%--<asp:UpdatePanel ID="UpdatePanel" runat="server">
<ContentTemplate>--%>
<table cellspacing="0" cellpadding="0" style="width:550px; margin-left:20px;" class="dataheader2">

<tr>
    <td style="width: 100%" align="center" class="ancbg">
        <span><asp:Label ID="Rs_Maternal" Text="Maternal" runat="server" 
            meta:resourcekey="Rs_MaternalResource1"></asp:Label></span>
    </td>
    
</tr>
<tr height="5px"><td width="100%"></td></tr>
<tr>

    <td align="left" valign="middle" width="100%" 
        style="padding-left:5px; height:25px">
    <div style="display: none" id="ACX2plus1">
    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
        <asp:Label ID="Rs_Symptoms" Text="Symptoms" runat="server" 
            meta:resourcekey="Rs_SymptomsResource1"></asp:Label></span>
    </div>
    <div style="display: block" id="ACX2minus1">
    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
    <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
        <asp:Label ID ="Rs_Symptoms1" Text="Symptoms" runat="server" 
            meta:resourcekey="Rs_Symptoms1Resource1"></asp:Label></span>
    </div>
    </td>   
</tr>
<tr id="ACX2responses1" style="display: block">
    <td align="left" valign="top" height="23" width="100%">
    <asp:CheckBoxList CssClass="blackfontcolormediumanc" ID="chkSymptomatic" 
            RepeatColumns="5" runat="server" meta:resourcekey="chkSymptomaticResource1">
    </asp:CheckBoxList>
    <span class="defaultfontcolor"><asp:Label ID="Rs_Others" Text="Others" 
            runat="server" meta:resourcekey="Rs_OthersResource1"></asp:Label></span>
    <asp:TextBox ID="txtSymptomatic" runat="server" Width="300px"  CssClass ="Txtboxlarge"
             meta:resourcekey="txtSymptomaticResource1"></asp:TextBox>
    <asp:Button ID="btnAddProcess" runat="server" Text="Add" class="btn"
                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                    OnClientClick="return AddItemsToTableSymptomatic(this.id);" 
            meta:resourcekey="btnAddProcessResource1" />
    </td>
</tr>
<tr>
    <td>
    <input type="hidden" id="hResultvalues" value="" style="width: 346%;" runat="server" />
        <table id="tblResult" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
        width="100%" style="display: none;">
            <tr class="colorforcontent">
                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server" 
                        meta:resourcekey="Rs_DeleteResource1"></asp:Label>
                </td>
                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                    <asp:Label ID="Rs_OtherSymptomatics" Text="Other Symptomatics" runat="server" 
                        meta:resourcekey="Rs_OtherSymptomaticsResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td align="left" valign="middle" style="width: 100%; padding-left:5px" 
        height="25px">
    <div style="display: none" id="ACX2plus2">
    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
        <asp:Label ID="Rs_Examination" Text="Examination" runat="server" 
            meta:resourcekey="Rs_ExaminationResource1"></asp:Label></span>
    </div>
    <div style="display: block" id="ACX2minus2">
    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
    <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
        <asp:Label ID="Rs_Examination1" Text="Examination" runat="server" 
            meta:resourcekey="Rs_Examination1Resource1"></asp:Label></span>
    </div>
    </td>
   </tr>
<tr id="ACX2responses2" style="display: block">
    <td align="left" valign="top" class="tablerow" width="100%" height="23" 
        align="left">
        <asp:RadioButtonList Visible="False" CssClass="blackfontcolormedium" AutoPostBack="True" 
            ID="rblExamination1" RepeatDirection="Horizontal" runat="server" 
            onselectedindexchanged="rblExamination1_SelectedIndexChanged" 
            meta:resourcekey="rblExamination1Resource1">
            <asp:ListItem Selected="True" Text="Normal" 
                meta:resourcekey="ListItemResource1"></asp:ListItem>
            <asp:ListItem Text="Abnormal" meta:resourcekey="ListItemResource2"></asp:ListItem>
        </asp:RadioButtonList>
        <asp:RadioButton id="rbNormal" Text="Normal" onclick="ValidateExam(id)" 
            Checked="True" GroupName="colors" runat="server" 
            meta:resourcekey="rbNormalResource1"/>
        <asp:RadioButton id="rbAbNormal" Text="Ab Normal" onclick="ValidateExam(id)" 
            GroupName="colors" runat="server" meta:resourcekey="rbAbNormalResource1"/>
    
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:CheckBoxList RepeatColumns="2" CssClass="chkdefaultfontcolor" ID="chkAbnormal" 
                runat="server" AutoPostBack="True" 
                onselectedindexchanged="chkAbnormal_SelectedIndexChanged" 
                    meta:resourcekey="chkAbnormalResource1">
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td>
            <div id="divPregnancy1" runat="server">
                <input type="checkbox" runat="server" onclick="ValidateGenObs(id)" id="chkGenH" name="General" value="836">General</input>
                <input type="checkbox" runat="server" id="chkObsH" onclick="ValidateGenObs(id)" name="Obstretric" value="837">Obstretric</input>
            </div>
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Label ID="lblGeneral" CssClass="blackfontcolormedium" runat="server" Text="&nbsp;&nbsp;General"></asp:Label>--%>
                <asp:CheckBoxList CssClass="chkdefaultfontcolor" RepeatColumns="4" 
                    ID="chkGeneral" runat="server" meta:resourcekey="chkGeneralResource1">
                </asp:CheckBoxList>
                
                <div id="divGeneral" runat="server">
                <asp:Label ID="lblGeneral" CssClass="blackfontcolormedium" runat="server" 
                        Text="General" meta:resourcekey="lblGeneralResource1"></asp:Label>
                <asp:CheckBoxList ID="cblGeneral" RepeatColumns="4" runat="server" 
                        meta:resourcekey="cblGeneralResource1">
                    <asp:ListItem Text="Brittle nails" Value="89" 
                        meta:resourcekey="ListItemResource3"></asp:ListItem>
                    <asp:ListItem Text="clubbing" Value="114" meta:resourcekey="ListItemResource4"></asp:ListItem>
                    <asp:ListItem Text="Cyanosis" Value="146" meta:resourcekey="ListItemResource5"></asp:ListItem>
                    <asp:ListItem Text="Dry skin" Value="202" meta:resourcekey="ListItemResource6"></asp:ListItem>
                    
                    <asp:ListItem Text="ecchymoses" Value="212" 
                        meta:resourcekey="ListItemResource7"></asp:ListItem>
                    <asp:ListItem Text="elevated JVP" Value="217" 
                        meta:resourcekey="ListItemResource8"></asp:ListItem>
                    <asp:ListItem Text="Erythema" Value="234" meta:resourcekey="ListItemResource9"></asp:ListItem>
                    <asp:ListItem Text="Facial puffiness" Value="259" 
                        meta:resourcekey="ListItemResource10"></asp:ListItem>
                    
                    <asp:ListItem Text="Glossitis" Value="314" 
                        meta:resourcekey="ListItemResource11"></asp:ListItem>
                    <asp:ListItem Text="Hemorrhoids" Value="339" 
                        meta:resourcekey="ListItemResource12"></asp:ListItem>
                    <asp:ListItem Text="Hepatomegaly" Value="340" 
                        meta:resourcekey="ListItemResource13"></asp:ListItem>
                    <asp:ListItem Text="Icterus" Value="360" meta:resourcekey="ListItemResource14"></asp:ListItem>
                    
                    <asp:ListItem Text="Joint tenderness" Value="399" 
                        meta:resourcekey="ListItemResource15"></asp:ListItem>
                    <asp:ListItem Text="Lymphadenopathy" Value="445" 
                        meta:resourcekey="ListItemResource16"></asp:ListItem>
                    <asp:ListItem Text="pallor" Value="549" meta:resourcekey="ListItemResource17"></asp:ListItem>
                    <asp:ListItem Text="Pedal edema" Value="569" 
                        meta:resourcekey="ListItemResource18"></asp:ListItem>
                    
                    <asp:ListItem Text="skin hyperpigmentation" Value="692" 
                        meta:resourcekey="ListItemResource19"></asp:ListItem>
                    <asp:ListItem Text="splenomegaly" Value="716" 
                        meta:resourcekey="ListItemResource20"></asp:ListItem>
                    <asp:ListItem Text="Suprapubic tenderness" Value="729" 
                        meta:resourcekey="ListItemResource21"></asp:ListItem>
                    <asp:ListItem Text="Tachycardia" Value="743" 
                        meta:resourcekey="ListItemResource22"></asp:ListItem>
                    
                    <asp:ListItem Text="varicose veins" Value="814" 
                        meta:resourcekey="ListItemResource23"></asp:ListItem>
                    <asp:ListItem Text="Dehydrated Skin" Value="838" 
                        meta:resourcekey="ListItemResource24"></asp:ListItem>
                    <asp:ListItem Text="Tachypnea" Value="839" 
                        meta:resourcekey="ListItemResource25"></asp:ListItem>
                    <asp:ListItem Text="Respiratory Distress" Value="840" 
                        meta:resourcekey="ListItemResource26"></asp:ListItem>
                    
                    <asp:ListItem Text="Striae Gravidarum" Value="841" 
                        meta:resourcekey="ListItemResource27"></asp:ListItem>
                    
                </asp:CheckBoxList>
                <%--<table style="width: 100%">
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkBrittlenails"  name="Brittle nails" value="89">Brittle nails</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkclubbing" name="clubbing" value="114">clubbing</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkCyanosis" name="Cyanosis" value="146">Cyanosis</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkDryskin" name="Dry skin" value="202">Dry skin</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkecchymoses" name="ecchymoses" value="212">ecchymoses</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkelevatedJVP" name="elevated JVP" value="217">elevated JVP</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkErythema" name="Erythema" value="234">Erythema</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkFacialpuffiness" name="Facial puffiness" value="259">Facial puffiness</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkGlossitis" name="Glossitis" value="314">Glossitis</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkHemorrhoids" name="Hemorrhoids" value="339">Hemorrhoids</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkHepatomegaly" name="Hepatomegaly" value="340">Hepatomegaly</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkIcterus" name="Icterus" value="360">Icterus</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkJointtenderness" name="Joint tenderness" value="399">Joint tenderness</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkLymphadenopathy" name="Lymphadenopathy" value="445">Lymphadenopathy</input>
                        </td>
                        <td>
                <input type="checkbox" runat="server" id="chkpallor" name="pallor" value="549">pallor</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkPedaledema" name="Pedal edema" value="569">Pedal edema</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkskinhyperpigmentation" name="skin hyperpigmentation" value="692">skin hyperpigmentation</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chksplenomegaly" name="splenomegaly" value="716">splenomegaly</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkSuprapubictenderness" name="Suprapubic tenderness" value="729">Suprapubic tenderness</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkTachycardia" name="Tachycardia" value="743">Tachycardia</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkvaricoseveins" name="varicose veins" value="814">varicose veins</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkDehydratedSkin" name="Dehydrated Skin" value="838">Dehydrated Skin</input></td>
                        <td>
                <input type="checkbox" runat="server" id="chkTachypnea" name="Tachypnea" value="839">Tachypnea</input>
                        </td>
                        <td>
                <input type="checkbox" runat="server" id="chkRespiratoryDistress" name="Respiratory Distress" value="840">Respiratory Distress</input></td>
                    </tr>
                    <tr>
                        <td>
                <input type="checkbox" runat="server" id="chkStriaeGravidarum" name="Striae Gravidarum" value="841">Striae Gravidarum</input></td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>--%>
                </div>
                <table>
                    </table>
                
                
                
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Label ID="lblObstretric" CssClass="blackfontcolormedium" runat="server" Text="&nbsp;&nbsp;Obstretric"></asp:Label>--%>
                <asp:CheckBoxList CssClass="chkdefaultfontcolor"  AutoPostBack="True" 
                    RepeatColumns="4" ID="chkObstretric" 
                    runat="server" onselectedindexchanged="chkObstretric_SelectedIndexChanged" 
                    meta:resourcekey="chkObstretricResource1">
                </asp:CheckBoxList>
                <div id="divObstratic" runat="server">
                <asp:Label ID="lblObstretric" CssClass="blackfontcolormedium" runat="server" 
                        Text="Obstretric" meta:resourcekey="lblObstretricResource1"></asp:Label>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <input type="checkbox" runat="server" onclick="validateObsChild(id)" id="chkBreastH" name="Breast" value="842"><asp:Label 
                                ID="Rs_Breast" Text="Breast" runat="server" 
                                meta:resourcekey="Rs_BreastResource1"></asp:Label></input>
                        </td>
                        <td>
                            <input type="checkbox" runat="server" onclick="validateObsChild(id)" id="chkNipplesH" name="Nipples" value="843"><asp:Label 
                                ID="Rs_Nipples" Text="Nipples" runat="server" 
                                meta:resourcekey="Rs_NipplesResource1"></asp:Label></input>
                        </td>
                        <td>
                            <input type="checkbox" runat="server" onclick="validateObsChild(id)" id="chkGenitaliaH" name="Genitalia" value="844"><asp:Label 
                                ID="Rs_Genitalia" Text="Genitalia" runat="server" 
                                meta:resourcekey="Rs_GenitaliaResource1"></asp:Label></input>
                        </td>
                    </tr>
                </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
        <%--<asp:Label ID="lblBreast" CssClass="blackfontcolormedium" runat="server" Text="&nbsp;&nbsp;Breast"></asp:Label>--%>
        <asp:CheckBoxList CssClass="chkdefaultfontcolor" ID="chkBreast" RepeatColumns="4" 
                    runat="server" meta:resourcekey="chkBreastResource1">
        </asp:CheckBoxList>
        <div id="divBreast" runat="server">
        <asp:Label ID="lblBreast" CssClass="blackfontcolormedium" runat="server" 
                Text="Breast" meta:resourcekey="lblBreastResource1"></asp:Label>
        <asp:CheckBoxList ID="cblBreastO" runat="server" RepeatColumns="4" 
                meta:resourcekey="cblBreastOResource1">
            <asp:ListItem Text="Breast tenderness" Value="88" 
                meta:resourcekey="ListItemResource28"></asp:ListItem>
            <asp:ListItem Text="firm breast mass" Value="276" 
                meta:resourcekey="ListItemResource29"></asp:ListItem>
            <asp:ListItem Text="Galactorrhoea" Value="302" 
                meta:resourcekey="ListItemResource30"></asp:ListItem>
            <asp:ListItem Text="Hypoplastic" Value="845" 
                meta:resourcekey="ListItemResource31"></asp:ListItem>
        </asp:CheckBoxList>
        <%--<table style="width: 100%;">
            <tr>
                <td>
                    <input type="checkbox" runat="server" id="chkBreasttendernessB" name="Breast tenderness" value="88">Breast tenderness</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkfirmbreastmassB" name="firm breast mass" value="276">firm breast mass</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkGalactorrhoeaB" name="Galactorrhoea" value="302">Galactorrhoea</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkHypoplasticB" name="Hypoplastic" value="845">Hypoplastic</input>
                </td>
        </table>--%>
        </div>
            </td>
        </tr>
        <tr>
            <td>
        <%--<asp:Label ID="lblNipples" CssClass="blackfontcolormedium" runat="server" Text="&nbsp;&nbsp;Nipples"></asp:Label>--%>
        <asp:CheckBoxList CssClass="chkdefaultfontcolor" ID="chkNipples" RepeatColumns="4" 
                    runat="server" meta:resourcekey="chkNipplesResource1">
        </asp:CheckBoxList>
        <div id="divNipples" runat="server">
        <asp:Label ID="lblNipples" CssClass="blackfontcolormedium" runat="server" 
                Text="Nipples" meta:resourcekey="lblNipplesResource1"></asp:Label>
        <asp:CheckBoxList ID="cblNipplesO" runat="server" RepeatColumns="4" 
                meta:resourcekey="cblNipplesOResource1">
            <asp:ListItem Text="Discharge" Value="182" 
                meta:resourcekey="ListItemResource32"></asp:ListItem>
            <asp:ListItem Text="Retracted nipples" Value="640" 
                meta:resourcekey="ListItemResource33"></asp:ListItem>
            <asp:ListItem Text="Hypoplastic" Value="846" 
                meta:resourcekey="ListItemResource34"></asp:ListItem>
        </asp:CheckBoxList>
        <%--<table style="width: 100%;">
            <tr>
                <td>
                    <input type="checkbox" runat="server" id="chkDischargeN" name="Discharge" value="182">Discharge</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkRetractednipplesN" name="Retracted nipples" value="640">Retracted nipples</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkHypoplasticN" name="Hypoplastic" value="846">Hypoplastic</input>
                </td>
            </tr>
        </table>--%>
        </div>
            </td>
        </tr>
        <tr>
            <td>
        <%--<asp:Label ID="lblGenitalia" CssClass="blackfontcolormedium" runat="server" Text="&nbsp;&nbsp;Genitalia"></asp:Label>--%>
        <asp:CheckBoxList CssClass="chkdefaultfontcolor"  ID="chkGenitalia" RepeatColumns="4" 
                    runat="server" meta:resourcekey="chkGenitaliaResource1">
        </asp:CheckBoxList>
        <div id="divGenitalia" runat="server">
        <asp:Label ID="lblGenitalia" CssClass="blackfontcolormedium" runat="server" 
                Text="Genitalia" meta:resourcekey="lblGenitaliaResource1"></asp:Label>
        <asp:CheckBoxList ID="cblGenetaliaO" runat="server" RepeatColumns="4" 
                meta:resourcekey="cblGenetaliaOResource1">
            <asp:ListItem Text="Inflammed" Value="847" 
                meta:resourcekey="ListItemResource35"></asp:ListItem>
            <asp:ListItem Text="Herpes" Value="848" meta:resourcekey="ListItemResource36"></asp:ListItem>
            <asp:ListItem Text="Candidiasis" Value="849" 
                meta:resourcekey="ListItemResource37"></asp:ListItem>
            <asp:ListItem Text="Warts" Value="850" meta:resourcekey="ListItemResource38"></asp:ListItem>
        </asp:CheckBoxList>
        <%--<table style="width: 100%;">
            <tr>
                <td>
                    <input type="checkbox" runat="server" id="chkInflammedG" name="Inflammed" value="847">Inflammed</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkHerpesG" name="Herpes" value="848">Herpes</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkCandidiasisG" name="Candidiasis" value="849">Candidiasis</input>
                </td>
                <td>
                    <input type="checkbox" runat="server" id="chkWartsG" name="Warts" value="850">Warts</input>
                </td>
            </tr>
        </table>--%>
        </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divExamOthers" runat="server">
                <span class="defaultfontcolor"><asp:Label ID="Rs_Others1" Text="Others" 
                        runat="server" meta:resourcekey="Rs_Others1Resource1"></asp:Label></span>
                <asp:TextBox ID="txtExamination" runat="server" Width="300px"  CssClass ="Txtboxlarge"
                        meta:resourcekey="txtExaminationResource1"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Add" class="btn"
                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                    OnClientClick="return AddItemsToTableExaminations(this.id);" 
                        meta:resourcekey="Button1Resource1" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
            <input type="hidden" id="hdnExaminations" value="" style="width: 346%;" runat="server" />
                <table id="tblExaminations" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
                width="100%" style="display: none;">
                    <tr class="colorforcontent">
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                           <asp:Label ID="Rs_Delete1" Text="Delete" runat="server" 
                                meta:resourcekey="Rs_Delete1Resource1"></asp:Label>
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                            <asp:Label ID="Rs_OtherExaminations" Text="Other Examinations" runat="server" 
                                meta:resourcekey="Rs_OtherExaminationsResource1"></asp:Label>
                        </td>
                    </tr>
                </table>            
            </td>
        </tr>
        </table>

    </td>
</tr>
<tr>
    <td valign="middle" width="100%" style="padding-left:5px; height:25px">
    <div style="display: block" id="ACX2plus3">
    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
        <asp:Label ID="Rs_Complications" Text="Complications" runat="server" 
            meta:resourcekey="Rs_ComplicationsResource1"></asp:Label></span>
    </div>
    <div style="display: none" id="ACX2minus3">
    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
    <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">Complication</span>
    </div>
    </td>
    
</tr>
<tr id="ACX2responses3" style="display: none">
    <td align="left" valign="top" height="23">
    <asp:CheckBoxList CssClass="blackfontcolormediumanc" ID="chkMaternal" 
            RepeatColumns="3" runat="server" meta:resourcekey="chkMaternalResource1">
        </asp:CheckBoxList>
    <span class="defaultfontcolor"><asp:Label ID="Rs_Others2" Text="Others" 
            runat="server" meta:resourcekey="Rs_Others2Resource1"></asp:Label></span>
        <asp:TextBox ID="txtMComplication" runat="server" Width="300px" CssClass ="Txtboxlarge" 
            meta:resourcekey="txtMComplicationResource1"></asp:TextBox>
        <asp:Button ID="btnMComplication" runat="server" Text="Add" class="btn"
            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
            OnClientClick="return AddItemsToTableMComplication(this.id);" 
            meta:resourcekey="btnMComplicationResource1" />
<br />&nbsp;
            <input type="hidden" id="hdnMComplication" value="" style="width: 346%;" runat="server" />
            <table id="tblMComplication" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
            width="100%" style="display: none;">
                <tr class="colorforcontent">
                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                      <asp:Label ID="Rs_Delete2" Text="Delete" runat="server" 
                            meta:resourcekey="Rs_Delete2Resource1"></asp:Label>
                    </td>
                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                        <asp:Label ID="Rs_OtherComplication" Text="Other Complication(Maternal)" 
                            runat="server" meta:resourcekey="Rs_OtherComplicationResource1"></asp:Label>
                    </td>                </tr>
            </table>
    </td>
</tr>
<tr>
    <td>
        &nbsp;
    </td>
</tr>
<tr>
    <td style="width: 100%;" align="center" class="ancbg">
        <span><asp:Label ID="Rs_Fetus" Text="Fetus" runat="server" 
            meta:resourcekey="Rs_FetusResource1"></asp:Label></span>
    </td>
    
</tr>
<tr height="5px"><td></td></tr>
<tr>
    <td align="left" valign="middle" height="23px" style="padding-left:5px">
    <div style="display: none" id="ACX2plus4">
    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);">
        <asp:Label ID="Rs_FetalFindings" Text="Fetal Findings" runat="server" 
            meta:resourcekey="Rs_FetalFindingsResource1"></asp:Label></span>
    </div>
    <div style="display: block" id="ACX2minus4">
    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);">
        <asp:Label ID="Rs_FetalFindings1" Text="Fetal Findings" runat="server" 
            meta:resourcekey="Rs_FetalFindings1Resource1"></asp:Label></span>
    </div>
    </td>
     
</tr>
<tr id="ACX2responses4" style="display: block">
    <td align="left" valign="top" style="width: 80%; padding-left:10px;" 
        height="23" class="tablerow">
        <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rblFetals" 
            RepeatDirection="Horizontal" runat="server" 
            meta:resourcekey="rblFetalsResource1">
            <asp:ListItem Selected="True" Value="Y" Text="Normal" 
                meta:resourcekey="ListItemResource39"></asp:ListItem>
            <asp:ListItem Text="Abnormal" Value="N" meta:resourcekey="ListItemResource40"></asp:ListItem>
        </asp:RadioButtonList>
        <br />
    <asp:Table CssClass="tablerow" ID="ddlTable" runat="server" Width="90%" 
            meta:resourcekey="ddlTableResource1">
            <asp:TableHeaderRow meta:resourcekey="TableHeaderRowResource1">
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource1"><asp:Label ID="Rs_Fetus1" 
                    Text="Fetus" runat="server" meta:resourcekey="Rs_Fetus1Resource1"></asp:Label>
            
</asp:TableHeaderCell>
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource2"><asp:Label ID="Rs_Presentation" 
                    Text="Presentation" runat="server" meta:resourcekey="Rs_PresentationResource1"></asp:Label>
            
</asp:TableHeaderCell>
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource3"><asp:Label ID="Rs_Position" 
                    Text="Position" runat="server" meta:resourcekey="Rs_PositionResource1"></asp:Label>
            
</asp:TableHeaderCell>
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource4"><asp:Label ID="Rs_Movement" 
                    Text="Movement" runat="server" meta:resourcekey="Rs_MovementResource1"></asp:Label>
            
</asp:TableHeaderCell>
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource5"><asp:Label ID="Rs_FHS" 
                    Text="FHS" runat="server" meta:resourcekey="Rs_FHSResource1"></asp:Label>
            
</asp:TableHeaderCell>
            <asp:TableHeaderCell CssClass="defaultfontcolor" 
                    meta:resourcekey="TableHeaderCellResource6"><asp:Label ID="Rs_Others3" 
                    Text="Others" runat="server" meta:resourcekey="Rs_Others3Resource1"></asp:Label>
            
</asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table> 
        <asp:Label ID="lblFetals" runat="server" meta:resourcekey="lblFetalsResource1"></asp:Label>       
    </td>
</tr>
<tr>
    <td align="left" valign="middle" style="padding-left:5px; height:23px">
    <div style="display: block" id="ACX2plus5">
    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',1);">
        <asp:Label ID="Rs_Complications1" Text="Complications" runat="server" 
            meta:resourcekey="Rs_Complications1Resource1"></asp:Label></span>
    </div>
    <div style="display: none" id="ACX2minus5">
    <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);" />
        <span class="blackfontcolormedium" style="cursor: pointer" onclick="showResponses('ACX2plus5','ACX2minus5','ACX2responses5',0);">
        <asp:Label ID="Rs_Complication" Text="Complication" runat="server" 
            meta:resourcekey="Rs_ComplicationResource1"></asp:Label></span>
    </div>
    </td>
</tr>
<tr id="ACX2responses5" style="display: none">
    <td align="left" valign="top" style="width: 100%" height="23" class="tablerow">
        <table width="100%">
            <tr>
                <td>
                    <asp:CheckBoxList CssClass="chkdefaultfontcolor" AutoPostBack="True" 
                        ID="chkFoetus" RepeatColumns="3" runat="server" 
                        onselectedindexchanged="chkFoetus_SelectedIndexChanged" 
                        meta:resourcekey="chkFoetusResource1"></asp:CheckBoxList>
                    <asp:TreeView ID="TVH" runat="server" PathSeparator="-" ParentNodeStyle-ChildNodesPadding="2"
                        EnableTheming="True" ForeColor="Black" AutoPostBack="false" 
                        meta:resourcekey="TVHResource1">
<ParentNodeStyle ChildNodesPadding="2px"></ParentNodeStyle>

                            <RootNodeStyle CssClass="defaultfontcolor" />
                           
                    </asp:TreeView>
                    <asp:CheckBoxList ID="cblFoetus" runat="server" RepeatColumns="4" 
                        meta:resourcekey="cblFoetusResource1">
                        <asp:ListItem Text="Abnormal Presentation" Value="26" 
                            meta:resourcekey="ListItemResource41"></asp:ListItem>
                        <asp:ListItem Text="IUGR" Value="27" meta:resourcekey="ListItemResource42"></asp:ListItem>
                        <asp:ListItem Text="Congenital Fetal Anamoly" Value="29" 
                            meta:resourcekey="ListItemResource43"></asp:ListItem>
                        <asp:ListItem Text="Foetal Demise" Value="30" 
                            meta:resourcekey="ListItemResource44"></asp:ListItem>
                        <asp:ListItem Text="Ovarian" Value="31" meta:resourcekey="ListItemResource45"></asp:ListItem>
                        <asp:ListItem Text="Tubal" Value="32" meta:resourcekey="ListItemResource46"></asp:ListItem>
                        <asp:ListItem Text="Abdominal" Value="33" meta:resourcekey="ListItemResource47"></asp:ListItem>
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="defaultfontcolor"><asp:Label ID="Rs_Others4" Text="Others" 
                        runat="server" meta:resourcekey="Rs_Others4Resource1"></asp:Label></span>
                    <asp:TextBox ID="txtFComplication" runat="server" Width="300px" CssClass ="Txtboxlarge" 
                        meta:resourcekey="txtFComplicationResource1"></asp:TextBox>
                    <asp:Button ID="btnFComplication" runat="server" Text="Add" class="btn"
                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return AddItemsToTableFComplication(this.id);" 
                        meta:resourcekey="btnFComplicationResource1" />
                </td>
            </tr>
            <tr>
                <td>
                <input type="hidden" id="hdnFComplication" value="" style="width: 346%;" runat="server" />
                    <table id="tblFComplication" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
                    width="100%" style="display: none;">
                        <tr class="colorforcontent">
                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                <asp:Label ID="Rs_Delete3" Text="Delete" runat="server" 
                                    meta:resourcekey="Rs_Delete3Resource1"></asp:Label>
                            </td>
                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                               <asp:Label ID="Rs_OtherComplication2" Text="Other Complication(Foetus)" 
                                    runat="server" meta:resourcekey="Rs_OtherComplication2Resource1"></asp:Label>
                            </td>
                        </tr>
                    </table>            
                </td>
            </tr>            
            <tr>
                <td>
                    <asp:Label ID="lblEctopic" CssClass="blackf2ontcolormedium" runat="server" 
                        Text="Ectopic Gestation" meta:resourcekey="lblEctopicResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBoxList ID="chkEctopicGestation" RepeatColumns="3" 
                        CssClass="chkdefaultfontcolor"  runat="server" 
                        meta:resourcekey="chkEctopicGestationResource1">
        </asp:CheckBoxList>
                </td>
            </tr>
        </table>
    </td>
</tr>

</table>
<%--</ContentTemplate>
</asp:UpdatePanel>--%>