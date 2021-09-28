<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvestigationSearchControl.ascx.cs"
    Inherits="CommonControls_InvestigationSearchControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
<script type="text/javascript">
    var total = '';
    function onClick1(id) {

        var type;
        var rate = '';
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');

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
        else if (id == document.getElementById("<%= listLCON.ClientID %>").getAttribute('id')) {
            type = 'LCON';
        }
        else if (id == document.getElementById("<%= listOtherInv.ClientID %>").getAttribute('id')) {
            type = 'INV';
        }

        total = parseFloat(document.getElementById('<%=lblTotal.ClientID %>').innerHTML);
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');

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
            var cell4 = row.insertCell(3);

            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell3.innerHTML = type;
            cell3.style.display = "none";
            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
            cell4.width = "30%";
            document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~Ordered^";
            rate = obj.options[obj.selectedIndex].text.split(':');
            total = parseFloat(rate[1]);
            //alert('total:' + parseFloat(total).toFixed(2));
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
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
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
            cell3.innerHTML = type;
            cell3.style.display = "none";
            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
            cell4.width = "30%";
            document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "~Ordered^";
            rate = obj.options[obj.selectedIndex].text.split(':');
            //alert('rae:' + rate[1]);
            total = parseFloat(total) + parseFloat(rate[1]);
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationSearchControl.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        }
            alert("Investigation Already Added!");
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
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
        var list = HidValue.split('^');
        var minusamt;
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
                        document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(totalAmt).toFixed(2);
                    }
                }

            }
            document.getElementById('<%= iconHid.ClientID %>').value = newInvList;
        }
    }

    function LoadOrdItems() {
        //5331~ANGIOGRAM(CT) -$$: 20.00~INV~Ordered^
        //alert('safas');
        var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;

        var list = HidValue.split('^');
        var total = 0, rate;
        if (document.getElementById('<%=iconHid.ClientID %>').value != "") {
            document.getElementById('<%=lblHeader.ClientID %>').style.display = "block";
            //document.getElementById('tblOrederedInves').innerHTML = '';
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //total = document.getElementById('InvestigationControl1_lblTotal').innerHTML;
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = InvesList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = InvesList[1];
                cell3.innerHTML = InvesList[2];
                cell3.style.display = "none";
                cell4.innerHTML = addPhyFeeList(InvesList[0]);
                cell4.width = "30%";
                if (InvesList[2] == "NEW") {
                    document.getElementById(InvesList[0]).style.display = "none";
                }
                rate = InvesList[1].split(':');
                // alert(rate[1]);
                total = parseFloat(total) + parseFloat(rate[1]);
                document.getElementById('tblTot').style.display = "block";
                if (InvesList[3] == 'paid') {
                    document.getElementById('<%= divPaid.ClientID %>').style.display = "block";
                }
            }
            //  alert('load');
            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
        }
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


    function deselectLists(id) {

        var obj1 = document.getElementById('<%= listINV.ClientID %>');
        var obj2 = document.getElementById('<%= listGRP.ClientID %>');
        var obj3 = document.getElementById('<%= listPKG.ClientID %>');
        var obj4 = document.getElementById('<%= listLCON.ClientID %>');


        //        if (id == document.getElementById("<%= listGRP.ClientID %>").getAttribute('id')) {
        //            if (obj2) { document.getElementById('<%= listGRP.ClientID %>').selectedIndex = 0; }
        //            if (obj3) { document.getElementById('<%= listPKG.ClientID %>').selectedIndex = -1; }
        //            if (obj1) { document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1; }
        //            if (obj4) { document.getElementById('<%= listLCON.ClientID %>').selectedIndex = -1; }
        //        }
        //        else if (id == document.getElementById("<%= listPKG.ClientID %>").getAttribute('id')) {
        //            if (obj3) { document.getElementById('<%= listPKG.ClientID %>').selectedIndex = 0; }
        //            if (obj2) { document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1; }
        //            if (obj1) { document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1; }
        //            if (obj4) { document.getElementById('<%= listLCON.ClientID %>').selectedIndex = -1; }
        //        }
        //        else if (id == document.getElementById("<%= listINV.ClientID %>").getAttribute('id')) {
        //            if (obj1) { document.getElementById('<%= listINV.ClientID %>').selectedIndex = 0; }
        //            if (obj2) { document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1; }
        //            if (obj3) { document.getElementById('<%= listPKG.ClientID %>').selectedIndex = -1; }
        //            if (obj4) { document.getElementById('<%= listLCON.ClientID %>').selectedIndex = -1; }
        //        }
        //        else if (id == document.getElementById("<%= listLCON.ClientID %>").getAttribute('id')) {
        //            if (obj4) { document.getElementById('<%= listLCON.ClientID %>').selectedIndex = 0; }
        //            if (obj2) { document.getElementById('<%= listGRP.ClientID %>').selectedIndex = -1; }
        //            if (obj3) { document.getElementById('<%= listPKG.ClientID %>').selectedIndex = -1; }
        //            if (obj1) { document.getElementById('<%= listINV.ClientID %>').selectedIndex = -1; }
        //        }

    }

    function checkItemsAdded() {
        if (document.getElementById('<%= iconHid.ClientID %>').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\InvestigationSearchControl.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Select Investigation");
            }
            document.getElementById('<%= listINV.ClientID %>').focus();
            document.getElementById('<%= listINV.ClientID %>').selectedIndex = 0;
            return false;
        }
        else {
            return true;
        }
    }
    function SearchList() {

        var l = document.getElementById('<%= listINV.ClientID %>');

        var tb = document.getElementById('<%= listINV.ClientID %>');

        if (tb.value == "") {

            ClearSelection(l);

        }

        else {

            for (var i = 0; i < l.options.length; i++) {

                if (l.options[i].text.toLowerCase().match(tb.value.toLowerCase())) {
                    l.options[i].selected = true;
                    return false;
                }

                else {

                    ClearSelection(l);

                }

            }

        }

    }

    function ClearSelection(lb) {
        lb.selectedIndex = -1;
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
            document.getElementById('txtBX').focus();
        }

        return false;
    }

    
