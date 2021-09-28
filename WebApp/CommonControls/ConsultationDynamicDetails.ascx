<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConsultationDynamicDetails.ascx.cs"
    Inherits="CommonControls_ConsultationDynamicDetails"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<asp:UpdatePanel ID="pnlSpeciality" runat="server">
    <ContentTemplate>

        <script language="javascript" type="text/javascript">

            function ImgDeleteclick(ImgDeleteID) {
                document.getElementById(ImgDeleteID).style.display = "none";
                var HidDeleteValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
                var list = HidDeleteValue.split('^');
                var newPhyList = '';

                if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var PhyList = list[count].split('~');
                        if (PhyList[1] != '') {
                            if (PhyList[1] != ImgDeleteID) {
                                newPhyList += list[count] + "^";
                            }
                        }
                    }
                    document.getElementById('<%=iconHidDelete.ClientID %>').value = newPhyList;
                }
            }

            function LoadPhysicianItems() {

                var ChkOthers = document.getElementById('<%= ddlSpeciality.ClientID %>').options[document.getElementById('<%= ddlSpeciality.ClientID %>').selectedIndex].text;
                if (document.getElementById('<%=ddlSpeciality.ClientID %>').selectedIndex == 0) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDynamicDetails.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert("Select Speciality");
                    }
                    document.getElementById('<%=ddlSpeciality.ClientID %>').focus();
                    return false;
                }
              
                var PhysicianStatus = 0;
                var HidAddValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
                var list = HidAddValue.split('^');
                var DrId = document.getElementById('<%=ddlSpeciality.ClientID %>').value;

                var vals = document.getElementById('<%= ddlPhysicianVis.ClientID %>').value;

                var DrName = document.getElementById('<%=ddlSpeciality.ClientID %>').options[document.getElementById('<%=ddlSpeciality.ClientID %>').selectedIndex].text;

                if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var PhysicianList = list[count].split('~');

                        if (PhysicianList[0] != '') {
                            if (PhysicianList[0] == vals && PhysicianList[2] == DrName ) {
                                PhysicianStatus = 1;
                            }
                        }
                    }
                }
                else {

                    document.getElementById('<%=lblHeader.ClientID %>').style.display = 'block';
                    document.getElementById('<%=tblPhysician.ClientID %>').style.display = "table";
                    var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                    row.id = icout;

                    vals = vals + "~" + icout;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                   
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = DrName;
                     
                     
                    document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "^";
                    document.getElementById('<%=ddlSpeciality.ClientID %>').selectedIndex = 0;
                   
                    PhysicianStatus = 0;
                    return false;
                }
                if (PhysicianStatus == 0) {
                    document.getElementById('<%=lblHeader.ClientID %>').style.display = 'block';
                    document.getElementById('<%=tblPhysician.ClientID %>').style.display = "table";
                    var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                    row.id = icout;

                    vals = vals + "~" + icout;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                   
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = DrName;
                    cell3.innerHTML = vals;
                      
                    document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName  + "^";
                    document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
                     
                    return false;

                }
                else if (PhysicianStatus == 1) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDynamicDetails.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Speciality/Doctor Name Already Added!");
                }
                    return false;
                }


            }

            function LoadPhysicianExistingItems() {
                var HidLoadValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
                var list = HidLoadValue.split('^');
                if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                    document.getElementById('<%=tblPhysician.ClientID %>').style.display = "table";
                    document.getElementById('<%=lblHeader.ClientID %>').style.display = "block";
                    for (var count = 0; count < list.length - 1; count++) {
                        var PhysicianList = list[count].split('~');

                        var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                        row.id = PhysicianList[1];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                         
                        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + PhysicianList[1] + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "5%";


                        cell2.innerHTML = PhysicianList[2];
                        cell3.innerHTML = PhysicianList[3];
                         
                        //cell5.style.display = "none";
                    }
                }
                return false;
            }
            function ConsDisplay(Cid) {
                document.getElementById(Cid).style.display = 'block';
            }

            function selPhysician() {

                var drpSlots = document.getElementById('<%= ddlPhysicianVis.ClientID %>');
                document.getElementById('<%=  hdnSelectedPhysician.ClientID %>').value = drpSlots.value;
                var drpSpeciality = document.getElementById('<%= ddlSpeciality.ClientID %>');
                var phyName = drpSlots.options[drpSlots.selectedIndex].text;

                var speName = drpSpeciality.options[drpSpeciality.selectedIndex].text.split('<%= CurrencyName %>')[0].split('-')[0];
                var SPeAMt = drpSpeciality.options[drpSpeciality.selectedIndex].text.split('<%= CurrencyName %>')[1].split('-')[1]; 

                if (phyName == "--Select--") {
                   
                    CmdAddBillItemsType_onclick('SPE', 0, drpSpeciality.value, speName, 1, SPeAMt, SPeAMt);
                }
                else {
                    var amtVal = phyName.split('<%= CurrencyName %>')[1].split('-')[1];
                    CmdAddBillItemsType_onclick('CON', drpSlots.value, drpSpeciality.value, phyName.split('<%=CurrencyName %>')[0].split(':')[0], 1, amtVal, amtVal);
                }
            }
            
            function chkSource() {

                var value = document.getElementById('<%= ddlSpeciality.ClientID %>').value;
                
                var invisibleSlots = document.getElementById('<%= ddlTempConsultingName.ClientID %>');
                var SpecSlots = document.getElementById('<%= ddlTempConsultAndSpec.ClientID %>');
                var drpSlots = document.getElementById('<%= ddlPhysicianVis.ClientID %>');



                var intVisibleCount = 0;
                intVisibleCount = invisibleSlots.length;
                var i = 0;

                drpSlots.options.length = 0;

                var optn = document.createElement("option");
                drpSlots.options.add(optn);
                optn.text = "--Select--";
                optn.value = "0";

                for (i = 1; i < SpecSlots.length; i++) {
                    var SelVAl = SpecSlots.options[i].text;
                    if (SelVAl == value) {
                        var j = 0;
                        var selobj = SpecSlots.options[i].value;
                        for (j = 1; j < invisibleSlots.length; j++) {
                            var SelVals = invisibleSlots.options[j].value;
                            if (SelVals == selobj) {
                            
                                var opt = document.createElement("option");
                                drpSlots.options.add(opt);
                                opt.text = invisibleSlots.options[j].text;
                                opt.value = SelVals;
                            }
                        }

                    }


                }
            }

                
 
               
             
        </script>
  <asp:HiddenField ID="hdnSelectedPhysician" Value="0" runat="server" />
        <asp:HiddenField ID="iconHidDelete" runat="server" />
        <table  id="tableConsultation" runat="server">
            <tr runat="server">
                <td colspan="6" style="display: none;" runat="server">
                    <asp:RadioButton ID="rdoVisit" runat="server" Checked="True" Text="Visiting Consultation"
                        OnClick="DropShow();" GroupName="Phy" />
                </td>
                <td colspan="3" runat="server">
                </td>
            </tr>
            <tr runat="server">
                <td runat="server">
                    <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>&nbsp;&nbsp;
                    <asp:DropDownList ID="ddlSpeciality" CssClass="ddlTheme12 ddlsmall" runat="server"
                        onChange="javascript:chkSource();" TabIndex="2">
                    </asp:DropDownList>
                    <asp:Label ID="lblConsultingName" runat="server" Text="Name"></asp:Label>&nbsp;&nbsp;
                    <asp:DropDownList ID="ddlPhysicianVis" CssClass="ddlTheme12 ddlsmall" runat="server"
                        TabIndex="3">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlTempConsultingName" CssClass="ddlsmall" runat="server" Style="display: none;">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlTempConsultAndSpec" CssClass="ddlsmall" runat="server" Style="display: none;">
                    </asp:DropDownList>
                </td>
                <td runat="server">
                    <input type="button" id="btnAdd" onclick="selPhysician();" class="btn" value="Add" />
                </td>
            </tr>
        </table>
        <br />
        <table id="Table1" class="w-50p">
            <tr>
                <td>
                    <asp:Label ID="lblHeader" runat="server" Text="Consultation Details" Style="display: none;"
                        CssClass="Duecolor font12 v-middle padding5" meta:resourcekey="lblHeaderResource2"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="tblPhysician" class="dataheaderInvCtrl w-50p" runat="server" style="display: none">
            <tr>
                <td>
                </td>
                <td>
                    <asp:Label ID="lblspec" runat="server" Text="Speciality" meta:resourcekey="lblspecResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbdrnme" runat="server" Text="Dr Name" meta:resourcekey="lbdrnmeResource1"></asp:Label>
                </td>
                 
            </tr>
        </table>
    <asp:HiddenField ID="hdnShowAmount" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>
