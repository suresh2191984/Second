<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CultureandSensitivityReportV1.ascx.cs"
    Inherits="Investigation_CultureandSensitivityReportV1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function validateSymbol(evt) {
        var keyCode = 0;
        if (evt) {
            keyCode = evt.keyCode || evt.which;
        }
        else {
            keyCode = window.event.keyCode;
        }
        //alert('keyCode  : '+keyCode);
        if ((keyCode == 126) || (keyCode == 94)) {
            return false;
        }
        else {
            return true;
        }
    }

    function ShowLoadingDrug(id) {

        alert(id);
        document.getElementById(document.getElementById('hdndivprogid').value).style.display = "block";

    }
    function HideLoadingDrug() {


        document.getElementById(document.getElementById('hdndivprogid').value).style.display = "none";
        alert(id);
    }

    function showHideClientType(rdObj) {

        if (rdObj.value == '1') {
            document.getElementById('CTHospital').style.display = 'block';
            document.getElementById('CTBranch').style.display = 'none';
        }
        else if (rdObj.value == '2') {
            document.getElementById('CTHospital').style.display = 'none';
            document.getElementById('CTBranch').style.display = 'block';
        }
        else {
            document.getElementById('CTHospital').style.display = 'none';
            document.getElementById('CTBranch').style.display = 'none';
        }

    }


    function AddControl(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vOrgName = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_01') == null ? "Organism Name:" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_01');
        var vSensitive = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_02') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_02');
        var vModerately = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_03') == null ? "Moderately sensitive to" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_03');
        var vResistant = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_04') == null ? "Resistant" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_04');
        var vDrugName = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_05') == null ? "DrugName" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_05');
        var vDisc = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_06') == null ? "Disc Diameter" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_06');
        var vSensitiveTo = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_07') == null ? "SensitiveTo" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_07');
        var vResistantTo = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_09') == null ? "ResistantTo" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_09');
        //alert(document.getElementById('divTab').innerHTML);
        //alert(id);
        var splitID = id.split('_');
        document.getElementById(splitID[0] + '_divTab').innerHTML = '';
        var drgName = document.getElementById(splitID[0] + '_drugname').value;
        var splidrg = drgName.split('$');
        var noCtrl = document.getElementById(splitID[0] + '_txtOrgan').value;
        //alert(noCtrl);
        for (var i = 0; i < noCtrl; i++) {
            var table = '';

            table = "<TABLE cellpadding='0' cellspacing='0' width='100%' style='padding-bottom:20px;'Class='colorforcontentborder' border='0'>"
                    + "<TR style='height:25px;'><TD>" + vOrgName + " </TD><TD Colspan='5'>"
                    + "<input type='text' id='" + splitID[0] + "_txtOrgName_" + i + "' /></TD></TR>"
                    + "<TR style='height:15px; font-size:11px;' Class='Duecolor'>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vSensitive + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vModerately + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vResistant + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vDrugName + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;width:10%;'>" + vDisc + "</TD>"
                    + "<TD>&nbsp;</TD></TR>"
                    + "<TR style='height:30px;'><TD><input type='radio' id='" + splitID[0] + "_rdoSensitive_" + i + "' value='STO' name='" + splitID[0] + "rdo" + i + "' checked='checked'  />" + vSensitiveTo + "</TD>"
                    + "<TD><input type='radio'  id='" + splitID[0] + "_rdoModerate_" + i + "' value='mTO ' name='" + splitID[0] + "rdo" + i + "' />" + vModerately + "</TD>"
                    + "<TD><input type='radio'  id='" + splitID[0] + "_rdoResistant_" + i + "' value='rTO' name='" + splitID[0] + "rdo" + i + "' /> " + vResistantTo + "</TD>"
                    + "<TD><select id='" + splitID[0] + "_ddl1_" + i + "' style='width:150px;'>";
            for (var j = 0; j < splidrg.length; j++) {
                table += "<option selected='selected' value='" + splidrg[j] + "'>" + splidrg[j] + "</option>";
                //alert(AddDrug[i]);
            }
            table += "</select></TD><TD><input type='text' style='width:100px;' id='" + splitID[0] + "_uom_" + i + "' />"
                        + "</TD><TD><input type='button' id='" + splitID[0] + "_btnADD_" + i + "' value='Add' OnClick='javascript:return AddSensitiveToTable(this.id);'/>"
                        + "</TD></TR><TR><TD colspan='5'><TABLE width='100%'><TR><TD width='33%' align='left' valign='Top'><TABLE width='100%' id='" + splitID[0] + "_tblSensitive_" + i + "' cellpadding='1' border='1'></TABLE></TD>"
                        + "<TD width='33%' align='left' valign='Top'><TABLE width='100%' id='" + splitID[0] + "_tblModerate_" + i + "'  cellpadding='1' border='1'></TABLE></TD>"
                        + "<TD width='33%' align='left' valign='Top'><TABLE width='100%' id='" + splitID[0] + "_tblResistant_" + i + "'  cellpadding='1' border='1'></TABLE></TD>"
                        + "</TR></TABLE></TD></TR></TABLE>";

            document.getElementById(splitID[0] + '_divTab').innerHTML += table;
        }

        return false;
    }

    function AddSensitiveToTable(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDrugAlready = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_01') == null ? "Drug Already Added. Please Check." : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_01');
        var vOrganism = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_02') == null ? "Enter Organism name and then add Drug" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_aspx_02');
        //alert(id);
        var splitID = id.split('_');
        var sensitiveTo;
        var mSensitive;
        var mResistantTo;
        var AddStatus = 0;
        var rowNumber = 0;
        var CheckDrugName = '';
        var organName = '';
        var AlreadyExists = 0;
        var a1, b1, c1, d1, e1, f1, g1, h1;

        var HidValue = document.getElementById(splitID[0] + '_hresistantto').value;
        organName = document.getElementById(splitID[0] + '_txtOrgName_' + splitID[2]).value;

        if (organName != '') {

            var UOMCode = '';
            UOMCode = document.getElementById(splitID[0] + '_uom_' + splitID[2]).value;
            if (document.getElementById(splitID[0] + '_rdoSensitive_' + splitID[2]).checked == true) {
                if (UOMCode != '') {
                    sensitiveTo = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text + " - (" + UOMCode + ")";
                }
                else {
                    sensitiveTo = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text;
                }

                if (document.getElementById(splitID[0] + '_hresistantto').value != "") {
                    a1 = document.getElementById(splitID[0] + '_hresistantto').value.split('^');
                    b1 = a1.length;
                    for (i = 0; i < b1 - 1; i++) {
                        c1 = a1[i].split('~');
                        d1 = c1[2].split(':');
                        f1 = d1[1].split(' ');
                        g1 = c1[0].split(':');
                        h1 = sensitiveTo.split(' ');
                        if (g1[1] == organName && f1[0] == h1[0]) {
                            AlreadyExists = 1;
                        }
                    }
                }

                if (AlreadyExists != 1) {
                    var row = document.getElementById(splitID[0] + '_tblSensitive_' + splitID[2]).insertRow(0);
                    //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
                    // alert(sensitiveTo);
                    rowNumber = HidValue.split('^').length;
                    var rowID = splitID[0] + "_" + sensitiveTo + "_" + rowNumber;
                    //alert(id);

                    row.id = rowID;
                    row.style.fontWeight = "normal";
                    row.style.fontsize = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);

                    //document.getElementById(splitID[0] + '_tblSensitiveToResult').style.display = "block";
                    cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                    //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
                    cell1.width = "5%";
                    cell2.innerHTML = sensitiveTo;
                    document.getElementById(splitID[0] + '_hresistantto').value += "OrganName:" + organName + "~RID:" + rowNumber + "~sTO:" + sensitiveTo + "^";
                    CheckDrugName = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text;
                }
                else if (AlreadyExists == 1) {
                    //alert("Drug Already Added. Please Check.");
                    ValidationWindow(vDrugAlready, AlertType);
                }
            }

            if (document.getElementById(splitID[0] + '_rdoModerate_' + splitID[2]).checked == true) {
                if (UOMCode != '') {

                    mSensitive = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text + " - (" + UOMCode + ")";
                }
                else {
                    mSensitive = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text;
                }
                if (document.getElementById(splitID[0] + '_hresistantto').value != "") {
                    a1 = document.getElementById(splitID[0] + '_hresistantto').value.split('^');
                    b1 = a1.length;
                    for (i = 0; i < b1 - 1; i++) {
                        c1 = a1[i].split('~');
                        d1 = c1[2].split(':');
                        f1 = d1[1].split(' ');
                        g1 = c1[0].split(':');
                        h1 = mSensitive.split(' ');
                        if (g1[1] == organName && f1[0] == h1[0]) {
                            AlreadyExists = 1;
                        }
                    }
                }
                if (AlreadyExists != 1) {
                    var row = document.getElementById(splitID[0] + '_tblModerate_' + splitID[2]).insertRow(0);

                    //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
                    //alert(sensitiveTo);
                    rowNumber = HidValue.split('^').length;
                    var rowID = splitID[0] + "_" + mSensitive + "_" + rowNumber;
                    //alert(id);
                    row.id = rowID;
                    row.style.fontWeight = "normal";
                    row.style.fontsize = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                    //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
                    cell1.width = "5%";
                    cell2.innerHTML = mSensitive;
                    //cell2.innerHTML = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text;
                    //cell3.innerHTML = UOMCode;
                    //                cell4.innerHTML = mResistantTo;
                    //                cell3.innerHTML = mSensitive;
                    document.getElementById(splitID[0] + '_hresistantto').value += "OrganName:" + organName + "~RID:" + rowNumber + "~mTO:" + mSensitive + "^";
                }
                else if (AlreadyExists == 1) {
                    // alert("Drug Already Added. Please Check.");
                    ValidationWindow(vDrugAlready, AlertType);
                }
            }


            if (document.getElementById(splitID[0] + '_rdoResistant_' + splitID[2]).checked == true) {
                if (UOMCode != '') {
                    mResistantTo = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text + " - (" + UOMCode + ")";
                }
                else {
                    mResistantTo = document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).options[document.getElementById(splitID[0] + '_ddl1_' + splitID[2]).selectedIndex].text;
                }
                if (document.getElementById(splitID[0] + '_hresistantto').value != "") {
                    a1 = document.getElementById(splitID[0] + '_hresistantto').value.split('^');
                    b1 = a1.length;
                    for (i = 0; i < b1 - 1; i++) {
                        c1 = a1[i].split('~');
                        d1 = c1[2].split(':');
                        f1 = d1[1].split(' ');
                        g1 = c1[0].split(':');
                        h1 = mResistantTo.split(' ');
                        if (g1[1] == organName && f1[0] == h1[0]) {
                            AlreadyExists = 1;
                        }
                    }
                }
                if (AlreadyExists != 1) {
                    var row = document.getElementById(splitID[0] + '_tblResistant_' + splitID[2]).insertRow(0);

                    //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
                    //alert(sensitiveTo);
                    rowNumber = HidValue.split('^').length;
                    var rowID = splitID[0] + "_" + mResistantTo + "_" + rowNumber;
                    //alert(id);

                    row.id = rowID;
                    row.style.fontWeight = "normal";
                    row.style.fontsize = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    //                var cell3 = row.insertCell(2);
                    //                var cell4 = row.insertCell(3);

                    //document.getElementById(splitID[0] + '_tblSensitiveToResult').style.display = "block";
                    cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                    //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
                    cell1.width = "5%";
                    cell2.innerHTML = mResistantTo;
                    //                cell4.innerHTML = mResistantTo;
                    //                cell3.innerHTML = mSensitive;
                    document.getElementById(splitID[0] + '_hresistantto').value += "OrganName:" + organName + "~RID:" + rowNumber + "~rTO:" + mResistantTo + "^";
                }
                else if (AlreadyExists == 1) {
                    //alert("Drug Already Added. Please Check.");
                    ValidationWindow(vDrugAlready, AlertType);
                }
            }


        }
        else {
            //alert('Enter Organism name and then add Drug');
            ValidationWindow(vOrganism, AlertType);
            document.getElementById(splitID[0] + '_txtOrgName_' + splitID[2]).focus();
        }
        return false;
    }


    function AddSensitiveImgOnclick(ImgID) {
        //alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hresistantto').value;
        var list = HidValue.split('^');
        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hresistantto').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');

                if (list[count] != '') {
                    if (InvesList[1] != 'RID:' + ImgsplitID[2]) {

                        newInvList += list[count] + '^';
                    }
                }
            }
            //alert(newInvList);
            document.getElementById(ImgsplitID[0] + '_hresistantto').value = newInvList;
        }
    }

    function LoadSensitivity(ControlID, SenstiveDrug, RowID, OrganismName) {
        //alert(RowID);
        var splitID = ControlID.split('_');
        var row = document.getElementById(splitID[0] + '_tblSensitive_' + splitID[2]).insertRow(0);
        document.getElementById(splitID[0] + '_txtOrgName_' + splitID[2]).value = OrganismName;
        var senTo = SenstiveDrug;
        //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
        //alert(row);
        var rowID = splitID[0] + "_" + senTo + "_" + RowID;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = senTo;
    }

    function LoadResistance(ControlID, ResistantDrug, RowID, OrganismName) {
        // alert(RowID);
        var splitID = ControlID.split('_');
        var row = document.getElementById(splitID[0] + '_tblResistant_' + splitID[2]).insertRow(0);
        document.getElementById(splitID[0] + '_txtOrgName_' + splitID[2]).value = OrganismName;
        var mRTo = ResistantDrug;
        //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
        // alert(row);
        var rowID = splitID[0] + "_" + mRTo + "_" + RowID;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = mRTo;
    }

    function LoadModerate(ControlID, ModerateDrug, RowID, OrganismName) {
        //alert(RowID);
        var splitID = ControlID.split('_');
        var row = document.getElementById(splitID[0] + '_tblModerate_' + splitID[2]).insertRow(0);
        document.getElementById(splitID[0] + '_txtOrgName_' + splitID[2]).value = OrganismName;
        var mTo = ModerateDrug;
        //document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text
        //alert(row);
        var rowID = splitID[0] + "_" + mTo + "_" + RowID;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"AddSensitiveImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = mTo;
    }

    function ChangeNoZone(ddlID, txtID) {

        var ddl = document.getElementById(ddlID);
        var ddllength = ddl.options.length;

        for (var i = 0; i < ddllength; i++) {
            if (ddl.options[i].selected) {
                if (ddl.options[i].text == "Resistant") {
                    document.getElementById(txtID).value = 'No Zone'
                }
            }
        }

    }

    function Addmm(txtmmid) {

        if (document.getElementById(txtmmid).value != 'No Zone' && document.getElementById(txtmmid).value != '') {
            document.getElementById(txtmmid).value = document.getElementById(txtmmid).value + " mm";
        }

    }

    function Removemm(txtmmid) {

        if (document.getElementById(txtmmid).value != '') {
            var txtarry = document.getElementById(txtmmid).value.split(' mm')


            document.getElementById(txtmmid).value = txtarry[0];
        }

    }
    
    
