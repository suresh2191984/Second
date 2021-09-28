<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvancePaymentApproval.aspx.cs" Inherits="Ledger_AdvancePaymentApproval" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title> Advance Approval</title>

    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet"
        type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />


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
                                    <asp:Label ID="Rs_FilterResult2" runat="server" Text="Advance Approval" meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="w-100p">
                                       
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
                                    <th align="left" class="w-10p">
                                    </th>
                                    <th align="left" class="w-10p">
                                        Date
                                    </th>
                                    <th align="left" class="w-30p" height="25px">
                                        ClientName
                                    </th>
                                    <th align="left" class="w-20p" height="25px">
                                        City
                                    </th>
                                    <th align="left" class="w-5p" height="25px">
                                        Payment Type
                                    </th>
                                    <th align="left" class="w-20p" height="25px">
                                        Remarks
                                    </th>
                                    <th align="left" class="w-5p" height="25px">
                                        Amount
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
       
    </div>
    <asp:HiddenField ID="hdnOrgID" runat="server" />
     <asp:HiddenField ID="hdnCID" runat="server" />
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
   
    /* JSON Data Binding Details */
    $(document).ready(function() {
        GetData();
    });

    function GetData() {
        try {
            debugger;
            var ClientCode = '';
            var OrgID = 0;
            var Status = 'Recommended';
          
            var ClientID = 0;
            OrgID = document.getElementById('hdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetAdvanceRecommendList",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'Status':'" + Status + "','ClientID':" + ClientID + "}",
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
            var oTable;
            $('#trbuttons').hide();
            if (result != "[]") {
                oTable = $('#example').dataTable({
                    "bJQueryUI": true,
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"aoColumnDefs": [{ "bSortable": false, "aTargets": [0, ]}],
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                    //{ "mDataProp": "ClientCode", "bVisible": false },
                          {"mDataProp": "AdvanceDetailID", sClass: "a-center", "mRender": function(data, type, full) {
                              debugger;
                              if (data != '') {
                                  return '<input type="checkbox" name="chk" id=' + data + '></br>';
                              }
                          }
                      },
                          { "mDataProp": "FromDate", sClass: "a-left" },
                          { "mDataProp": "ClientName", sClass: "a-left" },
                          { "mDataProp": "City", sClass: "a-left" },
                          { "mDataProp": "PaymentType", sClass: "a-left" },
                          { "mDataProp": "Remarks", sClass: "a-left" },
                          { "mDataProp": "Amount", sClass: "a-right" },


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
            alert('Exception while binding Advance Pending Deatails');
        }
        return false;
    }
    
    function Reloadpage() {
        //window.location.href = "../Ledger/CreditDebitRecommend.aspx";
        document.getElementById('txtClientName').value = "";
        document.getElementById('hdnClientID').value = "";
        GetData();
        return false;
    }

    function RecommendData(Status) {
        debugger;
        var lstLedgerInvoiceDetails = [];
        var Selected = "N";
        var OrgId = document.getElementById('hdnOrgID').value;
        //var Type = "R";

        debugger;
        var tblResultviewRows = $("#example > tbody > tr");
        $(tblResultviewRows).each(function() {

            var oTable = $("#example").dataTable();
            var pos = oTable.fnGetPosition(this);
            var rowData = oTable.fnGetData(pos);
            if ($(this).find('[name^=chk]').is(":checked")) {
                // $("input:checkbox[name=chk]:checked").each(function() {
                Selected = "Y";
                lstLedgerInvoiceDetails.push
                ({
                    OrgID: OrgId,
                    Status: Status,
                    AdvanceDetailID: rowData["AdvanceDetailID"], //$(this).attr("id"),
                    PaymentType: rowData["PaymentType"],
                    ClientId: rowData["ClientId"],
                    Amount: rowData["Amount"]

                });
            } //);

        });

        if (Selected == "Y") {
            var AdvanceRecommend = JSON.stringify(lstLedgerInvoiceDetails);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveAdvanceRecommentation",
                contentType: "application/json;charset=utf-8",
                data: "{lstLedgerInvoiceDetails:'" + AdvanceRecommend + "'}",
                dataType: "json",
                async: false,
                success: function() {
                alert('Advance ' + Status + ' Successfully!');
                    document.getElementById('txtClientName').value = "";
                    document.getElementById('hdnClientID').value = "";
                    document.getElementById('hdnCID').value = "";
                    GetData();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Updation");
                    return false;
                }
            });
        }
        else {
            alert("Please Select at least one Advance Note....!");
            return false;
        }
    }
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
