<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MethodKitMapping.ascx.cs"
    Inherits="CommonControls_MethodKitMapping" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    function expandBox(id) {
        document.getElementById(id).rows = "5";
    }
    function collapseBox(id) {
        document.getElementById(id).rows = "1";
    }
    function onClickAdd() {
    hidebutton();
        var type;
        var rate = '';
        var method = '--';
        var principle = '--';
        var kit = '--';
        var instrument = '--';
        var interpretation = '--';
        var qcData = '--';
        var AddStatus = 0;
        var obj;
        if (document.getElementById('ucMethodKitCapture_ddlInvestigation').value != "0") {
            obj = document.getElementById('ucMethodKitCapture_ddlInvestigation');
            type = "INV";
        }
        if (document.getElementById('ucMethodKitCapture_ddlGroup').value != "0") {
            obj = document.getElementById('ucMethodKitCapture_ddlGroup');
            type = "GRP";
        }
        var obj1 = document.getElementById('ucMethodKitCapture_ddlMethod');
        var obj2 = document.getElementById('ucMethodKitCapture_ddlKit');
        var obj3 = document.getElementById('ucMethodKitCapture_ddlInstrument');
        var obj4 = document.getElementById('ucMethodKitCapture_ddlPrinciple');
        if (obj1.options[obj1.selectedIndex].value != "0") {
            method = obj1.options[obj1.selectedIndex].text;
        }
        if (obj2.options[obj2.selectedIndex].value != "0") {
            kit = obj2.options[obj2.selectedIndex].text;
        }
        if (obj3.options[obj3.selectedIndex].value != "0") {
            instrument = obj3.options[obj3.selectedIndex].text;
        }
        if (obj4.options[obj4.selectedIndex].value != "0") {
            principle = obj4.options[obj4.selectedIndex].text;
        }
        if (document.getElementById('ucMethodKitCapture_txtInterpretation').value.trim() != "") {
            interpretation = document.getElementById('ucMethodKitCapture_txtInterpretation').value;
        }
        if (document.getElementById('ucMethodKitCapture_txtQCData').value.trim() != "") {
            qcData = document.getElementById('ucMethodKitCapture_txtQCData').value;
        }
        var HidValue = document.getElementById('ucMethodKitCapture_hdnMethodKit').value;
        var list = HidValue.split('^');

        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {

                    if (obj.selectedIndex >= 0) {
                        if (InvesList[1] == obj.options[obj.selectedIndex].value && InvesList[2] == obj1.options[obj1.selectedIndex].value && InvesList[3] == obj2.options[obj2.selectedIndex].value && InvesList[4] == obj3.options[obj3.selectedIndex].value && InvesList[11] == obj3.options[obj4.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {

            var row = document.getElementById('ucMethodKitCapture_tabMethodKit').insertRow(0);

            row.id = obj.options[obj.selectedIndex].value + obj1.options[obj1.selectedIndex].value + obj2.options[obj2.selectedIndex].value + obj3.options[obj3.selectedIndex].value;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);

            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + row.id + ");' src='../Images/Delete.jpg' />";
            cell1.width = "3%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell2.width = "19%";
            cell3.innerHTML = method;
            cell3.width = "13%";
            cell4.innerHTML = kit;
            cell4.width = "13%";
            cell5.innerHTML = instrument;
            cell5.width = "13%";
            cell6.innerHTML = interpretation;
            cell6.width = "13%";
            cell7.innerHTML = principle;
            cell7.width = "13%";
            cell8.innerHTML = qcData;
            cell8.width = "13%";
            document.getElementById('ucMethodKitCapture_hdnMethodKit').value += row.id + "~" + obj.options[obj.selectedIndex].value + "~" + obj1.options[obj1.selectedIndex].value + "~" + obj2.options[obj2.selectedIndex].value + "~" + obj3.options[obj3.selectedIndex].value + "~" + interpretation + "~" + obj.options[obj.selectedIndex].text + "~" + method + "~" + kit + "~" + instrument + "~" + type + "~" + obj4.options[obj4.selectedIndex].value + "~" + principle + "~" + qcData + "^";
            AddStatus = 2;
            document.getElementById('ucMethodKitCapture_ddlGroup').value = "0";
            document.getElementById('ucMethodKitCapture_ddlInvestigation').value = "0";
            document.getElementById('ucMethodKitCapture_ddlMethod').value = "0";
            document.getElementById('ucMethodKitCapture_ddlKit').value = "0";
            document.getElementById('ucMethodKitCapture_ddlInstrument').value = "0";
            document.getElementById('ucMethodKitCapture_txtInterpretation').value = "";
            document.getElementById('ucMethodKitCapture_ddlPrinciple').value = "0";
            document.getElementById('ucMethodKitCapture_txtQCData').value = "";
            return false;
        }
        if (AddStatus == 0) {
            var row = document.getElementById('ucMethodKitCapture_tabMethodKit').insertRow(0);
            row.id = obj.options[obj.selectedIndex].value + obj1.options[obj1.selectedIndex].value + obj2.options[obj2.selectedIndex].value + obj3.options[obj3.selectedIndex].value;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + row.id + ");' src='../Images/Delete.jpg' />";
            cell1.width = "3%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell2.width = "19%";
            cell3.innerHTML = method;
            cell3.width = "13%";
            cell4.innerHTML = kit;
            cell4.width = "13%";
            cell5.innerHTML = instrument;
            cell5.width = "13%";
            cell6.innerHTML = interpretation;
            cell6.width = "13%";
            cell7.innerHTML = principle;
            cell7.width = "13%";
            cell8.innerHTML = qcData;
            cell8.width = "13%";
            document.getElementById('ucMethodKitCapture_hdnMethodKit').value += row.id + "~" + obj.options[obj.selectedIndex].value + "~" + obj1.options[obj1.selectedIndex].value + "~" + obj2.options[obj2.selectedIndex].value + "~" + obj3.options[obj3.selectedIndex].value + "~" + interpretation + "~" + obj.options[obj.selectedIndex].text + "~" + method + "~" + kit + "~" + instrument + "~" + type + "~" + obj4.options[obj4.selectedIndex].value + "~" + principle + "~" + qcData + "^";
        }
        else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\MethodKitMapping.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }

            else { alert("Already Added Please Check!"); }
        }
        document.getElementById('ucMethodKitCapture_ddlGroup').value = "0";
        document.getElementById('ucMethodKitCapture_ddlInvestigation').value = "0";
        document.getElementById('ucMethodKitCapture_ddlMethod').value = "0";
        document.getElementById('ucMethodKitCapture_ddlKit').value = "0";
        document.getElementById('ucMethodKitCapture_ddlInstrument').value = "0";
        document.getElementById('ucMethodKitCapture_txtInterpretation').value = "";
        document.getElementById('ucMethodKitCapture_ddlPrinciple').value = "0";
        document.getElementById('ucMethodKitCapture_txtQCData').value = "";

        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "block";
        }
        else {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "none";
        }
        document.getElementById('ucMethodKitCapture_btnShow').value = "Y"; 
        return false;
    }

    function ImgOnclick(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('ucMethodKitCapture_hdnMethodKit').value;
        var list = HidValue.split('^');
        var minusamt;
        var newInvList = '';
        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != ImgID) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById('ucMethodKitCapture_hdnMethodKit').value = newInvList;
        }
        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "block";
        }
        else {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "none";
        }
    }

    function resetAlternative(id) {
        if (id == document.getElementById('ucMethodKitCapture_ddlGroup').id) {
            document.getElementById('ucMethodKitCapture_ddlInvestigation').value = "0";
        }
        if (id == document.getElementById('ucMethodKitCapture_ddlInvestigation').id) {
            document.getElementById('ucMethodKitCapture_ddlGroup').value = "0";
        }
    }
    function LoadExistingMethodKit() {

        var HidValue = document.getElementById('ucMethodKitCapture_hdnMethodKit').value;
        var list = HidValue.split('^');

        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    var row = document.getElementById('ucMethodKitCapture_tabMethodKit').insertRow(0);

                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "3%";
                    cell2.innerHTML = InvesList[6];
                    cell2.width = "19%";
                    cell3.innerHTML = InvesList[7];
                    cell3.width = "13%";
                    cell4.innerHTML = InvesList[8];
                    cell4.width = "13%";
                    cell5.innerHTML = InvesList[9];
                    cell5.width = "13%";
                    cell6.innerHTML = InvesList[5];
                    cell6.width = "13%";
                    cell7.innerHTML = InvesList[12];
                    cell7.width = "13%";
                    cell8.innerHTML = InvesList[13];
                    cell8.width = "13%";
                }
            }
        }
        if (document.getElementById('ucMethodKitCapture_hdnMethodKit').value != "") {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "block";
        }
        else {
            document.getElementById('ucMethodKitCapture_tabMethodKitHeader').style.display = "none";
        }
        return false;
    }
    function setQCData(value) {
        if (document.getElementById('ucMethodKitCapture_hdnQCData').value != "") {
            var x = document.getElementById('ucMethodKitCapture_hdnQCData').value.split("^");
            for (var count = 0; count < x.length - 1; count++) {
                var y = x[count].split("~");
                if (y[0] == value) {
                    document.getElementById('ucMethodKitCapture_txtQCData').value = y[1];
                }
            }
        }
    }
