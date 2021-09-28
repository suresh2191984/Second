<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConsultationDetails.ascx.cs"
    Inherits="CommonControls_ConsultationDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

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

        var ChkOthers = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].text;

        if (ChkOthers != "Others") {
            if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Select Dr-Name");
                }
                document.getElementById('<%=ddlPhysicianVis.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtAmount.ClientID %>').value == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Fill the Amount");
                }
                document.getElementById('<%= txtAmount.ClientID %>').focus();
                return false;
            }
            if ((document.getElementById('<%= txtUnit.ClientID %>').value == "") || (document.getElementById('<%= txtUnit.ClientID %>').value == "0")) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
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
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Fill the Amount");
                }
                document.getElementById('<%= txtAmount.ClientID %>').focus();
                return false;
            }
            if ((document.getElementById('<%= txtUnit.ClientID %>').value == "") || (document.getElementById('<%= txtUnit.ClientID %>').value == "0")) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Fill the Units, Cannot be 0");
                }
                document.getElementById('<%= txtUnit.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtOthers.ClientID %>').value == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Enter the Doctor Name");
                }
                document.getElementById('<%=txtOthers.ClientID %>').focus();
                return false;
            }

            var vals = 0;
            var DrName = document.getElementById('<%=txtOthers.ClientID %>').value;
            var Unit = document.getElementById('<%=txtUnit.ClientID %>').value;
            var PhysicianFee = document.getElementById('<%=txtAmount.ClientID %>').value;
            var DrDate = document.getElementById('<%=txtDate.ClientID %>').value;
            document.getElementById('<%=txtUnit.ClientID %>').value = '1';
            document.getElementById('<%=txtOthers.ClientID %>').value = "";
        }
        else {

            var DrId = document.getElementById('<%=ddlPhysicianVis.ClientID %>').value;

            var vals = DrId.split('~')[1];

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
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = DrName;
            cell3.innerHTML = Unit;
            cell4.innerHTML = PhysicianFee;
            cell5.innerHTML = DrDate;
            document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + Unit + "~" + PhysicianFee + "~" + DrDate + "^";
            document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=trOthers.ClientID %>').style.display = "none";

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
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = DrName;
            cell3.innerHTML = Unit;
            cell4.innerHTML = PhysicianFee;
            cell5.innerHTML = DrDate;
            document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + Unit + "~" + PhysicianFee + "~" + DrDate + "^";
            document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=trOthers.ClientID %>').style.display = "none";

            return false;

        }
        else if (PhysicianStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\ConsultationDetails.ascx_5');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Dr Name is Already Added!");
        }
            return false;
        }


    }

    function LoadPhysicianExistingItems() {
        var HidLoadValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
        var list = HidLoadValue.split('^');
        if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
            document.getElementById('<%=tblPhysician.ClientID %>').style.display = "block";
            document.getElementById('<%=lblHeader.ClientID %>').style.display = "block";
            for (var count = 0; count < list.length - 1; count++) {
                var PhysicianList = list[count].split('~');

                var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                row.id = PhysicianList[1];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + PhysicianList[1] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";


                cell2.innerHTML = PhysicianList[2];
                cell3.innerHTML = PhysicianList[3];
                cell4.innerHTML = PhysicianList[4];
                cell5.innerHTML = PhysicianList[5];
                //cell5.style.display = "none";
            }
        }
        return false;
    }
    function ConsDisplay(Cid) {
        document.getElementById(Cid).style.display = 'block';
    }
    function multipleQuantity() {
        //alert(document.getElementById('ipConsultation_txtUnit').value);
        //alert(document.getElementById('ipConsultation_txtAmount').value);
        var qty = document.getElementById('ipConsultation_txtUnit').value;
        var amt = document.getElementById('ipConsultation_txtAmount').value;
        var totAmt = qty * amt;
        //alert(totAmt);
        //document.getElementById('ipConsultation_txtAmount').value = totAmt;
    }

    function getFeeForPhysician() {

        if (document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].text == "Others") {
            document.getElementById('<%= txtUnit.ClientID %>').value = "1";
            document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
            document.getElementById('<%= txtAmount.ClientID %>').value = "";
            document.getElementById('<%=trOthers.ClientID %>').style.display = "block";

        }
        else {
            var docName = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%= ddlPhysicianVis.ClientID %>').selectedIndex].innerHTML;
            if (document.getElementById('<%= ddlPhysicianVis.ClientID %>').value == 0) {
                document.getElementById('<%= txtUnit.ClientID %>').value = "1";
                document.getElementById('<%= txtUnit.ClientID %>').disabled = true;
                document.getElementById('<%= txtAmount.ClientID %>').value = "";
                document.getElementById('<%=trOthers.ClientID %>').style.display = "none";
            }
            else {
                var amt = document.getElementById('<%= ddlPhysicianVis.ClientID %>').value;
                var totAmt = amt.split('~')[0];
                document.getElementById('<%= txtUnit.ClientID %>').disabled = false;
                document.getElementById('<%= txtAmount.ClientID %>').value = totAmt;
                document.getElementById('<%=trOthers.ClientID %>').style.display = "none";
            }
        }
    }
