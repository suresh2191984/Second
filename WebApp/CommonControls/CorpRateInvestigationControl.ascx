<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CorpRateInvestigationControl.ascx.cs" Inherits="CommonControls_CorpRateInvestigationControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="AddNewInvestigation.ascx" TagName="AddInvestigation" TagPrefix="AddnewInv" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script type="text/javascript">
    ////debugger;
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
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";
                rate = obj.options[obj.selectedIndex].text.split(':');

                total = Number(chkIsnumber(rate[1]));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
                AddStatus = 2;
                document.getElementById('tblTot').style.display = "block";
            }
            if (AddStatus == 0) {
                document.getElementById('<%= lblHeader.ClientID %>').style.display = 'block';
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";
                rate = obj.options[obj.selectedIndex].text.split(':');
                total = format_number(chkIsnumber(total), 2);
                total = Number(total) + Number(chkIsnumber(rate[1]));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpRateInvestigationControl.ascx_1');
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
                        var totalAmt = parseFloat(chkIsnumber(document.getElementById('<%= lblTotal.ClientID %>').innerHTML)) - parseFloat(chkIsnumber(Minusamount[1]));
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
        var total = 0;  //parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);
        total = format_number(chkIsnumber(total), 2);
        document.getElementById('InvestigationControl1_lblTotal').innerHTML = '';
        //alert(document.getElementById('<%= iconHid.ClientID %>').value);
        if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
            document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {
                //            document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);
                }
            }
            for (var count = 0; count < list.length - 1; count++) {
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
                //rate = format_number(chkIsnumber(rate), 2);
                total = Number(total) + Number(chkIsnumber(rate[1]));
                document.getElementById('tblTot').style.display = "table"

                //                total = format_number(chkIsnumber(total), 2);
                //                total = Number(total) + Number(chkIsnumber(rate[1]));
                //                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
            }
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = format_number(total, 2);
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
    function Validation1() {
        if (document.getElementById('<%= txtINV.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpRateInvestigationControl.ascx_2');
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

        //document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
        if (ID != document.getElementById('<%= hidID.ClientID %>').value) {
            //alert(document.getElementById('<%= hidID.ClientID %>').value);
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

<%--<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>--%>
<asp:HiddenField ID="iconHid" runat="server" />
<input type="hidden" id="HdnLPF" value="" runat="server" />
<input type="hidden" id="hidID" value="" runat="server" />
<table class="w-100p">
    <tr>
        <td class="v-top">
            <table>
                <tr>
                    <td>
                        <AddnewInv:AddInvestigation ID="AddNewInvestigation1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblGroup" runat="server" Visible="False" Text="Group" meta:resourcekey="lblGroupResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--  <td style="display:none" nowrap="nowrap">
                                
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtGroup" Visible="false" Width="150px" runat="server" autocomplete="off"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname" runat="server" TargetControlID="txtGroup"
                                            ServiceMethod="getgrpInvList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                            MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp1" CompletionInterval="10"
                                            DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:Button ID="btnAdd" Visible="false" runat="server" Text="Add" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnAdd_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>--%>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Filter" runat="server" Text="Filter:" Font-Bold="True" meta:resourcekey="Rs_FilterResource1"></asp:Label>
                        <input type="text" onkeyup="MyUtil.selectFilter('InvestigationControl1_listINV', this.value)"
                            id="txtBX" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listGRP" Visible="False" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="350px" Height="150px" onblur="javascript:return SetId(this.id);" onclick="javascript:return SetId(this.id);"
                            meta:resourcekey="listGRPResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPackage" runat="server" Visible="False" Text="Package" meta:resourcekey="lblPackageResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listPKG" Style="display: none;" CssClass="h-100" runat="server"
                            onfocus="javascript:deselectLists(this.id);" Width="350px" onclick="javascript:return SetId(this.id);"
                            meta:resourcekey="listPKGResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLCON" runat="server" Visible="False" Text="Consumables" meta:resourcekey="lblLCONResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listLCON" Visible="False" CssClass="h-100" runat="server" ToolTip="Double click the list or press Enter key to select consumables"
                            onfocus="javascript:deselectLists(this.id);" Width="350px" onclick="javascript:return SetId(this.id);"
                            meta:resourcekey="listLCONResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblBloodBank" runat="server" Visible="False" Text="Blood Bank" meta:resourcekey="lblBloodBankResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listBLB" CssClass="h-100" Style="display: none;" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="350px" onclick="javascript:return SetId(this.id);" meta:resourcekey="listBLBResource1">
                        </asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-left">
                        <asp:Label ID="lblInvestigation" runat="server" Visible="False" Text="Investigation"
                            meta:resourcekey="lblInvestigationResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="display: none" class="a-left">
                        <asp:UpdatePanel ID="up2" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtINV" Visible="False" CssClass="small" runat="server" autocomplete="off"
                                    meta:resourcekey="txtINVResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtINV"
                                    ServiceMethod="getIndInvList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;
                                <asp:Button ID="btnInvAdd" Visible="False" runat="server" Text="Add" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnInvAdd_Click"
                                    meta:resourcekey="btnInvAddResource1" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr style="display: none;">
                                <td>
                                    <asp:Label ID="lblSearchInves" runat="server" Text="Investigation search" meta:resourcekey="lblSearchInvesResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtsearch" runat="server" CssClass="small" OnTextChanged="txtsearch_TextChanged"
                                        meta:resourcekey="txtsearchResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnsearch" Text="search" runat="server" OnClick="btnsearch_Click"
                                        meta:resourcekey="btnsearchResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ListBox ID="listINV" EnableViewState="False" Visible="False" runat="server"
                                        Width="350px" onfocus="javascript:deselectLists(this.id);" Height="200px" onclick="javascript:return SetId(this.id);"
                                        onkeypress="javascript:setItem(event,this);" meta:resourcekey="listINVResource1">
                                    </asp:ListBox>
                                    <%--<ajc:ListSearchExtender ID="ListSearchExtender1" PromptPosition="Bottom" QueryPattern="StartsWith"
                                                runat="server" TargetControlID="listINV" PromptCssClass="ListSearchExtenderPrompt"
                                                IsSorted="false">
                                            </ajc:ListSearchExtender>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td class="v-top">
            <br />
            <br />
            <table id="Table1" class="w-96p">
                <tr>
                    <td>
                        <asp:Label ID="lblHeader" runat="server" Text="Ordered Investigations" Style="display: none;"
                            CssClass="Duecolor font12 v-middle padding5" meta:resourcekey="lblHeaderResource1"></asp:Label>
                    </td>
                </tr>
            </table>
            <table id="tblOrederedInves" class="dataheaderInvCtrl w-100p">
            </table>
            <table id="tblTot" style="display: none" class="dataheaderInvCtrl w-100p">
                <tr>
                    <td class="a-right w-60p">
                        <asp:Label ID="lblTotaltxt" runat="server" Text="Total Amount: " meta:resourcekey="lblTotaltxtResource1"></asp:Label>
                    </td>
                    <td class="a-right w-36p">
                        <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="ISAddItems" runat="server" />
<asp:HiddenField ID="hdnFromDate" Value='<%= DateTime.Now %>' runat="server" />
<%-- </ContentTemplate>
</asp:UpdatePanel>--%>

<script language="javascript" type="text/javascript">
    //LoadOrdItems();
    if (document.getElementById('<%= hidID.ClientID %>') != null && document.getElementById('<%=listINV.ClientID %>') != null) {
        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
        document.getElementById('<%=listINV.ClientID %>').selectedIndex = 0;
        SetId(document.getElementById('<%= hidID.ClientID %>').value);
    }
</script>

