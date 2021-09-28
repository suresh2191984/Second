<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvestigationControl1.ascx.cs"
    Inherits="CommonControls_InvestigationControl1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">
    ////debugger;
    
    function ShowAlertMsg(key) {
        
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else
            {
            alert('Investigation already added!');
            return false ;
            }
           return true;
        }
    function checkIt(evt) {
        evt = (evt) ? evt : window.event
        var charCode = (evt.which) ? evt.which : evt.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            status = "This field accepts numbers only."
            return false
        }
        status = ""
        return true
    }

    function onClick1(id, hdnID) {

        var type;
        var AddStatus = 0;
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');

        if (id == document.getElementById("<%= listGRP.ClientID %>").getAttribute('id')) {
            type = 'GRP';
        }
        else if (id == document.getElementById("<%= listPKG.ClientID %>").getAttribute('id')) {
            type = 'PKG';
        }
        else if (id == document.getElementById("<%= listINV.ClientID %>").getAttribute('id')) {
            type = 'INV';
        }
        else if (id == document.getElementById("<%= listBLB.ClientID %>").getAttribute('id')) {
            type = 'BLB';
        }

        total = parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);

        if (document.getElementById(hdnID).value == "") {
            var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
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
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                cell4.innerHTML = "<input type='text' value='0' id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='GetInvCount(" + row.id + ",this.value);' />";
                var value = document.getElementById('txt').value;
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~txt" + row.id + "~" + value + "^";
                rate = obj.options[obj.selectedIndex].text.split(':');
                total = Number(chkIsnumber(rate[1]));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
                AddStatus = 2;
                document.getElementById('tblTot').style.display = "none";

            }
            if (AddStatus == 0) {
                document.getElementById('<%= lblHeader.ClientID %>').style.display = 'block';
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                cell4.innerHTML = "<input type='text' value='0' id='txt' onkeypress='return ValidateOnlyNumeric(this);' onblur='GetInvCount(" + row.id + ",this.value);' />";
                var value = document.getElementById('txt').value;
                //alert(document.getElementById('txt').value);
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~txt" + row.id + "~" + value + "^";
                rate = obj.options[obj.selectedIndex].text.split(':');
                total = format_number(chkIsnumber(total), 2);
                total = Number(total) + Number(chkIsnumber(rate[1]));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl1.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Investigation Already Added!"); }
            }

            if (id == document.getElementById('<%= listGRP.ClientID %>')) {
                document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1;
            }
            else if (id == document.getElementById('<%= listINV.ClientID %>')) {
                document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1;
            }
        }
        else {
            var AmountVal = 0;
            var amtsplit = new Array();
            amtsplit = obj.options[obj.selectedIndex].text.split('<%= CurrencyName %>');
            if (amtsplit.length > 1) {
                AmountVal = amtsplit[1].split(':')[1];
            }
            if (id == document.getElementById(id.split('_')[0] + '_' + 'listGRP').getAttribute('id')) {
                type = 'GRP';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listPKG').getAttribute('id')) {
                type = 'PKG';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listINV').getAttribute('id')) {
                type = 'INV';
            }
            else if (id == document.getElementById(id.split('_')[0] + '_' + 'listBLB').getAttribute('id')) {
                type = 'BLB';
            }

            CmdAddBillItemsType_onclick(type, obj.options[obj.selectedIndex].value, 0, obj.options[obj.selectedIndex].text.split('<%=CurrencyName %>')[0], 1, AmountVal, AmountVal);
        }
        document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1;
        document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1;

    }

    function GetInvCount(obj, value) {
        var x = '';
        document.getElementById('<%= tempHid.ClientID %>').value = "";
        var list = document.getElementById('<%= iconHid.ClientID %>').value.split('^');
        // alert(list);
        for (var count = 0; count < list.length - 1; count++) {
            var InvesList = list[count].split('~');
            //            alert(InvesList[0]);
            //            alert(obj);
            if (InvesList != "") {

                if (InvesList[0] == obj) {
                    //InvesList[4] = value;
                    // alert(InvesList[0]);
                    x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + value + '^';
                    // alert(x);
                }
                else {
                    document.getElementById('<%= tempHid.ClientID %>').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + InvesList[4] + '^';
                    //alert(document.getElementById('<%= tempHid.ClientID %>').value);                 

                    //alert(document.getElementById('<%= tempHid.ClientID %>').value);
                }
            }
            //document.getElementById('<%= tempHid.ClientID %>').value += x;
        }
        document.getElementById('<%= iconHid.ClientID %>').value = "";
        document.getElementById('<%= iconHid.ClientID %>').value = document.getElementById('<%= tempHid.ClientID %>').value;
        document.getElementById('<%= iconHid.ClientID %>').value += x;
    }

    function ImgOnclick(ImgID) {
        //alert(document.getElementById(ImgID).innerHTML);
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');
        var newInvList = '';
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != ImgID) {
                        newInvList += list[count] + '^';
                    }
                    else {
                        var Minusamount = InvesList[1].split(':')
                        var totalAmt = parseFloat(document.getElementById('<%= lblTotal.ClientID %>').innerHTML) - parseFloat(Minusamount[1]);
                        totalAmt = format_number(chkIsnumber(totalAmt), 2);
                        document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(totalAmt).toFixed(2);
                    }
                }
            }
            document.getElementById('<%= iconHid.ClientID %>').value = newInvList;

        }
    }
    function addPhyFeeList(invID) {
        var HdnLPF = document.getElementById('InvestigationControl1_HdnLPF').value;
        var LPFlist = HdnLPF.split('^');

        if (document.getElementById('InvestigationControl1_HdnLPF').value != "") {

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
    function LoadOrdItems() {
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');
        var total = parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);
        total = format_number(chkIsnumber(total), 2);

        //alert(document.getElementById('<%= iconHid.ClientID %>').value);
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";
            for (var count = 0; count < list.length - 1; count++) {
                //            alert(
                var InvesList = list[count].split('~');
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = InvesList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = InvesList[1];
                cell3.innerHTML = InvesList[2];
                cell3.style.display = "none";
                rate = InvesList[1].split(':');
                total = format_number(chkIsnumber(total), 2);
                rate = format_number(chkIsnumber(rate), 2);
                total = parseFloat(total) + parseFloat(rate[1]);
                document.getElementById('tblTot').style.display = "none"
            }
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
        }

    }

    //    function setItem(e, ctl) {

    //        var key = window.event ? e.keyCode : e.which;
    //        if (key == 13) {
    //            onClick1(ctl.id);
    //        }

    //    }
    //    function deselectLists(id) {

    //        //        if (id == "InvestigationControl1_listGRP") {
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;
    //        //        }
    //        //        else if (id == "InvestigationControl1_listPKG") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;

    //        //        }
    //        //        else if (id == "InvestigationControl1_listINV") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listBLB').selectedIndex = -1;

    //        //        }
    //        //        else if (id == "InvestigationControl1_listBLB") {
    //        //            document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1;
    //        //            document.getElementById('InvestigationControl1_listINV').selectedIndex = -1;

    //        //        }
    //    }

    function Validation() {
        if (document.getElementById('<%= txtGroup.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl1.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter Group Investigation");
            }
            document.getElementById('<%= txtGroup.ClientID %>').focus();
            return false;
        }
        //        else {
        //            //var id1 = document.getElementById('<%= listGRP.ClientID %>');
        //            var id1 = 'InvestigationControl1_listGRP';
        //            alert(id1);
        //            onClickAdd(id1);
        //        }
        return true;
    }

    function Validation1() {
        if (document.getElementById('<%= txtINV.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationControl1.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Enter Investigation Name");
            }
            document.getElementById('<%= txtINV.ClientID %>').focus();
            return false;
        }
        return true;
    }
    function setItem(e, ctl, SecID) {

        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClick1(ctl.id, SecID);
        }
    }
    function deselectLists(id) {
        var obj1 = document.getElementById('InvestigationControl1_listINV');
        var obj2 = document.getElementById('InvestigationControl1_listGRP');
        var obj3 = document.getElementById('InvestigationControl1_listPKG');
        var obj4 = document.getElementById('InvestigationControl1_listLCON');

        if (id == "InvestigationControl1_listGRP") {
            //if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = 0; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listPKG") {
            //if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listINV") {
            //if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
        }
        else if (id == "InvestigationControl1_listLCON") {
            // if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = 0; }
            if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
            if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
            if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
        }
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
                    //alert("hai")
                    list.add(o);
                }
                else {
                    //alert("httt")
                    list.add(o, null);
                }
            }
        }
    }

    function SetId(ID) {

        if (ID != document.getElementById('<%= hidID.ClientID %>').value) {
            MyUtil.selectFilter(document.getElementById('<%= hidID.ClientID %>').value, '');
            document.getElementById('<%= hidID.ClientID %>').value = ID;
            document.getElementById('txtBX').value = '';
            //document.getElementById('txtBX').focus();
        }
        else {
            document.getElementById('txtBX').value = '';
            //document.getElementById('txtBX').focus();
        }
        return false;
    }
    