</script>

<div>
    <table class="w-90p">
        <tr>
            <td class="a-center style1 font12" style="font-weight: normal; color: #000;">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" runat="server" Font-Bold="True" 
                    meta:resourcekey="lblNameResource1"></asp:Label>
                <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="Red" OnClick="lnkEdit_Click"
                    Text="Edit" Visible="False" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                    visible="false"><u>
                        <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlenabled" runat="server" CssClass="w-100p" 
                    meta:resourcekey="pnlenabledResource1">
                    <table class="w-100p">
                        <tr>
                            <td class="font11 h-20 w-100" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblReportStatus" runat="server" Text="Report Status" 
                                    meta:resourcekey="lblReportStatusResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:DropDownList ForeColor="Black" ID="ddlData" runat="server" 
                                    CssClass="ddlsmall" meta:resourcekey="ddlDataResource1">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                <asp:Label runat="server" ID="lblSampleName" Text="Sample Name">
                                </asp:Label>
                            </td>
                            <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">--%>
                        <%-- <asp:TextBox ID="txtSample" runat="server"></asp:TextBox>--%>
                        <%--  <asp:DropDownList ID="ddlSample" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblSource" runat="server" Text="Specimen" 
                                    meta:resourcekey="lblSourceResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ID="txtSource" CssClass="small" runat="server" 
                                    meta:resourcekey="txtSourceResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblClinicalDiagnosis" runat="server" Text="Clinical History" 
                                    meta:resourcekey="lblClinicalDiagnosisResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ID="txtClinicalDiagnosis" CssClass="small" TextMode="MultiLine" 
                                    runat="server" meta:resourcekey="txtClinicalDiagnosisResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="font-weight: normal; font-size: 11px; color: #000;" class="style2">
                                <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes"></asp:Label>
                            </td>
                            <td class="style3" style="font-weight: normal; font-size: 11px; color: #000;">
                                <asp:TextBox ID="txtClinicalNotes" onkeyup="javascript:return setCompletedStatus(this.id);"
                                    runat="server" TextMode="MultiLine" Width="400px"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <tr>
                            <td class="font11 h-20 v-bottom" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblMicroscopy" runat="server" Text="AFB Smear" 
                                    meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMicroscopy" runat="server" CssClass="small" 
                                    TextMode="MultiLine" meta:resourcekey="txtMicroscopyResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 3%;"
                                valign="top">
                                &nbsp;&nbsp;
                                <asp:Label ID="lblMicroscopy0" Visible="false" runat="server" Text="Gram's stain">
                                </asp:Label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td class="font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblCultureReport" runat="server" Text="Culture Result" 
                                    meta:resourcekey="lblCultureReportResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCultureReport" CssClass="small" runat="server" 
                                    TextMode="MultiLine" meta:resourcekey="txtCultureReportResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblGrowth" runat="server" Text="Growth" 
                                    meta:resourcekey="lblGrowthResource1"></asp:Label>
                            </td>
                            <td>
                                <%-- <asp:TextBox ID="txtGrowth" runat="server"></asp:TextBox>--%>
                                <asp:DropDownList ID="ddlGrowth" CssClass="ddlsmall" runat="server" 
                                    meta:resourcekey="ddlGrowthResource1">
                                </asp:DropDownList>
                                <asp:HyperLink ID="hlnkAdd" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                                    onclick="changeSourceName(this.id);" meta:resourcekey="hlnkAddResource1"></asp:HyperLink>
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;"
                                align="left">
                                <asp:Label ID="lblGrowthStatus" runat="server" Text="Growth Status">
                                </asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlGrowthStatus" runat="server">
                                    <asp:ListItem Text="Select" Value="Select" />
                                    <asp:ListItem Text="Scanty" Value="Scanty" />
                                    <asp:ListItem Text="Moderate" Value="Moderate" />
                                    <asp:ListItem Text="Heavy" Value="Heavy" />
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <%--<tr>
                            <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                <asp:Label ID="lblColonyCount" runat="server" Text="Colony Count">
                                </asp:Label>
                            </td>
                            <td>--%>
                        <%-- <asp:TextBox ID="txtColonyCount" runat="server"></asp:TextBox>--%>
                        <%-- <asp:DropDownList ID="ddlColonyCount" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td class="a-left font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblNoofOrgans" runat="server" Text="Organism" 
                                    meta:resourcekey="lblNoofOrgansResource1"></asp:Label>
                            </td>
                            <td class="a-left font11" style="font-weight: normal; color: #000;">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%--<asp:TextBox runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                                ID="txtOrgan" Width="68px"></asp:TextBox>--%>
                                            <asp:DropDownList ID="ddlOrganismName" CssClass="ddlsmall" runat="server" 
                                                meta:resourcekey="ddlOrganismNameResource1">
                                            </asp:DropDownList>
                                            <%-- <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="Numbers" TargetControlID="txtOrgan"
                                                runat="server">
                                            </ajc:FilteredTextBoxExtender>--%>
                                            <asp:Button runat="server" ID="btnOrgADD" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnOrgADD_Click" 
                                                meta:resourcekey="btnOrgADDResource1" />
                                        </td>
                                        <td>
                                            <div id="divProgress" runat="server" class="a-center" style="position: absolute;
                                                top: 200px; left: 350px; display: none; z-index: 9999;">
                                                <table style="border-color: #000; color: #fff;">
                                                    <tr>
                                                        <td colspan="2">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <img id="img4" src="../Images/ajax-loader.gif" style="cursor: pointer;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;" colspan="2">
                                <div id="divTab" runat="server">
                                    <asp:Panel ID="pnltab" runat="server" meta:resourcekey="pnltabResource1">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblOrganismFirstLine" CssClass="dataheaderInvCtrl w-50p" 
                                                        runat="server" meta:resourcekey="tblOrganismFirstLineResource1">
                                                        <asp:TableRow ID="trFirstLine0" runat="server" 
                                                            meta:resourcekey="trFirstLine0Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName0" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName0Resource1">First Line</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone0" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone0Resource1">Breakpoint MICs</asp:TableCell>
                                                            <asp:TableCell ID="tcSensitivity0" runat="server" 
                                                                meta:resourcekey="tcSensitivity0Resource1">Sensitivity</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine1" runat="server" 
                                                            meta:resourcekey="trFirstLine1Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName1" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName1Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName1" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone1" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone1Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone1" runat="server" CssClass="small" onblur="Addmm(this.id)" 
                                                                meta:resourcekey="txtFirst_LineZone1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity1" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity1Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity1" CssClass="ddlsmall" runat="server"
                                                                    onchange="ChangeNoZone(this.id,'txtFirst_LineZone1')" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity1Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource1" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource2" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource3" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource4" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine2" runat="server" 
                                                            meta:resourcekey="trFirstLine2Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName2" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName2Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName2" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone2" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone2Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone2" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity2" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity2Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity2" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity2Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource5" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource6" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource7" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource8" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine3" runat="server" 
                                                            meta:resourcekey="trFirstLine3Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName3" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName3Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName3" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone3" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone3Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone3" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity3" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity3Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity3" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity3Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource9" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource10" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource11" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource12" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine4" runat="server" 
                                                            meta:resourcekey="trFirstLine4Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName4" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName4Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName4" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone4" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone4Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone4" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity4" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity4Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity4" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity4Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource13" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource14" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource15" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource16" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine5" runat="server" 
                                                            meta:resourcekey="trFirstLine5Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName5" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName5Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName5" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone5" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone5Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone5" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity5" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity5Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity5" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity5Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource17" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource18" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource19" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource20" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine6" runat="server" 
                                                            meta:resourcekey="trFirstLine6Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName6" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName6Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName6" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone6" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone6Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone6" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity6" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity6Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity6" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity6Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource21" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource22" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource23" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource24" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine7" runat="server" 
                                                            meta:resourcekey="trFirstLine7Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName7" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName7Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName7" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone7" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone7Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone7" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity7" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity7Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity7" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity7Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource25" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource26" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource27" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource28" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine8" runat="server" 
                                                            meta:resourcekey="trFirstLine8Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName8" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName8Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName8" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone8" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone8Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone8" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity8" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity8Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity8" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity8Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource29" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource30" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource31" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource32" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine9" runat="server" 
                                                            meta:resourcekey="trFirstLine9Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName9" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName9Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName9" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone9" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone9Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone9" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity9" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity9Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity9" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity9Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource33" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource34" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource35" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource36" />
</asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trFirstLine10" runat="server" 
                                                            meta:resourcekey="trFirstLine10Resource1">
                                                            <asp:TableCell ID="tcFirstLineDrugName10" runat="server" 
                                                                meta:resourcekey="tcFirstLineDrugName10Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineDrugName10" class="tb small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineDrugName10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineZone10" runat="server" 
                                                                meta:resourcekey="tcFirstLineZone10Resource1"><asp:TextBox 
                                                                ID="txtFirst_LineZone10" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtFirst_LineZone10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcFirstLineSensitivity10" runat="server" 
                                                                meta:resourcekey="tcFirstLineSensitivity10Resource1"><asp:DropDownList 
                                                                ID="tcFirst_LineddlSensitivity10" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcFirst_LineddlSensitivity10Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource37" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource38" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource39" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource40" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </td>
                                                <td>
                                                    <asp:Table ID="tblOrganismSecondLine" CssClass="dataheaderInvCtrl" runat="server"
                                                        class="w-50p" meta:resourcekey="tblOrganismSecondLineResource1">
                                                        <asp:TableRow ID="trSecondLine0" runat="server" 
                                                            meta:resourcekey="trSecondLine0Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName0" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName0Resource1">Second Line</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone0" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone0Resource1">Breakpoint MICs</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity0" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity0Resource1">
                                Sensitivity
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine1" runat="server" 
                                                            meta:resourcekey="trSecondLine1Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName1" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName1Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName1" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone1" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone1Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone1" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity1" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity1Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity1" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity1Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource41" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource42" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource43" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource44" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine2" runat="server" 
                                                            meta:resourcekey="trSecondLine2Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName2" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName2Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName2" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone2" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone2Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone2" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineddlSensitivity2" runat="server" 
                                                                meta:resourcekey="tcSecondLineddlSensitivity2Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity2" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity2Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource45" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource46" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource47" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource48" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine3" runat="server" 
                                                            meta:resourcekey="trSecondLine3Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName3" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName3Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName3" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone3" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone3Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone3" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity3" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity3Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity3" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity3Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource49" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource50" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource51" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource52" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine4" runat="server" 
                                                            meta:resourcekey="trSecondLine4Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName4" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName4Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName4" class="tb class" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone4" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone4Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone4" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity4" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity4Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity4" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity4Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource53" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource54" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource55" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource56" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine5" runat="server" 
                                                            meta:resourcekey="trSecondLine5Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName5" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName5Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName5" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone5" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone5Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone5" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity5" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity5Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity5" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity5Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource57" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource58" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource59" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource60" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine6" runat="server" 
                                                            meta:resourcekey="trSecondLine6Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName6" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName6Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName6" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone6" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone6Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone6" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity6" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity6Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity6" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity6Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource61" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource62" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource63" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource64" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine7" runat="server" 
                                                            meta:resourcekey="trSecondLine7Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName7" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName7Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName7" class="tb class" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone7" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone7Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone7" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity7" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity7Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity7" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity7Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource65" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource66" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource67" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource68" />
</asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine8" runat="server" 
                                                            meta:resourcekey="trSecondLine8Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName8" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName8Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName8" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone8" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone8Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone8" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity8" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity8Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity8" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity8Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource69" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource70" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource71" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource72" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine9" runat="server" 
                                                            meta:resourcekey="trSecondLine9Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName9" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName9Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName9" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone9" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone9Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone9" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity9" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity9Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity9" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity9Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource73" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource74" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource75" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource76" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trSecondLine10" runat="server" 
                                                            meta:resourcekey="trSecondLine10Resource1">
                                                            <asp:TableCell ID="tcSecondLineDrugName10" runat="server" 
                                                                meta:resourcekey="tcSecondLineDrugName10Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineDrugName10" class="tb small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineDrugName10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineZone10" runat="server" 
                                                                meta:resourcekey="tcSecondLineZone10Resource1"><asp:TextBox 
                                                                ID="txtSecond_LineZone10" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtSecond_LineZone10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcSecondLineSensitivity10" runat="server" 
                                                                meta:resourcekey="tcSecondLineSensitivity10Resource1"><asp:DropDownList 
                                                                ID="tcSecond_LineddlSensitivity10" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcSecond_LineddlSensitivity10Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource77" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource78" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource79" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource80" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblOrganismThirdLine" CssClass="dataheaderInvCtrl w-50p" 
                                                        runat="server" meta:resourcekey="tblOrganismThirdLineResource1">
                                                        <asp:TableRow ID="trThirdLine0" runat="server" 
                                                            meta:resourcekey="trThirdLine0Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName0" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName0Resource1">Third Line</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone0" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone0Resource1">Breakpoint MICs</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity0" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity0Resource1">
                                Sensitivity
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine1" runat="server" 
                                                            meta:resourcekey="trThirdLine1Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName1" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName1Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName1" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone1" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone1Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone1" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity1" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity1Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity1" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity1Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource81" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource82" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource83" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource84" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine2" runat="server" 
                                                            meta:resourcekey="trThirdLine2Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName2" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName2Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName2" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone2" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone2Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone2" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity2" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity2Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity2" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity2Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource85" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource86" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource87" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource88" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine3" runat="server" 
                                                            meta:resourcekey="trThirdLine3Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName3" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName3Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName3" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone3" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone3Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone3" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity3" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity3Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity3" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity3Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource89" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource90" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource91" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource92" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine4" runat="server" 
                                                            meta:resourcekey="trThirdLine4Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName4" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName4Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName4" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone4" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone4Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone4" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity4" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity4Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity4" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity4Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource93" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource94" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource95" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource96" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine5" runat="server" 
                                                            meta:resourcekey="trThirdLine5Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName5" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName5Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName5" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone5" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone5Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone5" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity5" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity5Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity5" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity5Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource97" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource98" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource99" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource100" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine6" runat="server" 
                                                            meta:resourcekey="trThirdLine6Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName6" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName6Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName6" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone6" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone6Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone6" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity6" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity6Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity6" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity6Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource101" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource102" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource103" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource104" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine7" runat="server" 
                                                            meta:resourcekey="trThirdLine7Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName7" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName7Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName7" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone7" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone7Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone7" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity7" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity7Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity7" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity7Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource105" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource106" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource107" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource108" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine8" runat="server" 
                                                            meta:resourcekey="trThirdLine8Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName8" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName8Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName8" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone8" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone8Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone8" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity8" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity8Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity8" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity8Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource109" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource110" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource111" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource112" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine9" runat="server" 
                                                            meta:resourcekey="trThirdLine9Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName9" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName9Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName9" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone9" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone9Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone9" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity9" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity9Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity9" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity9Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource113" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource114" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource115" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource116" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trThirdLine10" runat="server" 
                                                            meta:resourcekey="trThirdLine10Resource1">
                                                            <asp:TableCell ID="tcThirdLineDrugName10" runat="server" 
                                                                meta:resourcekey="tcThirdLineDrugName10Resource1"><asp:TextBox 
                                                                ID="txtThird_LineDrugName10" class="tb small" runat="server" 
                                                                meta:resourcekey="txtThird_LineDrugName10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineZone10" runat="server" 
                                                                meta:resourcekey="tcThirdLineZone10Resource1"><asp:TextBox 
                                                                ID="txtThird_LineZone10" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtThird_LineZone10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcThirdLineSensitivity10" runat="server" 
                                                                meta:resourcekey="tcThirdLineSensitivity10Resource1"><asp:DropDownList 
                                                                ID="tcThird_LineddlSensitivity10" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcThird_LineddlSensitivity10Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource117" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource118" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource119" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource120" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </td>
                                                <td>
                                                    <asp:Table ID="tblOrganismForthLine" CssClass="dataheaderInvCtrl w-50p" 
                                                        runat="server" meta:resourcekey="tblOrganismForthLineResource1">
                                                        <asp:TableRow ID="trForthLine0" runat="server" 
                                                            meta:resourcekey="trForthLine0Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName0" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName0Resource1">Fourth Line</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone0" runat="server" 
                                                                meta:resourcekey="tcForthLineZone0Resource1">Breakpoint MICs</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity0" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity0Resource1">
                                Sensitivity
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine1" runat="server" 
                                                            meta:resourcekey="trForthLine1Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName1" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName1Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName1" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone1" runat="server" 
                                                                meta:resourcekey="tcForthLineZone1Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone1" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone1Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity1" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity1Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity1" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity1Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource121" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource122" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource123" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource124" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine2" runat="server" 
                                                            meta:resourcekey="trForthLine2Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName2" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName2Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName2" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone2" runat="server" 
                                                                meta:resourcekey="tcForthLineZone2Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone2" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone2Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity2" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity2Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity2" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity2Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource125" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource126" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource127" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource128" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine3" runat="server" 
                                                            meta:resourcekey="trForthLine3Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName3" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName3Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName3" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone3" runat="server" 
                                                                meta:resourcekey="tcForthLineZone3Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone3" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone3Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity3" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity3Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity3" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity3Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource129" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource130" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource131" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource132" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine4" runat="server" 
                                                            meta:resourcekey="trForthLine4Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName4" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName4Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName4" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone4" runat="server" 
                                                                meta:resourcekey="tcForthLineZone4Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone4" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone4Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity4" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity4Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity4" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity4Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource133" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource134" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource135" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource136" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine5" runat="server" 
                                                            meta:resourcekey="trForthLine5Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName5" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName5Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName5" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone5" runat="server" 
                                                                meta:resourcekey="tcForthLineZone5Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone5" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone5Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity5" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity5Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity5" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity5Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource137" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource138" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource139" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource140" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine6" runat="server" 
                                                            meta:resourcekey="trForthLine6Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName6" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName6Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName6" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone6" runat="server" 
                                                                meta:resourcekey="tcForthLineZone6Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone6" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone6Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity6" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity6Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity6" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity6Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource141" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource142" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource143" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource144" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine7" runat="server" 
                                                            meta:resourcekey="trForthLine7Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName7" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName7Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName7" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone7" runat="server" 
                                                                meta:resourcekey="tcForthLineZone7Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone7" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone7Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity7" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity7Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity7" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity7Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource145" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource146" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource147" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource148" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine8" runat="server" 
                                                            meta:resourcekey="trForthLine8Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName8" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName8Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName8" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone8" runat="server" 
                                                                meta:resourcekey="tcForthLineZone8Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone8" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone8Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity8" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity8Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity8" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity8Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource149" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource150" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource151" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource152" />
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine9" runat="server" 
                                                            meta:resourcekey="trForthLine9Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName9" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName9Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName9" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone9" runat="server" 
                                                                meta:resourcekey="tcForthLineZone9Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone9" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone9Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity9" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity9Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity9" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity9Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource153" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource154" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource155" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource156" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow ID="trForthLine10" runat="server" 
                                                            meta:resourcekey="trForthLine10Resource1">
                                                            <asp:TableCell ID="tcForthLineDrugName10" runat="server" 
                                                                meta:resourcekey="tcForthLineDrugName10Resource1"><asp:TextBox 
                                                                ID="txtForth_LineDrugName10" class="tb small" runat="server" 
                                                                meta:resourcekey="txtForth_LineDrugName10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineZone10" runat="server" 
                                                                meta:resourcekey="tcForthLineZone10Resource1"><asp:TextBox 
                                                                ID="txtForth_LineZone10" CssClass="small" runat="server" 
                                                                meta:resourcekey="txtForth_LineZone10Resource1" />
