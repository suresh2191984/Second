<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="RollingAdvanceClientDetails.aspx.cs"
    Inherits="Reports_RollingAdvanceClientDetails" meta:resourcekey="PageResource1" %>


<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Rolling Advance Client Summary</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .dataheader3
        {
            margin-right: 2px;
        }
        .displayFalse
        {
            display: none;
        }
        #RollingAdvanceClient_wrapper.dataTables_wrapper
        {
            overflow-x: auto;
            overflow-y: auto;
            width: 100%;
            height: 298px;
            
        }
        .w-5p { width:5%!important;}
        .m-auto 
        {
            margin:0 auto;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            try {

                GetValues();
            }
            catch (e) {
                return false;
            }

        });
    </script>

    <script type="text/javascript" language="javascript">

        function GetValues() {
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetRollingAdvanceClients",
                    contentType: "application/json; charset=utf-8",
                    data: "{ }",
                    dataType: "json",
                    success: AjaxloadtblRollingAdvanceClientSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#RollingAdvanceClient').hide();
                        return false;
                    }
                });

            }
            catch (e) {

            }
            return false;

        }

        function AjaxloadtblRollingAdvanceClientSucceeded(result) {

            var oTable;
            if (result.d.length > 0) {

                var list = result.d;
                if (result != "[]") {
                    oTable = $('#RollingAdvanceClient').dataTable({
                        "bDestroy": true,

                        "bProcessing": true,
                        "aaData": list,
                        "aoColumns": [
                          { "mData": "CreatedAt",
                              "mRender": function(data, type, full) {
                                  return '<input type="checkbox" name="checkjdatatable" id="chkjdatatable_' + full.ClientID + '" / > ';
                              }
                          },

                                { "mDataProp": "ClientName",
                                    "fnRender": function(oObj) {
                                        return '	<label id="jClientName">' + oObj.aData.ClientName + '</label>   <input type="hidden"  id="jhdnClientID" value="' + oObj.aData.ClientID + '" /> ';
                                    }
                                }

                                  ],

                        "bPaginate": false,
                        "sZeroRecords": "Rolling Advance Clients are not Available in this Org.",
                        "bSort": false,
                        "bJQueryUI": true

                    });
                    $('#RollingAdvanceClient').show();
                    if ($("#hdnClientList").val() != '') {
                        MakeCheckCheckBox();
                    }
                }
                else {
                    $('#RollingAdvanceClient').hide();
                }
            }
        }

        function selectall() {

            $("#RollingAdvanceClient tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                if ($('#ChkbxSelectAll').is(':checked')) {
                    $row.find("input[id^='chkjdatatable']").attr('checked', true);
                }
                else {
                    $row.find("input[id^='chkjdatatable']").attr('checked', false);
                }
            });
        }
        function Validate() {

            btnsearchdata();
            return true;

        }
        function btnsearchdata() {

            var list = "";
            var dataTableclientid = [];
            var checkedcheckbox = 0;
            $("#RollingAdvanceClient tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var checked = $row.find("input[id^='chkjdatatable']").is(':checked')
                if (checked) {
                    var grdclientid = $row.find("#jhdnClientID").val();

                    dataTableclientid.push({
                        ClientID: grdclientid
                    });
                    checkedcheckbox = checkedcheckbox + 1;
                }

            });

            if (dataTableclientid.length > 0) {
                $('#hdnClientList').val(JSON.stringify(dataTableclientid));
            }
            return true;
        }
        function MakeCheckCheckBox() {
            var jcheck = JSON.parse($('#hdnClientList').val());
            $.each(jcheck, function(key, val) { $('#chkjdatatable_' + val.ClientID).prop('checked', true); });
        }
        function popupprint() {
            var grdResult = document.getElementById('<%=gvAdvanceClientDetails.ClientID %>');

            var gridRefund = document.getElementById('<%=PrintgvAdvanceClientDetails.ClientID %>');

            if (grdResult === null && gridRefund === null) {
                alert('No Records Found');
                return false;
            }
            else {
                var prtContent = document.getElementById('<%=printCashClosure.ClientID %>');
                var WinPrint = window.open('', '', 'letf=100,top=100,height=600,width=1050,toolbar=0,scrollbars=1,status=0,resizable=1');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                return false;
            }
        }
        
    </script>

   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <div class="defaultfontcolor">
                                        <asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Rolling Advance Summary"
                                            meta:resourcekey="pnlPSearchResource1">
                                            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="dataheader3">
                                                <tr>
                                                    <td>
                                                        <table width="45%"  class="m-auto">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <div id="AdvanceClient">
                                                                        <table id="RollingAdvanceClient" style="display: none">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th align="center" class="w-5p">
                                                                                        <asp:CheckBox ID="ChkbxSelectAll" onclick="selectall()" runat="server" />
                                                                                    </th>
                                                                                    <th align="left" width="95%">
                                                                                        ClientName
                                                                                    </th>
                                                                                </tr>
                                                                            </thead>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" Height="25px" Width="50px"
                                                                        CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                                        OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" OnClientClick="javascript:return Validate()" />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" Height="25px" Width="50px"
                                                                        CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                                        OnClick="btnCancel_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" />
                                                        <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="true"
                                                            Visible="true" Font-Size="12px" ForeColor="#000000" ToolTip="Save As Excel"><u>Export To XL</u></asp:LinkButton>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                            OnClientClick="return popupprint();" ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        <b id="printText" runat="server">
                                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" OnClientClick="return popupprint();"
                                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                                                meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr id="tralldetails" runat="server">
                                                    <td align="center">
                                                        <asp:GridView ID="gvAdvanceClientDetails" runat="server" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvAdvanceClientDetails_RowDataBound" CssClass="mytable1 dataheader3"
                                                            Width="100%" ForeColor="#333333" DataKeyNames="Identificationid">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Collection Report">
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" meta:resourceKey="grdResultResource1"
                                                                                        HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                                                        ForeColor="#333333" Width="100%">
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                                            <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                                            <asp:BoundField DataField="DepositedDate" HeaderText="Deposited Date" meta:resourceKey="BoundFieldResource2">
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourceKey="BoundFieldResource4" />
                                                                                            <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                                            <asp:BoundField DataField="CollectedBy" HeaderText="Collected By" meta:resourceKey="BoundFieldResource6" />
                                                                                        </Columns>
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                            PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                        <PagerStyle HorizontalAlign="Center" />
                                                                                    </asp:GridView>
                                                                                    <asp:GridView ID="gridRefund" runat="server" AutoGenerateColumns="False" meta:resourceKey="gridRefundResource1"
                                                                                        HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                                                        ForeColor="#333333" Width="100%">
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                                            <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                                            <asp:BoundField DataField="DepositedDate" HeaderText="Refunded Date" meta:resourceKey="BoundFieldResource2">
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="RefundAmount" HeaderText="Refund Amount" meta:resourceKey="BoundFieldResource4" />
                                                                                            <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                                            <asp:BoundField DataField="RefundedBy" HeaderText="Refunded By" meta:resourceKey="BoundFieldResource6" />
                                                                                        </Columns>
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                            PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                        <PagerStyle HorizontalAlign="Center" />
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label runat="server" ID="lblClientNamee" Text="Client Name :"></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblClientNameee" Text='<%# DataBinder.Eval(Container.DataItem, "ClientName") %>'></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                             
                                                                                    <asp:Label runat="server" ID="lblDeposited" Text="Total Deposit Amount :"></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblAmountDeposited" Text='<%# DataBinder.Eval(Container.DataItem, "AmountDeposited") %>'></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                    <asp:Label runat="server" ID="lblTotalDepositUsed" Text="Total Used Amount :"></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblAmountUsed" Text='<%# DataBinder.Eval(Container.DataItem, "AmountUsed") %>'></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                    <asp:Label runat="server" ID="lblAmtRefund" Text="Total Refund Amount :"></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblRefundAmount" Text='<%# DataBinder.Eval(Container.DataItem, "RefundAmount") %>'></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblAvlBalance" Text="Total Available Balance :"></asp:Label>
                                                                                    <asp:Label runat="server" ID="lblAvailableBalance" Text='<%# DataBinder.Eval(Container.DataItem, "AvailableBalance") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Right" />
                                                            <RowStyle BackColor="White" Font-Bold="True" HorizontalAlign="Right" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr id="trbeakupdetails" runat="server">
                                                    <td align="center">
                                                    </td>
                                                </tr>
                                                <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnRefundstatus" runat="server" />
                                                <asp:HiddenField ID="hdnReceivedAmount" runat="server" />
                                                <asp:HiddenField ID="hdnRefundAmount" runat="server" />
                                                <asp:HiddenField ID="hdnTotalAmount" runat="server" />
                                                <asp:HiddenField ID="hdnClientID" runat="server" />
                                                <asp:HiddenField ID="hdnFromDate" runat="server" />
                                                <asp:HiddenField ID="hdnToDate" runat="server" />
                                            </table>
                                            <div align="center" id="printCashClosure" style="page-break-after: auto; display: none;"
                                                runat="server">
                                                <asp:GridView ID="PrintgvAdvanceClientDetails" runat="server" AutoGenerateColumns="False"
                                                    OnRowDataBound="PrintgvAdvanceClientDetails_RowDataBound" CssClass="mytable1 dataheader3"
                                                    Width="100%" ForeColor="#333333">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Collection Report">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td align="center">
                                                                            <asp:GridView ID="PrintgrdResult" runat="server" AutoGenerateColumns="False" meta:resourceKey="grdResultResource1"
                                                                                HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                                                ForeColor="#333333" Width="100%">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                                    <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                                    <asp:BoundField DataField="DepositedDate" HeaderText="Deposited Date" meta:resourceKey="BoundFieldResource2">
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourceKey="BoundFieldResource4" />
                                                                                    <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                                    <asp:BoundField DataField="CollectedBy" HeaderText="Collected By" meta:resourceKey="BoundFieldResource6" />
                                                                                </Columns>
                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                    PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                <PagerStyle HorizontalAlign="Center" />
                                                                            </asp:GridView>
                                                                            <asp:GridView ID="PrintgridRefund" runat="server" AutoGenerateColumns="False" meta:resourceKey="gridRefundResource1"
                                                                                HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                                                ForeColor="#333333" Width="100%">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                                    <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                                    <asp:BoundField DataField="DepositedDate" HeaderText="Refunded Date" meta:resourceKey="BoundFieldResource2">
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="RefundAmount" HeaderText="Refund Amount" meta:resourceKey="BoundFieldResource4" />
                                                                                    <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                                    <asp:BoundField DataField="RefundedBy" HeaderText="Refunded By" meta:resourceKey="BoundFieldResource6" />
                                                                                </Columns>
                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                    PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                <PagerStyle HorizontalAlign="Center" />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Label runat="server" ID="lblPrintClientNamee" Text="Client Name :"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblPrintClientNameee" Text='<%# DataBinder.Eval(Container.DataItem, "ClientName") %>'></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:HiddenField runat="server" ID="hdnPrintCntId" Value='<%# DataBinder.Eval(Container.DataItem, "Identificationid") %>'>
                                                                            </asp:HiddenField>
                                                                            <asp:Label runat="server" ID="lblDeposited" Text="Total Deposit Amount :"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblAmountDeposited" Text='<%# DataBinder.Eval(Container.DataItem, "AmountDeposited") %>'></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:Label runat="server" ID="lblTotalDepositUsed" Text="Total Used Amount :"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblAmountUsed" Text='<%# DataBinder.Eval(Container.DataItem, "AmountUsed") %>'></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:Label runat="server" ID="lblAmtRefund" Text="Total Refund Amount :"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblRefundAmount" Text='<%# DataBinder.Eval(Container.DataItem, "RefundAmount") %>'></asp:Label>
                                                                            <asp:Label runat="server" ID="lblAvlBalance" Text="Total Avilable Balance :"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblAvailableBalance" Text='<%# DataBinder.Eval(Container.DataItem, "AvailableBalance") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Right" />
                                                    <RowStyle BackColor="White" Font-Bold="True" HorizontalAlign="Right" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </div>
                                            <input type="hidden" id="hdnBillStatus" runat="server"></input>
                                            <input type="hidden" id="hdnCollectionType" runat="server"></input>
                                            <asp:HiddenField ID="hdnAmt" runat="server" />
                                            <input id="bid" name="bid" type="hidden" />
                                            <asp:HiddenField ID="hdnClientPortal" runat="server" />
                                            <input type="hidden" runat="server" id="hdnclientName" />
                                            <input type="hidden" runat="server" id="hdnCustomerType" />
                                            <input type="hidden" runat="server" id="hdnClientTypeID" />
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
               
        <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnPNumber" name="PNumber" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="hdnpatientType" runat="server" />
       <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnClientList" runat="server" />
   
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>
</html>
