<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SynopticTest.ascx.cs"
    Inherits="Investigation_SynopticTest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">

    function setContextkeyforSynopticTest() {
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
        sval = "COMSynoptic" + '~' + ClientID + '~' + 'N' + '~' + '' + '~' + gen;
        $find('ucSynopticTest_AutoCompleteExtender1').set_contextKey(sval);
    }

    function SynopticOrderedItemSelected(source, eventArgs) {
        try {
            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length >= 2) {
                ID = list[0];
                name = list[1].trim();
                feeType = list[2];
                document.getElementById('ucSynopticTest_hdnSynopticID').value = ID;
                document.getElementById('ucSynopticTest_hdnSynopticName').value = name;
                document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value = feeType;
            }

            $find('ucSynopticTest_AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                $find('ucSynopticTest_AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                webservice_callback(result, context);
            };
        }
        catch (e) {
            return false;
        }
    }

    function AddSynopticTestItems() {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vOneTest = SListForAppMsg.Get('Investigation_SynopticTest_ascx_01') == null ?
         "Select one Test" : SListForAppMsg.Get('Investigation_SynopticTest_ascx_01');
        var vParentInvestigation = SListForAppMsg.Get('Investigation_SynopticTest_ascx_02') == null ?
        "Parent Investigation/Group is not abled to Synoptic Test" : SListForAppMsg.Get('Investigation_SynopticTest_ascx_02');
        var vReflex = SListForAppMsg.Get('Investigation_SynopticTest_ascx_03') == null ?
        "Are you sure you want to add Synoptic Test?" : SListForAppMsg.Get('Investigation_SynopticTest_ascx_03');
        var vTest = SListForAppMsg.Get('Investigation_SynopticTest_ascx_04') == null ?
        "This Test is already available for this Visit !!!" : SListForAppMsg.Get('Investigation_SynopticTest_ascx_04');
        var vApprovedReflex = SListForAppMsg.Get('Investigation_SynopticTest_ascx_05') == null ?
         "Approved test not allowed for Synoptic Test" : SListForAppMsg.Get('Investigation_SynopticTest_ascx_05');
         
        var vTestFromList = SListForAppMsg.Get('Investigation_SynopticTest_ascx_06') == null ? "Select Test From List" :
         SListForAppMsg.Get('Investigation_SynopticTest_ascx_06');
         
        var Serid = SListForAppMsg.Get("Investigation_SynopticTest_ascx_07") == null ? "ID" :
        SListForAppMsg.Get("Investigation_SynopticTest_ascx_07");
        
        var Serreflex = SListForAppMsg.Get("Investigation_SynopticTest_ascx_08") == null ? "Synoptic Test Investigation" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_08");
         
        var SerType = SListForAppMsg.Get("Investigation_SynopticTest_ascx_09") == null ? "Type" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_09");
         
        var SerParent = SListForAppMsg.Get("Investigation_SynopticTest_ascx_10") == null ? "Parent Investigation" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_10");

        var SerReferred = SListForAppMsg.Get("Investigation_SynopticTest_ascx_11") == null ? "Referred Type" :
        SListForAppMsg.Get("Investigation_SynopticTest_ascx_11");
        
        var SerReport = SListForAppMsg.Get("Investigation_SynopticTest_ascx_12") == null ? "IsReportable" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_12");
        
        var SerBill = SListForAppMsg.Get("Investigation_SynopticTest_ascx_13") == null ? "IsBillable" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_13");

        var SerAccession = SListForAppMsg.Get("Investigation_SynopticTest_ascx_14") == null ? "Accession Number" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_14");
        
        var Serdelete = SListForAppMsg.Get("Investigation_SynopticTest_ascx_15") == null ? "Delete" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_15");

        var prndInv = SListForAppMsg.Get("Investigation_SynopticTest_ascx_16") == null ? "Parent Investigation/Group is not allowed to add" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_16");

        var SameInvTest = SListForAppMsg.Get("Investigation_SynopticTest_ascx_17") == null ? "Same Test Cannot be Synoptic for Selected test !!!" :
         SListForAppMsg.Get("Investigation_SynopticTest_ascx_17");
         
        try {
            if (document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value == "") {
                ValidationWindow(vOneTest, AlertType);
                return false;
            }
            var flag1 = 0;
            var previousReflexId = '';
            var _temp = 0; var flag2 = 'Correct';
            if (document.getElementById('ucSynopticTest_hdnSynopticID').value != "" && document.getElementById('ucSynopticTest_txtSynopticTestName').value != "") {
                $('#ucSynopticTest_grdSynopticTestOrderedInv tbody tr:not(:first)').each(function(i, n) {
                    var $row = $(n);
                    if ($row.find($('span[id$="lblID"]')).html() != undefined) {
                        var ParentId = document.getElementById('ucSynopticTest_hdnParentInvID').value;
                        var lblGrpID = $row.find($('span[id$="lblGrpID"]')).html().trim();
                        var ReflexId = document.getElementById('ucSynopticTest_hdnSynopticID').value.trim();
                        if (ParentId == ReflexId) {
                            alert("Parent Investigation/Group is not allowed to add");
                            document.getElementById('ucSynopticTest_txtSynopticTestName').value = '';
                            document.getElementById('ucSynopticTest_chkIsReportable').checked = false;
                            document.getElementById('ucSynopticTest_chkIsBillable').checked = false;
                            document.getElementById('ucSynopticTest_txtSynopticTestName').focus();
                            flag1 = 1;
                        }
                        if (lblGrpID == ReflexId) {
                            flag2 = 'Wrong';
                        }
                    }

                });
                if (flag2 == 'Wrong' && flag1 == 0) {
                    ValidationWindow(vParentInvestigation, AlertType);
                    document.getElementById('ucSynopticTest_txtSynopticTestName').value = '';
                    document.getElementById('ucSynopticTest_chkIsReportable').checked = false;
                    document.getElementById('ucSynopticTest_txtSynopticTestName').focus();
                    _temp = '';
                    return false;
                }

                if (flag1 == 1) {
                    return false;
                }
                var status = document.getElementById('ucSynopticTest_hdnStatus').value;
                if (status != "Approve") {
                    var ok = confirm("" + vReflex + "");
                    if (ok) {

                        var lstParentTestsList = [];
                        if ($('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val() != undefined && $('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val() != "") {
                            lstParentTestsList = JSON.parse($('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val());
                            var ReflexId = document.getElementById('ucSynopticTest_hdnSynopticID').value.trim();
                            var ReflexType = document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value.trim();
                            if (lstParentTestsList.length > 0) {
                                for (k = 0; k < lstParentTestsList.length; k++) {
                                    if (lstParentTestsList[k].InvestigationID == ReflexId) {
                                        ValidationWindow(vTest, AlertType);
                                        document.getElementById('ucSynopticTest_hdnSynopticID').value = "";
                                        document.getElementById('ucSynopticTest_hdnSynopticName').value = "";
                                        document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value = "";
                                        document.getElementById('ucSynopticTest_txtSynopticTestName').value = "";
                                        document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value == "";
                                        document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value == "";
                                        document.getElementById('ucSynopticTest_hdnVID').value == "";
                                        document.getElementById('ucSynopticTest_hdnStatus').value = "";
                                        document.getElementById('ucSynopticTest_hdnUID').value = "";
                                        document.getElementById('ucSynopticTest_hdnLabNo').value = "";
                                        flag1 = 1;
                                    }
                                }
                            }
                        }

                        if (flag1 == 1) {
                            return false;
                        }

                        $('#ucSynopticTest_grdSynopticTestINV tbody tr:not(:first)').each(function(i, n) {
                            $row = $(n);
                            id = $row.children('td')[0].innerText;
                            if (id == document.getElementById('ucSynopticTest_hdnSynopticID').value) {
                                alert("Same Test Cannot be Synopticed for Selected test !!!");
                                document.getElementById('ucSynopticTest_hdnSynopticID').value = "";
                                document.getElementById('ucSynopticTest_hdnSynopticName').value = "";
                                document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value = "";
                                document.getElementById('ucSynopticTest_txtSynopticTestName').value = "";
                                document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value == "";
                                document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value == "";
                                document.getElementById('ucSynopticTest_hdnVID').value == "";
                                document.getElementById('ucSynopticTest_hdnStatus').value = "";
                                document.getElementById('ucSynopticTest_hdnUID').value = "";
                                document.getElementById('ucSynopticTest_hdnLabNo').value = "";
                                flag1 = 1;
                            }
                        });

                        if (flag1 == 1) {
                            return false;
                        }
                        var IsReportable;
                        if (document.getElementById('ucSynopticTest_chkIsReportable').checked == true) {
                            IsReportable = 'Y';
                        }
                        else {
                            IsReportable = 'N';
                        }
                        var IsBillable;
                        if (document.getElementById('ucSynopticTest_chkIsBillable').checked == true) {
                            IsBillable = 'Y';
                        }
                        else {
                            IsBillable = 'N';
                        }
                        var k = $("#ucSynopticTest_grdSynopticTestINV tr").length;

                        if (k == 0) {
                            $("#ucSynopticTest_grdSynopticTestINV").append("<tr class='dataheader1'><td style='display:none';><span id='lblinvID'>"
                            + Serid + "</span></td><td><span id='lblName'>"
                            + Serreflex + "</span></td><td><span id ='lbltype'>"
                            + SerType + "</span></td><td><span id ='lblParentINVName'>"
                            + SerParent + "</span></td><td style='display:none';><span id ='lblParentTestStatus'>"
                            + SerParent + "</span></td><td><span id ='lblReferredType'>"
                            + SerReferred + "</span></td><td style='display:none';><span id='lblIsReportable'>"
                            + SerReport + "</span></td><td style='display:none';><span id='lblIsBillable'>"
                            + SerBill + "</span></td><td style='display:none';><span id='lblAccNo'>"
                            + SerAccession + "</span></td><td><span id ='lblDelete'>" + Serdelete + "</span></td></tr>");
                        }
                        if ($("#ucSynopticTest_grdSynopticTestINV").length > 0) {
                            $("#ucSynopticTest_grdSynopticTestINV").append("<tr id=tr_"
                            + document.getElementById('ucSynopticTest_hdnSynopticID').value + "><td style='display:none';><span id='lblinvID'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticID').value + "</span></td><td><span id='lblName'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticName').value + "</td></span><td><span id ='lbltype'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value
                            + "</span></td><td><span id ='lblparentInvName'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value
                            + "</span></td><td><span id ='lblSynopticType'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticType').value
                            + "</span></td><td style='display:none';><span id ='lblParentTestStatus'>"
                            + document.getElementById('ucSynopticTest_hdnStatus').value
                            + "</span></td><td style='display:none';><span id ='lblIsReportable'>"
                            + IsReportable + "</span></td><td style='display:none';><span id ='lblIsBillable'>" + IsBillable
                            + "</span></td><td style='display:none';><span id ='lblAccNo'>"
                            + document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value
                            + "</span></td><td><input id=td_"
                            + document.getElementById('ucSynopticTest_hdnSynopticID').value
                            + " onclick=deleteRow(this); value = 'Delete' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'><input type='hidden' id='hdnUID' value='" + document.getElementById('ucSynopticTest_hdnUID').value + "'><input type='hidden' id='hdnLabNo' value='" + document.getElementById('ucSynopticTest_hdnLabNo').value + "'><input type='hidden' id='hdnVID' value='" + document.getElementById('ucSynopticTest_hdnVID').value + "'></td></tr>");
                        }
                        document.getElementById('ucSynopticTest_btnAddSynopticTest').style.display = 'block';
                        document.getElementById('ucSynopticTest_btnSaveSynopticTest').style.display = 'block';
                        document.getElementById('ucSynopticTest_txtSynopticTestName').value = '';
                        document.getElementById('ucSynopticTest_chkIsReportable').checked = false;
                        document.getElementById('ucSynopticTest_chkIsBillable').checked = false;
                        document.getElementById('ucSynopticTest_txtSynopticTestName').focus();

                    }
                    else {
                        document.getElementById('ucSynopticTest_hdnSynopticID').value = "";
                        document.getElementById('ucSynopticTest_hdnSynopticName').value = "";
                        document.getElementById('ucSynopticTest_hdnSynopticFeeTypeSelected').value = "";
                        document.getElementById('ucSynopticTest_txtSynopticTestName').value = "";
                        document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value == "";
                        document.getElementById('ucSynopticTest_hdnSynopticPrntInvName').value == "";
                        document.getElementById('ucSynopticTest_hdnStatus').value = "";
                        document.getElementById('ucSynopticTest_hdnUID').value = "";
                        document.getElementById('ucSynopticTest_hdnLabNo').value = "";
                        return false;
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
            var k = $("#ucReflexTest_grdReflexordINV tr").length;

            if (k <= 1) {
               
                $("#ucReflexTest_grdReflexordINV tr.dataheader1").remove();
            }
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
            $('#ucSynopticTest_grdSynopticTestINV tbody tr:not(:first)').each(function(i, n) {
                $row = $(n);
                id = $row.children('td')[0].innerText;
                name = $row.children('td')[1].innerText;
                type = $row.children('td')[2].innerText;
                lstorderedInvestigation.push({
                    ID: id,
                    Name: name,
                    Type: type,
                    ReferredAccessionNo: document.getElementById('ucSynopticTest_hdnSynopticAccessionNo').value
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
            document.getElementById('ucSynopticTest_alert').innerHTML = 'This Services would not been available for this Client (or) it would be a Gender based test.';
        }
        else {
            document.getElementById('ucSynopticTest_alert').innerHTML = "";
        }
    }
    function CheckSynopticTest() {
        var lstSynopticList = [];
        if ($('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val() != undefined && $('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val() != "") {
            lstSynopticList = JSON.parse($('input[id$="ucSynopticTest_hdnLstInvestigationQueue"]').val());
        }

        $('#ucSynopticTest_grdSynopticTestINV tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var visitID, investigationID, name, type, accessionNumber, IsReportable, IsBillable, ParentName, ParentInvId, status, UID, LabNo;
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
            ParentInvId = document.getElementById('ucSynopticTest_hdnParentInvID').value;
            status = $row.find($('span[id$="lblParentTestStatus"]')).html();
            UID = $row.find($('input[id$="hdnUID"]')).val();
            LabNo = $row.find($('input[id$="hdnLabNo"]')).val();

            if (accessionNumber != undefined && investigationID != undefined) {
                lstSynopticList.push({
                    VisitID: visitID,
                    InvestigationID: investigationID,
                    InvestigationName: name,
                    Type: type,
                    AccessionNumber: accessionNumber,
                    IsReportable: IsReportable,
                    IsBillable: IsBillable,
                    ParentName: ParentName,
                    ParentInvId: ParentInvId,
                    Status: status,
                    UID: UID,
                    LabNo: LabNo
                });
            }
        });
        if (lstSynopticList.length > 0) {
            document.getElementById('ucSynopticTest_hdnLstInvestigationQueue').value = JSON.stringify(lstSynopticList);
        }
        $('#progressbarSave').show();
        $find('ucSynopticTest_SynopticTestModalPopupExtender').hide();
        $("#ucSynopticTest_grdSynopticTestINV tr:not(:first-child)").remove();
        document.getElementById('ucSynopticTest_txtSynopticTestName').value = "";

        if (document.getElementById('hdnSynopticTestFlag') != null) {
            document.getElementById('hdnSynopticTestFlag').value = "SynopticFlag";
            document.getElementById('btnSaveToDispatch').click();
        }
        else {
            document.getElementById('hdnSynopticTestFlag').value = "";
        }
        //return false;
    }

    function CloseSynopticTestPopUp() {
        $find('ucSynopticTest_SynopticTestModalPopupExtender').hide();
        document.getElementById('ucSynopticTest_txtSynopticTestName').value = "";
        document.getElementById('hdnSynopticTestFlag').value = "";
    }
       

</script>

<style>
    #ucSynopticTest_pnlSynoptic
    {
        z-index: 10001 !important;
    }
</style>
<ajc:ModalPopupExtender ID="SynopticTestModalPopupExtender" runat="server" BackgroundCssClass="modalBackground"
    CancelControlID="btnSynopticpopUpClose" DynamicServicePath="" Enabled="True"
    PopupControlID="pnlSynoptic" TargetControlID="btnDummy2">
</ajc:ModalPopupExtender>
<asp:Panel ID="pnlSynoptic" Width="1000px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
    meta:resourcekey="pnlSynopticResource1">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 100%" align="right">
                <asp:Label ID="lblheader" runat="server" Text="Synoptic Test Ordered Investigation(s) for this visit"
                    Style="padding-right: 400px; font-weight: bold;" meta:resourcekey="lblheaderResource1"></asp:Label>
                <asp:Button ID="btnSynopticpopUpClose" Style="display: none;" runat="server" Text="Cancel"
                    CssClass="btn" OnClientClick="return CloseSynopticTestPopUp();" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" meta:resourcekey="btnSynopticpopUpCloseResource1" />
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 100%">
                <asp:GridView ID="grdSynopticTestOrderedInv" runat="server" Width="90%" OnRowDataBound="grdSynopticTestOrderedInv_RowDataBound"
                    AutoGenerateColumns="False" meta:resourcekey="grdSynopticTestOrderedInvResource1">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="width: 60%" align="left">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 13%">
                            <asp:Label ID="lblSynopticTest" runat="server" Text="Synoptic Test Name" meta:resourcekey="lblSynopticTestResource1"></asp:Label>
                        </td>
                        <td style="width: 32%">
                            <asp:TextBox CssClass="AutoCompletesearchBox11" ID="txtSynopticTestName" runat="server"
                                Width="350px" meta:resourcekey="txtSynopticTestNameResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSynopticTestName"
                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="SynopticOrderedItemSelected"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td style="display: none;">
                            <asp:CheckBox ID="chkIsReportable" Text="Is Reportable" runat="server" Style="display: none;"
                                meta:resourcekey="chkIsReportableResource1" />
                        </td>
                        <td style="display: none;">
                            <asp:CheckBox ID="chkIsBillable" Text="Is Billable" runat="server" Style="display: none;"
                                meta:resourcekey="chkIsBillableResource1" />
                        </td>
                        <td valign="middle">
                            <input type="button" id="btnAdd" value="ADD" width="150px" runat="server" onclick="return AddSynopticTestItems();"
                                class="btn" meta:resourcekey="btnAddResource1" />
                        </td>
                    </tr>
                </table>
                <asp:Label ID="alert" runat="server" ForeColor="Blue" meta:resourcekey="alertResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 100%" valign="top">
                <asp:GridView ID="grdSynopticTestINV" runat="server" Width="90%" AutoGenerateColumns="False"
                    meta:resourcekey="grdSynopticTestINVResource1">
                    <HeaderStyle CssClass="dataheader1" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td align="center" style="width: 100%" valign="top">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnSaveSynopticTest" runat="server" Text="Save" OnClick="btnSaveSynopticTest_Click"
                                OnClientClick="return CheckSynopticTest();" CssClass="btn" onmouseout="this.className='btn'"
                                onmouseover="this.className='btn btnhov'" Style="display: none;" meta:resourcekey="btnSaveSynopticTestResource1" />
                        </td>
                        <td>
                            <asp:Button ID="btnAddSynopticTest" runat="server" Text="Close" OnClientClick="return CloseSynopticTestPopUp();"
                                CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                Style="display: none;" meta:resourcekey="btnAddSynopticTestResource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnLstorderedInvestigationSynoptic" runat="server" Value="" />
    <asp:HiddenField ID="hdnSynopticID" runat="server" Value="" />
    <asp:HiddenField ID="hdnSynopticName" runat="server" Value="" />
    <asp:HiddenField ID="hdnSynopticFeeTypeSelected" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstInvestigationQueue" runat="server" />
    <asp:HiddenField ID="hdnSynopticAccessionNo" runat="server" />
    <asp:HiddenField ID="hdnSynopticPrntInvName" runat="server" />
    <asp:HiddenField ID="hdnStatus" runat="server" />
    <asp:HiddenField ID="hdnVID" runat="server" />
    <asp:HiddenField ID="hdnParentInvID" runat="server" />
    <asp:HiddenField ID="hdnDisableDropDown" runat="server" />
    <asp:HiddenField ID="hdnDropDownId" runat="server" />
    <asp:HiddenField ID="hdnGroupName" runat="server" />
    <asp:HiddenField ID="hdnControlId" runat="server" />
    <asp:HiddenField ID="hdnSynopticType" runat="server" />
    <asp:HiddenField ID="hdnUID" runat="server" Value="" />
    <asp:HiddenField ID="hdnLabNo" runat="server" Value="" />
    <asp:HiddenField ID="hdnTotalItems" runat="server" Value="" />
</asp:Panel>
<input id="btnDummy2" runat="server" type="button" style="display: none" />
