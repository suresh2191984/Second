<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CSSDReport.aspx.cs" Inherits="InventoryReports_CSSDReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function CheckDates() {

            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
    </script>

    <script type="text/javascript">
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:scriptmanager id="scriptManager1" runat="server">
    </asp:scriptmanager>
    <attune:attuneheader id="Attuneheader" runat="server"></attune:attuneheader>
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="searchPanel">
            <tr>
                <td align="left">
                    <div class="dataheaderWider">
                        <table id="tbl" width="100%">
                            <tr>
                                <td>
                                    <asp:label id="lblOrgs" runat="server" text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:label>
                                </td>
                                <td>
                                    <asp:dropdownlist id="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server" cssclass="ddl">
                                    </asp:dropdownlist>
                                </td>
                                <td>
                                    <asp:label id="Rs_FromDate" text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:label>
                                    <asp:textbox id="txtFDate" cssclass="small datePickerPres" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);"></asp:textbox>
                                </td>
                                <td>
                                    <asp:label id="Rs_ToDate" text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:label>
                                    <asp:textbox id="txtTDate" cssclass="small datePickerPres" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"></asp:textbox>
                                </td>
                                <td>
                                    <asp:panel id="Panel1" class="w-100p" groupingtext="Status Type" runat="server" meta:resourcekey="Panel1Resource1">
                                        <asp:radiobuttonlist id="rblVisitType" repeatdirection="Horizontal" runat="server" meta:resourcekey="rblVisitTypeResource1">
                                            <asp:listitem text="ALL" selected="True" value="0" meta:resourcekey="ListItemResource1"></asp:listitem>
                                            <asp:listitem text="Pending" value="1" meta:resourcekey="ListItemResource2"></asp:listitem>
                                            <asp:listitem text="Received" value="2" meta:resourcekey="ListItemResource3"></asp:listitem>
                                        </asp:radiobuttonlist>
                                    </asp:panel>
                                </td>
                                <td>
                                    <asp:label id="lblFlocation" runat="server" text="From location" meta:resourcekey="lblFlocationResource1"></asp:label>
                                    <asp:dropdownlist id="ddlFLocation" runat="server" cssclass="small">
                                    </asp:dropdownlist>
                                    <asp:label id="lblTlocation" runat="server" text="To location" meta:resourcekey="lblTlocationResource1"></asp:label>
                                    <asp:dropdownlist id="ddlTLocation" runat="server" cssclass="small">
                                    </asp:dropdownlist>
                                </td>
                            </tr>                     
                            <tr>
                                <td class="hide">
                                    <asp:panel id="pnlVisitType" class="w-100p" groupingtext="Report Type" runat="server" meta:resourcekey="pnlVisitTypeResource1">
                                        <asp:radiobuttonlist id="rblReportType" repeatdirection="Horizontal" runat="server" meta:resourcekey="rblReportTypeResource1">
                                            <asp:listitem text="Summary" selected="True" value="0" meta:resourcekey="ListItemResource4"></asp:listitem>
                                            <asp:listitem text="Detail" value="1" meta:resourcekey="ListItemResource5"></asp:listitem>
                                        </asp:radiobuttonlist>
                                    </asp:panel>
                                </td>
                                <td class="a-center" colspan="6">
                                    <asp:button id="btnSubmit" runat="server" text="Get Report" cssclass="btn" onclientclick="javascript:return CheckDates();" onclick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1"></asp:button>
                              
                                    <asp:linkbutton id="lnkBack" text="Back" style="padding: 1px 6px !important;" runat="server" cssclass="cancel-btn" onclick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:linkbutton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:updateprogress id="Progressbar" runat="server">
                        <progresstemplate>
                            <asp:image id="imgProgressbar" runat="server" imageurl="~/PlatForm/images/working.gif" meta:resourcekey="imgProgressbarResource1"></asp:image>
                            <asp:label id="Rs_Pleasewait" text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:label>
                        </progresstemplate>
                    </asp:updateprogress>
                    <div id="contentArea">
                        <div id="divPrint" style="display: none;" runat="server">
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td align="right" style="padding-right: 10px; color: #000000;">
                                        <b id="printText" runat="server">
                                            <asp:label id="Rs_PrintReport" text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:label>
                                        </b>
                                        
                                        <asp:imagebutton id="imgBtnXL" runat="server" imageurl="../PlatForm/images/ExcelImage.GIF" tooltip="Save As Excel" style="width: 16px" onclick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1"></asp:imagebutton>
                                        &nbsp;
                                        <asp:imagebutton id="btnPrint" runat="server" imageurl="~/PlatForm/images/printer.gif" onclientclick="javascript:return popupprint();" tooltip="Print" meta:resourcekey="btnPrintResource1"></asp:imagebutton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:updatepanel id="updatePanel1" runat="server">
                            <contenttemplate>
                                <div id="divOPDWCR" runat="server" style="display: none;">
                                    <div id="prnReport">
                                        <asp:gridview id="grdResult" runat="server" autogeneratecolumns="False" cssclass="gridView w-100p" headerstyle-cssclass="gridHeader">
                                            <columns>
                                                <asp:boundfield datafield="Sno" headertext="S.No" meta:resourcekey="grdResult_boundfieldResource2"></asp:boundfield>
                                                <asp:boundfield datafield="FromLocation" headertext="From Location" meta:resourcekey="grdResult_boundfieldResource4"></asp:boundfield>
                                                <asp:boundfield datafield="ToLocation" headertext="To Location" meta:resourcekey="grdResult_boundfieldResource6"></asp:boundfield>
                                                <asp:boundfield datafield="ProductName" headertext="Product Name" meta:resourcekey="grdResult_boundfieldResource8"></asp:boundfield>
                                                <asp:boundfield datafield="Status" headertext="Status" meta:resourcekey="grdResult_boundfieldResource10"></asp:boundfield>
                                                <asp:boundfield datafield="RaisedQty" headertext="Raised Qty" meta:resourcekey="grdResult_boundfieldResource12"></asp:boundfield>
                                                <asp:boundfield datafield="RecivedQty" headertext="Received Qty" meta:resourcekey="grdResult_boundfieldResource14"></asp:boundfield>
                                            </columns>
                                            <headerstyle cssclass="grdcolor" font-bold="True"></headerstyle>
                                        </asp:gridview>
                                    </div>
                                </div>
                            </contenttemplate>
                        </asp:updatepanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server"></attune:attunefooter>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>