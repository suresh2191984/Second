<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CultureandSensitivityReport.ascx.cs"
    Inherits="Investigation_CultureandSensitivityReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function validate() {
        var number = document.getElementById('4435~~0_txtOrgan').value;
        if (number > 5) {

            document.getElementById('4435~~0_txtOrgan').value = "5";


        }
    }

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
        //alert(document.getElementById('divTab').innerHTML);
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vOrgName = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_01') == null ? "Organism Name:" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_01');
        var vSensitive = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_02') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_02');
        var vModerately = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_03') == null ? "Moderately sensitive to" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_03');
        var vResistant = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_04') == null ? "Resistant" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_04');
        var vDrugName = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_05') == null ? "DrugName" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_05');
        var vDisc = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_06') == null ? "Disc Diameter" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_06');
        var vSensitiveTo = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_07') == null ? "SensitiveTo" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_07');
        var vAdd = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_10') == null ? "Add" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_10');
        var splitID = id.split('_');
        document.getElementById(splitID[0] + '_divTab').innerHTML = '';
        var drgName = document.getElementById(splitID[0] + '_drugname').value;
        var splidrg = drgName.split('$');
        var noCtrl = document.getElementById(splitID[0] + '_txtOrgan').value;
        //alert(noCtrl);
        for (var i = 0; i < noCtrl; i++) {
            var table = '';

            table = "<TABLE style='padding-bottom:20px;' Class='colorforcontentborder w-100p'>"
                    + "<TR style='height:25px;'><TD>" + vOrgName + "  </TD><TD Colspan='5'>"
                    + "<input type='text' id='" + splitID[0] + "_txtOrgName_" + i + "' /></TD></TR>"    
                    + "<TR style='height:15px; font-size:11px;' Class='Duecolor'>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vSensitive + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vModerately + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vResistant + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;'>" + vDrugName + "</TD>"
                    + "<TD style='padding-left:5px;padding-top:5px;padding-bottom:5px;padding-right:5px;width:10%;'>" + vDisc + "</TD>"
                    + "<TD>&nbsp;</TD></TR>"
                    + "<TR style='height:30px;' class='bg-row'><TD><input type='radio' id='" + splitID[0] + "_rdoSensitive_" + i + "' value='STO' name='" + splitID[0] + "rdo" + i + "' checked='checked'  />'" + vSensitiveTo + "'</TD>"
                    + "<TD><input type='radio'  id='" + splitID[0] + "_rdoModerate_" + i + "' value='mTO ' name='" + splitID[0] + "rdo" + i + "' />'" + vModerately + "'</TD>"
                    + "<TD><input type='radio'  id='" + splitID[0] + "_rdoResistant_" + i + "' value='rTO' name='" + splitID[0] + "rdo" + i + "' /> '" + vResistant + "'</TD>"
                    + "<TD><select id='" + splitID[0] + "_ddl1_" + i + "'>";
            for (var j = 0; j < splidrg.length; j++) {
                table += "<option selected='selected' value='" + splidrg[j] + "'>" + splidrg[j] + "</option>";
                //alert(AddDrug[i]);
            }
            table += "</select></TD><TD><input type='text' style='width:100px;' id='" + splitID[0] + "_uom_" + i + "' />"
                        + "</TD><TD><input type='button' id='" + splitID[0] + "_btnADD_" + i + "' value='" + vAdd + "' OnClick='javascript:return AddSensitiveToTable(this.id);'/>"
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
        var vDrugAlready = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_08') == null ? "Drug Already Added. Please Check." : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_08');
        var vOrganism = SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_09') == null ? "Enter Organism name and then add Drug" : SListForAppMsg.Get('Investigation_CultureandSensitivityReport_ascx_09');
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
                    //alert("Drug Already Added. Please Check.");
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
    
</script>

