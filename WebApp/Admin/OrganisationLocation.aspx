<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrganisationLocation.aspx.cs"
    EnableEventValidation="false" Inherits="Admin_OrganisationLocation" %>

<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="ucadd" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Organisation Location</title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/style.css" validateRequest="false" enableEventValidation="false"  rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
<%--
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function chngdefault() {
            var code = document.getElementById('drpcentertype').value;
            if (code == "PCS") {
                document.getElementById('<%= chkisdefault.ClientID %>').checked = true; 
            }
            else {
                document.getElementById('<%= chkisdefault.ClientID %>').checked = false; 
            }

        }
    
        function SelectRow(rid, ClientID) {
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
            var objvar33 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_01") == null ? "Provide the HUB code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_01");
            var objvar34 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_02") == null ? "Provide the HUB name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_02");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");

            if (document.getElementById('txthubcode').value == '') {
                //alert('Provide the HUB code');
                ValidationWindow(objvar33, objAlert);
                document.getElementById('txthubcode').focus();
                return false;
            }
            if (document.getElementById('txthubname').value == '') {
                //alert('Provide the HUB name');
                ValidationWindow(objvar34, objAlert);
                document.getElementById('txthubname').focus();
                return false;
            }

           // debugger;

            var flag = 0;

            $('#grddiv01 tbody tr:not(:first)').each(function(i, n) {
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var objvar35 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_03") == null ? "HUB already exist" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_03");

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
                            //alert('HUB already exist');
                            ValidationWindow(AlertMesg, objAlert);

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
                                //alert('HUB already exist');
                                ValidationWindow(AlertMesg, objAlert);
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
            var objvar33 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_01") == null ? "Provide the HUB code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtsearchhubcode').value == '') {
                // alert('Provide the HUB code');
                ValidationWindow(objvar33, objAlert);

                document.getElementById('txtsearchhubcode').focus();
                return false;
            }
        }
        function pcheckitem1() {
            var objvar34 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_02") == null ? "Provide the HUB name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_02");
            var objvar36 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_04") == null ? "Provide the ZONE code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_04");
            var objvar37 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_05") == null ? "Provide the ZONE name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_05");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtmaphub').value == '') {
                //alert('Provide the HUB name');
                ValidationWindow(objvar34, objAlert);

                document.getElementById('txtmaphub').focus();
                return false;
            }
            if (document.getElementById('txtzonecode').value == '') {
                //alert('Provide the ZONE code');
                ValidationWindow(objvar36, objAlert);

                document.getElementById('txtzonecode').focus();
                return false;
            }
            if (document.getElementById('txtzonename').value == '') {
                //alert('Provide the ZONE name');
                ValidationWindow(objvar37, objAlert);

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
                        var objvar38 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_06") == null ? "ZONE already exist" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_06");
                        var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
                        if (flag >= 1 && flag1 == 'match') {
                            //                            alert('ZONE already exist');
                            ValidationWindow(objvar38, objAlert);

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
                                //alert('ZONE already exist');
                                ValidationWindow(objvar38, objAlert);
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
            var objvar36 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_04") == null ? "Provide the ZONE code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtzonecode1').value == '') {
                //                alert('Provide the ZONE code');
                ValidationWindow(objvar36, objAlert);
                document.getElementById('txtzonecode1').focus();
                return false;
            }
        }
        function pcheckitem2() {
            var objvar37 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_05") == null ? "Provide the ZONE name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_05");
            var objvar39 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_07") == null ? "Provide the ROUTE code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_07");
            var objvar40 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_08") == null ? "Provide the ROUTE name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_08");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtmapzone').value == '') {
                //alert('Provide the ZONE name');
                ValidationWindow(objvar37, objAlert);
                document.getElementById('txtmapzone').focus();
                return false;
            }
            if (document.getElementById('txtroutecode').value == '') {
                //alert('Provide the ROUTE code');
                ValidationWindow(objvar39, objAlert);
                document.getElementById('txtroutecode').focus();
                return false;
            }
            if (document.getElementById('txtroutename').value == '') {
                //alert('Provide the ROUTE name');
                ValidationWindow(objvar40, objAlert);

                document.getElementById('txtroutename').focus();
                return false;
            }

            var flag = 0;
            var flag1 = 0;

            $('#grdaddroute tbody tr:not(:first)').each(function(i, n) {
            var objvar41 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_09") == null ? "ROUTE already exist" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_09");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
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
                            // alert('ROUTE already exist');
                            ValidationWindow(objvar41, objAlert);

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
                                //alert('ROUTE already exist');
                                ValidationWindow(objvar41, objAlert);
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
            var objvar39 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_07") == null ? "Provide the ROUTE code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_07");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtroutecode1').value == '') {
                // alert('Provide the ROUTE code');
                ValidationWindow(objvar39, objAlert);

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
        function DisplayTab(tabName) {

            $('#TabsMenu li').removeClass('active');
            if (tabName == 'SPL') {
                document.getElementById('tdmanagelocation').style.display = 'block';
                $('#li1').addClass('active');
                document.getElementById('tdlocalitymaster').style.display = 'none';
            }
            if (tabName == 'CLI') {
                document.getElementById('tdmanagelocation').style.display = 'none';
                $('#li2').addClass('active');
                document.getElementById('tdlocalitymaster').style.display = 'block';
                if (document.getElementById('rdoZone').checked == false && document.getElementById('rdoRoute').checked == false) {
                    document.getElementById('rdoHub').checked = true;
                    document.getElementById('div01').style.display = 'block';
                    document.getElementById('txthubname').value = "";
                    document.getElementById('div02').style.display = 'none';
                    document.getElementById('div03').style.display = 'none';
                }
                else {
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
            }
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
            document.getElementById("btnSaveLocation").value = document.getElementById("hdnsave").value;
            document.getElementById('tOrglocation').style.display = 'None';
            document.getElementById('TgrdOrgLocation').style.display = 'block';
        }
        function ValidateItems() {
           debugger;
            var objvar42 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_10") == null ? "Provide location name" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_10");
            var objvar43 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_11") == null ? "Provide location code" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_11");
            //var objvar44 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_12") == null ? "Already available processing center" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_12");
            var objvar45 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_23") == null ? "Provide Address" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_23");
            var objvar46 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_24") == null ? "Provide City" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_24");
            var objvar47 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_25") == null ? "Provide Mobile or LandLine" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_25");
            var objvar48 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_26") == null ? "Select Center Type" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_26");
            var objvar49 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_27") == null ? "Provide Status" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_27");//new change surya
           
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('txtOrgLocation').value == '') {
                // alert('Provide location name');
                ValidationWindow(objvar42, objAlert);

                document.getElementById('txtOrgLocation').focus();
                return false;
            }
            if (document.getElementById('txtCode').value == '') {
                //alert('Provide location code');
                ValidationWindow(objvar43, objAlert);
                document.getElementById('txtCode').focus();
                return false;
            }
			if (document.getElementById("ucPAdd_txtAddress2").value == "") {
                
                ValidationWindow(objvar45, objAlert);
               
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
                            ValidationWindow(objvar44, objAlert);

                            //alert('Already available processing center');
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
           
            if (document.getElementById("ucPAdd_txtCity").value == "") {
               
                ValidationWindow(objvar46, objAlert);
               
                return false;
            }
            if (document.getElementById("ucPAdd_txtMobile").value == "" && document.getElementById("ucPAdd_txtLandLine").value == "") {
               
                ValidationWindow(objvar47, objAlert);
                
                return false;
            }
            if (document.getElementById('drpcentertype').selectedIndex == 0) {
               
                ValidationWindow(objvar48, objAlert);
                return false;
            }
            if (document.getElementById('ddlstatus').value == 0) {

                ValidationWindow(objvar49, objAlert);
                return false;
            }
        }
        function ValidateCode() {
            var objvar44 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_12") == null ? "Already available processing center" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_12");
            var objAlert = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_Alert");
            if (document.getElementById('hdnLocationCode').value != "") {
                var LocationCode = document.getElementById('hdnLocationCode').value.split("^");
                var txtCode = document.getElementById('txtCode').value;
                var AddID = document.getElementById('hdnAddressID').value;
                for (var i = 0; i < LocationCode.length; i++) {
                    if (LocationCode[i].split('~')[0].toUpperCase() == txtCode.toUpperCase()) {

                        var userMsg = SListForApplicationMessages.Get('Admin\\OrganisationLocation.aspx_1');
                        if (userMsg != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg, objAlert);

                            document.getElementById('drpcentertype').focus();
                            return false;
                        } else {
                        //alert('Already available processing center');
                            //ValidationWindow(objvar44, objAlert);---surya new change on 7 nov2017

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
    <style>
        .btn1,.btn {
            left: 0px !important;
        }
        .w-180-imp{width: 180px !important;}
        .w-8-3-imp{width: 8.3% !important;}
    </style>
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
                                        <table class="w-100p"
                                            <tr>
                                                <td class="a-top" colspan="2">
                                                    <div id='TabsMenu' class="a-left">
                                                        <ul>
                                                            <li id="li1" class="active" onclick="DisplayTab('SPL')"><a href="#"><span><%=Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_07%></span></a></li>
                                                           <%-- <li id="li2" onclick="DisplayTab('CLI')"><a href='#'><span>Locality Master </span></a>--%>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="tdmanagelocation">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-center">
                                                                <div>
                                                                    <asp:Panel ID="pnlAdd" CssClass="dataheader2 w-100p" BorderWidth="1px"
                                                                        runat="server">
                                                                        <div id="divInv" runat="server">
                                                                            <table class="a-left w-100p">
                                                                                <tr>
                                                                                    <td class="v-top">
                                                                                        <table class="w-100p">
                                                                                            <tr>
                                                                                                <td style="width: 171px;">
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_01 %>
                                                                                                </td>
                                                                                                <td class="w-30p">
                                                                                                    <asp:DropDownList ID="ddlOrglocation" runat="server" Width="275px" AutoPostBack="True"
                                                                                                        OnSelectedIndexChanged="ddlOrglocation_SelectedIndexChanged" CssClass="ddlmedium">
                                                                                                    </asp:DropDownList>
                                                                                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                        onmouseout="this.className='btn'" Text=" Add Location" OnClick="btnAdd_Click" meta:resourcekey="btnAddResource1"/>
                                                                                                </td>
                                                                                                <td class="a-left">
                                                                                                    <div id="ExportXL" runat="server"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                        <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                                                                            Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblExportResource1"> </asp:Label>
                                                                                                        &nbsp;&nbsp;&nbsp;
                                                                                                        <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                                                                            meta:resourcekey="imgBtnXLResource1" Style="width: 16px" OnClick="ImageBtnExport_Click" />
                                                                                                    </div>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                        <asp:GridView runat="server" ID="grdExport" Visible="false" AutoGenerateColumns="true">
                                                                                        </asp:GridView>
                                                                                        <div id="TgrdOrgLocation" style="display: none;" runat="server">
                                                                                            <table cellspacing="0" style="border-collapse: collapse; border-color: Black;" id="TgrdOrgLocation1">
                                                                                                <tr>
                                                                                                    <td class="a-center">
                                                                                                        <asp:GridView ID="grdOrgLocation" runat="server" AllowPaging="True"
                                                                                                            CellPadding="4" EmptyDataText="location not exists !!" AutoGenerateColumns="False"
                                                                                                            ForeColor="#333333" PageSize="15" DataKeyNames="AddressID,City,Location,Status,LocationCode"
                                                                                                            OnRowDataBound="grdOrgLocation_RowDataBound" OnRowDeleting="grdOrgLocation_RowDeleting"
                                                                                                            CssClass="mytable1 gridView w-100p" OnRowCommand="grdOrgLocation_RowCommand" OnRowUpdating="grdOrgLocation_RowUpdating"
                                                                                                            OnPageIndexChanging="grdOrgLocation_PageIndexChanging">
                                                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                                                            <Columns>
                                                                                                                <asp:TemplateField HeaderText="AddressID/CCID">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:Label ID="lblId" runat="server" Text='<%#bind("AddressID")%>'> </asp:Label>
                                                                                                                    </ItemTemplate>
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="City" meta:resourcekey="TemplateFieldResource2">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:Label ID="lblCity" runat="server" Text='<%#bind("City")%>' Width="150px"> </asp:Label>
                                                                                                                    </ItemTemplate>
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource3">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location")%>' Width="210px"> </asp:Label>
                                                                                                                    </ItemTemplate>
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Location Code" meta:resourcekey="TemplateFieldResource4">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:Label ID="lblLocationCode" runat="server" Text='<%#Eval("LocationCode")%>' Width="210px"> </asp:Label>
                                                                                                                    </ItemTemplate>
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource5">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status")%>' Width="70px"> 
                                                                                                                        </asp:Label>
                                                                                                                    </ItemTemplate>
                                                                                                                </asp:TemplateField>
                                                                                                                <%-- <asp:TemplateField HeaderText="Center Type">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCenterType" runat="server" Text='<%#Eval("AddressType")%>' Width="150px"> 
                                                                                    </asp:Label>
                                                                                </ItemTemplate>
                                                                                                        </asp:TemplateField>--%>
                                                                                                        <asp:TemplateField HeaderText="Action"  meta:resourcekey="TemplateFieldResource6">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DELETE" ForeColor="#990000"
                                                                                                                    CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Font-Size="12px"><%=Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_02%></asp:LinkButton>
                                                                                                                &nbsp;||&nbsp;
                                                                                                                <asp:LinkButton ID="LinActive" runat="server" CommandName="ACTIVE" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                    ForeColor="Red" Font-Size="12px"> <%=Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_03%></asp:LinkButton>
                                                                                                                &nbsp;||&nbsp;
                                                                                                                <asp:LinkButton ID="LnkEdit" ForeColor="#0000FF" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                    runat="server"  CommandName="UPDATE"><%=Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_04%></asp:LinkButton>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                </asp:GridView>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div id="tOrglocation" style="display: none;" runat="server">
                                                                                    <table class="w-100p" style="border-collapse: collapse; border-color: Black;text-align: left;" id="tOrglocation1">
                                                                                        <tr>
                                                                                         <%--   <td class="w-67p">--%>
                                                                                                <caption>
                                                                                                    &nbsp;
                                                                                                    
                                                                                            </caption>
                                                                                            </tr>
                                                                               <%--surya changes start--%>
                                                                                                                   
                                                                                       <%-- </table>
                                                                                            </td>
                                                                                        </tr>--%>
                                                                                         <tr>
                                                                                            <td class="w-3p a-left" style="width: 171px;">
                                                                                                <asp:Label ID="lblorg" runat="server" meta:Resourcekey="lblorgResource1" 
                                                                                                    Text="Location Name" />
                                                                                            </td>
                                                                                            <td class="w-3p a-left" style="width: 300px;">
                                                                                                <asp:TextBox ID="txtOrgLocation" CssClass="Txtboxmedium" runat="server" Width="150px"> </asp:TextBox>
                                                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            
                                                                                            <td class="w-8-3-imp a-left">
                                                                                                <asp:Label ID="LlblCode" runat="server" Text="Code " Width="59px" meta:Resourcekey="LlblCodeResource1"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                                                            <td class=" a-left">
                                                                                                <asp:TextBox MaxLength="3" ID="txtCode" onchange="javascript:ValidateCode();" CssClass="Txtboxmedium"
																								 runat="server" Width="40px"> </asp:TextBox>
                                                                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                            </td>
                                                                                            <td class="w-20p" rowspan="2">
                                                                                                <table class="w-100p">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <div>
                                                                                                            
                                                                                                                <fieldset>
                                                                                                                    <%--<legend>Browse &amp; Save image in database </legend>--%>
                                                                                                                    <div >
                                                                                                                    <asp:Label CssClass="w-70">Upload Logo :</asp:Label>
                                                                                                                        
                                                                                                                        <asp:FileUpload CssClass="w-180-imp" ID="FileUpload1" runat="server"  />
                                                                                                                    </div>
                                                                                                                   <%-- <div>
                                                                                                                        <asp:Button ID="btnUploadImage" runat="server" Text="Upload" OnClick="btnUploadImage_Click" />
                                                                                                                    </div>--%>
                                                                                                                </fieldset>
                                                                                                                <br />
                                                                                                              <fieldset>
                                                                                                                    <%--<legend>Retrieved image from database </legend>--%>
                                                                                                                    <div>
                                                                                                                        <asp:Image ID="imgProfile" Width="150px" runat="server" Visible="false" />
                                                                                                                        &nbsp;
                                                                                                                    </div>
                                                                                                                </fieldset>
        </div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="4" class="v-top">
                                                                                                <uc10:ucadd ID="ucPAdd" runat="server" />
                                                                </td>
                                                                                                </tr>
                                                                                                <%--   <tr class="dataheaderInvCtrl">
                                                                                                    <td align="center" colspan="2" class="defaultfontcolor">
                                                                                                        <div id="divFooterNav" runat="server">
                                                                                                            <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                                                                            <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                                                            <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                                                                                CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                                                                                                            <asp:Button ID="Btn_Next" runat="server" Text="Next"  CssClass="btn"
                                                                                                                meta:resourcekey="Btn_NextResource1" />
                                                                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                                                            <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                                                                            <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                                                                            <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" 
                                                                                                                meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                                                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>--%>
                                                                                            </table>
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td colspan="2" style="width: 143px;">
                                                                                                    </td>
                                                                                                    <td>
                                                                                                         <asp:Label ID="lblcenterType" runat="server" Text="Center Type" Width="12.2%" meta:Resourcekey="lblcenterTypeResource1" />
                                                                                                            <asp:DropDownList ID="drpcentertype" onchange="chngdefault();" runat="server">
                                                                                                            </asp:DropDownList>
                                                                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                                        </caption>
                                                                                                    </td>
                                                                                </tr>
                                                                                                    <tr>
                                                                                                        <td class="a-left" colspan="3">
                                                                                                        
                                                                                                            <asp:CheckBox ID="ChkIsScanInScanOut" runat="server" Text="IsScanInScanOutRequired" />
                                                                                                            <asp:CheckBox ID="chkismappedclients" runat="server" Text="IsMappedClients" meta:Resourcekey="chkismappedclientsResource1"/>
                                                                                                          <asp:CheckBox ID="chkisdefault" runat="server" Text="IsDefault" />
                                                                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                                            <asp:Label ID="lblstatus1" runat="server" Text=" status"  meta:Resourcekey="lblstatus1Resource1"></asp:Label>
                                                                                                            <asp:DropDownList ID="ddlstatus" runat="server" CssClass="ddl">
                                                                                                            </asp:DropDownList>
                                                                                                              <img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3">
                                                                                                            <table class="dataheader2 defaultfontcolor w-100p">
                                                                                                                <tr>
                                                                                                                    <td align="left" class="colorforcontent a-left h-18 w-80p">
                                                                                                                        <div id="ACX2plusEU" runat="server" style="display: none;">
                                                                                                                            &nbsp;<img class="v-top h-15 w-15 pointer" alt="Show" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);"
                                                                                                                                src="../Images/showBids.gif" />
                                                                                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);">
                                                                                                                                <asp:Label ID="Rs_EditDefaultClientLoc" runat="server" meta:resourcekey="Rs_EditDefaultClientLoc"
                                                                                                                                    Text="Add Default Client Location"></asp:Label>
                                                                                                                            </span>
                                                                                                                        </div>
                                                                                                                        <div id="ACX2minusEU" runat="server" style="display: block;" class="h-18">
                                                                                                                            &nbsp;<img class="v-top h-15 w-15 pointer" alt="hide" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);"
                                                                                                                                src="../Images/hideBids.gif" />
                                                                                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);">
                                                                                                                                <asp:Label ID="Rs_EditDefaultClientLoc1" runat="server" meta:resourcekey="Rs_EditDefaultClientLoc1"
                                                                                                                                    Text="Add Default Client Location"></asp:Label>
                                                                                                                            </span>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr class="a-right">
                                                                                                                    <td style="padding-left: 50px;">
                                                                                                                        <asp:CheckBox ID="ChkselectMappedClient" OnCheckedChanged="loadOnlyMappedClients"
                                                                                                                            AutoPostBack="true" runat="server" ToolTip="Select Only Mapped Clients" />
                                                                                                                        <asp:Label ID="LblViewMappedClient" runat="server" meta:resourcekey="Rs_ViewMappedClientResource1"
                                                                                                                            Text="View Only Mapped Clients"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td id="ACX2responsesEU" runat="server" style="display: table-cell" class="a-center">
                                                                                                                        <table class="dataheader2 defaultfontcolor w-90p" id="NewTbl" runat="server">
                                                                                                                            <tr id="Tr1" runat="server">
                                                                                                                                <td id="Td1" runat="server" class="style1">
                                                                                                                                    <asp:Label ID="Rs_SupplierName" runat="server" meta:resourcekey="Rs_SupplierNameResource1"
                                                                                                                                        Text="Client Name"></asp:Label>
                                                                                                                                </td>
                                                                                                                                <td id="Td2" runat="server">
                                                                                                                                    <asp:TextBox ID="txtClientNameSrch" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                                        MaxLength="20"></asp:TextBox>
                                                                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" CompletionInterval="1"
                                                                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetHospAndRefPhy"
                                                                                                                                        ServicePath="~/WebService.asmx" TargetControlID="txtClientNameSrch" UseContextKey="True">
                                                                                                                                    </ajc:AutoCompleteExtender>
                                                                                                                                </td>
                                                                                                                                <td id="Td8" runat="server">
                                                                                                                                    <asp:Label ID="Rs_TinNo1" runat="server" meta:resourcekey="Rs_TinNo1Resource1" Text="Client Code"></asp:Label>
                                                                                                                                </td>
                                                                                                                                <td id="Td9" runat="server">
                                                                                                                                    <asp:TextBox ID="txtClientCodeSrch" runat="server" CssClass="Txtboxsmall" MaxLength="20"></asp:TextBox>
                                                                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender7" runat="server" CompletionInterval="1"
                                                                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetHospAndRefPhy"
                                                                                                                                        ServicePath="~/WebService.asmx" TargetControlID="txtClientCodeSrch" UseContextKey="True">
                                                                                                                                    </ajc:AutoCompleteExtender>
                                                                                                                                </td>
                                                                                                                                <td id="Td10" runat="server" class="style1 a-center">
                                                                                                                                    <table>
                                                                                                                                        <tr>
                                                                                                                                            <td>
                                                                                                                                                <asp:Button ID="btnSearch" runat="server" CssClass="btn" meta:resourcekey="btnSearchResource1"
                                                                                                                                                    OnClick="btnSearch_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                                                                                                    Text="Search" />
                                                                                                                                            </td>
                                                                                                                                            <td>
                                                                                                                                                <asp:Button ID="btnReset" runat="server" CssClass="btn" meta:resourcekey="btnResetResource1"
                                                                                                                                                    OnClick="btnReset_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                                                                                                    Text="Reset" />
                                                                                                                                            </td>
                                                                                                                                        </tr>
                                                                                                                                    </table>
                                                                                                                                </td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                        <asp:GridView ID="grdResults" runat="server" AllowPaging="true" AutoGenerateColumns="False"
                                                                                                                            CssClass="mytable1 w-80p gridView" EmptyDataText="No Results Found." meta:resourcekey="grdResultsResource1"
                                                                                                                            OnPageIndexChanging="PageIndexChanging" OnRowDataBound="grdResults_RowDataBound">
                                                                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                                                                            <Columns>
                                                                                                                                <asp:TemplateField HeaderText="Select" ItemStyle-Width="10%" meta:resourcekey="TemplateFieldResource15">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:CheckBox ID="Chkselect" runat="server" ToolTip="Select Client" />
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:BoundField DataField="ClientID" HeaderText="Client ID" Visible="false" />
                                                                                                                                <asp:BoundField DataField="ClientCode" HeaderText="Client ID" Visible="false" />
                                                                                                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" ItemStyle-Width="80%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3"/>
                                                                                                                                <asp:TemplateField HeaderText="IsDefaultClient" ItemStyle-Width="10%" meta:resourcekey="TemplateFieldResource1">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:RadioButton ID="rdioSel" runat="server" GroupName="SelectDefaultClient" meta:resourcekey="rdSelResource1"
                                                                                                                                            ToolTip="Select Default Client" />
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                            </Columns>
                                                                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                                                        </asp:GridView>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="a-center" colspan="3">
                                                                                                            <asp:Button ID="btnSaveLocation" runat="server" CssClass="btn1" OnClick="btnsave_Click1"
                                                                                                                OnClientClick="javascript:return ValidateItems();" onmouseout="this.className='btn1'"
                                                                                                                onmouseover="this.className='btn1 btnhov'" Text="Save" meta:Resourcekey="btnSaveLocationResource1"/>
                                                                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn1" OnClick="btnCancel_Click"
                                                                                                                onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov'"
                                                                                                                Text="Cancel" meta:Resourcekey="btnCancelResource1"/>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                            <tr>
                                                <td id="tdlocalitymaster" style="display: none;" class="a-center">
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
                                                                                        <div id="div01" runat="server" style="display: none;">
                                                                                            <table id="Table01" class="dataheader2 defaultfontcolor" width="100%">
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
                                                                                            </table>
                                                                                            <input id="hdnbtnsave" runat="server" type="hidden" />
                                                                                            <table id="Table04" class="dataheader2 defaultfontcolor" width="100%">
                                                                                                <tr>
                                                                                                    <td class="a-right w-25p">
                                                                                                        <asp:Label ID="lblsearchhubcode" runat="server" Text="Hub Code"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-left w-25p">
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
                                                                                            <td class="a-left w-20p">
                                                                                                <asp:Label ID="lblmaphub" runat="server" Text="Hub Name"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="a-left w-20p">
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
                                                                                            <td class="w-20p">
                                                                                                <asp:Label ID="lblzonecode" runat="server" Text="Zone Code"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:TextBox ID="txtzonecode" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:Label ID="lblzonename" runat="server" Text="Zone Name"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:TextBox ID="txtzonename" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td>
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
                                                                                    </table>
                                                                                    <input id="hdnbtnsavezone" runat="server" type="hidden" />
                                                                                    <table id="Table05" class="dataheader2 defaultfontcolor" width="100%">
                                                                                        <tr>
                                                                                            <td class="a-right w-25p">
                                                                                                <asp:Label ID="lblzonecode1" runat="server" Text="Zone Code"></asp:Label>
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:TextBox ID="txtzonecode1" runat="server"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionInterval="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetZoneCode"
                                                                                                    ServicePath="../WebService.asmx" TargetControlID="txtzonecode1">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <asp:HiddenField ID="hdntxtzonecode" runat="server" />
                                                                                            </td>
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:Button ID="btnsearchzone" Text="Search" CssClass="btn1" OnClick="btnsearchzone_OnClick"
                                                                                                    OnClientClick="javascript:return pcheckitem111();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" runat="server" />
                                                                                            </td>
                                                                                        </tr>
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
                                                                                            <td class="a-left w-20p">
                                                                                                <asp:Label ID="lblmapzone" runat="server" Text="Zone Name"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
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
                                                                                            <td class="w-20p">
                                                                                                <asp:Label ID="lblroutecode" runat="server" Text="Route Code"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:TextBox ID="txtroutecode" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:Label ID="lblroutename" runat="server" Text="Route Name"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-20p">
                                                                                                <asp:TextBox ID="txtroutename" onBlur="return ConverttoUpperCase(this.id);" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td>
                                                                                            </td>
                                                                                            <td class="w-25p">
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
                                                                                    </table>
                                                                                    <input id="hdnbtnsaveroute" runat="server" type="hidden" />
                                                                                    <table id="Table06" class="dataheader2 defaultfontcolor" width="100%">
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
                                                                                            <td class="a-left w-25p">
                                                                                                <asp:Button ID="btnsearchroute" Text="Search" CssClass="btn1" OnClick="btnsearchroute_OnClick"
                                                                                                    OnClientClick="javascript:return pcheckitem222();" onmouseout="this.className='btn'"
                                                                                                    onmouseover="this.className='btn btnhov'" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="a-center" colspan="20">
                                                                                                <asp:GridView ID="grdaddroute" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                    CellPadding="1" CellSpacing="1" CssClass="mytable1 girdView w-100p" ForeColor="#333333" OnPageIndexChanging="grdaddroute_PageIndexChanging"
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
                                        <asp:HiddenField ID="hdnsave" runat="server" />
                                        <asp:HiddenField ID="hdnImagevalue" runat="server" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="ImageBtnExport" />
                                        <asp:PostBackTrigger ControlID="btnSaveLocation" />
                                        
                                    </Triggers>
                        </asp:UpdatePanel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <%--<input type="hidden" id="hdnLocationCode" runat="server" />--%>
                        <br />
                    </div>
             
          <asp:HiddenField ID="hdnMessages" runat="server" />
      <Attune:Attunefooter ID="Attunefooter" runat="server" />
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