</script>

<asp:HiddenField ID="iconHidDelete" runat="server" />
<table width="100%" id="tableConsultation" runat="server">
    <tr>
        <td colspan="6" style="display: none;">
            <asp:RadioButton ID="rdoVisit" runat="server" Checked="True" Text="Visiting Consultation"
                OnClick="DropShow();" GroupName="Phy" meta:resourcekey="rdoVisitResource1" />
        </td>
        <td colspan="3">
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblPhysician" runat="server" Text="Dr." meta:resourcekey="lblPhysicianResource1"></asp:Label>
        </td>
        <td>
            <%--<asp:UpdatePanel ID="updatepanel1" runat="server">
                    <ContentTemplate>--%>
            <asp:DropDownList ID="ddlPhysicianVis" runat="server" onChange="getFeeForPhysician()"
                Width="150px" meta:resourcekey="ddlPhysicianVisResource1">
               
            </asp:DropDownList>
            <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
        </td>
        <td>
            <asp:Label ID="lblUnit" runat="server" Text="Unit" meta:resourcekey="lblUnitResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtUnit" onblur="multipleQuantity()" Enabled="False" runat="server"
                Width="30px" meta:resourcekey="txtUnitResource1"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblAmount" runat="server" Text="Amount" meta:resourcekey="lblAmountResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtAmount" runat="server" Width="50px" meta:resourcekey="txtAmountResource1"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtDate" MaxLength="25" size="25" ReadOnly="True"
                meta:resourcekey="txtDateResource1"></asp:TextBox>
            <a href="javascript:NewCal('<%=txtDate.ClientID %>','ddmmyyyy',true,12)">
                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"
                    style="width: 16px"></a>
        </td>
        <td>
            <asp:Button ID="btnInvAdd" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" OnClientClick="return LoadPhysicianItems();"
                meta:resourcekey="btnInvAddResource1" />
        </td>
    </tr>
    <tr id="trOthers" style="display: none">
        <td>
            <asp:Label ID="Rs_DoctorName" runat="server" Text="Doctor Name" meta:resourcekey="Rs_DoctorNameResource1"></asp:Label>
        </td>
        <td>
            <input type="text" id="txtOthers" runat="server" style="width: 148px;" />
        </td>
    </tr>
</table>
<br />
<table id="Table1" width="50%" cellpadding="0px" cellspacing="0">
    <tr>
        <td>
            <asp:Label ID="lblHeader" runat="server" Text="Consultation Details" Style="display: none;
                font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblPhysician" class="dataheaderInvCtrl" runat="server" width="50%" cellspacing="0"
    border="2" style="display: none">
    <tr>
        <td>
        </td>
        <td>
            <asp:Label ID="Rs_DrName" runat="server" Text="Dr Name" meta:resourcekey="Rs_DrNameResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="Rs_Unit" runat="server" Text="Unit" meta:resourcekey="Rs_UnitResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="Rs_PhysicianFee" runat="server" Text="PhysicianFee" meta:resourcekey="Rs_PhysicianFeeResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="Rs_Date" runat="server" Text="Date" meta:resourcekey="Rs_DateResource1"></asp:Label>
        </td>
    </tr>
</table>

<script language="javascript" type="text/javascript">
    LoadPhysicianExistingItems();
</script>

<asp:HiddenField ID="hdnShowAmount" runat="server" />