</asp:TableCell>
                                                            <asp:TableCell ID="tcForthLineSensitivity10" runat="server" 
                                                                meta:resourcekey="tcForthLineSensitivity10Resource1"><asp:DropDownList 
                                                                ID="tcForth_LineddlSensitivity10" CssClass="ddlsmall" runat="server" 
                                                                meta:resourcekey="tcForth_LineddlSensitivity10Resource1"><asp:ListItem 
                                                                Text="Select" Value="Select" meta:resourcekey="ListItemResource157" />
<asp:ListItem Text="Sensitive" Value="Sensitive" meta:resourcekey="ListItemResource158" />
<asp:ListItem Text="Moderate" Value="Moderate" meta:resourcekey="ListItemResource159" />
<asp:ListItem Text="Resistant" Value="Resistant" meta:resourcekey="ListItemResource160" />
</asp:DropDownList>
</asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReportV1_aspx_01 %>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtReason" TextMode="MultiLine" 
                                    CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnRemarksID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReportV1_aspx_02 %>
                            </td>
                            <td>
                                <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                    TabIndex="-1" TextMode="MultiLine" CssClass="small" 
                                    meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReportV1_aspx_03 %>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlstatus" runat="server" CssClass="ddlsmall" 
                                    meta:resourcekey="ddlstatusResource1">
                                    <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource161"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                    <tr runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                    <tr runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                    <tr>
                                        <td>
                                            <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" CssClass="ddlsmall" runat="server"
                                                TabIndex="-1" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                    <tr>
                                        <td>
                                            <span class="richcombobox" class="w-100">
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
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" id="hresistantto" value="" class="w-100p" runat="server" />
                <input type="hidden" id="drugname" value="" class="w-100p" runat="server" />
                <asp:Label ID="lblraw" runat="server" Font-Bold="False" 
                    meta:resourcekey="lblrawResource1"></asp:Label>
            </td>
        </tr>
        <asp:HiddenField runat="server" ID="hidVal" />
    </table>
