<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrthoEMR.ascx.cs" Inherits="CommonControls_OrthoEMR" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <asp:HiddenField ID="hdnBPItems" runat="server" />
    <asp:HiddenField ID="hdnOWItems" runat="server" />
    <asp:HiddenField ID="hdnRefItems" runat="server" />
    <asp:HiddenField ID="hdnMusExItems" runat="server" />
    <asp:HiddenField ID="HiddenField5" runat="server" />
    <asp:HiddenField ID="HiddenField6" runat="server" />
    <tr>
        <td>
            <asp:CheckBox ID="chkBP" Text="Body Part" runat="server" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkBPResource1" />
        </td>
    </tr>
    <tr id="trchkBP" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td>
                        <table cellpadding="3" cellspacing="3" border="0" width="75%">
                            <tr>
                                <td style="width: 150px;">
                                    <asp:Label ID="lblBodyPart" runat="server" Text="Body Part" meta:resourcekey="lblBodyPartResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlBodyPart" runat="server" meta:resourcekey="ddlBodyPartResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblPosition" runat="server" Text="Position" meta:resourcekey="lblPositionResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlBPPosition" runat="server" meta:resourcekey="ddlBPPositionResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table cellpadding="3" cellspacing="3" border="0" width="75%">
                            <tr>
                                <td style="width: 150px;">
                                    <asp:Label ID="Rs_Findings" runat="server" Text="Findings:" meta:resourcekey="Rs_FindingsResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlScience" runat="server" meta:resourcekey="ddlScienceResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDecs" runat="server" meta:resourcekey="txtDecsResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkIsAbsent" runat="server" Text="Is Absent" meta:resourcekey="chkIsAbsentResource1" />
                                </td>
                                <td>
                                    <input type="button" name="btnAdd" id="btnAdd" value="Add" class="btn" onclick="javascript:return AddBodyParts();" />
                                    <%--                        <asp:Button ID="btnAdd" OnClientClick="javascript:return AddBodyParts();" runat="server"
                            Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table id="tblBPItems" class="dataheaderInvCtrl" runat="server" cellpadding="8" cellspacing="0"
                            border="1">
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBox ID="chkOpenwound" runat="server" Text="Open Wound" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkOpenwoundResource1" />
        </td>
    </tr>
    <tr id="trchkOpenwound" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSize" runat="server" Text="Size" meta:resourcekey="lblSizeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSize1" runat="server" Width="25px" meta:resourcekey="txtSize1Resource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="X" meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSize2" runat="server" Width="25px" meta:resourcekey="txtSize2Resource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlUnits" runat="server" meta:resourcekey="ddlUnitsResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLocation" runat="server" meta:resourcekey="txtLocationResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDescription" runat="server" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <input type="button" name="btnAddOW" id="btnAddOW" value="Add" class="btn" onclick="javascript:return AddOpenWounds();" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <table id="tblOWItems" class="dataheaderInvCtrl" runat="server" cellpadding="8" cellspacing="0"
                                        border="1">
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
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
            <asp:CheckBox ID="chkVDPH" runat="server" Text="Vascular deficit present" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkVDPHResource1" />
        </td>
    </tr>
    <tr id="trchkVDPH" runat="server" style="display: none;">
        <td>
            <table cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td colspan="2">
                        <asp:CheckBoxList ID="chkVDPHV" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                            meta:resourcekey="chkVDPHVResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBox ID="chkNDPH" runat="server" Text="Neurological deficit present" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkNDPHResource1" />
        </td>
    </tr>
    <tr id="trchkNDPH" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td style="width: 150px;" valign="top">
                        <asp:Label ID="lblRootLvl" runat="server" Text="Root level" meta:resourcekey="lblRootLvlResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkRootlvl" runat="server" RepeatDirection="Horizontal" RepeatColumns="15"
                            meta:resourcekey="chkRootlvlResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lbl" runat="server" Text="Plexus level" meta:resourcekey="lblResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkPlexlvl" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                            meta:resourcekey="chkPlexlvlResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblNervelvl" runat="server" Text="Nerve level" RepeatDirection="Horizontal"
                            RepeatColumns="5" meta:resourcekey="lblNervelvlResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkNervelvl" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                            meta:resourcekey="chkNervelvlResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBox ID="chkReflexes" runat="server" Text="Reflexes" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkReflexesResource1" />
        </td>
    </tr>
    <tr id="trchkReflexes" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td colspan="2">
                        <table cellpadding="0" cellspacing="0" border="0" width="75%">
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlRefName" runat="server" meta:resourcekey="ddlRefNameResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRefPosition" runat="server" meta:resourcekey="ddlRefPositionResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRefStatus" runat="server" meta:resourcekey="ddlRefStatusResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <input type="button" name="btnAddRef" id="btnAddRef" value="Add" class="btn" onclick="javascript:return AddReflexes();" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table id="tblRefItems" runat="server" cellpadding="8" cellspacing="0" border="1">
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBox ID="chkME" runat="server" Text="Muscular Examination" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkMEResource1" />
        </td>
    </tr>
    <tr id="trchkME" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSM" runat="server" Text="Select Muscle" meta:resourcekey="lblSMResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMuscleType" runat="server" meta:resourcekey="ddlMuscleTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblMP" runat="server" Text="Muscle Power" meta:resourcekey="lblMPResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMusclePower" runat="server" meta:resourcekey="ddlMusclePowerResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblMT" runat="server" Text="Muscle Tone" meta:resourcekey="lblMTResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMuscleTone" runat="server" meta:resourcekey="ddlMuscleToneResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <input type="button" name="btnAddMusExam" id="btnAddMusExam" value="Add" class="btn"
                                        onclick="javascript:return AddMusExam();" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    <table id="tblMusExItems" runat="server" cellpadding="8" cellspacing="0" border="1">
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBox ID="chkMW" Text="Muscle Wasting" runat="server" onclick="javascript:ShowHideOrthoContents(this.id);"
                meta:resourcekey="chkMWResource1" />
        </td>
    </tr>
    <tr id="trchkMW" runat="server" style="display: none;">
        <td>
            <table cellpadding="3" cellspacing="3" border="0" class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="width: 150px">
                                    <asp:Label ID="lblMW" runat="server" Text="Muscle Wasting" meta:resourcekey="lblMWResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMuscleWasting" runat="server" onchange="javascript:ShowMW(this.id);"
                                        meta:resourcekey="ddlMuscleWastingResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trchkMWValue" runat="server" style="display: none;">
                    <td>
                        <asp:CheckBoxList ID="chkMWValue" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                            meta:resourcekey="chkMWValueResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script language="javascript" type="text/javascript">


    function ShowMW(id) {

        if (document.getElementById(id).value == "Present") {
          

            document.getElementById('<%=trchkMWValue.ClientID %>').style.display = 'block';
        }
        else {

            document.getElementById('<%=trchkMWValue.ClientID %>').style.display = 'none';

        }
    
    }

    //---------ShowHideOrthoContents


    function ShowHideOrthoContents(ChkID) {

        //OrthoEMR1_chkVDPH(ChkID)
        //OrthoEMR1_trchkVDPH(tr)
        var chkvalue = ChkID.split('_');
        
      
        var trid = chkvalue[0] + "_tr" + chkvalue[1];

        if (document.getElementById(ChkID).checked == true) {
            document.getElementById(trid).style.display = 'block';
        }
        else {
            document.getElementById(trid).style.display = 'none';
        }
    }

    //----------AddBodyParts section
    function AddBodyParts() {

        var rwNumber = parseInt(110);
        var AddStatus = 0;
        var BPText = document.getElementById('<%=ddlBodyPart.ClientID %>').options[document.getElementById('<%=ddlBodyPart.ClientID %>').selectedIndex].text;
        var BPValue = document.getElementById('<%=ddlBodyPart.ClientID %>').options[document.getElementById('<%=ddlBodyPart.ClientID %>').selectedIndex].value;
        var BPPText = document.getElementById('<%=ddlBPPosition.ClientID %>').options[document.getElementById('<%=ddlBPPosition.ClientID %>').selectedIndex].text;
        var BPPValue = document.getElementById('<%=ddlBPPosition.ClientID %>').options[document.getElementById('<%=ddlBPPosition.ClientID %>').selectedIndex].value;
        var BPCText = document.getElementById('<%=ddlScience.ClientID %>').options[document.getElementById('<%=ddlScience.ClientID %>').selectedIndex].text;
        var BPCValue = document.getElementById('<%=ddlScience.ClientID %>').options[document.getElementById('<%=ddlScience.ClientID %>').selectedIndex].value;
        var txtDecs = document.getElementById('<%=txtDecs.ClientID %>').value.trim();
        var IsPresent;

        document.getElementById('<%=tblBPItems.ClientID %>').style.display = 'block';

        if (document.getElementById('<%=chkIsAbsent.ClientID %>').checked) {
            IsPresent = "Absent";
        }
        else {
            IsPresent = "Present";
        }


        if (BPText == "--Select--") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }

            else { alert("Select the body part"); }
            document.getElementById('<%=ddlBodyPart.ClientID %>').focus();
            return false;
        }


        if (BPCText == "--Select--") {
            //            alert("Slect the Science");
            //            document.getElementById('<%=ddlScience.ClientID %>').focus();
            //            return false;
            BPCText = "";
        }

        if (BPPText == "--Select--") {
            BPPText = "";
        }
        var HidValue = document.getElementById('<%=hdnBPItems.ClientID %>').value;
        var list = HidValue.split('^');
        if (document.getElementById('<%=hdnBPItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var BPList = list[count].split('~');
                if (BPList[1] != '') {
                    if (BPList[0] != '') {
                        rwNumber = parseInt(parseInt(BPList[0]) + parseInt(1));
                    }
                    if (BPList[1] == BPValue && BPList[3] == BPPText && BPList[4] == BPCValue) {
                        AddStatus = 1;
                    }
                }
            }
        }
        else {
            var row = document.getElementById('<%=tblBPItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = BPText;
            cell3.innerHTML = BPPText;
            cell4.innerHTML = BPCText;
            cell5.innerHTML = txtDecs;
            cell6.innerHTML = IsPresent;
            document.getElementById('<%=hdnBPItems.ClientID %>').value += parseInt(rwNumber) + "~" + BPValue + "~" + BPText + "~" + BPPText + "~" + BPCValue + "~" + BPCText + "~" + txtDecs + "~" + IsPresent + "^";
            AddStatus = 2;

        }
        if (AddStatus == 0) {
            var row = document.getElementById('<%=tblBPItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = BPText;
            cell3.innerHTML = BPPText;
            cell4.innerHTML = BPCText;
            cell5.innerHTML = txtDecs;
            cell6.innerHTML = IsPresent;
            document.getElementById('<%=hdnBPItems.ClientID %>').value += parseInt(rwNumber) + "~" + BPValue + "~" + BPText + "~" + BPPText + "~" + BPCValue + "~" + BPCText + "~" + txtDecs + "~" + IsPresent + "^";

        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert('Already added');
        }
        }
        document.getElementById('<%=ddlScience.ClientID %>').value = 0;
        document.getElementById('<%=txtDecs.ClientID %>').value = '';
        return false;
    }

    function ImgOnclickBP(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnBPItems.ClientID %>').value;
        var list = HidValue.split('^');
        var newBPList = '';
        if (document.getElementById('<%=hdnBPItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var BPList = list[count].split('~');
                if (BPList[0] != '') {
                    if (BPList[0] != ImgID) {
                        newBPList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnBPItems.ClientID %>').value = newBPList;
        }
        if (document.getElementById('<%=hdnBPItems.ClientID %>').value == '') {
            document.getElementById('<%=tblBPItems.ClientID %>').style.display = 'none';
        }
    }


    function LoadBPItems() {
        var HidValue = document.getElementById('<%=hdnBPItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblBPItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblBPItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblBPItems.ClientID %>').deleteRow(j);

            }
        }
        if (document.getElementById('<%=hdnBPItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var BPList = list[count].split('~');
                var row = document.getElementById('<%=tblBPItems.ClientID %>').insertRow(0);
                row.id = BPList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickBP(" + parseInt(BPList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = BPList[2];
                cell3.innerHTML = BPList[3];
                cell4.innerHTML = BPList[5];
                cell5.innerHTML = BPList[6];
                cell6.innerHTML = BPList[7];
            }
        }
    }



    //----------AddOpenWounds section
    function AddOpenWounds() {

        var rwNumber = parseInt(510);
        var AddStatus = 0;
        var Units = document.getElementById('<%=ddlUnits.ClientID %>').options[document.getElementById('<%=ddlUnits.ClientID %>').selectedIndex].text;

        var Size = "";
        if (document.getElementById('<%=txtSize1.ClientID %>').value.trim() != "" && document.getElementById('<%=txtSize2.ClientID %>').value.trim() != "") {
            Size = document.getElementById('<%=txtSize1.ClientID %>').value.trim() + "x" + document.getElementById('<%=txtSize2.ClientID %>').value.trim();
        }

        if (Size == "") {
            Units = "";
        }




        var Location = document.getElementById('<%=txtLocation.ClientID %>').value.trim();
        var Description = document.getElementById('<%=txtDescription.ClientID %>').value.trim();

        document.getElementById('<%=tblOWItems.ClientID %>').style.display = 'block';



        if (Location == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter the location");
            }
            document.getElementById('<%=txtLocation.ClientID %>').focus();
            return false;
        }

        var HidValue = document.getElementById('<%=hdnOWItems.ClientID %>').value;
        var list = HidValue.split('^');
        if (document.getElementById('<%=hdnOWItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var OWList = list[count].split('~');
                if (OWList[3] != '') {
                    if (OWList[0] != '') {
                        rwNumber = parseInt(parseInt(OWList[0]) + parseInt(1));
                    }
                    if (OWList[3] == Location) {
                        AddStatus = 1;
                    }
                }
            }
        }
        else {
            var row = document.getElementById('<%=tblOWItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOW(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = Size + " " + Units;
            cell3.innerHTML = Location;
            cell4.innerHTML = Description;
            document.getElementById('<%=hdnOWItems.ClientID %>').value += parseInt(rwNumber) + "~" + Size + "~" + Units + "~" + Location + "~" + Description + "^";
            AddStatus = 2;

        }
        if (AddStatus == 0) {
            var row = document.getElementById('<%=tblOWItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOW(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = Size + " " + Units;
            cell3.innerHTML = Location;
            cell4.innerHTML = Description;
            document.getElementById('<%=hdnOWItems.ClientID %>').value += parseInt(rwNumber) + "~" + Size + "~" + Units + "~" + Location + "~" + Description + "^";

        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert('Already added');
        }
        }
        document.getElementById('<%=ddlUnits.ClientID %>').value = "mm";
        document.getElementById('<%=txtSize1.ClientID %>').value = "";
        document.getElementById('<%=txtSize2.ClientID %>').value = "";
        document.getElementById('<%=txtLocation.ClientID %>').value = "";
        document.getElementById('<%=txtDescription.ClientID %>').value = "";
        return false;
    }

    function ImgOnclickOW(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnOWItems.ClientID %>').value;
        var list = HidValue.split('^');
        var newOWList = '';
        if (document.getElementById('<%=hdnOWItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var OWList = list[count].split('~');
                if (OWList[0] != '') {
                    if (OWList[0] != ImgID) {
                        newOWList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnOWItems.ClientID %>').value = newOWList;
        }
        if (document.getElementById('<%=hdnOWItems.ClientID %>').value == '') {
            document.getElementById('<%=tblOWItems.ClientID %>').style.display = 'none';
        }
    }


    function LoadOWItems() {
        var HidValue = document.getElementById('<%=hdnOWItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblOWItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblOWItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblOWItems.ClientID %>').deleteRow(j);

            }
        }
        if (document.getElementById('<%=hdnOWItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var OWList = list[count].split('~');
                var row = document.getElementById('<%=tblOWItems.ClientID %>').insertRow(0);
                row.id = OWList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOW(" + parseInt(OWList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = OWList[1] + " " + OWList[2];
                cell3.innerHTML = OWList[3];
                cell4.innerHTML = OWList[4];
            }
        }
    }




    //----------AddReflexes section
    function AddReflexes() {

        var rwNumber = parseInt(810);
        var AddStatus = 0;
        var RefTText = document.getElementById('<%=ddlRefName.ClientID %>').options[document.getElementById('<%=ddlRefName.ClientID %>').selectedIndex].text;
        var RefTvalue = document.getElementById('<%=ddlRefName.ClientID %>').options[document.getElementById('<%=ddlRefName.ClientID %>').selectedIndex].value;
        var RefPText = document.getElementById('<%=ddlRefPosition.ClientID %>').options[document.getElementById('<%=ddlRefPosition.ClientID %>').selectedIndex].text;
        var RefPvalue = document.getElementById('<%=ddlRefPosition.ClientID %>').options[document.getElementById('<%=ddlRefPosition.ClientID %>').selectedIndex].value;
        var RefSText = document.getElementById('<%=ddlRefStatus.ClientID %>').options[document.getElementById('<%=ddlRefStatus.ClientID %>').selectedIndex].text;
        var RefSvalue = document.getElementById('<%=ddlRefStatus.ClientID %>').options[document.getElementById('<%=ddlRefStatus.ClientID %>').selectedIndex].value;


        document.getElementById('<%=tblRefItems.ClientID %>').style.display = 'block';

        if (RefPText == "--Select--") {
            RefPText = "";
        }



        var HidValue = document.getElementById('<%=hdnRefItems.ClientID %>').value;
        var list = HidValue.split('^');
        if (document.getElementById('<%=hdnRefItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var RefList = list[count].split('~');
                if (RefList[1] != '') {
                    if (RefList[0] != '') {
                        rwNumber = parseInt(parseInt(RefList[0]) + parseInt(1));
                    }
                    if (RefList[1] == RefTvalue && RefList[3] == RefPText && RefList[4] == RefSvalue) {
                        AddStatus = 1;
                    }
                }
            }
        }
        else {
            var row = document.getElementById('<%=tblRefItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickRef(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = RefTText;
            cell3.innerHTML = RefPText;
            cell4.innerHTML = RefSText;
            document.getElementById('<%=hdnRefItems.ClientID %>').value += parseInt(rwNumber) + "~" + RefTvalue + "~" + RefTText + "~" + RefPText + "~" + RefSvalue + "~" + RefSText + "^";
            AddStatus = 2;

        }
        if (AddStatus == 0) {
            var row = document.getElementById('<%=tblRefItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickRef(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = RefTText;
            cell3.innerHTML = RefPText;
            cell4.innerHTML = RefSText;
            document.getElementById('<%=hdnRefItems.ClientID %>').value += parseInt(rwNumber) + "~" + RefTvalue + "~" + RefTText + "~" + RefPText + "~" + RefSvalue + "~" + RefSText + "^";

        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert('Already added');
        }
        }
//        document.getElementById('<%=ddlRefPosition.ClientID %>').value = 0;

        return false;
    }

    function ImgOnclickRef(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnRefItems.ClientID %>').value;
        var list = HidValue.split('^');
        var newRefList = '';
        if (document.getElementById('<%=hdnRefItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var RefList = list[count].split('~');
                if (RefList[0] != '') {
                    if (RefList[0] != ImgID) {
                        newRefList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnRefItems.ClientID %>').value = newRefList;
        }
        if (document.getElementById('<%=hdnRefItems.ClientID %>').value == '') {
            document.getElementById('<%=tblRefItems.ClientID %>').style.display = 'none';
        }
    }

    function LoadRefItems() {
        var HidValue = document.getElementById('<%=hdnRefItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblRefItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblRefItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblRefItems.ClientID %>').deleteRow(j);

            }
        }
        if (document.getElementById('<%=hdnRefItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var RefList = list[count].split('~');
                var row = document.getElementById('<%=tblRefItems.ClientID %>').insertRow(0);
                row.id = RefList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickRef(" + parseInt(RefList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = RefList[2];
                cell3.innerHTML = RefList[3];
                cell4.innerHTML = RefList[5];
            }
        }
    }


    //---------Add Muscular Exam section

    function AddMusExam() {

        var rwNumber = parseInt(1000);
        var AddStatus = 0;
        var MusTText = document.getElementById('<%=ddlMuscleType.ClientID %>').options[document.getElementById('<%=ddlMuscleType.ClientID %>').selectedIndex].text;
        var MusTvalue = document.getElementById('<%=ddlMuscleType.ClientID %>').options[document.getElementById('<%=ddlMuscleType.ClientID %>').selectedIndex].value;
        var MusPText = document.getElementById('<%=ddlMusclePower.ClientID %>').options[document.getElementById('<%=ddlMusclePower.ClientID %>').selectedIndex].text;
        var MusPvalue = document.getElementById('<%=ddlMusclePower.ClientID %>').options[document.getElementById('<%=ddlMusclePower.ClientID %>').selectedIndex].value;
        var MusTnText = document.getElementById('<%=ddlMuscleTone.ClientID %>').options[document.getElementById('<%=ddlMuscleTone.ClientID %>').selectedIndex].text;
        var MusTnvalue = document.getElementById('<%=ddlMuscleTone.ClientID %>').options[document.getElementById('<%=ddlMuscleTone.ClientID %>').selectedIndex].value;


        document.getElementById('<%=tblMusExItems.ClientID %>').style.display = 'block';

        if (MusPText == "--Select--") {
            MusPText = "";
        }


        var HidValue = document.getElementById('<%=hdnMusExItems.ClientID %>').value;
        var list = HidValue.split('^');

        if (document.getElementById('<%=hdnMusExItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var MusExList = list[count].split('~');
                if (MusExList[1] != '') {
                    if (MusExList[0] != '') {
                        rwNumber = parseInt(parseInt(MusExList[0]) + parseInt(1));
                    }
                    if (MusExList[1] == MusTvalue) {
                        AddStatus = 1;
                    }
                }
            }
        }
        else {
            var row = document.getElementById('<%=tblMusExItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickMusEx(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = MusTText;
            cell3.innerHTML = MusPText;
            cell4.innerHTML = MusTnText;
            document.getElementById('<%=hdnMusExItems.ClientID %>').value += parseInt(rwNumber) + "~" + MusTvalue + "~" + MusTText + "~" + MusPvalue + "~" + MusPText + "~" + MusTnvalue + "~" + MusTnText + "^";
            AddStatus = 2;

        }
        if (AddStatus == 0) {
            var row = document.getElementById('<%=tblMusExItems.ClientID %>').insertRow(0);
            row.id = parseInt(rwNumber);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickMusEx(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = MusTText;
            cell3.innerHTML = MusPText;
            cell4.innerHTML = MusTnText;
            document.getElementById('<%=hdnMusExItems.ClientID %>').value += parseInt(rwNumber) + "~" + MusTvalue + "~" + MusTText + "~" + MusPvalue + "~" + MusPText + "~" + MusTnvalue + "~" + MusTnText + "^";

        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\OrthoEMR.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert('Already added');
        }
        }


        return false;
    }

    function ImgOnclickMusEx(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%=hdnMusExItems.ClientID %>').value;
        var list = HidValue.split('^');
        var newMusExList = '';
        if (document.getElementById('<%=hdnMusExItems.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var MusExList = list[count].split('~');
                if (MusExList[0] != '') {
                    if (MusExList[0] != ImgID) {
                        newMusExList += list[count] + '^';
                    }
                }
            }
            document.getElementById('<%=hdnMusExItems.ClientID %>').value = newMusExList;
        }
        if (document.getElementById('<%=hdnMusExItems.ClientID %>').value == '') {
            document.getElementById('<%=tblMusExItems.ClientID %>').style.display = 'none';
        }
    }

    function LoadMusExItems() {
        var HidValue = document.getElementById('<%=hdnMusExItems.ClientID %>').value;

        var list = HidValue.split('^');

        while (count = document.getElementById('<%=tblMusExItems.ClientID %>').rows.length) {

            for (var j = 0; j < document.getElementById('<%=tblMusExItems.ClientID %>').rows.length; j++) {
                document.getElementById('<%=tblMusExItems.ClientID %>').deleteRow(j);

            }
        }
        if (document.getElementById('<%=hdnMusExItems.ClientID %>').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var MusExList = list[count].split('~');
                var row = document.getElementById('<%=tblMusExItems.ClientID %>').insertRow(0);
                row.id = MusExList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickMusEx(" + parseInt(MusExList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = MusExList[2];
                cell3.innerHTML = MusExList[3];
                cell4.innerHTML = MusExList[5];
            }
        }
    }

    
    
</script>

<script language="javascript" type="text/javascript">
    LoadBPItems();
    LoadOWItems();
    LoadRefItems();
    LoadMusExItems();
//    ShowMW(document.getElementById('<%=trchkMWValue.ClientID %>'));
</script>

