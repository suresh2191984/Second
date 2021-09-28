<%@ Page Language="C#" AutoEventWireup="true" CodeFile="scheduleDrugReport.aspx.cs"
    Inherits="InventoryReports_scheduleDrugReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" language="javascript">
        function clearContextText() {
            $('#divprintExcelArea').hide();
            $('#dvPrintarea').hide();
        }
    </script>

</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table border="0" cellpadding="2" width="100%" cellspacing="1">
            <tr>
                <td class="dataheader2">
                    <table border="0" class="w-100p" >
                        <tr class="lh40">
                            <td class="w-12p">
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                    meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td class="w-13p">
                                <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                    CssClass="smaller" meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td class="w-7p">
                                <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" 
                                    meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td class="w-15p">
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small  datePickerPres"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" Width="70px" meta:resourcekey="txtFromResource1" />
                            </td>
                            <td class="w-5p">
                                <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" 
                                    meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td class="w-15p">
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePickerPres"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" Width="70px" meta:resourcekey="txtToResource1" />
                            </td>
                            <td class="w-7p">
                                <asp:Label ID="LabelLocation" runat="server" Text="Location" 
                                    meta:resourcekey="LabelLocationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" Width="130px" 
                                    TabIndex="4" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            
                            <td class="a-center" colspan="8">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click"
                                    OnClientClick="javascript:return CheckDates('');" TabIndex="2" 
                                    meta:resourcekey="btnSearchResource1" />
                                &nbsp;
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" Text="Back"
                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="divprintExcelArea">
                <td align="right">
                    <table width="90%">
                        <tr>
                            <td align="right">
                                <asp:ImageButton ID="imgBtnXL" Visible="False" OnClick="imgBtnXL_Click" runat="server"
                                    ImageUrl="~/PlatForm/Images/ExcelImage.GIF" ToolTip="Save As Excel" 
                                    meta:resourcekey="imgBtnXLResource1" />
                                <input type="hidden" runat="server" id="hdnStatus" value="N" />
                                <asp:LinkButton ID="lnkExportXL" CssClass="hide" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                    Visible="False" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" 
                                    meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>
                                <asp:HyperLink ID="hypLnkPrint" CssClass="marginL10" ImageUrl="~/PlatForm/Images/printer.gif" ToolTip="Print" Visible="False"
                                    Target="ReportWindow" OnClick="javascript:return printstockreport()" 
                                    runat="server" meta:resourcekey="hypLnkPrintResource1"></asp:HyperLink>
                                <asp:LinkButton ID="lnkPrint" CssClass="hide" Visible="False" runat="server" ForeColor="Black" Font-Bold="True"
                                    OnClientClick="javascript:return printstockreport()" 
                                    meta:resourcekey="lnkPrintResource1"><u>Print</u></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="dvPrintarea">
                        <table width="100%" class="gridView">
                            <tr style="display: none;">
                                <td align="left">
                                    <asp:Label runat="server" ID="lblstatus" Text="No Matching Records Found!" Font-Bold="True"
                                        Visible="False" meta:resourcekey="lblstatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <div id="dPrint">
                                        <asp:Table CssClass="gridView w-100p"
                                            runat="server" ID="tblScheduleDrug" 
                                            meta:resourcekey="tblScheduleDrugResource1">
                                        </asp:Table>
                                        <asp:HiddenField ID="hdnProductValues" runat="server" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
        var userMsg;
        function printstockreport() {
            var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);

            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "checkbox") {
                    document.forms[0].elements[i].disabled = true;
                }
            }
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            setTimeout(function(){
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "checkbox") {
                    document.forms[0].elements[i].disabled = false;
                }
            }
            WinPrint.close();
            },1000);
			return false;

        }

        function INVRowCheckBox(chkId, ProID) {

            var list = document.getElementById('hdnProductValues').value.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var y = list[i].split('~');
                    if (y[1] == ProID) {
                        if (document.getElementById(chkId).checked) {
                            document.getElementById(y[0]).checked = true;
                        }
                        else {
                            document.getElementById(y[0]).checked = false;

                        }
                    }
                }
            }
        }

        function CheckDates(splitChar) {

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
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
         $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