</script>

<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>
        <asp:HiddenField ID="iconHid" runat="server" />
        <asp:HiddenField ID="tempHid" runat="server" />
        <input type="hidden" id="HdnLPF" runat="server" />
        <input id="hidID" runat="server" type="hidden"></input>
        <table class="w-100p">
            <tr>
                <td class=v-top">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblGroup" runat="server" meta:resourcekey="lblGroupResource1" Text="Group"
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" style="display: none">
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtGroup" runat="server" autocomplete="off" meta:resourcekey="txtGroupResource1"
                                            Visible="False" Width="150px"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname" runat="server" BehaviorID="AutoCompleteExLstGrp1"
                                            CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                            Enabled="True" MinimumPrefixLength="2" ServiceMethod="getgrpInvList" ServicePath="~/WebService.asmx"
                                            TargetControlID="txtGroup">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:Button ID="btnAdd" runat="server" CssClass="btn" meta:resourcekey="btnAddResource1"
                                            OnClick="btnAdd_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            Text="Add" Visible="False" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>
                                    <asp:Label ID="Rs_Filter" runat="server" meta:resourcekey="Rs_FilterResource1" Text="Filter:"></asp:Label>
                                </b>
                                <input id="txtBX" onkeyup="MyUtil.selectFilter('InvestigationControl1_listINV', this.value)"
                                    type="text" /><br></br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listGRP" runat="server" Height="150px" meta:resourcekey="listGRPResource1"
                                    onblur="javascript:return SetId(this.id);" onclick="javascript:return SetId(this.id);"
                                    onfocus="javascript:deselectLists(this.id);" Visible="False" Width="350px"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPackage" runat="server" meta:resourcekey="lblPackageResource1"
                                    Text="Package" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listPKG" runat="server" Height="100px" meta:resourcekey="listPKGResource1"
                                    onclick="javascript:return SetId(this.id);" onfocus="javascript:deselectLists(this.id);"
                                    Style="display: none;" Width="350px"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLCON" runat="server" meta:resourcekey="lblLCONResource1" Text="Consumables"
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listLCON" runat="server" Height="100px" meta:resourcekey="listLCONResource1"
                                    onclick="javascript:return SetId(this.id);" onfocus="javascript:deselectLists(this.id);"
                                    ToolTip="Double Click the List or Press Enter to Select Consumables" Visible="False"
                                    Width="350px"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBloodBank" runat="server" meta:resourcekey="lblBloodBankResource1"
                                    Text="Blood Bank" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listBLB" runat="server" Height="100px" meta:resourcekey="listBLBResource1"
                                    onclick="javascript:return SetId(this.id);" onfocus="javascript:deselectLists(this.id);"
                                    Style="display: none;" Width="350px"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left">
                                <asp:Label ID="lblInvestigation" runat="server" meta:resourcekey="lblInvestigationResource1"
                                    Text="Investigation" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left" nowrap="nowrap" style="display: none">
                                <asp:UpdatePanel ID="up2" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtINV" runat="server" autocomplete="off" meta:resourcekey="txtINVResource1"
                                            Visible="False" Width="150px"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" BehaviorID="AutoCompleteExLstInv2"
                                            CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                            Enabled="True" MinimumPrefixLength="2" ServiceMethod="getIndInvList" ServicePath="~/WebService.asmx"
                                            TargetControlID="txtINV">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:Button ID="btnInvAdd" runat="server" CssClass="btn" meta:resourcekey="btnInvAddResource1"
                                            OnClick="btnInvAdd_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            Text="Add" Visible="False" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr style="display: none;">
                                        <td>
                                            <asp:Label ID="lblSearchInves" runat="server" meta:resourcekey="lblSearchInvesResource1"
                                                Text="Investigation search"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtsearch" runat="server" meta:resourcekey="txtsearchResource1"
                                                OnTextChanged="txtsearch_TextChanged"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnsearch" runat="server" meta:resourcekey="btnsearchResource1" OnClick="btnsearch_Click"
                                                Text="search" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:ListBox ID="listINV" runat="server" Height="200px" meta:resourcekey="listINVResource1"
                                                onclick="javascript:return SetId(this.id);" onfocus="javascript:deselectLists(this.id);"
                                                onkeypress="javascript:setItem(event,this);" Visible="False" Width="350px"></asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="v-top">
                    <table id="Table1" class="w-96p">
                        <tr>
                            <td>
                                <asp:Label ID="lblHeader" runat="server" CssClass="Duecolor padding5 font12" meta:resourcekey="lblHeaderResource1"
                                    Style="display: none;" Text="Ordered Investigations &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Quantity"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table id="tblOrederedInves" class="dataheaderInvCtrl w-96p">
                    </table>
                    <table id="tblTot" class="dataheaderInvCtrl w-96p" style="display: none">
                        <tr>
                            <td class="a-right w-60p">
                                <asp:Label ID="lblTotaltxt" runat="server" meta:resourcekey="lblTotaltxtResource1"
                                    Text="Total Amount :"></asp:Label>
                            </td>
                            <td class="a-right w-36p">
                                <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="ISAddItems" runat="server" />
        <asp:HiddenField ID="hdnFromDate" runat="server" Value="<%= DateTime.Now %>" />
    </ContentTemplate>
</asp:UpdatePanel>

<script language="javascript" type="text/javascript">
    LoadOrdItems();
    document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
    if (document.getElementById('<%=listINV.ClientID %>').style.visibility == "visible") {
        document.getElementById('<%=listINV.ClientID %>').focus();
    }

    document.getElementById('<%=listINV.ClientID %>').selectedIndex = 0;
    SetId(document.getElementById('<%= hidID.ClientID %>').value);
</script>

