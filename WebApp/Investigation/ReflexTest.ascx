<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReflexTest.ascx.cs" Inherits="Investigation_ReflexTest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%--<script type="text/javascript" src="../Scripts/jquery.min.js"></script>--%>

<%--<script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>--%>
<%--
<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>--%>

<script type="text/javascript">

    function runScript(e) {
        var keyCode = (e.keyCode ? e.keyCode : e.which);
        if (keyCode == 13) {
            if (keyCode == '13') {
                AddItems();
            }
            return false;
        }
    }
    function setContextkeyforReflex() {
        //debugger;
        var Gender = document.getElementById('PatientDetail_hdnGender').value;
        var ClientID = document.getElementById('PatientDetail_hdnClientID').value;
        var gen;
        var sval;
        if (Gender == "Male") {
            gen = "M";
        }
        else if (Gender = "Female") {
            gen = "F";
        }
        sval = "COM" + '~' + ClientID + '~' + 'N' + '~' + '' + '~' + gen;
        $find('ucReflexTest_AutoCompleteExtender3').set_contextKey(sval);
    }



    function orderedItemSelected(source, eventArgs) {
        try {
            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length >= 2) {
                //if (list[i] != "") {
                    ID = list[0];
                    name = list[1].trim();
                    feeType = list[2];
                    document.getElementById('ucReflexTest_hdnReflexID').value = ID;
                    document.getElementById('ucReflexTest_hdnReflexName').value = name;
                    document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = feeType;
                //}
            }

            $find('ucReflexTest_AutoCompleteExtender3')._onMethodComplete = function(result, context) {
                $find('ucReflexTest_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);
                webservice_callback(result, context);
            };
        }
        catch (e) {
            return false;
        }
    }

    function AddItems() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vOneTest = SListForAppMsg.Get('Investigation_ReflexTest_ascx_01') == null ? "Select one Test" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_01');
        var vParentInvestigation = SListForAppMsg.Get('Investigation_ReflexTest_ascx_02') == null ? "Parent Investigation/Group is not abled to reflex" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_02');
        var vReflex = SListForAppMsg.Get('Investigation_ReflexTest_ascx_03') == null ? "Are you sure you want to add reflex?" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_03');
        var vTest = SListForAppMsg.Get('Investigation_ReflexTest_ascx_04') == null ? "This Test is already available for this Visit !!!" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_04');
        var vApprovedReflex = SListForAppMsg.Get('Investigation_ReflexTest_ascx_05') == null ? "Approved test not allowed for reflex" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_05');
        var vTestFromList = SListForAppMsg.Get('Investigation_ReflexTest_ascx_06') == null ? "Select Test From List" : SListForAppMsg.Get('Investigation_ReflexTest_ascx_06');
        var Serid = SListForAppMsg.Get("Investigation_ReflexTest_ascx_07") == null ? "ID" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_07");
        var Serreflex = SListForAppMsg.Get("Investigation_ReflexTest_ascx_08") == null ? "Reflex Investigation" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_08");
        var SerType = SListForAppMsg.Get("Investigation_ReflexTest_ascx_09") == null ? "Type" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_09");

        var SerParent = SListForAppMsg.Get("Investigation_ReflexTest_ascx_10") == null ? "Parent Investigation" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_10");

        var SerReferred = SListForAppMsg.Get("Investigation_ReflexTest_ascx_11") == null ? "Referred Type" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_11");
        var SerReport = SListForAppMsg.Get("Investigation_ReflexTest_ascx_12") == null ? "IsReportable" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_12");
        var SerBill = SListForAppMsg.Get("Investigation_ReflexTest_ascx_13") == null ? "IsBillable" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_13");

        var SerAccession = SListForAppMsg.Get("Investigation_ReflexTest_ascx_14") == null ? "Accession Number" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_14");
        var Serdelete = SListForAppMsg.Get("Investigation_ReflexTest_ascx_15") == null ? "Delete" : SListForAppMsg.Get("Investigation_ReflexTest_ascx_15");

        try {
            if (document.getElementById('ucReflexTest_hdnReflexAccessionNo').value == "") {
                ValidationWindow(vOneTest, AlertType);
                return false;
            }
            var flag1 = 0;
            var previousReflexId = '';
            var _temp = 0; var flag2 = 'Correct';
            var RflxCount = 0;
            //var lstReflexAddedList = [];
            if (document.getElementById('ucReflexTest_hdnReflexID').value != "" && document.getElementById('ucReflexTest_txtFeflexTestName').value != "") {
                $('#ucReflexTest_grdReflexOrderedInv tbody tr:not(:first)').each(function(i, n) {
                    var $row = $(n);
                    if ($row.find($('span[id$="lblID"]')).html() != undefined) {
                        var ParentId = document.getElementById('ucReflexTest_hdnParentInvID').value;
                        var lblGrpID = $row.find($('span[id$="lblGrpID"]')).html().trim();
                        //document.getElementById('ucReflexTest_hdnParentInvID').value = ParentId;
                        var ReflexId = document.getElementById('ucReflexTest_hdnReflexID').value.trim();
                        if (ParentId == ReflexId) {
                            //alert("Parent Investigation/Group is not allowed to add");
                            RflxCount = RflxCount + 1;
                            document.getElementById('ucReflexTest_txtFeflexTestName').value = '';
                            document.getElementById('ucReflexTest_chkIsReportable').checked = false;
                            document.getElementById('ucReflexTest_chkIsBillable').checked = false;
                            document.getElementById('ucReflexTest_txtFeflexTestName').focus();
                            flag1 = 1;
                        }
                        if (lblGrpID == ReflexId) {
                            flag2 = 'Wrong';
                        }
                    }

                });
                if (RflxCount > 0) {
                    alert("Parent Investigation/Group is not allowed to add");
                }
                if (flag2 == 'Wrong' && flag1 == 0) {
                    ValidationWindow(vParentInvestigation, AlertType);
                    document.getElementById('ucReflexTest_txtFeflexTestName').value = '';
                    document.getElementById('ucReflexTest_chkIsReportable').checked = false;
                    document.getElementById('ucReflexTest_txtFeflexTestName').focus();
                    _temp = '';
                    return false;
                }
                
                if (flag1 == 1) {
                    return false;
                }
                var status = document.getElementById('ucReflexTest_hdnStatus').value;
                if (status != "Approve") {
                    var ok = confirm("" + vReflex + "");
                    if (ok) {
                        //debugger;
                        //                        if (lstorderedInvestigation.length > 0) {
                        //                            for (k = 0; k < lstorderedInvestigation.length; k++) {
                        //                                if (lstorderedInvestigation[k].ID == document.getElementById('ucReflexTest_hdnReflexID').value) {
                        //                                    alert("Already Added");
                        //                                    document.getElementById('ucReflexTest_hdnReflexID').value = "";
                        //                                    document.getElementById('ucReflexTest_hdnReflexName').value = "";
                        //                                    document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = "";
                        //                                    document.getElementById('ucReflexTest_txtFeflexTestName').value = "";
                        //                                    document.getElementById('ucReflexTest_hdnReflexAccessionNo').value == "";
                        //                                    document.getElementById('ucReflexTest_hdnReflexPrntInvName').value == "";
                        //                                    document.getElementById('ucReflexTest_hdnVID').value == "";
                        //                                    document.getElementById('ucReflexTest_hdnStatus').value = "";
                        //                                    document.getElementById('ucReflexTest_hdnUID').value = "";
                        //                                    document.getElementById('ucReflexTest_hdnLabNo').value = "";
                        //                                    return false;
                        //                                }
                        //                            }
                        //                        }

                        var lstParentTestsList = [];
                        if ($('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val() != undefined && $('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val() != "") {
                            lstParentTestsList = JSON.parse($('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val());
                            var ReflexId = document.getElementById('ucReflexTest_hdnReflexID').value.trim();
                            var ReflexType = document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value.trim();
                            if (lstParentTestsList.length > 0) {
                                for (k = 0; k < lstParentTestsList.length; k++) {
                                    if (lstParentTestsList[k].InvestigationID == ReflexId) {
                                        ValidationWindow(vTest, AlertType);
                                        document.getElementById('ucReflexTest_hdnReflexID').value = "";
                                        document.getElementById('ucReflexTest_hdnReflexName').value = "";
                                        document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = "";
                                        document.getElementById('ucReflexTest_txtFeflexTestName').value = "";
                                        document.getElementById('ucReflexTest_hdnReflexAccessionNo').value == "";
                                        document.getElementById('ucReflexTest_hdnReflexPrntInvName').value == "";
                                        document.getElementById('ucReflexTest_hdnVID').value == "";
                                        document.getElementById('ucReflexTest_hdnStatus').value = "";
                                        document.getElementById('ucReflexTest_hdnUID').value = "";
                                        document.getElementById('ucReflexTest_hdnLabNo').value = "";
                                        flag1 = 1;
                                    }
                                }
                            }
                        }

                        if (flag1 == 1) {
                            return false;
                        }

                        $('#ucReflexTest_grdReflexordINV tbody tr:not(:first)').each(function(i, n) {
                            $row = $(n);
                            id = $row.children('td')[0].innerText;
                            if (id == document.getElementById('ucReflexTest_hdnReflexID').value) {
                                alert("Same Test Cannot be reflexed for Selected test !!!");
                                document.getElementById('ucReflexTest_hdnReflexID').value = "";
                                document.getElementById('ucReflexTest_hdnReflexName').value = "";
                                document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = "";
                                document.getElementById('ucReflexTest_txtFeflexTestName').value = "";
                                document.getElementById('ucReflexTest_hdnReflexAccessionNo').value == "";
                                document.getElementById('ucReflexTest_hdnReflexPrntInvName').value == "";
                                document.getElementById('ucReflexTest_hdnVID').value == "";
                                document.getElementById('ucReflexTest_hdnStatus').value = "";
                                document.getElementById('ucReflexTest_hdnUID').value = "";
                                document.getElementById('ucReflexTest_hdnLabNo').value = "";
                                flag1 = 1;
                            }
                        });

                        if (flag1 == 1) {
                            return false;
                        }
                        var IsReportable;
                        if (document.getElementById('ucReflexTest_chkIsReportable').checked == true) {
                            IsReportable = 'Y';
                        }
                        else {
                            IsReportable = 'N';
                        }
                        var IsBillable;
                        if (document.getElementById('ucReflexTest_chkIsBillable').checked == true) {
                            IsBillable = 'Y';
                        }
                        else {
                            IsBillable = 'N';
                        }
                        //                    else {
                        //                        $("#ucReflexTest_grdReflexordINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>ID</span></td><td><span id='lblName'>Reflex Investigation</span></td><td><span id ='lbltype'>Type</span></td><td><span id ='lblParentINVName'>Parent Investigation</span></td><td><span id ='lblReferredType'>Referred Type</span></td><td><span id ='lblDelete'>Delete</span></td></tr>");
                        // 
                        var k = $("#ucReflexTest_grdReflexordINV tr").length;

                        if (k == 0) {
                            $("#ucReflexTest_grdReflexordINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>"+Serid+"</span></td><td><span id='lblName'>"+Serreflex+"</span></td><td><span id ='lbltype'>"+SerType+"</span></td><td><span id ='lblParentINVName'>"+SerParent+"</span></td><td><span id ='lblReferredType'>"+SerReferred+"</span></td><td><span id='lblIsReportable'>"+SerReport+"</span></td><td><span id='lblIsBillable'>"+SerBill+"</span></td><td style='display:none';><span id='lblAccNo'>"+SerAccession+"</span></td><td><span id ='lblDelete'>"+Serdelete+"</span></td></tr>");
                        }
                        if ($("#ucReflexTest_grdReflexordINV").length > 0) {
                            $("#ucReflexTest_grdReflexordINV").append("<tr id=tr_" + document.getElementById('ucReflexTest_hdnReflexID').value + "><td style='display:none';><span id='lblinvID'>" + document.getElementById('ucReflexTest_hdnReflexID').value + "</span></td><td><span id='lblName'>" + document.getElementById('ucReflexTest_hdnReflexName').value + "</td></span><td><span id ='lbltype'>" + document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value + "</span></td><td><span id ='lblparentInvName'>" + document.getElementById('ucReflexTest_hdnReflexPrntInvName').value + "</span></td><td><span id ='lblReflexType'>" + document.getElementById('ucReflexTest_hdnReflexType').value + "</span></td><td><span id ='lblIsReportable'>" + IsReportable + "</span></td><td><span id ='lblIsBillable'>" + IsBillable + "</span></td><td style='display:none';><span id ='lblAccNo'>" + document.getElementById('ucReflexTest_hdnReflexAccessionNo').value + "</span></td><td><input id=td_" + document.getElementById('ucReflexTest_hdnReflexID').value + " onclick=deleteRow(this); value = 'Delete' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'><input type='hidden' id='hdnUID' value='" + document.getElementById('ucReflexTest_hdnUID').value + "'><input type='hidden' id='hdnLabNo' value='" + document.getElementById('ucReflexTest_hdnLabNo').value + "'><input type='hidden' id='hdnVID' value='" + document.getElementById('ucReflexTest_hdnVID').value + "'></td></tr>");
                        }
                        document.getElementById('ucReflexTest_btnAddReflex').style.display = 'block';
                        document.getElementById('ucReflexTest_txtFeflexTestName').value = '';
                        document.getElementById('ucReflexTest_chkIsReportable').checked = false;
                        document.getElementById('ucReflexTest_chkIsBillable').checked = false;
                        document.getElementById('ucReflexTest_txtFeflexTestName').focus();
                        //document.getElementById('ucReflexTest_hdnUID').value = "";
                        //document.getElementById('ucReflexTest_hdnLabNo').value = "";
                        //document.getElementById('ucReflexTest_hdnReflexAccessionNo').value = '';

                    }
                    else {
                        document.getElementById('ucReflexTest_hdnReflexID').value = "";
                        document.getElementById('ucReflexTest_hdnReflexName').value = "";
                        document.getElementById('ucReflexTest_hdnReflexFeeTypeSelected').value = "";
                        document.getElementById('ucReflexTest_txtFeflexTestName').value = "";
                        document.getElementById('ucReflexTest_hdnReflexAccessionNo').value == "";
                        document.getElementById('ucReflexTest_hdnReflexPrntInvName').value == "";
                        document.getElementById('ucReflexTest_hdnStatus').value = "";
                        document.getElementById('ucReflexTest_hdnUID').value = "";
                        document.getElementById('ucReflexTest_hdnLabNo').value = "";
                        return false;
                        //document.getElementById('ucReflexTest_btnpopClose3').click();
                    }
                }
                else {
                    ValidationWindow(vApprovedReflex, AlertType);
                    return false;
                }
            }
            else {
                ValidationWindow(vTestFromList, AlertType);
                return false;
            }
        }
        catch (e) {
            return false;
        }
    }
    function deleteRow(obj) {
        try {
            $(obj).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
    }
    function tableToJSON() {
        try {
            //debugger;
            var lstorderedInvestigation = [];
            var id, name, type;
            $('#ucReflexTest_grdReflexordINV tbody tr:not(:first)').each(function(i, n) {
                $row = $(n);
                id = $row.children('td')[0].innerText;
                name = $row.children('td')[1].innerText;
                type = $row.children('td')[2].innerText;
                lstorderedInvestigation.push({
                    ID: id,
                    Name: name,
                    Type: type,
                    ReferredAccessionNo: document.getElementById('ucReflexTest_hdnReflexAccessionNo').value
                });
            });
            if (lstorderedInvestigation.length > 0) {
                $('#hdnLstInvestigationQueue').val(JSON.stringify(lstorderedInvestigation));
            }
        }
        catch (e) {
            return false;
        }
    }

    function webservice_callback(result, context) {
        if (result == "") {
            document.getElementById('ucReflexTest_alert').innerHTML = 'This Services would not been available for this Client (or) it would be a Gender based test.';
        }
        else {
            document.getElementById('ucReflexTest_alert').innerHTML = "";
        }
    }
    function CheckReflex() {
        var lstReflexList = [];
        if ($('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val() != undefined && $('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val() != "") {
            lstReflexList = JSON.parse($('input[id$="ucReflexTest_hdnLstInvestigationQueue"]').val());
        }

        $('#ucReflexTest_grdReflexordINV tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var visitID, investigationID, name, type, accessionNumber, IsReportable, IsBillable, ParentName, ParentInvId, status,UID,LabNo;
            if (document.getElementById('PatientDetail_hdnVID') != null) {
                visitID = document.getElementById('PatientDetail_hdnVID').value;
            }
            else {
                visitID = $row.find($('input[id$="hdnVID"]')).val();
            }
            investigationID = $row.find($('span[id$="lblinvID"]')).html();
            name = $row.find($('span[id$="lblName"]')).html();
            type = $row.find($('span[id$="lbltype"]')).html();
            accessionNumber = $row.find($('span[id$="lblAccNo"]')).html();
            IsReportable = $row.find($('span[id$="lblIsReportable"]')).html();
            IsBillable = $row.find($('span[id$="lblIsBillable"]')).html();
            ParentName = $row.find($('span[id$="lblparentInvName"]')).html();
            ParentInvId = document.getElementById('ucReflexTest_hdnParentInvID').value;
            status = $row.find($('span[id$="lblReflexType"]')).html();
            UID = $row.find($('input[id$="hdnUID"]')).val();
            LabNo = $row.find($('input[id$="hdnLabNo"]')).val();

//            if (document.getElementById('ucReflexTest_hdnLstInvestigationQueue').value != "") {
//                lstReflexList = JSON.parse(document.getElementById('ucReflexTest_hdnLstInvestigationQueue').value);
//            }
            //            $.each(lstContainerCount, function(i, obj) {
            //                lstReflexList.push({
            //                    VisitID: obj.visitID,
            //                    InvestigationID: obj.investigationID,
            //                    Name: obj.name,
            //                    Type: obj.type,
            //                    AccessionNumber: obj.accessionNumber,
            //                    IsReportable: obj.IsReportable,
            //                    IsBillable: 'N'
            //                });
            //            });

            if (accessionNumber != undefined && investigationID!=undefined) {
            lstReflexList.push({
                VisitID: visitID,
                InvestigationID: investigationID,
                InvestigationName: name,
                Type: type,
                AccessionNumber: accessionNumber,
                IsReportable: IsReportable,
                IsBillable: IsBillable,
                ParentName:ParentName,
                ParentInvId: ParentInvId,
                Status: status,
                UID: UID,
                LabNo:LabNo
            });
            }
        });
        if (lstReflexList.length > 0) {
            document.getElementById('ucReflexTest_hdnLstInvestigationQueue').value = JSON.stringify(lstReflexList);

        }
//        else {
//            alert('Please Select reflex test');
//            document.getElementById('ucReflexTest_txtFeflexTestName').focus();
//            return false;
//        }
        $find('ucReflexTest_ModalPopupExtender2').hide();
        $("#ucReflexTest_grdReflexordINV tr:not(:first-child)").remove();
        //$('#ucReflexTest_grdReflexordINV tbody tr').children().remove();
        
        return false;
    }

    //    function DisableControl() {
    //        var flag = 0;
    //        var disableDrop = document.getElementById('ucReflexTest_hdnDisableDropDown').value;
    //        var count = document.getElementById('hdnGroupCollection').value;
    //        var len = count.split('^'); var CompletedValue = 0;
    //        var dropId = document.getElementById('ucReflexTest_hdnDropDownId').value;
    //        var GrpName = document.getElementById('ucReflexTest_hdnGroupName').value;
    //        
    //        if (GrpName !="") {
    //            for (var i = 0; i < len.length; i++) {
    //                if (len[i] != "") {
    //                    var ctrlID = len[i].split('|');
    //                    if (GrpName == ctrlID[1]) {
    //                        var drpdwn = document.getElementById(dropId);
    //                        var ddldwn = document.getElementById(disableDrop);
    //                        var length = document.getElementById(ctrlID[2]).options.length;
    //                        var status = drpdwn.options[drpdwn.selectedIndex].value.split("_");

    //                        for (var j = 0; j < length; j++) {
    //                            var ddldwnVal = ddldwn.options[j].value.split("_");
    //                            if (ddldwnVal[0] == status[0]) {
    //                                document.getElementById(ctrlID[2]).disabled = true;
    //                                CheckIfEmpty(ctrlID[2], 'txtValue');
    //                                CheckIfEmpty1(ctrlID[2], 'ddlData', '0');
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //            document.getElementById(dropId).readOnly=true;
    //        }
    //        else {
    //            if (document.getElementById('ucReflexTest_hdnControlId').value != "" && flag == 0) {
    //                var InvCtrlId = document.getElementById('ucReflexTest_hdnControlId').value;
    //            }
    //            document.getElementById(disableDrop).readOnly=true;
    //            document.getElementById(InvCtrlId).disabled = true;
    //            flag = 1;
    //        }
    //       return false;
    //   }
        
    function CloseReflexPopUp() {
        $find('ucReflexTest_ModalPopupExtender2').hide();
    }
       

</script>
<style>
#ucReflexTest_pnlReflex {
        z-index: 10001!important;
}
</style>
<ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
    CancelControlID="btnpopClose3" DynamicServicePath="" Enabled="True" PopupControlID="pnlReflex"
    TargetControlID="btnDummy2">
</ajc:ModalPopupExtender>
<asp:Panel ID="pnlReflex" Width="1000px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
    meta:resourcekey="pnlReflexResource1">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 100%" align="right">
                <asp:Label ID="lblheader" runat="server" Text="Ordered Investigation(s) for this visit"
                    Style="padding-right: 400px; font-weight: bold;" meta:resourcekey="lblheaderResource1"></asp:Label>
                <asp:Button ID="btnpopClose3" runat="server" Text="Cancel" CssClass="btn" OnClientClick="return CloseReflexPopUp();" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" meta:resourcekey="btnpopClose3Resource1"/>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 100%">
                <asp:GridView ID="grdReflexOrderedInv" runat="server" Width="90%" OnRowDataBound="grdReflexOrderedInv_RowDataBound"
                    AutoGenerateColumns="False" meta:resourcekey="grdReflexOrderedInvResource1">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="width: 40%" align="left">
                <asp:Label ID="lblReflexTest" runat="server" Text="Test Name" meta:resourcekey="lblReflexTestResource1"></asp:Label>
                <asp:TextBox CssClass="AutoCompletesearchBox11" ID="txtFeflexTestName" runat="server"
                    Width="350px" meta:resourcekey="txtFeflexTestNameResource1" onkeypress="return runScript(event)"></asp:TextBox>
                <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtFeflexTestName"
                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="orderedItemSelected"
                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                    FirstRowSelected="false" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                    DelimiterCharacters="" Enabled="True">
                </ajc:AutoCompleteExtender>
                &nbsp;
                <asp:CheckBox ID="chkIsReportable" Text="Is Reportable" runat="server" meta:resourcekey="chkIsReportableResource1" />
                <asp:CheckBox ID="chkIsBillable" Text="Is Billable" runat="server" Style="display: none;"
                    meta:resourcekey="chkIsBillableResource1" />
                <input type="button" id="btnAdd" value="ADD" width="150px" runat="server" onclick="return AddItems();"
                    class="btn" meta:resourcekey="btnAddResource1" />
                <asp:Label ID="alert" runat="server" ForeColor="Blue" meta:resourcekey="alertResource1"></asp:Label>
            </td>
        </tr>
        <%-- <tr>
            <td width="100%" align="right">
                <asp:Label ID="lblRflInvestigation" runat="server" Text="Reflex Investigation(s) for this visit"
                    Style="padding-right: 400px; font-weight: bold;"></asp:Label>               
            </td>
        </tr>--%>
        <tr>
            <td align="left" style="width: 100%" valign="top">
                <asp:GridView ID="grdReflexordINV" runat="server" Width="90%" AutoGenerateColumns="False"
                    meta:resourcekey="grdReflexordINVResource1">
                    <HeaderStyle CssClass="dataheader1" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td align="center" style="width: 100%" valign="top">
                <asp:Button ID="btnAddReflex" runat="server" Text="Close" OnClientClick="return CheckReflex();"
                    CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                    Style="display: none;" meta:resourcekey="btnAddReflexResource1" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnLstorderedInvestigationReflex" runat="server" Value="" />
    <asp:HiddenField ID="hdnReflexID" runat="server" Value="" />
    <asp:HiddenField ID="hdnReflexName" runat="server" Value="" />
    <asp:HiddenField ID="hdnReflexFeeTypeSelected" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstInvestigationQueue" runat="server" />
    <asp:HiddenField ID="hdnReflexAccessionNo" runat="server" />
    <asp:HiddenField ID="hdnReflexPrntInvName" runat="server" />
    <asp:HiddenField ID="hdnStatus" runat="server" />
    <asp:HiddenField ID="hdnVID" runat="server" />
    <asp:HiddenField ID="hdnParentInvID" runat="server" />
    <asp:HiddenField ID="hdnDisableDropDown" runat="server" />
    <asp:HiddenField ID="hdnDropDownId" runat="server" />
    <asp:HiddenField ID="hdnGroupName" runat="server" />
    <asp:HiddenField ID="hdnControlId" runat="server" />
    <asp:HiddenField ID="hdnReflexType" runat="server" />
    <asp:HiddenField ID="hdnUID" runat="server" Value="" />
    <asp:HiddenField ID="hdnLabNo" runat="server" Value="" />
    <asp:HiddenField ID="hdnTotalItems" runat="server" Value="" />
</asp:Panel>
<input id="btnDummy2" runat="server" type="button" style="display: none" />