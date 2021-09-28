<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MergeForm.aspx.cs" Inherits="Reception_MergeForm"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%--Merge Form--%><%=Resources.Reception_ClientDisplay.Reception_MergeForm_aspx_001 %>
    </title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--    <script type="text/javascript" src="../Scripts/jquery.min.js" />--%>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>

    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        function callParent(obj, chkMerge) {
            $('input[id^="chkMerge"]').attr('disabled', false);
            if ($(obj).attr('checked')) {
                $(chkMerge).attr('disabled', true);
                $(chkMerge).attr('checked', false);
                var Count = $('[id$="tblPhysician"] tbody tr').length;
                for (var i = 1; i < Count; i++) {
                    var rad = "radioParent" + i;
                    var chck = "chkPermanent" + i;
                    if (document.getElementById(rad).checked == true) {
                        $('input[id^=' + chck + ']').attr('disabled', false);
                    }
                    else {
                        $('input[id^=' + chck + ']').attr('disabled', true);
                    }
                }
            }
        }

        function callRegType(obj, chkPermanent) {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_01") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_01") : "Are you sure in making the doctor permanent??";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reception_MergeForm_aspx_02") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_02") : "Are you sure in making the doctor temporary??";
            if ($(obj).attr('checked')) {
                //alert("Are you sure in making the doctor permanent??");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                $('#hdnRegPhysicianType').val('P');
            }
            else {
                //alert("Are you sure in making the doctor temporary??");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                $('#hdnRegPhysicianType').val('T');
            }

        }
        function ClearTextboxes() {
            document.getElementById('txtFDate').value = '';
            document.getElementById('txtTDate').value = '';
            document.getElementById('txtRefPhyName').value = '';
            document.getElementById('mergeDiv').style.display = 'none';
            $('#tblPhysician tr:not(:first)').remove();
            var Button = document.getElementById('btnMerge');
            Button.style.display = 'none';
            $('[id$="hdnSelectionList"]').val('');
        }
        function ClearTextboxesUnmerge() {
            document.getElementById('TxtBSm').value = '';
            document.getElementById('TxtBSml').value = '';
            document.getElementById('txtUnMergePhysician').value = '';
            document.getElementById('Unmerge').style.display = 'none';
            $('#tblUnMergePhysician tr:not(:first)').remove();
            var Button = document.getElementById('btnUnMerge');
            Button.style.display = 'none';
            $('[id$="hdnUnMergePhysicianList"]').val('');
        }
        function ClearValues() {
            document.getElementById('txtFDate').value = '';
            document.getElementById('txtTDate').value = '';
            document.getElementById('TxtBSm').value = '';
            document.getElementById('TxtBSml').value = '';
        }
        function DisplayTab(tabName) {
            $('#TabsMenu li').removeClass('active');
            $('.divTab').attr("style", "display:none");
            switch (tabName) {
                case 'divReferingPhysician':
                    $('#li1').addClass('active');
                    $('#divReferingPhysician').attr("style", "display:block");
                    ClearTextboxesUnmerge();
                    $('#tblUnMergePhysician').remove();
                    break;
                case 'divPatient':
                    $('#li2').addClass('active');
                    $('#divPatient').attr("style", "display:block");
                    ClearTextboxes();
                    $('#tblPhysician').remove();
                    break;
            }
        }
        function SetUniqueRadioButton(nameregex, current) {
            re = new RegExp(nameregex);
            for (i = 0; i < document.forms[0].elements.length; i++) {
                elm = document.forms[0].elements[i]
                if (elm.type == 'radio') {
                    if (re.test(elm.name)) {
                        elm.checked = false;
                    }
                }
            }
            current.checked = true;
        }


        function AddButtonClickItem(State) {
            try {
                var oNameValueCollection = [];
                var CategoryList = [];
                if (State == 'UnMerged') {
                    CategoryList = JSON.parse($('#hdnListcollections').val());
                    if (CategoryList != '' && CategoryList.length > 0) {
                        $.each(CategoryList, function(i, obj) {
                            oNameValueCollection.push({
                                ReferingPhysicianID: obj.ReferingPhysicianID,
                                ConsultantName: obj.ConsultantName,
                                Qualification: obj.Qualification,
                                PhysicianCode: obj.PhysicianCode,
                                ContactNumber: obj.ContactNumber,
                                EmailID: obj.EmailID,
                                OrganisationName: obj.OrganisationName,
                                Address: obj.Address,
                                VisitType: obj.VisitType

                            });
                        });
                        AddToTable(oNameValueCollection);
                    }
                }
                else {
                    CategoryList = JSON.parse($('#hdnListcollections').val());
                    if (CategoryList != '' && CategoryList.length > 0) {
                        //                        var ListArray = [];
                        $.each(CategoryList, function(i, obj) {
                            //                            ListArray = CategoryList[0].Description.split('~');
                            //                            obj.ParentPhyisicianName = ListArray[10]
                            oNameValueCollection.push({
                                ParentPhysicianName: obj.RefphysicianName,
                                ReferingPhysicianID: obj.ReferingPhysicianID,
                                ConsultantName: obj.ConsultantName,
                                Qualification: obj.Qualification,
                                PhysicianCode: obj.PhysicianCode,
                                ContactNumber: obj.ContactNumber,
                                EmailID: obj.EmailID,
                                OrganisationName: obj.OrganisationName,
                                Address: obj.Address

                            });
                        });
                        AddToTableForUnMerge(oNameValueCollection)
                    }
                }
            }
            catch (e) {
                return false;
            }
        }

        function MergePhysicianSelected(source, eventArgs) {
            $('[id$="txtRefPhyName"]').val(eventArgs.get_text());
            $('[id$="hdnSelectionList"]').val(eventArgs.get_value());
        }
        function UnMergePhysicianSelected(source, eventArgs) {
            $('[id$="txtUnMergePhysician"]').val(eventArgs.get_text());
            $('[id$="hdnUnMergePhysicianList"]').val(eventArgs.get_value());
        }
        function validateMerge() {

            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_03") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_03") : "Select Physician from list";
            if ($.trim($("#txtRefPhyName").val()) == '') {
                alert('Enter physician name');
                $("#txtRefPhyName").focus();
                return false;
            }
            else {
                if ($.trim($("#hdnSelectionList").val()) != '') {
                    AddPhysicianForMerge();
                }
                else {
                    //alert('Select Physician from list');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    ClearMergePageControls();
                    return false;
                }
            }
        }
        function validateUnMerge() {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_03") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_03") : "Select Physician from list";
            
            if ($.trim($("#txtUnMergePhysician").val()) == '') {
                alert('Enter physician name');
                $("#txtUnMergePhysician").focus();
                return false;
            }
            else {
                if ($.trim($("#hdnUnMergePhysicianList").val()) != '') {
                    AddPhysicianForUnMerge();
                }
                else {
                    //alert('Select Physician from list');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    ClearUnMergePageControls();
                    return false;
                }
            }
        }
        function AddPhysicianForMerge() {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_04") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_04") : "Already added to list";
	
            try {
                var newDataSet = '';
                var PhysicianID = 0;
                var PhyName = '';
                var Qual = '';
                var PhyCode = '';
                var CNumber = '';
                var EID = '';
                var OrgName = '';
                var Add = '';

                var ListArray = [];
                ListArray = $('[id$="hdnSelectionList"]').val().split('~');
                PhysicianID = ListArray[0];
                PhyName = ListArray[9];
                Qual = ListArray[2];
                PhyCode = ListArray[3];
                CNumber = ListArray[4];
                EID = ListArray[5];
                OrgName = ListArray[6];
                Add = ListArray[7];
                VisitType = ListArray[11];

                Exists = false
                var oNameValueCollection = [];
                $('[id$="tblPhysician"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var tbRefPhyID = currentRow.find("span[id$='RefPhyID']").html();
                    if ($.trim(tbRefPhyID) == PhysicianID) {
                        //alert('Already added to list');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        ClearMergePageControls();
                        Exists = true;
                    }
                });

                if (!Exists) {
                    oNameValueCollection.push({
                        ReferingPhysicianID: PhysicianID,
                        ConsultantName: PhyName,
                        Qualification: Qual,
                        PhysicianCode: PhyCode,
                        ContactNumber: CNumber,
                        EmailID: EID,
                        OrganisationName: OrgName,
                        Address: Add,
                        VisitType: VisitType
                    });
                    AddToTable(oNameValueCollection);
                    ClearMergePageControls();
                }
            }
            catch (e) {
                return false;
            }
        }
        function AddPhysicianForUnMerge() {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_04") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_04") : "Already added to list";
	
            try {
                var newDataSet = '';
                var PhysicianID = 0;
                var PhyName = '';
                var Qual = '';
                var PhyCode = '';
                var CNumber = '';
                var EID = '';
                var OrgName = '';
                var Add = '';
                var ParentPhyisicianName = '';
                var ListArray = [];
                ListArray = $('[id$="hdnUnMergePhysicianList"]').val().split('~');
                PhysicianID = ListArray[0];
                PhyName = ListArray[9];
                Qual = ListArray[2];
                PhyCode = ListArray[3];
                CNumber = ListArray[4];
                EID = ListArray[5];
                OrgName = ListArray[6];
                Add = ListArray[7];
                ParentPhyisicianName = ListArray[10];
                Exists = false
                var oNameValueCollection = [];
                $('[id$="tblUnMergePhysician"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var tbRefPhyID = currentRow.find("span[id$='RefPhyID']").html();
                    if ($.trim(tbRefPhyID) == PhysicianID) {
                        // alert('Already added to list');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        ClearUnMergePageControls();
                        Exists = true;
                    }
                });

                if (!Exists) {
                    oNameValueCollection.push({
                        ParentPhysicianName: ParentPhyisicianName,
                        ReferingPhysicianID: PhysicianID,
                        ConsultantName: PhyName,
                        Qualification: Qual,
                        PhysicianCode: PhyCode,
                        ContactNumber: CNumber,
                        EmailID: EID,
                        OrganisationName: OrgName,
                        Address: Add
                    });
                    AddToTableForUnMerge(oNameValueCollection);
                    ClearUnMergePageControls();
                }
            }
            catch (e) {
                return false;
            }
        }
        function ClearMergePageControls() {
            $("#txtRefPhyName").val("");
            $("#hdnSelectedPhysicianID").val("0");
            $("#hdnRegPhysicianType").val("");
            $("#txtRefPhyName").focus();
            $("#hdnSelectionList").val("");
        }
        function ClearUnMergePageControls() {
            $("#txtUnMergePhysician").val("");
            $("#hdnUnMergePhysicianID").val("0");
            $("#txtUnMergePhysician").focus();
            $("#hdnUnMergePhysicianList").val("");
        }
        function AddToTable(oNameValueCollection) {
            try {
                var DataTable = [];
                DataTable = oNameValueCollection;
                $.each(DataTable, function(i, obj) {
                    var rowCount = $('[id$="tblPhysician"] tbody tr').length;
                    dtTR = $('<tr/>');
                    var chkMergeID = "chkMerge" + rowCount;
                    var chkPermanentID = "chkPermanent" + rowCount;
                    var chkParentID = "radioParent" + rowCount;
                    var chkParent = '<input id="radioParent' + rowCount + '" type="radio" value="e" name="rb" onclick="callParent(this,' + chkMergeID + ')" />';
                    var tdID = $('<td style="display:none;"class="w-5p"/>').html("<span id='RefPhyID'>" + obj.ReferingPhysicianID + " </span>");
                    var tdName = $('<td  style="display:table-cell;"class="w-15p a-center"/>').html("<span id='RefPhyName'>" + obj.ConsultantName + " </span>");
                    var tdQua = $('<td  style="display:table-cell;" class="w-5p a-center"/>').html("<span id='Qua'>" + obj.Qualification + " </span>");
                    var tdPhyCode = $('<td  style="display:table-cell;" class="w-5p a-center"/>').html("<span id='PhyCode'>" + obj.PhysicianCode + " </span>");
                    var tdConNumber = $('<td  style="display:table-cell;" class="w-10p a-center"/>').html("<span id='ConNumber'>" + obj.ContactNumber + " </span>");
                    var tdEmail = $('<td  style="display:table-cell;" class="w-10p a-center"/>').html("<span id='Email'>" + obj.EmailID + " </span>");
                    var tdOrgName = $('<td  style="display:table-cell;" class="w-15p a-center"/>').html("<span id='OrgName'>" + obj.OrganisationName + " </span>");
                    var tdAdd = $('<td  style="display:table-cell;" class="w-25p a-center"/>').html("<span id='Addr'>" + obj.Address + " </span>");
                    var chkMerge = '<input id="' + chkMergeID + '" type="checkbox" value="e" name="rb1" />';
                    var chkPermanent = '<input id="' + chkPermanentID + '" type="checkbox" value="e" name="rb2" onclick="callRegType(this,' + chkPermanentID + ')"/>';
                    var tdParentAction = $('<td style="display:table-cell;" class="w-5p a-center">').html(chkParent);
                    var tdChildAction = $('<td style="display:table-cell;" class="w-25p a-center">').html(chkMerge);
                    var tdRegType = $('<td style="display:table-cell;" class="w-25p a-center">').html(chkPermanent);
                    var tdClose = $('</td>');
                    dtTR.append(tdParentAction).append(tdClose).append(tdID).append(tdName).append(tdQua).append(tdPhyCode).append(tdConNumber).append(tdEmail).append(tdOrgName).append(tdAdd).append(tdChildAction).append(tdRegType).append(tdClose);
                    $('[id$="tblPhysician"] tbody').append(dtTR);
                    $('[id$="pnlPhysicianResult"]').show();
                    $('[id$="trMerge"]').show();
                    document.getElementById('mergeDiv').style.display = 'block';
                    var Button = document.getElementById('btnMerge');
                    Button.style.display = 'block';
                    if (obj.VisitType == 'P') {
                        document.getElementById("" + chkPermanentID + "").checked = true;
                    }
                });
            }
            catch (e) {
                return false;
            }
        }
        function AddToTableForUnMerge(oNameValueCollection) {
            try {
                var DataTable = [];
                DataTable = oNameValueCollection;
                $.each(DataTable, function(i, obj) {
                    var rowCount = $('[id$="tblUnMergePhysician"] tbody tr').length;
                    dtTR = $('<tr/>');
                    var chkMergeID = "chkMerge" + rowCount;
                    var tdParentAction = $('<td style="display:table-cell;"class="w-5p"/>').html("<span id='ParentRefPhyName'>" + obj.ParentPhysicianName + " </span>");
                    var tdID = $('<td style="display:none;"class="w-5p"/>').html("<span id='RefPhyID'>" + obj.ReferingPhysicianID + " </span>");
                    var tdName = $('<td  style="display:table-cell;"class="w-15p a-center"/>').html("<span id='RefPhyName'>" + obj.ConsultantName + " </span>");
                    var tdQua = $('<td  style="display:table-cell;" class="w-5p a-center"/>').html("<span id='Qua'>" + obj.Qualification + " </span>");
                    var tdPhyCode = $('<td  style="display:table-cell;" class="w-5p a-center"/>').html("<span id='PhyCode'>" + obj.PhysicianCode + " </span>");
                    var tdConNumber = $('<td  style="display:table-cell;" class="w-10p a-center"/>').html("<span id='ConNumber'>" + obj.ContactNumber + " </span>");
                    var tdEmail = $('<td  style="display:table-cell;" class="w-10p a-center"/>').html("<span id='Email'>" + obj.EmailID + " </span>");
                    var tdOrgName = $('<td  style="display:table-cell;" class="w-15p a-center"/>').html("<span id='OrgName'>" + obj.OrganisationName + " </span>");
                    var tdAdd = $('<td  style="display:table-cell;" class="w-25p a-center"/>').html("<span id='Addr'>" + obj.Address + " </span>");
                    var chkMerge = '<input id="' + chkMergeID + '" type="checkbox" value="e" name="rb1" />';
                    var tdChildAction = $('<td style="display:table-cell;"class="w-25p">').html(chkMerge);
                    var tdClose = $('</td>');
                    dtTR.append(tdParentAction).append(tdID).append(tdName).append(tdQua).append(tdPhyCode).append(tdConNumber).append(tdEmail).append(tdOrgName).append(tdAdd).append(tdChildAction).append(tdClose);
                    $('[id$="tblUnMergePhysician"] tbody').append(dtTR);
                    $('[id$="pnlUnMergePhy"]').show();
                    $('[id$="trUnMerge"]').show();
                    document.getElementById('Unmerge').style.display = 'block';
                    var Button = document.getElementById('btnUnMerge');
                    Button.style.display = 'block';
                });
            }
            catch (e) {
                return false;
            }
        }
        function GenerateMergeData() {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reception_MergeForm_aspx_05") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_05") : "Select Parent Physician";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reception_MergeForm_aspx_06") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_06") : "Select Child Physician to Merge";
            var chkParentChecked = "", chkChildCheced = "";
            var lstDatas = [];
            var ParentRefPhysicianID = 0;
            var RefPhysicianType = "";
            if ($('#tblPhysician tr').length > 1) {
                $('#tblPhysician tr:not(:first)').each(function(i, n) {
                    $row = $(n);

                });
                $('table [id$="tblPhysician"] input[type=radio]:checked').each(function() {
                    ParentRefPhysicianID = $(this).closest("tr").find("span[id$='RefPhyID']").html();
                    $('#hdnSelectedPhysicianID').val(ParentRefPhysicianID);
                });
                $('table [id$="tblPhysician"] input[type=checkbox]:checked').each(function() {
                    var ChildRefPhysicianID = $(this).closest("tr").find("span[id$='RefPhyID']").html();
                    lstDatas.push({
                        RefPhysicianID: ChildRefPhysicianID
                    });
                });


                if (Number(ParentRefPhysicianID) == 0) {
                    //alert('Select Parent Physician');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    if (lstDatas.length > 0)
                        $('#hdnSelectedPhysicianList').val(JSON.stringify(lstDatas));
                    else {
                        // alert('Select Child Physician to Merge');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        return false;
                    }
                }
            }
        }
        function GenerateUnMergeData() {
            var AlrtWinHdr = SListForAppMsg.Get("Reception_AddressBook_aspx_02") != null ? SListForAppMsg.Get("Reception_AddressBook_aspx_02") : "Alert";
           
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reception_MergeForm_aspx_06") != null ? SListForAppMsg.Get("Reception_MergeForm_aspx_06") : "Select Child Physician to Merge";
           
            var chkParentChecked = "", chkChildCheced = "";
            var lstDatas = [];
            var ParentRefPhysicianID = 0;
            if ($('#tblUnMergePhysician tr').length > 1) {
                $('#tblUnMergePhysician tr:not(:first)').each(function(i, n) {
                    $row = $(n);

                });
                $('table [id$="tblUnMergePhysician"] input[type=checkbox]:checked').each(function() {
                    var ChildRefPhysicianID = $(this).closest("tr").find("span[id$='RefPhyID']").html();
                    lstDatas.push({
                        RefPhysicianID: ChildRefPhysicianID
                    });
                });
                if (lstDatas.length > 0)
                    $('#hdnSelectedUnMergePhysician').val(JSON.stringify(lstDatas));
                else {
                    //alert('Select Child Physician to Merge');
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
            }
        }
        function clearPageControlsValue() {
            $('id$="hdnListcollections"').val("");
            $('id$="hdnSelectedPhysicianID"').val("0");
            $('id$="hdnRegPhysicianType"').val("");
            $('id$="hdnSelectionList"').val("");
            $('id$="hdnUnMergePhysicianID"').val("0");
            $('id$="hdnUnMergePhysicianList"').val("0");
            $('id$="hdnSelectedUnMergePhysician"').val("");
            $('id$="hdnSelectedPhysicianList"').val("");
            $('[id$="pnlPhysicianResult"]').hide();
            $('[id$="trMerge"]').hide();
            $('[id$="pnlUnMergePhy"]').hide();
            $('[id$="trUnMerge"]').hide();
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdtPnlTOD" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <div id='TabsMenu' align="left">
                                <ul>
                                    <li id="li1" class="active" onclick="DisplayTab('divReferingPhysician')"><a href='#'>
                                        <span><%--Merge--%>	
	<%=Resources.Reception_ClientDisplay.Reception_MergeForm_aspx_002 %> </span></a></li>
                                    <li id="li2" onclick="DisplayTab('divPatient')"><a href='#'><span><%--Un Merge--%><%=Resources.Reception_ClientDisplay.Reception_MergeForm_aspx_003 %> </span></a></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
                <div id="divReferingPhysician" style="display: block;" runat="server" class="divTab">
                    <table class="searchPanel">
                        <tr>
                            <td>
                                <table cellpadding="4" class="dataheader2 defaultfontcolor w-100p searchPanel" id="tblRefPhysician">
                                    <tr>
                                        <td class="Duecolor a-left" colspan="5">
                                            &nbsp;&nbsp;<asp:Label ID="lblRefHeader" Text="Refering Physician Merge" runat="server"
                                                meta:resourcekey="lblRefHeaderResource1" />
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="a-left  w-100p">
                                                <tr>
                                                    <td class="w-3p">
                                                        <asp:Label ID="Rs_Date" Text="From Date:" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-5p">
                                                        <asp:TextBox ID="txtFDate" CssClass="small" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                            PopupButtonID="ImgFDate" Enabled="True" />
                                                        <%--<asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />--%>
                                                    </td>
                                                    <td class="w-3p">
                                                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-2p">
                                                        <asp:TextBox ID="txtTDate" CssClass="small" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                            PopupButtonID="ImgTDate" Enabled="True" />
                                                        <%--<asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />--%>
                                                    </td>
                                                    <td class="w-12p">
                                                        <asp:Button ID="btnReferingPhySearch" CssClass="btn" runat="server" Text="Submit"
                                                            OnClick="btnReferingPhySearch_Click" meta:resourcekey="btnReferingPhySearchResource1"  />
                                                        <input id="btnReset" value="Clear" type="button" class="btn" onclick="javascript:ClearTextboxes();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%-- <tr>
                                    <td colspan="5" class="colorforcontent" height="15px" width="100%">
                                        <div style="display: block;" id="ACX2plusMVitals">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);">
                                                <asp:Label ID="Rs_Options" Text="More Options" runat="server"></asp:Label></span>
                                        </div>
                                        <div style="display: none; height: 18px;" id="ACX2minusMVitals">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);">
                                                <asp:Label ID="Rs_Options1" Text="Less Options" runat="server"></asp:Label>
                                            </span>
                                        </div>
                                    </td>
                                </tr>--%>
                                </table>
                                <table class="dataheader2 defaultfontcolor w-100p">
                                    <tr id="ACX2responsesMVitals" style="display: table-row;" class="tablerow">
                                        <td class="a-left w-10p">
                                            <asp:Label ID="lblRefPhyName" runat="server" Text="Physician Name/Code" meta:resourcekey="lblRefPhyNameResource1"></asp:Label>
                                        </td>
                                        <td class="a-left w-5p">
                                            <asp:TextBox ID="txtRefPhyName" autocomplete="off" onfocus="javascript:ClearValues();SetContextkeyforPhyMerge();"
                                                ToolTip="Refering Physician(Doctor) Name" CssClass="Txtboxsmall" runat="server"  
												meta:resourcekey="txtRefPhyNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtRefPhyName"
                                                OnClientShown="DocPopM" UseContextKey="True" Enabled="True" FirstRowSelected="true"
                                                ServiceMethod="GetMergePhysicianPatient" ServicePath="~/WebService.asmx" CompletionSetCount="10"
                                                EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoRname" CompletionInterval="10"
                                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="MergePhysicianSelected">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td style="display: none;">
                                            <asp:Label ID="lblRefContactNumber" runat="server" Text="Contact Number" meta:resourcekey="lblRefContactNumberResource1"></asp:Label>
                                        </td>
                                        <td style="display: none;">
                                            <asp:TextBox ID="txtRefContact" onfocus="javascript:SetContextkeyforPhyMerge();"
                                                runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtRefContactResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtRefContact"
                                                FirstRowSelected="true" ServiceMethod="GetMergePhysicianPatient" ServicePath="~/WebService.asmx"
                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteExtender1"
                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                OnClientItemSelected="MergePhysicianSelected">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left">
                                            <input id="btnAddPhysician" value="Add" type="button" class="btn" onclick="javascript:validateMerge();" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5">
                                            <asp:Panel runat="server" ID="pnlPhysicianResult" Style="display: none;" meta:resourcekey="pnlPhysicianResultResource1">
                                                <div class="dataheaderInvCtrl" id="mergeDiv" runat="server">
                                                    <table id="tblPhysician" class="dataheaderInvCtrl w-100p font12" style="font-family: Tahoma;
                                                        display: block;" runat="server">
                                                        <thead id="theaderContent">
                                                            <tr class="dataheader1">
                                                                <th class="w-5p" scope="col">
                                                                    <asp:Label ID="Rs_ParentPhy" runat="server" Text="Primary Physician"></asp:Label>
                                                                </th>
                                                                <th style="display: none;" class="w-5p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_PhysicianID" Text="Physician ID" />
                                                                </th>
                                                                <th class="w-15p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_PhysicianName" Text="Physician Name" />
                                                                </th>
                                                                <th class="w-5p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_Qulatification" Text="Qualification" />
                                                                </th>
                                                                <th class="w-5p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_PhysicianCode" Text="Physician Code" />
                                                                </th>
                                                                <th class="w-10p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_ContactNumber" Text="Contact Number" />
                                                                </th>
                                                                <th class="w-10p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_Email" Text="Email" />
                                                                </th>
                                                                <th class="w-15p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_OrgName" Text="Organisation Name" />
                                                                </th>
                                                                <th class="w-25p" scope="col">
                                                                    <asp:Label runat="server" ID="Rs_Addrss" Text="Address" />
                                                                </th>
                                                                <th class="w-25p" scope="col">
                                                                    <asp:Label ID="Rs_MergeChildPhy" runat="server" Text="Merge Physician"></asp:Label>
                                                                </th>
                                                                <th class="w-25p" scope="col">
                                                                    <asp:Label ID="Rs_RegisterationType" runat="server" Text="Permanent"></asp:Label>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tBodyContent">
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr id="trMerge" runat="server" style="display: none;">
                                        <td colspan="5" class="a-center">
                                            <asp:Button ID="btnMerge" runat="server" Text="Merge" CssClass="btn" OnClientClick="return GenerateMergeData();"
                                                OnClick="btnMerge_Click" meta:resourcekey="btnMergeResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divPatient" runat="server" style="display: none;" class="divTab">
                    <table class="searchPanel">
                        <tr>
                            <td>
                                <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table1">
                                    <tr>
                                        <td class="Duecolor a-left" colspan="5">
                                            &nbsp;&nbsp;<asp:Label ID="Label1" Text="Refering Physician Un Merge" runat="server"
                                                meta:resourcekey="Label1Resource1" />
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="a-left w-100p">
                                                <tr>
                                                    <td class="w-4p">
                                                        <asp:Label ID="FrmLbl" Text="From Date:" runat="server" meta:resourcekey="FrmLblResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-5p">
                                                        <asp:TextBox ID="TxtBSm" CssClass="small" runat="server" meta:resourcekey="TxtBSmResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtenderFd" Format="dd/MM/yyyy" runat="server"
                                                            TargetControlID="TxtBSm" PopupButtonID="ImgFDate" Enabled="True" />
                                                        <%--<asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />--%>
                                                    </td>
                                                    <td class="w-3p">
                                                        <asp:Label ID="ToLbl" Text="To Date :" runat="server" meta:resourcekey="ToLblResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-2p">
                                                        <asp:TextBox ID="TxtBSml" CssClass="small" runat="server" meta:resourcekey="TxtBSmlResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtenderTd" Format="dd/MM/yyyy" runat="server"
                                                            TargetControlID="TxtBSml" PopupButtonID="ImgTDate" Enabled="True" />
                                                        <%--<asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />--%>
                                                    </td>
                                                    <td class="w-12p">
                                                        <asp:Button ID="btnReferingPhySearchUn" CssClass="btn" runat="server" Text="Submit"
                                                            OnClick="btnReferingPhySearchUn_Click" meta:resourcekey="btnReferingPhySearchUnResource1" />
                                                        <input id="btnCt" value="Clear" type="button" class="btn" onclick="javascript:ClearTextboxesUnmerge();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table class="dataheader2 defaultfontcolor w-100p searchPanel">
                                    <tr id="Tr1" style="display: table-row;" class="tablerow">
                                        <td class="a-left w-13p">
                                            <asp:Label ID="Label6" runat="server" Text="Merge Physician Name/Code" meta:resourcekey="Label6Resource1"></asp:Label>
                                        </td>
                                        <td class="a-left w-5p">
                                            <asp:TextBox ID="txtUnMergePhysician" autocomplete="off" onfocus="javascript:ClearValues();SetContextkeyforPhyUnMerge();"
                                                ToolTip="Refering Physician(Doctor) Name" CssClass="Txtboxsmall" runat="server"
												meta:resourcekey="txtUnMergePhysicianResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteForUnMergePhysician" runat="server" TargetControlID="txtUnMergePhysician"
                                                FirstRowSelected="true" ServiceMethod="GetMergePhysicianPatient" ServicePath="~/WebService.asmx"
                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteForUnMergePhysician"
                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                OnClientShown="DocPopUm" UseContextKey="True" Enabled="True" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="UnMergePhysicianSelected">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left">
                                            <input id="btnAddUnMerge" value="Add" type="button" class="btn" onclick="javascript:validateUnMerge();" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table class="dataheader2 defaultfontcolor w-100p searchPanel">
                                    <tr>
                                        <td colspan="5">
                                            <asp:Panel runat="server" ID="pnlUnMergePhy" class="w-100p" Style="display: none;"
                                                meta:resourcekey="pnlUnMergePhyResource1">
                                                <div class="dataheaderInvCtrl" id="Unmerge" runat="server">
                                                    <table id="tblUnMergePhysician" class="dataheaderInvCtrl w-100p font12" style="font-family: Tahoma;
                                                        display: table;">
                                                        <thead>
                                                            <tr class="dataheader1">
                                                                <th style="width: 5%" scope="col">
                                                                    <asp:Label ID="Label8" runat="server" Text="Primary Physician Name" meta:resourcekey="Label8Resource1"></asp:Label>
                                                                </th>
                                                                <th style="display: none;" class="w-5p" scope="col">
                                                                    <asp:Label runat="server" ID="Label9" Text="Physician ID" meta:resourcekey="Label9Resource1" />
                                                                </th>
                                                                <th class="w-15p" scope="col">
                                                                    <asp:Label runat="server" ID="Label10" Text="Physician Name" meta:resourcekey="Label10Resource1" />
                                                                </th>
                                                                <th class="w-5p" scope="col">
                                                                    <asp:Label runat="server" ID="Label11" Text="Qualification" meta:resourcekey="Label11Resource1" />
                                                                </th>
                                                                <th class="w-10p" scope="col">
                                                                    <asp:Label runat="server" ID="Label12" Text="Physician Code" meta:resourcekey="Label12Resource1" />
                                                                </th>
                                                                <th class="w-10p" scope="col">
                                                                    <asp:Label runat="server" ID="Label13" Text="Contact Number" meta:resourcekey="Label13Resource1" />
                                                                </th>
                                                                <th class="w-10p" scope="col">
                                                                    <asp:Label runat="server" ID="Label14" Text="Email" meta:resourcekey="Label14Resource1" />
                                                                </th>
                                                                <th class="w-15p" scope="col">
                                                                    <asp:Label runat="server" ID="Label15" Text="Organisation Name" meta:resourcekey="Label15Resource1" />
                                                                </th>
                                                                <th class="w-25p" scope="col">
                                                                    <asp:Label runat="server" ID="Label16" Text="Address" meta:resourcekey="Label16Resource1" />
                                                                </th>
                                                                <th class="w-25p" scope="col">
                                                                    <asp:Label ID="Label17" runat="server" Text="Un Merge" meta:resourcekey="Label17Resource1"></asp:Label>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr id="trUnMerge" runat="server" style="display: none;">
                                        <td colspan="5" class="a-center">
                                            <asp:Button ID="btnUnMerge" runat="server" Text="Un Merge" CssClass="btn" OnClientClick="return GenerateUnMergeData();"
                                                OnClick="btnUnMerge_Click" meta:resourcekey="btnUnMergeResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:HiddenField ID="hdnListcollections" Value="" runat="server" />
                <asp:HiddenField ID="hdnSelectedPhysicianID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnRegPhysicianType" runat="server" Value="" />
                <asp:HiddenField ID="hdnSelectionList" runat="server" Value="0" />
                <asp:HiddenField ID="hdnUnMergePhysicianID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnUnMergePhysicianList" runat="server" Value="" />
                <asp:HiddenField ID="hdnSelectedUnMergePhysician" runat="server" Value="" />
                <asp:HiddenField ID="hdnSelectedPhysicianList" runat="server" Value="" />
                <asp:HiddenField ID="hdnMessages" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>

