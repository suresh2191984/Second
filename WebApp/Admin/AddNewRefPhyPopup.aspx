<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="AddNewRefPhyPopup.aspx.cs"
    Inherits="Admin_AddNewRefPhyPopup" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add New Refered Physician </title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateLabRefPhysicianDetails() {
            if (document.getElementById('txtDrName').value.trim() == '') {
                alert('Provide physician name');
                document.getElementById('txtDrName').focus();
                return false;
            }
            if (document.getElementById('ddSalutation').value == '0') {
                alert('Select salutation');
                document.getElementById('ddSalutation').focus();
                return false;
            }
        }

        function checkSearchName() {
            if (document.getElementById('txtSearchPhysicianName').value.trim() == '') {
                alert('Provide the search text to find the physician');
                document.getElementById('txtSearchPhysicianName').focus();
                return false;
            }
        }

        function HideDiv() {
            document.getElementById('TabNew').style.visibility = 'visible';
        }
        var total = '';

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


            document.getElementById('<%= iconHid.ClientID %>').value = document.getElementById('<%= iconHid.ClientID %>').value == "" ? document.getElementById('<%= HdnHospitalID.ClientID %>').value : document.getElementById('iconHid').value;

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
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                //var cell4 = row.insertCell(3);

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
                var row = document.getElementById('tblOrederedInves').insertRow(0);
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
                alert('Hospital already added');
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
                MyUtil.selectFilter(document.getElementById('<%= hidID.ClientID %>').value, '');
                alert(ID);
                document.getElementById('<%= hidID.ClientID %>').value = ID;

                // document.getElementById('txtBX').value = '';
                //document.getElementById('txtBX').focus();
            }

            return false;
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
                        //alert("hai");
                        list.add(o);
                    }
                    else {
                        //alert("httt");
                        list.add(o, null);

                    }
                }
            }
        }
        function addPhyFeeList(invID) {
            var HdnLPF = document.getElementById('<%= HdnLPF.ClientID %>').value;
            var LPFlist = HdnLPF.split('^');

            if (document.getElementById('<%= HdnLPF.ClientID %>').value != "") {

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
        function ImgOnclick(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%= iconHid.ClientID %>').value != "" ? document.getElementById('iconHid').value : document.getElementById('HdnHospitalID').value;
            var list = HidValue.split('|');
            var minusamt;
            var newInvList = '';
            if (document.getElementById('<%= iconHid.ClientID %>').value != "" || document.getElementById('<%= HdnHospitalID.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '|';
                        }
                    }
                }
                document.getElementById('<%= iconHid.ClientID %>').value = newInvList;
                document.getElementById('<%= HdnHospitalID.ClientID %>').value = newInvList;
            }
        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        function GetOrgName() {
            //WebService.GetReferingHospital(, RoomTypename, OnRequestComplete, OnWSRequestFiled);
            //document.getElementById('txtDrName').value = "";
            return false;
        }
        function OnRequestComplete(arg) {
            if (arg.length != 0) {
                alert(document.getElementById('txtDrName').value + " Already Exists.");
                return false;
            }
        }
        function OnTimeOut(arg) {
            alert('Timeout has occured');
        }

        function OnWSRequestFailed(arg) {
            alert('Error has occured: ');
        }
        function ShowLogin(ctl) {
            if (ctl.checked == true) {
                document.getElementById("Login").style.display = "block";
                var DrName = document.getElementById("txtDrName").value;
                var Temp = DrName.split(' ');
                document.getElementById("txtUserName").value = Temp[0];
            }
            else {
                document.getElementById("Login").style.display = "none";
                document.getElementById("txtUserName").value = "";
            }


        }

    </script>

    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="85%" valign="top" class="tdspace">
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <input type="hidden" id="iconHid" style="width: 50%;" runat="server">
                                    <input id="HidDel" runat="server" style="width: 50%;" type="hidden"></input>
                                    <input id="HdnRoleID" runat="server" type="hidden"></input>
                                    <input id="hdnUserId" runat="server" type="hidden"></input>
                                    <input id="LogID" runat="server" type="hidden"></input>
                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                        <tr>
                                            <td height="32">
                                                <table id="mytable1" border="0" cellpadding="4" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td id="us" colspan="5">
                                                            <asp:Literal ID="ltHead" runat="server" meta:resourcekey="ltHeadResource1" Text="Search for existing Physician details or click on Add New 
                                                Physician."></asp:Literal>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            &nbsp;&nbsp;<img id="imgstar" runat="server" align="middle" src="../Images/starbutton.png"></img>
                                                            <asp:Label ID="Label4" runat="server" meta:resourcekey="Label4Resource1" Text="Type the first two characters to see the list of physicians. "></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="Panel7" runat="server" BorderWidth="1px" CssClass="dataheader2" meta:resourcekey="Panel7Resource1">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="padding: 3px;">
                                                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="center" style="width: 25%;">
                                                                            <asp:Label ID="lblPhysician" Text="Enter Physician Name" runat="server" 
                                                                                meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 35%;">
                                                                            <asp:TextBox ID="txtSearchPhysicianName" runat="server" CssClass="Txtboxlarge" meta:resourcekey="txtSearchPhysicianNameResource1"
                                                                                ToolTip="Refering Physician(Doctor) Name"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoRname" runat="server" BehaviorID="AutoCompleteEx1"
                                                                                CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" ServiceMethod="GetPhysician"
                                                                                ServicePath="~/WebService.asmx" TargetControlID="txtSearchPhysicianName">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td style="width: 10%;">
                                                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" meta:resourcekey="btnSearchResource1"
                                                                                OnClick="btnSearch_Click" OnClientClick="javascript:return checkSearchName();"
                                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="cursor: pointer;"
                                                                                Text="Search" ToolTip="Click here to Search Refering Physician Name" />
                                                                        </td>
                                                                        <td align="center" style="width: 40%;">
                                                                            <asp:LinkButton ID="addNewPhysician" runat="server" ForeColor="#000333" meta:resourcekey="addNewPhysicianResource1"
                                                                                OnClick="addNewPhysician_Click" ToolTip="Click here to add new Referring Physician"><u>Add new Referring 
                                                                                            Physician</u></asp:LinkButton>
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
                                            <td style="padding-bottom: 10px;">
                                                <asp:Label ID="lblStatus" runat="server" ForeColor="#000333" meta:resourcekey="lblStatusResource1"
                                                    Text="No Matching Records Found!" Visible="False"></asp:Label>
                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    CellPadding="4" CssClass="mytable1" DataKeyNames="ReferingPhysicianID,PhysicianName,Qualification,OrganizationName,LoginName"
                                                    ForeColor="#333333" meta:resourcekey="grdResultResource1" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                    OnRowCommand="grdResult_RowCommand" OnRowDataBound="grdResult_RowDataBound" Width="97%">
                                                    <Columns>
                                                        <asp:BoundField DataField="ReferingPhysicianID" HeaderText="ReferingPhysicianID"
                                                            meta:resourcekey="BoundFieldResource1" Visible="False"></asp:BoundField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1" Visible="False">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLoginId" runat="server" meta:resourcekey="lblLoginIdResource1"
                                                                    Text='<%# Eval("LoginId") %>' Visible="False"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource2" Visible="False">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSalutation" runat="server" meta:resourcekey="lblSalutationResource1"
                                                                    Text='<%# Eval("Salutation") %>' Visible="False"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PhysicianName" HeaderText="Physician Name" meta:resourcekey="BoundFieldResource2">
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Qualification" HeaderText="Qualification" meta:resourcekey="BoundFieldResource3">
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="OrganizationName" HeaderText="Ref Clinic Name" meta:resourcekey="BoundFieldResource4">
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource3" SortExpression="LoginName">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkLoginName" runat="server" CommandArgument="LoginName" CommandName="Sort"
                                                                    meta:resourcekey="lnkLoginNameResource1">LoginName</asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLoginName" runat="server" meta:resourcekey="lblLoginNameResource1"
                                                                    Text='<%# Bind("LoginName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource4"
                                                            SortExpression="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkReset" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="Reset" meta:resourcekey="lnkResetResource1" Style="color: Red; text-decoration: underline;">Reset Password</asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="40%" Wrap="True" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings Mode="NextPrevious" />
                                                    <PagerTemplate>
                                                        <tr>
                                                            <td align="center" colspan="6">
                                                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" meta:resourcekey="lnkPrevResource1"
                                                                    Width="18px" />
                                                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" meta:resourcekey="lnkNextResource1"
                                                                    Width="18px" />
                                                            </td>
                                                        </tr>
                                                    </PagerTemplate>
                                                    <RowStyle Font-Bold="False" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Button ID="btnpnCancel" runat="server" CssClass="btn" meta:resourcekey="btnpnCancelResource1"
                                                    OnClientClick="return popupClose();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                    Style="cursor: pointer;" Text="Close" ToolTip="Click here to Cancel, View the Home Page" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
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
                                                                        <asp:Label ID="lblHeader" runat="server" CssClass="reflabel"> Refering Hospitals 
                                                                                                    &nbsp;&nbsp;&nbsp;&nbsp;</asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblOrederedInves" runat="server" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                width="96%">
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
                                                            Doctor&#39;s Name
                                                        </td>
                                                        <td runat="server" align="left" style="width: 50%;">
                                                            <asp:DropDownList ID="ddSalutation" runat="server" CssClass="ddl" TabIndex="1" ToolTip="Select Salutation"
                                                                Width="80px">
                                                            </asp:DropDownList>
                                                            <asp:TextBox ID="txtDrName" runat="server" CssClass="Txtboxsmall" MaxLength="60"
                                                                onchange="GetOrgName()" TabIndex="2" ToolTip="Refering Physician(Doctor) Name"
                                                                Width="168px"></asp:TextBox>
                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                        <td runat="server">
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="right" style="width: 25%;">
                                                            Qualification
                                                        </td>
                                                        <td runat="server" align="left" style="width: 50%;">
                                                            <asp:TextBox ID="txtDrQualification" runat="server" CssClass="Txtboxlarge" MaxLength="60"
                                                                TabIndex="3" ToolTip="Refering Physician(Doctor) Qualification"></asp:TextBox>
                                                        </td>
                                                        <td runat="server">
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="right" style="width: 25%;">
                                                            Organization Name
                                                        </td>
                                                        <td runat="server" align="left" style="width: 50%;">
                                                            <asp:TextBox ID="txtDrOrganization" runat="server" CssClass="Txtboxlarge" MaxLength="60"
                                                                TabIndex="4" ToolTip="Refering Physician(Doctor) Organization"></asp:TextBox>
                                                        </td>
                                                        <td runat="server">
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="right">
                                                            Sex
                                                        </td>
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddSex" runat="server" CssClass="ddlsmall" TabIndex="5" ToolTip="Select Sex">
                                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                                <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>
                                                            </asp:DropDownList>
                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="right">
                                                            Filter
                                                        </td>
                                                        <td runat="server">
                                                            <input id="txtBX" onkeyup="MyUtil.selectFilter('chklstHsptl', this.value)" tabindex="6"
                                                                type="text" />
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="right" style="width: 25%;">
                                                            Referral Hospital Name
                                                        </td>
                                                        <td runat="server" style="width: 50%;">
                                                            <asp:ListBox ID="chklstHsptl" runat="server" EnableViewState="False" Height="100px"
                                                                onclick="javascript:return SetId(this.id);" ondblClick="javascript:onClick1(this.id);"
                                                                onkeypress="javascript:setItem(event,this);" TabIndex="7" ToolTip="Double Click the List or Press Enter to Select Group"
                                                                Width="300px"></asp:ListBox>
                                                            <asp:HiddenField ID="HdnHospitalID" runat="server" />
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
                                                            <asp:CheckBox ID="chkUserLogin" runat="server" TabIndex="8" Text="Create User Login" />
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
                                                                            Preferred User Name
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtUserName" runat="server" TabIndex="9" Width="135px"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            Password
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtPassword" runat="server" Enabled="False" TabIndex="10" TextMode="Password"
                                                                                Width="135px"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            UserType
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
                                                    <tr runat="server">
                                                        <td runat="server" colspan="3">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server" align="center" colspan="4">
                                                            <asp:Button ID="btnFinish" runat="server" CssClass="btn" OnClick="btnFinish_Click"
                                                                OnClientClick="return validateLabRefPhysicianDetails();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Style="cursor: pointer;" TabIndex="11"
                                                                Text="Save" ToolTip="Click here to Save Refering Physician(Doctor) Details" />
                                                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn" OnClick="btnUpdate_Click"
                                                                OnClientClick="return validateLabRefPhysicianDetails();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Style="cursor: pointer;" Text="Save Changes"
                                                                ToolTip="Click here to Change Refering Physician(Doctor) Details" Visible="False" />
                                                            <asp:Button ID="btnDelete" runat="server" CssClass="btn" OnClick="btnDelete_Click"
                                                                OnClientClick="return validateLabRefPhysicianDetails();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Style="cursor: pointer;" Text="Remove"
                                                                ToolTip="Click here to Remove Refering Physician(Doctor) Details" Visible="False" />
                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClientClick="return popupClose();"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="cursor: pointer;"
                                                                TabIndex="12" Text="Close" ToolTip="Click here to Cancel, View the Home Page" />
                                                        </td>
                                                    </tr>
                                                </table>
                                </input>
                                </input> </input> </td> </tr> </table>
                                <asp:HiddenField ID="hdnSetRefValues" runat="server" />
                                <asp:HiddenField ID="hdnpwdexpdate" runat="server" />
                                <asp:HiddenField ID="hdntranspwdexpdate" runat="server" />
                                </input> </input> </input> </input> </input>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>

    <script language="javascript" type="text/javascript">

        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=chklstHsptl.ClientID %>').id;

        function popupClose() {

            window.opener.SetDDValues(document.getElementById('<%= hdnSetRefValues.ClientID %>').value);
            window.close();
            return false;
        }
       
    </script>

</body>
</html>