<div>
    <table class="w-100p">
        <tr>
            <td class="a-center font12 style1" style="font-weight: normal; color: #000;">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" runat="server" Font-Bold="true">
                </asp:Label>
                <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="Red" OnClick="lnkEdit_Click"
                    Text="Edit" Visible="false"></asp:LinkButton>
                <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                    visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08%></u></a>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlenabled" CssClass="w-100p" runat="server">
                    <table class="w-100p">
                        <tr>
                            <td class="font11 h-20 w-8p" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblSampleName" Text="Sample Name" meta:resourcekey="lblSampleNameResource1">
                                </asp:Label>
                            </td>
                            <td class="font11 h-20 w-8p" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtSample" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-8p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblSource" runat="server" Text="Source" meta:resourcekey="lblSourceResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20 w-8p" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtSource" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-8p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblReportStatus" runat="server" Text="ReportStatus" meta:resourcekey="lblReportStatusResource1">
                                </asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlData" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblClinicalDiagnosis" runat="server" Text="Clinical Diagnosis" meta:resourcekey="lblClinicalDiagnosisResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" ID="txtClinicalDiagnosis"
                                    runat="server" MaxLength="50"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: normal; color: #000;" class="style2 font11">
                                <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                            </td>
                            <td class="style3 font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalNotes" CssClass="small"
                                    runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p v-bottom" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy &lt;br&gt; &nbsp; Gram's stain"
                                    meta:resourcekey="lblMicroscopyResource2">
                                </asp:Label>
                            </td>
                            <td rowspan="2">
                                <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtMicroscopy" CssClass="small"
                                    runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p v-top" style="font-weight: normal; color: #000;">
                                &nbsp;&nbsp;
                                <asp:Label ID="lblMicroscopy0" Visible="false" runat="server" Text="Gram's stain"
                                    meta:resourcekey="lblMicroscopy0Resource1">
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: normal; color: #000;" class="style3 font11">
                                <asp:Label ID="lblCultureReport" runat="server" Text="CultureReport" meta:resourcekey="lblCultureReportResource1">
                                </asp:Label>
                            </td>
                            <td class="style3">
                                <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtCultureReport" CssClass="small"
                                    runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblGrowth" runat="server" Text="Growth" meta:resourcekey="lblGrowthResource1">
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" ID="txtGrowth" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p a-left" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblGrowthStatus" runat="server" Text="Growth Status" meta:resourcekey="lblGrowthStatusResource1">
                                </asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ForeColor="Black" ID="ddlGrowthStatus" CssClass="ddlsmall" runat="server">
                                   <%-- <asp:ListItem Text="Select" Value="Select" />
                                    <asp:ListItem Text="Scanty" Value="Scanty" />
                                    <asp:ListItem Text="Moderate" Value="Moderate" />
                                    <asp:ListItem Text="Heavy" Value="Heavy" />--%>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p " style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblColonyCount" runat="server" Text="Colony Count" meta:resourcekey="lblColonyCountResource1">
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtColonyCount" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p a-left" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblNoofOrgans" runat="server" Text="No of Organism Found" meta:resourcekey="lblNoofOrgansResource1">
                                </asp:Label>
                            </td>
                            <td class="a-left font11 w-10p" style="font-weight: normal; color: #000;">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="small" ID="txtOrgan"
                                                onchange="validate()" MaxLength="3"></asp:TextBox>
                                            <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="LowercaseLetters,Numbers"
                                                TargetControlID="txtOrgan" runat="server">
                                            </ajc:FilteredTextBoxExtender>
                                            <asp:Button runat="server" ID="btnOrgADD" Text="Add" OnClientClick="javascript:return AddControl(this.id);"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                meta:resourcekey="btnOrgADDResource1" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-100p" style="font-weight: normal; color: #000;" colspan="4">
                                <div id="divTab" runat="server">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20 w-3p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                    CssClass="small"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnRemarksID" runat="server" />
                            </td>
                            <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                            </td>
                            <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" runat="server" ID="txtMedRemarks"
                                    TabIndex="-1" TextMode="MultiLine" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <%=Resources.Investigation_AppMsg.Investigation_CultureandSensitivityReport_ascx_11%>
                        </td>
                        <td class="a-left w-50p">
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                            meta:resourcekey="ddlstatusResource1">
                                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
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
                                                            <%--<asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>--%>
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
                <input type="hidden" id="hresistantto" value="" class="w-100p" runat="server" />
                <input type="hidden" id="drugname" value="" class="w-100p" runat="server" />
                <asp:Label ID="lblraw" runat="server" Font-Bold="false">
                </asp:Label>
            </td>
        </tr>
        <asp:HiddenField runat="server" ID="hidVal" />
    </table>
    <input id="hdnOpinionUser" runat="server" type="hidden" value="" />
    <asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
</div>
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
