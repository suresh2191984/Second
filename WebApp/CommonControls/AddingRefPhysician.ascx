<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddingRefPhysician.ascx.cs"
    Inherits="CommonControls_AddingRefPhysician" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>

<script language="javascript" type="text/javascript">

    function validateLabRefPhysicianDetails() {
        if (document.getElementById('<%=txtDrName.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\AddingRefPhysician.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Please Enter Physician Name');
            }
            //            document.getElementById('<%=txtDrName.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=ddSalutation.ClientID %>').value == '0') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\AddingRefPhysician.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Please Select Salutation');
            }
            document.getElementById('<%=ddSalutation.ClientID %>').focus();
            return false;
        }
    }
    function loginuser() {
        var login = document.getElementById('<%= chkUserLogin.ClientID %>').checked;
        if (login) {
            document.getElementById('<%= Login.ClientID%>').style.display = 'Block';
        }
        else if (!login) {
            document.getElementById('<%= Login.ClientID%>').style.display = 'none';
        }
    }
    function onClick1(id) {
        var type;
        var rate = '';
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');
        var AddStatus = 0;
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');
        if (id == document.getElementById("<%= chklstHsptl.ClientID %>").getAttribute('id')) {
            type = 'GRP';
        }
        document.getElementById('<%= iconHid.ClientID %>').value = document.getElementById('<%= iconHid.ClientID %>').value == "" ? document.getElementById('<%= HdnHospitalID.ClientID %>').value : document.getElementById('<%= iconHid.ClientID %>').value;
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('|');
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (obj.selectedIndex >= 0) {
                        if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";
            var row = document.getElementById('Rfrdoctor_AddingRefPhysician_tblOrederedInves').insertRow(0);
            row.id = obj.options[obj.selectedIndex].value;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            cell1.innerHTML = "<img id='" + obj.options[obj.selectedIndex].value + "' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell3.innerHTML = obj.options[obj.selectedIndex].value;
            cell3.style.display = "none";
            //cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
            //cell4.width = "30%";
            document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
            //rate = obj.options[obj.selectedIndex].text.split(':');
            //total = parseFloat(rate[1]);
            //alert('total:' + parseFloat(total).toFixed(2));
            AddStatus = 2;
            //document.getElementById('tblTot').style.display = "block";
        }
        if (AddStatus == 0) {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = 'block';
            var row = document.getElementById('Rfrdoctor_AddingRefPhysician_tblOrederedInves').insertRow(0);
            row.id = obj.options[obj.selectedIndex].value;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            //var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell2.width = "300Px";
            cell3.innerHTML = obj.options[obj.selectedIndex].value;
            cell3.style.display = "none";
            //cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
            //cell4.width = "30%";
            document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
            //rate = obj.options[obj.selectedIndex].text.split(':');
            //alert('rae:' + rate[1]);
            //total = parseFloat(total) + parseFloat(rate[1]);

        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\AddingRefPhysician.ascx_3');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert("Hospital Already Added!");
        }
        }
        return false;
    }

    function setItem(e, ctl) {
        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClick1(ctl.id);
        }
        else if (key == 0) {
            document.getElementById(ctl).focus();
        }
    }
    function SetId(ID) {
        if (ID != document.getElementById('<%= hidID.ClientID %>').value) {
            //MyUtil.selectFilter(document.getElementById('<%= hidID.ClientID %>').value, '');                
            document.getElementById('<%= hidID.ClientID %>').value = ID;
            // document.getElementById('txtBX').value = '';
            //document.getElementById('txtBX').focus();
        }
        return false;
    }
    //        MyUtil = new Object();
    //        MyUtil.selectFilterData = new Object();
    //        MyUtil.selectFilter = function(selectId, filter) {
    //            selectId = document.getElementById('<%= hidID.ClientID %>').value;
    //            var list = document.getElementById(selectId);
    //            if (!MyUtil.selectFilterData[selectId]) { //if we don't have a list of all the options, cache them now'
    //                MyUtil.selectFilterData[selectId] = new Array();
    //                for (var i = 0; i < list.options.length; i++) MyUtil.selectFilterData[selectId][i] = list.options[i];
    //            }
    //            list.options.length = 0;   //remove all elements from the list
    //            for (var i = 0; i < MyUtil.selectFilterData[selectId].length; i++) { //add elements from cache if they match filter
    //                var o = MyUtil.selectFilterData[selectId][i];
    //                if (o.text.toLowerCase().indexOf(filter.toLowerCase()) >= 0) {
    //                    if (navigator.appName == "Microsoft Internet Explorer") {
    //                        //alert("hai")
    //                        list.add(o);
    //                    }
    //                    else {
    //                        //alert("httt")
    //                        list.add(o, null);

    //                    }
    //                }
    //            }
    //        }
</script>