</script>

<table id="tabMappingContent" cellpadding="4" class="gridView w-100p">
    <tr class="gridHeader">
        <td class="h-23 a-left">
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <div id="ACX2plus211345" style="display: block;">
                <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                    onclick="showResponses('ACX2plus211345','ACX2minus211345','ACX2responses2111345',1);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus211345','ACX2minus211345','ACX2responses2111345',1);">
                    <%=Resources.CommonControls_ClientDisplay.CommonControls_MethodKitMapping_ascx_01%></span>
            </div>
            <div id="ACX2minus211345" style="display: none;">
                <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                    onclick="showResponses('ACX2plus211345','ACX2minus211','ACX2responses2111345',0);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus211345','ACX2minus211345','ACX2responses2111345',0);">
                    &nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_MethodKitMapping_ascx_02%></span>
            </div>
        </td>
    </tr>
    <tr class="tablerow" id="ACX2responses2111345" style="display: none;">
        <td>
            <div class="dataheader2">
                <table>
                    <tr class="Duecolor h-15 font11 bold">
                        <td colspan="5">
                            <asp:Label ID="Rs_SelectandAddMethodPrincipleKitandInstrumentusedforInvestigation"
                                runat="server" Text="Select and Add Method, Principle, Kit and Instrument used for Investigation"
                                meta:resourcekey="Rs_SelectandAddMethodPrincipleKitandInstrumentusedforInvestigationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trGroup" runat="server" class="h-15 font10 bold" style="display: none; color: #000000;">
                        <td colspan="2" class="a-left">
                            <asp:Label ID="Rs_Group" runat="server" Text="Group" meta:resourcekey="Rs_GroupResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="a-left">
                            <asp:DropDownList ID="ddlGroup" onchange="javascript:resetAlternative(this.id);"
                                Width="300px" runat="server" meta:resourcekey="ddlGroupResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trInvestigation" runat="server" class="h-15 font10 bold" style="display: none;
                        color: #000000;">
                        <td colspan="2" class="a-left">
                            <asp:Label ID="Rs_Investigation" runat="server" Text="Investigation" meta:resourcekey="Rs_InvestigationResource1"></asp:Label>
                        </td>
                        <td colspan="3" align="left">
                            <asp:DropDownList ID="ddlInvestigation" onchange="javascript:resetAlternative(this.id);"
                                Width="300px" runat="server" meta:resourcekey="ddlInvestigationResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="h-15 font10 bold" style="color: #000000;">
                        <td class="a-left" colspan="2">
                            <asp:Label ID="Rs_MethodUsed" runat="server" Text="Method Used" meta:resourcekey="Rs_MethodUsedResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="a-left">
                            <asp:DropDownList ID="ddlMethod" Width="300px" runat="server" meta:resourcekey="ddlMethodResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="h-15 font10 bold" style="color: #000000;">
                        <td class="a-left" colspan="2">
                            <asp:Label ID="Rs_PrincipleUsed" runat="server" Text="Principle Used" meta:resourcekey="Rs_PrincipleUsedResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="a-left">
                            <asp:DropDownList ID="ddlPrinciple" Width="300px" runat="server" meta:resourcekey="ddlPrincipleResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="h-15 font10 bold" style="color: #000000; height: 15px;">
                        <td colspan="2" class="a-left">
                            <asp:Label ID="Rs_KitUsed" runat="server" Text="Kit Used" meta:resourcekey="Rs_KitUsedResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="a-left">
                            <asp:DropDownList ID="ddlKit" runat="server" Width="300px" meta:resourcekey="ddlKitResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="h-15 font10 bold" style="color: #000000;">
                        <td colspan="2" class="a-left">
                            <asp:Label ID="Rs_InstrumentUsed" runat="server" Text="Instrument Used" meta:resourcekey="Rs_InstrumentUsedResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="a-left">
                            <asp:DropDownList ID="ddlInstrument" onchange="javascript:setQCData(this.value);"
                                runat="server" Width="300px" meta:resourcekey="ddlInstrumentResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="font10 bold h-15 a-left" style="color: #000000;">
                        <td colspan="2" class="a-left" style="color: #000000;">
                            <asp:Label ID="Rs_QCData" runat="server" Text="QC Data" meta:resourcekey="Rs_QCDataResource1"></asp:Label>
                        </td>
        <td colspan="3" align="left">
            <asp:TextBox ID="txtQCData" runat="server" TextMode="MultiLine" Rows="2" Columns="35"
                meta:resourcekey="txtQCDataResource1"></asp:TextBox>
        </td>
                    </tr>
                    <tr class="h-15 font10 bold a-left" style="color: #000000;">
                        <td colspan="2" class="a-left" style="color: #000000;">
                            <asp:Label ID="Rs_InterpretationNotes" runat="server" Text="Interpretation/Notes"
                                meta:resourcekey="Rs_InterpretationNotesResource1"></asp:Label>
                        </td>
        <td colspan="3" align="left">
            <asp:TextBox ID="txtInterpretation" runat="server" TextMode="MultiLine" Rows="2"
                Columns="35" meta:resourcekey="txtInterpretationResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="h-15 font10 bold a-left" style="color: #000000;">
                        <td colspan="5" style="color: #000000;" align="center">
                            <asp:Button ID="btnAdd" runat="server" OnClientClick="javascript:return onClickAdd();"
                                OnClick="btnAdd_Click" Text="Add Details" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" meta:resourcekey="btnAddResource1" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table id="tabMethodKitHeader" style="display: none;"
    runat="server" class="colorforcontent w-100p">
    <tr class="h-15 font11">
        <td class="w-3p">
            &nbsp;
        </td>
        <td class="w-19p">
            <asp:Label ID="Rs_Investigation1" runat="server" Text="Investigation" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_Method" runat="server" Text="Method" meta:resourcekey="Rs_MethodResource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_Kit" runat="server" Text="Kit" meta:resourcekey="Rs_KitResource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_Instrument" runat="server" Text="Instrument" meta:resourcekey="Rs_InstrumentResource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_Interpretation" runat="server" Text="Interpretation" meta:resourcekey="Rs_InterpretationResource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_Principle" runat="server" Text="Principle" meta:resourcekey="Rs_PrincipleResource1"></asp:Label>
        </td>
        <td class="w-13p">
            <asp:Label ID="Rs_QCData1" runat="server" Text="QC Data" meta:resourcekey="Rs_QCData1Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tabMethodKit" border="1" runat="server" cellpadding="3" style="color: #000000;
    font-weight: normal; border-collapse: collapse;" class="gridView w-100p">
</table>
<input type="hidden" runat="server" id="hdnMethodKit" />
<input type="hidden" runat="server" id="hdnQCData" />
<input type="hidden" runat="server" id="btnShow" value="N" />