</div>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .list2
    {
        width: 110px;
        border: 1px solid DarkGray;
        list-style-type: none;
        margin: 0px;
        background-color: #fff;
        text-align: left;
        font-weight: normal;
        vertical-align: middle;
        color: Gray;
        font-family: Verdana;
        font-size: 11px;
    }
    ul.list2 li
    {
        padding: 0px 0px;
    }
    .listitem2
    {
        color: Gray;
    }
    .hoverlistitem2
    {
        background-color: #fff;
    }
    .listMain
    {
        background-color: #fff;
        width: 150px;
        max-height: 150px;
        text-align: left;
        list-style: none;
        margin-top: -1px;
        font-weight: normal;
        font-size: 12px;
        overflow: auto;
        padding-left: 1px;
    }
    .wordWheel .itemsMain
    {
        background: none;
        width: 150px;
        border-collapse: collapse;
        color: #383838;
        white-space: nowrap;
        text-align: left;
        font-weight: normal;
        font-size: 12px;
    }
    .wordWheel .itemsSelected
    {
        width: 150px;
        color: #ffffff;
        background: #;
    }
    .style1
    {
        width: 10%;
    }
    .style2
    {
        width: 3%;
        height: 20px;
    }
    .style3
    {
        height: 20px;
    }
    .wordWheel .itemsSelected3
    {
        width: 350px;
        color: #ffffff;
        background: #2c88b1;
        white-space: pre-wrap;
    }
    .listMain
    {
        background-color: #fff;
        width: 350px;
        max-height: 150px;
        text-align: left;
        list-style: none;
        margin-top: -1px;
        font-family: Verdana;
        font-size: 11px;
        overflow: auto;
        padding-left: 1px;
        scrollbar-base-color: pink;
        scrollbar-arrow-color: #469bd0; /* #000000;*/
        scrollbar-3dlight-color: #ffffff; /* #e9eef0;*/
        scrollbar-darkshadow-color: black; /* #909699;*/
        scrollbar-face-color: #dddcdc; /*#cfd0d1;*/
        scrollbar-highlight-color: #909699;
        scrollbar-shadow-color: #fff; /* #cfd0d1;*/
        scrollbar-track-color: #73b5de; /*#89c2e5;  */
    }
</style>
