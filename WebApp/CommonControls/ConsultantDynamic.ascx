<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConsultantDynamic.ascx.cs"
    Inherits="CommonControls_ConsultantDynamic" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<asp:UpdatePanel ID="pnlSpeciality" runat="server">
    <ContentTemplate>

        <script language="javascript" type="text/javascript">


            function LoadPhysicianItems() {

                var ChkOthers = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].text;

                if (ChkOthers != "Others") {
                    if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_1');
                        if (userMsg != null) {
                            alert(userMsg);
                        } else {
                            alert("Select Dr-Name");
                        }
                        document.getElementById('<%=ddlPhysicianVis.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%= txtAmount.ClientID %>').value == "") {
                     if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_2');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else{
                        alert("Please Fill the Amount");
                        }
                        document.getElementById('<%= txtAmount.ClientID %>').focus();
                        return false;
                    }
                    if ((document.getElementById('<%= txtUnit.ClientID %>').value == "") || (document.getElementById('<%= txtUnit.ClientID %>').value == "0")) {
                     if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_3');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else
                        {
                        alert("Please Fill the Units, Cannot be 0");
                        }
                        document.getElementById('<%= txtUnit.ClientID %>').focus();
                        return false;
                    }
                }

                var PhysicianStatus = 0;
                var HidAddValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
                var list = HidAddValue.split('^');

                if (ChkOthers == "Others") {

                    if (document.getElementById('<%= txtAmount.ClientID %>').value == "") {
                     if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_2');
                        if (userMsg != null) {
                            alert(userMsg);
                        }else{
                        alert("Please Fill the Amount");
                        document.getElementById('<%= txtAmount.ClientID %>').focus();
                        }
                        return false;
                    }
                    if ((document.getElementById('<%= txtUnit.ClientID %>').value == "") || (document.getElementById('<%= txtUnit.ClientID %>').value == "0")) {
                     if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_3');
                        if (userMsg != null) {
                            alert(userMsg);
                        }else{
                        alert("Please Fill the Units, Cannor be 0");
                        }
                        document.getElementById('<%= txtUnit.ClientID %>').focus();
                        return false;
                    }
                    

                    var vals = 0;
                    var SpecialityName = document.getElementById('<%=ddlSpeciality.ClientID %>').options[document.getElementById('<%=ddlSpeciality.ClientID %>').selectedIndex].text;
                    var DrName = document.getElementById('<%=ddlPhysicianVis.ClientID %>').options[document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex].text;
                    var Unit = document.getElementById('<%=txtUnit.ClientID %>').value;
                    var PhysicianFee = document.getElementById('<%=txtAmount.ClientID %>').value;
                    var DrDate = document.getElementById('<%=txtDate.ClientID %>').value;
                    document.getElementById('<%=txtUnit.ClientID %>').value = '1';
                    
                }
                else {

                    var DrId = document.getElementById('<%=ddlPhysicianVis.ClientID %>').value;
//                    alert(DrId);
                    var vals = DrId.split('~')[0];

                    var SpecialityName = document.getElementById('<%=ddlSpeciality.ClientID %>').options[document.getElementById('<%=ddlSpeciality.ClientID %>').selectedIndex].text;
                    var DrName = document.getElementById('<%=ddlPhysicianVis.ClientID %>').options[document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex].text;
                    var Unit = document.getElementById('<%=txtUnit.ClientID %>').value;
                    var PhysicianFee = document.getElementById('<%=txtAmount.ClientID %>').value;
                    var DrDate = document.getElementById('<%=txtDate.ClientID %>').value;
                    document.getElementById('<%=txtUnit.ClientID %>').value = '1';
                    document.getElementById('<%=txtAmount.ClientID %>').value = '';
                }


                if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var PhysicianList = list[count].split('~');

                        if (PhysicianList[0] != '') {
                            if (PhysicianList[0] == vals && PhysicianList[2] == DrName && PhysicianList[5] == DrDate) {
                                PhysicianStatus = 1;
                            }
                        }
                    }
                }
                else {

                    document.getElementById('<%=lblHeader.ClientID %>').style.display = 'block';
                    document.getElementById('<%=tblPhysician.ClientID %>').style.display = "block";
                    var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                    row.id = icout;

                    vals = vals + "~" + icout;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = SpecialityName;
                    cell3.innerHTML = DrName;
                    cell4.innerHTML = Unit;
                    cell5.innerHTML = PhysicianFee;
                    cell6.innerHTML = DrDate; 
                    document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + Unit + "~" + PhysicianFee + "~" + DrDate + "^";
                    document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
                    

                    PhysicianStatus = 0;
                    return false;
                }
                if (PhysicianStatus == 0) {
                    document.getElementById('<%=lblHeader.ClientID %>').style.display = 'block';
                    document.getElementById('<%=tblPhysician.ClientID %>').style.display = "block";
                    var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                    row.id = icout;

                    vals = vals + "~" + icout;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = SpecialityName;
                    cell3.innerHTML = DrName;
                    cell4.innerHTML = Unit;
                    cell5.innerHTML = PhysicianFee;
                    cell6.innerHTML = DrDate;
                    document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + Unit + "~" + PhysicianFee + "~" + DrDate + "^";
                    document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
                    


                    return false;

                }
                else if (PhysicianStatus == 1) {
                 if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultantDynamic.ascx_4');
                        if (userMsg != null) {
                            alert(userMsg);
                        }else
                        {
                alert("Dr Name is Already Added!");
                }
                document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
                document.getElementById('<%= txtAmount.ClientID %>').value = "";
//                document.getElementById('<%= ddlPhysicianVis.ClientID %>').value = "";
//                document.getElementById('<%= ddlSpeciality.ClientID %>').value = "";

                    return false;
                }

                document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
                document.getElementById('<%= txtAmount.ClientID %>').value = "";
                document.getElementById('<%= ddlPhysicianVis.ClientID %>').value = "";
                document.getElementById('<%= ddlSpeciality.ClientID %>').value = "";

            }

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
                //alert(value);
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
                  //  alert(SelVAl);
                    if (SelVAl == value) {
                    //    alert("count =" + SelVAl);
                        var j = 0;
                        var selobj = SpecSlots.options[i].value;
                        for (j = 1; j < invisibleSlots.length; j++) {
                            var SelVals = invisibleSlots.options[j].value;
                            if (SelVals == selobj) {

                                var opt = document.createElement("option");
                                drpSlots.options.add(opt);
                                var subtext = new Array();
                                subtext = invisibleSlots.options[j].text.split(':');
                                opt.text = subtext[0];
                                opt.value = SelVals + '~' + subtext[1];
                            }
                        }

                    }


                }
                if (document.getElementById('<%= ddlSpeciality.ClientID %>').value != 0) {

                    var totAmt = new Array();
                    //var amt = document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedValue;
                    var amt = document.getElementById('<%= ddlSpeciality.ClientID %>').options[document.getElementById('<%= ddlSpeciality.ClientID %>').selectedIndex].text;
                    totAmt = amt.split('-');
                    document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                    document.getElementById('<%= txtUnit.ClientID %>').disabled = false;
                    document.getElementById('<%= txtAmount.ClientID %>').value = totAmt[1];
                }
            }


            function getFeeForPhysician() {

                if (document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].text == "Others") {
                    document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                    document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
                    document.getElementById('<%= txtAmount.ClientID %>').value = "";


                }
                else {
                    var docName = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].innerHTML;
                    if (document.getElementById('<%= ddlPhysicianVis.ClientID %>').value == 0) {
                        document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                        document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
                        document.getElementById('<%= txtAmount.ClientID %>').value = "";

                    }
                    else {
                        var totAmt = new Array();
                        //var amt = document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedValue;
                        var amt = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].value;
                        totAmt = amt.split('~');
                        var totAmt1 = new Array();
                        //alert(totAmt);
                        totAmt1 = totAmt[1].split('-');
                        document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                        document.getElementById('<%= txtUnit.ClientID %>').disabled = false;
                        document.getElementById('<%= txtAmount.ClientID %>').value = totAmt1[1];

                    }
                }
            }
                
 
               
             
        </script>

        <asp:HiddenField ID="hdnSelectedPhysician" Value="0" runat="server" />
        <asp:HiddenField ID="iconHidDelete" runat="server" />
        <table id="tableConsultation" runat="server" width="100%">
            <tr runat="server">
                <td colspan="9" style="display: none;" runat="server">
                    <asp:RadioButton ID="rdoVisit" runat="server" Checked="True" Text="Visiting Consultation"
                        OnClick="DropShow();" GroupName="Phy" />
                </td>
            </tr>
            <tr runat="server">
                <td runat="server">
                    <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>&nbsp;&nbsp;
                    <asp:DropDownList ID="ddlSpeciality" runat="server" onChange="javascript:chkSource();" TabIndex="2">
                    </asp:DropDownList>
                   
                </td>
                <td runat="server">
                    <asp:Label ID="lblUnit" runat="server" Text="Unit"></asp:Label>
                </td>
                <td runat="server">
                    <asp:TextBox ID="txtUnit" onblur="multipleQuantity()" Enabled="False" runat="server"
                        Width="30px"></asp:TextBox>
                </td>
                <td runat="server">
                    <asp:Label ID="lblAmount" runat="server" Text="Amount"></asp:Label>
                </td>
                <td runat="server">
                    <asp:TextBox ID="txtAmount" runat="server" Width="50px"></asp:TextBox>
                </td>
                <td runat="server">
                    <asp:Label ID="lblDate" runat="server" Text="Date"></asp:Label>
                </td>
                <td runat="server">
                    <asp:TextBox runat="server" ID="txtDate" MaxLength="25" size="25" 
                        Enabled="False"></asp:TextBox>
                    <a href="javascript:NewCal('<%=txtDate.ClientID %>','ddmmyyyy',true,12)">
                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                </td>
                <td runat="server">
                    <asp:Button ID="btnInvAdd" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" 
                        OnClientClick="return LoadPhysicianItems();" />
                </td>
            </tr>
            <tr runat="server">
                <td runat="server">
                     
                    <asp:Label ID="lblConsultingName" runat="server" Text="Dr Name"></asp:Label>&nbsp;&nbsp;&nbsp;
                    
                    <asp:DropDownList ID="ddlPhysicianVis" runat="server" onChange="getFeeForPhysician()"
                        TabIndex="3">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlTempConsultingName" runat="server" Style="display: none;">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlTempConsultAndSpec" runat="server" Style="display: none;">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <br />
        <table id="Table1" width="50%" cellpadding="0px" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lblHeader" runat="server" Text="Consultation Details" Style="display: none;
                        font-size: 12px; vertical-align: middle; padding: 5px;" 
                        CssClass="Duecolor" meta:resourcekey="lblHeaderResource1"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="tblPhysician" class="dataheaderInvCtrl" runat="server" width="80%" cellspacing="0"
            border="2" style="display: none" >
            
            
            <tr>
                <td>
                </td>
                <td align="center" style="font-weight:bold;">
        <asp:Label ID="lbspecl" runat="server" Text="Speciality" 
                        meta:resourcekey="lbspeclResource1"></asp:Label>
                </td>
                <td align="center" style="font-weight:bold;">
             <asp:Label ID="lbphy" runat="server" Text="Physician" 
                        meta:resourcekey="lbphyResource1"></asp:Label>
                </td>
                <td align="center" style="font-weight:bold;">
                 <asp:Label ID="lbunt" runat="server" Text="Unit" meta:resourcekey="lbuntResource1"></asp:Label>
                </td>
                <td align="center" style="font-weight:bold;">
                <asp:Label ID="lbamt" runat="server" Text="Amount" 
                        meta:resourcekey="lbamtResource1"></asp:Label>
                </td>
                <td align="center" style="font-weight:bold;">
                 <asp:Label ID="lbdt" runat="server" Text="Date" meta:resourcekey="lbdtResource1"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnShowAmount" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>