<div id="divAddLink" runat="server">
    <asp:UpdatePanel ID="Up2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click here to add new Referring Physician"
                ID="lnkAddnew" Text="Add New" OnClick="lnkAddnew_Click" meta:resourcekey="lnkAddnewResource1"></asp:LinkButton>
            <asp:Label ID="ltrMsg" runat="server" meta:resourcekey="ltrMsgResource1"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<asp:UpdatePanel ID="UpdatePanel5" runat="server">
    <ContentTemplate>
        <table border="0" width="50%" id="tblPopup" runat="server">
            <tr runat="server">
                <td runat="server">
                    <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                    <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                    <ajc:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                        PopupControlID="pnlAttrib" TargetControlID="hiddenTargetControlForModalPopup"
                        DynamicServicePath="" Enabled="True">
                    </ajc:ModalPopupExtender>
                    <asp:Panel ID="pnlAttrib" Style="display: none" BorderWidth="1px" Width="80%" CssClass="modalPopup dataheaderPopup"
                        runat="server">
                        <table border="2" width="100%" style="border-color: Red;">
                            <tr>
                                <td align="center">
                                    <input type="hidden" id="iconHid" style="width: 50%;" runat="server"></input>
                                    <input id="HidDel" runat="server" style="width: 50%;" type="hidden"></input>
                                    <input id="HdnRoleID" runat="server" type="hidden"></input>
                                    <input id="hdnUserId" runat="server" type="hidden"></input>
                                    <input id="LogID" runat="server" type="hidden"></input>
                                    <input id="hdnReferingPhysicianID" runat="server" type="hidden"></input>
                                    <input id="HdnLPF" runat="server" type="hidden"></input>
                                    <input id="hidID" runat="server" type="hidden"></input>
                                    <table id="TabNew" runat="server" border="0" cellpadding="2" cellspacing="0" class="dataheader2"
                                        width="100%">
                                        <tr runat="server">
                                            <td runat="server">
                                            </td>
                                            <td runat="server">
                                            </td>
                                            <td runat="server" rowspan="7" width="96%">
                                                <table border="0px" cellpadding="0px" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td valign="middle">
                                                            <asp:Label ID="lblHeader" runat="server" class="lblfont">
                                                                <asp:Label ID="Rs_ReferingHospitals" runat="server" Text="Refering Hospitals"></asp:Label>
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblOrederedInves" runat="server" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                    style="display: none" width="96%">
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="height: 5px;">
                                            </td>
                                            <td runat="server">
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" align="right" style="width: 25%;">
                                                <asp:Label ID="Rs_DoctorsName" runat="server" Text="Doctor's Name"></asp:Label>
                                            </td>
                                            <td runat="server" align="left" style="width: 50%;">
                                                <asp:DropDownList ID="ddSalutation" runat="server" TabIndex="1" ToolTip="Select Salutation"
                                                    Width="80px">
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtDrName" runat="server" MaxLength="60" TabIndex="2" ToolTip="Refering Physician(Doctor) Name"
                                                    Width="168px"></asp:TextBox>
                                                &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" align="right" style="width: 25%;">
                                                <asp:Label ID="Rs_Qualification" runat="server" Text="Qualification"></asp:Label>
                                            </td>
                                            <td runat="server" align="left" style="width: 50%;">
                                                <asp:TextBox ID="txtDrQualification" runat="server" MaxLength="60" TabIndex="3" ToolTip="Refering Physician(Doctor) Qualification"
                                                    Width="250px"></asp:TextBox>
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" align="right" style="width: 25%;">
                                                <asp:Label ID="Rs_OrganizationName" runat="server" Text="Organization Name"></asp:Label>
                                            </td>
                                            <td runat="server" align="left" style="width: 50%;">
                                                <asp:TextBox ID="txtDrOrganization" runat="server" MaxLength="60" TabIndex="4" ToolTip="Refering Physician(Doctor) Organization"
                                                    Width="250px"></asp:TextBox>
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" align="right">
                                                <asp:Label ID="Rs_Sex" runat="server" Text="Sex"></asp:Label>
                                            </td>
                                            <td runat="server">
                                                <asp:DropDownList ID="ddSex" runat="server" TabIndex="5" ToolTip="Select Sex">
                                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                                    <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                        </tr>
                                        <tr id="tdrefer" runat="server">
                                            <td runat="server" align="right" style="width: 25%;">
                                                <asp:Label ID="Rs_ReferalHospitalName" runat="server" Text="Referral Hospital Name"></asp:Label>
                                            </td>
                                            <td runat="server" style="width: 50%;">
                                                <asp:ListBox ID="chklstHsptl" runat="server" EnableViewState="False" Height="100px"
                                                    onclick="javascript:return SetId(this.id);" ondblClick="javascript:onClick1(this.id);"
                                                    onkeypress="javascript:setItem(event,this);" TabIndex="7" ToolTip="Double Click the List or Press Enter to Select Group"
                                                    Width="300px"></asp:ListBox>
                                                <asp:HiddenField ID="HdnHospitalID" runat="server" />
                                                <asp:HiddenField ID="hdnReferringPhy" runat="server" />
                                                <asp:HiddenField ID="hdnReferrinCancel" runat="server" />
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" colspan="3">
                                                <asp:Label ID="lblLoginName" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server">
                                            </td>
                                            <td id="Td1" runat="server">
                                                <asp:CheckBox ID="chkUserLogin" runat="server" onclick="javascript:loginuser()" TabIndex="8"
                                                    Text="Create User Login" />
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server">
                                            </td>
                                            <td runat="server">
                                                <div id="Login" runat="server" class="modalPopup dataheaderPopup" style="display: none;
                                                    border: none 20px; width: 300Px; height: 100px; border-color: Black;">
                                                    <table border="0">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PreferredUserName" runat="server" Text="Preferred User Name"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUserName" runat="server" TabIndex="9" Width="135px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Password" runat="server" Text="Password"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPassword" runat="server" TabIndex="10" TextMode="Password" Width="135px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_UserType" runat="server" Text="UserType"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="chkRefPhysician" runat="server" Checked="True" Enabled="False"
                                                                    Text="Referring Physician" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td runat="server">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnSave_Click" OnClientClick="return validateLabRefPhysicianDetails()" />
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="btnCancel1" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    OnClick="btnCancel1_click" onmouseout="this.className='btn'" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Label runat="server" ID="lblStatus" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdateProgress ID="UpdateProgress1" runat="server">
    <ProgressTemplate>
        <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="imgProg" runat="server" meta:resourcekey="imgProgResource1" />
    </ProgressTemplate>
</asp:UpdateProgress>
