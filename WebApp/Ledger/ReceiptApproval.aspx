<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiptApproval.aspx.cs"
    Inherits="Ledger_ReceiptApproval" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Receipt Approval</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/ClientBilling.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
         
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
        .ModalPopupBG
        {
            background-color: #666699;
            filter: alpha(opacity=50);
            opacity: 0.7;
        }
        .HellowWorldPopup
        {
            min-width: 200px;
            min-height: 150px;
            background: white;
        }
         table.dataTable tbody tr.selected
        {
            background-color: #B0BED9;
        }
        table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover
        {
            background-color: #FFFF77;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet"
        type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td class="a-center">
                    <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor w-100p">
                        <table class="w-100p searchPanel">
                            <tr class="panelHeader">
                                <td class="colorforcontent w-100p bold" height="23" align="center">
                                    <asp:Label ID="Rs_FilterResult2" runat="server" Text="Receipt Approval" meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="w-100p">
                                        <table class="w-90p m-auto">
                                            <tr class="a-center">
                                                <td class="w-20p">
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblCategory" runat="server" Text="Category" Font-Bold="true" meta:resourcekey="lblopResource2"></asp:Label>
                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="small">
                                                        <asp:ListItem Value="" Text="TSP"> </asp:ListItem>
                                                        <asp:ListItem Value="" Text="DSA"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label ID="lblClientName" Text="Client Name/Code" Font-Bold="true" runat="server"></asp:Label>
                                                    <asp:HiddenField ID="hdnClientID" runat="server" />
                                                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        OnClientItemOver="SelectedOver" Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                    <asp:Button ID="btnSearch" runat="server" TabIndex="4" Text="Search" CssClass="btn"
                                                        meta:resourcekey="btnChangeResource2" OnClientClick="javascript:return GetData();" />
                                                    <asp:Button ID="btnreload" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                                                        meta:resourcekey="btnChangeResource2" OnClientClick="javascript:return Reloadpage();" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td class="a-center">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td width="5%">
                </td>
                <td width="90%">
                    <div id="divPrint" runat="server">
                        <table id="example" width="100%" style="display: none;" class="display">
                            <thead>
                                <tr style="vertical-align: middle;">
                                    <th align="left" class="w-5p" height="25px">
                                    </th>
                                    <th align="left" class="w-10p" height="25px">
                                        Date
                                    </th>
                                    <th align="left" class="w-30" height="25px">
                                        ClientName
                                    </th>
                                    <th align="left" class="w-10p" height="25px">
                                        InCharge
                                    </th>
                                    <th align="left" class="w-15p" height="25px">
                                        City
                                    </th>
                                    <th align="left" class="w-10p" height="25px">
                                        Amount
                                    </th>
                                    <th align="left" class="w-10p" height="25px">
                                        Mode
                                    </th>
                                    <th align="left" class="w-5p" height="25px">
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </td>
                <td width="5%">
                </td>
            </tr>
        </table>
        <table cellpadding="0" border="0" cellspacing="0" class="w-100p">
            <tr>
                <td class="a-center" id="trbuttons" runat="server">
                    <asp:Button ID="btnSubmit" runat="server" TabIndex="4" Text="Approve" CssClass="btn"
                        OnClientClick="javascript:return RecommendData('Approved');" meta:resourcekey="btnChangeResource2" />
                    &nbsp;
                    <asp:Button ID="btnReject" runat="server" TabIndex="4" Text="Reject" CssClass="btn"
                        OnClientClick="javascript:return RecommendData('Rejected');" meta:resourcekey="btnChangeResource2" />
                    &nbsp;
                    <asp:Button ID="btnReset" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                        OnClientClick="javascript:return Reloadpage();" meta:resourcekey="btnChangeResource2" />
                </td>
            </tr>
        </table>
        <asp:Button ID="btnshow" CssClass="hide" runat="server" Text="" />
        <cc1:ModalPopupExtender ID="modalpopup" runat="server" CancelControlID="btnCancel"
            OkControlID="btnOkay" TargetControlID="btnshow" PopupControlID="Panel1" PopupDragHandleControlID="PopupHeader"
            Drag="true" BackgroundCssClass="ModalPopupBG">
        </cc1:ModalPopupExtender>
        <asp:UpdatePanel ID="updpopop" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel1" Style="display: none" Width="800px" runat="server">
                    <table class="gridView w-100p">
                        <tr class="gridHeader">
                            <td align="center" colspan="6">
                                TSP OutStanding Details
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="w-10p">
                                <asp:Label ID="lblhdrTSP" Text="TSP" runat="server"></asp:Label>
                            </td>
                            <td class="w-30p">
                                <asp:Label ID="lblrstTSP" runat="server"></asp:Label>
                            </td>
                            <td align="center" class="w-10p">
                                <asp:Label ID="lblhdrIncharge" Text="Incharge" runat="server"></asp:Label>
                            </td>
                            <td class="w-20p">
                                <asp:Label ID="lblrstIncharge" runat="server"></asp:Label>
                            </td>
                            <td align="center" class="w-10p">
                                <asp:Label ID="lblhdrCity" Text="City" runat="server"></asp:Label>
                            </td>
                            <td class="w-20p">
                                <asp:Label ID="lblrstCity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblhdrDate" Text="Date" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstDate" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrNarration" Text="Narration" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstNarration" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblhdrCount" Text="Count" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstCount" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrAmount" Text="Amount(Rs)" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstAmount" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table class="gridView w-100p">
                        <tr class="gridHeader">
                            <td align="center">
                                <asp:Label ID="lblhdrSrno" Text="Sr.No" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrDate1" Text="Date" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrClientName1" Text="ClientName" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrInCharge1" Text="InCharge" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrCity1" Text="City" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrNarration1" Text="Remarks" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrCount1" Text="Count" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblhdrAmount1" Text="Amount" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblAchck" Text="Approve" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="SRNO" Text="1" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblrstDate1" Text="" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstClientName1" Text="" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstInCharge1" Text="" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstCity1" Text="" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblrstNarration1" Text="" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblrstCount1" Text="" runat="server"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:Label ID="lblrstAmount1" Text="" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:CheckBox ID="chkApprove1" runat="server" />
                                <asp:HiddenField ID="hdnCDId" runat="server" />
                            </td>
                        </tr>
                        <table class="gridView w-100p">
                            <tr class="gridHeader">
                                <td align="center">
                                    <asp:Button ID="btnOkay" class="btn hide" OnClientClick="return checkvalCheckBox();"
                                        Text="Approve" runat="server" />
                                    <asp:Button ID="btnadd" class="btn" Text="Approve" OnClientClick="javascript:return RecommendData('Approved');"
                                        runat="server" />
                                    <asp:Button ID="btnrej" class="btn" Text="Reject" OnClientClick="javascript:return RecommendData('Rejected');"
                                        runat="server" />
                                    <asp:Button ID="btnCancel" OnClientClick="javascript:return ClearPopupBoxvalues();"
                                        class="btn" Text="Cancel" runat="server" />
                                </td>
                            </tr>
                        </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
    function SelectedOver(source, eventArgs) {
        $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
            //var Perphysicianname = document.getElementById('txtperphy').value;
            $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
            if (result == "") {
                alert('Please select from the list');
                document.getElementById('txtClientName').value = '';
                document.getElementById('<%=hdnClientID.ClientID %>').value = '';
            }
        };
    }
    function SetClientID(source, eventArgs) {
        //alert(eventArgs.get_value());
        var list = eventArgs.get_value().split('^');
        document.getElementById('<%=hdnClientID.ClientID %>').value = list[3];

    }
    /* JSON Data Binding Details */
    $(document).ready(function() {
        GetData();
    });

    function GetData() {
        try {
            debugger;
            var ClientCode = '';
            var OrgID = '';
            var Status = 'Recommended';
            var client = document.getElementById('txtClientName').value;
            if (client == "") {
                document.getElementById('hdnClientID').value = "";
            }
            ClientCode = document.getElementById('hdnClientID').value;
            OrgID = document.getElementById('hdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetTSPReceiptRecommend",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'Status':'" + Status + "','ClientCode':'" + ClientCode + "'}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example').hide();
                    return false;
                }
            });
            $('#example').show();
        }
        catch (e) {
        }
        return false
    }

    function AjaxGetFieldDataSucceeded(result) {
        try {
            debugger;
            $('#trbuttons').hide();
            var oTable;
            if (result != "[]") {
                oTable = $('#example').dataTable({
                    "bJQueryUI": true,
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    "aoColumnDefs": [{ "bSortable": false, "aTargets": [0, 7]}],
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                    //{ "mDataProp": "ClientCode", "bVisible": false },
                          {"mDataProp": "Id", sClass: "a-center", "mRender": function(data, type, full) {
                              if (data != '') {
                                  return '<input type="checkbox" name="chk" id=' + data + '></br>';
                              }
                          }
                      },
                          { "mDataProp": "SubSourceCode", sClass: "a-left" },
                          { "mDataProp": "ClientName", sClass: "a-left" },
                          { "mDataProp": "InCharge", sClass: "a-left" },
                          { "mDataProp": "City", sClass: "a-left" },
                    //{ "mDataProp": "BankName", sClass: "a-left" },
                    //{ "mDataProp": "Count", sClass: "a-right" },
                          {"mDataProp": "Amount", sClass: "a-right" },
                            { "mDataProp": "Mode", sClass: "a-left" },
                          { "mDataProp": "Id",
                              "mRender": function(data, type, full) {
                                  if (data != '') {
                                      return '<a href=' + data + ' Style="cursor: pointer; font-weight: bold;" id=' + data + ' onClick="javascript:return selectClient(' + data + ')">View</a>';
                                  }
                              }
                          }
                          ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[8, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 10,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                          "copy", "csv", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
                                            }
                                       ]
                    }
                });
                if (result.d != '' && result.d != null && result.d[0] != 'undefined') {
                    $('#trbuttons').show();
                }
                $('#example').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data In Receipt Recommentation');
        }
        return false;
    }
    function selectClient(data) {
        debugger;
        $("input:checkbox[name=chk]:checked").each(function() {
            $("input:checkbox[name=chk]:checked").removeAttr("checked");
        });
        var Id = data;
        var OrgId = document.getElementById('hdnOrgID').value;
        Type = "R";
        try {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetSelectedTSPCreditDebit",
                contentType: "application/json;charset=utf-8",
                data: "{'Id':" + Id + ",'OrgId':" + OrgId + ",'Type':'" + Type + "'}",
                dataType: "json",
                async: false,
                success: AjaxGetSuccessSelectedClientDetails,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example').hide();
                    return false;
                }
            });
            $('#example').show();
        }
        catch (e) {
            alert('Exception while Loading Selected Client Receipt Note details for Approval');
        }
        return false;
    }
    function AjaxGetSuccessSelectedClientDetails(result) {
        try {
            debugger;
            ClearPopupBoxvalues();
            if (result.d != "") {
                var Clientdata = result.d[0].Address2.split('^');
               // document.getElementById('lblrstTSP').innerHTML = Clientdata[2];
                //document.getElementById('lblrstClientName1').innerHTML = Clientdata[2];
                document.getElementById('lblrstTSP').innerHTML = result.d[0].ClientName;
                document.getElementById('lblrstClientName1').innerHTML = result.d[0].ClientName;
                document.getElementById('lblrstIncharge').innerHTML = result.d[0].InCharge;
                document.getElementById('lblrstInCharge1').innerHTML = result.d[0].InCharge;
                document.getElementById('lblrstDate').innerHTML = result.d[0].SubSourceCode;
                document.getElementById('lblrstDate1').innerHTML = result.d[0].SubSourceCode;
                document.getElementById('lblrstCount').innerHTML = result.d[0].Count;
                document.getElementById('lblrstCount1').innerHTML = result.d[0].Count;
                document.getElementById('lblrstCity').innerHTML = result.d[0].City;
                document.getElementById('lblrstCity1').innerHTML = result.d[0].City;
                document.getElementById('lblrstAmount').innerHTML = result.d[0].Amount;
                document.getElementById('lblrstAmount1').innerHTML = result.d[0].Amount;
                document.getElementById('lblrstNarration').innerHTML = result.d[0].Narration;
                document.getElementById('lblrstNarration1').innerHTML = result.d[0].Narration;
                document.getElementById('hdnCDId').value = result.d[0].Id;
                $find('modalpopup').show();
            }
            else {
                $find('modalpopup').hide();
            }
        }
        catch (e) {
            alert('Exception while Loading Selected client Receipt Note details in Receipt Approval');
        }
    }
    function Reloadpage() {
        //window.location.href = "../Ledger/CreditDebitRecommend.aspx";
        document.getElementById('txtClientName').value = "";
        document.getElementById('hdnClientID').value = "";
        GetData();
        return false;
    }
    function ClearPopupBoxvalues() {
        document.getElementById('lblrstTSP').innerHTML = '';
        document.getElementById('lblrstIncharge').innerHTML = '';
        document.getElementById('lblrstCity').innerHTML = '';
        document.getElementById('lblrstDate').innerHTML = '';
        document.getElementById('lblrstNarration').innerHTML = '';
        document.getElementById('lblrstCount').innerHTML = '';
        document.getElementById('lblrstAmount').innerHTML = '';
        document.getElementById('lblrstDate1').innerHTML = '';
        document.getElementById('lblrstClientName1').innerHTML = '';
        document.getElementById('lblrstInCharge1').innerHTML = '';
        document.getElementById('lblrstCity1').innerHTML = '';
        document.getElementById('lblrstNarration1').innerHTML = '';
        document.getElementById('lblrstCount1').innerHTML = '';
        document.getElementById('lblrstAmount1').innerHTML = '';
        document.getElementById('hdnCDId').value = '';
        $('#chkApprove1').prop('checked', false);
        return true;
    }
    function RecommendData(Status) {
        debugger;
        var lstClientReceipt = [];
        var Selected = "N";
        var OrgId = document.getElementById('hdnOrgID').value;
        if (document.getElementById('hdnCDId').value != "") {
            if (!jQuery("#chkApprove1").is(":checked")) {
                alert("Please Select Receipt Note....!");
                return false;
            }
            else {
                Selected = "Y";
                lstClientReceipt.push
            ({
                OrgID: OrgId,
                Status: Status,
                Id: document.getElementById('hdnCDId').value
            });
            }
        }
        $("input:checkbox[name=chk]:checked").each(function() {
            Selected = "Y";
            lstClientReceipt.push
            ({
                OrgID: OrgId,
                Status: Status,
                Id: $(this).attr("id")
            });
        });
        if (Selected == "Y") {
            var ClientRecommend = JSON.stringify(lstClientReceipt);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveReceiptRecommentation",
                contentType: "application/json;charset=utf-8",
                data: "{lstClientReceipt:'" + ClientRecommend + "'}",
                dataType: "json",
                async: false,
                success: function() {
                    alert('Receipt ' + Status + ' Successfully!');
                    document.getElementById('txtClientName').value = "";
                    document.getElementById('hdnClientID').value = "";
                    document.getElementById('hdnCDId').value = "";
                    $find('modalpopup').hide();
                    GetData();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Updation");
                    $find('modalpopup').hide();
                    return false;
                }
            });
        }
        else {
            alert("Please Select at least one Receipt Note....!");
            return false;
        }
    }
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

