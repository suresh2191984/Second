<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseTaxReports.aspx.cs"
    Inherits="InventoryReports_PurchaseTaxReports" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Tax Report</title>

    <script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>

   

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <ul>
            <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
        </ul>
        <div id="divProjection">
            <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                cellspacing="3">
                <tr>
                    <td align="left">
                        <table class="w-100p">
                            <tr>
                                <td align="left">
                                    From Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFrom" CssClass="small datePickerPres" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                </td>
                                <td align="left">
                                    To Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTo"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                        runat="server" CssClass="small datePickerPres" meta:resourcekey="txtToResource1" />
                                </td>
                           <%-- </tr>
                            <tr>--%>
                                <td align="left">
                                    Location
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" 
                                        meta:resourcekey="ddlLocationResource1">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                    Supplier
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="Txtboxsmall" OnkeyPress="return ValidateMultiLangCharacter(this) && ValidateMultiLangChar(this);"
                                        Width="130px" TabIndex="3"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSupplier"
                                        ServiceMethod="GetSupplierList" 
                                        ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                        DelimiterCharacters=";,:" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td align="left">
                                    <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                        OnClick="btnSearch_Click" OnClientClick="javascript:return CheckDates('');" meta:resourcekey="btnSearchResource1" />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="lnkBack" Text="Back" runat="server" CssClass="cancel-btn marginL5" OnClick="lnkBack_Click"
                                                            meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table id="tblTool" runat="server" style="display: none">
                            <tr align="right">
                                <td align="right">
                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" 
                                        Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" 
                                        meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>
                                </td>
                                <td align="right">
                                <asp:ImageButton ID="btnPrint" CssClass="marginL5" runat="server" ImageUrl="~/PlatForm/images/printer.gif"
                                                            OnClientClick="return printwin();" ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                    <%--<asp:LinkButton OnClientClick="javascript:return printwin();" ID="hypLnkPrint" 
                                        Font-Bold="True" Font-Size="12px" ForeColor="Black" Target="BillWindow" runat="server"
                                        ToolTip="Click Here To Print Purchase Order Report" 
                                        meta:resourcekey="hypLnkPrintResource1">
                                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/PlatForm/Images/printer.gif" />
&nbsp;<u>Print
                                            PO Report</u></asp:LinkButton>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="dPrint">
                <asp:Table CellPadding="2" CssClass="dataheaderInvCtrl" CellSpacing="2" BorderWidth="1px"
                    runat="server" ID="tblpurchaseOrder" Width="100%" 
                    meta:resourcekey="tblpurchaseOrderResource1">
                </asp:Table>
                <input type="hidden" id="hdnRowCount" runat="server" />
            </div>
        </div>
        <asp:HiddenField ID="hdnStatus" Value="N" runat="server" />
        <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>

    <script language="javascript" type="text/javascript">
        function printwin() {
            var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false
        }

    </script>
 <script language="javascript" type="text/javascript">
     var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
     var userMsg;
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
</body>
</html>