</script>

<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>
        <input type="hidden" id="iconHid" value="" style="width: 50%;" runat="server" />
        <input type="hidden" id="HdnLPF" value="" runat="server" />
        <input type="hidden" id="hidID" value="" runat="server" />
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="w-50p v-top">
                    <table>
                        <tr>
                            <td class="a-left">
                                <asp:Label ID="lblInvestigation" runat="server" Visible="false" Text="Investigation"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <%--<asp:TextBox ID="TextBox1" onkeypress="javascript:setItem(event,InvestigationSearchControl1_listINV);"  runat="server" onkeyup="return SearchList();" /><br />--%>
                                            <b>Filter:</b>
                                            <input type="text" onkeyup="MyUtil.selectFilter('InvestigationSearchControl1_listINV', this.value)"
                                                id="txtBX" /><br>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="listINV" Style="display: none;" ToolTip="Double Click the List or Press Enter to Select Investigation"
                                                runat="server" Width="300px" onfocus="javascript:deselectLists(this.id);" EnableViewState="false"
                                                Height="200px" onclick="javascript:return SetId(this.id);" onkeypress="javascript:setItem(event,this);"
                                                ondblClick="javascript:onClick1(this.id);"></asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblGroup" runat="server" Visible="false" Text="Group"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listGRP" Style="display: none;" runat="server" ToolTip="Double Click the List or Press Enter to Select Group"
                                    onfocus="javascript:deselectLists(this.id);" EnableViewState="false" Width="300px"
                                    Height="100px" onclick="javascript:return SetId(this.id);" onkeypress="javascript:setItem(event,this);"
                                    ondblClick="javascript:onClick1(this.id);"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPackage" runat="server" Visible="false" Text="Package"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listPKG" Style="display: none;" runat="server" ToolTip="Double Click the List or Press Enter to Select Package"
                                    onfocus="javascript:deselectLists(this.id);" EnableViewState="false" Width="300px"
                                    Height="100px" onclick="javascript:return SetId(this.id);" onkeypress="javascript:setItem(event,this);"
                                    ondblClick="javascript:onClick1(this.id);"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLCON" runat="server" Visible="false" Text="Consumables"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listLCON" Style="display: none;" runat="server" ToolTip="Double Click the List or Press Enter to Select Consumables"
                                    onclick="javascript:return SetId(this.id);" onfocus="javascript:deselectLists(this.id);"
                                    Width="300px" Height="100px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);">
                                </asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBloodBank" runat="server" Visible="false" Text="Blood Bank"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listBLB" Style="display: none;" runat="server" ToolTip="Double Click the List or Press Enter to Select Blood"
                                    onfocus="javascript:deselectLists(this.id);" EnableViewState="false" Width="300px"
                                    Height="100px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);">
                                </asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblOtherInv" runat="server" Visible="false" Text="Other Investigations"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listOtherInv" Style="display: none;" runat="server" ToolTip="Double Click the List or Press Enter to Select Blood"
                                    onfocus="javascript:deselectLists(this.id);" EnableViewState="false" Width="300px"
                                    Height="100px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);">
                                </asp:ListBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="v-top">
                    <br />
                    <br />
                    <table class="w-96p">
                        <tr>
                            <td>
                                <asp:Label ID="lblHeader" runat="server" class="ddfonts"> Ordered Investigations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Physician Fee</asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table id="tblOrederedInves" class="dataheaderInvCtrl w-96p">
                    </table>
                    <table id="tblTot" style="display: none" class="dataheaderInvCtrl w-96p">
                        <tr>
                            <td class="w-60p a-right">
                                <asp:Label ID="lblTotaltxt" runat="server" Text="Total Amount :"></asp:Label>
                            </td>
                            <td class="a-right w-36p">
                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                    </table>
                    <table>
                        <div id="divPaid" runat="server" style="display: none;">
                            <asp:Image ImageUrl="../Images/starbutton.png" ID="imgPaid" runat="server" />
                            Amount Paid In Referred Org
                            <asp:Label ID="lblOrg" runat="server"></asp:Label>
                        </div>
                </td>
            </tr>
        </table>
        </td> </tr> </table>
    </ContentTemplate>
</asp:UpdatePanel>

<script language="javascript" type="text/javascript">

    document.getElementById('<%=listINV.ClientID %>').focus();
    document.getElementById('<%=listINV.ClientID %>').selectedIndex = 0;
    document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
    //LoadOrdItems();
</script>

