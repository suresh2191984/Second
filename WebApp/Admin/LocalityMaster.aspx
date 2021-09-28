<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocalityMaster.aspx.cs" Inherits="Admin_LocalityMaster" EnableEventValidation="false" %>

<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="ucPAdd" TagPrefix="Uc10" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Organisation Location</title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/style.css" validateRequest="false" enableEventValidation="false"  rel="stylesheet" type="text/css" />--%>
 <%--   <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>
<%--
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function SelectRow(rid, ClientId) {
            document.getElementById('<%= hdnIsDefaultClientId.ClientID %>').value = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            var text = rid.split('_');
            var Chkid = text[0] + '_' + text[1] + '_Chkselect';
            document.getElementById(Chkid).checked = true;
            SelectClientRow(rid, ClientID);
            document.getElementById('<%= hdnIsDefaultClientId.ClientID %>').value = ClientID;
        }
        function SelectClientRow(rid, ClientID) {
            if (document.getElementById(rid).checked == true) {
            if (document.getElementById('<%= hdnMapClientId.ClientID %>').value == "") {
                    document.getElementById('<%= hdnMapClientId.ClientID %>').value = ClientID;
            }
            else {
                    document.getElementById('<%= hdnMapClientId.ClientID %>').value += '^' + ClientID;
                }
            }
            else {
                var text = rid.split('_');
                var Chkid = text[0] + '_' + text[1] + '_rdioSel';
                document.getElementById(Chkid).checked = false;
                if (document.getElementById('<%= hdnIsDefaultClientId.ClientID %>').value == ClientID) {
                    document.getElementById('<%= hdnIsDefaultClientId.ClientID %>').value = "";
        }
                if (document.getElementById('<%= hdnRemoveClientId.ClientID %>').value == "") {
                    document.getElementById('<%= hdnRemoveClientId.ClientID %>').value = ClientID;
                }
                else {
                    document.getElementById('<%= hdnRemoveClientId.ClientID %>').value += '^' + ClientID;
                }
                if (document.getElementById('<%= hdnMapClientId.ClientID %>').value != "") {
                    var id = document.getElementById('<%= hdnMapClientId.ClientID %>').value.split('^');
                    var len = id.length;
                    for (var i = 0; i < len; i++) {
                        if (id[i] == ClientID) {
                            if (document.getElementById('<%= hdnRemoveClientId.ClientID %>').value == "") {
                                document.getElementById('<%= hdnRemoveClientId.ClientID %>').value = id[i];
                            }
                            else {
                                document.getElementById('<%= hdnRemoveClientId.ClientID %>').value += '^' + id[i];
                            }
                            id[i] = undefined;
                        }
                    }
                    var len1 = id.length
                    document.getElementById('<%= hdnMapClientId.ClientID %>').value = "";
                    for (var i = 0; i < len1; i++) {
                        if (id[i] != undefined) {
                            if (document.getElementById('<%= hdnMapClientId.ClientID %>').value == "") {
                                document.getElementById('<%= hdnMapClientId.ClientID %>').value = id[i];
                            }
                            else {
                                document.getElementById('<%= hdnMapClientId.ClientID %>').value += '^' + id[i];
                            }
                        }
                    }
                }
            }
        }
        function pcheckitem() {
            if (document.getElementById('txthubcode').value == '') {
                alert('Provide the HUB Code');
                document.getElementById('txthubcode').focus();
                return false;
            }
            if (document.getElementById('txthubname').value == '') {
                alert('Provide the HUB Name');
                document.getElementById('txthubname').focus();
                return false;
            }

           // debugger;

            var flag = 0;

            $('#grddiv01 tbody tr:not(:first)').each(function(i, n) {

                var $row = $(n);
                var hdnhubid = $row.find($('input[id$="hdn1HUBID"]')).val();

                if (hdnhubid != undefined) {
                    var HUBID = $("input:hidden[id$=HdnhubID]").val();
                    var HubCode = $row.find($('span[id$="lbl01"]')).html();
                    var HubName = $row.find($('span[id$="lbl02"]')).html();

                    if (HUBID == '') {
                        if (HubCode == $.trim($('#txthubcode').val())) {
                    flag++;
                }
                        else if (HubName == $.trim($('#txthubname').val())) {
                    flag++;
                }

                        if (flag >= 1) {
                    alert('HUB already exist');
                    flag = 'set';
                    return false;
                        }
                    }
                    else {
                        if (hdnhubid != HUBID) {
                            if (HubCode == $.trim($('#txthubcode').val())) {
                                flag++;
                            }
                            else if (HubName == $.trim($('#txthubname').val())) {
                                flag++;
                            }
                            if (flag >= 1) {
                                alert('HUB already exist');
                                flag = 'set';
                                return false;
                            }

                        }

                    }
                }
  
            });
            
            if (flag == 'set') {
                return false;
            }
            
        }
        
        
        function pcheckitem00() {
            if (document.getElementById('txtsearchhubcode').value == '') {
                alert('Provide the HUB Code');
                document.getElementById('txtsearchhubcode').focus();
                return false;
            }
        }
        function pcheckitem1() {
            if (document.getElementById('txtmaphub').value == '') {
                alert('Provide the HUB Name');
                document.getElementById('txtmaphub').focus();
                return false;
            }
            if (document.getElementById('txtzonecode').value == '') {
                alert('Provide the ZONE Code');
                document.getElementById('txtzonecode').focus();
                return false;
            }
            if (document.getElementById('txtzonename').value == '') {
                alert('Provide the ZONE Name');
                document.getElementById('txtzonename').focus();
                return false;
            }

            var flag = 0;
            var flag1 = 0;

            $('#Gridaddzone tbody tr:not(:first)').each(function(i, n) {

                var $row = $(n);
                var hdnzoneid = $row.find($('input[id$="hdn1ZONEID"]')).val();

                if (hdnzoneid != undefined) {
                    var ZONEID = $("input:hidden[id$=hdnzoneid]").val();
                    var ZONECode = $row.find($('span[id$="lbl03"]')).html();
                    var ZONEName = $row.find($('span[id$="lbl04"]')).html();
                    var MapHUBName = $row.find($('span[id$="lblMapHUB"]')).html();

                    if (ZONEID == '') {

                        if (ZONECode == $.trim($('#txtzonecode').val())) {
                            flag++;
                        }
                        if (ZONEName == $.trim($('#txtzonename').val())) {
                            flag++;
                        }
                        if (MapHUBName == $.trim($('#txtmaphub').val())) {
                            flag1 = 'match';
                        }

                        if (flag >= 1 && flag1 == 'match') {
                            alert('ZONE already exist');
                            flag = 'set';
                            flag1 = 'set';
                            return false;
                        }
                    }


                    else {
                        if (hdnzoneid != ZONEID) {
                            if (ZONECode == $.trim($('#txtzonecode').val())) {
                                flag++;
                            }
                            if (ZONEName == $.trim($('#txtzonename').val())) {
                                flag++;
                            }
                            if (MapHUBName == $.trim($('#txtmaphub').val())) {
                                flag1 = 'match';
                            }

                            if (flag >= 1 && flag1 == 'match') {
                                alert('ZONE already exist');
                                flag = 'set';
                                flag1 = 'set';
                                return false;
                            }

                        }

                    }
                }

            });

            if (flag == 'set') {
                return false;
            }
            
            
        }
        function pcheckitem111() {
            if (document.getElementById('txtzonecode1').value == '') {
                alert('Provide the ZONE Code');
                document.getElementById('txtzonecode1').focus();
                return false;
            }
        }
        function pcheckitem2() {
            if (document.getElementById('txtmapzone').value == '') {
                alert('Provide the ZONE Name');
                document.getElementById('txtmapzone').focus();
                return false;
            }
            if (document.getElementById('txtroutecode').value == '') {
                alert('Provide the ROUTE Code');
                document.getElementById('txtroutecode').focus();
                return false;
            }
            if (document.getElementById('txtroutename').value == '') {
                alert('Provide the ROUTE Name');
                document.getElementById('txtroutename').focus();
                return false;
            }

            var flag = 0;
            var flag1 = 0;

            $('#grdaddroute tbody tr:not(:first)').each(function(i, n) {

                var $row = $(n);
                var hdnrouteid = $row.find($('input[id$="hdn1ROUTEID"]')).val();

                if (hdnrouteid != undefined) {
                    var ROUTEID = $("input:hidden[id$=hdnrouteid]").val();
                    var ROUTECode = $row.find($('span[id$="lbl031"]')).html();
                    var ROUTEName = $row.find($('span[id$="lbl041"]')).html();
                    var MapZONEName = $row.find($('span[id$="lblPrntNameZone"]')).html();
                    if (ROUTEID == '') {

                        if (ROUTECode == $.trim($('#txtroutecode').val())) {
                            flag++;
                        }
                        if (ROUTEName == $.trim($('#txtroutename').val())) {
                    flag++;
                }
                        if (MapZONEName == $.trim($('#txtmapzone').val())) {
                            flag1 = 'match';
                        }
                        if (flag >= 1 && flag1 == 'match') {
                            alert('ROUTE already exist');
                            flag = 'set';
                            flag1 = 'set';
                            return false;
                        }
                    }


                    else {
                        if (hdnrouteid != ROUTEID) {
                            if (ROUTECode == $.trim($('#txtroutecode').val())) {
                                flag++;
                            }
                            if (ROUTEName == $.trim($('#txtroutename').val())) {
                                flag++;
                            }
                            if (MapZONEName == $.trim($('#txtmapzone').val())) {
                                flag1 = 'match';
                            }
                            if (flag >= 1 && flag1 == 'match') {
                                alert('ROUTE already exist');
                                flag = 'set';
                                flag1 = 'set';
                                return false;
                            }

                        }

                    }
                }

            });

            if (flag == 'set') {
                return false;
            }
        }
        function pcheckitem222() {
            if (document.getElementById('txtroutecode1').value == '') {
                alert('Provide the ROUTE Code');
                document.getElementById('txtroutecode1').focus();
                return false;
            }
        }
        function extractRow(rid, hubid, hubCode, hubName) {


            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('HdnhubID').value = hubid;
            document.getElementById('txthubcode').value = hubCode;
            document.getElementById('txthubname').value = hubName;
            document.getElementById('<%=btnaddhub.ClientID %>').value = "Update";
            document.getElementById('hdnbtnsave').value = "Update";

        }
        function extractRow1(rid, zoneid, zoneCode, zoneName, parentname, parentid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnzoneid').value = zoneid;
            document.getElementById('txtzonecode').value = zoneCode;
            document.getElementById('txtzonename').value = zoneName;
            document.getElementById('txtmaphub').value = parentname;
            document.getElementById('hdnMapHubID').value = parentid;
            document.getElementById('<%=btnaddzone.ClientID %>').value = "Update";
            document.getElementById('hdnbtnsavezone').value = "Update";

        }
        function extractRow2(rid, routeid, routeCode, routeName, parentname, parentid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnrouteid').value = routeid;
            document.getElementById('txtroutecode').value = routeCode;
            document.getElementById('txtroutename').value = routeName;
            document.getElementById('txtmapzone').value = parentname;
            document.getElementById('hdnMapZoneID').value = parentid;
            document.getElementById('<%=btnaddroute.ClientID %>').value = "Update";
            document.getElementById('hdnbtnsaveroute').value = "Update";

        }
        
        function SelectMaster() {
            if (document.getElementById('rdoHub').checked == true) {
                document.getElementById('div01').style.display = 'block';
                document.getElementById('txthubname').value = "";
                document.getElementById('div02').style.display = 'none';
                document.getElementById('div03').style.display = 'none';

            }
            if (document.getElementById('rdoZone').checked == true) {
                document.getElementById('div01').style.display = 'none';
                document.getElementById('div02').style.display = 'block';
                document.getElementById('txtzonename').value = "";
                document.getElementById('div03').style.display = 'none';

            }
            if (document.getElementById('rdoRoute').checked == true) {
                document.getElementById('div01').style.display = 'none';
                document.getElementById('div02').style.display = 'none';
                document.getElementById('div03').style.display = 'block';
                document.getElementById('txtroutename').value = "";

            }

        }

        function Cancel() {
            document.getElementById('txtOrgLocation').value = '';
            document.getElementById('txtOrgLocation').focus();
            document.getElementById("ucPAdd_txtAddress1").value = '';
            document.getElementById("ucPAdd_txtAddress2").value = '';
            document.getElementById("ucPAdd_txtAddress3").value = '';
            document.getElementById("ucPAdd_txtCity").value = '';
            document.getElementById("ucPAdd_txtMobile").value = '';
            document.getElementById("ucPAdd_txtLandLine").value = '';
            document.getElementById("btnSaveLocation").value = "Save";
            document.getElementById('tOrglocation').style.display = 'None';
            document.getElementById('TgrdOrgLocation').style.display = 'block';
        }
        function ValidateItems() {
            if (document.getElementById('txtOrgLocation').value == '') {
                alert('Provide location name');
                document.getElementById('txtOrgLocation').focus();
                return false;
            }
            if (document.getElementById('txtCode').value == '') {
                alert('Provide location code');
                document.getElementById('txtCode').focus();
                return false;
            }
            if (document.getElementById('hdncenterTypeCode').value != "") {
                var CenterTypecode = document.getElementById('hdncenterTypeCode').value.split("^");
                var LocationCode = document.getElementById('hdnLocationCode').value.split("^");
                var AddID = document.getElementById('hdnAddressID').value;
                var code = document.getElementById('drpcentertype').value;
                for (var i = 0; i < LocationCode.length; i++) {
                   if (LocationCode[i].split('~')[1] == AddID && code == "PCS") {
                      // return true;
                   }
                    if (LocationCode[i].split('~')[1] != AddID) {

                        if (LocationCode[i].split('~')[2] != "" && LocationCode[i].split('~')[2] == "PCS" && code == "PCS") {
//                            var userMsg = SListForApplicationMessages.Get('Admin\\OrganisationLocation.aspx_1');
//                            if (userMsg != null) {
//                                alert(userMsg);
//                                document.getElementById('drpcentertype').focus();
//                                return false;
//                            } else {
                            alert('Already Available Processing Center');
                            document.getElementById('drpcentertype').focus();
                                return false;
                           // }
//                            alert('Already Available Processing Center');
//                            document.getElementById('drpcentertype').focus();
//                            return false;
                       }
                    }
                }
                
                
            }
        }
        function ValidateCode() {
            if (document.getElementById('hdnLocationCode').value != "") {
                var LocationCode = document.getElementById('hdnLocationCode').value.split("^");
                var txtCode = document.getElementById('txtCode').value;
                var AddID = document.getElementById('hdnAddressID').value;
                for (var i = 0; i < LocationCode.length; i++) {
                    if (LocationCode[i].split('~')[0].toUpperCase() == txtCode.toUpperCase()) {

                        var userMsg = SListForApplicationMessages.Get('Admin\\OrganisationLocation.aspx_1');
                        if (userMsg != null) {
                            alert(userMsg);
                            document.getElementById('drpcentertype').focus();
                            return false;
                        } else {
                            alert('Already Available Processing Center');
                            document.getElementById('drpcentertype').focus();
                            return false;
                        }
//                        alert('Code already exists !!');
//                        document.getElementById('txtCode').value = "";
//                        document.getElementById('txtCode').focus();
//                        return false;
                    }
                    if (LocationCode[i].split('~')[1] == AddID) {
                    }
                }
            }
        }
        

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                    <ContentTemplate>
                                    
                                    
                                        <table class="searchPanel w-100p">
                                    <tr>
                                        <td id="tdlocalitymaster"  align="center">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-center">
                                                        <div>
                                                            <asp:Panel ID="panel2" runat="server">
                                                                <div id="div1" runat="server">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <asp:Label ID="lblselect" runat="server" Text="Select One Type: " Font-Bold="True"
                                                                                    meta:resourcekey="lblselectResource1"></asp:Label>
                                                                                <asp:RadioButton ID="rdoHub" GroupName="LocalityMaster" runat="server" Text="HUB"
                                                                                    Checked="true" onclick="javascript:SelectMaster()" />
                                                                                <asp:RadioButton ID="rdoZone" GroupName="LocalityMaster" runat="server" Text="ZONE"
                                                                                    onclick="javascript:SelectMaster()" />
                                                                                <asp:RadioButton ID="rdoRoute" GroupName="LocalityMaster" runat="server" Text="ROUTE"
                                                                                    onclick="javascript:SelectMaster()" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <br />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <div id="div01" runat="server">
                                                                                    <table id="Table01" class="dataheader2 defaultfontcolor w-100p">
                                                                                        <tr>
                                                                                            <td class="a-right w-25p">
                                                                                                <asp:Label ID="lblhubcode" runat="server" Text="Hub Code"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:TextBox ID="txthubcode" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="a-right w-25p">
                                                                                                <asp:Label ID="lblhubname" runat="server" Text="Hub Name"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:TextBox ID="txthubname" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:Button ID="btnaddhub" runat="server" CssClass="btn1" OnClick="btnaddhub_Click"
                                                                                                    OnClientClick="javascript:return pcheckitem();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" Text="ADD" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="style8">
                                                                                                <asp:HiddenField ID="HdnhubID" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="a-right w-25p" colspan="2">
                                                                                                <asp:Label ID="lblsearchhubcode" runat="server" Text="Hub Code"></asp:Label>
                                                                                            </td>
                                                                                            <td class="a-left w-25p" colspan="2">
                                                                                                <asp:TextBox ID="txtsearchhubcode" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetHubCode"
                                                                                                    ServicePath="../WebService.asmx" TargetControlID="txtsearchhubcode">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxthubcode" runat="server" />
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:Button ID="btnsearchhub" runat="server" CssClass="btn1" OnClick="btnsearchhub_OnClick"
                                                                                                    OnClientClick="javascript:return pcheckitem00();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" Text="Search" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <input id="hdnbtnsave" runat="server" type="hidden" />
                                                                                    <table id="Table04" class="dataheader2 defaultfontcolor w-100p">
                                                                                        
                                                                                        <tr>
                                                                                            <td class="a-center" colspan="20">
                                                                                                <asp:GridView ID="grddiv01" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                    CellPadding="1" CellSpacing="1" CssClass="mytable1 w-100p gridView" ForeColor="#333333" OnPageIndexChanging="grddiv01_PageIndexChanging"
                                                                                                    OnRowDataBound="grddiv01_RowDataBound">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="Select">
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:RadioButton ID="rdSel" runat="server" GroupName="OrderSelect" ToolTip="Select Row" />
                                                                                                                        <asp:HiddenField ID="hdn1HUBID" runat="server" Value='<%# Eval("Locality_ID")%>' />
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Hub Code" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl01" runat="server" Text='<%# Eval("Locality_Code")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Hub Name" ItemStyle-Width="40px">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl02" runat="server" Text='<%# Eval("Locality_Value")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                    <RowStyle HorizontalAlign="Left" />
                                                                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                                </asp:GridView>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div id="div02" runat="server" style="display: none;">
                                                                                    <table id="Table02" class="dataheader2 defaultfontcolor w-100p">
                                                                                        <tr>
                                                                                            <td class="a-right w-20p">
                                                                                                <asp:Label ID="lblmaphub" runat="server" Text="Hub Name"></asp:Label>
                                                                                            </td>
                                                                                          
                                                                                            <td wclass="a-left w-20p">
                                                                                                <asp:TextBox ID="txtmaphub" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetHubName"
                                                                                                            ServicePath="../WebService.asmx" TargetControlID="txtmaphub" OnClientItemSelected="MapHubNameandID">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxtmaphubname" runat="server" />
                                                                                                        <asp:HiddenField ID="hdnMapHubID" runat="server" />
                                                                                            </td>
                                                                                            <td class="w-20p a-right">
                                                                                                <asp:Label ID="lblzonecode" runat="server" Text="Zone Code"></asp:Label>
                                                                                            </td>
                                                                                           
                                                                                            <td class="w-20p a-left">
                                                                                                <asp:TextBox ID="txtzonecode" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p a-right">
                                                                                                <asp:Label ID="lblzonename" runat="server" Text="Zone Name"></asp:Label>
                                                                                            </td>
                                                                                           
                                                                                            <td class="w-20p">
                                                                                                <asp:TextBox ID="txtzonename" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                           
                                                                                            <td class="w-25p">
                                                                                                <asp:Button ID="btnaddzone" runat="server" CssClass="btn1" OnClick="btnaddzone_Click"
                                                                                                    OnClientClick="javascript:return pcheckitem1();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" Text="ADD" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="style8">
                                                                                                <asp:HiddenField ID="hdnzoneid" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="a-right w-25p">
                                                                                                <asp:Label ID="lblzonecode1" runat="server" Text="Zone Code"></asp:Label>
                                                                                            </td>
                                                                                            <td class="a-left w-25p" colspan="2">
                                                                                                <asp:TextBox ID="txtzonecode1" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetZoneCode"
                                                                                                    ServicePath="../WebService.asmx" TargetControlID="txtzonecode1">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxtzonecode" runat="server" />
                                                                                            </td>
                                                                                            <td class="a-left w-25p" colspan="6">
                                                                                                <asp:Button ID="btnsearchzone" Text="Search" CssClass="btn1" OnClick="btnsearchzone_OnClick"
                                                                                                    OnClientClick="javascript:return pcheckitem111();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <input id="hdnbtnsavezone" runat="server" type="hidden" />
                                                                                    <table id="Table05" class="dataheader2 defaultfontcolor w-100p">
                                                                                        
                                                                                        <tr>
                                                                                            <td class="a-center" colspan="20">
                                                                                                <asp:GridView ID="Gridaddzone" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                    CellPadding="1" CellSpacing="1" CssClass="mytable1 w-100p gridView" ForeColor="#333333" OnPageIndexChanging="Gridaddzone_PageIndexChanging"
                                                                                                    OnRowDataBound="Gridaddzone_RowDataBound">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="Select">
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:RadioButton ID="rdSel1" runat="server" GroupName="OrderSelect" ToolTip="Select Row" />
                                                                                                                        <asp:HiddenField ID="hdn1ZONEID" runat="server" Value='<%# Eval("Locality_ID")%>' />
                                                                                                                        <asp:HiddenField ID="hdnMapHubID" runat="server" Value='<%# Eval("ParentID")%>' />
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="HUB Name" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblMapHUB" runat="server" Text='<%# Eval("ParentName")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Zone Code" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl03" runat="server" Text='<%# Eval("Locality_Code")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Zone Name" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl04" runat="server" Text='<%# Eval("Locality_Value")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                    <RowStyle HorizontalAlign="Left" />
                                                                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                                </asp:GridView>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div id="div03" runat="server" style="display: none;">
                                                                                    <table id="Table03" class="dataheader2 defaultfontcolor w-100p">
                                                                                        <tr>
                                                                                            <td class="a-right w-20p">
                                                                                                <asp:Label ID="lblmapzone" runat="server" Text="Zone Name"></asp:Label>
                                                                                            </td>
                                                                                           <td class="w-20p a-left">
                                                                                                <asp:TextBox ID="txtmapzone" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetZoneName"
                                                                                                            ServicePath="../WebService.asmx" TargetControlID="txtmapzone" OnClientItemSelected="MapZONENameandID">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxtmapzonename" runat="server" />
                                                                                                        <asp:HiddenField ID="hdnMapZoneID" runat="server" />
                                                                                            </td>
                                                                                            <td class="w-20p a-right">
                                                                                                <asp:Label ID="lblroutecode" runat="server" Text="Route Code"></asp:Label>
                                                                                            </td>
                                                                                           
                                                                                            <td class="w-20p a-left">
                                                                                                <asp:TextBox ID="txtroutecode" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                           
                                                                                            <td class="w-20p a-right">
                                                                                                <asp:Label ID="lblroutename" runat="server" Text="Route Name"></asp:Label>
                                                                                            </td>
                                                                                          
                                                                                            <td class="w-20p a-left">
                                                                                                <asp:TextBox ID="txtroutename" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:Button ID="btnaddroute" runat="server" CssClass="btn1" OnClick="btnaddroute_Click"
                                                                                                    OnClientClick="javascript:return pcheckitem2();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" Text="ADD" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="style8">
                                                                                                <asp:HiddenField ID="hdnrouteid" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="a-right w-25p">
                                                                                                <asp:Label ID="lblroutecode1" runat="server" Text="Route Code"></asp:Label>
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:TextBox ID="txtroutecode1" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetRouteCode"
                                                                                                    ServicePath="../WebService.asmx" TargetControlID="txtroutecode1">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxtroutecode" runat="server" />
                                                                                            </td>
                                                                                            <td class="a-left w-25p" colspan="3">
                                                                                                <asp:Button ID="btnsearchroute" Text="Search" CssClass="btn1" OnClick="btnsearchroute_OnClick"
                                                                                                    OnClientClick="javascript:return pcheckitem222();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <input id="hdnbtnsaveroute" runat="server" type="hidden" />
                                                                                    <table id="Table06" class="dataheader2 defaultfontcolor w-100p">
                                                                                        
                                                                                        <tr>
                                                                                            <td class="a-center" colspan="20">
                                                                                                <asp:GridView ID="grdaddroute" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                    CellPadding="1" CellSpacing="1" CssClass="mytable1 gridView w-100p" ForeColor="#333333" OnPageIndexChanging="grdaddroute_PageIndexChanging"
                                                                                                    OnRowDataBound="grdaddroute_RowDataBound">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="Select">
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:RadioButton ID="rdSel3" runat="server" GroupName="OrderSelect" ToolTip="Select Row" />
                                                                                                                        <asp:HiddenField ID="hdn1ROUTEID" runat="server" Value='<%# Eval("Locality_ID")%>' />
                                                                                                                        <asp:HiddenField ID="hdnMapZoneID" runat="server" Value='<%# Eval("ParentID")%>' />
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="ZONE Name" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblPrntNameZone" runat="server" Text='<%# Eval("ParentName")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Route Code" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl031" runat="server" Text='<%# Eval("Locality_Code")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Route Name" ItemStyle-Width="40px">
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lbl041" runat="server" Text='<%# Eval("Locality_Value")%>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                    <RowStyle HorizontalAlign="Left" />
                                                                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                                </asp:GridView>
                                                                                            </td>
                                                                                        </tr>
                                                                                            </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnLocationCode" runat="server" Value="" />
                                <asp:HiddenField ID="hdnAddressID" runat="server" Value="" />
                                   <asp:HiddenField ID="hdncenterTypeCode" runat="server" Value=""/>
                                        <asp:HiddenField ID="hdnIsDefaultClientId" runat="server" Value="" />
                                        <asp:HiddenField ID="hdnMapClientId" runat="server" Value="" />
                                        <asp:HiddenField ID="hdnRemoveClientId" runat="server" Value="" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <%--<input type="hidden" id="hdnLocationCode" runat="server" />--%>
                        <br />
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />          
          <asp:HiddenField ID="hdnMessages" runat="server" />
<%--    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
    <%-- <asp:HiddenField ID="hdntxtmaphubcode" runat="server" Value="0" OnValueChanged="hdntxtmaphubcode_ValueChanged" />--%>
    </form>
</body>
</html>
<script type="text/javascript">

    function MapHubNameandID(source, eventArgs) {

        var txtMapHubName = eventArgs.get_text();
        var txtMapHubID1 = eventArgs.get_value().split('~');
        var txtMapHubID = txtMapHubID1[1];
        document.getElementById('<%= txtmaphub.ClientID %>').value = txtMapHubName;
        document.getElementById('<%= hdnMapHubID.ClientID %>').value = txtMapHubID;

    }

    function MapZONENameandID(source, eventArgs) {
        var txtMapZoneName = eventArgs.get_text();
        var txtMapZoneID1 = eventArgs.get_value().split('~');
        var txtMapZoneID = txtMapZoneID1[1];
        document.getElementById('<%= txtmapzone.ClientID %>').value = txtMapZoneName;
        document.getElementById('<%= hdnMapZoneID.ClientID %>').value = txtMapZoneID;

    }
</script>