<script type="text/javascript">
    function SetContextkeyforPhyMerge() {
        var OrgID = "<%= OrgID %>";
        var sval = "";
        sval = OrgID + "~" + "PHY" + "~" + $("#txtFDate").val() + "~" + $("#txtTDate").val() + "~" + $("#txtRefPhyName").val() + "~" + $("#txtRefContact").val() + "~" + "UNMerged"
        $find('AutoRname').set_contextKey(sval);
    }
    function SetContextkeyforPhyUnMerge() {
        var OrgID = "<%= OrgID %>";
        var sval = "";
        sval = OrgID + "~" + "PHY" + "~" + $("#TxtBSm").val() + "~" + $("#TxtBSml").val() + "~" + $("#txtUnMergePhysician").val() + "~" + $("#txtRefContact").val() + "~" + "Merged"
        $find('AutoCompleteForUnMergePhysician').set_contextKey(sval);
    }
    function AddItems() {
        //        var arrGotValue = new Array();
        //        $.ajax({
        //            type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "../OPIPBilling.asmx/GetMergePhysicianPatient",
        //            data: JSON.stringify({ FilterText: $("#txtRefPhyName").val(), OrgID: "<%= OrgID %>", Type: "PHY", FromDate: $("#txtFDate").val(), ToDate: $("#txtTDate").val(), FindPosition: "0", ContactNumber: $("#txtRefContact").val() }),
        //            dataType: "json",
        //            success: function(data) {
        //                for (var i = 0; i < data.d.length; i++) {
        //                     
        //                    }
        //                }
        //            },
        //            error: function(result) {
        //                alert("Error");
        //            }
        //        });
    }
   
</script>

</html>
